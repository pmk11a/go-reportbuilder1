# Mapping KODEMENU → SP (dari FrmReportPreview.pas)

**Source:** `D:/TestLaB/Golang/Bca/ReportPreview/FrmReportPreview.pas`

## Cara Pakai
Sebelum assign SP di seed, HARUS cek file ini dulu!

## Mapping Lengkap

| KODEMENU | Line | ShowReportPreview | SP (sql.add) | Keterangan |
|---|---|---|---|---|
| 3030101 | 2011 | SO Per Nobukti | `Sp_reportSoDet` | Sales Order per No. Bukti |
| 3030102 | 2012 | SO Per Barang | `Sp_reportSoDet` | Sales Order per Barang |
| 3030103 | 2013 | SO Per Supplier | `Sp_reportSoDet` | Sales Order per Customer |
| 3030104 | 2041 | HPP SO | `Sp_reportSoDet` | HPP Sales Order |
| 20401 | 1704 | Kartu Piutang | `Sp_ReportKartuPiutang` | KP - different KodeMenu! |
| 20402 | 1705 | Sisa Piutang | `Sp_ReportKartuPiutang` | Sisa Piutang |
| 20403 | 1706 | Pelunasan Piutang | `Sp_ReportKartuPiutang` | Pelunasan Piutang |
| 20404 | 1707 | Saldo Piutang | `Sp_ReportKartuPiutang` | Saldo Piutang |
| 20405 | 1708 | Umur Piutang | `Sp_ReportKartuPiutang` | Aging Piutang |
| 20406 | 1709 | Rincian Piutang | `Sp_ReportKartuPiutang` | Detail Piutang |

## Referensi Kode Delphi

```pascal
// Line 2011-2013: ShowReportPreview
3030101 : ShowReportPreview('SO Per Nobukti',11);
3030102 : ShowReportPreview('SO Per Barang',11);
3030103 : ShowReportPreview('SO Per Supplier',11);
3030104 : ShowReportPreview('HPP SO ',11);

// Line 4777: SP Assignment
3030101,3030102,3030103,3030104 : sql.add('Exec Sp_reportSoDet :0,:1,:2,:3,:4,:5');

// Line 3658: KP Assignment (KODEMENU 20401)
if KodeReport=20401 Then
  SQL.Add('exec Sp_ReportKartuPiutang :0,:1,:2,:3,:4,:5,:6,:7,:8');
```

## Important Notes

1. **KP ada di KODEMENU 20401**, bukan 3030101!
2. 3030101-3030104 adalah **SO (Sales Order)**, bukan KP
3. Selalu cross-check dengan Delphi sebelum assign SP
