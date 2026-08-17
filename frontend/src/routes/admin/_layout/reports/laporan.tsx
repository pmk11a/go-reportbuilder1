import { createFileRoute, Outlet, Link, useLocation } from '@tanstack/react-router'
import { FileText, Folder } from 'lucide-react'
import { useState } from 'react'
import { useReportsMenu } from '@/domains/reports/hooks/useReport'
import type { IReportMenuItem } from '@/domains/reports/types'
import { useThemeStore } from '@/shared/stores/themeStore'
import { Each, Show, CollapsibleSidebarLayout } from '@/shared/ui/layout'
import { useDebounce } from '@/shared/hooks'

export const Route = createFileRoute('/admin/_layout/reports/laporan')({
  component: LaporanDinamisLayout,
})

function LaporanDinamisLayout() {
  const [searchQuery, setSearchQuery] = useState('')
  const debouncedSearch = useDebounce(searchQuery, 300)
  const { data: menuItems, isLoading } = useReportsMenu(debouncedSearch)
  const theme = useThemeStore((s) => s.theme)
  const isDark = theme === 'dark'

  // We could extract the active ID to highlight it
  // Since we don't have access to the matched route params directly here without a hook,
  const location = useLocation()
  const pathParts = location.pathname.split('/')
  const selectedKode = pathParts[pathParts.length - 1] !== 'laporan' ? pathParts[pathParts.length - 1] : ''
  const sidebarCustomContent = (
    <Show when={!isLoading} fallback={
      <div className="p-4 text-center text-secondary-400">Memuat...</div>
    }>
      {menuItems && menuItems.length > 0 ? (
        <div className="space-y-1">
          <Each of={menuItems}>
            {(item) => (
              <MenuNode 
                item={item} 
                searchQuery={searchQuery} 
                selectedKode={selectedKode}
                isDark={isDark} 
              />
            )}
          </Each>
        </div>
      ) : (
        <div className="p-4 text-center text-secondary-400 text-sm">Tidak ada laporan.</div>
      )}
    </Show>
  )

  const mainContent = (
    <div className={`rounded-3xl border shadow-xl overflow-hidden flex-1 flex flex-col h-full ${
      isDark 
        ? 'bg-[#0f172a] border-white/5 shadow-2xl' 
        : 'bg-white border-slate-100 shadow-blue-500/5'
    }`}>
      <Outlet />
    </div>
  )

  return (
    <div className="h-[calc(100vh-80px)]">
      <CollapsibleSidebarLayout
        sidebarTitle="Daftar Laporan"
        searchPlaceholder="Cari laporan..."
        searchValue={searchQuery}
        onSearchChange={setSearchQuery}
        sidebarCustomContent={sidebarCustomContent}
        mainContent={mainContent}
      />
    </div>
  )
}

function MenuNode({ 
  item, 
  depth = 0, 
  searchQuery, 
  selectedKode,
  isDark 
}: { 
  item: IReportMenuItem; 
  depth?: number; 
  searchQuery: string;
  selectedKode: string;
  isDark: boolean;
}) {
  const hasChildren = item.children && item.children.length > 0
  const isLeaf = !hasChildren

  return (
    <div className="w-full">
      {isLeaf ? (
        <Link 
          to="/admin/reports/laporan/$kodeMenu"
          params={{ kodeMenu: item.KODEMENU }}
          className={`flex items-start gap-3 p-2.5 rounded-lg text-sm transition-all mb-1 ${
            selectedKode === item.KODEMENU
              ? isDark 
                ? "bg-primary-600 text-white" 
                : "bg-primary-600 text-white shadow-md shadow-primary-500/20"
              : isDark 
                ? "text-slate-400 hover:bg-slate-700/50" 
                : "text-slate-600 hover:bg-slate-50"
          }`}
          style={{ paddingLeft: `${(depth * 16) + 12}px` }}
        >
          <FileText className="w-4 h-4 shrink-0 mt-0.5" />
          <div className="flex flex-col min-w-0 flex-1">
            <span className="font-medium truncate">{item.nama_laporan || item.NmReport}</span>
          </div>
        </Link>
      ) : (
        <div className="mb-2">
          <div 
            className="flex items-center gap-2 px-3 py-2 text-xs font-semibold text-secondary-500 uppercase tracking-wider"
            style={{ paddingLeft: `${(depth * 16) + 12}px` }}
          >
            <Folder className="w-3.5 h-3.5 shrink-0" />
            <span className="truncate">{item.NmReport}</span>
          </div>
          <div className="space-y-0.5">
            <Each of={item.children}>
              {(child) => (
                <MenuNode 
                  item={child} 
                  depth={depth + 1} 
                  searchQuery={searchQuery}
                  selectedKode={selectedKode}
                  isDark={isDark} 
                />
              )}
            </Each>
          </div>
        </div>
      )}
    </div>
  )
}
