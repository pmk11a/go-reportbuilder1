package reports

import (
	"context"
	"encoding/json"
	"fmt"
	"regexp"
	"strings"

	"github.com/masza1/dapen-backend/internal/shared/pagination"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

// IReportsRepository defines the persistence contract for the reports domain.
type IReportsRepository interface {
	// Report CRUD
	ListReports(ctx context.Context, search string, page, limit int) ([]SDBMasterLaporan, int64, error)
	GetReportByID(ctx context.Context, id int) (*SDBMasterLaporan, error)
	GetReportByKodeMenu(ctx context.Context, kodeMenu string) (*SDBMasterLaporan, error)
	CreateReport(ctx context.Context, data *SDBMasterLaporan) (int, error)
	UpdateReport(ctx context.Context, id int, data *SDBMasterLaporan) error
	DeleteReport(ctx context.Context, id int) error

	// Filters
	GetFilters(ctx context.Context, idLaporan int) ([]SDBParameterLaporan, error)
	CreateFilter(ctx context.Context, data *SDBParameterLaporan) (int, error)
	UpdateFilter(ctx context.Context, id int, data *SDBParameterLaporan) error
	DeleteFilter(ctx context.Context, id int) error
	ReorderFilters(ctx context.Context, idLaporan int, orders []SFilterOrder) error

	// Datasets
	GetDatasets(ctx context.Context, idLaporan int) ([]SDBQueryLaporan, error)
	CreateDataset(ctx context.Context, data *SDBQueryLaporan) (int, error)
	UpdateDataset(ctx context.Context, id int, data *SDBQueryLaporan) error
	DeleteDataset(ctx context.Context, id int) error

	// Columns
	GetAllColumns(ctx context.Context, idLaporan int) (map[string][]SDBKolomLaporan, error)
	CreateColumn(ctx context.Context, data *SDBKolomLaporan) (int, error)
	UpdateColumn(ctx context.Context, id int, data *SDBKolomLaporan) error
	DeleteColumn(ctx context.Context, id int) error

	// Groups
	GetGroups(ctx context.Context, idLaporan int) ([]SDBGroupLaporan, error)
	CreateGroup(ctx context.Context, data *SDBGroupLaporan) (int, error)
	UpdateGroup(ctx context.Context, id int, data *SDBGroupLaporan) error
	DeleteGroup(ctx context.Context, id int) error

	// Komponen
	GetKomponen(ctx context.Context, idLaporan int) ([]SDBKomponenLaporan, error)
	CreateKomponen(ctx context.Context, data *SDBKomponenLaporan) (int, error)
	UpdateKomponen(ctx context.Context, id int, data *SDBKomponenLaporan) error
	DeleteKomponen(ctx context.Context, id int) error
	DeleteKomponenByReportID(ctx context.Context, idLaporan int) error
	UpsertKomponenByName(ctx context.Context, idLaporan int, namaKomponen string, data *SDBKomponenLaporan) error

	// User Access
	GetUserAccess(ctx context.Context, kodeMenu string) ([]SUserAccess, error)
	GrantAccess(ctx context.Context, kodeMenu string, data *SDBFLMenuReport) error
	RevokeAccess(ctx context.Context, kodeMenu string, userId string) error
	GetAllUsers(ctx context.Context) ([]SUserListResponse, error)

	// Menu
	GetAvailableKodeMenu(ctx context.Context) ([]SAvailableKodeMenuResponse, error)
	GetMenuTreeForUser(ctx context.Context, userId string, search string) ([]SMenuReportItem, error)


	// Query Preview & Execution
	PreviewQuery(ctx context.Context, sql string, filters map[string]interface{}) ([]map[string]interface{}, []string, error)
	ExecuteQuery(ctx context.Context, sql string, filters map[string]interface{}, userId string) ([]map[string]interface{}, error)

	// Label Mapping
	GetLabelMapping(ctx context.Context, field string) (map[string]string, error)
}

type reportsRepository struct {
	db *gorm.DB
}

// NewReportsRepository constructs the default SQL-Server-backed reports repository.
func NewReportsRepository(db *gorm.DB) IReportsRepository {
	return &reportsRepository{db: db}
}

// ============================================================================
// Report CRUD
// ============================================================================

func (r *reportsRepository) ListReports(ctx context.Context, search string, page, limit int) ([]SDBMasterLaporan, int64, error) {
	var reports []SDBMasterLaporan
	baseSQL := `
		SELECT m.[id_laporan], m.[KODEMENU], m.[nama_laporan], m.[deskripsi],
			   m.[status_aktif], m.[footer_bands], m.[created_at], m.[updated_at],
			   menu.[Keterangan], menu.[L0]
		FROM dbmasterlaporan m
		LEFT JOIN DBMENUREPORT menu ON menu.[KODEMENU] = m.[KODEMENU]`

	var whereSQL string
	var args []interface{}

	if search != "" {
		whereSQL = " WHERE m.[nama_laporan] LIKE ? OR m.[KODEMENU] LIKE ?"
		searchParam := "%" + search + "%"
		args = append(args, searchParam, searchParam)
	}

	fullSQL := baseSQL
	if whereSQL != "" {
		fullSQL += whereSQL
	}
	// Use paginated find
	total, err := pagination.PaginatedFind(r.db.WithContext(ctx), &reports, fullSQL, "[nama_laporan]", page, limit, args...)
	if err != nil {
		return nil, 0, err
	}

	return reports, total, nil
}

func (r *reportsRepository) GetReportByID(ctx context.Context, id int) (*SDBMasterLaporan, error) {
	var report SDBMasterLaporan
	err := r.db.WithContext(ctx).Raw(`
		SELECT m.[id_laporan], m.[KODEMENU], m.[nama_laporan], m.[deskripsi],
			   m.[status_aktif], m.[footer_bands], m.[created_at], m.[updated_at],
			   menu.[Keterangan], menu.[L0]
		FROM dbmasterlaporan m
		LEFT JOIN DBMENUREPORT menu ON menu.[KODEMENU] = m.[KODEMENU]
		WHERE m.[id_laporan] = ?`, id).Scan(&report).Error

	if err != nil {
		return nil, err
	}
	if report.IDLaporan == 0 {
		return nil, gorm.ErrRecordNotFound
	}

	return &report, nil
}

func (r *reportsRepository) GetReportByKodeMenu(ctx context.Context, kodeMenu string) (*SDBMasterLaporan, error) {
	var report SDBMasterLaporan
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

func (r *reportsRepository) CreateReport(ctx context.Context, data *SDBMasterLaporan) (int, error) {
	err := r.db.WithContext(ctx).Create(data).Error
	return data.IDLaporan, err
}

func (r *reportsRepository) UpdateReport(ctx context.Context, id int, data *SDBMasterLaporan) error {
	return r.db.WithContext(ctx).Exec(`
		UPDATE dbmasterlaporan
		SET [nama_laporan] = ?, [deskripsi] = ?, [status_aktif] = ?, [footer_bands] = ?, [updated_at] = GETDATE()
		WHERE [id_laporan] = ?`,
		data.NamaLaporan, data.Deskripsi, data.StatusAktif, data.FooterBands, id,
	).Error
}

func (r *reportsRepository) DeleteReport(ctx context.Context, id int) error {
	return r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		// Delete cascade: filters, datasets, columns, groups
		if err := tx.Exec("DELETE FROM dbparameterlaporan WHERE [id_laporan] = ?", id).Error; err != nil {
			return err
		}
		if err := tx.Exec("DELETE FROM dbquerylaporan WHERE [id_laporan] = ?", id).Error; err != nil {
			return err
		}
		if err := tx.Exec("DELETE FROM dbkolomlaporan WHERE [id_laporan] = ?", id).Error; err != nil {
			return err
		}
		if err := tx.Exec("DELETE FROM dbgrouplaporan WHERE [id_laporan] = ?", id).Error; err != nil {
			return err
		}
		if err := tx.Exec("DELETE FROM dbkomponenlaporan WHERE [id_laporan] = ?", id).Error; err != nil {
			return err
		}
		return tx.Exec("DELETE FROM dbmasterlaporan WHERE [id_laporan] = ?", id).Error
	})
}

// ============================================================================
// Filters
// ============================================================================

func (r *reportsRepository) GetFilters(ctx context.Context, idLaporan int) ([]SDBParameterLaporan, error) {
	var filters []SDBParameterLaporan
	err := r.db.WithContext(ctx).
		Where("[id_laporan] = ?", idLaporan).
		Order("[posisi] ASC").
		Find(&filters).Error
	return filters, err
}

func (r *reportsRepository) CreateFilter(ctx context.Context, data *SDBParameterLaporan) (int, error) {
	// Get max posisi
	var maxPosisi int
	r.db.WithContext(ctx).Raw("SELECT ISNULL(MAX([posisi]), -1) FROM dbparameterlaporan WHERE [id_laporan] = ?", data.IDLaporan).Scan(&maxPosisi)

	posisi := data.Posisi
	if posisi == 0 {
		data.Posisi = maxPosisi + 1
	}

	err := r.db.WithContext(ctx).Create(data).Error
	return data.IDParameter, err
}

func (r *reportsRepository) UpdateFilter(ctx context.Context, id int, data *SDBParameterLaporan) error {
	res := r.db.WithContext(ctx).Exec(`
		UPDATE dbparameterlaporan
		SET [nama_filter] = ?, [label] = ?, [tipe_input] = ?, [wajib_isi] = ?, [nilai_default] = ?, [posisi] = ?, [konfigurasi] = ?
		WHERE [id_parameter] = ?`,
		data.NamaFilter, data.Label, data.TipeInput, data.WajibIsi, data.NilaiDefault, data.Posisi, data.Konfigurasi, id,
	)
	if res.Error != nil {
		return res.Error
	}
	if res.RowsAffected == 0 {
		return gorm.ErrRecordNotFound
	}
	return nil
}

func (r *reportsRepository) DeleteFilter(ctx context.Context, id int) error {
	return r.db.WithContext(ctx).Delete(&SDBParameterLaporan{}, "[id_parameter] = ?", id).Error
}

func (r *reportsRepository) ReorderFilters(ctx context.Context, idLaporan int, orders []SFilterOrder) error {
	return r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		for _, order := range orders {
			if err := tx.Exec(
				"UPDATE dbparameterlaporan SET [posisi] = ? WHERE [id_parameter] = ? AND [id_laporan] = ?",
				order.Posisi, order.ID, idLaporan,
			).Error; err != nil {
				return err
			}
		}
		return nil
	})
}

// ============================================================================
// Datasets
// ============================================================================

func (r *reportsRepository) GetDatasets(ctx context.Context, idLaporan int) ([]SDBQueryLaporan, error) {
	var datasets []SDBQueryLaporan
	err := r.db.WithContext(ctx).
		Where("[id_laporan] = ?", idLaporan).
		Order("[urutan] ASC").
		Find(&datasets).Error
	return datasets, err
}

func (r *reportsRepository) CreateDataset(ctx context.Context, data *SDBQueryLaporan) (int, error) {
	// Get max urutan
	var maxUrutan int
	r.db.WithContext(ctx).Raw("SELECT ISNULL(MAX([urutan]), 0) FROM dbquerylaporan WHERE [id_laporan] = ?", data.IDLaporan).Scan(&maxUrutan)

	urutan := data.Urutan
	if urutan == 0 {
		data.Urutan = maxUrutan + 1
	}

	err := r.db.WithContext(ctx).Create(data).Error
	return data.IDQuery, err
}

func (r *reportsRepository) UpdateDataset(ctx context.Context, id int, data *SDBQueryLaporan) error {
	return r.db.WithContext(ctx).Exec(`
		UPDATE dbquerylaporan
		SET [nama_dataset] = ?, [query_sumber_data] = ?, [deskripsi] = ?, [urutan] = ?, [visible] = ?, [config_json] = ?
		WHERE [id_query] = ?`,
		data.NamaDataset, data.QuerySumberData, data.Deskripsi, data.Urutan, data.Visible, data.ConfigJSON, id,
	).Error
}

func (r *reportsRepository) DeleteDataset(ctx context.Context, id int) error {
	return r.db.WithContext(ctx).Delete(&SDBQueryLaporan{}, "[id_query] = ?", id).Error
}

// ============================================================================
// Columns
// ============================================================================

func (r *reportsRepository) GetAllColumns(ctx context.Context, idLaporan int) (map[string][]SDBKolomLaporan, error) {
	var columns []SDBKolomLaporan
	err := r.db.WithContext(ctx).
		Where("[id_laporan] = ?", idLaporan).
		Order("[nama_dataset] ASC, [urutan_tampil] ASC").
		Find(&columns).Error

	if err != nil {
		return nil, err
	}

	// Group by nama_dataset
	result := make(map[string][]SDBKolomLaporan)
	for _, col := range columns {
		result[col.NamaDataset] = append(result[col.NamaDataset], col)
	}

	return result, nil
}

func (r *reportsRepository) CreateColumn(ctx context.Context, data *SDBKolomLaporan) (int, error) {
	err := r.db.WithContext(ctx).Create(data).Error
	return data.IDKolom, err
}

func (r *reportsRepository) UpdateColumn(ctx context.Context, id int, data *SDBKolomLaporan) error {
	return r.db.WithContext(ctx).Exec(`
		UPDATE dbkolomlaporan
		SET [nama_dataset] = ?, [nama_kolom] = ?, [label_tampil] = ?, [urutan_tampil] = ?, [format_type] = ?, [alignment] = ?, [is_summable] = ?, [is_visible] = ?
		WHERE [id_kolom] = ?`,
		data.NamaDataset, data.NamaKolom, data.LabelTampil, data.UrutanTampil, data.FormatType, data.Alignment, data.IsSummable, data.IsVisible, id,
	).Error
}

func (r *reportsRepository) DeleteColumn(ctx context.Context, id int) error {
	return r.db.WithContext(ctx).Delete(&SDBKolomLaporan{}, "[id_kolom] = ?", id).Error
}

// ============================================================================
// Groups
// ============================================================================

func (r *reportsRepository) GetGroups(ctx context.Context, idLaporan int) ([]SDBGroupLaporan, error) {
	var groups []SDBGroupLaporan
	err := r.db.WithContext(ctx).
		Where("[id_laporan] = ?", idLaporan).
		Order("[group_level] ASC, [sort_order] ASC").
		Find(&groups).Error
	return groups, err
}

func (r *reportsRepository) CreateGroup(ctx context.Context, data *SDBGroupLaporan) (int, error) {
	err := r.db.WithContext(ctx).Create(data).Error
	return data.IDGroup, err
}

func (r *reportsRepository) UpdateGroup(ctx context.Context, id int, data *SDBGroupLaporan) error {
	return r.db.WithContext(ctx).Exec(`
		UPDATE dbgrouplaporan
		SET [group_level] = ?, [group_field] = ?, [field_value] = ?, [label] = ?, [sort_order] = ?, [show_subtotal] = ?, [style_config] = ?, [special_handling] = ?, [config_json] = ?
		WHERE [id_group] = ?`,
		data.GroupLevel, data.GroupField, data.FieldValue, data.Label, data.SortOrder, data.ShowSubtotal, data.StyleConfig, data.SpecialHandling, data.ConfigJSON, id,
	).Error
}

func (r *reportsRepository) DeleteGroup(ctx context.Context, id int) error {
	return r.db.WithContext(ctx).Delete(&SDBGroupLaporan{}, "[id_group] = ?", id).Error
}

// ============================================================================
// Komponen
// ============================================================================

func (r *reportsRepository) GetKomponen(ctx context.Context, idLaporan int) ([]SDBKomponenLaporan, error) {
	var komponen []SDBKomponenLaporan
	err := r.db.WithContext(ctx).
		Where("[id_laporan] = ?", idLaporan).
		Order("[urutan] ASC").
		Find(&komponen).Error
	return komponen, err
}

func (r *reportsRepository) CreateKomponen(ctx context.Context, data *SDBKomponenLaporan) (int, error) {
	err := r.db.WithContext(ctx).Create(data).Error
	return data.IDKomponen, err
}

func (r *reportsRepository) UpdateKomponen(ctx context.Context, id int, data *SDBKomponenLaporan) error {
	return r.db.WithContext(ctx).Exec(`
		UPDATE dbkomponenlaporan
		SET [nama_komponen] = ?, [konfigurasi_layout] = ?, [urutan] = ?, [is_active] = ?
		WHERE [id_komponen] = ?`,
		data.NamaKomponen, data.KonfigurasiLayout, data.Urutan, data.IsActive, id,
	).Error
}

func (r *reportsRepository) DeleteKomponen(ctx context.Context, id int) error {
	return r.db.WithContext(ctx).Delete(&SDBKomponenLaporan{}, "[id_komponen] = ?", id).Error
}

func (r *reportsRepository) DeleteKomponenByReportID(ctx context.Context, idLaporan int) error {
	return r.db.WithContext(ctx).Exec("DELETE FROM dbkomponenlaporan WHERE [id_laporan] = ?", idLaporan).Error
}

func (r *reportsRepository) UpsertKomponenByName(ctx context.Context, idLaporan int, namaKomponen string, data *SDBKomponenLaporan) error {
	var existing SDBKomponenLaporan
	err := r.db.WithContext(ctx).
		Where("[id_laporan] = ? AND [nama_komponen] = ?", idLaporan, namaKomponen).
		First(&existing).Error
	if err != nil {
		// Not found, create new
		return r.db.WithContext(ctx).Create(data).Error
	}
	// Found, update existing
	return r.db.WithContext(ctx).Exec(`
		UPDATE dbkomponenlaporan
		SET [konfigurasi_layout] = ?, [urutan] = ?, [is_active] = ?
		WHERE [id_komponen] = ?`,
		data.KonfigurasiLayout, data.Urutan, data.IsActive, existing.IDKomponen,
	).Error
}

// ============================================================================
// User Access
// ============================================================================

func (r *reportsRepository) GetUserAccess(ctx context.Context, kodeMenu string) ([]SUserAccess, error) {
	var access []SUserAccess
	err := r.db.WithContext(ctx).Raw(`
		SELECT a.[USERID], COALESCE(p.[FullName], a.[USERID]) as FullName,
			   a.[Access], a.[IsDesign], a.[Isexport]
		FROM DBFLMENUREPORT a
		LEFT JOIN DBFLPASS p ON p.[USERID] = a.[USERID]
		WHERE a.[L1] = ?`, kodeMenu).Scan(&access).Error

	return access, err
}

func (r *reportsRepository) GrantAccess(ctx context.Context, kodeMenu string, data *SDBFLMenuReport) error {
	return r.db.WithContext(ctx).Clauses(clause.OnConflict{
		Columns:   []clause.Column{{Name: "USERID"}, {Name: "L1"}},
		DoUpdates: clause.AssignmentColumns([]string{"Access", "IsDesign", "Isexport"}),
	}).Create(data).Error
}

func (r *reportsRepository) RevokeAccess(ctx context.Context, kodeMenu string, userId string) error {
	return r.db.WithContext(ctx).
		Where("[L1] = ? AND [USERID] = ?", kodeMenu, userId).
		Delete(&SDBFLMenuReport{}).Error
}

func (r *reportsRepository) GetAllUsers(ctx context.Context) ([]SUserListResponse, error) {
	var users []SUserListResponse
	err := r.db.WithContext(ctx).Raw(`
		SELECT [USERID], COALESCE([FullName], [USERID]) as FullName
		FROM DBFLPASS
		ORDER BY [USERID]`).Scan(&users).Error

	return users, err
}

// ============================================================================
// Menu
// ============================================================================

func (r *reportsRepository) GetAvailableKodeMenu(ctx context.Context) ([]SAvailableKodeMenuResponse, error) {
	var available []SAvailableKodeMenuResponse

	err := r.db.WithContext(ctx).Raw(`
		SELECT m.[KODEMENU], m.[Keterangan]
		FROM DBMENUREPORT m
		WHERE m.[L0] >= 1
		  AND m.[KODEMENU] NOT IN (
			  SELECT [KODEMENU] FROM dbmasterlaporan WHERE [KODEMENU] IS NOT NULL
		  )
		ORDER BY m.[KODEMENU]`).Scan(&available).Error

	return available, err
}

// ============================================================================
// Query Preview & Execution
// ============================================================================

func (r *reportsRepository) PreviewQuery(ctx context.Context, sql string, filters map[string]interface{}) ([]map[string]interface{}, []string, error) {
	// Substitute placeholders with dummy values
	substitutedSQL := substituteParams(sql, filters, "")

	// Replace any remaining @variable with NULL (except @@ system vars)
	re := regexp.MustCompile(`(?i)@+[a-z0-9_]+`)
	substitutedSQL = re.ReplaceAllStringFunc(substitutedSQL, func(match string) string {
		if strings.HasPrefix(match, "@@") {
			return match
		}
		return "NULL"
	})

	// Use FMTONLY to get schema without executing (for preview)
	previewSQL := fmt.Sprintf("SET FMTONLY ON; %s; SET FMTONLY OFF;", substitutedSQL)

	sqlRows, err := r.db.WithContext(ctx).Raw(previewSQL).Rows()
	if err != nil {
		return nil, nil, err
	}
	defer sqlRows.Close()

	columns, err := sqlRows.Columns()
	if err != nil {
		return nil, nil, err
	}

	var results []map[string]interface{}
	// We don't need to scan since FMTONLY ON returns 0 rows


	return results, columns, err
}

func (r *reportsRepository) ExecuteQuery(ctx context.Context, sql string, filters map[string]interface{}, userId string) ([]map[string]interface{}, error) {
	// Substitute parameters
	substitutedSQL := substituteParams(sql, filters, userId)

	results := make([]map[string]interface{}, 0)
	err := r.db.WithContext(ctx).Raw(substitutedSQL).Scan(&results).Error

	if err != nil {
		return nil, err
	}

	// Convert from Windows-1252 to UTF-8 and fix []byte Base64 issue
	for i := range results {
		for key, value := range results[i] {
			if strVal, ok := value.(string); ok {
				results[i][key] = convertToUTF8(strVal)
			} else if bVal, ok := value.([]byte); ok {
				results[i][key] = convertToUTF8(string(bVal))
			}
		}
	}

	return results, nil
}

// ============================================================================
// Label Mapping
// ============================================================================

func (r *reportsRepository) GetLabelMapping(ctx context.Context, field string) (map[string]string, error) {
	var labels []SLabelGrup
	err := r.db.WithContext(ctx).
		Where("[field_name] = ?", field).
		Find(&labels).Error

	if err != nil {
		return nil, err
	}

	result := make(map[string]string)
	for _, l := range labels {
		result[l.FieldValue] = l.Label
	}

	return result, nil
}

// ============================================================================
// Helper Functions
// ============================================================================

// substituteParams replaces @paramName placeholders with actual values
func substituteParams(sql string, filters map[string]interface{}, userId string) string {
	// Sort filters by key length descending to avoid substring collision
	// e.g., @kodesupp1 before @kodesupp
	keys := make([]string, 0, len(filters))
	for key := range filters {
		keys = append(keys, key)
	}
	for i := 0; i < len(keys)-1; i++ {
		for j := i + 1; j < len(keys); j++ {
			if len(keys[j]) > len(keys[i]) {
				keys[i], keys[j] = keys[j], keys[i]
			}
		}
	}

	for _, key := range keys {
		value := filters[key]
		placeholder := "@" + key

		// Check if placeholder exists in SQL (case-insensitive)
		if !strings.Contains(strings.ToUpper(sql), strings.ToUpper(placeholder)) {
			continue
		}

		var replacement string
		switch v := value.(type) {
		case []interface{}:
			if len(v) == 0 {
				replacement = "NULL"
			} else {
				var parts []string
				for _, item := range v {
					if str, ok := item.(string); ok {
						parts = append(parts, fmt.Sprintf("'%s'", escapeSQLString(str)))
					} else {
						parts = append(parts, fmt.Sprintf("'%v'", item))
					}
				}
				replacement = strings.Join(parts, ",")
			}
		case string:
			if v == "" {
				replacement = "NULL"
			} else {
				replacement = fmt.Sprintf("'%s'", escapeSQLString(v))
			}
		default:
			if v == nil {
				replacement = "NULL"
			} else {
				replacement = fmt.Sprintf("'%v'", v)
			}
		}

		// Replace using regex to match whole word (case-insensitive)
		sql = replacePlaceholder(sql, placeholder, replacement)
	}

	// Handle @IDUser and @UserID
	if userId != "" {
		sql = replacePlaceholder(sql, "@IDUser", fmt.Sprintf("'%s'", escapeSQLString(userId)))
		sql = replacePlaceholder(sql, "@UserID", fmt.Sprintf("'%s'", escapeSQLString(userId)))
	} else {
		sql = replacePlaceholder(sql, "@IDUser", "''")
		sql = replacePlaceholder(sql, "@UserID", "''")
	}

	return sql
}

// replacePlaceholder replaces a placeholder case-insensitively
func replacePlaceholder(sql, placeholder, replacement string) string {
	re := regexp.MustCompile(`(?i)@[A-Za-z_]\w*`)
	return re.ReplaceAllStringFunc(sql, func(match string) string {
		if strings.EqualFold(match, placeholder) {
			return replacement
		}
		return match
	})
}


// escapeSQLString escapes single quotes in SQL strings
func escapeSQLString(s string) string {
	return strings.ReplaceAll(s, "'", "''")
}

// convertToUTF8 converts Windows-1252 encoded string to UTF-8
func convertToUTF8(s string) string {
	// Simple conversion: replace null bytes and trim
	s = strings.ReplaceAll(s, "\x00", "")
	return strings.TrimSpace(s)
}

// parseJSON safely parses JSON string
func parseJSON(data *string) map[string]interface{} {
	if data == nil || *data == "" {
		return nil
	}
	var result map[string]interface{}
	if err := json.Unmarshal([]byte(*data), &result); err != nil {
		return nil
	}
	return result
}

func (r *reportsRepository) GetMenuTreeForUser(ctx context.Context, userId string, search string) ([]SMenuReportItem, error) {
	var items []SMenuReportItem

	searchCondition := ""
	var args []interface{}

	if search != "" {
		searchCondition = " AND (menu.Keterangan LIKE ? OR menu.KODEMENU LIKE ?) "
		likeQuery := "%" + search + "%"
		args = append(args, likeQuery, likeQuery)
	}

	// Admin bypass: SA, admin, masza — show ALL active reports from DBMENUREPORT
	if userId == "SA" || userId == "admin" || userId == "masza" {
		query := `
			SELECT
				menu.KODEMENU as KODEMENU,
				menu.Keterangan as NmReport,
				menu.L0 as L0,
				'1' as ACCESS
			FROM DBMENUREPORT menu
			LEFT JOIN dbmasterlaporan m ON m.KODEMENU = menu.KODEMENU
			WHERE menu.L0 >= 0 ` + searchCondition + `
			ORDER BY menu.KODEMENU
		`
		err := r.db.WithContext(ctx).Raw(query, args...).Scan(&items).Error
		return items, err
	}

	// Normal users: join with DBFLMENUREPORT for access control
	query := `
		SELECT
			menu.KODEMENU as KODEMENU,
			menu.Keterangan as NmReport,
			menu.L0 as L0,
			'1' as ACCESS
		FROM DBMENUREPORT menu
		INNER JOIN DBFLMENUREPORT f ON menu.KODEMENU = f.KODEMENU
		LEFT JOIN dbmasterlaporan m ON m.KODEMENU = menu.KODEMENU
		WHERE f.USERID = ? AND menu.L0 >= 0 ` + searchCondition + `
		ORDER BY menu.KODEMENU
	`

	finalArgs := append([]interface{}{userId}, args...)
	err := r.db.WithContext(ctx).Raw(query, finalArgs...).Scan(&items).Error
	return items, err
}
