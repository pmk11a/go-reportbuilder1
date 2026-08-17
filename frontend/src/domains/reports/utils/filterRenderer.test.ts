import { describe, it, expect } from 'vitest'
import { resolveFilterConfig, sortFiltersByPosisi, resolveInitialFilterValues } from './filterRenderer'
import type { IReportFilter } from '../types'

function makeFilter(overrides: Partial<IReportFilter>): IReportFilter {
  return {
    id_parameter: 1,
    id_laporan: 100,
    nama_filter: 'TestFilter',
    label: 'Test Filter',
    tipe_input: 'text',
    wajib_isi: false,
    nilai_default: null,
    posisi: 1,
    konfigurasi: null,
    ...overrides,
  }
}

describe('resolveFilterConfig', () => {
  it('resolves date to kind=date', () => {
    const r = resolveFilterConfig(makeFilter({ tipe_input: 'date' }))
    expect(r.kind).toBe('date')
  })

  it('resolves text to kind=text', () => {
    const r = resolveFilterConfig(makeFilter({ tipe_input: 'text' }))
    expect(r.kind).toBe('text')
  })

  it('resolves number to kind=number', () => {
    const r = resolveFilterConfig(makeFilter({ tipe_input: 'number' }))
    expect(r.kind).toBe('number')
  })

  it('resolves dropdown with options to kind=dropdown + options[]', () => {
    const r = resolveFilterConfig(
      makeFilter({
        tipe_input: 'dropdown',
        konfigurasi: { options: ['T', 'F'] },
      })
    )
    expect(r.kind).toBe('dropdown')
    expect(r.options).toEqual(['T', 'F'])
  })

  it('falls back dropdown to text + warning when options missing', () => {
    const r = resolveFilterConfig(makeFilter({ tipe_input: 'dropdown' }))
    expect(r.kind).toBe('text')
    expect(r.warnings.length).toBeGreaterThan(0)
  })

  it('resolves checkbox to kind=checkbox + default options [1,0]', () => {
    const r = resolveFilterConfig(makeFilter({ tipe_input: 'checkbox' }))
    expect(r.kind).toBe('checkbox')
    expect(r.options).toEqual(['1', '0'])
  })

  it('resolves checkbox with custom options', () => {
    const r = resolveFilterConfig(
      makeFilter({ tipe_input: 'checkbox', konfigurasi: { options: ['Yes', 'No'] } })
    )
    expect(r.kind).toBe('checkbox')
    expect(r.options).toEqual(['Yes', 'No'])
  })

  it('resolves combobox with kode_browse', () => {
    const r = resolveFilterConfig(
      makeFilter({ tipe_input: 'combobox', konfigurasi: { kode_browse: '20011' } })
    )
    expect(r.kind).toBe('combobox')
    expect(r.kodeBrowse).toBe('20011')
  })

  it('falls back combobox to text + warning when kode_browse missing', () => {
    const r = resolveFilterConfig(makeFilter({ tipe_input: 'combobox' }))
    expect(r.kind).toBe('text')
    expect(r.warnings.length).toBeGreaterThan(0)
  })

  it('resolves browse with kode_browse', () => {
    const r = resolveFilterConfig(
      makeFilter({ tipe_input: 'browse', konfigurasi: { kode_browse: '3005' } })
    )
    expect(r.kind).toBe('browse')
    expect(r.kodeBrowse).toBe('3005')
  })

  it('resolves perkiraan with default browse 1001', () => {
    const r = resolveFilterConfig(makeFilter({ tipe_input: 'perkiraan' }))
    expect(r.kind).toBe('perkiraan')
    expect(r.kodeBrowse).toBe('1001')
  })

  it('resolves perkiraan with custom kode_browse override', () => {
    const r = resolveFilterConfig(
      makeFilter({ tipe_input: 'perkiraan', konfigurasi: { kode_browse: '9999' } })
    )
    expect(r.kodeBrowse).toBe('9999')
  })

  it('falls back unknown tipe_input to text + warning', () => {
    const r = resolveFilterConfig(makeFilter({ tipe_input: 'nonsense' as any }))
    expect(r.kind).toBe('text')
    expect(r.warnings.length).toBeGreaterThan(0)
  })
})

describe('sortFiltersByPosisi', () => {
  it('sorts by posisi ASC', () => {
    const f = [
      makeFilter({ nama_filter: 'B', posisi: 3 }),
      makeFilter({ nama_filter: 'A', posisi: 1 }),
      makeFilter({ nama_filter: 'C', posisi: 2 }),
    ]
    const sorted = sortFiltersByPosisi(f)
    expect(sorted.map((x) => x.nama_filter)).toEqual(['A', 'C', 'B'])
  })

  it('does not mutate input array', () => {
    const f = [makeFilter({ nama_filter: 'B', posisi: 3 }), makeFilter({ nama_filter: 'A', posisi: 1 })]
    const original = [...f]
    sortFiltersByPosisi(f)
    expect(f).toEqual(original)
  })

  it('returns empty array when input is empty', () => {
    expect(sortFiltersByPosisi([])).toEqual([])
  })
})

describe('resolveInitialFilterValues', () => {
  it('populates nilai_default for each filter', () => {
    const f = [
      makeFilter({ nama_filter: 'a', nilai_default: 'X' }),
      makeFilter({ nama_filter: 'b', nilai_default: 'Y' }),
      makeFilter({ nama_filter: 'c', nilai_default: null }),
    ]
    const r = resolveInitialFilterValues(f)
    expect(r).toEqual({ a: 'X', b: 'Y' })
  })

  it('preserves existing values, fills missing only', () => {
    const f = [
      makeFilter({ nama_filter: 'a', nilai_default: 'X' }),
      makeFilter({ nama_filter: 'b', nilai_default: 'Y' }),
    ]
    const r = resolveInitialFilterValues(f, { a: 'keep' })
    expect(r).toEqual({ a: 'keep', b: 'Y' })
  })

  it('skips empty string as existing value', () => {
    const f = [makeFilter({ nama_filter: 'a', nilai_default: 'X' })]
    const r = resolveInitialFilterValues(f, { a: '' })
    expect(r).toEqual({ a: 'X' })
  })
})
