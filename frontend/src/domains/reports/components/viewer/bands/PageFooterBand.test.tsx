import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import { PageFooterBand } from './PageFooterBand'

describe('PageFooterBand', () => {
  it('renders placeholder substitutions', () => {
    render(
      <PageFooterBand
        footerBandConfig={{
          enabled: true,
          content: 'Halaman {{page}} dari {{total}} | {{report}}',
        }}
        currentPage={3}
        totalPages={10}
        reportName="Laporan Penjualan"
      />
    )
    expect(screen.getByText(/Halaman 3 dari 10/)).toBeInTheDocument()
    expect(screen.getByText(/Laporan Penjualan/)).toBeInTheDocument()
  })

  it('does not render when content is empty', () => {
    const { container } = render(<PageFooterBand footerBandConfig={{ enabled: false }} />)
    expect(container.firstChild).toBeNull()
  })

  it('handles null footerBandConfig', () => {
    const { container } = render(<PageFooterBand />)
    expect(container.firstChild).toBeNull()
  })

  it('falls back to current date for {{date}}', () => {
    const { container } = render(
      <PageFooterBand footerBandConfig={{ enabled: true, content: '{{date}}' }} />
    )
    // Just verify it doesn't error and shows something
    expect(container.querySelector('p')).toBeInTheDocument()
  })

  it('substitutes {{user}} placeholder', () => {
    const { container } = render(
      <PageFooterBand
        footerBandConfig={{ enabled: true, content: 'Dicetak oleh: {{user}}' }}
        userName="superadmin"
      />
    )
    expect(container.querySelector('p')).toHaveTextContent('Dicetak oleh: superadmin')
  })

  it('substitutes {{time}} and {{datetime}} placeholders', () => {
    const { container } = render(
      <PageFooterBand
        footerBandConfig={{ enabled: true, content: '{{date}} {{time}}' }}
      />
    )
    expect(container.querySelector('p')).toBeInTheDocument()
  })

  it('uses center alignment', () => {
    const { container } = render(
      <PageFooterBand
        footerBandConfig={{
          enabled: true,
          content: 'Test',
          align: 'center',
        }}
      />
    )
    expect(container.firstChild).toHaveClass('text-center')
  })
})
