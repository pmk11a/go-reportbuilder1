# 📋 RULES: KODEMENU & nama_laporan

## ⚠️ RULE #1: KODEMENU FORMAT
**SELALU gunakan format DENGAN leading zero** untuk database.

| ✅ BENAR | ❌ SALAH |
|----------|----------|
| `03030101` | `3030101` |
| `03030201` | `3030201` |
| `03031101` | `3031101` |

**Penjelasan:**
- Database (`dbmasterlaporan.KODEMENU`, `DBMENUREPORT.KODEMENU`) → **dengan leading zero** (`03030101`)
- Delphi code (`FrmReportPreview.pas`) → **tanpa leading zero** (`3030101`) karena numeric literal
- Go code (`sp_validator.go`) → **dengan leading zero** (`"03030101"`) sesuai database
- Handler (`GetReportByKodeMenu`) → sudah handle normalisasi (`TrimLeft(kodeMenu, "0")`)

## ⚠️ RULE #2: sumber nama_laporan
**nama_laporan di `dbmasterlaporan` HARUS SAMA dengan `DBMENUREPORT.keterangan`**

### Urutan Prioritas Sumber:
1. **DBMENUREPORT.keterangan** ← *Source of Truth untuk UI*
2. Delphi (`FrmReportPreview.pas`) ← *Hanya untuk referensi SP mapping*
3. Seed file ← *Harus mengikuti DBMENUREPORT*

### Flow di Aplikasi:
```sql
-- Query GetMenuTreeForUser (repository.go line 697-718)
SELECT 
    menu.Keterangan as NmReport,                          -- dari DBMENUREPORT
    COALESCE(NULLIF(m.nama_laporan, ''), menu.Keterangan) as NamaLaporan
FROM DBMENUREPORT menu
LEFT JOIN dbmasterlaporan m ON m.KODEMENU = menu.KODEMENU
```

**Hasil di UI akan menampilkan `DBMENUREPORT.keterangan`**

## ⚠️ RULE #3: SP Mapping
SP yang dipanggil untuk KODEMENU tertentu TIDAK SELALU sesuai dengan nama laporannya.

Contoh:
| KODEMENU | nama_laporan (DBMENUREPORT) | SP yang dipanggil (Delphi) |
|----------|---------------------------|---------------------------|
| `03030101` | Laporan KP Per No.Bukti | `Sp_reportSoDet` (bukan SP KP!) |
| `03030102` | Laporan KP Per Barang | `Sp_reportSoDet` |
| `03030103` | Laporan KP Per Customer | `Sp_reportSoDet` |
| `03030104` | Laporan HPP KP | `Sp_reportSoDet` |

**Catatan:** KODEMENU `03030101-03030104` di DBMENUREPORT disebut "KP" tapi SP-nya tetap `Sp_reportSoDet` (dari Delphi). Ini adalah inkonsistensi legacy yang TIDAK BOLEH diubah.

## ⚠️ RULE #4: Validasi
Sebelum mengubah seed file:
1. **Query DBMENUREPORT dulu** untuk nama yang benar
2. **Jangan asumsikan berdasarkan Delphi** - bisa berbeda!
3. **Cek sp_validator.go** untuk mapping SP yang valid

## ⚠️ RULE #5: Jangan Ubah seed_dynamic_reports.sql sembarangan
Seed file menggunakan format:
```sql
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03030101', 'Laporan KP Per No.Bukti', 1, '[]');
```

- `KODEMENU` → **dengan leading zero** (`'03030101'`)
- `nama_laporan` → **sama dengan DBMENUREPORT.keterangan**

## Referensi Penting

### 🔥 CRITICAL - JANGAN PERNAH:
- Asumsikan parameter laporan tanpa query database
- Menggunakan parameter dari laporan lain
- Membuat parameter sendiri tanpa validasi Delphi
- Delphi Source: `D:/TestLaB/Golang/Bca/ReportPreview/FrmReportPreview.pas`
- DBMENUREPORT: Query manual dari database
- sp_validator.go: `internal/features/reports/execution/sp_validator.go`
- Seed file: `seed_dynamic_reports.sql`

## ⚠️ RULE #6: Verifikasi Entry Baru
Jika entry TIDAK DITEMUKAN di DBMENUREPORT, gunakan Delphi sebagai referensi terakhir:
- Line 2011-2013: SO Per Nobukti, SO Per Barang, SO Per Supplier
- Line 1704: Kartu Piutang
- Line 4777: SP assignment untuk SO reports

TAPI ingat: UI akan menampilkan `DBMENUREPORT.keterangan`, bukan Delphi!

## ⚠️ RULE #7: PARAMETER LAPORAN (CRITICAL!)
**Parameter di dbparameterlaporan TIDAK BOLEH DIASUMSIKAN!**

### ❌ SALAH (Yang Saya Lakukan):
```sql
-- ASUMSI sendirian tanpa query database
UNION ALL
SELECT id_laporan, 4 AS posisi, 'KodePiutang' AS nama_filter, ...
WHERE KODEMENU IN ('03030101','03030102','03030103',...);
```

### ✅ BENAR (Workflow yang Seharusnya):
1. **Query DBMENUREPORT dulu** → dapat KODEMENU
2. **Query dbparameterlaporan legacy** → dapat parameter yang sebenarnya
   ```sql
   -- Dari database legacy
   SELECT p.id_laporan, m.KODEMENU, p.nama_filter, p.label, p.tipe_input
   FROM dbparameterlaporan p
   JOIN dbmasterlaporan m ON p.id_laporan = m.id_laporan
   WHERE m.KODEMENU = '03030101';
   ```
3. **Cross-check dengan Delphi** → pastikan nama filter sama
   - Delphi: `TglAwal13`, `TglAkhir13`, `Divisi`, `Perkiraan`, `Valas`
   - Database: `TglAwal`, `TglAkhir`, `Divisi`, `Perkiraan`, `Valas`
4. **Update seed file** berdasarkan data nyata, bukan asumsi

### Contoh Parameter yang BENAR (dari Delphi):
Untuk KODEMENU 03030101 (SO Per No.Bukti):
- `TglAwal` (date) - dari TglAwal13
- `TglAkhir` (date) - dari TglAkhir13
- `Divisi` (browse) - dari Divisi
- `Perkiraan` (browse) - dari Perkiraan
- `Valas` (combobox) - dari Valas

### ⚠️ PENTING:
- Setiap laporan bisa punya parameter yang SANGAT BERBEDA
- Jangan pernah asumsi berdasarkan laporan lain
- SELALU query database legacy atau Delphi source untuk parameter
- Simpan hasil query ke file referensi sebelum update seed

## ⚠️ RULE #8: SP EXECUTION PATTERN (CRITICAL!)
**Tanggal DIHARDCODE ke SQL string, bukan parameter!**

### Contoh Delphi (line 4777):
```pascal
sql.add('Exec Sp_reportSoDet :0,:1,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglawal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglakhir13.Date)))+',:2,:3');
```

### Hasil SQL:
```sql
Exec Sp_reportSoDet :0,:1,'2025-08-01','2025-08-31',:2,:3
```

### Mapping Parameter:
| Position | Value | Source |
|----------|-------|--------|
| :0 | 'T' | Hardcoded |
| :1 | 'N'/'B'/'C'/'D' | Group Type (Nobukti/Barang/Customer/HPP) |
| :2 | Tanggal Awal | Hardcoded string (MM-DD-YYYY) |
| :3 | Tanggal Akhir | Hardcoded string (MM-DD-YYYY) |
| :4 | List Items | ListBox (Perkiraan;Divisi;KodePiutang) |
| :5 | Index | CboOto (Valas) |

### ⚠️ PENTING:
- TglAwal/TglAkhir **BUKAN parameter**, tapi **hardcoded string**
- Format tanggal: **MM-DD-YYYY** (bukan YYYY-MM-DD!)
- ListBox items digabung dengan separator **";"**
- Rekap checkbox → pilih SP (Det vs Rek)

---

## 🔄 WORKFLOW STANDARD (WAJIB DIKIKUTI!)

### Sebelum membuat parameter untuk laporan ANY:

1. **QUERY DATABASE LEGACY**
   ```sql
   SELECT p.* FROM dbparameterlaporan p
   JOIN dbmasterlaporan m ON p.id_laporan = m.id_laporan
   WHERE m.KODEMENU = '[KODEMENU_YANG_DIMAKSUD]';
   ```

2. **CROSS-CHECK DELPHI SOURCE**
   - Buka `FrmReportPreview.pas`
   - Cari line dengan `KODEMENU` tersebut
   - Catat SP signature dan parameter mapping

3. **BUAT MAPPING**
   - UI Filters (dari DB) → SP Parameters (dari Delphi)
   - Identifikasi yang di-hardcode vs yang jadi parameter

4. **UPDATE SEED FILE**
   - Sesuaikan dengan SP signature (bukan UI filters!)
   - Tambahkan konfigurasi JSON untuk setiap parameter

5. **IMPLEMENTASI GO CODE**
   - Buat executor yang handle mapping
   - Format tanggal sesuai Delphi (MM-DD-YYYY)

---

## ⚠️ COMMON MISTAKES (JANGAN TERJADI LAGI!)

| Mistake | Why Wrong | Correct Approach |
|---------|-----------|------------------|
| Asumsi parameter | Tidak validasi dengan DB | Query dbparameterlaporan dulu |
| UI filters = SP params | Bisa beda jumlah! | Cross-check Delphi source |
| Format tanggal YYYY-MM-DD | SP butuh MM-DD-YYYY | Format sesuai Delphi |
| Semua laporan sama | Setiap laporan unik! | Cek satu per satu |
| Tidak ada konfigurasi | Go code tidak tahu mapping | Tambah JSON konfigurasi |


---

## 📌 RULE #6: SP NAME CASE-SENSITIVE!

### ❌ JANGAN:
```go
// Asal-asalan dari Delphi
sql := "Exec Sp_reportSoDet :0,:1,..."
```

### ✅ HARUS:
```go
// Cek di database dulu!
SELECT ROUTINE_NAME 
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_TYPE = 'PROCEDURE' 
AND ROUTINE_NAME LIKE '%SO%';

// Baru pakai nama yang benar
sql := "Exec Sp_ReportSODet :0,:1,..."
```

### Contoh Error:
```
mssql: Procedure or function 'Sp_ReportSODet' expects parameter '@SReport', which was not supplied.
```

### Solusi:
1. Query `sys.procedures` atau `INFORMATION_SCHEMA.ROUTINES`
2. Catat nama SP persis seperti di database
3. Gunakan nama tersebut di Go code

### Contoh Lengkap:

**Step 1: Cek nama SP di database**
```sql
SELECT ROUTINE_NAME 
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_TYPE = 'PROCEDURE' 
AND ROUTINE_NAME LIKE '%SO%';
-- Output: Sp_ReportSODet (bukan Sp_reportSoDet)
```

**Step 2: Cek parameter SP**
```sql
SELECT p.name AS parameter_name,
       t.name AS data_type,
       p.default_value
FROM sys.procedures sp
JOIN sys.parameters p ON sp.object_id = p.object_id
JOIN sys.types t ON p.user_type_id = t.user_type_id
WHERE sp.name = 'Sp_ReportSODet'
ORDER BY p.parameter_id;
```

**Step 3: Bandingkan dengan Delphi**
- Delphi: `Exec Sp_reportSoDet :0,:1,'date1','date2',:2,:3`
- Database: `Sp_ReportSODet @SReport, @GroupType, @TglAwal, @TglAkhir, @Items, @Valas`
- **Perbedaan**: Ada `@SReport` yang tidak dikirim Delphi!

**Step 4: Update Go code**
```go
// Tambahkan parameter yang hilang
result.Params = []interface{}{
    "T",                  // :0
    groupType,           // :1
    tglAwalStr,          // hardcoded
    tglAkhirStr,         // hardcoded
    listStr,             // :2
    config.ValasIndex,   // :3
    "default_value",     // :4 = @SReport (baru!)
}
```

---

## 📌 RULE #7: CEK PARAMETER SP DI DATABASE!

### ❌ JANGAN:
- Mengasumsikan parameter SP hanya dari Delphi source
- Menganggap Delphi selalu lengkap

### ✅ HARUS:
1. Query `sys.parameters` untuk lihat semua parameter SP
2. Bandingkan dengan Delphi execution
3. Tambahkan parameter yang hilang di Go code

### Contoh:
```sql
-- Cek parameter SP
SELECT p.name, t.name, p.default_value
FROM sys.procedures sp
JOIN sys.parameters p ON sp.object_id = p.object_id
JOIN sys.types t ON p.user_type_id = t.user_type_id
WHERE sp.name = 'Sp_ReportSODet';
```

### Output yang diharapkan:
```
name        | type       | default_value
------------|------------|--------------
@SReport    | varchar    | NULL
@GroupType  | char       | NULL
@TglAwal    | date       | NULL
@TglAkhir   | date       | NULL
@Items      | varchar    | NULL
@ValasIndex | int        | NULL
```

### Jika ada parameter baru:
- Tambahkan ke `SPExecutionConfig`
- Tambahkan ke `result.Params`
- Update comment di fungsi
