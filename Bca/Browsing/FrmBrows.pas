unit FrmBrows;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Db, ADODB, StdCtrls, ExtCtrls, Buttons,
  dxCntner, dxTL, dxDBCtrl, dxDBGrid, cxLookAndFeelPainters,StrUtils,dxGridMenus ;

type
  TFrBrows = class(TForm)
    QuBrows: TADOQuery;
    DsBrows: TDataSource;
    Panel2: TPanel;
    QuBrowGL: TADOQuery;
    DsQuBrowGL: TDataSource;
    Sp_Simpan: TADOStoredProc;
    GridBrows: TdxDBGrid;
    Panel1: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    EditFilter: TEdit;
    Panel4: TPanel;
    TambahBtn: TSpeedButton;
    KoreksiBtn: TSpeedButton;
    HapusBtn: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Procedure ViewItem(mSelect : String; judul,Lebar: Array of Variant;
                             Var mQuery : TAdoQuery;carikata: string);
    procedure ResizeControls(padOnly: boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    Procedure ViewItems(mSelect : String; mParam,judul,Lebar: Array of Variant;
                             Var mQuery : TAdoQuery;Carikata:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridBrowsDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GridBrowsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure TambahBtnClick(Sender: TObject);
    procedure GridBrowsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditFilterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditFilterChange(Sender: TObject);
    procedure GridBrowsCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
  private
    { Private declarations }
//    xFilterDataBrows: String;
    procedure FilterDataBrows;
  public
     MaxWidth : integer;
     Tbl, brGudang, Gudang, NoKira, NoKira1, NoKira2, Customer,Devisi,kodearea,kodesales,sIsiBrg,JenisBahan:string;
     SortBy, IsiData, isidata1, NoSupp, mNopo, mNoSo, mPosisi, mSales1, mSales2, mLokasi, mKodebrg, mKodegdg, Tipeppn, mNobukti : String;
     GrpTipe,GrpPPN,GrpGdg : Byte;
     TglAwal,TglAkhir:Tdatetime;
     EditBrows,EditBrows1, IsLokal,Vw,Ordr,Colm1,Colm2,Fi : String;
     isKecuali,SelectAllRecord, IsTampil : Boolean;
     brTahun, brBulan,JnsPakai: Integer;
    { Public declarations }
  end;

const
     LoC = LoCaseInsensitive;
     LoP = LoPartialKey;
var
  FrBrows: TFrBrows;
  S:array[0..255]of char;

implementation

uses MyGlobal,MyModul,
  MyProcedure;

{$R *.DFM}

Procedure TFrBrows.ViewItem(mSelect : String; judul,Lebar: Array of Variant;
                             Var mQuery : TAdoQuery;carikata: string);
Var
   I: Word;
Begin
  FrBrows.DsBrows.DataSet:=mQuery;
  With mQuery Do
  Begin
    Close;
    Sql.Clear;
    Sql.Add(mSelect);
    Open;
  end;
  with Frbrows.GridBrows do
  begin
     BeginUpdate;
     DestroyColumns;
     KeyField := '';
     DataSource := FrBrows.DsBrows;
     CreateDefaultColumns(DataSource.DataSet, GridBrows);
     KeyField := mQuery.Fields[0].FieldName;
     EndUpdate;

     Columns[0].SummaryFooterField:=mQuery.Fields[0].FieldName;
     Columns[0].SummaryFooterType:=cstCount;
     For I := Low(Judul) to High(Judul) Do
     begin
         Columns[i].Width :=Lebar[i]*5;
         Columns[i].Caption :=Judul[i];
         Columns[i].HeaderAlignment:=taCenter;
         if Columns[i].Caption='N' then
            Columns[i].Visible := false;
         if (mQuery.Fields[i] is TNumericField) then
             (mQuery.Fields[i] as TNumericField).DisplayFormat:=',0.00';
         if (mQuery.Fields[i] is TIntegerField) then
             (mQuery.Fields[i] as TIntegerField).DisplayFormat:=',0';
     end;
     GridBrows.StartSearch(0, EditBrows);
     GridBrows.Invalidate;
  end;
  ResizeControls(false);
end;



Procedure TFrBrows.ViewItems(mSelect : String; mParam,judul,Lebar: Array of Variant;
                             Var mQuery : TAdoQuery;Carikata:String);
Var
   I,J: Word;
Begin
  FrBrows.DsBrows.DataSet:=mQuery;
  With mQuery Do
  Begin
    Close;
    Sql.Clear;
    Sql.Add(mSelect);
    Prepared;
    For J := Low(mParam) to High(mParam) Do
       Parameters[j].Value:=mParam[j];
    Open;
  end;
  with Frbrows.GridBrows do
  begin
     BeginUpdate;
     DestroyColumns;
     KeyField := '';
     DataSource := FrBrows.DsBrows;
     CreateDefaultColumns(DataSource.DataSet, GridBrows);
     KeyField := mQuery.Fields[0].FieldName;
     Columns[0].SummaryFooterField:=mQuery.Fields[0].FieldName;
     Columns[0].SummaryFooterType:=cstCount;
     EndUpdate;
     For I := Low(Judul) to High(Judul) Do
     begin
         Columns[i].Width :=Lebar[i]*5;
         Columns[i].Caption :=Judul[i];
         Columns[i].HeaderAlignment:=taCenter;
         if Columns[i].Caption='N' then
            Columns[i].Visible := false;
         if (mQuery.Fields[i] is TNumericField) then
             (mQuery.Fields[i] as TNumericField).DisplayFormat:=',0.00';
         if (mQuery.Fields[i] is TIntegerField) then
             (mQuery.Fields[i] as TIntegerField).DisplayFormat:=',0';
     end;
     GridBrows.StartSearch(0, EditBrows);
     GridBrows.Invalidate;
  end;
  ResizeControls(false);
end;

procedure TFrBrows.FilterDataBrows;
var xFilterData: String;
    xStrSQL: String;
    
begin
  xFilterData:=QuotedStr('%'+EditFilter.Text+'%');
  case KodeBrows of
    // Customer or Supplier
    100101  : begin
              ViewItem('select a.KodeGdg, a.Nama NamaGdg, a.IsRusak from dbGudang a '+
                       ' left outer join dbPemakaiGdg b on b.kodegdg=a.kodegdg '+
                       ' where b.Userid='+QuotedStr(IDUser) + ' and A.Kodegdg<>'+ QuotedStr(Gudang)+
                       ' and (A.KodeGdg like ''%'+EditFilter.Text+'%'' or a.Nama like ''%'+EditFilter.Text+'%'') '+
                       ' order by a.KodeGdg',
              ['Kode', 'Nama Gudang','N'],
              [15, 50, 1], QuBrows, EditBrows);
            end;    
    110701 : begin
               ViewItem(' select X.KodeCustSupp, Y.NamaCustSupp, '+
                        ' rtrim(ltrim(isnull(Y.Alamat1,'''')+case when isnull(Y.Alamat2,'''')='''' then '''' else '' ''+Y.Alamat2 end)) Alamat, '+
                        ' Y.Kota,PPN,Hari '+
                        ' from '+
                        '  (select A.KodeCustSupp from DBPERKCUSTSUPP A, DBPOSTHUTPIUT B '+
                        '   where B.Perkiraan=A.Perkiraan and B.Kode='+QuotedStr(NoKira)+
                        '   group by A.KodeCustSupp '+
                        '  ) X, DBCUSTSUPP Y '+
                        ' where X.KodeCustSupp=Y.KodeCustSupp and y.Jenis=0 '+
                        ' and (Y.KodeCustSupp like ''%'+EditFilter.Text+'%'' or Y.NamaCustSupp like ''%'+EditFilter.Text+'%'') '+
                        ' order by X.KodeCustSupp',
               ['Kode','Nama','Alamat','Kota','N','N'],
               [15,40,50,20,1,1], QuBrows, EditBrows);

             end;
    104050 : begin
               ViewItem(' select a.KodeKend, a.NamaKend, a.KodeJenisKend, b.NamaJenisKend '+
                        ' from dbKendaraan a '+
                        ' left outer join dbJenisKend b on b.KodeJenisKend=a.KodeJenisKend '+
                        ' where (a.KodeKend like ''%'+EditFilter.Text+'%'' or a.NamaKend like ''%'+EditFilter.Text+'%'') '+
                        ' order by a.KodeKend',
               ['No. Mesin','No. Pol.','N','Jenis Kend.'],
               [30,15,1,35], QuBrows, EditBrows);
             end;
    104051 : begin
               ViewItem(' select a.KodeAlat, a.NamaAlat, a.Tipe, a.NamaOpe '+
                        ' from dbAlatBerat a '+
                        ' where (a.KodeAlat like ''%'+EditFilter.Text+'%'' or a.NamaAlat like ''%'+EditFilter.Text+'%'') '+
                        ' order by a.KodeAlat',
               ['Kode','Nama Alat','Tipe','Nama Operator'],
               [30,70,20,70], QuBrows, EditBrows);
             end;
    105070 : begin
               ViewItem(' select KodeCustSupp, NamaCustSupp '+
                        ' from vwCustSupp '+
                        ' where Jenis=2 and (KodeCustSupp like ''%'+EditFilter.Text+'%'' or NamaCustSupp like ''%'+EditFilter.Text+'%'') '+
                        ' order by KodeCustSupp',
               ['Kode','Nama'],
               [15,40], QuBrows, EditBrows);
             end;
    11001 : begin
              ViewItem('select a.KodeVls, a.NamaVls, a.Kurs from dbValas a '+
                       ' where (A.KodeVls like ''%'+EditFilter.Text+'%'' or a.NamaVls like ''%'+EditFilter.Text+'%'') '+
                       'order by a.KodeVls',
              ['Kode', 'Nama Valas','Kurs'],
              [10, 30, 10], QuBrows, EditBrows);
            end;
    11002 : begin
              ViewItem('select KodeGdg,Nama,Alamat from dbGudang  '+
                       ' where (KodeGdg like ''%'+EditFilter.Text+'%'' or Nama like ''%'+EditFilter.Text+'%'') '+
                       'order by KodeGdg',
              ['Kode', 'Nama '],
              [10, 30], QuBrows, EditBrows);
            end;

    11003 : begin
              ViewItem('select * from dbGudang  '+
                       'where (KodeGdg like ''%'+EditFilter.Text+'%'' or Nama like ''%'+EditFilter.Text+'%'') '+
                       'order by KodeGdg',
              ['Kode', 'Nama '],
              [10, 30], QuBrows, EditBrows);
            end;
    11004 : begin
              ViewItem('select * from dbGudang where Nama Not Like ''%Bahan%''  '+
                       'where (KodeGdg like ''%'+EditFilter.Text+'%'' or Nama like ''%'+EditFilter.Text+'%'') '+
                       'order by KodeGdg',
              ['Kode', 'Nama '],
              [10, 30], QuBrows, EditBrows);
            end;
    11005 : begin
              ViewItem('select * from dbBank  '+
                       'where (KodeBank like ''%'+EditFilter.Text+'%'' or NamaBank like ''%'+EditFilter.Text+'%'') '+
                       'order by KodeBank',
              ['Kode', 'Nama '],
              [10, 30], QuBrows, EditBrows);
            end;
    110051 : begin
              ViewItem('select KodeBank,NamaBank+'' (''+KodeBank+'')'' NamaBank from dbBank  '+
                       'where (KodeBank like ''%'+EditFilter.Text+'%'' or NamaBank like ''%'+EditFilter.Text+'%'') '+
                       'order by KodeBank',
              ['Kode', 'Nama '],
              [20, 30], QuBrows, EditBrows);
            end;
    114901: Begin
              ViewItem('select Nama,NamaJab from dbKaryawan a left Outer Join DBJABATAN b on a.KodeJab=b.KODEJAB where Nama like ''%'+EditFilter.Text+'%'' '+
               ' order by Nama',
               ['Nama', 'Jabatan'],
               [35, 50], QuBrows, EditBrows);
            end;
    104040 : begin
               ViewItem('select KodeJenisKend, NamaJenisKend from dbJenisKend where NamaJenisKend like ''%'+EditFilter.Text+'%'' '+
               ' order by KodeJenisKend',
               ['Kode', 'Nama '],
               [15, 35], QuBrows, EditBrows);
            end;
    1100211: Begin
               ViewItems('Select NoBukti,KODEKEND,NamaKend,Supir from vw_TransRute where NoBukti  Not in(Select Isnull(NoTarif,'''') From dbSPB) '+
               'and (NoBukti like ''%'+EditFilter.Text+'%'' or KODEKEND like ''%'+EditFilter.Text+'%'') '+
               ' and Ket1=:0 and Ket2=:1 and NoBukti Like :2 Group by NoBukti,KODEKEND,NamaKend,Supir Order By NoBukti',[Isidata1,IsLokal,'%'+IsiData+'%'],
               ['No Tarif','N','N','N'],[30,1,1,1],QuBrows,EditBrows);
             end;
    1100411 : begin
              ViewItem('select KodeBiaya,Keterangan,Perkiraan from dbBIAYA  '+
                       'where (KodeBiaya like ''%'+EditFilter.Text+'%'' or Keterangan like ''%'+EditFilter.Text+'%'') '+
                       'order by KodeBiaya',
              ['Kode Biaya', 'Keterangan ','Perkiraan'],
              [10, 30,30], QuBrows, EditBrows);
            end;
    110011 : begin
              ViewItem('select a.KodeSubGrp,a.NamaSubGrp from dbSubGroup a Left Outer Join dbGroup b on a.KodeGrp=b.KodeGrp '+
                       'where a.KodeGrp Not in(''FG'') and (KodeSubGrp Like  ''%'+EditFilter.Text+'%'' or NamaSubGrp Like  ''%'+EditFilter.Text+'%'') order by a.KodeSubGrp',
              ['Kode Sub','Nama Sub'],
              [20, 30], QuBrows, EditBrows);
            end;
    1100112 : begin
              ViewItem('select KodeGrp,Nama from  dbGroup '+
                       'where KodeGrp Not in(''FG'')   '+
                       'and (KodeGrp like ''%'+EditFilter.Text+'%'' or Nama like ''%'+EditFilter.Text+'%'') '+
                       'order by KodeGrp',
              ['Kode Group','Nama'],
              [15, 30], QuBrows, EditBrows);
            end;
    1100113 : begin
              ViewItem('select KodeGrp,Nama from  dbGroup '+
                       'where (KodeGrp like ''%'+EditFilter.Text+'%'' or Nama like ''%'+EditFilter.Text+'%'') '+
                       'order by KodeGrp',
              ['Kode Group','Nama'],
              [15, 30], QuBrows, EditBrows);
            end;
    3001101
        :Begin
           SortBy:='KodeBrg';
           ViewItem('Select A.KODEBRG, A.NAMABRG, A.SAT1 Sat_1, A.Sat2 Sat_2, A.Isi2 Isi '+
           ' from dbBarang A  '+
           ' where (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
           ' order by A.KodeBrg',
           ['Kode Barang','Nama Barang','Sat1','Sat2','N'],
           [15,40,5,5,1],QuBrows,EditBrows);
         end;
    2420111: begin // browse barang jadi ada stok
             //if LevelUserAccess>0 Then xStrSQL:=' or (((NAMABRG Like ''%DITCH%'' or NamaBrg Like ''%BOX CULVERT%'' or NamaBrg Like  ''%%''))and A.KodeGrp=''FG'') ';
             SortBy:='KodeBrg';
             Viewitem('Select Isnull(NFix,0)Nfix,A.Isi2,A.KodeBrg,A.Sat1,A.Sat2, A.NamaBrg, Isnull(b.Qnt,0) QntSaldo, Isnull(b.Qnt2,0) Qnt2Saldo '+
                      'from dbBarang A '+
                      'left Outer Join (select Kodebrg,Sum(SaldoQnt)Qnt,Sum(Saldo2Qnt)Qnt2 from DBStockBrg a Left Outer Join dbGudang b On a.KodeGdg=b.KodeGdg where  Bulan='+PeriodBln+' and Tahun='+PeriodThn+' group by kodebrg)b On b.kodebrg=a.KodeBrg ' +
                      'where (a.isAktif=1 and A.KodeGrp=''FG'') and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      //'where a.isAktif=1 and A.KodeGrp=''BJ'' and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      '  '+xStrSQL+'   '+
                      'order by A.KodeBrg ',
                      ['N','N','Kode Barang','N','N', 'Nama Barang', 'Saldo','Saldo2'],
                      [1,1,25,1,1,70,15,15],QuBrows,EditBrows);
           end;
       24201112: begin // browse barang jadi ada stok
             SortBy:='KodeBrg';
             Viewitems('Select Isnull(NFix,0)Nfix,A.Isi2,A.KodeBrg,A.Sat1,A.Sat2, A.NamaBrg, Sum(A1.Qnt)-Isnull(A2.Qnt,0) QntSaldo,0 Qnt2Saldo  '+
                      'from dbSOdet A1 '+
                      'Left Outer Join dbBarang A on A.KodeBrg=A1.KodeBrg '+
                      'Left Outer Join(select a.KodeBrg,a.Satuan,b.NOSO,Sum(a.Qnt)Qnt from dbSPKMDet a Left Outer Join dbSPK b On a.noBukti=b.NoBukti Group by a.KodeBrg,a.Satuan,b.NOSO)A2 On A2.NOSO=A1.NoBukti and A2.KodeBrg=A1.KodeBrg '+
                      'where A1.NoBukti=:0 and a.isAktif=1 and A.KodeGrp=''FG'' and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'Group by NFix,A.ISI2,A.KODEBRG,A.Sat1,A.Sat2, A.NamaBrg,Isnull(A2.Qnt,0) '+
                      'Having Sum(A1.Qnt)-Isnull(A2.Qnt,0)>0   '+
                      'and (A.KodeBrg like ''%'+EditFilter.Text+'%'' or A.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'order by A.KodeBrg ',[IsiData],
                      ['N','N','Kode Barang','N','N', 'Nama Barang', 'Saldo','N'],
                      [1,1,25,1,1,70,15,1],QuBrows,EditBrows);
           end;
     24201122: begin // browse barang jadi ada stok
             SortBy:='KodeBrg';
             Viewitem('Select Isnull(NFix,0)Nfix,A.Isi2,A.KodeBrg,A.Sat1,A.Sat2, A.NamaBrg, Isnull(b.Qnt,0) QntSaldo, Isnull(b.Qnt2,0) Qnt2Saldo '+
                      'from dbBarang A '+
                      'left Outer Join (select Kodebrg,Sum(SaldoQnt)Qnt,Sum(Saldo2Qnt)Qnt2 from DBStockBrg a Left Outer Join dbGudang b On a.KodeGdg=b.KodeGdg where Bulan='+PeriodBln+' and Tahun='+PeriodThn+' group by kodebrg)b On b.kodebrg=a.KodeBrg ' +
                      'where a.isAktif=1 and A.KodeGrp<>''FG'' and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'order by A.KodeBrg ',
                      ['N','N','Kode Barang','N','N', 'Nama Barang', 'Saldo','Saldo2'],
                      [1,1,25,1,1,70,15,15],QuBrows,EditBrows);
           end;
     4006: Begin
            SortBy:='KodeBrg';
             Viewitems('Select Isnull(A.PPH,0)PPH,A.KodeBrg,Case When Isnull(b.isJasa,0)=1 Then A.NamaBrg else B.NamaBrg end NamaBrg ,Qnt,Qnt2,Satuan,Nosat,Harga,Isi '+
                      'from dbSODet A '+
                      'left Outer Join dbBarang b On  b.kodebrg=a.KodeBrg ' +
                      'where A.NoBukti=:0 and (Isnull(b.isJasa,0)=1 or b.NamaBrg Like ''%JASA%'')and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or b.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'order by A.KodeBrg ',[IsiData],
                      ['N','N','Nama Barang', 'Qnt KP','N','Satuan','N','Harga','N'],
                      [1,1,70,15,1,25,1,15,1],QuBrows,EditBrows);
           end;
      40061: Begin
            SortBy:='KodeBrg';
             Viewitem('Select A.NoBukti,B2.NamaCustSupp '+
                      'from dbSODet A '+
                      'left Outer Join dbBarang b On  b.kodebrg=a.KodeBrg ' +
                      'left Outer Join dbSO b1 On  b1.NoBukti=a.NoBukti ' +
                      'left Outer Join dbCustSupp b2 On  b2.KodeCustSupp=b1.KodeCust ' +
                      'where B1.PPN in(1,2) and a.NoBukti Not in(select NoSO from dbInvoicePLdet Group By NoSO)and (Isnull(b.isJasa,0)=1 or b.NamaBrg Like ''%JASA%'')and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or b.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'Group by A.NoBukti,B2.NamaCustSupp ',
                      ['No. KP','Nama Cust.'],
                      [30,50],QuBrows,EditBrows);
           end;
      40062: Begin
            SortBy:='KodeBrg';
             Viewitem('Select A.NoBukti,B2.NamaCustSupp '+
                      'from dbSODet A '+
                      'left Outer Join dbBarang b On  b.kodebrg=a.KodeBrg ' +
                      'left Outer Join dbSO b1 On  b1.NoBukti=a.NoBukti ' +
                      'left Outer Join dbCustSupp b2 On  b2.KodeCustSupp=b1.KodeCust ' +
                      'where B1.PPN in(0) and a.NoBukti Not in(select NoSO from dbInvoicePLdet Group By NoSO)and (Isnull(b.isJasa,0)=1 or b.NamaBrg Like ''%JASA%'')and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or b.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'Group by A.NoBukti,B2.NamaCustSupp ',
                      ['No. KP','Nama Cust.'],
                      [30,50],QuBrows,EditBrows);
           end;
     2420112: begin // browse barang jadi ada stok
             SortBy:='KodeBrg';
             Viewitem('Select Isnull(NFix,0)Nfix,A.Isi2,A.KodeBrg,A.Sat1,A.Sat2, A.NamaBrg, Isnull(b.Qnt,0) QntSaldo, Isnull(b.Qnt2,0) Qnt2Saldo '+
                      'from dbBarang A '+
                      'left Outer Join (select a.Kodegdg,Kodebrg,Sum(SaldoQnt)Qnt,Sum(Saldo2Qnt)Qnt2 from DBStockBrg a Left Outer Join dbGudang b On a.KodeGdg=b.KodeGdg where a.Kodegdg='+QuotedStr(IsiData)+ ' and Bulan='+PeriodBln+' and Tahun='+PeriodThn+' group by a.Kodegdg,kodebrg)b On b.kodebrg=a.KodeBrg ' +
                      'where a.isAktif=1 and A.KodeGrp<>''FG'' and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'order by A.KodeBrg ',
                      ['N','N','Kode Barang','N','N', 'Nama Barang', 'Saldo','Saldo2'],
                      [1,1,25,1,1,70,15,15],QuBrows,EditBrows);
           end;
     24201124: begin // browse barang jadi ada stok
             SortBy:='KodeBrg';
             Viewitem('Select Isnull(NFix,0)Nfix,A.Isi2,A.KodeBrg,A.Sat1,A.Sat2, A.NamaBrg, Isnull(b.Qnt,0) QntSaldo, Isnull(b.Qnt2,0) Qnt2Saldo '+
                      'from dbBarang A '+
                      'left Outer Join (select a.Kodegdg,Kodebrg,Sum(SaldoQnt)Qnt,Sum(Saldo2Qnt)Qnt2 from DBStockBrg a Left Outer Join dbGudang b On a.KodeGdg=b.KodeGdg where a.Kodegdg='+QuotedStr(IsiData)+ ' and Bulan='+PeriodBln+' and Tahun='+PeriodThn+' group by a.Kodegdg,kodebrg)b On b.kodebrg=a.KodeBrg ' +
                      'where a.isAktif=1 and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'order by A.KodeBrg ',
                      ['N','N','Kode Barang','N','N', 'Nama Barang', 'Saldo','Saldo2'],
                      [1,1,25,1,1,70,15,15],QuBrows,EditBrows);
           end;
     2420117: begin // browse barang jadi ada stok
             SortBy:='KodeBrg';
             Viewitems('Select Isnull(NFix,0)Nfix,A.Isi2,A.KodeBrg,A.Sat1,A.Sat2, A.NamaBrg, Isnull(b.Qnt,0) QntSaldo, Isnull(b.Qnt2,0) Qnt2Saldo '+
                      'from dbBarang A '+
                      'left Outer Join (select a.Kodegdg,Kodebrg,Sum(QntSaldo)Qnt,Sum(Qnt2Saldo)Qnt2 from vwKartuStock a Left Outer Join dbGudang b On a.KodeGdg=b.KodeGdg where a.Kodegdg='+QuotedStr(IsiData)+ ' and Bulan='+PeriodBln+' and Tahun='+PeriodThn+' and Tanggal<=:0 group by a.Kodegdg,kodebrg)b On b.kodebrg=a.KodeBrg ' +
                      'where a.isAktif=1 and A.KodeGrp<>''FG'' and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'order by A.KodeBrg ', [TglAwal],
                      ['N','N','Kode Barang','N','N', 'Nama Barang', 'Saldo','Saldo2'],
                      [1,1,25,1,1,70,15,15],QuBrows,EditBrows);
           end;
    11110 :Begin
              Viewitem('Select (NoBukti)NoBukti,Urut,Kredit Nilai,NoMsk,NoFaktur from dbHutPiut where KodeCustSupp='+QuotedStr(IsiData)+'  '+
              ' and TipeTrans=''L'' and NoBukti Like ''%'+EditFilter.Text+'%''  ',['No. Bukti','N','Nilai','N','N'],[30,1,15,1,1],QuBrows,EditBrows);
           end;
    242011: begin // browse BPPB
             SortBy:='KodeBrg';
             Viewitems('Select Isnull(NFix,0)Nfix,Isi2,A.KodeBrg,A.Sat1,A.Sat2, A.NamaBrg, Isnull(b.Qnt,0) QntSaldo, Isnull(b.Qnt2,0) Qnt2Saldo,Case When c.KodeBrg Is null Then   '+
                      'A.Hrg1_2 else c.HPP end HPP '+
                      'from dbBarang A '+
                      'left Outer Join (select a.Kodegdg,Kodebrg,Sum(QntSaldo)Qnt,Sum(Qnt2Saldo)Qnt2 from vwKartuStock a Left Outer Join dbGudang b On a.KodeGdg=b.KodeGdg where a.Kodegdg='+QuotedStr(IsiData)+ ' and Bulan='+PeriodBln+' and Tahun='+PeriodThn+' and Tanggal<=:0 group by a.kodegdg,kodebrg)b On b.kodebrg=a.KodeBrg ' +
                      'Left Outer Join HPPSO c On c.KodeBrg=A.KodeBrg  '+
                      'where A.KodeGrp=''FG'' '+
                      //and (Isnull(b.Qnt,0)>0 or Isnull(b.Qnt2,0)>0) '+
                      ' and a.isAktif=1 and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'order by A.KodeBrg ',[TglAwal],
                      ['N','N','Kode Barang','N','N', 'Nama Barang', 'Saldo','HPP'],
                      [1,1,25,1,1,70,15,15],QuBrows,EditBrows);
           end;
    2420119: begin // browse BPPB
             SortBy:='KodeBrg';
             Viewitem('Select Isnull(NFix,0)Nfix,Isi2,A.KodeBrg,A.Sat1,A.Sat2, A.NamaBrg, 0 QntSaldo, 0 Qnt2Saldo,Case When c.KodeBrg Is null Then   '+
                      'A.Hrg1_2 else c.HPP end HPP '+
                      'from dbBarang A '+
                      '/*left Outer Join (select a.Kodegdg,Kodebrg,Sum(QntSaldo)Qnt,Sum(Qnt2Saldo)Qnt2 from vwKartuStock a Left Outer Join dbGudang b On a.KodeGdg=b.KodeGdg where a.Kodegdg='+QuotedStr(IsiData)+ ' and Bulan='+PeriodBln+' and Tahun='+PeriodThn+' and Tanggal<=1 group by a.kodegdg,kodebrg)b On b.kodebrg=a.KodeBrg*/ ' +
                      'Left Outer Join HPPSO c On c.KodeBrg=A.KodeBrg  '+
                      'where A.KodeGrp=''FG'' '+
                      //and (Isnull(b.Qnt,0)>0 or Isnull(b.Qnt2,0)>0) '+
                      ' and a.isAktif=1 and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'order by A.KodeBrg ',
                      ['N','N','Kode Barang','N','N', 'Nama Barang', 'N','N','N'],
                      [1,1,25,1,1,70,1,1,1],QuBrows,EditBrows);
           end;
    242012: begin // browse PPL
             SortBy:='KodeBrg';
             Viewitem('Select A.KodeBrg, A.NamaBrg, Isnull(Sisa,0) QntSaldo,QntBPPB,Stock,Isnull(IsJasa,0)IsJasa '+
                      'from dbBarang A '+
                      'left outer join (select a.Kodebrg,0.00 QntBPPB,Isnull(b.Qnt,0)Stock,0.00 Sisa from DBBPPBDET a '+
                      'left Outer Join (select Kodebrg,Sum(SaldoQnt)Qnt,Sum(Saldo2Qnt)Qnt2 from DBStockBrg where Bulan='+PeriodBln+' and Tahun='+PeriodThn+' group by kodebrg)b On b.kodebrg=a.KodeBrg group by a.KodeBrg,b.Qnt)b On a.KODEBRG=b.Kodebrg ' +
                      'where a.isAktif=1 and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      ' and (a.KodeGrp not in (''FG'',''SVC'') or Isnull(A.IsJasa,0)=1) '+
                      'order by A.KodeBrg ',
                      ['Kode Barang', 'Nama Barang', 'Saldo','N','N','N'],
                      [25,70,15,1,1,1],QuBrows,EditBrows);
           end;
    242013: begin // Browse Barang pada Pemakaian Bahan
             SortBy:='KodeBrg';
             Viewitems('select A.Urut, A.KodeBrg, Br.NamaBrg, Br.NFix, A.NoSat, case when A.NoSat=1 then Br.Sat1 else Br.Sat2 end Satuan, '+
                      ' A.QntSPK, A.QntPakai, A.QntSisa,Isnull(Br.QntMin,0)QntMin,Isnull(b3.Qnt,0) Saldo '+
                      ' from vwOutSPK_Pakai A '+
                      ' left outer join dbBarang Br on Br.KodeBrg=A.KodeBrg '+
                      ' left Outer Join (select a.Kodegdg,Kodebrg,Sum(QntSaldo)Qnt,Sum(Qnt2Saldo)Qnt2 from vwKartuStock a Left Outer Join dbGudang b On a.KodeGdg=b.KodeGdg where a.Kodegdg='+QuotedStr(isidata1)+ ' and Bulan='+PeriodBln+' and Tahun='+PeriodThn+' and Tanggal<=:0 group by a.Kodegdg,kodebrg)b3 On b3.kodebrg=br.KodeBrg ' +
                      ' where (A.NoBukti='+QuotedStr(NoKira1)+') and A.QntSisa>0 '+
                      ' and (A.KodeBrg like ''%'+EditFilter.Text+'%'' or Br.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      ' order by A.Urut ',[TglAwal],
                      ['N','Kode Barang','Nama Barang','N','N','Satuan','Qnt SPK','Qnt Pakai','Sisa','Qnt Min','Saldo'],
                      [1,22,40,1,1,5,12,12,12,12,12],QuBrows,EditBrows);
           end;
     2420131: begin // Browse Barang pada Pemakaian Bahan
             SortBy:='KodeBrg';
             Viewitems('select 0 Urut, A.KodeBrg, A.NamaBrg, A.NFix,1 Nosat, sat1 Satuan, '+
                      ' 0.0 QntSPK, 0.0 QntPakai, 0.0 QntSisa,Isnull(A.QntMin,0)QntMin,Isnull(b3.Qnt,0) Saldo,Isnull(isJasa,0)IsJasa '+
                      ' from  dbBarang A '+
                       ' left Outer Join (select a.Kodegdg,Kodebrg,Sum(QntSaldo)Qnt,Sum(Qnt2Saldo)Qnt2 from vwKartuStock a Left Outer Join dbGudang b On a.KodeGdg=b.KodeGdg where a.Kodegdg='+QuotedStr(isidata1)+ ' and Bulan='+PeriodBln+' and Tahun='+PeriodThn+' and Tanggal<=:0 group by a.Kodegdg,kodebrg)b3 On b3.kodebrg=a.KodeBrg ' +
                      ' where KodeGrp not in(''FG'',''SVC'') and a.isAktif=1 and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      ' order by A.KodeBrg ',[TglAwal],
                      ['N','Kode Barang','Nama Barang','N','N','Satuan','N','N','N','Qnt Min','Saldo'],
                      [1,22,40,1,1,5,1,1,1,12,12],QuBrows,EditBrows);
           end;
    242014: begin  //brwse PPL
             SortBy:='Nobukti';
             Viewitem('select a.NoBukti from DBPPLDET a  '+
                      'Left Outer Join (select NoPPL,Kodebrg,SUM(Qnt*isi)Qnt from DBPODET group by NoPPL,Kodebrg)b On a.Nobukti=b.NoPPL and a.kodebrg=b.KODEBRG  '+
                      'left Outer Join DBBARANG c On c.KODEBRG=a.kodebrg '+
                      'group by a.NoBukti,b.Qnt  ' +
                      'having SUM(a.Qnt*isi)-Isnull(b.Qnt,0)<>0 '+
                      'and (a.NoBukti like ''%'+EditFilter.Text+'%'' ) ',
                      ['NoBukti'],
                      [25],QuBrows,EditBrows);
            end;
    242015: begin  //brwse PPL barang
             SortBy:='Nobukti';
             Viewitem('select a.KodeBrg, a.NamaBrg, a.Sat, a.NoSat, a.Isi, a.Qnt, a.QntPO, a.SisaPPL Sisa, a.NoBukti, a.Urut,a.tolerate '+
                      'from vwOutPPL a  '+
                      'where (A.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'order by a.KodeBrg, a.NoSat, a.NoBukti',
                      ['Kode Barang','Nama Barang','Sat','N','N','Qnt PR','Qnt PO','Sisa PR','No. PR','N'],
                      [18,45,6,1,1,10,10,10,22,1],QuBrows,EditBrows);
            end;
    242016: begin  //brwse PB
            SortBy:='Nobukti';
            Viewitem('Select A.Nobukti, C.Tanggal'+#13+
                     'From DBPenyerahanBhnDET A'+#13+
                     '     left outer join (Select x.NoPenyerahanBHN,  SUM(x.Qnt) Qnt, SUM(x.Qnt2) Qnt2'+#13+
                     '                      from DBRPenyerahanBhnDET x'+#13+
                     '                           left outer join DBRPenyerahanBhn y on y.Nobukti=x.Nobukti'+#13+
                     '                      Group by x.NoPenyerahanBHN) B on B.NoPenyerahanBHN=A.Nobukti'+#13+
                     '     left outer join DBPenyerahanBhn c on c.Nobukti=A.Nobukti'+#13+
                     'where Cast(Case when Case when C.IsOtorisasi1=1 then 1 else 0 end+'+#13+
                     '                       Case when C.IsOtorisasi2=1 then 1 else 0 end+'+#13+
                     '                       Case when C.IsOtorisasi3=1 then 1 else 0 end+'+#13+
                     '                       Case when C.IsOtorisasi4=1 then 1 else 0 end+'+#13+
                     '                       Case when C.IsOtorisasi5=1 then 1 else 0 end=C.MaxOL then 0'+#13+
                     '                  else 1'+#13+
                     '             end As Bit)=0 and ((A.Qnt-isnull(B.Qnt,0)>0) or (A.Qnt2-isnull(B.Qnt2,0)>0)) and C.IsSampel='+IntToStr(GrpTipe)+#13+
                     'where (A.Nobukti like ''%'+EditFilter.Text+'%'' ) '+
                     'Group by A.Nobukti, C.Tanggal',
                     ['No. Bukti', 'Tanggal'],
                     [45,50],QuBrows,EditBrows);
            end;
    20551  : begin // Supplier/ Customer
               if (UpperCase(NoKira1)='PT') or (UpperCase(NoKira1)='UPT') then
                 xStrSQL:=' A.IsCustomer=1 '
               else if UpperCase(NoKira1)='HT' then
                 xStrSQL:=' A.IsSupplier=1 '
               else if UpperCase(NoKira1)='EX' then
                 xStrSQL:=' A.IsExpedisi=1 ';
               ViewItem('select distinct A.KodeCustSupp, A.NamaCustSupp, A.AlamatKota, A.NamaKota, A.IsPPN, A.Hari, A.HariHutPiut '+
               ' from vwBrowsCustSupp A '+
               ' where '+xStrSQL+' and (A.KodeCustSupp like ''%'+EditFilter.Text+'%'' or A.NamaCustSupp like ''%'+EditFilter.Text+'%'') '+
               ' order by A.KodeCustSupp',
               ['Kode', 'Nama','N','Kota','N','N','N'],
               [15,40,1,25,1,1,1], QuBrows, EditBrows);
             end;
     25651  : begin
               if NoKira2='UPT' then
                 xStrSQL:='-1*'
               else xStrSQL:='';
               ViewItem('select A.NoFaktur, MIN(A.Tanggal) Tanggal, max(case when isnull(A.KodeVls_,'''')='''' then ''IDR'' else A.KodeVls_ end) Valas, '+
               ' max(case when isnull(A.Kurs_,0)=0 then 1 else A.Kurs_ end) Kurs, '+xStrSQL+'sum(A.Debet-A.Kredit) SisaRp, '+xStrSQL+'SUM(A.DebetD-A.KreditD) SisaVls '+
               ' from DBHUTPIUT A '+
               ' where A.KodeCustSupp='+QuotedStr(NoKira1)+
               //' and A.Perkiraan in (select Perkiraan from dbPostHutPiut where Kode='+QuotedStr(NoKira2)+')'+
               ' and A.Tipe='+QuotedStr(RightStr(NoKira2,2))+
               ' group by A.NoFaktur '+
               ' having ('+xStrSQL+'sum(A.Debet-A.Kredit)>0 or '+xStrSQL+'SUM(A.DebetD-A.KreditD)>0) '+
               ' and (A.NoFaktur like ''%'+EditFilter.Text+'%'' ) '+
               ' order by MIN(A.Tanggal) ',
               ['No. Uang Muka','Tanggal','Valas','Kurs','Sisa Rp','Sisa $'], [25,15,15,15,15,15], QuBrows, EditBrows);
             end;
     242017: begin  //brwse PB
            SortBy:='Nobukti';
            Viewitem('Select A.Nobukti, A.urut, A.kodebrg, d.NAMABRG, A.Qnt,A.Qnt2, A.Isi, A.NoSat, (A.Qnt-isnull(B.Qnt,0)) QntSisa,(A.Qnt2-isnull(B.Qnt2,0)) Qnt2Sisa,'+#13+
                     '       d.NFix'+#13+
                     'From DBPenyerahanBhnDET A'+#13+
                     '     left outer join (Select x.NoPenyerahanBHN,x.UrutPenyerahanBHN,  SUM(x.Qnt) Qnt, SUM(x.Qnt2) Qnt2'+#13+
                     '                      from DBRPenyerahanBhnDET x'+#13+
                     '                           left outer join DBRPenyerahanBhn y on y.Nobukti=x.Nobukti'+#13+
                     '                      Group by x.NoPenyerahanBHN, x.urutPenyerahanBHN) B on B.NoPenyerahanBHN=A.Nobukti and B.urutPenyerahanBHN=A.urut'+#13+
                     '     left outer join DBPenyerahanBhn c on c.Nobukti=A.Nobukti'+#13+
                     '     left Outer join DBBARANG d on d.KODEBRG=a.kodebrg'+#13+
                     'where Cast(Case when Case when C.IsOtorisasi1=1 then 1 else 0 end+'+#13+
                     '                       Case when C.IsOtorisasi2=1 then 1 else 0 end+'+#13+
                     '                       Case when C.IsOtorisasi3=1 then 1 else 0 end+'+#13+
                     '                       Case when C.IsOtorisasi4=1 then 1 else 0 end+'+#13+
                     '                       Case when C.IsOtorisasi5=1 then 1 else 0 end=C.MaxOL then 0'+#13+
                     '                  else 1'+#13+
                     '             end As Bit)=0 and ((A.Qnt-isnull(B.Qnt,0)>0) or (A.Qnt2-isnull(B.Qnt2,0)>0))'+#13+
                     '      and A.nobukti='+QuotedStr(NoKira)+' and C.IsSampel='+IntToStr(GrpTipe)+#13+
                     'and (A.Nobukti like ''%'+EditFilter.Text+'%'' or A.kodebrg like ''%'+EditFilter.Text+'%'' or d.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                     'Order by A.kodebrg',
                     ['N','N','Kode Brg.','Nama Brg.','N','N','N','N','Saldo','Saldo2','N'],
                     [1,1,25,50,1,1,1,1,15,15,1],QuBrows,EditBrows);
            end;
    242018: begin  //brwse Beli Utk Invoice
            SortBy:='Nobukti';
            Viewitem('select a.NoBukti,a.KodeSupp,NamaCustSupp,Sum(NDPP)NDPP,Sum(NPPN)NPPN,Sum(NNET)NNET from dbBeli a  '+
                     'Left Outer Join dbBeliDet b On a.NoBukti=b.noBukti      '+
                     'Left Outer join dbCustSupp c On c.KodeCustSupp=a.KodeSupp  '+
                     'where a.NoBukti Not in(select NoBeli from dbInvoiceDet)  '+
                     'and (A.Nobukti like ''%'+EditFilter.Text+'%'' or a.KodeSupp like ''%'+EditFilter.Text+'%'' or NamaCustSupp like ''%'+EditFilter.Text+'%'') '+
                     'Group by a.NoBukti,a.KodeSupp,NamaCustSupp',
                     ['No. Pemebelian','N','Nama Supp.','Nilai DPP','Nilai PPN','Nilai Net'],
                     [25,1,20,15,15,15],QuBrows,EditBrows);

            end;
    2420182: begin  //brwse  Utk Invoice PL
            SortBy:='Nobukti';
            Viewitem('select a.NoBukti,a.KodeSupp,NamaCustSupp,Sum(NDPP)NDPP,Sum(NPPN)NPPN,Sum(NNET)NNET from dbInvoicePL a  '+
                     'Left Outer Join dbInvoicePLDet b On a.NoBukti=b.noBukti      '+
                     'Left Outer join dbCustSupp c On c.KodeCustSupp=a.KodeSupp  '+
                     'where (A.Nobukti like ''%'+EditFilter.Text+'%'' or a.KodeSupp like ''%'+EditFilter.Text+'%'' or NamaCustSupp like ''%'+EditFilter.Text+'%'') '+
                     'Group by a.NoBukti,a.KodeSupp,NamaCustSupp',
                     ['No. Pemebelian','N','Nama Supp.','Nilai DPP','Nilai PPN','Nilai Net'],
                     [25,1,20,15,15,15],QuBrows,EditBrows);

            end;
    2420181 : begin
              SortBy:='Nobukti';
              ViewItem('select NOBukti,KodeVls,Kurs,PPN,TipeBayar,Hari from dbPO  '+
                       'where KodeSupp='+QuotedStr(IsiData)+' and NoBukti Not In(Select Isnull(NoPO,'''') from dbInvoice) and isotorisasi1=1 '+
                       'and (NOBukti like ''%'+EditFilter.Text+'%'' or KodeVls like ''%'+EditFilter.Text+'%'' ) '+
                       'order by NoBukti ' ,
              ['No. PO','N','N','N','N','N'],
              [30,1,1,1,1,1], QuBrows, EditBrows);
            end;
    242019: begin  //brwse SPK barang
             SortBy:='Nobukti';
             Viewitem('select a.KodeBrg, b.NamaBrg, a.Satuan Sat, a.NoSat, a.Isi, Sum(a.QntSPK) QntSPK, Sum(a.QntPPL) QntPPL, Sum(a.QntSisa) QntSisa, a.NoBukti, a.Urut,0 tolerate, A.nosat NosatSPK  '+
                      'from vwOutSPK_PPL a  '+
                      'left outer join DBBARANG b on b.KODEBRG=a.kodebrg '+
                      ' where a.nobukti='+QuotedStr(NoKira)+
                      ' and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or b.NamaBrg like ''%'+EditFilter.Text+'%'' ) '+
                      ' Group by a.KodeBrg, b.NamaBrg, a.Satuan , a.NoSat, a.Isi, a.NoBukti, a.Urut'+
                      ' order by a.KodeBrg, a.NoSat, a.NoBukti ',
                      ['Kode Barang','Nama Barang','Sat','N','N','Qnt PR','Qnt PO','Sisa PR','No. PR','N','N'],
                      [18,45,6,1,1,10,10,10,22,1,1],QuBrows,EditBrows);
            end;
    243010: begin // Browse No. BPPB pada Penyerahan Barang
             SortBy:='KodeBrg';
             Viewitem('Select A.NoBukti, A.Tanggal, A.KodeGdgT, A.KDDep, Dp.NmDep '+
                      ' from vwOutBPPB A0 '+
                      ' left outer join dbBPPB A on A.NoBukti=A0.NoBukti '+
                      ' left outer join DBDEPART Dp on Dp.KDDEP=A.KDDEP '+
                      ' where A0.QntSisa>0 and a.isotorisasi1=1 '+
                      ' and (A.NoBukti like ''%'+EditFilter.Text+'%'' or A.KodeGdgT like ''%'+EditFilter.Text+'%'' or Dp.NmDep like ''%'+EditFilter.Text+'%'') '+
                      ' group by A.NoBukti, A.Tanggal, A.KodeGdg, A.KDDep, Dp.NmDep '+
                      ' order by A.Tanggal, A.NoBukti ',
                      ['No. Bukti','Tanggal','Gudang','N','Departemen'],
                      [25,15,10,1,25],QuBrows,EditBrows);
           end;
    243011: begin // Browse Barang pada Penyerahan Barang
             SortBy:='KodeBrg';
             Viewitem('select A.Urut, A.KodeBrg, Br.NamaBrg, Br.NFix, A.NoSat, case when A.NoSat=1 then Br.Sat1 else Br.Sat2 end Satuan, '+
                      '       case when A.NoSat=1 then A.Qnt else A.Qnt2 End Qnt,'+#13+
                      '       case when A.NoSat=1 then A.QntBPPBT else A.Qnt2BPPBT End QntBPPBT,'+#13+
                      '       case when A.NoSat=1 then A.QntSisa else A.Qnt2Sisa End QntSisa'+#13+
                      ' from vwOutBPPB A '+
                      ' left outer join dbBarang Br on Br.KodeBrg=A.KodeBrg '+
                      ' where A.NoBukti='+QuotedStr(NoKira1)+' and A.QntSisa>0 '+
                      ' and (A.KodeBrg like ''%'+EditFilter.Text+'%'' or Br.NamaBrg like ''%'+EditFilter.Text+'%'' ) '+
                      ' order by A.Urut ',
                      ['N','Kode Barang','Nama Barang','N','N','Satuan','Minta','Terima','Sisa'],
                      [1,22,40,1,1,5,12,12,12],QuBrows,EditBrows);
           end;
    243012: begin // Browse No. SPK pada Pemakaian Bahan
             SortBy:='KodeBrg';
             Viewitem('Select A.NoBukti, A.Tanggal, A.KodeGdg '+
                      ' from vwOutSPK_Pakai A0 '+
                      ' left outer join dbSPK A on A.NoBukti=A0.NoBukti '+
                      ' where A0.QntSisa>0 '+
                      ' and (A.NoBukti like ''%'+EditFilter.Text+'%'' or A.KodeGdg like ''%'+EditFilter.Text+'%'' ) '+
                      ' group by A.NoBukti, A.Tanggal, A.KodeGdg '+
                      ' order by A.Tanggal, A.NoBukti ',
                      ['No. Bukti','Tanggal','Gudang'],
                      [25,15,10],QuBrows,EditBrows);
           end;
    110013 : begin
              ViewItem('select a.KodeGrp,a.Nama from dbGroup a '+
                       'where KodeGrp ='+QuotedStr(IsiData)+'  '+
                       'and (a.KodeGrp like ''%'+EditFilter.Text+'%'' or a.Nama like ''%'+EditFilter.Text+'%'' ) '+
                       'order by a.KodeGrp',
              ['Kode Group','Nama'],
              [15, 30], QuBrows, EditBrows);
            end;
    11001311 : begin
              ViewItem('select Qnt from dbKonversi  '+
                       'order by Qnt',
              ['Konversi'],
              [15], QuBrows, EditBrows);
            end;

     110014 : begin
              ViewItem('select a.KodeGrp,b.Nama,a.KodeSubGrp,a.NamaSubGrp from dbSubGroup a Left Outer Join dbGroup b on a.KodeGrp=b.KodeGrp '+
                       'where a.Kodegrp in(''FG'',''SVC'') and a.Kodegrp='+QuotedStr(isidata1)+' and (a.KodeSubGrp Like  ''%'+EditFilter.Text+'%'' or a.NamaSubGrp Like  ''%'+EditFilter.Text+'%'') order by a.KodeSubGrp',
              ['Kode Group','Nama', 'Kode Sub','Nama Sub'],
              [10, 30, 20, 30], QuBrows, EditBrows);
            end;
    110012 : begin
              ViewItem('select Nama,KodeGrp  from dbGroup '+
                       'where KodeGrp Like  ''%'+IsiData+'%''  '+
                       'and (Nama like ''%'+EditFilter.Text+'%'' or KodeGrp like ''%'+EditFilter.Text+'%'' ) '+
                       'order by KodeGrp',
              ['Nama', 'Kode Group'],
              [30, 10], QuBrows, EditBrows);
            end;
    11001212 : begin
              ViewItem('select Nama,KodeGrp  from dbGroup '+
                       'where KodeGrp Not in(''FG'',''SVC'')  '+
                       'and (Nama like ''%'+EditFilter.Text+'%'' or KodeGrp like ''%'+EditFilter.Text+'%'' ) '+
                       'order by KodeGrp',
              ['Nama', 'Kode Group'],
              [30, 10], QuBrows, EditBrows);
            end;
    1002  : begin
              ViewItem('select Kodebag,Namabag from dbbagian '+
                       'where (Kodebag like ''%'+EditFilter.Text+'%'' or Namabag like ''%'+EditFilter.Text+'%'' ) '+
                       'order by Kodebag',
              ['Kode Bagian', 'Nama Bagian'],
              [15, 50], QuBrows, EditBrows);
            end;
    10021  : begin
              ViewItem('select KdDep,NmDep from dbDepart where Isnull(IsSetPass,0)=1 '+
                       'and (KdDep like ''%'+EditFilter.Text+'%'' or NmDep like ''%'+EditFilter.Text+'%'' ) '+
                       'order by KdDep',
              ['Kode Dept.', 'Nama Dept.'],
              [15, 50], QuBrows, EditBrows);
            end;
    10022  : begin
              ViewItem('select KdDep,NmDep from dbDepart where Isnull(IsSetPass,0)=0 '+
                       'and (KdDep like ''%'+EditFilter.Text+'%'' or NmDep like ''%'+EditFilter.Text+'%'' ) '+
                       'order by KdDep',
              ['Kode Dept.', 'Nama Dept.'],
              [15, 50], QuBrows, EditBrows);
            end;
    1003  : begin
              ViewItem('select KodeJab,Namajab from dbjabatan '+
                       'where (KodeJab like ''%'+EditFilter.Text+'%'' or Namajab like ''%'+EditFilter.Text+'%'' ) '+
                       'order by Kodejab',
              ['Kode Jabatan', 'Nama Jabatan'],
              [15, 50], QuBrows, EditBrows);
            end;
    1004  : begin
              ViewItem('select Devisi,NamaDevisi from dbDevisi '+
                       'where (Devisi like ''%'+EditFilter.Text+'%'' or NamaDevisi like ''%'+EditFilter.Text+'%'' ) '+
                       'order by Devisi',
              ['Kode Devisi', 'Nama Devisi'],
              [15, 50], QuBrows, EditBrows);
            end;
  100400  : begin
              ViewItem('select Perkiraan,keterangan from dbPerkiraan where tipe=1 and '+
                       'perkiraan not in (select Perkiraan from dbposthutpiut) '+
                       'and (Perkiraan like ''%'+EditFilter.Text+'%'' or keterangan like ''%'+EditFilter.Text+'%'' ) '+
                       'order by Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
  1004001  : begin
              ViewItem('select Perkiraan,keterangan from dbPerkiraan where  '+
                       '(perkiraan like ''%'+EditFilter.Text+'%'' or keterangan like ''%'+EditFilter.Text+'%'')  '+
                       '  order by Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
  100400107  : begin
              ViewItem('select Perkiraan,keterangan from dbPerkiraan where  '+
                       '(perkiraan like ''%'+EditFilter.Text+'%'' or keterangan like ''%'+EditFilter.Text+'%'')  '+
                       ' and  ((Left(Perkiraan,1)=''9'' and Tipe=1)or (Keterangan Like ''%Persediaan%'' and Tipe=1))  '+
                       '  order by Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
  100401  : begin
              ViewItem('select a.Perkiraan,b.keterangan from dbposthutpiut a '+
                       'left outer join dbperkiraan b on b.perkiraan=a.perkiraan '+
                       'where a.Kode=''AKV'' '+
                       'and (a.Perkiraan like ''%'+EditFilter.Text+'%'' or b.keterangan like ''%'+EditFilter.Text+'%'' ) '+
                       'order by a.Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
  100402  : begin
              ViewItem('select a.Perkiraan,b.keterangan from dbposthutpiut a '+
                       'left outer join dbperkiraan b on b.perkiraan=a.perkiraan '+
                       'where a.Kode=''AKM''  '+
                       'and (a.Perkiraan like ''%'+EditFilter.Text+'%'' or b.keterangan like ''%'+EditFilter.Text+'%'' ) '+
                       'order by a.Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
  100403  : begin
              ViewItem('select a.Perkiraan,b.keterangan from dbposthutpiut a '+
                       'left outer join dbperkiraan b on b.perkiraan=a.perkiraan '+
                       'where a.Kode=''KAS'' and (A.Perkiraan like ''%'+EditFilter.Text+'%'') order by a.Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
  100404  : begin
              ViewItem('select a.Perkiraan,b.keterangan from dbposthutpiut a '+
                       'left outer join dbperkiraan b on b.perkiraan=a.perkiraan '+
                       'where a.Kode=''BANK'' and (A.Perkiraan like ''%'+EditFilter.Text+'%'')order by a.Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
  100405  : begin
              ViewItem('Select Bank, Nogiro, TglGiro, Case when kodevls=''IDR'' then KreditRp else Kredit end jumlah, '+
                       ' KodeVls, Kurs, Keterangan from dbGiro where Tipe=''HT'' '+
                       ' and TglCair is null '+
                       ' and (NoGiro like '+QuotedStr('%'+EditFilter.Text+'%')+') and Bank='+QuotedStr(IsiData)+'  '+
                       ' Order by Bank, Nogiro, TglGiro ',
              ['Bank', 'No. Giro','Tgl Giro Jatuh Tempo','Jumlah','Valas','Kurs','Keterangan'],
              [15,15,15,15,5,12,50], QuBrows, EditBrows);
            end;
  100406  : begin
              ViewItem('Select Bank, Nogiro, TglGiro, Case when kodevls=''IDR'' then DebetRp else Debet end jumlah, '+
                       'KodeVls, Kurs, Keterangan from dbGiro where Tipe=''PT'' '+
                       'and (Bank like ''%'+EditFilter.Text+'%'' or Nogiro like ''%'+EditFilter.Text+'%'' ) '+
                       'and TglCair is null '+
                       'Order by Bank, Nogiro, TglGiro ',
              ['Bank', 'No. Giro','Tgl Giro Jatuh Tempo','Jumlah','Valas','Kurs','Keterangan'],
              [15,15,12,12,5,9,50], QuBrows, EditBrows);
            end;
  1004061  : begin
              ViewItem('Select Bank, Nogiro, TglGiro, Case when kodevls=''IDR'' then DebetRp else Debet end jumlah, '+
                       'KodeVls, Kurs, Keterangan from dbGiro where Tipe=''PT'' '+
                       'and TglCair is null and Kas ='+QuotedStr(IsiData)  +
                       ' and (Bank like ''%'+EditFilter.Text+'%'' or Nogiro like ''%'+EditFilter.Text+'%'' ) '+
                       'Order by Bank, Nogiro, TglGiro ',
              ['Bank', 'No. Giro','Tgl Giro Jatuh Tempo','Jumlah','Valas','Kurs','Keterangan'],
              [15,15,12,12,5,9,50], QuBrows, EditBrows);
             end;
  100407  : begin
              ViewItems('Select A.Devisi,b.NamaBag,A.Perkiraan, A.Keterangan,A.Tanggal, '+
                       '       Case when A.Tipe=''L'' then ''[L]urus'' '+
                       '            when A.Tipe=''M'' then ''[M]enurun'' '+
                       '            when A.Tipe=''P'' then ''[P]ajak'' '+
                       '            else '''' '+
                       '       end Metode,A.Persen,A.Quantity,A.Kodebag, '+
                       '       A.Akumulasi, D.Keterangan NamaAkumulasi,'+
                       '       A.Nomuka,C.Keterangan NamaGroupAktiva,A.noBelakang,A.NoBelakang2, A.Biaya,a.biaya2,a.persenbiaya1,a.persenbiaya2,'+
                       '       E.NamaDevisi,a.TipeAktiva,a.Kelompok '+
                       'From DBAktiva A '+
                       '     left outer join dbBagian b on b.kodebag=a.kodebag '+
                       '     left outer join dbperkiraan c on c.perkiraan=a.Nomuka and c.tipe=1 '+
                       '     left outer join dbperkiraan d on d.perkiraan=a.Akumulasi and d.Tipe=1 '+
                       '     left outer join dbDevisi e on e.Devisi=a.Devisi '+
                       'Where A.NoMuka=:0 or A.Akumulasi=:1 '+
                       'and (A.Perkiraan like ''%'+EditFilter.Text+'%'' or b.NamaBag like ''%'+EditFilter.Text+'%'' ) '+
                       'Order by A.Perkiraan  ',[NoKira,NoKira],
              //['Devisi','Bagian', 'Kode Aktiva', 'Keterangan','Tanggal', 'Metode','Susut (%)','Qty',
              ['Devisi','Bagian', 'Kode Aktiva', 'Keterangan','Tanggal',
               'N','N','N','N','N',
               'N','N','N','N','N',
               'N','N','N','N','N',
               'N','N'],
              [15,25,26,50,12,
               1,1,1,1,1,
               1,1,1,1,1,
               1,1,1,1,1,
               1,1], QuBrows, EditBrows);
            end;
  100408  : begin
              ViewItem('select a.Perkiraan,b.keterangan from dbposthutpiut a '+
                       'left outer join dbperkiraan b on b.perkiraan=a.perkiraan '+
                       'where a.Kode=''PT''  '+
                       'and (A.Perkiraan like ''%'+EditFilter.Text+'%'' or b.keterangan like ''%'+EditFilter.Text+'%'' ) '+
                       'order by a.Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
  100409  : begin
              ViewItem('select a.Perkiraan,b.keterangan from dbposthutpiut a '+
                       'left outer join dbperkiraan b on b.perkiraan=a.perkiraan '+
                       'where a.Kode=''HT''  '+
                       'and (A.Perkiraan like ''%'+EditFilter.Text+'%'' or b.keterangan like ''%'+EditFilter.Text+'%'' ) '+
                       'order by a.Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
  100410  : begin
              ViewItem('select a.Perkiraan,b.keterangan from dbposthutpiut a '+
                       'left outer join dbperkiraan b on b.perkiraan=a.perkiraan '+
                       'where a.Kode=''DP'' and (A.Perkiraan like ''%'+EditFilter.Text+'%'') order by a.Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
  100411  : begin
              ViewItem('Select Bank, NoDeposito, TglJatuhTempo, Case when kodevls=''IDR'' then DebetRp else Debet end jumlah, '+
                       'KodeVls, Kurs, Keterangan from dbDeposito where TglCair is null '+
                       'and (Bank like ''%'+EditFilter.Text+'%'' or NoDeposito like ''%'+EditFilter.Text+'%'' ) '+
                       'Order by Bank, NoDeposito, TgljatuhTempo ',
              ['Bank', 'No. Deposito','Tgl Deposito Jatuh Tempo','Jumlah','Valas','Kurs','Keterangan'],
              [15,15,12,12,5,9,50], QuBrows, EditBrows);
            end;
  100412  : begin
              ViewItems('Select A.Devisi,b.NamaBag,A.Perkiraan, A.Keterangan,A.Tanggal, '+
                       '       Case when A.Tipe=''L'' then ''[L]urus'' '+
                       '            when A.Tipe=''M'' then ''[M]enurun'' '+
                       '            when A.Tipe=''P'' then ''[P]ajak'' '+
                       '            else '''' '+
                       '       end Metode,A.Persen,A.Quantity,A.Kodebag, '+
                       '       A.Akumulasi, D.Keterangan NamaAkumulasi,'+
                       '       A.Nomuka,C.Keterangan NamaGroupAktiva,A.noBelakang,A.NoBelakang2, A.Biaya,a.biaya2,a.persenbiaya1,a.persenbiaya2,'+
                       '       E.NamaDevisi,a.TipeAktiva '+
                       'From DBAktiva A '+
                       '     left outer join dbBagian b on b.kodebag=a.kodebag '+
                       '     left outer join dbperkiraan c on c.perkiraan=a.Nomuka and c.tipe=1 '+
                       '     left outer join dbperkiraan d on d.perkiraan=a.Akumulasi and d.Tipe=1 '+
                       '     left outer join dbDevisi e on e.Devisi=a.Devisi '+
                       'Where A.NoMuka=:0 and A.Kelompok=0  '+
                       'and (b.NamaBag like ''%'+EditFilter.Text+'%'' or A.Perkiraan like ''%'+EditFilter.Text+'%'' or A.Keterangan like ''%'+EditFilter.Text+'%'' ) '+
                       'Order by A.Perkiraan  ',[NoKira],
              //['Devisi','Bagian', 'Kode Aktiva', 'Keterangan','Tanggal', 'Metode','Susut (%)','Qty',
              ['Devisi','Bagian', 'Kode Aktiva', 'Keterangan','Tanggal', 'N','N','N',
               'N','N','N','N','N','N','N','N','N','N','N','N','N'],
              [15,25,26,50,12,25,12,12,1,1,1,1,1,1,1,1,1,1,1,1,1], QuBrows, EditBrows);
            end;
   100413  : begin
              ViewItem('Select A.Devisi,b.NamaBag,A.Perkiraan, A.Keterangan,A.Tanggal, '+
                       '       Case when A.Tipe=''L'' then ''[L]urus'' '+
                       '            when A.Tipe=''M'' then ''[M]enurun'' '+
                       '            when A.Tipe=''P'' then ''[P]ajak'' '+
                       '            else '''' '+
                       '       end Metode,A.Persen,A.Quantity,A.Kodebag, '+
                       '       A.Akumulasi, D.Keterangan NamaAkumulasi,'+
                       '       A.Nomuka,C.Keterangan NamaGroupAktiva,A.noBelakang,A.NoBelakang2, A.Biaya,a.biaya2,a.persenbiaya1,a.persenbiaya2,'+
                       '       E.NamaDevisi,a.TipeAktiva '+
                       'From DBAktiva A '+
                       '     left outer join dbBagian b on b.kodebag=a.kodebag '+
                       '     left outer join dbperkiraan c on c.perkiraan=a.Nomuka and c.tipe=1 '+
                       '     left outer join dbperkiraan d on d.perkiraan=a.Akumulasi and d.Tipe=1 '+
                       '     left outer join dbDevisi e on e.Devisi=a.Devisi '+
                       'Where A.Kelompok=0   '+
                       'and (b.NamaBag like ''%'+EditFilter.Text+'%'' or A.Perkiraan like ''%'+EditFilter.Text+'%'' or A.Keterangan like ''%'+EditFilter.Text+'%'' ) '+
                       'Order by A.Perkiraan  ',
              ['Devisi','Bagian', 'Kode Aktiva', 'Keterangan','Tanggal', 'N','N','N',
               'N','N','N','N','N','N','N','N','N','N','N','N','N'],
              [15,25,26,50,12,25,12,12,1,1,1,1,1,1,1,1,1,1,1,1,1], QuBrows, EditBrows);
            end;
    100414  : begin
              ViewItem('select a.Perkiraan, b.keterangan '+
                       'from dbposthutpiut a '+
                       'left outer join dbperkiraan b on b.perkiraan=a.perkiraan '+
                       'where a.Kode in (''HT'',''PT'',''UHT'',''UPT'') and '+
                       'a.Perkiraan not in (Select Perkiraan from dbperkcustsupp where kodecustsupp='+QuotedStr(Nokira)+')   '+
                       'and (A.Perkiraan like ''%'+EditFilter.Text+'%'' or b.Keterangan like ''%'+EditFilter.Text+'%'' ) '+
                       'order by a.Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
    1005  : begin
              ViewItem('select Perkiraan,Keterangan from dbPerkiraan a where  tipe=1  and (a.Keterangan like ''%'+EditFilter.Text+'%'' or a.Perkiraan like ''%'+EditFilter.Text+'%'') order by Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
   10051  : begin
              ViewItems('select a.Perkiraan,a.Keterangan from dbPerkiraan a '+
                        'left Outer join dbAksesPerkiraan b on b.perkiraan=a.Perkiraan '+
                        'where  a.tipe=1 and a.Perkiraan<>:1 and b.Userid='+QuotedStr(IDUser)+
                        ' and (a.Keterangan like ''%'+EditFilter.Text+'%'' or a.Perkiraan like ''%'+EditFilter.Text+'%'') '+
                        'order by a.Perkiraan',
              [NoKira],
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
   10052  : begin
              ViewItem('select Perkiraan,Keterangan from dbPerkiraan where and (Keterangan like ''%'+EditFilter.Text+'%'' or Perkiraan like ''%'+EditFilter.Text+'%'') order by Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
   1250  : begin
              ViewItem('select KodeExp,NamaExp, Alamat1, Alamat2, Kota from dbExpedisi '+
                       'where (KodeExp like ''%'+EditFilter.Text+'%'' or NamaExp like ''%'+EditFilter.Text+'%'' ) '+
                       'order by KodeExp',
              ['Kode Ekspedisi', 'Nama EksPedisi', 'N','N','N'],
              [20, 50,1,1,1], QuBrows, EditBrows);
            end;
   10053  : begin
              ViewItem('select Perkiraan, Keterangan from dbPerkiraan where Tipe=1 and Perkiraan Like ''153%'' '+
                       'and (Perkiraan like ''%'+EditFilter.Text+'%'' or NamaExp like ''%'+EditFilter.Text+'%'' ) '+
                       'order by Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
    10054  :begin
              ViewItemS('select Nomor, Keterangan from dbLRHPP where IsLRHPP=:0 and Bulan=:1 and Tahun=:2 '+
                        'and (Nomor like ''%'+EditFilter.Text+'%'' or Keterangan like ''%'+EditFilter.Text+'%'' ) '+
                        'order by Nomor',
              [isTampil,brBulan, BrTahun],['Nomor', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
    10055  :begin
              ViewItems('Select A.Perkiraan,A.Keterangan '+
                       'From DBPERKIRAAN A '+
                       '     left Outer join DBAKSESPERKIRAAN B on B.Perkiraan=A.Perkiraan '+
                       '     left Outer join DBPOSTHUTPIUT C on C.Perkiraan=A.Perkiraan '+
                       'where B.UserID='+QuotedStr(IDUser)+'  and C.Kode=:0 and (a.Keterangan like ''%'+EditFilter.Text+'%'' or a.Perkiraan like ''%'+EditFilter.Text+'%'')'+
                       'Order by A.Perkiraan',[NoKira2],
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
    10056  : begin
              ViewItems('Select A.Perkiraan,A.Keterangan '+
                       'From DBPERKIRAAN A '+
                       '     left Outer join DBAKSESPERKIRAAN B on B.Perkiraan=A.Perkiraan '+
                       '     left Outer join DBPOSTHUTPIUT C on C.Perkiraan=A.Perkiraan '+
                       'where B.UserID='+QuotedStr(IDUser)+'  and C.Kode<>:0 and (a.Keterangan like ''%'+EditFilter.Text+'%'' or a.Perkiraan like ''%'+EditFilter.Text+'%'')'+
                       'Order by A.Perkiraan',[NoKira2],
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
    1006  : begin
              ViewItem('select Kodevls,NamaVls,Kurs from dbValas '+
                       'where (Kodevls like ''%'+EditFilter.Text+'%'' or NamaVls like ''%'+EditFilter.Text+'%'' ) '+
                       'order by kodevls',
              ['Valas', 'Keterangan','Kurs'],
              [15, 50,12], QuBrows, EditBrows);
            end;
    1008  : begin//Master Kategori
              SortBy:='KodeKategori';
              ViewItem('Select KodeKategori,Keterangan from dbKategori '+
                       'where (KodeKategori like ''%'+EditFilter.Text+'%'' or Keterangan like ''%'+EditFilter.Text+'%'' ) '+
                       'Order by KodeKategori',['Kode Kategori','Nama Kategori'],[15,40],QuBrows,EditBrows);
            end;
    10081 : begin//Master Kategori
              SortBy:='KodeKategori';
              ViewItem('Select KodeKategori, Keterangan from dbKategoriBrgJadi '+
                       'where (KodeKategori like ''%'+EditFilter.Text+'%'' or Keterangan like ''%'+EditFilter.Text+'%'' ) '+
                       'Order by KodeKategori',['Kode Kategori','Nama Kategori'],[15,40],QuBrows,EditBrows);
            end;
    1014  : begin // Master CustSupp
              SortBy:='KodeCustSupp';
               ViewItem(' select Y.KodeCustSupp, Y.NamaCustSupp, '+
                        ' rtrim(ltrim(isnull(Y.Alamat1,'''')+case when isnull(Y.Alamat2,'''')='''' then '''' else '' ''+Y.Alamat2 end)) Alamat, '+
                        ' Y.Kota'+
                        ' from DBCUSTSUPP Y  '+
                        ' where '+
                        ' (Y.KodeCustSupp like ''%'+EditFilter.Text+'%'' or Y.NamaCustSupp like ''%'+EditFilter.Text+'%'') '+
                        ' order by Y.KodeCustSupp',
               ['Kode','Nama','Alamat','Kota'],
               [15,40,50,20], QuBrows, EditBrows);

            end;
    10145  : begin // Master CustSupp
              SortBy:='KodeCustSupp';
               ViewItem(' select Y.KodeCustSupp, Y.NamaCustSupp, '+
                        ' rtrim(ltrim(isnull(Y.Alamat1,'''')+case when isnull(Y.Alamat2,'''')='''' then '''' else '' ''+Y.Alamat2 end)) Alamat, '+
                        ' Y.Kota'+
                        ' from DBCUSTSUPP Y,DBPerkCustSupp X '+
                        ' where X.KodeCustSupp=Y.KodeCustSupp and X.Perkiraan='+QuotedStr(NoKira)+'    '+
                        ' and (Y.KodeCustSupp like ''%'+EditFilter.Text+'%'' or Y.NamaCustSupp like ''%'+EditFilter.Text+'%'') '+
                        ' order by X.KodeCustSupp',
               ['Kode','Nama','Alamat','Kota'],
               [15,40,50,20], QuBrows, EditBrows);

            end;
    10141 : begin // Master CustSupp
              SortBy:='KodeCustSupp';
              ViewItem('select a.KodeCustsupp, a.NamaCustSupp NamaCust, A.Alamat, A.Telpon '+
                        'from vwBrowsSupp A '+
                        'where a.isaktif=1 '+
                        'and (a.KodeCustsupp like ''%'+EditFilter.Text+'%'' or a.NamaCustSupp like ''%'+EditFilter.Text+'%'' ) '+
                        'Order by a.kodecustsupp',
                     ['Kode ', 'Nama ', 'Alamat','Telpon'],
                     [20, 50, 50, 50], QuBrows, EditBrows);
            end;
    1014111 : begin // Master CustSupp
              SortBy:='KodeCustSupp';
              ViewItem('select a.KodeCustsupp, a.NamaCustSupp NamaCust, A.Telpon '+
                        'from vwBrowsSupp A '+
                        'where a.isaktif=1 and Perkiraan=''21040003'' '+
                        'and (a.KodeCustsupp like ''%'+EditFilter.Text+'%'' or a.NamaCustSupp like ''%'+EditFilter.Text+'%'' ) '+
                        'Order by a.kodecustsupp',
                     ['Kode ', 'Penerima Cash Back ','Telpon'],
                     [20, 75, 50], QuBrows, EditBrows);
            end;
    10142 : begin // Master CustSupp
              SortBy:='KodeCustSupp';
              ViewItem('select a.KodeCustsupp, a.NamaCustSupp NamaCust, A.Alamat, A.Telpon '+
                        'from vwBrowscust A '+
                        'where a.isaktif=1 '+
                        'and (a.KodeCustsupp like ''%'+EditFilter.Text+'%'' or a.NamaCustSupp like ''%'+EditFilter.Text+'%'' ) '+
                        'Order by a.kodecustsupp',
                     ['Kode ', 'Nama ', 'Alamat','Telpon'],
                     [20, 50, 50, 50], QuBrows, EditBrows);
            end;
    1014213 : begin // Master CustSupp
              SortBy:='KodeCustSupp';
              ViewItem('select a.KodeCustsupp, a.NamaCustSupp NamaCust, A.Alamat, A.Telpon '+
                        'from [vwBrowsCustHT] A '+
                        'where a.isaktif=1 '+
                        'and (a.KodeCustsupp like ''%'+EditFilter.Text+'%'' or a.NamaCustSupp like ''%'+EditFilter.Text+'%'' ) '+
                        'Order by a.kodecustsupp',
                     ['Kode ', 'Nama ', 'Alamat','Telpon'],
                     [20, 50, 50, 50], QuBrows, EditBrows);
            end;
    10143 : begin // Master CustSupp
              SortBy:='KodeCustSupp';
              ViewItem('select a.KodeCustsupp, a.NamaCustSupp NamaCust, A.Alamat, A.Telpon '+
                        'from vwBrowsExpedisi A '+
                        'where a.isaktif=1 '+
                        'and (a.KodeCustsupp like ''%'+EditFilter.Text+'%'' or a.NamaCustSupp like ''%'+EditFilter.Text+'%'' ) '+
                        'Order by a.kodecustsupp',
                     ['Kode ', 'Nama ', 'Alamat','Telpon'],
                     [20, 50, 50, 50], QuBrows, EditBrows);
            end;
    10144 : begin // Master CustSupp
              SortBy:='KodeCustSupp';
              ViewItem('select a.KodeCustsupp, a.NamaCustSupp NamaCust '+
                        'from dbCustSupp A '+
                        'where a.isaktif=1 and a.Jenis=2'+
                        'and (a.KodeCustsupp like ''%'+EditFilter.Text+'%'' or a.NamaCustSupp like ''%'+EditFilter.Text+'%'' ) '+
                        'Order by a.kodecustsupp',
                     ['Kode ', 'Nama '],
                     [20, 50], QuBrows, EditBrows);
            end;
     ////////////////
     101411 : begin // Ambil KP
              SortBy:='NoBukti';
              ViewItem('Select A.NoBukti,B1.KodeCust,C1.NamaCustSupp,C2.NamaProject,A.KodeBrg BrgJ,E.NamaBrg NamaBrgJ ,A.Qnt QntJ,A.Nosat NosatJ,A.Isi IsiJ,A.Satuan SatJ,'+#13+
                       '       Sum(ISNULL(Case when A.Nosat=1 then Case when B.NOSAT=1 then B.QNT'+#13+
                       '                                            when B.NOSAT=2 then B.QNT*A.isi'+#13+
                       '                                            else 0'+#13+
                       '                                       end'+#13+
                       '                   when A.Nosat=2 then Case when B.NOSAT=1 then B.QNT/A.isi'+#13+
                       '                                            when B.NOSAT=2 then B.QNT'+#13+
                       '                                            else 0'+#13+
                       '                                       end'+#13+
                       '                   else 0'+#13+
                       '              end,0)) QntH,'+#13+
                       '       A.QNT-'+#13+
                       '       Sum(ISNULL(Case when A.Nosat=1 then Case when B.NOSAT=1 then B.QNT'+#13+
                       '                                            when B.NOSAT=2 then B.QNT*A.isi'+#13+
                       '                                            else 0'+#13+
                       '                                       end'+#13+
                       '                   when A.Nosat=2 then Case when B.NOSAT=1 then B.QNT/A.isi'+#13+
                       '                                            when B.NOSAT=2 then B.QNT'+#13+
                       '                                            else 0'+#13+
                       '                                       end'+#13+
                       '                   else 0'+#13+
                       '              end,0)) SisaSPK'+#13+
                       '     From DBSODET A    '+#13+
                       '     Left Outer join DBSO B1 On A.NOBUKTI=B1.NOBUKTI     '+#13+
                       '     Left Outer join dbCustSupp C1 On C1.KodeCustSupp=B1.KodeCust  '+#13+
                       '     Left Outer join dbProject C2 On C2.KodeProject=B1.AlamatKirim '+#13+
                       '     Left Outer join dbBarang E on E.KodeBrg=A.Kodebrg'+#13+
                       '     Left Outer join (Select X.NoSO,y.KODEBRG, y.QNT, y.NOSAT, y.ISI, y.SATUAN'+#13+
                       '                      from DBSPK x'+#13+
                       '                           left Outer join DBSPKMDET y on y.NOBUKTI=x.NOBUKTI) B on B.NoSO=A.NOBUKTI and B.KODEBRG=A.KODEBRG'+#13+
                       'where  B1.FLAGTIPE in(''P'',''N'') '+#13+
                       'Group by  A.NoBukti,B1.KodeCust,C1.NAMACUSTSUPP,C2.NamaProject,A.KodeBrg ,E.NamaBrg ,A.Qnt ,A.Nosat ,A.Isi ,A.Satuan  '+#13+
                       'Having A.QNT-              '+#13+
                       '       Sum(ISNULL(Case when A.Nosat=1 then Case when B.NOSAT=1 then B.QNT      '+#13+
                       '                                            when B.NOSAT=2 then B.QNT*A.isi     '+#13+
                       '                                            else 0                            '+#13+
                       '                                       end                                     '+#13+
                       '                   when A.Nosat=2 then Case when B.NOSAT=1 then B.QNT/A.isi     '+#13+
                       '                                            when B.NOSAT=2 then B.QNT           '+#13+
                       '                                            else 0                              '+#13+
                       '                                       end                                     '+#13+
                       '                   else 0                                       '+#13+
                       '              end,0))>0    '+
                       'and (A.NoBukti like ''%'+EditFilter.Text+'%'' or C1.NamaCustSupp like ''%'+EditFilter.Text+'%'' or C2.NamaProject like ''%'+EditFilter.Text+'%'') '+                                       
                       'Order by A.NoBukti',
                     ['No. Bukti ','N','Pelanggan','Nama Proyek','N', 'Nama Barang','Qnt KP','N','N','Sat','Qnt SPK','Qnt Sisa KP'],
                     [30,1,50,40,1, 50, 12,1,1, 10,12,12], QuBrows, EditBrows);
            end;
       ////////////////
     1014117 : begin // Ambil SPK
              SortBy:='NoBukti';
              ViewItem('Select A.NoBukti,B1.KodeCust,C1.NamaCustSupp,C2.NamaProject,A.KodeBrg BrgJ,E.NamaBrg NamaBrgJ ,Sum(A.Qnt-Isnull(A.QntBatal,0)) QntJ,A.Nosat NosatJ,A.Isi IsiJ,A.Satuan SatJ,'+#13+
                       '       (ISNULL(Case when A.Nosat=1 then Case when B.NOSAT=1 then B.QNT'+#13+
                       '                                            when B.NOSAT=2 then B.QNT*A.isi'+#13+
                       '                                            else 0'+#13+
                       '                                       end'+#13+
                       '                   when A.Nosat=2 then Case when B.NOSAT=1 then B.QNT/A.isi'+#13+
                       '                                            when B.NOSAT=2 then B.QNT'+#13+
                       '                                            else 0'+#13+
                       '                                       end'+#13+
                       '                   else 0'+#13+
                       '              end,0)) QntH,'+#13+
                       '       Sum(A.QNT-Isnull(A.QntBatal,0))-'+#13+
                       '       (ISNULL(Case when A.Nosat=1 then Case when B.NOSAT=1 then B.QNT'+#13+
                       '                                            when B.NOSAT=2 then B.QNT*A.isi'+#13+
                       '                                            else 0'+#13+
                       '                                       end'+#13+
                       '                   when A.Nosat=2 then Case when B.NOSAT=1 then B.QNT/A.isi'+#13+
                       '                                            when B.NOSAT=2 then B.QNT'+#13+
                       '                                            else 0'+#13+
                       '                                       end'+#13+
                       '                   else 0'+#13+
                       '              end,0)) SisaSPK'+#13+
                       '     From DBSPKMDET A    '+#13+
                       '     Left Outer join DBSPK B2 On A.NOBUKTI=B2.NOBUKTI     '+#13+
                       '     Left Outer join DBSO B1 On B1.NOBUKTI=B2.NOSO      '+#13+
                       '     Left Outer join dbCustSupp C1 On C1.KodeCustSupp=B1.KodeCust  '+#13+
                       '     Left Outer join dbProject C2 On C2.KodeProject=B1.AlamatKirim '+#13+
                       '     Left Outer join dbBarang E on E.KodeBrg=A.Kodebrg'+#13+
                       '     Left Outer join (Select y.NoSPK,y.KODEBRG, Sum(y.QNT)Qnt, y.NOSAT, y.ISI, y.SATUAN  '+#13+
                       '                      from DBHASILPRD x      '+#13+
                       '                           left Outer join DBHASILPRDDET y on y.NOBUKTI=x.NOBUKTI    '+#13+
                       '                      Group by  y.NoSPK,y.KODEBRG, y.NOSAT, y.ISI, y.SATUAN ) B on B.NoSPK=A.NOBUKTI and B.KODEBRG=A.KODEBRG'+#13+
                       'Group by  A.NoBukti,B1.KodeCust,C1.NAMACUSTSUPP,C2.NamaProject,A.KodeBrg ,E.NamaBrg ,A.Nosat ,A.Isi ,A.Satuan,B.Qnt,B.NOSAT    '+#13+
                       'Having Sum(A.QNT-Isnull(A.QntBatal,0))-              '+#13+
                       '       (ISNULL(Case when A.Nosat=1 then Case when B.NOSAT=1 then B.QNT      '+#13+
                       '                                            when B.NOSAT=2 then B.QNT*A.isi     '+#13+
                       '                                            else 0                            '+#13+
                       '                                       end                                     '+#13+
                       '                   when A.Nosat=2 then Case when B.NOSAT=1 then B.QNT/A.isi     '+#13+
                       '                                            when B.NOSAT=2 then B.QNT           '+#13+
                       '                                            else 0                              '+#13+
                       '                                       end                                     '+#13+
                       '                   else 0                                       '+#13+
                       '              end,0))>0                                         '+#13+
                       'and (A.NoBukti like ''%'+EditFilter.Text+'%'' or C1.NamaCustSupp like ''%'+EditFilter.Text+'%'' or C2.NamaProject like ''%'+EditFilter.Text+'%'') '+
                       'Order by A.NoBukti',
                     ['No. Bukti ','N','Pelanggan','Nama Proyek','N', 'Nama Barang','Qnt SPK','N','N','Sat','Qnt Produksi','Qnt Sisa SPK'],
                     [30,1,50,40,1, 50, 12,1,1, 10,12,12], QuBrows, EditBrows);
            end;
     20011:begin
             SortBy:='Perkiraan';
             ViewItem('Select Perkiraan, Keterangan, Simbol from dbPerkiraan where Tipe=1 '+
                     ' and Perkiraan in (select Perkiraan from dbPostHutPiut where Kode='+QuotedStr(NoKira1)+')'+
                     ' and (Perkiraan like ''%'+EditFilter.Text+'%'' or Keterangan like ''%'+EditFilter.Text+'%'') '+
                     //' and Perkiraan in (select Perkiraan from dbAksesPerkiraan where UserID='+QuotedStr(NoKira2)+')'+
                     ' Order by Perkiraan',
                     ['Perkiraan','Nama Perkiraan','Simbol'], [15,40,5], QuBrows, EditBrows);
           end;
     20012:begin
             SortBy:='Perkiraan';
             ViewItem('Select Perkiraan, Keterangan, Simbol from dbPerkiraan where Tipe=1 '+
                     ' and (Perkiraan like ''%'+EditFilter.Text+'%'') and Perkiraan in (select Perkiraan from dbPostHutPiut where Kode=''KAS'')'+
                     //' and (Perkiraan like ''%'+EditFilter.Text+'%'' or Keterangan like ''%'+EditFilter.Text+'%'') '+
                     //' and Perkiraan in (select Perkiraan from dbAksesPerkiraan where UserID='+QuotedStr(NoKira2)+')'+
                     ' Order by Perkiraan',
                     ['Perkiraan','Nama Perkiraan','Simbol'], [15,40,5], QuBrows, EditBrows);
           end;           
    23201: begin // Barang di Beli
             //SortBy:='KodeBrg';
             ViewItem('select min(A.Urut) Urut, A.KodeBrg, Br.NamaBrg, A.NoSat, '+
	              ' case when A.NOSAT=1 then Br.SAT1 else Br.SAT2 end Satuan, '+
	              ' case when A.NOSAT=1 then 1 else Br.ISI2 end Isi, '+
                      ' Br.Isi1, Br.Isi2, '+
	              ' sum(A.QntOut) QntSisa, Br.NFix '+
                      ' from ( '+
                      '   select A.NoBukti, A.Tanggal, B.Urut, B.KODEBRG, B.NOSAT, B.Qnt, B.Qnt QntOut, B.HARGA '+
                      '   from DBPO A, DBPODET B '+
                      '   where A.NOBUKTI=B.NOBUKTI and A.NOBUKTI='+QuotedStr(NoKira1)+
                      '   union all '+
                      '   select A.NoBukti, A.Tanggal, 99999 Urut, B.KODEBRG, B.NOSAT, 0.00 Qnt, -B.QNT QntOut, 0.00 Harga '+
                      '   from DBPO A, DBBELIDET B '+
                      '   where A.NOBUKTI=B.NoPO and A.NOBUKTI='+QuotedStr(NoKira1)+
                      '   ) A '+
                      ' left outer join DBBARANG Br on Br.KODEBRG=A.KODEBRG '+
                      ' group by A.NOBUKTI, A.TANGGAL, A.KODEBRG, Br.NAMABRG, A.NOSAT, Br.SAT1, Br.SAT2, Br.ISI1, Br.ISI2,Br.NFix '+
                      ' having sum(A.QntOut)>0 '+
                      ' and (A.KodeBrg like ''%'+EditFilter.Text+'%'' or Br.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      ' order by min(A.Urut) ',
                      ['N','Kode Barang','Nama Barang','N','Satuan','N','N','N','Qnt Sisa','N'],
                      [1,25,50,1,5,1,1,1,10,1], QuBrows, EditBrows);
           end;
    23301: begin // Barang di Retur Beli
             SortBy:='KodeBrg';
             ViewItem('Select A.URUT, A.KODEBRG, Isnull(A.NamaBrg,Br.NAMABRG)NamaBrg, A.NOSAT, A.ISI, A.SATUAN, A.QntTerima,'+#13+
                      '       A.QntTerima-Sum(Case when A.NOSAT=1 then Case when B.NOSAT=1 then B.QntReject'+#13+
                      '                                                     when B.NOSAT=2 then B.QntReject*Br.ISI2'+#13+
                      '                                                     else 0'+#13+
                      '                                                end'+#13+
                      '                            when A.NOSAT=2 then Case when B.NOSAT=1 then B.QntReject/Br.ISI2'+#13+
                      '                                                     when B.NOSAT=2 then B.QntReject'+#13+
                      '                                                     else 0'+#13+
                      '                                                end'+#13+
                      '                        else 0'+#13+
                      '                   end)-isnull(D.Qnt,0) Qnt,'+#13+
                      '       A.Qnt1Terima-Sum(Case when A.NOSAT=1 then Case when B.NOSAT=1 then B.Qnt1Reject'+#13+
                      '                                                      when B.NOSAT=2 then B.Qnt1Reject'+#13+
                      '                                                      else 0'+#13+
                      '                                                 end'+#13+
                      '                             when A.NOSAT=2 then Case when B.NOSAT=1 then B.Qnt1Reject'+#13+
                      '                                                      when B.NOSAT=2 then B.Qnt1Reject'+#13+
                      '                                                      else 0'+#13+
                      '                                                 end'+#13+
                      '                        else 0'+#13+
                      '                   end)-isnull(D.Qnt1,0) Qnt1,'+#13+
                      '       A.Qnt2Terima-Sum(Case when A.NOSAT=1 then Case when B.NOSAT=1 then B.Qnt2Reject'+#13+
                      '                                                      when B.NOSAT=2 then B.Qnt2Reject'+#13+
                      '                                                      else 0'+#13+
                      '                                                 end'+#13+
                      '                             when A.NOSAT=2 then Case when B.NOSAT=1 then B.Qnt2Reject'+#13+
                      '                                                      when B.NOSAT=2 then B.Qnt2Reject'+#13+
                      '                                                      else 0'+#13+
                      '                                                 end'+#13+
                      '                        else 0'+#13+
                      '                   end)-isnull(D.Qnt2,0) Qnt2, Br.NFix'+#13+
                      'from (Select urut, kodebrg,NamaBrg, QNT, QntTerima,Qnt1Terima, Qnt2Terima, NOSAT, ISI, SATUAN, NOBUKTI'+#13+
                      '      from DBBELIDET'+#13+
                      '      where QntTerima<>0) A'+#13+
                      '      Left Outer join (Select urut, kodebrg, QNT,  QntReject, Qnt1Reject, Qnt2Reject,  NOSAT, ISI, SATUAN, NOBUKTI'+#13+
                      '                       from DBBELIDET'+#13+
                      '                       where Qnt1Reject<>0) B on B.NOBUKTI=A.NOBUKTI and B.KODEBRG=A.KODEBRG'+#13+
                      '      left outer join DBBARANG Br on Br.KODEBRG=A.KODEBRG'+#13+
                      '      Left Outer join (Select x.NOPBL, x.URUTPBL, SUM(x.QNT) Qnt, SUM(x.Qnt1) Qnt1, SUM(x.Qnt2) Qnt2'+#13+
                      '                       from DBRBELIDET x'+#13+
                      '                       group by x.NOPBL, x.URUTPBL) D on D.NOPBL=A.NOBUKTI and D.URUTPBL=A.URUT'+#13+
                      'where A.NoBukti='+QuotedStr(NoKira1)+#13+
                      'Group by A.URUT, A.KODEBRG,A.NamaBrg, Br.NAMABRG, A.NOSAT, A.ISI, A.SATUAN, Br.NFix, A.QntTerima, A.Qnt1Terima, A.Qnt2Terima,D.Qnt,D.Qnt1, D.Qnt2'+#13+
                      'Having A.QntTerima-Sum(Case when A.NOSAT=1 then Case when B.NOSAT=1 then B.QntReject'+#13+
                      '                                                     when B.NOSAT=2 then B.QntReject*Br.ISI2'+#13+
                      '                                                     else 0'+#13+
                      '                                                end'+#13+
                      '                            when A.NOSAT=2 then Case when B.NOSAT=1 then B.QntReject/Br.ISI2'+#13+
                      '                                                     when B.NOSAT=2 then B.QntReject'+#13+
                      '                                                     else 0'+#13+
                      '                                                end'+#13+
                      '                        else 0'+#13+
                      '                   end)-isnull(D.Qnt,0)>0'+#13+
                      ' and (A.KodeBrg like ''%'+EditFilter.Text+'%'' or A.NamaBrg like ''%'+EditFilter.Text+'%'' or Br.NamaBrg like ''%'+EditFilter.Text+'%'') '+
                      'order by A.Urut',
                      ['N','Kode Barang','Nama Barang','N','N','Sat','N', 'Qnt','N','N','N'],
                      [1,20,50,1,1,5,1,10,1,1,1], QuBrows, EditBrows);
           end;
    23302: begin // No. Bukti Beli pada FrRBeli
             SortBy:='KodeBrg';
             Viewitem('Select  A.NoBukti, A.Tanggal from dbBeli A  '+
                      ' where A.KodeSupp='+QuotedStr(NoKira1)+
                      ' and (a.NoBukti like ''%'+EditFilter.Text+'%'') '+
                      'and Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 end+ '+
                      '                   Case when A.IsOtorisasi2=1 then 1 else 0 end+ '+
                      '                   Case when A.IsOtorisasi3=1 then 1 else 0 end+ '+
                      '                   Case when A.IsOtorisasi4=1 then 1 else 0 end+ '+
                      '                   Case when A.IsOtorisasi5=1 then 1 else 0 end=A.MaxOL then 0'+
                      '              else 1'+
                      '            end As Bit)=0 '+
                      ' and (A.NoBukti like ''%'+EditFilter.Text+'%'' ) '+
                      ' order by A.NoBukti ',
                      ['No Bukti','Tanggal'],[25,15],QuBrows,EditBrows);
           end;
    40201 : begin
              ViewItem(' select a.KodeBrg, a.NamaBrg, a.Sat1, a.Hrg1_1,Hrg1_2 HPP,Isnull(IsJasa,0)IsJasa,Isnull(nFix,0)nFix from vwBarang a '+
              ' where a.IsAktif=1 and (a.KodeGrp=''FG'' or a.KodeGrp=''SVC'' or Isnull(IsJasa,0)=1 or Isnull(IsBarang,0)=1) and (a.KodeBrg like ''%'+EditFilter.Text+'%'' or a.NamaBrg like ''%'+EditFilter.Text+'%'') '+
              ' order by a.NamaBrg',
              ['Kode Barang', 'Nama Barang','Sat','Harga','N','N','N'],
              [30,50,10,20,1,1,1], QuBrows, EditBrows);
            end;
    40221 : begin
              ViewItem(' select a.KodeBrg, a.NamaBrg, a.Sat1, a.Hrg1_1 HPP,Isnull(IsJasa,0)IsJasa from dbBarang a '+
              ' where a.IsAktif=1 '+
              ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
              ' order by a.NamaBrg',
              ['Kode Barang', 'Nama Barang','Sat','Harga','N'],
              [30,50,10,20,1], QuBrows, EditBrows);
            end;
    300161
        :Begin
           SortBy:='KodeBrg';
           ViewItem('Select A.KODEBRG, A.NAMABRG, A.SAT1 Sat_1, A.Sat2 Sat_2, A.Isi2 Isi, 0 IsSet, 0 IsInspeksi, nFix, 1 Nosat, 0 Urut '+
           ' from dbBarang A  '+
           ' where (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
           ' order by A.KodeBrg',
           ['Kode Barang','Nama Barang','Sat1','Sat2','N','N','N','N','N','N'],
           [15,60,5,5,1,1,1,10,30,30,1,1,1],QuBrows,EditBrows);
         end;       
    30056 : Begin
              SortBy := 'KodeSubtipe';
              ViewItemS('Select A.KODETIPE,B.KODESUBTIPE,B.Nama '+
                       'from DBTIPETRANS A '+
                       '     Left Outer join DBSUBTIPETRANS B on B.KODETIPE=A.KODETIPE '+
                       'where A.KodeTipe=:0 '+
                       ' and (A.KODETIPE like ''%'+EditFilter.Text+'%'' or B.Nama like ''%'+EditFilter.Text+'%'') '+
                       'Order by A.KODETIPE,B.KODESUBTIPE',[NoKira],
                       ['Kode Jenis','Kode Sub Jenis', 'Keterangan'],[15,15,50],QuBrows,EditBrows);
            end;
    30057 : Begin
              SortBy := 'Kodetipe';
              ViewItems('Select A.KODETIPE,A.Nama '+
                       'from DBTIPETRANS A where isJasaBeliJual=:0 '+
                        'and (A.KODETIPE like ''%'+EditFilter.Text+'%'' or a.Nama like ''%'+EditFilter.Text+'%'') '+
                       'Order by A.KODETIPE',[JnsPakai],
                       ['Kode Jenis', 'Keterangan'],[15,50],QuBrows,EditBrows);
            end;
    60:Begin
          SortBy:='KodeCust';
              Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 '+
                        ' and (Filter like ''%'+EditFilter.Text+'%'' or NamaCustSupp like ''%'+EditFilter.Text+'%'' or NamaProject like ''%'+EditFilter.Text+'%'') '+
                        ' Group by Filter,NamaCustSupp,NamaProject'+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],['N',''+colm1 ,''+Colm2],[1,30,30],QuBrows,EditBrows);
       end;
    61:Begin
          SortBy:='KodeCust';
              Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 '+
                        ' and (Filter like ''%'+EditFilter.Text+'%'' or NamaCustSupp like ''%'+EditFilter.Text+'%'' or NamaProject like ''%'+EditFilter.Text+'%'') '+
                        ' Group by Filter,NamaCustSupp,NamaProject'+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],['N',''+colm1 ,''+Colm2],[1,30,30],QuBrows,EditBrows);
       end;
    6101,6102:Begin
          SortBy:='KodeCust';
              Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 '+
                        ' and (Filter like ''%'+EditFilter.Text+'%'' or NamaCustSupp like ''%'+EditFilter.Text+'%'' or NamaProject like ''%'+EditFilter.Text+'%'') '+
                        ' Group by Filter,NamaCustSupp,NamaProject'+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],['N',''+colm1 ,''+Colm2,'N'],[1,30,30,1],QuBrows,EditBrows);
       end;
    303241:Begin
              SortBy:='KodeCustSupp';
              Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 '+
                        ' and (KodeCustSupp like ''%'+EditFilter.Text+'%'' or NamaCustSupp like ''%'+EditFilter.Text+'%'' or NamaProject like ''%'+EditFilter.Text+'%'') '+
                        ' Group by KodeCustSupp,KodeProject,NamaCustSupp,NamaProject'+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],['N',''+colm1 ,''+Colm2],[1,30,30],QuBrows,EditBrows);
           end;
    30314:Begin
             SortBy:='KodeCust';
              Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 '+
                        ' and (KodeCust like ''%'+EditFilter.Text+'%'' or NamaCustSupp like ''%'+EditFilter.Text+'%'' or NamaProject like ''%'+EditFilter.Text+'%'') '+
                        ' Group by KodeCust,NamaCustSupp,NamaProject '+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],['N',''+colm1 ,''+Colm2],[1,30,30],QuBrows,EditBrows);
          end;
    3032411:Begin
             SortBy:='KodeCust';
              Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 Group by KodeCustSupp,NamaCustSupp '+
                        ' and (KodeCustSupp like ''%'+EditFilter.Text+'%'' or NamaCustSupp like ''%'+EditFilter.Text+'%'' ) '+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],['N',''+colm1 ],[1,30],QuBrows,EditBrows);
          end;
   { 303321:Begin
              SortBy:='KodeCustSupp';
              Viewitems('Select '+ vw +
                        ' where TglInv between :0 and :1 Group by KodeCustSupp,NamaCustSupp'+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],['N',''+colm1 ],[1,30],QuBrows,EditBrows);
           end; }
    303321:Begin
              SortBy:='KodeCustSupp';
              Viewitems('Select '+ vw +
                        ' (:0 ,:1) '+
                        'Group By KodeCustSupp,NamaCustSupp '+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],['N',''+colm1 ],[1,30],QuBrows,EditBrows);
           end;
    303242:Begin
              SortBy:='KodeCustSupp';
              Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 '+
                        ' and (KodeCustSupp like ''%'+EditFilter.Text+'%'' or NamaCustSupp like ''%'+EditFilter.Text+'%'' or NamaProject like ''%'+EditFilter.Text+'%'') '+
                        ' Group by KodeCustSupp,NamaCustSupp,NamaProject'+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],['N',''+colm1 ,''+Colm2],[1,30,30],QuBrows,EditBrows);
           end;
    40851,40861,40361: Begin
             SortBy:='NoBukti';
             Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 '+
                        ' and (NoBukti like ''%'+EditFilter.Text+'%'' ) '+
                        ' Group by NoBukti '+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],[''+colm1 ],[30],QuBrows,EditBrows);
           end;
     40362: Begin
              SortBy:='KodeBrg';
             Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 '+
                        ' and (NamaBrg like ''%'+EditFilter.Text+'%'' or Kodebrg like ''%'+EditFilter.Text+'%'' ) '+
                        ' Group by NamaBrg,kodesubgrp,Kodebrg '+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],[''+colm1,''+Colm2,'N' ],[30,50,1],QuBrows,EditBrows);
            end;
     40852 : Begin
             SortBy:='KodeBrg';
             Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 '+
                        ' and (NamaSubGrp like ''%'+EditFilter.Text+'%'' or KodeSubGrp like ''%'+EditFilter.Text+'%'' ) '+
                        ' Group by NamaSubGrp,KodeSubGrp '+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],[''+colm1,''+Colm2],[30,50],QuBrows,EditBrows);
           end;
     40862: Begin
             SortBy:='kodesubgrp';
             Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 '+
                        ' and (NamaSubGrp like ''%'+EditFilter.Text+'%'' or KodeSubGrp like ''%'+EditFilter.Text+'%'' ) '+
                        ' Group by kodesubgrp,NamaSubGrp '+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],[''+colm1,''+Colm2 ],[50,30],QuBrows,EditBrows);
           end;
    251010,252010,301010,302010, //Nobukti
    251020,252020,301020,302020, //KodeCustSupp
    251030,252030,301030,302030, //AccPersediaan
    251040,252040,301040,302040://AccHutpiut
           begin  
               SortBy:='NoBukti';
               Viewitems('Select '+ vw +
                        ' where tanggal between :0 and :1 '+
                        ' Order By  '+ Ordr ,
                        [TglAwal,tglAkhir],[''+colm1 ,''+Colm2],[30,15],QuBrows,EditBrows);
           end;

    251050  : begin
              ViewItem('select Kodetipe,Nama from DbTipeTrans order by Kodetipe',
              ['Kode Tipe', 'Nama'],
              [15, 50], QuBrows, EditBrows);
            end;

    9111 : begin
              ViewItem('select * from DbArea  '+
                       'order by KodeArea',
              ['Kode', 'Nama '],
              [10, 30], QuBrows, EditBrows);
            end;
    911 : begin
             SortBy:='Kodebrg';
              ViewItem('select a.Kodebrg, a.NamaBrg, a.Isi2,a.Sat1, a.Sat2 from Dbbarang a '+
                       ' where a.isaktif=1 and KodeGrp=''FG''  '+
                       ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                       ' order by a.Kodebrg',
              ['Kode Barang', 'Nama Barang','N','N','N'],
              [30, 50,1,1,1], QuBrows, EditBrows);
            end;
    912 : begin
             SortBy:='KodeCustSupp';         
              ViewItem('select a.KodeCustSupp, a.NamaCustSupp from DbCustSupp a '+
                       ' where a.isaktif=1 '+
                        ' and (a.KodeCustSupp like ''%'+EditFilter.Text+'%'' or a.NamaCustSupp like ''%'+EditFilter.Text+'%'') '+
                       'order by a.Kodecustsupp',
              ['Kode Barang', 'Nama Barang'],
              [30, 50], QuBrows, EditBrows);
            end;

    913 : begin
             SortBy:='Kodebrg';
              ViewItem(' select a.Kodebrg, a.NamaBrg, a.Isi2, a.NFix, Cast(Case when B.KodeBrg is null then 0 Else 1 end as bit) Kontrak from DBbarang a '+
                       ' Left Outer join DBBARANGCUSTOMER B on B.kodebrg=A.Kodebrg and B.KodecustSupp='+QuotedStr(NoKira)+
                       ' where a.isaktif=1 and A.KodeGrp in(''FG'',''SVC'') '+
                       ' and  (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                       ' order by Cast(Case when B.KodeBrg is null then 0 Else 1 end as bit) DESC, a.Kodebrg ASC',
              ['Kode Barang', 'Nama Barang','N','N','Kontrak'],
              [30, 50,1,1,32], QuBrows, EditBrows);
            end;
    9141 : begin
            SortBy:='Kodebrg';
            ViewItem('Select a.KodeBrg,b.NamaBrg From dbSOdet a '+
                     'Left Outer Join dbBarang b On a.Kodebrg=b.KodeBrg '+
                     'where a.NoBukti='+QuotedStr(IsiData)+' and b.IsJasa=1    '+
                     'and  (A.KODEBRG like ''%'+EditFilter.Text+'%'' or b.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                     'Group By a.KodeBrg,b.NamaBrg '
                     ,['Kode Barang', 'Nama Barang'],
              [30, 50], QuBrows, EditBrows);
          end;
    91111 : begin
              ViewItem('select A.*,NamaArea from DbKota A '+
                       'Left Outer join DBArea B on A.kodearea=B.KodeAreA order by KodeKota',
              ['Kode Kota', 'Nama Kota','Kode Area','Nama Area'],
              [10, 30,10,30], QuBrows, EditBrows);
            end;
    1154  : begin
              {ViewItem(' select KodeCustSupp KodeCust, NamaCustSupp NamaCust, Alamat, Hari DueDate,  JENIS,IsPpn '+
              ' from vwBrowsCust '+
              ' Group by KodeCustSupp, NamaCustSupp, Alamat, Hari , JENIS,IsPpn'+
              ' order by KodeCustSupp',
              ['Kode', 'Nama Pelanggan', 'Alamat', 'N','N','N'],
              [15, 50, 50, 5, 1,1], QuBrows, EditBrows);}
              ViewItem('select A.KODECUSTSUPP KodeCust, A.NAMACUSTSUPP NamaCust, A.ALAMAT, A.KOTA, A.ALAMATKOTA, A.PPN, A.Hari DueDate, A.IsPPN,Isnull(A.IsKontrak,0)IsKontrak '+
               ' ,isnull(PRet,0)PRet,isnull(PPPH22,0)PPPH22,Isnull(NPPH22,0)NPPH22 '+
               ' from vwCUSTSUPP A Left Outer Join dbCustRetensi b on a.KODECUSTSUPP=b.KODECUSTSUPP '+
               ' where A.IsCustomer=1 and A.IsAktif=1 '+
               ' and (A.KodeCustSupp like ''%'+EditFilter.Text+'%'' or A.NamaCustSupp like ''%'+EditFilter.Text+'%'') '+
               ' order by A.KodeCustSupp',
               ['Kode', 'Nama Customer', 'Alamat','Kota','N','N','N','N','N','N','N','N'],
               [15,40,50,20,1,1,1,1,1,1,1,1], QuBrows, EditBrows);
            end;
    11542 : begin
              ViewItem(' select Nomor, Nama, ALamat AlamatKirim, '''' KodeExp, '''' NamaExp '+
              ' from vwAlamatCust where KodeCustsupp='+QuotedStr(NoKira)+' '+
              ' and (Nama like ''%'+EditFilter.Text+'%'' or Nomor like ''%'+EditFilter.Text+'%'') '+
              ' order by Nomor',
              ['No. ', 'Nama','Alamat Kirim','N','N'],
              [10,30 ,100, 1, 1], QuBrows, EditBrows);
            end;
    11543 : begin
              ViewItem(' select KodeProject, NamaProject '+
              ' from dbProject where KodeCust='+QuotedStr(NoKira)+'  '+
              ' and (KodeProject like ''%'+EditFilter.Text+'%'' or NamaProject like ''%'+EditFilter.Text+'%'') '+
              'order by KodeProject',
              ['Kode Project', 'Nama Project'],
              [20,50], QuBrows, EditBrows);
            end;
     11544 : begin
              ViewItem(' select KodeProject, NamaProject '+
              ' from dbProject where  '+
              ' (KodeProject like ''%'+EditFilter.Text+'%'' or NamaProject like ''%'+EditFilter.Text+'%'') '+
              'order by KodeProject',
              ['Kode Project', 'Nama Project'],
              [20,50], QuBrows, EditBrows);
            end;
     1154317 : begin
              ViewItem(' select NoBukti,Case When a.KodeCust=''-'' Then InsBrg else NamaCustSupp end NamaCustSupp,Jam '+
              ' from dbPNW a Left Outer Join dbCustSupp b on a.KodeCust=b.KodeCustSupp where  '+
              ' (NoBukti like ''%'+EditFilter.Text+'%'') and NoBukti not in(select NOPI from dbSO Group By NOPI) '+
              ' order by Nobukti',
              ['No. Penawaran', 'Nama Customer','Tgl. Deal'],
              [30,50,12], QuBrows, EditBrows);
            end;
    115431 : begin
              ViewItem(' select KodeProject, NamaProject '+
              ' from dbProject where KodeCust='+QuotedStr(NoKira)+'  '+
              ' and (KodeProject like ''%'+EditFilter.Text+'%'' or NamaProject like ''%'+EditFilter.Text+'%'') '+
              'order by KodeProject',
              ['Kode Project', 'Nama Project'],
              [20,50], QuBrows, EditBrows);
            end;
    1158  : begin
              ViewItem('select A.KeyNik KodeSls, A.Nama NamaSls '+
              ' from dbKaryawan A '+
              ' where (A.KeyNik like ''%'+EditFilter.Text+'%'' or A.Nama like ''%'+EditFilter.Text+'%'') '+
              ' order by A.KeyNIK',
              ['Kode', 'Nama Sales'],
              [15, 50], QuBrows, EditBrows);
            end;

    2530101,2530102,2530103,
    2530201,2530202, 2530203
    ,2540101,2540102,2540103,
    2540201,2540202,2540203,
    25501,25502,25503,
    2560101,2560102,2560103,
    2560201,2560202,2560203,
    25701,25702,25703,
    25711,25712,25713,
    25721,25722,25723,
    25731,25732,25733,25741,25742,
    25761,25762,25763,
    3030201,3030202,3030203,
    35101,35102,
    //40201,40202,
    40301,40302,
    4040101,4040102,
    4040201,4040202,
    40501,40502,
    40701,40702,4711,3032602,4712,3032601,4713,3032603,
    40801,40802,3030101,3030102,3030103,30301031,3030104,3031101,3031102,3031103,
    3031201,3031202,3031203,4010201,4010202,401020201,401020202,401020203,4010203,4010204,4010205,4010206,4010207,303701,303702,303703,303802,303803,4011,3032301,3032302,3033201,3032201,3032202,3032203,3033202,3033203,30201,30202,30203,30204:
     begin
       SortBy:='NoBukti';
       Viewitems('Select '+ Fi +
                ' From '+ Vw +
                ' where tanggal between :0 and :1 '+
                ' Order By  '+ Ordr ,
                [TglAwal,tglAkhir],[''+colm1 ,''+Colm2],[15,50],QuBrows,EditBrows);
     end;
    3032303:
     begin
       SortBy:='NoBukti';
       Viewitems('Select '+ Fi +
                ' From '+ Vw +
                ' where tanggal between :0 and :1 '+
                ' Order By  '+ Ordr ,
                [TglAwal,tglAkhir],[''+colm1 ,''+Colm2,'N'],[15,50,1],QuBrows,EditBrows);
     end;
    303801:
    Begin
     SortBy:='NOSO';
       Viewitems('Select '+ Fi +
                ' From '+ Vw +
                ' where tanggal between :0 and :1 '+
                ' Order By  '+ Ordr ,
                [TglAwal,tglAkhir],[''+colm1 ,''+Colm2],[30,15],QuBrows,EditBrows);
    end;
    2401,2402:
    begin
       SortBy:='NoBukti';
       Viewitems('Select '+ Fi +
                ' From '+ Vw +
                ' where tanggal between :0 and :1 '+
                ' Order By  '+ Ordr ,
                [TglAwal,tglAkhir],[''+colm1 ,''+Colm2],[30,15],QuBrows,EditBrows);
     end;
   2403:
   begin
       SortBy:='NoBukti';
       Viewitems('Select '+ Fi +
                ' From '+ Vw +
                ' where tanggal between :0 and :1 '+
                ' Order By  '+ Ordr ,
                [TglAwal,tglAkhir],[''+colm1],[30],QuBrows,EditBrows);
     end;
   20406:
   Begin
      SortBy:='NoBukti';
       Viewitems('Select  '+
                '  '+ Vw +
                ' where TglInv between :0 and :1 '+
                ' and (Kode like ''%'+EditFilter.Text+'%'' or Nama like ''%'+EditFilter.Text+'%'') '+
                ' Group by Kode,Nama  '+
                ' Order By  '+ Ordr ,
                [TglAwal,tglAkhir],['N',''+colm1 ],[1,30],QuBrows,EditBrows);
   end;
     40401
        :Begin
           SortBy:='NoBukti';
           ViewItem('Select distinct A.NoBukti, B.Tanggal, B.Kodecust KodeCustSupp, C.NamaCust NamaCustSupp, C.Alamat, C.kodekota Kota, '''' NoPO, null TGLPO, null Ship_Mark, A.Nobukti NoSO, '''' NoLC '+
                    'from vwBrowsOutSO_SPP A '+
                    '      left outer join dbSO B on B.NoBukti=A.NoBukti '+
                    ' left outer join vwBrowsCustomer C on C.KodeCust=B.KODECUST '+
                    ' where (A.NoBukti like ''%'+EditFilter.Text+'%'' or C.NamaCust like ''%'+EditFilter.Text+'%'') '+
                    ' order by B.Tanggal, A.NoBukti',
           ['Nomor Bukti','Tanggal','N','Customer','N','N','N','N','N','No. SO','N'],
           [25,15,1,40,1,1,1,1,1,25,1],QuBrows,EditBrows);
         end;
    40402
        :Begin
           SortBy:='KodeBrg';
           ViewItem(' Select A.Urut, A.KODEBRG, B.NAMABRG, '+
                    ' A.Satuan, Case When A.Nosat=1 Then A.QntSisa else Case When UPPER(A.Satuan)=''PCS'' Then Round(A.QntSisa/A.isi,0)else A.QntSisa/A.isi end end QntSisa,  A.Isi, A.Nosat, A.Namabrgkom,B.Sat1,B.Sat2 '+
                     ' from vwBrowsOutSO_SPP A left outer join dbBarang B on B.KodeBrg=A.KodeBrg '+
                     '      left Outer join dbSO D on d.Nobukti=A.nobukti '+
                     ' where A.NoBukti='+QuotedStr(NoKira)+
                     ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or B.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                     ' order by A.KodeBrg ',
           ['N','Kode Barang','Nama Barang','Satuan','Sisa', 'N','N','N','N','N'],
           [1,20,20,10,5,10,5,1,1,1],QuBrows,EditBrows);
         end;
    40421
        :Begin
           SortBy:='NoBukti';
           ViewItem(' Select distinct A.NoBukti, B.Tanggal, B.NoSO, B.KodeCustSupp, C.NamaCust NamaCustSupp, C.Alamat, C.kodekota Kota, A.Catatan '+
                    ' from vwOutSpp A '+
                    ' left outer join (Select x.NoBukti,o.Tanggal,x.Noso, z.Kodecust Kodecustsupp, o.IsFlag '+
                    '                  from dbSPPDet x '+
                    '                       left outer join dbSO z on z.Nobukti=x.NoSO '+
                    '                       left outer join dbSPP o on o.NoBukti=x.NoBukti '+
                    '                  group by x.Nobukti,o.Tanggal,z.Kodecust, o.IsFlag, x.NOSO) B on B.NoBukti=A.NoBukti '+
                    ' left outer join vwBrowsCustomer C on C.KodeCust=B.KodeCustSupp '+
                    ' left Outer join (Select NospB, UrutSPB from dbInvoicePLDet) D on D.NoSPB=A.NoBukti  and D.UrutSPB=A.Urut '+
                    ' where B.NoBukti='+QuotedStr(NoKira2)+' and (D.NoSPB is null and D.UrutSPB is null) '+
                    ' and (A.NoBukti like ''%'+EditFilter.Text+'%'' or B.NoSO like ''%'+EditFilter.Text+'%'' or C.NamaCust like ''%'+EditFilter.Text+'%'') '+
                    ' order by B.Tanggal, A.NoBukti',
           ['Nomor Bukti','Tanggal','N','N','Supplier','N','N','N'],[25,15,1,1,40,1,1,1],QuBrows,EditBrows);
         end;
      404217
        :Begin
           SortBy:='NoBukti';
           ViewItem(' Select distinct A.NoBukti, A.Tanggal, B.NoSO, A.KodeCustSupp, C.NamaCust NamaCustSupp, C.Alamat, C.kodekota Kota, A.Catatan '+
                    ' from dbRSPB A '+
                    ' left outer join (Select x.NoBukti,z.Noso '+
                    '                  from dbSPBDet x '+
                    '                       left outer join (Select NOSO,NoBukti from dbSPPDet Group by  NOSO,NoBukti) z on z.Nobukti=x.NoSPP '+
                    '                  group by x.Nobukti, z.NOSO) B on B.NoBukti=A.NoBukti '+
                    ' left outer join vwBrowsCustomer C on C.KodeCust=A.KodeCustSupp '+
                    ' where A.NoBukti='+QuotedStr(NoKira2)+'  '+
                    ' and (A.NoBukti like ''%'+EditFilter.Text+'%'' or B.NoSO like ''%'+EditFilter.Text+'%'' or C.NamaCust like ''%'+EditFilter.Text+'%'') '+
                    ' order by A.Tanggal, A.NoBukti',
           ['Nomor Bukti','Tanggal','N','N','Supplier','N','N','N'],[25,15,1,1,40,1,1,1],QuBrows,EditBrows);
         end;
    40422
        :Begin
           SortBy:='KodeBrg';
           ViewItem(' Select A.Urut, A.KODEBRG, B.NAMABRG, A.Qnt2Sisa, A.Sat_2, A.QntSisa, A.Sat_1, A.Isi, A.Nosat, A.NetW, A.GrossW, A.Namabrg Namabrgkom, 0.00 Toleransi, '+
                    ' A.Qnt, A.Qnt2,A.QntSPB, A.Qnt2SPB, B.Nfix Konversi '+
                    ' from vwBrowsOutSpp A left outer join dbBarang B on B.KodeBrg=A.KodeBrg '+
                    ' left Outer join dbSPP c on c.nobukti=a.nobukti '+
                    ' where A.NoBukti='+QuotedStr(NoKira)+
                    ' and (B.NAMABRG like ''%'+EditFilter.Text+'%'' or A.KODEBRG like ''%'+EditFilter.Text+'%'') '+
                    ' order by A.KodeBrg ',
           ['N','Kode Barang','Nama Barang','Sisa2','Sat2','Sisa1','Sat1','N','N','N','N','N','N','N','N','N','N','N'],
           [1,20,50,10,5,10,5,1,1,1,1,1,1,1,1,1,1,1],QuBrows,EditBrows);
         end;
     404223
        :Begin
           SortBy:='KodeBrg';
           ViewItem(' Select 0 Urut, A.KODEBRG, A.NAMABRG, 0 Qnt2Sisa, A.Sat2, 0 QntSisa, A.Sat1, A.Isi2, '+
                    ' A.Nfix Konversi '+
                    ' from  dbBarang A  '+
                    ' where Isnull(IsJasa,0)=0 and /*KodeGrp=''FG''  and*/ '+
                    '  (A.NAMABRG like ''%'+EditFilter.Text+'%'' or A.KODEBRG like ''%'+EditFilter.Text+'%'') '+
                    ' order by A.KodeBrg ',
           ['N','Kode Barang','Nama Barang','N','N','N','N','N','N'],
           [1,20,50,1,1,1,1,1,1,1],QuBrows,EditBrows);
         end;
    4042217
        :Begin
           SortBy:='KodeBrg';
           ViewItem(' Select A.Urut, A.KODEBRG, B.NAMABRG, A.Qnt2Sisa, A.Sat_2, A.QntSisa, A.Sat_1, A.Isi, A.Nosat, A.NetW, A.GrossW, A.Namabrg Namabrgkom, 0.00 Toleransi, '+
                    ' A.Qnt, A.Qnt2,A.QntSPB, A.Qnt2SPB, B.Nfix Konversi '+
                    ' from [vwOutRSPB] A left outer join dbBarang B on B.KodeBrg=A.KodeBrg '+
                    ' where A.NoBukti='+QuotedStr(NoKira)+
                    ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or B.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                    ' order by A.KodeBrg ',
           ['N','Kode Barang','Nama Barang','Sisa2','Sat2','Sisa1','Sat1','N','N','N','N','N','N','N','N','N','N','N'],
           [1,20,50,10,5,10,5,1,1,1,1,1,1,1,1,1,1,1],QuBrows,EditBrows);
         end;
    404301
        :begin
           Sortby:='NoSPB';
           ViewItem('Select  Distinct B.NoSPB, B.TglSPB, B.NoSPP, B.TglSPP, B.Noship, B.TglShip, B.NoSC, B.TglSC, B.IsLokal,a.Kodegdg '+
                    'B.KodecustSupp,c.NamaCust NAMACUSTSUPP, c.Alamat+'' ''+c.NamaKota Alamat '+
                    'from vwbrowsOutSPB_RSPB a '+
                    '     left Outer join vwSPB b on b.noSPB=a.nobukti '+
                    'left Outer join vwBrowsCustomer c on c.KODECUST=b.kodecustSupp '+
                    'where A.nobukti like ''%'+NoKira2+'%''  '+
                    ' and (B.NoSPB like ''%'+EditFilter.Text+'%'' or B.NoSPP like ''%'+EditFilter.Text+'%'') '+
                    ' Order by b.nospb',
                    ['No SPB', 'Tanggal SPB','N','N','N','N','N','N','Tipe','Kode Customer','Nama Customer','Alamat'],
                    [30,20,1,1,1,1,1,1,20,15,40,40],QuBrows,EditBrows);
         end;
    404302
        :begin
           Sortby:='NoSPB';
           ViewItems('Select a.nobukti, a.urut, a.kodebrg, b.Namabrg, a.Namabrg NamabrgKom, '+
                     '       Case when a.nosat=1 then a.QntSisa '+
                     '            when a.nosat=2 then a.Qnt2Sisa '+
                     '            else 0 '+
                     '       end Qty,'+
                     '       Case when a.nosat=1 then a.Sat_1 '+
                     '            when a.nosat=2 then a.Sat_2 '+
                     '            else '''' '+
                     '       end Satuan,'+
                     'a.Sat_1, a.sat_2, a.nosat, b.Isi2 isi, a.qnt, a.qnt2, a.qntRetur, a.Qnt2Retur,'+
                     '       a.QntSisa, A.qnt2Sisa '+
                     'from vwBrowsOutspB_RSPB a '+
                     '     left Outer join (Select Kodebrg, Namabrg,Isi2 from DBBARANG) b on b.KODEBRG=a.kodebrg '+
                     'Where a.nobukti=:0 '+
                     ' and (a.nobukti like ''%'+EditFilter.Text+'%'' or b.Namabrg like ''%'+EditFilter.Text+'%'') '+
                     'Order by a.nobukti,a.urut ',[Nokira],
                    ['N', 'N','Kode Barang','Nama Barang','N','Qty','Satuan','N','N','N','N','N','N','N','N','N'],
                    [1, 1,30,40,1,15,5,1,1,1,1,1,1,1,1,1],
                    QuBrows,EditBrows);
         end;
    30051
        :Begin
           SortBy:='KodeCustSupp';
           ViewItem(' Select A.KodeCustSupp, A.NamaCustSupp, A.Alamat, A.Kota, A.Fax, A.Negara, A.Usaha from vwBrowsCust A '+
                    ' where (A.KodeCustSupp like ''%'+EditFilter.Text+'%'' or A.NamaCustSupp like ''%'+EditFilter.Text+'%'') '+
                    ' order by A.KodeCustSupp',
           ['Kode','Nama','N','N','N','N','N'],
           [15,50,1,1,1,1,1],QuBrows,EditBrows);
         end;
    8005 : begin   //dbinvoicePL + lokal
               SortBy:='NoBukti';
               ViewItem(' select a.nobukti, a.tanggal, '''' Keterangan, a.kodecustSupp '+
                        ' from dbInvoicePL a '+
                        '      Left Outer join (Select nobukti,Sum(Qnt) Qnt From dbinvoicePLDet x Group by nobukti) b on b.nobukti=a.nobukti '+
                        '      Left Outer join (Select noinvoice,Sum(Qnt) Qnt From dbRinvoicePLDet x Group by noinvoice) c on c.noinvoice=a.nobukti '+
                        ' where Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 end+'+#13+
                        '                      Case when A.IsOtorisasi2=1 then 1 else 0 end+'+#13+
                        '                      Case when A.IsOtorisasi3=1 then 1 else 0 end+'+#13+
                        '                      Case when A.IsOtorisasi4=1 then 1 else 0 end+'+#13+
                        '                      Case when A.IsOtorisasi5=1 then 1 else 0 end=A.MaxOL then 0'+#13+
                        '                else 1'+#13+
                        '           end As Bit)=0 and a.KodecustSupp='+QuotedStr(NoKira)+
                        '       and B.Qnt-isnull(c.Qnt,0)>0  and A.Nobukti like ''%'+NoKira2+'%''  '+
                        ' and (a.nobukti like ''%'+EditFilter.Text+'%'' or a.kodecustSupp like ''%'+EditFilter.Text+'%'') '+
                        ' Order by a.nobukti',
               ['No. Faktur Penjualan','Tanggal','N', 'N'],
               [25,15,20,1],QuBrows,EditBrows);
             end;
    8006 :begin
               SortBy :='KodeBrg';
               ViewItems('Select Kodebrg, Namabrg, QtySisa, Satuan, NetWSisa, GrossWSisa, SAT_1, SAT_2, Nosat, Isi, Urut, QntSisa, Qnt2Sisa, Harga, NamabrgKom '+
                         'from vwOutInvoicePL_RInvoicePL '+
                         'where nobukti=:0 and NoSPB=:1 '+
                         'and (Kodebrg like ''%'+EditFilter.Text+'%'' or Namabrg like ''%'+EditFilter.Text+'%'') '+
                         'Order by urut',
                         [NoKira, Nokira2],
                         ['Kode Barang', 'Nama Barang', 'Qty', 'Satuan', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'],
                         [25,50,12,10,12,12,1,1,1,1,1,1,1,1,1], Qubrows, EditBrows);
             end;
     8009 :begin
               SortBy :='KodeBrg';
               ViewItem('Select Kodebrg, Namabrg, 0 QtySisa, Sat1, Sat2 '+
                         'from dbBarang '+
                         'where '+
                         ' (Kodebrg like ''%'+EditFilter.Text+'%'' or Namabrg like ''%'+EditFilter.Text+'%'') '+
                         'Order by Kodebrg',
                         ['Kode Barang', 'Nama Barang', 'N', 'Satuan 1','Satuan 2'],
                         [25,50,1,12,12], Qubrows, EditBrows);
             end;
    8007 :begin   //SPB Lokal + Export
               SortBy:='NoBukti';
               ViewItem('select nobukti, tanggal from dbSPB where noBukti='+QuotedStr(NoKira)+' '+
                        'where (nobukti like ''%'+EditFilter.Text+'%'' ) '+
                        'Order by nobukti',
               ['No. SPB','Tanggal'],
               [25,15],QuBrows,EditBrows);
             end;
    8013:begin
               SortBy:='Nobukti';
               ViewItem(
                       ' Select distinct A.NoBukti, D.Tanggal, B.NoSO, B.KodeCustSupp, C.NamaCust NamaCustSupp, C.Alamat, C.NamaKota Kota, '''' Catatan,'''' '+
                       ' from vwBrowsOutRJual A '+
                       ' Left Outer join DBRInvoicePL D on D.NoBukti=A.Nobukti'+
                       ' Left outer join (Select x.NoBukti,x.Tanggal, x.KodeCustSupp, z.NOBUKTI NoSo, z1.KODESLS '+
                       '                  from dbInvoicePL x                                                    '+
                       '                  Left Outer join dbInvoicePLDet y on y.nobukti=x.nobukti               '+
                       '                  left Outer join dbSPBDet SPB on SPB.NoBukti=y.NoSPB and SPB.Urut=y.UrutSPB '+
                       '                  left Outer join dbSPPDet o on o.NoBukti=SPB.NoSPP and o.Urut=SPB.UrutSPP '+
                       '                  left Outer join DBSODET z on z.NoBukti=o.NoSO and z.Urut=o.UrutSO '+
                       '                  left outer join DBSO z1 on z1.NOBUKTI=z.NOBUKTI                   '+
                       '                  Group by  x.NoBukti,x.Tanggal, x.KodeCustSupp, z.NOBUKTI, z1.KODESLS '+
                       ') B on B.NoBukti=A.Noinvoice                                                        '+
                       'left outer join vwBrowsCustomer C on C.KodeCust=B.KodeCustSupp and c.Sales=B.KODESLS '+
                       'where (A.NoBukti like ''%'+EditFilter.Text+'%'' or B.NoSO like ''%'+EditFilter.Text+'%'' or C.NamaCust like ''%'+EditFilter.Text+'%'') '+
                       ' order by D.Tanggal, A.NoBukti ',
                        ['No. Retur ', 'Tanggal', 'No. SO','N', 'Nama Supplier','N', 'N', 'N', 'N'],
                        [50,12,50,1,50,1,1,1,1],QuBrows,EditBrows);
             end;
    80131:begin
               SortBy:='Nobukti';
               ViewItems(
                       ' Declare @nobukti varchar(50), @Kodebrg varchar(50) Select @nobukti=:0 '+
                       ' Select A.KODEBRG, Case When Isnull(A.NamaBrg,'''')='''' Then B.NAMABRG else A.Namabrg end NamaBrg, Case When Isnull(A.NamaBrg,'''')='''' Then B.NAMABRG else A.Namabrg end Namabrgkom, A.Qnt2Sisa, A.Sat_2, A.QntSisa, A.Sat_1, A.Isi, A.NoBukti, A.Urut, A.Nosat, '+
                       '        A.NetW, A.GrossW '+
                       ' from vwBrowsOutRjual A left outer join dbBarang B on B.KodeBrg=A.KodeBrg '+
                       ' left Outer join dbRInvoicePL c on c.nobukti=a.nobukti '+
                       ' where A.NoBukti=@nobukti  '+
                       ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NamaBrg like ''%'+EditFilter.Text+'%'' or B.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                       ' order by A.KodeBrg ',[nokira],
                        ['Kode Barang ', 'Nama Barang', 'Nama Komersil','N','Satuan', 'N','N', 'N', 'N', 'N', 'N','N','N'],
                        [50,50,50,1,12,1,1,1,1,1,1,1,1],QuBrows,EditBrows);
             end;
    8014:begin
               SortBy:='Nobukti';
               ViewItem('Select a.NoBukti, a.Tanggal, a.KodecustSupp, B.NamaCustSupp, B.Alamat, C1.NOSPB, D.Tanggal TGLSPB, C1.Tipe '+#13+
                        ' ,C.NOinvoice NoPNJ '+#13+
                        ' from dbSPBRjual a '+#13+
                        ' left Outer join vwBrowsCust b on b.KodeCustSupp=A.kodecustSupp '+#13+
                        ' Left Outer join (Select nobukti, NoInvoice from DBRInvoicePLDET Group by nobukti, NoInvoice) C on C.nobukti=a.NoRPJ '+#13+
                        ' Left Outer join (Select NoSPB, NoBukti, 1 Tipe from dbInvoicePLDet group by NoSPB, NoBukti) C1 on C1.NoBukti=C.NoInvoice '+#13+
                        ' left Outer join (Select Nobukti, Tanggal from DBSPB ) D on D.NoBukti=C1.NoSPB  '+#13+
                        ' where '+#13+
                        '       Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 end+'+#13+
                        '                      Case when A.IsOtorisasi2=1 then 1 else 0 end+'+#13+
                        '                      Case when A.IsOtorisasi3=1 then 1 else 0 end+'+#13+
                        '                      Case when A.IsOtorisasi4=1 then 1 else 0 end+'+#13+
                        '                      Case when A.IsOtorisasi5=1 then 1 else 0 end=A.MaxOL then 0'+#13+
                        '                  else 1'+#13+
                        '             end As Bit)=0'+#13+
                        ' And A.nobukti like ''%'+NoKira2+'%''   '+#13+
                        ' and (A.nobukti like ''%'+EditFilter.Text+'%'' or B.NamaCustSupp like ''%'+EditFilter.Text+'%'' or a.KodecustSupp like ''%'+EditFilter.Text+'%'') '+
                        ' order by a.nobukti',
                        ['No. Retur ', 'Tanggal', 'N', 'Nama Supplier','N', 'N', 'N','N','N'],
                        [50,12,1,100,1,1,1,1,1],QuBrows,EditBrows);
             end;
      80141 :begin
               SortBy:='Nobukti';
               ViewItems('Declare @noBukti Varchar(30)'+#13+
                         'Set @Nobukti=:0'+#13+
                         'Select A.KODEBRG, Case When Isnull(A.NamaBrg,'''')='' Then B.NAMABRG else A.NamaBrg end NamaBrg, A.NoSat, A.Qnt2-isnull(C.Qnt2,0) Qnt2Sisa, A.Sat_2, A.Qnt-isnull(C.Qnt,0) QntSisa, '+#13+
                         '       A.Sat_1, A.Isi, A.NoBukti, A.Urut, D.Harga '+#13+
                         'from dbSPBRJualDet A '+#13+
                         'left outer join dbBarang B on B.KodeBrg=A.KodeBrg '+#13+
                         '     left outer join (select NOSPR, UrutSPR, sum(Qnt2) Qnt2, sum(Qnt) Qnt '+#13+
                         '                      from DBINVOICERPJDet where NOSPR=@Nobukti '+#13+
                         '                      group by NOSPR, UrutSPR) C on C.NOSPR=A.NoBukti and C.UrutSPR=A.Urut '+#13+
                         '     left Outer join (Select x.nobukti,x.urut, x.Harga'+#13+
                         '                      from dbRInvoicePLdet x) D on D.Nobukti=A.NoRPJ and D.Urut=A.UrutRPJ'+#13+
                         'where A.NoBukti=@Nobukti and ((A.Qnt2-isnull(C.Qnt2,0))>0 or (A.Qnt-isnull(C.Qnt,0))>0) '+#13+
                         ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NamaBrg like ''%'+EditFilter.Text+'%'' or B.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                         '  order by A.KodeBrg',[Nokira],
                        ['Kode Barang', 'Nama Barang', 'N', 'Qnt2 Sisa','Sat 2', 'Qnt Sisa', 'Sat 1', 'N','N','N','N'],
                        [30,50,1,12,6,12,6,1,1,1,1],QuBrows,EditBrows);
             end;
    914 : begin
             SortBy := 'KodeSubtipe';
              ViewItemS('Select A.Lokasi '+
                       'from DBLokasi A '+
                       'where A.KodeGDG=:0 '+
                       'Order by A.Lokasi',[NoKira],
                       ['Lokasi'],[80],QuBrows,EditBrows);
            end;
    915 : begin
             SortBy:='Kodebrg';
              ViewItem('select a.Kodebrg, a.NamaBrg from Dbbarang a '+
                       ' where a.isaktif=1 '+
                       ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                       ' order by a.Kodebrg',
              ['Kode Barang', 'Nama Barang','N'],
              [30, 50], QuBrows, EditBrows);
            end;
    916 : begin
              ViewItem('select KodeGDg,Nama NamaGdg from dbGudang  '+
                       'order by KodeGdg',
              ['Kode', 'Nama '],
              [10, 30], QuBrows, EditBrows);
            end;
    9161 : begin
              ViewItem('select KodeGDg,Nama NamaGdg from dbGudang  where Isnull(IsProduksi,0)=1 '+
                       'order by KodeGdg',
              ['Kode', 'Nama '],
              [10, 30], QuBrows, EditBrows);
            end;
    9162 : begin
              ViewItem('select KodeGDg,Nama NamaGdg from dbGudang where Isnull(IsProduksi,0)=0  '+
                       'order by KodeGdg',
              ['Kode', 'Nama '],
              [10, 30], QuBrows, EditBrows);
            end;
    917 : begin
             SortBy:='Kodebrg';
              ViewItem('select a.Kodebrg, a.NamaBrg from Dbbarang a '+
                       ' where a.isaktif=1 '+
                       ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                       ' order by a.Kodebrg',
              ['Kode Barang', 'Nama Barang'],
              [30, 50], QuBrows, EditBrows);
            end;
    9171 : begin
             SortBy:='Kodebrg';
              ViewItem('select a.Kodebrg, a.NamaBrg from Dbbarang a '+
                       ' where a.isaktif=1 --and a.KodeGrp in(''FG'',''SVC'') '+
                       ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                       ' order by a.Kodebrg',
              ['Kode Barang', 'Nama Barang'],
              [30, 50], QuBrows, EditBrows);
            end;
     9172 : begin
             SortBy:='Kodebrg';
              ViewItem('select a.Kodebrg, a.NamaBrg from Dbbarang a '+
                       ' where a.isaktif=1 and a.KodeGrp Not in(''FG'',''SVC'') '+
                       ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                       ' order by a.Kodebrg',
              ['Kode Barang', 'Nama Barang'],
              [30, 50], QuBrows, EditBrows);
            end;
    100444  : begin
              ViewItem('select Perkiraan,keterangan from dbPerkiraan where tipe=1 '+
                       ' and (Perkiraan like ''%'+EditFilter.Text+'%'' or keterangan like ''%'+EditFilter.Text+'%'' ) '+
                       ' order by Perkiraan',
              ['Perkiraan', 'Keterangan'],
              [15, 50], QuBrows, EditBrows);
            end;
    157  :begin
              ViewItemS('select KOdeSubGrp,NamaSubGrp from DbSubGroup where Kodegrp=:0  '+
                        ' and (KOdeSubGrp like ''%'+EditFilter.Text+'%'' or NamaSubGrp like ''%'+EditFilter.Text+'%'' ) '+
                        'order by KodeSubGrp',
              [Nokira],['Kode Sub Group', 'Nama Sub Group'],
              [15, 50], QuBrows, EditBrows);
            end;
    1571 :begin
           ViewItem('select KOdebrg,NamaBrg from dbbarang where kodegrp not in (''FG'') and isaktif=1  '+
                    ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                    ' order by kodebrg ',['Kode Barang','Nama Barang'],[20,50],Qubrows,EditBrows);

         End;
    91112 : begin
              ViewItem('Select * from DbjenisCustSupp',
              ['Kode jenis', 'Nama Jenis'],
              [10, 30], QuBrows, EditBrows);
            end;
    91113 : begin
              ViewItem('Select * from DBBANK',
              ['Kode jenis', 'Nama Jenis'],
              [10, 30], QuBrows, EditBrows);
            end;
    91114:begin
           ViewItem('Declare @Isaktif tinyint,@Perkiraan varchar(100), @Flagmenu int  '+
                    '    set @isaktif=2     '+
                    '    Select @Perkiraan=''semua'',@Flagmenu=2      '+
                    '    select  distinct a.KODECUSTSUPP,  '+
                    '            a.Usaha+Case when isnull(a.Usaha,'''')='''' then '''' else ''. '' end+a.NamacustSupp Nama,   '+
                    '            [dbo].[DataPostHutPiut](A.KodecustSupp,Case when @Flagmenu=0 then ''HT'' else ''PT'' end) DetailAkun  '+
                    '    from dbCustSupp  a                 '+
                    '         left Outer join dbperkcustsupp b on b.kodecustsupp=a.kodecustsupp   '+
                    '         left Outer join dbPerkiraan c on c.perkiraan=b.perkiraan and c.tipe=1  '+
                    '         Left Outer join dbkota D on a.kota=D.KodeKota            '+
                    '         Left outer join dbarea E on D.KodeArea=E.KodeArea         '+
                    '         Left Outer Join DBJenisCustSupp G on A.Kodejenis=G.KOdejenis   '+
                    '    where (a.IsAktif  Like (Case when @isAktif=0 then 0     '+
                    '                                 when @isAktif=1 then 1   '+
                    '                            end) or     '+
                    '         (Case when @isAktif=0 then 0   '+
                    '               when @isAktif=1 then 1    '+
                    '               else 2         '+
                    '           end)=2) and isnull(c.Keterangan,'''')+'' (''+isnull(b.Perkiraan,'''')+'')''  like Case when @Perkiraan=''Semua'' then ''%'' else @Perkiraan end  '+
                    '                   '+
                    '    and a.Jenis=2    '+
                    '          Order by a.KodeCustSupp  ',['Kode','Nama','Detail Akun'],[20,50,40], QuBrows, EditBrows);

          End   ;
    91115:begin
           ViewItem('Declare @Isaktif tinyint,@Perkiraan varchar(100), @Flagmenu int  '+
                    '    set @isaktif=2     '+
                    '    Select @Perkiraan=''semua'',@Flagmenu=1      '+
                    '    select  distinct a.KODECUSTSUPP,  '+
                    '            a.Usaha+Case when isnull(a.Usaha,'''')='''' then '''' else ''. '' end+a.NamacustSupp Nama,   '+
                    '            [dbo].[DataPostHutPiut](A.KodecustSupp,Case when @Flagmenu=0 then ''HT'' else ''PT'' end) DetailAkun  '+
                    '    from dbCustSupp  a                 '+
                    '         left Outer join dbperkcustsupp b on b.kodecustsupp=a.kodecustsupp   '+
                    '         left Outer join dbPerkiraan c on c.perkiraan=b.perkiraan and c.tipe=1  '+
                    '         Left Outer join dbkota D on a.kota=D.KodeKota            '+
                    '         Left outer join dbarea E on D.KodeArea=E.KodeArea         '+
                    '         Left Outer Join DBJenisCustSupp G on A.Kodejenis=G.KOdejenis   '+
                    '    where (a.IsAktif  Like (Case when @isAktif=0 then 0     '+
                    '                                 when @isAktif=1 then 1   '+
                    '                            end) or     '+
                    '         (Case when @isAktif=0 then 0   '+
                    '               when @isAktif=1 then 1    '+
                    '               else 2         '+
                    '           end)=2) and isnull(c.Keterangan,'''')+'' (''+isnull(b.Perkiraan,'''')+'')''  like Case when @Perkiraan=''Semua'' then ''%'' else @Perkiraan end  '+
                    '                   '+
                    '    and a.Jenis=1    '+
                    ' and (a.KODECUSTSUPP like ''%'+EditFilter.Text+'%'' or a.NamacustSupp like ''%'+EditFilter.Text+'%'') '+
                    '          Order by a.KodeCustSupp  ',['Kode','Nama','Detail Akun'],[20,50,40], QuBrows, EditBrows);

          End   ;
    91116: begin
              ViewItem('Select * from DbDealer',
              ['Kode Dealer', 'Nama Dealer'],
              [10, 30], QuBrows, EditBrows);
            end;
    9119: Begin
          ViewItem(' select distinct(A.Keynik) keynik,B.Nama  from DBSALESCUSTOMER A  '+
                   ' Left Outer Join dbKaryawan B on A.KeyNik = B.KeyNIK  ',['Kode Sales','Nama'],[10,50], QuBrows, EditBrows);
          End;
    9120: Begin
          ViewItem(' select KodeCustsupp,NamaCustsupp from DbCustSupp   '+
                   ' Where isaktif=1 and Kodecustsupp in (select kodecustsupp from dbPerkCustSupp where perkiraan=''205008'') '+
                   ' and (KodeCustsupp like ''%'+EditFilter.Text+'%'' or NamaCustsupp like ''%'+EditFilter.Text+'%'') ',
                   ['Kode Ekspedisi','Nama Ekspedisi'],[10,50], QuBrows, EditBrows);
          End;
    9121:begin
            ViewItem('select * from DBRUTE  '+
                     'where (KodeRute like ''%'+EditFilter.Text+'%'' or NamaRute like ''%'+EditFilter.Text+'%'') '+
                     'order by KodeRute',
            ['Kode Rute', 'Nama Rute'],
            [10, 30], QuBrows, EditBrows);
          end;
    91217:begin
            ViewItem('select a.KodeRute,b.NamaRute from dbProject a Left Outer Join DBRUTE b on a.KodeRute=b.KodeRute  '+
                     'where a.KodeProJect='+QuotedStr(IsiData)+' and(a.KodeRute like ''%'+EditFilter.Text+'%'' or NamaRute like ''%'+EditFilter.Text+'%'') '+
                     'order by a.KodeRute',
            ['Kode Rute', 'Nama Rute'],
            [10, 30], QuBrows, EditBrows);
          end;
    91211:begin
            ViewItem('select NoBukti,KodeKend,NamaRute,b.NamaCustSupp from DBRUTETRANS a Left Outer Join dbCustSupp b On a.Ket2=b.KodeCustSupp '+
                     ' Left Outer Join dbRute c On c.KodeRute=a.Rute '+
                     ' where NoBukti Not in(select NoRute From dbRRuteTrans) '+
                     ' and (NoBukti like ''%'+EditFilter.Text+'%'' or NamaCustSupp like ''%'+EditFilter.Text+'%'' or KodeKend like ''%'+EditFilter.Text+'%'' or NamaRute like ''%'+EditFilter.Text+'%'') '+
                     ' order by NoBukti',
            ['No.Bukti', 'No. POL','Rute','Nama Cust.'],
            [25, 15,40,40], QuBrows, EditBrows);
          end;
    9122
        :Begin
           SortBy:='KodeBrg';
           ViewItems('Select A.KODEBRG, A.NAMABRG, A.SAT1 Sat_1, A.Sat2 Sat_2, A.Isi2 Isi, 0 IsSet, 0 IsInspeksi, nFix, 1 Nosat, 0 Urut,B.SALDOQNT '+
                    ' from dbBarang A  '+
                    ' Left Outer Join (Select Kodebrg,isnull(SALDOQNT,0) SALDOQNT,KODEGDG,BULAN,TAHUN  '+
                    ' from DBSTOCKBRG Where KODEGDG=:0 and BULAN=:1 and TAHUN=:2   '+
                    '   )B on A.KODEBRG=B.KODEBRG  '+
                    ' WHERE isnull(SALDOQNT,0)>0 '+
                    ' and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                    ' order by A.KodeBrg',[Nokira,Nokira1,Nokira2],
           ['Kode Barang','Nama Barang','Sat1','Sat2','N','N','N','N','N','N','Stock'],
           [15,60,5,5,1,1,1,10,30,30,1,1,1,50],QuBrows,EditBrows);
         end;
     912212
        :Begin
           SortBy:='KodeBrg';
           ViewItems('Select A.KODEBRG, A.NAMABRG, A.SAT1 Sat_1, A.Isi1 Isi, SUM(B.QNT)QntH,Isnull(C.Qnt,0) QntTr,Sum(B.QNT)-Isnull(C.Qnt,0) Qnt,A1.Qnt SaldoQnt '+
                     'From DBHASILPRDDET B     '+
                     'Left Outer Join DBHASILPRD B1 On B1.NoBukti=B.NoBukti '+
                     'Left Outer Join dbBarang A On A.KODEBRG=B.KODEBRG    '+
                     //'Left Outer Join (select KodeGdg,KodeBrg,SaldoQnt from dbStockbrg where Bulan='+PeriodBln+' and Tahun='+PeriodThn+' )A1 On A1.KodeGdg=B.KodeGdg and A1.KodeBrg=B.KodeBrg  '+
                     ' left Outer Join (select a.Kodegdg,Kodebrg,Sum(QntSaldo)Qnt,Sum(Qnt2Saldo)Qnt2 from vwKartuStock a Left Outer Join dbGudang b On a.KodeGdg=b.KodeGdg where a.Kodegdg='+QuotedStr(isidata1)+ ' and Bulan='+PeriodBln+' and Tahun='+PeriodThn+' and Tanggal<=:0 group by a.Kodegdg,kodebrg)A1 On A1.kodebrg=B.KodeBrg ' +
                     'Left Outer Join (select GDGASAL,KodeBrg,SUM(Qnt)Qnt from DBTRANSFERDET Group by GDGASAL,KodeBrg)C On  C.GDGASAL=B.KodeGdg and C.KODEBRG=B.KODEBRG  '+
                     'where B.Kodegdg=:1   '+
                     'and (A.KODEBRG like ''%'+EditFilter.Text+'%'' or A.NAMABRG like ''%'+EditFilter.Text+'%'') '+
                     'Group by A.KODEBRG, A.NAMABRG,A.SAT1,A.ISI1,Isnull(C.Qnt,0),A.NFix,A1.Qnt    '+
                     'Having Sum(B.QNT)-Isnull(C.Qnt,0)>0  or Isnull(A1.Qnt,0) >0 '+
                     ' order by A.KodeBrg',[TglAwal,Nokira],
           ['Kode Barang','Nama Barang','Satuan','N','Qnt HP','Qnt M','Qnt Sisa','Qnt Stock'],
           [20,60,10,1,30,30,30,30],QuBrows,EditBrows);
         end;
     9122121
        :Begin
           SortBy:='KodeBrg';
           ViewItem('Select b.Kodebrg,b.namaBrg, b.SAT1 Sat_1, b.Isi1 Isi,0 Awal,0 QntR,0 Qnt,0 Qnt2    '+
           'from dbBarang b '+
           'where '+
           '(b.KodeBrg like ''%'+EditFilter.Text+'%'' or b.NamaBrg like ''%'+EditFilter.Text+'%'')  Order By b.KodeBrg ',['Kode Barang','Nama Barang','N','N','N','N','N','N'],[20,60,1,1,1,1,1,1], QuBrows,EditBrows);
         end;
    end;
end;

procedure TFrBrows.ResizeControls(padOnly: boolean);
const spacing = 13;
var
   i,growByWidth, desiredSize: integer;
   minWidth: integer;
   totalColWidth: integer;
   temp: integer;

   Function max(x,y: integer): integer;
   begin
      if x>y then result:=x
      else result:= y;
   end;
   Function min(x,y: integer): integer;
   begin
      if x<y then result:=x
      else result:= y;
   end;
begin
   desiredSize:= GetSystemMetrics(SM_CXHThumb) + 1;  {Win95 fix }
   {$ifdef win32}
   inc(desiredSize,3);
   {$endif}

   minWidth:= 3;

   for i:= 0 to GridBrows.ColumnCount-1 do
      desiredSize:= desiredSize + GridBrows.Columns[i].Width + 1;//GridBrows.GridLineWidth;
   TotalColWidth:= desiredSize;

   if (desiredSize < minWidth) then {pad last field }
   begin
      { 4/30/98 - ColWidths is rounded to character boundary so expand grid by difference }
      //temp:= GridBrows.colWidths[GridBrows.getColCount-1] + (minWidth - desiredSize);
      //GridBrows.colWidths[GridBrows.getColCount-1]:= temp;
      //desiredSize:= minWidth +  GridBrows.colWidths[GridBrows.getColCount-1]-temp;

      temp:= GridBrows.Columns[GridBrows.ColumnCount-1].Width + (minWidth - desiredSize);

      GridBrows.Columns[GridBrows.ColumnCount-1].Width:= temp;
      desiredSize:= minWidth +  GridBrows.Columns[GridBrows.ColumnCount-1].Width-temp;
   end;
   if padOnly then exit;

   If MaxWidth= 0 then MaxWidth:= Screen.width-40
   else MaxWidth:= min(MaxWidth, screen.width - 40);

   desiredSize:= min(desiredSize, MaxWidth);
   desiredSize:= max(desiredSize, minWidth);

   GrowByWidth:= desiredSize - GridBrows.width;
   GridBrows.width:= GridBrows.width + GrowByWidth;

   //if TotalColWidth <= GridBrows.width then  { Don't show horizontal scroll bar }
   //   GridBrows.ShowHorzScrollBar:= False;
   //GridBrows.DoPerfectFit;  { Adjust size before its shown }

   self.width:= self.width + GrowByWidth;

   FrBrows.Width:=GridBrows.width+30;
end;



procedure TFrBrows.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=VK_ESCAPE then
   begin
      Close;
   end else
   if Key=VK_RETURN then begin
      ModalResult:= mrOK;
   end;
end;

procedure TFrBrows.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=cafree;
end;

procedure TFrBrows.GridBrowsDblClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TFrBrows.FormShow(Sender: TObject);
begin
  QuBrows.Connection:=DM.MyStock;
  EditBrows:=IsiData;
  EditBrows1:=IsiData1;
  {TambahBtn.Visible:=false;
  HapusBtn.Visible:=false;
  KoreksiBtn.Visible:=false; }
  GridBrows.OptionsBehavior:=[edgoAutoSearch,edgoAutoSort,edgoDragScroll,edgoEnterShowEditor,edgoMultiSelect,
    edgoTabThrough,edgoVertThrough];
  FilterDataBrows;
  EditBrows:=IsiData;
  Button2.Left:=FrBrows.Width-100;
  Button1.Left:=Button2.Left-75;
  ActiveControl:=EditFilter;
end;

procedure TFrBrows.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TFrBrows.Button2Click(Sender: TObject);
begin
  case KodeBrows of
    100407 : begin
               xAktiva:='NO';
             end;
  end;
  close;
end;

procedure TFrBrows.GridBrowsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button <> mbRight) or (Shift <> []) then Exit;
  TdxDBGridPopupMenuManager.Instance.ShowGridPopupMenu(Sender as TdxDBGrid);
end;

procedure TFrBrows.Button4Click(Sender: TObject);
begin
    GridBrows.SelectAll;
end;

procedure TFrBrows.TambahBtnClick(Sender: TObject);
begin
  case KodeBrows of
    100407 : begin
               xAktiva:='OK';
               ModalResult := mrNo;
             end;
  end;
end;

procedure TFrBrows.GridBrowsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_UP) and (QuBrows.RecNo=1) then
    ActiveControl:=EditFilter;
end;

procedure TFrBrows.EditFilterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Down then
    ActiveControl:=GridBrows;
end;

procedure TFrBrows.EditFilterChange(Sender: TObject);
begin
  FilterDataBrows;
  Application.ProcessMessages;
end;

procedure TFrBrows.GridBrowsCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
Var Value:Variant;
begin
 if (KodeBrows=242013) or(KodeBrows=2420131) Then
  Begin
   Value := ANode.Values[GridBrows.ColumnByFieldName('Saldo').Index] - ANode.Values[GridBrows.ColumnByFieldName('QntMin').Index];
   if Value<=5 then
   begin
     AFont.Color:=clRed;
   end;
  end;
end;

end.
