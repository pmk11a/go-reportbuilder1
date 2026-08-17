// Report Store - Zustand state management for reports

import { create } from 'zustand'
// @ts-ignore — zustand/middleware exports persist and createJSONStorage; keep as-is
import { persist, createJSONStorage } from 'zustand/middleware'
import type {
  IReport,
  IReportConfig,
  IReportFilterValues,
//   IQueryPreviewResult,
  IAvailableKodeMenu
} from '../types'

interface ReportState {
  // Admin state
  reports: IReport[]
  selectedReport: IReport | null
  selectedReportConfig: IReportConfig | null
  availableKodeMenu: IAvailableKodeMenu[]
  allUsers: { USERID: string; FullName: string }[]
  activeTab: 'general' | 'filters' | 'datasets' | 'columns' | 'grouping' | 'access'

  // User viewer state
  currentReport: IReportConfig | null
  /**
   * Filter values for the currently-active report, scoped by kodeMenu.
   * Shape: { _kodeMenu: string, ...filterValues: Record<name, value> }
   * The _kodeMenu marker is used to detect when the user switches reports
   * and to avoid leaking values between reports.
   */
  filterValues: IReportFilterValues & { _kodeMenu?: string }
  isExecuting: boolean
  executionError: string | null
  executionResult: Record<string, any[]> | null

  // Loading states
  isLoading: boolean
  isSaving: boolean
  error: string | null

  // Actions - Admin
  setReports: (reports: IReport[]) => void
  selectReport: (report: IReport | null) => void
  setReportConfig: (config: IReportConfig | null) => void
  setAvailableKodeMenu: (menu: IAvailableKodeMenu[]) => void
  setAllUsers: (users: { USERID: string; FullName: string }[]) => void
  setActiveTab: (tab: 'general' | 'filters' | 'datasets' | 'columns' | 'grouping' | 'access') => void

  // Actions - Admin CRUD
  addReport: (report: IReport) => void
  updateReportInList: (id: number, updates: Partial<IReport>) => void
  removeReport: (id: number) => void

  // Actions - User Viewer
  setCurrentReport: (config: IReportConfig | null) => void
  setFilterValue: (name: string, value: string | string[] | null) => void
  setFilterValues: (values: IReportFilterValues) => void
  /**
   * Populate filter values for a specific kodeMenu, preserving existing user
   * edits while filling in any missing nilai_default values.
   * Called by DynamicFilterPanel on hydration.
   */
  hydrateFilters: (kodeMenu: string, values: Record<string, string | string[] | null>) => void
  resetFilters: () => void
  setIsExecuting: (executing: boolean) => void
  setExecutionError: (error: string | null) => void
  setExecutionResult: (result: Record<string, any[]> | null) => void

  // Loading
  setIsLoading: (loading: boolean) => void
  setIsSaving: (saving: boolean) => void
  setError: (error: string | null) => void

  // Reset
  clearSelection: () => void
}

// Persisted-shape subset: only the scoped filter values are persisted
// (admin state and current report config are NOT persisted).
interface PersistedShape {
  filterValues: IReportFilterValues & { _kodeMenu?: string }
}

const PERSIST_VERSION = 1
const PERSIST_KEY = 'dapendev-reports-store'

export const useReportStore = create<ReportState>()(
  persist(
    (set) => ({
  // Initial state - Admin
  reports: [],
  selectedReport: null,
  selectedReportConfig: null,
  availableKodeMenu: [],
  allUsers: [],
  activeTab: 'general',

  // Initial state - User
  currentReport: null,
  filterValues: {},
  isExecuting: false,
  executionError: null,
  executionResult: null,

  // Initial state - Loading
  isLoading: false,
  isSaving: false,
  error: null,

  // Actions - Admin
  setReports: (reports) => set({ reports }),

  selectReport: (report) => set({
    selectedReport: report,
    selectedReportConfig: null,
    activeTab: 'general'
  }),

  setReportConfig: (config) => set({ selectedReportConfig: config }),

  setAvailableKodeMenu: (menu) => set({ availableKodeMenu: menu }),

  setAllUsers: (users) => set({ allUsers: users }),

  setActiveTab: (tab) => set({ activeTab: tab }),

  // Actions - Admin CRUD
  addReport: (report) => set((state) => ({
    reports: [...state.reports, report]
  })),

  updateReportInList: (id, updates) => set((state) => ({
    reports: state.reports.map((r) =>
      r.id_laporan === id ? { ...r, ...updates } : r
    ),
    selectedReport: state.selectedReport?.id_laporan === id
      ? { ...state.selectedReport, ...updates }
      : state.selectedReport
  })),

  removeReport: (id) => set((state) => ({
    reports: state.reports.filter((r) => r.id_laporan !== id),
    selectedReport: state.selectedReport?.id_laporan === id ? null : state.selectedReport,
    selectedReportConfig: state.selectedReport?.id_laporan === id ? null : state.selectedReportConfig
  })),

  // Actions - User Viewer
  setCurrentReport: (config) => set({
    currentReport: config,
    filterValues: {},
    executionError: null
  }),

  setFilterValue: (name, value) => set((state) => ({
    filterValues: { ...state.filterValues, [name]: value }
  })),

  setFilterValues: (values) => set({ filterValues: values }),

  hydrateFilters: (kodeMenu, values) => set((state) => {
    // If the persisted filterValues are for a different report, replace.
    // Otherwise merge: keep user edits, fill in missing values.
    const currentScope = state.filterValues._kodeMenu
    if (currentScope !== kodeMenu) {
      return { filterValues: { _kodeMenu: kodeMenu, ...values } }
    }
    const merged: Record<string, any> = { _kodeMenu: kodeMenu }
    for (const k of Object.keys(values)) {
      const existing = (state.filterValues as any)[k]
      // Only fill in if the existing value is missing/empty
      if (existing === undefined || existing === null || existing === '') {
        merged[k] = values[k]
      } else {
        merged[k] = existing
      }
    }
    return { filterValues: merged }
  }),

  resetFilters: () => set({ filterValues: {} }),

  setIsExecuting: (executing) => set({ isExecuting: executing }),

  setExecutionError: (error) => set({ executionError: error }),

  setExecutionResult: (result) => set({ executionResult: result }),

  // Loading
  setIsLoading: (loading) => set({ isLoading: loading }),

  setIsSaving: (saving) => set({ isSaving: saving }),

  setError: (error) => set({ error }),

  // Reset
  clearSelection: () => set({
    selectedReport: null,
    selectedReportConfig: null,
    currentReport: null,
    filterValues: {},
    isExecuting: false,
    executionError: null,
    error: null
  })
    }),
    {
      name: PERSIST_KEY,
      version: PERSIST_VERSION,
      storage: createJSONStorage(() => (typeof window !== 'undefined' ? localStorage : (undefined as unknown as Storage))),
      // Only persist filterValues (scoped per kodeMenu). Admin state stays in-memory.
      partialize: (state) => ({ filterValues: state.filterValues }) as PersistedShape as any,
      // Skip hydration on server (SSR-safe); UI rehydrates on mount via DynamicFilterPanel effect.
      skipHydration: true,
    }
  )
)

// Selector helpers
export const selectFilters = (state: ReportState) =>
  state.selectedReportConfig?.filters || []

export const selectDatasets = (state: ReportState) =>
  state.selectedReportConfig?.datasets || []

export const selectColumns = (state: ReportState) =>
  state.selectedReportConfig?.columns || {}

export const selectGroups = (state: ReportState) =>
  state.selectedReportConfig?.groups || []
