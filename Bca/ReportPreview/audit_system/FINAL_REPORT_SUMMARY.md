# Final Report Mapping - seed_complete.sql

**Generated:** 2026-08-06  
**Total Reports:** 61  
**Status:** ✅ KODEMENU verified against DBMENUREPORT

## Report Mapping (REPORT 1-61)

| No | KODEMENU | Report Name | Notes |
|----|----------|-------------|-------|
| 1-49 | Various | Laporan Standar | Existing DBMENUREPORT |
| 50 | 020409 | History KP | Existing |
| 51 | 303322 | ReportPLInvoice_DPP | New (303xx range) |
| 52 | 303242 | ReportKontrakvsSJ | New |
| 53 | 303241 | ReportKartuProyek | KodeReport=60 |
| 54 | 303243 | ReportKartuProyekBarang | New |
| 55 | **020501** | ReportNeracaLajur | Reusing existing 020501 |
| 56 | **020504** | ReportNeraca | Reusing existing 020504 |
| 57 | **020508** | ReportNeracaOld | NEW - was 20501 (5-digit) |
| 58 | **020509** | Barang_ukuran | NEW - was 20506 (asumsi) |
| 59 | **020510** | ReportKartuStok1 | NEW |
| 60 | **020511** | ReportCrossCheckBPPB | NEW |
| 61 | **020512** | ReportPerhitunganPoint | NEW |

## Verifikasi KODEMENU (query ke DBMENUREPORT)

```
303241: AVAILABLE ✅
303242: AVAILABLE ✅
303243: AVAILABLE ✅
303322: AVAILABLE ✅
020501: EXISTS as "Neraca Lajur" ✅
020504: EXISTS as "Neraca" ✅
020508: AVAILABLE ✅
020509: AVAILABLE ✅
020510: AVAILABLE ✅
020511: AVAILABLE ✅
020512: AVAILABLE ✅
```

## SP yang digunakan

| Report | SP | Params |
|--------|----|----|
| ReportNeracaOld | sp_ReportNeracaAktiva + sp_ReportNeracaPasiva | Devisi, Bulan, Tahun |
| Barang_ukuran | Sp_reportkartuStock | KodeBrg, KodeGdg, Bulan1/2, Tahun1/2, NoSat |
| ReportKartuStok1 | Sp_reportkartuStock | (same) |
| ReportCrossCheckBPPB | Sp_reportOutStandingBPPBRek | Choice, Tgl1, Tgl2 |
| ReportPerhitunganPoint | Sp_reportDebetnoteDet | KodeCust, Tgl1, Tgl2 |

## Catatan

- REPORT 55-56 sebelumnya pakai KODEMENU 5-digit (`20501`, `20502`) yang conflict dengan id existing di dbMasterLaporan (`020502=Laba Rugi`, `020503=Neraca`). Sudah dikoreksi ke 6-digit format `020501` (Neraca Lajur) dan `020504` (Neraca).
- 5 report baru (REPORT 57-61) assign ke KODEMENU kosong `020508-020512` di range 0205xx (Rugi Laba & Neraca category).
- Report 53 (ReportKartuProyek) KodeReport di Pascal = `60` (tanpa leading zero), tapi DBMENUREPORT pakai `060` - mapped ke `303241` untuk konsistensi dengan KODEMENU 6-digit.
