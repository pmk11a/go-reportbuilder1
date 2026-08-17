-- ============================================================
-- Seed Laporan KODEMENU: 03031101 - Laporan KP Per No. Bukti
-- SP: Sp_reportOutSoDet (dari Delphi FrmReportPreview.pas)
-- Params: :0=Type('T'), :1=Grouping('N'/'B'/'C'), :2=FilterList
-- ============================================================

-- 1. Hapus data lama untuk idemponent
DELETE FROM dbkomponenlaporan WHERE id_laporan IN (SELECT id_laporan FROM dbmasterlaporan WHERE KODEMENU = '03031101');
DELETE FROM dbquerylaporan    WHERE id_laporan IN (SELECT id_laporan FROM dbmasterlaporan WHERE KODEMENU = '03031101');
DELETE FROM dbparameterlaporan WHERE id_laporan IN (SELECT id_laporan FROM dbmasterlaporan WHERE KODEMENU = '03031101');
DELETE FROM dbmasterlaporan   WHERE KODEMENU = '03031101';

PRINT 'Cleared existing entries for 03031101';

-- 2. Master Laporan
INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif, footer_bands)
VALUES ('03031101', 'Laporan KP Per No. Bukti', 1, '[]');

PRINT 'Inserted dbmasterlaporan for 03031101';

-- 3. Parameter Filters (dari Delphi: TglAwal, TglAkhir)
INSERT INTO dbparameterlaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, posisi, konfigurasi)
SELECT id_laporan, 'tgl_awal', 'Tanggal Awal', 'date', 1, NULL, 1, NULL
FROM dbmasterlaporan WHERE KODEMENU = '03031101';

INSERT INTO dbparameterlaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, posisi, konfigurasi)
SELECT id_laporan, 'tgl_akhir', 'Tanggal Akhir', 'date', 1, NULL, 2, NULL
FROM dbmasterlaporan WHERE KODEMENU = '03031101';

PRINT 'Inserted dbparameterlaporan for 03031101';

-- 4. Query Dataset (scope: body untuk data utama)
-- NOTE: SP Sp_ReportOutSODet pakai dynamic EXEC() yang tidak bisa return results via GORM
-- Query view langsung dengan logic yang sama
INSERT INTO dbquerylaporan (id_laporan, nama_dataset, urutan, query_sumber_data, config_json)
SELECT id_laporan, 'dataset_utama', 1, 'SELECT ''Gabungan'' AS Perusahaan, * FROM vwreportoutSO WHERE (Tanggal BETWEEN @tgl_awal AND @tgl_akhir) ORDER BY NoBukti, Tanggal',
       '{"scope": "body", "static_params": {}, "display_role": "detail"}'
FROM dbmasterlaporan WHERE KODEMENU = '03031101';

PRINT 'Inserted dbquerylaporan for 03031101';

-- 5. Komponen Layout (Header, Body, Footer)
INSERT INTO dbkomponenlaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan)
SELECT id_laporan, 'HeaderLayout', '{"type":"header","rows":[]}', 1
FROM dbmasterlaporan WHERE KODEMENU = '03031101';

INSERT INTO dbkomponenlaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan)
SELECT id_laporan, 'BodyLayout', '{"type":"body","rows":[]}', 2
FROM dbmasterlaporan WHERE KODEMENU = '03031101';

INSERT INTO dbkomponenlaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan)
SELECT id_laporan, 'FooterLayout', '{"type":"footer","rows":[]}', 3
FROM dbmasterlaporan WHERE KODEMENU = '03031101';

PRINT 'Inserted dbkomponenlaporan for 03031101';

PRINT 'Seed completed for KODEMENU 03031101';
GO
