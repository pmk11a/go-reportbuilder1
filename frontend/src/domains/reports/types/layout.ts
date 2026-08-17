export interface ILayoutColumn {
  text?: string
  sourceType?: 'static' | 'system' | 'database' | 'filter'
  dataset?: string // Untuk sourceType = 'database'
  field?: string   // Untuk sourceType = 'database'
  filter?: string  // Untuk sourceType = 'filter'
  title?: string 
  title2?: string
  name?: string  
  role?: string  
  role2?: string
  align?: 'left' | 'center' | 'right'
  width?: string
  colSpan?: number
  rowSpan?: number
  style?: string
}

export interface ILayoutRow {
  justifyContent?: 'flex-start' | 'center' | 'flex-end' | 'space-between' | 'space-around'
  showBorder?: boolean
  gapless?: boolean
  columns: ILayoutColumn[]
}

export interface ILayoutHeader {
  type: 'header'
  contentHtml?: string // New property for TipTap editor content
  rows?: ILayoutRow[]
}

export interface ILayoutFooter {
  type: 'footer'
  contentHtml?: string // New property for TipTap editor content
  rows?: ILayoutRow[]
}

export interface ILayoutDataColumn {
  field: string
  type?: 'field' | 'formula' | 'row_number'
  formula?: string
  align?: 'left' | 'center' | 'right'
  format?: string
  width?: string
  isHeader?: boolean
}

export interface ILayoutTable {
  title?: string
  showBorder?: boolean
  dataset: string
  style?: string
  tableLayout?: 'auto' | 'fixed'
  showGrandTotal?: boolean
  filters?: { field: string, operator: string, value: any }[]
  headerRows: ILayoutColumn[][]
  dataColumns: ILayoutDataColumn[]
  grouping?: {
    groupBy: string
    showSubtotal?: boolean
    subtotalLabel?: string
    subtotalColumns?: string[]
    hideSubtotalIfSingleGroup?: boolean
    showOnlyFirstRowPerGroup?: boolean
  }
}

export interface ILayoutBodyRow {
  type?: 'table' | 'signature' | 'layout';
  columns?: {
    width?: string; 
    colSpan?: number;
    marginTop?: string;
    align?: 'left' | 'center' | 'right';
    type?: 'table' | 'signature' | 'text';
    table?: ILayoutTable;
    signature?: ILayoutColumn;
    text?: string;
    sourceType?: string;
    dataset?: string;
    field?: string;
    filter?: string;
  }[];
  signatureRow?: ILayoutRow;
}

export interface ILayoutBody {
  type: 'body'
  rows: ILayoutBodyRow[]
}

export type ILayoutConfig = ILayoutHeader | ILayoutBody | ILayoutFooter

export interface IReportComponent {
  id_komponen: number
  id_laporan?: number
  nama_komponen: string
  konfigurasi_layout: Record<string, any>
  urutan: number
  is_active?: boolean
}
