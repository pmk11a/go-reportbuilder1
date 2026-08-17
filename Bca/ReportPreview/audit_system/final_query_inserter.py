"""
INSERTER FOR DBQUERYLAPORAN - For 49 reports missing SP queries
"""
import pyodbc

CONN_STR = 'DRIVER={ODBC Driver 17 for SQL Server};SERVER=192.168.56.1;DATABASE=dbbcagroup;UID=sa;PWD=anekajc1a9;'

# Map: KODEMENU -> SP_NAME (LENGKAP untuk EXEC)
SP_MAPPING = {
    '020106': 'Sp_LapDeposito',
    '020107': 'Sp_LapGiroHutang',
    '020108': 'sp_LapGiroPiutang',
    '020201': 'Sp_LapJurnal',
    '020205': 'sp_LapAktiva',
    '020206': 'sp_LapSusutAktiva',
    '020303': 'sp_ReportPelunasanPiutang',
    '020304': 'sp_ReportSisaPiutang',
    '020403': 'sp_ReportPelunasanPiutang',
    '020404': 'sp_ReportSisaPiutangDet',
    '020407': 'sp_ReportMonitoringPiutang',
    '020502': 'Sp_ReportStock',
    '020505': 'SP_LapNeracaPenunjang',
    '025711': 'Sp_reportPenerimaanAccDet',
    '025712': 'Sp_ReportPenerimaanACCRek',
    '025713': 'Sp_ReportPenerimaanACCRek',
    '025731': 'Sp_reportBeliAccDet',
    '025732': 'Sp_reportBeliAccDetPerPerkiraan',
    '025733': 'Sp_reportBeliAccDet',
    '025741': 'Sp_reportRBeliGDGDet',
    '025743': 'Sp_reportRPembelianGDGRek',
    '030201': 'Sp_ReportPNWDet',
    '030202': 'Sp_ReportPNWDet',
    '030203': 'Sp_reportPNWRek',
    '030204': 'Sp_reportPNWRek',
    '030314': 'Sp_report_CashBack',
    '030325': 'Sp_ReturPenyerahan',
    '030326': 'Sp_ReturPenyerahan',
    '030351': 'sp_ReportKomisiSales',
    '030361': 'sp_ReportKomisiSales',
    '030362': 'sp_ReportKomisiSales',
    '040361': 'Sp_ReportTransferDet',
    '040362': 'Sp_ReportTransferDet',
    '040501': 'Sp_reportUbahKemasanBahan',
    '040502': 'Sp_reportUbahKemasanBahan',
    '040701': 'Sp_ReportOpnamebahan',
    '040702': 'Sp_ReportOpnamebahan',
    '040801': 'Sp_ReportOpnameBarang',
    '040802': 'Sp_ReportOpnameBarang',
    '040851': 'cetakhasilproduksi',
    '040852': 'cetakhasilproduksi',
    '040861': 'cetakhasilproduksi',
    '040862': 'cetakhasilproduksi',
    '050104': 'Sp_ReportStockAkhir',
    '050105': 'Sp_ReportStockFisikGudang',
    '050106': 'SP_ReportStockHarian',
    '050107': 'Sp_reportStockQtyPCS',
    '050201': 'sp_reportkartuStock',
    '050202': 'sp_reportStockQtyRprek',
}

# Get next id_query
def get_next_id(conn):
    cur = conn.cursor()
    cur.execute('SELECT COALESCE(MAX(id_query),0) FROM dbquerylaporan')
    return cur.fetchone()[0] + 1

def main():
    conn = pyodbc.connect(CONN_STR)
    cur = conn.cursor()
    
    # Get reports without query
    cur.execute('''
        SELECT m.id_laporan, m.KODEMENU
        FROM dbmasterlaporan m
        LEFT JOIN dbquerylaporan q ON m.id_laporan = q.id_laporan
        WHERE m.status_aktif = 1 
        AND q.id_query IS NULL
        ORDER BY m.id_laporan
    ''')
    
    missing = cur.fetchall()
    print(f'Reports without query: {len(missing)}')
    
    next_id = get_next_id(conn)
    success = 0
    errors = 0
    
    for id_laporan, kode in missing:
        sp_name = SP_MAPPING.get(kode)
        if not sp_name:
            print(f'  SKIP: {kode} - no SP mapping')
            continue
        
        try:
            sql = f"INSERT INTO dbquerylaporan (id_laporan, nama_dataset, query_sumber_data, urutan, visible) VALUES ({id_laporan}, 'ds_{kode}', 'EXEC {sp_name}', 1, 1)"
            cur.execute(sql)
            success += 1
            next_id += 1
        except Exception as e:
            errors += 1
            print(f'  ERROR {kode}: {str(e)[:80]}')
    
    conn.commit()
    
    cur.execute('SELECT COUNT(*) FROM dbquerylaporan')
    print(f'\nSuccess: {success}, Errors: {errors}')
    print(f'dbquerylaporan total: {cur.fetchone()[0]}')
    
    conn.close()

if __name__ == '__main__':
    main()
