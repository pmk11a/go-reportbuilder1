"""
Learning engine — language-agnostic skill storage & pattern compiler.
Kept as-is (already generic).
"""
from __future__ import annotations
import json
import time
import re
from pathlib import Path
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any

from fr3_parser import AuditResult


@dataclass
class LearnedSkill:
    rule_id: str
    pattern: str
    fix_action: str
    confidence: float
    applied_count: int
    success_rate: float
    example_path: str
    language: str = "unknown"  # NEW: track language


@dataclass
class SkillPattern:
    rule_id: str
    regex: str
    fix_pattern: str
    language: str


class LearningEngine:
    """Language-agnostic learning engine for any codebase."""

    def __init__(
        self,
        skills_path: str = "d:/TestLaB/piagent/Bca/ReportPreview/audit_system/learning_engine/skills.json",
        patterns_path: str = "d:/TestLaB/piagent/Bca/ReportPreview/audit_system/learning_engine/patterns.json",
    ):
        self.skills_path = Path(skills_path)
        self.patterns_path = Path(patterns_path)
        self._skills: Dict[str, LearnedSkill] = {}
        self._load()

    def _load(self):
        if self.skills_path.exists():
            data = json.loads(self.skills_path.read_text(encoding="utf-8"))
            for s in data.get("skills", []):
                self._skills[s["rule_id"]] = LearnedSkill(**s)
        if self.patterns_path.exists():
            pass  # compiled separately

    def _save_skills(self):
        self.skills_path.parent.mkdir(parents=True, exist_ok=True)
        payload = {
            "total_skills": len(self._skills),
            "skills": [
                {
                    "rule_id": s.rule_id,
                    "pattern": s.pattern,
                    "fix_action": s.fix_action,
                    "confidence": s.confidence,
                    "applied_count": s.applied_count,
                    "success_rate": s.success_rate,
                    "example_path": s.example_path,
                    "language": s.language,
                }
                for s in self._skills.values()
            ],
            "total_audits": getattr(self, "_total_audits", 0),
            "total_fixes_applied": getattr(self, "_total_fixes_applied", 0),
            "avg_score": getattr(self, "_avg_score", 0.0),
        }
        self.skills_path.write_text(json.dumps(payload, indent=2, ensure_ascii=False), encoding="utf-8")

    def learn(self, rule_id: str, pattern: str, fix_action: str, confidence: float,
              applied: bool, success: bool, example_path: str, language: str = "unknown"):
        """Register a new skill or update existing."""
        if rule_id in self._skills:
            s = self._skills[rule_id]
            s.applied_count += 1 if applied else 0
            # weighted moving average for success rate
            s.success_rate = s.success_rate * 0.9 + (1.0 if success else 0.0) * 0.1
            s.confidence = min(1.0, s.confidence * 0.95 + confidence * 0.05)
        else:
            self._skills[rule_id] = LearnedSkill(
                rule_id=rule_id,
                pattern=pattern,
                fix_action=fix_action,
                confidence=confidence,
                applied_count=1 if applied else 0,
                success_rate=1.0 if success else 0.0,
                example_path=example_path,
                language=language,
            )
        self._save_skills()
        self._compile_patterns()

    def _compile_patterns(self):
        """Compile skills → regex patterns for fast matching."""
        compiled = []
        for s in self._skills.values():
            if s.success_rate >= 0.8:  # only compile successful skills
                compiled.append({
                    "rule_id": s.rule_id,
                    "regex": s.pattern,
                    "fix_pattern": s.fix_action,
                    "language": s.language,
                })
        self.patterns_path.write_text(
            json.dumps(compiled, indent=2, ensure_ascii=False),
            encoding="utf-8",
        )

    def get_skill_report(self) -> Dict[str, Any]:
        return {
            "total_skills": len(self._skills),
            "skills": [
                {
                    "rule_id": s.rule_id,
                    "pattern": s.pattern,
                    "fix_action": s.fix_action,
                    "confidence": s.confidence,
                    "applied_count": s.applied_count,
                    "success_rate": s.success_rate,
                    "example_path": s.example_path,
                    "language": s.language,
                }
                for s in self._skills.values()
            ],
            "total_audits": getattr(self, "_total_audits", 0),
            "total_fixes_applied": getattr(self, "_total_fixes_applied", 0),
            "avg_score": getattr(self, "_avg_score", 0.0),
            "patterns": len(list(self.patterns_path.read_text(encoding="utf-8").strip()) if self.patterns_path.exists() else []),
        }

    def get_language_skills(self, language: str) -> Dict[str, LearnedSkill]:
        return {k: v for k, v in self._skills.items() if v.language == language}


__all__ = ["LearningEngine", "LearnedSkill"]