"""
Analyzer base class — all language analyzers extend this.
"""
from __future__ import annotations
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Optional


@dataclass
class AuditIssue:
    rule_id: str
    severity: str  # critical, high, medium, low
    message: str
    path: str = ""
    line: int = 0
    suggestion: str = ""


@dataclass
class AuditResult:
    file_path: str
    score: float
    issues: List[AuditIssue] = field(default_factory=list)
    metadata: Dict[str, Any] = field(default_factory=dict)


class BaseAnalyzer(ABC):
    """Abstract analyzer — each language gets its own subclass."""

    language: str = "unknown"
    file_extensions: List[str] = []

    @abstractmethod
    def audit(self, file_path: str) -> AuditResult:
        """Audit a single file and return result."""
        ...

    @abstractmethod
    def scan_directory(self, dir_path: str, recursive: bool = True,
                       limit: Optional[int] = None) -> List[str]:
        """Scan directory and return list of matching file paths."""
        ...

    def get_language(self) -> str:
        return self.language

    def get_extensions(self) -> List[str]:
        return self.file_extensions


__all__ = ["BaseAnalyzer", "AuditIssue", "AuditResult"]