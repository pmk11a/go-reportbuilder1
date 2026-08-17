-- ============================================================
-- SEED: dbGroupLaporan untuk 9 New Complex Reports (id 25-35)
-- ============================================================
USE dbbcagroup;
GO

INSERT INTO dbGroupLaporan
    (id_laporan, group_level, group_field, field_value, label, sort_order, show_subtotal, special_handling, config_json)
VALUES
-- id 26: Piutang Surat Jalan
(26, 1, 'Kelompok', '', 'Sub Total per Kelompok', 1, 1, 'default', '{"auto_sum":"Jumlah,Sisa"}'),

-- id 34: Stock Qty Rp
(34, 1, 'KodeGrp', '', 'Sub Total per Group', 1, 1, 'default', '{"auto_sum":"Stok,Harga,Nilai"}'),

-- id 35: Stock Rekonsiliasi
(35, 1, 'KodeGrp', '', 'Sub Total per Group', 1, 1, 'default', '{"auto_sum":"StokAwal,Masuk,Keluar,StokAkhir"}');

PRINT 'Group seed complete (3 rows)';
GO

SELECT id_laporan, group_level, group_field, label FROM dbGroupLaporan
WHERE id_laporan BETWEEN 25 AND 35;
GO
