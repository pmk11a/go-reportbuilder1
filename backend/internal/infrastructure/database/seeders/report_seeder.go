package seeders

import (
	"gorm.io/gorm"
)

func seedReports(db *gorm.DB) {
	executeSQLFile(db, "seed_report_tables.sql", "\nGO")
}

func seedDynamicReports(db *gorm.DB) {
	// Pre-flight: validate SP mappings against Delphi source of truth.
	// This catches mistakes like assigning Sp_ReportKartuPiutang to SO KODEMENU 3030101.
	if err := validateSeedSPMappings("seed_dynamic_reports.sql"); err != nil {
		logSeedValidationFailure(err)
		return // Skip seeding to avoid corrupting the database with bad SP mappings
	}
	executeSQLFile(db, "seed_dynamic_reports.sql", "\nGO")
}

func logSeedValidationFailure(err error) {
	// Imported lazily via a side-effect import to avoid cycles; keep simple here.
	// The error is logged by validateSeedSPMappings; this is just an extension point.
}
