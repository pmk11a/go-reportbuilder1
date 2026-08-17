import { useState, useEffect, useRef, useCallback } from 'react';
import { useQueryClient } from '@tanstack/react-query';
import { ReportEditor } from './ReportEditor';
import { ReportPreview } from './ReportPreview';
import type { ILayoutConfig, IReportConfig } from '@/domains/reports/types';
import { Save, ArrowLeft, Monitor, Smartphone } from 'lucide-react';
import { useNavigate } from '@tanstack/react-router';
import { useThemeStore } from '@/shared/stores/themeStore';
import { Button, Tabs } from '@/shared/ui';
import { useReports } from '@/domains/reports/hooks/useReport';
import { useGetTabGeneral, useGetTabFilters, useGetTabKomponen } from '@/domains/reports/hooks/useReportBuilder';
import { reportService } from '@/domains/reports/services/reportService';
import { useToast } from '@/shared/hooks/use-toast';

export function ReportBuilder({ kodeMenu }: { kodeMenu?: string }) {
  const navigate = useNavigate();
  const { toast } = useToast();
  const isDark = useThemeStore((s) => s.isDark);
  const queryClient = useQueryClient();
  
  const { data: reports } = useReports();
  const reportId = (kodeMenu && kodeMenu !== 'new') ? (reports?.find(r => r.KODEMENU === kodeMenu)?.id_laporan || null) : null;

  const [activeTab, setActiveTab] = useState<string>(() => {
    if (typeof window !== 'undefined') {
      const saved = localStorage.getItem('report-editor-tab');
      return saved || 'general';
    }
    return 'general';
  });

  // generalData selalu difetch agar tersedia di semua tab
  const { data: generalData, isLoading: l1 } = useGetTabGeneral(reportId, true);
  const { data: filtersData, isLoading: l2 } = useGetTabFilters(reportId, activeTab === 'filters');
  const { data: komponenData, isLoading: l3 } = useGetTabKomponen(reportId, ['header', 'body', 'footer'].includes(activeTab));

  const isLoading = (kodeMenu && kodeMenu !== 'new' && reportId) ? 
    (activeTab === 'general' ? l1 : activeTab === 'filters' ? l2 : l3) 
    : false;

  const [zoom, setZoom] = useState(0.8);
  const [orientation, setOrientation] = useState<'portrait' | 'landscape'>('portrait');
  const [isAutoFit, setIsAutoFit] = useState(true);
  const [isFitTable, setIsFitTable] = useState(false);
  const previewContainerRef = useRef<HTMLDivElement>(null);

  const calculateAutoFitZoom = useCallback(() => {
    if (!previewContainerRef.current) return;
    const containerWidth = previewContainerRef.current.clientWidth - 32;
    const paperWidthMm = orientation === 'landscape' ? 297 : 210;
    const paperWidthPx = paperWidthMm * (96 / 25.4);
    const newZoom = Math.min(1.5, Math.max(0.3, containerWidth / paperWidthPx));
    setZoom(Math.round(newZoom * 100) / 100);
  }, [orientation]);

  // Auto-fit using ResizeObserver so it works when tab becomes visible
  useEffect(() => {
    if (!isAutoFit) return;
    const el = previewContainerRef.current;
    if (!el) {
      // Tab might not be mounted yet, retry
      const timer = setTimeout(calculateAutoFitZoom, 500);
      return () => clearTimeout(timer);
    }
    calculateAutoFitZoom();
    const observer = new ResizeObserver(() => calculateAutoFitZoom());
    observer.observe(el);
    return () => observer.disconnect();
  }, [isAutoFit, calculateAutoFitZoom]);

  // Full report configuration state
  const [reportConfig, setReportConfig] = useState<Partial<IReportConfig>>({});

  // Layout config state
  const [layoutConfig, setLayoutConfig] = useState<ILayoutConfig[]>([]);

  // Effect: sync reportConfig saat generalData/filtersData siap
  useEffect(() => {
    if (kodeMenu === 'new') {
      setReportConfig({
        nama_laporan: '',
        KODEMENU: '',
        status_aktif: true,
        deskripsi: '',
        filters: [],
        datasets: []
      });
    } else if (generalData) {
      setReportConfig({
        ...generalData,
        filters: filtersData || [],
        datasets: generalData.datasets || [],
      });
    }
  }, [kodeMenu, generalData, filtersData]);

  // Effect: sync layoutConfig saat komponenData siap
  useEffect(() => {
    if (kodeMenu === 'new') {
      setLayoutConfig([
        { type: 'header', rows: [] },
        { type: 'body', rows: [] },
        { type: 'footer', rows: [] }
      ]);
      return;
    }

    if (!komponenData) return;

    const komponentList = komponenData as any[];

    const parseSection = (namaKomponen: string, type: string) => {
      const found = komponentList.find((k: any) => k.nama_komponen === namaKomponen);
      if (found?.konfigurasi_layout) {
        try {
          const parsed = typeof found.konfigurasi_layout === 'string'
            ? JSON.parse(found.konfigurasi_layout)
            : found.konfigurasi_layout;
          // bisa berupa object langsung {type, rows}
          if (parsed && typeof parsed === 'object' && !Array.isArray(parsed) && parsed.rows) {
            return parsed;
          }
        } catch (e) {
          console.error('Failed to parse komponen layout:', e);
        }
      }
      return { type, rows: [] };
    };

    setLayoutConfig([
      parseSection('HeaderLayout', 'header'),
      parseSection('BodyLayout', 'body'),
      parseSection('FooterLayout', 'footer'),
    ]);
  }, [kodeMenu, komponenData]);

  const handleSave = async () => {
    try {
      if (kodeMenu === 'new' || !reportId) {
        if (!reportConfig.KODEMENU || !reportConfig.nama_laporan) {
          toast({ title: 'Kode Menu dan Nama Laporan wajib diisi!', variant: 'destructive' });
          return;
        }
        
        // Simpan sebagai laporan baru (hanya tab general yang valid di awal)
        const finalPayload = {
          ...reportConfig,
          komponen: [{ nama_komponen: 'DynamicLayout', konfigurasi_layout: JSON.stringify(layoutConfig) }]
        };
        const created = await reportService.createReport(finalPayload as any);
        if (created) {
          toast({ title: 'Laporan baru berhasil dibuat!', variant: 'success' });
          navigate({ to: '/admin/reports/builder' });
        }
        return;
      }

      // --- EXISTING REPORT SAVE LOGIC (Contextual based on activeTab) ---
      
      if (activeTab === 'general') {
        // Hanya simpan General (Detail + Datasets)
        await reportService.updateReport(reportId, reportConfig);
        
        // Handle Datasets
        if (generalData?.datasets) {
          const currentDsIds = (reportConfig.datasets || []).map(q => q.id_query);
          for (const oldDs of generalData.datasets) {
            if (!currentDsIds.includes(oldDs.id_query)) {
              await reportService.deleteDataset(reportId, oldDs.id_query);
            }
          }
        }
        if (reportConfig.datasets) {
          for (let i = 0; i < reportConfig.datasets.length; i++) {
            const ds = reportConfig.datasets[i];
            const isNew = ds.id_query.toString().length > 10;
            const dsPayload = {
              id_laporan: reportId,
              nama_dataset: ds.nama_dataset,
              query_sumber_data: ds.query_sumber_data,
              urutan: i + 1,
              visible: true,
              config_json: ds.config_json
            };
            if (isNew) {
              await reportService.createDataset(reportId, dsPayload);
            } else {
              await reportService.updateDataset(reportId, ds.id_query, dsPayload);
            }
          }
        }
        toast({ title: 'Tab General berhasil disimpan!', variant: 'success' });
        queryClient.invalidateQueries({ queryKey: ['report-builder', 'general', reportId] });

      } else if (activeTab === 'filters') {
        // Hanya simpan Filters
        if (filtersData) {
          const currentFilterIds = (reportConfig.filters || []).map(f => f.id_parameter).filter(Boolean);
          for (const oldF of filtersData) {
            if (!currentFilterIds.includes(oldF.id_parameter)) {
              await reportService.deleteFilter(reportId, oldF.id_parameter);
            }
          }
        }
        if (reportConfig.filters) {
          for (const f of reportConfig.filters) {
            if (f.id_parameter) {
              await reportService.updateFilter(reportId, f.id_parameter, f);
            } else {
              await reportService.createFilter(reportId, f);
            }
          }
        }
        toast({ title: 'Tab Filters berhasil disimpan!', variant: 'success' });
        queryClient.invalidateQueries({ queryKey: ['report-builder', 'filters', reportId] });

      } else if (['header', 'body', 'footer'].includes(activeTab)) {
        // Simpan Dataset lokal scope tab ini (create/update/delete)
        const tabScope = activeTab as 'header' | 'body' | 'footer';
        const tabDatasets = (reportConfig.datasets || []).filter(d => d.config_json?.scope === tabScope);
        const serverDatasets = (generalData?.datasets || []).filter((d: any) => d.config_json?.scope === tabScope);

        // Delete datasets yang sudah dihapus
        for (const old of serverDatasets) {
          if (!tabDatasets.find(d => d.id_query === old.id_query)) {
            await reportService.deleteDataset(reportId, old.id_query);
          }
        }
        // Create/update datasets
        for (let i = 0; i < tabDatasets.length; i++) {
          const ds = tabDatasets[i];
          const isNew = ds.id_query.toString().length > 10;
          const dsPayload = {
            id_laporan: reportId,
            nama_dataset: ds.nama_dataset,
            deskripsi: ds.deskripsi,
            query_sumber_data: ds.query_sumber_data,
            urutan: i + 1,
            visible: true,
            config_json: ds.config_json
          };
          if (isNew) {
            await reportService.createDataset(reportId, dsPayload);
          } else {
            await reportService.updateDataset(reportId, ds.id_query, dsPayload);
          }
        }

        // Upsert komponen layout by nama_komponen (header/body/footer)
        const layoutSection = layoutConfig.find(l => l.type === activeTab);
        const komponenNames: Record<string, string> = {
          header: 'HeaderLayout',
          body: 'BodyLayout',
          footer: 'FooterLayout',
        };
        await reportService.upsertKomponen(reportId, {
          nama_komponen: komponenNames[activeTab],
          konfigurasi_layout: JSON.stringify(layoutSection || { type: activeTab, rows: [] }),
        });

        toast({ title: `Tab ${activeTab.charAt(0).toUpperCase() + activeTab.slice(1)} Layout berhasil disimpan!`, variant: 'success' });
        queryClient.invalidateQueries({ queryKey: ['report-builder', 'komponen', reportId] });
        queryClient.invalidateQueries({ queryKey: ['report-builder', 'general', reportId] });
      }

    } catch (err: any) {
      toast({ title: 'Gagal menyimpan konfigurasi: ' + err.message, variant: 'destructive' });
    }
  };

  const handleDeleteReport = async () => {
    if (!reportId) return;
    if (window.confirm('Yakin ingin menghapus laporan ini? Seluruh data tab akan hilang.')) {
      const success = await reportService.deleteReport(reportId);
      if (success) {
        toast({ title: 'Laporan berhasil dihapus!', variant: 'success' });
        navigate({ to: '/admin/reports/builder' });
      } else {
        toast({ title: 'Gagal menghapus laporan.', variant: 'destructive' });
      }
    }
  };

  return (
    <div className={`flex flex-col h-screen ${isDark ? 'bg-[#0f172a]' : 'bg-slate-50'}`}>
      {/* Top Navbar */}
      <div className={`flex flex-col sm:flex-row sm:items-center justify-between px-4 sm:px-6 py-4 gap-4 border-b ${isDark ? 'bg-slate-900 border-slate-800' : 'bg-white border-slate-200 shadow-sm'}`}>
        <div className="flex items-center gap-4">
          <Button 
            variant="outline"
            size="sm"
            onClick={() => navigate({ to: '/admin/reports/laporan' })}
            className="rounded-full w-9 h-9 p-0 shrink-0"
          >
            <ArrowLeft className="w-4 h-4" />
          </Button>
          <div>
            <h1 className={`text-lg sm:text-xl font-bold ${isDark ? 'text-white' : 'text-slate-900'}`}>Report Builder</h1>
            <p className={`text-xs sm:text-sm ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Susun Konfigurasi Laporan (Filter, SP, Layout)</p>
          </div>
        </div>
        <Button onClick={handleSave} className="w-full sm:w-auto">
          <Save className="w-4 h-4 mr-2" /> 
          Simpan {
            activeTab === 'general' ? 'General' :
            activeTab === 'filters' ? 'Filters' : 
            'Layout'
          }
        </Button>
      </div>

      {/* Main Container */}
      <div className="flex-1 overflow-y-auto xl:overflow-hidden bg-slate-50 dark:bg-[#0f172a]">
        
        {/* Desktop Split Screen */}
        <div className="hidden xl:flex flex-row h-full p-6 gap-6">
          {/* Left Side: Editor */}
          <div className="w-1/2 max-w-175 h-full flex flex-col shrink-0 overflow-y-auto overflow-x-hidden">
            <ReportEditor 
              activeTab={activeTab}
              setActiveTab={setActiveTab}
              reportConfig={reportConfig} 
              setReportConfig={setReportConfig}
              layoutConfig={layoutConfig} 
              setLayoutConfig={setLayoutConfig}
              onDeleteReport={handleDeleteReport}
              isLoading={isLoading}
            />
          </div>
          
          {/* Right Side: Preview */}
          <div className={`flex-1 h-full rounded-3xl relative overflow-hidden border ${isDark ? 'bg-slate-950 border-white/5' : 'bg-slate-100 border-slate-200'}`}>
            <div ref={previewContainerRef} className="absolute inset-0 overflow-auto flex flex-col justify-start items-center p-4">
              <ReportPreview config={layoutConfig} zoom={zoom} orientation={reportConfig.paperConfig?.orientation || orientation} paperConfig={reportConfig.paperConfig} isFitTable={isFitTable} />
            </div>

            <div className="absolute top-4 right-4 bg-white dark:bg-slate-800 shadow-lg rounded-full p-1.5 flex gap-1 z-50 border border-slate-200 dark:border-slate-700">
              <Button variant="ghost" size="icon" onClick={() => { setIsAutoFit(v => !v); if (!isAutoFit) setTimeout(calculateAutoFitZoom, 100); }} className={`h-8 w-8 rounded-full ${isAutoFit ? 'text-blue-500 bg-blue-50 dark:bg-blue-900/30' : 'text-slate-500'}`} title="Auto Fit Zoom">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M18 8L22 12L18 16"/><path d="M6 8L2 12L6 16"/><path d="M2 12H22"/></svg>
              </Button>
              <div className="w-px h-4 bg-slate-200 dark:bg-slate-700 my-auto mx-1" />
              <Button variant="ghost" size="icon" onClick={() => setOrientation(o => o === 'portrait' ? 'landscape' : 'portrait')} className="h-8 w-8 rounded-full text-slate-500" title="Ubah Orientasi">
                {orientation === 'portrait' ? <Smartphone className="w-4 h-4" /> : <Monitor className="w-4 h-4" />}
              </Button>
              <div className="w-px h-4 bg-slate-200 dark:bg-slate-700 my-auto mx-1" />
              <Button variant="ghost" size="icon" onClick={() => setIsFitTable(v => !v)} className={`h-8 w-8 rounded-full ${isFitTable ? 'text-blue-500 bg-blue-50 dark:bg-blue-900/30' : 'text-slate-500'}`} title="Fit Table ke Paper">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18"/><path d="M3 15h18"/><path d="M9 3v18"/><path d="M15 3v18"/></svg>
              </Button>
              <div className="w-px h-4 bg-slate-200 dark:bg-slate-700 my-auto mx-1" />
              <Button variant="ghost" size="icon" onClick={() => { setIsAutoFit(false); setZoom(z => Math.max(0.3, z - 0.1)); }} className="h-8 w-8 rounded-full">
                <span className="text-lg font-bold leading-none">-</span>
              </Button>
              <div className="flex items-center justify-center w-12 text-xs font-medium dark:text-slate-200">
                {Math.round(zoom * 100)}%
              </div>
              <Button variant="ghost" size="icon" onClick={() => { setIsAutoFit(false); setZoom(z => Math.min(2, z + 0.1)); }} className="h-8 w-8 rounded-full">
                <span className="text-lg font-bold leading-none">+</span>
              </Button>
            </div>
          </div>
        </div>

        {/* Mobile Tabs */}
        <div className="xl:hidden">
          <Tabs 
            storageKey="report-builder-mobile-tab"
            tabs={[
              {
                label: 'Editor Konfigurasi',
                value: 'editor',
                content: (
                  <div className="xl:p-2 bg-slate-50 dark:bg-[#0f172a]">
                    <ReportEditor 
                      reportConfig={reportConfig} 
                      setReportConfig={setReportConfig}
                      layoutConfig={layoutConfig} 
                      setLayoutConfig={setLayoutConfig}
                      onDeleteReport={handleDeleteReport}
                      activeTab={activeTab}
                      setActiveTab={setActiveTab}
                      isLoading={isLoading}
                    />
                  </div>
                )
              },
              {
                label: 'Preview Laporan',
                value: 'preview',
                content: (
                  <div className={`w-full h-[calc(100vh-220px)] rounded-3xl relative overflow-hidden border ${isDark ? 'bg-slate-950 border-white/5' : 'bg-slate-100 border-slate-200'}`}>
                    <div ref={previewContainerRef} className="absolute inset-0 overflow-auto flex flex-col justify-start items-center p-4">
                      <ReportPreview config={layoutConfig} zoom={zoom} orientation={orientation} paperConfig={reportConfig.paperConfig} isAutoFit={isAutoFit} isFitTable={isFitTable} />
                    </div>
                    
                    <div className="absolute top-4 right-4 bg-white dark:bg-slate-800 shadow-lg rounded-full p-1.5 flex gap-1 z-50 border border-slate-200 dark:border-slate-700">
                      <Button variant="ghost" size="icon" onClick={() => { setIsAutoFit(v => !v); if (!isAutoFit) calculateAutoFitZoom(); }} className={`h-8 w-8 rounded-full ${isAutoFit ? 'text-blue-500 bg-blue-50 dark:bg-blue-900/30' : 'text-slate-500'}`} title="Auto Fit Zoom">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M18 8L22 12L18 16"/><path d="M6 8L2 12L6 16"/><path d="M2 12H22"/></svg>
                      </Button>
                      <div className="w-px h-4 bg-slate-200 dark:bg-slate-700 my-auto mx-1" />
                      <Button variant="ghost" size="icon" onClick={() => setOrientation(o => o === 'portrait' ? 'landscape' : 'portrait')} className="h-8 w-8 rounded-full text-slate-500" title="Ubah Orientasi">
                        {orientation === 'portrait' ? <Smartphone className="w-4 h-4" /> : <Monitor className="w-4 h-4" />}
                      </Button>
                      <div className="w-px h-4 bg-slate-200 dark:bg-slate-700 my-auto mx-1" />
                      <Button variant="ghost" size="icon" onClick={() => setIsFitTable(v => !v)} className={`h-8 w-8 rounded-full ${isFitTable ? 'text-blue-500 bg-blue-50 dark:bg-blue-900/30' : 'text-slate-500'}`} title="Fit Table ke Paper">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18"/><path d="M3 15h18"/><path d="M9 3v18"/><path d="M15 3v18"/></svg>
                      </Button>
                      <div className="w-px h-4 bg-slate-200 dark:bg-slate-700 my-auto mx-1" />
                      <Button variant="ghost" size="icon" onClick={() => { setIsAutoFit(false); setZoom(z => Math.max(0.3, z - 0.1)); }} className="h-8 w-8 rounded-full">
                        <span className="text-lg font-bold leading-none">-</span>
                      </Button>
                      <div className="flex items-center justify-center w-12 text-xs font-medium dark:text-slate-200">
                        {Math.round(zoom * 100)}%
                      </div>
                      <Button variant="ghost" size="icon" onClick={() => { setIsAutoFit(false); setZoom(z => Math.min(2, z + 0.1)); }} className="h-8 w-8 rounded-full">
                        <span className="text-lg font-bold leading-none">+</span>
                      </Button>
                    </div>
                  </div>
                )
              }
            ]}
          />
        </div>

      </div>
    </div>
  );
}
