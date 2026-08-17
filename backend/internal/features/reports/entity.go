package reports

import "time"

// SDBMasterLaporan maps to dbmasterlaporan table
type SDBMasterLaporan struct {
	IDLaporan   int        `gorm:"column:id_laporan;primaryKey;autoIncrement" json:"id_laporan"`
	KODEMENU    string     `gorm:"column:KODEMENU;size:50;index" json:"KODEMENU"`
	NamaLaporan string     `gorm:"column:nama_laporan;size:200" json:"nama_laporan"`
	Deskripsi   *string    `gorm:"column:deskripsi;type:text" json:"deskripsi"`
	FooterBands *string    `gorm:"column:footer_bands;type:text" json:"footer_bands"`
	StatusAktif bool       `gorm:"column:status_aktif;default:true" json:"status_aktif"`
	PaperConfig *string    `gorm:"column:paper_config;type:text" json:"paperConfig"`
	CreatedAt   *time.Time `gorm:"column:created_at;type:datetime" json:"created_at"`
	UpdatedAt   *time.Time `gorm:"column:updated_at;type:datetime" json:"updated_at"`

	// Joined columns from DBMENUREPORT (LEFT JOIN in ListReports / GetReportByID).
	// Pointer types because the JOIN may return NULL when KODEMENU has no menu row.
	Keterangan *string `gorm:"column:Keterangan;->" json:"Keterangan,omitempty"`
	L0         *int    `gorm:"column:L0;->" json:"L0,omitempty"`
	Icon       *string `gorm:"column:Icon;->" json:"Icon,omitempty"`

	// Relations (loaded manually to avoid GORM offset/fetch on SQL Server 2008)
	Filters  []SDBParameterLaporan `gorm:"-" json:"filters,omitempty"`
	Datasets []SDBQueryLaporan      `gorm:"-" json:"datasets,omitempty"`
	Columns  map[string][]SDBKolomLaporan `gorm:"-" json:"columns,omitempty"`
	Groups   []SDBGroupLaporan      `gorm:"-" json:"groups,omitempty"`
	Komponen []SDBKomponenLaporan   `gorm:"-" json:"komponen,omitempty"`
}

func (SDBMasterLaporan) TableName() string { return "dbmasterlaporan" }

// SDBQueryLaporan maps to dbquerylaporan table
type SDBQueryLaporan struct {
	IDQuery        int     `gorm:"column:id_query;primaryKey;autoIncrement" json:"id_query"`
	IDLaporan      int     `gorm:"column:id_laporan;index" json:"id_laporan"`
	NamaDataset    string  `gorm:"column:nama_dataset;size:50" json:"nama_dataset"`
	QuerySumberData string `gorm:"column:query_sumber_data;type:text" json:"query_sumber_data"`
	Deskripsi      *string `gorm:"column:deskripsi;size:200" json:"deskripsi"`
	Urutan         int     `gorm:"column:urutan;default:0" json:"urutan"`
	Visible        bool    `gorm:"column:visible;default:true" json:"visible"`
	ConfigJSON     *string `gorm:"column:config_json;type:text" json:"config_json"`
}

func (SDBQueryLaporan) TableName() string { return "dbquerylaporan" }

// SDBParameterLaporan maps to dbparameterlaporan table
type SDBParameterLaporan struct {
	IDParameter   int     `gorm:"column:id_parameter;primaryKey;autoIncrement" json:"id_parameter"`
	IDLaporan     int     `gorm:"column:id_laporan;index" json:"id_laporan"`
	NamaFilter    string  `gorm:"column:nama_filter;size:100" json:"nama_filter"`
	Label         *string `gorm:"column:label;size:100" json:"label"`
	TipeInput     string  `gorm:"column:tipe_input;size:50" json:"tipe_input"`
	WajibIsi      bool    `gorm:"column:wajib_isi;default:false" json:"wajib_isi"`
	NilaiDefault  *string `gorm:"column:nilai_default;size:200" json:"nilai_default"`
	Posisi        int     `gorm:"column:posisi;default:0" json:"posisi"`
	Konfigurasi   *string `gorm:"column:konfigurasi;type:text" json:"konfigurasi"`
}

func (SDBParameterLaporan) TableName() string { return "dbparameterlaporan" }

// SDBKolomLaporan maps to dbkolomlaporan table
type SDBKolomLaporan struct {
	IDKolom      int     `gorm:"column:id_kolom;primaryKey;autoIncrement" json:"id_kolom"`
	IDLaporan    int     `gorm:"column:id_laporan;index" json:"id_laporan"`
	NamaDataset  string  `gorm:"column:nama_dataset;size:50" json:"nama_dataset"`
	NamaKolom    string  `gorm:"column:nama_kolom;size:100" json:"nama_kolom"`
	LabelTampil  *string `gorm:"column:label_tampil;size:100" json:"label_tampil"`
	UrutanTampil int     `gorm:"column:urutan_tampil;default:0" json:"urutan_tampil"`
	FormatType   string  `gorm:"column:format_type;size:20;default:text" json:"format_type"`
	Alignment    string  `gorm:"column:alignment;size:10;default:left" json:"alignment"`
	IsSummable   bool    `gorm:"column:is_summable;default:false" json:"is_summable"`
	IsVisible    bool    `gorm:"column:is_visible;default:true" json:"is_visible"`
}

func (SDBKolomLaporan) TableName() string { return "dbkolomlaporan" }

// SDBGroupLaporan maps to dbgrouplaporan table
type SDBGroupLaporan struct {
	IDGroup          int     `gorm:"column:id_group;primaryKey;autoIncrement" json:"id_group"`
	IDLaporan        int     `gorm:"column:id_laporan;index" json:"id_laporan"`
	GroupLevel       int     `gorm:"column:group_level;default:1" json:"group_level"`
	GroupField       *string `gorm:"column:group_field;size:100" json:"group_field"`
	FieldValue       *string `gorm:"column:field_value;size:50" json:"field_value"`
	Label            string  `gorm:"column:label;size:200" json:"label"`
	SortOrder        int     `gorm:"column:sort_order;default:0" json:"sort_order"`
	ShowSubtotal     bool    `gorm:"column:show_subtotal;default:true" json:"show_subtotal"`
	StyleConfig      *string `gorm:"column:style_config;type:text" json:"style_config"`
	SpecialHandling  string  `gorm:"column:special_handling;size:50;default:default" json:"special_handling"`
	ConfigJSON       *string `gorm:"column:config_json;type:text" json:"config_json"`
}

func (SDBGroupLaporan) TableName() string { return "dbgrouplaporan" }

// SDBMenuReport maps to DBMENUREPORT table (master menu catalogue for reports)
type SDBMenuReport struct {
	KODEMENU     string  `gorm:"column:KODEMENU;primaryKey;size:50" json:"KODEMENU"`
	Keterangan   string  `gorm:"column:Keterangan;size:200" json:"Keterangan"`
	L0           int     `gorm:"column:L0;default:0" json:"L0"`
	ACCESS       string  `gorm:"column:ACCESS;size:100" json:"ACCESS"`
	OL           *string `gorm:"column:OL;size:10" json:"OL"`
	PlatformMask *string `gorm:"column:PlatformMask;size:20" json:"PlatformMask"`
}

func (SDBMenuReport) TableName() string { return "DBMENUREPORT" }

// SDBFLMenuReport maps to DBFLMENUREPORT table (user access to reports)
type SDBFLMenuReport struct {
	ID        uint   `gorm:"column:id;primaryKey;autoIncrement" json:"id"`
	USERID    string `gorm:"column:USERID;size:50;index" json:"USERID"`
	L1        string `gorm:"column:L1;size:50;index" json:"L1"`
	Access    bool   `gorm:"column:Access;default:false" json:"Access"`
	IsDesign  bool   `gorm:"column:IsDesign;default:false" json:"IsDesign"`
	IsExport  bool   `gorm:"column:Isexport;default:false" json:"IsExport"`
}

func (SDBFLMenuReport) TableName() string { return "DBFLMENUREPORT" }

// SDBFLPASS maps to DBFLPASS table (user master)
type SDBFLPASS struct {
	USERID   string `gorm:"column:USERID;primaryKey;size:50" json:"USERID"`
	FullName string `gorm:"column:FullName;size:100" json:"FullName"`
}

func (SDBFLPASS) TableName() string { return "DBFLPASS" }

// SUserAccess represents a user's access to a specific report menu
type SUserAccess struct {
	USERID   string `json:"USERID"`
	FullName string `json:"FullName"`
	Access   bool   `json:"Access"`
	IsDesign bool   `json:"IsDesign"`
	IsExport bool   `json:"IsExport"`
}

// SLabelGrup maps to dbLabelGrup table for label mapping
type SLabelGrup struct {
	ID         uint   `gorm:"column:id;primaryKey;autoIncrement" json:"id"`
	FieldName  string `gorm:"column:field_name;size:100;index" json:"field_name"`
	FieldValue string `gorm:"column:field_value;size:100" json:"field_value"`
	Label      string `gorm:"column:label;size:200" json:"label"`
	Aktif      bool   `gorm:"column:aktif;default:1" json:"aktif"`
	SortOrder  int    `gorm:"column:sort_order;default:0" json:"sort_order"`
}

func (SLabelGrup) TableName() string { return "dbLabelGrup" }

// SDBKomponenLaporan maps to dbkomponenlaporan table
type SDBKomponenLaporan struct {
	IDKomponen        int    `gorm:"column:id_komponen;primaryKey;autoIncrement" json:"id_komponen"`
	IDLaporan         int    `gorm:"column:id_laporan;index" json:"id_laporan"`
	NamaKomponen      string `gorm:"column:nama_komponen;size:128" json:"nama_komponen"`
	KonfigurasiLayout string `gorm:"column:konfigurasi_layout;type:text" json:"konfigurasi_layout"`
	Urutan            int    `gorm:"column:urutan;default:0" json:"urutan"`
	IsActive          bool   `gorm:"column:is_active;default:true" json:"is_active"`
}

func (SDBKomponenLaporan) TableName() string { return "dbkomponenlaporan" }
