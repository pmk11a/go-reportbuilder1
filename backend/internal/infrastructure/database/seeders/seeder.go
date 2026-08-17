package seeders

import (
	"log"
	"os"
	"strings"

	"gorm.io/gorm"
)

func SeedDatabase(database *gorm.DB) {
	log.Println("Checking for seeds...")
	seedSuperAdmin(database)
	seedDBMenu(database)
	seedReports(database)
	seedDynamicReports(database)
	seedDbBrowseConfigs(database)
}

// executeSQLFile runs a given SQL file by splitting its contents by a delimiter (e.g. "\nGO" or ";")
func executeSQLFile(db *gorm.DB, filename string, delimiter string) {
	log.Printf("Seeding from %s...", filename)

	content, err := os.ReadFile(filename)
	if err != nil {
		log.Printf("Failed to read %s: %v. Make sure the file exists in the root directory.", filename, err)
		return
	}

	sqlScript := string(content)
	batches := strings.Split(sqlScript, delimiter)

	for i, batch := range batches {
		batch = strings.TrimSpace(batch)
		if batch == "" || strings.HasPrefix(batch, "USE ") {
			continue // Skip empty batches or USE statements since GORM connects to the specific DB directly
		}

		// Remove trailing GO if any (some formatting might leave it)
		if strings.HasSuffix(strings.ToUpper(batch), "GO") {
			batch = batch[:len(batch)-2]
		}
		batch = strings.TrimSpace(batch)

		if batch == "" {
			continue
		}

		err := db.Exec(batch).Error
		if err != nil {
			log.Printf("Error executing batch %d in %s: %v\nBatch content: %s", i+1, filename, err, batch[:minInt(100, len(batch))]+"...")
		}
	}

	log.Printf("Finished seeding %s.", filename)
}

func minInt(a, b int) int {
	if a < b {
		return a
	}
	return b
}
