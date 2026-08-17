unit FrmBrows2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Db, ADODB, StdCtrls, ExtCtrls, Buttons,
  dxCntner, dxTL, dxDBCtrl, dxDBGrid, cxLookAndFeelPainters,StrUtils,dxGridMenus ;

type
  TFrBrows2 = class(TForm)
    QuBrows: TADOQuery;
    DsBrows: TDataSource;
    Panel2: TPanel;
    QuBrowGL: TADOQuery;
    DsQuBrowGL: TDataSource;
    Sp_Simpan: TADOStoredProc;
    GridBrows: TdxDBGrid;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    EditFilter: TEdit;
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
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    xFilterDataBrows: String;
    procedure FilterDataBrows;
  public
     MaxWidth : integer;
     Tbl, brGudang, Gudang, NoKira, NoKira2, Customer,Devisi,kodearea,kodesales,sIsiBrg,JenisBahan:string;
     SortBy,IsiData,isidata1,NoSupp,mNopo,mNoSo,mPosisi,mSales1,mSales2,mLokasi,mKodebrg,mKodegdg,Tipeppn,mNobukti : String;
     GrpTipe,GrpPPN,GrpGdg : Byte;
     TglAwal,TglAkhir:Tdatetime;
     EditBrows,EditBrows1 : String;
     isKecuali,SelectAllRecord : Boolean;
     brTahun, brBulan: Integer;
    { Public declarations }
  end;

const
     LoC = LoCaseInsensitive;
     LoP = LoPartialKey;


var
  FrBrows2: TFrBrows2;
  S:array[0..255]of char;

implementation

uses MyGlobal,MyModul,
  MyProcedure, FrmJual, FrmRJual, FrmAlamatCust;

{$R *.DFM}

Procedure TFrBrows2.ViewItem(mSelect : String; judul,Lebar: Array of Variant;
                             Var mQuery : TAdoQuery;carikata: string);
Var
   I: Word;
Begin
  FrBrows2.DsBrows.DataSet:=mQuery;
  With mQuery Do
  Begin
    Close;
    Sql.Clear;
    Sql.Add(mSelect);
    Open;
  end;
  with FrBrows2.GridBrows do
  begin
     BeginUpdate;
     DestroyColumns;
     KeyField := '';
     DataSource := FrBrows2.DsBrows;
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



Procedure TFrBrows2.ViewItems(mSelect : String; mParam,judul,Lebar: Array of Variant;
                             Var mQuery : TAdoQuery;Carikata:String);
Var
   I,J: Word;
Begin
  FrBrows2.DsBrows.DataSet:=mQuery;
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
  with FrBrows2.GridBrows do
  begin
     BeginUpdate;
     DestroyColumns;
     KeyField := '';
     DataSource := FrBrows2.DsBrows;
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

procedure TFrBrows2.FilterDataBrows;
var xFilterData: String;
    xStrSQL: String;
    
begin
  xFilterData:=QuotedStr('%'+EditFilter.Text+'%');
  case KodeBrows2 of
    1152  : begin
              ViewItem('select KodeKota, NamaKota from dbkota Order by kodekota',
              ['Kode', 'Nama Kota'],[15, 40], QuBrows, EditBrows);
            end;
    1160  : begin
              if NoKira='' then xStrSQL:=''
                else xStrSQL:='where Perkiraan like '+QuotedStr(NoKira);
              ViewItem('select KodeExp, NamaExp from dbExpedisi '+xStrSQL+' order by KodeExp',
              ['Kode', 'Nama Ekspedisi'],
              [15, 50], QuBrows, EditBrows);
            end;
  End;
end;

procedure TFrBrows2.ResizeControls(padOnly: boolean);
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

   FrBrows2.Width:=GridBrows.width+30;
end;



procedure TFrBrows2.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFrBrows2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=cafree;
end;

procedure TFrBrows2.GridBrowsDblClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TFrBrows2.FormShow(Sender: TObject);
begin
  QuBrows.Connection:=DM.MyStock;
  EditBrows:=IsiData;
  EditBrows1:=IsiData1;
  GridBrows.OptionsBehavior:=[edgoAutoSearch,edgoAutoSort,edgoDragScroll,edgoEnterShowEditor,edgoMultiSelect,
    edgoTabThrough,edgoVertThrough];
  FilterDataBrows;
  EditBrows:=IsiData;
end;

procedure TFrBrows2.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TFrBrows2.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TFrBrows2.GridBrowsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button <> mbRight) or (Shift <> []) then Exit;
  TdxDBGridPopupMenuManager.Instance.ShowGridPopupMenu(Sender as TdxDBGrid);
end;

procedure TFrBrows2.Button4Click(Sender: TObject);
begin
    GridBrows.SelectAll;
end;

procedure TFrBrows2.Button3Click(Sender: TObject);
begin
     ModalResult:=mrYes;
end;

end.
