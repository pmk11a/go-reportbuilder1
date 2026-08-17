-- ============================================================
-- Seed: dbKolomLaporan - Column definitions from Delphi reports
-- ============================================================

USE dbbcagroup;
GO

DELETE FROM dbKolomLaporan;
GO

-- Master Perkiraan (101)
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES ((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '101'), 'perkiraan', 'Perkiraan', 'Kode Akun', 0, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '101'), 'perkiraan', 'Keterangan', 'Nama Akun', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '101'), 'perkiraan', 'SaldoAwal', 'Saldo Awal', 2, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '101'), 'perkiraan', 'Debet', 'Debet', 3, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '101'), 'perkiraan', 'Kredit', 'Kredit', 4, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '101'), 'perkiraan', 'SaldoAkhir', 'Saldo Akhir', 5, 'number', 'right', 1, 1);
GO

-- Kas Harian (20101)
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES ((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101'), 'saldo_awal', 'Perkiraan', 'Kode', 0, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101'), 'saldo_awal', 'Keterangan', 'Nama', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101'), 'saldo_awal', 'SaldoAwalRp', 'Saldo Awal', 2, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101'), 'kas_harian', 'Tanggal', 'Tanggal', 0, 'date', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101'), 'kas_harian', 'NoBukti', 'No. Bukti', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101'), 'kas_harian', 'Keterangan', 'Keterangan', 2, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101'), 'kas_harian', 'Debet', 'Debit', 3, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101'), 'kas_harian', 'Kredit', 'Kredit', 4, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101'), 'kas_harian', 'Saldo', 'Saldo', 5, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101'), 'kas_harian', 'Valas', 'Mata Uang', 6, 'text', 'left', 0, 1);
GO

-- Hutang (20301-20305)
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES 
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20301'), 'kartu_hutang', 'Tanggal', 'Tanggal', 0, 'date', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20301'), 'kartu_hutang', 'NoNota', 'No. Nota', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20301'), 'kartu_hutang', 'Supplier', 'Supplier', 2, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20301'), 'kartu_hutang', 'Keterangan', 'Ket', 3, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20301'), 'kartu_hutang', 'Debit', 'Debit', 4, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20301'), 'kartu_hutang', 'Credit', 'Kredit', 5, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20301'), 'kartu_hutang', 'Saldo', 'Saldo', 6, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20301'), 'kartu_hutang', 'Valas', 'Valas', 7, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20302'), 'sisa_hutang', 'Tanggal', 'Tanggal', 0, 'date', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20302'), 'sisa_hutang', 'NoNota', 'No. Nota', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20302'), 'sisa_hutang', 'Supplier', 'Supplier', 2, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20302'), 'sisa_hutang', 'Tagihan', 'Tagihan', 3, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20302'), 'sisa_hutang', 'Terbayar', 'Terbayar', 4, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20302'), 'sisa_hutang', 'Sisa', 'Sisa Tagihan', 5, 'number', 'right', 1, 1);
GO

-- Piutang (20401-20409)
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES 
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20401'), 'kartu_piutang', 'Tanggal', 'Tanggal', 0, 'date', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20401'), 'kartu_piutang', 'NoNota', 'No. Nota', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20401'), 'kartu_piutang', 'Customer', 'Customer', 2, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20401'), 'kartu_piutang', 'Keterangan', 'Ket', 3, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20401'), 'kartu_piutang', 'Debit', 'Debit', 4, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20401'), 'kartu_piutang', 'Credit', 'Kredit', 5, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20401'), 'kartu_piutang', 'Saldo', 'Saldo', 6, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20401'), 'kartu_piutang', 'Valas', 'Valas', 7, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20402'), 'sisa_piutang', 'Tanggal', 'Tanggal', 0, 'date', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20402'), 'sisa_piutang', 'NoNota', 'No. Nota', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20402'), 'sisa_piutang', 'Customer', 'Customer', 2, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20402'), 'sisa_piutang', 'Piutang', 'Piutang', 3, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20402'), 'sisa_piutang', 'Terbayar', 'Terbayar', 4, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20402'), 'sisa_piutang', 'Sisa', 'Sisa Piutang', 5, 'number', 'right', 1, 1);
GO

-- Neraca Lajur (20501)
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES 
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20501'), 'neraca_lajur', 'KodeAkun', 'Kode Akun', 0, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20501'), 'neraca_lajur', 'NamaAkun', 'Nama Akun', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20501'), 'neraca_lajur', 'SaldoAW', 'Saldo AW', 2, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20501'), 'neraca_lajur', 'Debet', 'Debit', 3, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20501'), 'neraca_lajur', 'Kredit', 'Kredit', 4, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20501'), 'neraca_lajur', 'SaldoAkhir', 'Saldo Akhir', 5, 'number', 'right', 1, 1);
GO

-- Laba Rugi (20502)
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES 
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20502'), 'laba_rugi', 'KodeAkun', 'Kode Akun', 0, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20502'), 'laba_rugi', 'NamaAkun', 'Nama Akun', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20502'), 'laba_rugi', 'Debit', 'Debit', 2, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20502'), 'laba_rugi', 'Kredit', 'Kredit', 3, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20502'), 'laba_rugi', 'Saldo', 'Saldo', 4, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20502'), 'laba_rugi', 'Divisi', 'Divisi', 5, 'text', 'left', 0, 1);
GO

-- Neraca (20503)
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES 
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20503'), 'aktiva', 'KodeAkun', 'Kode Akun', 0, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20503'), 'aktiva', 'NamaAkun', 'Nama Akun', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20503'), 'aktiva', 'Debit', 'Debit', 2, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20503'), 'pasiva', 'KodeAkun', 'Kode Akun', 0, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20503'), 'pasiva', 'NamaAkun', 'Nama Akun', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20503'), 'pasiva', 'Credit', 'Kredit', 2, 'number', 'right', 1, 1);
GO

-- Pembelian & Penjualan (301xxx, 302xxx)
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES 
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '301010'), 'penjualan', 'Tanggal', 'Tanggal', 0, 'date', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '301010'), 'penjualan', 'NoBukti', 'No. Bukti', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '301010'), 'penjualan', 'Customer', 'Customer', 2, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '301010'), 'penjualan', 'Keterangan', 'Ket', 3, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '301010'), 'penjualan', 'Jumlah', 'Jumlah', 4, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '301010'), 'penjualan', 'Valas', 'Valas', 5, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '302010'), 'retur_jual', 'Tanggal', 'Tanggal', 0, 'date', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '302010'), 'retur_jual', 'NoBukti', 'No. Bukti', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '302010'), 'retur_jual', 'Customer', 'Customer', 2, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '302010'), 'retur_jual', 'Keterangan', 'Ket', 3, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '302010'), 'retur_jual', 'Jumlah', 'Jumlah', 4, 'number', 'right', 1, 1);
GO

-- Stok (501xx, 502xx)
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES 
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50101'), 'stok', 'Tanggal', 'Tanggal', 0, 'date', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50101'), 'stok', 'KodeBarang', 'Kode Barang', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50101'), 'stok', 'NamaBarang', 'Nama Barang', 2, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50101'), 'stok', 'Gudang', 'Gudang', 3, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50101'), 'stok', 'Satuan', 'Satuan', 4, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50101'), 'stok', 'StokAwal', 'Stok Awal', 5, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50101'), 'stok', 'Masuk', 'Masuk', 6, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50101'), 'stok', 'Keluar', 'Keluar', 7, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50101'), 'stok', 'StokAkhir', 'Stok Akhir', 8, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50201'), 'kartu', 'Tanggal', 'Tanggal', 0, 'date', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50201'), 'kartu', 'KodeBarang', 'Kode Barang', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50201'), 'kartu', 'In', 'Masuk', 2, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50201'), 'kartu', 'Out', 'Keluar', 3, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50201'), 'kartu', 'Saldo', 'Saldo', 4, 'number', 'right', 1, 1);
GO

-- Cash Flow (106)
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES 
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106'), 'cashflow', 'Perkiraan', 'Perkiraan', 0, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106'), 'cashflow', 'Lawan', 'Lawan', 1, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106'), 'cashflow', 'Keterangan', 'Ket', 2, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106'), 'cashflow', 'Kas', 'Kas', 3, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106'), 'cashflow', 'Koreksi', 'Koreksi', 4, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106'), 'cashflow', 'Jumlah', 'Jumlah', 5, 'number', 'right', 1, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106'), 'cashflow', 'Gol', 'Golongan', 6, 'text', 'left', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106'), 'cashflow', 'Urut', 'Urutan', 7, 'number', 'right', 0, 1),
((SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106'), 'cashflow', 'Devisi', 'Divisi', 8, 'text', 'left', 0, 1);
GO

-- Verification
PRINT '';
PRINT '=== VERIFICATION ===';
SELECT COUNT(*) AS TotalColumns FROM dbKolomLaporan;
SELECT TOP 20 id_laporan, nama_dataset, nama_kolom, label_tampil FROM dbKolomLaporan ORDER BY id_laporan, urutan_tampil;
PRINT 'Seed kolom completed!';
GO
-- ============================================================
-- Seed: dbParameterLaporan - Filter parameters from Delphi UI
-- Source: FrmReportPreview.dfm (component names) + .pas (usage)
-- Mapping: TabIndex = dxTabSheet index shown in ShowReportPreview()
-- ============================================================

USE dbbcagroup;
GO

DELETE FROM dbParameterLaporan;
GO

-- Helper: Get report ID from KODEMENU
DECLARE @R1 INT, @R2 INT, @R3 INT, @R4 INT, @R5 INT;

-- ============================================================
-- Kas Harian (20101) - TabIndex 0
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, kode_browse, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, NULL, '{"tabIndex":0}', 0),
(@R1, 'perkiraan', 'Perkiraan', 'browse', 0, NULL, '1101', '{"tabIndex":0}', 1),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, NULL, '{"tabIndex":0}', 2),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, NULL, '{"tabIndex":0}', 3);

-- ============================================================
-- Bank Harian (20102) - TabIndex 0
-- ============================================================
SET @R2 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20102');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, kode_browse, konfigurasi, posisi)
VALUES 
(@R2, 'divisi', 'Divisi', 'text', 0, NULL, NULL, '{"tabIndex":0}', 0),
(@R2, 'perkiraan', 'Perkiraan', 'browse', 0, NULL, '1101', '{"tabIndex":0}', 1),
(@R2, 'tanggal_awal', 'Awal', 'date', 0, NULL, NULL, '{"tabIndex":0}', 2),
(@R2, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, NULL, '{"tabIndex":0}', 3),
(@R2, 'lokasi', 'Lokasi', 'combobox', 0, 'Semua', '{"options":["Surabaya","Gempol","Semua"],"tabIndex":0}', 4),
(@R2, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 5);

-- ============================================================
-- Posisi Bank Kas (20103) - TabIndex 6
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20103');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":6}', 0),
(@R1, 'tanggal', 'Tanggal', 'date', 0, NULL, '{"tabIndex":6}', 1);

-- ============================================================
-- Giro Reports (201071-201085) - TabIndex 0
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '201071');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":0}', 0),
(@R1, 'perkiraan', 'Perkiraan', 'browse', 0, NULL, '1101', '{"tabIndex":0}', 1),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":0}', 2),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":0}', 3),
(@R1, 'lokasi', 'Lokasi', 'combobox', 0, 'Semua', '{"options":["Surabaya","Gempol","Semua"]}', 4);

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '201081');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":0}', 0),
(@R1, 'perkiraan', 'Perkiraan', 'browse', 0, NULL, '1101', '{"tabIndex":0}', 1),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":0}', 2),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":0}', 3);

-- ============================================================
-- Bon Sementara (20109) - TabIndex 0
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20109');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":0}', 0),
(@R1, 'perkiraan', 'Perkiraan', 'browse', 0, NULL, '1101', '{"tabIndex":0}', 1),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":0}', 2),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":0}', 3);
GO

-- ============================================================
-- Jurnal Reports (2020101-2020109) - TabIndex 3
-- ============================================================
DECLARE @JurnalCodes TABLE (KODEMENU NVARCHAR(10));
INSERT INTO @JurnalCodes VALUES ('2020101'),('2020102'),('2020103'),('2020104'),('2020105'),('2020106'),('2020107'),('2020108'),('2020109');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT 
    id_laporan,
    'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":3}', 0
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @JurnalCodes);

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT 
    id_laporan,
    'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":3}', 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @JurnalCodes);

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT 
    id_laporan,
    'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":3}', 2
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @JurnalCodes);

-- ============================================================
-- Buku Tambahan (20202) - TabIndex 13
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20202');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, NULL, 1),
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":13}', 2),
(@R1, 'perkiraan_awal', 'Perkiraan Awal', 'browse', 0, NULL, '1101', 3),
(@R1, 'perkiraan_akhir', 'Perkiraan Akhir', 'browse', 0, NULL, '1101', 4);

-- ============================================================
-- Buku Tambahan Baru (202021) - TabIndex 1
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '202021');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":1}', 0);

-- ============================================================
-- Mutasi (20203) - TabIndex 4
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20203');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, NULL, 1),
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":4}', 2);

-- ============================================================
-- Biaya (20204) - TabIndex 5
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20204');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, NULL, 1),
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":5}', 2),
(@R1, 'perkiraan_awal', 'Perkiraan Awal', 'browse', 0, NULL, '1101', 3),
(@R1, 'perkiraan_akhir', 'Perkiraan Akhir', 'browse', 0, NULL, '1101', 4);
GO

-- ============================================================
-- Biaya Satu Tahun (202041) - TabIndex 14
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '202041');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":14}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, NULL, 1);

-- ============================================================
-- Aktiva (20205) - TabIndex 4
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20205');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, NULL, 1),
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":4}', 2);

-- ============================================================
-- Penyusutan (20206) - TabIndex 4
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20206');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, NULL, 1),
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":4}', 2);

-- ============================================================
-- Kartu Hutang (20301) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20301');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, kode_browse, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, NULL, '{"tabIndex":7}', 0),
(@R1, 'supplier_awal', 'Supplier Awal', 'browse', 0, NULL, '1110', '{"tabIndex":7}', 1),
(@R1, 'supplier_akhir', 'Supplier Akhir', 'browse', 0, NULL, '1110', '{"tabIndex":7}', 2),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":7}', 3),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":7}', 4),
(@R1, 'urut', 'Urut', 'combobox', 0, 'Tanggal', '{"options":["Tanggal","No. Nota"]}', 5),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 6);

-- ============================================================
-- Sisa Hutang (20302) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20302');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'supplier_awal', 'Supplier Awal', 'browse', 0, NULL, '1110', 1),
(@R1, 'supplier_akhir', 'Supplier Akhir', 'browse', 0, NULL, '1110', 2),
(@R1, 'tanggal_akhir', 's/d Tanggal', 'date', 0, NULL, '{"tabIndex":7}', 3),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 4);

-- ============================================================
-- Pelunasan Hutang (20303) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20303');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'supplier_awal', 'Supplier Awal', 'browse', 0, NULL, '1110', 1),
(@R1, 'supplier_akhir', 'Supplier Akhir', 'browse', 0, NULL, '1110', 2),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":7}', 3),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":7}', 4),
(@R1, 'urut', 'Urut', 'combobox', 0, 'Tanggal', '{"options":["Tanggal","No. Nota"]}', 5),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 6);

-- ============================================================
-- Saldo Hutang (20304) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20304');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'perkiraan', 'Perkiraan', 'browse', 0, NULL, '1101', 1),
(@R1, 'supplier_awal', 'Supplier Awal', 'browse', 0, NULL, '1110', 2),
(@R1, 'supplier_akhir', 'Supplier Akhir', 'browse', 0, NULL, '1110', 3),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":7}', 4),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":7}', 5),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 6);
GO

-- ============================================================
-- Umur Hutang (20305) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20305');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'supplier_awal', 'Supplier Awal', 'browse', 0, NULL, '1110', 1),
(@R1, 'supplier_akhir', 'Supplier Akhir', 'browse', 0, NULL, '1110', 2),
(@R1, 'tanggal_akhir', 's/d Tanggal', 'date', 0, NULL, '{"tabIndex":7}', 3),
(@R1, 'urut', 'Urut', 'combobox', 0, 'Tanggal', '{"options":["Tanggal","No. Nota"]}', 4),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 5);

-- ============================================================
-- Kartu Piutang (20401) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20401');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'customer_awal', 'Customer Awal', 'browse', 0, NULL, '1298', 1),
(@R1, 'customer_akhir', 'Customer Akhir', 'browse', 0, NULL, '1298', 2),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":7}', 3),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":7}', 4),
(@R1, 'urut', 'Urut', 'combobox', 0, 'Tanggal', '{"options":["Tanggal","No. Nota"]}', 5),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 6);

-- ============================================================
-- Sisa Piutang (20402) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20402');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'customer_awal', 'Customer Awal', 'browse', 0, NULL, '1298', 1),
(@R1, 'customer_akhir', 'Customer Akhir', 'browse', 0, NULL, '1298', 2),
(@R1, 'tanggal_akhir', 's/d Tanggal', 'date', 0, NULL, '{"tabIndex":7}', 3),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 4);

-- ============================================================
-- Pelunasan Piutang (20403) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20403');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'customer_awal', 'Customer Awal', 'browse', 0, NULL, '1298', 1),
(@R1, 'customer_akhir', 'Customer Akhir', 'browse', 0, NULL, '1298', 2),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":7}', 3),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":7}', 4),
(@R1, 'urut', 'Urut', 'combobox', 0, 'Tanggal', '{"options":["Tanggal","No. Nota"]}', 5),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 6);

-- ============================================================
-- Saldo Piutang (20404) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20404');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'perkiraan', 'Perkiraan', 'browse', 0, NULL, '1101', 1),
(@R1, 'customer_awal', 'Customer Awal', 'browse', 0, NULL, '1298', 2),
(@R1, 'customer_akhir', 'Customer Akhir', 'browse', 0, NULL, '1298', 3),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":7}', 4),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":7}', 5),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 6);

-- ============================================================
-- Saldo Detail Piutang (204041) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '204041');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'customer_awal', 'Customer Awal', 'browse', 0, NULL, '1298', 1),
(@R1, 'customer_akhir', 'Customer Akhir', 'browse', 0, NULL, '1298', 2),
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 3),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, '{"tabIndex":7}', 4),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 5);
GO

-- ============================================================
-- Umur Piutang (20405) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20405');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'customer_awal', 'Customer Awal', 'browse', 0, NULL, '1298', 1),
(@R1, 'customer_akhir', 'Customer Akhir', 'browse', 0, NULL, '1298', 2),
(@R1, 'tanggal_akhir', 's/d Tanggal', 'date', 0, NULL, '{"tabIndex":7}', 3),
(@R1, 'urut', 'Urut', 'combobox', 0, 'Tanggal', '{"options":["Tanggal","No. Nota"]}', 4),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 5);

-- ============================================================
-- Kartu Piutang Detail (20406) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20406');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'customer', 'Customer', 'browse', 1, NULL, '1298', '{"tabIndex":7}', 0),
(@R1, 'tanggal_awal', 'Tanggal Awal', 'date', 0, NULL, '{"tabIndex":7}', 1),
(@R1, 'tanggal_akhir', 'Tanggal Akhir', 'date', 0, NULL, '{"tabIndex":7}', 2);

-- ============================================================
-- Histori Piutang (20409) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20409');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'customer_awal', 'Customer Awal', 'browse', 0, NULL, '1298', 1),
(@R1, 'customer_akhir', 'Customer Akhir', 'browse', 0, NULL, '1298', 2),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":7}', 3),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":7}', 4),
(@R1, 'urut', 'Urut', 'combobox', 0, 'Tanggal', '{"options":["Tanggal","No. Nota"]}', 5),
(@R1, 'valas', 'Valas', 'radiogroup', 0, 'IDR', '{"options":["IDR","USD"]}', 6);

-- ============================================================
-- Neraca Lajur (20501) - TabIndex 2
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20501');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, '{"tabIndex":2}', 1),
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":2}', 2);

-- ============================================================
-- Laba Rugi (20502) - TabIndex 2
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20502');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, '{"tabIndex":2}', 1),
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":2}', 2),
(@R1, 'tipe', 'Tipe', 'combobox', 0, 'LabaRugi', '{"options":["LabaRugi","HPP","Modal"]}', 3),
(@R1, 'pilih_rp', 'Rekognisi', 'combobox', 0, 'Cash', '{"options":["Cash","Accrual"]}', 4);
GO

-- ============================================================
-- Neraca (20503) - TabIndex 2
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20503');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, '{"tabIndex":2}', 1),
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":2}', 2);

-- ============================================================
-- Neraca Penunjang (20504) - TabIndex 2
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20504');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, '{"tabIndex":2}', 1),
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":2}', 2);

-- ============================================================
-- HPP (20505) - TabIndex 2
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20505');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, '{"tabIndex":2}', 1),
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":2}', 2);

-- ============================================================
-- Pembelian Reports (251010-251050) - TabIndex 15
-- ============================================================
DECLARE @BeliCodes TABLE (KODEMENU NVARCHAR(10));
INSERT INTO @BeliCodes VALUES ('251010'),('251020'),('251030'),('251040'),('251050'),('252010'),('252020'),('252030'),('252040'),('252050');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":15}', 0 FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @BeliCodes);

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":15}', 1 FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @BeliCodes);

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":15}', 2 FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @BeliCodes);

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'jenis', 'Jenis', 'combobox', 0, 'Detail', '{"options":["Detail","Rekap"],"tabIndex":15}', 3 FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @BeliCodes);

-- ============================================================
-- Penjualan Reports (301010-301050) - TabIndex 15
-- ============================================================
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":15}', 0 FROM dbMasterLaporan WHERE KODEMENU IN (SELECT KODEMENU FROM dbMasterLaporan WHERE KODEMENU LIKE '301%');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":15}', 1 FROM dbMasterLaporan WHERE KODEMENU IN (SELECT KODEMENU FROM dbMasterLaporan WHERE KODEMENU LIKE '301%');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":15}', 2 FROM dbMasterLaporan WHERE KODEMENU IN (SELECT KODEMENU FROM dbMasterLaporan WHERE KODEMENU LIKE '301%');
GO

-- ============================================================
-- Retur Penjualan (302010-302050) - TabIndex 15
-- ============================================================
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":15}', 0 FROM dbMasterLaporan WHERE KODEMENU IN (SELECT KODEMENU FROM dbMasterLaporan WHERE KODEMENU LIKE '302%');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":15}', 1 FROM dbMasterLaporan WHERE KODEMENU IN (SELECT KODEMENU FROM dbMasterLaporan WHERE KODEMENU LIKE '302%');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":15}', 2 FROM dbMasterLaporan WHERE KODEMENU IN (SELECT KODEMENU FROM dbMasterLaporan WHERE KODEMENU LIKE '302%');

-- ============================================================
-- PR/PO Reports (2530201-2560103) - TabIndex 11
-- ============================================================
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":11}', 0 FROM dbMasterLaporan WHERE KODEMENU IN ('2530201','2530202','2530203');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":11}', 1 FROM dbMasterLaporan WHERE KODEMENU IN ('2530201','2530202','2530203');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":11}', 2 FROM dbMasterLaporan WHERE KODEMENU IN ('2530201','2530202','2530203');

-- PO
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":11}', 0 FROM dbMasterLaporan WHERE KODEMENU IN ('2540201','2540202','2540203');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":11}', 1 FROM dbMasterLaporan WHERE KODEMENU IN ('2540201','2540202','2540203');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":11}', 2 FROM dbMasterLaporan WHERE KODEMENU IN ('2540201','2540202','2540203');

-- Outstanding PO
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":11}', 0 FROM dbMasterLaporan WHERE KODEMENU IN ('2540101','2540102','2540103');

-- ============================================================
-- SO Reports (3030101-3030203) - TabIndex 11
-- ============================================================
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":11}', 0 FROM dbMasterLaporan WHERE KODEMENU IN ('3030101','3030102','3030103');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":11}', 1 FROM dbMasterLaporan WHERE KODEMENU IN ('3030101','3030102','3030103');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'otorisasi', 'Otorisasi', 'combobox', 0, 'Semua', '{"options":["Otorisasi","Non Otorisasi","Semua"],"tabIndex":11}', 2 FROM dbMasterLaporan WHERE KODEMENU IN ('3030101','3030102','3030103');
GO

-- SPP (3031201-3031203)
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":11}', 0 FROM dbMasterLaporan WHERE KODEMENU IN ('3031201','3031202','3031203');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":11}', 1 FROM dbMasterLaporan WHERE KODEMENU IN ('3031201','3031202','3031203');

-- SPB (3032101-3032103)
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":11}', 0 FROM dbMasterLaporan WHERE KODEMENU IN ('3032101','3032102','3032103');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":11}', 1 FROM dbMasterLaporan WHERE KODEMENU IN ('3032101','3032102','3032103');

-- ============================================================
-- CashBack (30314) - TabIndex 11
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '30314');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":11}', 0),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":11}', 1);

-- ============================================================
-- DP by Customer (303321) - TabIndex 11
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '303321');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":11}', 0),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":11}', 1);

-- ============================================================
-- Laba Kotor (303323) - TabIndex 11
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '303323');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":11}', 0),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":11}', 1);

-- ============================================================
-- Komisi Sales (30362) - TabIndex 7
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '30362');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":7}', 0),
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":7}', 1),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":7}', 2);
GO

-- ============================================================
-- SO vs SPK vs Hasil Produksi (303701-303703) - TabIndex 11
-- ============================================================
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":11}', 0 FROM dbMasterLaporan WHERE KODEMENU IN ('303701','303702','303703');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":11}', 1 FROM dbMasterLaporan WHERE KODEMENU IN ('303701','303702','303703');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":11}', 2 FROM dbMasterLaporan WHERE KODEMENU IN ('303701','303702','303703');

-- ============================================================
-- Kontrak vs SJ vs Saku (303801-303803) - TabIndex 11
-- ============================================================
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'divisi', 'Divisi', 'text', 0, NULL, '{"tabIndex":11}', 0 FROM dbMasterLaporan WHERE KODEMENU IN ('303801','303802','303803');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":11}', 1 FROM dbMasterLaporan WHERE KODEMENU IN ('303801','303802','303803');

INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
SELECT id_laporan, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":11}', 2 FROM dbMasterLaporan WHERE KODEMENU IN ('303801','303802','303803');

-- ============================================================
-- Stok (50101) - TabIndex 11
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50101');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, '{"tabIndex":11}', 1),
(@R1, 'gudang', 'Gudang', 'browse', 0, NULL, '1101', 2),
(@R1, 'jenis', 'Jenis', 'combobox', 0, 'Semua', '{"options":["Semua","Sahaja","Cacat"]}', 3);

-- ============================================================
-- Kartu Stock (50201) - TabIndex 11
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50201');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'tanggal_awal', 'Awal', 'date', 0, NULL, '{"tabIndex":11}', 0),
(@R1, 'tanggal_akhir', 'Akhir', 'date', 0, NULL, '{"tabIndex":11}', 1),
(@R1, 'gudang', 'Gudang', 'browse', 0, NULL, '1101', 2),
(@R1, 'barang', 'Barang', 'browse', 0, NULL, '1107', 3);
GO

-- ============================================================
-- Analisa Sales (30351) - TabIndex 11
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '30351');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan', 'Bulan', 'combobox', 0, '1', '{"options":["1","2","3","4","5","6","7","8","9","10","11","12"]}', 0),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, '{"tabIndex":11}', 1);

-- ============================================================
-- Target Sales (30352) - TabIndex 11
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '30352');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, '{"tabIndex":11}', 0);

-- ============================================================
-- Cash Flow (106) - TabIndex 24
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106');
INSERT INTO dbParameterLaporan (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, konfigurasi, posisi)
VALUES 
(@R1, 'bulan_awal', 'Bulan Awal', 'number', 0, '1', '{"tabIndex":24}', 0),
(@R1, 'bulan_akhir', 'Bulan Akhir', 'number', 0, '12', '{"tabIndex":24}', 1),
(@R1, 'tahun', 'Tahun', 'number', 0, NULL, '{"tabIndex":24}', 2);

-- ============================================================
-- Verification
-- ============================================================
PRINT '';
PRINT '=== VERIFICATION ===';
SELECT COUNT(*) AS TotalParameters FROM dbParameterLaporan;
PRINT '';
PRINT 'Parameters by Report:';
SELECT m.KODEMENU, m.nama_laporan, COUNT(p.id_parameter) AS param_count
FROM dbMasterLaporan m
LEFT JOIN dbParameterLaporan p ON m.id_laporan = p.id_laporan
GROUP BY m.KODEMENU, m.nama_laporan
ORDER BY m.KODEMENU;
PRINT '';
PRINT 'Seed parameter completed!';
GO
-- ============================================================
-- Seed: dbGroupLaporan - Grouping configuration per laporan
-- Source: FrmReportPreview.pas + FrxReport structure
-- ============================================================

USE dbbcagroup;
GO

DELETE FROM dbGroupLaporan;
GO

-- ============================================================
-- Master Reports (101-104)
-- ============================================================
DECLARE @R1 INT, @R2 INT, @R3 INT, @R4 INT, @R5 INT;

-- 101 - Daftar Perkiraan
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '101');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Tipe', '', 'Perkiraan Aktiva', 0, 1, 'default', '{"auto_sum":"Debet,Kredit,SaldoAkhir"}'),
(@R1, 1, 'Tipe', 'K', 'Perkiraan Kewajiban', 1, 1, 'default', '{"auto_sum":"Debet,Kredit,SaldoAkhir"}'),
(@R1, 1, 'Tipe', 'M', 'Perkiraan Modal', 2, 1, 'default', '{"auto_sum":"Debet,Kredit,SaldoAkhir"}'),
(@R1, 1, 'Tipe', 'R', 'Perkiraan Pendapatan', 3, 1, 'default', '{"auto_sum":"Debet,Kredit"}'),
(@R1, 1, 'Tipe', 'B', 'Perkiraan Beban', 4, 1, 'default', '{"auto_sum":"Debet,Kredit"}');
GO

-- 102 - Daftar Neraca
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '102');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Kelompok', '1', 'Aktiva Lancar', 0, 1, 'default', '{"auto_sum":"Debet,Kredit"}'),
(@R1, 1, 'Kelompok', '2', 'Aktiva Tidak Lancar', 1, 1, 'default', '{"auto_sum":"Debet,Kredit"}'),
(@R1, 1, 'Kelompok', '3', 'Kewajiban Lancar', 2, 1, 'default', '{"auto_sum":"Debet,Kredit"}'),
(@R1, 1, 'Kelompok', '4', 'Kewajiban Tidak Lancar', 3, 1, 'default', '{"auto_sum":"Debet,Kredit"}'),
(@R1, 1, 'Kelompok', '5', 'Modal', 4, 1, 'default', '{"auto_sum":"Debet,Kredit"}');
GO

-- 103 - Daftar Laba Rugi
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '103');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Kelompok', '1', 'Pendapatan', 0, 1, 'default', '{"auto_sum":"Debit,Kredit"}'),
(@R1, 1, 'Kelompok', '2', 'Harga Pokok Penjualan', 1, 1, 'default', '{"auto_sum":"Debit,Kredit"}'),
(@R1, 1, 'Kelompok', '3', 'Beban Usaha', 2, 1, 'default', '{"auto_sum":"Debit,Kredit"}'),
(@R1, 1, 'Kelompok', '4', 'Beban Lain-lain', 3, 1, 'default', '{"auto_sum":"Debit,Kredit"}');
GO

-- 104 - Daftar HPP
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '104');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Kelompok', '2', 'Harga Pokok', 0, 1, 'default', '{"auto_sum":"Jumlah"}');
GO

-- ============================================================
-- Kas & Bank Reports (20101, 20102)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Perkiraan', '', 'Sub Total per Perkiraan', 0, 1, 'default', '{"auto_sum":"Debit,Kredit,Saldo"}'),
(@R1, 2, 'Tanggal', '', 'Sub Total per Tanggal', 1, 1, 'default', '{"auto_sum":"Debit,Kredit"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20102');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Perkiraan', '', 'Sub Total per Perkiraan', 0, 1, 'default', '{"auto_sum":"Debit,Kredit,Saldo"}'),
(@R1, 2, 'Tanggal', '', 'Sub Total per Tanggal', 1, 1, 'default', '{"auto_sum":"Debit,Kredit"}');
GO

-- ============================================================
-- Hutang Reports (20301-20305)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20301');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Supplier', '', 'Sub Total per Supplier', 0, 1, 'default', '{"auto_sum":"Debit,Kredit,Saldo"}'),
(@R1, 2, 'Tanggal', '', 'Sub Total per Tanggal', 1, 1, 'default', '{"auto_sum":"Debit,Kredit"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20302');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Supplier', '', 'Sub Total per Supplier', 0, 1, 'default', '{"auto_sum":"Tagihan,Terbayar,Sisa"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20303');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Supplier', '', 'Sub Total per Supplier', 0, 1, 'default', '{"auto_sum":"Debit,Kredit"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20304');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Perkiraan', '', 'Sub Total per Perkiraan', 0, 1, 'default', '{"auto_sum":"Saldo"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20305');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Ageing', '0-30', 'Umur 0-30 Hari', 0, 1, 'ageing', '{"age_buckets":["0-30","31-60","61-90","91-120",">120"]}'),
(@R1, 1, 'Ageing', '31-60', 'Umur 31-60 Hari', 1, 1, 'ageing', '{"age_buckets":["0-30","31-60","61-90","91-120",">120"]}'),
(@R1, 1, 'Ageing', '61-90', 'Umur 61-90 Hari', 2, 1, 'ageing', '{"age_buckets":["0-30","31-60","61-90","91-120",">120"]}'),
(@R1, 1, 'Ageing', '91-120', 'Umur 91-120 Hari', 3, 1, 'ageing', '{"age_buckets":["0-30","31-60","61-90","91-120",">120"]}'),
(@R1, 1, 'Ageing', '121+', 'Umur >120 Hari', 4, 1, 'ageing', '{"age_buckets":["0-30","31-60","61-90","91-120",">120"]}');
GO

-- ============================================================
-- Piutang Reports (20401-20409)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20401');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Customer', '', 'Sub Total per Customer', 0, 1, 'default', '{"auto_sum":"Debit,Kredit,Saldo"}'),
(@R1, 2, 'Tanggal', '', 'Sub Total per Tanggal', 1, 1, 'default', '{"auto_sum":"Debit,Kredit"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20402');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Customer', '', 'Sub Total per Customer', 0, 1, 'default', '{"auto_sum":"Piutang,Terbayar,Sisa"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20403');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Customer', '', 'Sub Total per Customer', 0, 1, 'default', '{"auto_sum":"Debit,Kredit"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20404');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Perkiraan', '', 'Sub Total per Perkiraan', 0, 1, 'default', '{"auto_sum":"Saldo"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20405');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Ageing', '0-30', 'Umur 0-30 Hari', 0, 1, 'ageing', '{"age_buckets":["0-30","31-60","61-90","91-120",">120"]}'),
(@R1, 1, 'Ageing', '31-60', 'Umur 31-60 Hari', 1, 1, 'ageing', '{"age_buckets":["0-30","31-60","61-90","91-120",">120"]}'),
(@R1, 1, 'Ageing', '61-90', 'Umur 61-90 Hari', 2, 1, 'ageing', '{"age_buckets":["0-30","31-60","61-90","91-120",">120"]}'),
(@R1, 1, 'Ageing', '91-120', 'Umur 91-120 Hari', 3, 1, 'ageing', '{"age_buckets":["0-30","31-60","61-90","91-120",">120"]}'),
(@R1, 1, 'Ageing', '121+', 'Umur >120 Hari', 4, 1, 'ageing', '{"age_buckets":["0-30","31-60","61-90","91-120",">120"]}');
GO

-- ============================================================
-- Neraca Lajur (20501)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20501');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Kelompok', '1', 'Aktiva Lancar', 0, 1, 'default', '{"auto_sum":"Debit,Kredit,Saldo"}'),
(@R1, 1, 'Kelompok', '2', 'Aktiva Tetap', 1, 1, 'default', '{"auto_sum":"Debit,Kredit,Saldo"}'),
(@R1, 1, 'Kelompok', '3', 'Kewajiban Lancar', 2, 1, 'default', '{"auto_sum":"Debit,Kredit,Saldo"}'),
(@R1, 1, 'Kelompok', '4', 'Kewajiban Jangka Panjang', 3, 1, 'default', '{"auto_sum":"Debit,Kredit,Saldo"}'),
(@R1, 1, 'Kelompok', '5', 'Modal', 4, 1, 'default', '{"auto_sum":"Debit,Kredit,Saldo"}');
GO

-- ============================================================
-- Laba Rugi (20502)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20502');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Kelompok', '1', 'Pendapatan', 0, 1, 'default', '{"auto_sum":"Debit,Kredit"}'),
(@R1, 1, 'Kelompok', '2', 'Harga Pokok', 1, 1, 'default', '{"auto_sum":"Debit,Kredit"}'),
(@R1, 1, 'Kelompok', '3', 'Beban Usaha', 2, 1, 'default', '{"auto_sum":"Debit,Kredit"}'),
(@R1, 1, 'Kelompok', '4', 'Beban Lain-lain', 3, 1, 'default', '{"auto_sum":"Debit,Kredit"}');
GO

-- ============================================================
-- Neraca (20503)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20503');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Kelompok', '1', 'Aktiva Lancar', 0, 1, 'default', '{"auto_sum":"Debit,Kredit"}'),
(@R1, 1, 'Kelompok', '2', 'Aktiva Tetap', 1, 1, 'default', '{"auto_sum":"Debit,Kredit"}'),
(@R1, 1, 'Kelompok', '3', 'Kewajiban Lancar', 2, 1, 'default', '{"auto_sum":"Debit,Kredit"}'),
(@R1, 1, 'Kelompok', '4', 'Kewajiban Jangka Panjang', 3, 1, 'default', '{"auto_sum":"Debit,Kredit"}'),
(@R1, 1, 'Kelompok', '5', 'Modal', 4, 1, 'default', '{"auto_sum":"Debit,Kredit"}');
GO

-- ============================================================
-- Pembelian (251xxx)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '251010');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Supplier', '', 'Sub Total per Supplier', 0, 1, 'default', '{"auto_sum":"Jumlah"}'),
(@R1, 2, 'Tanggal', '', 'Sub Total per Tanggal', 1, 1, 'default', '{"auto_sum":"Jumlah"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '251020');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Supplier', '', 'Sub Total per Supplier', 0, 1, 'default', '{"auto_sum":"Jumlah"}');
GO

-- ============================================================
-- Penjualan (301xxx)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '301010');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Customer', '', 'Sub Total per Customer', 0, 1, 'default', '{"auto_sum":"Jumlah"}'),
(@R1, 2, 'Tanggal', '', 'Sub Total per Tanggal', 1, 1, 'default', '{"auto_sum":"Jumlah"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '301020');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Customer', '', 'Sub Total per Customer', 0, 1, 'default', '{"auto_sum":"Jumlah"}');
GO

-- ============================================================
-- Stok Reports (50101, 50201)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50101');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Gudang', '', 'Sub Total per Gudang', 0, 1, 'default', '{"auto_sum":"StokAwal,Masuk,Keluar,StokAkhir"}'),
(@R1, 2, 'KodeGrp', '', 'Sub Total per Kelompok', 1, 1, 'default', '{"auto_sum":"StokAwal,Masuk,Keluar,StokAkhir"}');
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '50201');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Gudang', '', 'Sub Total per Gudang', 0, 1, 'default', '{"auto_sum":"In,Out,Saldo"}'),
(@R1, 2, 'KodeGrp', '', 'Sub Total per Kelompok', 1, 1, 'default', '{"auto_sum":"In,Out,Saldo"}');
GO

-- ============================================================
-- Cash Flow (106)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Gol', '', 'Sub Total per Golongan', 0, 1, 'default', '{"auto_sum":"Kas,Koreksi,Jumlah"}'),
(@R1, 2, 'Devisi', '', 'Sub Total per Divisi', 1, 1, 'default', '{"auto_sum":"Kas,Koreksi,Jumlah"}');
GO

-- ============================================================
-- Buku Tambahan (20202)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20202');
INSERT INTO dbGroupLaporan (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES 
(@R1, 1, 'Perkiraan', '', 'Sub Total per Perkiraan', 0, 1, 'default', '{"auto_sum":"Debit,Kredit,Saldo"}'),
(@R1, 2, 'Tanggal', '', 'Sub Total per Tanggal', 1, 1, 'default', '{"auto_sum":"Debit,Kredit"}');
GO

-- ============================================================
-- Verification
-- ============================================================
PRINT '';
PRINT '=== VERIFICATION ===';
SELECT COUNT(*) AS TotalGroups FROM dbGroupLaporan;
PRINT '';
PRINT 'Groups by Report:';
SELECT m.KODEMENU, m.nama_laporan, g.group_level, g.group_field, g.label
FROM dbMasterLaporan m
JOIN dbGroupLaporan g ON m.id_laporan = g.id_laporan
ORDER BY m.KODEMENU, g.group_level, g.sort_order;
PRINT '';
PRINT 'Seed group completed!';
GO
-- ============================================================
-- Seed: dbLabelGrup - Global Label Mapping
-- Source: Field values from GroupLaporan configurations
-- ============================================================

USE dbbcagroup;
GO

DELETE FROM dbLabelGrup;
GO

-- ============================================================
-- 1. Tipe Akun (Field: Tipe)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('Tipe', 'A', 'Aktiva', 1, 1),
('Tipe', 'K', 'Kewajiban', 2, 1),
('Tipe', 'M', 'Modal', 3, 1),
('Tipe', 'R', 'Pendapatan', 4, 1),
('Tipe', 'B', 'Beban', 5, 1);
GO

-- ============================================================
-- 2. Kelompok Akun (Field: Kelompok)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('Kelompok', '1', 'Aktiva Lancar', 1, 1),
('Kelompok', '2', 'Aktiva Tetap', 2, 1),
('Kelompok', '3', 'Aktiva Tidak Lancar', 3, 1),
('Kelompok', '4', 'Kewajiban Lancar', 4, 1),
('Kelompok', '5', 'Kewajiban Jangka Panjang', 5, 1),
('Kelompok', '6', 'Modal', 6, 1),
('Kelompok', '7', 'Pendapatan Operasional', 7, 1),
('Kelompok', '8', 'Harga Pokok Penjualan', 8, 1),
('Kelompok', '9', 'Beban Usaha', 9, 1),
('Kelompok', '10', 'Lain-lain', 10, 1);
GO

-- ============================================================
-- 3. Golongan Cash Flow (Field: Gol)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('Gol', 'A', 'Arus Kas Operasional', 1, 1),
('Gol', 'B', 'Arus Kas Investasi', 2, 1),
('Gol', 'C', 'Arus Kas Pendanaan', 3, 1),
('Gol', 'D', 'Kenaikan/Suran Kas', 4, 1),
('Gol', 'E', 'Saldo Kas Awal', 5, 1),
('Gol', 'F', 'Saldo Kas Akhir', 6, 1);
GO

-- ============================================================
-- 4. Valas (Field: Valas)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('Valas', 'IDR', 'Rupiah', 1, 1),
('Valas', 'USD', 'Dollar', 2, 1),
('Valas', 'EUR', 'Euro', 3, 1),
('Valas', 'SGD', 'Singapura', 4, 1),
('Valas', 'CNY', 'Yuan', 5, 1);
GO

-- ============================================================
-- 5. Ageing Buckets (Field: Ageing)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('Ageing', '0-30', '0-30 Hari', 1, 1),
('Ageing', '31-60', '31-60 Hari', 2, 1),
('Ageing', '61-90', '61-90 Hari', 3, 1),
('Ageing', '91-120', '91-120 Hari', 4, 1),
('Ageing', '121+', 'Lebih dari 120 Hari', 5, 1);
GO

-- ============================================================
-- 6. Periode (Field: Periode)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('Periode', 'Jan', 'Januari', 1, 1),
('Periode', 'Feb', 'Februari', 2, 1),
('Periode', 'Mar', 'Maret', 3, 1),
('Periode', 'Apr', 'April', 4, 1),
('Periode', 'Mei', 'Mei', 5, 1),
('Periode', 'Jun', 'Juni', 6, 1),
('Periode', 'Jul', 'Juli', 7, 1),
('Periode', 'Ags', 'Agustus', 8, 1),
('Periode', 'Sep', 'September', 9, 1),
('Periode', 'Okt', 'Oktober', 10, 1),
('Periode', 'Nov', 'November', 11, 1),
('Periode', 'Des', 'Desember', 12, 1);
GO

-- ============================================================
-- 7. Jenis Transaksi (Field: Jenis)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('Jenis', 'Detail', 'Detail', 1, 1),
('Jenis', 'Rekap', 'Rekapitulasi', 2, 1),
('Jenis', 'Total', 'Total', 3, 1);
GO

-- ============================================================
-- 8. Tipe Laporan (Field: TipeLaporan)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('TipeLaporan', 'LabaRugi', 'Laba Rugi', 1, 1),
('TipeLaporan', 'HPP', 'Harga Pokok Penjualan', 2, 1),
('TipeLaporan', 'Modal', 'Perubahan Modal', 3, 1),
('TipeLaporan', 'Neraca', 'Neraca', 4, 1);
GO

-- ============================================================
-- 9. Status Otorisasi (Field: Otorisasi)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('Otorisasi', '1', 'Otorisasi', 1, 1),
('Otorisasi', '0', 'Non Otorisasi', 2, 1),
('Otorisasi', 'All', 'Semua', 3, 1);
GO

-- ============================================================
-- 10. Gudang (Field: Gudang - sample codes)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('Gudang', 'SGA', 'Gudang Surabaya A', 1, 1),
('Gudang', 'SGP', 'Gudang Surabaya P', 2, 1),
('Gudang', 'GEM', 'Gudang Gempol', 3, 1),
('Gudang', 'JKT', 'Gudang Jakarta', 4, 1),
('Gudang', 'SBY', 'Gudang Semarang', 5, 1);
GO

-- ============================================================
-- 11. Satuan (Field: Satuan)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('Satuan', 'PCS', 'Pcs', 1, 1),
('Satuan', 'SET', 'Set', 2, 1),
('Satuan', 'BOX', 'Box', 3, 1),
('Satuan', 'LBR', 'Lembar', 4, 1),
('Satuan', 'KG', 'Kg', 5, 1),
('Satuan', 'M', 'Meter', 6, 1),
('Satuan', 'UNIT', 'Unit', 7, 1),
('Satuan', 'ROLL', 'Roll', 8, 1),
('Satuan', 'BTL', 'Botol', 9, 1),
('Satuan', 'DUS', 'Dus', 10, 1);
GO

-- ============================================================
-- 12. Tipe Bayar (Field: TipeBayar)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('TipeBayar', 'Tunai', 'Tunai', 1, 1),
('TipeBayar', 'Bank', 'Bank', 2, 1),
('TipeBayar', 'Giro', 'Giro', 3, 1),
('TipeBayar', 'Debit', 'Debit', 4, 1),
('TipeBayar', 'Credit', 'Credit', 5, 1);
GO

-- ============================================================
-- 13. Status Stok (Field: StatusStok)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('StatusStok', 'Normal', 'Normal', 1, 1),
('StatusStok', 'Cacat', 'Cacat', 2, 1),
('StatusStok', 'Sahaja', 'Sahaja', 3, 1);
GO

-- ============================================================
-- 14. Rekening (Field: Rekening)
-- ============================================================
INSERT INTO dbLabelGrup (field_name, field_value, label, sort_order, aktif)
VALUES 
('Rekening', 'Aktiva', 'Aktiva', 1, 1),
('Rekening', 'Pasiva', 'Pasiva', 2, 1),
('Rekening', 'LabaRugi', 'Laba Rugi', 3, 1);
GO

-- ============================================================
-- Verification
-- ============================================================
PRINT '';
PRINT '=== VERIFICATION ===';
SELECT COUNT(*) AS TotalLabels FROM dbLabelGrup;
PRINT '';
PRINT 'Labels by Field:';
SELECT field_name, COUNT(*) AS count, MIN(label) AS sample_label
FROM dbLabelGrup
GROUP BY field_name
ORDER BY field_name;
PRINT '';
PRINT 'All Labels:';
SELECT id, field_name, field_value, label, sort_order
FROM dbLabelGrup
ORDER BY field_name, sort_order;
PRINT '';
PRINT 'Seed label completed!';
GO
-- ============================================================
-- Seed: dbKomponenLaporan - Layout components from FastReports
-- Source: .fr3 file structure analysis
-- ============================================================

USE dbbcagroup;
GO

DELETE FROM dbKomponenLaporan;
GO

-- ============================================================
-- Template Component JSON Structure
-- Each report gets standard bands: Title, PageHeader, MasterData, GroupHeader, Footer, PageFooter
-- ============================================================

-- ============================================================
-- Kas Harian (20101)
-- ============================================================
DECLARE @R1 INT;
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20101');

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
VALUES 
(@R1, 'TitleBand', '{"type":"title","enabled":true,"content":"LAPORAN KAS HARIAN","align":"center","fontSize":14,"bold":true}', 1, 1),
(@R1, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["tanggal","divisi"],"showPageNumber":true,"showDate":true}', 2, 1),
(@R1, 'MasterDataBand', '{"type":"masterdata","dataset":"kas_harian","columns":["Tanggal","NoBukti","Keterangan","Debit","Kredit","Saldo"],"pageSize":"A4"}', 3, 1),
(@R1, 'GroupHeaderBand', '{"type":"groupheader","groupField":"Perkiraan","showLine":true}', 4, 1),
(@R1, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Debit","label":"Total Debit"},{"field":"Kredit","label":"Total Kredit"},{"field":"Saldo","label":"Saldo Akhir"}]}', 5, 1),
(@R1, 'PageFooterBand', '{"type":"pagefooter","showSignature":true,"signatures":[{"label":"Kasir","position":"left"},{"label":"Manager","position":"right"}],"showPageNumber":true}', 6, 1);
GO

-- ============================================================
-- Bank Harian (20102)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20102');
INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
VALUES 
(@R1, 'TitleBand', '{"type":"title","enabled":true,"content":"LAPORAN BANK HARIAN","align":"center","fontSize":14,"bold":true}', 1, 1),
(@R1, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["tanggal","divisi","lokasi"],"showPageNumber":true,"showDate":true}', 2, 1),
(@R1, 'MasterDataBand', '{"type":"masterdata","dataset":"bank_harian","columns":["Tanggal","NoBukti","Keterangan","Debit","Kredit","Saldo"],"pageSize":"A4"}', 3, 1),
(@R1, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Debit","label":"Total Debit"},{"field":"Kredit","label":"Total Kredit"},{"field":"Saldo","label":"Saldo Akhir"}]}', 4, 1),
(@R1, 'PageFooterBand', '{"type":"pagefooter","showSignature":true,"signatures":[{"label":"Teller","position":"left"},{"label":"Admin","position":"center"},{"label":"Manager","position":"right"}],"showPageNumber":true}', 5, 1);
GO

-- ============================================================
-- Posisi Bank Kas (20103)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20103');
INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
VALUES 
(@R1, 'TitleBand', '{"type":"title","enabled":true,"content":"POSISI BANK & KAS","align":"center","fontSize":14,"bold":true}', 1, 1),
(@R1, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["tanggal"],"showPageNumber":true,"showDate":true}', 2, 1),
(@R1, 'MasterDataBand', '{"type":"masterdata","dataset":"posisi_bank","columns":["Perkiraan","Nama","Debit","Kredit","Saldo"],"pageSize":"A4"}', 3, 1),
(@R1, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Debit","label":"Total Debit"},{"field":"Kredit","label":"Total Kredit"},{"field":"Saldo","label":"Saldo Akhir"}]}', 4, 1);
GO

-- ============================================================
-- Giro Reports (201071-201085)
-- ============================================================
DECLARE @GiroCodes TABLE (KODEMENU NVARCHAR(10));
INSERT INTO @GiroCodes VALUES ('201071'),('201072'),('201073'),('201074'),('201075'),('201081'),('201082'),('201083'),('201084'),('201085');

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'TitleBand', '{"type":"title","enabled":true,"content":"LAPORAN GIRO","align":"center","fontSize":14,"bold":true}', 1, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @GiroCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'MasterDataBand', '{"type":"masterdata","dataset":"giro","columns":["Tanggal","NoBukti","Perkiraan","Keterangan","Jumlah"],"pageSize":"A4"}', 2, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @GiroCodes);
GO

-- ============================================================
-- Bon Sementara (20109)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20109');
INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
VALUES 
(@R1, 'TitleBand', '{"type":"title","enabled":true,"content":"BON SEMENTARA","align":"center","fontSize":14,"bold":true}', 1, 1),
(@R1, 'MasterDataBand', '{"type":"masterdata","dataset":"bon","columns":["Tanggal","NoBukti","Keterangan","Jumlah"],"pageSize":"A4"}', 2, 1),
(@R1, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Jumlah","label":"Total"}]}', 3, 1);
GO

-- ============================================================
-- Jurnal Reports (2020101-2020109)
-- ============================================================
DECLARE @JurnalCodes TABLE (KODEMENU NVARCHAR(10));
INSERT INTO @JurnalCodes VALUES ('2020101'),('2020102'),('2020103'),('2020104'),('2020105'),('2020106'),('2020107'),('2020108'),('2020109');

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'TitleBand', '{"type":"title","enabled":true,"content":"LAPORAN JURNAL","align":"center","fontSize":14,"bold":true}', 1, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @JurnalCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["tanggal_awal","tanggal_akhir","divisi"],"showPageNumber":true}', 2, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @JurnalCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'MasterDataBand', '{"type":"masterdata","dataset":"jurnal","columns":["Tanggal","NoBukti","Perkiraan","Keterangan","Debet","Kredit"],"pageSize":"A4"}', 3, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @JurnalCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Debet","label":"Total Debit"},{"field":"Kredit","label":"Total Kredit"}]}', 4, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @JurnalCodes);
GO

-- ============================================================
-- Buku Tambahan (20202, 202021)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '20202');
INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
VALUES 
(@R1, 'TitleBand', '{"type":"title","enabled":true,"content":"BUKU BESAR","align":"center","fontSize":14,"bold":true}', 1, 1),
(@R1, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["bulan","tahun","divisi","perkiraan"],"showPageNumber":true}', 2, 1),
(@R1, 'MasterDataBand', '{"type":"masterdata","dataset":"generate","columns":["Tanggal","NoBukti","Keterangan","Debit","Kredit","Saldo"],"pageSize":"A4"}', 3, 1),
(@R1, 'GroupHeaderBand', '{"type":"groupheader","groupField":"Perkiraan","showSubtotal":true}', 4, 1),
(@R1, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Debit","label":"Total Debit"},{"field":"Kredit","label":"Total Kredit"},{"field":"Saldo","label":"Saldo Akhir"}]}', 5, 1);
GO

SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '202021');
INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
VALUES 
(@R1, 'TitleBand', '{"type":"title","enabled":true,"content":"BUKU BESAR BARU","align":"center","fontSize":14,"bold":true}', 1, 1),
(@R1, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["divisi"],"showPageNumber":true}', 2, 1),
(@R1, 'MasterDataBand', '{"type":"masterdata","dataset":"generate","columns":["Tanggal","NoBukti","Keterangan","Debit","Kredit","Saldo"],"pageSize":"A4"}', 3, 1),
(@R1, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Debit","label":"Total Debit"},{"field":"Kredit","label":"Total Kredit"},{"field":"Saldo","label":"Saldo Akhir"}]}', 4, 1);
GO

-- ============================================================
-- Hutang Reports (20301-20305)
-- ============================================================
DECLARE @HutangCodes TABLE (KODEMENU NVARCHAR(10));
INSERT INTO @HutangCodes VALUES ('20301'),('20302'),('20303'),('20304'),('20305');

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'TitleBand', '{"type":"title","enabled":true,"content":"LAPORAN HUTANG","align":"center","fontSize":14,"bold":true}', 1, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @HutangCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["tanggal_awal","tanggal_akhir","supplier","valas"],"showPageNumber":true}', 2, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @HutangCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'MasterDataBand', '{"type":"masterdata","dataset":"kartu_hutang","columns":["Tanggal","NoNota","Supplier","Keterangan","Debit","Kredit","Saldo"],"pageSize":"A4"}', 3, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @HutangCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Debit","label":"Total Debit"},{"field":"Kredit","label":"Total Kredit"},{"field":"Saldo","label":"Total Saldo"}]}', 4, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @HutangCodes);
GO

-- ============================================================
-- Piutang Reports (20401-20409)
-- ============================================================
DECLARE @PiutangCodes TABLE (KODEMENU NVARCHAR(10));
INSERT INTO @PiutangCodes VALUES ('20401'),('20402'),('20403'),('20404'),('204041'),('20405'),('20406'),('20409');

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'TitleBand', '{"type":"title","enabled":true,"content":"LAPORAN PIUTANG","align":"center","fontSize":14,"bold":true}", 1, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @PiutangCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["tanggal_awal","tanggal_akhir","customer","valas"],"showPageNumber":true}', 2, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @PiutangCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'MasterDataBand', '{"type":"masterdata","dataset":"kartu_piutang","columns":["Tanggal","NoNota","Customer","Keterangan","Debit","Kredit","Saldo"],"pageSize":"A4"}', 3, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @PiutangCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Debit","label":"Total Debit"},{"field":"Kredit","label":"Total Kredit"},{"field":"Saldo","label":"Total Saldo"}]}', 4, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @PiutangCodes);
GO

-- ============================================================
-- Neraca & Laba Rugi (20501-20505)
-- ============================================================
DECLARE @NeracaCodes TABLE (KODEMENU NVARCHAR(10));
INSERT INTO @NeracaCodes VALUES ('20501'),('20502'),('20503'),('20504'),('20505');

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'TitleBand', '{"type":"title","enabled":true,"content":"LAPORAN KEUANGAN","align":"center","fontSize":14,"bold":true}', 1, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @NeracaCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["bulan","tahun","divisi"],"showPageNumber":true}', 2, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @NeracaCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'MasterDataBand', '{"type":"masterdata","dataset":"neraca","columns":["KodeAkun","NamaAkun","Debit","Kredit","Saldo"],"pageSize":"A4"}', 3, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @NeracaCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Debit","label":"Total Debit"},{"field":"Kredit","label":"Total Kredit"},{"field":"Saldo","label":"Total Saldo"}]}', 4, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @NeracaCodes);
GO

-- ============================================================
-- Pembelian (251xxx, 252xxx)
-- ============================================================
DECLARE @BeliCodes TABLE (KODEMENU NVARCHAR(10));
INSERT INTO @BeliCodes VALUES ('251010'),('251020'),('251030'),('251040'),('251050'),('252010'),('252020'),('252030'),('252040'),('252050');

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'TitleBand', '{"type":"title","enabled":true,"content":"LAPORAN PEMBELIAN","align":"center","fontSize":14,"bold":true}', 1, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @BeliCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["tanggal_awal","tanggal_akhir","divisi"],"showPageNumber":true}', 2, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @BeliCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'MasterDataBand', '{"type":"masterdata","dataset":"pembelian","columns":["Tanggal","NoBukti","Supplier","Keterangan","Jumlah","Valas"],"pageSize":"A4"}', 3, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @BeliCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Jumlah","label":"Total"}]}', 4, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @BeliCodes);
GO

-- ============================================================
-- Penjualan (301xxx, 302xxx)
-- ============================================================
DECLARE @JualCodes TABLE (KODEMENU NVARCHAR(10));
INSERT INTO @JualCodes VALUES ('301010'),('301020'),('301030'),('301040'),('301050'),('302010'),('302020'),('302030'),('302040'),('302050');

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'TitleBand', '{"type":"title","enabled":true,"content":"LAPORAN PENJUALAN","align":"center","fontSize":14,"bold":true}', 1, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @JualCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["tanggal_awal","tanggal_akhir","divisi"],"showPageNumber":true}', 2, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @JualCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'MasterDataBand', '{"type":"masterdata","dataset":"penjualan","columns":["Tanggal","NoBukti","Customer","Keterangan","Jumlah","Valas"],"pageSize":"A4"}', 3, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @JualCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Jumlah","label":"Total"}]}', 4, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @JualCodes);
GO

-- ============================================================
-- SO/SPK/SPP/SPB (303xxx)
-- ============================================================
DECLARE @SOCodes TABLE (KODEMENU NVARCHAR(10));
INSERT INTO @SOCodes VALUES ('3030101'),('3030102'),('3030103'),('3030201'),('3030202'),('3030203');

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'TitleBand', '{"type":"title","enabled":true,"content":"SALES ORDER","align":"center","fontSize":14,"bold":true}', 1, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @SOCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'MasterDataBand', '{"type":"masterdata","dataset":"so","columns":["Tanggal","NoSO","Customer","Barang","Qty","Harga"],"pageSize":"A4"}', 2, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @SOCodes);
GO

-- ============================================================
-- Stok (501xx, 502xx)
-- ============================================================
DECLARE @StokCodes TABLE (KODEMENU NVARCHAR(10));
INSERT INTO @StokCodes VALUES ('50101'),('50102'),('50103'),('50104'),('50105'),('50106'),('50201'),('50202');

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'TitleBand', '{"type":"title","enabled":true,"content":"LAPORAN STOK","align":"center","fontSize":14,"bold":true}', 1, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @StokCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["tanggal_awal","tanggal_akhir","gudang"],"showPageNumber":true}', 2, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @StokCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'MasterDataBand', '{"type":"masterdata","dataset":"stok","columns":["KodeBarang","NamaBarang","Gudang","Satuan","StokAwal","Masuk","Keluar","StokAkhir"],"pageSize":"A4"}', 3, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @StokCodes);

INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
SELECT id_laporan, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"StokAwal","label":"Total Awal"},{"field":"Masuk","label":"Total Masuk"},{"field":"Keluar","label":"Total Keluar"},{"field":"StokAkhir","label":"Total Akhir"}]}', 4, 1
FROM dbMasterLaporan WHERE KODEMENU IN (SELECT * FROM @StokCodes);
GO

-- ============================================================
-- Cash Flow (106)
-- ============================================================
SET @R1 = (SELECT id_laporan FROM dbMasterLaporan WHERE KODEMENU = '106');
INSERT INTO dbKomponenLaporan (id_laporan, nama_komponen, konfigurasi_layout, urutan, is_active)
VALUES 
(@R1, 'TitleBand', '{"type":"title","enabled":true,"content":"LAPORAN ARUS KAS","align":"center","fontSize":14,"bold":true}', 1, 1),
(@R1, 'PageHeaderBand', '{"type":"pageheader","enabled":true,"fields":["bulan_awal","bulan_akhir","tahun"],"showPageNumber":true}', 2, 1),
(@R1, 'MasterDataBand', '{"type":"masterdata","dataset":"cashflow","columns":["Perkiraan","Lawan","Keterangan","Kas","Koreksi","Jumlah","Gol","Divisi"],"pageSize":"A4"}', 3, 1),
(@R1, 'GroupHeaderBand', '{"type":"groupheader","groupField":"Golongan","showSubtotal":true}', 4, 1),
(@R1, 'FooterBand', '{"type":"footer","showTotal":true,"totals":[{"field":"Kas","label":"Total Kas"},{"field":"Koreksi","label":"Total Koreksi"},{"field":"Jumlah","label":"Total Jumlah"}]}', 5, 1);
GO

-- ============================================================
-- Verification
-- ============================================================
PRINT '';
PRINT '=== VERIFICATION ===';
SELECT COUNT(*) AS TotalKomponen FROM dbKomponenLaporan;
PRINT '';
PRINT 'Components by Report:';
SELECT m.KODEMENU, m.nama_laporan, COUNT(k.id_komponen) AS comp_count
FROM dbMasterLaporan m
LEFT JOIN dbKomponenLaporan k ON m.id_laporan = k.id_laporan
GROUP BY m.KODEMENU, m.nama_laporan
ORDER BY m.KODEMENU;
PRINT '';
PRINT 'Seed komponen completed!';
GO
