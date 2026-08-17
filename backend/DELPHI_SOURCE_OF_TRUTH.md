# Delphi Source of Truth Reference

**Folder aktif yang user tunjuk:** `D:/TestLaB/Golang/Bca/ReportPreview/`

## Daftar File Referensi

| File | Path Absolut | Line Penting |
|---|---|---|
| FrmReportPreview.pas | `D:/TestLaB/Golang/Bca/ReportPreview/FrmReportPreview.pas` | 2011, 3658, 4777 |
| FrmMenuReport.pas | `D:/TestLaB/Golang/Bca/ReportPreview/FrmMenuReport.pas` | - |

## PENTING

⚠️ **SELALU gunakan path `D:/TestLaB/Golang/Bca/`** untuk referensi Delphi.

❌ **JANGAN** gunakan path lain seperti:
- `D:/TestLaB/FitiurOri/` (sistem lama)
- `D:/TestLaB/Acc/`
- `D:/TestLaB/Fitur/`
- `D:/TestLaB/piagent/`
- `D:/TestLaB/trade-kasbank/`
- `D:/TestLaB/trade-keu/`
- `D:/TestLaB/GolangReport/`
- `D:/TestLaB/Golang/pwt/` (Versi berbeda)

## Verifikasi Sebelum Pakai

```bash
# Cek file aktif yang user maksud
ls D:/TestLaB/Golang/Bca/ReportPreview/FrmReportPreview.pas

# Cek line penting
grep -n "3030101.*ShowReportPreview\|20401.*ShowReportPreview\|3030101.*sql.add" \
  D:/TestLaB/Golang/Bca/ReportPreview/FrmReportPreview.pas
```

## Root Cause (Salah Pakai Path)

Saya pernah salah pakai path `D:/TestLaB/FitiurOri/` karena tidak konsisten
merujuk ke path aktif yang user tunjuk. Sejak insiden ini, **path aktif**
adalah `D:/TestLaB/Golang/Bca/`.
