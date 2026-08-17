"""
Schema baseline comparator — diff between FR3 reports against a saved baseline.
"""
from __future__ import annotations
import json
import hashlib
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional, Any

from fr3_parser import FR3Report, FR3Auditor, AuditResult


@dataclass
class DiffEntry:
    file_a: str
    file_b: str
    type: str  # "missing", "added", "changed"
    path: str  # JSON-like path within report (e.g. "datasets[2].fields")
    detail: str = ""
    severity: str = "low"


@dataclass
class BaselineDiff:
    entries: List[DiffEntry] = field(default_factory=list)

    @property
    def critical_count(self) -> int:
        return sum(1 for e in self.entries if e.severity == "critical")

    @property
    def high_count(self) -> int:
        return sum(1 for e in self.entries if e.severity == "high")

    def to_markdown(self) -> str:
        lines = ["# Baseline Diff\n"]
        if not self.entries:
            lines.append("✅ No differences.\n")
            return "\n".join(lines)
        by_type: Dict[str, List[DiffEntry]] = {}
        for e in self.entries:
            by_type.setdefault(e.type, []).append(e)
        for t, items in by_type.items():
            lines.append(f"## {t.upper()} ({len(items)})")
            for i in items:
                lines.append(f"- `{i.file_a}` → `{i.file_b}` | `{i.path}` | {i.detail}  _{i.severity}_")
            lines.append("")
        return "\n".join(lines)


def _report_signature(report: FR3Report) -> Dict[str, Any]:
    """Compute a normalized structural signature (without content) for comparison."""
    return {
        "version": report.version,
        "pages": [{
            "paper_w": round(p.paper_width, 1),
            "paper_h": round(p.paper_height, 1),
            "orientation": p.orientation,
            "margins": getattr(p, 'margins', [0]*4),
        } for p in report.pages],
        "datasets": [sorted(d.fields) for d in report.datasets],
        "dataset_names": sorted([d.name for d in report.datasets]),
        "memo_count": len(report.memos),
        "variables": sorted(getattr(report, 'variables', [])),
        "script_procs": len(report.script.procedures) if report.script else 0,
    }


def _signature_to_paths(sig: Dict[str, Any], prefix: str = "") -> List[str]:
    paths = []
    for k, v in sig.items():
        path = f"{prefix}.{k}" if prefix else k
        if isinstance(v, list):
            if v and isinstance(v[0], dict):
                for i, item in enumerate(v):
                    paths.extend(_signature_to_paths(item, f"{path}[{i}]"))
            else:
                paths.append(f"{path}={v}")
        elif isinstance(v, dict):
            paths.extend(_signature_to_paths(v, path))
        else:
            paths.append(f"{path}={v}")
    return paths


class BaselineComparator:
    """Compares FR3 reports against a saved baseline."""

    def __init__(self, baseline_dir: str = "d:/TestLaB/piagent/Bca/ReportPreview/audit_system/baselines"):
        self.baseline_dir = Path(baseline_dir)
        self.baseline_dir.mkdir(parents=True, exist_ok=True)

    def save_baseline(self, name: str, reports: List[FR3Report]):
        path = self.baseline_dir / f"{name}.json"
        sigs = {Path(r.file_path).name: _report_signature(r) for r in reports}
        payload = {
            "name": name,
            "saved_at": time.time(),
            "signatures": sigs,
        }
        path.write_text(json.dumps(payload, indent=2, default=str), encoding="utf-8")
        return path

    def load_baseline(self, name: str) -> Optional[Dict[str, Any]]:
        path = self.baseline_dir / f"{name}.json"
        if not path.exists():
            return None
        return json.loads(path.read_text(encoding="utf-8"))

    def compare(self, baseline_name: str, reports: List[FR3Report]) -> BaselineDiff:
        baseline = self.load_baseline(baseline_name)
        diff = BaselineDiff()
        if not baseline:
            return diff
        baseline_sigs: Dict[str, Dict[str, Any]] = baseline.get("signatures", {})

        current_sigs = {Path(r.file_path).name: _report_signature(r) for r in reports}
        all_files = set(baseline_sigs.keys()) | set(current_sigs.keys())

        for fname in all_files:
            if fname not in baseline_sigs:
                diff.entries.append(DiffEntry(file_a="<baseline>", file_b=fname,
                                              type="added", path="*",
                                              detail="file added since baseline",
                                              severity="medium"))
                continue
            if fname not in current_sigs:
                diff.entries.append(DiffEntry(file_a=fname, file_b="<current>",
                                              type="missing", path="*",
                                              detail="file removed since baseline",
                                              severity="medium"))
                continue

            base = baseline_sigs[fname]
            cur = current_sigs[fname]
            base_paths = sorted(_signature_to_paths(base))
            cur_paths = sorted(_signature_to_paths(cur))
            for p in set(base_paths) - set(cur_paths):
                diff.entries.append(DiffEntry(file_a=fname, file_b=fname, type="changed",
                                              path=p, detail="baseline value missing in current",
                                              severity="high"))
            for p in set(cur_paths) - set(base_paths):
                diff.entries.append(DiffEntry(file_a=fname, file_b=fname, type="changed",
                                              path=p, detail="current value not in baseline",
                                              severity="medium"))

        return diff


__all__ = ["BaselineComparator", "BaselineDiff", "DiffEntry"]