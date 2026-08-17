/**
 * SubreportLayout — TASK-030 Step 6.
 *
 * Renders a subreport page (Page 2 in Delphi fr3 terms).
 * Used for datasets like T3 that display on a secondary physical page:
 * Bank / Riil $ / Riil Rp / CHGB / Total breakdown.
 *
 * Mirrors Delphi Footer2 (Page 2) with a Footer row showing SUM of each column.
 */
import { DynamicReportTable } from '../DynamicReportTable'
import { IReportDataset } from '@/domains/reports/types'


interface SubreportDataset {
  dataset: IReportDataset
  columns: any[]
  data: any[]
}

interface SubreportLayoutProps {
  kodeMenu: string
  subreportDatasets: SubreportDataset[]
}

export function SubreportLayout({ kodeMenu, subreportDatasets }: SubreportLayoutProps) {
  if (!subreportDatasets || subreportDatasets.length === 0) return null

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat('id-ID', { minimumFractionDigits: 2 }).format(val)

  return (
    <div className="mt-10 flex flex-col gap-6">
      {subreportDatasets.map(({ dataset, columns, data }) => (
        <div key={dataset.nama_dataset} className="flex flex-col">
          {/* Section label */}
          <div className="mb-3 flex items-center gap-3">
            <span className="text-xs font-semibold uppercase tracking-wider text-slate-400">
              Halaman 2 — {dataset.deskripsi || dataset.nama_dataset}
            </span>
            <div className="flex-1 h-px bg-slate-200 dark:bg-slate-700/50"></div>
          </div>

          {/* Table */}
          <div className="bg-white dark:bg-[#0f172a] rounded-2xl border border-slate-100 dark:border-white/5 shadow-sm overflow-hidden">
            <DynamicReportTable
              kodeMenu={kodeMenu}
              columns={columns}
              data={data}
              isLoading={false}
            />

            {/* Footer2: Jumlah row with SUM of each numeric column */}
            {data.length > 0 && (
              <div className="border-t-2 border-slate-300 dark:border-slate-600 bg-slate-50 dark:bg-slate-800/50 px-4 py-2">
                <div className="flex items-center">
                  <span className="text-sm font-bold text-slate-700 dark:text-slate-200 w-1/2">
                    Jumlah
                  </span>
                  <div className="flex-1 flex gap-2">
                    {columns
                      .filter(col => col.is_summable !== false && col.is_visible !== false)
                      .map((col) => {
                        const sum = data.reduce((acc, row) => {
                          const val = row[col.nama_kolom]
                          return acc + (parseFloat(String(val || '').replace(/,/g, '')) || 0)
                        }, 0)
                        return (
                          <span
                            key={col.nama_kolom}
                            className={`flex-1 text-sm font-semibold text-right pr-4 ${
                              col.alignment === 'right' || col.format_type === 'currency'
                                ? ''
                                : 'text-left'
                            }`}
                          >
                            {col.format_type === 'currency' || col.format_type === 'number'
                              ? formatCurrency(sum)
                              : sum.toLocaleString('id-ID')}
                          </span>
                        )
                      })}
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>
      ))}
    </div>
  )
}
