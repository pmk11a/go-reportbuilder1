-- ============================================================
-- SEED: 9 Complex Reports - dbMasterLaporan & DBMENUREPORT
-- ============================================================
USE dbbcagroup;
GO

-- Step 1: Insert KODEMENU yang belum ada di DBMENUREPORT
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '0303301')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('0303301', 'Invoice Penjualan Detail', 3, '0303301');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '0303302')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('0303302', 'Invoice Penjualan Rekening', 3, '0303302');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '025801')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('025801', 'Transfer In Detail', 3, '025801');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '0303303')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('0303303', 'Rekap Invoice Penjualan', 3, '0303303');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '0303304')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('0303304', 'Penjualan Gudang Rekening', 3, '0303304');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '025902')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('025902', 'Pembelian ACC Rekening', 3, '025902');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '025802')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('025802', 'Transfer Out Detail', 3, '025802');

PRINT '7 KODEMENU baru di DBMENUREPORT (inserted if missing)';
GO

-- Step 2: Insert 9 laporan ke dbMasterLaporan (id 25-35) using IDENTITY_INSERT
SET IDENTITY_INSERT dbMasterLaporan ON;
GO

IF NOT EXISTS (SELECT 1 FROM dbMasterLaporan WHERE id_laporan = 25)
    INSERT INTO dbMasterLaporan (id_laporan, KODEMENU, nama_laporan, deskripsi, query_sumber_data, status_aktif, footer_bands)
    VALUES (25, '020507', 'Laporan Mutasi Keuangan', 'Mutasi Keuangan',
        'EXEC Sp_ReportInvoicePenjualanDet @SReport=''T'', @Ordr=''S'', @tgl1=''2024-01-01'', @tgl2=''2024-12-31'', @isiList='''', @NeedOto=''0'', @isKP=''0'', @PPN=1, @Id=''%''',
        1,
        '{"bands":{"title":{"enabled":true,"content":"LAPORAN MUTASI KEUANGAN","align":"center"},"summary":{"enabled":true,"signatures":[{"label":"Kasir","position":"left"},{"label":"Admin","position":"center"},{"label":"Manager","position":"right"}]}}}');

IF NOT EXISTS (SELECT 1 FROM dbMasterLaporan WHERE id_laporan = 26)
    INSERT INTO dbMasterLaporan (id_laporan, KODEMENU, nama_laporan, deskripsi, query_sumber_data, status_aktif, footer_bands)
    VALUES (26, '020406', 'Kartu Piutang Detail', 'Piutang Detail',
        'EXEC sp_ReportPiutangSrtJln @Bulan=12, @Tahun=2024, @Id=''%''',
        1,
        '{"bands":{"title":{"enabled":true,"content":"KARTU PIUTANG DETAIL","align":"center"},"summary":{"enabled":true,"signatures":[{"label":"Collector","position":"left"},{"label":"Finance","position":"right"}]}}}');

IF NOT EXISTS (SELECT 1 FROM dbMasterLaporan WHERE id_laporan = 27)
    INSERT INTO dbMasterLaporan (id_laporan, KODEMENU, nama_laporan, deskripsi, query_sumber_data, status_aktif, footer_bands)
    VALUES (27, '0303301', 'Invoice Penjualan Detail', 'Invoice Penjualan Detail (Score 1217.82)',
        'EXEC Sp_ReportInvoicePenjualanDet @SReport=''T'', @Ordr=''S'', @tgl1=''2024-01-01'', @tgl2=''2024-12-31'', @isiList='''', @NeedOto=''0'', @isKP=''0'', @PPN=1, @Id=''%''',
        1,
        '{"bands":{"title":{"enabled":true,"content":"LAPORAN INVOICE PENJUALAN DETAIL","align":"center"},"pageHeader":{"enabled":true,"content":"Periode: @tgl1 s/d @tgl2"},"summary":{"enabled":true,"layout":{"columns":3,"alignment":"spread"},"signatures":[{"label":"Kontrol","position":"left"},{"label":"Sales","position":"center"},{"label":"Pimpinan","position":"right"}]}}}');

IF NOT EXISTS (SELECT 1 FROM dbMasterLaporan WHERE id_laporan = 28)
    INSERT INTO dbMasterLaporan (id_laporan, KODEMENU, nama_laporan, deskripsi, query_sumber_data, status_aktif, footer_bands)
    VALUES (28, '0303302', 'Invoice Penjualan Rekening', 'Invoice Penjualan Rekening (Score 945.77)',
        'EXEC Sp_ReportInvoicePenjualanRek @Choice=''B'', @Tgl1=''2024-01-01'', @Tgl2=''2024-12-31'', @NeedOto=0, @PPN=1, @Id=''%''',
        1,
        '{"bands":{"title":{"enabled":true,"content":"INVOICE PENJUALAN REKAP","align":"center"},"summary":{"enabled":true,"signatures":[{"label":"Accounting","position":"left"},{"label":"Finance Manager","position":"right"}]}}}');

IF NOT EXISTS (SELECT 1 FROM dbMasterLaporan WHERE id_laporan = 29)
    INSERT INTO dbMasterLaporan (id_laporan, KODEMENU, nama_laporan, deskripsi, query_sumber_data, status_aktif, footer_bands)
    VALUES (29, '025801', 'Transfer In Detail', 'Transfer Masuk (Score 773.45)',
        'EXEC sp_TFTransIn @Nobukti=''%'', @Do=''I'', @Urut=1',
        1,
        '{"bands":{"title":{"enabled":true,"content":"LAPORAN TRANSFER IN","align":"center"},"summary":{"enabled":true,"signatures":[{"label":"Teller","position":"left"},{"label":"Pincab","position":"right"}]}}}');

IF NOT EXISTS (SELECT 1 FROM dbMasterLaporan WHERE id_laporan = 30)
    INSERT INTO dbMasterLaporan (id_laporan, KODEMENU, nama_laporan, deskripsi, query_sumber_data, status_aktif, footer_bands)
    VALUES (30, '0303303', 'Rekap Invoice Penjualan', 'Recurring Invoice (Score 688.94)',
        'EXEC Sp_ReportRInvoicePenjualanRek @Choice=''B'', @Tgl1=''2024-01-01'', @Tgl2=''2024-12-31'', @Needoto=0, @Id=''%''',
        1,
        '{"bands":{"title":{"enabled":true,"content":"REKAP INVOICE PENJUALAN","align":"center"},"summary":{"enabled":true,"signatures":[{"label":"Kontrol","position":"left"},{"label":"Manager","position":"center"},{"label":"Pimpinan","position":"right"}]}}}');

IF NOT EXISTS (SELECT 1 FROM dbMasterLaporan WHERE id_laporan = 31)
    INSERT INTO dbMasterLaporan (id_laporan, KODEMENU, nama_laporan, deskripsi, query_sumber_data, status_aktif, footer_bands)
    VALUES (31, '0303304', 'Penjualan Gudang Rekening', 'Penjualan Gudang Rek (Score 685.15)',
        'EXEC Sp_ReportRPenjualanGdgRek @Choice=''B'', @Tgl1=''2024-01-01'', @Tgl2=''2024-12-31'', @Needoto=0, @Id=''%''',
        1,
        '{"bands":{"title":{"enabled":true,"content":"PENJUALAN GUDANG REKAP","align":"center"},"summary":{"enabled":true,"signatures":[{"label":"Gudang","position":"left"},{"label":"Penjualan","position":"center"},{"label":"Pimpinan","position":"right"}]}}}');

IF NOT EXISTS (SELECT 1 FROM dbMasterLaporan WHERE id_laporan = 32)
    INSERT INTO dbMasterLaporan (id_laporan, KODEMENU, nama_laporan, deskripsi, query_sumber_data, status_aktif, footer_bands)
    VALUES (32, '025902', 'Pembelian ACC Rekening', 'Pembelian ACC (Score 638.50)',
        'EXEC Sp_ReportBeliACCRek @Choice=''B'', @Tgl1=''2024-01-01'', @Tgl2=''2024-12-31'', @NeedOto=0, @TipeBayar=0, @Id=''%''',
        1,
        '{"bands":{"title":{"enabled":true,"content":"LAPORAN PEMBELIAN ACC","align":"center"},"summary":{"enabled":true,"signatures":[{"label":"Pembelian","position":"left"},{"label":"Finance","position":"right"}]}}}');

IF NOT EXISTS (SELECT 1 FROM dbMasterLaporan WHERE id_laporan = 33)
    INSERT INTO dbMasterLaporan (id_laporan, KODEMENU, nama_laporan, deskripsi, query_sumber_data, status_aktif, footer_bands)
    VALUES (33, '025802', 'Transfer Out Detail', 'Transfer Keluar (Score 493.18)',
        'EXEC sp_TFTransOut @Nobukti=''%'', @Do=''O'', @Urut=1',
        1,
        '{"bands":{"title":{"enabled":true,"content":"LAPORAN TRANSFER OUT","align":"center"},"summary":{"enabled":true,"signatures":[{"label":"Teller","position":"left"},{"label":"Pincab","position":"right"}]}}}');

IF NOT EXISTS (SELECT 1 FROM dbMasterLaporan WHERE id_laporan = 34)
    INSERT INTO dbMasterLaporan (id_laporan, KODEMENU, nama_laporan, deskripsi, query_sumber_data, status_aktif, footer_bands)
    VALUES (34, '050102', 'Stock Quantity Rupiah', 'Stock Qty Rp (Score 479.10)',
        'EXEC Sp_reportStockQtyRp @Bulan=12, @Tahun=2024, @isi=2, @Kodegdg=''%'', @KodeGrp=''%'', @minus=0, @MinusHpp=0, @Qty1=1, @Qty2=1, @Pilih=1, @KodeSubGrp=''%''',
        1,
        '{"bands":{"title":{"enabled":true,"content":"LAPORAN STOCK QUANTITY & RUPIAH","align":"center"},"summary":{"enabled":true,"signatures":[{"label":"Gudang","position":"left"},{"label":"PPIC","position":"center"},{"label":"Pimpinan","position":"right"}]}}}');

IF NOT EXISTS (SELECT 1 FROM dbMasterLaporan WHERE id_laporan = 35)
    INSERT INTO dbMasterLaporan (id_laporan, KODEMENU, nama_laporan, deskripsi, query_sumber_data, status_aktif, footer_bands)
    VALUES (35, '050103', 'Stock Quantity Rekonsiliasi', 'Stock Rekonsiliasi (Score 474.81)',
        'EXEC sp_reportStockQtyRprek @Bulan=12, @Tahun=2024, @isi=2, @Kodegdg=''%'', @KodeGrp=''%'', @minus=0, @MinusHPP=0, @Qty1=1, @Qty2=1, @Pilih=1, @KodeSubGrp=''%''',
        1,
        '{"bands":{"title":{"enabled":true,"content":"STOCK QUANTITY REKONSILIASI","align":"center"},"summary":{"enabled":true,"signatures":[{"label":"Accounting","position":"left"},{"label":"Gudang","position":"center"},{"label":"Pimpinan","position":"right"}]}}}');

SET IDENTITY_INSERT dbMasterLaporan OFF;
GO

PRINT '9 laporan baru inserted ke dbMasterLaporan (id 25-35)';
GO

-- Verify
SELECT id_laporan, KODEMENU, nama_laporan FROM dbMasterLaporan
WHERE id_laporan BETWEEN 25 AND 35 ORDER BY id_laporan;
GO