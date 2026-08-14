import { Plus, Trash2, Edit2 } from 'lucide-react';
import { Button, Select, SelectTrigger, SelectValue, SelectContent, SelectItem, Each, Show, Input } from '@/shared/ui';
import type { ILayoutBody, IReportConfig } from '@/domains/reports/types';
import { DataSourceManager } from './DataSourceManager';
import { HelpGuide } from '../HelpGuide';
import { Checkbox } from '@/shared/ui/form/checkbox';

export function BodyEditor({ config, onChange, reportConfig, setReportConfig, onOpenHeaderModal, isDark }: { config: ILayoutBody, onChange: any, reportConfig: Partial<IReportConfig>, setReportConfig: any, onOpenHeaderModal: (rIdx: number, cIdx: number, table: any) => void, isDark: boolean }) {
  const rows = config.rows || [];
  const datasets = reportConfig.datasets || [];
  const availableDataSources = datasets
    .filter(d => d.config_json?.scope === 'global' || d.config_json?.scope === 'body')
    .map(d => ({ id: d.nama_dataset, name: `${d.nama_dataset} (${d.config_json?.scope === 'global' ? 'Global' : 'Body'})` }));
  const cardClass = isDark ? 'bg-slate-800/50 border-slate-700' : 'bg-slate-50 border-slate-200';
  const headingClass = isDark ? 'text-slate-200' : 'text-slate-800';

  const addRow = () => onChange({ ...config, type: 'body', rows: [...rows, { columns: [{ width: '100%', table: { dataset: '', headerRows: [], dataColumns: [] } }] }] });

  return (
    <div className="space-y-8">
      <div className="flex justify-between items-center mb-2">
        <h2 className={`text-lg font-bold ${isDark ? 'text-slate-200' : 'text-slate-800'}`}>Pengaturan Body Layout</h2>
        <HelpGuide title="Panduan Tab Body (Layouting & Struktur Utama)">
          <div className="space-y-4 text-sm leading-relaxed">
            <p>
              Tab <strong>Body</strong> adalah fondasi penyusunan isi utama laporan. Di sini Anda mendefinisikan sumber data (Dataset) dan menatanya dalam bentuk baris (Row) dan blok tabel.
            </p>

            <div>
              <h4 className="font-bold text-slate-800 dark:text-slate-200 mb-1">1. Body Data Sources (Dataset Utama)</h4>
              <ul className="list-disc pl-5 space-y-1 text-slate-600 dark:text-slate-400">
                <li>Berisi *Query SQL* utama yang menghasilkan **array data (banyak baris)** untuk dirender sebagai tabel.</li>
                <li>Gunakan <strong>ID Source</strong> unik dan <strong>Nama Dataset</strong> yang rapi (huruf kecil, garis bawah, misal: <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-[11px]">mutasi_bank</code>).</li>
                <li>Dataset ini nantinya akan dipilih saat Anda mengonfigurasi komponen tabel di bawah.</li>
              </ul>
            </div>

            <div>
              <h4 className="font-bold text-slate-800 dark:text-slate-200 mb-1">2. Body Layout (Struktur Baris & Kolom)</h4>
              <p className="text-slate-600 dark:text-slate-400 mb-2">
                Sistem layouting menggunakan konsep Grid (Baris dan Kolom). Anda bisa menata tabel sejajar atau bertumpuk:
              </p>
              <ul className="list-disc pl-5 space-y-1 text-slate-600 dark:text-slate-400">
                <li><strong>Tambah Baris (Add Row):</strong> Menambah baris horizontal baru.</li>
                <li><strong>Tambah Tabel ke Baris Ini:</strong> Di dalam satu baris, Anda bisa membuat dua atau tiga tabel berjajar ke samping (misal: untuk perbandingan data). Sesuaikan <strong>Lebar (Width)</strong> misal <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-[11px]">50%</code> untuk masing-masing blok.</li>
                <li>Klik tombol <strong>Konfigurasi Tabel</strong> (ikon pensil) pada setiap blok tabel untuk mendesain Header, Kolom (Tbody), dan Rumus perhitungan.</li>
              </ul>
            </div>
          </div>
        </HelpGuide>
      </div>
      <DataSourceManager
        config={reportConfig}
        onChange={setReportConfig}
        isDark={isDark}
        scope="body"
        title="Body Data Sources (Local)"
        description="Query untuk mengambil data utama yang akan dirender dalam bentuk tabel."
      />

      <div className={`h-px w-full ${isDark ? 'bg-slate-800' : 'bg-slate-200'}`}></div>

      {/* 2. Body Layout */}
      <div className={`sticky top-0 z-20 flex justify-between items-center py-2 px-1 -mx-1 mb-2 ${isDark ? 'bg-[#0f172a]' : 'bg-slate-50'}`}>
        <div>
          <h3 className={`font-medium ${headingClass}`}>Body Layout (Tables & Signatures)</h3>
          <p className={`text-xs ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Tentukan isi utama laporan.</p>
        </div>
        <div className="flex gap-2">
          <Button variant="default" size="sm" onClick={addRow}>
            <Plus className="w-4 h-4 mr-1" /> Add Table Row
          </Button>
          <Button variant="secondary" size="sm" onClick={() => {
            onChange({ 
              ...config, type: 'body', 
              rows: [...rows, { type: 'signature', signatureRow: { justifyContent: 'space-between', columns: [{ title: 'Mengetahui', name: 'John Doe', role: 'Manager' }] } }] 
            });
          }}>
            <Plus className="w-4 h-4 mr-1" /> Add Signature
          </Button>
        </div>
      </div>

      <div className="space-y-4">
        <Each of={rows}>
          {(row, rIdx) => (
            <div key={rIdx} className={`border rounded-xl p-4 ${cardClass}`}>
              <div className="flex justify-between items-center mb-3">
                <span className={`text-xs font-bold uppercase tracking-wider ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Row {rIdx + 1}</span>
                <Button variant="ghost" size="sm" onClick={() => onChange({ ...config, rows: rows.filter((_, i) => i !== rIdx) })} className="text-red-500 hover:text-red-600 h-6 w-6 p-0 rounded-full">
                  <Trash2 className="w-4 h-4" />
                </Button>
              </div>

              <div className="space-y-4">
                {row.type === 'signature' && row.signatureRow ? (
                  <div className={`border rounded-xl p-4 ${isDark ? 'bg-slate-900 border-slate-700' : 'bg-white border-slate-200'}`}>
                    <div className="flex flex-wrap sm:flex-nowrap items-center gap-2 mb-4">
                      <span className={`text-xs font-bold uppercase ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Signature Block</span>
                      <Select 
                        value={row.signatureRow.justifyContent || 'space-between'}
                        onValueChange={(val) => {
                          const newRows = [...rows];
                          newRows[rIdx].signatureRow!.justifyContent = val as any;
                          onChange({ ...config, rows: newRows });
                        }}
                      >
                        <SelectTrigger className="h-8 rounded-lg text-xs w-full sm:w-40 ml-2">
                          <SelectValue placeholder="Alignment" />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="flex-start">Left</SelectItem>
                          <SelectItem value="center">Center</SelectItem>
                          <SelectItem value="flex-end">Right</SelectItem>
                          <SelectItem value="space-between">Space Between</SelectItem>
                          <SelectItem value="space-around">Space Around</SelectItem>
                        </SelectContent>
                      </Select>
                      <label className={`flex items-center gap-1.5 text-xs ${isDark ? 'text-slate-300' : 'text-slate-600'}`}>
                        <Checkbox 
                          checked={row.signatureRow.showBorder || false}
                          onChange={(e) => {
                            const newRows = [...rows];
                            newRows[rIdx].signatureRow!.showBorder = !!e.target.checked;
                            onChange({ ...config, rows: newRows });
                          }}
                        />
                        Border
                      </label>
                      <label className={`flex items-center gap-1.5 text-xs ${isDark ? 'text-slate-300' : 'text-slate-600'}`}>
                        <Checkbox 
                          checked={row.signatureRow.gapless || false}
                          onChange={(e) => {
                            const newRows = [...rows];
                            newRows[rIdx].signatureRow!.gapless = !!e.target.checked;
                            onChange({ ...config, rows: newRows });
                          }}
                        />
                        Berdempetan
                      </label>
                    </div>
                    <div className="grid grid-cols-1 xl:grid-cols-2 gap-4">
                      <Each of={row.signatureRow.columns}>
                        {(col, cIdx) => (
                          <div key={cIdx} className={`border rounded-xl p-4 relative ${isDark ? 'bg-slate-950 border-slate-700' : 'bg-slate-50 border-slate-200 shadow-sm'}`}>
                            <Button 
                              variant="ghost" size="sm" 
                              onClick={() => {
                                const newRows = [...rows];
                                newRows[rIdx].signatureRow!.columns.splice(cIdx, 1);
                                onChange({ ...config, rows: newRows });
                              }}
                              className="absolute top-2 right-2 text-red-500 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-950/50 h-7 w-7 p-0 rounded-full"
                            >
                              <Trash2 className="w-3.5 h-3.5" />
                            </Button>
                            <h4 className={`text-xs font-bold uppercase mb-3 ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Kolom {cIdx + 1}</h4>
                            <div className="space-y-4">
                              <div className="space-y-1">
                                <label className={`text-[11px] font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Baris 1 (Judul)</label>
                                <Input 
                                  placeholder="e.g. Mengetahui" className={`h-8 rounded-xl text-xs ${isDark ? 'bg-slate-900 border-slate-700' : 'bg-white'}`}
                                  value={col.title || ''}
                                  onChange={e => {
                                    const newRows = [...rows];
                                    newRows[rIdx].signatureRow!.columns[cIdx].title = e.target.value;
                                    onChange({ ...config, rows: newRows });
                                  }}
                                />
                              </div>
                              <div className="space-y-1">
                                <label className={`text-[11px] font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Baris 2 (Nama TTD)</label>
                                <Input 
                                  placeholder="Nama Lengkap" className={`h-8 rounded-xl font-bold text-xs ${isDark ? 'bg-slate-900 border-slate-700' : 'bg-white'}`}
                                  value={col.name || ''}
                                  onChange={e => {
                                    const newRows = [...rows];
                                    newRows[rIdx].signatureRow!.columns[cIdx].name = e.target.value;
                                    onChange({ ...config, rows: newRows });
                                  }}
                                />
                              </div>
                              <div className="space-y-1">
                                <label className={`text-[11px] font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Baris 3 (NIP/Jabatan)</label>
                                <Input 
                                  placeholder="NIP. 123456" className={`h-8 rounded-xl text-xs ${isDark ? 'bg-slate-900 border-slate-700' : 'bg-white'}`}
                                  value={col.role || ''}
                                  onChange={e => {
                                    const newRows = [...rows];
                                    newRows[rIdx].signatureRow!.columns[cIdx].role = e.target.value;
                                    onChange({ ...config, rows: newRows });
                                  }}
                                />
                              </div>
                            </div>
                          </div>
                        )}
                      </Each>
                    </div>
                    <Button 
                      variant="ghost" size="sm"
                      disabled={row.signatureRow.columns.length >= 5}
                      onClick={() => {
                        const newRows = [...rows];
                        newRows[rIdx].signatureRow!.columns.push({ title: 'Baris 1', name: 'Baris 2', role: 'Baris 3' });
                        onChange({ ...config, rows: newRows });
                      }}
                      className="mt-3 text-xs"
                    >
                      <Plus className="w-3 h-3 mr-1" /> Add Signature Column
                    </Button>
                  </div>
                ) : (
                  <Each of={row.columns || []}>
                    {(col, cIdx) => (
                    <div key={cIdx} className={`border rounded-xl p-5 relative ${isDark ? 'bg-slate-900 border-slate-700' : 'bg-white border-slate-200 shadow-sm'}`}>
                      <Button variant="ghost" size="sm" onClick={() => {
                        const newRows = [...rows];
                        newRows[rIdx].columns!.splice(cIdx, 1);
                        onChange({ ...config, rows: newRows });
                      }} className="absolute top-3 right-3 text-red-500 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-950/50 h-8 w-8 p-0 rounded-full">
                        <Trash2 className="w-4 h-4" />
                      </Button>
                      <h4 className={`text-xs font-bold uppercase mb-4 tracking-wider ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Tabel {cIdx + 1}</h4>
                      
                      <div className={`grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-5`}>

                        <div className="space-y-1.5">
                          <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Lebar (Width)</label>
                          <Input 
                            placeholder="Contoh: 100%, 500px" 
                            className={`h-10 text-sm ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={col.width || ''}
                            onChange={e => {
                              const newRows = [...rows];
                              newRows[rIdx].columns![cIdx].width = e.target.value;
                              onChange({ ...config, rows: newRows });
                            }}
                          />
                        </div>

                        <div className="space-y-1.5">
                          <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Grid Colspan</label>
                          <Input 
                            type="number"
                            placeholder="Contoh: 1, 2, 12" 
                            className={`h-10 text-sm ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={col.colSpan || ''}
                            onChange={e => {
                              const newRows = [...rows];
                              newRows[rIdx].columns![cIdx].colSpan = parseInt(e.target.value) || undefined;
                              onChange({ ...config, rows: newRows });
                            }}
                          />
                        </div>

                        <div className="space-y-1.5">
                          <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Jarak Atas (Margin Top)</label>
                          <Input 
                            placeholder="Contoh: 1rem, 20px" 
                            className={`h-10 text-sm ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={col.marginTop || ''}
                            onChange={e => {
                              const newRows = [...rows];
                              newRows[rIdx].columns![cIdx].marginTop = e.target.value;
                              onChange({ ...config, rows: newRows });
                            }}
                          />
                        </div>

                        <div className="space-y-1.5">
                          <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Pilih Data Source (Tabel)</label>
                          <Select 
                            value={col.table.dataset || undefined}
                            onValueChange={(val) => {
                              const newRows = [...rows];
                              newRows[rIdx].columns![cIdx].table.dataset = val;
                              onChange({ ...config, rows: newRows });
                            }}
                          >
                            <SelectTrigger className={`h-10 w-full rounded-xl text-sm ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}>
                              <SelectValue placeholder="Pilih Dataset untuk Tabel ini" />
                            </SelectTrigger>
                            <SelectContent>
                                  <Show when={availableDataSources.length === 0}>
                                    <SelectItem value="none" disabled>Belum ada Data Source</SelectItem>
                                  </Show>
                                  <Each of={availableDataSources}>
                                    {(ds: any) => <SelectItem key={ds.id} value={ds.id}>{ds.name}</SelectItem>}
                                  </Each>
                            </SelectContent>
                          </Select>
                        </div>
                        
                        
                        <div className="space-y-1.5 md:col-span-2 lg:col-span-1">
                            <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Posisi Horizontal</label>
                            <Select 
                              value={col.align || 'left'}
                              onValueChange={(val) => {
                                const newRows = [...rows];
                                newRows[rIdx].columns![cIdx].align = val as any;
                                onChange({ ...config, rows: newRows });
                              }}
                            >
                              <SelectTrigger className={`h-10 w-full rounded-xl text-sm ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}>
                                <SelectValue placeholder="Posisi" />
                              </SelectTrigger>
                              <SelectContent>
                                <SelectItem value="left">Kiri (Left)</SelectItem>
                                <SelectItem value="center">Tengah (Center)</SelectItem>
                                <SelectItem value="right">Kanan (Right)</SelectItem>
                              </SelectContent>
                            </Select>
                          </div>
                      </div>

                      <div className={`flex flex-col sm:flex-row justify-between items-start sm:items-center p-4 rounded-xl border ${isDark ? 'bg-slate-950/50 border-slate-800/60' : 'bg-slate-50 border-slate-100'} gap-4 sm:gap-0`}>
                        <div>
                          <h5 className={`text-sm font-semibold ${isDark ? 'text-slate-200' : 'text-slate-800'}`}>Konfigurasi Kolom & Struktur</h5>
                          <p className={`text-xs mt-0.5 ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Atur urutan kolom, grouping, styling, dan kalkulasi sub-total.</p>
                        </div>
                        <Button 
                          variant="default" className="h-9 px-4 shrink-0 shadow-sm rounded-xl text-xs font-medium"
                          onClick={() => onOpenHeaderModal(rIdx, cIdx, col.table)}
                        >
                          <Edit2 className="w-3.5 h-3.5 mr-2" /> Edit Tabel
                        </Button>
                      </div>
                    </div>
                  )}
                </Each>
                )}
              </div>

              {(!row.type || row.type === 'table') && (
                <Button 
                  variant="ghost" size="sm"
                  onClick={() => {
                    const newRows = [...rows];
                    newRows[rIdx].columns!.push({ width: '50%', table: { dataset: '', headerRows: [], dataColumns: [] } });
                    onChange({ ...config, rows: newRows });
                  }}
                  className="mt-2 text-xs"
                >
                  <Plus className="w-3 h-3 mr-1" /> Add Table to Row
                </Button>
              )}
            </div>
          )}
        </Each>
      </div>
    </div>
  );
}
