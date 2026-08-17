#!/usr/bin/env python3
"""High-level dashboard runner."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from dashboard import AuditDashboard


def main():
    import argparse
    ap = argparse.ArgumentParser(description="FR3 Audit Dashboard")
    ap.add_argument("source", help="Source directory")
    ap.add_argument("--baseline", help="Baseline name to compare")
    ap.add_argument("--limit", type=int)
    ap.add_argument("--apply", action="store_true", help="Apply fixes")
    ap.add_argument("--config", default="d:/TestLaB/piagent/Bca/ReportPreview/audit_system/config/audit_config.json")
    args = ap.parse_args()

    dash = AuditDashboard(args.config)
    dash.run(args.source, baseline=args.baseline, limit=args.limit, apply=args.apply)


if __name__ == "__main__":
    main()