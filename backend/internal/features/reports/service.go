package reports

import (
	"context"
	"encoding/json"
	"errors"
)

// IReportsService defines the business logic contract for the reports domain.
type IReportsService interface {
	// Report CRUD
	ListReports(ctx context.Context, req *SListReportsRequest) (*ListReportsResponse, error)
	GetReport(ctx context.Context, id int) (*SReportDetailResponse, error)
	CreateReport(ctx context.Context, req *SCreateReportRequest) (*SReportResponse, error)
	UpdateReport(ctx context.Context, id int, req *SUpdateReportRequest) (*SReportResponse, error)
	DeleteReport(ctx context.Context, id int) error

	// Filters
	GetFilters(ctx context.Context, idLaporan int) ([]SFilterResponse, error)
	CreateFilter(ctx context.Context, idLaporan int, req *SCreateFilterRequest) (*SFilterResponse, error)
	UpdateFilter(ctx context.Context, id int, req *SUpdateFilterRequest) (*SFilterResponse, error)
	DeleteFilter(ctx context.Context, id int) error
	ReorderFilters(ctx context.Context, idLaporan int, req *SReorderFiltersRequest) error

	// Datasets
	GetDatasets(ctx context.Context, idLaporan int) ([]SDatasetResponse, error)
	CreateDataset(ctx context.Context, idLaporan int, req *SCreateDatasetRequest) (*SDatasetResponse, error)
	UpdateDataset(ctx context.Context, id int, req *SUpdateDatasetRequest) (*SDatasetResponse, error)
	DeleteDataset(ctx context.Context, id int) error

	// Columns
	GetAllColumns(ctx context.Context, idLaporan int) (map[string][]SColumnResponse, error)
	CreateColumn(ctx context.Context, idLaporan int, req *SCreateColumnRequest) (*SColumnResponse, error)
	UpdateColumn(ctx context.Context, id int, req *SUpdateColumnRequest) (*SColumnResponse, error)
	DeleteColumn(ctx context.Context, id int) error

	// Groups
	GetGroups(ctx context.Context, idLaporan int) ([]SGroupResponse, error)
	CreateGroup(ctx context.Context, idLaporan int, req *SCreateGroupRequest) (*SGroupResponse, error)
	UpdateGroup(ctx context.Context, id int, req *SUpdateGroupRequest) (*SGroupResponse, error)
	DeleteGroup(ctx context.Context, id int) error

	// Komponen
	GetKomponen(ctx context.Context, idLaporan int) ([]SKomponenResponse, error)
	UpsertKomponen(ctx context.Context, idLaporan int, req *SKomponenRequest) (*SKomponenResponse, error)

	// User Access
	GetUserAccess(ctx context.Context, kodeMenu string) ([]SUserAccess, error)
	GrantAccess(ctx context.Context, kodeMenu string, req *SGrantAccessRequest) ([]SUserAccess, error)
	RevokeAccess(ctx context.Context, kodeMenu string, userId string) ([]SUserAccess, error)
	GetAllUsers(ctx context.Context) ([]SUserListResponse, error)

	// Menu
	GetAvailableKodeMenu(ctx context.Context) ([]SAvailableKodeMenuResponse, error)
	GetMenuTreeForUser(ctx context.Context, userId string, search string) ([]SMenuReportItem, error)


	// Query Preview
	PreviewQuery(ctx context.Context, req *SPreviewQueryRequest) (*SPreviewQueryResponse, error)
}

// reportsService implements IReportsService
type reportsService struct {
	repo IReportsRepository
}

// NewReportsService constructs the default reports service.
func NewReportsService(repo IReportsRepository) IReportsService {
	return &reportsService{repo: repo}
}

// ListReportsResponse wraps paginated report list
type ListReportsResponse struct {
	Reports   []SReportResponse `json:"reports"`
	Total     int64            `json:"total"`
	Page      int              `json:"page"`
	Limit     int              `json:"limit"`
}

// ============================================================================
// Report CRUD
// ============================================================================

func (s *reportsService) ListReports(ctx context.Context, req *SListReportsRequest) (*ListReportsResponse, error) {
	page := req.Page
	if page < 1 {
		page = 1
	}
	limit := req.Limit
	if limit < 1 {
		limit = 10
	}

	reports, total, err := s.repo.ListReports(ctx, req.Search, page, limit)
	if err != nil {
		return nil, err
	}

	var response []SReportResponse
	for _, r := range reports {
		response = append(response, mapReportToResponse(&r))
	}

	return &ListReportsResponse{
		Reports: response,
		Total:   total,
		Page:    page,
		Limit:   limit,
	}, nil
}

func (s *reportsService) GetReport(ctx context.Context, id int) (*SReportDetailResponse, error) {
	report, err := s.repo.GetReportByID(ctx, id)
	if err != nil {
		return nil, err
	}

	// Load related data
	datasets, _ := s.repo.GetDatasets(ctx, id)
	access, _ := s.repo.GetUserAccess(ctx, report.KODEMENU)

	return mapReportToDetailResponse(report, datasets, access), nil
}

func (s *reportsService) CreateReport(ctx context.Context, req *SCreateReportRequest) (*SReportResponse, error) {
	// Check if kode menu is already used
	existing, err := s.repo.GetReportByKodeMenu(ctx, req.KODEMENU)
	if err == nil && existing != nil {
		return nil, errors.New("kode menu already used by another report")
	}

	statusAktif := true
	if req.StatusAktif != nil {
		statusAktif = *req.StatusAktif
	}

	var footerJSON json.RawMessage
	if req.FooterBands != nil {
		footerJSON = req.FooterBands
	}

	entity := &SDBMasterLaporan{
		KODEMENU:    req.KODEMENU,
		NamaLaporan: req.NamaLaporan,
		Deskripsi:   req.Deskripsi,
		StatusAktif: statusAktif,
		FooterBands: func() *string { s := string(footerJSON); return &s }(),
	}

	id, err := s.repo.CreateReport(ctx, entity)
	if err != nil {
		return nil, err
	}

	entity.IDLaporan = id
	resp := &SReportResponse{
		IDLaporan:   id,
		KODEMENU:    req.KODEMENU,
		NamaLaporan: req.NamaLaporan,
		Deskripsi:   req.Deskripsi,
		StatusAktif: statusAktif,
		FooterBands: footerJSON,
	}

	if len(req.Komponen) > 0 {
		for i, k := range req.Komponen {
			urutan := i + 1
			if k.Urutan != nil {
				urutan = *k.Urutan
			}
			isActive := true
			if k.IsActive != nil {
				isActive = *k.IsActive
			}
			_, _ = s.repo.CreateKomponen(ctx, &SDBKomponenLaporan{
				IDLaporan:         id,
				NamaKomponen:      k.NamaKomponen,
				KonfigurasiLayout: k.KonfigurasiLayout,
				Urutan:            urutan,
				IsActive:          isActive,
			})
		}
	}

	return resp, nil
}

func (s *reportsService) UpdateReport(ctx context.Context, id int, req *SUpdateReportRequest) (*SReportResponse, error) {
	report, err := s.repo.GetReportByID(ctx, id)
	if err != nil {
		return nil, err
	}

	if req.NamaLaporan != nil {
		report.NamaLaporan = *req.NamaLaporan
	}
	if req.Deskripsi != nil {
		report.Deskripsi = req.Deskripsi
	}
	if req.StatusAktif != nil {
		report.StatusAktif = *req.StatusAktif
	}
	if req.FooterBands != nil {
		report.FooterBands = func() *string { if req.FooterBands != nil && len(req.FooterBands) > 0 { s := string(req.FooterBands); return &s }; return nil }()
	}

	if err := s.repo.UpdateReport(ctx, id, report); err != nil {
		return nil, err
	}

	if len(req.Komponen) > 0 {
		_ = s.repo.DeleteKomponenByReportID(ctx, id)
		for i, k := range req.Komponen {
			urutan := i + 1
			if k.Urutan != nil {
				urutan = *k.Urutan
			}
			isActive := true
			if k.IsActive != nil {
				isActive = *k.IsActive
			}
			_, _ = s.repo.CreateKomponen(ctx, &SDBKomponenLaporan{
				IDLaporan:         id,
				NamaKomponen:      k.NamaKomponen,
				KonfigurasiLayout: k.KonfigurasiLayout,
				Urutan:            urutan,
				IsActive:          isActive,
			})
		}
	}

	resp := mapReportToResponse(report)
	return &resp, nil
}

func (s *reportsService) DeleteReport(ctx context.Context, id int) error {
	return s.repo.DeleteReport(ctx, id)
}

// ============================================================================
// Filters
// ============================================================================

func (s *reportsService) GetFilters(ctx context.Context, idLaporan int) ([]SFilterResponse, error) {
	filters, err := s.repo.GetFilters(ctx, idLaporan)
	if err != nil {
		return nil, err
	}

	var response []SFilterResponse
	for _, f := range filters {
		response = append(response, mapFilterToResponse(&f))
	}
	return response, nil
}

func (s *reportsService) CreateFilter(ctx context.Context, idLaporan int, req *SCreateFilterRequest) (*SFilterResponse, error) {
	wajibIsi := false
	if req.WajibIsi != nil {
		wajibIsi = *req.WajibIsi
	}

	var konfigurasi *string
	if req.Konfigurasi != nil {
		jsonData, _ := json.Marshal(req.Konfigurasi)
		s := string(jsonData)
		konfigurasi = &s
	}

	entity := &SDBParameterLaporan{
		IDLaporan:    idLaporan,
		NamaFilter:   req.NamaFilter,
		Label:        req.Label,
		TipeInput:    req.TipeInput,
		WajibIsi:     wajibIsi,
		NilaiDefault: req.NilaiDefault,
		Konfigurasi: konfigurasi,
	}

	id, err := s.repo.CreateFilter(ctx, entity)
	if err != nil {
		return nil, err
	}

	entity.IDParameter = id
	resp := mapFilterToResponse(entity)
	return &resp, nil
}

func (s *reportsService) UpdateFilter(ctx context.Context, id int, req *SUpdateFilterRequest) (*SFilterResponse, error) {
	entity := &SDBParameterLaporan{}

	if req.NamaFilter != nil {
		entity.NamaFilter = *req.NamaFilter
	}
	if req.Label != nil {
		entity.Label = req.Label
	}
	if req.TipeInput != nil {
		entity.TipeInput = *req.TipeInput
	}
	if req.WajibIsi != nil {
		entity.WajibIsi = *req.WajibIsi
	}
	if req.NilaiDefault != nil {
		entity.NilaiDefault = req.NilaiDefault
	}
	if req.Posisi != nil {
		entity.Posisi = *req.Posisi
	}
	if req.Konfigurasi != nil {
		jsonData, _ := json.Marshal(req.Konfigurasi)
		s := string(jsonData)
		entity.Konfigurasi = &s
	}

	if err := s.repo.UpdateFilter(ctx, id, entity); err != nil {
		return nil, err
	}

	resp := mapFilterToResponse(entity)
	resp.IDParameter = id
	return &resp, nil
}

func (s *reportsService) DeleteFilter(ctx context.Context, id int) error {
	return s.repo.DeleteFilter(ctx, id)
}

func (s *reportsService) ReorderFilters(ctx context.Context, idLaporan int, req *SReorderFiltersRequest) error {
	return s.repo.ReorderFilters(ctx, idLaporan, req.Orders)
}

// ============================================================================
// Datasets
// ============================================================================

func (s *reportsService) GetDatasets(ctx context.Context, idLaporan int) ([]SDatasetResponse, error) {
	datasets, err := s.repo.GetDatasets(ctx, idLaporan)
	if err != nil {
		return nil, err
	}

	var response []SDatasetResponse
	for _, d := range datasets {
		response = append(response, mapDatasetToResponse(&d))
	}
	return response, nil
}

func (s *reportsService) CreateDataset(ctx context.Context, idLaporan int, req *SCreateDatasetRequest) (*SDatasetResponse, error) {
	visible := true
	if req.Visible != nil {
		visible = *req.Visible
	}

	var configJSON *string
	if req.ConfigJSON != nil {
		jsonData, _ := json.Marshal(req.ConfigJSON)
		s := string(jsonData)
		configJSON = &s
	}

	entity := &SDBQueryLaporan{
		IDLaporan:      idLaporan,
		NamaDataset:    req.NamaDataset,
		QuerySumberData: req.QuerySumberData,
		Deskripsi:      req.Deskripsi,
		Visible:        visible,
		ConfigJSON:     configJSON,
	}

	id, err := s.repo.CreateDataset(ctx, entity)
	if err != nil {
		return nil, err
	}

	entity.IDQuery = id
	resp := mapDatasetToResponse(entity)
	return &resp, nil
}

func (s *reportsService) UpdateDataset(ctx context.Context, id int, req *SUpdateDatasetRequest) (*SDatasetResponse, error) {
	entity := &SDBQueryLaporan{}

	if req.NamaDataset != nil {
		entity.NamaDataset = *req.NamaDataset
	}
	if req.QuerySumberData != nil {
		entity.QuerySumberData = *req.QuerySumberData
	}
	if req.Deskripsi != nil {
		entity.Deskripsi = req.Deskripsi
	}
	if req.Urutan != nil {
		entity.Urutan = *req.Urutan
	}
	if req.Visible != nil {
		entity.Visible = *req.Visible
	}
	if req.ConfigJSON != nil {
		jsonData, _ := json.Marshal(req.ConfigJSON)
		s := string(jsonData)
		entity.ConfigJSON = &s
	}

	if err := s.repo.UpdateDataset(ctx, id, entity); err != nil {
		return nil, err
	}

	resp := mapDatasetToResponse(entity)
	resp.IDQuery = id
	return &resp, nil
}

func (s *reportsService) DeleteDataset(ctx context.Context, id int) error {
	return s.repo.DeleteDataset(ctx, id)
}

// ============================================================================
// Columns
// ============================================================================

func (s *reportsService) GetAllColumns(ctx context.Context, idLaporan int) (map[string][]SColumnResponse, error) {
	columns, err := s.repo.GetAllColumns(ctx, idLaporan)
	if err != nil {
		return nil, err
	}

	result := make(map[string][]SColumnResponse)
	for dataset, cols := range columns {
		var response []SColumnResponse
		for _, c := range cols {
			response = append(response, mapColumnToResponse(&c))
		}
		result[dataset] = response
	}
	return result, nil
}

func (s *reportsService) CreateColumn(ctx context.Context, idLaporan int, req *SCreateColumnRequest) (*SColumnResponse, error) {
	formatType := "text"
	if req.FormatType != nil {
		formatType = *req.FormatType
	}

	alignment := "left"
	if req.Alignment != nil {
		alignment = *req.Alignment
	}

	isSummable := false
	if req.IsSummable != nil {
		isSummable = *req.IsSummable
	}

	isVisible := true
	if req.IsVisible != nil {
		isVisible = *req.IsVisible
	}

	urutanTampil := 0
	if req.UrutanTampil != nil {
		urutanTampil = *req.UrutanTampil
	}

	entity := &SDBKolomLaporan{
		IDLaporan:    idLaporan,
		NamaDataset:  req.NamaDataset,
		NamaKolom:    req.NamaKolom,
		LabelTampil:  req.LabelTampil,
		UrutanTampil: urutanTampil,
		FormatType:   formatType,
		Alignment:    alignment,
		IsSummable:   isSummable,
		IsVisible:    isVisible,
	}

	id, err := s.repo.CreateColumn(ctx, entity)
	if err != nil {
		return nil, err
	}

	entity.IDKolom = id
	resp := mapColumnToResponse(entity)
	return &resp, nil
}

func (s *reportsService) UpdateColumn(ctx context.Context, id int, req *SUpdateColumnRequest) (*SColumnResponse, error) {
	entity := &SDBKolomLaporan{}

	if req.NamaDataset != nil {
		entity.NamaDataset = *req.NamaDataset
	}
	if req.NamaKolom != nil {
		entity.NamaKolom = *req.NamaKolom
	}
	if req.LabelTampil != nil {
		entity.LabelTampil = req.LabelTampil
	}
	if req.UrutanTampil != nil {
		entity.UrutanTampil = *req.UrutanTampil
	}
	if req.FormatType != nil {
		entity.FormatType = *req.FormatType
	}
	if req.Alignment != nil {
		entity.Alignment = *req.Alignment
	}
	if req.IsSummable != nil {
		entity.IsSummable = *req.IsSummable
	}
	if req.IsVisible != nil {
		entity.IsVisible = *req.IsVisible
	}

	if err := s.repo.UpdateColumn(ctx, id, entity); err != nil {
		return nil, err
	}

	resp := mapColumnToResponse(entity)
	resp.IDKolom = id
	return &resp, nil
}

func (s *reportsService) DeleteColumn(ctx context.Context, id int) error {
	return s.repo.DeleteColumn(ctx, id)
}

// ============================================================================
// Groups
// ============================================================================

func (s *reportsService) GetGroups(ctx context.Context, idLaporan int) ([]SGroupResponse, error) {
	groups, err := s.repo.GetGroups(ctx, idLaporan)
	if err != nil {
		return nil, err
	}

	var response []SGroupResponse
	for _, g := range groups {
		response = append(response, mapGroupToResponse(&g))
	}
	return response, nil
}

func (s *reportsService) CreateGroup(ctx context.Context, idLaporan int, req *SCreateGroupRequest) (*SGroupResponse, error) {
	showSubtotal := true
	if req.ShowSubtotal != nil {
		showSubtotal = *req.ShowSubtotal
	}

	specialHandling := "default"
	if req.SpecialHandling != nil {
		specialHandling = *req.SpecialHandling
	}

	sortOrder := 0
	if req.SortOrder != nil {
		sortOrder = *req.SortOrder
	}

	var styleConfig, configJSON *string
	if req.StyleConfig != nil {
		jsonData, _ := json.Marshal(req.StyleConfig)
		s := string(jsonData)
		styleConfig = &s
	}
	if req.ConfigJSON != nil {
		jsonData, _ := json.Marshal(req.ConfigJSON)
		s := string(jsonData)
		configJSON = &s
	}

	entity := &SDBGroupLaporan{
		IDLaporan:       idLaporan,
		GroupLevel:      req.GroupLevel,
		GroupField:      req.GroupField,
		FieldValue:      req.FieldValue,
		Label:           req.Label,
		SortOrder:       sortOrder,
		ShowSubtotal:    showSubtotal,
		StyleConfig:     styleConfig,
		SpecialHandling: specialHandling,
		ConfigJSON:      configJSON,
	}

	id, err := s.repo.CreateGroup(ctx, entity)
	if err != nil {
		return nil, err
	}

	entity.IDGroup = id
	resp := mapGroupToResponse(entity)
	return &resp, nil
}

func (s *reportsService) UpdateGroup(ctx context.Context, id int, req *SUpdateGroupRequest) (*SGroupResponse, error) {
	entity := &SDBGroupLaporan{}

	if req.GroupLevel != nil {
		entity.GroupLevel = *req.GroupLevel
	}
	if req.GroupField != nil {
		entity.GroupField = req.GroupField
	}
	if req.FieldValue != nil {
		entity.FieldValue = req.FieldValue
	}
	if req.Label != nil {
		entity.Label = *req.Label
	}
	if req.SortOrder != nil {
		entity.SortOrder = *req.SortOrder
	}
	if req.ShowSubtotal != nil {
		entity.ShowSubtotal = *req.ShowSubtotal
	}
	if req.StyleConfig != nil {
		jsonData, _ := json.Marshal(req.StyleConfig)
		s := string(jsonData)
		entity.StyleConfig = &s
	}
	if req.SpecialHandling != nil {
		entity.SpecialHandling = *req.SpecialHandling
	}
	if req.ConfigJSON != nil {
		jsonData, _ := json.Marshal(req.ConfigJSON)
		s := string(jsonData)
		entity.ConfigJSON = &s
	}

	if err := s.repo.UpdateGroup(ctx, id, entity); err != nil {
		return nil, err
	}

	resp := mapGroupToResponse(entity)
	resp.IDGroup = id
	return &resp, nil
}

func (s *reportsService) DeleteGroup(ctx context.Context, id int) error {
	return s.repo.DeleteGroup(ctx, id)
}

// ============================================================================
// Komponen
// ============================================================================

func (s *reportsService) GetKomponen(ctx context.Context, idLaporan int) ([]SKomponenResponse, error) {
	komponen, err := s.repo.GetKomponen(ctx, idLaporan)
	if err != nil {
		return nil, err
	}
	var responses []SKomponenResponse
	for _, k := range komponen {
		responses = append(responses, mapKomponenToResponse(&k))
	}
	return responses, nil
}

func (s *reportsService) UpsertKomponen(ctx context.Context, idLaporan int, req *SKomponenRequest) (*SKomponenResponse, error) {
	urutan := 1
	if req.Urutan != nil {
		urutan = *req.Urutan
	}
	isActive := true
	if req.IsActive != nil {
		isActive = *req.IsActive
	}

	// KonfigurasiLayout adalah string JSON yang sudah di-stringify oleh frontend
	konfigJSON := req.KonfigurasiLayout

	entity := &SDBKomponenLaporan{
		IDLaporan:         idLaporan,
		NamaKomponen:      req.NamaKomponen,
		KonfigurasiLayout: konfigJSON,
		Urutan:            urutan,
		IsActive:          isActive,
	}

	err := s.repo.UpsertKomponenByName(ctx, idLaporan, req.NamaKomponen, entity)
	if err != nil {
		return nil, err
	}

	resp := mapKomponenToResponse(entity)
	return &resp, nil
}

// ============================================================================
// User Access
// ============================================================================

func (s *reportsService) GetUserAccess(ctx context.Context, kodeMenu string) ([]SUserAccess, error) {
	return s.repo.GetUserAccess(ctx, kodeMenu)
}

func (s *reportsService) GrantAccess(ctx context.Context, kodeMenu string, req *SGrantAccessRequest) ([]SUserAccess, error) {
	access := true
	if req.Access != nil {
		access = *req.Access
	}

	isDesign := false
	if req.IsDesign != nil {
		isDesign = *req.IsDesign
	}

	isExport := false
	if req.IsExport != nil {
		isExport = *req.IsExport
	}

	entity := &SDBFLMenuReport{
		USERID:   req.USERID,
		L1:       kodeMenu,
		Access:   access,
		IsDesign: isDesign,
		IsExport: isExport,
	}

	if err := s.repo.GrantAccess(ctx, kodeMenu, entity); err != nil {
		return nil, err
	}

	return s.repo.GetUserAccess(ctx, kodeMenu)
}

func (s *reportsService) RevokeAccess(ctx context.Context, kodeMenu string, userId string) ([]SUserAccess, error) {
	if err := s.repo.RevokeAccess(ctx, kodeMenu, userId); err != nil {
		return nil, err
	}
	return s.repo.GetUserAccess(ctx, kodeMenu)
}

func (s *reportsService) GetAllUsers(ctx context.Context) ([]SUserListResponse, error) {
	return s.repo.GetAllUsers(ctx)
}

// ============================================================================
// Menu
// ============================================================================

func (s *reportsService) GetAvailableKodeMenu(ctx context.Context) ([]SAvailableKodeMenuResponse, error) {
	return s.repo.GetAvailableKodeMenu(ctx)
}

// ============================================================================
// Query Preview
// ============================================================================

func (s *reportsService) PreviewQuery(ctx context.Context, req *SPreviewQueryRequest) (*SPreviewQueryResponse, error) {
	if req.SQL == "" {
		return &SPreviewQueryResponse{
			Success: false,
			Message:  "Query is empty",
		}, nil
	}

	rows, columns, err := s.repo.PreviewQuery(ctx, req.SQL, req.Filters)
	if err != nil {
		return &SPreviewQueryResponse{
			Success: false,
			Message:  err.Error(),
		}, nil
	}

	// Limit preview to 5 rows
	previewRows := rows
	if len(previewRows) > 5 {
		previewRows = previewRows[:5]
	}

	return &SPreviewQueryResponse{
		Success:  true,
		Columns:  columns,
		Rows:     previewRows,
		RowCount: len(rows),
		Message:  "Query executed successfully",
	}, nil
}

// ============================================================================
// Mapper Functions
// ============================================================================

func mapReportToResponse(r *SDBMasterLaporan) SReportResponse {
	var footerBands json.RawMessage
	if r.FooterBands != nil && *r.FooterBands != "" {
		footerBands = json.RawMessage(*r.FooterBands)
	}

	return SReportResponse{
		IDLaporan:   r.IDLaporan,
		KODEMENU:    r.KODEMENU,
		NamaLaporan: r.NamaLaporan,
		Deskripsi:   r.Deskripsi,
		StatusAktif: r.StatusAktif,
		FooterBands: footerBands,
		Keterangan:  r.Keterangan,
		L0:          r.L0,
		Icon:        r.Icon,
	}
}

func mapReportToDetailResponse(
	r *SDBMasterLaporan,
	datasets []SDBQueryLaporan,
	access []SUserAccess,
) *SReportDetailResponse {
	var footerBands json.RawMessage
	if r.FooterBands != nil && *r.FooterBands != "" {
		footerBands = json.RawMessage(*r.FooterBands)
	}

	var datasetResponses []SDatasetResponse
	for _, d := range datasets {
		datasetResponses = append(datasetResponses, mapDatasetToResponse(&d))
	}

	return &SReportDetailResponse{
		IDLaporan:   r.IDLaporan,
		KODEMENU:    r.KODEMENU,
		NamaLaporan: r.NamaLaporan,
		Deskripsi:   r.Deskripsi,
		StatusAktif: r.StatusAktif,
		FooterBands: footerBands,
		Datasets:    datasetResponses,
		Access:      access,
	}
}

func mapKomponenToResponse(k *SDBKomponenLaporan) SKomponenResponse {
	var konfigurasiLayout interface{}
	if k.KonfigurasiLayout != "" {
		json.Unmarshal([]byte(k.KonfigurasiLayout), &konfigurasiLayout)
	}

	return SKomponenResponse{
		IDKomponen:        k.IDKomponen,
		IDLaporan:         k.IDLaporan,
		NamaKomponen:      k.NamaKomponen,
		KonfigurasiLayout: konfigurasiLayout,
		Urutan:            k.Urutan,
		IsActive:          k.IsActive,
	}
}

func mapFilterToResponse(f *SDBParameterLaporan) SFilterResponse {
	label := f.NamaFilter
	if f.Label != nil {
		label = *f.Label
	}

	var konfigurasi map[string]interface{}
	if f.Konfigurasi != nil && *f.Konfigurasi != "" {
		json.Unmarshal([]byte(*f.Konfigurasi), &konfigurasi)
	}

	return SFilterResponse{
		IDParameter:  f.IDParameter,
		IDLaporan:    f.IDLaporan,
		NamaFilter:   f.NamaFilter,
		Label:        label,
		TipeInput:    f.TipeInput,
		WajibIsi:     f.WajibIsi,
		NilaiDefault: f.NilaiDefault,
		Posisi:       f.Posisi,
		Konfigurasi:  konfigurasi,
	}
}

func mapDatasetToResponse(d *SDBQueryLaporan) SDatasetResponse {
	var configJSON map[string]interface{}
	if d.ConfigJSON != nil && *d.ConfigJSON != "" {
		json.Unmarshal([]byte(*d.ConfigJSON), &configJSON)
	}

	return SDatasetResponse{
		IDQuery:        d.IDQuery,
		IDLaporan:      d.IDLaporan,
		NamaDataset:    d.NamaDataset,
		QuerySumberData: d.QuerySumberData,
		Deskripsi:      d.Deskripsi,
		Urutan:         d.Urutan,
		Visible:        d.Visible,
		ConfigJSON:     configJSON,
	}
}

func mapColumnToResponse(c *SDBKolomLaporan) SColumnResponse {
	labelTampil := c.NamaKolom
	if c.LabelTampil != nil {
		labelTampil = *c.LabelTampil
	}

	return SColumnResponse{
		IDKolom:      c.IDKolom,
		IDLaporan:    c.IDLaporan,
		NamaDataset:  c.NamaDataset,
		NamaKolom:    c.NamaKolom,
		LabelTampil:  labelTampil,
		UrutanTampil: c.UrutanTampil,
		FormatType:   c.FormatType,
		Alignment:    c.Alignment,
		IsSummable:   c.IsSummable,
		IsVisible:    c.IsVisible,
	}
}

func mapGroupToResponse(g *SDBGroupLaporan) SGroupResponse {
	var styleConfig, configJSON map[string]interface{}
	if g.StyleConfig != nil && *g.StyleConfig != "" {
		json.Unmarshal([]byte(*g.StyleConfig), &styleConfig)
	}
	if g.ConfigJSON != nil && *g.ConfigJSON != "" {
		json.Unmarshal([]byte(*g.ConfigJSON), &configJSON)
	}

	return SGroupResponse{
		IDGroup:         g.IDGroup,
		IDLaporan:       g.IDLaporan,
		GroupLevel:      g.GroupLevel,
		GroupField:      g.GroupField,
		FieldValue:      g.FieldValue,
		Label:           g.Label,
		SortOrder:       g.SortOrder,
		ShowSubtotal:    g.ShowSubtotal,
		StyleConfig:     styleConfig,
		SpecialHandling: g.SpecialHandling,
		ConfigJSON:      configJSON,
	}
}

func (s *reportsService) GetMenuTreeForUser(ctx context.Context, userId string, search string) ([]SMenuReportItem, error) {
	return s.repo.GetMenuTreeForUser(ctx, userId, search)
}
