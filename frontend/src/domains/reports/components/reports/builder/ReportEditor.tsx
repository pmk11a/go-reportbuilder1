import { useState } from 'react';
import { useThemeStore } from '@/shared/stores/themeStore';
import { Show, Tabs, Skeleton } from '@/shared/ui';
import type { 
  ILayoutConfig, IReportConfig, ILayoutHeader, ILayoutBody, ILayoutFooter, 
  ILayoutTable 
} from '@/domains/reports/types';

import { 
  GeneralEditor, 
  FiltersEditor, 
  HeaderEditor, 
  BodyEditor, 
  FooterEditor, 
  TableHeaderModal 
} from './editor';

interface ReportEditorProps {
  activeTab: string;
  setActiveTab: (val: string) => void;
  reportConfig: Partial<IReportConfig>;
  setReportConfig: (val: Partial<IReportConfig>) => void;
  layoutConfig: ILayoutConfig[];
  setLayoutConfig: (val: ILayoutConfig[]) => void;
  isLoading: boolean;
  onDeleteReport?: () => void;
}

export function ReportEditor({ activeTab, setActiveTab, reportConfig, setReportConfig, layoutConfig, setLayoutConfig, isLoading, onDeleteReport }: ReportEditorProps) {
  const isDark = useThemeStore((s) => s.isDark);
  const [headerModal, setHeaderModal] = useState<{isOpen: boolean, rowIndex: number, colIndex: number, table: ILayoutTable | null}>({ isOpen: false, rowIndex: -1, colIndex: -1, table: null });

  const updateLayout = (type: 'header' | 'body' | 'footer', newData: any) => {
    const newConfig = [...layoutConfig];
    const index = newConfig.findIndex(c => c.type === type);
    if (index >= 0) {
      newConfig[index] = newData;
    } else {
      newConfig.push(newData);
    }
    setLayoutConfig(newConfig);
  };

  const getLayout = (type: string) => layoutConfig.find(c => c.type === type) || { type, rows: [] };

  const tabItems = [
    { 
      label: 'General', 
      value: 'general', 
      content: (
        <div className="p-4 pb-32">
          <Show when={!isLoading} fallback={<EditorSkeleton isDark={isDark} />}>
            <GeneralEditor config={reportConfig} onChange={setReportConfig} isDark={isDark} onDelete={onDeleteReport} />
          </Show>
        </div>
      )
    },
    { 
      label: 'Filters', 
      value: 'filters', 
      content: (
        <div className="p-4 pb-32">
          <Show when={!isLoading} fallback={<EditorSkeleton isDark={isDark} />}>
            <FiltersEditor config={reportConfig} onChange={setReportConfig} isDark={isDark} />
          </Show>
        </div>
      )
    },
    { 
      label: 'Header Layout', 
      value: 'header', 
      content: (
        <div className="p-4 pb-32">
          <Show when={!isLoading} fallback={<EditorSkeleton isDark={isDark} />}>
            <HeaderEditor config={getLayout('header') as ILayoutHeader} onChange={(d: any) => updateLayout('header', d)} reportConfig={reportConfig} setReportConfig={setReportConfig} isDark={isDark} />
          </Show>
        </div>
      )
    },
    { 
      label: 'Body Layout', 
      value: 'body', 
      content: (
        <div className="p-4 pb-32">
          <Show when={!isLoading} fallback={<EditorSkeleton isDark={isDark} />}>
            <BodyEditor 
              config={getLayout('body') as ILayoutBody} 
              onChange={(d: any) => updateLayout('body', d)}
              reportConfig={reportConfig}
              setReportConfig={setReportConfig}
              onOpenHeaderModal={(rIdx, cIdx, table) => setHeaderModal({ isOpen: true, rowIndex: rIdx, colIndex: cIdx, table })}
              isDark={isDark}
            />
          </Show>
        </div>
      )
    },
    { 
      label: 'Footer Layout', 
      value: 'footer', 
      content: (
        <div className="p-4 pb-32">
          <Show when={!isLoading} fallback={<EditorSkeleton isDark={isDark} />}>
            <FooterEditor config={getLayout('footer') as ILayoutFooter} onChange={(d: any) => updateLayout('footer', d)} reportConfig={reportConfig} setReportConfig={setReportConfig} isDark={isDark} />
          </Show>
        </div>
      )
    }
  ];

  return (
    <div className="flex flex-col h-full bg-transparent">
      {/* Tabs Component */}
      <Tabs tabs={tabItems} defaultValue={activeTab} onValueChange={setActiveTab} className="h-full" storageKey="report-editor-tab" />

      {/* Table Header Modal */}
      <Show when={headerModal.isOpen && headerModal.table !== null}>
        <TableHeaderModal 
          table={headerModal.table!}
          isDark={isDark}
          reportId={reportConfig.id_laporan}
          datasetQuery={reportConfig.datasets?.find(d => d.nama_dataset === headerModal.table?.dataset)?.query_sumber_data}
          onClose={() => setHeaderModal({ isOpen: false, rowIndex: -1, colIndex: -1, table: null })}
          onSave={(newTable) => {
            const bodyConfig = getLayout('body') as ILayoutBody;
            const newBody = { ...bodyConfig };
            newBody.rows[headerModal.rowIndex].columns[headerModal.colIndex].table = newTable;
            updateLayout('body', newBody);
            setHeaderModal({ isOpen: false, rowIndex: -1, colIndex: -1, table: null });
          }}
        />
      </Show>
    </div>
  );
}

function EditorSkeleton({ isDark }: { isDark: boolean }) {
  return (
    <div className={`rounded-3xl border shadow-sm p-6 ${isDark ? 'bg-slate-800/50 border-slate-700' : 'bg-white border-slate-100'}`}>
      <div className={`flex justify-between items-center mb-6 pb-6 border-b border-dashed ${isDark ? 'border-slate-700' : 'border-slate-200'}`}>
        <Skeleton className="h-8 w-48" />
        <Skeleton className="h-8 w-8 rounded-full" />
      </div>
      <div className="space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div className="space-y-2">
            <Skeleton className="h-4 w-24" />
            <Skeleton className="h-10 w-full rounded-xl" />
          </div>
          <div className="space-y-2">
            <Skeleton className="h-4 w-32" />
            <Skeleton className="h-10 w-full rounded-xl" />
          </div>
        </div>
        <div className="space-y-2">
          <Skeleton className="h-4 w-28" />
          <Skeleton className="h-24 w-full rounded-xl" />
        </div>
      </div>
    </div>
  );
}
