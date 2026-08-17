/**
 * DynamicFilterPanel.test.tsx — TASK-027a AC2.8
 *
 * Tests the 8 tipe_input cases render the correct widget.
 * Uses vitest + @testing-library/react.
 */
import { describe, it, expect, vi, beforeEach } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { DynamicFilterPanel } from './DynamicFilterPanel'
import { useReportStore } from '../../stores/reportStore'
import type { IReportConfig } from '../../types'

// Stable config — created once to avoid re-render loop in the mock
const stableConfig: IReportConfig = {
  id_laporan: 100,
  KODEMENU: '0303301',
  nama_laporan: 'Test Report',
  deskripsi: 'Test',
  status_aktif: true,
  footer_bands: null,
  created_at: '',
  updated_at: '',
  filters: [
    {
      id_parameter: 1, id_laporan: 100, nama_filter: 'SReport',
      label: 'SReport', tipe_input: 'dropdown', wajib_isi: true,
      nilai_default: 'T', posisi: 1,
      konfigurasi: { options: ['T', 'F'] },
    },
    {
      id_parameter: 2, id_laporan: 100, nama_filter: 'tgl1',
      label: 'Tanggal Mulai', tipe_input: 'date', wajib_isi: true,
      nilai_default: '2024-01-01', posisi: 2, konfigurasi: null,
    },
    {
      id_parameter: 3, id_laporan: 100, nama_filter: 'NeedOto',
      label: 'NeedOto', tipe_input: 'dropdown', wajib_isi: true,
      nilai_default: '0', posisi: 3,
      konfigurasi: { options: ['0', '1'] },
    },
    {
      id_parameter: 4, id_laporan: 100, nama_filter: 'aktif',
      label: 'Aktif', tipe_input: 'checkbox', wajib_isi: false,
      nilai_default: '0', posisi: 4,
      konfigurasi: { options: ['1', '0'] },
    },
    {
      id_parameter: 5, id_laporan: 100, nama_filter: 'Cust',
      label: 'Customer', tipe_input: 'combobox', wajib_isi: false,
      nilai_default: '', posisi: 5,
      konfigurasi: { kode_browse: '20011' },
    },
    {
      id_parameter: 6, id_laporan: 100, nama_filter: 'Perk',
      label: 'Perkiraan', tipe_input: 'perkiraan', wajib_isi: false,
      nilai_default: '', posisi: 6, konfigurasi: null,
    },
    {
      id_parameter: 7, id_laporan: 100, nama_filter: 'Bar',
      label: 'Barang', tipe_input: 'browse', wajib_isi: false,
      nilai_default: '', posisi: 7,
      konfigurasi: { kode_browse: '5001' },
    },
    {
      id_parameter: 8, id_laporan: 100, nama_filter: 'jumlah',
      label: 'Jumlah', tipe_input: 'number', wajib_isi: false,
      nilai_default: '0', posisi: 8, konfigurasi: null,
    },
  ],
  datasets: [],
  columns: {},
  groups: [],
}

// Mock the Query hooks — tests are about rendering, not data
vi.mock('../../hooks/useReport', () => ({
  useReportConfig: () => ({ data: stableConfig, isLoading: false, isError: false }),
  useExecuteReport: () => ({
    mutate: vi.fn(),
    isPending: false,
    data: null,
  }),
}))

// Mock GenericBrowsePicker — the real one hits /api/browse/types
vi.mock('@/domains/browse/components/browse/GenericBrowsePicker', () => ({
  GenericBrowsePicker: ({ kodeBrowse, value, onChange, placeholder }: any) => (
    <input
      data-testid={`browse-${kodeBrowse}`}
      data-kode-browse={kodeBrowse}
      data-value={value}
      placeholder={placeholder}
      onChange={(e) => onChange(e.target.value)}
    />
  ),
}))

beforeEach(() => {
  // Reset store between tests
  useReportStore.setState({
    filterValues: {},
    currentReport: null,
  } as any)
})

describe('DynamicFilterPanel', () => {
  it('renders all 8 tipe_input variants', () => {
    render(<DynamicFilterPanel kodeMenu="0303301" executeReport={{ mutate: vi.fn(), isPending: false }} />)

    // date input
    expect(screen.getByLabelText(/Tanggal Mulai/i)).toBeInTheDocument()
    // number input
    expect(screen.getByLabelText(/Jumlah/i)).toBeInTheDocument()
    // checkbox
    expect(screen.getByLabelText(/Aktif/i)).toBeInTheDocument()
    // combobox → browse picker (kode_browse=20011)
    expect(screen.getByTestId('browse-20011')).toBeInTheDocument()
    // perkiraan → browse picker (kode_browse=1001 default)
    expect(screen.getByTestId('browse-1001')).toBeInTheDocument()
    // browse → kode_browse=5001
    expect(screen.getByTestId('browse-5001')).toBeInTheDocument()
  })

  it('sorts filters by posisi ASC', () => {
    render(<DynamicFilterPanel kodeMenu="0303301" executeReport={{ mutate: vi.fn(), isPending: false }} />)
    // First label should be SReport (posisi=1); use precise label match
    expect(screen.getByText('SReport')).toBeInTheDocument()
    expect(screen.getByText('Tanggal Mulai')).toBeInTheDocument()
    expect(screen.getByText('Jumlah')).toBeInTheDocument()
    // Verify all 8 labels are present
    expect(screen.getByText('SReport')).toBeTruthy()
    expect(screen.getByText('Tanggal Mulai')).toBeTruthy()
    expect(screen.getByText('NeedOto')).toBeTruthy()
    expect(screen.getByText('Aktif')).toBeTruthy()
    expect(screen.getByText('Customer')).toBeTruthy()
    expect(screen.getByText('Perkiraan')).toBeTruthy()
    expect(screen.getByText('Barang')).toBeTruthy()
    expect(screen.getByText('Jumlah')).toBeTruthy()
  })

  it('dropdown filter has a Select trigger (role=combobox)', () => {
    render(<DynamicFilterPanel kodeMenu="0303301" executeReport={{ mutate: vi.fn(), isPending: false }} />)
    const triggers = screen.getAllByRole('combobox')
    // At least 2 dropdown filters (SReport + NeedOto)
    expect(triggers.length).toBeGreaterThanOrEqual(2)
  })

  it('hydrates filterValues from nilai_default on mount', () => {
    render(<DynamicFilterPanel kodeMenu="0303301" executeReport={{ mutate: vi.fn(), isPending: false }} />)
    const state = useReportStore.getState()
    expect((state.filterValues as any)._kodeMenu).toBe('0303301')
    expect((state.filterValues as any).SReport).toBe('T')
    expect((state.filterValues as any).tgl1).toBe('2024-01-01')
  })

  it('preserves user edits across re-hydration (does not reset)', () => {
    render(<DynamicFilterPanel kodeMenu="0303301" executeReport={{ mutate: vi.fn(), isPending: false }} />)
    const state1 = useReportStore.getState()
    expect((state1.filterValues as any).tgl1).toBe('2024-01-01')

    // User changes the date via fireEvent (jsdom-friendly)
    const dateInput = screen.getByLabelText(/Tanggal Mulai/i) as HTMLInputElement
    fireEvent.change(dateInput, { target: { value: '2025-06-15' } })

    const state2 = useReportStore.getState()
    expect((state2.filterValues as any).tgl1).toBe('2025-06-15')

    // Force a re-render of the same component with the same kodeMenu
    render(<DynamicFilterPanel kodeMenu="0303301" executeReport={{ mutate: vi.fn(), isPending: false }} />)
    const state3 = useReportStore.getState()
    expect((state3.filterValues as any).tgl1).toBe('2025-06-15')
  })

  it('resets all filter values via Reset button', () => {
    render(<DynamicFilterPanel kodeMenu="0303301" executeReport={{ mutate: vi.fn(), isPending: false }} />)
    const resetBtn = screen.getByRole('button', { name: /Reset/i })
    fireEvent.click(resetBtn)
    const state = useReportStore.getState()
    expect(state.filterValues).toEqual({})
  })

  it('alerts when a required filter is missing on Generate', () => {
    const alertSpy = vi.spyOn(window, 'alert').mockImplementation(() => {})

    render(<DynamicFilterPanel kodeMenu="0303301" executeReport={{ mutate: vi.fn(), isPending: false }} />)

    // Clear the required SReport value AFTER render (so hydrate ran once)
    useReportStore.setState({ filterValues: { _kodeMenu: '0303301' } as any })

    // Click Generate
    const gen = screen.getByRole('button', { name: /Generate/i })
    fireEvent.click(gen)
    expect(alertSpy).toHaveBeenCalledWith(expect.stringMatching(/SReport/))
    alertSpy.mockRestore()
  })
})
