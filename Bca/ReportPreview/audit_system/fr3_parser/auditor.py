"""
FR3 Auditor Module
==================
Validates parsed FR3 reports against a configurable rule set.

Each rule:
  - enabled   – whether to run
  - weight    – contribution to overall score (0..100)
  - severity  – critical / high / medium / low
  - check()   – returns (pass: bool, detail: str)
"""
from __future__ import annotations
import re
from pathlib import Path
from typing import Dict, List, Tuple, Optional
from dataclasses import dataclass, field

from .parser import FR3Report, FR3Memo, FR3Dataset


# ---------------------------------------------------------------------------
# Audit Issue
# ---------------------------------------------------------------------------
@dataclass
class AuditIssue:
    rule_id: str
    severity: str          # critical | high | medium | low
    score_impact: float    # weight * (0 or 1)
    message: str
    path: str
    element_name: Optional[str] = None
    raw_value: Optional[str] = None
    suggestion: str = ""
    fixable: bool = False


@dataclass
class AuditResult:
    file_path: str
    issues: List[AuditIssue] = field(default_factory=list)
    total_weight: float = 100.0
    passed_weight: float = 100.0
    score: float = 100.0
    passed: bool = True
    summary: Dict[str, int] = field(default_factory=dict)

    def add_issue(self, issue: AuditIssue):
        self.issues.append(issue)
        self.passed_weight -= issue.score_impact
        severity_key = issue.severity
        self.summary[severity_key] = self.summary.get(severity_key, 0) + 1

    @property
    def failed(self) -> bool:
        return not self.passed


# ---------------------------------------------------------------------------
# Rule Definitions
# ---------------------------------------------------------------------------
@dataclass
class Rule:
    rule_id: str
    enabled: bool = True
    weight: float = 10.0
    severity: str = "medium"
    description: str = ""
    check_func: object = None  # (report: FR3Report) -> (pass: bool, detail: str)


class RulesRegistry:
    _rules: Dict[str, Rule] = {}

    def __init__(self):
        self._rules = {
            "XML_VALIDITY": Rule(
                "XML_VALIDITY",
                enabled=True, weight=15.0, severity="critical",
                description="File must be well-formed XML",
                check_func=self._check_xml_validity
            ),
            "FR_VERSION": Rule(
                "FR_VERSION",
                enabled=True, weight=10.0, severity="medium",
                description="Version must be 3.18 or higher",
                check_func=self._check_version
            ),
            "ZERO_BYTE_TAIL": Rule(
                "ZERO_BYTE_TAIL",
                enabled=True, weight=15.0, severity="critical",
                description="No zero-padded bytes after </TfrxReport>",
                check_func=self._check_zero_byte_tail
            ),
            "DATASET_REFERENCED": Rule(
                "DATASET_REFERENCED",
                enabled=True, weight=15.0, severity="high",
                description="Every dataset referenced in memos must be declared",
                check_func=self._check_dataset_referenced
            ),
            "MEMO_FIELD_BINDING": Rule(
                "MEMO_FIELD_BINDING",
                enabled=True, weight=10.0, severity="high",
                description="Memo with data-binding must reference a declared DataSet",
                check_func=self._check_memo_field_binding
            ),
            "SCRIPT_SYNTAX": Rule(
                "SCRIPT_SYNTAX",
                enabled=True, weight=5.0, severity="high",
                description="PascalScript: at least one procedure block structure",
                check_func=self._check_script_syntax
            ),
            "MEMO_OVERFLOW": Rule(
                "MEMO_OVERFLOW",
                enabled=True, weight=10.0, severity="medium",
                description="Memos must fit within page boundaries (tolerance 5%)",
                check_func=self._check_memo_overflow
            ),
            "DUPLICATE_NAME": Rule(
                "DUPLICATE_NAME",
                enabled=True, weight=5.0, severity="low",
                description="No duplicate Name across all child elements",
                check_func=self._check_duplicate_names
            ),
            "DUPLICATE_FIELD": Rule(
                "DUPLICATE_FIELD",
                enabled=True, weight=5.0, severity="low",
                description="No duplicate field name within same dataset",
                check_func=self._check_duplicate_fields
            ),
            "ORPHAN_DATASET": Rule(
                "ORPHAN_DATASET",
                enabled=True, weight=10.0, severity="medium",
                description="All declared datasets should be referenced at least once",
                check_func=self._check_orphan_datasets
            ),
            "MEMO_FONT_MISSING": Rule(
                "MEMO_FONT_MISSING",
                enabled=True, weight=3.0, severity="low",
                description="All memos should have a Font.Name set",
                check_func=self._check_font_names
            ),
            "PAGE_LAYOUT": Rule(
                "PAGE_LAYOUT",
                enabled=True, weight=5.0, severity="low",
                description="Page must have valid PaperWidth/PaperHeight",
                check_func=self._check_page_layout
            ),
        }

    def _check_xml_validity(self, r: FR3Report) -> Tuple[bool, str]:
        if r.is_valid_xml:
            return True, "XML is well-formed"
        return False, f"XML parse error(s): {r.xml_errors}"

    def _check_version(self, r: FR3Report) -> Tuple[bool, str]:
        if not r.version:
            return False, "Version attribute missing"
        # Accept 3.18, 4.x, 5.x, 6.x, 7.x
        if r.version.startswith("3.18") or re.match(r"^[3-9]\.", r.version):
            return True, f"Version {r.version} recognized"
        return False, f"Unrecognized or too old version: {r.version}"

    def _check_zero_byte_tail(self, r: FR3Report) -> Tuple[bool, str]:
        if r.has_zero_byte_tail:
            return False, (
                f"Zero-byte or junk tail detected after </TfrxReport>: "
                f"{r.extra_bytes_after_root} extra bytes"
            )
        return True, "No tail corruption detected"

    def _check_dataset_referenced(self, r: FR3Report) -> Tuple[bool, str]:
        referenced: Dict[str, List[str]] = {}
        for m in r.memos:
            if m.dataset:
                ds = m.dataset.split(".")[0]
                if ds not in referenced:
                    referenced[ds] = []
                referenced[ds].append(m.datafield)

        issues = []
        for ds in r.datasets:
            if ds.name not in referenced:
                issues.append(f"Dataset '{ds.name}' declared but never referenced")
        if issues:
            return False, "; ".join(issues)
        return True, f"All {len(r.datasets)} declared datasets referenced"

    def _check_memo_field_binding(self, r: FR3Report) -> Tuple[bool, str]:
        issues = []
        declared_datasets = {ds.name for ds in r.datasets}
        for m in r.memos:
            if m.datafield and m.dataset:
                ds_name = m.dataset.split(".")[0]
                if ds_name not in declared_datasets:
                    issues.append(
                        f"Memo '{m.name}' binds field '{m.datafield}' "
                        f"to undeclared dataset '{ds_name}'"
                    )
        if issues:
            return False, "; ".join(issues)
        return True, f"All {len(r.memos)} memo bindings valid"

    def _check_script_syntax(self, r: FR3Report) -> Tuple[bool, str]:
        if not r.script:
            return True, "No script present – skip"
        s = r.script.text
        # At minimum expect a begin..end block or 'procedure' keyword
        if "begin" not in s:
            return False, "Script missing 'begin' block"
        return True, f"Script OK ({len(s)} chars, {len(r.script.procedures)} procedures)"

    def _check_memo_overflow(self, r: FR3Report) -> Tuple[bool, str]:
        if not r.pages:
            return False, "No pages defined"
        page = r.pages[0]
        page_width = page.paper_width - page.margins.get("left", 10) - page.margins.get("right", 10)
        overflow = [
            m.name for m in r.memos
            if m.left + m.width > page_width + page_width * 0.05
        ]
        if overflow:
            return False, f"Memories overflow page width: {', '.join(overflow[:10])}"
        return True, f"All memos within page boundary"

    def _check_duplicate_names(self, r: FR3Report) -> Tuple[bool, str]:
        seen: Dict[str, List[str]] = {}
        for m in r.memos:
            if m.name:
                seen.setdefault(m.name, []).append(f"Memo@{m.left:.0f},{m.top:.0f}")
        dups = {k: v for k, v in seen.items() if len(v) > 1}
        if dups:
            return False, f"Duplicate names: {', '.join(dups.keys())}"
        return True, "All element names unique"

    def _check_duplicate_fields(self, r: FR3Report) -> Tuple[bool, str]:
        for ds in r.datasets:
            if len(ds.fields) != len(set(ds.fields)):
                return False, f"Dataset '{ds.name}' has duplicate fields"
        return True, "No duplicate fields"

    def _check_orphan_datasets(self, r: FR3Report) -> Tuple[bool, str]:
        referenced: set = set()
        for m in r.memos:
            if m.dataset:
                ds = m.dataset.split(".")[0]
                referenced.add(ds)
        orphans = [ds.name for ds in r.datasets if ds.name not in referenced]
        if orphans:
            return False, f"Orphan datasets: {', '.join(orphans)}"
        return True, "No orphan datasets"

    def _check_font_names(self, r: FR3Report) -> Tuple[bool, str]:
        missing = [m.name for m in r.memos if not m.font and m.name]
        if missing:
            return False, f"Memories without Font.Name: {', '.join(missing[:10])}"
        return True, "All memos have Font.Name"

    def _check_page_layout(self, r: FR3Report) -> Tuple[bool, str]:
        if not r.pages:
            return False, "No page defined"
        p = r.pages[0]
        if p.paper_width <= 0 or p.paper_height <= 0:
            return False, f"Invalid page size: {p.paper_width}x{p.paper_height}"
        return True, f"Page OK: {p.paper_width}x{p.paper_height}"

    def get_rule(self, rule_id: str) -> Optional[Rule]:
        return self._rules.get(rule_id)

    def all_rules(self) -> List[Rule]:
        return [self._rules[k] for k in sorted(self._rules.keys())]


# ---------------------------------------------------------------------------
# Auditor
# ---------------------------------------------------------------------------
class FR3Auditor:
    def __init__(self, config: Optional[Dict] = None):
        self.registry = RulesRegistry()
        self.config = config or {}

    def audit(self, report: FR3Report) -> AuditResult:
        result = AuditResult(file_path=report.file_path)
        for rule in self.registry.all_rules():
            if not rule.enabled:
                continue
            try:
                passed, detail = rule.check_func(report)
                impact = rule.weight if not passed else 0.0
                issue = AuditIssue(
                    rule_id=rule.rule_id,
                    severity=rule.severity,
                    score_impact=impact,
                    message=detail,
                    path=report.file_path,
                    fixable=False,
                    suggestion=_suggestion(rule.rule_id, detail)
                )
                result.add_issue(issue)
            except Exception as exc:
                issue = AuditIssue(
                    rule_id=rule.rule_id,
                    severity="critical",
                    score_impact=rule.weight,
                    message=f"Rule error: {exc}",
                    path=report.file_path,
                    fixable=False
                )
                result.add_issue(issue)

        result.passed = result.passed_weight > 0
        result.score = round(result.passed_weight, 2)
        return result


def _suggestion(rule_id: str, detail: str) -> str:
    map_ = {
        "ZERO_BYTE_TAIL": "Open .fr3 in FastReport Designer and re-save as UTF-8 XML.",
        "XML_VALIDITY": "Fix XML syntax errors before reimporting.",
        "DATASET_REFERENCED": "Declare dataset in TfrxReport's PropData or bind via script.",
        "MEMO_FIELD_BINDING": "Add missing DataSet reference to the memo element.",
        "SCRIPT_SYNTAX": "Ensure script contains at least one begin..end block.",
    }
    return map_.get(rule_id, "Review rule definition.")
