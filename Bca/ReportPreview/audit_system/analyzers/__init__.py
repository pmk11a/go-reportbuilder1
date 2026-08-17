"""
Analyzer registry — dispatches to language-specific analyzers.
"""
from __future__ import annotations
from typing import Dict, List, Optional

from analyzer import BaseAnalyzer, AuditResult
from .nextjs_analyzer import NextjsAnalyzer
from .go_analyzer import GoAnalyzer


class AnalyzerRegistry:
    """Registry that maps languages to their analyzers."""

    _analyzers: Dict[str, BaseAnalyzer] = {}
    _extensions: Dict[str, str] = {}  # ext -> analyzer

    def __init__(self):
        self.register(NextjsAnalyzer())
        self.register(GoAnalyzer())

    def register(self, analyzer: BaseAnalyzer):
        """Register an analyzer by language."""
        self._analyzers[analyzer.language] = analyzer
        for ext in analyzer.file_extensions:
            self._extensions[ext] = analyzer.language

    def get_analyzer(self, file_path: str) -> Optional[BaseAnalyzer]:
        """Get the right analyzer for a file path."""
        ext = "." + file_path.rsplit(".", 1)[-1].lower() if "." in file_path else ""
        return self._analyzers.get(self._extensions.get(ext))

    def get_analyzer_by_language(self, language: str) -> Optional[BaseAnalyzer]:
        return self._analyzers.get(language)

    def list_languages(self) -> List[str]:
        return list(self._analyzers.keys())

    def audit_file(self, file_path: str) -> Optional[AuditResult]:
        analyzer = self.get_analyzer(file_path)
        if analyzer:
            return analyzer.audit(file_path)
        return None

    def audit_directory(self, dir_path: str, language: Optional[str] = None,
                        limit: Optional[int] = None) -> List[AuditResult]:
        """Audit all files in directory, optionally filtered by language."""
        results = []
        analyzer = self._analyzers[language] if language else None

        if analyzer:
            files = analyzer.scan_directory(dir_path, limit=limit)
            for f in files:
                r = analyzer.audit(f)
                if r:
                    results.append(r)
        else:
            # Scan all registered languages
            import os
            for lang_analyzer in self._analyzers.values():
                for f in lang_analyzer.scan_directory(dir_path, limit=limit):
                    r = lang_analyzer.audit(f)
                    if r:
                        results.append(r)

        return results


__all__ = ["AnalyzerRegistry"]