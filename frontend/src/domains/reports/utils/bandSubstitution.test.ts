import { describe, it, expect } from 'vitest'
import { substituteTemplate, parseTitleStyle } from './bandSubstitution'

describe('substituteTemplate', () => {
  it('replaces @paramName in template', () => {
    const result = substituteTemplate('Invoice @tgl1 s/d @tgl2', { tgl1: '01/01/2024', tgl2: '31/12/2024' })
    expect(result).toBe('Invoice 01/01/2024 s/d 31/12/2024')
  })

  it('replaces [paramName] in template', () => {
    const result = substituteTemplate('Periode [tgl1] - [tgl2]', { tgl1: 'Jan 2024', tgl2: 'Des 2024' })
    expect(result).toBe('Periode Jan 2024 - Des 2024')
  })

  it('replaces @paramName and [paramName] mixed', () => {
    const result = substituteTemplate('@tgl1 s/d [tgl2]', { tgl1: 'A', tgl2: 'B' })
    expect(result).toBe('A s/d B')
  })

  it('falls back placeholder if not in filterValues', () => {
    const result = substituteTemplate('Invoice @tgl1', { other: 'val' })
    expect(result).toBe('Invoice @tgl1')
  })

  it('handles empty filterValues', () => {
    const result = substituteTemplate('Invoice @tgl1 s/d @tgl2', {})
    expect(result).toBe('Invoice @tgl1 s/d @tgl2')
  })

  it('handles null template', () => {
    expect(substituteTemplate(null, {})).toBe('')
    expect(substituteTemplate(undefined, {})).toBe('')
  })

  it('handles null/undefined value in filterValues', () => {
    const result = substituteTemplate('Invoice @tgl1', { tgl1: null })
    expect(result).toBe('Invoice @tgl1')
  })

  it('handles array value (joins as string)', () => {
    // String(['a','b']) === 'a,b' (default join)
    const result = substituteTemplate('Multi: [items]', { items: ['a', 'b'] })
    expect(result).toBe('Multi: a,b')
  })

  it('does not replace substrings (longest match first)', () => {
    const result = substituteTemplate('Invoice @tgl1 and @tgl2', { tgl1: 'A', tgl2: 'B', tgl: 'X' })
    // tgl2 > tgl1 > tgl in sort (length descending)
    expect(result).toBe('Invoice A and B')
  })
})

describe('parseTitleStyle', () => {
  it('returns defaults when config is empty', () => {
    const style = parseTitleStyle({})
    expect(style.fontSize).toBe('large')
    expect(style.fontWeight).toBe('black')
    expect(style.italic).toBe(false)
    expect(style.divider).toBe(false)
  })

  it('parses custom values', () => {
    const style = parseTitleStyle({ font_size: 'medium', font_weight: 'semibold', italic: true, divider: true })
    expect(style.fontSize).toBe('medium')
    expect(style.fontWeight).toBe('semibold')
    expect(style.italic).toBe(true)
    expect(style.divider).toBe(true)
  })
})
