// Reports Catalog Page - User accessible reports

import { createFileRoute } from '@tanstack/react-router'
import { useReportsMenu } from '@/domains/reports/hooks/useReport'
import { Skeleton } from '@/shared/ui'
import { FileText } from 'lucide-react'

export const Route = createFileRoute('/karyawan/_layout/berkas/laporan-dinamis/')({
  head: () => ({
    meta: [
      { title: 'Reports - DAPEN' },
    ],
  }),
  component: ReportsPage,
})

function ReportsPage() {
  const { data: menuItems, isLoading } = useReportsMenu()

  if (isLoading) {
    return (
      <div className="p-6 space-y-4">
        <Skeleton className="h-8 w-64" />
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {Array.from({ length: 6 }).map((_, i) => (
            <Skeleton key={i} className="h-32 w-full" />
          ))}
        </div>
      </div>
    )
  }

  // Build flat list from hierarchical menu
  const reports = flattenMenu(menuItems || [])

  return (
    <div className="p-6 space-y-6">
      <div>
        <h1 className="text-2xl font-semibold">Reports</h1>
        <p className="text-sm text-muted-foreground mt-1">
          Browse and generate dynamic reports
        </p>
      </div>

      {reports.length === 0 ? (
        <div className="text-center py-12 text-muted-foreground">
          <FileText className="h-12 w-12 mx-auto mb-4 opacity-50" />
          <p>No reports available for your account.</p>
        </div>
      ) : (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {reports.map((report) => (
            <ReportCard key={report.KODEMENU} report={report} />
          ))}
        </div>
      )}
    </div>
  )
}

interface ReportMenuItem {
  KODEMENU: string
  NmReport: string
  L0: number
  ACCESS: string
  children: ReportMenuItem[]
}

function flattenMenu(items: ReportMenuItem[]): ReportMenuItem[] {
  const result: ReportMenuItem[] = []
  for (const item of items) {
    if (item.children?.length) {
      result.push(...flattenMenu(item.children))
    } else {
      result.push(item)
    }
  }
  return result
}

function ReportCard({ report }: { report: ReportMenuItem }) {
  return (
    <a
      href={`/karyawan/berkas/laporan-dinamis/${report.KODEMENU}`}
      className="block p-4 bg-card border rounded-lg hover:border-primary hover:shadow-md transition-colors"
    >
      <div className="flex items-start gap-3">
        <div className="p-2 bg-primary/10 rounded-lg">
          <FileText className="h-5 w-5 text-primary" />
        </div>
        <div className="flex-1 min-w-0">
          <h3 className="font-medium truncate">{(report as any).nama_laporan || report.NmReport}</h3>
          <p className="text-sm text-muted-foreground mt-1">
            {report.KODEMENU}
          </p>
        </div>
      </div>
    </a>
  )
}
