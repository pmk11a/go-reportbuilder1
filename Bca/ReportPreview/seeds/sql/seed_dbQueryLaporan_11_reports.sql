-- ============================================================
-- SEED: dbQueryLaporan untuk 11 High Complexity Reports
-- ============================================================
USE dbbcagroup;
GO

INSERT INTO dbQueryLaporan
    (id_laporan, nama_dataset, query_sumber_data, deskripsi, urutan, config_json, visible)
VALUES
(100, 'QuView', 'EXEC Sp_ReportInvoicePenjualanDet @SReport=@SReport, @Ordr=@Ordr, @tgl1=@tgl1, @tgl2=@tgl2, @isiList=@isiList, @NeedOto=@NeedOto, @isKP=@isKP, @PPN=@PPN, @Id=@Id', 'Invoice Penjualan Detail - Master Data', 1, '{"display_role":"detail"}', 1),

(101, 'QuView', 'EXEC Sp_ReportInvoicePenjualanRek @Choice=@Choice, @Tgl1=@Tgl1, @Tgl2=@Tgl2, @NeedOto=@NeedOto, @PPN=@PPN, @Id=@Id', 'Invoice Penjualan Rekening - Master Data', 1, '{"display_role":"detail"}', 1),

(102, 'QuView', 'EXEC sp_TFTransIn @Nobukti=@Nobukti, @Do=@Do, @Urut=@Urut', 'Transfer Masuk - Master Data', 1, '{"display_role":"detail"}', 1),

(103, 'QuView', 'EXEC Sp_reportBPrek @Choice=@Choice, @Tgl1=@Tgl1, @Tgl2=@Tgl2, @NeedOto=@NeedOto, @Id=@Id', 'Buku Besar Rekening - Master Data', 1, '{"display_role":"detail"}', 1),

(104, 'QuView', 'EXEC Sp_ReportRInvoicePenjualanRek @Choice=@Choice, @Tgl1=@Tgl1, @Tgl2=@Tgl2, @Needoto=@Needoto, @Id=@Id', 'Rekap Invoice Penjualan - Master Data', 1, '{"display_role":"detail"}', 1),

(105, 'QuView', 'EXEC Sp_ReportRPenjualanGdgRek @Choice=@Choice, @Tgl1=@Tgl1, @Tgl2=@Tgl2, @Needoto=@Needoto, @Id=@Id', 'Penjualan Gudang Rekening - Master Data', 1, '{"display_role":"detail"}', 1),

(106, 'QuView', 'EXEC Sp_ReportBeliACCRek @Choice=@Choice, @Tgl1=@Tgl1, @Tgl2=@Tgl2, @NeedOto=@NeedOto, @TipeBayar=@TipeBayar, @Id=@Id', 'Pembelian ACC Rekening - Master Data', 1, '{"display_role":"detail"}', 1),

(107, 'QuView', 'EXEC sp_ReportPiutangSrtJln @Bulan=@Bulan, @Tahun=@Tahun, @Id=@Id, @Tanggal=@Tanggal, @SmpTgl=@SmpTgl, @SmpBln=@SmpBln, @SmpThn=@SmpThn', 'Piutang Surat Jalan - Master Data', 1, '{"display_role":"detail"}', 1),

(108, 'QuView', 'EXEC sp_TFTransOut @Nobukti=@Nobukti, @Do=@Do, @Urut=@Urut', 'Transfer Keluar - Master Data', 1, '{"display_role":"detail"}', 1),

(109, 'QuView', 'EXEC Sp_reportStockQtyRp @Bulan=@Bulan, @Tahun=@Tahun, @isi=@isi, @Kodegdg=@Kodegdg, @KodeGrp=@KodeGrp, @minus=@minus, @MinusHpp=@MinusHpp, @Qty1=@Qty1, @Qty2=@Qty2, @Pilih=@Pilih, @KodeSubGrp=@KodeSubGrp', 'Stock Quantity Rupiah - Master Data', 1, '{"display_role":"detail"}', 1),

(110, 'QuView', 'EXEC sp_reportStockQtyRprek @Bulan=@Bulan, @Tahun=@Tahun, @isi=@isi, @Kodegdg=@Kodegdg, @KodeGrp=@KodeGrp, @minus=@minus, @MinusHPP=@MinusHPP, @Qty1=@Qty1, @Qty2=@Qty2, @Pilih=@Pilih, @KodeSubGrp=@KodeSubGrp', 'Stock Rekonsiliasi - Master Data', 1, '{"display_role":"detail"}', 1);

PRINT 'Query seed complete (11 rows)';
GO

SELECT id_laporan, nama_dataset, LEFT(query_sumber_data, 60) as query_preview FROM dbQueryLaporan
WHERE id_laporan BETWEEN 100 AND 110 ORDER BY id_laporan;
GO