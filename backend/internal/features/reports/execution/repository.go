package execution

import (
	"context"
	"log"

	"github.com/masza1/dapen-backend/internal/features/reports"
	"gorm.io/gorm"
)

// ReportExecutionRepository implements IReportExecutionRepository for report execution
type ReportExecutionRepository struct {
	db *gorm.DB
}

// NewReportExecutionRepository constructs the report execution repository
func NewReportExecutionRepository(db *gorm.DB) IReportExecutionRepository {
	return &ReportExecutionRepository{db: db}
}

func (r *ReportExecutionRepository) GetReportByID(ctx context.Context, id int) (*reports.SDBMasterLaporan, error) {
	var report reports.SDBMasterLaporan
	err := r.db.WithContext(ctx).Raw(`
		SELECT m.[id_laporan], m.[KODEMENU], m.[nama_laporan], m.[deskripsi],
			   m.[status_aktif], m.[footer_bands], m.[created_at], m.[updated_at]
		FROM dbmasterlaporan m
		WHERE m.[id_laporan] = ?`, id).Scan(&report).Error

	if err != nil {
		return nil, err
	}
	if report.IDLaporan == 0 {
		return nil, gorm.ErrRecordNotFound
	}
	return &report, nil
}

func (r *ReportExecutionRepository) GetReportByKodeMenu(ctx context.Context, kodeMenu string) (*reports.SDBMasterLaporan, error) {
	var report reports.SDBMasterLaporan
	err := r.db.WithContext(ctx).Raw(`
		SELECT m.[id_laporan], m.[KODEMENU], m.[nama_laporan], m.[deskripsi],
			   m.[status_aktif], m.[footer_bands], m.[created_at], m.[updated_at],
				menu.[Keterangan], menu.[L0]
		FROM dbmasterlaporan m
		LEFT JOIN DBMENUREPORT menu ON menu.[KODEMENU] = m.[KODEMENU]
		WHERE m.[KODEMENU] = ? AND m.[status_aktif] = 1`, kodeMenu).Scan(&report).Error

	if err != nil {
		return nil, err
	}
	if report.IDLaporan == 0 {
		return nil, gorm.ErrRecordNotFound
	}
	return &report, nil
}

func (r *ReportExecutionRepository) GetFilters(ctx context.Context, idLaporan int) ([]reports.SDBParameterLaporan, error) {
	var filters []reports.SDBParameterLaporan
	err := r.db.WithContext(ctx).
		Where("[id_laporan] = ?", idLaporan).
		Order("[posisi] ASC").
		Find(&filters).Error
	return filters, err
}

func (r *ReportExecutionRepository) GetDatasets(ctx context.Context, idLaporan int) ([]reports.SDBQueryLaporan, error) {
	var datasets []reports.SDBQueryLaporan
	err := r.db.WithContext(ctx).
		Where("[id_laporan] = ?", idLaporan).
		Order("[urutan] ASC").
		Find(&datasets).Error
	return datasets, err
}

func (r *ReportExecutionRepository) GetAllColumns(ctx context.Context, idLaporan int) (map[string][]reports.SDBKolomLaporan, error) {
	var columns []reports.SDBKolomLaporan
	err := r.db.WithContext(ctx).
		Where("[id_laporan] = ?", idLaporan).
		Order("[nama_dataset] ASC, [urutan_tampil] ASC").
		Find(&columns).Error

	if err != nil {
		return nil, err
	}

	result := make(map[string][]reports.SDBKolomLaporan)
	for _, col := range columns {
		result[col.NamaDataset] = append(result[col.NamaDataset], col)
	}
	return result, nil
}

func (r *ReportExecutionRepository) GetGroups(ctx context.Context, idLaporan int) ([]reports.SDBGroupLaporan, error) {
	var groups []reports.SDBGroupLaporan
	err := r.db.WithContext(ctx).
		Where("[id_laporan] = ?", idLaporan).
		Order("[group_level] ASC, [sort_order] ASC").
		Find(&groups).Error
	return groups, err
}

func (r *ReportExecutionRepository) ExecuteQuery(ctx context.Context, sql string, filters map[string]interface{}, userId string) ([]map[string]interface{}, error) {
	results := make([]map[string]interface{}, 0)
	
	// Build params from filters map
	params := make([]interface{}, 0, len(filters))
	for _, v := range filters {
		params = append(params, v)
	}
	
	err := r.db.WithContext(ctx).Raw(sql, params...).Scan(&results).Error

	if err == nil {
		for i := range results {
			for key, value := range results[i] {
				if bVal, ok := value.([]byte); ok {
					results[i][key] = string(bVal)
				}
			}
		}
	}

	return results, err
}

// ExecuteQueryMulti executes a stored procedure and returns ALL result sets
// as a slice of per-result-set arrays. Used for SPs that return multiple result sets (e.g. sp_LapBankHarian).
func (r *ReportExecutionRepository) ExecuteQueryMulti(ctx context.Context, sql string) ([][]map[string]interface{}, error) {
	rows, err := r.db.WithContext(ctx).Raw(sql).Rows()
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	allSets := make([][]map[string]interface{}, 0)
	setIndex := 0

	for {
		columns, err := rows.Columns()
		if err != nil {
			break // no more result sets
		}

		log.Printf("DEBUG MULTI RESULT SET %d: columns=%v", setIndex, columns)

		// Read all rows in this result set
		set := make([]map[string]interface{}, 0)
		rowIndex := 0
		for rows.Next() {
			vals := make([]interface{}, len(columns))
			valPtrs := make([]interface{}, len(columns))
			for i := range vals {
				valPtrs[i] = &vals[i]
			}
			if err := rows.Scan(valPtrs...); err != nil {
				log.Printf("DEBUG MULTI SCAN ERROR: %v", err)
				continue
			}

			row := make(map[string]interface{})
			for i, col := range columns {
				if vals[i] == nil {
					row[col] = nil
				} else if bVal, ok := vals[i].([]byte); ok {
					row[col] = string(bVal)
				} else {
					row[col] = vals[i]
				}
			}
			set = append(set, row)
			if rowIndex < 2 {
				log.Printf("DEBUG MULTI ROW %d: %v", rowIndex, row)
			}
			rowIndex++
		}
		log.Printf("DEBUG MULTI RESULT SET %d: %d rows", setIndex, len(set))
		allSets = append(allSets, set)
		setIndex++
	}

	return allSets, nil
}

// ExecuteQueryWithParams executes a stored procedure with explicit parameters
func (r *ReportExecutionRepository) ExecuteQueryWithParams(ctx context.Context, sql string, params []interface{}) ([]map[string]interface{}, error) {
	results := make([]map[string]interface{}, 0)
	err := r.db.WithContext(ctx).Raw(sql, params...).Scan(&results).Error

	if err == nil {
		for i := range results {
			for key, value := range results[i] {
				if bVal, ok := value.([]byte); ok {
					results[i][key] = string(bVal)
				}
			}
		}
	}

	return results, err
}

// ExecuteSPQuery executes a stored procedure with inline SQL (no additional params)
// Used when parameters are already embedded in the SQL string
// Uses Rows() to properly capture results from SPs with dynamic EXEC()
func (r *ReportExecutionRepository) ExecuteSPQuery(ctx context.Context, sql string) ([]map[string]interface{}, error) {
	results := make([]map[string]interface{}, 0)

	rows, err := r.db.WithContext(ctx).Raw(sql).Rows()
	if err != nil {
		return results, err
	}
	defer rows.Close()

	// Get column names
	columns, err := rows.Columns()
	if err != nil {
		return results, err
	}

	// Scan each row
	for rows.Next() {
		row := make(map[string]interface{})
		values := make([]interface{}, len(columns))
		valuePtrs := make([]interface{}, len(columns))

		for i := range columns {
			valuePtrs[i] = &values[i]
		}

		if err := rows.Scan(valuePtrs...); err != nil {
			return results, err
		}

		for i, col := range columns {
			val := values[i]
			if b, ok := val.([]byte); ok {
				row[col] = string(b)
			} else {
				row[col] = val
			}
		}
		results = append(results, row)
	}

	if err := rows.Err(); err != nil {
		return results, err
	}

	return results, nil
}

// GetKomponen implements IReportExecutionRepository
func (r *ReportExecutionRepository) GetKomponen(ctx context.Context, idLaporan int) ([]reports.SDBKomponenLaporan, error) {
	var komponen []reports.SDBKomponenLaporan
	err := r.db.WithContext(ctx).
		Where("[id_laporan] = ?", idLaporan).
		Order("[urutan] ASC").
		Find(&komponen).Error
	return komponen, err
}

// GetUserAccess implements IReportExecutionRepository
func (r *ReportExecutionRepository) GetUserAccess(ctx context.Context, kodeMenu string) ([]reports.SUserAccess, error) {
	var access []reports.SUserAccess
	err := r.db.WithContext(ctx).
		Raw(`
			SELECT a.[USERID], COALESCE(p.[FullName], a.[USERID]) as FullName,
				   a.[Access], a.[IsDesign], a.[Isexport]
			FROM DBFLMENUREPORT a
			LEFT JOIN DBFLPASS p ON p.[USERID] = a.[USERID]
			WHERE a.[L1] = ?`, kodeMenu).
		Scan(&access).Error
	return access, err
}

// GetLabelMapping implements IReportExecutionRepository
func (r *ReportExecutionRepository) GetLabelMapping(ctx context.Context, field string) (map[string]string, error) {
	mapping := make(map[string]string)
	// Return empty mapping as default
	return mapping, nil
}
