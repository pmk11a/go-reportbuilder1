# FR3 Audit Report
**Generated**: 2026-08-06 07:18:58

## Summary
| Metric | Value |
|--------|-------|
| Files scanned | 5 |
| Passed | 5 |
| Failed | 0 |
| Avg score | 60.8 / 100 |
| Valid XML | 2 |
| Invalid XML | 3 |
| Zero-byte tail | 0 |
| Total datasets | 7 |
| Total memos | 124 |

## Severity Distribution
- **high**: 15
- **low**: 20
- **medium**: 15
- **critical**: 10

## Top Rule Violations
- `DATASET_REFERENCED`: 5 occurrences
- `DUPLICATE_FIELD`: 5 occurrences
- `DUPLICATE_NAME`: 5 occurrences
- `FR_VERSION`: 5 occurrences
- `MEMO_FIELD_BINDING`: 5 occurrences
- `MEMO_FONT_MISSING`: 5 occurrences
- `MEMO_OVERFLOW`: 5 occurrences
- `ORPHAN_DATASET`: 5 occurrences
- `PAGE_LAYOUT`: 5 occurrences
- `SCRIPT_SYNTAX`: 5 occurrences

## Top Failing Files
- `BatalBPPB.fr3` — score **60.0** — 12 issues
- `BatalPO.fr3` — score **60.0** — 12 issues
- `BPPL.fr3` — score **60.0** — 12 issues
- `Barang_ukuran.fr3` — score **62.0** — 12 issues
- `Copy of ReporRJualPertipe.fr3` — score **62.0** — 12 issues

## Learning Engine
- Total skills: 3
- Total audits: 0
- Total fixes applied: 0
- Avg score: 0.0

### Skills
- `MEMO_OVERFLOW` (applied 45x, success rate 99%, conf 1.00): Memo 'Memo17' overflows at left+width=0.0+260.8
- `ORPHAN_DATASET` (applied 1x, success rate 10%, conf 0.95): Dataset 'Data' declared but never used
- `ZERO_BYTE_TAIL` (applied 1x, success rate 10%, conf 1.00): Remove trailing zero-byte or junk bytes after </TfrxReport>

## Recommendations
- ⚠️ **3 files** have invalid XML. Run repair through FastReport Designer.
- 🔴 Average score below threshold (80). Prioritize critical issues.
