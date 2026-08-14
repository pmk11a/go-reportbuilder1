/**
 * DynamicFilterPanel — TASK-027a AC2.
 *
 * Renders the right widget for each filter based on `tipe_input`:
 *   - date/text/number → <Input type="...">
 *   - dropdown        → <Select> (from @/shared/ui/form) with konfigurasi.options
 *   - checkbox        → <Checkbox> with on/off values
 *   - browse/combobox/perkiraan → <GenericBrowsePicker>
 *
 * Filters are sorted by `posisi` ASC before rendering (gap #8 fix).
 * Each rendered input has a stable `name` attribute matching the
 * filter name — this is the contract the parity harness uses.
 *
 * The initial values honor `nilai_default` for every tipe_input.
 * Values are persisted in useReportStore (Zustand persist middleware,
 * keyed by kodeMenu).
 */
import { useEffect, useMemo } from 'react'
import { Button, Input, Select, SelectContent, SelectItem, SelectTrigger, SelectValue, Checkbox } from '@/shared/ui'
import { Label } from '@/shared/ui/form'
import { Filter, Loader2, Play } from 'lucide-react'
import { useReportStore } from '../../../stores/reportStore'
import { GenericBrowsePicker } from '@/domains/browse/components/browse/GenericBrowsePicker'
import { Each, Show } from '@/shared/ui/layout'
import { useThemeStore } from '@/shared/stores/themeStore'

import { resolveFilterConfig, sortFiltersByPosisi, resolveInitialFilterValues } from '../../../utils/filterRenderer'

interface BuilderFilterPanelProps {
  kodeMenu: string
  filters: any[]
  executeReport: any // useExecuteReport mutation instance
}

export function BuilderFilterPanel({ kodeMenu, filters, executeReport }: BuilderFilterPanelProps) {
  const filterValues = useReportStore((s: any) => s.filterValues)

  const resetFilters = useReportStore((s: any) => s.resetFilters)
  const hydrateFilters = useReportStore((s: any) => s.hydrateFilters)

  const isDark = useThemeStore((s: any) => s.theme === 'dark')

  // Sort by posisi ASC (gap #8 fix)
  const sortedFilters = useMemo(() => sortFiltersByPosisi(filters), [filters])

  // Hydration: on first render with config, populate nilai_default for ALL filters
  useEffect(() => {
    if (sortedFilters.length > 0) {
      const currentScope = filterValues._kodeMenu === kodeMenu ? filterValues : { _kodeMenu: kodeMenu } as any
      const values = resolveInitialFilterValues(
        sortedFilters,
        currentScope._kodeMenu === kodeMenu ? currentScope : {}
      )
      hydrateFilters(kodeMenu, values)
    }
  }, [kodeMenu, sortedFilters, hydrateFilters]) // intentionally exclude filterValues to avoid loops

  const handleGenerate = () => {
    // Always read the LATEST filterValues from the store (avoid stale closure)
    const currentValues = useReportStore.getState().filterValues
    const missingRequired: string[] = []
    for (const f of sortedFilters) {
      const v = (currentValues as any)[f.nama_filter]
      if (f.wajib_isi && (v === undefined || v === null || v === '')) {
        missingRequired.push(f.label)
      }
    }
    if (missingRequired.length > 0) {
      alert(`Mohon isi parameter wajib: ${missingRequired.join(', ')}`)
      return
    }
    // Strip the _kodeMenu marker before sending to backend
    const { _kodeMenu, ...payload } = currentValues as any
    executeReport.mutate(payload)
  }


  return (
    <Show
      when={sortedFilters.length > 0}
      fallback={
        <div
          className={`mb-6 p-4 flex items-center justify-between rounded-3xl border ${
            isDark ? 'bg-[#0f172a] border-white/5 shadow-2xl' : 'bg-white border-slate-100 shadow-xl shadow-blue-500/5'
          }`}
        >
          <p className={`text-sm ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>
            Laporan ini tidak memiliki parameter filter.
          </p>
          <Button onClick={handleGenerate} disabled={executeReport.isPending} className="flex items-center gap-2">
            <Show when={executeReport.isPending} fallback={<Play className="w-4 h-4" />}>
              <Loader2 className="w-4 h-4 animate-spin" />
            </Show>
            Generate Report
          </Button>
        </div>
      }
    >
      <div
        className={`mb-6 rounded-3xl border ${
          isDark ? 'bg-[#0f172a] border-white/5 shadow-2xl' : 'bg-white border-slate-100 shadow-xl shadow-blue-500/5'
        }`}
      >
        <div
          className={`py-3 px-4 border-b flex items-center gap-2 rounded-t-3xl ${
            isDark ? 'bg-slate-800/50 border-slate-700/50' : 'bg-slate-50/50 border-slate-100'
          }`}
        >
          <Filter className={`w-4 h-4 ${isDark ? 'text-slate-400' : 'text-slate-500'}`} />
          <h3 className={`text-sm font-medium ${isDark ? 'text-slate-200' : 'text-slate-700'}`}>Parameter Laporan</h3>
        </div>
        <div className="p-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
            <Each of={sortedFilters}>
              {(filter: any) => {
                const config = resolveFilterConfig(filter)
                return (
                  <FilterFieldRenderer
                    key={filter.id_filter || filter.nama_filter}
                    kodeMenu={kodeMenu}
                    filter={filter}
                    config={config}
                  />
                )
              }}
            </Each>
          </div>

          <div className={`flex items-center gap-3 mt-5 pt-4 border-t ${isDark ? 'border-slate-700/50' : 'border-slate-100'}`}>
            <Button
              onClick={handleGenerate}
              disabled={executeReport.isPending}
              className="flex items-center gap-2 rounded-xl h-9 px-6"
            >
              <Show when={executeReport.isPending} fallback={<Play className="w-4 h-4" />}>
                <Loader2 className="w-4 h-4 animate-spin" />
              </Show>
              <Show when={executeReport.isPending} fallback="Generate Report">
                Generating...
              </Show>
            </Button>

            <Button
              variant="outline"
              onClick={resetFilters}
              disabled={executeReport.isPending}
              className="rounded-xl h-9 px-6"
            >
              Reset
            </Button>
          </div>
        </div>
      </div>
    </Show>
  )
}

/**
 * FilterInput — renders the right widget for one filter.
 * Must be defined OUTSIDE DynamicFilterPanel to avoid infinite loop
 * caused by recreating it on every parent render.
 */
interface FilterFieldRendererProps {
  kodeMenu: string
  filter: import('../../../types').IReportFilter
  config: import('../../../utils/filterRenderer').ResolvedFilterConfig
}

function FilterFieldRenderer({ kodeMenu, filter, config }: FilterFieldRendererProps) {
  const value = useReportStore((s: any) => s.filterValues[filter.nama_filter] ?? '')
  const setFilterValue = useReportStore((s: any) => s.setFilterValue)
  const isDark = useThemeStore((s: any) => s.theme === 'dark')

  return (
    <div className="flex flex-col gap-1.5">
      <Label className="text-xs font-medium text-slate-500">{filter.label}</Label>
      <FilterInput
        filter={filter}
        resolved={config}
        value={value}
        onChange={(v) => setFilterValue(kodeMenu, filter.nama_filter, v)}
        isDark={isDark}
      />
    </div>
  )
}

interface FilterInputProps {
  filter: import('../../../types').IReportFilter
  resolved: import('../../../utils/filterRenderer').ResolvedFilterConfig
  value: string
  onChange: (v: string) => void
  isDark: boolean
}

function FilterInput({ filter, resolved, value, onChange, isDark }: FilterInputProps) {
  const id = `filter-${filter.nama_filter}`
  const inputClass = 'w-full text-sm h-9 rounded-xl'

  switch (resolved.kind) {
    case 'date':
      return (
        <Input
          id={id}
          name={filter.nama_filter}
          type="date"
          value={value}
          onChange={(e) => onChange(e.target.value)}
          className={inputClass}
        />
      )
    case 'number':
      return (
        <Input
          id={id}
          name={filter.nama_filter}
          type="number"
          value={value}
          onChange={(e) => onChange(e.target.value)}
          placeholder={filter.label}
          className={inputClass}
        />
      )
    case 'text':
      return (
        <Input
          id={id}
          name={filter.nama_filter}
          type="text"
          value={value}
          onChange={(e) => onChange(e.target.value)}
          placeholder={filter.label}
          className={inputClass}
        />
      )
    case 'browse':
      return (
        <GenericBrowsePicker
          kodeBrowse={resolved.kodeBrowse || ''}
          value={value}
          onChange={(v) => onChange(v)}
          placeholder={`Pilih ${filter.label}...`}
          className="w-full text-sm"
        />
      )
    case 'dropdown':
      return (
        <Select value={value || undefined} onValueChange={(v) => onChange(v)}>
          <SelectTrigger id={id} name={filter.nama_filter} className={inputClass}>
            <SelectValue placeholder={filter.label} />
          </SelectTrigger>
          <SelectContent>
            <Each of={resolved.options || []}>
              {(opt) => (
                <SelectItem key={opt} value={opt}>
                  {resolved.labelMap?.[opt] ?? opt}
                </SelectItem>
              )}
            </Each>
          </SelectContent>
        </Select>
      )
    case 'checkbox': {
      const checked = value === (resolved.options?.[0] ?? '1')
      return (
        <div className="flex items-center gap-2 h-9">
          <Checkbox
            id={id}
            name={filter.nama_filter}
            checked={checked}
            onChange={(e) => onChange(e.target.checked ? (resolved.options?.[0] ?? '1') : (resolved.options?.[1] ?? '0'))}
          />
          <span className={`text-xs ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>
            {checked ? (resolved.labelMap?.[resolved.options?.[0] ?? '1'] ?? 'Aktif') : (resolved.labelMap?.[resolved.options?.[1] ?? '0'] ?? 'Tidak Aktif')}
          </span>
        </div>
      )
    }
    case 'combobox':
      return (
        <GenericBrowsePicker
          kodeBrowse={resolved.kodeBrowse || ''}
          value={value}
          onChange={(v) => onChange(v)}
          placeholder={`Pilih ${filter.label}...`}
          className="w-full text-sm"
        />
      )
    case 'perkiraan':
      return (
        <GenericBrowsePicker
          kodeBrowse={resolved.kodeBrowse || '1001'}
          value={value}
          onChange={(v) => onChange(v)}
          placeholder={`Pilih ${filter.label}...`}
          className="w-full text-sm"
        />
      )
    default:
      return null
  }
}
