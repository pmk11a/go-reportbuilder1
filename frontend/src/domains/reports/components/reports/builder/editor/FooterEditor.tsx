import { Plus, Trash2 } from 'lucide-react';
import { Button, Input, Select, SelectTrigger, SelectValue, SelectContent, SelectItem, Each, Checkbox } from '@/shared/ui';
import type { ILayoutFooter, IReportConfig } from '@/domains/reports/types';
import { DataSourceManager } from './DataSourceManager';
import { HelpGuide } from '../HelpGuide';

export function FooterEditor({ config, onChange, reportConfig, setReportConfig, isDark }: { config: ILayoutFooter, onChange: any, reportConfig: Partial<IReportConfig>, setReportConfig: any, isDark: boolean }) {
  const rows = config.rows || [];
  const headingClass = isDark ? 'text-slate-200' : 'text-slate-800';

  const addRow = () => onChange({ ...config, type: 'footer', rows: [...rows, { justifyContent: 'space-between', columns: [{ title: 'Mengetahui', title2: '', name: 'John Doe', role: 'Manager', role2: '' }] }] });

  return (
    <div className="space-y-8">
      <div className="flex justify-between items-center mb-2">
        <h2 className={`text-lg font-bold ${isDark ? 'text-slate-200' : 'text-slate-800'}`}>Pengaturan Footer Layout</h2>
        <HelpGuide title="Panduan Tab Footer">
          <p>Tab <strong>Footer</strong> digunakan untuk mendesain bagian bawah (kaki) dari laporan Anda, biasanya berupa kolom-kolom tanda tangan.</p>
          <ul className="list-disc pl-5 space-y-1">
            <li><strong>Footer Data Sources:</strong> Opsional, jika Anda butuh mengambil nama/jabatan penandatangan secara dinamis dari database.</li>
            <li><strong>Footer Signatures:</strong> Klik "Add Footer Row" untuk menambah baris penandatangan. Tambahkan kolom (blok) tanda tangan di baris tersebut.</li>
            <li>Di setiap blok tanda tangan, Anda bisa mengisi Title (misal: "Mengetahui"), Nama (misal: "Direktur Utama", atau panggil dari Dataset menggunakan <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-xs">{`{NamaDataset.Field}`}</code>), dll.</li>
          </ul>
        </HelpGuide>
      </div>
      <DataSourceManager
        config={reportConfig}
        onChange={setReportConfig}
        isDark={isDark}
        scope="footer"
        title="Footer Data Sources (Local)"
        description="Query untuk mengambil data dinamis khusus bagian footer."
      />

      <div className={`h-px w-full ${isDark ? 'bg-slate-800' : 'bg-slate-200'}`}></div>

      {/* 2. Footer Signatures */}
      <div>
        <div className={`sticky top-0 z-20 flex justify-between items-center py-2 px-1 -mx-1 mb-2 ${isDark ? 'bg-[#0f172a]' : 'bg-slate-50'}`}>
          <div>
            <h3 className={`font-medium ${headingClass}`}>Footer Signatures</h3>
            <p className={`text-xs ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Tentukan tanda tangan di bagian Footer Laporan.</p>
          </div>
          <Button variant="default" size="sm" onClick={addRow} disabled={rows.length >= 5}>
            <Plus className="w-4 h-4 mr-1" /> Add Row
          </Button>
        </div>
        <p className={`text-[11px] mb-4 ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>
          Tips: Gunakan format <code>{`{Alias.Field}`}</code> pada kolom isian di bawah (misal: <code>{`{F1.nama_manager}`}</code>) untuk mengambil teks dinamis dari Data Source. Maksimal 5 baris dan 5 tanda tangan per baris.
        </p>

      <div className="space-y-4">
        <Each of={rows}>
          {(row, rIdx) => (
            <div key={rIdx} className={`border rounded-xl p-4 ${isDark ? 'bg-slate-800/50 border-slate-700' : 'bg-slate-50 border-slate-200'}`}>
              <div className="flex flex-wrap sm:flex-nowrap justify-between items-center mb-3 gap-2">
                <div className="flex flex-1 items-center gap-2 sm:gap-4 min-w-[200px]">
                  <span className={`text-xs font-bold uppercase tracking-wider shrink-0 ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Row {rIdx + 1}</span>
                  <Select 
                    value={row.justifyContent || 'space-between'}
                    onValueChange={(val) => {
                      const newRows = [...rows];
                      newRows[rIdx].justifyContent = val as any;
                      onChange({ ...config, rows: newRows });
                    }}
                  >
                    <SelectTrigger className="h-8 rounded-lg text-xs w-full sm:w-40">
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
                      checked={row.showBorder || false}
                      onChange={(e) => {
                        const newRows = [...rows];
                        newRows[rIdx].showBorder = !!e.target.checked;
                        onChange({ ...config, rows: newRows });
                      }}
                    />
                    Border
                  </label>
                  <label className={`flex items-center gap-1.5 text-xs ${isDark ? 'text-slate-300' : 'text-slate-600'}`}>
                    <Checkbox 
                      checked={row.gapless || false}
                      onChange={(e) => {
                        const newRows = [...rows];
                        newRows[rIdx].gapless = !!e.target.checked;
                        onChange({ ...config, rows: newRows });
                      }}
                    />
                    Berdempetan
                  </label>
                </div>
                <Button variant="ghost" size="sm" onClick={() => onChange({ ...config, rows: rows.filter((_, i) => i !== rIdx) })} className="text-red-500 hover:text-red-600 h-8 w-8 p-0 rounded-full shrink-0">
                  <Trash2 className="w-4 h-4" />
                </Button>
              </div>

              <div className="grid grid-cols-1 xl:grid-cols-2 gap-4">
                <Each of={row.columns}>
                  {(col, cIdx) => (
                    <div key={cIdx} className={`border rounded-xl p-4 relative ${isDark ? 'bg-slate-900 border-slate-700' : 'bg-white border-slate-200 shadow-sm'}`}>
                        <Button 
                          variant="ghost" size="sm" 
                          onClick={() => {
                            const newRows = [...rows];
                            newRows[rIdx].columns.splice(cIdx, 1);
                            onChange({ ...config, rows: newRows });
                          }}
                          className="absolute top-2 right-2 text-red-500 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-950/50 h-7 w-7 p-0 rounded-full"
                        >
                          <Trash2 className="w-3.5 h-3.5" />
                        </Button>
                        <h4 className={`text-xs font-bold uppercase mb-3 ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Kolom {cIdx + 1}</h4>
                       
                        <div className="space-y-4">
                          <div className="space-y-1">
                            <label className={`text-[11px] font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Baris 1 (Judul Atas)</label>
                          <Input 
                            placeholder="e.g. Mengetahui" className={`h-8 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={col.title || ''}
                            onChange={e => {
                              const newRows = [...rows];
                              newRows[rIdx].columns[cIdx].title = e.target.value;
                              onChange({ ...config, rows: newRows });
                            }}
                          />
                        </div>
                          <div className="space-y-1">
                            <label className={`text-[11px] font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Baris 2 (Jabatan)</label>
                          <Input 
                            placeholder="e.g. Direktur" className={`h-8 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={col.title2 || ''}
                            onChange={e => {
                              const newRows = [...rows];
                              newRows[rIdx].columns[cIdx].title2 = e.target.value;
                              onChange({ ...config, rows: newRows });
                            }}
                          />
                        </div>
                        <div className="space-y-1">
                          <label className={`text-[11px] font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Baris 3 (Nama TTD)</label>
                          <Input 
                            placeholder="Nama Lengkap" className={`h-8 rounded-xl font-bold text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={col.name || ''}
                            onChange={e => {
                              const newRows = [...rows];
                              newRows[rIdx].columns[cIdx].name = e.target.value;
                              onChange({ ...config, rows: newRows });
                            }}
                          />
                        </div>
                        <div className="space-y-1">
                          <label className={`text-[11px] font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Baris 4 (NIP / NIK)</label>
                          <Input 
                            placeholder="NIP. 123456" className={`h-8 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={col.role || ''}
                            onChange={e => {
                              const newRows = [...rows];
                              newRows[rIdx].columns[cIdx].role = e.target.value;
                              onChange({ ...config, rows: newRows });
                            }}
                          />
                        </div>
                        <div className="space-y-1">
                          <label className={`text-[11px] font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Baris 5 (Ekstra)</label>
                          <Input 
                            placeholder="Opsional" className={`h-8 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={col.role2 || ''}
                            onChange={e => {
                              const newRows = [...rows];
                              newRows[rIdx].columns[cIdx].role2 = e.target.value;
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
                disabled={row.columns.length >= 5}
                onClick={() => {
                  if (row.columns.length >= 5) return;
                  const newRows = [...rows];
                  newRows[rIdx].columns.push({ title: 'Baris 1', title2: '', name: 'Baris 3', role: '', role2: '' });
                  onChange({ ...config, rows: newRows });
                }}
                className="mt-3 text-xs"
              >
                <Plus className="w-3 h-3 mr-1" /> Add Signature
              </Button>
            </div>
          )}
        </Each>
      </div>
      </div>
    </div>
  );
}
