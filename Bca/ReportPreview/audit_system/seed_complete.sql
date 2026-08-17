-- ============================================================
-- COMPLETE SEED FOR 49 MISSING REPORTS
-- Database: SQL Server (sqlsrv)
-- Tables:   dbMasterLaporan, dbQueryLaporan, dbParameterLaporan
--
-- Strategi: Idempotent per report -- DELETE dulu by KODEMENU,
--           lalu INSERT fresh.  Setiap report dibungkus batch
--           GO terpisah agar variabel lokal (@IdLapN) ter-reset
--           dan lookup id_laporan selalu fresh per section.
--
-- Pola per report (mengikuti seeds_all_complete.sql):
--   Na. dbMasterLaporan    -- DELETE+INSERT, GO
--   Nb. dbQueryLaporan     -- DECLARE @IdLapN, lookup, DELETE+INSERT, GO
--   Nc. dbParameterLaporan -- DECLARE ulang, DELETE+INSERT, GO
--
-- PENTING: dbmenreport & dbflmenureport TIDAK diubah
--          (lihat memory: no-modify-menu-report-tables)
-- ============================================================

USE dbbcagroup;
GO

-- ============================================================
-- REPORT 1: 020106 -- Daftar Deposito
-- ============================================================

-- 1a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020106';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020106', 'Daftar Deposito', 1);
GO

-- 1b. dbQueryLaporan
DECLARE @IdLap1 INT;
SET @IdLap1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020106');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap1;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap1, 'ds_020106', 'EXEC Sp_LapDeposito');
GO

-- 1c. dbParameterLaporan
DECLARE @IdLap1b INT;
SET @IdLap1b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020106');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap1b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap1b, 'Masuk', 'text', 0),
    (@IdLap1b, 'Divisi', 'text', 0),
    (@IdLap1b, 'Perkiraan', 'text', 0),
    (@IdLap1b, 'TglAw', 'text', 0),
    (@IdLap1b, 'TglAk', 'text', 0);
GO

-- ============================================================
-- REPORT 2: 020107 -- Daftar Giro diterima
-- ============================================================

-- 2a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020107';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020107', 'Daftar Giro diterima', 1);
GO

-- 2b. dbQueryLaporan
DECLARE @IdLap2 INT;
SET @IdLap2 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020107');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap2;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap2, 'ds_020107', 'EXEC Sp_LapGiroHutang');
GO

-- 2c. dbParameterLaporan
DECLARE @IdLap2b INT;
SET @IdLap2b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020107');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap2b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap2b, 'Masuk', 'text', 0),
    (@IdLap2b, 'Divisi', 'text', 0),
    (@IdLap2b, 'Perkiraan', 'text', 0),
    (@IdLap2b, 'TglAw', 'text', 0),
    (@IdLap2b, 'TglAk', 'text', 0);
GO

-- ============================================================
-- REPORT 3: 020108 -- Daftar Giro dibuka
-- ============================================================

-- 3a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020108';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020108', 'Daftar Giro dibuka', 1);
GO

-- 3b. dbQueryLaporan
DECLARE @IdLap3 INT;
SET @IdLap3 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020108');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap3;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap3, 'ds_020108', 'EXEC sp_LapGiroPiutang');
GO

-- 3c. dbParameterLaporan
DECLARE @IdLap3b INT;
SET @IdLap3b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020108');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap3b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap3b, 'Masuk', 'text', 0),
    (@IdLap3b, 'Divisi', 'text', 0),
    (@IdLap3b, 'Perkiraan', 'text', 0),
    (@IdLap3b, 'TglAw', 'text', 0),
    (@IdLap3b, 'TglAk', 'text', 0),
    (@IdLap3b, 'tolak', 'text', 0);
GO

-- ============================================================
-- REPORT 4: 020201 -- Jurnal
-- ============================================================

-- 4a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020201';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020201', 'Jurnal', 1);
GO

-- 4b. dbQueryLaporan
DECLARE @IdLap4 INT;
SET @IdLap4 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020201');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap4;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap4, 'ds_020201', 'EXEC Sp_LapJurnal');
GO

-- 4c. dbParameterLaporan
DECLARE @IdLap4b INT;
SET @IdLap4b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020201');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap4b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap4b, 'Tipe', 'text', 0),
    (@IdLap4b, 'Divisi', 'text', 0),
    (@IdLap4b, 'TglAw', 'text', 0),
    (@IdLap4b, 'TglAk', 'text', 0);
GO

-- ============================================================
-- REPORT 5: 020205 -- Aktiva
-- ============================================================

-- 5a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020205';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020205', 'Aktiva', 1);
GO

-- 5b. dbQueryLaporan
DECLARE @IdLap5 INT;
SET @IdLap5 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020205');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap5;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap5, 'ds_020205', 'EXEC sp_LapAktiva');
GO

-- 5c. dbParameterLaporan
DECLARE @IdLap5b INT;
SET @IdLap5b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020205');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap5b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap5b, 'bulan', 'text', 0),
    (@IdLap5b, 'tahun', 'text', 0),
    (@IdLap5b, 'Divisi', 'text', 0);
GO

-- ============================================================
-- REPORT 6: 020206 -- Biaya Penyusutan
-- ============================================================

-- 6a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020206';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020206', 'Biaya Penyusutan', 1);
GO

-- 6b. dbQueryLaporan
DECLARE @IdLap6 INT;
SET @IdLap6 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020206');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap6;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap6, 'ds_020206', 'EXEC sp_LapSusutAktiva');
GO

-- 6c. dbParameterLaporan
DECLARE @IdLap6b INT;
SET @IdLap6b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020206');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap6b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap6b, 'bulan', 'text', 0),
    (@IdLap6b, 'tahun', 'text', 0),
    (@IdLap6b, 'Divisi', 'text', 0);
GO

-- ============================================================
-- REPORT 7: 020303 -- Pelunasan
-- ============================================================

-- 7a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020303';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020303', 'Pelunasan', 1);
GO

-- 7b. dbQueryLaporan
DECLARE @IdLap7 INT;
SET @IdLap7 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020303');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap7;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap7, 'ds_020303', 'EXEC sp_ReportPelunasanPiutang');
GO

-- 7c. dbParameterLaporan
DECLARE @IdLap7b INT;
SET @IdLap7b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020303');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap7b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap7b, 'tanggal1', 'text', 0),
    (@IdLap7b, 'tanggal2', 'text', 0),
    (@IdLap7b, 'awal', 'text', 0),
    (@IdLap7b, 'akhir', 'text', 0),
    (@IdLap7b, 'devisi', 'text', 0),
    (@IdLap7b, 'tipe', 'text', 0),
    (@IdLap7b, 'perkiraan', 'text', 0),
    (@IdLap7b, 'KodeVls', 'text', 0);
GO

-- ============================================================
-- REPORT 8: 020304 -- Saldo
-- ============================================================

-- 8a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020304';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020304', 'Saldo', 1);
GO

-- 8b. dbQueryLaporan
DECLARE @IdLap8 INT;
SET @IdLap8 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020304');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap8;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap8, 'ds_020304', 'EXEC sp_ReportSisaPiutang');
GO

-- 8c. dbParameterLaporan
DECLARE @IdLap8b INT;
SET @IdLap8b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020304');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap8b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap8b, 'tanggal', 'text', 0),
    (@IdLap8b, 'awal', 'text', 0),
    (@IdLap8b, 'akhir', 'text', 0),
    (@IdLap8b, 'devisi', 'text', 0),
    (@IdLap8b, 'tipe', 'text', 0),
    (@IdLap8b, 'Perkiraan', 'text', 0),
    (@IdLap8b, 'KodeVls', 'text', 0);
GO

-- ============================================================
-- REPORT 9: 020403 -- Pelunasan
-- ============================================================

-- 9a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020403';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020403', 'Pelunasan', 1);
GO

-- 9b. dbQueryLaporan
DECLARE @IdLap9 INT;
SET @IdLap9 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020403');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap9;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap9, 'ds_020403', 'EXEC sp_ReportPelunasanPiutang');
GO

-- 9c. dbParameterLaporan
DECLARE @IdLap9b INT;
SET @IdLap9b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020403');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap9b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap9b, 'tanggal1', 'text', 0),
    (@IdLap9b, 'tanggal2', 'text', 0),
    (@IdLap9b, 'awal', 'text', 0),
    (@IdLap9b, 'akhir', 'text', 0),
    (@IdLap9b, 'devisi', 'text', 0),
    (@IdLap9b, 'tipe', 'text', 0),
    (@IdLap9b, 'perkiraan', 'text', 0),
    (@IdLap9b, 'KodeVls', 'text', 0);
GO

-- ============================================================
-- REPORT 10: 020404 -- Saldo
-- ============================================================

-- 10a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020404';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020404', 'Saldo', 1);
GO

-- 10b. dbQueryLaporan
DECLARE @IdLap10 INT;
SET @IdLap10 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020404');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap10;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap10, 'ds_020404', 'EXEC sp_ReportSisaPiutangDet');
GO

-- 10c. dbParameterLaporan
DECLARE @IdLap10b INT;
SET @IdLap10b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020404');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap10b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap10b, 'tanggal', 'text', 0),
    (@IdLap10b, 'awal', 'text', 0),
    (@IdLap10b, 'akhir', 'text', 0),
    (@IdLap10b, 'devisi', 'text', 0),
    (@IdLap10b, 'tipe', 'text', 0),
    (@IdLap10b, 'Perkiraan', 'text', 0),
    (@IdLap10b, 'KodeVls', 'text', 0);
GO

-- ============================================================
-- REPORT 11: 020407 -- Monitoring Pembayaran Piutang
-- ============================================================

-- 11a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020407';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020407', 'Monitoring Pembayaran Piutang', 1);
GO

-- 11b. dbQueryLaporan
DECLARE @IdLap11 INT;
SET @IdLap11 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020407');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap11;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap11, 'ds_020407', 'EXEC sp_ReportMonitoringPiutang');
GO

-- 11c. dbParameterLaporan
DECLARE @IdLap11b INT;
SET @IdLap11b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020407');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap11b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap11b, 'tanggal', 'text', 0),
    (@IdLap11b, 'awal', 'text', 0),
    (@IdLap11b, 'akhir', 'text', 0),
    (@IdLap11b, 'devisi', 'text', 0),
    (@IdLap11b, 'tipe', 'text', 0),
    (@IdLap11b, 'Perkiraan', 'text', 0),
    (@IdLap11b, 'KodeVls', 'text', 0),
    (@IdLap11b, 'KodePrj', 'text', 0);
GO

-- ============================================================
-- REPORT 12: 020502 -- HPP
-- ============================================================

-- 12a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020502';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020502', 'HPP', 1);
GO

-- 12b. dbQueryLaporan
DECLARE @IdLap12 INT;
SET @IdLap12 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020502');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap12;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap12, 'ds_020502', 'EXEC Sp_ReportStock');
GO

-- 12c. dbParameterLaporan
DECLARE @IdLap12b INT;
SET @IdLap12b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020502');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap12b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap12b, 'bulan', 'text', 0),
    (@IdLap12b, 'tahun', 'text', 0),
    (@IdLap12b, 'kodegdg', 'text', 0),
    (@IdLap12b, 'nosat', 'text', 0);
GO

-- ============================================================
-- REPORT 13: 020505 -- Laporan Neraca Penunjang
-- ============================================================

-- 13a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020505';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020505', 'Laporan Neraca Penunjang', 1);
GO

-- 13b. dbQueryLaporan
DECLARE @IdLap13 INT;
SET @IdLap13 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020505');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap13;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap13, 'ds_020505', 'EXEC SP_LapNeracaPenunjang');
GO

-- 13c. dbParameterLaporan
DECLARE @IdLap13b INT;
SET @IdLap13b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020505');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap13b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap13b, 'divisi', 'text', 0),
    (@IdLap13b, 'bulan', 'text', 0),
    (@IdLap13b, 'tahun', 'text', 0);
GO

-- ============================================================
-- REPORT 14: 025711 -- Penerimaan ACC Per. Nobukti
-- ============================================================

-- 14a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '025711';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('025711', 'Penerimaan ACC Per. Nobukti', 1);
GO

-- 14b. dbQueryLaporan
DECLARE @IdLap14 INT;
SET @IdLap14 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025711');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap14;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap14, 'ds_025711', 'EXEC Sp_reportPenerimaanAccDet');
GO

-- 14c. dbParameterLaporan
DECLARE @IdLap14b INT;
SET @IdLap14b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025711');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap14b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap14b, 'SReport', 'text', 0),
    (@IdLap14b, 'Ordr', 'text', 0),
    (@IdLap14b, 'tgl1', 'text', 0),
    (@IdLap14b, 'tgl2', 'text', 0),
    (@IdLap14b, 'isiList', 'text', 0);
GO

-- ============================================================
-- REPORT 15: 025712 -- Penerimaan ACC Per Barang
-- ============================================================

-- 15a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '025712';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('025712', 'Penerimaan ACC Per Barang', 1);
GO

-- 15b. dbQueryLaporan
DECLARE @IdLap15 INT;
SET @IdLap15 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025712');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap15;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap15, 'ds_025712', 'EXEC Sp_ReportPenerimaanACCRek');
GO

-- 15c. dbParameterLaporan
DECLARE @IdLap15b INT;
SET @IdLap15b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025712');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap15b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap15b, 'Choice', 'text', 0),
    (@IdLap15b, 'Tgl1', 'text', 0),
    (@IdLap15b, 'Tgl2', 'text', 0);
GO

-- ============================================================
-- REPORT 16: 025713 -- Penerimaan ACC Per Supplier
-- ============================================================

-- 16a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '025713';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('025713', 'Penerimaan ACC Per Supplier', 1);
GO

-- 16b. dbQueryLaporan
DECLARE @IdLap16 INT;
SET @IdLap16 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025713');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap16;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap16, 'ds_025713', 'EXEC Sp_ReportPenerimaanACCRek');
GO

-- 16c. dbParameterLaporan
DECLARE @IdLap16b INT;
SET @IdLap16b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025713');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap16b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap16b, 'Choice', 'text', 0),
    (@IdLap16b, 'Tgl1', 'text', 0),
    (@IdLap16b, 'Tgl2', 'text', 0);
GO

-- ============================================================
-- REPORT 17: 025731 -- Retur Pembelian ACC Per. Nobukti
-- ============================================================

-- 17a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '025731';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('025731', 'Retur Pembelian ACC Per. Nobukti', 1);
GO

-- 17b. dbQueryLaporan
DECLARE @IdLap17 INT;
SET @IdLap17 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025731');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap17;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap17, 'ds_025731', 'EXEC Sp_reportBeliAccDet');
GO

-- 17c. dbParameterLaporan
DECLARE @IdLap17b INT;
SET @IdLap17b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025731');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap17b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap17b, 'SReport', 'text', 0),
    (@IdLap17b, 'Ordr', 'text', 0),
    (@IdLap17b, 'tgl1', 'text', 0),
    (@IdLap17b, 'tgl2', 'text', 0),
    (@IdLap17b, 'isiList', 'text', 0),
    (@IdLap17b, 'NeedOto', 'text', 0),
    (@IdLap17b, 'TipeBayar', 'text', 0),
    (@IdLap17b, 'Perkiraan', 'text', 0),
    (@IdLap17b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 18: 025732 -- Retur Pembelian ACC Per Barang
-- ============================================================

-- 18a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '025732';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('025732', 'Retur Pembelian ACC Per Barang', 1);
GO

-- 18b. dbQueryLaporan
DECLARE @IdLap18 INT;
SET @IdLap18 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025732');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap18;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap18, 'ds_025732', 'EXEC Sp_reportBeliAccDetPerPerkiraan');
GO

-- 18c. dbParameterLaporan
DECLARE @IdLap18b INT;
SET @IdLap18b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025732');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap18b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap18b, 'SReport', 'text', 0),
    (@IdLap18b, 'Ordr', 'text', 0),
    (@IdLap18b, 'tgl1', 'text', 0),
    (@IdLap18b, 'tgl2', 'text', 0),
    (@IdLap18b, 'isiList', 'text', 0),
    (@IdLap18b, 'NeedOto', 'text', 0),
    (@IdLap18b, 'TipeBayar', 'text', 0),
    (@IdLap18b, 'Keterangan', 'text', 0),
    (@IdLap18b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 19: 025733 -- Retur Pembelian ACC Per Supplier
-- ============================================================

-- 19a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '025733';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('025733', 'Retur Pembelian ACC Per Supplier', 1);
GO

-- 19b. dbQueryLaporan
DECLARE @IdLap19 INT;
SET @IdLap19 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025733');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap19;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap19, 'ds_025733', 'EXEC Sp_reportBeliAccDet');
GO

-- 19c. dbParameterLaporan
DECLARE @IdLap19b INT;
SET @IdLap19b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025733');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap19b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap19b, 'SReport', 'text', 0),
    (@IdLap19b, 'Ordr', 'text', 0),
    (@IdLap19b, 'tgl1', 'text', 0),
    (@IdLap19b, 'tgl2', 'text', 0),
    (@IdLap19b, 'isiList', 'text', 0),
    (@IdLap19b, 'NeedOto', 'text', 0),
    (@IdLap19b, 'TipeBayar', 'text', 0),
    (@IdLap19b, 'Perkiraan', 'text', 0),
    (@IdLap19b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 20: 025741 -- Retur Pembelian GDG Per No. Bukti
-- ============================================================

-- 20a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '025741';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('025741', 'Retur Pembelian GDG Per No. Bukti', 1);
GO

-- 20b. dbQueryLaporan
DECLARE @IdLap20 INT;
SET @IdLap20 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025741');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap20;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap20, 'ds_025741', 'EXEC Sp_reportRBeliGDGDet');
GO

-- 20c. dbParameterLaporan
DECLARE @IdLap20b INT;
SET @IdLap20b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025741');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap20b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap20b, 'SReport', 'text', 0),
    (@IdLap20b, 'Ordr', 'text', 0),
    (@IdLap20b, 'tgl1', 'text', 0),
    (@IdLap20b, 'tgl2', 'text', 0),
    (@IdLap20b, 'isiList', 'text', 0),
    (@IdLap20b, 'NeedOto', 'text', 0),
    (@IdLap20b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 21: 025743 -- Retur Pembelian GDGPer Supplier
-- ============================================================

-- 21a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '025743';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('025743', 'Retur Pembelian GDGPer Supplier', 1);
GO

-- 21b. dbQueryLaporan
DECLARE @IdLap21 INT;
SET @IdLap21 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025743');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap21;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap21, 'ds_025743', 'EXEC Sp_reportRPembelianGDGRek');
GO

-- 21c. dbParameterLaporan
DECLARE @IdLap21b INT;
SET @IdLap21b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '025743');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap21b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap21b, 'Choice', 'text', 0),
    (@IdLap21b, 'Tgl1', 'text', 0),
    (@IdLap21b, 'Tgl2', 'text', 0),
    (@IdLap21b, 'NeedOto', 'text', 0),
    (@IdLap21b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 22: 030201 -- Laporan Penawaran Per No.Bukti
-- ============================================================

-- 22a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '030201';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('030201', 'Laporan Penawaran Per No.Bukti', 1);
GO

-- 22b. dbQueryLaporan
DECLARE @IdLap22 INT;
SET @IdLap22 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030201');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap22;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap22, 'ds_030201', 'EXEC Sp_ReportPNWDet');
GO

-- 22c. dbParameterLaporan
DECLARE @IdLap22b INT;
SET @IdLap22b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030201');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap22b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap22b, 'SReport', 'text', 0),
    (@IdLap22b, 'Ordr', 'text', 0),
    (@IdLap22b, 'tgl1', 'text', 0),
    (@IdLap22b, 'tgl2', 'text', 0),
    (@IdLap22b, 'isiList', 'text', 0),
    (@IdLap22b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 23: 030202 -- Laporan Penawaran Per Barang
-- ============================================================

-- 23a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '030202';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('030202', 'Laporan Penawaran Per Barang', 1);
GO

-- 23b. dbQueryLaporan
DECLARE @IdLap23 INT;
SET @IdLap23 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030202');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap23;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap23, 'ds_030202', 'EXEC Sp_ReportPNWDet');
GO

-- 23c. dbParameterLaporan
DECLARE @IdLap23b INT;
SET @IdLap23b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030202');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap23b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap23b, 'SReport', 'text', 0),
    (@IdLap23b, 'Ordr', 'text', 0),
    (@IdLap23b, 'tgl1', 'text', 0),
    (@IdLap23b, 'tgl2', 'text', 0),
    (@IdLap23b, 'isiList', 'text', 0),
    (@IdLap23b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 24: 030203 -- Laporan Penawaran Per Customer
-- ============================================================

-- 24a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '030203';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('030203', 'Laporan Penawaran Per Customer', 1);
GO

-- 24b. dbQueryLaporan
DECLARE @IdLap24 INT;
SET @IdLap24 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030203');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap24;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap24, 'ds_030203', 'EXEC Sp_reportPNWRek');
GO

-- 24c. dbParameterLaporan
DECLARE @IdLap24b INT;
SET @IdLap24b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030203');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap24b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap24b, 'Choice', 'text', 0),
    (@IdLap24b, 'Tgl1', 'text', 0),
    (@IdLap24b, 'Tgl2', 'text', 0),
    (@IdLap24b, 'needOto', 'text', 0),
    (@IdLap24b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 25: 030204 -- Laporan Penawaran Per Marketing
-- ============================================================

-- 25a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '030204';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('030204', 'Laporan Penawaran Per Marketing', 1);
GO

-- 25b. dbQueryLaporan
DECLARE @IdLap25 INT;
SET @IdLap25 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030204');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap25;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap25, 'ds_030204', 'EXEC Sp_reportPNWRek');
GO

-- 25c. dbParameterLaporan
DECLARE @IdLap25b INT;
SET @IdLap25b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030204');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap25b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap25b, 'Choice', 'text', 0),
    (@IdLap25b, 'Tgl1', 'text', 0),
    (@IdLap25b, 'Tgl2', 'text', 0),
    (@IdLap25b, 'needOto', 'text', 0),
    (@IdLap25b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 26: 030314 -- Laporan CashBack
-- ============================================================

-- 26a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '030314';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('030314', 'Laporan CashBack', 1);
GO

-- 26b. dbQueryLaporan
DECLARE @IdLap26 INT;
SET @IdLap26 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030314');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap26;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap26, 'ds_030314', 'EXEC Sp_report_CashBack');
GO

-- 26c. dbParameterLaporan
DECLARE @IdLap26b INT;
SET @IdLap26b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030314');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap26b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap26b, 'tgl1', 'text', 0),
    (@IdLap26b, 'tgl2', 'text', 0),
    (@IdLap26b, 'isiList', 'text', 0);
GO

-- ============================================================
-- REPORT 27: 030325 -- Retur Surat Jalan
-- ============================================================

-- 27a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '030325';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('030325', 'Retur Surat Jalan', 1);
GO

-- 27b. dbQueryLaporan
DECLARE @IdLap27 INT;
SET @IdLap27 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030325');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap27;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap27, 'ds_030325', 'EXEC Sp_ReturPenyerahan');
GO

-- 27c. dbParameterLaporan
DECLARE @IdLap27b INT;
SET @IdLap27b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030325');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap27b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap27b, 'Choice', 'text', 0),
    (@IdLap27b, 'Nobukti', 'text', 0),
    (@IdLap27b, 'Nourut', 'text', 0),
    (@IdLap27b, 'Tanggal', 'text', 0),
    (@IdLap27b, 'Kodebag', 'text', 0),
    (@IdLap27b, 'kodeBiaya', 'text', 0),
    (@IdLap27b, 'SOP', 'text', 0);
GO

-- ============================================================
-- REPORT 28: 030326 -- Retur Surat Jalan ACC
-- ============================================================

-- 28a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '030326';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('030326', 'Retur Surat Jalan ACC', 1);
GO

-- 28b. dbQueryLaporan
DECLARE @IdLap28 INT;
SET @IdLap28 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030326');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap28;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap28, 'ds_030326', 'EXEC Sp_ReturPenyerahan');
GO

-- 28c. dbParameterLaporan
DECLARE @IdLap28b INT;
SET @IdLap28b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030326');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap28b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap28b, 'Choice', 'text', 0),
    (@IdLap28b, 'Nobukti', 'text', 0),
    (@IdLap28b, 'Nourut', 'text', 0),
    (@IdLap28b, 'Tanggal', 'text', 0),
    (@IdLap28b, 'Kodebag', 'text', 0),
    (@IdLap28b, 'kodeBiaya', 'text', 0),
    (@IdLap28b, 'SOP', 'text', 0);
GO

-- ============================================================
-- REPORT 29: 030351 -- Laporan Target Sales
-- ============================================================

-- 29a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '030351';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('030351', 'Laporan Target Sales', 1);
GO

-- 29b. dbQueryLaporan
DECLARE @IdLap29 INT;
SET @IdLap29 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030351');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap29;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap29, 'ds_030351', 'EXEC sp_ReportKomisiSales');
GO

-- 29c. dbParameterLaporan
DECLARE @IdLap29b INT;
SET @IdLap29b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030351');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap29b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap29b, 'tanggal', 'text', 0),
    (@IdLap29b, 'tipe', 'text', 0),
    (@IdLap29b, 'awal', 'text', 0),
    (@IdLap29b, 'akhir', 'text', 0),
    (@IdLap29b, 'Devisi', 'text', 0),
    (@IdLap29b, 'perkiraan', 'text', 0),
    (@IdLap29b, 'KodeVls', 'text', 0);
GO

-- ============================================================
-- REPORT 30: 030361 -- Komisi Pelunasan
-- ============================================================

-- 30a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '030361';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('030361', 'Komisi Pelunasan', 1);
GO

-- 30b. dbQueryLaporan
DECLARE @IdLap30 INT;
SET @IdLap30 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030361');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap30;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap30, 'ds_030361', 'EXEC sp_ReportKomisiSales');
GO

-- 30c. dbParameterLaporan
DECLARE @IdLap30b INT;
SET @IdLap30b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030361');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap30b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap30b, 'tanggal', 'text', 0),
    (@IdLap30b, 'tipe', 'text', 0),
    (@IdLap30b, 'awal', 'text', 0),
    (@IdLap30b, 'akhir', 'text', 0),
    (@IdLap30b, 'Devisi', 'text', 0),
    (@IdLap30b, 'perkiraan', 'text', 0),
    (@IdLap30b, 'KodeVls', 'text', 0);
GO

-- ============================================================
-- REPORT 31: 030362 -- Komisi Sales
-- ============================================================

-- 31a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '030362';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('030362', 'Komisi Sales', 1);
GO

-- 31b. dbQueryLaporan
DECLARE @IdLap31 INT;
SET @IdLap31 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030362');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap31;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap31, 'ds_030362', 'EXEC sp_ReportKomisiSales');
GO

-- 31c. dbParameterLaporan
DECLARE @IdLap31b INT;
SET @IdLap31b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '030362');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap31b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap31b, 'tanggal', 'text', 0),
    (@IdLap31b, 'tipe', 'text', 0),
    (@IdLap31b, 'awal', 'text', 0),
    (@IdLap31b, 'akhir', 'text', 0),
    (@IdLap31b, 'Devisi', 'text', 0),
    (@IdLap31b, 'perkiraan', 'text', 0),
    (@IdLap31b, 'KodeVls', 'text', 0);
GO

-- ============================================================
-- REPORT 32: 040361 -- Trasfer Barang Per Nobukti
-- ============================================================

-- 32a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040361';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040361', 'Trasfer Barang Per Nobukti', 1);
GO

-- 32b. dbQueryLaporan
DECLARE @IdLap32 INT;
SET @IdLap32 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040361');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap32;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap32, 'ds_040361', 'EXEC Sp_ReportTransferDet');
GO

-- 32c. dbParameterLaporan
DECLARE @IdLap32b INT;
SET @IdLap32b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040361');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap32b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap32b, 'SReport', 'text', 0),
    (@IdLap32b, 'Ordr', 'text', 0),
    (@IdLap32b, 'tgl1', 'text', 0),
    (@IdLap32b, 'tgl2', 'text', 0),
    (@IdLap32b, 'isiList', 'text', 0),
    (@IdLap32b, 'NeedOto', 'text', 0),
    (@IdLap32b, 'GM', 'text', 0),
    (@IdLap32b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 33: 040362 -- Trasfer Barang Per Barang
-- ============================================================

-- 33a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040362';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040362', 'Trasfer Barang Per Barang', 1);
GO

-- 33b. dbQueryLaporan
DECLARE @IdLap33 INT;
SET @IdLap33 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040362');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap33;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap33, 'ds_040362', 'EXEC Sp_ReportTransferDet');
GO

-- 33c. dbParameterLaporan
DECLARE @IdLap33b INT;
SET @IdLap33b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040362');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap33b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap33b, 'SReport', 'text', 0),
    (@IdLap33b, 'Ordr', 'text', 0),
    (@IdLap33b, 'tgl1', 'text', 0),
    (@IdLap33b, 'tgl2', 'text', 0),
    (@IdLap33b, 'isiList', 'text', 0),
    (@IdLap33b, 'NeedOto', 'text', 0),
    (@IdLap33b, 'GM', 'text', 0),
    (@IdLap33b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 34: 040501 -- Laporan Ubah Kemasan Bahan Per Nobukti
-- ============================================================

-- 34a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040501';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040501', 'Laporan Ubah Kemasan Bahan Per Nobukti', 1);
GO

-- 34b. dbQueryLaporan
DECLARE @IdLap34 INT;
SET @IdLap34 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040501');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap34;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap34, 'ds_040501', 'EXEC Sp_reportUbahKemasanBahan');
GO

-- 34c. dbParameterLaporan
DECLARE @IdLap34b INT;
SET @IdLap34b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040501');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap34b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap34b, 'SReport', 'text', 0),
    (@IdLap34b, 'Ordr', 'text', 0),
    (@IdLap34b, 'tgl1', 'text', 0),
    (@IdLap34b, 'tgl2', 'text', 0),
    (@IdLap34b, 'isiList', 'text', 0),
    (@IdLap34b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 35: 040502 -- Laporan Ubah Kemasan Bahan Per Barang
-- ============================================================

-- 35a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040502';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040502', 'Laporan Ubah Kemasan Bahan Per Barang', 1);
GO

-- 35b. dbQueryLaporan
DECLARE @IdLap35 INT;
SET @IdLap35 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040502');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap35;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap35, 'ds_040502', 'EXEC Sp_reportUbahKemasanBahan');
GO

-- 35c. dbParameterLaporan
DECLARE @IdLap35b INT;
SET @IdLap35b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040502');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap35b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap35b, 'SReport', 'text', 0),
    (@IdLap35b, 'Ordr', 'text', 0),
    (@IdLap35b, 'tgl1', 'text', 0),
    (@IdLap35b, 'tgl2', 'text', 0),
    (@IdLap35b, 'isiList', 'text', 0),
    (@IdLap35b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 36: 040701 -- Laporan Opname Bahan Per Nobukti
-- ============================================================

-- 36a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040701';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040701', 'Laporan Opname Bahan Per Nobukti', 1);
GO

-- 36b. dbQueryLaporan
DECLARE @IdLap36 INT;
SET @IdLap36 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040701');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap36;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap36, 'ds_040701', 'EXEC Sp_ReportOpnamebahan');
GO

-- 36c. dbParameterLaporan
DECLARE @IdLap36b INT;
SET @IdLap36b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040701');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap36b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap36b, 'SReport', 'text', 0),
    (@IdLap36b, 'Ordr', 'text', 0),
    (@IdLap36b, 'tgl1', 'text', 0),
    (@IdLap36b, 'tgl2', 'text', 0),
    (@IdLap36b, 'isiList', 'text', 0),
    (@IdLap36b, 'Needoto', 'text', 0);
GO

-- ============================================================
-- REPORT 37: 040702 -- Laporan Opname Bahan Per Barang
-- ============================================================

-- 37a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040702';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040702', 'Laporan Opname Bahan Per Barang', 1);
GO

-- 37b. dbQueryLaporan
DECLARE @IdLap37 INT;
SET @IdLap37 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040702');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap37;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap37, 'ds_040702', 'EXEC Sp_ReportOpnamebahan');
GO

-- 37c. dbParameterLaporan
DECLARE @IdLap37b INT;
SET @IdLap37b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040702');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap37b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap37b, 'SReport', 'text', 0),
    (@IdLap37b, 'Ordr', 'text', 0),
    (@IdLap37b, 'tgl1', 'text', 0),
    (@IdLap37b, 'tgl2', 'text', 0),
    (@IdLap37b, 'isiList', 'text', 0),
    (@IdLap37b, 'Needoto', 'text', 0);
GO

-- ============================================================
-- REPORT 38: 040801 -- Laporan Opname Barang Per Nobukti
-- ============================================================

-- 38a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040801';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040801', 'Laporan Opname Barang Per Nobukti', 1);
GO

-- 38b. dbQueryLaporan
DECLARE @IdLap38 INT;
SET @IdLap38 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040801');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap38;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap38, 'ds_040801', 'EXEC Sp_ReportOpnameBarang');
GO

-- 38c. dbParameterLaporan
DECLARE @IdLap38b INT;
SET @IdLap38b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040801');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap38b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap38b, 'SReport', 'text', 0),
    (@IdLap38b, 'Ordr', 'text', 0),
    (@IdLap38b, 'tgl1', 'text', 0),
    (@IdLap38b, 'tgl2', 'text', 0),
    (@IdLap38b, 'isiList', 'text', 0),
    (@IdLap38b, 'NeeDoto', 'text', 0);
GO

-- ============================================================
-- REPORT 39: 040802 -- Laporan Opname Barang Per Barang
-- ============================================================

-- 39a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040802';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040802', 'Laporan Opname Barang Per Barang', 1);
GO

-- 39b. dbQueryLaporan
DECLARE @IdLap39 INT;
SET @IdLap39 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040802');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap39;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap39, 'ds_040802', 'EXEC Sp_ReportOpnameBarang');
GO

-- 39c. dbParameterLaporan
DECLARE @IdLap39b INT;
SET @IdLap39b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040802');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap39b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap39b, 'SReport', 'text', 0),
    (@IdLap39b, 'Ordr', 'text', 0),
    (@IdLap39b, 'tgl1', 'text', 0),
    (@IdLap39b, 'tgl2', 'text', 0),
    (@IdLap39b, 'isiList', 'text', 0),
    (@IdLap39b, 'NeeDoto', 'text', 0);
GO

-- ============================================================
-- REPORT 40: 040851 -- Hasil Produksi Per NObukti
-- ============================================================

-- 40a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040851';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040851', 'Hasil Produksi Per NObukti', 1);
GO

-- 40b. dbQueryLaporan
DECLARE @IdLap40 INT;
SET @IdLap40 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040851');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap40;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap40, 'ds_040851', 'EXEC cetakhasilproduksi');
GO

-- 40c. dbParameterLaporan
DECLARE @IdLap40b INT;
SET @IdLap40b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040851');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap40b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap40b, 'NoBukti', 'text', 0);
GO

-- ============================================================
-- REPORT 41: 040852 -- Hasil Produksi Per Barang
-- ============================================================

-- 41a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040852';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040852', 'Hasil Produksi Per Barang', 1);
GO

-- 41b. dbQueryLaporan
DECLARE @IdLap41 INT;
SET @IdLap41 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040852');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap41;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap41, 'ds_040852', 'EXEC cetakhasilproduksi');
GO

-- 41c. dbParameterLaporan
DECLARE @IdLap41b INT;
SET @IdLap41b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040852');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap41b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap41b, 'NoBukti', 'text', 0);
GO

-- ============================================================
-- REPORT 42: 040861 -- Hasil Produksi ACC Per Nobukti
-- ============================================================

-- 42a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040861';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040861', 'Hasil Produksi ACC Per Nobukti', 1);
GO

-- 42b. dbQueryLaporan
DECLARE @IdLap42 INT;
SET @IdLap42 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040861');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap42;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap42, 'ds_040861', 'EXEC cetakhasilproduksi');
GO

-- 42c. dbParameterLaporan
DECLARE @IdLap42b INT;
SET @IdLap42b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040861');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap42b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap42b, 'NoBukti', 'text', 0);
GO

-- ============================================================
-- REPORT 43: 040862 -- Hasil Produksi ACC Per Barang
-- ============================================================

-- 43a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '040862';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('040862', 'Hasil Produksi ACC Per Barang', 1);
GO

-- 43b. dbQueryLaporan
DECLARE @IdLap43 INT;
SET @IdLap43 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040862');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap43;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap43, 'ds_040862', 'EXEC cetakhasilproduksi');
GO

-- 43c. dbParameterLaporan
DECLARE @IdLap43b INT;
SET @IdLap43b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '040862');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap43b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap43b, 'NoBukti', 'text', 0);
GO

-- ============================================================
-- REPORT 44: 050104 -- Stock Akhir Barang Produksi
-- ============================================================

-- 44a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '050104';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('050104', 'Stock Akhir Barang Produksi', 1);
GO

-- 44b. dbQueryLaporan
DECLARE @IdLap44 INT;
SET @IdLap44 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050104');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap44;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap44, 'ds_050104', 'EXEC Sp_ReportStockAkhir');
GO

-- 44c. dbParameterLaporan
DECLARE @IdLap44b INT;
SET @IdLap44b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050104');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap44b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap44b, 'Nosat', 'text', 0),
    (@IdLap44b, 'tanggal', 'text', 0),
    (@IdLap44b, 'KOdegdg', 'text', 0);
GO

-- ============================================================
-- REPORT 45: 050105 -- Stock Fisik Gudang
-- ============================================================

-- 45a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '050105';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('050105', 'Stock Fisik Gudang', 1);
GO

-- 45b. dbQueryLaporan
DECLARE @IdLap45 INT;
SET @IdLap45 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050105');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap45;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap45, 'ds_050105', 'EXEC Sp_ReportStockFisikGudang');
GO

-- 45c. dbParameterLaporan
DECLARE @IdLap45b INT;
SET @IdLap45b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050105');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap45b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap45b, 'tanggal', 'text', 0),
    (@IdLap45b, 'KOdegdg', 'text', 0);
GO

-- ============================================================
-- REPORT 46: 050106 -- Stock Harian
-- ============================================================

-- 46a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '050106';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('050106', 'Stock Harian', 1);
GO

-- 46b. dbQueryLaporan
DECLARE @IdLap46 INT;
SET @IdLap46 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050106');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap46;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap46, 'ds_050106', 'EXEC SP_ReportStockHarian');
GO

-- 46c. dbParameterLaporan
DECLARE @IdLap46b INT;
SET @IdLap46b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050106');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap46b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap46b, 'awal', 'text', 0),
    (@IdLap46b, 'akhir', 'text', 0),
    (@IdLap46b, 'gudang', 'text', 0),
    (@IdLap46b, 'nosat', 'text', 0);
GO

-- ============================================================
-- REPORT 47: 050107 -- Laporan Katalog Barang (Satuan PCS)
-- ============================================================

-- 47a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '050107';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('050107', 'Laporan Katalog Barang (Satuan PCS)', 1);
GO

-- 47b. dbQueryLaporan
DECLARE @IdLap47 INT;
SET @IdLap47 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050107');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap47;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap47, 'ds_050107', 'EXEC Sp_reportStockQtyPCS');
GO

-- 47c. dbParameterLaporan
DECLARE @IdLap47b INT;
SET @IdLap47b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050107');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap47b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap47b, 'Bulan', 'text', 0),
    (@IdLap47b, 'Tahun', 'text', 0),
    (@IdLap47b, 'Kodegdg', 'text', 0),
    (@IdLap47b, 'KodeGrp', 'text', 0);
GO

-- ============================================================
-- REPORT 48: 050201 -- Kartu Stock Qnt
-- ============================================================

-- 48a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '050201';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('050201', 'Kartu Stock Qnt', 1);
GO

-- 48b. dbQueryLaporan
DECLARE @IdLap48 INT;
SET @IdLap48 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050201');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap48;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap48, 'ds_050201', 'EXEC sp_reportkartuStock');
GO

-- 48c. dbParameterLaporan
DECLARE @IdLap48b INT;
SET @IdLap48b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050201');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap48b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap48b, 'kodegdg', 'text', 0),
    (@IdLap48b, 'Kodebrg', 'text', 0),
    (@IdLap48b, 'bulan1', 'text', 0),
    (@IdLap48b, 'bulan2', 'text', 0),
    (@IdLap48b, 'tahun1', 'text', 0),
    (@IdLap48b, 'tahun2', 'text', 0),
    (@IdLap48b, 'periode1', 'text', 0),
    (@IdLap48b, 'periode2', 'text', 0),
    (@IdLap48b, 'Nosat', 'text', 0);
GO

-- ============================================================
-- REPORT 49: 050202 -- Kartu Stock Qnt dan Rupiah
-- ============================================================

-- 49a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '050202';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('050202', 'Kartu Stock Qnt dan Rupiah', 1);
GO

-- 49b. dbQueryLaporan
DECLARE @IdLap49 INT;
SET @IdLap49 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050202');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap49;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap49, 'ds_050202', 'EXEC sp_reportStockQtyRprek');
GO

-- 49c. dbParameterLaporan
DECLARE @IdLap49b INT;
SET @IdLap49b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '050202');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap49b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap49b, 'Bulan', 'text', 0),
    (@IdLap49b, 'Tahun', 'text', 0),
    (@IdLap49b, 'isi', 'text', 0),
    (@IdLap49b, 'Kodegdg', 'text', 0),
    (@IdLap49b, 'KodeGrp', 'text', 0),
    (@IdLap49b, 'minus', 'text', 0),
    (@IdLap49b, 'MinusHPP', 'text', 0),
    (@IdLap49b, 'Qty1', 'text', 0),
    (@IdLap49b, 'Qty2', 'text', 0),
    (@IdLap49b, 'Pilih', 'text', 0),
    (@IdLap49b, 'KodeSubGrp', 'text', 0);
GO

-- ============================================================
-- REPORT 50: 020409 -- History KP
-- ============================================================

-- 50a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020409';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020409', 'History KP', 1);
GO

-- 50b. dbQueryLaporan
DECLARE @IdLap50 INT;
SET @IdLap50 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020409');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap50;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap50, 'ds_020409', 'EXEC Sp_ReportHistoriKP');
GO

-- 50c. dbParameterLaporan
DECLARE @IdLap50b INT;
SET @IdLap50b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020409');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap50b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap50b, 'Tgl1', 'text', 0),
    (@IdLap50b, 'Tgl2', 'text', 0),
    (@IdLap50b, 'isiList', 'text', 0),
    (@IdLap50b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 51: 303322 -- ReportPLInvoice_DPP
-- ============================================================

-- 51a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '303322';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('303322', 'ReportPLInvoice_DPP', 1);
GO

-- 51b. dbQueryLaporan
DECLARE @IdLap51 INT;
SET @IdLap51 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '303322');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap51;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap51, 'ds_303322', 'EXEC Sp_ReportPlInvoicedet');
GO

-- 51c. dbParameterLaporan
DECLARE @IdLap51b INT;
SET @IdLap51b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '303322');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap51b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap51b, 'SReport', 'text', 0),
    (@IdLap51b, 'Ordr', 'text', 0),
    (@IdLap51b, 'tgl1', 'text', 0),
    (@IdLap51b, 'tgl2', 'text', 0),
    (@IdLap51b, 'isiList', 'text', 0);
GO

-- ============================================================
-- REPORT 52: 303242 -- ReportKontrakvsSJ
-- ============================================================

-- 52a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '303242';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('303242', 'ReportKontrakvsSJ', 1);
GO

-- 52b. dbQueryLaporan
DECLARE @IdLap52 INT;
SET @IdLap52 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '303242');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap52;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap52, 'ds_303242', 'EXEC Sp_ReportKontrakVsSJ');
GO

-- 52c. dbParameterLaporan
DECLARE @IdLap52b INT;
SET @IdLap52b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '303242');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap52b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap52b, 'Tgl1', 'text', 0),
    (@IdLap52b, 'Tgl2', 'text', 0),
    (@IdLap52b, 'isiList', 'text', 0),
    (@IdLap52b, 'Id', 'text', 0);
GO

-- ============================================================
-- REPORT 53: 303241 -- ReportKartuProyek (KodeReport 60)
-- ============================================================

-- 53a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '303241';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('303241', 'ReportKartuProyek', 1);
GO

-- 53b. dbQueryLaporan
DECLARE @IdLap53 INT;
SET @IdLap53 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '303241');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap53;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap53, 'ds_303241', 'EXEC Sp_ReportKartuProyek');
GO

-- 53c. dbParameterLaporan
DECLARE @IdLap53b INT;
SET @IdLap53b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '303241');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap53b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap53b, 'Tgl1', 'text', 0),
    (@IdLap53b, 'Tgl2', 'text', 0),
    (@IdLap53b, 'isiList', 'text', 0);
GO

-- ============================================================
-- REPORT 54: 303243 -- ReportKartuProyekBarang
-- ============================================================

-- 54a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '303243';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('303243', 'ReportKartuProyekBarang', 1);
GO

-- 54b. dbQueryLaporan
DECLARE @IdLap54 INT;
SET @IdLap54 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '303243');
-- ============================================================
-- INSERT KODEMENU baru ke DBMENUREPORT (303241, 303242, 303243, 303322)
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '303241')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('303241', 'ReportKartuProyek', 3, '303241');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '303242')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('303242', 'ReportKontrakvsSJ', 3, '303242');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '303243')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('303243', 'ReportKartuProyekBarang', 3, '303243');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '303322')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('303322', 'ReportPLInvoice_DPP', 3, '303322');
GO


DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap54;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap54, 'ds_303243', 'EXEC Sp_ReportKartuProyekBarang');
GO

-- 54c. dbParameterLaporan
DECLARE @IdLap54b INT;
SET @IdLap54b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '303243');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap54b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap54b, 'Tgl1', 'text', 0),
    (@IdLap54b, 'Tgl2', 'text', 0),
    (@IdLap54b, 'isiList', 'text', 0);
GO

-- ============================================================
-- REPORT 55: 020501 -- ReportNeracaLajur
-- ============================================================

-- 55a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020501';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020501', 'ReportNeracaLajur', 1);
GO

-- 55b. dbQueryLaporan
DECLARE @IdLap55 INT;
SET @IdLap55 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020501');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap55;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap55, 'ds_020501', 'EXEC sp_NerajaLajur');
GO

-- 55c. dbParameterLaporan
DECLARE @IdLap55b INT;
SET @IdLap55b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020501');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap55b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap55b, 'Masuk', 'text', 0),
    (@IdLap55b, 'Bulan', 'text', 0),
    (@IdLap55b, 'Tahun', 'text', 0),
    (@IdLap55b, 'Devisi', 'text', 0),
    (@IdLap55b, 'IdUser', 'text', 0);
GO

-- ============================================================
-- REPORT 56: 020504 -- ReportNeraca (Aktiva+Pasiva)
-- ============================================================

-- 56a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020504';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020504', 'ReportNeraca', 1);
GO

-- 56b. dbQueryLaporan (2 SPs: Aktiva + Pasiva)
DECLARE @IdLap56 INT;
SET @IdLap56 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020504');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap56;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap56, 'ds_020504_aktiva', 'EXEC sp_ReportNeracaAktiva'),
    (@IdLap56, 'ds_020504_pasiva', 'EXEC sp_ReportNeracaPasiva');
GO

-- 56c. dbParameterLaporan
DECLARE @IdLap56b INT;
SET @IdLap56b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020504');

-- ============================================================
-- INSERT KODEMENU baru ke DBMENUREPORT
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '020508')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('020508', 'ReportNeracaOld', 3, '020508');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '020509')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('020509', 'Barang_ukuran', 3, '020509');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '020510')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('020510', 'ReportKartuStok1', 3, '020510');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '020511')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('020511', 'ReportCrossCheckBPPB', 3, '020511');
IF NOT EXISTS (SELECT 1 FROM DBMENUREPORT WHERE KODEMENU = '020512')
    INSERT INTO DBMENUREPORT (KODEMENU, Keterangan, L0, ACCESS) VALUES ('020512', 'ReportPerhitunganPoint', 3, '020512');
GO


-- ============================================================
-- REPORT 57: 020508 -- ReportNeracaOld
-- ============================================================

-- 57a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020508';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020508', 'ReportNeracaOld', 1);
GO

-- 57b. dbQueryLaporan (uses 2 datasets: Aktiva + Pasiva from old format)
DECLARE @IdLap57 INT;
SET @IdLap57 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020508');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap57;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap57, 'ds_020508_aktiva', 'EXEC sp_ReportNeracaAktiva'),
    (@IdLap57, 'ds_020508_pasiva', 'EXEC sp_ReportNeracaPasiva');
GO

-- 57c. dbParameterLaporan
DECLARE @IdLap57b INT;
SET @IdLap57b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020508');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap57b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap57b, 'Devisi', 'text', 0),
    (@IdLap57b, 'Bulan', 'text', 0),
    (@IdLap57b, 'Tahun', 'text', 0);
GO

-- ============================================================
-- REPORT 58: 020509 -- Barang_ukuran
-- ============================================================

-- 58a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020509';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020509', 'Barang_ukuran', 1);
GO

-- 58b. dbQueryLaporan
DECLARE @IdLap58 INT;
SET @IdLap58 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020509');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap58;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap58, 'ds_020509', 'EXEC Sp_ReportKartuStock');
GO

-- 58c. dbParameterLaporan
DECLARE @IdLap58b INT;
SET @IdLap58b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020509');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap58b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap58b, 'KodeBrg', 'text', 0),
    (@IdLap58b, 'KodeGdg', 'text', 0),
    (@IdLap58b, 'Bulan1', 'text', 0),
    (@IdLap58b, 'Bulan2', 'text', 0),
    (@IdLap58b, 'Tahun1', 'text', 0),
    (@IdLap58b, 'Tahun2', 'text', 0),
    (@IdLap58b, 'NoSat', 'text', 0);
GO

-- ============================================================
-- REPORT 59: 020510 -- ReportKartuStok1
-- ============================================================

-- 59a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020510';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020510', 'ReportKartuStok1', 1);
GO

-- 59b. dbQueryLaporan
DECLARE @IdLap59 INT;
SET @IdLap59 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020510');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap59;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap59, 'ds_020510', 'EXEC Sp_reportkartuStock');
GO

-- 59c. dbParameterLaporan
DECLARE @IdLap59b INT;
SET @IdLap59b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020510');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap59b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap59b, 'KodeBrg', 'text', 0),
    (@IdLap59b, 'KodeGdg', 'text', 0),
    (@IdLap59b, 'Bulan1', 'text', 0),
    (@IdLap59b, 'Bulan2', 'text', 0),
    (@IdLap59b, 'Tahun1', 'text', 0),
    (@IdLap59b, 'Tahun2', 'text', 0),
    (@IdLap59b, 'NoSat', 'text', 0);
GO

-- ============================================================
-- REPORT 60: 020511 -- ReportCrossCheckBPPB
-- ============================================================

-- 60a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020511';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020511', 'ReportCrossCheckBPPB', 1);
GO

-- 60b. dbQueryLaporan
DECLARE @IdLap60 INT;
SET @IdLap60 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020511');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap60;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap60, 'ds_020511', 'EXEC Sp_reportOutStandingBPPBRek');
GO

-- 60c. dbParameterLaporan
DECLARE @IdLap60b INT;
SET @IdLap60b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020511');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap60b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap60b, 'Choice', 'text', 0),
    (@IdLap60b, 'Tgl1', 'text', 0),
    (@IdLap60b, 'Tgl2', 'text', 0);
GO

-- ============================================================
-- REPORT 61: 020512 -- ReportPerhitunganPoint
-- ============================================================

-- 61a. dbMasterLaporan
DELETE FROM dbMasterLaporan WHERE KODEMENU = '020512';
INSERT INTO dbMasterLaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('020512', 'ReportPerhitunganPoint', 1);
GO

-- 61b. dbQueryLaporan
DECLARE @IdLap61 INT;
SET @IdLap61 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020512');

DELETE FROM dbQueryLaporan WHERE id_laporan = @IdLap61;
INSERT INTO dbQueryLaporan (id_laporan, nama_dataset, query_sumber_data) VALUES
    (@IdLap61, 'ds_020512', 'EXEC Sp_reportDebetnoteDet');
GO

-- 61c. dbParameterLaporan
DECLARE @IdLap61b INT;
SET @IdLap61b = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '020512');

DELETE FROM dbParameterLaporan WHERE id_laporan = @IdLap61b;
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES
    (@IdLap61b, 'KodeCust', 'text', 0),
    (@IdLap61b, 'Tgl1', 'text', 0),
    (@IdLap61b, 'Tgl2', 'text', 0);
GO
