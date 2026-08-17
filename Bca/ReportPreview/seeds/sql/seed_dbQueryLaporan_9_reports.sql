-- ============================================================
-- SEED: dbQueryLaporan untuk 9 New Complex Reports (id 25-35)
-- ============================================================
USE dbbcagroup;
GO

INSERT INTO dbQueryLaporan
    (id_laporan, nama_dataset, query_sumber_data, deskripsi, urutan, config_json, visible)
VALUES
(25, 'QuView', 'EXEC Sp_ReportInvoicePenjualanDet @SReport=@SReport, @Ordr=@Ordr, @tgl1=@tgl1, @tgl2=@tgl2, @isiList=@isiList, @NeedOto=@NeedOto, @isKP=@isKP, @PPN=@PPN, @Id=@Id', 'Invoice Penjualan Detail - Master Data', 1, '{"display_role":"detail"}', 1),

(26, 'QuView', 'EXEC sp_ReportPiutangSrtJln @Bulan=@Bulan, @Tahun=@Tahun, @Id=@Id, @Tanggal=@Tanggal, @SmpTgl=@SmpTgl, @SmpBln=@SmpBln, @SmpThn=@SmpThn', 'Piutang Surat Jalan - Master Data', 1, '{"display_role":"detail"}', 1),

(27, 'QuView', 'EXEC Sp_ReportInvoicePenjualanDet @SReport=@SReport, @Ordr=@Ordr, @tgl1=@tgl1, @tgl2=@tgl2, @isiList=@isiList, @NeedOto=@NeedOto, @isKP=@isKP, @PPN=@PPN, @Id=@Id', 'Invoice Penjualan Detail (v2) - Master Data', 1, '{"display_role":"detail"}', 1),

(28, 'QuView', 'EXEC Sp_ReportInvoicePenjualanRek @Choice=@Choice, @Tgl1=@Tgl1, @Tgl2=@Tgl2, @NeedOto=@NeedOto, @PPN=@PPN, @Id=@Id', 'Invoice Penjualan Rekening - Master Data', 1, '{"display_role":"detail"}', 1),

(29, 'QuView', 'EXEC sp_TFTransIn @Nobukti=@Nobukti, @Do=@Do, @Urut=@Urut', 'Transfer Masuk - Master Data', 1, '{"display_role":"detail"}', 1),

(30, 'QuView', 'EXEC Sp_ReportRInvoicePenjualanRek @Choice=@Choice, @Tgl1=@Tgl1, @Tgl2=@Tgl2, @Needoto=@Needoto, @Id=@Id', 'Rekap Invoice Penjualan - Master Data', 1, '{"display_role":"detail"}', 1),

(31, 'QuView', 'EXEC Sp_ReportRPenjualanGdgRek @Choice=@Choice, @Tgl1=@Tgl1, @Tgl2=@Tgl2, @Needoto=@Needoto, @Id=@Id', 'Penjualan Gudang Rekening - Master Data', 1, '{"display_role":"detail"}', 1),

(32, 'QuView', 'EXEC Sp_ReportBeliACCRek @Choice=@Choice, @Tgl1=@Tgl1, @Tgl2=@Tgl2, @NeedOto=@NeedOto, @TipeBayar=@TipeBayar, @Id=@Id', 'Pembelian ACC Rekening - Master Data', 1, '{"display_role":"detail"}', 1),

(33, 'QuView', 'EXEC sp_TFTransOut @Nobukti=@Nobukti, @Do=@Do, @Urut=@Urut', 'Transfer Keluar - Master Data', 1, '{"display_role":"detail"}', 1),

(34, 'QuView', 'EXEC Sp_reportStockQtyRp @Bulan=@Bulan, @Tahun=@Tahun, @isi=@isi, @Kodegdg=@Kodegdg, @KodeGrp=@KodeGrp, @minus=@minus, @MinusHpp=@MinusHpp, @Qty1=@Qty1, @Qty2=@Qty2, @Pilih=@Pilih, @KodeSubGrp=@KodeSubGrp', 'Stock Quantity Rupiah - Master Data', 1, '{"display_role":"detail"}', 1),

(35, 'QuView', 'EXEC sp_reportStockQtyRprek @Bulan=@Bulan, @Tahun=@Tahun, @isi=@isi, @Kodegdg=@Kodegdg, @KodeGrp=@KodeGrp, @minus=@minus, @MinusHPP=@MinusHPP, @Qty1=@Qty1, @Qty2=@Qty2, @Pilih=@Pilih, @KodeSubGrp=@KodeSubGrp', 'Stock Rekonsiliasi - Master Data', 1, '{"display_role":"detail"}', 1);

PRINT 'Query seed complete (11 rows)';
GO

SELECT id_laporan, nama_dataset, LEFT(query_sumber_data, 60) as query_preview FROM dbQueryLaporan
WHERE id_laporan BETWEEN 25 AND 35 ORDER BY id_laporan;
GO
