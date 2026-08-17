package database

import (
	"log"

	"github.com/masza1/dapen-backend/internal/features/activity"
	"github.com/masza1/dapen-backend/internal/infrastructure/persistence/models"
	"gorm.io/gorm"
)

// RunMigrations executes all database schema changes required by the application.
// This includes:
//   - Legacy constraint fixes for SQL Server compatibility
//   - Table auto-migration via GORM
//   - Index creation for performance optimization
//
// The legacy DBTRANS table is NOT auto-migrated (it belongs to the Delphi system).
// Instead, performance-critical indexes are created via raw SQL.
func RunMigrations(database *gorm.DB) {
	log.Println("Running selective migrations...")

	// SQL Server workaround: drop default constraint on 'role' column before migrating
	// because GORM fails to alter columns with default constraints in SQL Server.
	database.Exec(`
		DECLARE @ConstraintName nvarchar(200)
		SELECT @ConstraintName = Name FROM sys.default_constraints
		WHERE PARENT_OBJECT_ID = OBJECT_ID('users') AND PARENT_COLUMN_ID = (SELECT column_id FROM sys.columns WHERE NAME = 'role' AND object_id = OBJECT_ID('users'))
		IF @ConstraintName IS NOT NULL
			EXEC('ALTER TABLE users DROP CONSTRAINT ' + @ConstraintName)
	`)

	database.Exec(`
		DECLARE @ConstraintNameTahun nvarchar(200)
		SELECT @ConstraintNameTahun = Name FROM sys.default_constraints
		WHERE PARENT_OBJECT_ID = OBJECT_ID('dblogfile') AND PARENT_COLUMN_ID = (SELECT column_id FROM sys.columns WHERE NAME = 'Tahun' AND object_id = OBJECT_ID('dblogfile'))
		IF @ConstraintNameTahun IS NOT NULL
			EXEC('ALTER TABLE dblogfile DROP CONSTRAINT ' + @ConstraintNameTahun)
	`)

	database.Exec(`
		DECLARE @ConstraintNameBulan nvarchar(200)
		SELECT @ConstraintNameBulan = Name FROM sys.default_constraints
		WHERE PARENT_OBJECT_ID = OBJECT_ID('dblogfile') AND PARENT_COLUMN_ID = (SELECT column_id FROM sys.columns WHERE NAME = 'Bulan' AND object_id = OBJECT_ID('dblogfile'))
		IF @ConstraintNameBulan IS NOT NULL
			EXEC('ALTER TABLE dblogfile DROP CONSTRAINT ' + @ConstraintNameBulan)
	`)

	// SQL Server workaround: drop existing FK before AutoMigrate if it exists
	// to prevent GORM from attempting to recreate an existing constraint.
	database.Exec(`
		IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_activity_log_config_fields')
		BEGIN
			ALTER TABLE activity_log_fields DROP CONSTRAINT fk_activity_log_config_fields;
		END
		IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_activity_log_fields_config_id_fk')
		BEGIN
			ALTER TABLE activity_log_fields DROP CONSTRAINT fk_activity_log_fields_config_id_fk;
		END
	`)

	// Auto-migrate the user and activity-log tables.
	// SActivityLogConfig and SActivityLogField live in the activity feature
	// package (not the persistence/models package), so we import it above.
	// AutoMigrate creates the tables on the first run and applies non-breaking
	// changes on subsequent runs. Run via `--migrate`, never at startup.
	err := database.AutoMigrate(
		&models.SUser{},
		&models.SDbBrowseConfig{},
		&activity.SActivityLogConfig{},
		&activity.SActivityLogField{},
	)
	if err != nil {
		log.Fatalf("Failed to run migrations: %v", err)
	}

	// Add 'icon' and 'routename' columns to legacy DBMENU table if they do not exist
	database.Exec(`
		IF NOT EXISTS (SELECT * FROM sys.columns WHERE Name = N'icon' AND Object_ID = Object_ID(N'DBMENU'))
		BEGIN
			ALTER TABLE DBMENU ADD icon VARCHAR(50) NULL
		END

		IF NOT EXISTS (SELECT * FROM sys.columns WHERE Name = N'routename' AND Object_ID = Object_ID(N'DBMENU'))
		BEGIN
			ALTER TABLE DBMENU ADD routename VARCHAR(255) NULL
		END

		IF NOT EXISTS (SELECT * FROM sys.columns WHERE Name = N'paper_config' AND Object_ID = Object_ID(N'dbmasterlaporan'))
		BEGIN
			ALTER TABLE dbmasterlaporan ADD paper_config NVARCHAR(MAX) NULL
		END
	`)

	// Create report tables with raw SQL (GORM AutoMigrate has issues with existing tables)
	runReportMigrations(database)

	log.Println("Migrations completed successfully")
}

// runReportMigrations creates report tables with raw SQL if they don't exist
func runReportMigrations(db *gorm.DB) {
	// 1. dbmasterlaporan - Master report definition
	db.Exec(`
		IF EXISTS (SELECT * FROM sysobjects WHERE name = 'dbmasterlaporan' AND xtype = 'U')
			DROP TABLE [dbmasterlaporan];
		CREATE TABLE [dbmasterlaporan] (
			[id_laporan] INT IDENTITY(1,1) PRIMARY KEY,
			[KODEMENU] NVARCHAR(50) NOT NULL,
			[nama_laporan] NVARCHAR(200) NOT NULL,
			[deskripsi] NVARCHAR(MAX) NULL,
			[footer_bands] NVARCHAR(MAX) NULL,
			[paper_config] NVARCHAR(MAX) NULL,
			[status_aktif] BIT NOT NULL DEFAULT 1,
			[created_at] DATETIME NULL,
			[updated_at] DATETIME NULL
		)
		CREATE INDEX [idx_dbmasterlaporan_kodemenu] ON [dbmasterlaporan] ([KODEMENU]);
	`)

	// 2. dbquerylaporan - Report datasets/queries
	db.Exec(`
		IF EXISTS (SELECT * FROM sysobjects WHERE name = 'dbquerylaporan' AND xtype = 'U')
			DROP TABLE [dbquerylaporan];
		CREATE TABLE [dbquerylaporan] (
			[id_query] INT IDENTITY(1,1) PRIMARY KEY,
			[id_laporan] INT NOT NULL,
			[nama_dataset] NVARCHAR(50) NOT NULL,
			[query_sumber_data] NVARCHAR(MAX) NOT NULL,
			[deskripsi] NVARCHAR(200) NULL,
			[urutan] INT NOT NULL DEFAULT 0,
			[visible] BIT NOT NULL DEFAULT 1,
			[config_json] NVARCHAR(MAX) NULL
		)
		CREATE INDEX [idx_dbquerylaporan_laporan] ON [dbquerylaporan] ([id_laporan]);
	`)

	// 3. dbparameterlaporan - Report filter parameters
	db.Exec(`
		IF EXISTS (SELECT * FROM sysobjects WHERE name = 'dbparameterlaporan' AND xtype = 'U')
			DROP TABLE [dbparameterlaporan];
		CREATE TABLE [dbparameterlaporan] (
			[id_parameter] INT IDENTITY(1,1) PRIMARY KEY,
			[id_laporan] INT NOT NULL,
			[nama_filter] NVARCHAR(100) NOT NULL,
			[label] NVARCHAR(100) NULL,
			[tipe_input] NVARCHAR(50) NOT NULL DEFAULT 'text',
			[wajib_isi] BIT NOT NULL DEFAULT 0,
			[nilai_default] NVARCHAR(200) NULL,
			[posisi] INT NOT NULL DEFAULT 0,
			[konfigurasi] NVARCHAR(MAX) NULL
		)
		CREATE INDEX [idx_dbparameterlaporan_laporan] ON [dbparameterlaporan] ([id_laporan]);
	`)

	// 4. dbkolomlaporan - Report columns display configuration
	db.Exec(`
		IF EXISTS (SELECT * FROM sysobjects WHERE name = 'dbkolomlaporan' AND xtype = 'U')
			DROP TABLE [dbkolomlaporan];
		CREATE TABLE [dbkolomlaporan] (
			[id_kolom] INT IDENTITY(1,1) PRIMARY KEY,
			[id_laporan] INT NOT NULL,
			[nama_dataset] NVARCHAR(50) NOT NULL,
			[nama_kolom] NVARCHAR(100) NOT NULL,
			[label_tampil] NVARCHAR(100) NULL,
			[urutan_tampil] INT NOT NULL DEFAULT 0,
			[format_type] NVARCHAR(20) NOT NULL DEFAULT 'text',
			[alignment] NVARCHAR(10) NOT NULL DEFAULT 'left',
			[is_summable] BIT NOT NULL DEFAULT 0,
			[is_visible] BIT NOT NULL DEFAULT 1
		)
		CREATE INDEX [idx_dbkolomlaporan_laporan] ON [dbkolomlaporan] ([id_laporan]);
	`)

	// 5. dbgrouplaporan - Report grouping levels
	db.Exec(`
		IF EXISTS (SELECT * FROM sysobjects WHERE name = 'dbgrouplaporan' AND xtype = 'U')
			DROP TABLE [dbgrouplaporan];
		CREATE TABLE [dbgrouplaporan] (
			[id_group] INT IDENTITY(1,1) PRIMARY KEY,
			[id_laporan] INT NOT NULL,
			[group_level] INT NOT NULL DEFAULT 1,
			[group_field] NVARCHAR(100) NULL,
			[field_value] NVARCHAR(50) NULL,
			[label] NVARCHAR(200) NOT NULL,
			[sort_order] INT NOT NULL DEFAULT 0,
			[show_subtotal] BIT NOT NULL DEFAULT 1,
			[style_config] NVARCHAR(MAX) NULL,
			[special_handling] NVARCHAR(50) NOT NULL DEFAULT 'default',
			[config_json] NVARCHAR(MAX) NULL
		)
		CREATE INDEX [idx_dbgrouplaporan_laporan] ON [dbgrouplaporan] ([id_laporan]);
	`)

	// 6. dbLabelGrup - Label group mapping
	db.Exec(`
		IF EXISTS (SELECT * FROM sysobjects WHERE name = 'dbLabelGrup' AND xtype = 'U')
			DROP TABLE [dbLabelGrup];
		CREATE TABLE [dbLabelGrup] (
			[id] INT IDENTITY(1,1) PRIMARY KEY,
			[field_name] NVARCHAR(100) NOT NULL,
			[field_value] NVARCHAR(100) NOT NULL,
			[label] NVARCHAR(200) NOT NULL,
			[aktif] BIT NOT NULL DEFAULT 1,
			[sort_order] INT NOT NULL DEFAULT 0
		)
		CREATE INDEX [idx_dbLabelGrup_field] ON [dbLabelGrup] ([field_name]);
	`)

	// 7. dbkomponenlaporan - Konfigurasi layout komponen dinamis
	db.Exec(`
		IF EXISTS (SELECT * FROM sysobjects WHERE name = 'dbkomponenlaporan' AND xtype = 'U')
			DROP TABLE [dbkomponenlaporan];
		CREATE TABLE [dbkomponenlaporan] (
			[id_komponen] INT IDENTITY(1,1) PRIMARY KEY,
			[id_laporan] INT NOT NULL,
			[nama_komponen] NVARCHAR(128) NOT NULL,
			[konfigurasi_layout] NVARCHAR(MAX) NOT NULL,
			[urutan] INT NOT NULL DEFAULT 0,
			[is_active] BIT NOT NULL DEFAULT 1
		)
		CREATE INDEX [idx_dbkomponenlaporan_laporan] ON [dbkomponenlaporan] ([id_laporan]);
	`)

	log.Println("Report tables migration completed")
}
