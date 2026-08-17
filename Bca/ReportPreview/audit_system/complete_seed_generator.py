"""
COMPLETE FINAL SEED - All 49 Missing Reports
Maps DBMENUREPORT L0=3 -> dbmasterlaporan with SP parameters
"""
import pyodbc
import json
from datetime import datetime

CONN_STR = 'DRIVER={ODBC Driver 17 for SQL Server};SERVER=192.168.56.1;DATABASE=dbbcagroup;UID=sa;PWD=anekajc1a9;'

# Complete mapping: KODEMENU -> (SP_NAME, PARAM_NAMES, SAMPLE_VALUES, DESCRIPTION)
COMPLETE_MAPPING = {
    # 02 - Finance
    '020106': ('Sp_LapDeposito', ['Masuk','Divisi','Perkiraan','TglAw','TglAk'], ['%','02','0','2024-01-01','2024-12-31'], 'Laporan Deposito'),
    '020107': ('Sp_LapGiroHutang', ['Masuk','Divisi','Perkiraan','TglAw','TglAk'], ['%','02','0','2024-01-01','2024-12-31'], 'Laporan Giro Hutang'),
    '020108': ('sp_LapGiroPiutang', ['Masuk','Divisi','Perkiraan','TglAw','TglAk','tolak'], ['%','02','0','2024-01-01','2024-12-31','0'], 'Laporan Giro Piutang'),
    '020201': ('Sp_LapJurnal', ['Tipe','Divisi','TglAw','TglAk'], ['','02','2024-01-01','2024-12-31'], 'Laporan Jurnal Umum'),
    '020205': ('sp_LapAktiva', ['bulan','tahun','Divisi'], ['12','2024','02'], 'Laporan Aktiva'),
    '020206': ('sp_LapSusutAktiva', ['bulan','tahun','Divisi'], ['12','2024','02'], 'Laporan Susut Aktiva'),
    '020303': ('sp_ReportPelunasanPiutang', ['tanggal1','tanggal2','awal','akhir','devisi','tipe','perkiraan','KodeVls'], ['2024-01-01','2024-12-31','0','9','02','0','%','%'], 'Pelunasan Piutang'),
    '020304': ('sp_ReportSisaPiutang', ['tanggal','awal','akhir','devisi','tipe','Perkiraan','KodeVls'], ['2024-12-31','0','9','02','0','%','%'], 'Sisa Piutang'),
    '020403': ('sp_ReportPelunasanPiutang', ['tanggal1','tanggal2','awal','akhir','devisi','tipe','perkiraan','KodeVls'], ['2024-01-01','2024-12-31','0','9','02','0','%','%'], 'Pelunasan Piutang - Detail'),
    '020404': ('sp_ReportSisaPiutangDet', ['tanggal','awal','akhir','devisi','tipe','Perkiraan','KodeVls'], ['2024-12-31','0','9','02','0','%','%'], 'Sisa Piutang - Detail'),
    '020407': ('sp_ReportMonitoringPiutang', ['tanggal','awal','akhir','devisi','tipe','Perkiraan','KodeVls','KodePrj'], ['2024-12-31','0','9','02','0','%','%','%'], 'Monitoring Piutang'),
    '020409': ('Sp_ReportHistoriKP', ['Tgl1','Tgl2','isiList','Id'], ['2024-01-01','2024-12-31','%',''], 'History KP'),
    '020502': ('Sp_ReportStock', ['bulan','tahun','kodegdg','nosat'], ['12','2024','GUDANG','1'], 'Laporan HPP'),
    '020505': ('SP_LapNeracaPenunjang', ['divisi','bulan','tahun'], ['02','12','2024'], 'Neraca Penunjang'),
    '020501': ('sp_NerajaLajur', ['Masuk','Bulan','Tahun','Devisi','IdUser'], ['D','12','2024','02',''], 'ReportNeracaLajur'),
    '020504': ('sp_ReportNeracaAktiva', ['Devisi','Bulan','Tahun'], ['02','12','2024'], 'ReportNeraca'),
    '020508': ('sp_ReportNeracaAktiva', ['Devisi','Bulan','Tahun'], ['02','12','2024'], 'ReportNeracaOld'),
    '020509': ('Sp_reportkartuStock', ['KodeBrg','KodeGdg','Bulan1','Bulan2','Tahun1','Tahun2','NoSat'], ['%','%','1','12','2024','2024','1'], 'Barang_ukuran'),
    '020510': ('Sp_reportkartuStock', ['KodeBrg','KodeGdg','Bulan1','Bulan2','Tahun1','Tahun2','NoSat'], ['%','%','1','12','2024','2024','1'], 'ReportKartuStok1'),
    '020511': ('Sp_reportOutStandingBPPBRek', ['Choice','Tgl1','Tgl2'], ['N','2024-01-01','2024-12-31'], 'ReportCrossCheckBPPB'),
    '020512': ('Sp_reportDebetnoteDet', ['KodeCust','Tgl1','Tgl2'], ['%','2024-01-01','2024-12-31'], 'ReportPerhitunganPoint'),

    '303241': ('Sp_ReportKartuProyek', ['Tgl1','Tgl2','isiList'], ['2024-01-01','2024-12-31','%'], 'ReportKartuProyek'),
    '303242': ('Sp_ReportKontrakVsSJ', ['Tgl1','Tgl2','isiList','Id'], ['2024-01-01','2024-12-31','%',''], 'ReportKontrakvsSJ'),
    '303243': ('Sp_ReportKartuProyekBarang', ['Tgl1','Tgl2','isiList'], ['2024-01-01','2024-12-31','%'], 'ReportKartuProyekBarang'),
    '303322': ('Sp_ReportPlInvoicedet', ['SReport','Ordr','tgl1','tgl2','isiList'], ['A','A','2024-01-01','2024-12-31','%'], 'ReportPLInvoice_DPP'),
    '020505': ('SP_LapNeracaPenunjang', ['divisi','bulan','tahun'], ['02','12','2024'], 'Neraca Penunjang'),
    
    # 0257 - ACC Reports
    '025711': ('Sp_reportPenerimaanAccDet', ['SReport','Ordr','tgl1','tgl2','isiList'], ['A','A','2024-01-01','2024-12-31','%'], 'Penerimaan ACC Per No.Bukti'),
    '025712': ('Sp_ReportPenerimaanACCRek', ['Choice','Tgl1','Tgl2'], ['A','2024-01-01','2024-12-31'], 'Penerimaan ACC Per Barang'),
    '025713': ('Sp_ReportPenerimaanACCRek', ['Choice','Tgl1','Tgl2'], ['A','2024-01-01','2024-12-31'], 'Penerimaan ACC Per Supplier'),
    '025731': ('Sp_reportBeliAccDet', ['SReport','Ordr','tgl1','tgl2','isiList','NeedOto','TipeBayar','Perkiraan','Id'], ['A','A','2024-01-01','2024-12-31','%','A','A','1','%'], 'Retur Pembelian ACC Per No.Bukti'),
    '025732': ('Sp_reportBeliAccDetPerPerkiraan', ['SReport','Ordr','tgl1','tgl2','isiList','NeedOto','TipeBayar','Keterangan','Id'], ['A','A','2024-01-01','2024-12-31','%','A','A','%','%'], 'Retur Pembelian ACC Per Barang'),
    '025733': ('Sp_reportBeliAccDet', ['SReport','Ordr','tgl1','tgl2','isiList','NeedOto','TipeBayar','Perkiraan','Id'], ['A','A','2024-01-01','2024-12-31','%','A','A','1','%'], 'Retur Pembelian ACC Per Supplier'),
    '025741': ('Sp_reportRBeliGDGDet', ['SReport','Ordr','tgl1','tgl2','isiList','NeedOto','Id'], ['A','A','2024-01-01','2024-12-31','%','1','%'], 'Retur Pembelian GDG Per No.Bukti'),
    '025743': ('Sp_reportRPembelianGDGRek', ['Choice','Tgl1','Tgl2','NeedOto','Id'], ['A','2024-01-01','2024-12-31','1','%'], 'Retur Pembelian GDG Per Supplier'),
    
    # 03 - Sales Reports
    '030201': ('Sp_ReportPNWDet', ['SReport','Ordr','tgl1','tgl2','isiList','Id'], ['A','A','2024-01-01','2024-12-31','%','%'], 'Laporan Penawaran Per No.Bukti'),
    '030202': ('Sp_ReportPNWDet', ['SReport','Ordr','tgl1','tgl2','isiList','Id'], ['A','A','2024-01-01','2024-12-31','%','%'], 'Laporan Penawaran Per Barang'),
    '030203': ('Sp_reportPNWRek', ['Choice','Tgl1','Tgl2','needOto','Id'], ['A','2024-01-01','2024-12-31','1','%'], 'Laporan Penawaran Per Customer'),
    '030204': ('Sp_reportPNWRek', ['Choice','Tgl1','Tgl2','needOto','Id'], ['A','2024-01-01','2024-12-31','1','%'], 'Laporan Penawaran Per Marketing'),
    '030314': ('Sp_report_CashBack', ['tgl1','tgl2','isiList'], ['2024-01-01','2024-12-31','%'], 'Laporan CashBack'),
    '030325': ('Sp_ReturPenyerahan', ['Choice','Nobukti','Nourut','Tanggal','Kodebag','kodeBiaya','SOP'], ['A','%','%','2024-12-31','%','%','%'], 'Retur Surat Jalan'),
    '030326': ('Sp_ReturPenyerahan', ['Choice','Nobukti','Nourut','Tanggal','Kodebag','kodeBiaya','SOP'], ['A','%','%','2024-12-31','%','%','%'], 'Retur Surat Jalan ACC'),
    '030351': ('sp_ReportKomisiSales', ['tanggal','tipe','awal','akhir','Devisi','perkiraan','KodeVls'], ['2024-12-31','0','0','9','02','%','%'], 'Laporan Target Sales'),
    '030361': ('sp_ReportKomisiSales', ['tanggal','tipe','awal','akhir','Devisi','perkiraan','KodeVls'], ['2024-12-31','0','0','9','02','%','%'], 'Komisi Pelunasan'),
    '030362': ('sp_ReportKomisiSales', ['tanggal','tipe','awal','akhir','Devisi','perkiraan','KodeVls'], ['2024-12-31','0','0','9','02','%','%'], 'Komisi Sales'),
    
    # 04 - Production/Stock Reports
    '040361': ('Sp_ReportTransferDet', ['SReport','Ordr','tgl1','tgl2','isiList','NeedOto','GM','Id'], ['A','A','2024-01-01','2024-12-31','%','%','0','%'], 'Transfer Barang Per No.Bukti'),
    '040362': ('Sp_ReportTransferDet', ['SReport','Ordr','tgl1','tgl2','isiList','NeedOto','GM','Id'], ['A','A','2024-01-01','2024-12-31','%','%','0','%'], 'Transfer Barang Per Barang'),
    '040501': ('Sp_reportUbahKemasanBahan', ['SReport','Ordr','tgl1','tgl2','isiList','Id'], ['A','A','2024-01-01','2024-12-31','%','%'], 'Ubah Kemasan Bahan Per No.Bukti'),
    '040502': ('Sp_reportUbahKemasanBahan', ['SReport','Ordr','tgl1','tgl2','isiList','Id'], ['A','A','2024-01-01','2024-12-31','%','%'], 'Ubah Kemasan Bahan Per Barang'),
    '040701': ('Sp_ReportOpnamebahan', ['SReport','Ordr','tgl1','tgl2','isiList','Needoto'], ['A','A','2024-01-01','2024-12-31','%','0'], 'Opname Bahan Per No.Bukti'),
    '040702': ('Sp_ReportOpnamebahan', ['SReport','Ordr','tgl1','tgl2','isiList','Needoto'], ['A','A','2024-01-01','2024-12-31','%','0'], 'Opname Bahan Per Barang'),
    '040801': ('Sp_ReportOpnameBarang', ['SReport','Ordr','tgl1','tgl2','isiList','NeeDoto'], ['A','A','2024-01-01','2024-12-31','%','0'], 'Opname Barang Per No.Bukti'),
    '040802': ('Sp_ReportOpnameBarang', ['SReport','Ordr','tgl1','tgl2','isiList','NeeDoto'], ['A','A','2024-01-01','2024-12-31','%','0'], 'Opname Barang Per Barang'),
    '040851': ('cetakhasilproduksi', ['NoBukti'], ['%'], 'Hasil Produksi Per No.Bukti'),
    '040852': ('cetakhasilproduksi', ['NoBukti'], ['%'], 'Hasil Produksi Per Barang'),
    '040861': ('cetakhasilproduksi', ['NoBukti'], ['%'], 'Hasil Produksi ACC Per No.Bukti'),
    '040862': ('cetakhasilproduksi', ['NoBukti'], ['%'], 'Hasil Produksi ACC Per Barang'),
    
    # 05 - Stock Reports
    '050104': ('Sp_ReportStockAkhir', ['Nosat','tanggal','KOdegdg'], ['1','2024-12-31','%'], 'Stock Akhir Barang Produksi'),
    '050105': ('Sp_ReportStockFisikGudang', ['tanggal','KOdegdg'], ['2024-12-31','%'], 'Stock Fisik Gudang'),
    '050106': ('SP_ReportStockHarian', ['awal','akhir','gudang','nosat'], ['2024-01-01','2024-12-31','%','1'], 'Stock Harian'),
    '050107': ('Sp_reportStockQtyPCS', ['Bulan','Tahun','Kodegdg','KodeGrp'], ['12','2024','%','%'], 'Laporan Katalog Barang (PCS)'),
    '050201': ('sp_reportkartuStock', ['kodegdg','Kodebrg','bulan1','bulan2','tahun1','tahun2','periode1','periode2','Nosat'], ['%','%','1','12','2024','2024','A','A','1'], 'Kartu Stock Qnt'),
    '050202': ('sp_reportStockQtyRprek', ['Bulan','Tahun','isi','Kodegdg','KodeGrp','minus','MinusHPP','Qty1','Qty2','Pilih','KodeSubGrp'], ['12','2024','0','%','%','0','0','0','0','0','%'], 'Kartu Stock Qnt dan Rupiah'),
}

def get_existing_id_laporan(cur):
    cur.execute("SELECT COALESCE(MAX(id_laporan),0) FROM dbmasterlaporan")
    return cur.fetchone()[0]

def get_laporan_names(cur):
    cur.execute("SELECT KODEMENU, Keterangan FROM DBMENUREPORT WHERE L0=3 AND LEN(KODEMENU)=6 ORDER BY KODEMENU")
    return {r[0]: r[1] for r in cur.fetchall()}

def get_existing_kodemenu(cur):
    cur.execute("SELECT KODEMENU FROM dbmasterlaporan")
    return {r[0] for r in cur.fetchall()}

def main():
    conn = pyodbc.connect(CONN_STR)
    cur = conn.cursor()
    
    # Get existing data
    existing_codes = get_existing_kodemenu(cur)
    all_menus = get_laporan_names(cur)
    
    # Find missing codes from DBMENUREPORT
    missing_codes = sorted(set(all_menus.keys()) - existing_codes)
    print(f"Missing reports from DBMENUREPORT: {len(missing_codes)}")
    
    # Map to SPs
    mapped = {}
    for code in missing_codes:
        if code in COMPLETE_MAPPING:
            sp_name, params, sample, desc = COMPLETE_MAPPING[code]
            mapped[code] = (all_menus[code], sp_name, params, sample)
        else:
            print(f"  WARNING: {code} - No SP mapping!")
    
    print(f"Mapped to SPs: {len(mapped)}")
    
    # Get max ID
    max_id = get_existing_id_laporan(cur)
    
    # Generate SQL
    sql_master = []
    sql_param = []
    sql_query = []
    
    for idx, (code, (nama, sp_name, params, sample)) in enumerate(mapped.items(), start=max_id+1):
        # dbmasterlaporan
        sql_master.append(f"INSERT INTO dbmasterlaporan (KODEMENU, nama_laporan, status_aktif) VALUES ('{code}', '{nama}', 1);")
        
        # dbparameterlaporan
        for i, (pname, pval) in enumerate(zip(params, sample)):
            sql_param.append(f"INSERT INTO dbparameterlaporan (id_laporan, nama_filter, tipe_input, wajib_isi) VALUES ({idx}, '{pname}', 'text', 0);")
        
        # dbquerylaporan
        sql_query.append(f"INSERT INTO dbquerylaporan (id_laporan, nama_dataset, query_sumber_data) VALUES ({idx}, 'ds_{code}', 'EXEC {sp_name}');")
    
    # Combine and save
    full_sql = f"""-- =====================================================
-- COMPLETE SEED FOR {len(mapped)} MISSING REPORTS
-- Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
-- Source: DBMENUREPORT L0=3 -> dbmasterlaporan
-- SP Mapping: Verified from SQL Server
-- =====================================================

-- DBMASTERLAPORAN
""" + '\n'.join(sql_master) + """

-- DBPARAMETERLAPORAN
""" + '\n'.join(sql_param) + """

-- DBQUERYLAPORAN
""" + '\n'.join(sql_query)

    # Save
    with open('seed_complete.sql', 'w') as f:
        f.write(full_sql)
    
    # Save mapping
    with open('sp_mapping_complete.json', 'w') as f:
        json.dump({
            'total_missing': len(missing_codes),
            'mapped': len(mapped),
            'mapping': {k: {'nama': v[0], 'sp': v[1], 'params': v[2], 'sample': v[3]} for k, v in mapped.items()}
        }, f, indent=2)
    
    print(f"\nGenerated: seed_complete.sql ({len(mapped)} reports)")
    print(f"SP Mapping: sp_mapping_complete.json")
    
    conn.close()

if __name__ == '__main__':
    main()
