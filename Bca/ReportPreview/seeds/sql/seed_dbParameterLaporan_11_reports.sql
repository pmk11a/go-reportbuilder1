-- ============================================================
-- SEED: dbParameterLaporan untuk 11 High Complexity Reports
-- ============================================================
USE dbbcagroup;
GO

INSERT INTO dbParameterLaporan
    (id_laporan, nama_filter, label, tipe_input, wajib_isi, nilai_default, posisi, konfigurasi, kode_browse)
VALUES
-- Laporan 100: Sp_ReportInvoicePenjualanDet (params: SReport, Ordr, tgl1, tgl2, isiList, NeedOto, isKP, PPN, Id)
(100, 'SReport', 'SReport', 'dropdown', 1, 'T', 1, '{"options":["T","F"]}', NULL),
(101, 'Ordr', 'Ordr', 'dropdown', 1, 'S', 2, '{"options":["S","D"]}', NULL),
(102, 'tgl1', 'Tanggal Mulai', 'date', 1, '2024-01-01', 3, NULL, NULL),
(103, 'tgl2', 'Tanggal Akhir', 'date', 1, '2024-12-31', 4, NULL, NULL),
(104, 'isiList', 'Isi List', 'text', 0, '', 5, NULL, NULL),
(105, 'NeedOto', 'NeedOto', 'dropdown', 1, '0', 6, '{"options":["0","1"]}', NULL),
(106, 'PPN', 'PPN', 'dropdown', 0, '1', 7, '{"options":["0","1"]}', NULL),
(107, 'Id', 'Id Customer', 'text', 0, '%', 8, NULL, NULL),

-- Laporan 101: Sp_ReportInvoicePenjualanRek (params: Choice, Tgl1, Tgl2, NeedOto, PPN, Id)
(108, 'Choice', 'Choice', 'dropdown', 1, 'B', 1, '{"options":["B","F","D"]}', NULL),
(109, 'Tgl1', 'Tgl1', 'date', 1, '2024-01-01', 2, NULL, NULL),
(110, 'Tgl2', 'Tgl2', 'date', 1, '2024-12-31', 3, NULL, NULL),
(111, 'NeedOto', 'NeedOto', 'dropdown', 1, '0', 4, '{"options":["0","1"]}', NULL),
(112, 'PPN', 'PPN', 'dropdown', 0, '1', 5, '{"options":["0","1"]}', NULL),
(113, 'Id', 'Id Customer', 'text', 0, '%', 6, NULL, NULL),

-- Laporan 102: sp_TFTransIn (params: Nobukti, Do, Urut)
(114, 'Nobukti', 'No Bukti', 'text', 0, '%', 1, NULL, NULL),
(115, 'Do', 'Do', 'dropdown', 1, 'I', 2, '{"options":["I","O"]}', NULL),
(116, 'Urut', 'Urut', 'number', 0, '1', 3, NULL, NULL),

-- Laporan 103: Sp_reportBPrek (params: Choice, Tgl1, Tgl2, NeedOto, Id)
(117, 'Choice', 'Choice', 'dropdown', 1, 'B', 1, '{"options":["B","D"]}', NULL),
(118, 'Tgl1', 'Tgl1', 'date', 1, '2024-01-01', 2, NULL, NULL),
(119, 'Tgl2', 'Tgl2', 'date', 1, '2024-12-31', 3, NULL, NULL),
(120, 'NeedOto', 'NeedOto', 'dropdown', 1, '0', 4, '{"options":["0","1"]}', NULL),
(121, 'Id', 'Perkiraan', 'text', 0, '%', 5, NULL, NULL),

-- Laporan 104: Sp_ReportRInvoicePenjualanRek
(122, 'Choice', 'Choice', 'dropdown', 1, 'B', 1, '{"options":["B","F"]}', NULL),
(123, 'Tgl1', 'Tgl1', 'date', 1, '2024-01-01', 2, NULL, NULL),
(124, 'Tgl2', 'Tgl2', 'date', 1, '2024-12-31', 3, NULL, NULL),
(125, 'Needoto', 'Needoto', 'dropdown', 1, '0', 4, '{"options":["0","1"]}', NULL),
(126, 'Id', 'Id Customer', 'text', 0, '%', 5, NULL, NULL),

-- Laporan 105: Sp_ReportRPenjualanGdgRek
(127, 'Choice', 'Choice', 'dropdown', 1, 'B', 1, '{"options":["B","F"]}', NULL),
(128, 'Tgl1', 'Tgl1', 'date', 1, '2024-01-01', 2, NULL, NULL),
(129, 'Tgl2', 'Tgl2', 'date', 1, '2024-12-31', 3, NULL, NULL),
(130, 'Needoto', 'Needoto', 'dropdown', 1, '0', 4, '{"options":["0","1"]}', NULL),
(131, 'Id', 'Id Customer', 'text', 0, '%', 5, NULL, NULL),

-- Laporan 106: Sp_ReportBeliACCRek
(132, 'Choice', 'Choice', 'dropdown', 1, 'B', 1, '{"options":["B","F"]}', NULL),
(133, 'Tgl1', 'Tgl1', 'date', 1, '2024-01-01', 2, NULL, NULL),
(134, 'Tgl2', 'Tgl2', 'date', 1, '2024-12-31', 3, NULL, NULL),
(135, 'NeedOto', 'NeedOto', 'dropdown', 1, '0', 4, '{"options":["0","1"]}', NULL),
(136, 'TipeBayar', 'TipeBayar', 'dropdown', 0, '0', 5, '{"options":["0","1","2"]}', NULL),
(137, 'Id', 'Id Supplier', 'text', 0, '%', 6, NULL, NULL),

-- Laporan 107: sp_ReportPiutangSrtJln
(138, 'Bulan', 'Bulan', 'number', 1, '1', 1, NULL, NULL),
(139, 'Tahun', 'Tahun', 'number', 1, '2024', 2, NULL, NULL),
(140, 'Id', 'Id Customer', 'text', 0, '%', 3, NULL, NULL),
(141, 'Tanggal', 'Tanggal', 'date', 0, '', 4, NULL, NULL),
(142, 'SmpTgl', 'SmpTgl', 'date', 0, '', 5, NULL, NULL),
(143, 'SmpBln', 'SmpBln', 'number', 0, '0', 6, NULL, NULL),
(144, 'SmpThn', 'SmpThn', 'number', 0, '2024', 7, NULL, NULL),

-- Laporan 108: sp_TFTransOut
(145, 'Nobukti', 'No Bukti', 'text', 0, '%', 1, NULL, NULL),
(146, 'Do', 'Do', 'dropdown', 1, 'O', 2, '{"options":["I","O"]}', NULL),
(147, 'Urut', 'Urut', 'number', 0, '1', 3, NULL, NULL),

-- Laporan 109: Sp_reportStockQtyRp
(148, 'Bulan', 'Bulan', 'number', 1, '1', 1, NULL, NULL),
(149, 'Tahun', 'Tahun', 'number', 1, '2024', 2, NULL, NULL),
(150, 'isi', 'Isi', 'dropdown', 1, '2', 3, '{"options":["1","2","3"]}', NULL),
(151, 'Kodegdg', 'KodeGudang', 'text', 0, '%', 4, NULL, NULL),
(152, 'KodeGrp', 'KodeGrp', 'text', 0, '%', 5, NULL, NULL),
(153, 'minus', 'Minus', 'dropdown', 0, '0', 6, '{"options":["0","1"]}', NULL),
(154, 'MinusHpp', 'MinusHpp', 'dropdown', 0, '0', 7, '{"options":["0","1"]}', NULL),
(155, 'Qty1', 'Qty1', 'dropdown', 0, '1', 8, '{"options":["0","1"]}', NULL),
(156, 'Qty2', 'Qty2', 'dropdown', 0, '1', 9, '{"options":["0","1"]}', NULL),
(157, 'Pilih', 'Pilih', 'dropdown', 0, '1', 10, '{"options":["1","2"]}', NULL),
(158, 'KodeSubGrp', 'KodeSubGrp', 'text', 0, '%', 11, NULL, NULL),

-- Laporan 110: sp_reportStockQtyRprek
(159, 'Bulan', 'Bulan', 'number', 1, '1', 1, NULL, NULL),
(160, 'Tahun', 'Tahun', 'number', 1, '2024', 2, NULL, NULL),
(161, 'isi', 'Isi', 'dropdown', 1, '2', 3, '{"options":["1","2","3"]}', NULL),
(162, 'Kodegdg', 'KodeGudang', 'text', 0, '%', 4, NULL, NULL),
(163, 'KodeGrp', 'KodeGrp', 'text', 0, '%', 5, NULL, NULL),
(164, 'minus', 'Minus', 'dropdown', 0, '0', 6, '{"options":["0","1"]}', NULL),
(165, 'MinusHpp', 'MinusHpp', 'dropdown', 0, '0', 7, '{"options":["0","1"]}', NULL),
(166, 'Qty1', 'Qty1', 'dropdown', 0, '1', 8, '{"options":["0","1"]}', NULL),
(167, 'Qty2', 'Qty2', 'dropdown', 0, '1', 9, '{"options":["0","1"]}', NULL),
(168, 'Pilih', 'Pilih', 'dropdown', 0, '1', 10, '{"options":["1","2"]}', NULL),
(169, 'KodeSubGrp', 'KodeSubGrp', 'text', 0, '%', 11, NULL, NULL);

PRINT 'Parameter seed complete';
GO

-- Verify
SELECT id_laporan, nama_filter, label, tipe_input FROM dbParameterLaporan
WHERE id_laporan BETWEEN 100 AND 169 ORDER BY id_laporan;
GO