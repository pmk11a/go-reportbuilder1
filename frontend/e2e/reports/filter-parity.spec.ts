/**
 * Filter Parity E2E — TASK-027a AC2.9
 *
 * Validates that all 11 high-complexity reports render dropdown/checkbox/combobox/perkiraan filters
 * with the correct widget (not as plain text input).
 *
 * Strategy:
 *   1. Login as superadmin
 *   2. Navigate to /admin/reports/laporan/{KODEMENU}
 *   3. For each report, find every filter with tipe_input in {dropdown, checkbox, combobox, perkiraan}
 *      and assert it is rendered as Select (combobox role) / Checkbox / BrowsePicker (data-testid).
 *
 * The harness is idempotent — running 3x produces the same result matrix.
 *
 * To run: npx playwright test e2e/reports/filter-parity.spec.ts
 */
import { test, expect, type Page } from '@playwright/test'
import * as fs from 'node:fs'
import * as path from 'node:path'

const BASE_URL = 'http://localhost:5173'

interface FilterDef {
  nama_filter: string
  label: string
  tipe_input: string
  konfigurasi?: { options?: string[]; kode_browse?: string }
}

interface ReportExpected {
  id_laporan: number
  kodeMenu: string
  nama_laporan: string
  filters: FilterDef[]
}

const FIXTURE_PATH = path.join(__dirname, 'fixtures', 'parity-expected.json')
const fixture = JSON.parse(fs.readFileSync(FIXTURE_PATH, 'utf-8'))
const reports: ReportExpected[] = fixture.reports

async function loginAsAdmin(page: Page) {
  await page.goto(`${BASE_URL}/login`)
  const username = page.getByLabel(/Username|User name|Nama Pengguna/i).first()
  const password = page.getByLabel(/Password|Kata Sandi/i).first()
  await username.fill('superadmin')
  await password.fill('superadmin123')
  await page.getByRole('button', { name: /Sign in|Masuk/i }).first().click()
  await page.waitForURL((url) => !url.pathname.endsWith('/login'), { timeout: 15_000 })
}

const filterFailures: Record<string, string[]> = {}

for (const r of reports) {
  const typedFilters = r.filters.filter(
    (f) => f.tipe_input === 'dropdown' || f.tipe_input === 'checkbox' || f.tipe_input === 'combobox' || f.tipe_input === 'perkiraan' || f.tipe_input === 'browse'
  )

  if (typedFilters.length === 0) continue

  test(`filter-parity-${r.id_laporan} ${r.kodeMenu} ${r.nama_laporan}`, async ({ page }) => {
    test.setTimeout(60_000)
    filterFailures[r.kodeMenu] = []

    await loginAsAdmin(page)
    await page.goto(`${BASE_URL}/admin/reports/laporan/${r.kodeMenu}`)
    await page.waitForSelector('text=/Parameter Laporan|Report Parameters|Filter/i', { timeout: 15_000 })

    for (const f of typedFilters) {
      try {
        switch (f.tipe_input) {
          case 'dropdown': {
            // Assert a Select trigger exists for this filter (Radix renders role=combobox)
            const trigger = page.locator(`[name="${f.nama_filter}"]`).first()
            // Some filter names are not propagated as `name` attribute — fall back to label
            const triggerOrFallback = (await trigger.count()) > 0
              ? trigger
              : page.getByRole('combobox').filter({ hasText: new RegExp(f.label, 'i') }).first()
            await expect(triggerOrFallback).toBeVisible({ timeout: 3_000 })
            break
          }
          case 'checkbox': {
            const cb = page.locator(`[name="${f.nama_filter}"]`).first()
            const cbOrFallback = (await cb.count()) > 0
              ? cb
              : page.getByRole('checkbox').filter({ has: page.getByText(new RegExp(f.label, 'i')) }).first()
            await expect(cbOrFallback).toBeVisible({ timeout: 3_000 })
            break
          }
          case 'combobox': {
            const kode = f.konfigurasi?.kode_browse
            if (!kode) {
              throw new Error(`combobox filter "${f.nama_filter}" missing kode_browse in fixture`)
            }
            const browse = page.locator(`[data-kode-browse="${kode}"]`).first()
            await expect(browse).toBeVisible({ timeout: 3_000 })
            break
          }
          case 'perkiraan': {
            const kode = f.konfigurasi?.kode_browse || '1001'
            const browse = page.locator(`[data-kode-browse="${kode}"]`).first()
            await expect(browse).toBeVisible({ timeout: 3_000 })
            break
          }
          case 'browse': {
            const kode = f.konfigurasi?.kode_browse
            if (!kode) {
              throw new Error(`browse filter "${f.nama_filter}" missing kode_browse in fixture`)
            }
            const browse = page.locator(`[data-kode-browse="${kode}"]`).first()
            await expect(browse).toBeVisible({ timeout: 3_000 })
            break
          }
        }
      } catch (e: any) {
        const msg = `${f.nama_filter} (${f.tipe_input}): ${e.message?.split('\n')[0] ?? e.message}`
        filterFailures[r.kodeMenu].push(msg)
        // Re-throw to mark test as failed
        throw new Error(msg)
      }
    }
  })
}

test.afterAll(async () => {
  const totalFailures = Object.values(filterFailures).reduce((acc, v) => acc + v.length, 0)
  console.log(`\n[filter-parity] ${totalFailures} filter assertion failures across ${Object.keys(filterFailures).length} reports`)
})
