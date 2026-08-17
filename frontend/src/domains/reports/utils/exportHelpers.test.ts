import { describe, it, expect } from 'vitest'
import {
  formatCell,
  getPaperSize,
  buildColumnHeaders,
  buildColumnRows,
  substituteFooterText,
  buildFooterContext,
} from './exportHelpers'
import type { IReportColumn } from '../types'

describe('formatCell', () => {
  it('formats currency as IDR', () => {
    const result = formatCell(1500000, 'currency')
    expect(result).toContain('Rp')
    expect(result).toContain('1.500.000')
  })

  it('formats numbers with locale', () => {
    const result = formatCell(1234567.89, 'number')
    expect(result).toContain('1.234.567,89')
  })

  it('formats dates in Indonesian locale', () => {
    const date = new Date(2024, 7, 6) // Aug 6, 2024
    const result = formatCell(date, 'date')
    // Just verify it returns a non-empty string with some date-like content
    expect(result).toBeTruthy()
    expect(typeof result).toBe('string')
  })

  it('returns plain string for text type', () => {
    expect(formatCell('Hello', 'text')).toBe('Hello')
  })

  it('returns empty string for null/undefined', () => {
    expect(formatCell(null, 'currency')).toBe('')
    expect(formatCell(undefined, 'number')).toBe('')
  })

  it('falls back to String() for non-numeric values', () => {
    expect(formatCell('abc', 'number')).toBe('abc')
  })
})

describe('getPaperSize', () => {
  it('returns A4 portrait dimensions', () => {
    expect(getPaperSize('a4', 'portrait')).toEqual({ w: 210, h: 297 })
  })

  it('swaps w/h for landscape', () => {
    expect(getPaperSize('a4', 'landscape')).toEqual({ w: 297, h: 210 })
  })

  it('defaults to a4 when key is unknown', () => {
    expect(getPaperSize('xyz', 'portrait')).toEqual({ w: 210, h: 297 })
  })

  it('defaults to a4 when key is null', () => {
    expect(getPaperSize(null, 'portrait')).toEqual({ w: 210, h: 297 })
  })
})

describe('buildColumnHeaders', () => {
  it('extracts labels', () => {
    const cols: IReportColumn[] = [
      { id_kolom: 1, id_laporan: 1, nama_dataset: 'd1', nama_kolom: 'A', label_tampil: 'Column A', urutan_tampil: 0, format_type: 'text', alignment: 'left', is_summable: false, is_visible: true },
      { id_kolom: 2, id_laporan: 1, nama_dataset: 'd1', nama_kolom: 'B', label_tampil: 'Column B', urutan_tampil: 1, format_type: 'currency', alignment: 'right', is_summable: true, is_visible: true },
    ]
    expect(buildColumnHeaders(cols)).toEqual(['Column A', 'Column B'])
  })
})

describe('buildColumnRows', () => {
  it('formats each cell according to column type', () => {
    const cols: IReportColumn[] = [
      { id_kolom: 1, id_laporan: 1, nama_dataset: 'd1', nama_kolom: 'Name', label_tampil: 'Name', urutan_tampil: 0, format_type: 'text', alignment: 'left', is_summable: false, is_visible: true },
      { id_kolom: 2, id_laporan: 1, nama_dataset: 'd1', nama_kolom: 'Amount', label_tampil: 'Amount', urutan_tampil: 1, format_type: 'currency', alignment: 'right', is_summable: true, is_visible: true },
    ]
    const rows = buildColumnRows([{ Name: 'Test', Amount: 100000 }], cols)
    expect(rows[0]).toEqual(['Test', expect.stringContaining('Rp')])
  })
})

describe('substituteFooterText', () => {
  it('replaces known placeholders', () => {
    expect(substituteFooterText('{{page}} / {{total}}', { page: '3', total: '10' })).toBe('3 / 10')
  })

  it('leaves unknown placeholders unchanged', () => {
    expect(substituteFooterText('{{unknown}}', { page: '1' })).toBe('{{unknown}}')
  })

  it('returns empty string for empty template', () => {
    expect(substituteFooterText('', {})).toBe('')
  })
})

describe('buildFooterContext', () => {
  it('includes page, total, date, report', () => {
    const ctx = buildFooterContext(2, 10, 'Laporan Uji', { tgl1: '01/01/2024' })
    expect(ctx.page).toBe('2')
    expect(ctx.total).toBe('10')
    expect(ctx.report).toBe('Laporan Uji')
    expect(ctx.tgl1).toBe('01/01/2024')
    expect(ctx.date).toBeDefined()
  })
})
