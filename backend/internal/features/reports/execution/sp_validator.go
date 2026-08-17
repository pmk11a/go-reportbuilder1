package execution

import (
	"fmt"
	"strings"
)

// SPMapping represents the authoritative mapping from Delphi FrmReportPreview.pas
// Source: D:/TestLaB/Golang/Bca/ReportPreview/FrmReportPreview.pas
// Line references:
// - ShowReportPreview: lines 2011-2013
// - SP Assignment: line 4777
type SPMapping struct {
	KodeMenu      string
	ExpectedSP    string
	LaporanName   string
	DelphiLine    int
}

// ValidSPMappings is the single source of truth for SP mappings
// Based on Delphi FrmReportPreview.pas
var ValidSPMappings = map[string]SPMapping{
	// Sales Order (03030101-03030104) - Line 4777
	"03030101": {
		KodeMenu:    "03030101",
		ExpectedSP:  "Sp_ReportSODet",
		LaporanName: "SO Per Nobukti",
		DelphiLine:  4777,
	},
	"03030102": {
		KodeMenu:    "03030102",
		ExpectedSP:  "Sp_ReportSODet",
		LaporanName: "SO Per Barang",
		DelphiLine:  4777,
	},
	"03030103": {
		KodeMenu:    "03030103",
		ExpectedSP:  "Sp_ReportSODet",
		LaporanName: "SO Per Supplier",
		DelphiLine:  4777,
	},
	"03030104": {
		KodeMenu:    "03030104",
		ExpectedSP:  "Sp_ReportSODet",
		LaporanName: "HPP SO",
		DelphiLine:  4777,
	},
	// Note: KP (Kartu Piutang) is at KODEMENU 020401, NOT 03030101
	// KP mappings would be added here if needed in this KODEMENU range
}

// ValidateSPMapping checks if the given SP matches the expected SP from Delphi
// Returns error if mismatch found, nil if valid or not in mapping table
func ValidateSPMapping(kodeMenu, actualSP string) error {
	// Normalize inputs
	kodeMenu = strings.TrimSpace(kodeMenu)
	actualSP = strings.TrimSpace(actualSP)

	// Check if this KODEMENU has a mapping
	mapping, exists := ValidSPMappings[kodeMenu]
	if !exists {
		// Not in our mapping table - skip validation
		return nil
	}

	// Normalize SP names for comparison (remove EXEC prefix, case insensitive)
	expectedSP := strings.TrimPrefix(strings.ToUpper(mapping.ExpectedSP), "EXEC ")
	actualSPUpper := strings.TrimPrefix(strings.ToUpper(actualSP), "EXEC ")

	if expectedSP != actualSPUpper {
		return fmt.Errorf(
			"SP mismatch for KODEMENU %s: expected '%s' (from Delphi line %d: %s), got '%s'",
			kodeMenu,
			mapping.ExpectedSP,
			mapping.DelphiLine,
			mapping.LaporanName,
			actualSP,
		)
	}

	return nil
}

// GetExpectedSP returns the expected SP for a given KODEMENU
func GetExpectedSP(kodeMenu string) (string, bool) {
	mapping, exists := ValidSPMappings[kodeMenu]
	if !exists {
		return "", false
	}
	return mapping.ExpectedSP, true
}

// ValidateSeedMapping validates a list of KODEMENU → SP mappings
// Used during seed validation
func ValidateSeedMapping(kodeMenu, sp string) error {
	expected, ok := GetExpectedSP(kodeMenu)
	if !ok {
		// Not in table, skip
		return nil
	}
	if expected != sp {
		return fmt.Errorf(
			"KODEMENU %s: expected SP '%s', got '%s'. Check Delphi FrmReportPreview.pas line %d",
			kodeMenu, expected, sp,
			ValidSPMappings[kodeMenu].DelphiLine,
		)
	}
	return nil
}
