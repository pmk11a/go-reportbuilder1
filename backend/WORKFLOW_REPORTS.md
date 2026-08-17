# 📋 Workflow Laporan - Panduan Lengkap

## ⚠️ RULES PENTING (HARUS DIBACA DULU!)

### RULE #1: JANGAN ASUMSI PARAMETER!
- **SELALU** query database legacy (`dbparameterlaporan`) untuk dapat parameter
- **SELALU** cross-check dengan Delphi source (`FrmReportPreview.pas`)
- **JANGAN** buat parameter berdasarkan asumsi sendiri

### RULE #2: SP Signature vs UI Filters
- **UI Filters** (di `dbparameterlaporan`) = yang dilihat user
- **SP Parameters** (di Delphi) = yang dikirim ke stored procedure
- **MEREKA BISA BERBEDA!**

### RULE #3: Tanggal DIHARDCODE ke SQL
- Di Delphi, tanggal DI-HARDCODE ke SQL string, bukan parameter
- Format: `MM-DD-YYYY` (bukan `YYYY-MM-DD`!)
- Contoh: `Exec Sp_reportSoDet :0,:1,'08-01-2025','08-31-2025',:2,:3`

---

## 🔍 STEP 1: Ambil Parameter dari Database Legacy

```sql
-- Query untuk dapatkan parameter asli dari database
SELECT 
    p.id_parameter,
    p.id_laporan,
    m.KODEMENU,
    p.nama_filter,
    p.label,
    p.tipe_input,
    p.wajib_isi,
    p.nilai_default,
    p.konfigurasi
FROM dbparameterlaporan p
JOIN dbmasterlaporan m ON p.id_laporan = m.id_laporan
WHERE m.KODEMENU = '03030101';  -- Ganti dengan KODEMENU yang dituju
```

### Contoh Output (dari database user):
```
id_parameter | nama_filter   | label        | tipe_input | wajib_isi
-------------|---------------|--------------|------------|----------
1051         | TglAwal       | Tanggal Awal | date       | 1
1052         | TglAkhir      | Tanggal Akhir| date       | 1
1053         | Divisi        | Divisi       | browse     | 0
1054         | KodePiutang   | Kode Piutang | browse     | 0
1055         | Perkiraan     | Perkiraan    | browse     | 0
1056         | Valas         | Mata Uang    | combobox   | 0
1057         | Rekap         | Rekap        | checkbox   | 0
```

---

## 🔍 STEP 2: Cross-Check dengan Delphi Source

Buka file: `D:\TestLaB\Golang\Bca\ReportPreview\FrmReportPreview.pas`

### Cari SP Execution:
```pascal
// Line 4777 untuk KODEMENU 3030101-3030104
3030101,3030102,3030103,3030104 :sql.add('Exec  Sp_reportSoDet :0,:1,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglawal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglakhir13.Date)))+',:2,:3');
```

### Analisis:
- **SP Signature**: `Exec Sp_reportSoDet :0,:1,'TglAwal','TglAkhir',:2,:3`
- **Total args**: 6
- **Parameters**: 4 (:0, :1, :2, :3)
- **Hardcoded**: 2 (TglAwal, TglAkhir)

### Mapping Parameter:
```
:0 → Parameters[0] = 'T' (hardcoded)
:1 → Parameters[1] = Group Type ('N'/'B'/'C'/'D')
:2 → Tglawal13.Date (hardcoded string, format MM-DD-YYYY)
:3 → Tglakhir13.Date (hardcoded string, format MM-DD-YYYY)
:4 → Parameters[2] = XParameter (ListBox items)
:5 → Parameters[3] = CboOto.ItemIndex
```

---

## 🔍 STEP 3: Bandingkan UI Filters vs SP Parameters

| UI Filter (Database) | SP Parameter | Status |
|---------------------|--------------|--------|
| TglAwal | Hardcoded (:2) | ✅ |
| TglAkhir | Hardcoded (:3) | ✅ |
| Divisi | Parameters[2] (ListBox) | ✅ |
| KodePiutang | Parameters[2] (ListBox) | ✅ |
| Perkiraan | Parameters[2] (ListBox) | ✅ |
| Valas | Parameters[3] (CboOto) | ✅ |
| Rekap | Switch SP (Det/Rek) | ✅ |

### Kesimpulan:
- **7 UI filters** → di-map ke **4 SP parameters**
- Tanggal di-hardcode ke SQL string
- Divisi + KodePiutang + Perkiraan → digabung jadi 1 ListBox parameter

---

## 🔧 STEP 4: Update Seed File

### Buat ParamDefaults dengan 4 parameters (sesuai SP):

```sql
ParamDefaults AS (
    SELECT id_laporan, 1 AS posisi, 'TglAwal' AS nama_filter, 'Tanggal Awal' AS label, 'date' AS tipe_input, 1 AS wajib_isi, CONVERT(NVARCHAR, GETDATE(), 121) AS created_at, '{"format": "MM-DD-YYYY", "hardcoded": true}' AS konfigurasi
    FROM ReportIds
    UNION ALL
    SELECT id_laporan, 2 AS posisi, 'TglAkhir' AS nama_filter, 'Tanggal Akhir' AS label, 'date' AS tipe_input, 1 AS wajib_isi, CONVERT(NVARCHAR, GETDATE(), 121) AS created_at, '{"format": "MM-DD-YYYY", "hardcoded": true}' AS konfigurasi
    FROM ReportIds
    UNION ALL
    SELECT id_laporan, 3 AS posisi, 'ListItems' AS nama_filter, 'Filter Items' AS label, 'browse' AS tipe_input, 0 AS wajib_isi, CONVERT(NVARCHAR, GETDATE(), 121) AS created_at, '{"type": "listbox", "allowMultiple": true}' AS konfigurasi
    FROM ReportIds
    WHERE KODEMENU IN ('03030101','03030102','03030103','030301031','03030104')
    UNION ALL
    SELECT id_laporan, 4 AS posisi, 'Valas' AS nama_filter, 'Mata Uang' AS label, 'combobox' AS tipe_input, 0 AS wajib_isi, CONVERT(NVARCHAR, GETDATE(), 121) AS created_at, '{"type": "combobox", "paramIndex": 3}' AS konfigurasi
    FROM ReportIds
    WHERE KODEMENU IN ('03030101','03030102','03030103','030301031','03030104')
)
```

### Insert dengan konfigurasi:
```sql
INSERT INTO dbparameterlaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, posisi, konfigurasi, created_at)
SELECT id_laporan, nama_filter, label, tipe_input, wajib_isi, 
       CASE WHEN nama_filter = 'TglAwal' THEN CONVERT(NVARCHAR, DATEADD(day, -7, GETDATE()), 121)
            WHEN nama_filter = 'TglAkhir' THEN CONVERT(NVARCHAR, GETDATE(), 121)
            ELSE NULL END,  -- ListItems dan Valas tidak ada default
       posisi, konfigurasi, created_at
FROM ParamDefaults
ORDER BY id_laporan, posisi;
```

---

## 🔧 STEP 5: Implementasi Go Code

### sp_executor.go:
```go
package execution

import (
    "fmt"
    "strings"
    "time"
)

type SPExecutionConfig struct {
    KodeMenu   string
    TglAwal    time.Time
    TglAkhir   time.Time
    ListItems  []string  // Gabungan Perkiraan+Divisi+KodePiutang
    ValasIndex int
    IsRekap    bool
}

func ExecuteSPReport(config SPExecutionConfig) *SPExecutionResult {
    // 1. Format tanggal ke MM-DD-YYYY
    dateFmt := "01-02-2006"
    tglAwalStr := config.TglAwal.Format(dateFmt)
    tglAkhirStr := config.TglAkhir.Format(dateFmt)
    
    // 2. Group type berdasarkan KODEMENU
    groupType := getGroupType(config.KodeMenu)
    
    // 3. Gabung list items
    listStr := strings.Join(config.ListItems, ";")
    
    // 4. Tentukan SP (Detail vs Rekap)
    if config.IsRekap {
        sql = fmt.Sprintf("Exec Sp_reportSORek :0,:1,'%s','%s',:2", tglAwalStr, tglAkhirStr)
        params = []interface{}{"T", groupType, listStr}
    } else {
        sql = fmt.Sprintf("Exec Sp_reportSoDet :0,:1,'%s','%s',:2,:3", tglAwalStr, tglAkhirStr)
        params = []interface{}{"T", groupType, listStr, config.ValasIndex}
    }
    
    return result
}
```

---

## 📝 CHECKLIST SEBELUM MULAI

- [ ] Saya sudah query `dbparameterlaporan` dari database legacy
- [ ] Saya sudah cross-check dengan Delphi source (`FrmReportPreview.pas`)
- [ ] Saya paham perbedaan UI filters vs SP parameters
- [ ] Saya tahu tanggal di-hardcode ke SQL (bukan parameter)
- [ ] Saya tahu format tanggal: `MM-DD-YYYY` (bukan `YYYY-MM-DD`)
- [ ] Saya sudah buat mapping dari UI filters ke SP parameters

---

## 🚫 JANGAN PERNAH LAKUKAN INI!

❌ Membuat parameter berdasarkan asumsi tanpa query database
❌ Menganggap UI filters == SP parameters
❌ Menggunakan format tanggal `YYYY-MM-DD` untuk SP
❌ Tidak cross-check dengan Delphi source
❌ Menganggap semua laporan punya parameter yang sama

---

## 📚 REFERENSI

- Delphi Source: `D:\TestLaB\Golang\Bca\ReportPreview\FrmReportPreview.pas`
- Database Legacy: Query `dbparameterlaporan` dan `dbmasterlaporan`
- Seed File: `seed_dynamic_reports.sql`
- Rules: `RULES_KODEMENU.md`
