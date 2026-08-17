-- ============================================================
-- DDL — Report Tables (SQL Server)
-- Database: SQL Server (sqlsrv)
-- Tables: dbMasterLaporan, dbParameterLaporan, dbQueryLaporan,
--         dbKolomLaporan, dbGroupLaporan, dbKomponenLaporan,
--         dbLabelGrup
--
-- Konvensi:
--   - Semua nama kolom UPPERCASE (legacy Delphi/SQL Server)
--   - dbLabelGrup bersifat GLOBAL (tidak tied ke id_laporan)
--   - FK opsional, recommended untuk referential integrity
-- ============================================================

USE dbbcagroup;
GO

-- ============================================================
-- 1. dbMasterLaporan — Master definisi laporan
--    Titik awal semua konfigurasi laporan per KODEMENU
-- ============================================================

IF OBJECT_ID('dbMasterLaporan', 'U') IS NULL
BEGIN
    CREATE TABLE dbMasterLaporan (
        id_laporan        INT IDENTITY(1,1) PRIMARY KEY,
        KODEMENU          NVARCHAR(20) NOT NULL,
        nama_laporan      NVARCHAR(256) NOT NULL,
        deskripsi         NVARCHAR(512) NULL,
        query_sumber_data NVARCHAR(MAX) NULL,
        status_aktif      BIT NOT NULL DEFAULT 1,
        footer_bands      NVARCHAR(MAX) NULL
    );
    PRINT 'Table dbMasterLaporan created.';
END
ELSE
BEGIN
    PRINT 'Table dbMasterLaporan already exists - skipped.';
END
GO

CREATE UNIQUE INDEX UX_dbMasterLaporan_kodemenu ON dbMasterLaporan (KODEMENU);
GO

-- ============================================================
-- 2. dbParameterLaporan — Filter parameters per laporan
-- ============================================================

IF OBJECT_ID('dbParameterLaporan', 'U') IS NULL
BEGIN
    CREATE TABLE dbParameterLaporan (
        id_parameter  INT IDENTITY(1,1) PRIMARY KEY,
        id_laporan    INT NOT NULL,
        nama_filter   NVARCHAR(128) NOT NULL,
        label         NVARCHAR(128) NULL,
        tipe_input    NVARCHAR(32) NOT NULL,
        wajib_isi     BIT NOT NULL DEFAULT 0,
        nilai_default NVARCHAR(256) NULL,
        kode_browse   NVARCHAR(32) NULL,
        konfigurasi   NVARCHAR(MAX) NULL,
        posisi        INT NOT NULL DEFAULT 0
    );
    PRINT 'Table dbParameterLaporan created.';
END
ELSE
BEGIN
    PRINT 'Table dbParameterLaporan already exists - skipped.';
END
GO

CREATE INDEX IX_dbParameterLaporan_laporan ON dbParameterLaporan (id_laporan);
GO

-- ============================================================
-- 3. dbQueryLaporan — Dataset / query definitions per laporan
-- ============================================================

IF OBJECT_ID('dbQueryLaporan', 'U') IS NULL
BEGIN
    CREATE TABLE dbQueryLaporan (
        id_query            INT IDENTITY(1,1) PRIMARY KEY,
        id_laporan          INT NOT NULL,
        nama_dataset        NVARCHAR(128) NOT NULL,
        query_sumber_data   NVARCHAR(MAX) NOT NULL,
        deskripsi           NVARCHAR(256) NULL,
        urutan              INT NOT NULL DEFAULT 0,
        visible             BIT NOT NULL DEFAULT 1,
        config_json         NVARCHAR(MAX) NULL
    );
    PRINT 'Table dbQueryLaporan created.';
END
ELSE
BEGIN
    PRINT 'Table dbQueryLaporan already exists - skipped.';
END
GO

CREATE INDEX IX_dbQueryLaporan_laporan ON dbQueryLaporan (id_laporan);
GO

-- ============================================================
-- 4. dbKolomLaporan — Kolom tampilan per dataset per laporan
-- ============================================================

IF OBJECT_ID('dbKolomLaporan', 'U') IS NULL
BEGIN
    CREATE TABLE dbKolomLaporan (
        id_kolom      INT IDENTITY(1,1) PRIMARY KEY,
        id_laporan    INT NOT NULL,
        nama_dataset  NVARCHAR(128) NOT NULL,
        nama_kolom    NVARCHAR(128) NOT NULL,
        label_tampil  NVARCHAR(128) NOT NULL,
        urutan_tampil INT NOT NULL DEFAULT 0,
        format_type   NVARCHAR(32) NOT NULL DEFAULT 'text',
        alignment     NVARCHAR(16) NOT NULL DEFAULT 'left',
        is_summable   BIT NOT NULL DEFAULT 0,
        is_visible    BIT NOT NULL DEFAULT 1
    );
    PRINT 'Table dbKolomLaporan created.';
END
ELSE
BEGIN
    PRINT 'Table dbKolomLaporan already exists - skipped.';
END
GO

CREATE INDEX IX_dbKolomLaporan_laporan ON dbKolomLaporan (id_laporan);
GO

-- ============================================================
-- 5. dbGroupLaporan — Grouping configuration per laporan
-- ============================================================

IF OBJECT_ID('dbGroupLaporan', 'U') IS NULL
BEGIN
    CREATE TABLE dbGroupLaporan (
        id_group         INT IDENTITY(1,1) PRIMARY KEY,
        id_laporan       INT NOT NULL,
        group_level      INT NOT NULL,
        group_field      NVARCHAR(128) NOT NULL,
        field_value      NVARCHAR(128) NULL,
        label            NVARCHAR(256) NOT NULL,
        sort_order       INT NOT NULL DEFAULT 0,
        show_subtotal    BIT NOT NULL DEFAULT 1,
        special_handling NVARCHAR(50) NULL DEFAULT 'default',
        style_config     NVARCHAR(MAX) NULL,
        config_json      NVARCHAR(MAX) NULL
    );
    PRINT 'Table dbGroupLaporan created.';
END
ELSE
BEGIN
    PRINT 'Table dbGroupLaporan already exists - skipped.';
END
GO

CREATE INDEX IX_dbGroupLaporan_laporan ON dbGroupLaporan (id_laporan);
GO

-- ============================================================
-- 6. dbKomponenLaporan — Konfigurasi layout komponen dinamis
-- ============================================================

IF OBJECT_ID('dbKomponenLaporan', 'U') IS NULL
BEGIN
    CREATE TABLE dbKomponenLaporan (
        id_komponen        INT IDENTITY(1,1) PRIMARY KEY,
        id_laporan         INT NOT NULL,
        nama_komponen      NVARCHAR(128) NOT NULL,
        konfigurasi_layout NVARCHAR(MAX) NOT NULL,
        urutan             INT NOT NULL DEFAULT 0,
        is_active          BIT NOT NULL DEFAULT 1
    );
    PRINT 'Table dbKomponenLaporan created.';
END
ELSE
BEGIN
    PRINT 'Table dbKomponenLaporan already exists - skipped.';
END
GO

CREATE INDEX IX_dbKomponenLaporan_laporan ON dbKomponenLaporan (id_laporan);
GO

-- ============================================================
-- 7. dbLabelGrup — Label mapping (GLOBAL, tidak tied ke laporan)
-- ============================================================

IF OBJECT_ID('dbLabelGrup', 'U') IS NULL
BEGIN
    CREATE TABLE dbLabelGrup (
        id          INT IDENTITY(1,1) PRIMARY KEY,
        field_name  NVARCHAR(128) NOT NULL,
        field_value NVARCHAR(128) NOT NULL,
        label       NVARCHAR(256) NOT NULL,
        aktif       BIT NOT NULL DEFAULT 1,
        sort_order  INT NOT NULL DEFAULT 0
    );
    PRINT 'Table dbLabelGrup created.';
END
ELSE
BEGIN
    PRINT 'Table dbLabelGrup already exists - skipped.';
END
GO

CREATE INDEX IX_dbLabelGrup_field ON dbLabelGrup (field_name, aktif);
GO

-- ============================================================
-- Foreign Keys (opsional, recommended)
-- ============================================================

IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_param_laporan'
)
BEGIN
    ALTER TABLE dbParameterLaporan
        ADD CONSTRAINT FK_param_laporan
        FOREIGN KEY (id_laporan) REFERENCES dbMasterLaporan(id_laporan);
    PRINT 'FK FK_param_laporan added.';
END
ELSE
BEGIN
    PRINT 'FK FK_param_laporan already exists - skipped.';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_query_laporan'
)
BEGIN
    ALTER TABLE dbQueryLaporan
        ADD CONSTRAINT FK_query_laporan
        FOREIGN KEY (id_laporan) REFERENCES dbMasterLaporan(id_laporan);
    PRINT 'FK FK_query_laporan added.';
END
ELSE
BEGIN
    PRINT 'FK FK_query_laporan already exists - skipped.';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_col_laporan'
)
BEGIN
    ALTER TABLE dbKolomLaporan
        ADD CONSTRAINT FK_col_laporan
        FOREIGN KEY (id_laporan) REFERENCES dbMasterLaporan(id_laporan);
    PRINT 'FK FK_col_laporan added.';
END
ELSE
BEGIN
    PRINT 'FK FK_col_laporan already exists - skipped.';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_grp_laporan'
)
BEGIN
    ALTER TABLE dbGroupLaporan
        ADD CONSTRAINT FK_grp_laporan
        FOREIGN KEY (id_laporan) REFERENCES dbMasterLaporan(id_laporan);
    PRINT 'FK FK_grp_laporan added.';
END
ELSE
BEGIN
    PRINT 'FK FK_grp_laporan already exists - skipped.';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_comp_laporan'
)
BEGIN
    ALTER TABLE dbKomponenLaporan
        ADD CONSTRAINT FK_comp_laporan
        FOREIGN KEY (id_laporan) REFERENCES dbMasterLaporan(id_laporan);
    PRINT 'FK FK_comp_laporan added.';
END
ELSE
BEGIN
    PRINT 'FK FK_comp_laporan already exists - skipped.';
END
GO

-- ============================================================
-- Verifikasi
-- ============================================================

PRINT '';
PRINT '=== DDL VERIFICATION ===';
PRINT '';

SELECT
    t.name AS table_name,
    SCHEMA_NAME(t.schema_id) AS schema_name,
    p.rows AS row_count
FROM sys.tables t
JOIN sys.partitions p ON p.object_id = t.object_id AND p.index_id IN (0,1)
WHERE t.name IN (
    'dbMasterLaporan', 'dbParameterLaporan', 'dbQueryLaporan',
    'dbKolomLaporan', 'dbGroupLaporan', 'dbKomponenLaporan', 'dbLabelGrup'
)
ORDER BY t.name;

PRINT '';
PRINT '=== INDEXES ===';
PRINT '';

SELECT
    t.name AS table_name,
    i.name AS index_name,
    i.type_desc
FROM sys.indexes i
JOIN sys.tables t ON t.object_id = i.object_id
WHERE t.name IN (
    'dbMasterLaporan', 'dbParameterLaporan', 'dbQueryLaporan',
    'dbKolomLaporan', 'dbGroupLaporan', 'dbKomponenLaporan', 'dbLabelGrup'
)
ORDER BY t.name, i.name;

PRINT '';
PRINT '=== FOREIGN KEYS ===';
PRINT '';

SELECT
    fk.name AS fk_name,
    t.name AS table_name,
    OBJECT_NAME(fk.referenced_object_id) AS referenced_table
FROM sys.foreign_keys fk
JOIN sys.tables t ON t.object_id = fk.parent_object_id
WHERE t.name IN (
    'dbParameterLaporan', 'dbQueryLaporan', 'dbKolomLaporan',
    'dbGroupLaporan', 'dbKomponenLaporan'
)
ORDER BY t.name, fk.name;

PRINT '';
PRINT 'DDL COMPLETE.';
GO
