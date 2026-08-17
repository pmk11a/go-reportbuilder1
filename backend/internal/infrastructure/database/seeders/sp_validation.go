package seeders

import (
	"log"
	"regexp"
	"strings"

	"github.com/masza1/dapen-backend/internal/features/reports/execution"
)

// validateSeedSPMappings parses the SQL seed file and validates each
// INSERT INTO dbquerylaporan with an EXEC Sp_xxx statement against
// the authoritative Delphi mapping in execution.ValidSPMappings.
//
// This is a safety net to prevent the mistake of assigning the wrong SP
// to a KODEMENU (e.g., Sp_ReportKartuPiutang to SO KODEMENU 3030101).
func validateSeedSPMappings(filename string) error {
	log.Printf("[SAFETY] Validating SP mappings in %s...", filename)

	content, err := readFile(filename)
	if err != nil {
		return err
	}

	// Pattern to extract: KODEMENU = 'xxxxxxx' ... 'EXEC Sp_xxx'
	// We need a regex that captures the KODEMENU and the SP within each INSERT block.
	// Since seed may have multiple KODEMENU entries, we'll scan block-by-block.
	blockRegex := regexp.MustCompile(`(?si)INSERT INTO\s+dbquerylaporan[\s\S]+?FROM\s+dbmasterlaporan\s+WHERE\s+KODEMENU\s*=\s*'([^']+)'`)
	spRegex := regexp.MustCompile(`(?i)'EXEC\s+(Sp_\w+)'`)

	matches := blockRegex.FindAllStringSubmatch(content, -1)
	if len(matches) == 0 {
		log.Printf("[SAFETY] No INSERT INTO dbquerylaporan blocks found (OK if report uses dynamic SQL)")
		return nil
	}

	var failures []string
	for _, m := range matches {
		kodeMenu := strings.TrimSpace(m[1])
		block := m[0]
		spMatches := spRegex.FindStringSubmatch(block)
		if len(spMatches) < 2 {
			continue // No EXEC Sp_xxx in this block - skip (e.g., placeholder)
		}
		sp := spMatches[1]

		// Use validator
		expected, hasMapping := execution.GetExpectedSP(kodeMenu)
		if !hasMapping {
			// No mapping registered yet for this KODEMENU - skip but log
			log.Printf("[SAFETY] No Delphi mapping registered for KODEMENU=%s (using SP=%s). Add it to sp_validator.go to enforce.", kodeMenu, sp)
			continue
		}

		if !strings.EqualFold(expected, sp) {
			failures = append(failures, "KODEMENU "+kodeMenu+": expected '"+expected+"', got '"+sp+"'")
		}
	}

	if len(failures) > 0 {
		log.Printf("[SAFETY] ❌ SP mapping validation FAILED for %s:", filename)
		for _, f := range failures {
			log.Printf("  - %s", f)
		}
		log.Printf("[SAFETY] Fix by editing seed_dynamic_reports.sql and re-run. Cross-check with D:/TestLaB/Golang/Bca/ReportPreview/FrmReportPreview.pas")
		return &SeedValidationError{Failures: failures}
	}

	log.Printf("[SAFETY] ✅ All SP mappings match Delphi source.")
	return nil
}

// readFile is a tiny helper to keep imports tidy.
func readFile(path string) (string, error) {
	// Use os.ReadFile to keep behavior identical to executeSQLFile
	b, err := osReadFile(path)
	if err != nil {
		return "", err
	}
	return string(b), nil
}

// SeedValidationError carries per-KODEMENU validation failures
type SeedValidationError struct {
	Failures []string
}

func (e *SeedValidationError) Error() string {
	return "seed SP mapping validation failed: " + strings.Join(e.Failures, "; ")
}