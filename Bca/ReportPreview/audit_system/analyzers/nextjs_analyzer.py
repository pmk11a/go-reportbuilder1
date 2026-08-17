"""
Next.js / React analyzer — checks for common React/Next.js issues.
"""
from __future__ import annotations
import re
import os
from dataclasses import dataclass, field
from typing import List, Optional, Any

from analyzer import BaseAnalyzer, AuditIssue, AuditResult


class NextjsAnalyzer(BaseAnalyzer):
    """Analyzer for Next.js / React codebases (.tsx, .jsx, .ts, .js)."""

    language = "nextjs"
    file_extensions = [".tsx", ".jsx", ".ts", ".js"]

    # Common Next.js anti-patterns
    RULES = [
        {
            "rule_id": "NO_IMPORT_NEXT",
            "severity": "high",
            "pattern": r'from\s+["\']next["\']',
            "suggestion": "Use next/dynamic for client-only imports",
        },
        {
            "rule_id": "UNSAFE_LIFECYCLE",
            "severity": "high",
            "pattern": r"componentWillMount|componentWillReceiveProps|componentWillUpdate",
            "suggestion": "Replace with useEffect or getDerivedStateFromProps",
        },
        {
            "rule_id": "MISSING_KEY",
            "severity": "medium",
            "pattern": r"\.map\([^,]+,\s*\(",
            "suggestion": "Add 'key' prop when mapping over arrays",
        },
        {
            "rule_id": "SERVER_IMPORT_CLIENT",
            "severity": "high",
            "pattern": r'import\s+.*\s+from\s+["\'](fs|path|os)["\']',
            "suggestion": "Server modules cannot be imported in client components",
        },
        {
            "rule_id": "MISSING_ERROR_BOUNDARY",
            "severity": "low",
            "pattern": r"export\s+default\s+function\s+\w+",
            "suggestion": "Consider adding error boundary for this component",
        },
        {
            "rule_id": "UNUSED_IMPORT",
            "severity": "low",
            "pattern": r"^import\s+.*\s+from",
            "suggestion": "Check for unused imports",
        },
        {
            "rule_id": "INLINE_STYLE",
            "severity": "medium",
            "pattern": r"style\s*=\s*\{",
            "suggestion": "Use CSS modules or Tailwind instead of inline styles",
        },
        {
            "rule_id": "MUTABLE_STATE",
            "severity": "medium",
            "pattern": r"setState\((.+)\)",
            "suggestion": "Use functional updates: setState(prev => ({ ...prev, ... }))",
        },
        {
            "rule_id": "MISSING_ASYNC_ERROR",
            "severity": "high",
            "pattern": r"async\s+\w+\s*\([^)]*\)\s*:\s*Promise",
            "suggestion": "Add error handling for async operations",
        },
        {
            "rule_id": "LARGE_BUNDLE_WARNING",
            "severity": "medium",
            "pattern": r"import\s+.*\s+from\s+['\"]webpack['\"]",
            "suggestion": "Check bundle size — consider dynamic imports",
        },
    ]

    def audit(self, file_path: str) -> AuditResult:
        issues = []
        content = self._read_file(file_path)
        if content is None:
            return AuditResult(file_path=file_path, score=0.0, issues=[])

        lines = content.split("\n")
        severity_weights = {"critical": 4, "high": 3, "medium": 2, "low": 1}
        total_weight = 0
        found_weight = 0

        for line_no, line in enumerate(lines, 1):
            for rule in self.RULES:
                if re.search(rule["pattern"], line, re.IGNORECASE):
                    # Skip if line is a comment
                    stripped = line.strip()
                    if stripped.startswith("//") or stripped.startswith("*") or stripped.startswith("/*"):
                        continue

                    issue = AuditIssue(
                        rule_id=rule["rule_id"],
                        severity=rule["severity"],
                        message=f"{self._get_message(rule['rule_id'])} — line {line_no}",
                        path=file_path,
                        line=line_no,
                        suggestion=rule["suggestion"],
                    )
                    issues.append(issue)
                    found_weight += severity_weights.get(rule["severity"], 1)
            total_weight += 1

        # Calculate score (100 - penalty)
        penalty = found_weight * 2
        score = max(0, 100 - penalty)

        return AuditResult(
            file_path=file_path,
            score=round(score, 2),
            issues=issues,
            metadata={"language": self.language, "lines": len(lines)},
        )

    def scan_directory(self, dir_path: str, recursive: bool = True,
                       limit: Optional[int] = None) -> List[str]:
        files = []
        for root, dirs, filenames in os.walk(dir_path):
            for fname in filenames:
                ext = os.path.splitext(fname)[1].lower()
                if ext in self.file_extensions:
                    full = os.path.join(root, fname)
                    files.append(full)
                    if limit and len(files) >= limit:
                        return files
            if not recursive:
                break
        return files

    def _read_file(self, path: str) -> Optional[str]:
        try:
            return open(path, "r", encoding="utf-8").read()
        except (UnicodeDecodeError, FileNotFoundError, PermissionError):
            try:
                return open(path, "r", encoding="latin-1").read()
            except Exception:
                return None

    def _get_message(self, rule_id: str) -> str:
        messages = {
            "NO_IMPORT_NEXT": "Next.js import detected in client component",
            "UNSAFE_LIFECYCLE": "Unsafe lifecycle method detected",
            "MISSING_KEY": "Potential missing key prop in map",
            "SERVER_IMPORT_CLIENT": "Server module imported in client component",
            "MISSING_ERROR_BOUNDARY": "Component may need error boundary",
            "UNUSED_IMPORT": "Potential unused import",
            "INLINE_STYLE": "Inline style detected — consider CSS module",
            "MUTABLE_STATE": "Direct state mutation detected",
            "MISSING_ASYNC_ERROR": "Async function without error handling",
            "LARGE_BUNDLE_WARNING": "Webpack import — check bundle size",
        }
        return messages.get(rule_id, "Rule violation detected")


__all__ = ["NextjsAnalyzer"]