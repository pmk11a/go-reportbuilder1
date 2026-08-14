import { Plus, Trash2 } from 'lucide-react';
import { Button, Input, Textarea, Show, Each } from '@/shared/ui';
import type { IReportConfig, IReportDataset } from '@/domains/reports/types';

interface DataSourceManagerProps {
  config: Partial<IReportConfig>;
  onChange: (config: Partial<IReportConfig>) => void;
  isDark: boolean;
  scope: 'global' | 'filter' | 'header' | 'body' | 'footer';
  title: string;
  description: string;
}

export function DataSourceManager({ config, onChange, isDark, scope, title, description }: DataSourceManagerProps) {
  const allDatasets = config.datasets || [];
  const localDatasets = allDatasets.filter(d => d.config_json?.scope === scope);
  const cardClass = isDark ? 'bg-slate-800/50 border-slate-700' : 'bg-slate-50 border-slate-200';
  const headingClass = isDark ? 'text-slate-200' : 'text-slate-800';

  const updateAllDatasets = (newLocal: IReportDataset[]) => {
    const otherDatasets = allDatasets.filter(d => d.config_json?.scope !== scope);
    onChange({ ...config, datasets: [...otherDatasets, ...newLocal] });
  };

  const addSource = () => {
    const baru: IReportDataset = {
      id_query: Date.now(), // temporary ID
      id_laporan: config.id_laporan || 0,
      nama_dataset: `new_${scope}_ds_${Date.now()}`,
      deskripsi: '',
      query_sumber_data: 'SELECT ...',
      urutan: localDatasets.length + 1,
      visible: true,
      config_json: { scope }
    };
    updateAllDatasets([...localDatasets, baru]);
  };

  const updateSource = (idx: number, updates: Partial<IReportDataset>) => {
    const newLocal = [...localDatasets];
    newLocal[idx] = { ...newLocal[idx], ...updates };
    updateAllDatasets(newLocal);
  };

  const deleteSource = (idx: number) => {
    const newLocal = localDatasets.filter((_, i) => i !== idx);
    updateAllDatasets(newLocal);
  };

  return (
    <div className="space-y-4">
      <div className={`sticky top-0 z-20 flex justify-between items-center py-2 px-1 -mx-1 mb-2 ${isDark ? 'bg-[#0f172a]' : 'bg-slate-50'}`}>
        <div>
          <h3 className={`font-medium ${headingClass}`}>{title}</h3>
          <p className={`text-xs ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>{description}</p>
        </div>
        <Button variant="outline" size="sm" onClick={addSource}>
          <Plus className="w-4 h-4 mr-1" /> Add Source
        </Button>
      </div>

      <Show when={localDatasets.length > 0}>
        <div className="space-y-3">
          <Each of={localDatasets}>
            {(ds, i) => (
              <div key={ds.id_query} className={`p-4 border rounded-xl relative ${cardClass}`}>
                <Button variant="ghost" size="icon" onClick={() => deleteSource(i)} className="absolute top-2 right-2 text-red-500 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-950/50">
                  <Trash2 className="w-4 h-4" />
                </Button>
                
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-3 pr-0 sm:pr-8">
                  <div className="space-y-1">
                    <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>ID Source (Unik)</label>
                    <Input value={ds.id_query.toString()} readOnly className={`h-9 rounded-xl text-xs ${isDark ? 'bg-slate-900 text-slate-400 border-slate-700' : 'bg-slate-100 text-slate-500 border-slate-200'}`} />
                  </div>
                  <div className="space-y-1">
                    <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Nama Dataset</label>
                    <Input 
                      value={ds.nama_dataset} 
                      onChange={e => {
                        let val = e.target.value.toLowerCase().replace(/\s+/g, '_').replace(/^[0-9]+/, '');
                        updateSource(i, { nama_dataset: val });
                      }} 
                      placeholder="Misal: periode_aktif" 
                      className={`h-9 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'} ${localDatasets.filter((d, idx) => d.nama_dataset === ds.nama_dataset && idx !== i).length > 0 ? 'border-red-500 ring-1 ring-red-500' : ''}`} 
                    />
                    {localDatasets.filter((d, idx) => d.nama_dataset === ds.nama_dataset && idx !== i).length > 0 && (
                      <span className="text-[10px] text-red-500 font-medium">Nama dataset ini sudah digunakan (duplikat).</span>
                    )}
                  </div>
                </div>
                <div className="space-y-1 mb-3">
                  <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Keterangan</label>
                  <Input
                    value={ds.deskripsi || ''}
                    onChange={e => updateSource(i, { deskripsi: e.target.value })}
                    placeholder="Deskripsi singkat data source ini..."
                    className={`h-9 rounded-xl text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`}
                  />
                </div>
                <div className="space-y-1">
                  <label className={`text-xs font-semibold block ${isDark ? 'text-slate-300' : 'text-slate-700'}`}>Query (SP / SELECT)</label>
                  <Textarea value={ds.query_sumber_data} onChange={e => updateSource(i, { query_sumber_data: e.target.value })} rows={3} placeholder="EXEC Sp_Periode" className={`rounded-xl font-mono text-xs ${isDark ? 'bg-slate-950 border-slate-700 text-slate-200' : 'bg-white border-slate-200 text-slate-900'}`} />
                </div>
              </div>
            )}
          </Each>
        </div>
      </Show>
    </div>
  );
}
