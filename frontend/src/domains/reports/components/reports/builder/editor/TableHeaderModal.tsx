import { useState, useEffect } from 'react';
import { Plus, Trash2, X, Settings2, ChevronUp, ChevronDown, Loader2 } from 'lucide-react';
import { Button, DebouncedInput, Select, SelectTrigger, SelectValue, SelectContent, SelectItem, Each } from '@/shared/ui';
import { Checkbox } from '@/shared/ui/form/checkbox';
import type { ILayoutTable } from '@/domains/reports/types';
import { usePreviewDataset } from '@/domains/reports/hooks/useReport';
import { HelpGuide } from '../HelpGuide';

export function TableHeaderModal({ 
  table, 
  isDark, 
  onClose, 
  onSave,
  reportId,
  datasetQuery
}: { 
  table: ILayoutTable, 
  isDark: boolean, 
  onClose: () => void, 
  onSave: (t: ILayoutTable) => void,
  reportId?: number,
  datasetQuery?: string
}) {
  const [localTable, setLocalTable] = useState<ILayoutTable>(JSON.parse(JSON.stringify(table)));
  const [previewColumns, setPreviewColumns] = useState<string[]>([]);
  
  const { mutateAsync: previewDataset, isPending: isPreviewing } = usePreviewDataset(reportId || null);

  useEffect(() => {
    if (reportId && datasetQuery) {
      previewDataset({ sql: datasetQuery })
        .then(res => {
          if (res?.columns) {
            setPreviewColumns(res.columns);
          }
        })
        .catch(err => console.error("Failed to fetch dataset columns", err));
    }
  }, [reportId, datasetQuery]);

  // Ensure grouping is initialized
  if (!localTable.grouping) {
    localTable.grouping = { groupBy: '', showSubtotal: false, subtotalLabel: '', subtotalColumns: [] };
  }

  const addHeaderRow = () => {
    setLocalTable({ ...localTable, headerRows: [...(localTable.headerRows || []), []] });
  };

  const addHeaderCol = (rIdx: number) => {
    const newRows = [...(localTable.headerRows || [])];
    newRows[rIdx].push({ text: '', align: 'center', colSpan: 1, rowSpan: 1 });
    setLocalTable({ ...localTable, headerRows: newRows });
  };

  const addDataCol = () => {
    setLocalTable({ ...localTable, dataColumns: [...(localTable.dataColumns || []), { field: '', align: 'left' }] });
  };

  const moveHeaderRow = (rIdx: number, dir: -1 | 1) => {
    const newRows = [...(localTable.headerRows || [])];
    const target = rIdx + dir;
    if (target < 0 || target >= newRows.length) return;
    [newRows[rIdx], newRows[target]] = [newRows[target], newRows[rIdx]];
    setLocalTable({ ...localTable, headerRows: newRows });
  };

  const moveDataCol = (cIdx: number, dir: -1 | 1) => {
    const newCols = [...(localTable.dataColumns || [])];
    const target = cIdx + dir;
    if (target < 0 || target >= newCols.length) return;
    [newCols[cIdx], newCols[target]] = [newCols[target], newCols[cIdx]];
    setLocalTable({ ...localTable, dataColumns: newCols });
  };

  const moveHeaderCol = (rIdx: number, cIdx: number, dir: -1 | 1) => {
    const newRows = [...(localTable.headerRows || [])];
    const target = cIdx + dir;
    if (target < 0 || target >= newRows[rIdx].length) return;
    [newRows[rIdx][cIdx], newRows[rIdx][target]] = [newRows[rIdx][target], newRows[rIdx][cIdx]];
    setLocalTable({ ...localTable, headerRows: newRows });
  };

  return (
    <div className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
      <div className={`w-full max-w-4xl max-h-[90vh] flex flex-col rounded-xl shadow-2xl ${isDark ? 'bg-slate-900 border border-slate-700' : 'bg-white'}`}>
        <div className={`p-4 border-b flex justify-between items-center ${isDark ? 'border-slate-800' : 'border-slate-100'}`}>
          <div className="flex items-center">
            <h3 className="font-semibold">Table Configuration</h3>
            <HelpGuide title="Panduan Konfigurasi Tabel Inti">
              <div className="space-y-4 text-sm leading-relaxed max-h-[70vh] overflow-y-auto pr-2">
                <p>
                  Modal ini adalah **jantung dari Report Builder**. Di sini Anda merancang struktur Thead (Kepala Tabel), Tbody (Isi Tabel), serta kalkulasi matematis antar dataset (Multi-Dataset Calculation).
                </p>
                
                <div>
                  <h4 className="font-bold text-slate-800 dark:text-slate-200 mb-1">1. Pengaturan Tabel (Global)</h4>
                  <ul className="list-disc pl-5 space-y-1 text-slate-600 dark:text-slate-400">
                    <li><strong>Pilih Data Source:</strong> Pilih Dataset Utama yang akan me-looping (mencetak) baris data.</li>
                    <li><strong>Table Layout:</strong> Pilih Auto (lebar menyesuaikan konten) atau Fixed (lebar kolom diatur presisi dengan %).</li>
                    <li><strong>Grouping & Subtotal:</strong> Anda dapat mengelompokkan data berdasarkan field tertentu (misal: <em>Perkiraan</em>) dan otomatis mencetak Subtotal per grup.</li>
                  </ul>
                </div>

                <div>
                  <h4 className="font-bold text-slate-800 dark:text-slate-200 mb-1">2. Table Headers (Thead)</h4>
                  <ul className="list-disc pl-5 space-y-1 text-slate-600 dark:text-slate-400">
                    <li>Desain Kepala Tabel sebebas mungkin. Tambahkan Baris, lalu susun kolom-kolomnya (gunakan <strong>ColSpan</strong> untuk menggabung sel menyamping, atau <strong>RowSpan</strong> ke bawah).</li>
                    <li><strong>Teks Statis:</strong> Ketik judul kolom biasa (misal: "No. Bukti").</li>
                    <li><strong>Teks Dinamis (Cross-Dataset):</strong> Jika Anda ingin mencetak teks dari dataset lain (misal dari dataset <em>summary</em>), gunakan format: <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-[11px]">{`{summary.SaldoAwal:currency}`}</code>. Ingat, gunakan <strong>Nama Dataset</strong>, bukan ID.</li>
                  </ul>
                </div>

                <div>
                  <h4 className="font-bold text-slate-800 dark:text-slate-200 mb-1">3. Table Body (Tbody / Data Columns)</h4>
                  <ul className="list-disc pl-5 space-y-1 text-slate-600 dark:text-slate-400">
                    <li>Di sinilah nilai dari <strong>Dataset Utama</strong> dirender baris demi baris.</li>
                    <li>Pilih tipe kolom: <strong>Field</strong> (data mentah dari query), <strong>Row Number</strong> (nomor urut otomatis), atau <strong>Formula</strong>.</li>
                    <li><strong>Jadikan Header (TH):</strong> Centang opsi ini jika Anda ingin sel tersebut ditebalkan dan memiliki background layaknya Header Samping (Left Header).</li>
                  </ul>
                </div>

                <div>
                  <h4 className="font-bold text-slate-800 dark:text-slate-200 mb-1">4. Formula & Kalkulasi Lanjutan</h4>
                  <p className="text-slate-600 dark:text-slate-400 mb-2">Anda bisa melakukan operasi matematika di dalam sel (Tbody maupun Thead):</p>
                  <ul className="list-disc pl-5 space-y-1 text-slate-600 dark:text-slate-400">
                    <li>Gunakan operator matematika biasa: <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-[11px]">+ - * / ( )</code></li>
                    <li><strong>Contoh Pengurangan Kolom (Satu baris berjalan):</strong> <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-[11px]">{`{Debet} - {Kredit}`}</code></li>
                    <li><strong>Contoh Total Kolom (SUM):</strong> <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-[11px]">{`{SUM(Debet)}`}</code></li>
                    <li><strong>Contoh Cross-Dataset Math:</strong> <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-[11px]">{`{summary.SaldoAwal} + {SUM(Debet)}`}</code> (Menjumlahkan Saldo Awal dari dataset 'summary' dengan Total Debet dari dataset tabel saat ini).</li>
                  </ul>
                </div>
              </div>
            </HelpGuide>
          </div>
          <Button variant="ghost" size="icon" onClick={onClose}><X className="w-5 h-5"/></Button>
        </div>

        <div className="p-4 overflow-y-auto flex-1 space-y-8">
          
          <div className={`p-4 border rounded-xl shadow-sm ${isDark ? 'bg-slate-800/30 border-slate-700' : 'bg-white border-slate-200'}`}>
            <h4 className="font-semibold text-sm mb-3">Pengaturan Tabel (Global)</h4>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="space-y-1">
                <label className="text-[10px] font-bold uppercase text-slate-500">Table Layout</label>
                <Select 
                  value={localTable.tableLayout || 'auto'}
                  onValueChange={(val) => setLocalTable({...localTable, tableLayout: val as 'auto' | 'fixed'})}
                >
                  <SelectTrigger className="h-9 w-full text-sm"><SelectValue placeholder="Layout Tabel" /></SelectTrigger>
                  <SelectContent>
                    <SelectItem value="auto">Auto (Default)</SelectItem>
                    <SelectItem value="fixed">Fixed</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </div>
          
          {/* Header Rows */}
          <div>
            <div className="flex justify-between items-center mb-4">
              <div>
                <h4 className="font-semibold text-sm">Table Headers (Thead)</h4>
                <p className="text-xs text-slate-500">Desain judul kolom tabel, dukung multi-baris (RowSpan/ColSpan).</p>
              </div>
              <Button variant="outline" size="sm" onClick={addHeaderRow}><Plus className="w-4 h-4 mr-1"/> Add Row</Button>
            </div>
            
            <div className="space-y-6">
              <Each of={localTable.headerRows || []}>
                {(hRow, rIdx) => (
                  <div key={rIdx} className={`p-4 border rounded-xl shadow-sm ${isDark ? 'bg-slate-800/30 border-slate-700' : 'bg-white border-slate-200'}`}>
                    <div className="flex justify-between mb-4 border-b pb-2 dark:border-slate-700">
                      <span className="text-xs font-bold uppercase tracking-wider text-slate-500">Baris Header {rIdx + 1}</span>
                      <div className="flex items-center gap-2">
                        <div className="flex items-center border rounded-md px-1 dark:border-slate-700 bg-white dark:bg-slate-800">
                          <Button variant="ghost" size="icon" onClick={() => moveHeaderRow(rIdx, -1)} disabled={rIdx === 0} className="h-7 w-7 text-slate-600 dark:text-slate-300 hover:text-indigo-500 disabled:opacity-30">
                            <ChevronUp className="w-4 h-4"/>
                          </Button>
                          <Button variant="ghost" size="icon" onClick={() => moveHeaderRow(rIdx, 1)} disabled={rIdx === (localTable.headerRows?.length ?? 0) - 1} className="h-7 w-7 text-slate-600 dark:text-slate-300 hover:text-indigo-500 disabled:opacity-30">
                            <ChevronDown className="w-4 h-4"/>
                          </Button>
                        </div>
                        <Button variant="ghost" size="sm" onClick={() => {
                          const newRows = [...localTable.headerRows]; newRows.splice(rIdx, 1); setLocalTable({...localTable, headerRows: newRows});
                        }} className="h-8 text-red-500 bg-red-50 dark:bg-red-500/10 hover:bg-red-100 dark:hover:bg-red-500/20"><Trash2 className="w-4 h-4"/></Button>
                      </div>
                    </div>
                    
                    <div className="space-y-4">
                      <Each of={hRow}>
                        {(hCol, cIdx) => (
                          <div key={cIdx} className={`relative p-3 rounded-lg border ${isDark ? 'bg-slate-900 border-slate-700' : 'bg-slate-50 border-slate-200'}`}>
                            <div className="absolute top-2 right-2 flex items-center gap-1">
                              <div className="flex items-center border rounded-md bg-white dark:bg-slate-800 shadow-sm dark:border-slate-700">
                                <Button variant="ghost" size="icon" onClick={() => moveHeaderCol(rIdx, cIdx, -1)} disabled={cIdx === 0} className="h-6 w-6 text-slate-600 dark:text-slate-300 hover:text-indigo-500 disabled:opacity-30">
                                  <ChevronUp className="w-3 h-3"/>
                                </Button>
                                <Button variant="ghost" size="icon" onClick={() => moveHeaderCol(rIdx, cIdx, 1)} disabled={cIdx === hRow.length - 1} className="h-6 w-6 text-slate-600 dark:text-slate-300 hover:text-indigo-500 disabled:opacity-30">
                                  <ChevronDown className="w-3 h-3"/>
                                </Button>
                              </div>
                              <Button variant="ghost" size="icon" onClick={() => {
                                const newRows = [...localTable.headerRows];
                                newRows[rIdx].splice(cIdx, 1);
                                setLocalTable({...localTable, headerRows: newRows});
                              }} className="text-red-500 h-6 w-6 rounded-md bg-white dark:bg-slate-800 shadow-sm border dark:border-slate-700"><Trash2 className="w-3 h-3"/></Button>
                            </div>
                            
                            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-12 gap-3">
                              <div className="lg:col-span-3 space-y-1">
                                <label className="text-[10px] font-bold uppercase text-slate-500">Label Kolom</label>
                                <DebouncedInput 
                                  placeholder="Contoh: No. Bukti" className="text-sm h-9"
                                  value={hCol.text || ''}
                                  onChange={val => {
                                    const newRows = [...localTable.headerRows];
                                    newRows[rIdx][cIdx].text = String(val);
                                    setLocalTable({...localTable, headerRows: newRows});
                                  }}
                                />
                              </div>
                              <div className="lg:col-span-3 space-y-1">
                                <label className="text-[10px] font-bold uppercase text-slate-500">Perataan (Align)</label>
                                <Select 
                                  value={hCol.align || 'center'}
                                  onValueChange={(val) => {
                                    const newRows = [...localTable.headerRows];
                                    newRows[rIdx][cIdx].align = val as any;
                                    setLocalTable({...localTable, headerRows: newRows});
                                  }}
                                >
                                  <SelectTrigger className="h-9 w-full text-sm"><SelectValue placeholder="Align" /></SelectTrigger>
                                  <SelectContent>
                                    <SelectItem value="left">Kiri (Left)</SelectItem>
                                    <SelectItem value="center">Tengah (Center)</SelectItem>
                                    <SelectItem value="right">Kanan (Right)</SelectItem>
                                  </SelectContent>
                                </Select>
                              </div>
                              <div className="lg:col-span-2 space-y-1">
                                <label className="text-[10px] font-bold uppercase text-slate-500">Lebar (Width)</label>
                                <DebouncedInput 
                                  placeholder="Auto" className="h-9 text-sm"
                                  value={hCol.width || ''}
                                  onChange={val => {
                                    const newRows = [...localTable.headerRows];
                                    newRows[rIdx][cIdx].width = String(val);
                                    setLocalTable({...localTable, headerRows: newRows});
                                  }}
                                />
                              </div>
                              <div className="lg:col-span-2 space-y-1">
                                <label className="text-[10px] font-bold uppercase text-slate-500">ColSpan</label>
                                <DebouncedInput 
                                  type="number" placeholder="1" className="h-9 text-sm"
                                  value={hCol.colSpan || 1}
                                  onChange={val => {
                                    const newRows = [...localTable.headerRows];
                                    newRows[rIdx][cIdx].colSpan = parseInt(String(val)) || 1;
                                    setLocalTable({...localTable, headerRows: newRows});
                                  }}
                                />
                              </div>
                              <div className="lg:col-span-2 space-y-1">
                                <label className="text-[10px] font-bold uppercase text-slate-500">RowSpan</label>
                                <DebouncedInput 
                                  type="number" placeholder="1" className="h-9 text-sm"
                                  value={hCol.rowSpan || 1}
                                  onChange={val => {
                                    const newRows = [...localTable.headerRows];
                                    newRows[rIdx][cIdx].rowSpan = parseInt(String(val)) || 1;
                                    setLocalTable({...localTable, headerRows: newRows});
                                  }}
                                />
                              </div>
                            </div>
                          </div>
                        )}
                      </Each>
                    </div>
                    <Button variant="ghost" size="sm" onClick={() => addHeaderCol(rIdx)} className="mt-3 text-xs font-medium text-indigo-500 hover:text-indigo-600"><Plus className="w-3.5 h-3.5 mr-1"/> Tambah Kolom ke Baris Ini</Button>
                  </div>
                )}
              </Each>
            </div>
          </div>

          <div className="h-px bg-slate-200 dark:bg-slate-700 w-full" />

          {/* Data Columns */}
          <div>
            <div className={`sticky top-0 z-20 flex justify-between items-center py-2 px-1 -mx-1 mb-4 ${isDark ? 'bg-slate-900/95 backdrop-blur' : 'bg-white/95 backdrop-blur'}`}>
              <div>
                <h4 className="font-semibold text-sm">Data Columns (Tbody)</h4>
                <p className="text-xs text-slate-500">Pemetaan field dari Data Source (Database) ke tabel ini.</p>
              </div>
              <Button variant="default" size="sm" onClick={addDataCol}><Plus className="w-4 h-4 mr-1"/> Add Field</Button>
            </div>
            
            <div className="space-y-3">
              <Each of={localTable.dataColumns || []}>
                {(dCol, cIdx) => (
                  <div key={cIdx} className={`relative p-4 rounded-xl border shadow-sm ${isDark ? 'bg-slate-800/30 border-slate-700' : 'bg-white border-slate-200'}`}>
                    {/* Reorder + Delete buttons */}
                    <div className="absolute top-2 right-2 flex items-center gap-2">
                      <div className="flex items-center border rounded-md px-1 dark:border-slate-700 bg-white dark:bg-slate-800">
                        <Button variant="ghost" size="icon" onClick={() => moveDataCol(cIdx, -1)} disabled={cIdx === 0} className="h-7 w-7 text-slate-600 dark:text-slate-300 hover:text-indigo-500 disabled:opacity-30">
                          <ChevronUp className="w-4 h-4"/>
                        </Button>
                        <Button variant="ghost" size="icon" onClick={() => moveDataCol(cIdx, 1)} disabled={cIdx === (localTable.dataColumns?.length ?? 0) - 1} className="h-7 w-7 text-slate-600 dark:text-slate-300 hover:text-indigo-500 disabled:opacity-30">
                          <ChevronDown className="w-4 h-4"/>
                        </Button>
                      </div>
                      <Button variant="ghost" size="icon" onClick={() => {
                        const newCols = [...localTable.dataColumns];
                        newCols.splice(cIdx, 1);
                        setLocalTable({...localTable, dataColumns: newCols});
                      }} className="h-8 w-8 text-red-500 bg-red-50 dark:bg-red-500/10 hover:bg-red-100 dark:hover:bg-red-500/20 rounded-md"><Trash2 className="w-4 h-4"/></Button>
                    </div>
                    
                    <div className="space-y-4 pr-24">
                      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-12 gap-3">
                        <div className="xl:col-span-2 space-y-1">
                          <label className="text-[10px] font-bold uppercase text-slate-500">Tipe Kolom</label>
                          <Select 
                            value={dCol.type || 'field'}
                            onValueChange={(val) => {
                              const newCols = [...localTable.dataColumns];
                              newCols[cIdx].type = val as any;
                              setLocalTable({...localTable, dataColumns: newCols});
                            }}
                          >
                            <SelectTrigger className="h-9 w-full text-sm"><SelectValue placeholder="Tipe" /></SelectTrigger>
                            <SelectContent>
                              <SelectItem value="field">Field DB</SelectItem>
                              <SelectItem value="formula">Formula / Math</SelectItem>
                              <SelectItem value="row_number">No. Baris</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>
                        {(dCol.type || 'field') !== 'formula' && (
                          <div className="xl:col-span-3 space-y-1">
                            <label className="text-[10px] font-bold uppercase text-slate-500">
                              ID / Field
                              {isPreviewing && <Loader2 className="w-3 h-3 inline-block ml-2 animate-spin text-indigo-500" />}
                            </label>
                            <DebouncedInput 
                              list={((dCol.type || 'field') === 'field') ? `columns-list-${cIdx}` : undefined}
                              placeholder="Contoh: no_rekening" className="font-mono text-sm h-9"
                              value={dCol.field || ''}
                              onChange={val => {
                                const newCols = [...localTable.dataColumns];
                                newCols[cIdx].field = String(val);
                                setLocalTable({...localTable, dataColumns: newCols});
                              }}
                            />
                            {((dCol.type || 'field') === 'field') && previewColumns.length > 0 && (
                              <datalist id={`columns-list-${cIdx}`}>
                                {previewColumns.map(col => (
                                  <option key={col} value={col} />
                                ))}
                              </datalist>
                            )}
                          </div>
                        )}
                        <div className="xl:col-span-3 space-y-1">
                          <label className="text-[10px] font-bold uppercase text-slate-500">Format</label>
                          <Select 
                            value={dCol.format || 'text'}
                            onValueChange={(val) => {
                              const newCols = [...localTable.dataColumns];
                              newCols[cIdx].format = val;
                              setLocalTable({...localTable, dataColumns: newCols});
                            }}
                          >
                            <SelectTrigger className="h-9 w-full text-sm"><SelectValue placeholder="Format" /></SelectTrigger>
                            <SelectContent>
                              <SelectItem value="text">Teks (Default)</SelectItem>
                              <SelectItem value="number">Angka (Number)</SelectItem>
                              <SelectItem value="currency">Mata Uang</SelectItem>
                              <SelectItem value="date">Tanggal (Date)</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>
                        <div className="xl:col-span-2 space-y-1">
                          <label className="text-[10px] font-bold uppercase text-slate-500">Align</label>
                          <Select 
                            value={dCol.align || 'left'}
                            onValueChange={(val) => {
                              const newCols = [...localTable.dataColumns];
                              newCols[cIdx].align = val as any;
                              setLocalTable({...localTable, dataColumns: newCols});
                            }}
                          >
                            <SelectTrigger className="h-9 w-full text-sm"><SelectValue placeholder="Align" /></SelectTrigger>
                            <SelectContent>
                              <SelectItem value="left">Kiri</SelectItem>
                              <SelectItem value="center">Tengah</SelectItem>
                              <SelectItem value="right">Kanan</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>
                        <div className="xl:col-span-3 space-y-1">
                          <label className="text-[10px] font-bold uppercase text-slate-500">Lebar (Width)</label>
                          <DebouncedInput 
                            placeholder="Contoh: 100px, 20%" 
                            className="font-mono text-sm h-9"
                            value={dCol.width || ''}
                            onChange={val => {
                              const newCols = [...localTable.dataColumns];
                              newCols[cIdx].width = String(val);
                              setLocalTable({...localTable, dataColumns: newCols});
                            }}
                          />
                        </div>
                        <div className="xl:col-span-2 space-y-1 flex items-end pb-1.5">
                          <label className="flex items-center gap-2 cursor-pointer group">
                            <input 
                              type="checkbox" 
                              className={`rounded border-gray-300 w-4 h-4 cursor-pointer ${isDark ? 'bg-slate-800' : 'bg-white'}`}
                              checked={dCol.isHeader || false}
                              onChange={e => {
                                const newCols = [...localTable.dataColumns];
                                newCols[cIdx].isHeader = e.target.checked;
                                setLocalTable({...localTable, dataColumns: newCols});
                              }}
                            />
                            <span className="text-[10px] font-bold uppercase text-slate-500 group-hover:text-indigo-500 transition-colors">Jadikan Header (TH)</span>
                          </label>
                        </div>
                      </div>
                      
                      {(dCol.type || 'field') === 'formula' && (
                        <div className={`space-y-1.5 p-3 mt-1 rounded-lg border ${isDark ? 'bg-slate-900/50 border-slate-700/50' : 'bg-slate-50/50 border-slate-200/50'}`}>
                          <label className={`text-[10px] font-bold uppercase ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Rumus Formula</label>
                          <DebouncedInput 
                            placeholder="Contoh: {tanggal:date} - {no_bukti}" className={`font-mono text-sm h-9 ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                            value={dCol.formula || ''}
                            onChange={val => {
                              const newCols = [...localTable.dataColumns];
                              newCols[cIdx].formula = String(val);
                              setLocalTable({...localTable, dataColumns: newCols});
                            }}
                          />
                          <p className={`text-[10px] leading-tight ${isDark ? 'text-slate-500' : 'text-slate-400'}`}>Gunakan <code>{`{field}`}</code> untuk merujuk ke data. Sisipkan teks bebas di luar kurung. Contoh: <code>{`{tanggal:date} - {no_bukti}`}</code>.</p>
                        </div>
                      )}
                    </div>
                  </div>
                )}
              </Each>
            </div>
          </div>

          <div className="h-px bg-slate-200 dark:bg-slate-700 w-full" />

          {/* Grouping & Sub-totals */}
          <div>
            <div className="flex items-center gap-2 mb-4">
              <Settings2 className="w-5 h-5 text-indigo-500" />
              <h4 className="font-semibold text-sm">Table Grouping & Sub-Totals</h4>
            </div>
            <div className={`p-5 rounded-xl border ${isDark ? 'bg-slate-800/50 border-slate-700' : 'bg-slate-50 border-slate-200'} space-y-5`}>
              
              <div className="bg-indigo-50 dark:bg-indigo-900/20 border border-indigo-100 dark:border-indigo-800 p-3 rounded-lg flex flex-col gap-1">
                <h5 className="text-xs font-semibold text-indigo-800 dark:text-indigo-300">Multi-Column Grouping</h5>
                <p className="text-[11px] text-indigo-600 dark:text-indigo-400">Anda dapat mengelompokkan data berdasarkan beberapa field sekaligus dengan memisahkannya menggunakan koma (contoh: <code>kode_cabang, id_divisi</code>).</p>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div className="space-y-1.5">
                  <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">Group By Field(s)</label>
                  <DebouncedInput 
                    placeholder="Contoh: kode_cabang, divisi" className="text-sm h-10"
                    value={localTable.grouping?.groupBy || ''}
                    onChange={val => setLocalTable({...localTable, grouping: {...localTable.grouping!, groupBy: String(val)}})}
                  />
                </div>
                <div className="space-y-1.5">
                  <label className="text-xs font-semibold text-slate-700 dark:text-slate-300">Label Text untuk Sub-Total</label>
                  <DebouncedInput 
                    placeholder="Contoh: Total" className="text-sm h-10"
                    value={localTable.grouping?.subtotalLabel || ''}
                    onChange={val => setLocalTable({...localTable, grouping: {...localTable.grouping!, subtotalLabel: String(val)}})}
                  />
                  <p className="text-[10px] text-slate-500">Akan tampil di kolom pertama baris sub-total.</p>
                </div>
              </div>

              <div className="flex items-center gap-2 mt-2">
                <Checkbox 
                  checked={localTable.grouping?.showSubtotal}
                  onChange={e => setLocalTable({...localTable, grouping: {...localTable.grouping!, showSubtotal: e.target.checked}})}
                />
                <label className="text-sm font-medium">Tampilkan Sub-Total (Sum)</label>
              </div>

              <div className="flex items-center gap-2 mt-2">
                <Checkbox 
                  checked={localTable.showGrandTotal !== false}
                  onChange={e => setLocalTable({...localTable, showGrandTotal: e.target.checked})}
                />
                <label className="text-sm font-medium">Tampilkan Grand Total</label>
              </div>

              {localTable.showGrandTotal !== false && localTable.grouping?.showSubtotal && (
                <div className="flex items-center gap-2 mt-2 pl-6">
                  <Checkbox 
                    checked={localTable.grouping?.hideSubtotalIfSingleGroup || false}
                    onChange={e => setLocalTable({...localTable, grouping: {...localTable.grouping!, hideSubtotalIfSingleGroup: e.target.checked}})}
                  />
                  <label className="text-sm font-medium text-slate-500">Sembunyikan Sub-Total jika hanya ada 1 grup</label>
                </div>
              )}

              {localTable.grouping?.groupBy && (
                <div className="flex items-center gap-2 mt-2">
                  <Checkbox 
                    checked={localTable.grouping?.showOnlyFirstRowPerGroup || false}
                    onChange={e => setLocalTable({...localTable, grouping: {...localTable.grouping!, showOnlyFirstRowPerGroup: e.target.checked}})}
                  />
                  <label className="text-sm font-medium">Tampilkan satu data (baris pertama) dari setiap grup</label>
                </div>
              )}

              {localTable.grouping?.showSubtotal && (
                <div className="space-y-2 pt-2">
                  <label className="text-xs font-semibold text-slate-500">Pilih Kolom untuk Dijumlahkan (Sum)</label>
                  {(!localTable.dataColumns || localTable.dataColumns.length === 0) ? (
                    <p className="text-xs text-red-500 italic">Silakan tambahkan Data Columns (Tbody) terlebih dahulu di atas.</p>
                  ) : (
                    <div className="flex flex-wrap gap-3 p-3 rounded-lg border bg-white dark:bg-slate-900 dark:border-slate-800">
                      <Each of={localTable.dataColumns}>
                        {(dCol, cIdx) => (
                          <div key={cIdx} className="flex items-center gap-2">
                            <Checkbox 
                              checked={localTable.grouping?.subtotalColumns?.includes(dCol.field)}
                              onChange={e => {
                                const currentCols = [...(localTable.grouping?.subtotalColumns || [])];
                                if (e.target.checked) {
                                  if (!currentCols.includes(dCol.field)) currentCols.push(dCol.field);
                                } else {
                                  const idx = currentCols.indexOf(dCol.field);
                                  if (idx > -1) currentCols.splice(idx, 1);
                                }
                                setLocalTable({...localTable, grouping: {...localTable.grouping!, subtotalColumns: currentCols}});
                              }}
                            />
                            <label className="text-xs font-medium cursor-pointer" onClick={() => {
                                const currentCols = [...(localTable.grouping?.subtotalColumns || [])];
                                if (!currentCols.includes(dCol.field)) currentCols.push(dCol.field);
                                else currentCols.splice(currentCols.indexOf(dCol.field), 1);
                                setLocalTable({...localTable, grouping: {...localTable.grouping!, subtotalColumns: currentCols}});
                            }}>{dCol.field || `Kolom ${cIdx+1}`}</label>
                          </div>
                        )}
                      </Each>
                    </div>
                  )}
                  <p className="text-[10px] text-slate-400">Pilih field (dari Tbody) yang akan dijumlahkan pada baris Sub-Total.</p>
                </div>
              )}
            </div>
          </div>

        </div>

        <div className={`p-4 border-t flex justify-end gap-3 rounded-b-xl ${isDark ? 'bg-slate-900 border-slate-800' : 'bg-slate-50 border-slate-200'}`}>
          <Button variant="outline" onClick={onClose}>Batal</Button>
          <Button onClick={() => onSave(localTable)}>Simpan Konfigurasi</Button>
        </div>
      </div>
    </div>
  );
}
