// Package seeders_test contains integration tests for the report seeders.
package seeders_test

import (
	"os"
	"testing"

	"github.com/masza1/dapen-backend/tests/testhelper"
)

// TestMain initializes the test database before running any tests in this package.
func TestMain(m *testing.M) {
	// Create a minimal testing.T for InitTestDB
	t := &testing.T{}
	db := testhelper.InitTestDB(t)
	if db == nil {
		os.Exit(1)
	}
	testhelper.SetTestDB(db)
	os.Exit(m.Run())
}