import { Plus, Trash2 } from 'lucide-react';
import { Button, Input, Select, SelectTrigger, SelectValue, SelectContent, SelectItem, Each, RichTextEditor } from '@/shared/ui';
import type { ILayoutHeader, IReportConfig } from '@/domains/reports/types';
import { DataSourceManager } from './DataSourceManager';
import { HelpGuide } from '../HelpGuide';

export function HeaderEditor({ config, onChange, reportConfig, setReportConfig, isDark }: { config: ILayoutHeader, onChange: any, reportConfig: Partial<IReportConfig>, setReportConfig: any, isDark: boolean }) {
  const rows = config.rows || [];
  const cardClass = isDark ? 'bg-slate-800/50 border-slate-700' : 'bg-slate-50 border-slate-200';
  const headingClass = isDark ? 'text-slate-200' : 'text-slate-800';

  const addRow = () => onChange({ ...config, type: 'header', rows: [...rows, { columns: [{ text: '', align: 'center', colSpan: 1, sourceType: 'static' }] }] });

  return (
    <div className="space-y-8">
      <div className="flex justify-between items-center mb-2">
        <h2 className={`text-lg font-bold ${isDark ? 'text-slate-200' : 'text-slate-800'}`}>Pengaturan Header Layout</h2>
        <HelpGuide title="Panduan Tab Header">
          <p>Tab <strong>Header</strong> digunakan untuk mendesain bagian atas (kop) dari laporan Anda.</p>
          <ul className="list-disc pl-5 space-y-1">
            <li><strong>Header Data Sources:</strong> Tambahkan query dataset jika Anda butuh menampilkan teks dinamis di kop laporan (misalnya: mencetak parameter Nama Cabang, Tanggal Cetak, dsb).</li>
            <li><strong>Layout Rows:</strong> Klik "Add Header Row" untuk menambah baris pada kop. Anda bisa membagi baris menjadi beberapa kolom, mengatur perataan (Align), lebar (Width), dan mengatur teks secara statis atau dinamis dari Dataset.</li>
            <li>Gunakan format <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-xs">{`{NamaDataset.Field}`}</code> pada teks statis jika ingin menyisipkan variabel dinamis.</li>
          </ul>
        </HelpGuide>
      </div>
      {/* 1. Header Data Sources */}
      <DataSourceManager
        config={reportConfig}
        onChange={setReportConfig}
        isDark={isDark}
        scope="header"
        title="Header Data Sources (Local)"
        description="Data Source khusus untuk dipakai di area Header Laporan ini."
      />

      <div className={`h-px w-full ${isDark ? 'bg-slate-800' : 'bg-slate-200'}`}></div>

      {/* 2. Header Layout */}
      <div className={`sticky top-0 z-20 flex justify-between items-center py-2 px-1 -mx-1 mb-2 ${isDark ? 'bg-[#0f172a]' : 'bg-slate-50'}`}>
        <div>
          <h3 className={`font-medium ${headingClass}`}>Header Rows</h3>
          <p className={`text-xs ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Tentukan baris dan kolom (grid) di bagian Header.</p>
        </div>
        <Button variant="default" size="sm" onClick={addRow}>
          <Plus className="w-4 h-4 mr-1" /> Add Row
        </Button>
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
              
              <div className="space-y-3">
                <Each of={row.columns}>
                  {(col, cIdx) => (
                    <div key={cIdx} className={`border rounded-xl p-4 relative ${isDark ? 'bg-slate-900 border-slate-700' : 'bg-white border-slate-200 shadow-sm'}`}>
                      <Button variant="ghost" size="sm" onClick={() => {
                        const newRows = [...rows];
                        newRows[rIdx].columns.splice(cIdx, 1);
                        onChange({ ...config, rows: newRows });
                      }} className="absolute top-2 right-2 text-red-500 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-950/50 h-7 w-7 p-0 rounded-full">
                        <Trash2 className="w-3.5 h-3.5" />
                      </Button>
                      <h4 className={`text-xs font-bold uppercase mb-3 ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Kolom {cIdx + 1}</h4>
                      
                      <div className="space-y-4">
                        {/* Konten Berdasarkan Source Type */}
                        <div>
                            <div className="space-y-1">
                              <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Isi Konten (Rich Text)</label>
                              <div className="bg-white dark:bg-slate-900 rounded-xl overflow-hidden shadow-sm border border-slate-200 dark:border-slate-700">
                                <RichTextEditor 
                                  value={col.text || ''}
                                  onChange={(html: string) => {
                                    const newRows = [...rows];
                                    newRows[rIdx].columns[cIdx].text = html;
                                    onChange({ ...config, rows: newRows });
                                  }}
                                  placeholder="Masukkan teks statis atau variabel..."
                                  className="border-0 shadow-none min-h-[150px]"
                                />
                              </div>
                              <span className={`text-[10px] block leading-tight ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Anda bisa menggunakan variabel dinamis seperti {`{current_date}`} atau {`{DatasetName.Field}`}.</span>
                            </div>
                        </div>

                        <div className="grid grid-cols-1 md:grid-cols-12 gap-4">
                          {/* Alignment */}
                          <div className="md:col-span-6 space-y-1">
                            <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Perataan Teks</label>
                            <Select 
                              value={col.align || 'center'}
                              onValueChange={(val) => {
                                const newRows = [...rows];
                                newRows[rIdx].columns[cIdx].align = val as any;
                                onChange({ ...config, rows: newRows });
                              }}
                            >
                              <SelectTrigger className={`h-9 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}>
                                <SelectValue placeholder="Align" />
                              </SelectTrigger>
                              <SelectContent>
                                <SelectItem value="left">Rata Kiri</SelectItem>
                                <SelectItem value="center">Rata Tengah</SelectItem>
                                <SelectItem value="right">Rata Kanan</SelectItem>
                              </SelectContent>
                            </Select>
                            <span className={`text-[10px] block leading-tight ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Posisi teks.</span>
                          </div>

                          {/* Colspan */}
                          <div className="md:col-span-6 space-y-1">
                            <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>ColSpan (1-12)</label>
                            <Input 
                              type="number" min="1" max="12"
                              className={`h-9 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                              value={col.colSpan || 1}
                              onChange={e => {
                                let val = parseInt(e.target.value) || 1;
                                if(val < 1) val = 1;
                                if(val > 12) val = 12;
                                const newRows = [...rows];
                                newRows[rIdx].columns[cIdx].colSpan = val;
                                onChange({ ...config, rows: newRows });
                              }}
                            />
                            <span className={`text-[10px] block leading-tight ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Maks 12 grid.</span>
                          </div>
                        </div>
                      </div>
                    </div>
                  )}
                </Each>
                <Button 
                  variant="ghost" size="sm"
                  onClick={() => {
                    const newRows = [...rows];
                    newRows[rIdx].columns.push({ text: '', align: 'center', colSpan: 1, sourceType: 'static' });
                    onChange({ ...config, rows: newRows });
                  }}
                  className="mt-2 text-xs"
                >
                  <Plus className="w-3 h-3 mr-1" /> Add Column to Row
                </Button>
              </div>
            </div>
          )}
        </Each>
      </div>
    </div>
  );
}
