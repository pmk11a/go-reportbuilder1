/**
 * Export helpers for PDF, Excel, and Print — TASK-027b AC3.4-3.11.
 *
 * Provides:
 *   - formatCell(value, formatType): format a cell value for export
 *   - getPaperSize(paperSize, orientation): dimensions in mm for jsPDF
 *   - buildColumnHeaders(columns): headers array for tables
 *   - buildColumnRows(data, columns): rows array for tables
 *   - buildFooterText(config): footer text with substitutions
 */

import type { IReportColumn } from '../types'

// ============================================================
// Cell Formatting
// ============================================================

const CURRENCY_LOCALE = 'id-ID'

export function formatCell(value: any, formatType: IReportColumn['format_type']): string {
  if (value === null || value === undefined) return ''

  if (formatType === 'date') {
    const d = new Date(value)
    if (isNaN(d.getTime())) return String(value)
    const dd = String(d.getDate()).padStart(2, '0')
    const mm = String(d.getMonth() + 1).padStart(2, '0')
    const yyyy = d.getFullYear()
    return `${dd}/${mm}/${yyyy}`
  }

  const num = parseFloat(String(value))
  if (isNaN(num)) return String(value)

  switch (formatType) {
    case 'currency':
      return new Intl.NumberFormat(CURRENCY_LOCALE, {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 1,
        maximumFractionDigits: 1,
      }).format(num)
    case 'number':
      return new Intl.NumberFormat(CURRENCY_LOCALE, {
        minimumFractionDigits: 1,
        maximumFractionDigits: 1,
      }).format(num)
    default:
      return String(value)
  }
}

// ============================================================
// Paper Size Configuration (mm)
// ============================================================

export const PAPER_SIZES: Record<string, { w: number; h: number }> = {
  a4:       { w: 210, h: 297 },
  a5:       { w: 148, h: 210 },
  a3:       { w: 297, h: 420 },
  letter:   { w: 216, h: 279 },
  legal:    { w: 216, h: 356 },
  tabloid:  { w: 279, h: 432 },
}

export function getPaperSize(paperSizeKey: string | null | undefined, orientation: 'portrait' | 'landscape'): { w: number; h: number } {
  const key = (paperSizeKey || 'a4').toLowerCase()
  const dim = PAPER_SIZES[key] || PAPER_SIZES.a4
  return orientation === 'landscape' ? { w: dim.h, h: dim.w } : dim
}

// ============================================================
// Table Data Helpers
// ============================================================

export function buildColumnHeaders(columns: IReportColumn[]): string[] {
  return columns.map(col => col.label_tampil || col.nama_kolom)
}

export function buildColumnRows(
  data: Record<string, any>[],
  columns: IReportColumn[]
): string[][] {
  return data.map(row =>
    columns.map(col => formatCell(row[col.nama_kolom], col.format_type))
  )
}

// ============================================================
// Footer Text Substitution
// ============================================================

const PLACEHOLDER_RE = /\{\{(\w+)\}\}/g

export function substituteFooterText(
  template: string,
  context: Record<string, string>
): string {
  return template.replace(PLACEHOLDER_RE, (_match, key) => context[key] ?? _match)
}

export function buildFooterContext(
  currentPage: number,
  totalPages: number,
  reportName: string,
  filterValues: Record<string, any>
): Record<string, string> {
  const now = new Date().toLocaleDateString('id-ID', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
  })
  return {
    page: String(currentPage),
    total: String(totalPages),
    date: now,
    report: reportName,
    ...Object.fromEntries(
      Object.entries(filterValues).map(([k, v]) => [k, String(v)])
    ),
  }
}

// ============================================================
// Print View
// ============================================================

/**
 * Open a new window for print preview.
 * The browser's print dialog is invoked via window.print().
 */
export function openPrintView(
  html: string,
  title: string,
  options?: { width?: string; height?: string }
): Window | null {
  if (!html) return null
  const w = options?.width || '1200px'
  const h = options?.height || '800px'
  const printWin = window.open('', '_blank', `width=${w},height=${h},scrollbars=yes`)
  if (!printWin) return null
  printWin.document.write(`
    <!DOCTYPE html>
    <html lang="id">
    <head>
      <meta charset="utf-8" />
      <title>${title}</title>
      <style>
        @page { size: auto; margin: 15mm; }
        body { font-family: system-ui, sans-serif; font-size: 11pt; color: #1e293b; line-height: 1.5; padding: 0; margin: 0; }
        @media print { body { padding: 0; } }
      </style>
    </head>
    <body>${html}</body>
    </html>
  `)
  printWin.document.close()
  setTimeout(() => printWin.print(), 300)
  return printWin
}
