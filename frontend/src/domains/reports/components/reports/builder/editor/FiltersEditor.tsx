import { useMemo, useState } from 'react';
import { Plus, Trash2, GripVertical } from 'lucide-react';
import { Button, Input, Textarea, Select, SelectTrigger, SelectValue, SelectContent, SelectItem, Checkbox, Each, Show } from '@/shared/ui';
import { SearchableSelect } from '@/shared/ui/form/searchable-select';
import { useBrowseTypes } from '@/domains/browse/hooks/useBrowse';
import type { IReportConfig } from '@/domains/reports/types';
import { DataSourceManager } from './DataSourceManager';
import { HelpGuide } from '../HelpGuide';

export function FiltersEditor({ config, onChange, isDark }: { config: Partial<IReportConfig>, onChange: any, isDark: boolean }) {
  const { data: browseTypes, isLoading: isLoadingBrowse } = useBrowseTypes();
  const filters = config.filters || [];
  const datasets = config.datasets || [];
  const availableDataSources = datasets
    .filter(d => d.config_json?.scope === 'global' || d.config_json?.scope === 'filter')
    .map(d => ({ id: d.id_query.toString(), name: `${d.nama_dataset} (${d.config_json?.scope === 'global' ? 'Global' : 'Filter'})` }));
  const headingClass = isDark ? 'text-slate-200' : 'text-slate-800';
  
  const browseOptions = useMemo(() => {
    return browseTypes?.map((bt: any) => ({
      value: bt.kodeBrowse,
      label: `${bt.kodeBrowse} ${bt.group ? `(${bt.group})` : ''}`
    })) || []
  }, [browseTypes]);
  
  // Drag and Drop State
  const [draggedIdx, setDraggedIdx] = useState<number | null>(null);

  const addFilter = () => {
    onChange({ ...config, filters: [...filters, { nama_filter: 'new_filter', label: 'New Filter', tipe_input: 'text' }] });
  };

  const updateFilter = (index: number, key: string, value: any) => {
    const newFilters = [...filters];
    newFilters[index] = { ...newFilters[index], [key]: value };
    onChange({ ...config, filters: newFilters });
  };

  const updateFilterConfig = (index: number, configUpdates: any) => {
    const newFilters = [...filters];
    newFilters[index] = { 
      ...newFilters[index], 
      konfigurasi: { ...(newFilters[index].konfigurasi || {}), ...configUpdates } 
    };
    onChange({ ...config, filters: newFilters });
  };

  // Drag handlers
  const handleDragStart = (e: React.DragEvent, index: number) => {
    setDraggedIdx(index);
    e.dataTransfer.effectAllowed = 'move';
    e.currentTarget.classList.add('opacity-50');
  };

  const handleDragEnd = (e: React.DragEvent) => {
    setDraggedIdx(null);
    e.currentTarget.classList.remove('opacity-50');
  };

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault();
    e.dataTransfer.dropEffect = 'move';
  };

  const handleDrop = (e: React.DragEvent, dropIdx: number) => {
    e.preventDefault();
    if (draggedIdx === null || draggedIdx === dropIdx) return;
    
    const newFilters = [...filters];
    const draggedItem = newFilters[draggedIdx];
    newFilters.splice(draggedIdx, 1);
    newFilters.splice(dropIdx, 0, draggedItem);
    
    // Update urutan 'posisi' berdasarkan array index
    const reorderedFilters = newFilters.map((f, i) => ({ ...f, posisi: i + 1 }));
    onChange({ ...config, filters: reorderedFilters });
  };

  return (
    <div className="space-y-8">
      {/* 1. Pre-Fetch Queries Section */}
      <div className="flex justify-between items-center mb-2">
        <h2 className={`text-lg font-bold ${isDark ? 'text-slate-200' : 'text-slate-800'}`}>Pengaturan Filter</h2>
        <HelpGuide title="Panduan Tab Filters">
          <p>Tab <strong>Filters</strong> digunakan untuk mendefinisikan parameter input (filter) yang akan ditanyakan ke pengguna sebelum men-generate laporan.</p>
          <ul className="list-disc pl-5 space-y-1">
            <li><strong>Filter Data Sources:</strong> Tambahkan query dataset jika Anda butuh mengambil nilai dinamis dari database untuk dijadikan Nilai Default (misal: mencari tanggal hari ini).</li>
            <li><strong>Tipe Input:</strong> Pilih jenis input seperti Teks, Tanggal, atau Dropdown (berasal dari API atau query database).</li>
            <li><strong>Variabel / Nama Filter:</strong> Pastikan sesuai dengan nama variabel di dalam SQL/Stored Procedure Anda (misal: <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-xs">TglAwal</code>, <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-xs">Divisi</code>). Parameter yang dikirimkan secara otomatis dari klien ketika dieksekusi.</li>
          </ul>
        </HelpGuide>
      </div>
      <div className="space-y-3">
      <DataSourceManager
        config={config}
        onChange={onChange}
        isDark={isDark}
        scope="filter"
        title="Filter Data Sources (Local)"
        description="Ambil data awal dari DB untuk dijadikan nilai default dinamis khusus pada filter di laporan ini."
      />
      </div>

      <div className={`h-px w-full ${isDark ? 'bg-slate-800' : 'bg-slate-200'}`}></div>

      {/* 2. Filters List */}
      <div className="space-y-4">
        <div className={`sticky top-0 z-20 flex justify-between items-center py-2 px-1 -mx-1 mb-2 ${isDark ? 'bg-[#0f172a]' : 'bg-slate-50'}`}>
          <div>
            <h3 className={`font-medium ${headingClass}`}>Daftar Filter (Parameter)</h3>
            <p className={`text-xs ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Urutkan filter dengan men-drag ikon di sebelah kiri.</p>
          </div>
          <Button variant="default" size="sm" onClick={addFilter}>
            <Plus className="w-4 h-4 mr-1" /> Tambah Filter
          </Button>
        </div>
        
        <div className="space-y-3">
          <Each of={filters}>
            {(f, i) => (
              <div 
                key={f.id_parameter || i} 
                draggable
                onDragStart={(e) => handleDragStart(e, i)}
                onDragEnd={handleDragEnd}
                onDragOver={(e) => handleDragOver(e)}
                onDrop={(e) => handleDrop(e, i)}
                className={`border rounded-xl p-4 flex gap-3 items-start relative transition-all ${isDark ? 'bg-slate-900 border-slate-700' : 'bg-white border-slate-200 shadow-sm'} ${draggedIdx === i ? 'border-primary-500 shadow-lg' : ''}`}
              >
                <div className={`pt-2 cursor-grab active:cursor-grabbing ${isDark ? 'text-slate-500 hover:text-slate-300' : 'text-slate-400 hover:text-slate-600'}`}>
                  <GripVertical className="w-5 h-5" />
                </div>
                
                <div className="flex-1 space-y-4 pr-6">
                  <Button 
                    variant="ghost" size="icon" 
                    onClick={() => onChange({ ...config, filters: filters.filter((_, idx) => idx !== i) })} 
                    className="absolute top-2 right-2 text-red-500 h-7 w-7 p-0 rounded-full hover:bg-red-50 dark:hover:bg-red-950/50"
                  >
                    <Trash2 className="w-3.5 h-3.5" />
                  </Button>

                  <div className="grid grid-cols-1 md:grid-cols-12 gap-4 items-start">
                    <div className="md:col-span-4 space-y-1">
                      <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Nama Parameter</label>
                      <Input 
                        className={`h-9 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                        placeholder="e.g. @TglAwal"
                        value={f.nama_filter || ''} onChange={e => updateFilter(i, 'nama_filter', e.target.value)}
                      />
                      <span className={`text-[10px] block leading-tight ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Variabel di query/SP yang akan digantikan nilainya saat eksekusi.</span>
                    </div>
                    <div className="md:col-span-4 space-y-1">
                      <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Label Form UI</label>
                      <Input 
                        className={`h-9 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                        placeholder="e.g. Tanggal Mulai"
                        value={f.label || ''} onChange={e => updateFilter(i, 'label', e.target.value)}
                      />
                      <span className={`text-[10px] block leading-tight ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Teks yang akan ditampilkan kepada user di atas input filter.</span>
                    </div>
                    <div className="md:col-span-4 space-y-1">
                      <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Tipe Input</label>
                      <Select value={f.tipe_input || 'text'} onValueChange={(val) => updateFilter(i, 'tipe_input', val)}>
                        <SelectTrigger className={`h-9 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}>
                          <SelectValue placeholder="Tipe" />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="text">Text Biasa</SelectItem>
                          <SelectItem value="date">Tanggal (Date)</SelectItem>
                          <SelectItem value="month">Bulan (Month)</SelectItem>
                          <SelectItem value="year">Tahun (Year)</SelectItem>
                          <SelectItem value="number">Angka (Number)</SelectItem>
                          <SelectItem value="combobox">Combobox</SelectItem>
                          <SelectItem value="browse">Browse Lookup</SelectItem>
                          <SelectItem value="dropdown">Dropdown (System)</SelectItem>
                          <SelectItem value="select">Dropdown Statis</SelectItem>
                          <SelectItem value="select-db">Dropdown Database</SelectItem>
                          <SelectItem value="checkbox">Checkbox (True/False)</SelectItem>
                        </SelectContent>
                      </Select>
                      <span className={`text-[10px] block leading-tight opacity-0`}>Spacer</span>
                    </div>
                  </div>

                  <div className={`p-4 border rounded-lg ${isDark ? 'bg-slate-900/50 border-slate-700/50' : 'bg-slate-100/50 border-slate-200/60'}`}>
                    <h4 className={`text-xs font-bold uppercase mb-4 ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Konfigurasi Filter</h4>
                    
                    {/* Tipe Select DB config */}
                    <Show when={f.tipe_input === 'select-db'}>
                      <div className="grid grid-cols-1 md:grid-cols-12 gap-4 mb-4">
                        <div className="md:col-span-12 space-y-1">
                          <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Query Sumber Data Dropdown</label>
                          <Textarea 
                            rows={3}
                            placeholder="SELECT id, nama FROM master_divisi"
                            className={`rounded-xl font-mono text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={f.konfigurasi?.query || ''} 
                            onChange={e => updateFilterConfig(i, { query: e.target.value })}
                          />
                        </div>
                        <div className="md:col-span-6 space-y-1">
                          <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Value Field (Dikirim ke API)</label>
                          <Input 
                            placeholder="id" className={`h-9 rounded-xl font-mono text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={f.konfigurasi?.value_field || ''} 
                            onChange={e => updateFilterConfig(i, { value_field: e.target.value })}
                          />
                        </div>
                        <div className="md:col-span-6 space-y-1">
                          <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Label Field (Ditampilkan)</label>
                          <Input 
                            placeholder="nama" className={`h-9 rounded-xl font-mono text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={f.konfigurasi?.label_field || ''} 
                            onChange={e => updateFilterConfig(i, { label_field: e.target.value })}
                          />
                        </div>
                      </div>
                    </Show>

                    {/* Tipe Browse config */}
                    <Show when={f.tipe_input === 'browse'}>
                      <div className="grid grid-cols-1 gap-4 mb-4">
                        <div className="space-y-1">
                          <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Kode Browse (Identifier Lookup)</label>
                          <SearchableSelect 
                            value={f.konfigurasi?.kode_browse || ''}
                            onValueChange={(val) => updateFilterConfig(i, { kode_browse: val })}
                            options={browseOptions}
                            placeholder="Pilih Kode Browse..."
                            searchPlaceholder="Cari kode browse..."
                            disabled={isLoadingBrowse}
                            triggerClassName={`h-9 rounded-xl font-mono text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                          />
                        </div>
                      </div>
                    </Show>

                    {/* Tipe Select (Statis) config */}
                    <Show when={f.tipe_input === 'select'}>
                      <div className="mb-4">
                        <div className="flex justify-between items-center mb-2">
                          <label className={`text-xs font-semibold ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Pilihan Statis</label>
                          <Button 
                            variant="ghost" size="sm" className="h-6 text-xs px-2"
                            onClick={() => {
                              const existing = f.konfigurasi?.options_statis || [];
                              updateFilterConfig(i, { options_statis: [...existing, { value: '', label: '' }] });
                            }}
                          >
                            <Plus className="w-3 h-3 mr-1" /> Tambah Pilihan
                          </Button>
                        </div>
                        <div className="space-y-2">
                          <Each of={f.konfigurasi?.options_statis || []} fallback={<div className="text-xs text-slate-400 p-2 border rounded-xl text-center">Belum ada pilihan, klik tambah pilihan.</div>}>
                            {(opt, optIdx) => (
                              <div key={optIdx} className="grid grid-cols-1 md:grid-cols-12 gap-3 items-start md:items-center">
                                <div className="md:col-span-5">
                                  <Input 
                                    placeholder="Value (Nilai)" className={`h-9 rounded-xl text-xs w-full ${isDark ? 'bg-slate-950 border-slate-700' : 'bg-white border-slate-200'}`}
                                    value={opt.value} 
                                    onChange={e => {
                                      const opts = [...(f.konfigurasi?.options_statis || [])];
                                      opts[optIdx].value = e.target.value;
                                      updateFilterConfig(i, { options_statis: opts });
                                    }}
                                  />
                                </div>
                                <div className="md:col-span-5">
                                  <Input 
                                    placeholder="Label (Ditampilkan)" className={`h-9 rounded-xl text-xs w-full ${isDark ? 'bg-slate-950 border-slate-700' : 'bg-white border-slate-200'}`}
                                    value={opt.label} 
                                    onChange={e => {
                                      const opts = [...(f.konfigurasi?.options_statis || [])];
                                      opts[optIdx].label = e.target.value;
                                      updateFilterConfig(i, { options_statis: opts });
                                    }}
                                  />
                                </div>
                                <div className="md:col-span-2 flex justify-start md:justify-end">
                                  <Button variant="ghost" size="sm" onClick={() => {
                                    const opts = [...(f.konfigurasi?.options_statis || [])];
                                    opts.splice(optIdx, 1);
                                    updateFilterConfig(i, { options_statis: opts });
                                  }} className="h-9 w-full md:w-auto text-red-500 shrink-0 justify-start md:justify-center">
                                    <Trash2 className="w-4 h-4 mr-2 md:mr-0" /> <span className="md:hidden text-xs">Hapus</span>
                                  </Button>
                                </div>
                              </div>
                            )}
                          </Each>
                        </div>
                      </div>
                    </Show>

                    {/* Tipe Dropdown System config */}
                    <Show when={f.tipe_input === 'dropdown'}>
                      <div className="grid grid-cols-1 md:grid-cols-12 gap-4 mb-4">
                        <div className="md:col-span-6 space-y-1">
                          <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Jenis Sistem</label>
                          <Select 
                            value={f.konfigurasi?.jenis_sistem || ''} 
                            onValueChange={(val) => updateFilterConfig(i, { jenis_sistem: val })}
                          >
                            <SelectTrigger className={`h-9 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}>
                              <SelectValue placeholder="Pilih Sistem..." />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="bulan">Daftar Bulan (Jan-Des)</SelectItem>
                              <SelectItem value="tahun">Daftar Tahun (2010 - 2030)</SelectItem>
                              <SelectItem value="status_aktif">Status Aktif (Aktif/Tidak Aktif)</SelectItem>
                              <SelectItem value="status_lunas">Status Lunas (Lunas/Belum Lunas)</SelectItem>
                            </SelectContent>
                          </Select>
                          <span className={`text-[10px] block leading-tight ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Pilihan bawaan sistem yang tidak memerlukan setup tabel atau query tambahan.</span>
                        </div>
                      </div>
                    </Show>

                    {/* Sumber Nilai Default */}
                    <div className="grid grid-cols-1 md:grid-cols-12 gap-4 items-start mb-4">
                      <div className="md:col-span-4 space-y-1">
                        <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Sumber Nilai Default</label>
                        <Select 
                          value={f.konfigurasi?.default_source?.type || 'static'} 
                          onValueChange={(val) => updateFilterConfig(i, { default_source: { ...(f.konfigurasi?.default_source || {}), type: val }})}
                        >
                          <SelectTrigger className={`h-9 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}>
                            <SelectValue placeholder="Pilih Sumber" />
                          </SelectTrigger>
                          <SelectContent>
                            <SelectItem value="static">Statis (Manual)</SelectItem>
                            <SelectItem value="prefetch">Dinamis (Dari Pre-Fetch)</SelectItem>
                          </SelectContent>
                        </Select>
                      </div>

                      <div className="md:col-span-8">
                        <Show when={f.konfigurasi?.default_source?.type === 'prefetch'} fallback={
                          <div className="space-y-1">
                            <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Nilai Default Statis</label>
                            <Input 
                              placeholder="e.g. 2024-01-01 atau Kosongkan" className={`h-9 rounded-xl text-xs w-full ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                              value={f.nilai_default || ''} 
                              onChange={e => updateFilter(i, 'nilai_default', e.target.value)}
                            />
                          </div>
                        }>
                          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div className="space-y-1">
                              <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Sumber Pre-Fetch</label>
                              <Select 
                                value={f.konfigurasi?.default_source?.prefetch_id || ''} 
                                onValueChange={(val) => updateFilterConfig(i, { default_source: { ...(f.konfigurasi?.default_source || {}), prefetch_id: val }})}
                              >
                                <SelectTrigger className={`h-9 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}>
                                  <SelectValue placeholder="Pilih Source" />
                                </SelectTrigger>
                                <SelectContent>
                                  <Show when={availableDataSources.length === 0}>
                                    <SelectItem value="none" disabled>Belum ada Pre-Fetch Query</SelectItem>
                                  </Show>
                                  <Each of={availableDataSources}>
                                    {(q: any) => <SelectItem key={q.id} value={q.id}>{q.name}</SelectItem>}
                                  </Each>
                                </SelectContent>
                              </Select>
                            </div>
                            <div className="space-y-1">
                              <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Nama Field Response</label>
                              <Input 
                                placeholder="e.g. tanggal_mulai" className={`h-9 rounded-xl text-xs font-mono w-full ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                                value={f.konfigurasi?.default_source?.field_name || ''} 
                                onChange={e => updateFilterConfig(i, { default_source: { ...(f.konfigurasi?.default_source || {}), field_name: e.target.value }})}
                              />
                            </div>
                          </div>
                        </Show>
                      </div>
                    </div>

                    <div className="mt-4 pt-4 border-t border-dashed border-slate-300 dark:border-slate-700 space-y-4">
                      <div className="grid grid-cols-1 md:grid-cols-12 gap-4">
                        <div className="md:col-span-6 space-y-1">
                          <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Lebar (Colspan)</label>
                          <Input 
                            type="number" 
                            min={1} 
                            max={12} 
                            className={`h-9 rounded-xl text-xs w-full ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={f.konfigurasi?.colspan || ''} 
                            onChange={e => updateFilterConfig(i, { colspan: e.target.value ? parseInt(e.target.value, 10) : undefined })}
                            placeholder="Nilai 1-12"
                          />
                          <span className={`text-[10px] block leading-tight ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Min: 1, Max: 12 (1 baris penuh). Default otomatis.</span>
                        </div>
                      </div>
                      
                      <div className="flex flex-col gap-3">
                        <label className={`flex items-center cursor-pointer text-xs font-semibold ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>
                          <Checkbox checked={!!f.wajib_isi} onChange={(e: any) => updateFilter(i, 'wajib_isi', e.target.checked)} className="mr-2" />
                          <span>Wajib Isi (Mandatory)</span>
                        </label>
                        <Show when={['dropdown', 'browse', 'select', 'select-db'].includes(f.tipe_input || 'text')}>
                          <label className={`flex items-center cursor-pointer text-xs font-semibold ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>
                            <Checkbox checked={!!f.konfigurasi?.is_multiple} onChange={(e: any) => updateFilterConfig(i, { is_multiple: e.target.checked })} className="mr-2" />
                            <span>Pilih Multiple (Banyak)</span>
                          </label>
                        </Show>
                      </div>
                    </div>
                  </div>

                </div>
              </div>
            )}
          </Each>
        </div>
      </div>
    </div>
  );
}
