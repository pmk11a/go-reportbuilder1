import { useState } from 'react'
import { FileText, Settings, Trash2 } from 'lucide-react'
import { Button } from '@/shared/ui'
import type { IReportConfig } from '@/domains/reports/types'
import { useDeleteReport } from '@/domains/reports/hooks/useReport'
import { ReportFormModal } from '../modals/ReportFormModal'
import { useToast } from '@/shared/hooks/use-toast'

export function TabUmum({ report, isDark }: { report: IReportConfig; isDark: boolean }) {
  const [isEditModalOpen, setIsEditModalOpen] = useState(false)
  const deleteReport = useDeleteReport()
  const { toast } = useToast()

  const handleDelete = () => {
    if (confirm('Apakah Anda yakin ingin menghapus laporan ini?')) {
      deleteReport.mutate(report.id_laporan, {
        onSuccess: () => {
          toast({ title: 'Laporan berhasil dihapus', variant: 'success' })
        },
      })
    }
  }

  const cardClass = isDark ? 'bg-slate-800/50 border-slate-700' : 'bg-slate-50 border-slate-100'

  return (
    <>
      <div className="p-6 border-b border-slate-100 dark:border-slate-800">
        <div className="flex items-start justify-between gap-4">
          <div>
            <h2 className={`text-xl font-bold flex items-center gap-2 ${isDark ? 'text-white' : 'text-slate-800'}`}>
              <FileText size={20} className={isDark ? 'text-primary-400' : 'text-primary-600'} />
              {report.nama_laporan}
            </h2>
            <p className={`text-sm mt-2 ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>
              {report.deskripsi}
            </p>
          </div>
          <div className="flex gap-2">
            <Button variant="outline" size="sm" onClick={() => setIsEditModalOpen(true)}>
              <Settings className="h-4 w-4 mr-1" />
              Edit
            </Button>
            <Button variant="destructive" size="sm" onClick={handleDelete} loading={deleteReport.isPending}>
              <Trash2 className="h-4 w-4 mr-1" />
              Hapus
            </Button>
          </div>
        </div>
      </div>

      <div className="p-6">
        <div className={`space-y-3 p-4 rounded-xl border ${cardClass}`}>
          <DetailRow label="Nama Laporan" value={report.nama_laporan} isDark={isDark} />
          <DetailRow label="Kode Menu" value={report.KODEMENU} isDark={isDark} mono />
          <DetailRow label="Deskripsi" value={report.deskripsi || '—'} isDark={isDark} />
          <DetailRow label="Status" value={report.status_aktif ? 'Aktif' : 'Nonaktif'} isDark={isDark} />
        </div>
      </div>

      <ReportFormModal 
        isOpen={isEditModalOpen} 
        onClose={() => setIsEditModalOpen(false)} 
        report={report} 
      />
    </>
  )
}

function DetailRow({ label, value, isDark, mono }: { label: string; value: string | null | undefined; isDark: boolean; mono?: boolean }) {
  return (
    <div className="grid grid-cols-3 gap-4">
      <span className={`text-sm ${isDark ? 'text-slate-400' : 'text-slate-500'}`}>{label}</span>
      <span className={`col-span-2 text-sm ${mono ? 'font-mono' : ''} ${isDark ? 'text-slate-200' : 'text-slate-700'}`}>
        {value || '—'}
      </span>
    </div>
  )
}
