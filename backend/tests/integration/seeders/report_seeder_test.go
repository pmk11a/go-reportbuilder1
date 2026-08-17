// Package seeders_test contains integration tests for the report seeders.
// Run with: go test ./tests/integration/seeders/ -v
package seeders_test

import (
	"encoding/json"
	"os"
	"path/filepath"
	"reflect"
	"testing"

	"github.com/masza1/dapen-backend/tests/testhelper"
	"gorm.io/gorm"
)

// seedSnapshot mirrors the structure stored in
// backend/testdata/report_seed_snapshot.json so a drift in seed counts or
// KODEMENU list will fail the test loudly.
type seedSnapshot struct {
	Table       string   `json:"table"`
	ExpectedCnt int      `json:"expected_count"`
	KodeMenus   []string `json:"kode_menus,omitempty"`
}

// TestReportSeederSnapshot ensures that running the report seeders produces
// the expected row counts and KODEMENU catalogue.
//
// Run with -update to regenerate the snapshot from the live DB (useful after
// intentionally adding/removing seed rows):
//
//	go test ./tests/integration/seeders/ -run TestReportSeederSnapshot -update -v
func TestReportSeederSnapshot(t *testing.T) {
	db := testhelper.GetTestDB()
	if db == nil {
		t.Skip("Test DB not initialized — run TestMain first")
	}

	// Build actual snapshot from live DB
	actual := []seedSnapshot{
		{Table: "dbMasterLaporan", ExpectedCnt: countRows(db, "dbmasterlaporan"), KodeMenus: kolamMenus(db)},
		{Table: "dbParameterLaporan", ExpectedCnt: countRows(db, "dbparameterlaporan")},
		{Table: "dbQueryLaporan", ExpectedCnt: countRows(db, "dbquerylaporan")},
		{Table: "dbKolomLaporan", ExpectedCnt: countRows(db, "dbkolomlaporan")},
		{Table: "dbGroupLaporan", ExpectedCnt: countRows(db, "dbgrouplaporan")},
		{Table: "dbLabelGrup", ExpectedCnt: countRows(db, "dblabelgrup")},
	}

	snapPath := filepath.Join(projectRoot(), "backend", "testdata", "report_seed_snapshot.json")

	// -update flag regenerates the snapshot file from live DB
	if os.Getenv("UPDATE_SNAPSHOT") == "1" || flagPassed("-update") {
		bytes, _ := json.MarshalIndent(actual, "", "  ")
		if err := os.MkdirAll(filepath.Dir(snapPath), 0o755); err != nil {
			t.Fatalf("mkdir: %v", err)
		}
		if err := os.WriteFile(snapPath, bytes, 0o644); err != nil {
			t.Fatalf("write snapshot: %v", err)
		}
		t.Logf("snapshot updated: %s", snapPath)
		return
	}

	// Load expected snapshot
	expectedBytes, err := os.ReadFile(snapPath)
	if err != nil {
		t.Fatalf("snapshot file not found at %s — run with -update to generate: %v", snapPath, err)
	}
	var expected []seedSnapshot
	if err := json.Unmarshal(expectedBytes, &expected); err != nil {
		t.Fatalf("invalid snapshot JSON: %v", err)
	}

	// Compare — strict equality ensures both counts and KODEMENU list match
	if !reflect.DeepEqual(actual, expected) {
		got, _ := json.MarshalIndent(actual, "", "  ")
		t.Errorf("seed snapshot mismatch (run with -update to refresh):\n%s", string(got))
	}
}

// flagPassed checks if a test flag like -update was passed.
func flagPassed(name string) bool {
	for _, arg := range os.Args[1:] {
		if arg == name {
			return true
		}
	}
	return false
}

// countRows returns the number of rows in a table.
func countRows(db *gorm.DB, table string) int {
	var count int64
	db.Raw("SELECT COUNT(*) FROM " + table).Scan(&count)
	return int(count)
}

// kolamMenus returns sorted distinct KODEMENU values from dbMasterLaporan.
func kolamMenus(db *gorm.DB) []string {
	var codes []string
	db.Raw("SELECT DISTINCT KODEMENU FROM dbmasterlaporan ORDER BY KODEMENU").Scan(&codes)
	return codes
}

// projectRoot returns the project root (parent of backend/) by walking up from CWD.
// Works whether called from backend/, backend/tests/integration/seeders/, or anywhere else.
func projectRoot() string {
	dir, err := os.Getwd()
	if err != nil {
		return "."
	}
	for {
		// Check for go.mod first
		if _, err := os.Stat(filepath.Join(dir, "go.mod")); err == nil {
			// go.mod found — if we're inside backend/, go up one more level
			if filepath.Base(dir) == "backend" {
				return filepath.Dir(dir)
			}
			return dir
		}
		p := filepath.Dir(dir)
		if p == dir {
			return "."
		}
		dir = p
	}
}