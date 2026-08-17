# FR3 Audit & Validation System

> Self-improving FastReport (.fr3) audit, validation, and auto-fix system.

## Structure

```
audit_system/
├── config/
│   └── audit_config.json       # Rules & thresholds
├── fr3_parser/
│   ├── __init__.py
│   ├── parser.py               # XML parser → FR3Report model
│   ├── auditor.py              # Rule engine
│   └── fix_generator.py        # Self-healing suggestions
├── learning_engine/
│   ├── __init__.py
│   └── engine.py               # Skills + log book
├── reports/                    # Markdown + JSON outputs
├── logs/                       # Audit log
├── baselines/                  # Reference baselines
├── orchestrator.py             # Top-level API
├── run_audit.py                # CLI runner
└── audit_config.json
```

## Quick start

```bash
# Audit a single file
python run_audit.py "d:/TestLaB/piagent/Bca/ReportFiles/ReportKasHarian.fr3"

# Audit entire directory
python run_audit.py "d:/TestLaB/piagent/Bca/ReportFiles" --limit 50

# Apply fixes
python run_audit.py "d:/TestLaB/piagent/Bca/ReportFiles" --apply
```

## Rules

| ID | Severity | Description |
|---|---|---|
| XML_VALIDITY | critical | File must be well-formed XML |
| FR_VERSION | medium | FastReport 3.18 or higher |
| ZERO_BYTE_TAIL | critical | No zero bytes after `</TfrxReport>` |
| DATASET_REFERENCED | high | Datasets referenced must be declared |
| MEMO_FIELD_BINDING | high | Memo with data-binding needs DataSet |
| SCRIPT_SYNTAX | high | PascalScript must have begin/end |
| MEMO_OVERFLOW | medium | Memos within page boundaries |
| DUPLICATE_NAME | low | No duplicate element names |
| DUPLICATE_FIELD | low | No duplicate field names |
| ORPHAN_DATASET | medium | Declared datasets must be used |
| MEMO_FONT_MISSING | low | All memos need Font.Name |
| PAGE_LAYOUT | low | Page must have valid dimensions |

## Self-Improvement

The `learning_engine` records every audit cycle in `logs/` and updates
`learning_engine/skills.json` with successful fix patterns.
Each skill tracks:
- `applied_count` – how often the fix was used
- `success_rate` – rolling success metric
- `confidence` – used as a filter when proposing fixes