"""
Fix generator — creates corrective XML edits for common FR3 issues.
"""
from __future__ import annotations
import re
from dataclasses import dataclass
from typing import List, Optional

from .parser import FR3Report


@dataclass
class Fix:
    rule_id: str
    severity: str
    description: str
    action: str      # what to do
    code_patch: Optional[str] = None   # raw XML patch snippet
    confidence: float = 1.0


class FR3FixGenerator:
    """Generates self-healing patch suggestions for failed audit rules."""

    def __init__(self):
        self.handlers: dict[str, callable] = {
            "ZERO_BYTE_TAIL":   self._fix_zero_byte_tail,
            "XML_VALIDITY":     self._fix_xml_syntax,
            "MEMO_FIELD_BINDING": self._fix_memo_binding,
            "ORPHAN_DATASET":   self._fix_orphan_dataset,
            "MEMO_OVERFLOW":    self._fix_memo_overflow,
            "DUPLICATE_NAME":   self._fix_duplicate_name,
            "SCRIPT_SYNTAX":    self._fix_script_syntax,
        }

    def generate(self, report: FR3Report, issues) -> List[Fix]:
        fixes: List[Fix] = []
        for issue in issues:
            handler = self.handlers.get(issue.rule_id)
            if not handler:
                continue
            try:
                fixes.extend(handler(report, issue))
            except Exception as exc:
                fixes.append(Fix(
                    rule_id=issue.rule_id,
                    severity=issue.severity,
                    description=f"Fix generation error: {exc}",
                    action="Manual review required",
                    confidence=0.0
                ))
        return fixes

    # ------------------------------------------------------------------
    # Individual fix handlers
    # ------------------------------------------------------------------
    def _fix_zero_byte_tail(self, report: FR3Report, issue) -> List[Fix]:
        return [Fix(
            rule_id="ZERO_BYTE_TAIL",
            severity="critical",
            description="Remove trailing zero-byte or junk bytes after </TfrxReport>",
            action="Strip trailing bytes after </TfrxReport> tag",
            confidence=1.0
        )]

    def _fix_xml_syntax(self, report: FR3Report, issue) -> List[Fix]:
        fixes = []
        for err in report.xml_errors:
            if "unexpected end of file" in err:
                fixes.append(Fix(
                    rule_id="XML_VALIDITY",
                    severity="critical",
                    description="File truncated – missing closing tag",
                    action="Re-generate .fr3 from FastReport Designer or restore from backup",
                    confidence=0.9
                ))
            elif "unbound prefix" in err or "undeclared namespace" in err:
                fixes.append(Fix(
                    rule_id="XML_VALIDITY",
                    severity="high",
                    description="Namespace or prefix issue",
                    action="Fix XML namespace declarations at root element",
                    confidence=0.7
                ))
        return fixes

    def _fix_memo_binding(self, report: FR3Report, issue) -> List[Fix]:
        fixes = []
        for m in report.memos:
            if m.datafield and m.dataset:
                ds_name = m.dataset.split(".")[0]
                declared = {ds.name for ds in report.datasets}
                if ds_name not in declared:
                    fixes.append(Fix(
                        rule_id="MEMO_FIELD_BINDING",
                        severity="high",
                        description=f"Memo '{m.name}' references undeclared dataset '{ds_name}'",
                        action=f"Add TfrxDBDataset named '{ds_name}' under <TfrxReport>, "
                               f"or bind memo to existing dataset (e.g. frxDBDataset1)",
                        code_patch=(
                            f'  <TfrxDBDataset Name="{ds_name}" '
                            f'DataSet="DB.{ds_name}" />  '
                            f"// insert under <TfrxReport>"
                        ),
                        confidence=0.85
                    ))
        return fixes

    def _fix_orphan_dataset(self, report: FR3Report, issue) -> List[Fix]:
        fixes = []
        referenced = set()
        for m in report.memos:
            if m.dataset:
                referenced.add(m.dataset.split(".")[0])
        for ds in report.datasets:
            if ds.name not in referenced:
                fixes.append(Fix(
                    rule_id="ORPHAN_DATASET",
                    severity="medium",
                    description=f"Dataset '{ds.name}' declared but never used",
                    action=f"Either add memo bindings to dataset '{ds.name}' "
                           f"or remove the unused dataset declaration",
                    confidence=0.9
                ))
        return fixes

    def _fix_memo_overflow(self, report: FR3Report, issue) -> List[Fix]:
        if not report.pages:
            return [Fix("MEMO_OVERFLOW", "medium", "No pages", "Add a TfrxReportPage", confidence=0.9)]
        page = report.pages[0]
        page_width = page.paper_width - page.margins.get("left", 10) - page.margins.get("right", 10)
        fixes = []
        for m in report.memos:
            if m.left + m.width > page_width + page_width * 0.05:
                new_left = max(0, page_width - m.width - 1)
                fixes.append(Fix(
                    rule_id="MEMO_OVERFLOW",
                    severity="medium",
                    description=f"Memo '{m.name}' overflows at left+width={m.left:.1f}+{m.width:.1f}",
                    action=f"Reduce width or shift Left to {new_left:.1f}",
                    code_patch=(
                        f'<TfrxMemoView Name="{m.name}" '
                        f'Left="{new_left:.6f}" '
                        f'Width="{m.width:.6f}" .../>'
                    ),
                    confidence=0.95
                ))
        return fixes

    def _fix_duplicate_name(self, report: FR3Report, issue) -> List[Fix]:
        fixes = []
        seen: dict = {}
        for m in report.memos:
            if m.name:
                if m.name in seen:
                    fixes.append(Fix(
                        rule_id="DUPLICATE_NAME",
                        severity="low",
                        description=f"Duplicate name '{m.name}' at ({m.left:.0f},{m.top:.0f}) "
                                    f"and {seen[m.name]}",
                        action=f"Rename one of the duplicates (e.g. add suffix)",
                        confidence=0.9
                    ))
                else:
                    seen[m.name] = f"({m.left:.0f},{m.top:.0f})"
        return fixes

    def _fix_script_syntax(self, report: FR3Report, issue) -> List[Fix]:
        if not report.script:
            return []
        s = report.script.text
        if "begin" not in s:
            return [Fix(
                rule_id="SCRIPT_SYNTAX",
                severity="high",
                description="Missing begin..end block in PascalScript",
                action="Add 'begin ... end.' block at the end of the script",
                code_patch="begin\nend.",
                confidence=0.8
            )]
        return []
