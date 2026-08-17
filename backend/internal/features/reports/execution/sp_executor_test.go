package execution

import (
	"strings"
	"testing"
	"time"
)

func TestExecuteSPReport_Detail(t *testing.T) {
	config := SPExecutionConfig{
		KodeMenu:   "03030101",
		TglAwal:    time.Date(2025, 8, 1, 0, 0, 0, 0, time.UTC),
		TglAkhir:   time.Date(2025, 8, 31, 0, 0, 0, 0, time.UTC),
		ListItems:  []string{"1.1.01", "IT"},
		ValasIndex: 0,
		IsRekap:    false,
	}

	result := ExecuteSPReport(config)

	if result.HasError {
		t.Fatalf("Unexpected error: %s", result.Message)
	}

	// Verify SQL format
	expectedSQL := "Exec Sp_ReportSODet :0,:1,'08-01-2025','08-31-2025',:2,:3"
	if result.SQL != expectedSQL {
		t.Errorf("SQL mismatch.\nExpected: %s\nGot: %s", expectedSQL, result.SQL)
	}

	// Verify parameters
	if len(result.Params) != 4 {
		t.Fatalf("Expected 4 params, got %d", len(result.Params))
	}

	if result.Params[0] != "T" {
		t.Errorf("Param[0] expected 'T', got %v", result.Params[0])
	}

	if result.Params[1] != "N" {
		t.Errorf("Param[1] expected 'N', got %v", result.Params[1])
	}

	if result.Params[2] != "1.1.01;IT" {
		t.Errorf("Param[2] expected '1.1.01;IT', got %v", result.Params[2])
	}

	if result.Params[3] != 0 {
		t.Errorf("Param[3] expected 0, got %v", result.Params[3])
	}
}

func TestExecuteSPReport_Rekap(t *testing.T) {
	config := SPExecutionConfig{
		KodeMenu: "03030101",
		TglAwal:  time.Date(2025, 8, 1, 0, 0, 0, 0, time.UTC),
		TglAkhir: time.Date(2025, 8, 31, 0, 0, 0, 0, time.UTC),
		ListItems: []string{"1.1.01"},
		IsRekap: true,
	}

	result := ExecuteSPReport(config)

	if result.HasError {
		t.Fatalf("Unexpected error: %s", result.Message)
	}

	// Verify SQL format for Rekap
	expectedSQL := "Exec Sp_reportSORek :0,:1,'08-01-2025','08-31-2025',:2"
	if result.SQL != expectedSQL {
		t.Errorf("SQL mismatch.\nExpected: %s\nGot: %s", expectedSQL, result.SQL)
	}

	// Verify parameters (Rekap has 3 params)
	if len(result.Params) != 3 {
		t.Fatalf("Expected 3 params for Rekap, got %d", len(result.Params))
	}
}

func TestExecuteSPReport_GroupType(t *testing.T) {
	tests := []struct {
		kodeMenu   string
		expectedType string
	}{
		{"03030101", "N"}, // Nobukti
		{"03030102", "B"}, // Barang
		{"03030103", "C"}, // Customer
		{"03030104", "D"}, // HPP
	}

	for _, tt := range tests {
		config := SPExecutionConfig{
			KodeMenu: tt.kodeMenu,
			TglAwal:  time.Date(2025, 8, 1, 0, 0, 0, 0, time.UTC),
			TglAkhir: time.Date(2025, 8, 31, 0, 0, 0, 0, time.UTC),
			IsRekap:  false,
		}

		result := ExecuteSPReport(config)
		if result.Params[1] != tt.expectedType {
			t.Errorf("KodeMenu %s: expected group type %s, got %s",
				tt.kodeMenu, tt.expectedType, result.Params[1])
		}
	}
}

func TestExecuteSPReport_InvalidInput(t *testing.T) {
	// Missing KodeMenu
	config := SPExecutionConfig{
		TglAwal: time.Date(2025, 8, 1, 0, 0, 0, 0, time.UTC),
		TglAkhir: time.Date(2025, 8, 31, 0, 0, 0, 0, time.UTC),
	}
	result := ExecuteSPReport(config)
	if !result.HasError || !strings.Contains(result.Message, "KodeMenu") {
		t.Errorf("Expected error for missing KodeMenu")
	}

	// Missing dates
	config = SPExecutionConfig{
		KodeMenu: "03030101",
	}
	result = ExecuteSPReport(config)
	if !result.HasError || !strings.Contains(result.Message, "TglAwal") {
		t.Errorf("Expected error for missing dates")
	}
}
