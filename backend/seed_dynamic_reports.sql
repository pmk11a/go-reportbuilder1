-- ============================================================
-- Seed: DBMENUREPORT + dbmasterlaporan + dbquerylaporan
-- Purpose: Seed dynamic report entries for KODEMENU 0302xx-03038xx
-- Date: 2026-07-30
-- Idempotent: Yes (uses DELETE + INSERT pattern)
-- ============================================================

-- ============================================================
-- DBMASTERLAPORAN SEED
-- ============================================================

-- Delete existing entries for these KODEMENU first (idempotent)
DELETE FROM dbmasterlaporan WHERE KODEMENU IN (
    '030201','030202','030203','030204', -- Penawaran
    '03030','0303010','03030101','03030102','03030103','030301031','03030104', -- SO
    '0303020','03030201','03030202','03030203', -- Pembelian
    '03031','0303110','03031101','03031102','03031103', -- Penjualan per Barang
    '0303120','03031201','03031202','03031203', -- Penjualan per Customer
    '0303130','030313001','030313002','030313003', -- Penjualan per Marketing
    '030314', -- CashBack
    '03032','0303210','03032101','03032102','03032103', -- Stok Opname
    '0303220','03032201','03032202','03032203','03032204','03032205','03032206','03032207', -- Mutasi
    '03032301','03032302','03032303','03032304', -- Stok variants
    '0303240','0303241', -- Barang variants
    '0303251','0303252','0303253', -- Retur variants
    '03032601','03032602','03032603', -- Retur Surat Jalan
    '03033','0303301','0303302','0303303','0303304', -- Keuangan
    '0303310','03033101','03033102','03033103', -- Buku Besar
    '0303320','03033201','03033202','03033203','0303321','0303322','0303323', -- Neraca Saldo
    '03034','0303410','0303420','0303430', -- Pajak
    '0303501','0303502','030351','030352', -- Laporan Khusus
    '030361','030362', -- Komisi
    '0303701','0303702','0303703', -- Produksi
    '0303801','0303802','0303803' -- Persediaan
);

-- Delete related query data (CASCADE by KODEMENU)
DELETE FROM dbquerylaporan 
WHERE id_laporan IN (
    SELECT id_laporan FROM dbmasterlaporan 
    WHERE KODEMENU IN (
        '030201','030202','030203','030204', '03030','0303010','03030101','03030102','03030103','030301031','03030104',
        '0303020','03030201','03030202','03030203', '03031','0303110','03031101','03031102','03031103',
        '0303120','03031201','03031202','03031203', '0303130','030313001','030313002','030313003',
        '030314', '03032','0303210','03032101','03032102','03032103',
        '0303220','03032201','03032202','03032203','03032204','03032205','03032206','03032207',
        '03032301','03032302','03032303','03032304', '0303240','0303241',
        '0303251','0303252','0303253', '03032601','03032602','03032603',
        '03033','0303301','0303302','0303303','0303304', '0303310','03033101','03033102','03033103',
        '0303320','03033201','03033202','03033203','0303321','0303322','0303323',
        '03034','0303410','0303420','0303430', '0303501','0303502','030351','030352',
        '030361','030362', '0303701','0303702','0303703', '0303801','0303802','0303803'
    )
);

PRINT 'Cleared existing dynamic report entries';

-- ============================================================
-- DBMASTERLAPORAN SEED
-- ============================================================

-- 0302xx: Penawaran Reports
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030201', 'Laporan Penawaran Per No.Bukti', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030202', 'Laporan Penawaran Per Barang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030203', 'Laporan Penawaran Per Customer', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030204', 'Laporan Penawaran Per Marketing', 1, '[]');

-- 03030x: Laporan SO/KP
-- NOTE: nama_laporan di dbmasterlaporan HARUS sama dengan DBMENUREPORT.keterangan
-- untuk konsistensi tampilan di UI.
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03030', 'Laporan SO', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303010', 'Laporan SO', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03030101', 'Laporan KP Per No.Bukti', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03030102', 'Laporan KP Per Barang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03030103', 'Laporan KP Per Customer', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030301031', 'Laporan KP Per Sales', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03030104', 'Laporan HPP KP', 1, '[]');

-- 030302x: Laporan Pembelian
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303020', 'Laporan OutStanding KP', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03030201', 'Laporan OutStanding KP Per No.Bukti', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03030202', 'Laporan OutStanding KP Per Barang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03030203', 'Laporan OutStanding KP Per Customer', 1, '[]');

-- 03031x: Laporan Penjualan
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03031', 'Laporan Perintah Kirim', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303110', 'Laporan KP', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03031101', 'Laporan KP Per No. Bukti', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03031102', 'Laporan KP Per Barang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03031103', 'Laporan KP Per Customer', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303120', 'Laporan SPP', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03031201', 'Laporan SPP Per No. Bukti', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03031202', 'Laporan SPP Per Barang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03031203', 'Laporan SPP Per Customer', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303130', 'Laporan Uang Saku', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030313001', 'Uang Saku Per No.Bukti', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030313002', 'Uang Saku Per Project', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030313003', 'Uang Saku Per No. SJ', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030314', 'Laporan CashBack', 1, '[]');

-- 03032x: Laporan Stok & Barang
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032', 'Laporan Surat Jalan', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303210', 'Laporan Outstanding SPP', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032101', 'Laporan Outstanding SPP Per No. Bukti', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032102', 'Laporan Outstanding SPP Per Barang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032103', 'Laporan Outstanding SPP Per Customer', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303220', 'Laporan Pengiriman', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032201', 'Laporan Pengiriman Per No. Bukti', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032202', 'Laporan Pengiriman Per Barang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032203', 'Laporan  Per Customer', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032204', 'Laporan Kontrak vs SJ', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032205', 'Laporan Sisa Order Per Customer', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032206', 'Laporan Progress Pengiriman', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032207', 'Laporan  Per NO. POL', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032301', 'Laporan Pengiriman ACC Per No. Bukti', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032302', 'Laporan Pengiriman ACC Per Barang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032303', 'Laporan Pengiriman ACC Per Customer', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032304', 'Laporan Pengiriman ACC Per Gudang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303240', 'Laporan Rekapitulasi Pengiriman Barang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303241', 'Laporan Faktur Penjualan', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303251', 'Retur Surat Jalan per Nobukti', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303252', 'Retur Surat Jalan per Barang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303253', 'Retur Surat Jalan per Customer', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032601', 'Retur Surat Jalan', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032602', 'Retur Surat Jalan ACC', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03032603', 'Per Cutomer', 1, '[]');

-- 03033x: Laporan Keuangan
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03033', 'Laporan Invoice Penjualan', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303301', 'Laporan Neraca', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303302', 'Laporan Laba Rugi', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303303', 'Laporan Arus Kas', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303304', 'Laporan Perubahan Ekuitas', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303310', 'Buku Besar', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03033101', 'Buku Besar Harian', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03033102', 'Buku Besar Mingguan', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03033103', 'Buku Besar Bulanan', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303320', 'Neraca Saldo', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03033201', 'Neraca Saldo Awal', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03033202', 'Neraca Saldo Akhir', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03033203', 'Neraca Saldo per Periode', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303321', 'Neraca Adjusting', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303322', 'Neraca Closing', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303323', 'Neraca Recurring', 1, '[]');

-- 03034x: Laporan Pajak
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03034', 'Laporan Invoice Retur Penjualan', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303410', 'Pajak Pembelian', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303420', 'Pajak Penjualan', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303430', 'SPT Masa PPN', 1, '[]');

-- 03035x: Laporan Khusus
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303501', 'Laporan Target Sales', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303502', 'Laporan Komisi Sales', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030351', 'Laporan Aging Piutang', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030352', 'Laporan Aging Hutang', 1, '[]');

-- 03036x: Laporan Operasional
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030361', 'Laporan Komisi Pelunasan', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('030362', 'Laporan Komisi Sales', 1, '[]');

-- 03037x: Laporan Produksi
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303701', 'Laporan Produksi Harian', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303702', 'Laporan Produksi Mingguan', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303703', 'Laporan Produksi Bulanan', 1, '[]');

-- 03038x: Laporan Persediaan
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303801', 'Laporan Stok Opname', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303802', 'Laporan Selisih Stok', 1, '[]');

INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('0303803', 'Laporan Penyesuaian Stok', 1, '[]');

PRINT 'Inserted dbmasterlaporan seed data';
GO

-- ============================================================
-- DBQUERYLAPORAN SEED
-- Map known SPs from Delphi dispatch table
-- ============================================================

-- 0302xx: Penawaran Reports
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapPenawaranPerNobukti', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapPenawaranPerNobukti"}'
FROM dbmasterlaporan WHERE KODEMENU = '030201';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapPenawaranPerBarang', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapPenawaranPerBarang"}'
FROM dbmasterlaporan WHERE KODEMENU = '030202';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapPenawaranPerCustomer', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapPenawaranPerCustomer"}'
FROM dbmasterlaporan WHERE KODEMENU = '030203';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapPenawaranPerMarketing', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapPenawaranPerMarketing"}'
FROM dbmasterlaporan WHERE KODEMENU = '030204';

-- 03030x: Laporan KP (Kartu Piutang)
-- NOTE: nama_laporan harus sesuai dengan DBMENUREPORT.keterangan
-- NOTE: Ikuti DBMENUREPORT.keterangan untuk nama yang benar
-- Note: 3030101-3030104 use Sp_ReportSODet (from Delphi)
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_ReportSODet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_ReportSODet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03030101';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_ReportSODet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_ReportSODet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03030102';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_ReportSODet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_ReportSODet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03030103';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_ReportSODet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_ReportSODet"}'
FROM dbmasterlaporan WHERE KODEMENU = '030301031';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_ReportSODet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_ReportSODet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03030104';

-- 030302x: Laporan Pembelian
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303020';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '03030201';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '03030202';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '03030203';

-- 03031x: Laporan Penjualan (from Delphi: Sp_reportOutSoDet for 30311xx, Sp_reportSppdet for 30312xx)
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportOutSoDet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportOutSoDet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03031101';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportOutSoDet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportOutSoDet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03031102';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportOutSoDet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportOutSoDet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03031103';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSppdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSppdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03031201';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSppdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSppdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03031202';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSppdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSppdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03031203';

-- 0303130: Komisi Marketing
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapKomisiMarketing', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapKomisiMarketing"}'
FROM dbmasterlaporan WHERE KODEMENU = '030313001';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapKomisiMarketing', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapKomisiMarketing"}'
FROM dbmasterlaporan WHERE KODEMENU = '030313002';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapKomisiMarketing', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapKomisiMarketing"}'
FROM dbmasterlaporan WHERE KODEMENU = '030313003';

-- 030314: CashBack (already in seed_complete.sql)
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapCashBack', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapCashBack"}'
FROM dbmasterlaporan WHERE KODEMENU = '030314';

-- 03032x: Laporan Stok & Barang
-- 030321x: Stok Opname
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_ReportStokOpname', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_ReportStokOpname"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032101';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_ReportStokOpname', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_ReportStokOpname"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032102';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_ReportStokOpname', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_ReportStokOpname"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032103';

-- 030322x: Mutasi Barang (from Delphi: Sp_reportSpbdet)
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSpbdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSpbdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032201';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSpbdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSpbdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032202';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSpbdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSpbdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032203';

-- 03032204-03032207: Mutasi variants
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSpbdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSpbdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032204';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSpbdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSpbdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032205';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSpbdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSpbdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032206';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSpbdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSpbdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032207';

-- 030323x: Stok variants
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSpbACCdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSpbACCdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032301';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSpbACCdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSpbACCdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032302';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_reportSpbACCdet', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_reportSpbACCdet"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032303';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '03032304';

-- 030324x: Barang variants
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303240';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303241';

-- 030325x: Retur variants
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapReturPembelian', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapReturPembelian"}'
FROM dbmasterlaporan WHERE KODEMENU = '0303251';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapReturPenjualan', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapReturPenjualan"}'
FROM dbmasterlaporan WHERE KODEMENU = '0303252';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapReturSupplier', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapReturSupplier"}'
FROM dbmasterlaporan WHERE KODEMENU = '0303253';

-- 030326x: Retur Surat Jalan (already in seed_complete.sql for 030325, 030326)
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapReturSuratJalan', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapReturSuratJalan"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032601';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapReturSuratJalanACC', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapReturSuratJalanACC"}'
FROM dbmasterlaporan WHERE KODEMENU = '03032602';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '03032603';

-- 03033x: Laporan Keuangan
-- 0303301-0303304: Neraca, Laba Rugi, etc.
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapNeraca', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapNeraca"}'
FROM dbmasterlaporan WHERE KODEMENU = '0303301';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapLabaRugi', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapLabaRugi"}'
FROM dbmasterlaporan WHERE KODEMENU = '0303302';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapArusKas', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapArusKas"}'
FROM dbmasterlaporan WHERE KODEMENU = '0303303';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303304';

-- 030331x: Buku Besar
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapBukuBesar', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapBukuBesar"}'
FROM dbmasterlaporan WHERE KODEMENU = '03033101';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapBukuBesar', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapBukuBesar"}'
FROM dbmasterlaporan WHERE KODEMENU = '03033102';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapBukuBesar', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapBukuBesar"}'
FROM dbmasterlaporan WHERE KODEMENU = '03033103';

-- 030332x: Neraca Saldo
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapNeracaSaldo', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapNeracaSaldo"}'
FROM dbmasterlaporan WHERE KODEMENU = '03033201';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapNeracaSaldo', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapNeracaSaldo"}'
FROM dbmasterlaporan WHERE KODEMENU = '03033202';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapNeracaSaldo', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapNeracaSaldo"}'
FROM dbmasterlaporan WHERE KODEMENU = '03033203';

-- 0303321-0303323: Neraca variants
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303321';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303322';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303323';

-- 03034x: Laporan Pajak
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303410';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303420';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303430';

-- 03035x: Laporan Khusus
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapTargetSales', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapTargetSales"}'
FROM dbmasterlaporan WHERE KODEMENU = '0303501';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapKomisiSales', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapKomisiSales"}'
FROM dbmasterlaporan WHERE KODEMENU = '0303502';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapAgingPiutang', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapAgingPiutang"}'
FROM dbmasterlaporan WHERE KODEMENU = '030351';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapAgingHutang', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapAgingHutang"}'
FROM dbmasterlaporan WHERE KODEMENU = '030352';

-- 03036x: Laporan Operasional (already in seed_complete.sql)
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapKomisiPelunasan', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapKomisiPelunasan"}'
FROM dbmasterlaporan WHERE KODEMENU = '030361';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'EXEC Sp_LapKomisiSales', '{"static_params": {}, "display_role": "detail", "sp_signature": "Sp_LapKomisiSales"}'
FROM dbmasterlaporan WHERE KODEMENU = '030362';

-- 03037x: Laporan Produksi
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303701';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303702';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303703';

-- 03038x: Laporan Persediaan
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303801';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303802';

INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, '-- TO BE CONFIGURED --', '{"static_params": {}}'
FROM dbmasterlaporan WHERE KODEMENU = '0303803';

PRINT 'Inserted dbquerylaporan seed data';
GO

-- ============================================================
-- DBPARAMETERLAPORAN SEED (delete old, insert new)
-- ============================================================

-- Clear old parameters for these KODEMENU
DELETE FROM dbparameterlaporan
WHERE id_laporan IN (
    SELECT id_laporan FROM dbmasterlaporan 
    WHERE KODEMENU IN (
        '030201','030202','030203','030204', '03030','0303010','03030101','03030102','03030103','030301031','03030104',
        '0303020','03030201','03030202','03030203', '03031','0303110','03031101','03031102','03031103',
        '0303120','03031201','03031202','03031203', '0303130','030313001','030313002','030313003',
        '030314', '03032','0303210','03032101','03032102','03032103',
        '0303220','03032201','03032202','03032203','03032204','03032205','03032206','03032207',
        '03032301','03032302','03032303','03032304', '0303240','0303241',
        '0303251','0303252','0303253', '03032601','03032602','03032603',
        '03033','0303301','0303302','0303303','0303304', '0303310','03033101','03033102','03033103',
        '0303320','03033201','03033202','03033203','0303321','0303322','0303323',
        '03034','0303410','0303420','0303430', '0303501','0303502','030351','030352',
        '030361','030362', '0303701','0303702','0303703', '0303801','0303802','0303803'
    )
);

PRINT 'Cleared existing parameters';

-- Insert default parameters for each report (TglAwal, TglAkhir, Divisi)
-- Using recursive CTE approach for efficiency

-- Generate parameters for all reports
;WITH ReportIds AS (
    SELECT id_laporan, KODEMENU FROM dbmasterlaporan 
    WHERE KODEMENU IN (
        '030201','030202','030203','030204', '03030','0303010','03030101','03030102','03030103','030301031','03030104',
        '0303020','03030201','03030202','03030203', '03031','0303110','03031101','03031102','03031103',
        '0303120','03031201','03031202','03031203', '0303130','030313001','030313002','030313003',
        '030314', '03032','0303210','03032101','03032102','03032103',
        '0303220','03032201','03032202','03032203','03032204','03032205','03032206','03032207',
        '03032301','03032302','03032303','03032304', '0303240','0303241',
        '0303251','0303252','0303253', '03032601','03032602','03032603',
        '03033','0303301','0303302','0303303','0303304', '0303310','03033101','03033102','03033103',
        '0303320','03033201','03033202','03033203','0303321','0303322','0303323',
        '03034','0303410','0303420','0303430', '0303501','0303502','030351','030352',
        '030361','030362', '0303701','0303702','0303703', '0303801','0303802','0303803'
    )
),
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
    UNION ALL
    SELECT id_laporan, 5 AS posisi, 'SReport' AS nama_filter, 'Report Type' AS label, 'combobox' AS tipe_input, 0 AS wajib_isi, CONVERT(NVARCHAR, GETDATE(), 121) AS created_at, '{"type": "combobox", "paramIndex": 0, "default": "T"}' AS konfigurasi
    FROM ReportIds
    WHERE KODEMENU IN ('03030101','03030102','03030103','030301031','03030104')
)
INSERT INTO dbparameterlaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, posisi, konfigurasi, created_at)
SELECT id_laporan, nama_filter, label, tipe_input, wajib_isi, 
       CASE WHEN nama_filter = 'TglAwal' THEN CONVERT(NVARCHAR, DATEADD(day, -7, GETDATE()), 121)
            WHEN nama_filter = 'TglAkhir' THEN CONVERT(NVARCHAR, GETDATE(), 121)
            ELSE NULL END,
       posisi, konfigurasi, created_at
FROM ParamDefaults
ORDER BY id_laporan, posisi;




PRINT 'Inserted default parameters';
GO

-- ============================================================
-- DBKOLOMLAPORAN SEED (delete old, insert basic columns)
-- ============================================================

-- Clear old columns for these KODEMENU
DELETE FROM dbkolomlaporan
WHERE id_laporan IN (
    SELECT id_laporan FROM dbmasterlaporan 
    WHERE KODEMENU IN (
        '030201','030202','030203','030204', '03030','0303010','03030101','03030102','03030103','030301031','03030104',
        '0303020','03030201','03030202','03030203', '03031','0303110','03031101','03031102','03031103',
        '0303120','03031201','03031202','03031203', '0303130','030313001','030313002','030313003',
        '030314', '03032','0303210','03032101','03032102','03032103',
        '0303220','03032201','03032202','03032203','03032204','03032205','03032206','03032207',
        '03032301','03032302','03032303','03032304', '0303240','0303241',
        '0303251','0303252','0303253', '03032601','03032602','03032603',
        '03033','0303301','0303302','0303303','0303304', '0303310','03033101','03033102','03033103',
        '0303320','03033201','03033202','03033203','0303321','0303322','0303323',
        '03034','0303410','0303420','0303430', '0303501','0303502','030351','030352',
        '030361','030362', '0303701','0303702','0303703', '0303801','0303802','0303803'
    )
);

PRINT 'Cleared existing columns';

-- Insert basic placeholder columns (will be updated per report)
-- For each report, insert a generic "Keterangan" column as placeholder
-- This ensures the report has at least one column defined
INSERT INTO dbkolomlaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
SELECT ml.id_laporan, 'dataset_utama', 'Keterangan', 'Keterangan', 1, 'string', 'left', 0, 1
FROM dbmasterlaporan ml
WHERE ml.KODEMENU IN (
    '030201','030202','030203','030204', '03030','0303010','03030101','03030102','03030103','030301031','03030104',
    '0303020','03030201','03030202','03030203', '03031','0303110','03031101','03031102','03031103',
    '0303120','03031201','03031202','03031203', '0303130','030313001','030313002','030313003',
    '030314', '03032','0303210','03032101','03032102','03032103',
    '0303220','03032201','03032202','03032203','03032204','03032205','03032206','03032207',
    '03032301','03032302','03032303','03032304', '0303240','0303241',
    '0303251','0303252','0303253', '03032601','03032602','03032603',
    '03033','0303301','0303302','0303303','0303304', '0303310','03033101','03033102','03033103',
    '0303320','03033201','03033202','03033203','0303321','0303322','0303323',
    '03034','0303410','0303420','0303430', '0303501','0303502','030351','030352',
    '030361','030362', '0303701','0303702','0303703', '0303801','0303802','0303803'
);

PRINT 'Inserted default columns';
GO

PRINT 'Finished seeding dynamic reports';
