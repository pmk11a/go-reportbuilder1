unit FrmReportPreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, Buttons, StdCtrls, DB, ADODB,
  frxClass, frxPreview, frxDBSet, frxExportXLS, Menus, frxCross, ImgList,
  frxCtrls, frxDock, frxDesgn, frxChart, frxExportTXT, frxExportMail,
  frxExportCSV, frxExportText, frxExportImage, frxExportRTF, frxExportHTML,
  frxExportXML, frxExportPDF, PBNumEdit, Mask, ToolEdit,StrUtils, dxTL, fcTreeView,
  frxDCtrl, math, frxGradient, dateutils, Spin, dxCntner, dxEditor,
  dxExEdtr, dxEdLib, DBCtrls, dxmdaset, dxPageControl;

type
  TFrReportPreview = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Panel4: TPanel;
    QuView: TADOQuery;
    frxDBDataset1: TfrxDBDataset;
    frxXLSExport1: TfrxXLSExport;
    StatusBar1: TStatusBar;
    frxCrossObject1: TfrxCrossObject;
    ToolBar: TToolBar;
    PrintB: TToolButton;
    OpenB: TToolButton;
    SaveB: TToolButton;
    ExportB: TToolButton;
    PdfB: TToolButton;
    EmailB: TToolButton;
    FindB: TToolButton;
    Sep1: TToolButton;
    ZoomWholePageB: TToolButton;
    ZoomPageWidthB: TToolButton;
    Zoom100B: TToolButton;
    Zoom50B: TToolButton;
    Sep3: TfrxTBPanel;
    ZoomCB: TfrxComboBox;
    FullScreenBtn: TToolButton;
    Sep2: TToolButton;
    PageSettingsB: TToolButton;
    OutlineB: TToolButton;
    Sep5: TToolButton;
    HandToolB: TToolButton;
    ZoomToolB: TToolButton;
    Sep7: TToolButton;
    NewPageB: TToolButton;
    DelPageB: TToolButton;
    DesignerB: TToolButton;
    Sep6: TToolButton;
    FirstB: TToolButton;
    PriorB: TToolButton;
    Sep4: TfrxTBPanel;
    PageE: TEdit;
    NextB: TToolButton;
    LastB: TToolButton;
    CancelB: TSpeedButton;
    MainImages: TImageList;
    Image1: TImage;
    RightMenu: TPopupMenu;
    HiddenMenu: TPopupMenu;
    Showtemplate1: TMenuItem;
    ExportPopup: TPopupMenu;
    frxPDFExport1: TfrxPDFExport;
    frxXMLExport1: TfrxXMLExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxRTFExport1: TfrxRTFExport;
    frxBMPExport1: TfrxBMPExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxTIFFExport1: TfrxTIFFExport;
    frxGIFExport1: TfrxGIFExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    frxCSVExport1: TfrxCSVExport;
    frxMailExport1: TfrxMailExport;
    frxTXTExport1: TfrxTXTExport;
    frxChartObject1: TfrxChartObject;
    frxDesigner1: TfrxDesigner;
    SpeedButton2: TSpeedButton;
    ImageList1: TImageList;
    QuMenuRep1: TADOQuery;
    DsMenuRep1: TDataSource;
    QuMenuRep2: TADOQuery;
    DsMenuRep2: TDataSource;
    QuMenuRep3: TADOQuery;
    DsMenuRep3: TDataSource;
    QuMenuRep4: TADOQuery;
    DsMenuRep4: TDataSource;
    QuMenuRep5: TADOQuery;
    DsMenuRep5: TDataSource;
    Panel5: TPanel;
    SpeedButton3: TSpeedButton;
    LJudulReport: TLabel;
    Panel6: TPanel;
    Button2: TButton;
    Button1: TButton;
    TreeB: TToolButton;
    spView: TADOStoredProc;
    sp_totalqntJual: TADOStoredProc;
    frxDBDataset2: TfrxDBDataset;
    Sp_SaldoQntRp: TADOQuery;
    QuRincian: TADOQuery;
    sp_ProsesFifoRetur: TADOStoredProc;
    QuBarang: TADOQuery;
    Sp_FifoIn: TADOStoredProc;
    Sp_FifoOut: TADOStoredProc;
    Sp_BrowsFifoIN: TADOStoredProc;
    frxGradientObject1: TfrxGradientObject;
    ListBox2: TListBox;
    QuPerusahaan: TADOQuery;
    frxDBPerusahaan: TfrxDBDataset;
    Splitter1: TSplitter;
    frxDBDataset3: TfrxDBDataset;
    QuView2: TADOQuery;
    QuView3: TADOQuery;
    frxReport1: TfrxReport;
    fcTreeView1: TfcTreeView;
    dxR: TdxMemData;
    frxDBDataset4: TfrxDBDataset;
    DsView: TDataSource;
    quView4: TADOQuery;
    frxDBDataset5: TfrxDBDataset;
    frxReport2: TfrxReport;
    frxReport3: TfrxReport;
    dxPageControl1: TdxPageControl;
    dxTabSheet1: TdxTabSheet;
    dxTabSheet2: TdxTabSheet;
    Label2: TLabel;
    Divisi: TEdit;
    Perkiraan: TEdit;
    lPerkiraan: TLabel;
    GrpPeriode: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Awal: TDateEdit;
    Akhir: TDateEdit;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Awal3: TDateEdit;
    Akhir3: TDateEdit;
    lPilihRp: TLabel;
    PilihRp: TEdit;
    Perkiraan3: TEdit;
    Label9: TLabel;
    Label6: TLabel;
    Perkiraan2: TEdit;
    Devisi3: TEdit;
    Label5: TLabel;
    dxTabSheet3: TdxTabSheet;
    Tahun: TPBNumEdit;
    Bulan: TPBNumEdit;
    Devisi2: TEdit;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    dxTabSheet4: TdxTabSheet;
    Devisi4: TEdit;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    TglAwal4: TDateEdit;
    TglAkhir4: TDateEdit;
    Label15: TLabel;
    dxTabSheet5: TdxTabSheet;
    Tahun5: TPBNumEdit;
    Bulan5: TPBNumEdit;
    Devisi5: TEdit;
    Label18: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    dxTabSheet6: TdxTabSheet;
    Devisi6: TEdit;
    grpPerkiraan1: TGroupBox;
    lPerkiraan4: TLabel;
    lPerkiraan5: TLabel;
    Perkiraan6A: TEdit;
    Perkiraan6B: TEdit;
    Tahun6: TPBNumEdit;
    Bulan6: TPBNumEdit;
    Label21: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    dxTabSheet7: TdxTabSheet;
    Tanggal7: TDateEdit;
    Devisi7: TEdit;
    Label23: TLabel;
    Label22: TLabel;
    dxTabSheet8: TdxTabSheet;
    KodeVls8: TEdit;
    Valas8: TRadioGroup;
    Urut8: TComboBox;
    gbCustSupp8: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    Awal8: TEdit;
    Akhir8: TEdit;
    Devisi8: TEdit;
    Perkiraan8: TEdit;
    gbPeriode8: TGroupBox;
    LblTglAwal8: TLabel;
    LblTglAkhir8: TLabel;
    TglAwal8: TDateEdit;
    TglAkhir8: TDateEdit;
    Label25: TLabel;
    Label24: TLabel;
    dxTabSheet9: TdxTabSheet;
    GroupBox3: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    TglAwal9: TDateEdit;
    TglAkhir9: TDateEdit;
    Jurnal: TEdit;
    lJurnal: TLabel;
    dxPageControl2: TdxPageControl;
    dxTabSheetPreview: TdxTabSheet;
    dxTabSheetDetail: TdxTabSheet;
    dxTabSheetSubDetail: TdxTabSheet;
    frxPreview1: TfrxPreview;
    frxPreview2: TfrxPreview;
    frxPreview3: TfrxPreview;
    dxTabSheet10: TdxTabSheet;
    Label30: TLabel;
    Bulan10: TPBNumEdit;
    Tahun10: TPBNumEdit;
    Label31: TLabel;
    Gudang10: TEdit;
    Label32: TLabel;
    Satuan10: TComboBox;
    Label33: TLabel;
    ListBox1: TListBox;
    DotMatrix: TCheckBox;
    Button3: TButton;
    Button5: TButton;
    Button4: TButton;
    dxTabSheet11: TdxTabSheet;
    LKodeBrg11: TLabel;
    Label37: TLabel;
    LSDTanggal11: TLabel;
    Periode11: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    TglAwal11: TDateEdit;
    TglAkhir11: TDateEdit;
    KodeBrg11: TEdit;
    Satuan11: TComboBox;
    SDTanggal11: TDateEdit;
    ComboBox1: TComboBox;
    Label36: TLabel;
    RadioGroup1: TRadioGroup;
    dxTabSheet12: TdxTabSheet;
    GroupBox4: TGroupBox;
    Label38: TLabel;
    Label39: TLabel;
    TglAwal13: TDateEdit;
    TglAkhir13: TDateEdit;
    frxDBDataset6: TfrxDBDataset;
    ADOidr: TADOQuery;
    procedure GetMenuLevel1;
    procedure GetMenuLevel2(KdParent:string);
    procedure GetMenuLevel3(KdParent:string);
    procedure GetMenuLevel4(KdParent:string);
    procedure GetMenuLevel5(KdParent:string);
    function GetPageCount: Integer;
    procedure Exit1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure SpeedButton3Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Init;
    procedure ExportMIClick(Sender: TObject);
    procedure PrintBClick(Sender: TObject);
    procedure OpenBClick(Sender: TObject);
    procedure SaveBClick(Sender: TObject);
    procedure PdfBClick(Sender: TObject);
    procedure EmailBClick(Sender: TObject);
    procedure FindBClick(Sender: TObject);
    procedure ZoomWholePageBClick(Sender: TObject);
    procedure ZoomPageWidthBClick(Sender: TObject);
    procedure Zoom100BClick(Sender: TObject);
    procedure Zoom50BClick(Sender: TObject);
    procedure PageSettingsBClick(Sender: TObject);
    procedure OutlineBClick(Sender: TObject);
    procedure HandToolBClick(Sender: TObject);
    procedure ZoomToolBClick(Sender: TObject);
    procedure NewPageBClick(Sender: TObject);
    procedure DelPageBClick(Sender: TObject);
    procedure DesignerBClick(Sender: TObject);
    procedure FirstBClick(Sender: TObject);
    procedure PriorBClick(Sender: TObject);
    procedure NextBClick(Sender: TObject);
    procedure LastBClick(Sender: TObject);
    procedure ZoomCBClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure frxPreview1PageChanged(Sender: TfrxPreview; PageNo: Integer);
    procedure PageEClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure selectreport;
    procedure fcTreeView1DblClick(TreeView: TfcCustomTreeView;
      Node: TfcTreeNode; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TreeBClick(Sender: TObject);
    procedure frxReport1GetValue(const VarName: String;
      var Value: Variant);
    procedure DotMatrixClick(Sender: TObject);
    procedure PerkiraanKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DivisiKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Devisi3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Perkiraan2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Perkiraan3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Devisi4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Devisi5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Devisi6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Perkiraan6AKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Perkiraan6BKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Valas8Click(Sender: TObject);
    procedure Devisi7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Devisi2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Devisi8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Perkiraan8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Awal8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KodeVls8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure frxReport1ClickObject(Sender: TfrxView; Button: TMouseButton;
      Shift: TShiftState; var Modified: Boolean);
    //procedure Gudang10Change(Sender: TObject);
    procedure Gudang10KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure KodeBrg11KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  //  FFullScreen: Boolean;
    mReportStokQntRp: Integer;
    FPDFExport: TfrxCustomExportFilter;
    FEmailExport: TfrxCustomExportFilter;
    FPreviewPages: TfrxCustomPreviewPages;
    //FLocked: Boolean;
    mNamaKlien: String;
    procedure IsiDariListBox1(var pQuery: TADOQuery);
    function  TglStr(aw,ak:tdatetime): string;
    procedure TampilIsiGudang(Sender: TEdit);
    procedure TampilIsiBarang(Sender: TEdit; pTipeBrg: String);
  public
    { Public declarations }
    KodeReport,TabIndex,heightPanel : Integer;
    mTglawal, mtglakhir : Tdatetime;
    PageIdx : Shortint;
    isCustSupp : Boolean;
    vKodeBonus : string;
    property PageCount: Integer read GetPageCount;
    property PreviewPages: TfrxCustomPreviewPages read FPreviewPages write FPreviewPages;
    //property PageNo: Integer read FPageNo write SetPageNo;
  end;

var
  FrReportPreview: TFrReportPreview;
  SelectedSemuaRecord : boolean;
  but : integer;
  MyTreeNode1, MyTreeNode2, MyTreeNode3, MyTreeNode4, MyTreeNode5 : TfcTreeNode;
  mTipe,mPPn,mTipeRPJ : String;
  xKodebonus :string;

implementation

uses Printers, frxPrinter, frxSearchDialog, frxUtils, frxRes, frxDsgnIntf,
  frxPreviewPageSettings, frxDMPClass, myGlobal, MyProcedure, MyModul, FrmBrows;

{$R *.dfm}

procedure TFrReportPreview.IsiDariListBox1(var pQuery: TADOQuery);
var i: Integer;
begin
  for i:= 0 to ListBox1.Count-1 do
  begin
     if i<>ListBox1.Count-1 then
        pQuery.SQL.Add(QuotedStr(ListBox1.Items.Strings[i])+',')
     else
        pQuery.SQL.Add(QuotedStr(ListBox1.Items.Strings[i])+') ');
  end;
end;

function TFrReportPreview.TglStr(aw,ak:tdatetime): string;
begin
  TglStr:=FormatDateTime('dd/MM/yyyy',aw)+' s/d '+FormatDateTime('dd/MM/yyyy',ak);
end;

procedure TFrReportPreview.TampilIsiGudang(Sender: TEdit);
begin
  KodeBrows:=1101;
  Application.CreateForm(TFrBrows, FrBrows);
  FrBrows.IsiData:=(Sender as TEdit).Text;
  FrBrows.showmodal;
  if FrBrows.ModalResult=mrOk then
  begin
    (Sender as TEdit).Text:=FrBrows.QuBrows.fieldbyname('KodeGdg').AsString;
  end
  else
    ActiveControl:=Sender;
end;

procedure TFrReportPreview.TampilIsiBarang(Sender: TEdit; pTipeBrg: String);
begin
  if pTipeBrg='' then KodeBrows:=1140
  else if pTipeBrg='0' then KodeBrows:=11401
  else if pTipeBrg='1' then KodeBrows:=11402;
  Application.CreateForm(TFrBrows, FrBrows);
  FrBrows.IsiData:=(Sender as TEdit).Text;
  FrBrows.showmodal;
  if FrBrows.ModalResult=mrOk then
  begin
    (Sender as TEdit).Text:=FrBrows.QuBrows.fieldbyname('KodeBrg').AsString;
  end
  else
    ActiveControl:=Sender;
end;

procedure TFrReportPreview.GetMenuLevel1;
begin
   with qumenurep1 do
   begin
      close;
      sql.clear;
      sql.add('select * from dbflmenureport ');
      sql.add('where userid='+quotedstr(iduser)+' and access=1 and l0=1 ');
      sql.add('order by l1 ');
      open;
   end;
end;

procedure TFrReportPreview.GetMenuLevel2(KdParent:string);
begin
   with qumenurep2 do
   begin
      close;
      sql.clear;
      sql.add('select * from dbflmenureport ');
      sql.add('where userid='+quotedstr(iduser)+' and access=1 and l0=2 ');
      sql.add('and l1 like '+#39+KdParent+#37+#39);
      sql.add('order by l1 ');
      open;
   end;
end;

procedure TFrReportPreview.GetMenuLevel3(KdParent:string);
begin
   with qumenurep3 do
   begin
      close;
      sql.clear;
      sql.add('select * from dbflmenureport ');
      sql.add('where userid='+quotedstr(iduser)+' and access=1 and l0=3 ');
      sql.add('and l1 like '+#39+KdParent+#37+#39);
      sql.add('order by l1 ');
      open;
   end;
end;

procedure TFrReportPreview.GetMenuLevel4(KdParent:string);
begin
   with qumenurep4 do
   begin
      close;
      sql.clear;
      sql.add('select * from dbflmenureport ');
      sql.add('where userid='+quotedstr(iduser)+' and access=1 and l0=4 ');
      sql.add('and l1 like '+#39+KdParent+#37+#39);
      sql.add('order by l1 ');
      open;
   end;
end;

procedure TFrReportPreview.GetMenuLevel5(KdParent:string);
begin
   with qumenurep5 do
   begin
      close;
      sql.clear;
      sql.add('select * from dbflmenureport ');
      sql.add('where userid='+quotedstr(iduser)+' and access=1 and l0=5 ');
      sql.add('and l1 like '+#39+KdParent+#37+#39);
      sql.add('order by l1 ');
      open;
   end;
end;

function TFrReportPreview.GetPageCount: Integer;
begin
  if PreviewPages <> nil then
    Result := PreviewPages.Count else
    Result := 0;
end;


procedure TFrReportPreview.ExportMIClick(Sender: TObject);
begin
  frxPreview1.Export(TfrxCustomExportFilter(frxExportFilters[TMenuItem(Sender).Tag].Filter));
  Enabled := True;
end;

procedure TFrReportPreview.Init;
var
  i, j, k: Integer;
  m, e: TMenuItem;
begin
  with frxReport1.PreviewOptions do
  begin
    if Maximized then
      WindowState := wsMaximized;
    if MDIChild then
      FormStyle := fsMDIChild;
    frxPreview1.OutlineVisible := OutlineVisible;
    frxPreview1.OutlineWidth := OutlineWidth;
    frxPreview1.Zoom := Zoom;
    frxPreview1.ZoomMode := ZoomMode;

    NewPageB.Enabled := AllowEdit;
    DelPageB.Enabled := AllowEdit;
    DesignerB.Enabled := AllowEdit;

    PrintB.Visible := pbPrint in Buttons;
    OpenB.Visible := pbLoad in Buttons;
    SaveB.Visible := pbSave in Buttons;
    ExportB.Visible := pbExport in Buttons;
    FindB.Visible := pbFind in Buttons;

    ZoomWholePageB.Visible := pbZoom in Buttons;
    ZoomPageWidthB.Visible := pbZoom in Buttons;
    Zoom100B.Visible := pbZoom in Buttons;
    Zoom50B.Visible := pbZoom in Buttons;
    Sep3.Visible := pbZoom in Buttons;
    FullScreenBtn.Visible := pbZoom in Buttons;
    if not (pbZoom in Buttons) then
      Sep1.Free;

    OutlineB.Visible := pbOutline in Buttons;
    OutlineB.Down := OutlineVisible;
    PageSettingsB.Visible := pbPageSetup in Buttons;
    if not (OutlineB.Visible or PageSettingsB.Visible) then
      Sep2.Free;

    HandToolB.Visible := pbTools in Buttons;
    ZoomToolB.Visible := pbTools in Buttons;
    if not (pbTools in Buttons) then
      Sep5.Free;

    NewPageB.Visible := pbEdit in Buttons;
    DelPageB.Visible := pbEdit in Buttons;
    DesignerB.Visible := pbEdit in Buttons;
    if not (pbEdit in Buttons) then
      Sep7.Free;

    FirstB.Visible := pbNavigator in Buttons;
    PriorB.Visible := pbNavigator in Buttons;
    NextB.Visible := pbNavigator in Buttons;
    LastB.Visible := pbNavigator in Buttons;
    Sep4.Visible := pbNavigator in Buttons;
    if not (pbNavigator in Buttons) then
      Sep6.Free;

    Toolbar.ShowCaptions := ShowCaptions;
  end;

  if (frxExportFilters.Count = 0) or
     ((frxExportFilters.Count = 1) and (frxExportFilters[0].Filter = frxDotMatrixExport)) then
    ExportB.Visible := False;

  for i := 0 to frxExportFilters.Count - 1 do
  begin
    if frxExportFilters[i].Filter = frxDotMatrixExport then
      continue;
    m := TMenuItem.Create(ExportPopup);
    ExportPopup.Items.Add(m);
    m.Caption := TfrxCustomExportFilter(frxExportFilters[i].Filter).GetDescription + '...';
    m.Tag := i;
    m.OnClick := ExportMIClick;
    if TfrxCustomExportFilter(frxExportFilters[i].Filter).ClassName = 'TfrxPDFExport' then
    begin
      FPDFExport := TfrxCustomExportFilter(frxExportFilters[i].Filter);
      PdfB.Visible := ExportB.Visible;
    end;
    if TfrxCustomExportFilter(frxExportFilters[i].Filter).ClassName = 'TfrxMailExport' then
    begin
      FEmailExport := TfrxCustomExportFilter(frxExportFilters[i].Filter);
      EmailB.Visible := ExportB.Visible;
    end;
  end;

  if frxReport1.ReportOptions.Name <> '' then
    Caption := frxReport1.ReportOptions.Name;
  //Init;

  k := 0;
  for i := 0 to ToolBar.ButtonCount - 1 do
  begin
    if (ToolBar.Buttons[i].Style <> tbsCheck) and
       (ToolBar.Buttons[i].Visible) and
       (ToolBar.Buttons[i].Hint <> '') then
    begin
      m := TMenuItem.Create(RightMenu);
      RightMenu.Items.Add(m);
      m.Caption := ToolBar.Buttons[i].Hint;
      m.OnClick := ToolBar.Buttons[i].OnClick;
      m.ImageIndex := ToolBar.Buttons[i].ImageIndex;
      if Assigned(ToolBar.Buttons[i].DropdownMenu) then
        for j := 0  to ToolBar.Buttons[i].DropdownMenu.Items.Count - 1 do
        begin
          e := TMenuItem.Create(m);
          e.Caption := ToolBar.Buttons[i].DropdownMenu.Items[j].Caption;
          e.Tag := ToolBar.Buttons[i].DropdownMenu.Items[j].Tag;
          e.OnClick := ToolBar.Buttons[i].DropdownMenu.Items[j].OnClick;
          m.Add(e);
        end;
    end;
    if ToolBar.Buttons[i].Style = tbsSeparator then
    begin
      if k = 1 then
        break;
      m := TMenuItem.Create(RightMenu);
      RightMenu.Items.Add(m);
      m.Caption := '-';
      Inc(k);
    end;
  end;

end;

procedure TFrReportPreview.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrReportPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ModalResult:=mrOk;
  Action:=cafree;
end;

procedure TFrReportPreview.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  if Node.HasChildren=false then
  begin
      StatusBar1.Panels[0].Text:=Node.Text;
  end;
end;

procedure TFrReportPreview.SpeedButton3Click(Sender: TObject);
begin
   panel5.visible := false;
end;

procedure TFrReportPreview.ToolButton3Click(Sender: TObject);
begin
  frxPreview1.ZoomMode:=zmPageWidth;
end;

procedure TFrReportPreview.FormCreate(Sender: TObject);
var
  i, j, k: Integer;
  m, e: TMenuItem;
begin
  if panel5.height>=348 then
     heightPanel := panel5.height
  else
     heightPanel := 348;
  //Caption := frxGet(100);
  PrintB.Caption := frxGet(101);
  PrintB.Hint := frxGet(102);
  OpenB.Caption := frxGet(103);
  OpenB.Hint := frxGet(104);
  SaveB.Caption := frxGet(105);
  SaveB.Hint := frxGet(106);
  ExportB.Caption := frxGet(107);
  ExportB.Hint := frxGet(108);
  FindB.Caption := frxGet(109);
  FindB.Hint := frxGet(110);
  ZoomWholePageB.Caption := frxGet(111);
  ZoomWholePageB.Hint := frxGet(112);
  ZoomPageWidthB.Caption := frxGet(113);
  ZoomPageWidthB.Hint := frxGet(114);
  Zoom100B.Caption := frxGet(115);
  Zoom100B.Hint := frxGet(116);
  Zoom50B.Caption := frxGet(117);
  Zoom50B.Hint := frxGet(118);
  ZoomCB.Hint := frxGet(119);
  PageSettingsB.Caption := frxGet(120);
  PageSettingsB.Hint := frxGet(121);
  OutlineB.Caption := frxGet(122);
  OutlineB.Hint := frxGet(123);
  HandToolB.Caption := frxGet(124);
  HandToolB.Hint := frxGet(125);
  ZoomToolB.Caption := frxGet(126);
  ZoomToolB.Hint := frxGet(127);
  NewPageB.Caption := frxGet(128);
  NewPageB.Hint := frxGet(129);
  DelPageB.Caption := frxGet(130);
  DelPageB.Hint := frxGet(131);
  DesignerB.Caption := frxGet(132);
  DesignerB.Hint := frxGet(133);
  FirstB.Caption := frxGet(134);
  FirstB.Hint := frxGet(135);
  PriorB.Caption := frxGet(136);
  PriorB.Hint := frxGet(137);
  NextB.Caption := frxGet(138);
  NextB.Hint := frxGet(139);
  LastB.Caption := frxGet(140);
  LastB.Hint := frxGet(141);
  CancelB.Caption := frxGet(2);
  PageE.Hint := frxGet(142);
  FullScreenBtn.Hint := frxGet(150);
  PdfB.Hint := frxGet(151);
  EmailB.Hint := frxGet(152);
  ZoomCB.Items.Clear;
  ZoomCB.Items.Add('25%');
  ZoomCB.Items.Add('50%');
  ZoomCB.Items.Add('75%');
  ZoomCB.Items.Add('100%');
  ZoomCB.Items.Add('150%');
  ZoomCB.Items.Add('200%');
  ZoomCB.Items.Add(frxResources.Get('zmPageWidth'));
  ZoomCB.Items.Add(frxResources.Get('zmWholePage'));
  frxAssignImages(Image1.Picture.Bitmap, 16, 16, MainImages);
  Image1.Free;

  //ActiveControl := frxPreview1;
  SetWindowLong(PageE.Handle, GWL_STYLE, GetWindowLong(PageE.Handle, GWL_STYLE) or ES_NUMBER);

  if (frxExportFilters.Count = 0) or
     ((frxExportFilters.Count = 1) and (frxExportFilters[0].Filter = frxDotMatrixExport)) then
    ExportB.Visible := False;

  for i := 0 to frxExportFilters.Count - 1 do
  begin
    if frxExportFilters[i].Filter = frxDotMatrixExport then
      continue;
    m := TMenuItem.Create(ExportPopup);
    ExportPopup.Items.Add(m);
    m.Caption := TfrxCustomExportFilter(frxExportFilters[i].Filter).GetDescription + '...';
    m.Tag := i;
    m.OnClick := ExportMIClick;
    if TfrxCustomExportFilter(frxExportFilters[i].Filter).ClassName = 'TfrxPDFExport' then
    begin
      FPDFExport := TfrxCustomExportFilter(frxExportFilters[i].Filter);
      PdfB.Visible := ExportB.Visible;
    end;
    if TfrxCustomExportFilter(frxExportFilters[i].Filter).ClassName = 'TfrxMailExport' then
    begin
      FEmailExport := TfrxCustomExportFilter(frxExportFilters[i].Filter);
      EmailB.Visible := ExportB.Visible;
    end;
  end;

  frxPreview1.Init;
  k := 0;
  for i := 0 to ToolBar.ButtonCount - 1 do
  begin
    if (ToolBar.Buttons[i].Style <> tbsCheck) and
       (ToolBar.Buttons[i].Visible) and
       (ToolBar.Buttons[i].Hint <> '') then
    begin
      m := TMenuItem.Create(RightMenu);
      RightMenu.Items.Add(m);
      m.Caption := ToolBar.Buttons[i].Hint;
      m.OnClick := ToolBar.Buttons[i].OnClick;
      m.ImageIndex := ToolBar.Buttons[i].ImageIndex;
      if Assigned(ToolBar.Buttons[i].DropdownMenu) then
        for j := 0  to ToolBar.Buttons[i].DropdownMenu.Items.Count - 1 do
        begin
          e := TMenuItem.Create(m);
          e.Caption := ToolBar.Buttons[i].DropdownMenu.Items[j].Caption;
          e.Tag := ToolBar.Buttons[i].DropdownMenu.Items[j].Tag;
          e.OnClick := ToolBar.Buttons[i].DropdownMenu.Items[j].OnClick;
          m.Add(e);
        end;
    end;
    if ToolBar.Buttons[i].Style = tbsSeparator then
    begin
      if k = 1 then
        break;
      m := TMenuItem.Create(RightMenu);
      RightMenu.Items.Add(m);
      m.Caption := '-';
      Inc(k);
    end;
  end;
  dxPageControl2.Pages[1].TabVisible:=false;
  dxPageControl2.Pages[2].TabVisible:=false;
  dxPageControl1.HideButtons:=True;
end;

procedure TFrReportPreview.PrintBClick(Sender: TObject);
begin
  if not frxPrinters.HasPhysicalPrinters then
    frxErrorMsg(frxResources.Get('clNoPrinters')) else
    frxPreview1.Print;
  Enabled := True;
end;

procedure TFrReportPreview.OpenBClick(Sender: TObject);
begin
  frxPreview1.LoadFromFile;
end;

procedure TFrReportPreview.SaveBClick(Sender: TObject);
begin
  frxPreview1.SaveToFile;
end;

procedure TFrReportPreview.PdfBClick(Sender: TObject);
begin
  if Assigned(FPDFExport) then
    frxPreview1.Export(FPDFExport);
end;

procedure TFrReportPreview.EmailBClick(Sender: TObject);
begin
  if Assigned(FEmailExport) then
    frxPreview1.Export(FEmailExport);
end;

procedure TFrReportPreview.FindBClick(Sender: TObject);
begin
  frxPreview1.Find;
end;

procedure TFrReportPreview.ZoomWholePageBClick(Sender: TObject);
begin
  frxPreview1.ZoomMode := zmWholePage;
end;

procedure TFrReportPreview.ZoomPageWidthBClick(Sender: TObject);
begin
  frxPreview1.ZoomMode := zmPageWidth;
end;

procedure TFrReportPreview.Zoom100BClick(Sender: TObject);
begin
  frxPreview1.Zoom := 1;
end;

procedure TFrReportPreview.Zoom50BClick(Sender: TObject);
begin
  frxPreview1.ZoomMode := zmManyPages;
end;

procedure TFrReportPreview.PageSettingsBClick(Sender: TObject);
begin
  frxPreview1.PageSetupDlg;
end;

procedure TFrReportPreview.OutlineBClick(Sender: TObject);
begin
  frxPreview1.OutlineVisible := OutlineB.Down;
end;

procedure TFrReportPreview.HandToolBClick(Sender: TObject);
begin
  if HandToolB.Down then
    frxPreview1.Tool := ptHand
  else if ZoomToolB.Down then
    frxPreview1.Tool := ptZoom
end;

procedure TFrReportPreview.ZoomToolBClick(Sender: TObject);
begin
  if HandToolB.Down then
    frxPreview1.Tool := ptHand
  else if ZoomToolB.Down then
    frxPreview1.Tool := ptZoom
end;

procedure TFrReportPreview.NewPageBClick(Sender: TObject);
begin
  frxPreview1.AddPage;
end;

procedure TFrReportPreview.DelPageBClick(Sender: TObject);
begin
  frxPreview1.DeletePage;
end;

procedure TFrReportPreview.DesignerBClick(Sender: TObject);
begin
  frxPreview1.Edit;
end;

procedure TFrReportPreview.FirstBClick(Sender: TObject);
begin
  frxPreview1.First;
end;

procedure TFrReportPreview.PriorBClick(Sender: TObject);
begin
  frxPreview1.Prior;
end;

procedure TFrReportPreview.NextBClick(Sender: TObject);
begin
  frxPreview1.Next;
end;

procedure TFrReportPreview.LastBClick(Sender: TObject);
begin
  frxPreview1.Last;
end;

procedure TFrReportPreview.ZoomCBClick(Sender: TObject);
var
  s: String;
begin
  frxPreview1.SetFocus;

  if ZoomCB.ItemIndex = 6 then
    ZoomPageWidthBClick(nil)
  else if ZoomCB.ItemIndex = 7 then
    ZoomWholePageBClick(nil)
  else
  begin
    s := ZoomCB.Text;

    if Pos('%', s) <> 0 then
      s[Pos('%', s)] := ' ';
    while Pos(' ', s) <> 0 do
      Delete(s, Pos(' ', s), 1);

    if s <> '' then
      frxPreview1.Zoom := frxStrToFloat(s) / 100;
  end;

  PostMessage(Handle, WM_UPDATEZOOM, 0, 0);
end;

procedure TFrReportPreview.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  frxPreview1.MouseWheelScroll(WheelDelta, False, ssCtrl in Shift);
end;

procedure TFrReportPreview.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if ActiveControl = ZoomCB then
      ZoomCBClick(nil)
    else
    if ActiveControl = PageE then
      PageEClick(nil)
    else
      sendmessage(handle,wm_nextdlgctl,0,0);
  end;
end;

procedure TFrReportPreview.frxPreview1PageChanged(Sender: TfrxPreview;
  PageNo: Integer);
begin
  PageE.Text:=IntToStr(PageNo);
end;

procedure TFrReportPreview.PageEClick(Sender: TObject);
begin
  frxPreview1.PageNo := StrToInt(PageE.Text);
  frxPreview1.SetFocus;
end;

procedure TFrReportPreview.CancelBClick(Sender: TObject);
begin
  Close;
end;

procedure TFrReportPreview.FormDestroy(Sender: TObject);
begin
  FrReportPreview:=nil;
end;

procedure TFrReportPreview.SpeedButton2Click(Sender: TObject);
begin
  frxReport1.DesignReport;
end;

procedure TFrReportPreview.FormShow(Sender: TObject);
begin
   DataBersyarat('select * from dbPerusahaan where 1=:0',[1],DM.QuCari);
   mNamaKlien:=DM.QuCari.FieldByName('Nama').AsString;
   fcTreeView1.Items.Clear;
   GetMenuLevel1;
   QuMenuRep1.first;
   while not(QuMenuRep1.eof) do
   begin
      MyTreeNode1 := fctreeview1.Items.Add(nil, qumenurep1.Fieldbyname('nmreport').AsString);
      MyTreeNode1.StringData := qumenurep1.Fieldbyname('access').AsString;
      MyTreeNode1.StringData2 := inttostr(qumenurep1.Fieldbyname('kodereport').Asinteger);

      GetMenuLevel2(qumenurep1.fieldbyname('l1').asstring);
      QuMenuRep2.First;
      while not(qumenurep2.Eof) do
      begin
         MyTreeNode2 := fctreeview1.Items.AddChild(mytreenode1, qumenurep2.Fieldbyname('nmreport').AsString);
         MyTreeNode2.StringData := qumenurep2.Fieldbyname('access').AsString;
         MyTreeNode2.StringData2 := inttostr(qumenurep2.Fieldbyname('kodereport').Asinteger);

         GetMenuLevel3(qumenurep2.fieldbyname('l1').asstring);
         QuMenuRep3.First;
         while not(QuMenuRep3.Eof) do
         begin
            MyTreeNode3 := fctreeview1.Items.AddChild(mytreenode2, qumenurep3.Fieldbyname('nmreport').AsString);
            MyTreeNode3.StringData := qumenurep3.Fieldbyname('access').AsString;
            MyTreeNode3.StringData2 := inttostr(qumenurep3.Fieldbyname('kodereport').Asinteger);
            GetMenuLevel4(qumenurep3.fieldbyname('l1').asstring);
            QuMenuRep4.First;
            while not(qumenurep4.Eof) do
            begin
               MyTreeNode4 := fctreeview1.Items.AddChild(mytreenode3, qumenurep4.Fieldbyname('nmreport').AsString);
               MyTreeNode4.StringData := qumenurep4.Fieldbyname('access').AsString;
               MyTreeNode4.StringData2 := inttostr(qumenurep4.Fieldbyname('kodereport').Asinteger);
               GetMenuLevel5(qumenurep4.fieldbyname('l1').asstring);
               QuMenuRep5.First;
               while not(qumenurep5.Eof) do
               begin
                  MyTreeNode5 := fctreeview1.Items.AddChild(mytreenode4, qumenurep5.Fieldbyname('nmreport').AsString);
                  MyTreeNode5.StringData := qumenurep5.Fieldbyname('access').AsString;
                  MyTreeNode5.StringData2 := inttostr(qumenurep5.Fieldbyname('kodereport').Asinteger);
                  QuMenuRep5.Next;
               end;
               QuMenuRep4.Next;
            end;
            QuMenuRep3.Next;
         end;
         QuMenuRep2.next;
      end;
      QuMenuRep1.next;
   end;
end;

procedure TFrReportPreview.fcTreeView1DblClick(TreeView: TfcCustomTreeView;
  Node: TfcTreeNode; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var vkodebonus : string;
begin
  DotMatrix.Visible:=False;
  if TreeView.GetNodeAt(x,y)<>nil then
  begin
    if not(Node.HasChildren) then
    begin
      KodeReport:=StrToInt(Node.StringData2);
      Panel5.visible:=True;
      Button2.Visible:=true;
      case KodeReport of
          101 : ShowReportPreview(' Master Perkiraan ',-1);
          273 : begin
                ShowReportPreview(' Daftar Harga',10);
                              Periode11.Visible:=True;
                              TglAwal11.Date:=EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                              TglAkhir11.Date:=IncDay(IncMonth(TglAwal11.Date,1),-1);
                              KodeBrg11.Visible:=False;
                              SDTanggal11.Visible:=false;
                              LKodeBrg11.Visible:=false;
                              Label37.Visible:=false;
                              Satuan11.Visible:=false;
                              //LKodeBrg11.Caption:='Kode Barang';
                              //Button2.Visible:=true;
                end;

         // 201 :
       300101 : begin
                  ShowReportPreview(' Laporan Kas Harian',0);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Divisi.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Divisi.Enabled:=DM.QuCari.RecordCount>1;
                  Perkiraan.Text:='';
                  if Divisi.CanFocus then
                    ActiveControl:=Divisi
                  else ActiveControl:=Perkiraan;
                end;
       300102 : begin
                  ShowReportPreview(' Laporan Bank Harian',0);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Divisi.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Divisi.Enabled:=DM.QuCari.RecordCount>1;
                  Perkiraan.Text:='';
                  if Divisi.CanFocus then
                    ActiveControl:=Divisi
                  else ActiveControl:=Perkiraan;
                end;
       300103 : begin
                  ShowReportPreview(' Rekap Kas dan Bank Harian',0);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Divisi.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Divisi.Enabled:=DM.QuCari.RecordCount>1;
                end;
       300110 : begin
                  ShowReportPreview(' Posisi Bank, Kas & Piutang',6);
                  //TabSheet7.Caption:='Posisi Bank, Kas & Piutang';
                  Tanggal7.Date:=Now;
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi7.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi7.Enabled:=DM.QuCari.RecordCount>1;
                end;
       300202 : begin
                  ShowReportPreview(' Buku Tambahan ',1);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi3.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi3.Enabled:=DM.QuCari.RecordCount>1;
                end;
       300501 : begin
                  Bulan.Value:=StrToInt(PeriodBln);
                  Tahun.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi2.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi2.Enabled:=DM.QuCari.RecordCount>1;
                  ShowReportPreview(' Neraca Lajur',2);
                end;
       300502 : begin
                  Bulan.Value:=StrToInt(PeriodBln);
                  Tahun.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi2.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi2.Enabled:=DM.QuCari.RecordCount>1;
                  ShowReportPreview(' HPP',2);
                end;
       300503 : begin
                  Bulan.Value:=StrToInt(PeriodBln);
                  Tahun.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi2.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi2.Enabled:=DM.QuCari.RecordCount>1;
                  ShowReportPreview(' Laba Rugi',2);
                end;
       300504 : begin
                  Bulan.Value:=StrToInt(PeriodBln);
                  Tahun.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi2.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi2.Enabled:=DM.QuCari.RecordCount>1;
                  ShowReportPreview(' Neraca',2);
                end;
       300505 : begin
                  Bulan.Value:=StrToInt(PeriodBln);
                  Tahun.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi2.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi2.Enabled:=DM.QuCari.RecordCount>1;
                  ShowReportPreview(' Neraca Penunjang',2);
                end;
       30020101..30020107, 300201062, 300201064 :
                begin
                  case KodeReport of
                    30020101 : ShowReportPreview(' Jurnal Penerimaan Kas',3);
                    30020102 : ShowReportPreview(' Jurnal Pengeluaran Kas',3);
                    30020103 : ShowReportPreview(' Jurnal Penerimaan Bank',3);
                    30020104 : ShowReportPreview(' Jurnal Pengeluaran Bank',3);
                    30020105 : ShowReportPreview(' Jurnal Memorial',3);
                    30020106 : ShowReportPreview(' Jurnal Koreksi',3);
                    300201062: ShowReportPreview(' Jurnal Pembelian',3);
                    300201064: ShowReportPreview(' Jurnal Penjualan',3);
                    30020107 : ShowReportPreview(' Jurnal Penutup',3);
                  end;
                  TglAwal4.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                  TglAkhir4.Date := incday(incmonth(TglAwal4.Date,1),-1);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi4.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi4.Enabled:=DM.QuCari.RecordCount>1;
                end;
       300203 : begin
                  ShowReportPreview(' Mutasi',4);
                  Bulan5.Value:=StrToInt(PeriodBln);
                  Tahun5.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi5.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi5.Enabled:=DM.QuCari.RecordCount>1;
                end;
       300204 : begin
                  ShowReportPreview(' Laporan Biaya',5);
                  //TabSheet6.Caption:='Laporan Biaya';
                  Bulan6.Value:=StrToInt(PeriodBln);
                  Tahun6.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi6.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi6.Enabled:=DM.QuCari.RecordCount>1;
                end;
       300207 : begin
                  ShowReportPreview(' Laporan Aktiva',4);
                  //TabSheet5.Caption:='Laporan Aktiva';
                  Bulan5.Value:=StrToInt(PeriodBln);
                  Tahun5.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi5.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi5.Enabled:=DM.QuCari.RecordCount>1;
                end;
       300208 : begin
                  ShowReportPreview(' Laporan Biaya Penyusutan',4);
                  //TabSheet5.Caption:='Laporan Biaya Penyusutan';
                  Bulan5.Value:=StrToInt(PeriodBln);
                  Tahun5.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi5.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi5.Enabled:=DM.QuCari.RecordCount>1;
                end;
       300301, 300302, 300303, 300304, 300305 :
                begin
                  case KodeReport of
                    300301 : ShowReportPreview(' Kartu Hutang',7);
                    300302 : ShowReportPreview(' Sisa Hutang',7);
                    300303 : ShowReportPreview(' Pelunasan Hutang',7);
                    300304 : ShowReportPreview(' Saldo Hutang',7);
                    300305 : ShowReportPreview(' Umur Hutang',7);
                  end;
                  TglAwal8.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                  TglAkhir8.Date := incday(incmonth(TglAwal8.Date,1),-1);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi8.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi8.Enabled:=DM.QuCari.RecordCount>1;
                  case KodeReport of
                    300301, 300303, 300304 :
                      begin
                        gbPeriode8.Caption:='Periode';
                        LblTglAwal8.Visible:=True;
                        LblTglAkhir8.Visible:=True;
                        TglAwal8.Visible:=True;
                      end;
                    300302, 300305 :
                      begin
                        gbPeriode8.Caption:='s/d Tanggal';
                        LblTglAwal8.Visible:=False;
                        LblTglAkhir8.Visible:=False;
                        TglAwal8.Visible:=False;
                      end;
                  end;
                  Urut8.Clear;
                  Urut8.Items.Add('Tanggal');
                  Urut8.Items.Add('No. Nota');
                  Urut8.ItemIndex:=0;
                  Urut8.Visible:=KodeReport<>300304;
                  gbCustSupp8.Caption:='Supplier';
                end;
       300401, 300402, 300403, 300404, 300405 :
                begin
                  case KodeReport of
                    300401 : ShowReportPreview(' Kartu Piutang',7);
                    300402 : ShowReportPreview(' Sisa Piutang',7);
                    300403 : ShowReportPreview(' Pelunasan Piutang',7);
                    300404 : ShowReportPreview(' Saldo Piutang',7);
                    300405 : ShowReportPreview(' Umur Piutang',7);
                  end;
                  TglAwal8.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                  TglAkhir8.Date := incday(incmonth(TglAwal8.Date,1),-1);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi8.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi8.Enabled:=DM.QuCari.RecordCount>1;
                  case KodeReport of
                    300401, 300403, 300404 :
                      begin
                        gbPeriode8.Caption:='Periode';
                        LblTglAwal8.Visible:=True;
                        LblTglAkhir8.Visible:=True;
                        TglAwal8.Visible:=True;
                      end;
                    300402, 300405 :
                      begin
                        gbPeriode8.Caption:='s/d Tanggal';
                        LblTglAwal8.Visible:=False;
                        LblTglAkhir8.Visible:=False;
                        TglAwal8.Visible:=False;
                      end;
                  end;
                  Urut8.Clear;
                  Urut8.Items.Add('Tanggal');
                  Urut8.Items.Add('No. Nota');
                  Urut8.ItemIndex:=0;
                  Urut8.Visible:=KodeReport<>300404;
                  gbCustSupp8.Caption:='Customer';
                end;
       51705, 51707, 51709, 51715, 51720, 51725, 51730,51734,51735 :
                begin
                 radiogroup1.visible :=true;
                    combobox1.visible :=true;
                    label36.visible :=true;
                  case KodeReport of
                    51705 : ShowReportPreview(' OP Per No. Bukti',8);
                    51707 : ShowReportPreview(' OP Per Pemasok',8);
                    51709 : ShowReportPreview(' OP Per Barang',8);
                    51715 :
                    begin
                    ShowReportPreview(' Ketepatan Pembuatan OP',8);
                    radiogroup1.visible :=false;
                    combobox1.visible :=false;
                    label36.visible :=false;
                    end;
                    51720 :
                    begin
                    ShowReportPreview(' Outstanding OP',8);
                    radiogroup1.visible :=false;
                    combobox1.visible :=false;
                    label36.visible :=false;
                    end;
                    51725 :
                    begin
                    ShowReportPreview(' Outstanding Pembayaran OP',8);
                     radiogroup1.visible :=false;
                    combobox1.visible :=false;
                    label36.visible :=false;
                    end;
                    51730 :
                    begin
                    ShowReportPreview(' Realisasi Pembayaran OP',8);
                    radiogroup1.visible :=false;
                    combobox1.visible :=false;
                    label36.visible :=false;
                    end;
                    51734 :
                    begin
                    ShowReportPreview(' Per Jenis Barang',8);
                    radiogroup1.visible :=false;
                    combobox1.visible :=false;
                    label36.visible :=false;
                     end;
                    51735 : ShowReportPreview(' Realisasi OP Import',8);
                  end;
                  TglAwal9.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                  TglAkhir9.Date := incday(incmonth(TglAwal9.Date,1),-1);
                  button3.Visible :=false;

                  button4.Visible :=false;
                 // button5.Visible :=false;
                  button5.Visible :=false;
                end;
       52320, 52325, 52330, 52315, 51731,51732,51733,52335,52410,52420,52430,52440,52510,52520
       ,52530,52540,52610,52620,52630,52640 :
                begin
                 radiogroup1.visible :=true;
                    combobox1.visible :=true;
                    label36.visible :=true;
                  case KodeReport of
                    52320 : ShowReportPreview(' Penerimaan Barang Per No. Bukti',8);
                    52325 : ShowReportPreview(' Penerimaan Barang Per Pemasok',8);
                    52330 : ShowReportPreview(' Penerimaan Barang Per Barang',8);
                    52335 : ShowReportPreview(' Penerimaan Barang Per Jenis Barang',8);
                    52410 : ShowReportPreview(' Retur Penerimaan Per No. Bukti',8);
                    52420 : ShowReportPreview(' Retur Penerimaan Per Supplier',8);
                    52430 : ShowReportPreview(' Retur Penerimaan Per Barang',8);
                    52440 : ShowReportPreview(' Retur Penerimaan Per Jenis Barang',8);


                    52510,52520,52530,52540,52610,52620,52630,52640 :
                    begin
                     case kodereport of
                     52510:ShowReportPreview(' Pemakaian Per Nobukti',8);
                     52520:ShowReportPreview(' Pemakaian Per Supplier',8);
                     52530:ShowReportPreview(' Pemakaian Per Barang',8);
                     52540:ShowReportPreview(' Pemakaian Per Jenis Barang',8);
                     52610 : ShowReportPreview(' Retur Pemakaian Per Nobukti',8);
                     52620 : ShowReportPreview(' Retur Pemakaian Per Supplier',8);
                     52630 : ShowReportPreview(' Retur Pemakaian Per Barang',8);
                     52640 : ShowReportPreview(' Retur Pemakaian Per Jenis Barang',8);
                     end;

                    radiogroup1.visible :=false;
                    combobox1.visible :=false;
                    label36.visible :=false;
                    end;


                    {52520 :
                    begin
                    ShowReportPreview(' Pemakaian Per Supplier',8);
                    radiogroup1.visible :=false;
                    combobox1.visible :=false;
                    label36.visible :=false;
                    end;
                    52530 :
                    begin
                    ShowReportPreview(' Pemakaian Per Barang',8);
                    radiogroup1.visible :=false;
                    combobox1.visible :=false;
                    label36.visible :=false;
                    end;
                    52540 :
                    begin
                    ShowReportPreview(' Pemakaian Per Jenis Barang',8);
                    radiogroup1.visible :=false;
                    combobox1.visible :=false;
                    label36.visible :=false;
                    end;         }
                    52315 :
                    begin
                    ShowReportPreview(' Ketepatan Penerimaan Barang',8);
                     radiogroup1.visible :=false;
                    combobox1.visible :=false;
                    label36.visible :=false;
                    end;
                    51731 : ShowReportPreview(' Outstanding PPL',8);
                    51732 :
                    begin
                    ShowReportPreview(' Pembayaran Via L/C',8);
                     radiogroup1.visible :=false;
                    combobox1.visible :=false;
                    label36.visible :=false;
                    end;
                    51733 :
                    Begin
                    ShowReportPreview(' Performance Supplier',11);
                    TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                    TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);

                    end;
                  end;
                  TglAwal9.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                  TglAkhir9.Date := incday(incmonth(TglAwal9.Date,1),-1);
                end;

      52915, 53515, 53520, 54115 :
                  begin
                    button2.Visible := false;
                    button4.Visible := true;
                    button5.Visible := true;
                    button3.Visible := true;
                    case KodeReport of
                    52915, 53515,53520  :
                            Begin
                             case kodereport of
                                52915 : ShowReportPreview(' Laporan BPPB',8);
                                53515 : ShowReportPreview(' Laporan BPB',8);
                                53520 : ShowReportPreview(' Laporan Retur BPB',8);
                             end;
                            button3.Caption := 'Per No Bukti';
                            button4.Caption := 'Per Barang';
                            button5.Caption := 'Per Bagian';
                            end;
                    54115 :
                            begin
                                ShowReportPreview(' Laporan BP',8);
                                button3.Caption := 'Per No Bukti';
                                button4.Caption := 'Per Barang';
                                button5.Caption := 'Per Supplier';

                            end;
                    end;
                  TglAwal9.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                  TglAkhir9.Date := incday(incmonth(TglAwal9.Date,1),-1);
                  end;

      81010, 81020  :
                begin
                  case KodeReport of
                    81010 : ShowReportPreview(' Laporan Stock Quantity',9);
                    81020 : ShowReportPreview(' Laporan Stock Quantity + Rupiah',9);

                  end;
                  label33.Visible := false ;
                  satuan10.Visible := false ;
                  button3.Visible := false;
                  button4.Visible := false;
                  button5.Visible := false;
                end;
      864, 866, 867, 868, 869, 870 :
                begin
                  Periode11.Visible:=False;
                  SDTanggal11.Visible:=False;
                  KodeBrg11.Visible:=False;
                  case KodeReport of
                    864   : begin
                              ShowReportPreview(' Stock Barang',10);
                              SDTanggal11.Date:=EndOfAMonth(StrToInt(PeriodThn),StrToInt(PeriodBln));
                              SDTanggal11.Visible:=True;
                              Button2.Visible:=False;
                            end;
                    866   : begin
                              ShowReportPreview(' Stock Opname - Gudang',10);
                              SDTanggal11.Date:=EndOfAMonth(StrToInt(PeriodThn),StrToInt(PeriodBln));
                              SDTanggal11.Visible:=True;
                              KodeBrg11.Visible:=True;
                              LKodeBrg11.Caption:='Group';
                              Button2.Visible:=False;
                            end;
                    867   : begin
                              ShowReportPreview(' Mutasi Persediaan Barang',10);
                              Periode11.Visible:=True;
                              TglAwal11.Date:=EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                              TglAkhir11.Date:=IncDay(IncMonth(TglAwal11.Date,1),-1);
                              KodeBrg11.Visible:=True;
                              LKodeBrg11.Caption:='Group';
                              Button2.Visible:=False;
                            end;
                    868, 869 : begin
                              if KodeReport=868 then
                                ShowReportPreview(' Daftar Penerimaan Barang',10)
                              else if KodeReport=869 then
                                ShowReportPreview(' Daftar Pengeluaran Barang',10);
                              Periode11.Visible:=True;
                              TglAwal11.Date:=EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                              TglAkhir11.Date:=IncDay(IncMonth(TglAwal11.Date,1),-1);
                              KodeBrg11.Visible:=False;
                              //LKodeBrg11.Caption:='Kode Barang';
                              Button2.Visible:=False;
                            end;
                    870   : begin
                              ShowReportPreview(' Kartu Persediaan Barang',10);
                              Periode11.Visible:=True;
                              TglAwal11.Date:=EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                              TglAkhir11.Date:=IncDay(IncMonth(TglAwal11.Date,1),-1);
                              KodeBrg11.Visible:=True;
                              LKodeBrg11.Caption:='Kode Barang';
                              Button2.Visible:=False;
                            end;
                  end;
                  LKodeBrg11.Visible:=KodeBrg11.Visible;
                end;
      end;

    end;
  end;
end;

procedure TFrReportPreview.selectreport;
var i : integer;
    yy,mm,dd :Word;
    vkodebonus : string;
    xKodeVls: String;
begin
  QuView2.DataSource:=nil;
  case KodeReport of
      101 : begin   // Master Perkiraan
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from dbPerkiraan a ');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('where a.Perkiraan in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by a.Perkiraan ');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterPerkiraan.fr3');
                 ShowReport;
              end;
            end;
      273 : begin   // Daftar Harga
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('declare @tgl datetime  ');
                 SQL.Add('set @tgl =:0 ');
                 SQL.Add('select y.KODEBRG,z.NAMABRG ,y.SAT_1 ,y.KODEVLS ,SUM(rata2a)Januari,SUM(rata2b)Februari,SUM(rata2c)Maret,SUM(rata2d)April,SUM(rata2e)Mei,SUM(rata2f)Juni,');
                 SQL.Add('SUM(rata2g)Juli,SUM(rata2h)Agustus,SUM(rata2i)September,SUM(rata2j)Oktober,SUM(rata2k)November,SUM(rata2l)Desember');
                 SQL.Add('From  ');
                 SQL.Add('(select x.kodebrg, x.SAT_1 ,m.KODEVLS ,COUNT (a.HARGA ) jml1,ISNULL( SUM(a.harga)/COUNT (a.harga),0) rata2a,COUNT (b.HARGA ) jml2, ISNULL( SUM(b.harga)/COUNT (b.harga),0) rata2b,COUNT (c.HARGA ) jml3,');
                 SQL.Add('ISNULL( SUM(c.harga)/COUNT (c.harga),0) rata2c,COUNT (' +
                   'd.HARGA ) jml4, ISNULL( SUM(d.harga)/COUNT (d.harga),0) ' +
                   'rata2d,COUNT (e.HARGA ) jml5, ISNULL( SUM(e.harga)/COUNT (e.harga),0) rata2e,COUNT (f.HARGA ) jml6, ISNULL( SUM(f.harga)/COUNT (f.harga),0) rata2f,COUNT (g.HARGA ) jml7, ISNULL( SUM(g.harga)/COUNT (g.harga),0) rata2g,COUNT (h.HARGA ) jml8,  ');
                 SQL.Add('ISNULL( SUM(h.harga)/COUNT (h.harga),0) rata2h,COUNT (i.HARGA ) jml9, ISNULL( SUM(i.harga)/COUNT (i.harga),0) rata2i,COUNT (j.HARGA ) jml10,  ');
                 SQL.Add('ISNULL( SUM(j.harga)/COUNT (j.harga),0) rata2j,COUNT (k.HARGA ) jml11,ISNULL( SUM(k.harga)/COUNT (k.harga),0) rata2k,COUNT (l.HARGA ) jml12, ISNULL( SUM(l.harga)/COUNT (l.harga),0) rata2l  ');
                 SQL.Add('from DBPODET x');
                 SQL.Add('left outer join(select b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI');
                 SQL.Add('where month(a.TANGGAL)=1 and YEAR(a.TANGGAL)=Year(@Tgl) group by b.KODEBRG , b.HARGA, a.TANGGAL )a on a.KODEBRG =x.KODEBRG ');
                 SQL.Add('left outer join (select  b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI ');
                 SQL.Add('where month(a.TANGGAL)=2 and YEAR(a.TANGGAL)=Year(@Tgl)group by b.KODEBRG , b.HARGA, a.TANGGAL )b on b.KODEBRG =x.KODEBRG ');
                 SQL.Add('left outer join (select  b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI ');
                 SQL.Add('where month(a.TANGGAL)=3 and YEAR(a.TANGGAL)=Year(@Tgl) group by b.KODEBRG , b.HARGA, a.TANGGAL )c on c.KODEBRG =x.KODEBRG ');
                 SQL.Add('left outer join (select  b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI ');
                 SQL.Add('where month(a.TANGGAL)=4 and YEAR(a.TANGGAL)=Year(@Tgl)group by b.KODEBRG , b.HARGA, a.TANGGAL )d on d.KODEBRG =x.KODEBRG');
                 SQL.Add('left outer join(select b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI');
                 SQL.Add('where month(a.TANGGAL)=5 and YEAR(a.TANGGAL)=Year(@Tgl)group by b.KODEBRG , b.HARGA, a.TANGGAL )e on e.KODEBRG =x.KODEBRG ');
                 SQL.Add('left outer join(select b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI');
                 SQL.Add('where month(a.TANGGAL)=6 and YEAR(a.TANGGAL)=Year(@Tgl)group by b.KODEBRG , b.HARGA, a.TANGGAL )f on f.KODEBRG =x.KODEBRG ');
                 SQL.Add('left outer join(select b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI');
                 SQL.Add('where month(a.TANGGAL)=7 and YEAR(a.TANGGAL)=Year(@Tgl)group by b.KODEBRG , b.HARGA, a.TANGGAL )g on g.KODEBRG =x.KODEBRG');
                 SQL.Add('left outer join(select b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI');
                 SQL.Add('where month(a.TANGGAL)=8 and YEAR(a.TANGGAL)=Year(@Tgl)group by b.KODEBRG , b.HARGA, a.TANGGAL )h on h.KODEBRG =x.KODEBRG ');
                 SQL.Add('left outer join(select b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI');
                 SQL.Add('where month(a.TANGGAL)=9 and YEAR(a.TANGGAL)=Year(@Tgl) group by b.KODEBRG , b.HARGA, a.TANGGAL )i on i.KODEBRG =x.KODEBRG ');
                 SQL.Add('left outer join(select b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI');
                 SQL.Add('where month(a.TANGGAL)=10 and YEAR(a.TANGGAL)=Year(@Tgl)group by b.KODEBRG , b.HARGA, a.TANGGAL )j on j.KODEBRG =x.KODEBRG ');
                 SQL.Add('left outer join(select b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI');
                 SQL.Add('where month(a.TANGGAL)=11 and YEAR(a.TANGGAL)=Year(@Tgl)group by b.KODEBRG , b.HARGA, a.TANGGAL )k on k.KODEBRG =x.KODEBRG ');
                 SQL.Add('left outer join(select b.KODEBRG, MAX(a.TANGGAL )tgl,b.HARGA ,a.TANGGAL from DBPO a left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI');
                 SQL.Add('where month(a.TANGGAL)=11 and YEAR(a.TANGGAL)=Year(@Tgl)group by b.KODEBRG , b.HARGA, a.TANGGAL )l on k.KODEBRG =x.KODEBRG ');
                 sql.Add ('left outer join DBPO m on m.NOBUKTI =x.NOBUKTI group by x.KODEBRG, x.SAT_1 , KODEVLS');
                 SQL.Add(')y');
                 SQL.Add('left outer join DBBARANG z on z.KODEBRG =y.KODEBRG ');

                 if SelectedSemuaRecord = false then
                     begin
                      SQL.Add('where y.KodeBrg in (');
                      IsiDariListBox1(QuView);
                     end;
                 SQL.Add('group by y.KODEBRG , y.SAT_1 , z.NAMABRG , y.KODEVLS ');
                 SQL.Add('order by y.KODEBRG ');
                 Prepared;
                 Parameters[0].Value:=TglAkhir11.Date;
                 sql.savetofile('c:/1.txt');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportDaftarHarga.fr3');
                 ShowReport;
              end;
            end;

   300101,300102 : begin
              with frxReport1 do
              begin
                frxDBDataset1.DataSet.Close;
                frxDBDataset2.DataSet.Close;
                with QuView do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('exec Sp_LapSaldoAwal :0,:1,:2,:3');
                  Prepared;
                  Parameters[0].Value:=Perkiraan.Text;
                  Parameters[1].Value:=Awal.Date;
                  Parameters[2].Value:=Akhir.Date;
                  Parameters[3].Value:=Divisi.Text;
                  Open;
                end;
                with QuView2 do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('exec Sp_LapKasHarian :0,:1,:2,:3');
                  Prepared;
                  Parameters[0].Value:=Perkiraan.Text;
                  Parameters[1].Value:=Awal.Date;
                  Parameters[2].Value:=Akhir.Date;
                  Parameters[3].Value:=Divisi.Text;
                  Open;
                end;
                frxDBDataset1.DataSet := Quview;
                frxDBDataset1.Close;
                frxDBDataset1.Open;
                frxDBDataset2.DataSet := Quview2;
                frxDBDataset2.Close;
                frxDBDataset2.Open;
                DataBersyarat('select * from dbPerkiraan where Perkiraan=:0',[Perkiraan.Text],DM.QuTemp);
                xKodeVls:=DM.QuTemp.FieldByName('Valas').AsString;
                case KodeReport of
                   300101 : if xKodeVls='IDR' then
                              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKasHarian.fr3')
                            else frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKasHarianUSD.fr3');
                   300102 : if xKodeVls='IDR' then
                              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBankHarian.fr3')
                            else frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBankHarianUSD.fr3');
                end;
                frxReport1.ShowReport;
              end;
            end;
   300110 : begin
              with frxReport1 do
              begin
                frxDBDataset1.DataSet.Close;
                frxDBDataset2.DataSet.Close;
                with QuView do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('exec Sp_LapPosisiBankKasHarian :0,:1');
                  Prepared;
                  Parameters[0].Value:=Devisi7.Text;
                  Parameters[1].Value:=Tanggal7.Date;
                  Open;
                end;
                QuView2.DataSource:=DsView;
                with QuView2 do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('exec Sp_LapPosisiBankKasHarianDet :0,:1, :NoAcc');
                  Prepared;
                  Parameters[0].Value:=Devisi7.Text;
                  Parameters[1].Value:=Tanggal7.Date;
                  Open;
                end;
                frxDBDataset1.DataSet := Quview;
                frxDBDataset1.Close;
                frxDBDataset1.Open;
                frxDBDataset2.DataSet := QuView2;
                frxDBDataset2.Close;
                frxDBDataset2.Open;
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPosisiBankKasHarian.fr3');
                frxReport1.ShowReport;
                //QuView2.DataSource:=nil;
              end;
            end;
   300202 : begin
              DecodeDate(Awal3.date,yy,mm,dd);
              frxDBDataset1.DataSet.Close;
              with DM.QuCari do
              begin
               Close;
               SQL.Clear;
               SQL.Add('exec Sp_GenerateReportBukuTambahan :0,:1,:2,:3,:4,:5,:6,:7');
               Parameters[0].Value:=mm;
               Parameters[1].Value:=yy;
               Parameters[2].Value:=Awal3.Date;
               Parameters[3].Value:=Akhir3.Date;
               Parameters[4].Value:=Perkiraan2.Text;
               Parameters[5].Value:=Perkiraan3.Text;
               Parameters[6].Value:=Jurnal.Text;
               Parameters[7].Value:=Devisi3.Text;
               try
               ExecSQL;
               except
               ShowMessage('Generate Report Gagal !');
               end;
              end;
              with QuView do
              begin
               Close;
               SQL.Clear;
               SQL.Add('exec sp_ViewReportBukuTambahan :0,:1,:2,:3,:4,:5');
               Prepared;
               Parameters[0].Value:=Perkiraan2.Text;
               Parameters[1].Value:=Perkiraan3.Text;
               Parameters[2].Value:=Awal3.Date;
               Parameters[3].Value:=Akhir3.Date;
               Parameters[4].Value:=Devisi3.Text;
               Parameters[5].Value:=IDUser;
               open;
              end;
              frxDBDataset1.DataSet := Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
               if PilihRp.Text='1' then
               LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBukuTambahan1.fr3')
               else
               LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBukuTambahan2.fr3');
              end;
              frxReport1.ShowReport;

            end;
   300501 : begin
                frxDBDataset3.DataSet.Close;
                with QuView3 do
                begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec sp_NerajaLajur :0,:1,:2,:3,:4');
                 Prepared;
                 Parameters[0].Value:='D';
                 Parameters[1].Value:=inttostr(Bulan.AsInteger);
                 Parameters[2].Value:=inttostr(Tahun.AsInteger);
                 Parameters[3].Value:=Devisi2.Text;
                 Parameters[4].Value:=IDUser;
                 Open;
                end;
                frxDBDataset3.DataSet := Quview3;
                frxDBDataset3.Close;
                frxDBDataset3.Open;
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportNeracaLajur.fr3');
                frxReport1.ShowReport;
            end;
     300502,
     300503 : begin
                with DM.QuCari do
                begin
                  close;
                  Sql.Clear;
                  sql.add('select totalA,totalB,totalC');
                  sql.add('from dbLRHPP');
                  sql.add('where persen='+QuotedStr('A')+' and tahun=:0 and Bulan=:1 and devisi=:2 ');
                  Prepared;
                  Parameters[0].Value := Tahun.AsInteger;
                  Parameters[1].Value := Bulan.AsInteger;
                  Parameters[2].Value := Devisi2.text;
                  open;
                end;
                frxDBDataset3.DataSet.Close;
                with QuView3 do
                begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec sp_ReportLabaRugi :0,:1,:2,:3,:4,:5,:6');
                 Prepared;
                 Parameters[0].Value:=inttostr(Bulan.AsInteger);
                 Parameters[1].Value:=inttostr(Tahun.AsInteger);
                 Parameters[2].Value:=Devisi2.Text;
                 if KodeReport=300502 then
                    Parameters[3].Value:=1
                 else
                    Parameters[3].Value:=0;
                 Parameters[4].Value:=DM.QuCari.Fields[0].Value;
                 Parameters[5].Value:=DM.QuCari.Fields[1].Value;
                 Parameters[6].Value:=DM.QuCari.Fields[2].Value;
                 Open;
                end;
                frxDBDataset3.DataSet := Quview3;
                frxDBDataset3.Close;
                frxDBDataset3.Open;
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportLabaRugi.fr3');
                frxReport1.ShowReport;

              end; 
     300504 : begin
                frxDBDataset3.DataSet.Close;
                with QuView3 do
                begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec sp_ReportNeracaAktiva :0,:1,:2');
                 Prepared;
                 Parameters[0].Value:=Devisi2.Text;
                 Parameters[1].Value:=inttostr(Bulan.AsInteger);
                 Parameters[2].Value:=inttostr(Tahun.AsInteger);
                 Open;
                end;
                frxDBDataset3.DataSet := Quview3;
                frxDBDataset3.Close;

                frxDBDataset4.Open;
                frxDBDataset4.DataSet.Close;
                with QuView4 do
                begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec sp_ReportNeracaPasiva :0,:1,:2');
                 Prepared;
                 Parameters[0].Value:=Devisi2.Text;
                 Parameters[1].Value:=inttostr(Bulan.AsInteger);
                 Parameters[2].Value:=inttostr(Tahun.AsInteger);
                 Open;
                end;
                frxDBDataset4.DataSet := Quview4;
                frxDBDataset4.Close;
                frxDBDataset4.Open;
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportNeraca.fr3');
                frxReport1.ShowReport;
            end;
     30020101..30020107, 300201062, 300201064:
            begin     // Laporan Jurnal
               if (Devisi4.Text='') then
               begin
                  if Devisi4.Enabled=true then
                  ActiveControl:=Devisi4
               end else
               begin
                  frxDBDataset1.DataSet.Close;
                  with QuView do
                  begin
                     Close;
                     SQL.Clear;
                     SQL.Add('exec Sp_LapJurnal :0,:1,:2,:3');
                     Prepared;
                     Case KodeReport of
                       30020101 : Parameters[0].Value := 'BKM';
                       30020102 : Parameters[0].Value := 'BKK';
                       30020103 : Parameters[0].Value := 'BBM';
                       30020104 : Parameters[0].Value := 'BBK';
                       30020105 : Parameters[0].Value := 'BMM';
                       30020106 : Parameters[0].Value := 'BJK';
                       300201062: Parameters[0].Value := 'PBL';
                       300201064: Parameters[0].Value := 'PJL';
                       30020107 : Parameters[0].Value := 'BJP';
                     end;
                     Parameters[1].Value := Devisi4.Text;
                     Parameters[2].Value := TglAwal4.Date;
                     Parameters[3].Value := TglAkhir4.Date;
                     open;
                  end;
                  frxDBDataset1.DataSet := Quview;
                  frxDBDataset1.Close;
                  frxDBDataset1.Open;
                  with frxReport1 do
                  begin
                     //case KodeReport of
                     //30020101,30020103 : LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportJurnal1.fr3');
                     //30020102,30020104 : LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportJurnal2.fr3');
                     //else
                             LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportJurnal3.fr3');
                     //end
                  end;
                  frxReport1.ShowReport;
               end;
            end;
     300203 :
            begin     // Laporan Mutasi
               if (Devisi5.Text='') then
               begin
                  if Devisi5.Enabled=true then
                  ActiveControl:=Devisi5
               end else
               begin
                  frxDBDataset1.DataSet.Close;
                  with QuView do
                  begin
                     Close;
                     SQL.Clear;
                     SQL.Add('exec Sp_ReportMutasi :0,:1,:2,:3');
                     Prepared;
                     Parameters[0].Value:=Bulan5.AsInteger;
                     Parameters[1].Value:=Tahun5.AsInteger;
                     Parameters[2].Value:=Devisi5.Text;
                     Parameters[3].Value:=IDUser;
                     Open;
                  end;
                  frxDBDataset1.DataSet := Quview;
                  frxDBDataset1.Close;
                  frxDBDataset1.Open;
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportMutasi.fr3');
                  frxReport1.ShowReport;
               end;
            end;
     300204 :
            begin     // Laporan Biaya
               if (Devisi6.Text='') or (Perkiraan6A.Text='') or (Perkiraan6B.Text='')then
               begin
                  if Devisi6.Enabled=true then
                  ActiveControl:=Devisi6
               end else
               begin
                  frxDBDataset1.DataSet.Close;
                  with QuView do
                  begin
                     Close;
                     SQL.Clear;
                     SQL.Add('exec Sp_LapBiaya :0,:1,:2,:3,:4');
                     Prepared;
                     Parameters[0].Value := Devisi6.Text;
                     Parameters[1].Value := Bulan6.AsInteger;
                     Parameters[2].Value := Tahun6.AsInteger;
                     Parameters[3].Value := Perkiraan6A.Text;
                     Parameters[4].Value := Perkiraan6B.Text;
                     Open;
                  end;
                  frxDBDataset1.DataSet := Quview;
                  frxDBDataset1.Close;
                  frxDBDataset1.Open;
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBiaya.fr3');
                  frxReport1.ShowReport;
               end;
            end;
     300207 :
            begin     // Laporan Aktiva Tetap
               if (Devisi5.Text='') then
               begin
                  if Devisi5.Enabled=true then
                  ActiveControl:=Devisi5
               end else
               begin
                  frxDBDataset1.DataSet.Close;
                  with QuView do
                  begin
                     Close;
                     SQL.Clear;
                     SQL.Add('exec sp_LapAktiva :0,:1,:2');
                     Prepared;
                     Parameters[0].Value := Bulan5.AsInteger;
                     Parameters[1].Value := Tahun5.AsInteger;
                     Parameters[2].Value := Devisi5.Text;
                     Open;
                  end;
                  frxDBDataset1.DataSet := Quview;
                  frxDBDataset1.Close;
                  frxDBDataset1.Open;
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportAktivaTetap.fr3');
                  frxReport1.ShowReport;
               end;
            end;
     300208 :
            begin     // Laporan Biaya Penyusutan
               if (Devisi5.Text='') then
               begin
                  if Devisi5.Enabled=true then
                  ActiveControl:=Devisi5
               end else
               begin
                  frxDBDataset1.DataSet.Close;
                  with QuView do
                  begin
                     Close;
                     SQL.Clear;
                     SQL.Add('exec sp_LapSusutAktiva :0,:1,:2');
                     Prepared;
                     Parameters[0].Value := Bulan5.AsInteger;
                     Parameters[1].Value := Tahun5.AsInteger;
                     Parameters[2].Value := Devisi5.Text;
                     Open;
                  end;
                  frxDBDataset1.DataSet := Quview;
                  frxDBDataset1.Close;
                  frxDBDataset1.Open;
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSusutAktiva.fr3');
                  frxReport1.ShowReport;
               end;
            end;
     300301 :
            begin     // kartu Hutang
              frxDBDataset3.DataSet.Close;
              with QuView3 do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec Sp_ReportKartuHutang :0,:1,:2,:3,:4,:5,:6,:7,:8');
                 Prepared;
                 Parameters[0].Value:=TglAwal8.Date;
                 Parameters[1].Value:=TglAkhir8.Date;
                 Parameters[2].Value:=Awal8.Text;
                 Parameters[3].Value:=Akhir8.Text;
                 Parameters[4].Value:=Devisi8.Text;
                 Parameters[5].Value:=Urut8.ItemIndex;
                 Parameters[6].Value:=Perkiraan8.Text;
                 //if Rekap1.Checked then
                 //Parameters[7].Value:=1
                 //else
                 Parameters[7].Value:=0;
                 if Valas8.ItemIndex=0 then
                   Parameters[8].Value:='IDR'
                 else
                   Parameters[8].Value:=KodeVls8.Text;
                 Open;
              end;
              frxDBDataset3.DataSet := Quview3;
              frxDBDataset3.Close;
              frxDBDataset3.Open;
              if Valas8.ItemIndex=0 then
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKartuHutang1.fr3')
              else
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKartuHutang2.fr3');
              frxReport1.ShowReport;
            end;
     300302 :
            begin     // Sisa Hutang
              frxDBDataset4.DataSet.Close;
              with QuView4 do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec Sp_ReportSisaHutang :0,:1,:2,:3,:4,:5,:6');
                 Prepared;
                 Parameters[0].Value:=TglAkhir8.Date;
                 Parameters[1].Value:=Awal8.Text;
                 Parameters[2].Value:=Akhir8.Text;
                 Parameters[3].Value:=Devisi8.Text;
                 Parameters[4].Value:=Urut8.ItemIndex;
                 Parameters[5].Value:=Perkiraan8.Text;
                 if Valas8.ItemIndex=0 then
                   Parameters[6].Value:='IDR'
                 else
                   Parameters[6].Value:=KodeVls8.Text;
                 Open;
              end;
              frxDBDataset4.DataSet := Quview4;
              frxDBDataset4.Close;
              frxDBDataset4.Open;
                if Valas8.ItemIndex=0 then
                begin
                  //if Rekap1.Checked then
                  //frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSisaHutang2.fr3')
                  //else
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSisaHutang1.fr3');
                end else
                begin
                  //if Rekap1.Checked then
                  //frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSisaHutang2Valas.fr3')
                  //else
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSisaHutang1Valas.fr3');
                end;
              frxReport1.ShowReport;
            end;
     300303 :
            begin     // Pelunasan Hutang
              frxDBDataset3.DataSet.Close;
              with QuView3 do
              begin
               Close;
               SQL.Clear;
               SQL.Add('exec Sp_ReportPelunasanHutang :0,:1,:2,:3,:4,:5,:6,:7');
               Prepared;
               Parameters[0].Value:=TglAwal8.Date;
               Parameters[1].Value:=TglAkhir8.Date;
               Parameters[2].Value:=Awal8.Text;
               Parameters[3].Value:=Akhir8.Text;
               Parameters[4].Value:=Devisi8.Text;
               Parameters[5].Value:=Urut8.ItemIndex;
               Parameters[6].Value:=Perkiraan8.Text;
               if Valas8.ItemIndex=0 then
                 Parameters[7].Value:='IDR'
               else
                 Parameters[7].Value:=KodeVls8.Text;
               Open;
              end;
              frxDBDataset3.DataSet := Quview3;
              frxDBDataset3.Close;
              frxDBDataset3.Open;
              if Valas8.ItemIndex=0 then
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPelunasanHutang1.fr3')
              else
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPelunasanHutang2.fr3');
              frxReport1.ShowReport;
            end;
     300304 :
            begin     // Saldo Hutang
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
               SQL.Add('exec Sp_ReportSaldoHutang :0,:1,:2,:3,:4,:5,:6,:7');
               Prepared;
               Parameters[0].Value:=Perkiraan8.Text;
               Parameters[1].Value:=TglAwal8.Date;
               Parameters[2].Value:=TglAkhir8.Date;
               Parameters[3].Value:=Awal8.Text;
               Parameters[4].Value:=Akhir8.Text;
               Parameters[5].Value:=Devisi8.Text;
               Parameters[6].Value:=0;
               if Valas8.ItemIndex=0 then
                 Parameters[7].Value:='IDR'
               else
                 Parameters[7].Value:=KodeVls8.Text;
               Open;
              end;
              frxDBDataset1.DataSet := Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              if Valas8.ItemIndex=0 then
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSaldoHutang1.fr3')
              else
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSaldoHutang2.fr3');
              frxReport1.ShowReport;
            end;
     300305 :
            begin     // Umur Hutang
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
               SQL.Add('exec sp_ReportUmurHutang :0,:1,:2,:3,:4,:5,:6');
               Prepared;
               Parameters[0].Value:=TglAkhir8.Date;
               Parameters[1].Value:=Urut8.ItemIndex;
               Parameters[2].Value:=Awal8.Text;
               Parameters[3].Value:=Akhir8.Text;
               Parameters[4].Value:=Devisi8.Text;
               Parameters[5].Value:=Perkiraan8.Text;
               if Valas8.ItemIndex=0 then
                 Parameters[6].Value:='IDR'
               else
                 Parameters[6].Value:=KodeVls8.Text;
               Open;
              end;
              frxDBDataset1.DataSet := Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              if Valas8.ItemIndex=0 then
              begin
                //if Rekap1.Checked then
                //frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportUmurHutang2.fr3')
                //else
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportUmurHutang1.fr3');
              end else
              begin
                //if Rekap1.Checked then
                //frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportUmurHutang2Valas.fr3')
                //else
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportUmurHutang1Valas.fr3');
              end;
              frxReport1.ShowReport;
            end;
     300401 :
            begin     // kartu Piutang
              frxDBDataset3.DataSet.Close;
              with QuView3 do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec Sp_ReportKartuPiutang :0,:1,:2,:3,:4,:5,:6,:7,:8');
                 Prepared;
                 Parameters[0].Value:=TglAwal8.Date;
                 Parameters[1].Value:=TglAkhir8.Date;
                 Parameters[2].Value:=Awal8.Text;
                 Parameters[3].Value:=Akhir8.Text;
                 Parameters[4].Value:=Devisi8.Text;
                 Parameters[5].Value:=Urut8.ItemIndex;
                 Parameters[6].Value:=Perkiraan8.Text;
                 //if Rekap1.Checked then
                 //Parameters[7].Value:=1
                 //else
                 Parameters[7].Value:=0;
                 if Valas8.ItemIndex=0 then
                   Parameters[8].Value:='IDR'
                 else
                   Parameters[8].Value:=KodeVls8.Text;
                 Open;
              end;
              frxDBDataset3.DataSet := Quview3;
              frxDBDataset3.Close;
              frxDBDataset3.Open;
              if Valas8.ItemIndex=0 then
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKartuPiutang1.fr3')
              else
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKartuPiutang2.fr3');
              frxReport1.ShowReport;
            end;
     300402 :
            begin     // Sisa Piutang
              frxDBDataset4.DataSet.Close;
              with QuView4 do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec Sp_ReportSisaPiutang :0,:1,:2,:3,:4,:5,:6');
                 Prepared;
                 Parameters[0].Value:=TglAkhir8.Date;
                 Parameters[1].Value:=Awal8.Text;
                 Parameters[2].Value:=Akhir8.Text;
                 Parameters[3].Value:=Devisi8.Text;
                 Parameters[4].Value:=Urut8.ItemIndex;
                 Parameters[5].Value:=Perkiraan8.Text;
                 if Valas8.ItemIndex=0 then
                   Parameters[6].Value:='IDR'
                 else
                   Parameters[6].Value:=KodeVls8.Text;
                 Open;
              end;
              frxDBDataset4.DataSet := Quview4;
              frxDBDataset4.Close;
              frxDBDataset4.Open;
              if Valas8.ItemIndex=0 then
              begin
                //if Rekap1.Checked then
                //  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSisaPiutang1.fr3')
                //else
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSisaPiutang2.fr3');
              end else
              begin
                //if Rekap1.Checked then
                //  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSisaPiutang1Valas.fr3')
                //else
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSisaPiutang2Valas.fr3');
              end;
              frxReport1.ShowReport;
            end;
     300403 :
            begin     // Pelunasan Piutang
              frxDBDataset3.DataSet.Close;
              with QuView3 do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec Sp_ReportPelunasanPiutang :0,:1,:2,:3,:4,:5,:6,:7');
                 Prepared;
                 Parameters[0].Value:=TglAwal8.Date;
                 Parameters[1].Value:=TglAkhir8.Date;
                 Parameters[2].Value:=Awal8.Text;
                 Parameters[3].Value:=Akhir8.Text;
                 Parameters[4].Value:=Devisi8.Text;
                 Parameters[5].Value:=Urut8.ItemIndex;
                 Parameters[6].Value:=Perkiraan8.Text;
                 if Valas8.ItemIndex=0 then
                   Parameters[7].Value:='IDR'
                 else
                   Parameters[7].Value:=KodeVls8.Text;
                 Open;
              end;
              frxDBDataset3.DataSet := Quview3;
              frxDBDataset3.Close;
              frxDBDataset3.Open;
              if Valas8.ItemIndex=0 then
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPelunasanPiutang1.fr3')
              else
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPelunasanPiutang2.fr3');
              frxReport1.ShowReport;
            end;
     300404 :
            begin     // Saldo Piutang
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec Sp_ReportSaldoHutang :0,:1,:2,:3,:4,:5,:6,:7');
                 Prepared;
                 Parameters[0].Value:=Perkiraan8.Text;
                 Parameters[1].Value:=TglAwal8.Date;
                 Parameters[2].Value:=TglAkhir8.Date;
                 Parameters[3].Value:=Awal8.Text;
                 Parameters[4].Value:=Akhir8.Text;
                 Parameters[5].Value:=Devisi8.Text;
                 Parameters[6].Value:=1;
                 if Valas8.ItemIndex=0 then
                   Parameters[7].Value:='IDR'
                 else
                   Parameters[7].Value:=KodeVls8.Text;
                 Open;
              end;
              frxDBDataset1.DataSet := Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              if Valas8.ItemIndex=0 then
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSaldoPiutang1.fr3')
              else
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSaldoPiutang2.fr3');
              frxReport1.ShowReport;
            end;
     300405 :
             begin     // Umur Piutang
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec sp_ReportUmurPiutang :0,:1,:2,:3,:4,:5,:6');
                 Prepared;
                 Parameters[0].Value:=TglAkhir8.Date;
                 Parameters[1].Value:=Urut8.ItemIndex;
                 Parameters[2].Value:=Awal8.Text;
                 Parameters[3].Value:=Akhir8.Text;
                 Parameters[4].Value:=Devisi8.Text;
                 Parameters[5].Value:=Perkiraan8.Text;
                 if Valas8.ItemIndex=0 then
                   Parameters[6].Value:='IDR'
                 else
                   Parameters[6].Value:=KodeVls8.Text;
                 Open;
              end;
              frxDBDataset1.DataSet := Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              if Valas8.ItemIndex=0 then
              begin
                //if Rekap1.Checked then
                //  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportUmurPiutang2.fr3')
                //else
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportUmurPiutang1.fr3');
              end else
              begin
                //if Rekap1.Checked then
                //  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportUmurPiutang2Valas.fr3')
                //else
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportUmurPiutang1Valas.fr3');
              end;
              frxReport1.ShowReport;
            end;
     51705, 51707, 51709 :
            begin     // Order Pembelian
              frxDBDataset1.DataSet.Close;
              frxDBDataset2.DataSet.Close;
              frxDBDataset6.DataSet.Close;

              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select A.*, B.Tanggal TglKirim');
                 SQL.Add('from vwRepPO A');
                 SQL.Add('left outer join (Select MAX(x.tanggal) Tanggal, y.NOPO, y.URUTPO');
                 SQL.Add('                 from DBBELI x ');
                 SQL.Add('                 left outer join DBBELIDET y on y.NOBUKTI=x.NOBUKTI');
                 SQL.Add('                 group by y.NOPO, y.URUTPO) B on B.NOPO=A.NOBUKTI and B.URUTPO=A.URUT');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                 Sql.Add(' and (A.Tipe  Like (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
                 sql.Add('                         when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
                 Sql.add('                    end) or (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
                 Sql.add('                                  when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
                 sql.add('                                  else 2');
                 sql.add('                              end)=2)');
                 Case RadioGroup1.ItemIndex of
                   0 : Sql.Add(' and A.NOPPL  Like (''%PPL%'')');
                   1 : Sql.Add(' and A.NOPPL  Like (''%SPRK%'') and A.IsJasa=0');
                   2 : Sql.Add(' and A.NOPPL  Like (''%SPRK%'') and A.IsJasa=1');
                 end;
                 case KodeReport of
                 51705 :
                   begin
                      if SelectedSemuaRecord=false then
                      begin
                        SQL.Add('and a.nobukti in (');
                        IsiDariListBox1(QuView);
                      end;
                      SQL.Add('order by A.NoBukti, A.Urut') ;
                   end;
                 51707 :
                   begin
                          if SelectedSemuaRecord=false then
                          begin
                                  SQL.Add('and a.kodecustsupp in (');
                                  IsiDariListBox1(QuView);
                          end;
                          SQL.Add('order by A.KodeCustSupp, A.NoBukti, A.Urut ');
                   end;
                 51709 :
                   begin
                     if SelectedSemuaRecord=false then
                     begin
                        SQL.Add('and a.kodebrg in (');
                        IsiDariListBox1(QuView);
                     end;
                     SQL.Add('order by A.KodeBrg, A.NoBukti, A.Urut ');
                   end;
                 end;
                 Sql.SaveToFile('C:\Testing.SQl');
  {               case KodeReport of
                   51705 : SQL.Add('order by A.NoBukti, A.Urut');
                   51707 : SQL.Add('order by A.KodeCustSupp, A.NoBukti, A.Urut ');
                   51709 : SQL.Add('order by A.KodeBrg, A.NoBukti, A.Urut ');
                 end; }
                 Open;
              end;
             { with QuView2 do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select a.nobukti,sum(a.subtotal) subtotal, b.KODEVLS vls, sum(a.NilaiPPN) ppn,sum(a.JumlahNetto) nett');
                 SQL.Add('from vwRepPO A');
                 SQL.Add('left outer join dbvalas b on b.kodevls=a.kodevls');

                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));

              //   sql.Add('and a.nopo like ')

                 case KodeReport of
                 51705 :
                 begin
                        if SelectedSemuaRecord=false then
                        begin
                                SQL.Add('and a.nobukti in (');
                                IsiDariListBox1(QuView2);
                                //sql.Add('and ')
                        end;
                        SQL.Add('GROUP BY a.nobukti,B.KODEVLS') ;
                        //SQL.Add('order by A.NoBukti, A.Urut') ;
                 end;
                 51707 :
                 begin
                        if SelectedSemuaRecord=false then
                        begin
                                SQL.Add('and a.kodecustsupp in (');
                                IsiDariListBox1(QuView2);
                        end;
                        //SQL.Add('order by A.KodeCustSupp, A.NoBukti, A.Urut ');
                        SQL.Add('GROUP BY B.KODEVLS') ;
                 end;
                 51709 :
                 begin
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('and a.kodebrg in (');
                    IsiDariListBox1(QuView2);
                 end;
                 //SQL.Add('order by A.KodeBrg, A.NoBukti, A.Urut ');
                 SQL.Add('GROUP BY b.KODEVLS') ;
                 end;
                 end;

                 SQL.SaveToFile('D:\x1.Txt');
                 Open;
              end; }

              frxDBDataset1.DataSet:=Quview;
              //frxDBDataset2.DataSet:=Quview2;
              frxDBDataset1.Close;
              //frxDBDataset2.Close;
              frxDBDataset1.Open;
              //frxDBDataset2.Open;

              case KodeReport of
                   51705 : frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPoPerNoBukti.fr3');
                   51707 : frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPoPerSupplier.fr3');
                   51709 : frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPoPerBarang.fr3');
              end;
              frxReport1.ShowReport;
            end;
     51715 :
            begin     // Ketepatan Waktu Pembuatan OP
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select	A.NOBUKTI, A.TANGGAL, B.Urut, B.KODEBRG, H.NAMABRG,  case when B.Nosat=1 then B.QNT else B.QNT2 end Qnt, ');
                 SQL.Add('case when B.Nosat=1 then B.SAT_1 else B.SAT_2 end Satuan, ');
                 SQL.Add('ISNULL(D.Tanggal,F.Tanggal) TglTerimaPPL, A.KODECUSTSUPP, G.NAMACUSTSUPP, ');
                 SQL.Add('DATEDIFF(day,ISNULL(D.Tanggal,F.Tanggal),A.TANGGAL) Keterlambatan ');
                 SQL.Add('from DBPO A ');
                 SQL.Add('left outer join DBPODET B on B.NOBUKTI=A.NOBUKTI ');
                 SQL.Add('left outer join DBPPLDET C on C.Nobukti=B.NoPPL and C.urut=B.UrutPPL ');
                 SQL.Add('left outer join DBPPL D on D.Nobukti=B.NoPPL and D.Nobukti=C.Nobukti ');
                 SQL.Add('left outer join dbSPRKDet E on E.NoBukti=B.NoPPL and E.Urut=B.UrutPPL ');
                 SQL.Add('left outer join dbSPRK F on F.NoBukti=B.NoPPL and F.NoBukti=E.NoBukti ');
                 SQL.Add('left outer join DBCUSTSUPP G on G.KODECUSTSUPP=A.KODECUSTSUPP ');
                 SQL.Add('left outer join DBBARANG H on H.KODEBRG=B.KODEBRG ');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                 if selectedsemuarecord =false then
                     begin
                     sql.add('and a.nobukti in (');
                      IsiDariListBox1(QuView);
                     end;

                 SQL.Add('order by B.NoBukti, B.Urut');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKetepatanBuatPo.fr3');
              frxReport1.ShowReport;
            end;
     51720 :
            begin     // Outstanding OP
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select A.*, B.Tanggal TglKirim');
                 SQL.Add('from vwRepPO A');
                 SQL.Add('left outer join (Select MAX(x.tanggal) Tanggal, y.NOPO, y.URUTPO');
                 SQL.Add('                 from DBBELI x ');
                 SQL.Add('                 left outer join DBBELIDET y on y.NOBUKTI=x.NOBUKTI');
                 SQL.Add('                 group by y.NOPO, y.URUTPO) B on B.NOPO=A.NOBUKTI and B.URUTPO=A.URUT');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                 Sql.Add(' and (A.Tipe  Like (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
                 sql.Add('                         when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
                 Sql.add('                    end) or (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
                 Sql.add('                                  when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
                 sql.add('                                  else 2');
                 sql.add('                              end)=2)');
                 Case RadioGroup1.ItemIndex of
                   0 : Sql.Add(' and A.NOPPL  Like (''%PPL%'')');
                   1 : Sql.Add(' and A.NOPPL  Like (''%SPRK%'') and A.IsJasa=0');
                   2 : Sql.Add(' and A.NOPPL  Like (''%SPRK%'') and A.IsJasa=1');
                 end;
                 //SQl.add(' and (A.QntSisa>0 or A.Qnt2Sisa>0)');
                 if selectedsemuarecord = false then
                    begin
                       sql.add('and a.nobukti in (');
                       IsiDariListBox1(QuView);
                    end;
                 SQL.Add('order by A.NoBukti, A.Urut');
                 //SQL.SaveToFile('C:\test.sql');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutPo.fr3');
              frxReport1.ShowReport;
            end;
     51725 :
            begin     // Outstanding Pembayaran OP
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select A.*, B.Tanggal TglKirim, b.nobukti NobuktiTerima');
                 SQL.Add('from vwRepPO A');
                 SQL.Add('left outer join (Select distinct x .nobukti,x.Tanggal, y.NOPO, y.URUTPO');
                 SQL.Add('                 from DBBELI x ');
                 SQL.Add('                 left outer join DBBELIDET y on y.NOBUKTI=x.NOBUKTI');
                 SQL.Add('                 ) B on B.NOPO=A.NOBUKTI and B.URUTPO=A.URUT');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                 Sql.Add(' and (A.Tipe  Like (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
                 sql.Add('                         when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
                 Sql.add('                    end) or (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
                 Sql.add('                                  when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
                 sql.add('                                  else 2');
                 sql.add('                              end)=2)');
                 Case RadioGroup1.ItemIndex of
                   0 : Sql.Add(' and A.NOPPL  Like (''%PPL%'')');
                   1 : Sql.Add(' and A.NOPPL  Like (''%SPRK%'') and A.IsJasa=0');
                   2 : Sql.Add(' and A.NOPPL  Like (''%SPRK%'') and A.IsJasa=1');
                 end;
                 //SQl.add(' and (A.QntSisa>0 or A.Qnt2Sisa>0)');
                 if selectedsemuarecord = false then
                    begin
                    sql.add('and a.nobukti in (');
                    IsiDariListBox1(QuView);
                    end;
                 SQL.Add('order by A.NoBukti, A.Urut');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutBayarPo.fr3');
              frxReport1.ShowReport;
            end;
     51730 :
            begin     // Realisasi Pembayaran OP
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select T.*, DATEDIFF(day,T.TglJatuhTempo,T.TglLunas) Keterlambatan ');
                 SQL.Add('from ( ');
                 SQL.Add('select A.*, B.NoBukti NoBuktiTerima, B.Tanggal TglTerima, ');
                 SQL.Add('(select max(Tanggal) from vwHutPiut X where X.NoBukti<>'''' and X.NoFaktur=B.NoBukti) TglLunas ');
                 SQL.Add('from vwRepPO A');
                 SQL.Add('left outer join ');
                 SQL.Add('  (select A.NOPO, A.URUTPO, B.NoBukti, B.TANGGAL ');
                 SQL.Add('  from DBBELIDET A, DBBELI B, DBPO C, DBPODET D ');
                 SQL.Add('  where A.NOBUKTI=B.NOBUKTI and A.NOPO=C.NoBukti and A.NOPO=D.NoBukti and A.UrutPO=D.Urut and C.NoBukti=D.NoBukti');
                 SQL.Add('  and C.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                 SQL.Add('  group by A.NOPO, A.URUTPO, B.NoBukti, B.TANGGAL ) B on B.NOPO=A.NoBukti and B.UrutPO=A.Urut');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                // SQL.Add(') T ');
                 //SQL.Add('order by A.NoBukti, A.Urut');
                 if selectedsemuarecord = false then
                    begin
                    sql.add('and a.nobukti in (');
                    IsiDariListBox1(QuView);
                    end;
                 SQL.Add(') T ');
                 SQL.Add('order by NoBukti, Urut');
                 //sql.savetofile('c:/1.txt');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRealisasiBayarPo.fr3');
              frxReport1.ShowReport;
            end;
     52315 :
            begin     // Ketepatan Waktu Penerimaan Barang
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select B.NOPO, D.TANGGAL TglPO, B.KODEBRG, H.NAMABRG, case when B.Nosat=1 then B.QNT else B.QNT2 end Qnt, ');
                 SQL.Add('case when B.Nosat=1 then B.SAT_1 else B.SAT_2 end Satuan, ');
                 SQL.Add('A.TGLSPB, A.TANGGAL TglBPB, A.KODECUSTSUPP, G.NAMACUSTSUPP, ');
                 SQL.Add('DATEDIFF(day,D.TANGGAL,A.TANGGAL) Keterlambatan ');
                 SQL.Add('from DBBELI A ');
                 SQL.Add('left outer join DBBELIDET B on B.NOBUKTI=A.NOBUKTI ');
                 SQL.Add('left outer join DBPODET C on C.NOBUKTI=B.NOPO and C.URUT=B.URUTPO ');
                 SQL.Add('left outer join DBPO D on D.NOBUKTI=C.NOBUKTI and D.NOBUKTI=B.NOPO ');
                 SQL.Add('left outer join DBCUSTSUPP G on G.KODECUSTSUPP=A.KODECUSTSUPP ');
                 SQL.Add('left outer join DBBARANG H on H.KODEBRG=B.KODEBRG ');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                 SQL.Add('order by B.NOPO, B.UrutPO');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKetepatanTerimaBrg.fr3');
              frxReport1.ShowReport;
            end;

     52320,52325,52330,52335:
     BEGIN
     frxDBDataset1.DataSet.Close;
     with QuView do
     begin
        Close;
        sql.clear;
        sql.add('select * from vwpenerimaanbrg');
        SQL.Add('where Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
        Sql.Add(' and (Tipe  Like (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
        sql.Add(' when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
        Sql.add(' end) or (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
        Sql.add(' when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
        sql.add(' else 2');
        sql.add(' end)=2)');
        Case RadioGroup1.ItemIndex of
        0 : Sql.Add(' and NOPPL  Like (''%PPL%'')');
        1 : Sql.Add(' and NOPPL  Like (''%SPRK%'') and IsJasa=0');
        2 : Sql.Add(' and NOPPL  Like (''%SPRK%'') and IsJasa=1');
        end;
        case kodereport of
        52320 :
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and nobukti in (');
         IsiDariListBox1(QuView);
         end;
        end;

        52325 :
        begin
        if selectedsemuarecord = false then
        begin
         sql.add('and kodecustsupp in (');
         IsiDariListBox1(QuView);
         end;

        end;

        52330:
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and kodebrg in (');
         IsiDariListBox1(QuView);
         end;

        end;

        52335:
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and kodejnsbrg in (');
         IsiDariListBox1(QuView);
         end;

        end;
       end;
       //sql.savetofile('c:/a.txt');
       case kodereport of
       52325: SQL.Add('order by namacustsupp');
        52320:SQL.Add('order by NoBukti');
        52330:SQL.Add('order by namabrg');
        52335:  SQL.Add('order by kodejnsbrg');
       end;
        Open;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              case kodereport of
              52320 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportpenerimaanpernobukti.fr3');
              52325 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportpenerimaanpersupplier.fr3');
              52330 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportpenerimaanperbarang.fr3');
              52335 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportpenerimaanperjenisbrg.fr3');
              end;
              frxReport1.ShowReport;
      end;
     END;

     52410,52420,52430,52440:
     BEGIN
     frxDBDataset1.DataSet.Close;
     with QuView do
     begin
        Close;
        sql.clear;
        sql.add('select * from vwrpenerimaanbrg');
        SQL.Add('where Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
        Sql.Add(' and (Tipe  Like (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
        sql.Add(' when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
        Sql.add(' end) or (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
        Sql.add(' when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
        sql.add(' else 2');
        sql.add(' end)=2)');
        Case RadioGroup1.ItemIndex of
        0 : Sql.Add(' and NOPPL  Like (''%PPL%'')');
        1 : Sql.Add(' and NOPPL  Like (''%SPRK%'') and IsJasa=0');
        2 : Sql.Add(' and NOPPL  Like (''%SPRK%'') and IsJasa=1');
        end;
        case kodereport of
        52410 :
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and nobukti in (');
         IsiDariListBox1(QuView);
         end;

        end;

        52420 :
        begin
        if selectedsemuarecord = false then
        begin
         sql.add('and kodecustsupp in (');
         IsiDariListBox1(QuView);
         end;

        end;

        52430:
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and kodebrg in (');
         IsiDariListBox1(QuView);
         end;

        end;

        52440:
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and kodejnsbrg in (');
         IsiDariListBox1(QuView);
         end;

        end;
       end;
              case kodereport of
               52410:SQL.Add('order by NoBukti');
               52420:SQL.Add('order by Namacustsupp');
               52430:SQL.Add('order by Namabrg');
               52440:SQL.Add('order by kodejnsbrg');
              end;
        Open;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              case kodereport of
              52410 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportreturpernobukti.fr3');
              52420 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportreturpersupplier.fr3');
              52430 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportreturperbarang.fr3');
              52440 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportreturperjenisbrg.fr3');
              end;
              frxReport1.ShowReport;
      end;
     END;


     52510,52520,52530,52540:
     BEGIN
     frxDBDataset1.DataSet.Close;
     with QuView do
     begin
        Close;
        sql.clear;
        sql.add('select * from vwpemakaianbrg');
        SQL.Add('where Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));

        case kodereport of
        52510 :
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and nobukti in (');
         IsiDariListBox1(QuView);
         end;

        end;

        52520 :
        begin
        if selectedsemuarecord = false then
        begin
         sql.add('and kodecustsupp in (');
         IsiDariListBox1(QuView);
         end;

        end;

        52530:
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and kodebrg in (');
         IsiDariListBox1(QuView);
         end;

        end;

        52540:
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and kodejnsbrg in (');
         IsiDariListBox1(QuView);
         end;

        end;
       end;
       case kodereport of
        52510:SQL.Add('order by NoBukti');
        52520:sql.Add('order by namacustsupp');
        52530:sql.Add('order by kodebrg');
        52540:sql.Add('order by Kodejnsbrg');
         end;
         sql.savetofile('c:/m.txt');
        Open;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              case kodereport of
              52510 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportpemakaianpernobukti.fr3');
              52520 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportpemakaianpersupplier.fr3');
              52530 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportpemakaianperbarang.fr3');
              52540 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportpemakaianperjenisbrg.fr3');
              end;
              frxReport1.ShowReport;
      end;
     END;



     52610,52620,52630,52640:
     BEGIN
     frxDBDataset1.DataSet.Close;
     with QuView do
     begin
        Close;
        sql.clear;
        sql.add('select * from vwrpemakaianbrg');
        SQL.Add('where Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));

        case kodereport of
        52610 :
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and nobukti in (');
         IsiDariListBox1(QuView);
         end;

        end;

        52620 :
        begin
        if selectedsemuarecord = false then
        begin
         sql.add('and kodecustsupp in (');
         IsiDariListBox1(QuView);
         end;

        end;

        52630:
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and kodebrg in (');
         IsiDariListBox1(QuView);
         end;

        end;

        52640:
        begin
        if selectedsemuarecord = false then
         begin
         sql.add('and kodejnsbrg in (');
         IsiDariListBox1(QuView);
         end;

        end;
       end;
       case kodereport of
        52610:SQL.Add('order by NoBukti');
        52620:sql.Add('order by namacustsupp');
        52630:sql.Add('order by kodebrg');
        52640:sql.Add('order by Kodejnsbrg');
         end;


        Open;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              case kodereport of
              52610 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportreturpemakaianpernobukti.fr3');
              52620 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportreturpemakaianpersupplier.fr3');
              52630 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportreturpemakaianperbarang.fr3');
              52640 :frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\Reportreturpemakaianperjenisbrg.fr3');
              end;
              frxReport1.ShowReport;
      end;
     END;




     051731 :
            begin     // Outstanding PPL
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQl.Add('Select case when x.Nosat=1 then x.QNTsisa else x.QNT2Sisa end Qnt,');
                 SQl.Add('case when x.Nosat=1 then x.SAT_1 else x.SAT_2 end Satuan,');
                 SQl.Add('X.*,C.NamaBrg,');
                 SQl.Add('DATEDIFF(DD,x.Tanggal,GETDATE()) KeterLambatan');
                 SQl.Add('From (Select A.NoBukti+right(''00000''+cast(A.Urut as varchar(5)),5) KeyNoBukti,');
                 SQl.Add('             A.Nobukti, A.urut, A.kodebrg, A.Sat_1, A.Sat_2, A.Isi, A.Qnt, A.Qnt2, A.TglTiba TglTiba,');
                 SQl.Add('             A.NoPermintaan, A.UrutPermintaan, A.QntBatal, A.Qnt2Batal, A.QntPO, A.Qnt2PO, A.QntSisaPO, A.Qnt2SisaPO, ');
                 SQl.Add('             A.QntSisa, A.Qnt2Sisa, A.NamaBag,');
                 SQl.Add('             A.Keterangan, A.IsInspeksi, A.NoSat, B.Tanggal,');
                 SQl.Add('             JP.Keterangan NamaJnsPakai,A.Pelaksana');
                 SQl.Add('      from vwBrowsOutPPL A ');
                       SQl.Add('left outer join dbPPL B on B.NoBukti=A.NoBukti ');
                       SQl.Add('left outer join dbBarang C on C.KodeBrg=A.KodeBrg');
                       SQl.Add('left outer join dbPermintaanBrg P on P.NoBukti=A.NoPermintaan ');
                       SQl.Add('left outer join dbJnsPakai JP on JP.KodeJnsPakai=P.KodeJnsPakai');
                 SQl.Add('Union ');
                 SQl.Add('SELECT A.Nobukti+RIGHT(''00000''+CAST(A.urut AS varchar(5)),5) KeyNoBukti, ');
                 Sql.add('       A.Nobukti, A.urut, A.kodebrg, A.Sat_1, A.Sat_2, A.Isi, A.Qnt, A.Qnt2, null TglTiba,');
                 SQl.Add('       A.NoPermintaan, A.UrutPermintaan, A.QntBatal, A.Qnt2Batal, A.QntPO, A.Qnt2PO, A.QntSisaPO,');
                 SQl.add('       A.Qnt2SisaPO, A.QntSisa, A.Qnt2Sisa, A.NamaBag, ');
                 SQl.Add('       '''' Keterangan, 0 isinspeksi, A.nosat, B.Tanggal,');
                 SQl.Add('       '''' NamaJnsPakai, A.Pelaksana');
                 SQl.Add('FROM vwBrowsOutSPRK A');
                 SQl.Add('LEFT OUTER JOIN dbSPRK AS B ON B.Nobukti = A.Nobukti)x ');
                 SQl.Add('LEFT OUTER JOIN DBBARANG AS C ON C.KODEBRG = x.kodebrg');
                 SQl.Add('ORDER BY X.Tanggal,X.Nobukti, X.urut');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingPPL.fr3');
              frxReport1.ShowReport;
            end;
     051732 :
            begin     // Pembayaran LC
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select a.NOBUKTI nopo, c.NAMABRG,a.KODEVLS , a.KURS,b.HARGA , b.NNETRp  ');
                 //SQL.Add('case when B.Nosat=1 then B.SAT_1 else B.SAT_2 end Satuan,  DATEDIFF(day,c.TANGGAL,A.TANGGAL) Keterlambatan');
                 //SQL.Add('A.TGLSPB, A.TANGGAL TglBPB, A.KODECUSTSUPP, G.NAMACUSTSUPP, ');
                 //SQL.Add(',DATEDIFF(day,D.TANGGAL,A.TANGGAL) Keterlambatan ');
                 SQL.Add('from DBPO a ');
                 SQL.Add('left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI  ');
                 SQL.Add('left outer join DBBARANG c on c.KODEBRG = b.KODEBRG  ');
//                 SQL.Add('left outer join DBBARANG H on H.KODEBRG=B.KODEBRG ');
//                 SQL.Add('left outer join DBCUSTSUPP G on G.KODECUSTSUPP=A.KODECUSTSUPP ');
                 //SQL.Add('left outer join DBBARANG H on H.KODEBRG=B.KODEBRG ');
                 SQL.Add('where Tipe =1 and A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                 SQL.Add('order by a.nobukti');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPembayaranViaLC.fr3');
              frxReport1.ShowReport;
            end;
     051733 :
            begin     // Supplier Performance
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select a.NOPO , a.TANGGAL tglbp, c.TANGGAL tglpo, f.NAMABRG ,g.kodecustsupp , g.NAMACUSTSUPP ');
                 SQL.Add(', case when d.Nosat=1 then d.QNT else d.QNT2 end Qnt,case when d.Nosat=1 then d.SAT_1 else d.SAT_2 end Satuan');
                 //SQL.Add('A.TGLSPB, A.TANGGAL TglBPB, A.KODECUSTSUPP, G.NAMACUSTSUPP, ');
                 //SQL.Add(',DATEDIFF(day,D.TANGGAL,A.TANGGAL) Keterlambatan ');
                 SQL.Add(' from DBBELI a ');
                 SQL.Add('left outer join DBBELIDET b on b.NOBUKTI =a.NOBUKTI   ');
                 SQL.Add('left outer join DBPO c on a.NOPO = c.NOBUKTI  ');
                 SQL.Add('left outer join DBPODET d on d.NOBUKTI =c.NOBUKTI  ');
                 SQL.Add('left outer join DBPOKIRIM e on e.NoPO = d.NOBUKTI and e.UrutPO = c.NOURUT  ');
                 SQL.Add('left outer join DBBARANG f on f.KODEBRG = ' +
                   'b.KODEBRG  ');
                 SQL.Add('left outer join DBCUSTSUPP g on g.KODECUSTSUPP =c.KODECUSTSUPP ');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal13.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir13.Date)));
                 //SQL.Add('order by a.nobukti');
                 case KodeReport of
                 51733 :
                   begin
                      if SelectedSemuaRecord=false then
                      begin
                        SQL.Add('and g.kodecustsupp in (');
                        IsiDariListBox1(QuView);
                      end;
                      SQL.Add('order by A.NoBukti') ;
                   end;
                 end;
              Open;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSupplierPerformance.fr3');
              frxReport1.ShowReport;
              end;
              end;

     051734 :
            begin     // Supplier Per jenis barang
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select A.*, B.Tanggal TglKirim');
                 SQL.Add('from vwRepPO A');
                 SQL.Add('left outer join (Select MAX(x.tanggal) Tanggal, y.NOPO, y.URUTPO');
                 SQL.Add('                 from DBBELI x ');
                 SQL.Add('                 left outer join DBBELIDET y on y.NOBUKTI=x.NOBUKTI');
                 SQL.Add('                 group by y.NOPO, y.URUTPO) B on B.NOPO=A.NOBUKTI and B.URUTPO=A.URUT');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                 Sql.Add(' and (A.Tipe  Like (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
                 sql.Add('                         when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
                 Sql.add('                    end) or (Case when '+IntToStr(ComboBox1.ItemIndex)+'=0 then 0');
                 Sql.add('                                  when '+IntToStr(ComboBox1.ItemIndex)+'=1 then 1');
                 sql.add('                                  else 2');
                 sql.add('                              end)=2)');
                 case KodeReport of
                 51734 :
                   begin
                      if SelectedSemuaRecord=false then
                      begin
                        SQL.Add('and a.kodejnsbrg in (');
                        IsiDariListBox1(QuView);
                      end;
                      SQL.Add('order by A.NoBukti') ;
                   end;
                 end;
                 //sql.SaveToFile('C:\Tes.sql');
              Open;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPoPerJenisBarang.fr3');
              frxReport1.ShowReport;
              end;
              end;
     051735 :
            begin     // Realisasi Import
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select a.NOBUKTI nopo, c.NAMABRG,a.KODEVLS , a.KURS,b.HARGA , b.NNETRp  ,a.tanggal tglpo,b.qnt,  ');
                 SQL.Add('case when B.Nosat=1 then B.SAT_1 else B.SAT_2 end Satuan,');
                 SQL.Add('A.KODECUSTSUPP, G.NAMACUSTSUPP,e.PORT , e.Country  ');
                 //SQL.Add(',DATEDIFF(day,D.TANGGAL,A.TANGGAL) Keterlambatan ');
                 SQL.Add('from DBPO a ');
                 SQL.Add('left outer join DBPODET b on b.NOBUKTI =a.NOBUKTI ');
                 SQL.Add('left outer join DBBARANG c on c.KODEBRG = b.KODEBRG   ');
                 //SQL.Add('left outer join DBCUSTSUPP G on G.KODECUSTSUPP=A.KODECUSTSUPP  ');
                 SQL.Add('left outer join DBCUSTSUPP G on G.KODECUSTSUPP=A.KODECUSTSUPP ');
                 SQL.Add('left outer join DBNOTEPO e on e.NOBUKTI =a.NOBUKTI ');
                 SQL.Add('where Tipe =1 and A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                 SQL.Add('order by a.nobukti');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRealisasiImport.fr3');
              frxReport1.ShowReport;
            end;




     81010, 81020 :
            begin     // Stock Barang
              frxDBDataset1.DataSet.Close;
              //frxDBDataset2.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 {QL.Add('select B.NOPO, D.TANGGAL TglPO, B.KODEBRG, H.NAMABRG, case when B.Nosat=1 then B.QNT else B.QNT2 end Qnt, ');
                 SQL.Add('case when B.Nosat=1 then B.SAT_1 else B.SAT_2 end Satuan, ');
                 SQL.Add('A.TGLSPB, A.TANGGAL TglBPB, A.KODECUSTSUPP, G.NAMACUSTSUPP, ');
                 SQL.Add('DATEDIFF(day,D.TANGGAL,A.TANGGAL) Keterlambatan ');
                 SQL.Add('from DBBELI A ');
                 SQL.Add('left outer join DBBELIDET B on B.NOBUKTI=A.NOBUKTI ');
                 SQL.Add('left outer join DBPODET C on C.NOBUKTI=B.NOPO and C.URUT=B.URUTPO ');
                 SQL.Add('left outer join DBPO D on D.NOBUKTI=C.NOBUKTI and D.NOBUKTI=B.NOPO ');
                 SQL.Add('left outer join DBCUSTSUPP G on G.KODECUSTSUPP=A.KODECUSTSUPP ');
                 SQL.Add('left outer join DBBARANG H on H.KODEBRG=B.KODEBRG ');
                 SQL.Add('where A.Tanggal between '+IntToStr(bulan10.AsInteger )+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                 SQL.Add('order by B.NOPO, B.UrutPO');}
                 sql.Add('select a.*, b.namabrg, b.sat1,b.Grup from DBSTOCKBRG A' )  ;
                 sql.Add('left outer join dbbarang b on b.kodebrg = a.kodebrg');
                 SQL.Add('left outer join dbMyUrutan c on c.KodeUrutan=b.Grup and c.KodeData=''GRUP'' ');
                 sql.add('where A.Bulan='+IntToStr(bulan10.AsInteger));
                 sql.Add(' and a.tahun =' +IntToStr(Tahun10.AsInteger) );
                 SQL.add(' and a.kodegdg='+QuotedStr(Gudang10.Text));
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('and a.kodebrg in (');
                    //SQL.SaveToFile('C:\test.sql') ;
                    IsiDariListBox1(QuView);
                 end;
                 sql.Add('Order by c.Urutan, b.Grup,A.kodebrg');
                 Open;

              end;
              {with QuView2 do
              begin
                 Close;
                 SQL.Clear;
                 sql.Add('select a.kodevls, b.namavls, sum(a.subtotal)  from DBSTOCKBRG A' )  ;
                 sql.Add('left outer join db b on b.kodevls = a.kodevls');
                 sql.Add('left outer join dbvalas b on b.kodevls = a.kodevls');
                 sql.add('where A.Bulan='+IntToStr(bulan10.AsInteger));
                 sql.Add(' and a.tahun =' +IntToStr(Tahun10.AsInteger) );
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('and a.kodebrg in (');
                    IsiDariListBox1(QuView2);
                    sql.add('group by a.kodevls, b.namavls');


                    SQL.SaveToFile('C:\test1.sql') ;
                 end;
                 Open;
                  ;
              end;}

              frxDBDataset1.DataSet:=Quview;
              //frxDBDataset1.DataSet:=Quview2;
              frxDBDataset1.Close;
              //frxDBDataset2.Close;
              frxDBDataset1.Open;
              //frxDBDataset2.Open ;

              case KodeReport of
                81010 :
                        frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportStokPerQty.fr3');
                81020 :
                        frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportStokPerQtyRp.fr3');
              end;
              frxReport1.ShowReport;
            end;
     52915  :
        Begin
              frxDBDataset1.DataSet.Close;
              with Quview do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('SELECT * from vwBPPB a');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                if ((SelectedSemuaRecord=false) and (but=3) ) then
                 begin
                    SQL.Add('and a.nobukti in (');
                    IsiDariListBox1(QuView);
                    //SQL.SaveToFile('C:\test.sql') ;
                 end;
                 if ((SelectedSemuaRecord=false) and (but=4)  )then
                 begin
                    SQL.Add('and a.kodebrg in (');
                    IsiDariListBox1(QuView);
                    //SQL.SaveToFile('C:\test.sql') ;
                 end;
                 if ((SelectedSemuaRecord=false) and (but=5) ) then
                 begin
                    SQL.Add('and a.kodebag in (');
                    IsiDariListBox1(QuView);
                    //SQL.SaveToFile('C:\test.sql') ;
                 end;

                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPB.fr3');
              frxReport1.ShowReport;

        end;
     53515 :
        begin
              frxDBDataset1.DataSet.Close;
              with Quview do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('SELECT a.NoBukti, a.tanggal, d.namabag,b.kodebrg,c.namabrg,');
                 SQL.Add('b.qnt, b.sat_1 from dbpenyerahanbrg a');
                 SQL.Add ('left outer join dbpenyerahanbrgdet b on b.nobukti= a.nobukti');
                 SQL.add ('left outer join dbbarang c on c.kodebrg = b.kodebrg');
                 SQL.Add('left outer join dbbagian d on d.kodebag=a.kodebag');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                if ((SelectedSemuaRecord=false) and (but=3) ) then
                 begin
                    SQL.Add('and a.nobukti in (');
                    IsiDariListBox1(QuView);
                   // SQL.SaveToFile('C:\test.sql') ;
                 end;
                 if ((SelectedSemuaRecord=false) and (but=4)  )then
                 begin
                    SQL.Add('and b.kodebrg in (');
                    IsiDariListBox1(QuView);
                    //SQL.SaveToFile('C:\test.sql') ;
                 end;
                 if ((SelectedSemuaRecord=false) and (but=5) ) then
                 begin
                    SQL.Add('and a.kodebag in (');
                    IsiDariListBox1(QuView);
                    //SQL.SaveToFile('C:\test.sql') ;
                 end;

                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPB.fr3');
              frxReport1.ShowReport;
        end;
     53520 :
          Begin
              frxDBDataset1.DataSet.Close;
              with Quview do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('SELECT a.NoBukti, a.tanggal, d.namabag,b.kodebrg,c.namabrg,');
                 SQL.Add('b.qnt, b.sat_1 from DBRPenyerahanBrg a');
                 SQL.Add ('left outer join dbpenyerahanbrgdet b on b.nobukti= a.nobukti');
                 SQL.add ('left outer join dbbarang c on c.kodebrg = b.kodebrg');
                 SQL.Add('left outer join dbbagian d on d.kodebag=a.kodebag');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                if ((SelectedSemuaRecord=false) and (but=3) ) then
                 begin
                    SQL.Add('and a.nobukti in (');
                    IsiDariListBox1(QuView);
                    //SQL.SaveToFile('C:\test.sql') ;
                 end;
                 if ((SelectedSemuaRecord=false) and (but=4)  )then
                 begin
                    SQL.Add('and b.kodebrg in (');
                    IsiDariListBox1(QuView);
                    //SQL.SaveToFile('C:\test.sql') ;
                 end;
                 if ((SelectedSemuaRecord=false) and (but=5) ) then
                 begin
                    SQL.Add('and a.kodebag in (');
                    IsiDariListBox1(QuView);
                    //SQL.SaveToFile('C:\test.sql') ;
                 end;

                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportReturBPB.fr3');
              frxReport1.ShowReport;
          end;
     54115 :
          Begin
              frxDBDataset1.DataSet.Close;
              with Quview do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('SELECT a.NoBukti, a.tanggal, e.namacustsupp,a.nopo,b.kodebrg,c.namabrg,');
                 SQL.Add('b.qnt, b.sat_1, b.harga, a.kodevls, b.ndpp, b.ndpprp, b.nppnrp, b.subtotal from Dbbeli a');
                 SQL.Add ('left outer join dbbelidet b on b.nobukti= a.nobukti');
                 SQL.add ('left outer join dbbarang c on c.kodebrg = b.kodebrg');
                 //SQL.Add('left outer join dbbagian d on d.kodebag=a.kodebag');
                 SQL.Add('left outer join dbcustsupp e on e.kodecustsupp=a.kodecustsupp');
                 SQL.Add('left outer join dbvalas f on f.kodevls=a.kodevls');
                 SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal9.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir9.Date)));
                if ((SelectedSemuaRecord=false) and (but=3) ) then
                 begin
                    SQL.Add('and a.nobukti in (');
                    IsiDariListBox1(QuView);
                   // SQL.SaveToFile('C:\test.sql') ;
                 end;
                 if ((SelectedSemuaRecord=false) and (but=4)  )then
                 begin
                    SQL.Add('and b.kodebrg in (');
                    IsiDariListBox1(QuView);
                   // SQL.SaveToFile('C:\test.sql') ;
                 end;
                 if ((SelectedSemuaRecord=false) and (but=5) ) then
                 begin
                    if button5.Caption = 'Per Bagian' then
                    begin
                    SQL.Add('and a.kodebag in (');
                    IsiDariListBox1(QuView);
                   // SQL.SaveToFile('C:\test.sql') ;
                    end;
                    if button5.Caption = 'Per Supplier' then
                    begin
                    SQL.Add('and e.kodecustsupp in (');
                    IsiDariListBox1(QuView);
                   // SQL.SaveToFile('C:\test.sql') ;
                    end;

                 end;

                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBP.fr3');
              frxReport1.ShowReport;
          end;
     864 :
          Begin
              frxDBDataset1.DataSet.Close;
              with Quview do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('declare @TglAkhir datetime, @KodeGrp varchar(25), @NoSat int ');
                 SQL.Add('select @TglAkhir='+QuotedStr(FormatDateTime('MM/dd/yyyy',SDTanggal11.Date))+
                   ',@KodeGrp='+QuotedStr(KodeBrg11.Text)+',@NoSat='+IntToStr(Satuan11.ItemIndex));
                 SQL.Add('select Grup, Gudang, KodeBrg, NamaBrg, Satuan, sum(SaldoAkhir) SaldoAkhir, Keterangan ');
                 SQL.Add('from ');
                 SQL.Add('( ');
                 SQL.Add('select B.Grup, C.Nama Gudang, A.KodeBrg, B.NamaBrg, case when @NoSat=0 then B.Sat1 else B.Sat2 end Satuan, ');
                 SQL.Add('  case when @NoSat=0 then A.QntAwal else A.Qnt2Awal end SaldoAkhir, B.Lokasi Keterangan ');
                 SQL.Add('from dbStockBrg A ');
                 SQL.Add('left outer join dbBarang B on B.KodeBrg=A.KodeBrg ');
                 SQL.Add('left outer join dbGudang C on C.KodeGdg=B.KodeGdg ');
                 SQL.Add('where A.Tahun=year(@TglAkhir) and A.Bulan=1 ');
                 SQL.Add('union all ');
                 SQL.Add('select B.Grup, C.Nama Gudang, A.KodeBrg, B.NamaBrg, case when @NoSat=0 then B.Sat1 else B.Sat2 end Satuan, ');
                 SQL.Add('  case when @NoSat=0 then A.QntSaldo else A.Qnt2Saldo end SaldoAkhir, B.Lokasi Keterangan ');
                 SQL.Add('from vwKartuPersediaan A ');
                 SQL.Add('left outer join dbBarang B on B.KodeBrg=A.KodeBrg ');
                 SQL.Add('left outer join dbGudang C on C.KodeGdg=B.KodeGdg ');
                 SQL.Add('where A.Tanggal<=@TglAkhir ');
                 SQL.Add(') X ');
                 SQL.Add('group by Grup, Gudang, KodeBrg, NamaBrg, Satuan, Keterangan ');
                 SQL.Add('order by KodeBrg ');
                 //SQL.SaveToFile('C:\test.sql');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportStockBarangQnt.fr3');
              frxReport1.ShowReport;
          end;
     866 :
          Begin
              frxDBDataset1.DataSet.Close;
              with Quview do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('declare @TglAwal datetime, @TglAkhir datetime, @KodeGrp varchar(25), @NoSat int ');
                 SQL.Add('select @TglAkhir='+QuotedStr(FormatDateTime('MM/dd/yyyy',SDTanggal11.Date))+
                   ',@KodeGrp='+QuotedStr(KodeBrg11.Text)+',@NoSat='+IntToStr(Satuan11.ItemIndex));
                 SQL.Add('select @TglAwal=@TglAkhir-1 ');
                 SQL.Add('select @TglAwal TglAwal, @TglAkhir TglAkhir, ');
                 SQL.Add('Grup, Gudang, KodeBrg, NamaBrg, Satuan, sum(SaldoAwal) SaldoAwal, sum(QntDb) QntDb, sum(QntCr) QntCr, sum(SaldoAkhir) SaldoAkhir, Keterangan ');
                 SQL.Add('from ');
                 SQL.Add('( ');
                 SQL.Add('select B.Grup, C.Nama Gudang, A.KodeBrg, B.NamaBrg, case when @NoSat=0 then B.Sat1 else B.Sat2 end Satuan, ');
                 SQL.Add('  case when @NoSat=0 then A.QntAwal else A.Qnt2Awal end SaldoAwal, ');
                 SQL.Add('  0.00 QntDb, 0.00 QntCr, case when @NoSat=0 then A.QntAwal else A.Qnt2Awal end SaldoAkhir, ');
                 SQL.Add('  B.Lokasi Keterangan ');
                 SQL.Add('from dbStockBrg A ');
                 SQL.Add('left outer join dbBarang B on B.KodeBrg=A.KodeBrg ');
                 SQL.Add('left outer join dbGudang C on C.KodeGdg=B.KodeGdg ');
                 SQL.Add('where A.Tahun=year(@TglAkhir) and A.Bulan=1 and B.Grup=@KodeGrp');
                 SQL.Add('union all ');
                 SQL.Add('select B.Grup, C.Nama Gudang, A.KodeBrg, B.NamaBrg, case when @NoSat=0 then B.Sat1 else B.Sat2 end Satuan, ');
                 SQL.Add('  case when A.Tanggal<@TglAwal then case when @NoSat=0 then A.QntSaldo else A.Qnt2Saldo end else 0.00 end SaldoAwal, ');
                 SQL.Add('  case when A.Tanggal>=@TglAwal then case when @NoSat=0 then A.QntDb else A.Qnt2Db end else 0.00 end QntDb, ');
                 SQL.Add('  case when A.Tanggal>=@TglAwal then case when @NoSat=0 then A.QntCr else A.Qnt2Cr end else 0.00 end QntCr, ');
                 SQL.Add('  case when @NoSat=0 then A.QntSaldo else A.Qnt2Saldo end SaldoAkhir, ');
                 SQL.Add('  B.Lokasi Keterangan ');
                 SQL.Add('from vwKartuPersediaan A ');
                 SQL.Add('left outer join dbBarang B on B.KodeBrg=A.KodeBrg ');
                 SQL.Add('left outer join dbGudang C on C.KodeGdg=B.KodeGdg ');
                 SQL.Add('where A.Tanggal<=@TglAkhir and B.Grup=@KodeGrp');
                 SQL.Add(') X ');
                 SQL.Add('group by Grup, Gudang, KodeBrg, NamaBrg, Satuan, Keterangan ');
                 SQL.Add('order by Grup, KodeBrg ');
                 //SQL.SaveToFile('C:\test.sql');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportStockOpnameGudang.fr3');
              frxReport1.ShowReport;
          end;
     867 :
          Begin
              frxDBDataset1.DataSet.Close;
              with Quview do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('declare @TglAwal datetime, @TglAkhir datetime, @KodeGrp varchar(25), @NoSat int ');
                 SQL.Add('select @TglAwal='+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal11.Date))+',@TglAkhir='+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir11.Date))+
                   ',@KodeGrp='+QuotedStr(KodeBrg11.Text)+',@NoSat='+IntToStr(Satuan11.ItemIndex));
                 SQL.Add('select Grup, Gudang, KodeBrg, NamaBrg, Satuan, sum(SaldoAwal) SaldoAwal, sum(QntDb) QntDb, sum(QntCr) QntCr, sum(SaldoAkhir) SaldoAkhir ');
                 SQL.Add('from ');
                 SQL.Add('( ');
                 SQL.Add('select B.Grup, C.Nama Gudang, A.KodeBrg, B.NamaBrg, case when @NoSat=0 then B.Sat1 else B.Sat2 end Satuan, ');
                 SQL.Add('  case when @NoSat=0 then A.QntAwal else A.Qnt2Awal end SaldoAwal, ');
                 SQL.Add('  0.00 QntDb, 0.00 QntCr, case when @NoSat=0 then A.QntAwal else A.Qnt2Awal end SaldoAkhir ');
                 SQL.Add('from dbStockBrg A ');
                 SQL.Add('left outer join dbBarang B on B.KodeBrg=A.KodeBrg ');
                 SQL.Add('left outer join dbGudang C on C.KodeGdg=B.KodeGdg ');
                 SQL.Add('where A.Tahun=year(@TglAwal) and A.Bulan=1 and B.Grup=@KodeGrp ');
                 SQL.Add('union all ');
                 SQL.Add('select B.Grup, C.Nama Gudang, A.KodeBrg, B.NamaBrg, case when @NoSat=0 then B.Sat1 else B.Sat2 end Satuan, ');
                 SQL.Add('  case when A.Tanggal<@TglAwal then case when @NoSat=0 then A.QntSaldo else A.Qnt2Saldo end else 0.00 end SaldoAwal, ');
                 SQL.Add('  case when A.Tanggal>=@TglAwal then case when @NoSat=0 then A.QntDb else A.Qnt2Db end else 0.00 end QntDb, ');
                 SQL.Add('  case when A.Tanggal>=@TglAwal then case when @NoSat=0 then A.QntCr else A.Qnt2Cr end else 0.00 end QntCr, ');
                 SQL.Add('  case when @NoSat=0 then A.QntSaldo else A.Qnt2Saldo end SaldoAkhir ');
                 SQL.Add('from vwKartuPersediaan A ');
                 SQL.Add('left outer join dbBarang B on B.KodeBrg=A.KodeBrg ');
                 SQL.Add('left outer join dbGudang C on C.KodeGdg=B.KodeGdg ');
                 SQL.Add('where (A.Tanggal between @TglAwal and @TglAkhir) and B.Grup=@KodeGrp ');
                 SQL.Add(') X ');
                 SQL.Add('group by Grup, Gudang, KodeBrg, NamaBrg, Satuan ');
                 SQL.Add('order by Grup, Gudang, KodeBrg ');
                 //SQL.SaveToFile('C:\test.sql');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportMutasiPersediaanQnt.fr3');
              frxReport1.ShowReport;
          end;
     868, 869 :
          Begin
              frxDBDataset1.DataSet.Close;
              with Quview do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('declare @TglAwal datetime, @TglAkhir datetime, @KodeGrp varchar(25), @NoSat int ');
                 SQL.Add('select @TglAwal='+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal11.Date))+',@TglAkhir='+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir11.Date))+
                   ',@KodeGrp='+QuotedStr(KodeBrg11.Text)+',@NoSat='+IntToStr(Satuan11.ItemIndex));
                 SQL.Add('select A.KodeBrg, B.NAMABRG, case when @NoSat=0 then B.Sat1 else B.Sat2 end Satuan, ');
                 SQL.Add('B.Grup, B.Lokasi, A.Tanggal, A.NoBukti, case when @NoSat=0 then abs(A.QntSaldo) else abs(A.Qnt2Saldo) end Jumlah, ');
                 SQL.Add('case when A.Tipe in (''BPY'',''RPB'') then A.KodeBag ');
                 SQL.Add('  when A.Tipe in (''BPB'',''BRB'') then CS.NamaCustSupp ');
                 SQL.Add('else '''' end Keterangan ');
                 SQL.Add('from vwKartuPersediaan A ');
                 SQL.Add('left outer join DBBARANG B on B.KODEBRG=A.KodeBrg ');
                 SQL.Add('left outer join dbCustSupp CS on CS.KodeCustSupp=A.KodeCustSupp ');
                 SQL.Add('where A.Tanggal between @TglAwal and @TglAkhir ');
                 if KodeReport=868 then
                   SQL.Add('and Tipe in (''RPB'',''BPB'',''ADI'') ')
                 else if KodeReport=869 then
                   SQL.Add('and Tipe in (''BPY'',''BRB'',''ADO'') ');
                 //SQL.Add('and B.Grup=@KodeGrp and @KodeGrp<>'-')
                 SQL.Add('order by A.KodeBrg, A.Tanggal, A.Prioritas, A.NoBukti ');
                 //SQL.SaveToFile('C:\test.sql');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              if KodeReport=868 then
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportTerimaBarangQnt.fr3')
              else if KodeReport=869 then
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKeluarBarangQnt.fr3');
              frxReport1.ShowReport;
          end;
     870 :
          Begin
              frxDBDataset1.DataSet.Close;
              with Quview do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('declare @TglAwal datetime, @TglAkhir datetime, @KodeBrg varchar(25), @NoSat int, @SaldoAwal numeric(18,2) ');
                 SQL.Add('select @TglAwal='+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAwal11.Date))+',@TglAkhir='+QuotedStr(FormatDateTime('MM/dd/yyyy',TglAkhir11.Date))+
                   ',@KodeBrg='+QuotedStr(KodeBrg11.Text)+',@NoSat='+IntToStr(Satuan11.ItemIndex));
                 SQL.Add('select @SaldoAwal=sum(QntAwal) from dbStockBrg where Tahun=year(@TglAwal) and Bulan=1 and KodeBrg=@KodeBrg');
                 SQL.Add('select @SaldoAwal=isnull(@SaldoAwal,0)+isnull((select sum(case when @NoSat=0 then QntSaldo else Qnt2Saldo end) from vwKartuPersediaan ');
                 SQL.Add('where year(Tanggal)=year(@TglAwal) and Tanggal<@TglAwal and KodeBrg=@KodeBrg),0) ');
                 SQL.Add('select A0.TglAwal, A0.TglAkhir, A0.KodeBrg, B.NAMABRG, case when @NoSat=0 then B.Sat1 else B.Sat2 end Satuan, A0.SaldoAwal, ');
                 SQL.Add('B.Grup, B.Lokasi, A.Tanggal, A.NoBukti, case when @NoSat=0 then A.QntDb else A.Qnt2Db end QntDb, ');
                 SQL.Add('case when @NoSat=0 then A.QntCr else A.Qnt2Cr end QntCr, case when @NoSat=0 then A.QntSaldo else A.Qnt2Saldo end QntSaldo, ');
                 SQL.Add('A.Namacustsupp Keterangan ');
                 SQL.Add('from ');
                 SQL.Add('      (select @TglAwal TglAwal, @TglAkhir TglAkhir, @KodeBrg KodeBrg, @SaldoAwal SaldoAwal) A0 ');
                 SQL.Add('left outer join vwKartuPersediaan A on A.KodeBrg=A0.KodeBrg and A.Tanggal between @TglAwal and @TglAkhir ');
                 SQL.Add('left outer join DBBARANG B on B.KODEBRG=A0.KodeBrg ');
                 SQL.Add('order by A.Tanggal, A.Prioritas, A.NoBukti ');
                 //SQL.SaveToFile('C:\test.sql');
                 Open;
              end;
              frxDBDataset1.DataSet:=Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKartuPersediaanQnt.fr3');
              frxReport1.ShowReport;
          end;


  end;
end;

procedure TFrReportPreview.Button1Click(Sender: TObject);
begin
   frxReport1.DotMatrixReport:=DotMatrix.Checked;
   SelectedSemuaRecord := true;
   SelectReport;
end;

procedure TFrReportPreview.SpeedButton1Click(Sender: TObject);
begin
   panel1.Visible := false;
   treeb.enabled := true;
end;



procedure TFrReportPreview.Button2Click(Sender: TObject);
var i : integer;
begin
  case KodeReport of
    51705,51715,51720,51725,51730,52315,52320:                                //,51707,51709,51715,51720,51725,51730
    begin
      Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=30073;
     // FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal9.Date;
     FrBrows.TglAkhir:=TglAkhir9.Date;
      FrBrows.ShowModal;
    end;
     52410:                           //,51707,51709,51715,51720,51725,51730
    begin
      Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=30083;
     // FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal9.Date;
     FrBrows.TglAkhir:=TglAkhir9.Date;
      FrBrows.ShowModal;
    end;
     52510:
        begin
      Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=30093;
     // FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal9.Date;
     FrBrows.TglAkhir:=TglAkhir9.Date;
      FrBrows.ShowModal;
    end;

    52610:
    begin
    Application.CreateForm(TFrBrows, FrBrows);
    KodeBrows:=30004;
    // FrBrows.NoKira:='dbPerkiraan';
    FrBrows.TglAwal:=TglAwal9.Date;
    FrBrows.TglAkhir:=TglAkhir9.Date;
    FrBrows.ShowModal;
    end;


    51707,52325,52520,52620 : //,51709,51715,51720,51725,51730
    begin
      Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=30074;
     // FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal9.Date;
     FrBrows.TglAkhir:=TglAkhir9.Date;
      FrBrows.ShowModal;
    end;
     52420:
     begin
      Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=30084;
     // FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal9.Date;
     FrBrows.TglAkhir:=TglAkhir9.Date;
      FrBrows.ShowModal;
    end;

     51709,52330,52630 :
    begin
      Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=30075;
     // FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal9.Date;
     FrBrows.TglAkhir:=TglAkhir9.Date;
      FrBrows.ShowModal;
    end;

      52530 :
    begin
      Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=300750;
     // FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal9.Date;
     FrBrows.TglAkhir:=TglAkhir9.Date;
      FrBrows.ShowModal;
    end;
         52430 :
    begin
      Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=30085;
     // FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal9.Date;
     FrBrows.TglAkhir:=TglAkhir9.Date;
      FrBrows.ShowModal;
    end;
    81010, 81020 :
    begin
      Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=30075;
     {FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal9.Date;
     FrBrows.TglAkhir:=TglAkhir9.Date;  }
      FrBrows.ShowModal;
    end;

         51733 :

 begin
      Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=30074;
     // FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal13.Date;
     FrBrows.TglAkhir:=TglAkhir13.Date;
      FrBrows.ShowModal;
    end;
         51734,52335,52540,52440,52640 :

 begin
      Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=1009;
     // FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal13.Date;
     FrBrows.TglAkhir:=TglAkhir13.Date;
      FrBrows.ShowModal;
    end;

   273:
  begin
    Application.CreateForm(TFrBrows, FrBrows);
      KodeBrows:=1013;
     {FrBrows.NoKira:='dbPerkiraan';
     FrBrows.TglAwal:=TglAwal9.Date;
     FrBrows.TglAkhir:=TglAkhir9.Date;  }
      FrBrows.ShowModal;
  end;
 end;
  if (assigned(frbrows)) and (FrBrows.ModalResult=mrOk) then
  begin
    SelectedSemuaRecord:=FrBrows.SelectAllRecord;
    xList := TList.Create;
    ListBox1.Clear;
    for i:= 0 to FrBrows.GridBrows.SelectedCount - 1 do
      xList.Add(FrBrows.GridBrows.SelectedNodes[i]);
    xList.Sort(@CompareByAbsoluteIndex);
    if not FrBrows.QuBrows.IsEmpty then
    begin
    for i:= 0 to FrBrows.GridBrows.SelectedCount - 1 do
    begin
      case KodeBrows of
       30073 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('nobukti').Index]);
        30083 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('nobukti').Index]);
        30093 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('nobukti').Index]);
        30004 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('nobukti').Index]);
        30074 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeCustSupp').Index]);
        30084 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeCustSupp').Index]);
        30085 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeBrg').Index]);
        30075 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeBrg').Index]);
        300750 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeBrg').Index]);
        1013 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeBrg').Index]);
        1009 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodejnsBrg').Index]);
        //30075 :
        //ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeBrg').Index]);
      end;
    end;
    end
    else
      ListBox1.Items.add('');
    xList.Free;
    selectreport;
  end
  else
    ListBox1.Items.add('');
end;

procedure TFrReportPreview.TreeBClick(Sender: TObject);
begin
   panel1.Visible := true;
end;

procedure TFrReportPreview.frxReport1GetValue(const VarName: String;
  var Value: Variant);
var xStringKet: String;
begin
  if CompareText(VarName,'nmKlien')=0 then
     Value := mNamaKlien ;
  if CompareText(VarName,'Divisi')=0 then
     Value := '';
  if dxPageControl1.ActivePageIndex=0 then
  begin
    DataBersyarat('select Perkiraan, Keterangan from dbPerkiraan where Perkiraan=:0',[Perkiraan.Text],DM.QuTemp);
    if CompareText(VarName,'Perkiraan')=0 then
      Value := 'Perkiraan : '+Perkiraan.Text+' ('+DM.QuTemp.FieldByName('Keterangan').AsString+')';
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+Awal.Text +' s/d ' + Akhir.Text;
  end else
  if dxPageControl1.ActivePageIndex=1 then
  begin
    DataBersyarat('select Perkiraan, Keterangan from dbPerkiraan where Perkiraan=:0',[Perkiraan2.Text],DM.QuTemp);
    xStringKet:='Perkiraan : '+Perkiraan2.Text+' ('+DM.QuTemp.FieldByName('Keterangan').AsString+') s/d ';
    DataBersyarat('select Perkiraan, Keterangan from dbPerkiraan where Perkiraan=:0',[Perkiraan3.Text],DM.QuTemp);
    xStringKet:=xStringKet+Perkiraan3.Text+' ('+DM.QuTemp.FieldByName('Keterangan').AsString+')';
    if CompareText(VarName,'Perkiraan')=0 then
      Value := xStringKet;
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+Awal3.Text +' s/d ' + Akhir3.Text;
  end else
  if dxPageControl1.ActivePageIndex=2 then
  begin
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+Bulan.Text +' / ' + Tahun.Text;
  end else
  if dxPageControl1.ActivePageIndex=3 then
  begin
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+TglAwal4.Text +' s/d ' + TglAkhir4.Text;
  end else
  if dxPageControl1.ActivePageIndex=4 then
  begin
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+Bulan5.Text +' / ' + Tahun5.Text;
  end else
  if dxPageControl1.ActivePageIndex=5 then
  begin
    DataBersyarat('select Perkiraan, Keterangan from dbPerkiraan where Perkiraan=:0',[Perkiraan6A.Text],DM.QuTemp);
    xStringKet:='Perkiraan : '+Perkiraan6A.Text+' ('+DM.QuTemp.FieldByName('Keterangan').AsString+') s/d ';
    DataBersyarat('select Perkiraan, Keterangan from dbPerkiraan where Perkiraan=:0',[Perkiraan6B.Text],DM.QuTemp);
    xStringKet:=xStringKet+Perkiraan6B.Text+' ('+DM.QuTemp.FieldByName('Keterangan').AsString+')';
    if CompareText(VarName,'Perkiraan')=0 then
      Value := xStringKet;
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+Bulan6.Text +' / ' + Tahun6.Text;
  end else
  if dxPageControl1.ActivePageIndex=6 then
  begin
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+Tanggal7.Text;
  end else
  if dxPageControl1.ActivePageIndex=7 then
  begin
    DataBersyarat('select * from dbPerkiraan where Perkiraan=:0 ',[Perkiraan8.Text],DM.QuTemp);
    if CompareText(VarName,'Perkiraan')=0 then
      Value := 'Perkiraan : '+Perkiraan8.Text+' ('+DM.QuTemp.FieldByName('Keterangan').AsString+')';
    case KodeReport of
      300301 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      300302 : if CompareText(VarName,'Periode')=0 then Value := 's/d Tanggal : '+TglAkhir8.Text;
      300303 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      300304 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      300305 : if CompareText(VarName,'Periode')=0 then Value := 's/d Tanggal : '+TglAkhir8.Text;
    end;
    case KodeReport of
      300401 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      300402 : if CompareText(VarName,'Periode')=0 then Value := 's/d Tanggal : '+TglAkhir8.Text;
      300403 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      300404 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      300405 : if CompareText(VarName,'Periode')=0 then Value := 's/d Tanggal : '+TglAkhir8.Text;
    end;
  end else
  if dxPageControl1.ActivePageIndex=8 then
  begin
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+TglAwal9.Text+' s/d '+TglAkhir9.Text;
  end;
  if dxPageControl1.ActivePageIndex=9 then
  begin
    if CompareText(VarName,'Bulan')=0 then
      Value := 'Bulan : '+Bulan10.Text +' - ' +tahun10.Text  ;
    if CompareText(VarName,'Gudang')=0 then
      Value := 'Gudang : '+Gudang10.Text ;
  end;
  if dxPageControl1.ActivePageIndex=10 then
  begin
    if CompareText(VarName,'Periode')=0 then
    begin
      if KodeReport=864 then
        Value := 'Sampai Tanggal '+FormatDateTime('dd MMMM yyyy',SDTanggal11.Date)
      else if (KodeReport=867) or (KodeReport=868) or (KodeReport=869) or (KodeReport=870)then
      begin
        if FormatDateTime('yyyyMM',TglAwal11.Date)=FormatDateTime('yyyyMM',TglAkhir11.Date) then
          Value := 'Periode '+FormatDateTime('dd',TglAwal11.Date)+' - '+FormatDateTime('dd MMMM yyyy',TglAkhir11.Date)
        else
          Value := 'Periode '+FormatDateTime('dd MMMM yyyy',TglAwal11.Date)+' - '+FormatDateTime('dd MMMM yyyy',TglAkhir11.Date);
      end;
    end;
  end;
  if dxPageControl1.ActivePageIndex=11 then
  begin
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+TglAwal13.Text+' s/d '+TglAkhir13.Text;
  end;
end;

procedure TFrReportPreview.DotMatrixClick(Sender: TObject);
begin
  frxReport1.DotMatrixReport := DotMatrix.Checked;
end;

procedure TFrReportPreview.PerkiraanKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_Return then
  begin
    case KodeReport of
    300101,300102:
      begin
        if length(Perkiraan.Text)=0 then
        begin
          if KodeReport=300101 then
             KodeBrows:=100403
          else if KodeReport=300102 then
             KodeBrows:=100404;
          Application.CreateForm(TFrBrows, FrBrows);
          FrBrows.IsiData:=Perkiraan.Text;
          FrBrows.showmodal;
          if FrBrows.ModalResult=mrOk then
          begin
            with FrBrows.QuBrows do
            begin
              Perkiraan.Text:=fieldbyname('Perkiraan').AsString;
              //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
            end;
          end else
            ActiveControl:=Perkiraan;
        end else
        begin
          if DataBersyarat('select a.Perkiraan,b.keterangan from dbposthutpiut a '+
                       'left outer join dbperkiraan b on b.perkiraan=a.perkiraan '+
                       'where a.Kode=Case when 300101='+IntToStr(KodeReport) +' then ''KAS'' '+
                       '                  when 300102='+IntToStr(KodeReport) +' then ''BANK'' end and a.Perkiraan=:0 order by a.Perkiraan',
             [Perkiraan.Text],DM.QuCari)=true then
          begin
            with DM.QuCari do
            begin
              Perkiraan.Text:=fieldbyname('Perkiraan').AsString;
              //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
            end;
          end else
          begin
            if KodeReport=300101 then
               KodeBrows:=100403
            else if KodeReport=300102 then
               KodeBrows:=100404;
            Application.CreateForm(TFrBrows, FrBrows);
            FrBrows.IsiData:=Perkiraan.Text;
            FrBrows.showmodal;
            if FrBrows.ModalResult=mrOk then
            begin
              with FrBrows.QuBrows do
              begin
                Perkiraan.Text:=fieldbyname('Perkiraan').AsString;
                //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
              end;
            end else
              ActiveControl:=Perkiraan;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrReportPreview.DivisiKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return Then
 begin
   if (Divisi.Text = '-')  then
   begin
      if Perkiraan.Visible=true then
      ActiveControl := Perkiraan;
   end else
   begin
     if (length(Divisi.Text)=0)  then
     begin
       KodeBrows:=1004;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=Divisi.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Divisi.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
         //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
       end else
       begin
        if Divisi.Enabled=true then
        ActiveControl:=Divisi;
       end;
     end else
     begin
       if MyFindField('dbDevisi','Devisi',Divisi.Text)=true then
       begin
         Divisi.Text:=DM.QuCari.fieldbyname('Devisi').AsString;
         //NamaDivisi.Text:=DM.QuCari.fieldbyname('NamaDevisi').AsString;
       end else
       begin
         KodeBrows:=1004;
         Application.CreateForm(Tfrbrows, frbrows);
         FrBrows.IsiData:=Divisi.Text;
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           Divisi.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
           //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
         end else
         begin
           if Divisi.Enabled=true then
           ActiveControl:=Divisi;
         end;
       end;
     end;
   end;
 end;
end;

procedure TFrReportPreview.Devisi3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return Then
 begin
   begin
     if (length(Devisi3.Text)=0)  then
     begin
       KodeBrows:=1004;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=Devisi3.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Devisi3.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
         //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
       end else
       begin
        if Devisi3.Enabled=true then
        ActiveControl:=Devisi3;
       end;
     end else
     begin
       if MyFindField('dbDevisi','Devisi',Devisi3.Text)=true then
       begin
         Devisi3.Text:=DM.QuCari.fieldbyname('Devisi').AsString;
         //NamaDivisi.Text:=DM.QuCari.fieldbyname('NamaDevisi').AsString;
       end else
       begin
         KodeBrows:=1004;
         Application.CreateForm(Tfrbrows, frbrows);
         FrBrows.IsiData:=Devisi3.Text;
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           Devisi3.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
           //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
         end else
         begin
           if Devisi3.Enabled=true then
           ActiveControl:=Devisi3;
         end;
       end;
     end;
   end;
 end;
end;

procedure TFrReportPreview.Perkiraan2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_Return then
  begin
    if length(Perkiraan.Text)=0 then
    begin
      KodeBrows:=1005;
      Application.CreateForm(TFrBrows, FrBrows);
      FrBrows.IsiData:=Perkiraan2.Text;
      FrBrows.showmodal;
      if FrBrows.ModalResult=mrOk then
      begin
        with FrBrows.QuBrows do
        begin
          Perkiraan2.Text:=fieldbyname('Perkiraan').AsString;
          //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
        ActiveControl:=Perkiraan;
    end else
    begin
      if DataBersyarat('select Perkiraan,Keterangan from dbPerkiraan where  tipe=1 and Perkiraan=:0 order by Perkiraan',
         [Perkiraan2.Text],DM.QuCari)=true then
      begin
        with DM.QuCari do
        begin
          Perkiraan2.Text:=fieldbyname('Perkiraan').AsString;
          //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
      begin
        KodeBrows:=1005;
        Application.CreateForm(TFrBrows, FrBrows);
        FrBrows.IsiData:=Perkiraan2.Text;
        FrBrows.showmodal;
        if FrBrows.ModalResult=mrOk then
        begin
          with FrBrows.QuBrows do
          begin
            Perkiraan2.Text:=fieldbyname('Perkiraan').AsString;
            //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
          end;
        end else
          ActiveControl:=Perkiraan2;
      end;
    end;
  end;
end;

procedure TFrReportPreview.Perkiraan3KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_Return then
  begin
    if length(Perkiraan3.Text)=0 then
    begin
      KodeBrows:=1005;
      Application.CreateForm(TFrBrows, FrBrows);
      FrBrows.IsiData:=Perkiraan3.Text;
      FrBrows.showmodal;
      if FrBrows.ModalResult=mrOk then
      begin
        with FrBrows.QuBrows do
        begin
          Perkiraan3.Text:=fieldbyname('Perkiraan').AsString;
          //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
        ActiveControl:=Perkiraan;
    end else
    begin
      if DataBersyarat('select Perkiraan,Keterangan from dbPerkiraan where  tipe=1 and Perkiraan=:0 order by Perkiraan',
         [Perkiraan3.Text],DM.QuCari)=true then
      begin
        with DM.QuCari do
        begin
          Perkiraan3.Text:=fieldbyname('Perkiraan').AsString;
          //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
      begin
        KodeBrows:=1005;
        Application.CreateForm(TFrBrows, FrBrows);
        FrBrows.IsiData:=Perkiraan3.Text;
        FrBrows.showmodal;
        if FrBrows.ModalResult=mrOk then
        begin
          with FrBrows.QuBrows do
          begin
            Perkiraan3.Text:=fieldbyname('Perkiraan').AsString;
            //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
          end;
        end else
          ActiveControl:=Perkiraan3;
      end;
    end;
  end;
end;

procedure TFrReportPreview.Devisi4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return Then
 begin
   if (length(Devisi4.Text)=0)  then
   begin
     KodeBrows:=1004;
     Application.CreateForm(Tfrbrows, frbrows);
     FrBrows.IsiData:=Devisi4.Text;
     frbrows.Showmodal;
     if FrBrows.ModalResult=mrOk then
     begin
       Devisi4.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
       //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
     end else
     begin
      if Devisi4.Enabled=true then
      ActiveControl:=Devisi4;
     end;
   end else
   begin
     if MyFindField('dbDevisi','Devisi',Devisi4.Text)=true then
     begin
       Devisi4.Text:=DM.QuCari.fieldbyname('Devisi').AsString;
       //NamaDivisi.Text:=DM.QuCari.fieldbyname('NamaDevisi').AsString;
     end else
     begin
       KodeBrows:=1004;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=Devisi4.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Devisi4.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
         //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
       end else
       begin
         if Devisi4.Enabled=true then
         ActiveControl:=Devisi4;
       end;
     end;
   end;
 end;
end;

procedure TFrReportPreview.Devisi5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return Then
 begin
   if (length(Devisi5.Text)=0)  then
   begin
     KodeBrows:=1004;
     Application.CreateForm(Tfrbrows, frbrows);
     FrBrows.IsiData:=Devisi5.Text;
     frbrows.Showmodal;
     if FrBrows.ModalResult=mrOk then
     begin
       Devisi5.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
       //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
     end else
     begin
      if Devisi5.Enabled=true then
      ActiveControl:=Devisi5;
     end;
   end else
   begin
     if MyFindField('dbDevisi','Devisi',Devisi5.Text)=true then
     begin
       Devisi5.Text:=DM.QuCari.fieldbyname('Devisi').AsString;
       //NamaDivisi.Text:=DM.QuCari.fieldbyname('NamaDevisi').AsString;
     end else
     begin
       KodeBrows:=1004;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=Devisi5.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Devisi5.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
         //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
       end else
       begin
         if Devisi5.Enabled=true then
         ActiveControl:=Devisi5;
       end;
     end;
   end;
 end;
end;

procedure TFrReportPreview.Devisi6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return Then
 begin
   if (length(Devisi6.Text)=0)  then
   begin
     KodeBrows:=1004;
     Application.CreateForm(Tfrbrows, frbrows);
     FrBrows.IsiData:=Devisi6.Text;
     frbrows.Showmodal;
     if FrBrows.ModalResult=mrOk then
     begin
       Devisi6.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
     end else
     begin
      if Devisi6.Enabled=true then
      ActiveControl:=Devisi6;
     end;
   end else
   begin
     if MyFindField('dbDevisi','Devisi',Devisi6.Text)=true then
     begin
       Devisi6.Text:=DM.QuCari.fieldbyname('Devisi').AsString;
     end else
     begin
       KodeBrows:=1004;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=Devisi6.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Devisi6.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
       end else
       begin
         if Devisi6.Enabled=true then
         ActiveControl:=Devisi6;
       end;
     end;
   end;
 end;
end;

procedure TFrReportPreview.Perkiraan6AKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_Return then
  begin
    if length(Perkiraan6A.Text)=0 then
    begin
      KodeBrows:=1005;
      Application.CreateForm(TFrBrows, FrBrows);
      FrBrows.IsiData:=Perkiraan6A.Text;
      FrBrows.showmodal;
      if FrBrows.ModalResult=mrOk then
      begin
        with FrBrows.QuBrows do
        begin
          Perkiraan6A.Text:=fieldbyname('Perkiraan').AsString;
        end;
      end else
        ActiveControl:=Perkiraan6A;
    end else
    begin
      if DataBersyarat('select Perkiraan,Keterangan from dbPerkiraan where  tipe=1 and Perkiraan=:0 order by Perkiraan',
         [Perkiraan6A.Text],DM.QuCari)=true then
      begin
        with DM.QuCari do
        begin
          Perkiraan6A.Text:=fieldbyname('Perkiraan').AsString;
        end;
      end else
      begin
        KodeBrows:=1005;
        Application.CreateForm(TFrBrows, FrBrows);
        FrBrows.IsiData:=Perkiraan6A.Text;
        FrBrows.showmodal;
        if FrBrows.ModalResult=mrOk then
        begin
          with FrBrows.QuBrows do
          begin
            Perkiraan6A.Text:=fieldbyname('Perkiraan').AsString;
          end;
        end else
          ActiveControl:=Perkiraan6A;
      end;
    end;
  end;
end;

procedure TFrReportPreview.Perkiraan6BKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_Return then
  begin
    if length(Perkiraan6B.Text)=0 then
    begin
      KodeBrows:=1005;
      Application.CreateForm(TFrBrows, FrBrows);
      FrBrows.IsiData:=Perkiraan6B.Text;
      FrBrows.showmodal;
      if FrBrows.ModalResult=mrOk then
      begin
        with FrBrows.QuBrows do
        begin
          Perkiraan6B.Text:=fieldbyname('Perkiraan').AsString;
        end;
      end else
        ActiveControl:=Perkiraan6B;
    end else
    begin
      if DataBersyarat('select Perkiraan,Keterangan from dbPerkiraan where  tipe=1 and Perkiraan=:0 order by Perkiraan',
         [Perkiraan6B.Text],DM.QuCari)=true then
      begin
        with DM.QuCari do
        begin
          Perkiraan6B.Text:=fieldbyname('Perkiraan').AsString;
        end;
      end else
      begin
        KodeBrows:=1005;
        Application.CreateForm(TFrBrows, FrBrows);
        FrBrows.IsiData:=Perkiraan6B.Text;
        FrBrows.showmodal;
        if FrBrows.ModalResult=mrOk then
        begin
          with FrBrows.QuBrows do
          begin
            Perkiraan6B.Text:=fieldbyname('Perkiraan').AsString;
          end;
        end else
          ActiveControl:=Perkiraan6B;
      end;
    end;
  end;
end;

procedure TFrReportPreview.Valas8Click(Sender: TObject);
begin
  KodeVls8.Visible:=Valas8.ItemIndex=1;
end;

procedure TFrReportPreview.Devisi7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return Then
 begin
   if (length(Devisi7.Text)=0)  then
   begin
     KodeBrows:=1004;
     Application.CreateForm(Tfrbrows, frbrows);
     FrBrows.IsiData:=Devisi7.Text;
     frbrows.Showmodal;
     if FrBrows.ModalResult=mrOk then
     begin
       Devisi7.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
     end else
     begin
      if Devisi7.Enabled=true then
      ActiveControl:=Devisi7;
     end;
   end else
   begin
     if MyFindField('dbDevisi','Devisi',Devisi7.Text)=true then
     begin
       Devisi7.Text:=DM.QuCari.fieldbyname('Devisi').AsString;
     end else
     begin
       KodeBrows:=1004;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=Devisi7.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Devisi7.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
       end else
       begin
         if Devisi7.Enabled=true then
         ActiveControl:=Devisi7;
       end;
     end;
   end;
 end;
end;

procedure TFrReportPreview.Devisi2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return Then
 begin
   if (length(Devisi2.Text)=0)  then
   begin
     KodeBrows:=1001;
     Application.CreateForm(Tfrbrows, frbrows);
     FrBrows.IsiData:=Devisi2.Text;
     frbrows.Showmodal;
     if FrBrows.ModalResult=mrOk then
     begin
       Devisi2.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
     end else
     begin
      if Devisi2.Enabled=true then
      ActiveControl:=Devisi2;
     end;
   end else
   begin
     if MyFindField('dbDevisi','Devisi',Devisi2.Text)=true then
     begin
       Devisi2.Text:=DM.QuCari.fieldbyname('Devisi').AsString;
     end else
     begin
       KodeBrows:=1004;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=Devisi2.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Devisi2.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
       end else
       begin
         if Devisi2.Enabled=true then
         ActiveControl:=Devisi2;
       end;
     end;
   end;
 end;
end;

procedure TFrReportPreview.Devisi8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return Then
 begin
   if (length(Devisi8.Text)=0)  then
   begin
     KodeBrows:=1004;
     Application.CreateForm(Tfrbrows, frbrows);
     FrBrows.IsiData:=Devisi8.Text;
     frbrows.Showmodal;
     if FrBrows.ModalResult=mrOk then
     begin
       Devisi8.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
     end else
     begin
      if Devisi8.Enabled=true then
      ActiveControl:=Devisi8;
     end;
   end else
   begin
     if MyFindField('dbDevisi','Devisi',Devisi8.Text)=true then
     begin
       Devisi8.Text:=DM.QuCari.fieldbyname('Devisi').AsString;
     end else
     begin
       KodeBrows:=1004;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=Devisi8.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Devisi8.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
       end else
       begin
         if Devisi8.Enabled=true then
         ActiveControl:=Devisi8;
       end;
     end;
   end;
 end;
end;

procedure TFrReportPreview.Perkiraan8KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var xHTPT: String;
begin
  if key=vk_Return then
  begin
    case KodeReport of
    300301,300302, 300303, 300304, 300305, 300401,300402, 300403, 300404, 300405 :
      begin
        if (KodeReport=300301) or (KodeReport=300302) or (KodeReport=300303) or (KodeReport=300304) or (KodeReport=300305) then
          xHTPT:='HT'
        else if (KodeReport=300401) or (KodeReport=300402) or (KodeReport=300403) or (KodeReport=300404) or (KodeReport=300405) then
          xHTPT:='PT';
        if length(Perkiraan8.Text)=0 then
        begin
          if (KodeReport=300301) or (KodeReport=300302) or (KodeReport=300303) or (KodeReport=300304) or (KodeReport=300305) then
             KodeBrows:=100409
          else if (KodeReport=300401) or (KodeReport=300402) or (KodeReport=300403) or (KodeReport=300404) or (KodeReport=300405) then
             KodeBrows:=100408;
          Application.CreateForm(TFrBrows, FrBrows);
          FrBrows.IsiData:=Perkiraan8.Text;
          FrBrows.showmodal;
          if FrBrows.ModalResult=mrOk then
          begin
            with FrBrows.QuBrows do
            begin
              Perkiraan8.Text:=fieldbyname('Perkiraan').AsString;
            end;
          end else
            ActiveControl:=Perkiraan8;
        end else
        begin
          if DataBersyarat('select a.Perkiraan,b.keterangan from dbposthutpiut a '+
                       'left outer join dbperkiraan b on b.perkiraan=a.perkiraan '+
                       'where a.Kode='+QuotedStr(xHTPT)+' and a.Perkiraan=:0 order by a.Perkiraan',
             [Perkiraan8.Text],DM.QuCari)=true then
          begin
            with DM.QuCari do
            begin
              Perkiraan8.Text:=fieldbyname('Perkiraan').AsString;
            end;
          end else
          begin
            if (KodeReport=300301) or (KodeReport=300302) or (KodeReport=300303) or (KodeReport=300304) or (KodeReport=300305) then
               KodeBrows:=100409
            else if (KodeReport=300401) or (KodeReport=300402) or (KodeReport=300403) or (KodeReport=300404) or (KodeReport=300405) then
               KodeBrows:=100408;
            Application.CreateForm(TFrBrows, FrBrows);
            FrBrows.IsiData:=Perkiraan8.Text;
            FrBrows.showmodal;
            if FrBrows.ModalResult=mrOk then
            begin
              with FrBrows.QuBrows do
              begin
                Perkiraan8.Text:=fieldbyname('Perkiraan').AsString;
              end;
            end else
              ActiveControl:=Perkiraan8;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrReportPreview.Awal8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return Then
 begin
   if (length((Sender as TEdit).Text)=0)  then
   begin
     KodeBrows:=1014;
     Application.CreateForm(Tfrbrows, frbrows);
     FrBrows.IsiData:=(Sender as TEdit).Text;
     FrBrows.NoKira:=Perkiraan8.Text;
     frbrows.Showmodal;
     if FrBrows.ModalResult=mrOk then
     begin
       (Sender as TEdit).Text:=FrBrows.QuBrows.fieldbyname('KodeCustSupp').AsString;
       if (Sender as TEdit).Name='Awal8' then
           Akhir8.Text :=(Sender as TEdit).Text;
     end else
     begin
      if (Sender as TEdit).Enabled=true then
      ActiveControl:=(Sender as TEdit);
     end;
   end else
   begin
     if DataBersyarat('select KodeCustsupp, NamaCustSupp from dbCustSupp '+
       ' where KodeCustSupp=:0 and Perkiraan=:1 '+
       ' Order by KodeCustSupp ',[(Sender as TEdit).Text], DM.QuCari)=True then
     begin
       (Sender as TEdit).Text:=DM.QuCari.fieldbyname('KodeCustSupp').AsString;
       if (Sender as TEdit).Name='Awal8' then
           Akhir8.Text :=(Sender as TEdit).Text;
     end else
     begin
       KodeBrows:=1014;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=(Sender as TEdit).Text;
       FrBrows.NoKira:=Perkiraan8.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         (Sender as TEdit).Text:=FrBrows.QuBrows.fieldbyname('KodeCustSupp').AsString;
         if (Sender as TEdit).Name='Awal8' then
            Akhir8.Text :=(Sender as TEdit).Text;
       end else
       begin
        if (Sender as TEdit).Enabled=true then
        ActiveControl:=(Sender as TEdit);
       end;
     end;
   end;
 end;
end;

procedure TFrReportPreview.KodeVls8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return Then
 begin
   if (length(KodeVls8.Text)=0)  then
   begin
     KodeBrows:=1006;
     Application.CreateForm(Tfrbrows, frbrows);
     FrBrows.IsiData:=KodeVls8.Text;
     frbrows.Showmodal;
     if FrBrows.ModalResult=mrOk then
     begin
       KodeVls8.Text:=FrBrows.QuBrows.fieldbyname('KodeVls').AsString;
     end else
     begin
      if KodeVls8.Enabled=true then
      ActiveControl:=KodeVls8;
     end;
   end else
   begin
     if MyFindField('dbValas','KodeVls',KodeVls8.Text)=true then
     begin
       KodeVls8.Text:=DM.QuCari.fieldbyname('KodeVls').AsString;
     end else
     begin
       KodeBrows:=1006;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=KodeVls8.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         KodeVls8.Text:=FrBrows.QuBrows.fieldbyname('KodeVls').AsString;
       end else
       begin
         if KodeVls8.Enabled=true then
         ActiveControl:=KodeVls8;
       end;
     end;
   end;
 end;
end;

procedure TFrReportPreview.frxReport1ClickObject(Sender: TfrxView;
  Button: TMouseButton; Shift: TShiftState; var Modified: Boolean);
var xS, xS1, xS2, xDevisi: String;
    xTglAwal, xTglAkhir: TDateTime;
    xBulan, xTahun: Integer;
begin
  if (Button = mbLeft) then
  begin
    if (Sender.Name='Memo2') and (frxReport1.FileName=ExtractFilePath(Application.ExeName)+'ReportFiles\ReportNeracaLajur.fr3') then
    begin
      xS:=TrimRight(TfrxMemoView(Sender).Text);
      xS1:=xS;
      xS2:=xS;
      dxPageControl2.Pages[1].TabVisible:=True;
      dxPageControl2.Pages[1].Caption:=xS;
      case KodeReport of
        300501 :
          begin
            xBulan:=Bulan.AsInteger;
            xTahun:=Tahun.AsInteger;
            xTglAwal:=EncodeDate(Tahun.AsInteger, Bulan.AsInteger,1);
            xTglAwal:=IncDay(IncMonth(xTglAwal,1),-1);
          end;
      end;
    end;
    frxDBDataset1.DataSet.Close;
    with DM.QuCari do
    begin
      Close;
      SQL.Clear;
      SQL.Add('exec Sp_GenerateReportBukuTambahan :0,:1,:2,:3,:4,:5,:6,:7');
      Prepared;
      Parameters[0].Value:=xBulan;
      Parameters[1].Value:=xTahun;
      Parameters[2].Value:=xTglAwal;
      Parameters[3].Value:=xTglAkhir;
      Parameters[4].Value:=xS1;
      Parameters[5].Value:=xS2;
      Parameters[6].Value:='Y';
      Parameters[7].Value:=xDevisi;
      try
        ExecSQL;
      except
        ShowMessage('Generate Report Gagal !');
      end;
    end;
    with QuView do
    begin
      Close;
      SQL.Clear;
      SQL.Add('exec sp_ViewReportBukuTambahan :0,:1,:2,:3,:4,:5');
      Prepared;
      Parameters[0].Value:=xS1;
      Parameters[1].Value:=xS2;
      Parameters[2].Value:=xTglAwal;
      Parameters[3].Value:=xTglAkhir;
      Parameters[4].Value:=xDevisi;
      Parameters[5].Value:=IDUser;
      Open;
    end;
    frxDBDataset1.DataSet := Quview;
    frxDBDataset1.Close;
    frxDBDataset1.Open;
    QuView.RecordCount;
    with frxReport2 do
    begin
      Preview:=frxPreview2;
      LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBukuTambahan1a.fr3');
    end;
    frxReport2.ShowReport;
    dxPageControl2.ActivePageIndex:=1;
  end;
end;



procedure TFrReportPreview.Gudang10KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
begin
  if key=vk_return Then
 begin
   if (length(Gudang10.Text)=0)  then
   begin
     KodeBrows:=1001;
     Application.CreateForm(Tfrbrows, frbrows);
     FrBrows.IsiData:=Gudang10.Text;
     frbrows.Showmodal;
     if FrBrows.ModalResult=mrOk then
     begin
       Gudang10.Text:=FrBrows.QuBrows.fieldbyname('KODEGDG').AsString;
     end else
     begin
      if Gudang10.Enabled=true then
      ActiveControl:=Gudang10;
     end;
   end else
   begin
     if MyFindField('DBGUDANG','KODEGDG',Gudang10.Text)=true then
     begin
       Gudang10.Text:=DM.QuCari.fieldbyname('KODEGDG').AsString;
     end else
     begin
       KodeBrows:=1001;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=gudang10.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         gudang10.Text:=FrBrows.QuBrows.fieldbyname('KODEGDG').AsString;
       end else
       begin
         if gudang10.Enabled=true then
         ActiveControl:=gudang10;
       end;
     end;
   end;
 end;

end;
end;


procedure TFrReportPreview.Button3Click(Sender: TObject);
var i : integer;
begin
  case KodeReport of
      51709, 52915, 53515, 53520, 54115 : //,51709,51715,51720,51725,51730
      begin
        if button3.Caption = 'Per No Bukti' then
        begin
            case kodereport of
             51709:
               begin
               Application.CreateForm(TFrBrows, FrBrows);
               KodeBrows:=30073  ;
               FrBrows.TglAwal:=TglAwal9.Date;
               FrBrows.TglAkhir:=TglAkhir9.Date;
               FrBrows.ShowModal;
               end;
             52915 :
               begin
               Application.CreateForm(TFrBrows, FrBrows);
               KodeBrows:=30076  ;
               FrBrows.TglAwal:=TglAwal9.Date;
               FrBrows.TglAkhir:=TglAkhir9.Date;
               FrBrows.ShowModal;
               end;
             53515 :
               begin
               Application.CreateForm(TFrBrows, FrBrows);
               KodeBrows:=30077  ;
               FrBrows.TglAwal:=TglAwal9.Date;
               FrBrows.TglAkhir:=TglAkhir9.Date;
               FrBrows.ShowModal;
               end;
             53520 :
               begin
               Application.CreateForm(TFrBrows, FrBrows);
               KodeBrows:=30078;
               FrBrows.TglAwal:=TglAwal9.Date;
               FrBrows.TglAkhir:=TglAkhir9.Date;
               FrBrows.ShowModal;
               end;
             54115 :
               Begin
               Application.CreateForm(TFrBrows, FrBrows);
               KodeBrows:=30079;
               FrBrows.TglAwal:=TglAwal9.Date;
               FrBrows.TglAkhir:=TglAkhir9.Date;
               FrBrows.ShowModal;
               end;
            end;
        SelectedSemuaRecord:=false;
        but:=3;
        end;
      end;
  end;
  if (assigned(frbrows)) and (FrBrows.ModalResult=mrOk) then
  begin
     SelectedSemuaRecord:=FrBrows.SelectAllRecord;
     xList := TList.Create;
     ListBox1.Clear;
     for i:= 0 to FrBrows.GridBrows.SelectedCount - 1 do
      xList.Add(FrBrows.GridBrows.SelectedNodes[i]);
      xList.Sort(@CompareByAbsoluteIndex);
     if not FrBrows.QuBrows.IsEmpty then
       begin
          for i:= 0 to FrBrows.GridBrows.SelectedCount - 1 do
           begin
             case KodeBrows of
             30073 :
             ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('NoBukti').Index]);
             30076 :
             ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('NoBukti').Index]);
             30077 :
             ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('NoBukti').Index]);
             30078 :
             ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('NoBukti').Index]);
             30079 :
             ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('NoBukti').Index]);
             end;
          end;
       end
       else
         ListBox1.Items.add('');
         xList.Free;
         selectreport;
  end
  else
    ListBox1.Items.add('');
  //end;

end;


procedure TFrReportPreview.Button5Click(Sender: TObject);
var i : integer;
begin
        if button5.caption = 'Per Bagian' then
         begin
          Application.CreateForm(TFrBrows, FrBrows);
          KodeBrows:=1002;
          FrBrows.TglAwal:=TglAwal9.Date;
          FrBrows.TglAkhir:=TglAkhir9.Date;
          FrBrows.ShowModal;
          but:=5;
         end;
        if button5.caption = 'Per Supplier' then
         begin
          Application.CreateForm(TFrBrows, FrBrows);
          KodeBrows:=30074;
          FrBrows.TglAwal:=TglAwal9.Date;
          FrBrows.TglAkhir:=TglAkhir9.Date;
          FrBrows.ShowModal;
          but:=5;
         end;

         if (assigned(frbrows)) and (FrBrows.ModalResult=mrOk) then
         begin
         SelectedSemuaRecord:=FrBrows.SelectAllRecord;
         xList := TList.Create;
         ListBox1.Clear;
    for i:= 0 to FrBrows.GridBrows.SelectedCount - 1 do
      xList.Add(FrBrows.GridBrows.SelectedNodes[i]);
    xList.Sort(@CompareByAbsoluteIndex);
    if not FrBrows.QuBrows.IsEmpty then
    begin
    for i:= 0 to FrBrows.GridBrows.SelectedCount - 1 do
    begin
      case KodeBrows of
        1002 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeBag').Index]);
        30074:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeCustSupp').Index]);

      end;
    end;
    end
    else
      ListBox1.Items.add('');
    xList.Free;
    selectreport;
  end
  else
    ListBox1.Items.add('');



end;

procedure TFrReportPreview.Button4Click(Sender: TObject);
var i : integer;
begin
        if button4.Caption = 'Per Barang' then
         begin
          Application.CreateForm(TFrBrows, FrBrows);
          KodeBrows:=30075;
          FrBrows.TglAwal:=TglAwal9.Date;
          FrBrows.TglAkhir:=TglAkhir9.Date;
          FrBrows.ShowModal;
          SelectedSemuaRecord := false;
          but:=4
         end;

  if (assigned(frbrows)) and (FrBrows.ModalResult=mrOk) then
   begin
         SelectedSemuaRecord:=FrBrows.SelectAllRecord;
         xList := TList.Create;
         ListBox1.Clear;
    for i:= 0 to FrBrows.GridBrows.SelectedCount - 1 do
      xList.Add(FrBrows.GridBrows.SelectedNodes[i]);
    xList.Sort(@CompareByAbsoluteIndex);
    if not FrBrows.QuBrows.IsEmpty then
    begin
    for i:= 0 to FrBrows.GridBrows.SelectedCount - 1 do
    begin
      case KodeBrows of
        30075 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeBrg').Index]);
      end;
    end;
    end
    else
      ListBox1.Items.add('');
    xList.Free;
    selectreport;
  end
  else
    ListBox1.Items.add('');


end;

procedure TFrReportPreview.KodeBrg11KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then
  begin
    if (KodeReport=866) or (KodeReport=867) then
    begin
      if DataBersyarat('select isnull(Grup,'''') Grup from dbBarang where Grup=:0 and isnull(Grup,'''')<>'''' ',[KodeBrg11.Text],DM.QuCari)=True then
      begin
        KodeBrg11.Text:=DM.QuCari.FieldByName('Grup').AsString;
      end else
      begin
        KodeBrows:=30012;
        Application.CreateForm(TFrBrows, FrBrows);
        FrBrows.IsiData:=KodeBrg11.Text;
        FrBrows.ShowModal;
        if (FrBrows.ModalResult=mrOk) and (FrBrows.QuBrows.FieldByName('Grup').AsString<>'') then
          KodeBrg11.Text:=FrBrows.QuBrows.FieldByName('Grup').AsString
        else ActiveControl:=KodeBrg11;
      end;
    end;
  
    if KodeReport=870 then
    begin
      if DataBersyarat('select KodeBrg from dbBarang where KodeBrg=:0 and KodeBrg<>'''' ',[KodeBrg11.Text],DM.QuCari)=True then
      begin
        KodeBrg11.Text:=DM.QuCari.FieldByName('KodeBrg').AsString;
      end else
      begin
        KodeBrows:=30011;
        Application.CreateForm(TFrBrows, FrBrows);
        FrBrows.IsiData:=KodeBrg11.Text;
        FrBrows.ShowModal;
        if (FrBrows.ModalResult=mrOk) and (FrBrows.QuBrows.FieldByName('KodeBrg').AsString<>'') then
          KodeBrg11.Text:=FrBrows.QuBrows.FieldByName('KodeBrg').AsString
        else ActiveControl:=KodeBrg11;
      end;
    end;
  end;
end;

end.


                                                                       `
