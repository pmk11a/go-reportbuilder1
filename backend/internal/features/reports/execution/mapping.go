package execution

import (
	"encoding/json"

	"github.com/masza1/dapen-backend/internal/features/reports"
)

// mapReportToDetailResponse converts raw domain entities into the detail response DTO.
// This is a local copy of the mapping logic from the reports package to avoid import cycles.
func mapReportToDetailResponse(
	report *reports.SDBMasterLaporan,
	filters []reports.SDBParameterLaporan,
	datasets []reports.SDBQueryLaporan,
	columns map[string][]reports.SDBKolomLaporan,
	groups []reports.SDBGroupLaporan,
	komponen []reports.SDBKomponenLaporan,
	access []reports.SUserAccess,
) *reports.SReportDetailResponse {
	var footerBands json.RawMessage
	if report.FooterBands != nil && *report.FooterBands != "" {
		footerBands = json.RawMessage(*report.FooterBands)
	}

	var filterResponses []reports.SFilterResponse
	for _, f := range filters {
		filterResponses = append(filterResponses, mapFilterToResponse(&f))
	}

	var datasetResponses []reports.SDatasetResponse
	for _, d := range datasets {
		datasetResponses = append(datasetResponses, mapDatasetToResponse(&d))
	}

	columnResponses := make(map[string][]reports.SColumnResponse)
	for dataset, cols := range columns {
		var responses []reports.SColumnResponse
		for _, c := range cols {
			responses = append(responses, mapColumnToResponse(&c))
		}
		columnResponses[dataset] = responses
	}

	var groupResponses []reports.SGroupResponse
	for _, g := range groups {
		groupResponses = append(groupResponses, mapGroupToResponse(&g))
	}

	var komponenResponses []reports.SKomponenResponse
	for _, k := range komponen {
		komponenResponses = append(komponenResponses, mapKomponenToResponse(&k))
	}

	return &reports.SReportDetailResponse{
		IDLaporan:   report.IDLaporan,
		KODEMENU:    report.KODEMENU,
		NamaLaporan: report.NamaLaporan,
		Deskripsi:   report.Deskripsi,
		StatusAktif: report.StatusAktif,
		FooterBands: footerBands,
		Filters:     filterResponses,
		Datasets:    datasetResponses,
		Columns:     columnResponses,
		Groups:      groupResponses,
		Komponen:    komponenResponses,
		Access:      access,
	}
}

func mapFilterToResponse(f *reports.SDBParameterLaporan) reports.SFilterResponse {
	label := f.NamaFilter
	if f.Label != nil {
		label = *f.Label
	}

	var konfigurasi map[string]interface{}
	if f.Konfigurasi != nil && *f.Konfigurasi != "" {
		json.Unmarshal([]byte(*f.Konfigurasi), &konfigurasi)
	}

	return reports.SFilterResponse{
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

func mapDatasetToResponse(d *reports.SDBQueryLaporan) reports.SDatasetResponse {
	var configJSON map[string]interface{}
	if d.ConfigJSON != nil && *d.ConfigJSON != "" {
		json.Unmarshal([]byte(*d.ConfigJSON), &configJSON)
	}

	return reports.SDatasetResponse{
		IDQuery:         d.IDQuery,
		IDLaporan:       d.IDLaporan,
		NamaDataset:     d.NamaDataset,
		QuerySumberData: d.QuerySumberData,
		Deskripsi:       d.Deskripsi,
		Urutan:          d.Urutan,
		Visible:         d.Visible,
		ConfigJSON:      configJSON,
	}
}

func mapColumnToResponse(c *reports.SDBKolomLaporan) reports.SColumnResponse {
	labelTampil := c.NamaKolom
	if c.LabelTampil != nil {
		labelTampil = *c.LabelTampil
	}

	return reports.SColumnResponse{
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

func mapGroupToResponse(g *reports.SDBGroupLaporan) reports.SGroupResponse {
	var styleConfig, configJSON map[string]interface{}
	if g.StyleConfig != nil && *g.StyleConfig != "" {
		json.Unmarshal([]byte(*g.StyleConfig), &styleConfig)
	}
	if g.ConfigJSON != nil && *g.ConfigJSON != "" {
		json.Unmarshal([]byte(*g.ConfigJSON), &configJSON)
	}

	return reports.SGroupResponse{
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

func mapKomponenToResponse(k *reports.SDBKomponenLaporan) reports.SKomponenResponse {
	var konfigurasiLayout map[string]interface{}
	if k.KonfigurasiLayout != "" {
		json.Unmarshal([]byte(k.KonfigurasiLayout), &konfigurasiLayout)
	}

	return reports.SKomponenResponse{
		IDKomponen:        k.IDKomponen,
		IDLaporan:         k.IDLaporan,
		NamaKomponen:      k.NamaKomponen,
		KonfigurasiLayout: konfigurasiLayout,
		Urutan:            k.Urutan,
		IsActive:          k.IsActive,
	}
}
