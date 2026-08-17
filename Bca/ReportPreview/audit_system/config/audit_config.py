"""Configuration loader"""
import json
from pathlib import Path

DEFAULT_CONFIG = {
    "paths": {},
    "audit_rules": {},
    "validation_thresholds": {},
    "baseline_compare": {},
    "self_improvement": {},
    "reporting": {},
}


def load_config(path: str) -> dict:
    p = Path(path)
    if not p.exists():
        return DEFAULT_CONFIG
    with open(p, "r", encoding="utf-8") as f:
        return json.load(f)


def merge_config(*dicts: dict) -> dict:
    out = {}
    for d in dicts:
        if d:
            for k, v in d.items():
                if k in out and isinstance(out[k], dict) and isinstance(v, dict):
                    out[k] = merge_config(out[k], v)
                else:
                    out[k] = v
    return out