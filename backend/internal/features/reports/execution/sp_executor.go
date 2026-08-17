package execution

import (
	"fmt"
	"strings"
	"time"
)

// SPExecutionConfig konfigurasi eksekusi SP (4 parameters sesuai Delphi)
type SPExecutionConfig struct {
	KodeMenu   string
	TglAwal    time.Time
	TglAkhir   time.Time
	ListItems  []string // Gabungan Perkiraan+Divisi+KodePiutang
	ValasIndex int      // CboOto index
	IsRekap    bool     // Cbojns index
	SReport    string   // @SReport parameter (optional, default="T")
}

// SPExecutionResult hasil eksekusi SP
type SPExecutionResult struct {
	SQL      string
	Params   []interface{}
	HasError bool
	Message  string
}

// ExecuteSPReport executes report SP following Delphi pattern
// SP Signature: Exec Sp_ReportSODet :0,:1,'TglAwal','TglAkhir',:2,:3
// Parameters:
//   :0 = 'T' (hardcoded)
//   :1 = Group Type ('N'/'B'/'C'/'D')
//   :2 = TglAwal (hardcoded date string)
//   :3 = TglAkhir (hardcoded date string)
//   :4 = ListItems (ListBox, separator ";")
//   :5 = ValasIndex (CboOto)
//   :6 = SReport (optional, default "T")
func ExecuteSPReport(config SPExecutionConfig) *SPExecutionResult {
	result := &SPExecutionResult{}

	// 1. Validasi input
	if config.KodeMenu == "" {
		result.HasError = true
		result.Message = "KodeMenu required"
		return result
	}
	if config.TglAwal.IsZero() || config.TglAkhir.IsZero() {
		result.HasError = true
		result.Message = "TglAwal dan TglAkhir required"
		return result
	}

	// 2. Format tanggal ke MM-DD-YYYY (sesuai Delphi FormatDateTime)
	dateFmt := "01-02-2006"
	tglAwalStr := config.TglAwal.Format(dateFmt)
	tglAkhirStr := config.TglAkhir.Format(dateFmt)

	// 3. Tentukan group type (N/B/C/D) berdasarkan KODEMENU
	groupType := getGroupType(config.KodeMenu)

	// 4. Default SReport = "T" jika tidak diisi
	sReport := config.SReport
	if sReport == "" {
		sReport = "T"
	}

	// 5. Gabung list items dengan separator ";"
	listStr := strings.Join(config.ListItems, ";")

	// 6. Tentukan SP dan parameter
	if config.IsRekap {
		// Rekap mode: Exec Sp_reportSORek :0,:1,'TglAwal','TglAkhir',:2
		result.SQL = fmt.Sprintf("Exec Sp_reportSORek :0,:1,'%s','%s',:2",
			tglAwalStr, tglAkhirStr)
		result.Params = []interface{}{
			sReport,     // Parameters[0]
			groupType,   // Parameters[1]
			listStr,     // Parameters[2]
		}
	} else {
		// Detail mode: Exec Sp_ReportSODet :0,:1,'TglAwal','TglAkhir',:2,:3
		result.SQL = fmt.Sprintf("Exec Sp_ReportSODet :0,:1,'%s','%s',:2,:3",
			tglAwalStr, tglAkhirStr)
		result.Params = []interface{}{
			sReport,           // Parameters[0] - @SReport
			groupType,         // Parameters[1] - N/B/C/D
			listStr,           // Parameters[2] - ListBox items
			config.ValasIndex, // Parameters[3] - CboOto index
		}
	}

	return result
}

// getGroupType returns group type based on KODEMENU
// N = Nobukti, B = Barang, C = Customer, D = HPP
func getGroupType(kodeMenu string) string {
	switch kodeMenu {
	case "03030101":
		return "N" // SO Per Nobukti
	case "03030102":
		return "B" // SO Per Barang
	case "03030103":
		return "C" // SO Per Customer
	case "03030104":
		return "D" // HPP SO
	default:
		return "N"
	}
}
