import type { IReportFilter } from './filter';
import type { IReportDataset } from './dataset';
import type { IReportColumn } from './column';
import type { IReportGroup } from './group';
import type { IReportComponent } from './layout';

export interface IPaperConfig {
  size: 'A4' | 'F4' | 'Letter' | 'Legal';
  orientation: 'portrait' | 'landscape';
  margin: {
    top: string;
    right: string;
    bottom: string;
    left: string;
  };
}

export interface IReport {
  id_laporan: number
  KODEMENU: string
  nama_laporan: string
  deskripsi: string | null
  status_aktif: boolean
  footer_bands: Record<string, any> | null
  created_at: string
  updated_at: string
  Keterangan?: string | null
  L0?: number | null
  icon?: string | null
}

export interface IPreFetchQuery {
  id: string
  name: string
  query: string
}

export interface IReportConfig extends IReport {
  filters: IReportFilter[]
  datasets: IReportDataset[]
  columns: Record<string, IReportColumn[]>
  groups: IReportGroup[]
  komponen?: IReportComponent[]
  preFetchQueries?: IPreFetchQuery[]
  paperConfig?: IPaperConfig
}
