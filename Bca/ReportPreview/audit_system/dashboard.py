"""
Dashboard untuk menampilkan semua report yang ada di dbmasterlaporan
Menggunakan Dynamic Report Engine (dbmasterlaporan -> SP)
"""
import pyodbc
import os

# Database connection
CONN_STR = 'DRIVER={ODBC Driver 17 for SQL Server};SERVER=192.168.56.1;DATABASE=dbbcagroup;UID=sa;PWD=anekajc1a9;'
DB_PATH = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'dbmenureport.mdb')

def get_db_connection():
    return pyodbc.connect(CONN_STR)

def execute_sp(sp_name, params):
    """Execute stored procedure with parameters"""
    conn = get_db_connection()
    cur = conn.cursor()
    try:
        sql = f"EXEC {sp_name}"
        cur.execute(sql)
        columns = [col[0] for col in cur.description]
        rows = cur.fetchall()
        return {'columns': columns, 'rows': rows}
    except Exception as e:
        return {'error': str(e)}
    finally:
        conn.close()

def load_all_reports():
    """Load all reports from dbmasterlaporan"""
    conn = get_db_connection()
    cur = conn.cursor()
    
    cur.execute("""
        SELECT 
            m.id_laporan,
            m.KODEMENU,
            m.nama_laporan,
            p.nama_filter,
            p.tipe_input,
            q.query_sumber_data,
            q.produksisistem
        FROM dbmasterlaporan m
        LEFT JOIN dbparameterlaporan p ON m.id_laporan = p.id_laporan
        LEFT JOIN dbquerylaporan q ON m.id_laporan = q.id_laporan
        WHERE m.status_aktif = 1
        ORDER BY m.KODEMENU, m.nama_laporan
    """)
    
    reports = {}
    for row in cur.fetchall():
        id_laporan, kode, nama, param, tipe, query, produksi = row
        
        if id_laporan not in reports:
            reports[id_laporan] = {
                'KODEMENU': kode,
                'nama_laporan': nama,
                'query_sumber_data': query or '',
                'produksi': produksi,
                'parameters': []
            }
        
        if param:
            reports[id_laporan]['parameters'].append({
                'nama': param,
                'tipe': tipe
            })
    
    conn.close()
    return reports

def get_reports_by_group(reports):
    """Group reports by menu category (L0, L1, L2)"""
    groups = {}
    
    for id_laporan, report in reports.items():
        kode = report['KODEMENU']
        
        # Extract group from kode (first 3 digits = L0, first 4 = L1)
        l0 = kode[:3]
        l1 = kode[:4]
        
        if l0 not in groups:
            groups[l0] = {
                'title': f'Laporan Group {l0}',
                'reports': []
            }
        
        groups[l0]['reports'].append({
            'id': id_laporan,
            'KODEMENU': kode,
            'nama_laporan': report['nama_laporan'],
            'query': report['query_sumber_data'],
            'produksi': report['produksi'],
            'parameters': report['parameters']
        })
    
    return groups

def get_menu_hierarchy():
    """Get menu hierarchy from DBMENUREPORT"""
    conn = get_db_connection()
    cur = conn.cursor()
    
    cur.execute("""
        SELECT L0, KODEMENU, Keterangan, L1, L2
        FROM DBMENUREPORT
        WHERE L0 > 0 AND LEN(KODEMENU) = 6
        ORDER BY KODEMENU
    """)
    
    menu = {}
    for row in cur.fetchall():
        l0, kode, ket, l1, l2 = row
        
        if l0 not in menu:
            menu[l0] = {
                'title': f'Group {l0}',
                'children': {}
            }
        
        menu[l0]['children'][kode] = {
            'nama': ket,
            'L1': l1,
            'L2': l2,
            'reports': []
        }
    
    conn.close()
    return menu

def get_report_with_data(id_laporan, params=None):
    """Get report data by id_laporan with optional parameters"""
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Get report metadata
    cur.execute("""
        SELECT m.nama_laporan, m.KODEMENU, m.produksisistem, q.query_sソース_data
        FROM dbmasterlaporan m
        LEFT JOIN dbquerylaporan q ON m.id_laporan = q.id_laporan
        WHERE m.id_laporan = ?
    """, (id_laporan,))
    
    report = cur.fetchone()
    if not report:
        conn.close()
        return None
    
    nama, kode, produksi, query = report
    sp_name = query.split('EXEC ')[-1].strip() if query and 'EXEC ' in query else ''
    
    # Get parameters
    cur.execute("SELECT nama_filter, tipe_input FROM dbparameterlaporan WHERE id_laporan = ?", (id_laporan,))
    params_list = cur.fetchall()
    
    # Build and execute query
    if sp_name and params:
        try:
            param_names = [p[0] for p in params_list]
            param_values = [params.get(p, '%') for p in param_names]
            
            # Create SQL with parameters
            sql = f"EXEC {sp_name} {', '.join(['?' for _ in param_values])}"
            cur.execute(sql, param_values)
            
            columns = [col[0] for col in cur.description] if cur.description else []
            rows = cur.fetchall()
            
            conn.close()
            return {
                'nama_laporan': nama,
                'kode': kode,
                'produksisistem': produksi,
                'parameters': params_list,
                'columns': columns,
                'rows': rows
            }
        except Exception as e:
            conn.close()
            return {'error': str(e)}
    else:
        # Execute without parameters
        try:
            cur.execute(f"EXEC {sp_name}")
            columns = [col[0] for col in cur.description] if cur.description else []
            rows = cur.fetchall()
            
            conn.close()
            return {
                'nama_laporan': nama,
                'kode': kode,
                'produksisistem': produksi,
                'parameters': params_list,
                'columns': columns,
                'rows': rows
            }
        except Exception as e:
            conn.close()
            return {'error': str(e)}

def get_report_count():
    """Get total count of active reports"""
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM dbmasterlaporan WHERE status_aktif = 1")
    count = cur.fetchone()[0]
    conn.close()
    return count

def get_parameter_structure():
    """Get parameter structure for each report"""
    conn = get_db_connection()
    cur = conn.cursor()
    
    cur.execute("""
        SELECT m.id_laporan, m.KODEMENU, m.nama_laporan, p.nama_filter, p.tipe_input
        FROM dbmasterlaporan m
        LEFT JOIN dbparameterlaporan p ON m.id_laporan = p.id_laporan
        WHERE m.status_aktif = 1
        ORDER BY m.id_laporan, p.id_parameter
    """)
    
    params = {}
    for row in cur.fetchall():
        id_laporan, kode, nama, param, tipe = row
        if id_laporan not in params:
            params[id_laporan] = {
                'KODEMENU': kode,
                'nama_laporan': nama,
                'parameters': []
            }
        if param:
            params[id_laporan]['parameters'].append({
                'nama': param,
                'tipe': tipe
            })
    
    conn.close()
    return params

if __name__ == '__main__':
    print("=" * 80)
    print("BCA Report Dashboard - Dynamic Report Engine")
    print("=" * 80)
    
    reports = load_all_reports()
    print(f"Total Reports: {len(reports)}")
    
    # Group reports
    groups = get_reports_by_group(reports)
    for l0, group in sorted(groups.items()):
        print(f"\n{group['title']}: {len(group['reports'])} reports")
        for r in group['reports'][:3]:
            print(f"  - {r['KODEMENU']}: {r['nama_laporan']}")
    
    # Show parameter structure
    params = get_parameter_structure()
    print(f"\n\nParameter Structure: {len(params)} reports with parameters")
    
    # Get count
    count = get_report_count()
    print(f"Active Reports: {count}")
