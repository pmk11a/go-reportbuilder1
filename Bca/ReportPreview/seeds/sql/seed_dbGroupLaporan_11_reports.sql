-- ============================================================
-- SEED: dbGroupLaporan untuk 11 High Complexity Reports
-- ============================================================
USE dbbcagroup;
GO

-- Only add groups where grouping makes sense (mainly for financial reports)
INSERT INTO dbGroupLaporan
    (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES
-- Laporan 103: Buku Besar - group by Perkiraan
(103, 1, 'Perkiraan', '', 'Sub Total per Perkiraan', 1, 1, 'default', '{"auto_sum":"Debet,Kredit,Saldo"}'),

-- Laporan 109: Stock Qty Rp - group by Group Barang
(109, 1, 'KodeGrp', '', 'Sub Total per Group', 1, 1, 'default', '{"auto_sum":"Stok,Harga,Nilai"}'),

-- Laporan 110: Stock Rekonsiliasi - group by Group Barang
(110, 1, 'KodeGrp', '', 'Sub Total per Group', 1, 1, 'default', '{"auto_sum":"StokAwal,Masuk,Keluar,StokAkhir"}');

PRINT 'Group seed complete (3 rows)';
GO

SELECT id_laporan, group_level, group_field, label FROM dbGroupLaporan
WHERE id_laporan BETWEEN 100 AND 110;
GO