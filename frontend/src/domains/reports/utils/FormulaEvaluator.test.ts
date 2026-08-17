import { describe, it, expect } from 'vitest'
import {
  evalT1Expression,
  computeT1SummaryData,
  computePerRowComputed,
  applyRunningBalance,
} from './FormulaEvaluator'

describe('evalT1Expression', () => {
  it('evaluates simple numeric expression', () => {
    const result = evalT1Expression('5 + 3', {}, { t1: {}, t1Sums: {}, t2Sums: {} })
    expect(result).toBe(8)
  })

  it('resolves t1 field by name', () => {
    const result = evalT1Expression('Debet', {}, {
      t1: { Debet: 100 },
      t1Sums: {},
      t2Sums: {},
    })
    expect(result).toBe(100)
  })

  it('resolves sum(t2Field)', () => {
    const result = evalT1Expression('sum(Jumlah)', { Jumlah: 'sum:t2' }, {
      t1: {},
      t1Sums: {},
      t2Sums: { Jumlah: 250 },
    })
    expect(result).toBe(250)
  })

  it('handles compound expression', () => {
    const result = evalT1Expression('sum(Debet) - sum(Kredit)', {
      Debet: 'sum:t2',
      Kredit: 'sum:t2',
    }, {
      t1: {},
      t1Sums: {},
      t2Sums: { Debet: 1000, Kredit: 400 },
    })
    expect(result).toBe(600)
  })

  it('returns 0 for unknown token (legacy behavior)', () => {
    const result = evalT1Expression('Unknown + 5', {}, { t1: {}, t1Sums: {}, t2Sums: {} })
    expect(result).toBe(5)
  })

  it('rejects invalid characters', () => {
    expect(() =>
      evalT1Expression('bad();var x=1', {}, { t1: {}, t1Sums: {}, t2Sums: {} })
    ).toThrow()
  })
})

describe('computePerRowComputed', () => {
  it('computes per-row from current row + sum of column', () => {
    const rows = [
      { Nama: 'A', Debet: 100, Kredit: 50 },
      { Nama: 'B', Debet: 200, Kredit: 80 },
    ]
    const rules = {
      Net: { expression: 'Debet - Kredit', operands: {} },
      PctOfTotal: { expression: 'Debet / sum(Debet) * 100', operands: { sum: 'sum:t2' as any } },
    }
    const out = computePerRowComputed(rows, rules)
    expect(out[0].Net).toBe(50)
    expect(out[1].Net).toBe(120)
    expect(out[0].PctOfTotal).toBeCloseTo(33.33, 1)
    expect(out[1].PctOfTotal).toBeCloseTo(66.67, 1)
  })

  it('handles empty rows', () => {
    expect(computePerRowComputed([], { X: { expression: 'A', operands: {} } })).toEqual([])
  })

  it('handles empty rules', () => {
    const rows = [{ A: 1 }]
    expect(computePerRowComputed(rows, {})).toEqual([{ A: 1 }])
  })

  it('does not mutate input', () => {
    const rows = [{ X: 1 }]
    const out = computePerRowComputed(rows, { Y: { expression: 'X * 2', operands: {} } })
    expect(rows[0]).not.toHaveProperty('Y')
    expect(out[0].Y).toBe(2)
  })

  it('resolves t1 context for per-row expressions', () => {
    const rows = [{ X: 10 }, { X: 20 }]
    const out = computePerRowComputed(
      rows,
      { Ratio: { expression: 'X / t1Total', operands: {} } },
      { t1Total: 100 }
    )
    expect(out[0].Ratio).toBeCloseTo(0.1)
    expect(out[1].Ratio).toBeCloseTo(0.2)
  })
})

describe('applyRunningBalance', () => {
  it('accumulates delta across rows starting from opening', () => {
    // Each row: balance[i] = opening[i] + delta[i] for row 0; balance[i] = balance[i-1] + delta[i] afterwards
    // Row 0: 1000 + 200 = 1200
    // Row 1: 1200 + (-100) = 1100
    // Row 2: 1100 + 300 = 1400
    const rows = [
      { SaldoAwal: 1000, Mutasi: 200 },
      { SaldoAwal: 0, Mutasi: -100 },
      { SaldoAwal: 0, Mutasi: 300 },
    ]
    const out = applyRunningBalance(rows, { saldo: { opening: 'SaldoAwal', delta: 'Mutasi' } }, 'Saldo')
    expect(out[0].Saldo).toBe(1200)
    expect(out[1].Saldo).toBe(1100)
    expect(out[2].Saldo).toBe(1400)
  })

  it('handles debetCredit mode (object delta)', () => {
    const rows = [
      { SaldoAwal: 0, Pergerakan: { debet: 500, kredit: 200 } },
      { SaldoAwal: 0, Pergerakan: { debet: 0, kredit: 100 } },
    ]
    const out = applyRunningBalance(
      rows,
      { sal: { delta: 'Pergerakan', debetCredit: true } },
      'Balance'
    )
    expect(out[0].Balance).toBe(300)
    expect(out[1].Balance).toBe(200)
  })

  it('handles empty rows', () => {
    expect(applyRunningBalance([], { x: { delta: 'd' } })).toEqual([])
  })

  it('default opening field is SaldoAwal', () => {
    // Row 0: 100 + 50 = 150
    // Row 1: 150 + (-25) = 125
    const rows = [{ SaldoAwal: 100, D: 50 }, { SaldoAwal: 0, D: -25 }]
    const out = applyRunningBalance(rows, { b: { delta: 'D' } })
    expect(out[0].Saldo).toBe(150)
    expect(out[1].Saldo).toBe(125)
  })

  it('does not mutate input rows', () => {
    const rows = [{ SaldoAwal: 100, M: 50 }]
    const out = applyRunningBalance(rows, { b: { delta: 'M' } })
    expect(rows[0]).not.toHaveProperty('Saldo')
    // Row 0: 100 + 50 = 150
    expect(out[0].Saldo).toBe(150)
  })
})

describe('computeT1SummaryData', () => {
  it('computes t2 sum fields', () => {
    const t1 = [{ HeaderA: 'val' }]
    const t2 = [{ X: 10 }, { X: 20 }, { X: 30 }]
    const out = computeT1SummaryData('h', { t2_sum_fields: ['X'] }, { h: t1, d: t2 }, ['d'])
    expect(out?.sumX).toBe(60)
  })

  it('applies computed rules (legacy string format)', () => {
    const t1 = [{ A: 'x' }]
    const t2 = [{ X: 10 }, { X: 20 }]
    const out = computeT1SummaryData(
      'h',
      { t2_sum_fields: ['X'], computed: { Result: 'sum(X) * 2' as any } },
      { h: t1, d: t2 },
      ['d']
    )
    expect(out?.Result).toBe(60)
  })

  it('returns null if no t1 data', () => {
    expect(computeT1SummaryData('h', {}, { h: [] }, [])).toBe(null)
  })
})