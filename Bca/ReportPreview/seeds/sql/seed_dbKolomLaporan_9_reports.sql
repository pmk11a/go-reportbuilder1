-- ============================================================
-- SEED: dbKolomLaporan untuk 9 New Complex Reports (id 25-35)
-- ============================================================
USE dbbcagroup;
GO

-- id 25: Sp_ReportInvoicePenjualanDet
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(25, 'QuView', 'Perusahaan', 'Perusahaan', 1, 'text', 'left', 0, 1),
(26, 'QuView', 'NoBukti', 'No Bukti', 2, 'text', 'left', 0, 1),
(27, 'QuView', 'Tanggal', 'Tanggal', 3, 'date', 'left', 0, 1),
(28, 'QuView', 'KodeCustSupp', 'Kode Customer', 4, 'text', 'left', 0, 1),
(29, 'QuView', 'NAMACUSTSUPP', 'Nama Customer', 5, 'text', 'left', 0, 1),
(30, 'QuView', 'NoSuratJalan', 'No SJ', 6, 'text', 'left', 0, 1),
(31, 'QuView', 'Total', 'Total', 7, 'number', 'right', 1, 1),
(32, 'QuView', 'PPN', 'PPN', 8, 'number', 'right', 1, 1),
(33, 'QuView', 'GrandTotal', 'Grand Total', 9, 'number', 'right', 1, 1),
(34, 'QuView', 'Status', 'Status', 10, 'text', 'center', 0, 1);

-- id 26: sp_ReportPiutangSrtJln
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(35, 'QuView', 'KodeCustSupp', 'Kode Customer', 1, 'text', 'left', 0, 1),
(36, 'QuView', 'NAMACUSTSUPP', 'Nama Customer', 2, 'text', 'left', 0, 1),
(37, 'QuView', 'Tanggal', 'Tanggal', 3, 'date', 'left', 0, 1),
(38, 'QuView', 'NoSuratJalan', 'No SJ', 4, 'text', 'left', 0, 1),
(39, 'QuView', 'NoInvoice', 'No Invoice', 5, 'text', 'left', 0, 1),
(40, 'QuView', 'Jumlah', 'Jumlah', 6, 'number', 'right', 1, 1),
(41, 'QuView', 'Sisa', 'Sisa Piutang', 7, 'number', 'right', 1, 1),
(42, 'QuView', 'Kelompok', 'Kelompok', 8, 'text', 'center', 0, 1);

-- id 27: Sp_ReportInvoicePenjualanDet
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(43, 'QuView', 'Perusahaan', 'Perusahaan', 1, 'text', 'left', 0, 1),
(44, 'QuView', 'NoBukti', 'No Bukti', 2, 'text', 'left', 0, 1),
(45, 'QuView', 'Tanggal', 'Tanggal', 3, 'date', 'left', 0, 1),
(46, 'QuView', 'KodeCustSupp', 'Kode Customer', 4, 'text', 'left', 0, 1),
(47, 'QuView', 'NAMACUSTSUPP', 'Nama Customer', 5, 'text', 'left', 0, 1),
(48, 'QuView', 'NoSuratJalan', 'No SJ', 6, 'text', 'left', 0, 1),
(49, 'QuView', 'Total', 'Total', 7, 'number', 'right', 1, 1),
(50, 'QuView', 'PPN', 'PPN', 8, 'number', 'right', 1, 1),
(51, 'QuView', 'GrandTotal', 'Grand Total', 9, 'number', 'right', 1, 1),
(52, 'QuView', 'Status', 'Status', 10, 'text', 'center', 0, 1);

-- id 28: Sp_ReportInvoicePenjualanRek
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(53, 'QuView', 'Perusahaan', 'Perusahaan', 1, 'text', 'left', 0, 1),
(54, 'QuView', 'NoBukti', 'No Bukti', 2, 'text', 'left', 0, 1),
(55, 'QuView', 'Tanggal', 'Tanggal', 3, 'date', 'left', 0, 1),
(56, 'QuView', 'KodeCustSupp', 'Kode', 4, 'text', 'left', 0, 1),
(57, 'QuView', 'NAMACUSTSUPP', 'Nama Customer', 5, 'text', 'left', 0, 1),
(58, 'QuView', 'Total', 'Total', 6, 'number', 'right', 1, 1),
(59, 'QuView', 'PPN', 'PPN', 7, 'number', 'right', 1, 1),
(60, 'QuView', 'GrandTotal', 'Grand Total', 8, 'number', 'right', 1, 1);

-- id 29: sp_TFTransIn
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(61, 'QuView', 'nomor', 'No. Transaksi', 1, 'text', 'left', 0, 1),
(62, 'QuView', 'Tanggal', 'Tanggal', 2, 'date', 'left', 0, 1),
(63, 'QuView', 'DariBank', 'Dari Bank', 3, 'text', 'left', 0, 1),
(64, 'QuView', 'KeBank', 'Ke Bank', 4, 'text', 'left', 0, 1),
(65, 'QuView', 'Jumlah', 'Jumlah', 5, 'number', 'right', 1, 1),
(66, 'QuView', 'Keterangan', 'Keterangan', 6, 'text', 'left', 0, 1);

-- id 30: Sp_ReportRInvoicePenjualanRek
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(67, 'QuView', 'Perusahaan', 'Perusahaan', 1, 'text', 'left', 0, 1),
(68, 'QuView', 'NoBukti', 'No Bukti', 2, 'text', 'left', 0, 1),
(69, 'QuView', 'Tanggal', 'Tanggal', 3, 'date', 'left', 0, 1),
(70, 'QuView', 'KodeCustSupp', 'Kode', 4, 'text', 'left', 0, 1),
(71, 'QuView', 'NAMACUSTSUPP', 'Nama Customer', 5, 'text', 'left', 0, 1),
(72, 'QuView', 'Total', 'Total', 6, 'number', 'right', 1, 1),
(73, 'QuView', 'PPN', 'PPN', 7, 'number', 'right', 1, 1),
(74, 'QuView', 'GrandTotal', 'Grand Total', 8, 'number', 'right', 1, 1);

-- id 31: Sp_ReportRPenjualanGdgRek
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(75, 'QuView', 'Perusahaan', 'Perusahaan', 1, 'text', 'left', 0, 1),
(76, 'QuView', 'NoBukti', 'No Bukti', 2, 'text', 'left', 0, 1),
(77, 'QuView', 'Tanggal', 'Tanggal', 3, 'date', 'left', 0, 1),
(78, 'QuView', 'KodeCustSupp', 'Kode', 4, 'text', 'left', 0, 1),
(79, 'QuView', 'NAMACUSTSUPP', 'Nama Customer', 5, 'text', 'left', 0, 1),
(80, 'QuView', 'Total', 'Total', 6, 'number', 'right', 1, 1),
(81, 'QuView', 'PPN', 'PPN', 7, 'number', 'right', 1, 1),
(82, 'QuView', 'Gudang', 'Gudang', 8, 'text', 'left', 0, 1);

-- id 32: Sp_ReportBeliACCRek
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(83, 'QuView', 'Perusahaan', 'Perusahaan', 1, 'text', 'left', 0, 1),
(84, 'QuView', 'NoBukti', 'No Bukti', 2, 'text', 'left', 0, 1),
(85, 'QuView', 'TANGGAL', 'Tanggal', 3, 'date', 'left', 0, 1),
(86, 'QuView', 'KODESUPP', 'Kode Supplier', 4, 'text', 'left', 0, 1),
(87, 'QuView', 'NAMACUSTSUPP', 'Nama Supplier', 5, 'text', 'left', 0, 1),
(88, 'QuView', 'KODEVLS', 'Valas', 6, 'text', 'left', 0, 1),
(89, 'QuView', 'Total', 'Total', 7, 'number', 'right', 1, 1),
(90, 'QuView', 'PPN', 'PPN', 8, 'number', 'right', 1, 1),
(91, 'QuView', 'TipeBayar', 'Tipe Bayar', 9, 'text', 'left', 0, 1);

-- id 33: sp_TFTransOut
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(92, 'QuView', 'nomor', 'No. Transaksi', 1, 'text', 'left', 0, 1),
(93, 'QuView', 'Tanggal', 'Tanggal', 2, 'date', 'left', 0, 1),
(94, 'QuView', 'DariBank', 'Dari Bank', 3, 'text', 'left', 0, 1),
(95, 'QuView', 'KeBank', 'Ke Bank', 4, 'text', 'left', 0, 1),
(96, 'QuView', 'Jumlah', 'Jumlah', 5, 'number', 'right', 1, 1),
(97, 'QuView', 'Tujuan', 'Tujuan', 6, 'text', 'left', 0, 1);

-- id 34: Sp_reportStockQtyRp
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(98, 'QuView', 'KodeBarang', 'Kode Barang', 1, 'text', 'left', 0, 1),
(99, 'QuView', 'NAMABRG', 'Nama Barang', 2, 'text', 'left', 0, 1),
(100, 'QuView', 'Satuan', 'Satuan', 3, 'text', 'center', 0, 1),
(101, 'QuView', 'Stok', 'Stok', 4, 'number', 'right', 1, 1),
(102, 'QuView', 'Harga', 'Harga', 5, 'number', 'right', 1, 1),
(103, 'QuView', 'Nilai', 'Nilai', 6, 'number', 'right', 1, 1),
(104, 'QuView', 'KodeGudang', 'Gudang', 7, 'text', 'left', 0, 1),
(105, 'QuView', 'KodeGrp', 'Group', 8, 'text', 'left', 0, 1);

-- id 35: sp_reportStockQtyRprek
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(106, 'QuView', 'KodeBarang', 'Kode Barang', 1, 'text', 'left', 0, 1),
(107, 'QuView', 'NAMABRG', 'Nama Barang', 2, 'text', 'left', 0, 1),
(108, 'QuView', 'StokAwal', 'Stok Awal', 3, 'number', 'right', 1, 1),
(109, 'QuView', 'Masuk', 'Masuk', 4, 'number', 'right', 1, 1),
(110, 'QuView', 'Keluar', 'Keluar', 5, 'number', 'right', 1, 1),
(111, 'QuView', 'StokAkhir', 'Stok Akhir', 6, 'number', 'right', 1, 1),
(112, 'QuView', 'KodeGudang', 'Gudang', 7, 'text', 'left', 0, 1);

PRINT 'Kolom seed complete (66 rows)';
GO

SELECT id_laporan, COUNT(*) as jumlah_kolom FROM dbKolomLaporan
WHERE id_laporan BETWEEN 25 AND 35
GROUP BY id_laporan ORDER BY id_laporan;
GO