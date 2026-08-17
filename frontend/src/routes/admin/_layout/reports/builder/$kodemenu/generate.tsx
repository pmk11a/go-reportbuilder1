import { createFileRoute } from '@tanstack/react-router'
import { ReportPreview } from '@/domains/reports/components/reports/builder/ReportPreview'
import { useGetTabGeneral, useGetTabFilters, useGetTabKomponen } from '@/domains/reports/hooks/useReportBuilder'
import { useReports, useExecuteReport } from '@/domains/reports/hooks/useReport'
import { Loader2, FileSpreadsheet, FileText, Printer, Filter, Smartphone, Monitor } from 'lucide-react'
import { BuilderFilterPanel } from '@/domains/reports/components/reports/builder/BuilderFilterPanel'
import { useReportStore } from '@/domains/reports/stores/reportStore'
import { reportViewerService } from '@/domains/reports/services/reportService'
import { Show } from '@/shared/ui'
import React, { useMemo } from 'react'

export const Route = createFileRoute('/admin/_layout/reports/builder/$kodemenu/generate')({
  component: ReportGeneratorPage,
})

function ReportGeneratorPage() {
  const { kodemenu } = Route.useParams()
  
  // Find report ID by kodeMenu
  const { data: reports } = useReports()
  const reportId = reports?.find(r => r.KODEMENU === kodemenu)?.id_laporan || null

  // Fetch configs
  // Fetch configs
  const { data: reportGeneral, isLoading: l1 } = useGetTabGeneral(reportId)
  const { data: filterConfigs, isLoading: l2 } = useGetTabFilters(reportId)
  const { data: komponenData, isLoading: l3 } = useGetTabKomponen(reportId)

  const layoutConfig = useMemo(() => {
    if (!komponenData || !Array.isArray(komponenData)) return [];
    
    const parseSection = (sectionName: string, type: 'header' | 'body' | 'footer') => {
      const komp = komponenData.find((k: any) => k.nama_komponen === sectionName);
      if (komp?.konfigurasi_layout) {
        try {
          const parsed = typeof komp.konfigurasi_layout === 'string' 
            ? JSON.parse(komp.konfigurasi_layout) 
            : komp.konfigurasi_layout;
          return { type, ...parsed };
        } catch (e) {
          console.error(`Gagal parsing ${sectionName}:`, e);
        }
      }
      return { type, rows: [] };
    };

    return [
      parseSection('HeaderLayout', 'header'),
      parseSection('BodyLayout', 'body'),
      parseSection('FooterLayout', 'footer'),
    ];
  }, [komponenData]);

  const executeReport = useExecuteReport(kodemenu)
  const filterValues = useReportStore((s) => s.filterValues)

  let reportDatasets: Record<string, any[]> = {}
  if (executeReport.data) {
    const rawData = executeReport.data as any
    if (Array.isArray(rawData)) {
      reportDatasets = { default: rawData }
    } else if (rawData.datasets) {
      reportDatasets = rawData.datasets
    } else {
      reportDatasets = { default: rawData.data || rawData.items || [] }
    }
  }

  const hasAnyData = Object.keys(reportDatasets).some(k => reportDatasets[k] && reportDatasets[k].length > 0)

  const handleExportExcel = async () => {
    if (!hasAnyData) {
      alert('Tidak ada data untuk diekspor')
      return
    }
    try {
      await reportViewerService.downloadReport({
        kodeMenu: kodemenu,
        format: 'xlsx',
        filters: filterValues || {},
      })
    } catch (e) {
      console.error('Export XLSX failed:', e)
      alert('Gagal mengekspor: ' + (e instanceof Error ? e.message : String(e)))
    }
  }

  const handleExportPDF = async () => {
    if (!hasAnyData) {
      alert('Tidak ada data untuk diekspor')
      return
    }
    try {
      await reportViewerService.downloadReport({
        kodeMenu: kodemenu,
        format: 'pdf',
        filters: filterValues || {},
        paperSize: 'a4',
        orientation: 'landscape',
      })
    } catch (e) {
      console.error('Export PDF failed:', e)
      alert('Gagal mengekspor: ' + (e instanceof Error ? e.message : String(e)))
    }
  }

  const handlePrint = () => {
    window.print() // Simplistic fallback if generatePrintHTML is too tightly coupled to DynamicReportViewer
  }

  const [zoom, setZoom] = React.useState(1.5)
  const [orientation, setOrientation] = React.useState<'portrait'|'landscape'>('portrait')
  const [isAutoFit, setIsAutoFit] = React.useState(true)
  const [isFitTable, setIsFitTable] = React.useState(true)

  React.useEffect(() => {
    if (reportGeneral?.paperConfig?.orientation) {
      setOrientation(reportGeneral.paperConfig.orientation)
    }
  }, [reportGeneral])

  React.useEffect(() => {
    setIsAutoFit(zoom === 1.5);
  }, [zoom]);

  const isLoading = l1 || l2 || l3

  if (isLoading || !reportId) {
    return (
      <div className="flex flex-col items-center justify-center w-full h-full p-8 text-center">
        <Loader2 className="w-8 h-8 animate-spin text-primary-500 mb-4" />
        <p className="text-slate-500">Memuat konfigurasi laporan...</p>
      </div>
    )
  }



  return (
    <div className="w-full h-full bg-slate-100 dark:bg-slate-900 overflow-auto flex flex-col">
      <div className="bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 px-4 py-3 flex items-center justify-between sticky top-0 z-10">
        <div>
          <h2 className="text-sm font-semibold text-slate-800 dark:text-slate-200">Preview Laporan</h2>
        </div>
        <div className="flex items-center gap-2">
          <button
            onClick={handleExportExcel}
            disabled={!hasAnyData}
            data-testid="export-excel"
            className="flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-slate-700 dark:text-slate-200 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-md hover:bg-slate-50 dark:hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed shadow-sm transition-colors"
          >
            <FileSpreadsheet className="w-4 h-4 text-green-600" /> Excel
          </button>
          <button
            onClick={handleExportPDF}
            disabled={!hasAnyData}
            data-testid="export-pdf"
            className="flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-slate-700 dark:text-slate-200 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-md hover:bg-slate-50 dark:hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed shadow-sm transition-colors"
          >
            <FileText className="w-4 h-4 text-red-500" /> PDF
          </button>
          <button
            onClick={handlePrint}
            disabled={!hasAnyData}
            data-testid="export-print"
            className="flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-slate-700 dark:text-slate-200 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-md hover:bg-slate-50 dark:hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed shadow-sm transition-colors"
          >
            <Printer className="w-4 h-4 text-blue-600" /> Print
          </button>
        </div>
      </div>

      <div className="flex-1 overflow-y-auto flex flex-col">
        <div className="w-full mx-auto space-y-6 flex flex-col flex-1 px-4 sm:px-6 py-6 max-w-full">
          <BuilderFilterPanel
            kodeMenu={kodemenu}
            filters={filterConfigs || []}
            executeReport={executeReport}
          />

          <Show
            when={!!executeReport.data || executeReport.isPending}
            fallback={
              <div className="flex-1 flex flex-col items-center justify-center p-12 text-slate-400 bg-slate-50/50 dark:bg-slate-800/20 rounded-3xl border border-slate-100 dark:border-white/5 border-dashed min-h-[300px]">
                <div className="p-4 rounded-full bg-slate-100 dark:bg-slate-800 mb-4">
                  <Filter className="w-8 h-8 text-slate-400 dark:text-slate-500" />
                </div>
                <p className="text-center font-medium mb-1 text-slate-600 dark:text-slate-300">
                  Data Belum Ditampilkan
                </p>
                <p className="text-center text-sm max-w-sm mb-4">
                  Silakan sesuaikan parameter filter di atas, kemudian klik "Generate" untuk menampilkan laporan.
                </p>
              </div>
            }
          >
            {executeReport.isPending ? (
              <div className="flex-1 flex flex-col items-center justify-center p-12 bg-white dark:bg-slate-900 rounded-3xl border border-slate-100 dark:border-slate-800 min-h-[300px]">
                <Loader2 className="w-8 h-8 animate-spin text-indigo-500 mb-4" />
                <p className="text-slate-500">Mengeksekusi laporan...</p>
              </div>
            ) : executeReport.isError ? (
              <div className="flex-1 flex items-center justify-center p-12 bg-red-50 dark:bg-red-500/10 rounded-3xl border border-red-100 dark:border-red-500/20 text-red-600 min-h-[300px]">
                Gagal memuat laporan: {executeReport.error?.message}
              </div>
            ) : (
              <div className="bg-slate-100 dark:bg-slate-950 rounded-2xl shadow-sm border border-slate-200 dark:border-slate-800 overflow-hidden h-[calc(100vh-350px)] relative">
                <div className="absolute top-4 right-4 bg-white dark:bg-slate-800 shadow-lg rounded-full p-1.5 flex gap-1 z-50 border border-slate-200 dark:border-slate-700">
                  <button onClick={() => { setIsAutoFit(v => !v); if (!isAutoFit) setZoom(1.5); }} className={`h-8 w-8 rounded-full flex items-center justify-center hover:bg-slate-100 ${isAutoFit ? 'text-blue-500 bg-blue-50 dark:bg-blue-900/30' : 'text-slate-500'}`} title="Auto Fit Zoom (150%)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M18 8L22 12L18 16"/><path d="M6 8L2 12L6 16"/><path d="M2 12H22"/></svg>
                  </button>
                  <div className="w-px h-4 bg-slate-200 dark:bg-slate-700 my-auto mx-1" />
                  <button onClick={() => setOrientation(o => o === 'portrait' ? 'landscape' : 'portrait')} className="h-8 w-8 rounded-full text-slate-500 flex items-center justify-center hover:bg-slate-100" title="Ubah Orientasi">
                    {orientation === 'portrait' ? <Smartphone className="w-4 h-4" /> : <Monitor className="w-4 h-4" />}
                  </button>
                  <div className="w-px h-4 bg-slate-200 dark:bg-slate-700 my-auto mx-1" />
                  <button onClick={() => setIsFitTable(v => !v)} className={`h-8 w-8 rounded-full flex items-center justify-center hover:bg-slate-100 ${isFitTable ? 'text-blue-500 bg-blue-50 dark:bg-blue-900/30' : 'text-slate-500'}`} title="Fit Table ke Paper">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18"/><path d="M3 15h18"/><path d="M9 3v18"/><path d="M15 3v18"/></svg>
                  </button>
                  <div className="w-px h-4 bg-slate-200 dark:bg-slate-700 my-auto mx-1" />
                  <button onClick={() => { setIsAutoFit(false); setZoom(z => Math.max(0.3, z - 0.1)); }} className="h-8 w-8 rounded-full flex items-center justify-center hover:bg-slate-100">
                    <span className="text-lg font-bold leading-none text-slate-600 dark:text-slate-300">-</span>
                  </button>
                  <div className="flex items-center justify-center w-12 text-xs font-medium dark:text-slate-200 text-slate-600">
                    {Math.round(zoom * 100)}%
                  </div>
                  <button onClick={() => { setIsAutoFit(false); setZoom(z => Math.min(2, z + 0.1)); }} className="h-8 w-8 rounded-full flex items-center justify-center hover:bg-slate-100">
                    <span className="text-lg font-bold leading-none text-slate-600 dark:text-slate-300">+</span>
                  </button>
                </div>
                <div className="absolute inset-0 overflow-auto flex flex-col justify-start items-center">
                  <ReportPreview 
                    config={layoutConfig} 
                    zoom={zoom} 
                    orientation={orientation}
                    paperConfig={reportGeneral?.paperConfig} 
                    datasets={reportDatasets}
                    mode="preview"
                    isAutoFit={isAutoFit}
                    isFitTable={isFitTable}
                  />
                </div>
              </div>
            )}
          </Show>
        </div>
      </div>
    </div>
  )
}
