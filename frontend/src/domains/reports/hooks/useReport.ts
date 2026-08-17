// Report Hooks - TanStack Query hooks for reports

import { useQuery, useMutation, useQueryClient, useInfiniteQuery } from '@tanstack/react-query'
import { reportService, reportViewerService } from '../services/reportService'
import { useReportStore } from '../stores/reportStore'
import type {
  IReportFilterValues,
  IReportColumn,
} from '../types'

// ============================================================
// ADMIN HOOKS
// ============================================================

export function useReports() {
  const setReports = useReportStore((s) => s.setReports)

  return useQuery({
    queryKey: ['admin', 'reports'],
    queryFn: async () => {
      const data = await reportService.listReports({ limit: 100 }) // Load more by default for non-infinite usage
      setReports(data.items)
      return data.items
    },
    staleTime: 30_000,
  })
}

export function useReportsInfinite(search: string = '') {
  return useInfiniteQuery({
    queryKey: ['admin', 'reports', 'infinite', search],
    queryFn: async ({ pageParam = 1 }) => {
      return await reportService.listReports({ page: pageParam, limit: 10, search })
    },
    getNextPageParam: (lastPage) => {
      const totalPages = Math.ceil(lastPage.total / lastPage.perPage)
      if (lastPage.page < totalPages) {
        return lastPage.page + 1
      }
      return undefined
    },
    initialPageParam: 1,
  })
}

export function useReport(id: number | null) {
  const setReportConfig = useReportStore((s) => s.setReportConfig)

  return useQuery({
    queryKey: ['admin', 'reports', id],
    queryFn: async () => {
      if (!id) return null
      const data = await reportService.getReport(id)
      setReportConfig(data)
      return data
    },
    enabled: Boolean(id),
    staleTime: 30_000,
  })
}

export function useAvailableKodeMenu() {
  const setAvailableKodeMenu = useReportStore((s) => s.setAvailableKodeMenu)

  return useQuery({
    queryKey: ['admin', 'reports', 'available-kodemenu'],
    queryFn: async () => {
      const data = await reportService.getAvailableKodeMenu()
      setAvailableKodeMenu(data)
      return data
    },
    staleTime: 60_000,
  })
}

export function useAllUsers() {
  const setAllUsers = useReportStore((s) => s.setAllUsers)

  return useQuery({
    queryKey: ['admin', 'reports', 'users'],
    queryFn: async () => {
      const data = await reportService.getAllUsers()
      setAllUsers(data)
      return data
    },
    staleTime: 60_000,
  })
}

// Create Report
export function useCreateReport() {
  const queryClient = useQueryClient()
  const addReport = useReportStore((s) => s.addReport)
  const setError = useReportStore((s) => s.setError)
  const setIsSaving = useReportStore((s) => s.setIsSaving)

  return useMutation({
    mutationFn: async (data: Parameters<typeof reportService.createReport>[0]) => {
      setIsSaving(true)
      return reportService.createReport(data)
    },
    onSuccess: (data) => {
      if (data) {
        addReport(data)
        queryClient.invalidateQueries({ queryKey: ['admin', 'reports'] })
      }
    },
    onError: (err) => setError((err as Error).message),
    onSettled: () => setIsSaving(false),
  })
}

// Update Report
export function useUpdateReport() {
  const queryClient = useQueryClient()
  const updateReportInList = useReportStore((s) => s.updateReportInList)
  const setError = useReportStore((s) => s.setError)
  const setIsSaving = useReportStore((s) => s.setIsSaving)

  return useMutation({
    mutationFn: async ({
      id,
      payload,
    }: {
      id: number
      payload: Parameters<typeof reportService.updateReport>[1]
    }) => {
      setIsSaving(true)
      return reportService.updateReport(id, payload)
    },
    onSuccess: (_, { id, payload }) => {
      updateReportInList(id, payload)
      queryClient.invalidateQueries({ queryKey: ['admin', 'reports', id] })
    },
    onError: (err) => setError((err as Error).message),
    onSettled: () => setIsSaving(false),
  })
}

// Delete Report
export function useDeleteReport() {
  const queryClient = useQueryClient()
  const removeReport = useReportStore((s) => s.removeReport)
  const setError = useReportStore((s) => s.setError)
  const setIsSaving = useReportStore((s) => s.setIsSaving)

  return useMutation({
    mutationFn: async (id: number) => {
      setIsSaving(true)
      return reportService.deleteReport(id)
    },
    onSuccess: (_, id) => {
      removeReport(id)
      queryClient.invalidateQueries({ queryKey: ['admin', 'reports'] })
    },
    onError: (err: Error) => setError(err.message),
    onSettled: () => setIsSaving(false),
  })
}

// Preview Dataset
export function usePreviewDataset(reportId: number | null) {
  return useMutation({
    mutationFn: async ({
      sql,
      filters,
    }: {
      sql: string
      filters?: Record<string, any>
    }) => {
      if (!reportId) throw new Error('Report ID required')
      return reportService.previewDataset(reportId, sql, filters)
    },
  })
}

// ============================================================
// USER VIEWER HOOKS
// ============================================================

export function useReportsMenu(searchQuery?: string) {
  return useQuery({
    queryKey: ['reports', 'menu', searchQuery],
    queryFn: () => reportViewerService.getReportsMenu(searchQuery),
    staleTime: 60_000,
  })
}

export function useReportConfig(kodeMenu: string | null) {
  const setCurrentReport = useReportStore((s) => s.setCurrentReport)

  return useQuery({
    queryKey: ['reports', 'config', kodeMenu],
    queryFn: async () => {
      if (!kodeMenu) return null
      const data = await reportViewerService.getReportConfig(kodeMenu)
      setCurrentReport(data)
      return data
    },
    enabled: Boolean(kodeMenu),
    staleTime: 30_000,
  })
}

export function useExecuteReport(kodeMenu: string | null) {
  const setIsExecuting = useReportStore((s) => s.setIsExecuting)
  const setExecutionError = useReportStore((s) => s.setExecutionError)
  const setExecutionResult = useReportStore((s) => s.setExecutionResult)

  return useMutation({
    mutationFn: async (filters: IReportFilterValues) => {
      if (!kodeMenu) throw new Error('Kode menu required')
      setIsExecuting(true)
      setExecutionError(null)
      const result = await reportViewerService.executeReport(kodeMenu, filters)
      // Store execution result for preview
      setExecutionResult(result?.datasets || null)
      return result
    },
    onError: (err: Error) => setExecutionError(err.message),
    onSettled: () => setIsExecuting(false),
  })
}

// ============================================================
// HELPER HOOKS
// ============================================================

// Get default filter value from report config
export function useDefaultFilterValues(filters: Parameters<typeof useReportConfig>[0] extends string ? Parameters<typeof reportViewerService.getReportConfig>[0] : never) {
  const config = useReportConfig(filters ?? null)

  return config.data?.filters?.reduce<IReportFilterValues>((acc, f) => {
    if (f.nilai_default) {
      acc[f.nama_filter] = f.nilai_default
    }
    return acc
  }, {}) ?? {}
}

// Format column value based on format type
export function useFormatColumn() {
  return (value: any, formatType: IReportColumn['format_type']): string => {
    if (value === null || value === undefined) return ''

    switch (formatType) {
      case 'date':
        try {
          const date = new Date(value)
          return date.toLocaleDateString('id-ID', {
            day: '2-digit',
            month: 'short',
            year: 'numeric',
          })
        } catch {
          return String(value)
        }

      case 'number':
        return Number(value).toLocaleString('id-ID')

      case 'currency': {
        let numVal = value
        if (typeof value === 'string') {
          numVal = value.replace(/,/g, '') // strip commas in case backend sends formatted US string
        }
        const parsed = Number(numVal)
        if (isNaN(parsed)) return String(value)

        return new Intl.NumberFormat('id-ID', {
          style: 'currency',
          currency: 'IDR',
          minimumFractionDigits: 0,
          maximumFractionDigits: 2,
        }).format(parsed)
      }

      case 'text':
      default:
        return String(value)
    }
  }
}
