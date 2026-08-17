/**
 * Advanced integration tests for export helpers — TASK-027b AC3.4-3.11
 */
import { describe, it, expect } from 'vitest'
import { getPaperSize, buildColumnRows, formatCell } from './exportHelpers'
import type { IReportColumn } from '../types'

describe('Advanced: paper size for any combination', () => {
  const cases: Array<{ size: string; orient: 'portrait' | 'landscape'; expected: { w: number; h: number } }> = [
    { size: 'a3', orient: 'portrait', expected: { w: 297, h: 420 } },
    { size: 'a5', orient: 'landscape', expected: { w: 210, h: 148 } },
    { size: 'letter', orient: 'portrait', expected: { w: 216, h: 279 } },
    { size: 'legal', orient: 'landscape', expected: { w: 356, h: 216 } },
    { size: 'tabloid', orient: 'portrait', expected: { w: 279, h: 432 } },
    { size: 'A4', orient: 'landscape', expected: { w: 297, h: 210 } }, // case insensitive
  ]
  cases.forEach(({ size, orient, expected }) => {
    it(`formats ${size} ${orient}`, () => {
      expect(getPaperSize(size, orient)).toEqual(expected)
    })
  })
})

describe('Advanced: currency formatting precision', () => {
  it('rounds currencies to whole numbers', () => {
    const result = formatCell(1234567.89, 'currency')
    // Formatter uses maximumFractionDigits: 0
    expect(result).toMatch(/^Rp\s/)
    expect(result).not.toContain(',89')
  })

  it('handles zero values', () => {
    expect(formatCell(0, 'currency')).toMatch(/Rp/)
    expect(formatCell(0, 'currency')).toMatch(/0/)
  })

  it('handles negative values', () => {
    expect(formatCell(-1500, 'currency')).toMatch(/-/)
  })
})

describe('Advanced: column row construction with various types', () => {
  const cols: IReportColumn[] = [
    { id_kolom: 1, id_laporan: 1, nama_dataset: 'd', nama_kolom: 'Text', label_tampil: 'Text', urutan_tampil: 0, format_type: 'text', alignment: 'left', is_summable: false, is_visible: true },
    { id_kolom: 2, id_laporan: 1, nama_dataset: 'd', nama_kolom: 'Number', label_tampil: 'Number', urutan_tampil: 1, format_type: 'number', alignment: 'right', is_summable: true, is_visible: true },
    { id_kolom: 3, id_laporan: 1, nama_dataset: 'd', nama_kolom: 'Currency', label_tampil: 'Currency', urutan_tampil: 2, format_type: 'currency', alignment: 'right', is_summable: true, is_visible: true },
    { id_kolom: 4, id_laporan: 1, nama_dataset: 'd', nama_kolom: 'Date', label_tampil: 'Date', urutan_tampil: 3, format_type: 'date', alignment: 'center', is_summable: false, is_visible: true },
  ]

  it('formats all four types correctly', () => {
    const rows = buildColumnRows(
      [{ Text: 'Hello', Number: 1234567, Currency: 1500000, Date: new Date(2024, 7, 6) }],
      cols
    )
    expect(rows[0][0]).toBe('Hello')
    expect(rows[0][1]).toContain('1.234.567')
    expect(rows[0][2]).toContain('Rp')
    expect(rows[0][2]).toContain('1.500.000')
    expect(rows[0][3]).toBeTruthy() // Date string
  })

  it('returns empty strings for null values', () => {
    const rows = buildColumnRows(
      [{ Text: null, Number: null, Currency: null, Date: null }],
      cols
    )
    expect(rows[0]).toEqual(['', '', '', ''])
  })
})
