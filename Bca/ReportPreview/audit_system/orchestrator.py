"""
Audit orchestrator – top-level CLI / API.
"""
from __future__ import annotations
import argparse
import json
import os
import sys
from pathlib import Path
from typing import Dict, List, Optional

# Make package-style imports work whether invoked as module or as script
_PKG_ROOT = Path(__file__).resolve().parent
if str(_PKG_ROOT) not in sys.path:
    sys.path.insert(0, str(_PKG_ROOT))

from fr3_parser import FR3Parser, FR3Auditor, FR3FixGenerator, scan_directory
from learning_engine import SelfImprovementEngine
from report_generator import ReportGenerator
from config.audit_config import load_config, merge_config


class AuditOrchestrator:
    def __init__(self, config_path: str = "d:/TestLaB/piagent/Bca/ReportPreview/audit_system/config/audit_config.json"):
        self.config = load_config(config_path)
        self.root = Path(__file__).parent
        self.auditor = FR3Auditor(self.config.get("audit_rules"))
        self.fix_generator = FR3FixGenerator()
        self.engine = SelfImprovementEngine(
            skills_path=self.config["paths"]["skills_root"] + "/skills.json",
            patterns_path=self.config["paths"]["skills_root"] + "/patterns.json",
            min_confidence_to_apply=self.config["validation_thresholds"]["min_confidence_to_apply_fix"],
        )
        self.reporter = ReportGenerator(engine=self.engine,
                                        output_dir=self.config["paths"]["reports"])

    def run_full_audit(self,
                       source_dir: Optional[str] = None,
                       limit: Optional[int] = None,
                       apply_fixes: bool = False,
                       dry_run: bool = True,
                       ) -> Dict:
        source = source_dir or self.config["paths"]["fr3_source_root"]
        print(f"[audit] Scanning: {source}")
        reports = scan_directory(source, recursive=True, limit=limit)

        results: List = []
        fix_stats: List[Dict] = []
        for report in reports:
            stat = self.engine.run_audit_and_fix(
                report=report,
                auditor=self.auditor,
                fix_generator=self.fix_generator,
                apply=apply_fixes,
                dry_run=dry_run,
            )
            # also keep raw audit for report
            ar = self.auditor.audit(report)
            results.append(ar)
            fix_stats.append({"file": report.file_path, **stat})

        # write reports
        paths = self.reporter.write(results, reports, prefix="audit_report")
        return {
            "scanned": len(reports),
            "results": results,
            "fix_stats": fix_stats,
            "paths": paths,
            "skill_report": self.engine.get_skill_report(),
        }


def main():
    ap = argparse.ArgumentParser(description="FR3 Audit & Validation System")
    ap.add_argument("--source", help="Source directory of .fr3 files")
    ap.add_argument("--limit", type=int, help="Limit number of files")
    ap.add_argument("--apply", action="store_true", help="Apply fixes (writes to disk)")
    ap.add_argument("--config", default="d:/TestLaB/piagent/Bca/ReportPreview/audit_system/config/audit_config.json")
    ap.add_argument("--out", default=None, help="Output prefix")
    args = ap.parse_args()

    orch = AuditOrchestrator(args.config)
    out = orch.run_full_audit(source_dir=args.source, limit=args.limit,
                              apply_fixes=args.apply, dry_run=not args.apply)
    print(f"[done] scanned {out['scanned']} files. Reports at:")
    print(json.dumps(out["paths"], indent=2))


if __name__ == "__main__":
    main()