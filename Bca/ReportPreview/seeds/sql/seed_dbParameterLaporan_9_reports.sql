-- ============================================================
-- SEED: dbParameterLaporan untuk 9 New Complex Reports (id 25-35)
-- ============================================================
USE dbbcagroup;
GO

INSERT INTO dbParameterLaporan
    (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, posisi, konfigurasi, kode_browse)
VALUES
-- id 25: Sp_ReportInvoicePenjualanDet (params: SReport, Ordr, tgl1, tgl2, isiList, NeedOto, isKP, PPN, Id)
(25, 'SReport', 'SReport', 'dropdown', 1, 'T', 1, '{"options":["T","F"]}', NULL),
(26, 'Ordr', 'Ordr', 'dropdown', 1, 'S', 2, '{"options":["S","D"]}', NULL),
(27, 'tgl1', 'Tanggal Mulai', 'date', 1, '2024-01-01', 3, NULL, NULL),
(28, 'tgl2', 'Tanggal Akhir', 'date', 1, '2024-12-31', 4, NULL, NULL),
(29, 'isiList', 'Isi List', 'text', 0, '', 5, NULL, NULL),
(30, 'NeedOto', 'NeedOto', 'dropdown', 1, '0', 6, '{"options":["0","1"]}', NULL),
(31, 'PPN', 'PPN', 'dropdown', 0, '1', 7, '{"options":["0","1"]}', NULL),
(32, 'Id', 'Id Customer', 'text', 0, '%', 8, NULL, NULL),

-- id 26: sp_ReportPiutangSrtJln (params: Bulan, Tahun, Id, Tanggal, SmpTgl, SmpBln, SmpThn)
(33, 'Bulan', 'Bulan', 'number', 1, '1', 1, NULL, NULL),
(34, 'Tahun', 'Tahun', 'number', 1, '2024', 2, NULL, NULL),
(35, 'Id', 'Id Customer', 'text', 0, '%', 3, NULL, NULL),
(36, 'Tanggal', 'Tanggal', 'date', 0, '', 4, NULL, NULL),
(37, 'SmpTgl', 'SmpTgl', 'date', 0, '', 5, NULL, NULL),
(38, 'SmpBln', 'SmpBln', 'number', 0, '0', 6, NULL, NULL),
(39, 'SmpThn', 'SmpThn', 'number', 0, '2024', 7, NULL, NULL),

-- id 27: Sp_ReportInvoicePenjualanDet (same as 25)
(40, 'SReport', 'SReport', 'dropdown', 1, 'T', 1, '{"options":["T","F"]}', NULL),
(41, 'Ordr', 'Ordr', 'dropdown', 1, 'S', 2, '{"options":["S","D"]}', NULL),
(42, 'tgl1', 'Tanggal Mulai', 'date', 1, '2024-01-01', 3, NULL, NULL),
(43, 'tgl2', 'Tanggal Akhir', 'date', 1, '2024-12-31', 4, NULL, NULL),
(44, 'isiList', 'Isi List', 'text', 0, '', 5, NULL, NULL),
(45, 'NeedOto', 'NeedOto', 'dropdown', 1, '0', 6, '{"options":["0","1"]}', NULL),
(46, 'PPN', 'PPN', 'dropdown', 0, '1', 7, '{"options":["0","1"]}', NULL),
(47, 'Id', 'Id Customer', 'text', 0, '%', 8, NULL, NULL),

-- id 28: Sp_ReportInvoicePenjualanRek
(48, 'Choice', 'Choice', 'dropdown', 1, 'B', 1, '{"options":["B","F","D"]}', NULL),
(49, 'Tgl1', 'Tgl1', 'date', 1, '2024-01-01', 2, NULL, NULL),
(50, 'Tgl2', 'Tgl2', 'date', 1, '2024-12-31', 3, NULL, NULL),
(51, 'NeedOto', 'NeedOto', 'dropdown', 1, '0', 4, '{"options":["0","1"]}', NULL),
(52, 'PPN', 'PPN', 'dropdown', 0, '1', 5, '{"options":["0","1"]}', NULL),
(53, 'Id', 'Id Customer', 'text', 0, '%', 6, NULL, NULL),

-- id 29: sp_TFTransIn
(54, 'Nobukti', 'No Bukti', 'text', 0, '%', 1, NULL, NULL),
(55, 'Do', 'Do', 'dropdown', 1, 'I', 2, '{"options":["I","O"]}', NULL),
(56, 'Urut', 'Urut', 'number', 0, '1', 3, NULL, NULL),

-- id 30: Sp_ReportRInvoicePenjualanRek
(57, 'Choice', 'Choice', 'dropdown', 1, 'B', 1, '{"options":["B","F"]}', NULL),
(58, 'Tgl1', 'Tgl1', 'date', 1, '2024-01-01', 2, NULL, NULL),
(59, 'Tgl2', 'Tgl2', 'date', 1, '2024-12-31', 3, NULL, NULL),
(60, 'Needoto', 'Needoto', 'dropdown', 1, '0', 4, '{"options":["0","1"]}', NULL),
(61, 'Id', 'Id Customer', 'text', 0, '%', 5, NULL, NULL),

-- id 31: Sp_ReportRPenjualanGdgRek
(62, 'Choice', 'Choice', 'dropdown', 1, 'B', 1, '{"options":["B","F"]}', NULL),
(63, 'Tgl1', 'Tgl1', 'date', 1, '2024-01-01', 2, NULL, NULL),
(64, 'Tgl2', 'Tgl2', 'date', 1, '2024-12-31', 3, NULL, NULL),
(65, 'Needoto', 'Needoto', 'dropdown', 1, '0', 4, '{"options":["0","1"]}', NULL),
(66, 'Id', 'Id Customer', 'text', 0, '%', 5, NULL, NULL),

-- id 32: Sp_ReportBeliACCRek
(67, 'Choice', 'Choice', 'dropdown', 1, 'B', 1, '{"options":["B","F"]}', NULL),
(68, 'Tgl1', 'Tgl1', 'date', 1, '2024-01-01', 2, NULL, NULL),
(69, 'Tgl2', 'Tgl2', 'date', 1, '2024-12-31', 3, NULL, NULL),
(70, 'NeedOto', 'NeedOto', 'dropdown', 1, '0', 4, '{"options":["0","1"]}', NULL),
(71, 'TipeBayar', 'TipeBayar', 'dropdown', 0, '0', 5, '{"options":["0","1","2"]}', NULL),
(72, 'Id', 'Id Supplier', 'text', 0, '%', 6, NULL, NULL),

-- id 33: sp_TFTransOut
(73, 'Nobukti', 'No Bukti', 'text', 0, '%', 1, NULL, NULL),
(74, 'Do', 'Do', 'dropdown', 1, 'O', 2, '{"options":["I","O"]}', NULL),
(75, 'Urut', 'Urut', 'number', 0, '1', 3, NULL, NULL),

-- id 34: Sp_reportStockQtyRp
(76, 'Bulan', 'Bulan', 'number', 1, '1', 1, NULL, NULL),
(77, 'Tahun', 'Tahun', 'number', 1, '2024', 2, NULL, NULL),
(78, 'isi', 'Isi', 'dropdown', 1, '2', 3, '{"options":["1","2","3"]}', NULL),
(79, 'Kodegdg', 'KodeGudang', 'text', 0, '%', 4, NULL, NULL),
(80, 'KodeGrp', 'KodeGrp', 'text', 0, '%', 5, NULL, NULL),
(81, 'minus', 'Minus', 'dropdown', 0, '0', 6, '{"options":["0","1"]}', NULL),
(82, 'MinusHpp', 'MinusHpp', 'dropdown', 0, '0', 7, '{"options":["0","1"]}', NULL),
(83, 'Qty1', 'Qty1', 'dropdown', 0, '1', 8, '{"options":["0","1"]}', NULL),
(84, 'Qty2', 'Qty2', 'dropdown', 0, '1', 9, '{"options":["0","1"]}', NULL),
(85, 'Pilih', 'Pilih', 'dropdown', 0, '1', 10, '{"options":["1","2"]}', NULL),
(86, 'KodeSubGrp', 'KodeSubGrp', 'text', 0, '%', 11, NULL, NULL),

-- id 35: sp_reportStockQtyRprek
(87, 'Bulan', 'Bulan', 'number', 1, '1', 1, NULL, NULL),
(88, 'Tahun', 'Tahun', 'number', 1, '2024', 2, NULL, NULL),
(89, 'isi', 'Isi', 'dropdown', 1, '2', 3, '{"options":["1","2","3"]}', NULL),
(90, 'Kodegdg', 'KodeGudang', 'text', 0, '%', 4, NULL, NULL),
(91, 'KodeGrp', 'KodeGrp', 'text', 0, '%', 5, NULL, NULL),
(92, 'minus', 'Minus', 'dropdown', 0, '0', 6, '{"options":["0","1"]}', NULL),
(93, 'MinusHpp', 'MinusHpp', 'dropdown', 0, '0', 7, '{"options":["0","1"]}', NULL),
(94, 'Qty1', 'Qty1', 'dropdown', 0, '1', 8, '{"options":["0","1"]}', NULL),
(95, 'Qty2', 'Qty2', 'dropdown', 0, '1', 9, '{"options":["0","1"]}', NULL),
(96, 'Pilih', 'Pilih', 'dropdown', 0, '1', 10, '{"options":["1","2"]}', NULL),
(97, 'KodeSubGrp', 'KodeSubGrp', 'text', 0, '%', 11, NULL, NULL);

PRINT 'Parameter seed complete (73 rows)';
GO

SELECT id_laporan, COUNT(*) as jumlah_param FROM dbParameterLaporan
WHERE id_laporan BETWEEN 25 AND 35
GROUP BY id_laporan ORDER BY id_laporan;
GO