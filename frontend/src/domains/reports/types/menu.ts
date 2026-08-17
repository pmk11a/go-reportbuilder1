export interface IReportMenuItem {
  KODEMENU: string
  NmReport: string
  nama_laporan?: string
  L0: number
  ACCESS: string
  children: IReportMenuItem[]
}

export interface IAvailableKodeMenu {
  KODEMENU: string
  Keterangan: string
}
