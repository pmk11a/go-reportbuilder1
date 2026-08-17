package reports

import "encoding/json"

// ============================================================================
// Request DTOs
// ============================================================================

// SListReportsRequest represents query params for listing reports
type SListReportsRequest struct {
	Page   int    `form:"page"`
	Limit  int    `form:"limit"`
	Search string `form:"search"`
}

// SKomponenRequest is the JSON payload for a component (e.g. layout)
type SKomponenRequest struct {
	NamaKomponen      string `json:"nama_komponen"`
	KonfigurasiLayout string `json:"konfigurasi_layout"`
	Urutan            *int   `json:"urutan"`
	IsActive          *bool  `json:"is_active"`
}

// SCreateReportRequest is the JSON payload for creating a new report
type SCreateReportRequest struct {
	KODEMENU    string          `json:"KODEMENU" binding:"required"`
	NamaLaporan string          `json:"nama_laporan" binding:"required"`
	Deskripsi   *string         `json:"deskripsi"`
	FooterBands json.RawMessage `json:"footer_bands"`
	StatusAktif *bool           `json:"status_aktif"`
	Komponen    []SKomponenRequest `json:"komponen"`
}

// SUpdateReportRequest is the JSON payload for updating a report
type SUpdateReportRequest struct {
	NamaLaporan *string         `json:"nama_laporan"`
	Deskripsi   *string         `json:"deskripsi"`
	FooterBands json.RawMessage `json:"footer_bands"`
	StatusAktif *bool            `json:"status_aktif"`
	Komponen    []SKomponenRequest `json:"komponen"`
}

// SCreateFilterRequest is the JSON payload for creating a filter
type SCreateFilterRequest struct {
	NamaFilter   string                 `json:"nama_filter" binding:"required"`
	Label        *string                `json:"label"`
	TipeInput    string                 `json:"tipe_input" binding:"required"`
	WajibIsi     *bool                  `json:"wajib_isi"`
	NilaiDefault *string                `json:"nilai_default"`
	Posisi       *int                   `json:"posisi"`
	Konfigurasi  map[string]interface{} `json:"konfigurasi"`
}

// SUpdateFilterRequest is the JSON payload for updating a filter
type SUpdateFilterRequest struct {
	NamaFilter   *string                `json:"nama_filter"`
	Label        *string                `json:"label"`
	TipeInput    *string                `json:"tipe_input"`
	WajibIsi     *bool                  `json:"wajib_isi"`
	NilaiDefault *string                `json:"nilai_default"`
	Posisi       *int                   `json:"posisi"`
	Konfigurasi  map[string]interface{} `json:"konfigurasi"`
}

// SCreateDatasetRequest is the JSON payload for creating a dataset
type SCreateDatasetRequest struct {
	NamaDataset    string                 `json:"nama_dataset" binding:"required"`
	QuerySumberData string                `json:"query_sumber_data" binding:"required"`
	Deskripsi      *string                `json:"deskripsi"`
	Urutan         *int                   `json:"urutan"`
	Visible        *bool                  `json:"visible"`
	ConfigJSON     map[string]interface{} `json:"config_json"`
}

// SUpdateDatasetRequest is the JSON payload for updating a dataset
type SUpdateDatasetRequest struct {
	NamaDataset    *string                `json:"nama_dataset"`
	QuerySumberData *string               `json:"query_sumber_data"`
	Deskripsi      *string                `json:"deskripsi"`
	Urutan         *int                   `json:"urutan"`
	Visible        *bool                  `json:"visible"`
	ConfigJSON     map[string]interface{} `json:"config_json"`
}

// SCreateColumnRequest is the JSON payload for creating a column
type SCreateColumnRequest struct {
	NamaDataset  string  `json:"nama_dataset" binding:"required"`
	NamaKolom    string  `json:"nama_kolom" binding:"required"`
	LabelTampil  *string `json:"label_tampil"`
	UrutanTampil *int    `json:"urutan_tampil"`
	FormatType   *string `json:"format_type"`
	Alignment    *string `json:"alignment"`
	IsSummable   *bool   `json:"is_summable"`
	IsVisible    *bool   `json:"is_visible"`
}

// SUpdateColumnRequest is the JSON payload for updating a column
type SUpdateColumnRequest struct {
	NamaDataset  *string `json:"nama_dataset"`
	NamaKolom    *string `json:"nama_kolom"`
	LabelTampil  *string `json:"label_tampil"`
	UrutanTampil *int    `json:"urutan_tampil"`
	FormatType   *string `json:"format_type"`
	Alignment    *string `json:"alignment"`
	IsSummable   *bool   `json:"is_summable"`
	IsVisible    *bool   `json:"is_visible"`
}

// SCreateGroupRequest is the JSON payload for creating a grouping config
type SCreateGroupRequest struct {
	GroupLevel      int                    `json:"group_level" binding:"required"`
	GroupField      *string                `json:"group_field"`
	FieldValue      *string                `json:"field_value"`
	Label           string                 `json:"label" binding:"required"`
	SortOrder       *int                   `json:"sort_order"`
	ShowSubtotal    *bool                  `json:"show_subtotal"`
	StyleConfig     map[string]interface{} `json:"style_config"`
	SpecialHandling *string                `json:"special_handling"`
	ConfigJSON      map[string]interface{} `json:"config_json"`
}

// SUpdateGroupRequest is the JSON payload for updating a grouping config
type SUpdateGroupRequest struct {
	GroupLevel      *int                   `json:"group_level"`
	GroupField      *string                `json:"group_field"`
	FieldValue      *string                `json:"field_value"`
	Label           *string                `json:"label"`
	SortOrder       *int                   `json:"sort_order"`
	ShowSubtotal    *bool                  `json:"show_subtotal"`
	StyleConfig     map[string]interface{} `json:"style_config"`
	SpecialHandling *string                `json:"special_handling"`
	ConfigJSON      map[string]interface{} `json:"config_json"`
}

// SGrantAccessRequest is the JSON payload for granting user access
type SGrantAccessRequest struct {
	USERID   string `json:"USERID" binding:"required"`
	Access   *bool  `json:"Access"`
	IsDesign *bool  `json:"IsDesign"`
	IsExport *bool  `json:"IsExport"`
}

// SPreviewQueryRequest is the JSON payload for previewing a query
type SPreviewQueryRequest struct {
	SQL     string                 `json:"sql" binding:"required"`
	Filters map[string]interface{} `json:"filters"`
}

// SExecuteReportRequest is the JSON payload for executing a report
type SExecuteReportRequest struct {
	Filters map[string]interface{} `json:"filters"`
}

// SReorderFiltersRequest is the JSON payload for reordering filters
type SReorderFiltersRequest struct {
	Orders []SFilterOrder `json:"orders" binding:"required"`
}

// SFilterOrder represents a single filter order update
type SFilterOrder struct {
	ID     int `json:"id" binding:"required"`
	Posisi int `json:"posisi" binding:"required"`
}

// ============================================================================
// Response DTOs
// ============================================================================

// SReportResponse is the JSON shape for a single report (list view)
type SReportResponse struct {
	IDLaporan   int              `json:"id_laporan"`
	KODEMENU   string           `json:"KODEMENU"`
	NamaLaporan string          `json:"nama_laporan"`
	Deskripsi  *string          `json:"deskripsi"`
	StatusAktif bool            `json:"status_aktif"`
	FooterBands json.RawMessage `json:"footer_bands"`
	Keterangan *string          `json:"Keterangan,omitempty"`
	L0         *int             `json:"L0,omitempty"`
	Icon       *string          `json:"icon,omitempty"`
	CreatedAt  *string          `json:"created_at"`
	UpdatedAt  *string          `json:"updated_at"`
}

// SReportDetailResponse is the JSON shape for full report detail
type SReportDetailResponse struct {
	IDLaporan   int                         `json:"id_laporan"`
	KODEMENU   string                       `json:"KODEMENU"`
	NamaLaporan string                       `json:"nama_laporan"`
	Deskripsi  *string                       `json:"deskripsi"`
	StatusAktif bool                        `json:"status_aktif"`
	FooterBands json.RawMessage              `json:"footer_bands"`
	Keterangan *string                       `json:"Keterangan,omitempty"`
	L0         *int                          `json:"L0,omitempty"`
	Filters     []SFilterResponse            `json:"filters"`
	Datasets    []SDatasetResponse           `json:"datasets"`
	Columns     map[string][]SColumnResponse  `json:"columns"`
	Groups      []SGroupResponse             `json:"groups"`
	Komponen    []SKomponenResponse          `json:"komponen"`
	Access     []SUserAccess                 `json:"access"`
	CreatedAt  *string                       `json:"created_at"`
	UpdatedAt  *string                       `json:"updated_at"`
}

// SFilterResponse is the JSON shape for a filter
type SFilterResponse struct {
	IDParameter  int                    `json:"id_parameter"`
	IDLaporan    int                    `json:"id_laporan"`
	NamaFilter   string                  `json:"nama_filter"`
	Label        string                  `json:"label"`
	TipeInput    string                  `json:"tipe_input"`
	WajibIsi     bool                    `json:"wajib_isi"`
	NilaiDefault *string                  `json:"nilai_default"`
	Posisi       int                    `json:"posisi"`
	Konfigurasi  map[string]interface{} `json:"konfigurasi"`
}

// SDatasetResponse is the JSON shape for a dataset
type SDatasetResponse struct {
	IDQuery        int                    `json:"id_query"`
	IDLaporan      int                    `json:"id_laporan"`
	NamaDataset    string                  `json:"nama_dataset"`
	QuerySumberData string                 `json:"query_sumber_data"`
	Deskripsi      *string                 `json:"deskripsi"`
	Urutan         int                    `json:"urutan"`
	Visible        bool                    `json:"visible"`
	ConfigJSON     map[string]interface{} `json:"config_json"`
}

// SColumnResponse is the JSON shape for a column
type SColumnResponse struct {
	IDKolom      int    `json:"id_kolom"`
	IDLaporan    int    `json:"id_laporan"`
	NamaDataset  string `json:"nama_dataset"`
	NamaKolom    string `json:"nama_kolom"`
	LabelTampil  string `json:"label_tampil"`
	UrutanTampil int    `json:"urutan_tampil"`
	FormatType   string `json:"format_type"`
	Alignment    string `json:"alignment"`
	IsSummable   bool   `json:"is_summable"`
	IsVisible    bool   `json:"is_visible"`
}

// SGroupResponse is the JSON shape for a grouping config
type SGroupResponse struct {
	IDGroup         int                    `json:"id_group"`
	IDLaporan       int                    `json:"id_laporan"`
	GroupLevel      int                    `json:"group_level"`
	GroupField      *string                 `json:"group_field"`
	FieldValue      *string                 `json:"field_value"`
	Label           string                  `json:"label"`
	SortOrder       int                    `json:"sort_order"`
	ShowSubtotal    bool                    `json:"show_subtotal"`
	StyleConfig     map[string]interface{} `json:"style_config"`
	SpecialHandling string                  `json:"special_handling"`
	ConfigJSON      map[string]interface{} `json:"config_json"`
}

// SKomponenResponse is the JSON shape for a component config
type SKomponenResponse struct {
	IDKomponen        int                    `json:"id_komponen"`
	IDLaporan         int                    `json:"id_laporan"`
	NamaKomponen      string      `json:"nama_komponen"`
	KonfigurasiLayout interface{} `json:"konfigurasi_layout"`
	Urutan            int         `json:"urutan"`
	IsActive          bool                   `json:"is_active"`
}

// SMenuReportItem represents a menu item for the reports sidebar
type SMenuReportItem struct {
	KODEMENU    string               `json:"KODEMENU"`
	Keterangan  string               `json:"NmReport"`
	NamaLaporan string               `json:"nama_laporan,omitempty"`
	L0          int                  `json:"L0"`
	ACCESS      string               `json:"ACCESS"`
	Children    []SMenuReportItem    `gorm:"-" json:"children,omitempty"`
}

// SPreviewQueryResponse is the JSON shape for query preview results
type SPreviewQueryResponse struct {
	Success   bool     `json:"success"`
	Columns   []string `json:"columns"`
	Rows      []map[string]interface{} `json:"rows"`
	RowCount  int      `json:"rowCount"`
	Message   string   `json:"message,omitempty"`
}

// SExecuteReportResponse is the JSON shape for executed report data
type SExecuteReportResponse struct {
	Success       bool                          `json:"success"`
	Datasets      map[string][]map[string]interface{} `json:"datasets"`
	GroupedData   map[string]interface{}        `json:"groupedData,omitempty"`
	GrandTotal    map[string]interface{}        `json:"grandTotal,omitempty"`
	Errors        []string                      `json:"errors,omitempty"`
	Message       string                        `json:"message,omitempty"`
}

// SReportConfigResponse is the JSON shape for report config (for execution)
type SReportConfigResponse struct {
	IDLaporan    int                           `json:"id_laporan"`
	KODEMENU     string                        `json:"KODEMENU"`
	NamaLaporan  string                        `json:"nama_laporan"`
	Deskripsi    *string                        `json:"deskripsi"`
	ACCESS       string                        `json:"ACCESS"`
	FooterBands  map[string]interface{}        `json:"footer_bands,omitempty"`
	Filters      []SFilterConfigResponse       `json:"filters"`
	Datasets     []SDatasetConfigResponse      `json:"datasets"`
	Columns      map[string][]SColumnConfigResponse `json:"columns"`
	Grouping     []map[string]interface{}      `json:"grouping,omitempty"`
	Komponen     []SKomponenConfigResponse     `json:"komponen,omitempty"`
}

// SFilterConfigResponse is the JSON shape for filter config (for execution)
type SFilterConfigResponse struct {
	IDParameter  int                    `json:"id_parameter"`
	NamaFilter   string                  `json:"nama_filter"`
	Label        string                  `json:"label"`
	TipeInput    string                  `json:"tipe_input"`
	WajibIsi     bool                    `json:"wajib_isi"`
	NilaiDefault *string                  `json:"nilai_default"`
	KodeBrowse   *string                  `json:"kode_browse,omitempty"`
	Mode         *string                  `json:"mode,omitempty"`
	Konfigurasi  map[string]interface{} `json:"konfigurasi,omitempty"`
	BrowseConfig map[string]interface{} `json:"browse_config,omitempty"`
	ParentFilterRef *string               `json:"parent_filter_ref,omitempty"`
	ParentFilterConfig *map[string]interface{} `json:"parent_filter_config,omitempty"`
}

// SDatasetConfigResponse is the JSON shape for dataset config (for execution)
type SDatasetConfigResponse struct {
	IDQuery     int                    `json:"id_query"`
	NamaDataset string                  `json:"nama_dataset"`
	Deskripsi   *string                 `json:"deskripsi"`
	Urutan      int                    `json:"urutan"`
	Visible     bool                    `json:"visible"`
	ConfigJSON  map[string]interface{} `json:"config_json"`
}

// SColumnConfigResponse is the JSON shape for column config (for execution)
type SColumnConfigResponse struct {
	NamaKolom    string `json:"nama_kolom"`
	LabelTampil  string `json:"label_tampil"`
	FormatType   string `json:"format_type"`
	Alignment    string `json:"alignment"`
	IsSummable   bool   `json:"is_summable"`
	IsVisible    bool   `json:"is_visible"`
}

// SKomponenConfigResponse is the JSON shape for component config (for execution)
type SKomponenConfigResponse struct {
	IDKomponen        int                    `json:"id_komponen"`
	NamaKomponen      string      `json:"nama_komponen"`
	KonfigurasiLayout interface{} `json:"konfigurasi_layout"`
	Urutan            int         `json:"urutan"`
}

// SAvailableKodeMenuResponse represents an available kode menu item
type SAvailableKodeMenuResponse struct {
	KODEMENU   string `json:"KODEMENU"`
	Keterangan string `json:"Keterangan"`
}

// SUserListResponse represents a user in the list
type SUserListResponse struct {
	USERID   string `json:"USERID"`
	FullName string `json:"FullName"`
}
