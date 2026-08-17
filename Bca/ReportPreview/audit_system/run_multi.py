"""
Multi-language audit runner — uses AnalyzerRegistry to audit any codebase.
"""
from __future__ import annotations
import sys
from pathlib import Path
from typing import Dict, List, Optional

sys.path.insert(0, str(Path(__file__).parent))

from analyzer import BaseAnalyzer, AuditResult
from analyzers import AnalyzerRegistry
from learning_engine.engine import LearningEngine


class MultiLanguageAuditor:
    """Audit any codebase using pluggable language analyzers."""

    def __init__(self, config_path: str = "d:/TestLaB/piagent/Bca/ReportPreview/audit_system/config/audit_config.json"):
        self.registry = AnalyzerRegistry()
        self.engine = LearningEngine()

    def audit(self, source: str, language: Optional[str] = None,
              limit: Optional[int] = None, apply: bool = False) -> List[AuditResult]:
        results = self.registry.audit_directory(source, language=language, limit=limit)

        # Run learning engine on results
        for r in results:
            for issue in r.issues:
                if issue.severity in ("high", "critical"):
                    self.engine.learn(
                        rule_id=issue.rule_id,
                        pattern=issue.message,
                        fix_action=issue.suggestion,
                        confidence=0.9 if issue.severity == "critical" else 0.7,
                        applied=False,
                        success=False,
                        example_path=r.file_path,
                        language=r.metadata.get("language", "unknown"),
                    )

        return results

    def audit_single_file(self, file_path: str) -> Optional[AuditResult]:
        return self.registry.audit_file(file_path)

    def get_supported_languages(self) -> List[str]:
        return self.registry.list_languages()


def main():
    import argparse
    ap = argparse.ArgumentParser(description="Multi-language FR3/Go/Next.js Auditor")
    ap.add_argument("source", help="Source directory or file")
    ap.add_argument("--language", help="Filter by language (nextjs, go, fr3)")
    ap.add_argument("--limit", type=int)
    ap.add_argument("--apply", action="store_true")
    args = ap.parse_args()

    auditor = MultiLanguageAuditor()
    print(f"Supported languages: {auditor.get_supported_languages()}")

    source = args.source
    if Path(source).is_file():
        result = auditor.audit_single_file(source)
        if result:
            print(f"File: {result.file_path}")
            print(f"Score: {result.score}")
            for issue in result.issues[:5]:
                print(f"  [{issue.severity}] {issue.rule_id}: {issue.message}")
    else:
        results = auditor.audit(source, language=args.language, limit=args.limit)
        print(f"\nAudited {len(results)} files")
        for r in results[:5]:
            print(f"  {r.file_path}: {r.score}/100")


if __name__ == "__main__":
    main()