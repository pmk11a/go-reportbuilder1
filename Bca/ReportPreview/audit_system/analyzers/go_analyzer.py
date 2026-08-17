"""
Golang analyzer — checks for common Go anti-patterns and issues.
"""
from __future__ import annotations
import re
import os
from dataclasses import dataclass, field
from typing import List, Optional, Any

from analyzer import BaseAnalyzer, AuditIssue, AuditResult


class GoAnalyzer(BaseAnalyzer):
    """Analyzer for Go codebases (.go)."""

    language = "go"
    file_extensions = [".go"]

    RULES = [
        {
            "rule_id": "GOERROR_HANDLING",
            "severity": "high",
            "pattern": r"\bif\s+err\s*!=\s*nil\s*\{",
            "suggestion": "Consider wrapping error with fmt.Errorf(\"%w\", err)",
        },
        {
            "rule_id": "GO_UNUSED_IMPORT",
            "severity": "medium",
            "pattern": r'import\s+"\w+',
            "suggestion": "Check for unused imports",
        },
        {
            "rule_id": "GO_GOROUTINE_LEAK",
            "severity": "high",
            "pattern": r"go\s+\w+\(",
            "suggestion": "Ensure goroutine has proper shutdown mechanism",
        },
        {
            "rule_id": "GO_MUTEX_LOCK",
            "severity": "medium",
            "pattern": r"\.Lock\(\)|\.RLock\(\)",
            "suggestion": "Ensure Lock() is always followed by Unlock() (defer)",
        },
        {
            "rule_id": "GO_DEFER_PANIC",
            "severity": "low",
            "pattern": r"\bpanic\(",
            "suggestion": "Use errors instead of panic for error handling",
        },
        {
            "rule_id": "GO_INTERFACE_IMPLE",
            "severity": "low",
            "pattern": r"func\s+\(\s*\*\w+\s*\w+\s*\)\s*\w+\s*\(",
            "suggestion": "Check if interface method should be on pointer or value receiver",
        },
        {
            "rule_id": "GO_CONTEXT_TIMEOUT",
            "severity": "medium",
            "pattern": r"context\.WithTimeout|context\.WithCancel",
            "suggestion": "Ensure context is cancelled after use",
        },
        {
            "rule_id": "GO_CHANNEL_BUFFER",
            "severity": "low",
            "pattern": r"make\(chan\s+\w+",
            "suggestion": "Consider buffered channels to avoid goroutine deadlock",
        },
        {
            "rule_id": "GO_SLICE_CAP",
            "severity": "low",
            "pattern": r"append\([^,]+,\s*[^)]+\)",
            "suggestion": "Check slice capacity — may cause unexpected allocations",
        },
        {
            "rule_id": "GO_NIL_POINTER",
            "severity": "critical",
            "pattern": r"\w+\s*:=\s*nil",
            "suggestion": "Initialize value before using",
        },
        {
            "rule_id": "GO_LONG_FUNC",
            "severity": "low",
            "pattern": r"func\s+\w+\s*\([^)]*\)\s*\w+",
            "suggestion": "Consider breaking into smaller functions",
        },
        {
            "rule_id": "GO_GOLINT_IMPORTS",
            "severity": "low",
            "pattern": r'"(encoding/json|io/ioutil|math/rand)"',
            "suggestion": "Use encoding/json, io/fs instead of deprecated packages",
        },
    ]

    def audit(self, file_path: str) -> AuditResult:
        issues = []
        content = self._read_file(file_path)
        if content is None:
            return AuditResult(file_path=file_path, score=0.0, issues=[])

        lines = content.split("\n")
        severity_weights = {"critical": 5, "high": 3, "medium": 2, "low": 1}
        total_weight = 0
        found_weight = 0

        for line_no, line in enumerate(lines, 1):
            stripped = line.strip()
            if stripped.startswith("//") or stripped.startswith("/*") or stripped.startswith("*"):
                continue

            for rule in self.RULES:
                if re.search(rule["pattern"], line):
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

        penalty = found_weight * 3
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
                if fname.endswith(".go"):
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
            return None

    def _get_message(self, rule_id: str) -> str:
        messages = {
            "GOERROR_HANDLING": "Error handling — consider wrapping",
            "GO_UNUSED_IMPORT": "Import detected — verify usage",
            "GO_GOROUTINE_LEAK": "Goroutine launched — ensure cleanup",
            "GO_MUTEX_LOCK": "Mutex lock — ensure defer Unlock()",
            "GO_DEFER_PANIC": "Panic detected — consider error return",
            "GO_INTERFACE_IMPLE": "Interface method — check receiver type",
            "GO_CONTEXT_TIMEOUT": "Context timeout — ensure cancel()",
            "GO_CHANNEL_BUFFER": "Unbuffered channel — consider buffer",
            "GO_SLICE_CAP": "Slice append — check capacity",
            "GO_NIL_POINTER": "Nil initialization — ensure proper init",
            "GO_LONG_FUNC": "Function definition — consider refactoring",
            "GO_GOLINT_IMPORTS": "Deprecated import — update package",
        }
        return messages.get(rule_id, "Rule violation detected")


__all__ = ["GoAnalyzer"]