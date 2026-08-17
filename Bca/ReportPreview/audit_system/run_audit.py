#!/usr/bin/env python3
"""Quick audit runner — single file or directory."""
import sys
import json
from pathlib import Path

# Make imports work standalone
sys.path.insert(0, str(Path(__file__).parent))

from fr3_parser import FR3Parser, FR3Auditor, FR3FixGenerator
from learning_engine import SelfImprovementEngine
from report_generator import ReportGenerator
from orchestrator import AuditOrchestrator


def main():
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("path", help="File or directory to audit")
    ap.add_argument("--limit", type=int)
    args = ap.parse_args()

    orch = AuditOrchestrator()
    src = args.path
    if Path(src).is_file():
        # single file
        parser = FR3Parser(src)
        r = parser.parse()
        result = orch.auditor.audit(r)
        print(json.dumps({
            "file": src,
            "score": result.score,
            "passed": result.passed,
            "issues": [
                {
                    "rule_id": i.rule_id,
                    "severity": i.severity,
                    "message": i.message,
                    "suggestion": i.suggestion,
                } for i in result.issues
            ],
            "summary": result.summary,
        }, indent=2, ensure_ascii=False))
    else:
        out = orch.run_full_audit(source_dir=src, limit=args.limit, apply_fixes=False)
        print(json.dumps(out["skill_report"], indent=2))
        print("\nGenerated:", out["paths"])


if __name__ == "__main__":
    main()