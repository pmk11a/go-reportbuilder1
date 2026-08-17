package execution

import (
	"testing"
)

func TestValidateSPMapping(t *testing.T) {
	tests := []struct {
		name       string
		kodeMenu   string
		sp         string
		wantErr    bool
		errContain string
	}{
		// Valid mappings - SO reports
		{"SO Per Nobukti valid", "03030101", "Sp_ReportSODet", false, ""},
		{"SO Per Barang valid", "03030102", "Sp_ReportSODet", false, ""},
		{"SO Per Supplier valid", "03030103", "Sp_ReportSODet", false, ""},
		{"HPP SO valid", "03030104", "Sp_ReportSODet", false, ""},

		// Invalid - KP mistakenly assigned to SO KODEMENU
		{"KP assigned to SO KODEMENU (ERROR)", "03030101", "Sp_ReportKartuPiutang", true, "SP mismatch"},
		{"KP assigned to SO KODEMENU case insensitive", "03030102", "sp_reportkartupiutang", true, "SP mismatch"},

		// Unknown KODEMENU - should pass
		{"Unknown KODEMENU", "9999999", "Something", false, ""},

		// With EXEC prefix
		{"With EXEC prefix", "03030101", "EXEC Sp_ReportSODet", false, ""},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			err := ValidateSPMapping(tt.kodeMenu, tt.sp)
			if (err != nil) != tt.wantErr {
				t.Errorf("ValidateSPMapping(%q, %q) error = %v, wantErr %v",
					tt.kodeMenu, tt.sp, err, tt.wantErr)
				return
			}
			if err != nil && tt.errContain != "" && !contains(err.Error(), tt.errContain) {
				t.Errorf("ValidateSPMapping() error = %v, should contain %q",
					err, tt.errContain)
			}
		})
	}
}

func TestGetExpectedSP(t *testing.T) {
	tests := []struct {
		name       string
		kodeMenu   string
		wantSP     string
		wantExists bool
	}{
		{"SO Per Nobukti", "03030101", "Sp_ReportSODet", true},
		{"SO Per Barang", "03030102", "Sp_ReportSODet", true},
		{"Unknown", "9999999", "", false},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			sp, exists := GetExpectedSP(tt.kodeMenu)
			if exists != tt.wantExists {
				t.Errorf("GetExpectedSP(%q) exists = %v, want %v", tt.kodeMenu, exists, tt.wantExists)
			}
			if exists && sp != tt.wantSP {
				t.Errorf("GetExpectedSP(%q) = %q, want %q", tt.kodeMenu, sp, tt.wantSP)
			}
		})
	}
}

func TestInvalidKPSpMapping(t *testing.T) {
	// This test ensures we catch the common mistake:
	// Assigning Sp_ReportKartuPiutang to KODEMENU 3030101-3030104
	// (which are actually SO reports)
	invalidPairs := []struct {
		kodeMenu string
		sp       string
	}{
		{"03030101", "Sp_ReportKartuPiutang"},
		{"03030102", "Sp_ReportKartuPiutang"},
		{"03030103", "Sp_ReportKartuPiutang"},
		{"03030104", "Sp_ReportKartuPiutang"},
	}

	for _, p := range invalidPairs {
		err := ValidateSPMapping(p.kodeMenu, p.sp)
		if err == nil {
			t.Errorf("Should reject invalid SP mapping for %s = %s", p.kodeMenu, p.sp)
		}
	}
}

func contains(s, substr string) bool {
	return len(s) >= len(substr) && (s == substr || len(s) > 0 && containsHelper(s, substr))
}

func containsHelper(s, substr string) bool {
	for i := 0; i <= len(s)-len(substr); i++ {
		if s[i:i+len(substr)] == substr {
			return true
		}
	}
	return false
}
