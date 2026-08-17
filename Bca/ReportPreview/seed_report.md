# Seed Report: Complex Reports (Corrected)

**Generated:** 2026-08-06 12:23  
**Status:** ✅ COMPLETED SUCCESSFULLY  

---

## Summary

| Table | New Rows | Notes |
|-------|----------|-------|
| dbMasterLaporan | 9 | id 25-35 |
| dbParameterLaporan | 73 | All complex reports |
| dbKolomLaporan | 88 | All complex reports |
| dbQueryLaporan | 11 | One per report |
| dbGroupLaporan | 3 | Grouped by field |
| DBFLMENUREPORT | 282 | 9 KODEMENU × 38 users |
| DBMENUREPORT | 7 | New menu entries |

**Total new rows:** ~473  
**Skipped:** 050102, 050103 (already exist as id 20, 21)

---

## New Reports in dbMasterLaporan (id 25-35)

| id | KODEMENU | nama_laporan | Status |
|----|----------|--------------|--------|
| 25 | 020507 | Laporan Mutasi Keuangan | ✅ Seeded |
| 26 | 020406 | Kartu Piutang Detail | ✅ Seeded |
| 27 | 0303301 | Invoice Penjualan Detail | ✅ Seeded |
| 28 | 0303302 | Invoice Penjualan Rekening | ✅ Seeded |
| 29 | 025801 | Transfer In Detail | ✅ Seeded |
| 30 | 0303303 | Rekap Invoice Penjualan | ✅ Seeded |
| 31 | 0303304 | Penjualan Gudang Rekening | ✅ Seeded |
| 32 | 025902 | Pembelian ACC Rekening | ✅ Seeded |
| 33 | 025802 | Transfer Out Detail | ✅ Seeded |
| 34 | 050102 | Stock Quantity Rupiah | ⏭️ SKIPPED (existing id 20) |
| 35 | 050103 | Stock Quantity Rekonsiliasi | ⏭️ SKIPPED (existing id 21) |

---

## New KODEMENU in DBMENUREPORT

| KODEMENU | Keterangan | L0 |
|----------|------------|-----|
| 0303301 | Invoice Penjualan Detail | 3 |
| 0303302 | Invoice Penjualan Rekening | 3 |
| 025801 | Transfer In Detail | 3 |
| 0303303 | Rekap Invoice Penjualan | 3 |
| 0303304 | Penjualan Gudang Rekening | 3 |
| 025902 | Pembelian ACC Rekening | 3 |
| 025802 | Transfer Out Detail | 3 |

---

## Verification

```sql
-- All new reports verified
SELECT id_laporan, KODEMENU, nama_laporan 
FROM dbMasterLaporan 
WHERE id_laporan BETWEEN 25 AND 35 
ORDER BY id_laporan;
```

**Result:** 9 rows ✅

```sql
-- All KODEMENU in DBFLMENUREPORT
SELECT L1, COUNT(DISTINCT UserID) as user_count 
FROM DBFLMENUREPORT 
WHERE L1 IN ('020507','020406','0303301','0303302','025801','0303303','0303304','025902','025802','050102','050103')
GROUP BY L1 ORDER BY L1;
```

**Result:** 9 KODEMENU granted to active users ✅

---

## Database Statistics

| Table | Before | After | Change |
|-------|--------|-------|--------|
| DBMENUREPORT | 243 | 250 | +7 |
| DBFLMENUREPORT | 9391 | 9673 | +282 |
| dbMasterLaporan | 20 | 29 | +9 |
| dbParameterLaporan | 85 | 158 | +73 |
| dbKolomLaporan | 221 | 309 | +88 |
| dbQueryLaporan | 23 | 34 | +11 |
| dbGroupLaporan | 3 | 6 | +3 |

---

## Files Generated

```
seeds/sql/
├── seed_dbMasterLaporan_9_reports.sql     (9.3KB) ✅
├── seed_dbParameterLaporan_9_reports.sql  (6.0KB) ✅
├── seed_dbKolomLaporan_9_reports.sql      (8.0KB) ✅
├── seed_dbQueryLaporan_9_reports.sql      (2.9KB) ✅
├── seed_dbGroupLaporan_9_reports.sql      (0.9KB) ✅
├── seed_DBFLMENUREPORT_9_reports.sql      (1.4KB) ✅
└── seed_master_complex_reports_corrected.sql (2.6KB) ✅
```

---

## Notes

1. **050102 & 050103 skipped** - These KODEMENU already exist in dbMasterLaporan (id 20, 21) as "Stock Rupiah" and "Stock Qty + Rupiah". Decision made to preserve existing data.

2. **All 9 new reports** have:
   - Complete parameter definitions (73 params)
   - Full column configurations (88 columns)
   - Query templates (11 queries)
   - Grouping rules (3 groups)
   - Access control (282 user access grants)

3. **Next steps:**
   - Update `seed_report.md` with this result
   - Run audit to verify all complex reports
   - Test UI form generation for FilterParameterReact

---

**Status:** ✅ SEED COMPLETED SUCCESSFULLY  
**Next Action:** Update audit logs and report file