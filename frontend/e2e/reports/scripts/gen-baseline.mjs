/**
 * Generate the baseline parity report from parity-expected.json.
 * This is a static renderer that produces tmp/latest/report-parity-baseline.md
 * without needing a running server.
 *
 * Run: node frontend/e2e/reports/scripts/gen-baseline.mjs
 */
import { readFileSync, mkdirSync, writeFileSync } from 'node:fs'
import { join } from 'node:path'
import { fileURLToPath } from 'node:url'

const __dirname = fileURLToPath(new URL('.', import.meta.url))
const fixture = JSON.parse(readFileSync(join(__dirname, '..', 'fixtures', 'parity-expected.json'), 'utf-8'))
const reports = fixture.reports

const GAP = {
  filtersBroken: 10,
  titleSubstitution: 1,
  pagefooterMissing: 11,
  runningBalance: 1,
  perRowComputed: 8,
  groupAutoSum: 3,
  filterUnsorted: 11,
  filterValuesNotPersisted: 11,
  konfigurasiOptionsUnused: 10,
  signaturesTitleMissing: 11,
}

const lines = []
lines.push('# Report Parity — Baseline (TASK-027a Phase 0)')
lines.push('')
lines.push(`Generated: ${new Date().toISOString()}`)
lines.push('')
lines.push('## Baseline score per report')
lines.push('')
lines.push('| ID | KODEMENU | Report | filters | title | header | footer | columns | computed | subtotal | signatures | **Score** |')
lines.push('|----|----------|--------|---------|-------|--------|--------|---------|----------|----------|------------|-----------|')

for (const r of reports) {
  const filterCount = r.filters.length
  const dropdownCount = r.filters.filter((f) => f.tipe_input === 'dropdown').length
  const noGroup = r.groups.length === 0
  const noComputed = Object.keys(r.per_row_computed).length === 0

  // Expected pass/fail for baseline:
  // filters: PASS = filters have NO dropdown (n/a), else FAIL (dropdown broken)
  // title: PASS (always)
  // header: PASS = no pageHeader, else FAIL (@param not substituted)
  // footer: FAIL (always)
  // columns: PASS (always)
  // computed: PASS = no per_row_computed (n/a), else FAIL
  // subtotal: PASS = no groups (n/a), else FAIL
  // signatures: PASS (always)
  const props = {
    filters: dropdownCount === 0 ? true : false,
    title: true,
    header: r.pageHeader === null ? true : false,
    footer: false,
    columns: true,
    computed: noComputed ? true : false,
    subtotal: noGroup ? true : false,
    signatures: true,
  }
  const passCount = Object.values(props).filter(Boolean).length
  const total = Object.keys(props).length
  const score = Math.round((passCount / total) * 100)

  const cell = (id) => {
    if (id === 'footer') return props[id] ? '✅' : '❌'
    if (id === 'computed') return props[id] ? 'n/a' : props[id] ? '✅' : '❌'
    if (id === 'subtotal') return props[id] ? 'n/a' : props[id] ? '✅' : '❌'
    return props[id] ? '✅' : '❌'
  }

  lines.push(
    `| ${r.id_laporan} | ${r.kodeMenu} | ${r.nama_laporan} | ${cell('filters')} | ${cell('title')} | ${cell('header')} | ${cell('footer')} | ${cell('columns')} | ${cell('computed')} | ${cell('subtotal')} | ${cell('signatures')} | **${score}%** |`
  )
}

lines.push('')
lines.push('## Aggregate pass count per property (across 11 reports)')
lines.push('')
for (const propId of ['filters', 'title', 'header', 'footer', 'columns', 'computed', 'subtotal', 'signatures']) {
  const passCount = reports.filter((r) => {
    if (propId === 'footer') return false
    if (propId === 'header') return r.pageHeader === null
    if (propId === 'computed') return Object.keys(r.per_row_computed).length === 0
    if (propId === 'subtotal') return r.groups.length === 0
    if (propId === 'filters') return r.filters.every((f) => f.tipe_input !== 'dropdown')
    return true
  }).length
  const marker = propId === 'filters' && passCount < 11 ? '❌ (dropdowns broken)' : ''
  lines.push(`- **${propId}**: ${passCount}/11${marker}`)
}

lines.push('')
lines.push('## Gap inventory (source: audit findings in TASK-027)')
lines.push('')
lines.push('| # | Gap | Count affected | Severity |')
lines.push('|---|-----|----------------|----------|')
lines.push(`| 1 | Dropdown filters render as text input | 10/11 | **Critical** |`)
lines.push(`| 2 | @param template substitution absent | 1/11 | High |`)
lines.push(`| 3 | No PageFooter band | 11/11 | **Critical** |`)
lines.push(`| 4 | Running balance not implemented | 1/11 | High |`)
lines.push(`| 5 | Per-row computed columns absent | 8/11 | **Critical** |`)
lines.push(`| 6 | Group subtotal auto_sum ignored | 3/11 | Medium |`)
lines.push(`| 8 | Filter posisi ordering not enforced | 11/11 | Medium |`)
lines.push(`| 9 | No konfigurasi.options for dropdowns | 10/11 | **Critical** |`)
lines.push(`| 10 | useReportStore.filterValues not persisted | 11/11 | Medium |`)
lines.push(`| 11 | Signature block lacks title field | 11/11 | Low |`)
lines.push(`| 12 | No [periode] / [param] substitution style | 1/11 | Low |`)

lines.push('')
lines.push('## Target after TASK-027a (Phase 0 + Phase 1)')
lines.push('')
lines.push('- **filters**: 11/11 (dropdowns rendered correctly with options)')
lines.push('- **title**: 11/11')
lines.push('- **header**: 1/11 (only report 100 has pageHeader with @param)')
lines.push('- **footer**: 0/11 (still Phase 2 — PageFooterBand not implemented)')
lines.push('- **columns**: 11/11')
lines.push('- **computed**: 0/11 (still Phase 3 — per_row_computed not wired)')
lines.push('- **subtotal**: 0/11 (still Phase 3 — auto_sum not wired)')
lines.push('- **signatures**: 11/11')
lines.push('')
lines.push('### Expected score after AC2 (Phase 1) completion')
lines.push('')
lines.push('| Report | filters | title | header | footer | columns | computed | subtotal | signatures | **Score** |')
lines.push('|--------|---------|-------|--------|--------|---------|----------|----------|------------|-----------|')
for (const r of reports) {
  // After AC2, expected PASS: filters, title, columns, signatures = 4 always
  // + header if pageHeader exists (1 of 11 reports)
  // + computed n/a if no per_row_computed (3 of 11: 102, 107, 108)
  // + subtotal n/a if no groups (8 of 11)
  // + footer still FAIL (Phase 2)
  // + computed FAIL if per_row_computed exists (8 of 11)
  // + subtotal FAIL if groups exist (3 of 11)
  const passCount = 4 + (r.pageHeader ? 1 : 0) + (Object.keys(r.per_row_computed).length === 0 ? 1 : 0) + (r.groups.length === 0 ? 1 : 0)
  const applicableTotal = 6 + (r.pageHeader ? 0 : 1) + (Object.keys(r.per_row_computed).length === 0 ? 0 : 1) + (r.groups.length === 0 ? 0 : 1)
  // 6 always: filters, title, footer, columns, computed(not n/a), subtotal(not n/a), signatures = 7 always
  // Wait: 8 properties total. footer always FAIL.
  // Let me re-count properly:
  // 8 total properties.
  // PASS: filters, title, columns, signatures = 4
  // header: PASS if pageHeader exists (1) else n/a (not counted in applicable)
  // footer: FAIL (always)
  // computed: PASS n/a (not counted) if no per_row_computed, else FAIL
  // subtotal: PASS n/a (not counted) if no groups, else FAIL
  // n/a counts: header (10) + computed (3) + subtotal (8) = 21 n/a
  // For report with all of (pageHeader, per_row_computed, groups) = applicable = 8 (5 PASS, 3 FAIL) = 62%
  // For report with NONE of those = applicable = 5 (4 PASS + 1 FAIL) = 80%
  const applicablePass = 4 + (r.pageHeader ? 1 : 0)
  const applicableFail = 1 // footer always
  const applicableTotal2 = applicablePass + applicableFail
  const expectedScore = Math.round((applicablePass / applicableTotal2) * 100)
  lines.push(`| ${r.id_laporan} | ✅ | ✅ | ${r.pageHeader ? '✅' : 'n/a'} | ❌ | ✅ | ${Object.keys(r.per_row_computed).length > 0 ? '❌' : 'n/a'} | ${r.groups.length > 0 ? '❌' : 'n/a'} | ✅ | **${expectedScore}%** |`)
}

lines.push('')
lines.push('## Source of truth')
lines.push('')
lines.push('- Fixture: `frontend/e2e/reports/fixtures/parity-expected.json`')
lines.push('- Audit manifest: `tmp/latest/audit-manifest.json`')
lines.push('- Full task: `tasks/TASK-027-dynamic-report-delphi-fr3-parity-phase1.md`')

const outDir = join(__dirname, '..', '..', '..', '..', 'tmp', 'latest')
mkdirSync(outDir, { recursive: true })
writeFileSync(join(outDir, 'report-parity-baseline.md'), lines.join('\n'))
console.log('Baseline written to tmp/latest/report-parity-baseline.md')
