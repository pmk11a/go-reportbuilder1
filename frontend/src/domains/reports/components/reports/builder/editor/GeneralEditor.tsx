import { Input, Textarea, Checkbox, Button, Select, SelectTrigger, SelectValue, SelectContent, SelectItem } from '@/shared/ui';
import type { IReportConfig } from '@/domains/reports/types';
import { Trash2 } from 'lucide-react';
import { DataSourceManager } from './DataSourceManager';
import { HelpGuide } from '../HelpGuide';

export function GeneralEditor({ config, onChange, isDark, onDelete }: { config: Partial<IReportConfig>, onChange: any, isDark: boolean, onDelete?: () => void }) {
  const labelClass = `text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`;
  return (
    <div className="space-y-4">
      <div className="flex justify-between items-center mb-2">
        <h2 className={`text-lg font-bold ${isDark ? 'text-slate-200' : 'text-slate-800'}`}>Pengaturan Umum</h2>
        <HelpGuide title="Panduan Tab General">
          <p>Tab <strong>General</strong> digunakan untuk mengatur identitas dasar laporan dan meracik sumber data (Dataset) yang akan digunakan pada tab-tab berikutnya.</p>
          <ul className="list-disc pl-5 space-y-1">
            <li><strong>Nama Laporan:</strong> Judul yang akan tampil di halaman laporan.</li>
            <li><strong>Kode Menu:</strong> Kode unik untuk menu laporan.</li>
            <li><strong>Data Source:</strong> Query SQL yang menghasilkan data. Pastikan menamakan dataset dengan jelas (otomatis dikonversi ke format snake_case tanpa angka di depan). Dataset yang dideklarasikan di sini bisa dipanggil secara lintas dataset menggunakan sintaks <code className="bg-slate-100 dark:bg-slate-800 px-1 py-0.5 rounded text-xs">{`{NamaDataset.Field}`}</code>.</li>
          </ul>
        </HelpGuide>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-12 gap-4 mb-4">
        <div className="md:col-span-8 space-y-1">
          <label className={labelClass}>Nama Laporan</label>
          <Input 
            className={`h-9 rounded-xl ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
            type="text" 
            value={config.nama_laporan || ''}
            onChange={e => onChange({ ...config, nama_laporan: e.target.value })}
          />
        </div>
        <div className="md:col-span-4 space-y-1">
          <label className={labelClass}>Kode Menu</label>
          <Input 
            className={`h-9 rounded-xl ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
            type="text" 
            value={config.KODEMENU || ''}
            onChange={e => onChange({ ...config, KODEMENU: e.target.value })}
          />
        </div>
      </div>
      <div className="space-y-1">
        <label className={labelClass}>Deskripsi Laporan</label>
        <Textarea 
          className={`rounded-xl ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
          rows={3}
          value={config.deskripsi || ''}
          onChange={e => onChange({ ...config, deskripsi: e.target.value })}
        />
      </div>
      <div>
        <label className={`flex items-center text-sm font-medium cursor-pointer ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>
          <Checkbox 
            className="mr-2"
            checked={config.status_aktif !== false} // default true
            onChange={(e: React.ChangeEvent<HTMLInputElement>) => onChange({ ...config, status_aktif: e.target.checked })}
          />
          Laporan Aktif (Ditampilkan di Menu)
        </label>
      </div>

      <div className={`h-px w-full ${isDark ? 'bg-slate-800' : 'bg-slate-200'}`}></div>

      <div>
        <h3 className={`text-base font-bold mb-3 ${isDark ? 'text-slate-200' : 'text-slate-800'}`}>Konfigurasi Kertas (Cetak)</h3>
        <div className={`p-4 rounded-xl border ${isDark ? 'bg-slate-900 border-slate-700' : 'bg-white border-slate-200'}`}>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="space-y-1.5">
              <label className={labelClass}>Ukuran Kertas</label>
              <Select
                value={config.paperConfig?.size || 'A4'}
                onValueChange={(val: any) => onChange({ ...config, paperConfig: { ...(config.paperConfig || {}), size: val } })}
              >
                <SelectTrigger className={`h-9 w-full rounded-xl ${isDark ? 'bg-slate-950 border-slate-700' : 'bg-white border-slate-200'}`}>
                  <SelectValue placeholder="Pilih Kertas" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="A4">A4 (210 x 297 mm)</SelectItem>
                  <SelectItem value="F4">F4 / Folio (215 x 330 mm)</SelectItem>
                  <SelectItem value="Letter">Letter (216 x 279 mm)</SelectItem>
                  <SelectItem value="Legal">Legal (216 x 356 mm)</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-1.5">
              <label className={labelClass}>Orientasi (Rotasi)</label>
              <Select
                value={config.paperConfig?.orientation || 'portrait'}
                onValueChange={(val: any) => onChange({ ...config, paperConfig: { ...(config.paperConfig || {}), orientation: val } })}
              >
                <SelectTrigger className={`h-9 w-full rounded-xl ${isDark ? 'bg-slate-950 border-slate-700' : 'bg-white border-slate-200'}`}>
                  <SelectValue placeholder="Pilih Orientasi" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="portrait">Potret (Berdiri)</SelectItem>
                  <SelectItem value="landscape">Lanskap (Mendatar)</SelectItem>
                </SelectContent>
              </Select>
            </div>
            
            <div className="md:col-span-2 mt-2">
              <label className={labelClass + " mb-2"}>Margin Kertas</label>
              <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
                <div className="space-y-1">
                  <label className={`text-[10px] ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Atas (Top)</label>
                  <Input 
                    placeholder="Contoh: 20mm" className={`h-8 text-xs ${isDark ? 'bg-slate-950' : 'bg-white'}`}
                    value={config.paperConfig?.margin?.top || '20mm'}
                    onChange={e => onChange({ ...config, paperConfig: { ...(config.paperConfig || {}), margin: { ...(config.paperConfig?.margin || {}), top: e.target.value } } })}
                  />
                </div>
                <div className="space-y-1">
                  <label className={`text-[10px] ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Kanan (Right)</label>
                  <Input 
                    placeholder="Contoh: 15mm" className={`h-8 text-xs ${isDark ? 'bg-slate-950' : 'bg-white'}`}
                    value={config.paperConfig?.margin?.right || '15mm'}
                    onChange={e => onChange({ ...config, paperConfig: { ...(config.paperConfig || {}), margin: { ...(config.paperConfig?.margin || {}), right: e.target.value } } })}
                  />
                </div>
                <div className="space-y-1">
                  <label className={`text-[10px] ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Bawah (Bottom)</label>
                  <Input 
                    placeholder="Contoh: 20mm" className={`h-8 text-xs ${isDark ? 'bg-slate-950' : 'bg-white'}`}
                    value={config.paperConfig?.margin?.bottom || '20mm'}
                    onChange={e => onChange({ ...config, paperConfig: { ...(config.paperConfig || {}), margin: { ...(config.paperConfig?.margin || {}), bottom: e.target.value } } })}
                  />
                </div>
                <div className="space-y-1">
                  <label className={`text-[10px] ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>Kiri (Left)</label>
                  <Input 
                    placeholder="Contoh: 15mm" className={`h-8 text-xs ${isDark ? 'bg-slate-950' : 'bg-white'}`}
                    value={config.paperConfig?.margin?.left || '15mm'}
                    onChange={e => onChange({ ...config, paperConfig: { ...(config.paperConfig || {}), margin: { ...(config.paperConfig?.margin || {}), left: e.target.value } } })}
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className={`h-px w-full ${isDark ? 'bg-slate-800' : 'bg-slate-200'}`}></div>

      <DataSourceManager 
        config={config}
        onChange={onChange}
        isDark={isDark}
        scope="global"
        title="Global Data Sources"
        description="Ambil data dari database yang bisa digunakan di semua tab (Filter, Header, Body, Footer)."
      />

      {onDelete && config.id_laporan && (
        <div className="pt-4 mt-6 border-t border-slate-200 dark:border-slate-800">
          <Button variant="destructive" onClick={onDelete} className="w-full sm:w-auto">
            <Trash2 className="w-4 h-4 mr-2" /> Hapus Laporan Ini
          </Button>
          <p className="text-xs text-slate-500 mt-2">Menghapus laporan akan menghapus seluruh data tab, filter, dataset, dan layout secara permanen.</p>
        </div>
      )}
    </div>
  );
}
