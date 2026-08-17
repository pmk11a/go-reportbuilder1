-- ============================================================
-- SEED: dbKolomLaporan untuk 11 High Complexity Reports
-- ============================================================
USE dbbcagroup;
GO

-- Laporan 100: Sp_ReportInvoicePenjualanDet
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(100, 'QuView', 'Perusahaan', 'Perusahaan', 1, 'text', 'left', 0, 1),
(101, 'QuView', 'NoBukti', 'No Bukti', 2, 'text', 'left', 0, 1),
(102, 'QuView', 'Tanggal', 'Tanggal', 3, 'date', 'left', 0, 1),
(103, 'QuView', 'KodeCustSupp', 'Kode Customer', 4, 'text', 'left', 0, 1),
(104, 'QuView', 'NAMACUSTSUPP', 'Nama Customer', 5, 'text', 'left', 0, 1),
(105, 'QuView', 'NoSuratJalan', 'No SJ', 6, 'text', 'left', 0, 1),
(106, 'QuView', 'Total', 'Total', 7, 'number', 'right', 1, 1),
(107, 'QuView', 'PPN', 'PPN', 8, 'number', 'right', 1, 1),
(108, 'QuView', 'GrandTotal', 'Grand Total', 9, 'number', 'right', 1, 1),
(109, 'QuView', 'Status', 'Status', 10, 'text', 'center', 0, 1);

-- Laporan 101: Sp_ReportInvoicePenjualanRek
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(110, 'QuView', 'Perusahaan', 'Perusahaan', 1, 'text', 'left', 0, 1),
(111, 'QuView', 'NoBukti', 'No Bukti', 2, 'text', 'left', 0, 1),
(112, 'QuView', 'Tanggal', 'Tanggal', 3, 'date', 'left', 0, 1),
(113, 'QuView', 'KodeCustSupp', 'Kode', 4, 'text', 'left', 0, 1),
(114, 'QuView', 'NAMACUSTSUPP', 'Nama Customer', 5, 'text', 'left', 0, 1),
(115, 'QuView', 'Total', 'Total', 6, 'number', 'right', 1, 1),
(116, 'QuView', 'PPN', 'PPN', 7, 'number', 'right', 1, 1),
(117, 'QuView', 'GrandTotal', 'Grand Total', 8, 'number', 'right', 1, 1);

-- Laporan 102: sp_TFTransIn
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(118, 'QuView', 'nomor', 'No. Transaksi', 1, 'text', 'left', 0, 1),
(119, 'QuView', 'Tanggal', 'Tanggal', 2, 'date', 'left', 0, 1),
(120, 'QuView', 'DariBank', 'Dari Bank', 3, 'text', 'left', 0, 1),
(121, 'QuView', 'KeBank', 'Ke Bank', 4, 'text', 'left', 0, 1),
(122, 'QuView', 'Jumlah', 'Jumlah', 5, 'number', 'right', 1, 1),
(123, 'QuView', 'Keterangan', 'Keterangan', 6, 'text', 'left', 0, 1);

-- Laporan 103: Sp_reportBPrek
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(124, 'QuView', 'Perkiraan', 'Perkiraan', 1, 'text', 'left', 0, 1),
(125, 'QuView', 'Keterangan', 'Keterangan', 2, 'text', 'left', 0, 1),
(126, 'QuView', 'Debet', 'Debet', 3, 'number', 'right', 1, 1),
(127, 'QuView', 'Kredit', 'Kredit', 4, 'number', 'right', 1, 1),
(128, 'QuView', 'Saldo', 'Saldo', 5, 'number', 'right', 1, 1),
(129, 'QuView', 'NoBukti', 'No Bukti', 6, 'text', 'left', 0, 1),
(130, 'QuView', 'Tanggal', 'Tanggal', 7, 'date', 'left', 0, 1);

-- Laporan 104: Sp_ReportRInvoicePenjualanRek
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(131, 'QuView', 'Perusahaan', 'Perusahaan', 1, 'text', 'left', 0, 1),
(132, 'QuView', 'NoBukti', 'No Bukti', 2, 'text', 'left', 0, 1),
(133, 'QuView', 'Tanggal', 'Tanggal', 3, 'date', 'left', 0, 1),
(134, 'QuView', 'KodeCustSupp', 'Kode', 4, 'text', 'left', 0, 1),
(135, 'QuView', 'NAMACUSTSUPP', 'Nama Customer', 5, 'text', 'left', 0, 1),
(136, 'QuView', 'Total', 'Total', 6, 'number', 'right', 1, 1),
(137, 'QuView', 'PPN', 'PPN', 7, 'number', 'right', 1, 1),
(138, 'QuView', 'GrandTotal', 'Grand Total', 8, 'number', 'right', 1, 1);

-- Laporan 105: Sp_ReportRPenjualanGdgRek
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(139, 'QuView', 'Perusahaan', 'Perusahaan', 1, 'text', 'left', 0, 1),
(140, 'QuView', 'NoBukti', 'No Bukti', 2, 'text', 'left', 0, 1),
(141, 'QuView', 'Tanggal', 'Tanggal', 3, 'date', 'left', 0, 1),
(142, 'QuView', 'KodeCustSupp', 'Kode', 4, 'text', 'left', 0, 1),
(143, 'QuView', 'NAMACUSTSUPP', 'Nama Customer', 5, 'text', 'left', 0, 1),
(144, 'QuView', 'Total', 'Total', 6, 'number', 'right', 1, 1),
(145, 'QuView', 'PPN', 'PPN', 7, 'number', 'right', 1, 1),
(146, 'QuView', 'Gudang', 'Gudang', 8, 'text', 'left', 0, 1);

-- Laporan 106: Sp_ReportBeliACCRek
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(147, 'QuView', 'Perusahaan', 'Perusahaan', 1, 'text', 'left', 0, 1),
(148, 'QuView', 'NoBukti', 'No Bukti', 2, 'text', 'left', 0, 1),
(149, 'QuView', 'TANGGAL', 'Tanggal', 3, 'date', 'left', 0, 1),
(150, 'QuView', 'KODESUPP', 'Kode Supplier', 4, 'text', 'left', 0, 1),
(151, 'QuView', 'NAMACUSTSUPP', 'Nama Supplier', 5, 'text', 'left', 0, 1),
(152, 'QuView', 'KODEVLS', 'Valas', 6, 'text', 'left', 0, 1),
(153, 'QuView', 'Total', 'Total', 7, 'number', 'right', 1, 1),
(154, 'QuView', 'PPN', 'PPN', 8, 'number', 'right', 1, 1),
(155, 'QuView', 'TipeBayar', 'Tipe Bayar', 9, 'text', 'left', 0, 1);

-- Laporan 107: sp_ReportPiutangSrtJln
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(156, 'QuView', 'KodeCustSupp', 'Kode Customer', 1, 'text', 'left', 0, 1),
(157, 'QuView', 'NAMACUSTSUPP', 'Nama Customer', 2, 'text', 'left', 0, 1),
(158, 'QuView', 'Tanggal', 'Tanggal', 3, 'date', 'left', 0, 1),
(159, 'QuView', 'NoSuratJalan', 'No SJ', 4, 'text', 'left', 0, 1),
(160, 'QuView', 'NoInvoice', 'No Invoice', 5, 'text', 'left', 0, 1),
(161, 'QuView', 'Jumlah', 'Jumlah', 6, 'number', 'right', 1, 1),
(162, 'QuView', 'Sisa', 'Sisa Piutang', 7, 'number', 'right', 1, 1),
(163, 'QuView', 'Kelompok', 'Kelompok', 8, 'text', 'center', 0, 1);

-- Laporan 108: sp_TFTransOut
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(164, 'QuView', 'nomor', 'No. Transaksi', 1, 'text', 'left', 0, 1),
(165, 'QuView', 'Tanggal', 'Tanggal', 2, 'date', 'left', 0, 1),
(166, 'QuView', 'DariBank', 'Dari Bank', 3, 'text', 'left', 0, 1),
(167, 'QuView', 'KeBank', 'Ke Bank', 4, 'text', 'left', 0, 1),
(168, 'QuView', 'Jumlah', 'Jumlah', 5, 'number', 'right', 1, 1),
(169, 'QuView', 'Tujuan', 'Tujuan', 6, 'text', 'left', 0, 1);

-- Laporan 109: Sp_reportStockQtyRp
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(170, 'QuView', 'KodeBarang', 'Kode Barang', 1, 'text', 'left', 0, 1),
(171, 'QuView', 'NAMABRG', 'Nama Barang', 2, 'text', 'left', 0, 1),
(172, 'QuView', 'Satuan', 'Satuan', 3, 'text', 'center', 0, 1),
(173, 'QuView', 'Stok', 'Stok', 4, 'number', 'right', 1, 1),
(174, 'QuView', 'Harga', 'Harga', 5, 'number', 'right', 1, 1),
(175, 'QuView', 'Nilai', 'Nilai', 6, 'number', 'right', 1, 1),
(176, 'QuView', 'KodeGudang', 'Gudang', 7, 'text', 'left', 0, 1),
(177, 'QuView', 'KodeGrp', 'Group', 8, 'text', 'left', 0, 1);

-- Laporan 110: sp_reportStockQtyRprek
INSERT INTO dbKolomLaporan (id_laporan, nama_dataset, nama_kolom, label_tampil, urutan_tampil, format_type, alignment, is_summable, is_visible)
VALUES
(178, 'QuView', 'KodeBarang', 'Kode Barang', 1, 'text', 'left', 0, 1),
(179, 'QuView', 'NAMABRG', 'Nama Barang', 2, 'text', 'left', 0, 1),
(180, 'QuView', 'StokAwal', 'Stok Awal', 3, 'number', 'right', 1, 1),
(181, 'QuView', 'Masuk', 'Masuk', 4, 'number', 'right', 1, 1),
(182, 'QuView', 'Keluar', 'Keluar', 5, 'number', 'right', 1, 1),
(183, 'QuView', 'StokAkhir', 'Stok Akhir', 6, 'number', 'right', 1, 1),
(184, 'QuView', 'KodeGudang', 'Gudang', 7, 'text', 'left', 0, 1);

PRINT 'Kolom seed complete (71 rows)';
GO

SELECT id_laporan, COUNT(*) as jumlah_kolom FROM dbKolomLaporan
WHERE id_laporan BETWEEN 100 AND 184
GROUP BY id_laporan ORDER BY id_laporan;
GO