"""
Report generator — produces Markdown/HTML/JSON output.
"""
from __future__ import annotations
import json
import time
from pathlib import Path
from typing import List, Dict, Any, Optional

from fr3_parser import FR3Report, AuditResult
from fr3_parser.fix_generator import FR3FixGenerator
from learning_engine.engine import SelfImprovementEngine


class ReportGenerator:
    """Generates audit reports in multiple formats."""

    def __init__(self, engine: Optional[SelfImprovementEngine] = None,
                 output_dir: str = "d:/TestLaB/piagent/Bca/ReportPreview/audit_system/reports"):
        self.engine = engine
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)

    def build_summary(self, results: List[AuditResult], reports: List[FR3Report]) -> Dict[str, Any]:
        """Aggregate stats across all results."""
        total = len(results)
        passed = sum(1 for r in results if r.passed)
        avg_score = round(sum(r.score for r in results) / max(total, 1), 2)

        severity_counts: Dict[str, int] = {}
        rule_counts: Dict[str, int] = {}
        for r in results:
            for i in r.issues:
                severity_counts[i.severity] = severity_counts.get(i.severity, 0) + 1
                rule_counts[i.rule_id] = rule_counts.get(i.rule_id, 0) + 1

        top_issues = sorted(rule_counts.items(), key=lambda kv: -kv[1])[:10]

        reports_with_zero_tail = sum(1 for r in reports if r.has_zero_byte_tail)
        valid_xml = sum(1 for r in reports if r.is_valid_xml)

        return {
            "timestamp": time.time(),
            "scanned_files": total,
            "passed": passed,
            "failed": total - passed,
            "avg_score": avg_score,
            "valid_xml": valid_xml,
            "invalid_xml": total - valid_xml,
            "zero_byte_tail_count": reports_with_zero_tail,
            "severity_counts": severity_counts,
            "top_rule_violations": top_issues,
            "total_datasets": sum(len(rp.datasets) for rp in reports),
            "total_memos": sum(len(rp.memos) for rp in reports),
        }

    def to_markdown(self, results: List[AuditResult], reports: List[FR3Report]) -> str:
        summary = self.build_summary(results, reports)
        md: List[str] = []
        md.append("# FR3 Audit Report")
        md.append(f"**Generated**: {time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(summary['timestamp']))}\n")

        md.append("## Summary")
        md.append("| Metric | Value |")
        md.append("|--------|-------|")
        md.append(f"| Files scanned | {summary['scanned_files']} |")
        md.append(f"| Passed | {summary['passed']} |")
        md.append(f"| Failed | {summary['failed']} |")
        md.append(f"| Avg score | {summary['avg_score']} / 100 |")
        md.append(f"| Valid XML | {summary['valid_xml']} |")
        md.append(f"| Invalid XML | {summary['invalid_xml']} |")
        md.append(f"| Zero-byte tail | {summary['zero_byte_tail_count']} |")
        md.append(f"| Total datasets | {summary['total_datasets']} |")
        md.append(f"| Total memos | {summary['total_memos']} |")
        md.append("")

        md.append("## Severity Distribution")
        for sev, count in summary["severity_counts"].items():
            md.append(f"- **{sev}**: {count}")
        md.append("")

        md.append("## Top Rule Violations")
        for rule_id, count in summary["top_rule_violations"]:
            md.append(f"- `{rule_id}`: {count} occurrences")
        md.append("")

        md.append("## Top Failing Files")
        worst = sorted(results, key=lambda r: r.score)[:10]
        for r in worst:
            md.append(f"- `{Path(r.file_path).name}` — score **{r.score}** — {len(r.issues)} issues")
        md.append("")

        # Skills summary
        if self.engine:
            sr = self.engine.get_skill_report()
            md.append("## Learning Engine")
            md.append(f"- Total skills: {sr['total_skills']}")
            md.append(f"- Total audits: {sr['total_audits']}")
            md.append(f"- Total fixes applied: {sr['total_fixes_applied']}")
            md.append(f"- Avg score: {sr['avg_score']}")
            md.append("")
            if sr["skills"]:
                md.append("### Skills")
                for s in sr["skills"]:
                    md.append(f"- `{s['rule_id']}` (applied {s['applied_count']}x, "
                              f"success rate {s['success_rate']:.0%}, conf {s['confidence']:.2f}): "
                              f"{s['pattern']}")
                md.append("")

        # Recommendations
        md.append("## Recommendations")
        if summary["zero_byte_tail_count"] > 0:
            md.append(f"- ⚠️ **{summary['zero_byte_tail_count']} files** have zero-byte tail. "
                      "Open each in FastReport Designer and re-save as UTF-8 XML.")
        if summary["invalid_xml"] > 0:
            md.append(f"- ⚠️ **{summary['invalid_xml']} files** have invalid XML. "
                      "Run repair through FastReport Designer.")
        if summary["avg_score"] < 80:
            md.append("- 🔴 Average score below threshold (80). Prioritize critical issues.")
        else:
            md.append("- 🟢 Average score is healthy. Continue routine validation.")
        md.append("")
        return "\n".join(md)

    def write(self, results: List[AuditResult], reports: List[FR3Report],
              prefix: str = "audit") -> Dict[str, str]:
        md = self.to_markdown(results, reports)
        summary = self.build_summary(results, reports)

        paths = {}
        p1 = self.output_dir / f"{prefix}.md"
        p1.write_text(md, encoding="utf-8")
        paths["markdown"] = str(p1)

        p2 = self.output_dir / f"{prefix}.json"
        with open(p2, "w", encoding="utf-8") as f:
            json.dump({
                "summary": summary,
                "results": [
                    {
                        "file_path": r.file_path,
                        "score": r.score,
                        "passed": r.passed,
                        "issues": [
                            {
                                "rule_id": i.rule_id,
                                "severity": i.severity,
                                "message": i.message,
                                "suggestion": i.suggestion,
                            }
                            for i in r.issues
                        ]
                    } for r in results
                ],
            }, f, indent=2, ensure_ascii=False)
        paths["json"] = str(p2)

        return paths