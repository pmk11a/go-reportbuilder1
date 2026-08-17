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
  dxExEdtr, dxEdLib, DBCtrls, dxmdaset, dxPageControl, frxChBox;

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
    cbTipe13: TComboBox;
    Label36: TLabel;
    rgJenis13: TRadioGroup;
    dxTabSheet12: TdxTabSheet;
    GroupBox4: TGroupBox;
    Label38: TLabel;
    Label39: TLabel;
    TglAwal13: TDateEdit;
    TglAkhir13: TDateEdit;
    frxDBDataset6: TfrxDBDataset;
    ADOidr: TADOQuery;
    QuMenuRep6: TADOQuery;
    dsMenuRep6: TDataSource;
    QuMenuRep7: TADOQuery;
    dsMenuRep7: TDataSource;
    Label41: TLabel;
    kodeKelompok10: TEdit;
    Label42: TLabel;
    KodeKategori10: TEdit;
    Label43: TLabel;
    kodeSubKategori10: TEdit;
    Label44: TLabel;
    kodeJenis10: TEdit;
    Label45: TLabel;
    KodeSubJenis10: TEdit;
    Label46: TLabel;
    Persediaan10: TComboBox;
    Label47: TLabel;
    Tampil10: TComboBox;
    Label48: TLabel;
    cbPembayaran13: TComboBox;
    cbPPn13: TComboBox;
    Label49: TLabel;
    Splitter2: TSplitter;
    Panel7: TPanel;
    Panel8: TPanel;
    dxTabSheet13: TdxTabSheet;
    GroupBox5: TGroupBox;
    Label53: TLabel;
    Label54: TLabel;
    TglAwal14: TDateEdit;
    TglAkhir14: TDateEdit;
    Label40: TLabel;
    JenisPakai14: TComboBox;
    Label55: TLabel;
    Persediaan11: TComboBox;
    Label56: TLabel;
    KodeKelompok11: TEdit;
    Label57: TLabel;
    KodeKategori11: TEdit;
    Label58: TLabel;
    KodeSubKategori11: TEdit;
    Label59: TLabel;
    KodeJenis11: TEdit;
    Label60: TLabel;
    KodeSubJenis11: TEdit;
    Label61: TLabel;
    Gudang11: TEdit;
    Label50: TLabel;
    Lokasi: TComboBox;
    dxTabSheet14: TdxTabSheet;
    Label63: TLabel;
    Devisi13: TEdit;
    Label62: TLabel;
    Perkiraan12: TEdit;
    Perkiraan13: TEdit;
    Label52: TLabel;
    Label51: TLabel;
    PilihRp13: TEdit;
    grpPeriode2a: TGroupBox;
    Label65: TLabel;
    Bulan3: TPBNumEdit;
    Tahun3: TPBNumEdit;
    Label64: TLabel;
    Jurnal13: TEdit;
    NamaPerkiraan12: TLabel;
    NamaPerkiraan13: TLabel;
    dxTabSheet15: TdxTabSheet;
    Label66: TLabel;
    Tahun1: TPBNumEdit;
    Label67: TLabel;
    Counter: TComboBox;
    GroupBox6: TGroupBox;
    Label68: TLabel;
    Label69: TLabel;
    Perkiraan4: TEdit;
    Perkiraan5: TEdit;
    Label70: TLabel;
    Divisi4: TEdit;
    NamaDivisi4: TEdit;
    NamaPerkiraan4: TLabel;
    NamaPerkiraan5: TLabel;
    dxTabSheet16: TdxTabSheet;
    GroupBox7: TGroupBox;
    Label71: TLabel;
    Label72: TLabel;
    Awal15: TDateEdit;
    Akhir15: TDateEdit;
    GroupBox8: TGroupBox;
    KodeTipe15: TEdit;
    Label73: TLabel;
    Label74: TLabel;
    KodeSubTipe15: TEdit;
    dxTabSheet17: TdxTabSheet;
    Label75: TLabel;
    Label76: TLabel;
    tahun16: TPBNumEdit;
    bulan16: TPBNumEdit;
    GroupBox9: TGroupBox;
    Label77: TLabel;
    Cbojns: TComboBox;
    dxTabSheet18: TdxTabSheet;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Bulan17: TPBNumEdit;
    Tahun17: TPBNumEdit;
    KodeGdg17: TEdit;
    Nosat: TPBNumEdit;
    IsStockMinus17: TCheckBox;
    dxTabSheet19: TdxTabSheet;
    Label82: TLabel;
    LabelNoSat7: TLabel;
    Label83: TLabel;
    KodeGdg18: TEdit;
    NoSat18: TPBNumEdit;
    StockMinus18: TCheckBox;
    Tgl18: TDateEdit;
    dxTabSheet20: TdxTabSheet;
    Label84: TLabel;
    Tgl19: TDateEdit;
    KodeGdg19: TEdit;
    Label85: TLabel;
    dxTabSheet21: TdxTabSheet;
    Label86: TLabel;
    GroupBox10: TGroupBox;
    Label87: TLabel;
    Label88: TLabel;
    awal20: TDateEdit;
    akhir20: TDateEdit;
    KodeGdg20: TEdit;
    Label90: TLabel;
    NoSat20: TPBNumEdit;
    StockMinus20: TCheckBox;
    dxTabSheet22: TdxTabSheet;
    GroupBox11: TGroupBox;
    Label89: TLabel;
    blnawal21: TComboBox;
    thnawal21: TPBNumEdit;
    Label92: TLabel;
    KodeGdg21: TEdit;
    KodeBrg21: TEdit;
    Label93: TLabel;
    NoSat21: TPBNumEdit;
    Label94: TLabel;
    Label91: TLabel;
    Label95: TLabel;
    blnakhir21: TComboBox;
    thnakhir21: TPBNumEdit;
    Label96: TLabel;
    CboLokasi: TComboBox;
    lblLokasi: TLabel;
    dxTabSheet23: TdxTabSheet;
    Tahun22: TPBNumEdit;
    Label97: TLabel;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    PanelOto: TPanel;
    CboOto: TComboBox;
    Label98: TLabel;
    Cbotampil: TComboBox;
    Label99: TLabel;
    Group17: TEdit;
    Label100: TLabel;
    dxTabSheet24: TdxTabSheet;
    sls: TPBNumEdit;
    Label101: TLabel;
    CBODet7: TComboBox;
    GroupBox12: TGroupBox;
    Label102: TLabel;
    Label103: TLabel;
    Awal23: TDateEdit;
    Akhir23: TDateEdit;
    Tipe23: TComboBox;
    Label104: TLabel;
    HPP: TCheckBox;
    GroupBox13: TGroupBox;
    Label105: TLabel;
    ComboBox1: TComboBox;
    dxTabSheet25: TdxTabSheet;
    Label106: TLabel;
    BulanA: TPBNumEdit;
    Label107: TLabel;
    TahunA: TPBNumEdit;
    Label108: TLabel;
    BulanB: TPBNumEdit;
    Label109: TLabel;
    TahunB: TPBNumEdit;
    Label110: TLabel;
    Divisi2: TEdit;
    SpPrsCF: TADOStoredProc;
    IsHHPminus: TCheckBox;
    Bulan8: TPBNumEdit;
    Tahun8: TPBNumEdit;
    CBR: TCheckBox;
    procedure GetMenuLevel1;
    procedure GetMenuLevel2(KdParent:string);
    procedure GetMenuLevel3(KdParent:string);
    procedure GetMenuLevel4(KdParent:string);
    procedure GetMenuLevel5(KdParent:string);
    procedure GetMenuLevel6(KdParent:string);
    procedure GetMenuLevel7(KdParent:string);
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
    procedure frxReport1ProgressStart(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    procedure frxReport1ProgressStop(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    procedure JenisPakai14DropDown(Sender: TObject);
    procedure Persediaan10DropDown(Sender: TObject);
    procedure Persediaan11DropDown(Sender: TObject);
    procedure Devisi13KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Perkiraan12KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Perkiraan13KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Perkiraan4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Perkiraan5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Divisi4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KodeTipe15KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KodeSubTipe15KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CbojnsChange(Sender: TObject);
    procedure KodeGdg17KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KodeGdg18KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KodeGdg19KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KodeGdg20KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KodeGdg21KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KodeBrg21KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Group17KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Divisi2KeyDown(Sender: TObject; var Key: Word;
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
    mKodeReport_: Integer;
    procedure IsiDariListBox1(var pQuery: TADOQuery);
    function  TglStr(aw,ak:tdatetime): string;
    procedure TampilIsiGudang(Sender: TEdit);
    procedure TampilIsiBarang(Sender: TEdit; pTipeBrg: String);
    procedure TampilIsiKasBank;
    procedure TampilIsiKode(Sender:TEdit; NamaTabel,NamaKolom,Syarat:String; xKodebrows:Integer);
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
  MyTreeNode1, MyTreeNode2, MyTreeNode3, MyTreeNode4, MyTreeNode5, MyTreeNode6, MyTreeNode7 : TfcTreeNode;
  mTipe,mPPn,mTipeRPJ : String;
  xKodebonus :string;
  ttgl,TglAwal, TglAkhir:TDateTime;

implementation

uses Printers, frxPrinter, frxSearchDialog, frxUtils, frxRes, frxDsgnIntf,
  frxPreviewPageSettings, frxDMPClass, myGlobal, MyProcedure, MyModul, FrmBrows;

{$R *.dfm}

procedure TFrReportPreview.TampilIsiKode(Sender:TEdit; NamaTabel,NamaKolom,Syarat:String; xKodebrows:Integer);
begin
  KodeBrows:=xKodebrows;
  Application.CreateForm(TFrBrows, FrBrows);
  FrBrows.IsiData:=(Sender as TEdit).Text;
  FrBrows.showmodal;
  if FrBrows.ModalResult=mrOk then
  begin
    (Sender as TEdit).Text:=FrBrows.QuBrows.fieldbyname(NamaKolom).AsString;
  end
  else
    ActiveControl:=Sender;
end;

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
      sql.add('select A.UserID,b.L0, a.L1, b.Keterangan NmReport, b.ACCESS KodeReport, a.Access, a.IsDesign, a.Isexport ');
      sql.add('from dbflmenureport a ');
      sql.add('     left outer join DBMENUREPORT b on b.KODEMENU=a.L1');
      sql.add('where a.userid='+quotedstr(iduser)+' and a.access=1 and b.L0=1 ');//+' and a.access=1 and a.L0=1 '
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
      sql.add('select A.UserID,b.L0, a.L1, b.Keterangan NmReport, b.ACCESS KodeReport, a.Access, a.IsDesign, a.Isexport ');
      sql.add('from dbflmenureport a ');
      sql.add('     left outer join DBMENUREPORT b on b.KODEMENU=a.L1');
      sql.add('where a.userid='+quotedstr(iduser)+' and a.access=1 and B.l0=2 ');
      sql.add('and a.l1 like '+#39+KdParent+#37+#39);
      sql.add('order by a.l1 ');
      open;
   end;
end;

procedure TFrReportPreview.GetMenuLevel3(KdParent:string);
begin
   with qumenurep3 do
   begin
      close;
      sql.clear;
      sql.add('select A.UserID,b.L0, a.L1, b.Keterangan NmReport, b.ACCESS KodeReport, a.Access, a.IsDesign, a.Isexport ');
      sql.add('from dbflmenureport a ');
      sql.add('     left outer join DBMENUREPORT b on b.KODEMENU=a.L1');
      sql.add('where a.userid='+quotedstr(iduser)+' and a.access=1 and B.l0=3 ');
      sql.add('and a.l1 like '+#39+KdParent+#37+#39);
      sql.add('order by a.l1 ');
      open;
   end;
end;

procedure TFrReportPreview.GetMenuLevel4(KdParent:string);
begin
   with qumenurep4 do
   begin
      close;
      sql.clear;
      sql.add('select A.UserID,b.L0, a.L1, b.Keterangan NmReport, b.ACCESS KodeReport, a.Access, a.IsDesign, a.Isexport ');
      sql.add('from dbflmenureport a ');
      sql.add('     left outer join DBMENUREPORT b on b.KODEMENU=a.L1');
      sql.add('where a.userid='+quotedstr(iduser)+' and a.access=1 and B.l0=4 ');
      sql.add('and a.l1 like '+#39+KdParent+#37+#39);
      sql.add('order by a.l1 ');
      open;
   end;
end;

procedure TFrReportPreview.GetMenuLevel5(KdParent:string);
begin
   with qumenurep5 do
   begin
      close;
      sql.clear;
      sql.add('select A.UserID,b.L0, a.L1, b.Keterangan NmReport, b.ACCESS KodeReport, a.Access, a.IsDesign, a.Isexport ');
      sql.add('from dbflmenureport a ');
      sql.add('     left outer join DBMENUREPORT b on b.KODEMENU=a.L1');
      sql.add('where a.userid='+quotedstr(iduser)+' and a.access=1 and B.l0=5 ');
      sql.add('and a.l1 like '+#39+KdParent+#37+#39);
      sql.add('order by a.l1 ');
      open;
   end;
end;

procedure TFrReportPreview.GetMenuLevel6(KdParent:string);
begin
   with qumenurep5 do
   begin
      close;
      sql.clear;
      sql.add('select A.UserID,b.L0, a.L1, b.Keterangan NmReport, b.ACCESS KodeReport, a.Access, a.IsDesign, a.Isexport ');
      sql.add('from dbflmenureport a ');
      sql.add('     left outer join DBMENUREPORT b on b.KODEMENU=a.L1');
      sql.add('where a.userid='+quotedstr(iduser)+' and a.access=1 and b.l0=6 ');
      sql.add('and a.l1 like '+#39+KdParent+#37+#39);
      sql.add('order by a.l1 ');
      open;
   end;
end;

procedure TFrReportPreview.GetMenuLevel7(KdParent:string);
begin
   with qumenurep5 do
   begin
      close;
      sql.clear;
      sql.add('select A.UserID,b.L0, a.L1, b.Keterangan NmReport, b.ACCESS KodeReport, a.Access, a.IsDesign, a.Isexport ');
      sql.add('from dbflmenureport a ');
      sql.add('     left outer join DBMENUREPORT b on b.KODEMENU=a.L1');
      sql.add('where a.userid='+quotedstr(iduser)+' and a.access=1 and B.l0=7 ');
      sql.add('and a.l1 like '+#39+KdParent+#37+#39);
      sql.add('order by a.l1 ');
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
   Splitter2.Visible:=False;
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
//  if panel5.height>=348 then
//     heightPanel := panel5.height
//  else
//     heightPanel := 348;
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
   DataBersyarat('select * from vwPerusahaan where 1=:0',[1],QuPerusahaan);
   //mNamaKlien:=DM.QuCari.FieldByName('Nama').AsString;
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
         MyTreeNode2 := fctreeview1.Items.AddChild(mytreenode1,' '+qumenurep2.Fieldbyname('nmreport').AsString+' ');
         MyTreeNode2.StringData := qumenurep2.Fieldbyname('access').AsString;
         MyTreeNode2.StringData2 := inttostr(qumenurep2.Fieldbyname('kodereport').Asinteger);

         GetMenuLevel3(qumenurep2.fieldbyname('l1').asstring);
         QuMenuRep3.First;
         while not(QuMenuRep3.Eof) do
         begin
            MyTreeNode3 := fctreeview1.Items.AddChild(mytreenode2, ' '+qumenurep3.Fieldbyname('nmreport').AsString+' ');
            MyTreeNode3.StringData := qumenurep3.Fieldbyname('access').AsString;
            MyTreeNode3.StringData2 := inttostr(qumenurep3.Fieldbyname('kodereport').Asinteger);
            GetMenuLevel4(qumenurep3.fieldbyname('l1').asstring);
            QuMenuRep4.First;
            while not(qumenurep4.Eof) do
            begin
               MyTreeNode4 := fctreeview1.Items.AddChild(mytreenode3, ' '+qumenurep4.Fieldbyname('nmreport').AsString+' ');
               MyTreeNode4.StringData := qumenurep4.Fieldbyname('access').AsString;
               MyTreeNode4.StringData2 := inttostr(qumenurep4.Fieldbyname('kodereport').Asinteger);
               GetMenuLevel5(qumenurep4.fieldbyname('l1').asstring);
               QuMenuRep5.First;
               while not(qumenurep5.Eof) do
               begin
                  MyTreeNode5 := fctreeview1.Items.AddChild(mytreenode4, ' '+qumenurep5.Fieldbyname('nmreport').AsString+' ');
                  MyTreeNode5.StringData := qumenurep5.Fieldbyname('access').AsString;
                  MyTreeNode5.StringData2 := inttostr(qumenurep5.Fieldbyname('kodereport').Asinteger);
                  GetMenuLevel6(qumenurep5.fieldbyname('l1').asstring);
                  QuMenuRep6.First;
                  while not(qumenurep6.Eof) do
                  begin
                    MyTreeNode6 := fctreeview1.Items.AddChild(mytreenode5, ' '+qumenurep6.Fieldbyname('nmreport').AsString+' ');
                    MyTreeNode6.StringData := qumenurep6.Fieldbyname('access').AsString;
                    MyTreeNode6.StringData2 := inttostr(qumenurep6.Fieldbyname('kodereport').Asinteger);
                    QuMenuRep6.Next;
                    GetMenuLevel7(qumenurep6.fieldbyname('l1').asstring);
                    QuMenuRep7.First;
                    while not(qumenurep7.Eof) do
                    begin
                      MyTreeNode7 := fctreeview1.Items.AddChild(mytreenode6, ' '+qumenurep7.Fieldbyname('nmreport').AsString+' ');
                      MyTreeNode7.StringData := qumenurep7.Fieldbyname('access').AsString;
                      MyTreeNode7.StringData2 := inttostr(qumenurep7.Fieldbyname('kodereport').Asinteger);
                      QuMenuRep7.Next;
                    end;
                  end;
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
  HPP.Visible:=False;
  if TreeView.GetNodeAt(x,y)<>nil then
  begin
    if not(Node.HasChildren) then
    begin
      KodeReport := 0;
      KodeReport:=StrToInt(Node.StringData2);
      Panel5.visible:=True;
      Splitter2.Visible:=true;
      Button2.Visible:=true;
      {combobox1.Clear;
      combobox1.Items.Add('lokal');
      combobox1.Items.add('Import');
      combobox1.Items.add('Semua');
      Combobox1.ItemIndex:=0;}
      GroupBox3.Visible :=True;
      Label36.Visible := True;
      //ComboBox1.Visible := True;
      //RadioGroup1.Visible := True;
      Label10.Visible := True;
      Devisi2.Visible := True;
      Label15.Visible := True;
      Devisi4.Visible := True;
      Lokasi.Visible := False;
      Label50.Visible := False;
      lPerkiraan.Caption := 'Perkiraan';
      Label3.Visible := True;
      Awal.Visible := True;
      Label4.Caption :=' Akhir ';
      GroupBox8.Visible:=False;
      GroupBox9.Visible:=False;
      Cbojns.ItemIndex:=0;
      CboLokasi.visible:=false;
      Label38.Visible:=True;
      Label39.Visible:=True;
      TglAwal13.Visible:=True;
      TglAkhir13.Visible:=True;
      PanelOto.visible:=False;
      Cbotampil.Visible:=false;
      Group17.Visible:=False;
      Label100.Visible:=False;
      Sls.Visible:=False;
      CBODet7.Visible:=False;
      Tipe23.Visible:=False;
      ////
      Valas8.Visible:=True;
      Label24.Visible:=True;
      Devisi8.Visible:=True;
      label25.Visible:=True;
      Perkiraan8.Visible:=True;
      gbCustSupp8.Visible:=True;
      Urut8.Visible:=True;
      CboOto.Visible:=True;
      Label98.Visible:=True;
      GroupBox13.Visible:=False;
      Bulan8.Visible:=False;
      Tahun8.Visible:=False;
      TglAwal8.Visible:=True;
      TglAkhir8.Visible:=True;
      Urut8.Visible:=True;
      CBR.Visible:=False;
      ////

      case KodeReport of
          101 : ShowReportPreview(' Daftar Perkiraan ',-1);
        10101 : ShowReportPreview(' Daftar Aktiva ',-1);
          102 : ShowReportPreview(' Daftar Neraca ',-1);
          103 : ShowReportPreview(' Daftar Laba Rugi ',-1);
          104 : ShowReportPreview(' Daftar HPP ',-1);
          106 : BEGIN
                ShowReportPreview(' Laporan Mutasi Keuagan',24);
                BulanA.Value:=StrToInt(PeriodBln);
                TahunA.Value:=StrToInt(PeriodThn);
                BulanB.Value:=StrToInt(PeriodBln);
                TahunB.Value:=StrToInt(PeriodThn);
                eND;
         1101 : ShowReportPreview(' Daftar Gudang',-1);
         1102 : ShowReportPreview(' Daftar Mesin',-1);
         1103 : ShowReportPreview(' Daftar Post Biaya',-1);
         1104,1200 : ShowReportPreview(' Daftar Kelompok Barang',-1);
         1105 : ShowReportPreview(' Daftar Kategori Barang',-1);
         1106 : ShowReportPreview(' Daftar Sub Kategori Barang',-1);
         1107 : ShowReportPreview(' Daftar Jenis Barang',-1);
         1108 : ShowReportPreview(' Daftar Sub Jenis Barang',-1);
         1109 : ShowReportPreview(' Daftar Bahan Baku dan Pembantu',-1);
         1110 : ShowReportPreview(' Daftar Supplier',-1);
         1201 : ShowReportPreview(' Daftar Kategori Barang Jadi',-1);
         1202 : ShowReportPreview(' Daftar Sub Kategori Barang Jadi',-1);
         1203 : ShowReportPreview(' Daftar Jenis Barang Jadi',-1);
         1204 : ShowReportPreview(' Daftar Sub Jenis Barang Jadi',-1);
         1205 : ShowReportPreview(' Daftar Barang Jadi',-1);
         1298 : ShowReportPreview(' Daftar Customer',-1);
         1300 : ShowReportPreview(' Daftar Bagian',-1);
         1301 : ShowReportPreview(' Daftar Jabatan',-1);
         1304 : Begin
                  ShowReportPreview(' Daftar Valas',2);
                  Label10.Visible := False;
                  Devisi2.Visible := False;
                end;
         // 201 :
       20101 : begin
                  ShowReportPreview(' Laporan Kas Harian',0);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Divisi.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Divisi.Enabled:=DM.QuCari.RecordCount>1;
                  Perkiraan.Text:='';
                  if Divisi.CanFocus then
                    ActiveControl:=Divisi
                  else ActiveControl:=Perkiraan;
                end;
       {20102 : begin
                  ShowReportPreview(' Rekap Kas dan Bank Harian',0);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Divisi.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Divisi.Enabled:=DM.QuCari.RecordCount>1;
                end;}
       20102 : begin
                  ShowReportPreview(' Laporan Bank Harian',0);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Divisi.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Divisi.Enabled:=DM.QuCari.RecordCount>1;
                  Perkiraan.Text:='';
                  Lokasi.Visible := True;
                  Label50.Visible := True;
                  if Divisi.CanFocus then
                    ActiveControl:=Divisi
                  else ActiveControl:=Perkiraan;
                  Lokasi.Visible:=False;
               end;


       20103 : begin
                 ShowReportPreview(' Posisi Bank, Kas & Piutang',6);
                 //TabSheet7.Caption:='Posisi Bank, Kas & Piutang';
                 Tanggal7.Date:=Now;
                 DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                 Devisi7.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                 Devisi7.Enabled:=DM.QuCari.RecordCount>1;
               end;
       201061, 201062, 201063, 201064, 201071, 201072, 201073, 201074, 201075, 201081, 201082, 201083, 201084, 201085 :
               Begin
                 Case KodeReport of
                    201071, 201072, 201073, 201074, 201075 : lPerkiraan.Caption := 'Kas';
                    else lPerkiraan.Caption := 'Perkiraan';
                 end;
                 Case KodeReport of
                   201074,201084 : begin
                              Label3.Visible := false;
                              Awal.Visible := false;
                              Label4.Caption :=' S.D ';
                   end;
                   else begin
                      Label3.Visible := True;
                      Awal.Visible := true;
                      Label4.Caption :=' Akhir ';
                   end;
                 end;
                 Case KodeReport of
                   201061, 201062, 201063, 201064 : ShowReportPreview(' Laporan Deposito ',0);
                   201071 : ShowReportPreview(' Laporan Terima Giro Jatuh Tempo ',0);
                   201072 : ShowReportPreview(' Laporan Terima Giro dicairkan',0);
                   201073 : ShowReportPreview(' Laporan Penerimaan Giro ',0);
                   201074 : ShowReportPreview(' Laporan Terima Giro Outstanding',0);
                   201075 : ShowReportPreview(' Laporan Register Terima Giro ',0);
                   201081 : ShowReportPreview(' Laporan Buka Giro Jatuh Tempo',0);
                   201082 : ShowReportPreview(' Laporan Buka Giro dicairkan',0);
                   201083 : ShowReportPreview(' Laporan Pembukaan Giro ',0);
                   201084 : ShowReportPreview(' Laporan Buka Giro Outstanding',0);
                   201085 : ShowReportPreview(' Laporan Register Buka Giro ',0);
                 end;
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Divisi.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Divisi.Enabled:=DM.QuCari.RecordCount>1;
                  Perkiraan.Text:='';
                  if Divisi.CanFocus then
                    ActiveControl:=Divisi
                  else ActiveControl:=Perkiraan;
                  case kodereport of
                    201071..201074:Cbolokasi.Visible :=True;
                  end; 
               End;

       20109 : begin
                  ShowReportPreview(' Laporan Bon Sementara ',0);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Divisi.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Divisi.Enabled:=DM.QuCari.RecordCount>1;
                  Perkiraan.Text:='';
                  if Divisi.CanFocus then
                    ActiveControl:=Divisi
                  else ActiveControl:=Perkiraan;
               end;
       2020101,2020102,2020103,2020104,2020105,2020106,2020107,2020108,2020109  :
                begin
                  case KodeReport of
                    2020101 : ShowReportPreview(' Jurnal Penerimaan Kas',3);
                    2020102 : ShowReportPreview(' Jurnal Pengeluaran Kas',3);
                    2020103 : ShowReportPreview(' Jurnal Penerimaan Bank',3);
                    2020104 : ShowReportPreview(' Jurnal Pengeluaran Bank',3);
                    2020105 : ShowReportPreview(' Jurnal Memorial',3);
                    2020106 : ShowReportPreview(' Jurnal Koreksi',3);
                    2020107 : ShowReportPreview(' Jurnal Pembelian',3);
                    2020108 : ShowReportPreview(' Jurnal Penjualan',3);
                    2020109 : ShowReportPreview(' Jurnal Penutup',3);
                  end;
                  TglAwal4.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                  TglAkhir4.Date := incday(incmonth(TglAwal4.Date,1),-1);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi4.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi4.Enabled:=DM.QuCari.RecordCount>1;
                end;

       20202 : begin
                  ShowReportPreview(' Buku Tambahan ',13);
                  Bulan3.Value:=StrToInt(PeriodBln);
                  Tahun3.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi13.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi13.Enabled:=DM.QuCari.RecordCount>1;
                end;
       202021 : begin
                  ShowReportPreview(' Buku Tambahan Baru',1);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi3.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi3.Enabled:=DM.QuCari.RecordCount>1;
                end;
       20203 : begin
                  ShowReportPreview(' Mutasi',4);
                  Bulan5.Value:=StrToInt(PeriodBln);
                  Tahun5.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi5.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi5.Enabled:=DM.QuCari.RecordCount>1;
                end;
       20204 : begin
                  ShowReportPreview(' Laporan Biaya',5);
                  //TabSheet6.Caption:='Laporan Biaya';
                  Bulan6.Value:=StrToInt(PeriodBln);
                  Tahun6.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi6.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi6.Enabled:=DM.QuCari.RecordCount>1;
                end;
       202041: begin
              DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Divisi4.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Divisi4.Enabled:=DM.QuCari.RecordCount>1;
              Tahun1.Value:=StrToInt(PeriodThn);
              ShowReportPreview('Biaya Satu Tahun',14);
              label67.caption:='Cetak';
              Counter.Clear;
              Counter.Items.Add('Tahunan');
              Counter.Items.Add('Bulanan');
              Counter.Visible:=True;
             tahun1.Left :=64;
           end;         
       20205 : begin
                  ShowReportPreview(' Laporan Aktiva',4);
                  //TabSheet5.Caption:='Laporan Aktiva';
                  Bulan5.Value:=StrToInt(PeriodBln);
                  Tahun5.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi5.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi5.Enabled:=DM.QuCari.RecordCount>1;
                end;
       20206 : begin
                  ShowReportPreview(' Laporan Biaya Penyusutan',4);
                  //TabSheet5.Caption:='Laporan Biaya Penyusutan';
                  Bulan5.Value:=StrToInt(PeriodBln);
                  Tahun5.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi5.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi5.Enabled:=DM.QuCari.RecordCount>1;
                end;
       20301,20302,20303,20304,20305 :
                begin
                  case KodeReport of
                    20301 : ShowReportPreview(' Kartu Hutang',7);
                    20302 : ShowReportPreview(' Sisa Hutang',7);
                    20303 : ShowReportPreview(' Pelunasan Hutang',7);
                    20304 : ShowReportPreview(' Saldo Hutang',7);
                    20305 : ShowReportPreview(' Umur Hutang',7);
                  end;
                  TglAwal8.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                  TglAkhir8.Date := incday(incmonth(TglAwal8.Date,1),-1);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi8.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi8.Enabled:=DM.QuCari.RecordCount>1;
                  case KodeReport of
                    20301, 20303, 20304 :
                      begin
                        gbPeriode8.Caption:='Periode';
                        LblTglAwal8.Visible:=True;
                        LblTglAkhir8.Visible:=True;
                        TglAwal8.Visible:=True;
                      end;
                    20302, 20305 :
                      begin
                        gbPeriode8.Caption:='s/d Tanggal';
                        LblTglAwal8.Visible:=False;
                        LblTglAkhir8.Visible:=False;
                        TglAwal8.Visible:=False;
                      end;
                  end;
                  if (mKodeReport_=20301) or (mKodeReport_=20302) or (mKodeReport_=20303) or (mKodeReport_=20304) or (mKodeReport_=20305) then
                  begin
                    
                  end
                  else
                    Perkiraan8.Text:='';
                  Urut8.Clear;
                  Urut8.Items.Add('Tanggal');
                  Urut8.Items.Add('No. Nota');
                  Urut8.ItemIndex:=0;
                  Urut8.Visible:=KodeReport<>20304;
                  gbCustSupp8.Caption:='Supplier';
                end;
       30362: Begin
                ShowReportPreview('Laporan Komisi Sales',7);
                TglAwal8.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                TglAkhir8.Date := incday(incmonth(TglAwal8.Date,1),-1);
                DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                Devisi8.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                Devisi8.Enabled:=DM.QuCari.RecordCount>1;
                gbPeriode8.Caption:='s/d Tanggal';
                LblTglAwal8.Visible:=False;
                LblTglAkhir8.Visible:=False;
                TglAwal8.Visible:=False;
                End;
       20401, 20402, 20403, 20404, 20405,20406,204041 :
                begin
                   LblTglAwal8.Caption:='AWAL';
                   LblTglAkhir8.Caption:='AKHIR';
                  case KodeReport of

                    20401 : ShowReportPreview(' Kartu Piutang',7);
                    20402 : ShowReportPreview(' Sisa Piutang',7);
                    20403 : ShowReportPreview(' Pelunasan Piutang',7);
                    20404 : Begin
                             LblTglAwal8.Caption:='AWAL';
                             LblTglAkhir8.Caption:='AKHIR';
                             ShowReportPreview(' Saldo Piutang',7);
                            end;
                    204041 : Begin
                              LblTglAwal8.Caption:='Bulan';
                              LblTglAkhir8.Caption:='Tahun';
                              Bulan8.Visible:=True;
                              Tahun8.Visible:=True;
                              Bulan8.Value:=StrToInt(PeriodBln);
                              Tahun8.Value:=StrToInt(PeriodThn);
                              TglAwal8.Visible:=False;
                              TglAkhir8.Visible:=False;
                              Urut8.Visible:=False;
                              ShowReportPreview(' Saldo Detail Piutang',7);
                             end;
                    20405 : ShowReportPreview(' Umur Piutang',7);
                    20406 : Begin
                             ShowReportPreview(' Kartu Piutang Detail',7);
                             Valas8.Visible:=False;
                             Label24.Visible:=False;
                             Devisi8.Visible:=False;
                             label25.Visible:=False;
                             Perkiraan8.Visible:=False;
                             gbCustSupp8.Visible:=False;
                             Urut8.Visible:=False;
                            end;
                  end;
                  TglAwal8.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                  TglAkhir8.Date := incday(incmonth(TglAwal8.Date,1),-1);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi8.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi8.Enabled:=DM.QuCari.RecordCount>1;
                  case KodeReport of
                    20401, 20403, 20404,20406 :
                      begin
                        gbPeriode8.Caption:='Periode';
                        LblTglAwal8.Visible:=True;
                        LblTglAkhir8.Visible:=True;
                        TglAwal8.Visible:=True;
                      end;
                    20402, 20405 :
                      begin
                        gbPeriode8.Caption:='s/d Tanggal';
                        LblTglAwal8.Visible:=False;
                        LblTglAkhir8.Visible:=False;
                        TglAwal8.Visible:=False;
                      end;
                  end;
                  if (mKodeReport_=20401) or (mKodeReport_=20402) or (mKodeReport_=20403) or (mKodeReport_=20404) or (mKodeReport_=20405) or (mKodeReport_=20406) then
                  begin

                  end
                  else
                    Perkiraan8.Text:='';
                  Urut8.Clear;
                  Urut8.Items.Add('Tanggal');
                  Urut8.Items.Add('No. Nota');
                  Urut8.ItemIndex:=0;
                  Urut8.Visible:=KodeReport<>20404;
                  gbCustSupp8.Caption:='Customer';
                  case kodereport of
                     20402:CBODet7.Visible:=true;
                  End;
                end;
        20501 : begin
                  Bulan.Value:=StrToInt(PeriodBln);
                  Tahun.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi2.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi2.Enabled:=DM.QuCari.RecordCount>1;
                  ShowReportPreview(' Neraca Lajur',2);
                end;
       20502 :  begin
                  Bulan.Value:=StrToInt(PeriodBln);
                  Tahun.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi2.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi2.Enabled:=DM.QuCari.RecordCount>1;
                  ShowReportPreview(' Laba Rugi',2);
                end;
       20503 : begin
                  Bulan.Value:=StrToInt(PeriodBln);
                  Tahun.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi2.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi2.Enabled:=DM.QuCari.RecordCount>1;
                  ShowReportPreview(' Neraca',2);
                end;
       20504 : begin
                  Bulan.Value:=StrToInt(PeriodBln);
                  Tahun.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi2.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi2.Enabled:=DM.QuCari.RecordCount>1;
                  ShowReportPreview(' Neraca Penunjang',2);
                end;
       20505 : begin
                  Bulan.Value:=StrToInt(PeriodBln);
                  Tahun.Value:=StrToInt(PeriodThn);
                  DataBersyarat('select * from dbDevisi where 1=:0 order by Devisi',[1],DM.QuCari);
                  Devisi2.Text:=DM.QuCari.FieldByName('Devisi').AsString;
                  Devisi2.Enabled:=DM.QuCari.RecordCount>1;
                  ShowReportPreview(' HPP',2);
                end;
       ///
       303321 : Begin
                ShowReportPreview('Laporan DP by Customer',11);
                TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
                GroupBox9.Visible:=True;
                end;
       303322 : Begin
                ShowReportPreview('Laporan Penjualan + DP',11);
                TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
                end;
       303323 : Begin
                ShowReportPreview('Laporan Laba Kotor',11);
                TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
                end;
       ///
       251010,251020,251030,251040,251050,252010,252020,252030,252040,252050,301010,301020,301030,301040,301050,
       302010,302020,302030,302040,302050:
               begin
               Awal15.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
               Akhir15.Date := incday(incmonth(Awal15.Date,1),-1);
                case kodereport of
                251010 : ShowReportPreview(' Pembelian Per No. Bukti',15);
                251020 : ShowReportPreview(' Pembelian Per Supplier',15);
                251030 : ShowReportPreview(' Pembelian Per Acc. Persediaan',15);
                251040 : ShowReportPreview(' Pembelian Per Acc. Hutang',15);
                251050 : ShowReportPreview(' Pembelian Per Tipe',15);
                252010 : ShowReportPreview(' Retur Pembelian Per No. Bukti',15);
                252020 : ShowReportPreview(' Retur Pembelian Per Supplier',15);
                252030 : ShowReportPreview(' Retur Pembelian Per Acc. Persediaan',15);
                252040 : ShowReportPreview(' Retur Pembelian Per Acc. Hutang',15);
                252050 : ShowReportPreview(' Retur Pembelian Per Tipe',15);
                301010 : ShowReportPreview(' Penjualan Per No. Bukti',15);
                301020 : ShowReportPreview(' Penjualan Per Supplier',15);
                301030 : ShowReportPreview(' Penjualan Per Acc. Persediaan',15);
                301040 : ShowReportPreview(' Penjualan Per Acc. Hutang',15);
                301050 : ShowReportPreview(' Penjualan Per Tipe',15);
                302010 : ShowReportPreview(' Retur Penjualan Per No. Bukti',15);
                302020 : ShowReportPreview(' Retur Penjualan Per Supplier',15);
                302030 : ShowReportPreview(' Retur Penjualan Per Acc. Persediaan',15);
                302040 : ShowReportPreview(' Retur Penjualan Per Acc. Hutang',15);
                302050 : ShowReportPreview(' Retur Penjualan Per Tipe',15);
                end;
                case kodereport of
                251050,252050,301050,302050:
                 begin
                 GroupBox8.Visible:=True;
                 Button2.Visible:=false;
                 end;
                end;
               end;


            2530201,2530202, 2530203
            ,2540101,2540102,2540103,
            2540201,2540202,2540203,
            25501,25502,25503,
            2560101,2560102,2560103,
            2560201,2560202,2560203,2560204,
            25701,25702,25703,25704,
            25711,25712,25713,
            25721,25722,25723,
            25731,25732,25733,
            25741,25742,
            25761,25762,25763,303701,303702,303703,303801,303802,303803 :
            begin
              TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
              TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
              case kodereport of
              303701: ShowReportPreview('SO vs SPK vs Hsl Prd. Per No. Bukti',11);
              303702: ShowReportPreview('SO vs SPK vs Hsl Prd. Per Barang',11);
              303703: ShowReportPreview('SO vs SPK vs Hsl Prd. Per Customer',11);


              303801: ShowReportPreview('Kontrak vs SJ vs Saku Per No. Bukti',11);
              303802: ShowReportPreview('Kontrak vs SJ vs Saku Per Barang',11);
              303803: ShowReportPreview('Kontrak vs SJ vs Saku Per Customer',11);

              2530201:ShowReportPreview('PR Per No. Bukti',11);
              2530202:ShowReportPreview('PR Per Barang',11);
              2530203:ShowReportPreview('PR Per Supplier',11);
              2540101:Begin
                        ShowReportPreview('OutStanding PR Per No. Bukti',11);
                        Label38.Visible:=False;
                        Label39.Visible:=False;
                        TglAwal13.Visible:=False;
                        TglAkhir13.Visible:=False;

                      end;
              2540102:Begin
                       ShowReportPreview('OutStanding PR Per Barang',11);
                        Label38.Visible:=False;
                        Label39.Visible:=False;
                        TglAwal13.Visible:=False;
                        TglAkhir13.Visible:=False;
                      end;
              2540103:Begin
                        ShowReportPreview('OutStanding PR Per Supplier',11);
                        Label38.Visible:=False;
                        Label39.Visible:=False;
                        TglAwal13.Visible:=False;
                        TglAkhir13.Visible:=False;
                      end;
              2540201:ShowReportPreview('PO Per No. Bukti',11);
              2540202:ShowReportPreview('PO Per Barang',11);
              2540203:ShowReportPreview('PO Per Supplier',11);

              25501:ShowReportPreview('Revisi PO Per No. Bukti',11);
              25502:ShowReportPreview('Revisi PO Per Barang',11);
              25503:ShowReportPreview('Revisi PO Per Supplier',11);

              2560101:ShowReportPreview('OutStanding PO Per No. Bukti',11);
              2560102:ShowReportPreview('OutStanding PO Per Barang',11);
              2560103:ShowReportPreview('OutStanding PO Per Supplier',11);

              2560201:ShowReportPreview('Beli Gudang Per No. Bukti',11);
              2560202:ShowReportPreview('Beli Gudang Per Barang',11);
              2560203:ShowReportPreview('Beli Gudang Per Supplier',11);
              2560204:ShowReportPreview('Beli Gudang Per Gudang',11);

              25701:ShowReportPreview('Inspeksi Penerimaan Gudang Per No. Bukti',11);
              25702:ShowReportPreview('Inspeksi Penerimaan Gudang Per Barang',11);
              25703:ShowReportPreview('Inspeksi Penerimaan Gudang Per Supplier',11);
              25704:ShowReportPreview('Inspeksi Penerimaan Gudang Per Gudang',11);

              25711:Begin
                     ShowReportPreview('Penerimaan ACC Per No. Bukti',11);
                     GroupBox13.Visible:=True;
                    end;
              25712:Begin
                     ShowReportPreview('Penerimaan ACC Per Barang',11);
                     GroupBox13.Visible:=True;
                    end;
              25713:Begin
                     ShowReportPreview('Penerimaan ACC Per Supplier',11);
                     GroupBox13.Visible:=True;
                    end;
              25721:ShowReportPreview('Retur Pembelian Gudang Per No. Bukti',11);
              25722:ShowReportPreview('Retur Pembelian Gudang Per Barang',11);
              25723:ShowReportPreview('Retur Pembelian Gudang Per Supplier',11);

              25731:ShowReportPreview('Debet Note Per No. Bukti',11);
              25732:ShowReportPreview('Debet Note Per Barang',11);
              25733:ShowReportPreview('Debet Note Per Supplier',11);

              25741:ShowReportPreview('Invoice Pembelian Per No. Bukti',11);
              25742:ShowReportPreview('Invoice Pembelian Per Supplier',11);

              25761:ShowReportPreview('Retur Pembelian Gudang Per No. Bukti',11);
              25763:ShowReportPreview('Retur Pembelian Gudang Per Barang',11);
              25762:ShowReportPreview('Retur Pembelian Gudang Per Supplier',11);
              end;

              Case KodeReport of
              2540201,2540202,2540203,25501,25502,25503,2560101,2560102,2560103,
              25721,25722,25723,25711,25712,25713,25741,25742:
               begin
               GroupBox9.Visible:=True;
               end;

              End;
              case kodereport of  //Filter ororisasi
              2530201,2530202, 2530203,2540201,2540202,2540203,25711,25712,25713,25741,25742,25721,25722,25723,25761,25762,25763,25731,25732,25733:
              PanelOto.visible:=True;
              end;
              case kodereport of
              2560101,2560102,2560103:Sls.Visible:=True;
              End;
            end;
            30314:
            Begin
              ShowReportPreview('Laporan CashBack',11);
              TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
              TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
            end;
            3032411:
            Begin
              ShowReportPreview('Laporan Faktur Penjualan BO Kode Customer',11);
              TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
              TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
            end;
            3030101,3030102,3030103,3030104,
            3030201,3030202,3030203,
            3031101,3031102,3031103,
            3031201,3031202,3031203,
            3032101,3032102,3032103,
            3032201,3032202,3032203,
            3032301,3032302,3032303,
            3033101,3033102,3033103,
            3033201,3033202,3033203,3033204,
            303410,303420,303430,303440,303241,303242 :
            begin
            TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
            TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
            GroupBox9.Visible:=True;
              Case Kodereport of
              3030101 : ShowReportPreview('SO Per Nobukti',11);
              3030102 : ShowReportPreview('SO Per Barang',11);
              3030103 : ShowReportPreview('SO Per Supplier',11);
              3030104 : Begin
                         GroupBox9.Visible:=False;
                         GroupBox13.Visible:=False;
                         ShowReportPreview('HPP SO ',11);
                         Label98.Visible:=False;
                         CboOto.Visible:=False;
                        end;
              3030201 : ShowReportPreview('OutStanding SO Per Nobukti',11);
              3030202 : ShowReportPreview('OutStanding SO Per Barang',11);
              3030203 : ShowReportPreview('OutStanding SO Per Supplier',11);

              3031101 : ShowReportPreview('SO Per Nobukti',11);
              3031102 : ShowReportPreview('SO Per Barang',11);
              3031103 : ShowReportPreview('SO Per Customer',11);

              3031201 : ShowReportPreview('SPP Per Nobukti',11);
              3031202 : ShowReportPreview('SPP Per Barang',11);
              3031203 : ShowReportPreview('SPP Per Customer',11);

              3032101 : ShowReportPreview('SPP Per Nobukti',11);
              3032102 : ShowReportPreview('SPP Per Barang',11);
              3032103 : ShowReportPreview('SPP Per Customer',11);

              3032201 : ShowReportPreview('SPB Per Nobukti',11);
              3032202 : ShowReportPreview('SPB Per Barang',11);
              3032203 : ShowReportPreview('SPB Per Customer',11);
              3032301,3032302,3032303:
               begin
                CBR.Visible:=True;
                ShowReportPreview('SPB ACC',11);
               end;
              303241  :
              Begin
               ShowReportPreview('Rekapitulasi Pengiriman Barang',11);
               GroupBox9.Visible:=False;
              end;
               303242  :
              Begin
               ShowReportPreview('Kontrak vs SJ',11);
               GroupBox9.Visible:=False;
              end;
              3033101 : ShowReportPreview('SPPB Per Nobukti',11);
              3033102 : ShowReportPreview('SPPB Per Barang',11);
              3033103 : ShowReportPreview('SPPB Per Customer',11);

              3033201 : ShowReportPreview('Packing List Invoice Per Nobukti',11);
              3033202 : ShowReportPreview('Packing List Invoice Per Barang',11);
              3033203 : ShowReportPreview('Packing List Invoice Per Customer',11);
              3033204 : ShowReportPreview('Packing List Invoice Per Sales',11);

              303410 : ShowReportPreview('Invoice Retur Penjualan Per Nobukti',11);
              303420 : ShowReportPreview('Invoice Retur Penjualan Per Barang',11);
              303430 : ShowReportPreview('Invoice Retur Penjualan Per Customer',11);
              303440 : ShowReportPreview('Invoice Retur Penjualan Per Sales',11);
              End;
              case kodereport of  //Filter ororisasi
              3030101,3030102,3030103,3030104,3031201,3031202,3031203,3032201,3032202,3032203,3033201,3033202,3033203,3033204,
              303410,303420,303430,303440,3032301,3032302,3032303 :
              PanelOto.visible:=True;
              end;
            End;
            4010201,4010202,401020201,4010203,4010204,4010205,
            4010301,4010302,
            40201,40202,
            40301,40302,40303,
            40351,40352,40353,
            4040101,4040102,
            4040201,4040202,
            40501,40502,
            40701,40702,
            40801,40802,
            402021,402022,
            40361,40362
            ,40851,40852
            ,40861,40862,4011:
            begin
            TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
            TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
            GroupBox9.Visible:=True;
             case kodereport of
              4011:Begin
                        ShowReportPreview('Laporan SPK',11);
                        GroupBox9.Visible:=False;
                   end;
              4010201:Begin
                        ShowReportPreview('BP Per Nobukti',11);
                        CboOto.Visible:=False;
                        Label98.Visible:=False;
                      end;
              4010202:Begin
                       ShowReportPreview('BP Per Barang',11);
                       CboOto.Visible:=False;
                       Label98.Visible:=False;
                      end;
              401020201:Begin
                       ShowReportPreview('BP Per Departemen',11);
                       CboOto.Visible:=False;
                       Label98.Visible:=False;
                      end;
              4010203:ShowReportPreview('BP Per Nobukti ACC',11);
              4010204:ShowReportPreview('BP Per Barang ACC',11);
              4010205:ShowReportPreview('BP Per Departemen ACC',11);

              4010301:ShowReportPreview('BP Per Nobukti (ACC)',11);
              4010302:ShowReportPreview('BP Per Barang (ACC)',11);

              40201:ShowReportPreview('Retur Penyerahan Bahan Per Nobukti',11);
              40202:ShowReportPreview('Retur Penyerahan Bahan Per Barang',11);
              402021,402022,40361,40362 :ShowReportPreview('',11);
              40851,40852,40861,40862 :
              Begin
              ShowReportPreview('Laporan Hasil Produksi',11);
              CboOto.Visible:=False;
              Label98.Visible:=False;
              end;
              40301:ShowReportPreview('Permintaan Bahan Per Nobukti',11);
              40302:ShowReportPreview('Permintaan Bahan Per Barang',11);
              40303:ShowReportPreview('Permintaan Bahan Per Department',11);

              40351:ShowReportPreview('Permintaan Bahan ACC Per Nobukti',11);
              40352:ShowReportPreview('Permintaan Bahan ACC Per Barang',11);
              40353:ShowReportPreview('Permintaan Bahan ACC Per Department',11);

              4040101 :ShowReportPreview('OutStanding BPPB Per Nobukti',11);
              4040102 :ShowReportPreview('OutStanding BPPB Per Barang',11);

              4040201 :ShowReportPreview('BPPB Keluar Per Nobukti',11);
              4040202 :ShowReportPreview('BPPB Keluar Per Barang',11);


              40501:ShowReportPreview('Ubah Kemasan Bahan Per Nobukti',11);
              40502:ShowReportPreview('Ubah Kemasan Bahan Per Barang',11);

              40701:ShowReportPreview('Opname Bahan Per Nobukti',11);
              40702:ShowReportPreview('Opname Bahan Per Barang',11);

              40801:ShowReportPreview('Opname Barang Per Nobukti',11);
              40802:ShowReportPreview('Opname Barang Per Barang',11);
             End;
             case kodereport of
             40361,40362,40501,40502,40701,40702,40801,40802,40851,40852,40861:groupbox9.visible:=false;
             end;
             case kodereport of
             4010201,4010202,401020201,4010203,4010204,4010205,4010301,4010302,40201,40202,40301,40302,40303,40351,40352,40353,40361,40362,40701,40702,40801,40802,402021,402022,
             40851,40852,40861,40862
             :PanelOto.visible:=true;
             end;

            End;
            4010101,4010102:
            Begin
             case kodereport of
             4010101:ShowReportPreview('Out Standing SPK Per Nobukti',11);
             4010102:ShowReportPreview('Out Standing SPK Per Barang',11);
             End;
             TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
             TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
            End;

           //Produksi
            35101, 35102 :
            Begin
            TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
            TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
            GroupBox9.Visible:=True;
                Case Kodereport of
                35101 :ShowReportPreview('SPRK Per Nobukti',11);
                35102 :ShowReportPreview('SPRK Per Barang',11);
                end;
            paneloto.Visible:=true;
            end;
            253010:
            begin
             case kodereport of
             253010:ShowReportPreview('OutStanding SPK',16);

             End;
            Bulan16.Value:=StrToInt(PeriodBln);
            Tahun16.Value:=StrToInt(PeriodThn);
            Bulan16.Visible:=False;
            Tahun16.Visible:=False;
            Button2.Visible:=False;
            end;

           50101,50102,50103:
            begin
             Bulan17.Value:=StrToInt(PeriodBln);
             Tahun17.Value:=StrToInt(PeriodThn);
             Label100.Visible:=True;
             Group17.Visible:=True;
             case kodereport of
             50101:ShowReportPreview(' Stok Per Quantity',17);
             50102:ShowReportPreview(' Stok RuPiah',17);
             50103:begin
                   cbotampil.ItemIndex:=0;
                   ShowReportPreview(' Stok Per Quantity + Rupiah',17);
                   Cbotampil.Visible:=true;
                   end;
             End;
            end;
           50104:begin
                 tgl18.date:=Now;
                 With DM.QuCari do
                 Begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select a.IsDesign from DBFLMENUREPORT a ');
                 SQL.Add('Left Outer Join DBMENUREPORT b on a.L1=b.KODEMENU  ');
                 SQL.Add('where b.ACCESS='+IntToStr(50104)+' and a.UserID='+QuotedStr(IDUser));
                 Open;
                 StockMinus18.Visible:=Fieldbyname('IsDesign').AsBoolean;
                 end;
                
                 StockMinus18.Caption:='HPP';
                 ShowReportPreview(' Stock Akhir Gudang Produksi',18);

                 End;
           501041:begin
                 tgl18.date:=Now;
                 With DM.QuCari do
                 Begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select a.IsDesign from DBFLMENUREPORT a ');
                 SQL.Add('Left Outer Join DBMENUREPORT b on a.L1=b.KODEMENU  ');
                 SQL.Add('where b.ACCESS='+IntToStr(50104)+' and a.UserID='+QuotedStr(IDUser));
                 Open;
                 StockMinus18.Visible:=Fieldbyname('IsDesign').AsBoolean;
                 end;
                
                 StockMinus18.Caption:='HPP';
                 ShowReportPreview(' Stock Akhir Gudang Bahan Mentah',18);

                 End;
           50105:Begin
                 tgl19.date:=Now;
                 ShowReportPreview('Stok Fisik Gudang',19);
                 End;
           50106:begin
                 awal20.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                 akhir20.Date := incday(incmonth(awal20.Date,1),-1);
                 ShowReportPreview('Stok Harian',20);
                 With DM.QuCari do
                 Begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select a.IsDesign from DBFLMENUREPORT a ');
                 SQL.Add('Left Outer Join DBMENUREPORT b on a.L1=b.KODEMENU  ');
                 SQL.Add('where b.ACCESS='+IntToStr(50106)+' and a.UserID='+QuotedStr(IDUser));
                 Open;
                 HPP.Visible:=Fieldbyname('IsDesign').AsBoolean;
                 end;
                 End;
           50201,50202
                 :begin
                    thnawal21.Value:=StrToInt(PeriodThn);
                    thnakhir21.Value:=StrToInt(PeriodThn);
                    case kodereport of
                    50201:ShowReportPreview('Kartu Stock Quantity',21);
                    50202:ShowReportPreview('Kartu Stock Quantity + Rupiah',21);
                    end;
                 End;
           60:Begin
                 ShowReportPreview('Kartu Proyek',11);
                 TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                 TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
              end;
           6101:Begin
                 ShowReportPreview('Laporan Cash Back-Detail',11);
                 TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                 TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
              end;
           6102:Begin
                 ShowReportPreview('Laporan Cash Back-Detail',11);
                 TglAwal13.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                 TglAkhir13.Date := incday(incmonth(TglAwal13.Date,1),-1);
              end;
           30351:begin
                 Bulan16.Value:=StrToInt(PeriodBln);
                 Tahun16.Value:=StrToInt(PeriodThn);
                 ShowReportPreview('Analisa Sales',16);
                 End;
           30352:begin
                 Tahun22.Value:=StrToInt(PeriodThn);
                 ShowReportPreview('Target Sales',22);
                 End;
           256021: ShowReportPreview('Laporan Harga Beli Terakhir',23);
           30363:Begin
                 Bulan16.Value:=StrToInt(PeriodBln);
                 Tahun16.Value:=StrToInt(PeriodThn);
                 ShowReportPreview('Laporan Omset Komisi',16);
                 End;
           30361: Begin
                Bulan16.Value:=StrToInt(PeriodBln);
                Tahun16.Value:=StrToInt(PeriodThn);
                ShowReportPreview('Laporan Komisi Pelunasan',16);
                End;
           
           4711,4712,4713,3032601,3032602,3032603:Begin
                 awal23.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                 akhir23.Date := incday(incmonth(awal23.Date,1),-1);
                    ShowReportPreview('',23);
                End;
           2401,2402,2403:Begin
                awal23.Date := EncodeDate(StrToInt(PeriodThn),StrToInt(PeriodBln),1);
                akhir23.Date := incday(incmonth(awal23.Date,1),-1);
                ShowReportPreview('',23);
                Tipe23.Visible:=True;
                End;

        end;
      mKodeReport_:=KodeReport;
      lblLokasi.Visible:=CboLokasi.Visible;
      Label50.Visible:=Lokasi.Visible;
      DataBersyarat('select keterangan from dbmenureport where access=:0',[kodereport],dm.qucari);
      LJudulReport.caption:=Dm.Qucari.Fieldbyname('Keterangan').asstring;
      label99.Visible:=Cbotampil.Visible;
      Label101.visible:=Sls.Visible;
      Label104.Visible:=Tipe23.Visible;
    end;
  end;
end;

procedure TFrReportPreview.selectreport;
var i : integer;
    yy,mm,dd :Word;
    vkodebonus,XParameter : string;
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
                 Sql.Add('Select * from vwPerkiraan a');
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
    10101 : begin   // Master Aktiva Tetap
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 Sql.Add('Select * from vwaktiva a');
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
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterAktiva.fr3');
                 ShowReport;
              end;
            end;
      102 : begin   // Master Perkiraan
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from vwPerkiraan a ');
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
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterNeraca.fr3');
                 ShowReport;
              end;
            end;
      103 : begin   // Master Laba Rugi
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from vwLabaRugiHPP a where Bulan=:0 and Tahun=:1 and IsLRHPP=0 ');
                 Prepared;
                 Parameters[0].Value := StrToInt(PeriodBln);
                 Parameters[1].Value := StrToInt(PeriodThn);
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('and a.Nomor in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by a.Nomor ');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterLabaRugi.fr3');
                 ShowReport;
              end;
            end;
      104 : begin   // Master HPP
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from vwLabaRugiHPP a where Bulan=:0 and Tahun=:1 and IsLRHPP=1 ');
                 Prepared;
                 Parameters[0].Value := StrToInt(PeriodBln);
                 Parameters[1].Value := StrToInt(PeriodThn);
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('and a.Nomor in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by a.Nomor ');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterLabaRugi.fr3');
                 ShowReport;
              end;
            end;
      1101: //ShowReportPreview(' Daftar Gudang',1);
            begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from VwGudang a ');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('where a.kodegdg in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by a.kodegdg ');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterGudang.fr3');
                 ShowReport;
              end;
            end;
      1104,1200: //ShowReportPreview(' Daftar Kelompok Barang',-1);
            begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from vwKelompok a ');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('where a.kodeKelompok in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by a.kodeKelompok ');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterKelompok.fr3');
                 ShowReport;
              end;
            end;
      1105: //ShowReportPreview(' Daftar Kategori Barang',-1);
            begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from vwKategori a ');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('where a.kodeKategori in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by a.kodekategori ');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterKategori.fr3');
                 ShowReport;
              end;
            end;
      1106: //ShowReportPreview(' Daftar Sub Kategori Barang',-1);
            begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from vwSubKategori a ');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('where a.kodeSubKategori in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by a.kodeSubkategori ');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterSubKategori.fr3');
                 ShowReport;
              end;
            end;
      1107: //ShowReportPreview(' Daftar Jenis Barang',-1);
            begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from vwjenis a ');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('where a.kodejnsBrg in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by a.kodejnsBrg ');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterjenis.fr3');
                 ShowReport;
              end;
            end;
      1108: //ShowReportPreview(' Daftar Sub Jenis Barang',-1);
            begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from vwSubjenis a ');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('where a.kodeSubjnsBrg in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by a.kodeSubjnsBrg ');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterSubjenis.fr3');
                 ShowReport;
              end;
            end;
      1110: //ShowReportPreview(' Daftar Supplier',-1);
            begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from vwBrowsSupp a ');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('where a.kodecustSupp in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by A.Perkiraan,a.kodecustSupp ');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterSupplier.fr3');
                 ShowReport;
              end;
            end;
   1298: //ShowReportPreview(' Daftar Customer',-1);
            begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from vwBrowsCust a ');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('where a.kodecustSupp in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by A.Perkiraan,a.kodecustSupp ');
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterCustomer.fr3');
                 ShowReport;
              end;
            end;
   1304: //ShowReportPreview(' Daftar Valas',-1);
            begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := quview;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 SQL.Add('select a.* from vwValas a ');
                 SQl.Add('where Month(A.Tanggal)=:0 and year(tanggal)=:1');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('and a.kodeVls in (');
                    IsiDariListBox1(QuView);
                 end;
                 sql.add('order by A.kodeVls ');
                 Prepared;
                 Parameters[0].Value := Bulan.AsInteger;
                 Parameters[1].Value := Tahun.AsInteger;
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 LoadFromFile(CurrDir+'ReportFiles\ReportMasterValas.fr3');
                 ShowReport;
              end;
            end;
   20101 :  begin
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
                   if xKodeVls='IDR' then
                              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKasHarian.fr3')
                            else frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKasHarianUSD.fr3');
                frxReport1.ShowReport;
              end;
            end;
   20102 :  begin
              with frxReport1 do
              begin
                frxDBDataset1.DataSet.Close;
                frxDBDataset2.DataSet.Close;
                frxDBDataset3.DataSet.Close;
                with QuView3 do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('declare @SaldoAwalRp numeric(18,2), @TglAw datetime, @TglAk datetime, @lokasi tinyint ');
                  SQL.Add('select @TglAw='+QuotedStr(FormatDateTime('MM/dd/yyyy',Awal.Date))+', @TglAk='+QuotedStr(FormatDateTime('MM/dd/yyyy',Akhir.Date)));
                  Sql.add('set @Lokasi='+IntToStr(Lokasi.ItemIndex));
                  SQL.Add('select @SaldoAwalRp=sum(isnull(Y0.SaldoRp,0)+isnull(Y1.SaldoRp,0)) ');
                  SQL.Add('from dbPostHutPiut X ');
                  SQL.Add('left outer join dbPerkiraan X1 on X1.Perkiraan=X.Perkiraan ');
                  SQL.Add('left outer join ');
                  SQL.Add('( select Perkiraan, sum(case when DK=0 then AwalD else AwalK end) SaldoUS, ');
                  SQL.Add('  sum(case when DK=0 then AwalDRp else AwalKRp end) SaldoRp ');
                  SQL.Add('from dbNeraca where Tahun=year(@TglAw) and Bulan=1 ');
                  SQL.Add('group by Perkiraan ');
                  SQL.Add(') Y0 on Y0.Perkiraan=X.Perkiraan ');
                  SQL.Add('left outer join ');
                  SQL.Add('( ');
                  SQL.Add('select case when C1.Perkiraan is null then B.Lawan else B.Perkiraan end Perkiraan, ');
                  SQL.Add('  sum(case when C1.Perkiraan is null then 0 else B.DebetRp end-');
                  SQL.Add('  case when C1.Perkiraan is null then B.DebetRp else 0 end) SaldoRp,');
                  SQL.Add('  sum((case when C1.Perkiraan is null then 0 else B.Debet end-');
                  SQL.Add('  case when C1.Perkiraan is null then B.Debet else 0 end)*');
                  SQL.Add('  case when B.Kurs=1 then 0 else 1 end) SaldoUS ');
                  SQL.Add('from dbTrans A');
                  SQL.Add('left outer join dbTransaksi B on B.NoBukti=A.NoBukti ');
                  SQL.Add('left outer join DBPOSTHUTPIUT C1 on C1.Perkiraan=B.Perkiraan and C1.Kode=''BANK'' ');
                  SQL.Add('left outer join DBPOSTHUTPIUT C2 on C2.Perkiraan=B.Lawan and C2.Kode=''BANK'' ');
                  SQL.Add('where year(A.Tanggal)='+FormatDateTime('yyyy',Awal.Date)+' and A.Tanggal<'+QuotedStr(FormatDateTime('MM/dd/yyyy',Awal.Date)));
                  SQL.Add('and A.Tanggal>=''06/01/2012'' ');
                  SQL.Add('and ((C1.Perkiraan is not null) or (C2.Perkiraan is not null)) ');
                  SQL.Add('group by case when C1.Perkiraan is null then B.Lawan else B.Perkiraan end ');
                  SQL.Add(') Y1 on Y1.Perkiraan=X.Perkiraan ');
                  SQL.Add('where X.Kode=''BANK'' ');
                  SQl.add('and (X1.lokasi  Like (Case when @Lokasi=0 then 0');
                  SQl.add('                           when @Lokasi=1 then 1');
                  SQl.add('                      end) or');
                  SQl.add('(Case when @Lokasi=0 then 0 ');
                  SQl.add('      when @Lokasi=1 then 1 ');
                  SQl.add('      else 2                ');
                  SQl.add(' end)=2)                    ');
                  if Perkiraan.Text<>'' then
                    SQL.Add('and X.Perkiraan='+QuotedStr(Perkiraan.Text));

                  SQL.Add('select @SaldoAwalRp=isnull(@SaldoAwalRp,0) ');

                  SQL.Add('select X.Perkiraan, X1.Keterangan, @SaldoAwalRp SaldoAwal, ');
                  SQL.Add('case when X1.Valas=''IDR'' then 0 else isnull(Y0.SaldoUS,0)+isnull(Y1.SaldoUS,0)+isnull(Y2.SaldoUS,0) end SaldoUS, ');
                  SQL.Add('isnull(Y0.SaldoRp,0)+isnull(Y1.SaldoRp,0)+isnull(Y2.SaldoRp,0)+isnull(Z.CHGB,0) SaldoRp, ');
                  SQL.Add('isnull(Z.CHGB,0) CHGB, ');
                  SQL.Add('isnull(Y0.SaldoRp,0)+isnull(Y1.SaldoRp,0)+isnull(Y2.SaldoRp,0) SaldoTotalRp ');
                  SQL.Add('from dbPostHutPiut X ');
                  SQL.Add('left outer join dbPerkiraan X1 on X1.Perkiraan=X.Perkiraan ');
                  SQL.Add('left outer join ');
                  SQL.Add('( select Perkiraan, sum(case when DK=0 then AwalD else AwalK end) SaldoUS, ');
                  SQL.Add('  sum(case when DK=0 then AwalDRp else AwalKRp end) SaldoRp ');
                  SQL.Add('from dbNeraca where Tahun=year(@TglAw) and Bulan=1 ');
                  SQL.Add('group by Perkiraan ');
                  SQL.Add(') Y0 on Y0.Perkiraan=X.Perkiraan ');
                  SQL.Add('left outer join ');
                  SQL.Add('( ');
                  SQL.Add('select case when C1.Perkiraan is null then B.Lawan else B.Perkiraan end Perkiraan, ');
                  SQL.Add('  sum(case when C1.Perkiraan is null then 0 else B.DebetRp end-');
                  SQL.Add('  case when C1.Perkiraan is null then B.DebetRp else 0 end) SaldoRp,');
                  SQL.Add('  sum((case when C1.Perkiraan is null then 0 else B.Debet end-');
                  SQL.Add('  case when C1.Perkiraan is null then B.Debet else 0 end)*');
                  SQL.Add('  case when B.Kurs=1 then 0 else 1 end) SaldoUS ');
                  SQL.Add('from dbTrans A');
                  SQL.Add('left outer join dbTransaksi B on B.NoBukti=A.NoBukti ');
                  SQL.Add('left outer join DBPOSTHUTPIUT C1 on C1.Perkiraan=B.Perkiraan and C1.Kode=''BANK'' ');
                  SQL.Add('left outer join DBPOSTHUTPIUT C2 on C2.Perkiraan=B.Lawan and C2.Kode=''BANK'' ');
                  SQL.Add('where year(A.Tanggal)='+FormatDateTime('yyyy',Awal.Date)+' and A.Tanggal<'+QuotedStr(FormatDateTime('MM/dd/yyyy',Awal.Date)));
                  SQL.Add('and A.Tanggal>=''06/01/2012'' ');
                  SQL.Add('and ((C1.Perkiraan is not null) or (C2.Perkiraan is not null)) ');
                  SQL.Add('group by case when C1.Perkiraan is null then B.Lawan else B.Perkiraan end ');
                  SQL.Add(') Y1 on Y1.Perkiraan=X.Perkiraan ');
                  SQL.Add('left outer join ');
                  SQL.Add('(');
                  SQL.Add('select case when C1.Perkiraan is null then B.Lawan else B.Perkiraan end Perkiraan, ');
                  SQL.Add('  sum((case when C1.Perkiraan is null then 0 else B.Debet end- ');
                  SQL.Add('  case when C1.Perkiraan is null then B.Debet else 0 end)* ');
                  SQL.Add('  case when B.Kurs=1 then 0 else 1 end) SaldoUS, ');
                  SQL.Add('  sum(case when C1.Perkiraan is null then 0 else B.DebetRp end- ');
                  SQL.Add('  case when C1.Perkiraan is null then B.DebetRp else 0 end) SaldoRp ');
                  SQL.Add('from dbTrans A ');
                  SQL.Add('left outer join dbTransaksi B on B.NoBukti=A.NoBukti ');
                  SQL.Add('left outer join DBPOSTHUTPIUT C1 on C1.Perkiraan=B.Perkiraan and C1.Kode=''BANK'' ');
                  SQL.Add('left outer join DBPOSTHUTPIUT C2 on C2.Perkiraan=B.Lawan and C2.Kode=''BANK'' ');
                  SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',Awal.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',Akhir.Date)));
                  SQL.Add('and ((C1.Perkiraan is not null) or (C2.Perkiraan is not null)) ');
                  SQL.Add('group by case when C1.Perkiraan is null then B.Lawan else B.Perkiraan end ');
                  SQL.Add(') Y2 on Y2.Perkiraan=X.Perkiraan ');
                  SQL.Add('left outer join ');
                  SQL.Add('(');
                  SQL.Add('select Bank, sum(KreditRp) CHGB from dbGiro ');
                  SQL.Add('where Tipe=''HT'' and isnull(TglCair,dateadd(day,1,+@TglAk+1))>@TglAk ');
                  SQL.Add('and TglBuka<=@TglAk ');
                  SQL.Add('and TglGiro>@TglAk ');
                  SQL.Add('group by Bank ');
                  SQL.Add(') Z on Z.Bank=X.Perkiraan ');
                  SQL.Add('where X.Kode=''BANK'' ');
                  SQl.add('and (X1.lokasi  Like (Case when @Lokasi=0 then 0');
                  SQl.add('                           when @Lokasi=1 then 1');
                  SQl.add('                      end) or');
                  SQl.add('(Case when @Lokasi=0 then 0 ');
                  SQl.add('      when @Lokasi=1 then 1 ');
                  SQl.add('      else 2                ');
                  SQl.add(' end)=2)                    ');
                  if Perkiraan.Text<>'' then
                    SQL.Add('and X.Perkiraan='+QuotedStr(Perkiraan.Text));
                  SQL.Add('order by X.Perkiraan ');
                  Open;
                end;
                {with QuView2 do
                begin
                  Close;
                  SQL.Clear;
                  SQl.Add('Declare @lokasi tinyint ');
                  Sql.add('set @Lokasi='+IntToStr(Lokasi.ItemIndex));
                  SQL.Add('select A.Tanggal, A.NoBukti, B.Keterangan, ');
                  SQL.Add('  case when C1.Perkiraan is null then B.Lawan else B.Perkiraan end Perkiraan, ');
                  SQL.Add('  case when C1.Perkiraan is null then B.Perkiraan else B.Lawan end Lawan, ');
                  SQL.Add('  case when C1.Perkiraan is null then 0 else B.DebetRp end Debet, ');
                  SQL.Add('  case when C1.Perkiraan is null then B.DebetRp else 0 end Kredit ');
                  SQL.Add('from dbTrans A ');
                  SQL.Add('left outer join dbTransaksi B on B.NoBukti=A.NoBukti ');
                  SQL.Add('left outer join DBPOSTHUTPIUT C1 on C1.Perkiraan=B.Perkiraan and C1.Kode=''BANK'' ');
                  SQL.Add('left outer join DBPOSTHUTPIUT C2 on C2.Perkiraan=B.Lawan and C2.Kode=''BANK'' ');
                  Sql.add('left Outer join dbperkiraan D on D.perkiraan=case when C1.Perkiraan is null then B.Lawan else B.Perkiraan end');
                  SQL.Add('where A.Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',Awal.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',Akhir.Date)));
                  SQL.Add('and ((C1.Perkiraan is not null) or (C2.Perkiraan is not null)) ');
                  SQl.add('and (D.lokasi  Like (Case when @Lokasi=0 then 0');
                  SQl.add('                           when @Lokasi=1 then 1');
                  SQl.add('                      end) or');
                  SQl.add('(Case when @Lokasi=0 then 0 ');
                  SQl.add('      when @Lokasi=1 then 1 ');
                  SQl.add('      else 2                ');
                  SQl.add(' end)=2)                    ');
                  if Perkiraan.Text<>'' then
                    SQL.Add('and (B.Perkiraan='+QuotedStr(Perkiraan.Text)+' or B.Lawan='+QuotedStr(Perkiraan.Text)+')');
                  SQL.Add('order by A.Tanggal, A.NoUrut, A.Simbol, A.TipeTransHd desc, A.NoBukti, B.Urut ');
                  Open;
                end;}
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
                  SQL.Add('exec Sp_LapBankHarian :0,:1,:2,:3');
                  Prepared;
                  Parameters[0].Value:=Perkiraan.Text;
                  Parameters[1].Value:=Awal.Date;
                  Parameters[2].Value:=Akhir.Date;
                  Parameters[3].Value:=Divisi.Text;
                  Open;
                end;
                frxDBDataset1.DataSet:=Quview;
                frxDBDataset1.Close;
                frxDBDataset1.Open;
                frxDBDataset2.DataSet:=Quview2;
                frxDBDataset2.Close;
                frxDBDataset2.Open;
                frxDBDataset3.DataSet:=Quview3;
                frxDBDataset3.Close;
                frxDBDataset3.Open;
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBankHarian.fr3');
                frxReport1.ShowReport;
              end;
            end;
   20103 : begin
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
   201061, 201062, 201063, 201064 : //Deposito
            Begin
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                Close;
                SQL.Clear;
                SQL.Add('exec Sp_LapDeposito :0,:1,:2,:3,:4');
                Prepared;
                Case KodeReport of
                  201061 : Parameters[0].Value := '1';
                  201062 : Parameters[0].Value := '2';
                  201063 : Parameters[0].Value := '3';
                  201064 : Parameters[0].Value := '4';
                  201065 : Parameters[0].Value := '5';
                end;
                Parameters[1].Value := Divisi.Text;
                Parameters[2].Value := Perkiraan.Text;
                Parameters[3].Value := Awal.Date;
                Parameters[4].Value := Akhir.Date;
                open;
              end;
              frxDBDataset1.DataSet := Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
                 case KodeReport of
                   201061..201064 : LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportDeposito.fr3');
                 end;
              end;
              frxReport1.ShowReport;
            end;
   201071, 201072, 201073, 201074, 201075 : //Terima Giro
            Begin
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                Close;
                SQL.Clear;
                SQL.Add('exec Sp_LapGiroPiutang :0,:1,:2,:3,:4,:5');
                Prepared;
                Case KodeReport of
                  201071 : Parameters[0].Value := '1';
                  201072 : Parameters[0].Value := '2';
                  201073 : Parameters[0].Value := '3';
                  201074 : Parameters[0].Value := '4';
                  201075 : Parameters[0].Value := '5';
                end;
                Parameters[1].Value := Divisi.Text;
                Parameters[2].Value := Perkiraan.Text;
                Parameters[3].Value := Awal.Date;
                Parameters[4].Value := Akhir.Date;
                case CboLokasi.ItemIndex of
                  0:Parameters[5].Value :=1;
                  1:Parameters[5].Value :=2;
                  2:Parameters[5].Value :=3;
                End;
                open;
              end;
              frxDBDataset1.DataSet := Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              with frxReport1 do
              begin
               case KodeReport of
                 201071..201074 : LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportGiroPiutang.fr3');
                 201075       : LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRegisterGiroPiutang.fr3');
               end
              end;
              frxReport1.ShowReport;
            end;
   201081, 201082, 201083, 201084, 201085 : //Buka Giro
            Begin
               frxDBDataset1.DataSet.Close;
               with QuView do
               begin
                 Close;
                 SQL.Clear;
                 Case KodeReport of
                   201081..201084 : SQL.Add('exec Sp_LapGiroHutang :0,:1,:2,:3,:4');
                   201085 : SQL.Add('exec sp_RegisterGiroHutang :0,:1,:2,:3');
                 end;
                 Prepared;
                 Case KodeReport of
                   201081 : Parameters[0].Value := '1';
                   201082 : Parameters[0].Value := '4';
                   201083 : Parameters[0].Value := '2';
                   201084 : Parameters[0].Value := '3';
                   201085 : Parameters[0].Value := Perkiraan.Text;
                 end;
                 Case KodeReport of
                   201081..201084 : Begin
                                      Parameters[1].Value := Divisi.Text;
                                      Parameters[2].Value := Perkiraan.Text;
                                      Parameters[3].Value := Awal.Date;
                                      Parameters[4].Value := Akhir.Date;
                                    end;
                   201085 : Begin
                              Parameters[1].Value := Awal.Date;
                              Parameters[2].Value := Akhir.Date;
                              Parameters[3].Value := Divisi.Text;
                            end;
                 end;
                 ExecSQL;
               end;
               frxDBDataset1.DataSet := Quview;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               with frxReport1 do
               begin
                 case KodeReport of
                   201081..201084 : LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportGiroHutang.fr3');
                   201085 : LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRegisterGiroHutang.fr3');
                 end
               end;
               frxReport1.ShowReport;

            end;
   20109 :  Begin
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec sp_ReportBon :0,:1,:2, :3');
                 Prepared;
                 Parameters[0].Value:=Divisi.Text;
                 Parameters[1].Value:=Perkiraan.Text;
                 Parameters[2].Value:=Awal.Date;
                 Parameters[3].Value:=Akhir.Date;
                 Open;
              end;
              frxDBDataset1.DataSet := Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBonSementara.fr3');
              frxReport1.ShowReport;
            end;        
   2020101,2020102,2020103,2020104,2020105,2020106,2020107,2020108,2020109:
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
                       2020101 : Parameters[0].Value := 'BKM';
                       2020102 : Parameters[0].Value := 'BKK';
                       2020103 : Parameters[0].Value := 'BBM';
                       2020104 : Parameters[0].Value := 'BBK';
                       2020105 : Parameters[0].Value := 'BMM';
                       2020106 : Parameters[0].Value := 'BJK';
                       2020107 : Parameters[0].Value := 'PBL';
                       2020108 : Parameters[0].Value := 'PJL';
                       2020109 : Parameters[0].Value := 'BJP';
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
                    LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportJurnal3.fr3');
                  end;
                  frxReport1.ShowReport;
               end;
            end;
   20202 : begin
{
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
               //SQL.Add('exec sp_ViewReportBukuTambahan :0,:1,:2,:3,:4,:5');
               SQL.Add('exec SP_LapBKBesar :0,:1,:2,:3,:4');
               Prepared;
               Parameters[0].Value:=Perkiraan2.Text;
               Parameters[1].Value:=Perkiraan3.Text;
               Parameters[2].Value:=Awal3.Date;
               Parameters[3].Value:=Akhir3.Date;
               Parameters[4].Value:=Devisi3.Text;
               Parameters[5].Value:=IDUser;
               open;
              end;
              frxDBDataset2.DataSet := Quview;
              frxDBDataset2.Close;
              frxDBDataset2.Open;
              with frxReport1 do
              begin
               if PilihRp.Text='1' then
               LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBukuBesar1.fr3')
               else
               LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBukuBesar2.fr3');
              end;
              frxReport1.ShowReport;
}
             if (Devisi13.Text='') or (Perkiraan12.Text='') or (Perkiraan13.Text='') then
             begin
              if Devisi13.Enabled=true then
              ActiveControl:=Devisi13
             end else
             begin
              //Animate1.active := true;
              //Animate1.visible := true;
              TglAwal := EncodeDate(Tahun3.AsInteger, Bulan3.AsInteger, 1);
              TglAkhir := IncDay(IncMonth(TglAwal,1),-1);
              frxDBDataset2.DataSet.Close;
              with DM.QuCari do
              begin
               Close;
               SQL.Clear;
               SQL.Add('exec Sp_GenerateReportBukuTambahan :0,:1,:2,:3,:4,:5,:6,:7');
               Parameters[0].Value:=Bulan3.AsInteger;
               Parameters[1].Value:=Tahun3.AsInteger;
               Parameters[2].Value:=TglAwal;
               Parameters[3].Value:=TglAkhir;
               Parameters[4].Value:=Perkiraan12.Text;
               Parameters[5].Value:=Perkiraan13.Text;
               Parameters[6].Value:=Jurnal13.Text;
               Parameters[7].Value:=Devisi13.Text;
               try
               ExecSQL;
               except
               ShowMessage('Generate Report Gagal !');
               end;
              end;
              with QuView2 do
              begin
               Close;
               SQL.Clear;
               SQL.Add('exec SP_LapBKBesar :0,:1,:2,:3,:4');
               Prepared;
               Parameters[0].Value:=Perkiraan12.Text;
               Parameters[1].Value:=Perkiraan13.Text;
               Parameters[2].Value:=Bulan3.AsInteger;
               Parameters[3].Value:=Tahun3.AsInteger;
               Parameters[4].Value:=IDUser;
               open;
              end;
              frxDBDataset2.DataSet := Quview2;
              frxDBDataset2.Close;
              frxDBDataset2.Open;
              //Animate1.active := false;
              //Animate1.visible := false;
              with frxReport1 do
              begin
               if PilihRp13.Text='1' then
               LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBukuBesar1.fr3')
               else
               LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBukuBesar2.fr3');
              end;
              frxReport1.ShowReport;
             end;

            end;
     202021 : begin
              DecodeDate(Awal3.date,yy,mm,dd);
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
               SQL.Add('exec sp_ReportBukuTambahan :0,:1,:2,:3,:4,:5');
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
     20203 :
            begin     // Laporan Mutasi
            //if (IDUser='STELLA')or (IDUser='SULIS')or(IDUser='HANI') Then
              Begin
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
            // else ShowMessage('Not Access');  
            end;
    20204 :
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
   202041: begin
             frxDBDataset1.DataSet.Close;
             frxDBDataset1.DataSet := QuView;
             with QuView do
             begin
               Close;
               SQL.Clear;
               Case Counter.ItemIndex of
                 0 : begin
                       SQL.Add('exec Sp_LapBiayaTahun :0,:1,:2,:3');
                       Prepared;
                       Parameters[0].Value := Divisi4.Text;
                       Parameters[1].Value := Tahun1.AsInteger;
                       Parameters[2].Value := Perkiraan4.Text;
                       Parameters[3].Value := Perkiraan5.Text;
                       Open;
                       frxDBDataset1.Open;
                       frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBiayaTahunan.fr3');
                       frxReport1.ShowReport;
                     end;
                 1 : begin
                       SQL.Add('exec SP_LapBiayabulan :0,:1,:2,:3');
                       Prepared;
                       Parameters[0].Value := Divisi4.Text;
                       Parameters[1].Value := Tahun1.AsInteger;
                       Parameters[2].Value := Perkiraan4.Text;
                       Parameters[3].Value := Perkiraan5.Text;
                       Open;
                       frxDBDataset1.Open;
                       frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBiayabulanan.fr3');
                       frxReport1.ShowReport;
                     end;
               end
               
             end;
         end;
   20205 :
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
     20206 :
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
    20301 :
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
     20302 :
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
     20303 :
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
     20304 :
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
     20305 :
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
     20401,20406 :
            begin     // kartu Piutang
              frxDBDataset3.DataSet.Close;
              with QuView3 do
              begin
                 Close;
                 SQL.Clear;
                 if KodeReport=20406 Then
                 Begin
                 XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                          end;
                 SQL.Add('exec Sp_ReportPiutangDetail '+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal8.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir8.Date)))+',:0');
                 Parameters[0].Value:=XParameter;
                 end
                 else
                 Begin
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
                 end;
                 Open;
              end;
              frxDBDataset3.DataSet := Quview3;
              frxDBDataset3.Close;
              frxDBDataset3.Open;
              case kodereport of
               20401:
               Begin
                if Valas8.ItemIndex=0 then
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKartuPiutang1.fr3')
                else
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKartuPiutang2.fr3');
               End;
               20406:
               Begin
                if Valas8.ItemIndex=0 then
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKartuPiutangDetail1.fr3')
                else
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKartuPiutang2.fr3');
               End;
              End;
              frxReport1.ShowReport;
            end;
     20402 :
            begin     // Sisa Piutang
              frxDBDataset4.DataSet.Close;
              with QuView4 do
              begin
                 Close;
                 SQL.Clear;
                 if CBODet7.ItemIndex=0 then
                    SQL.Add('exec Sp_ReportSisaPiutangDet :0,:1,:2,:3,:4,:5,:6')
                 else if CBODet7.ItemIndex=1 then
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
                if CBODet7.ItemIndex=0 then
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSisaPiutangDet.fr3')
                Else if CBODet7.ItemIndex=1 then
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSisaPiutang2.fr3');
              end else
              begin
                  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSisaPiutang2Valas.fr3');
              end;
              frxReport1.ShowReport;
            end;
     20403 :
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
     20404 :
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
      204041 :
            begin     // Saldo Detail Piutang
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec SP_SaldoPiutangDetail :0,:1,:2,:3,:4,:5');
                 Prepared;
                 Parameters[0].Value:=Bulan8.AsInteger;
                 Parameters[1].Value:=Tahun8.AsInteger;
                 Parameters[2].Value:=Perkiraan8.Text;
                 Parameters[3].Value:=Awal8.Text;
                 Parameters[4].Value:=Akhir8.Text;
                 Parameters[5].Value:=Devisi8.Text;
                 Open;
              end;
              frxDBDataset1.DataSet := Quview;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSaldoPiutangDetail.fr3');
              frxReport1.ShowReport;
            end;
     20405 :
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
   20501 : begin
           // if (IDUser='STELLA')or (IDUser='SULIS')or(IDUser='HANI') Then
             Begin
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
             // else ShowMessage('Not Access');
            end;
     20502,
     20505 : begin
            // if (IDUser='STELLA')or (IDUser='SULIS')or(IDUser='HANI') Then
             Begin
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
                 Parameters[3].Value:=(KodeReport=20505);
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
              // else ShowMessage('Not Access');

              end;
     20503 : begin
             // if (IDUser='STELLA')or (IDUser='SULIS')or(IDUser='HANI') Then
              Begin
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
              // else ShowMessage('Not Access');
             end;
     20504 : begin
              if (IDUser='STELLA')or (IDUser='SULIS')or(IDUser='HANI') Then
              Begin
                frxDBDataset1.DataSet.Close;
                with QuView do
                begin
                 Close;
                 SQL.Clear;
                 SQL.Add('exec sp_LapNeracaPenunjang :0,:1,:2');
                 Prepared;
                 Parameters[0].Value:=Devisi2.Text;
                 Parameters[1].Value:=inttostr(Bulan.AsInteger);
                 Parameters[2].Value:=inttostr(Tahun.AsInteger);
                 Open;
                end;
                frxDBDataset1.DataSet := Quview;
                frxDBDataset1.Close;
                frxDBDataset1.Open;
                frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportNeracaPenunjang.fr3');
                frxReport1.ShowReport;
               end;
              //else ShowMessage('Not Access');
             end;
    251010,251020,251030,251040,251050,252010,252020,252030,252040,252050,301010,301020,301030,301040,301050,
    302010,302020,302030,302040,302050:
            begin
            frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
                case kodereport of
                251010,251020,251030,251040,251050:sql.add('Select * from VwreportPembelian');
                252010,252020,252030,252040,252050:sql.add('Select * from VwreportRBeli');
                301010,301020,301030,301040,301050:sql.add('Select * from VwreportJual');
                302010,302020,302030,302040,302050:sql.add('Select * from VwreportRJual');
                end;
               SQL.Add('where Tanggal between '+QuotedStr(FormatDateTime('MM/dd/yyyy',Awal15.Date))+' and '+QuotedStr(FormatDateTime('MM/dd/yyyy',Akhir15.Date)));
               case kodereport of
               251050,252050,301050,302050:
                begin
                if (trim(kodetipe15.text)<>'') then sql.Add('and kodetipe='+QuotedStr(KodeTipe15.Text)) ;
                if (trim(kodeSubtipe15.text)<>'') then sql.Add('and kodeSubtipe='+QuotedStr(KodeSubTipe15.Text));
                end;
               end;
               if SelectedSemuaRecord =false then
               begin
                case kodereport of
                251010,252010,301010,302010:SQL.Add('and Nobukti in (');
                251020,252020,301020,302020:SQL.Add('and KodeCustSupp in (');
                251030,252030,301030,302030:SQL.Add('and AccPersediaan in (');
                251040,252040,301040,302040:SQL.Add('and AccHutpiut in (');
                end;
               IsiDariListBox1(QuView);
               end;
               case kodereport of
               251010,252010,301010,302010:SQL.Add('order by Nobukti ');
               251020,252020,301020,302020:SQL.Add('order by KodeCustSupp ');
               251030,252030,301030,302030:SQL.Add('order by AccPersediaan ');
               251040,252040,301040,302040:SQL.Add('order by AccHutpiut ');
               251050,252050,301050,302050:SQL.Add('order by KodeTipe,KodeSubtipe');
               end;
               Open;
               frxDBDataset1.DataSet:=QuView;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               with  frxReport1 do
               begin
                case kodereport of
                251010:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliPerNobukti.fr3');
                251020:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliPerSupplier.fr3');
                251030:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliPerAccpersediaan.fr3');
                251040:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliPerAcchutang.fr3');
                251050:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliPerTipe.fr3');

                252010:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRBeliPerNobukti.fr3');
                252020:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRBeliPerSupplier.fr3');
                252030:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRBeliPerAccpersediaan.fr3');
                252040:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRBeliPerAcchutang.fr3');
                252050:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRBeliPerTipe.fr3');

                301010:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportJualPerNobukti.fr3');
                301020:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportJualPerSupplier.fr3');
                301030:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportJualPerAccpersediaan.fr3');
                301040:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportJualPerAcchutang.fr3');
                301050:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportJualPerTipe.fr3');

                302010:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRjualPerNobukti.fr3');
                302020:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRjualPerSupplier.fr3');
                302030:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportjualPerAccpersediaan.fr3');
                302040:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportjualPerAcchutang.fr3');
                302050:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportjualPerTipe.fr3');
                end;
                ShowReport;
               end;
              end;
            end;
            253010:
            begin
            frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
               Sql.add('Exec Sp_ReportOutStandingSPk :0,:1');
               parameters[0].value:=Bulan16.value;
               Parameters[1].Value:=Tahun16.value;
               open;
               frxDBDataset1.DataSet:=QuView;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               with  frxReport1 do
               LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOUtStandingSPkPerNobukti.fr3');
              end;
             frxReport1.ShowReport;
            end;
            ///
            303701,303702,303703:
              Begin
               XParameter:='';
              if SelectedSemuaRecord=false then
               begin
                for i:= 0 to ListBox1.Count-1 do
                 begin
                   if ListBox1.Count=1 Then
                   XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                   else
                    Begin
                      if i=ListBox1.Count-1 then
                      XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                      else if i=0 Then
                      XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                      else
                      XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                    end;
                 end;
               end;
               frxDBDataset1.DataSet.Close;
               with QuView do
              begin
                Close;
                SQL.Clear;
                SQL.Add('exec [Sp_ReportSOvsSPKvsHasilPrd] :0,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:1');
                if KodeReport=303701 Then
                 Parameters[0].Value:='N'
                else if KodeReport=303702 Then
                 Parameters[0].Value:='B'
                else   Parameters[0].Value:='C';
                Parameters[1].Value:=XParameter;
                Open;
              end;
              with  frxReport1 do
               Begin
               if KodeReport=303701 Then
                 LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSOvsSPKperNoBukti.fr3')
               else if KodeReport=303702 Then
                 LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSOvsSPKperBarang.fr3')
               else
                 LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSOvsSPKperCustomer.fr3');
               end;
             frxReport1.ShowReport;
             end;
            ///
            303801,303802,303803:
              Begin
               XParameter:='';
              if SelectedSemuaRecord=false then
               begin
                for i:= 0 to ListBox1.Count-1 do
                 begin
                   if ListBox1.Count=1 Then
                   XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                   else
                    Begin
                      if i=ListBox1.Count-1 then
                      XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                      else if i=0 Then
                      XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                      else
                      XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                    end;
                 end;
               end;
               frxDBDataset1.DataSet.Close;
               with QuView do
              begin
                Close;
                SQL.Clear;
                SQL.Add('exec [Sp_ReportReportKPvsSJVsSaku] :0,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:1');
                if KodeReport=303801 Then
                 Parameters[0].Value:='N'
                else if KodeReport=303802 Then
                 Parameters[0].Value:='B'
                else   Parameters[0].Value:='C';
                Parameters[1].Value:=XParameter;
                Open;
              end;
              with  frxReport1 do
               Begin
               if KodeReport=303801 Then
                 LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKontrakvsSJperNoBukti.fr3')
               else if KodeReport=303802 Then
                 LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKontrakvsSJperBarang.fr3')
               else
                 LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKontrakvsSJperCustomer.fr3');
               end;
             frxReport1.ShowReport;
             end;
            ///
            60:
            Begin
             XParameter:='';
             if SelectedSemuaRecord=false then
              begin
                for i:= 0 to ListBox1.Count-1 do
                 begin
                   if ListBox1.Count=1 Then
                   XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                   else
                    Begin
                      if i=ListBox1.Count-1 then
                      XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                      else if i=0 Then
                      XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                      else
                      XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                    end;
                 end;
               end;
            frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
               SQL.Add('exec [Sp_ReportKartuProyek] '+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:0');
                Parameters[0].Value:=XParameter;
               Open;
              end;
              with  frxReport1 do
               Begin
                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKartuProyek.fr3');
               end;
             frxReport1.ShowReport;
            end;
            6101,6102:
            Begin
             XParameter:='';
             if SelectedSemuaRecord=false then
              begin
                for i:= 0 to ListBox1.Count-1 do
                 begin
                   if ListBox1.Count=1 Then
                   XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                   else
                    Begin
                      if i=ListBox1.Count-1 then
                      XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                      else if i=0 Then
                      XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                      else
                      XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                    end;
                 end;
               end;
            frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
               SQL.Add('exec [Sp_report_CashBack] '+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:0');
               Parameters[0].Value:=XParameter;
               Open;
              end;
              with  frxReport1 do
               Begin
               if KodeReport=6101 Then
                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportCashBackDet.fr3')
               else
                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportCashBackRek.fr3');
               end;
             frxReport1.ShowReport;
            end;
            2530201,2530202, 2530203
            ,2540101,2540102,2540103,
            2540201,2540202,2540203,
            25501,25502,25503,
            2560101,2560102,2560103,
            2560201,2560202,2560203,2560204,
            25701,25702,25703,25704,
            25711,25712,25713,
            25721,25722,25723,
            25731,25732,25733,
            25741,25742,
            25761,25762,25763 :
            begin
             frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
                case kodereport of
                2530201,2530202,2530203, 2540101,2540102,2540103,
                2540201,2540202,2540203,25501,25502,25503,2560101,2560102,2560103,2560201,2560202,2560203,2560204,
                25701,25702,25703,25704,25711,25712,25713,25721,25722,25723,25731,25732,25733,25741,25742,25761,25762,25763:
                    begin
                    if Cbojns.ItemIndex=0 then
                        begin
                         case kodereport of
                         2540101,2540102,2540103:sql.add('Exec  Sp_reportoutStandingPR :0,:1,:2,:3,:4 ');
                         2530201,2530202, 2530203:sql.add('Exec  Sp_ReportPurchasingReqDet :0,:1,:2,:3,:4,:5 ');
                         2540201,2540202,2540203:sql.add('Exec  Sp_ReportPOdet :0,:1,:2,:3,:4,:5 ');
                         25501,25502,25503:sql.add('Exec  Sp_ReportRevisiPOdet :0,:1,:2,:3,:4 ');
                         2560101,2560102,2560103:sql.add('Exec  Sp_ReportOutstandingPOdet :0,:1,:2,:3,:4,:5');
                         2560201,2560202,2560203,2560204:sql.add('Exec  Sp_ReportBeliGudangDet :0,:1,:2,:3,:4');
                         25701,25702,25703,25704:sql.add('Exec  Sp_ReportBeliRejectDet :0,:1,:2,:3,:4');
                         25711,25712,25713:
                         Begin
                         XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                          end;
                         sql.add('Exec  Sp_reportBeliAccDet :0,:1,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:2,'+IntToStr(CboOto.ItemIndex)+','+IntToStr(ComboBox1.ItemIndex)+'');
                         end;
                         25721,25722,25723,25761,25762,25763:sql.add('Exec  Sp_reportRBeliGDGdet :0,:1,:2,:3,:4,:5');
                         25731,25732,25733:sql.add('Exec  Sp_ReportDebetnoteDet :0,:1,:2,:3,:4,:5');
                         25741,25742 :sql.add('Exec  Sp_reportInVoiceDet :0,:1,:2,:3,:4,:5');
                         //25761,25762,25763 :sql.add('Exec  Sp_reportRInVoiceDet :0,:1,:2,:3,:4');
                         end;

                         Parameters[0].value:='T';
                          case kodereport of
                            2530201,2540201,25501,2560101,2560201,25701,25711,25721,25731,25741,25761,2540101 : Parameters[1].Value:='N';
                            2530202,2540202,25502,2560102,2560202,25702,25712,25722,25732,25743,25763,2540102 : Parameters[1].Value:='B';
                            2530203,2540203,25503,2560103,2560203,25703,25713,25723,25733,25742,25762,2540103 : Parameters[1].Value:='S';
                            2560204,25704:Parameters[1].Value:='G';
                          end;
                          if  (kodereport=25711)or(kodereport=25712)or(kodereport=25713)Then
                          Parameters[2].Value:=XParameter
                          else
                          Begin
                          Parameters[2].Value:=TglAwal13.Date;
                          Parameters[3].Value:=TglAkhir13.Date;
                          Parameters[4].Value:='';
                          end;

                          case kodereport of
                          2530201,2530202,2530203,2540201,2540202,2540203,25741,25742,25721,25722,25723,25761,25762,25763,
                          25731,25732,25733:
                          Parameters[5].value:= CboOto.ItemIndex;

                          end;
                          case kodereport of
                          2560101,2560102,2560103:Parameters[5].Value:=sls.value;
                          End;


                        end
                    else  if Cbojns.ItemIndex=1 then
                     begin
                       case kodereport of
                        2540201,2540202,2540203:Sql.add('Exec Sp_ReportPORek :0,:1,:2,:3')  ;
                        25501,25502,25503:Sql.add('Exec Sp_ReportRevisiPORek :0,:1,:2')  ;
                        2560101,2560102,2560103:Sql.add('Exec Sp_ReportOutStandingPORek :0,:1,:2')  ;
                        2560201,2560202,2560203:Sql.add('Exec Sp_ReportBeliGudangRek :0,:1,:2')  ;
                        25701,25702,25703 :Sql.add('Exec Sp_ReportBeliRejectRek :0,:1,:2')  ;
                        25711,25712,25713 :Sql.add('Exec Sp_ReportBeliACCRek :0,:1,:2,:3')  ;
                        25721,25722,25723 :Sql.add('Exec Sp_ReportRPembelianGDGRek :0,:1,:2,:3')  ;
                        25731,25732,25733:Sql.add('Exec Sp_ReportDebetNoteRek :0,:1,:2')  ;
                        25741,25742 :sql.add('Exec Sp_ReportinvoiceRek :0,:1,:2,:3');
                        25761,25762,25763 :sql.add('Exec Sp_ReportRinvoiceRek :0,:1,:2,');
                       end ;
                       case kodereport of
                        2530101,2530201,2540101,2540201,25501,2560101,2560201,25701,25711,25721,25731,25741,25761 :Parameters[0].Value:='N';
                        2530102,2530202,2540102,2540202,25502,2560102,2560202,25702,25712,25722,25732,25743,25763 :Parameters[0].Value:='B';
                        2530103,2530203,2540103,2540203,25503,2560103,2560203,25703,25713,25723,25733,25742,25762 :Parameters[0].Value:='S';
                       end;
                       Parameters[1].Value:=TglAwal13.Date;
                       Parameters[2].Value:=TglAkhir13.Date;
                       case kodereport of
                       2540201,2540202,2540203,25711,25712,25713,25741,25742,25721,25722,25723,402021,402022
                       :parameters[3].value:=CboOto.itemindex;
                       end;
                     end
                    else
                     begin
                     ShowMessage('Pilih Jenis Rekap');
                     ActiveControl:=Cbojns;
                     exit;
                     end;
                    end;
                end;


                if SelectedSemuaRecord =false then
                 begin
                  case kodereport of
                  2530101,2530201,2540101,2540201,25501,2560101,2560201,25701,25721,25731:SQL.Add('and Nobukti in (');
                  2530102,2530202,2540102,2540202,25502,2560102,2560202,25702,25722,25732:SQL.Add('and kodeBrg in (');
                  2530103,2530203,2540103,2540203,25503,2560103,2560203,25703,25723,25733:SQL.Add('and KodeCustSupp in (');
                  end;
                 if  (kodereport=25711)or(kodereport=25712)or(kodereport=25713)Then
                 else
                 IsiDariListBox1(QuView);
                 end;


                open;
               frxDBDataset1.DataSet:=QuView;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               with  frxReport1 do
                 begin
                   case Kodereport of
                   2530201:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPurchReqPerNobukti.fr3');
                   2530202:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPurchReqPerBarang.fr3');
                   2530203:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPurchReqPerSupplier.fr3');

                   2540101:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingPrPernobukti.fr3');
                   2540102:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingPrPerBarang.fr3');
                   2540103:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingPrPerSupplier.fr3');

                   2540201:begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPoPerNobukti.fr3')
                            else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPoPerNobuktiRek.fr3')
                           end;
                   2540202:begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPoPerBarang.fr3')
                            else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPoPerBarangRek.fr3')
                           end;
                   2540203:Begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPoPerSupplier.fr3')
                            else
                               LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPoPerSupplierRek.fr3')
                           End;

                   25501:  begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRevisiPoPerNobukti.fr3')
                            else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRevisiPoPerNobuktiRek.fr3');
                           end;
                   25502:  begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRevisiPoPerBarang.fr3')
                            else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRevisiPoPerBarangRek.fr3');
                           end;
                   25503:  begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRevisiPoPerSupplier.fr3')
                            else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRevisiPoPerSupplierRek.fr3');
                            end;
                   2560101:begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingPoPerNobukti.fr3')
                            else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingPoPerNobuktiRek.fr3');
                            End;
                   2560102:begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingPoPerBarang.fr3')
                            else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingPoPerBarangRek.fr3');
                            End;
                   2560103:Begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingPoPerSupplier.fr3')
                            else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingPoPerSupplierRek.fr3');
                            end;
                   2560201:Begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeligudangPerNobukti.fr3')
                            else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeligudangPerNobuktiRek.fr3');
                            End;
                   2560202: Begin
                             if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeligudangPerBarang.fr3')
                             else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeligudangPerBarangRek.fr3');
                            End;
                   2560203: Begin
                             if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeligudangPerSupplier.fr3')
                             else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeligudangPerSupplierRek.fr3');
                            End;
                   2560204: Begin
                             if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeligudangPerGudang.fr3')
                             else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeligudangPerSupplierRek.fr3');
                            End;
                   25701 :  begin
                             if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliRejectPerNobukti.fr3')
                             else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliRejectPerNobuktiRek.fr3');
                            end;
                   25702 :  Begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliRejectPerBarang.fr3')
                            else
                               LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliRejectPerBarangRek.fr3');
                            end;
                   25703 :  Begin
                             if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliRejectPerSupplier.fr3')
                             else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliRejectPerSupplierRek.fr3');
                            End;
                   25704 :  Begin
                             if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliRejectPerGudang.fr3')
                             else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBeliRejectPerSupplierRek.fr3');
                            End;
                   25711 :  Begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPenerimaanAccPerNoBukti.fr3')
                            else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPenerimaanAccPerNoBuktiRek.fr3')  ;
                            End;
                   25712 :  Begin
                            if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPenerimaanAccPerBarang.fr3')
                            else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPenerimaanAccPerBarangRek.fr3');
                            End;
                   25713 :  Begin
                              if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPenerimaanAccPerSupplier.fr3')
                              else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPenerimaanAccPerSupplierRek.fr3');
                            End;
                   25721:   Begin
                              if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPembelianGdgPerNoBukti.fr3')
                              else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPembelianGdgPerNoBuktiRek.fr3');
                            End;
                   25722:   begin
                              if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPembelianGdgPerBarang.fr3')
                              else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPembelianGdgPerBarangRek.fr3');
                            End;
                   25723:   Begin
                              if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPembelianGdgPerSupplier.fr3')
                              else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPembelianGdgPerSupplierRek.fr3');
                            End;
                   25731:   Begin
                               if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportDebetNotePerNoBukti.fr3')
                               else
                                 LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportDebetNotePerNoBuktirek.fr3');
                            End;
                   25732:   Begin
                                if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportDebetNotePerBarang.fr3')
                                else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportDebetNotePerBarangRek.fr3');
                            End;
                   25733:   Begin
                                if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportDebetNotePerSupplier.fr3')
                                else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportDebetNotePerSupplierRek.fr3');
                            End;
                   25741:   Begin
                                if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportInvoicePerNobukti.fr3')
                                else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportInvoicePerNobuktiRek.fr3');
                            End;
                   25742:   Begin
                                if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportInvoicePerSupplier.fr3')
                                else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportInvoicePerSupplierRek.fr3');
                            End;
                   25761:   Begin
                                if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportInvoiceRPerNobukti.fr3')
                                else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportInvoiceRPerNobuktiRek.fr3');
                            End;
                   25763:   Begin
                                if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportInvoiceRPerbarang.fr3')
                                else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportInvoiceRPerbarangRek.fr3');
                            End;
                   25762:   Begin
                                if Cbojns.ItemIndex=0 then
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportInvoiceRPerSupplier.fr3')
                                else
                                LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportInvoiceRPerSupplierRek.fr3');
                            End;
                   End;


                 ShowReport
                end;

              end;
            end;
            30314:
            Begin
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
               XParameter:='';
               if SelectedSemuaRecord=false then
                 begin
                  for i:= 0 to ListBox1.Count-1 do
                  begin
                   if ListBox1.Count=1 Then
                    XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                   else
                    Begin
                      if i=ListBox1.Count-1 then
                       XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                      else if i=0 Then
                       XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                      else
                       XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                    end;
                  end;
                end;
                sql.add('Exec  [Sp_ReportCashBack] '+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:0');
                Parameters[0].Value:=XParameter;
                open;
              end;

               frxDBDataset1.DataSet:=QuView;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               with  frxReport1 do
                 begin
                   LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportCashBack.fr3');
                   ShowReport ;
                 end;
            end;
            3032411:
            Begin
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
               XParameter:='';
               if SelectedSemuaRecord=false then
                 begin
                  for i:= 0 to ListBox1.Count-1 do
                  begin
                   if ListBox1.Count=1 Then
                    XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                   else
                    Begin
                      if i=ListBox1.Count-1 then
                       XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                      else if i=0 Then
                       XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                      else
                       XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                    end;
                  end;
                end;
                sql.add('Exec  [Sp_ReportFakturPenjualan] '+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:0');
                Parameters[0].Value:=XParameter;
                open;
              end;

               frxDBDataset1.DataSet:=QuView;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               with  frxReport1 do
                 begin
                   LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportFakturPenjualan.fr3');
                   ShowReport ;
                 end;
            end;

            3030101,3030102,3030103,3030104,
            3030201,3030202,3030203,
            3031101,3031102,3031103,
            3031201,3031202,3031203,
            3032101,3032102,3032103,
            3032201,3032202,3032203,
            3032301,3032302,3032303,
            3033101,3033102,3033103,
            3033201,3033202,3033203,3033204,
            303410,303420,303430,303440,303241,303242,303321,303322,303323  :
            begin
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
               case kodereport of
               3030101,3030102,3030103,3030104,3030201,3030202,3030203,3031101,3031102,3031103,3031201,3031202,3031203,
               3032101,3032102,3032103,3032201,3032202,3032203,3032301,3032302,3032303,3033101,3033102,3033103,3033201,3033202,3033203,3033204,
               303410,303420,303430,303440,303241,303242,303321   :
                   begin
                      if  (kodereport =303241) or(kodereport =303321)Then
                      Begin
                       XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                         end;
                      end;
                      if  kodereport =303242 Then
                      Begin
                       XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                         end;
                        end; 
                   { sql.add('Exec  [Sp_reportLabaProyekRekap] '+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tgl19.Date)))+',:0 ');
                    Parameters[0].Value:=XParameter;
                    Open;
                    end;
         frxDBDataset1.DataSet:=QuView;
         frxDBDataset1.Close;
         frxDBDataset1.Open;
         frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportLabaRugiProyekRekap.fr3');
         frxReport1.ShowReport; }
                    if KodeReport=303321 Then
                      Begin
                       sql.add('Exec  sp_LapDP '+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:0');
                       Parameters[0].Value:=XParameter;
                      end
                      else
                      Begin
                      if Cbojns.ItemIndex=0 then
                        begin
                         XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                         end;
                         case kodereport of
                         3030101,3030102,3030103,3030104 :sql.add('Exec  Sp_reportSoDet :0,:1,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglawal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglakhir13.Date)))+',:2,:3');
                         3030201,3030202,3030203 :sql.add('Exec  Sp_ReportOutStandingSoDet :0,:1,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglawal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglakhir13.Date)))+',:2');
                         3031101,3031102,3031103 :sql.add('Exec  Sp_reportOutSoDet :0,:1,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglawal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglakhir13.Date)))+',:2');
                         3031201,3031202,3031203 :sql.add('Exec  Sp_reportSppdet :0,:1,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglawal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglakhir13.Date)))+',:2,:3');
                         3032101,3032102,3032103 :sql.add('Exec  Sp_ReportOutSPPdet :0,:1,:2,:3,:4');
                         3032201,3032202,3032203 :sql.add('Exec  Sp_reportSpbdet :0,:1,:2,:3,:4,:5');
                         3032301,3032302,3032303 :if CBR.Checked Then sql.add('Exec  [Sp_ReportSPBACCPlusDet] :0,:1,:2,:3,:4,:5')
                                                  else sql.add('Exec  Sp_reportSpbACCdet :0,:1,:2,:3,:4,:5');
                         3033101,3033102,3033103 :sql.add('Exec  Sp_ReportOUtSPBDet :0,:1,:2,:3,:4');
                         3033201,3033202,3033203,3033204 :sql.add('Exec  Sp_reportINvoicePenjualanDet :0,:1,:2,:3,:4,:5');
                         303410,303420,303430,303440    :sql.add('Exec  Sp_reportRInvoicePenjualanDet :0,:1,:2,:3,:4,:5');
                         303241:sql.add('Exec  [Sp_ReportRekapKirim] '+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglawal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglakhir13.Date)))+',:0 ');
                         303242:sql.add('Exec [Sp_ReportKontrakVsSJ]  '+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglawal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',Tglakhir13.Date)))+',:0 ');
                         End;
                         if (Kodereport=303241)or(KodeReport=303242)
                         Then Parameters[0].value:=XParameter
                         else if  (Kodereport=303322) or (Kodereport=303323) Then
                         else
                         Parameters[0].value:='T';
                          case kodereport of
                            3030101,3030201,3031101,3031201,3032101,3032201,3033101,3033201,303410,3032301: Parameters[1].Value:='N';
                            3030102,3030202,3031102,3031202,3032102,3032202,3033102,3033202,303420,3032302: Parameters[1].Value:='B';
                            3030103,3030203,3031103,3031203,3032103,3032203,3033103,3033203,303430,3032303: Parameters[1].Value:='C';
                            3033204,303440:Parameters[1].Value:='S';
                            3030104:Parameters[1].Value:='D';
                          end;
                          if  (KodeReport=303241)or(KodeReport=303242) Then
                          else if  (KodeReport=3030101)or(KodeReport=3030102)or(KodeReport=3030103) or(KodeReport=3030104)or
                           (KodeReport=3031101)or(KodeReport=3031102)or(KodeReport=3031103)   or
                           (KodeReport=3030201)or(KodeReport=3030202)or(KodeReport=3030203)   or
                           (KodeReport=3031201)or(KodeReport=3031202)or(KodeReport=3031203)
                           Then
                           Begin
                            Parameters[2].Value:=XParameter;
                           if  (KodeReport=3030101)or(KodeReport=3030102)or(KodeReport=3030103) or (KodeReport=3030104) or
                               (KodeReport=3031201)or(KodeReport=3031202)or(KodeReport=3031203) Then
                            Parameters[3].Value:=IntToStr(CboOto.ItemIndex);
                           end
                          else
                          Begin
                           Parameters[2].Value:=TglAwal13.Date;
                           Parameters[3].Value:=TglAkhir13.Date;
                           Parameters[4].Value:='';
                          end;
                          case kodereport of
                          3032201,3032202,3032203,3033201,3033202,3033203,3033204,
                          303410,303420,303430,303440,3032301,3032302,3032303
                          :parameters[5].value:=CboOto.ItemIndex;
                          end;
                        end
                     else  if Cbojns.ItemIndex=1 then
                        Begin
                         Case Kodereport of
                         3030101,3030102,3030103 :sql.add('Exec Sp_reportSORek :0,:1,:2,:3');
                         3030201,3030202,3030203 :sql.add('Exec Sp_reportOutStandingSORek :0,:1,:2');
                         3031101,3031102,3031103 :sql.add('Exec Sp_ReportOutSORek :0,:1,:2');
                         3031201,3031202,3031203 :sql.add('Exec Sp_reportSPPRek :0,:1,:2,:3');
                         3032101,3032102,3032103 :sql.add('Exec Sp_ReportOutSppRek :0,:1,:2');
                         3032201,3032202,3032203 :sql.add('Exec Sp_reportSPbRek :0,:1,:2,:3');
                         3032301,3032302,3032303 :sql.add('Exec Sp_reportSPbACCRek :0,:1,:2,:3');
                         3033101,3033102,3033103 :sql.add('Exec Sp_ReportOUtSPBRek :0,:1,:2');
                         3033201,3033202,3033203,3033204 :sql.add('Exec Sp_reportInvoicePenjualanrek :0,:1,:2,:3');
                         303410,303420,303430,303440    :sql.add('Exec Sp_reportRInvoicePenjualanRek :0,:1,:2,:3');
                         End;
                         case kodereport of

                          3030101,3030201,3031101,3031201,3032101,3032201,3033101,3033201,303410,3032301:Parameters[0].Value:='N';
                          3030102,3030202,3031102,3031202,3032102,3032202,3033102,3033202,303420,3032302:Parameters[0].Value:='B';
                          3030103,3030203,3033204,303440:Parameters[0].Value:='S';
                          3031103,3031203,3032103,3032203,3033103,3033203,303430,3032303: Parameters[0].Value:='C';
                         end;
                         Parameters[1].Value:=TglAwal13.Date;
                         Parameters[2].Value:=TglAkhir13.Date;
                         case kodereport of
                         3030101,3030102,3030103,3031201,3031202,3031203,3032201,3032202,3032203,3033201,3033202,3033203,3033204,
                         303410,303420,303430,303440,3032301,3032302,3032303
                         :Parameters[3].Value:=CboOto.ItemIndex;
                         End
                        End
                    else
                       begin
                       ShowMessage('Pilih Jenis Rekap');
                       ActiveControl:=Cbojns;
                       exit;
                       end;
                   End;
               End;
               end;///-----end report selain sp_LapDP
               {if (SelectedSemuaRecord =false) and (KodeReport<>303321) then
               begin
                case kodereport of
                3030201:SQL.Add('and Nobukti in (');
                3030202:SQL.Add('and kodeBrg in (');
                3030203:SQL.Add('and KodeCustSupp in (');
                End;
                Case  KodeReport=303241)or(KodeReport=303242) Then
                else
                IsiDariListBox1(QuView);
               End; }
               if kodereport=303322 Then
                Begin
                  sql.add('Exec [Sp_ReportInvoicePenjualan_DP] :0,:1,:2');
                  Parameters[0].Value:='N';
                  Parameters[1].Value:=TglAwal13.Date;
                  Parameters[2].Value:=TglAkhir13.Date;
                end;
                if kodereport=303323 Then
                Begin
                  sql.add('Exec Sp_ReportLabaKotor :0,:1');
                  Parameters[0].Value:=TglAwal13.Date;
                  Parameters[1].Value:=TglAkhir13.Date;
                end;
               open;
               frxDBDataset1.DataSet:=QuView;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               with  frxReport1 do
                 begin
                   case Kodereport of
                    303241 :begin
                             LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRekapKirim.fr3')
                            end;
                    303242 :begin
                             LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportKontrakvsSJ.fr3')
                            end;
                    3030101:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSObaruPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSObaruPerNobuktiRek.fr3');
                          End;
                    3030102:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSObaruPerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSObaruPerBarangRek.fr3');
                          End;
                    3030103:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSOBaruPerSupplier.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSObaruPerSupplierRek.fr3');
                          End;
                    3030104:Begin
                              LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportHPPSO.fr3')
                             End;

                    3030201:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutSObaruPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutSObaruPerNobuktiRek.fr3');
                          End;
                    3030202:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutSObaruPerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutSObaruPerBarangRek.fr3');
                          End;
                    3030203:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutSOBaruPerSupplier.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutSObaruPerSupplierRek.fr3');
                          End;
                    3031101:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSoxPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSoxPerNobuktiRek.fr3');
                          End;
                    3031102:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSoxPerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSoxPerBarangRek.fr3');
                          End;
                    3031103:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSoxPerCustomer.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSoxPerCustomerRek.fr3');
                          End;
                    3031201:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1PerNoBukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1PerNoBuktiRek.fr3');
                          End;
                    3031202:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1PerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1PerBarangRek.fr3');
                          End;
                    3031203:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1PerCustomer.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1PerCustomerRek.fr3');
                          End;
                    3032101:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1xPerNoBukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1xPerNoBuktirek.fr3');
                          End;
                    3032102:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1xPerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1xPerBarangRek.fr3');
                          End;
                    3032103:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1xPerCustomer.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpp1xPerCustomerRek.fr3');
                          End;
                    3032201:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbbaruPernobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbbaruPernobuktiRek.fr3');
                          End;
                    3032202:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbbaruPerbarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbbaruPerbarangRek.fr3');
                          End;
                    3032203:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbbaruPerCustomer.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbbaruPerCustomerRek.fr3');
                          End;

                    3032301:begin
                            if Cbojns.ItemIndex=0 then
                            Begin
                             if CBR.Checked Then LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbACCPernobuktiPlus.fr3')
                             else LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbACCPernobukti.fr3');
                            end
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbACCPernobuktiRek.fr3');
                          End;
                    3032302:begin
                            if Cbojns.ItemIndex=0 then
                            Begin
                            if CBR.Checked Then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbACCPerbarangPlus.fr3')
                            else LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbACCPerbarang.fr3')
                            end
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbACCPerbarangRek.fr3');
                          End;
                    3032303:begin
                            if Cbojns.ItemIndex=0 then
                            Begin
                            if CBR.Checked Then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbACCPerCustomerPlus.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbACCPerCustomer.fr3')
                            end
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSpbACCPerCustomerRek.fr3');
                          End;
                    3033101:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSPPbPernobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSPPbPernobuktiRek.fr3');
                          End;
                    3033102:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSPPbPerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSPPbPerBarangRek.fr3');
                          End;
                    3033103:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSPPbPerCustomer.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSPPbPerCustomerrek.fr3');
                          End;
                    3033201:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPLInvoicePerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPLInvoicePerNobuktiRek.fr3');
                          End;
                    3033202:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPLInvoicePerbarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPLInvoicePerbarangRek.fr3');
                          End;
                     3033203:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPLInvoicePerCustomer.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPLInvoicePerCustomerRek.fr3');
                          End;
                     3033204:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPLInvoicePerSales.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPLInvoicePerSalesRek.fr3');
                          End;
                     303410:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPLInvoicePerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPLInvoicePerNobuktiRek.fr3');
                          End;
                    303420:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPLInvoicePerbarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPLInvoicePerbarangRek.fr3');
                          End;
                     303430:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPLInvoicePerCustomer.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPLInvoicePerCustomerRek.fr3');
                          End;
                     303440:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPLInvoicePersales.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPLInvoicePerSalesRek.fr3');
                          End;
                     303321:Begin
                            if Cbojns.ItemIndex=0 Then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportDP.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportDPRekap.fr3');
                            end;
                     303322:Begin
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPLInvoice_DPP.fr3')
                            end;
                     303323:Begin
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportLabaKotor.fr3')
                            end;
                   End;
                   ShowReport ;
                 End;

              End;
            end;


            35101,35102 :
            Begin
             frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
                case kodereport of
                 35101,35102 :
                             begin
                               if Cbojns.ItemIndex=0 then
                                  begin
                                   case kodereport of
                                   35101,35102:sql.add('Exec Sp_reportSPRK :0,:1,:2,:3,:4,:5');
                                   End;
                                   Parameters[0].Value:='T';
                                   case kodereport of
                                   35101:Parameters[1].Value:='N';
                                   35102:Parameters[1].Value:='B';
                                   End;
                                   Parameters[2].Value:=TglAwal13.Date;
                                   Parameters[3].Value:=TglAkhir13.Date;
                                   parameters[4].Value:='';
                                   parameters[5].Value:=CboOto.ItemIndex;
                                  end
                               else  if Cbojns.ItemIndex=1 then
                                  Begin
                                   Case Kodereport of
                                    35101,35102:sql.add('Exec Sp_reportSPRKRek :0,:1,:2,:3');
                                   End;
                                   case kodereport of
                                    35101:Parameters[0].Value:='N';
                                    35102:Parameters[0].Value:='B';
                                   end;
                                   Parameters[1].Value:=TglAwal13.Date;
                                   Parameters[2].Value:=TglAkhir13.Date;
                                   parameters[3].Value:=CboOto.ItemIndex;
                                  End
                              else
                                 begin
                                 ShowMessage('Pilih Jenis Rekap');
                                 ActiveControl:=Cbojns;
                                 exit;
                                 end;
                             End;
                end;

               open;
               frxDBDataset1.DataSet:=QuView;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               with  frxReport1 do
                 begin
                   case Kodereport of
                    35101:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSPRKPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSPRKPerNobuktiRek.fr3');
                          End;
                    35102:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSPRKPerbarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSPRKPerbarangRek.fr3');
                          End;
                   End;
                   ShowReport ;
                 End;
              End;
            End;
             //gudang
            4010101,4010102:    //OUtStandingSPK
            Begin
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
               sql.add('Exec Sp_reportOutSpk :0,:1,:2,:3,:4');
               Parameters[0].Value:='T';
               case kodereport of
               4010101:Parameters[1].Value:='N';
               4010102:Parameters[1].Value:='B';
               End;
               Parameters[2].Value:=TglAwal13.Date;
               Parameters[3].Value:=TglAkhir13.Date;
               parameters[4].Value:='';
               OPen;
               frxDBDataset1.DataSet:=QuView;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               with  frxReport1 do
               begin
                 case Kodereport of
                  4010101:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutSPKPerNobukti.fr3');
                  4010102:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutSPKPerBarang.fr3');
                 End;
                ShowReport;
               End;
              End;
            End;

            4010201,4010202,401020201,4010203,4010204,4010205,
            4010301,4010302,
            40201,40202,
            40301,40302,40303,
            40351,40352,40353,
            4040101,4040102,
            4040201,4040202,
            40501,40502,
            40701,40702,
            40801,40802
            ,402021,402022
            ,40361,40362,
            40851,40852
            ,40861,40862,4011:
            Begin
              frxDBDataset1.DataSet.Close;
              with QuView do
              begin
               Close;
               SQL.Clear;
                case kodereport of
                 4010201,4010202,401020201,4010203,4010204,4010205,40201,40202,40301,40302,40303,4040101,4040102,4040201,4040202,40501,40502,40701,40702,40801,40802,
                 40351,40352,40353,4010301,4010302,402021,402022,40361,40362,40851,40852,40861,40862,4011 :
                   begin
                     if kodereport=4011 Then
                     Begin
                      XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                          end;
                       sql.add('Exec [Sp_ReportSPK] '+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:0');
                       Parameters[0].Value:=XParameter;
                       open;
                       frxDBDataset1.DataSet:=QuView;
                       frxDBDataset1.Close;
                       frxDBDataset1.Open;
                       with  frxReport1 do
                        begin
                         LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportSPK.fr3');
                        end;
                     end
                     else
                     if Cbojns.ItemIndex=0 then
                        begin
                         case kodereport of
                         4010201,4010202,401020201,4010203,4010204,4010205,4010301,4010302:
                         Begin
                          XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                          end;
                          sql.add('Exec Sp_ReportBp :0,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:1');
                         end;
                         40201,40202,402021,402022:sql.add('Exec Sp_reportRPenyerahanBahan :0,:1,:2,:3,:4,:5');
                         40301,40302,40303,40351,40352,40353:sql.add('Exec Sp_reportPermintaanBahan :0,:1,:2,:3,:4,:5');
                         4040101,4040102: sql.add('Select * from VwReportOutStandingBPPB');
                         4040201,4040202: sql.add('Select * from VwReportBPPBKeluar');
                         40501,40502:sql.add('Exec Sp_reportUbahKemasanBahan :0,:1,:2,:3,:4');
                         40701,40702:sql.add('Exec Sp_ReportOpnameBahan :0,:1,:2,:3,:4,:5');
                         40801,40802:sql.add('Exec Sp_Reportopnamebarang :0,:1,:2,:3,:4,:5');
                         40361,40362:
                         Begin
                         XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                          end;
                         sql.add('Exec Sp_ReportTransferDet :0,:1,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:2,:3');
                         end;
                         40851,40852,40861,40862:
                         Begin
                          XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                         end;
                         sql.add('Exec [Sp_ReportHasilPrd] :0,:1,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:2');
                         end;

                         End;
                         if (KodeReport =4010201) or (KodeReport =4010202 )or (KodeReport =401020201 )or(KodeReport =4010203)or(KodeReport =4010204)or(KodeReport =4010205) Then
                          Begin
                           if  (KodeReport = 4010201) or (KodeReport =4010203) Then
                           Parameters[0].Value:='N'
                           else if (KodeReport = 4010202) or (KodeReport =4010204) Then
                           Parameters[0].Value:='B'
                           else
                           Parameters[0].Value:='D';
                          end
                         else
                         Begin
                          Parameters[0].Value:='T';
                         end;
                         case kodereport of
                         4010301,40201,40301,40351,40501,40701,40801,402021,40361,40851,40861:Parameters[1].Value:='N';
                         4010302,40202,40302,40352,40502,40702,40802,402022,40362,40852,40862:Parameters[1].Value:='B';
                         40303,40353:parameters[1].value:='D';
                         end;
                         case kodereport of
                         40851,40852,40861,40862,40361,40362:Begin
                                      Parameters[2].Value:=XParameter;
                                     end;
                         4010201,4010202,401020201,4010203,4010204,4010205: Begin
                                           Parameters[1].Value:=XParameter;
                                          end
                         else
                         Begin
                         Parameters[2].Value:=TglAwal13.Date;
                         Parameters[3].Value:=TglAkhir13.Date;
                         Parameters[4].Value:=XParameter;
                         end;
                         end;
                         case kodereport of
                         4010301,4010302,40201,40202,40301,40302,40303,40351,40352,40353,40701,40702,
                         40801,40802,402021,402022
                         :Parameters[5].Value:=CboOto.Itemindex;
                         40361,40362:Parameters[3].Value:=IntToStr(CboOto.Itemindex);
                         end;
                        end
                     else  if Cbojns.ItemIndex=1 then
                        Begin
                         Case Kodereport of
                          4010201,4010202,401020201,4010203,4010204,4010205,4010301,4010302:sql.add('Exec Sp_ReportBpRek :0,:1,:2,:3');
                          40201,40202,402021,402022:sql.add('Exec Sp_reportRPenyerahanBahanRek :0,:1,:2,:3');
                          40301,40302,40303,40351,40352,40353:sql.add('Exec Sp_reportPermintaanBahanRek :0,:1,:2,:3');
                          4040101,4040102: sql.add('Exec Sp_reportOutStandingBPPBRek :0,:1,:2');
                          4040201,4040202:sql.add('Exec Sp_ReportBPPBKeluarRek :0,:1,:2');
                          40501,40502:sql.add('Exec Sp_ReportUbahKemasanRek :0,:1,:2');
                          40701,40702:sql.add('Exec Sp_reportOpnameBahanRek :0,:1,:2,:3');
                          40801,40802:sql.add('Exec Sp_reportOpnameBarangRek :0,:1,:2');
                         End;
                         case kodereport of
                          4010201,4010301,4010203,40201,40301,40351,4040101,4040201,40501,40701,40801,402021:Parameters[0].Value:='N';
                          4010202,4010302,4010204,40202,40302,40352,4040102,4040202,40502,40702,40802,402022:Parameters[0].Value:='B';
                          40303,40353,401020201,4010205:Parameters[0].Value:='D';
                         end;
                         ////
                         if  Kodereport= 40862 Then
                         Begin
                          XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                         end;
                         sql.add('Exec [Sp_ReportHasilPrd] :0,:1,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAwal13.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',TglAkhir13.Date)))+',:2');
                         end;
                         ///
                         if  kodereport<>40862 Then
                         Begin
                          Parameters[1].Value:=TglAwal13.Date;
                          Parameters[2].Value:=TglAkhir13.Date;
                         end
                         else
                         Begin
                           Parameters[0].Value:='B';
                           Parameters[1].Value:='B';
                           Parameters[2].Value:=XParameter;
                         end;
                         case kodereport of
                         4010201,4010202,401020201,4010203,4010204,4010205,4010301,4010302,40201,40202,40301,40302,40303,40351,40352,40353,40701,40702,40801,40802,402021,402022
                         :Parameters[3].Value:=CboOto.Itemindex;
                         end;
                        End
                    else
                       begin
                       ShowMessage('Pilih Jenis Rekap');
                       ActiveControl:=Cbojns;
                       exit;
                       end;
                   End;
                end;

               open;
               frxDBDataset1.DataSet:=QuView;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               with  frxReport1 do
                 begin
                   case Kodereport of
                    4010201:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerNobuktiRek.fr3');
                          End;
                    4010202:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerbarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerbarangRek.fr3');
                          End;
                    401020201:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerDepart.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerDepartRek.fr3');
                          End;
                    4010203:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerNobuktiACC.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerNobuktiRekACC.fr3');
                          End;
                    4010204:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerbarangACC.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerbarangRekACC.fr3');
                          End;
                    4010205:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerDepartACC.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPerDepartRekACC.fr3');
                          End;
                    4010301:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPAccPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPAccPerNobuktiRek.fr3');
                          End;
                    4010302:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPAccPerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPAccPerBarangRek.fr3');
                          End;
                    40201:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRpenyerahanBahanPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRpenyerahanBahanPerNobuktiRek.fr3');
                          End;
                    40202:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRpenyerahanBahanPerbarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRpenyerahanBahanPerbarangRek.fr3');
                          End;
                    40301:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanPerNobuktiRek.fr3');
                          End;
                    40302:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanPerbarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanPerbarangRek.fr3');
                          End;
                    40303:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanPerDepartment.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanPerDepartmentRek.fr3');
                          End;
                    40351:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanACCPerNoBukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanACCPerNoBuktiRek.fr3');
                          End;
                    40352:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanACCPerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanACCPerBarangRek.fr3');
                          End;
                    40353:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanACCPerDept.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportPermintaanBahanACCPerDeptRek.fr3');
                          End;
                    4040101:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingBPPBPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingBPPBPerNobuktiRek.fr3');
                          End;
                    4040102:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingBPPBPerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOutStandingBPPBPerBarangRek.fr3');
                          End;
                     4040201:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPBKeluarPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPBKeluarPerNobuktiRek.fr3');
                          End;
                    4040202:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPBKeluarPerbarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportBPPBKeluarPerbarang.fr3');
                          End;

                    40501:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\reportUbahkemasanBHPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\reportUbahkemasanBHPerNobukti.fr3');
                          End;
                    40502:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\reportUbahkemasanBHPerbarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\reportUbahkemasanBHPerbarang.fr3');
                          End;
                    40701:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOpnameBahanPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOpnameBahanPerNobuktirek.fr3');
                          End;
                    40702:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOpnamebahanPerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOpnamebahanPerBarang.fr3');
                          End;
                    40801:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOpnameBahanPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOpnameBahanPerNobuktirek.fr3');
                          End;
                    40802:Begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOpnamebarangPerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportOpnameBarangPerBarangrek.fr3');
                          End;
                    402021:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPenyerahanBahanACCPerNobukti.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPenyerahanBahanACCPerNobuktiRek.fr3');
                          End;
                    402022:begin
                            if Cbojns.ItemIndex=0 then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPenyerahanBahanACCPerBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportRPenyerahanBahanACCPerBarangRek.fr3');
                          End;
                    40361:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportTransferPerNobukti.fr3');
                    40362:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportTransferPerBarang.fr3');
                    40851:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReporthasilPrdperNobukti.fr3');
                    40852:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReporthasilPrdperBarang.fr3');
                    40861:LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReporthasilPrdACCperNobukti.fr3');
                    40862: Begin if Cbojns.ItemIndex=0 Then
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReporthasilPrdACCperBarang.fr3')
                            else
                            LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReporthasilPrdACCperBarangRekap.fr3');
                           end;
                   End;
                   ShowReport;
                 End;
              End;
            End;

            50101,50102,50103:
            begin
            frxDBDataset1.DataSet.Close;
              Quview.close;
              frxDBDataset1.DataSet := Quview;
              with QuView do
              begin
                 Close;
                 SQL.Clear;
                 {
                 sql.Add('Select a.*, ');
                 sql.Add('  a.QNTAWAL/a.Isi'+IntToStr(NoSat.AsInteger)+' QntAwal, a.HRGAWAL, ');
                 sql.Add('  a.QNTPBL/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTPBL, a.HRGPBL, ');
                 sql.Add('  a.QNTRPB/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTRPB, a.HRGRPB, ');
                 sql.Add('  a.QNTPNJ/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTPNJ, a.HRGPNJ, ');
                 sql.Add('  a.QNTRPJ/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTRPJ, a.HRGRPJ, ');
                 sql.Add('  a.QNTPRJ/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTPRJ, a.HRGPRJ, ');
                 sql.Add('  a.QNTADI/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTADI, a.HRGADI, ');
                 sql.Add('  a.QNTADO/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTADO, a.HRGADO, ');
                 sql.Add('  a.QNTUKI/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTUKI, a.HRGUKI, ');
                 sql.Add('  a.QNTUKO/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTUKO, a.HRGUKO, ');
                 sql.Add('  a.QNTTRI/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTTRI, a.HRGTRI, ');
                 sql.Add('  a.QNTTRO/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTTRO, a.HRGTRO, ');
                 sql.Add('  a.HRGRATA, a.QNTIN/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTIN, a.RPIN, ');
                 sql.Add('  a.QNTOUT/a.Isi'+IntToStr(NoSat.AsInteger)+' QNTOUT, a.RPOUT, ');
                 sql.Add('  a.SALDOQNT/a.Isi'+IntToStr(NoSat.AsInteger)+' SALDOQNT, a.SALDORP ');
                 sql.Add('from vwReportStockBrg a');
                 sql.Add('Where a.Bulan='+IntToStr(Bulan17.AsInteger)+' and a.Tahun='+IntToStr(Tahun17.AsInteger));
                 if (kodegdg17.Text<>'') then
                 sql.Add('  and a.KodeGdg='+QuotedStr(Kodegdg17.Text));
                 if SelectedSemuaRecord=false then
                 begin
                   case kodereport of
                    50101:sql.add('and kodebrg in (');
                   End;
                   IsiDariListBox1(QuView);
                 End;
                   }
                 if (kodereport=50103) and (Cbotampil.ItemIndex=1) then sql.add('Exec Sp_reportStockQtyRprek :0,:1,:2,:3,:4,:5,:6')
                 else sql.add('Exec Sp_reportStockQtyRp :0,:1,:2,:3,:4,:5,:6');
                 Parameters[0].Value:=Bulan17.Value;
                 Parameters[1].Value:=Tahun17.Value;
                 Parameters[2].Value:=Nosat.Value;
                 Parameters[3].Value:=KodeGdg17.Text;
                 Parameters[4].Value:=Group17.Text;
                 Parameters[5].Value:=IsStockMinus17.Checked;
                 Parameters[6].Value:=IsHHPminus.Checked;
                 Open;

                frxDBDataset1.Close;
                frxDBDataset1.Open;
                Case Kodereport of
                50101 : frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportStokPerQty.fr3');
                50102 : frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportStokPerRp.fr3');
                50103 : begin
                        if cbotampil.ItemIndex=0 then
                        frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportStokPerQtyRp.fr3')
                        else if cbotampil.ItemIndex=1 then
                        frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportStokPerQtyRpRek.fr3');
                        end;
                end;
                frxReport1.ShowReport;
              End;
            End;

            50104,501041:
            Begin
              FrxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := QuView;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 {
                 SQL.Add('select A.KodeBrg, B.NamaBrg, B.Sat'+IntToStr(NoSat18.AsInteger)+' Sat1, A.KodeGdg, C.Nama NamaGdg, ');
                 sql.Add('  A.SALDOQNT/B.Isi'+IntToStr(NoSat18.AsInteger)+' SALDOQNT ');
                 SQL.Add('from ');
                 SQL.Add('(');
                 SQL.Add('select 	KodeBrg, KodeGdg, sum(SaldoQnt) SaldoQnt ');
                 SQL.Add('from ');
                 SQL.Add('(  ');
                 SQL.Add('select        KodeBrg, KodeGdg, QntAwal SaldoQnt ');
                 SQL.Add('from 	dbStockBrg ');
                 SQL.Add('where         Tahun='+FormatDateTime('yyyy',Tgl18.Date)+' and Bulan=1 ');
                 if (KodeGdg18.Text<>'') then
                    SQL.Add('and KodeGdg='+QuotedStr(KodeGdg18.Text));
                 SQL.Add('union all ');
                 SQL.Add('select 	KodeBrg, KodeGdg, ');
                 SQL.Add('	sum(case when Tipe in (''PBL'',''RPJ'',''ADI'',''TRI'',''UKI'') then Qnt else 1*Qnt end) SaldoQnt ');
                 SQL.Add('from 	vwKartuStock ');
                 SQL.Add('where 	year(Tanggal)='+FormatDateTime('yyyy',Tgl18.Date)+' and Tanggal<='+QuotedStr(FormatDateTime('MM/dd/yyyy',tgl18.Date)));
                 if (KodeGdg18.Text<>'') then
                    SQL.Add('and KodeGdg='+QuotedStr(KodeGdg18.Text));
                 SQL.Add('group by KodeBrg, KodeGdg ');
                 SQL.Add(') X ');
                 SQL.Add('group by KodeBrg, KodeGdg ');
                 SQL.Add(') A');
                 SQL.Add('left outer join dbBarang B on B.KodeBrg=A.KodeBrg ');
                 SQL.Add('left outer join dbGudang C on C.KodeGdg=A.KodeGdg ');
                 SQL.Add('where A.SALDOQNT<>0');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('and A.KodeBrg in (');
                    IsiDariListBox1(QuView);
                 end;
                 SQL.Add('order by  A.KodeBrg, A.KodeGdg ');
                   }

                 Sql.add('Exec Sp_reportStockAkhir :0,:1,:2');
                 Parameters[0].value:=Nosat.Value;
                 parameters[1].Value:=Tgl18.date;
                 Parameters[2].Value:= Kodegdg18.Text;
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              if StockMinus18.Checked Then
              frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportStokAkhirHPP.fr3')
              else
              frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportStokAkhir.fr3');
              frxReport1.ShowReport;
            end;

            50105:
            begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := QuView;
              with QuView do
              begin
                 close;
                 SQL.Clear;
                 {SQL.Add('select A.KodeGdg, C.Nama NamaGdg, B.KodeSupp, B.KodeGrp, A.KodeBrg, B.NamaBrg, ');
                 SQL.Add('  B.Sat3, B.Isi3, B.Sat2, B.Isi2, B.Sat1, B.Isi1, ');
                 sql.Add('  A.SALDOQNT, cast(A.SALDOQNT as int)/cast(B.Isi3 as int) SALDO3QNT, ');
                 sql.Add('  (cast(A.SALDOQNT as int) % cast(B.Isi3 as int))/cast(B.Isi2 as int) SALDO2QNT, ');
                 sql.Add('  (cast(A.SALDOQNT as int) % cast(B.Isi2 as int)) SALDO1QNT ');
                 SQL.Add('from ');
                 SQL.Add('(');
                 SQL.Add('select 	KodeBrg, KodeGdg, sum(SaldoQnt) SaldoQnt ');
                 SQL.Add('from ');
                 SQL.Add('(  ');
                 SQL.Add('select        KodeBrg, KodeGdg, QntAwal SaldoQnt ');
                 SQL.Add('from 	dbStockBrg ');
                 SQL.Add('where         Tahun='+FormatDateTime('yyyy',Tgl19.Date)+' and Bulan=1 ');
                 if (KodeGdg19.Text<>'') then
                    SQL.Add('and KodeGdg='+QuotedStr(KodeGdg19.Text));
                 SQL.Add('union all ');
                 SQL.Add('select 	KodeBrg, KodeGdg, ');
                 SQL.Add('	sum(case when Tipe in (''PBL'',''RPJ'',''ADI'',''TRI'',''UKI'') then Qnt else -1*Qnt end) SaldoQnt ');
                 SQL.Add('from 	vwKartuStock ');
                 SQL.Add('where 	year(Tanggal)='+FormatDateTime('yyyy',Tgl19.Date)+' and Tanggal<='+QuotedStr(FormatDateTime('MM/dd/yyyy',Tgl19.Date)));
                 if (KodeGdg19.Text<>'') then
                    SQL.Add('and KodeGdg='+QuotedStr(KodeGdg19.Text));
                 SQL.Add('group by KodeBrg, KodeGdg ');
                 SQL.Add(') X ');
                 SQL.Add('group by KodeBrg, KodeGdg ');
                 SQL.Add(') A');
                 SQL.Add('left outer join dbBarang B on B.KodeBrg=A.KodeBrg ');
                 SQL.Add('left outer join dbGudang C on C.KodeGdg=A.KodeGdg ');
                 sql.Add('Left Outer JOin DbGroup D on b.kodegrp = d.kodegrp');
                 //SQL.Add('where A.SALDOQNT<>0');
                 if SelectedSemuaRecord=false then
                 begin
                    SQL.Add('and A.KodeBrg in (');
                    IsiDariListBox1(QuView);
                 end;
                 SQL.Add('order by A.KodeGdg, B.KodeSupp, B.KodeGrp, A.KodeBrg');
                  }
                 Sql.add('Exec Sp_ReportStockFisikGudang :0,:1');
                 Parameters[0].Value:=Tgl19.date;
                 Parameters[1].Value:=KodeGdg19.text;
                 Open;
              end;
              frxDBDataset1.Close;
              frxDBDataset1.Open;
              frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportStokFisikGdg.fr3');
              frxReport1.ShowReport;
            end;
            50106:
            Begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := QuView;
              with QuView do
               begin
               close;
               SQL.Clear;
               SQL.Add('exec Sp_reportStockharian :0,:1,:2,:3 ');
               Parameters[0].Value :=awal20.Date;
               Parameters[1].Value :=akhir20.Date;
               Parameters[2].Value :=KodeGdg20.Text;
               Parameters[3].Value :=NoSat20.Value;
               Open;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               if HPP.Checked Then
               frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportStokHarianHPP.fr3')
               else
               frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportStokHarian.fr3');
               frxReport1.ShowReport;
               End;
            End;

            50201,50202:
            begin
             frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := QuView;
              with QuView do
               begin
               close;
               SQL.Clear;
               SQL.Add('exec Sp_reportkartuStock :0,:1,:2,:3,:4,:5,:6,:7,:8 ');
               Parameters[0].Value:=KodeGdg21.Text;
               Parameters[1].Value:=KodeBrg21.Text;
               Parameters[2].Value :=blnawal21.Text;
               Parameters[3].Value :=blnakhir21.Text;
               Parameters[4].Value :=thnawal21.Text;
               Parameters[5].Value :=thnakhir21.Text;
               Parameters[6].Value :=thnawal21.Text+blnawal21.Text;
               Parameters[7].Value :=thnakhir21.Text+blnakhir21.Text;
               Parameters[8].Value :=NOsat21.Value;
               Open;
               frxDBDataset1.Close;
               frxDBDataset1.Open;
               if kodereport=50201 then
               frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportKartuStock.fr3')
               else  frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportKartuStockQntRp.fr3');
               frxReport1.ShowReport;
               End;
            End;

            30351,30352:Begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := QuView;
              with QuView do
               begin
               close;
               SQL.Clear;
                Case kodereport of
                30351:begin
                        SQL.Add('exec Sp_reportAnalisasales :0,:1');
                        Parameters[0].Value:=bulan16.Value;
                        Parameters[1].Value:=tahun16.Value;
                      End;
                30352:begin
                        SQL.Add('exec Sp_reportTargetsales :0');
                        Parameters[0].Value:=Tahun22.Value;
                      end;
                end;
               open;
                case kodereport of
                30351:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportAnalisaSales.fr3') ;
                30352:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportTargetSales.fr3') ;
                end;
               frxReport1.ShowReport;
               end;
            End;
            256021:Begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := QuView;
              with QuView do
               begin
               close;
               SQL.Clear;
               Sql.add('Exec Sp_RepHrgAkhir') ;
               Open;
               frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportHargaAkhir.fr3') ;
               frxReport1.ShowReport;
               End;
            End;
            30363,30362,30361:Begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := QuView;
              with QuView do
               begin
               close;
               SQL.Clear;
                case kodereport of
                 30363:Sql.add('Exec Sp_RepOmsetKomisi :0,:1');
                 //30362:Sql.add('Exec Sp_RepKomisiNota :0,:1');
                 30361:Sql.add('Exec Sp_RepKomisiPelunasan :0,:1');
                 30362:Sql.add('Exec [sp_ReportKomisiSales] :0,:1,:2,:3,:4,:5,:6');
                End;
               if KodeReport=30362 Then
               Begin
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
               end
               else
               Begin
               Parameters[0].Value:=StrToInt(PeriodBln);
               Parameters[1].Value:=StrToInt(PeriodThn);
               end;
               Open;
                case kodereport of
                 30363:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportOmsetKomisi.fr3') ;
                 //30362:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportKomisiNota.fr3') ;
                 30361:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportKomisiPelunasan.fr3') ;
                 30362:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportKomisiSales.fr3') ;
                End;
               frxReport1.ShowReport;
               End;
            End;
            4711,4712,4713,2401,2402,2403,3032601,3032602,3032603:
            Begin
              frxDBDataset1.DataSet.Close;
              frxDBDataset1.DataSet := QuView;
              with QuView do
               begin
               close;
               SQL.Clear;
                 case Tipe23.ItemIndex of
                   0:Begin
                       Case Kodereport OF
                        4711,4712,4713,3032601,3032602,3032603:Sql.add('Exec Sp_ReportRSPBDET :0,:1,:3');
                        2401,2402,2403:
                        Begin
                        XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                         end;
                        Sql.add('Exec Sp_ReportUASDET :0,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',awal23.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',akhir23.Date)))+',:1');
                        end;
                       End;
                     End;
                   1:Begin
                      XParameter:='';
                          if SelectedSemuaRecord=false then
                           begin
                            for i:= 0 to ListBox1.Count-1 do
                             begin
                              if ListBox1.Count=1 Then
                              XParameter:=('(')+QuotedStr(ListBox1.Items.Strings[i])+(')')
                              else
                              Begin
                               if i=ListBox1.Count-1 then
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(')')
                               else if i=0 Then
                               XParameter:=XParameter+('(')+QuotedStr(ListBox1.Items.Strings[i])+(',')
                               else
                               XParameter:=XParameter+QuotedStr(ListBox1.Items.Strings[i])+(',')
                             end;
                           end;
                         end;
                      Case KodeReport Of
                       2401,2402,2403:Sql.add('Exec Sp_ReportUASrEK :0,'+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',awal23.Date)))+','+QuotedStr(QuotedStr(FormatDateTime('MM-DD-YYYY',akhir23.Date)))+',:1');
                      End;
                     End;
                 End;
                 case kodereport of
                 4711,2401,3032601:Parameters[0].value:='N';
                 4712,3032602:Parameters[0].value:='B';
                 4713,3032603:Parameters[0].value:='C';
                 2402:Parameters[0].value:='P';
                 2403:Parameters[0].value:='J';
                 End;
                 if ((kodereport=2401)or(kodereport=2402)or(kodereport=2403)) Then
                  Parameters[1].value:=XParameter
                 else
                 Begin
                 Parameters[1].value:=Awal23.Date;
                 Parameters[2].value:=Akhir23.Date;
                 end;
                 Open;
               End;
               case Tipe23.ItemIndex of
                 0:Begin
                     case kodereport of
                       4711:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportRSPBPerNobuktiN.fr3') ;
                       4712:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportRSPBPerBarangN.fr3') ;
                       4713:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportRSPBPerCustomerN.fr3') ;
                       3032601:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportRSPBPerNobukti.fr3') ;
                       3032602:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportRSPBPerBarang.fr3') ;
                       3032603:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportRSPBPerCustomer.fr3') ;
                       2401:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportUangMukaPerNobukti.fr3') ;
                       2402:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportUangMukaPerProyek.fr3') ;
                       2403:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportUangMukaPerSJ.fr3') ;
                     End;
                   End;
                 1:Begin
                     case kodereport of
                       2401:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportUangMukaPerNobuktiRek.fr3') ;
                       2402:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportUangMukaPerProyekRek.fr3') ;
                       2403:frxReport1.LoadFromFile(CurrDir+'ReportFiles\ReportUangMukaPerSJRek.fr3') ;
                     End;
                   End;
               End;
               frxReport1.ShowReport;
            End;
            ///
             106: begin
           //  if (IDUser='STELLA')or (IDUser='SULIS')or(IDUser='HANI') Then
              Begin
                  if (Divisi2.Text='') then
                   begin
                    if Divisi2.Enabled=true then
                    //ActiveControl:=Divisi1
                   end else
                   begin
                    frxDBDataset1.DataSet.Close;
                    with DM.QuTemp do
                    begin
                      Close;
                      SQL.Clear;
                      SQL.Add('Delete dbCashflow where UserID=:0');
                      Prepared;
                      Parameters[0].Value:=IDUser;
                      ExecSQL;
                    end;
                    with SpPrsCF do
                    begin
                      Active := false;
                      Prepared;
                      Parameters[1].Value := '01';
                      Parameters[2].Value := BulanA.AsInteger;
                      Parameters[3].Value := TahunA.AsInteger;
                      Parameters[4].Value := BulanB.AsInteger;
                      Parameters[5].Value := TahunB.AsInteger;
                      Parameters[6].Value := IDUser;
                      Active := true;
                    end;
                    while Not SpPrsCF.Eof do
                    begin
                      with DM.QuTemp do
                      begin
                        Close;
                        SQL.Clear;
                        SQL.Add('insert into dbCashFlow (Perkiraan, Lawan, Keterangan, Kas, Koreksi, Jumlah, Gol, Urut, UserID, Devisi, KodeCS)');
                        SQL.Add('values (:0, :1, :2, :3, :4, :5, :6, :7, :8, :9, :10)');
                        Prepared;
                        Parameters[0].Value := SpPrsCF.FieldByName('Perkiraan').AsString;
                        Parameters[1].Value := SpPrsCF.FieldByName('Lawan').AsString;
                        Parameters[2].Value := SpPrsCF.FieldByName('Keterangan').AsString;
                        Parameters[3].Value := SpPrsCF.FieldByName('Kas').AsFloat;
                        Parameters[4].Value := SpPrsCF.FieldByName('Koreksi').AsFloat;
                        Parameters[5].Value := SpPrsCF.FieldByName('Jumlah').AsFloat;
                        Parameters[6].Value := SpPrsCF.FieldByName('Gol').AsString;
                        Parameters[7].Value := SpPrsCF.FieldByName('Urut').AsInteger;
                        Parameters[8].Value := SpPrsCF.FieldByName('UserID').AsString;
                        Parameters[9].Value := SpPrsCF.FieldByName('Devisi').AsString;
                        Parameters[10].Value := SpPrsCF.FieldByName('KodeCS').AsString;
                        ExecSQL;
                      end;
                      SpPrsCF.Next;
                    end;
                    with QuView do
                    begin
                     Close;
                     SQL.Clear;
                      {
                     SQL.Add('select a.gol, a.lawan, case when a.KodeCS='''' then sum(isnull(a.kas,0)) else null end as Kas,');
                     SQL.Add('case when a.KodeCS='''' then (case when (exists (select isnull(b.kas,0)');
                     SQL.Add('                    from dbcashflow b');
                     SQL.Add('                    where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENERIMAAN''');
                     SQL.Add('		         group by b.Lawan, b.gol, b.userid, b.kas) and');
                     SQL.Add('            exists (select isnull(b.kas,0)');
                     SQL.Add('                    from dbcashflow b');
                     SQL.Add('                    where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENGELUARAN''');
                     SQL.Add('		         group by b.Lawan, b.gol, b.userid, b.kas)) then');

                     SQL.Add('           (case when (select sum(isnull(b.kas,0)) from dbcashflow b');
                     SQL.Add('                       where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENERIMAAN'')>');
                     SQL.Add('                      (select sum(isnull(b.kas,0)) from dbcashflow b');
                     SQL.Add('                       where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENGELUARAN'') then');

                     SQL.Add('                      (select sum(isnull(b.kas,0)) from dbcashflow b');
                     SQL.Add('                       where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENGELUARAN'') else');

                     SQL.Add('                      (select sum(isnull(b.kas,0)) from dbcashflow b');
                     SQL.Add('                       where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENERIMAAN'')');
                     SQL.Add('            end)');
                     SQL.Add('      else sum(0) end) else null end as Koreksi,');
                     SQL.Add(' case when a.KodeCS='''' then (sum(isnull(a.kas,0))-');
                     SQL.Add(' (case when (exists (select isnull(b.kas,0)');
                     SQL.Add('                     from dbcashflow b');
                     SQL.Add('                     where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENERIMAAN''');
                     SQL.Add('		          group by b.Lawan, b.gol, b.userid, b.kas) and');
                     SQL.Add('             exists (select isnull(b.kas,0)');
                     SQL.Add('                     from dbcashflow b');
                     SQL.Add('                     where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENGELUARAN''');
                     SQL.Add('		          group by b.Lawan, b.gol, b.userid, b.kas)) then');

                     SQL.Add('           (case when (select sum(isnull(b.kas,0)) from dbcashflow b');
                     SQL.Add('                       where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENERIMAAN'')>');
                     SQL.Add('                      (select sum(isnull(b.kas,0)) from dbcashflow b');
                     SQL.Add('                       where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENGELUARAN'') then');

                     SQL.Add('                      (select sum(isnull(b.kas,0)) from dbcashflow b');
                     SQL.Add('                       where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENGELUARAN'') else');

                     SQL.Add('                      (select sum(isnull(b.kas,0)) from dbcashflow b');
                     SQL.Add('                       where b.KodeCS='''' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol=''PENERIMAAN'')');
                     SQL.Add('            end)');
                     SQL.Add('  else 0 end)) else null end as Jumlah, case when a.KodeCs='''' then null else sum(a.Kas) end DetKas, a.keterangan, a.Urut, a.Devisi');
                     SQL.Add('from dbcashflow a');
                     SQL.Add('where Userid=:0 and Perkiraan in (select perkiraan from dbAksesPerkiraan where userid=:1)');
                     SQL.Add('and lawan in (select perkiraan from dbAksesPerkiraan where userid=:2)');
                     SQL.Add('Group by a.gol, a.lawan, a.Keterangan, a.userid, a.Urut, a.Devisi, a.KodeCS');
                     SQL.Add('order by a.devisi, a.Urut, a.Gol, a.lawan, a.KodeCS');
                     Prepared;
                     Parameters[0].Value := IDUser;
                     Parameters[1].Value:=IDUser;
                     Parameters[2].Value:=IDUser;
                     }
                     SQL.Add('exec SP_ReportCashFlow '+QuotedStr(IDUser) +' ');
                     open;
                    end;
                    frxDBDataset1.DataSet := Quview;
                    frxDBDataset1.Close;
                    frxDBDataset1.Open;
                    if Divisi2.Text = '-' then
                    begin
                     frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportMutasiKeuangan.fr3');
                    end else
                    begin
                      frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'ReportFiles\ReportMutasiKeuanganPerDivisi.fr3');
                    end;
                    frxReport1.ShowReport;
                   end;
                 end;
                // else ShowMessage('Not Access');
               End;
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
  Application.CreateForm(TFrBrows, FrBrows);
  with FrBrows do
  begin
    case KodeReport of
      101,102
          : begin //Perkiraan
              KodeBrows := 10051;
              IsiData := '';
            end;
    10101 : begin //Aktiva Tetap
              KodeBrows := 100413;
              IsiData := '';
            end;
      103,104
          : begin  //Laba Rugi dan HPP
              KodeBrows := 10054;
              IsiData := '';
              IsTampil := (KodeReport=104);
              brBulan := StrToInt(PeriodBln);
              brTahun := StrToInt(PeriodThn);
            end;
     1298 :
            begin //Customer
              KodeBrows := 10142;
              IsiData := '';
            end;
    300703 : // Pemasok
            begin
              KodeBrows:=30074;
              TglAwal:=TglAwal9.Date;
              TglAkhir:=TglAkhir9.Date;
            end;
    60:
    Begin
            frbrows.TglAwal := Tglawal13.date;
            frbrows.TglAkhir := Tglakhir13.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='Filter KodeCust,NamaCustSupp,NamaProject from [Vw_KartuProyek] ';
            Frbrows.Ordr :=' NamaCustSupp ';
            FrBrows.Colm1 := 'Pelanggan';
            FrBrows.Colm2 := 'Project';
    end;
    6101,6102:
    Begin
            frbrows.TglAwal := Tglawal13.date;
            frbrows.TglAkhir := Tglakhir13.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='Filter KodeCust,NamaCustSupp,NamaProject,Filter from [Vw_ReportCashBack] ';
            Frbrows.Ordr :=' NamaCustSupp ';
            FrBrows.Colm1 := 'Pelanggan';
            FrBrows.Colm2 := 'Project';
    end;
    20406:
    Begin
            frbrows.TglAwal := TglAwal8.date;
            frbrows.TglAkhir := TglAkhir8.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='Kode,Nama from vwPiutangDetail ';
            Frbrows.Ordr :=' Kode ';
            FrBrows.Colm1 := 'Nama';
    end;
    40851,40861:
          Begin
            frbrows.TglAwal := Tglawal13.date;
            frbrows.TglAkhir := Tglakhir13.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='NoBukti from Vw_HasilPrd ';
            Frbrows.Ordr :=' NoBukti ';
            FrBrows.Colm1 := 'No. Bukti';
          end;
    40361:Begin
            frbrows.TglAwal := Tglawal13.date;
            frbrows.TglAkhir := Tglakhir13.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='NoBukti from VwreportTransfer ';
            Frbrows.Ordr :=' NoBukti ';
            FrBrows.Colm1 := 'No. Bukti';
          end;
    40362:Begin
            frbrows.TglAwal := Tglawal13.date;
            frbrows.TglAkhir := Tglakhir13.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='NamaBrg,kodesubgrp,Kodebrg from VwreportTransfer ';
            Frbrows.Ordr :=' kodesubgrp,NamaBrg ';
            FrBrows.Colm1 := 'Nama Barang';
            FrBrows.Colm2 := 'Kode Sub Group';
          end;
    40852,40862:
          Begin
            frbrows.TglAwal := Tglawal13.date;
            frbrows.TglAkhir := Tglakhir13.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='NamaSubGrp,KodeSubGrp from Vw_HasilPrd ';
            Frbrows.Ordr :='NamaSubGrp,KodeSubGrp';
            FrBrows.Colm1 := 'Nama Group';
            FrBrows.Colm2 := 'Kode Group';

          end;
    303241:begin
            frbrows.TglAwal := Tglawal13.date;
            frbrows.TglAkhir := Tglakhir13.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='KodeCustSupp+KodeProject KodeCustSupp,NamaCustSupp,NamaProject from vwReportRekapKirim ';
            Frbrows.Ordr :=' NamaCustSupp ';
            FrBrows.Colm1 := 'Pelanggan';
            FrBrows.Colm2 := 'Project';
           end;
     30314: begin
            frbrows.TglAwal := Tglawal13.date;
            frbrows.TglAkhir := Tglakhir13.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='KodeCust,NamaCustSupp,NamaProject from vwCashBack ';
            Frbrows.Ordr :=' NamaCustSupp ';
            FrBrows.Colm1 := 'Pelanggan';
            FrBrows.Colm2 := 'Project';
           end;
      3032411: begin
            frbrows.TglAwal := Tglawal13.date;
            frbrows.TglAkhir := Tglakhir13.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='KodeCustSupp,NamaCustSupp from vwReportFakturPenjualan ';
            Frbrows.Ordr :=' NamaCustSupp ';
            FrBrows.Colm1 := 'Pelanggan';

           end;
      303321:begin
            frbrows.TglAwal := Tglawal13.date;
            frbrows.TglAkhir := Tglakhir13.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='KodeCustSupp,NamaCustSupp from fnc_ReportDP ';
            Frbrows.Ordr :=' NamaCustSupp ';
            FrBrows.Colm1 := 'Pelanggan';

           end;
     303242:begin
            frbrows.TglAwal := Tglawal13.date;
            frbrows.TglAkhir := Tglakhir13.date;
            KodeBrows:=KodeReport;
            FrBrows.vw:='KodeCustSupp,NamaCustSupp,NamaProject from vwKontrakvsSJ ';
            Frbrows.Ordr :=' NamaCustSupp ';
            FrBrows.Colm1 := 'Pelanggan';
            FrBrows.Colm2 := 'Project';
           end;
    251010,252010,301010,302010, //Nobukti
    251020,252020,301020,302020, //KodeCustSupp
    251030,252030,301030,302030, //AccPersediaan
    251040,252040,301040,302040://AccHutpiut
            begin
            frbrows.TglAwal := awal15.date;
            frbrows.TglAkhir := akhir15.date;
            KodeBrows:=KodeReport;
               case kodereport of
                251010,252010,301010,302010:
                  begin
                      case kodereport of
                      251010:FrBrows.vw:=' distinct (Nobukti) Nobukti,Tanggal from VwreportPembelian ';
                      252010:FrBrows.vw:=' distinct (Nobukti) Nobukti,Tanggal from VwreportRBeli ';
                      301010:FrBrows.vw:=' distinct (Nobukti) Nobukti,Tanggal from VwreportJual ';
                      302010:FrBrows.vw:=' distinct (Nobukti) Nobukti,Tanggal from VwreportRJual ';
                      end;
                     Frbrows.Ordr :=' Nobukti,Tanggal ';
                     FrBrows.Colm1 := 'Nobukti';
                     FrBrows.Colm2 := 'Tanggal';
                  end;

                251020,252020,301020,302020:
                     begin
                      case kodereport of
                      251020:FrBrows.vw:=' distinct (KodeCustSupp) KodeCustSupp,NamaCustSupp from VwreportPembelian  ';
                      252020:FrBrows.vw:=' distinct (KodeCustSupp) KodeCustSupp,NamaCustSupp from VwreportRBeli ';
                      301020:FrBrows.vw:=' distinct (KodeCustSupp) KodeCustSupp,NamaCustSupp from VwreportJual';
                      302020:FrBrows.vw:=' distinct (KodeCustSupp) KodeCustSupp,NamaCustSupp from VwreportRJual';
                      end;
                      Frbrows.Ordr :=' KodeCUstSupp,NamaCustSupp ';
                      FrBrows.Colm1 := 'KodeCustSupp';
                      FrBrows.Colm2 := 'Nama CustSupp';
                     end;
                251030,252030,301030,302030:
                      begin
                       case kodereport of
                        251030:FrBrows.vw:=' distinct (AccPersediaan) Accpersediaan,'''' ''-''  from VwreportPembelian ';
                        252030:FrBrows.vw:=' distinct (AccPersediaan) Accpersediaan,'''' ''-''  from VwreportRBeli ';
                        301030:FrBrows.vw:=' distinct (AccPersediaan) Accpersediaan,'''' ''-''  from VwreportJual ';
                        302030:FrBrows.vw:=' distinct (AccPersediaan) Accpersediaan,'''' ''-''  from VwreportRjual ';
                       end;
                       Frbrows.Ordr :='AccPersediaan';
                       FrBrows.Colm1 := 'AccPersediaan';
                       FrBrows.Colm2 := '-';
                      end;
                 251040,252040,301040,302040:
                      begin
                       case kodereport of
                        251040:FrBrows.vw:=' distinct (AcchutPiut) AcchutPiut,'''' ''-''  from VwreportPembelian ';
                        252040:FrBrows.vw:=' distinct (AcchutPiut) AcchutPiut,'''' ''-''  from VwreportRBeli ';
                        301040:FrBrows.vw:=' distinct (AcchutPiut) AcchutPiut,'''' ''-''  from VwreportJual ';
                        302040:FrBrows.vw:=' distinct (AcchutPiut) AcchutPiut,'''' ''-''  from VwreportRjual ';
                       end;
                       Frbrows.Ordr :='AcchutPiut';
                       FrBrows.Colm1 := 'AcchutPiut';
                       FrBrows.Colm2 := '-';
                      end;

               end;
            end;

        2530101,2530201,2540101,2540201,25501,2560101,2560201,25701,25711,25721,25731,3030101,3031101,3030201,3031201,2401,2402,2403,4010201,303701,303801,4010203,4011,  //PerNobukti
        401020201,4010205,
        2530102,2530202,2540102,2540202,25502,2560102,2560202,25702,25712,25722,25732,3030102,3031102,3030202,3031202,4010202,303702,303802,4010204, //Perbarang
        2530103,2530203,2540103,2540203,25503,2560103,2560203,25703,25713,25723,25733,3030103,3031103,3030203,3031203,303703,303803,3030104: //PerSupplier
            begin

            if  (KodeReport=2401)or(KodeReport=2402)or(KodeReport=2403)Then
            Begin
            frbrows.TglAwal := Awal23.date;
            frbrows.TglAkhir := Akhir23.date;
            end
            else
            Begin
            frbrows.TglAwal := TglAwal13.date;
            frbrows.TglAkhir := TglAkhir13.date;
            end;
            KodeBrows:=KodeReport;
             Case KodeReport of
             4010201,4010202,401020201,4010203,4010204,4010205:FrBrows.VW:=' VwReportBP ';
             4011: FrBrows.VW:=' VwReportSPK ';
             2530201,2530202, 2530203:FrBrows.VW:=' VwReportPurchasingReq ';
             2540101,2540102,2540103:FrBrows.VW:=' VwReportOutStandingPR ';
             2540201,2540202,2540203:FrBrows.VW:=' VwreportPO ';
             25501,25502,25503:FrBrows.VW:=' VwReportRevisiPO ';
             2560101,2560102,2560103:FrBrows.VW:=' VwReportOutStandingPO ';
             2560201,2560202,2560203:FrBrows.VW:=' VwReportBeliGudang ';
             25701,25702,25703:FrBrows.VW:=' VwreportBeliReject ';
             25711,25712,25713:FrBrows.VW:=' VwReportPenerimaanACC ';
             25721,25722,25723:FrBrows.VW:=' VwReportRPembelianGDg ';
             25731,25732,25733:FrBrows.VW:=' VwreportDebetNotte ';
             3030101,3030102,3030103,3030104:FrBrows.VW:=' VwReportSO ';
             3031101,3031102,3031103:FrBrows.VW:=' vwreportoutSO ';
             3030201,3030202,3030203:FrBrows.VW:=' VwReportOutStandingSO ';
             3031201,3031202,3031203 :FrBrows.VW:=' VwReportSPP ';
             2401,2402,2403:FrBrows.VW:=' VWREPORTUAS ';
             303701,303702,303703 :FrBrows.VW:=' vw_SOvsSPKvsHasilPrd ';
             303801,303802,303803 :FrBrows.VW:=' VwReportKPvsSJVsSaku ';
             End;
             case KodeReport of
              2530101,2530201,2540101,2540201,25501,2560101,2560201,25701,25711,25721,25731,3030101,3031101,3030201,3031201,2401,4010201,4010203,303701,4011:
                Begin
                 FrBrows.Fi:=' distinct (Nobukti) Nobukti, Tanggal';
                 Frbrows.Ordr :=' Nobukti,Tanggal ';
                 FrBrows.Colm1 := 'Nobukti';
                 FrBrows.Colm2 := 'Tanggal';
                End;
               303801 :Begin
                       FrBrows.Fi:=' distinct (NoSO) Nobukti, Tanggal';
                       Frbrows.Ordr :=' NoSO,Tanggal ';
                       FrBrows.Colm1 := 'No. Kontrak';
                       FrBrows.Colm2 := 'Tanggal';
                       end;
              2530102,2530202,2540102,2540202,25502,2560102,2560202,25702,25712,25722,25732,3030102,3031102,3030202,3031202,4010202,4010204,303702,303802:
                Begin
                 FrBrows.Fi:=' distinct (kodeBrg) KodeBrg, NamaBrg';
                 Frbrows.Ordr :=' KodeBrg,NamaBrg ';
                 FrBrows.Colm1 := 'Kode Barang';
                 FrBrows.Colm2 := 'Nama Barang';
                End;
              2530103,2530203,2540103,2540203,25503,2560103,2560203,25703,25713,25723,25733,3030103,3031103,3030203,3031203:
                Begin
                 FrBrows.Fi:=' distinct (KodeCustSupp) KodeCustSupp, NamaCustSupp';
                 Frbrows.Ordr :=' KodeCustSupp,NamaCustSupp ';
                 FrBrows.Colm1 := 'Kode CustSupp';
                 FrBrows.Colm2 := 'Nama CustSupp';
                End;
             401020201,4010205:
                Begin
                 FrBrows.Fi:=' distinct (KdDep) KdDep, NMDEP';
                 Frbrows.Ordr :=' KdDep,NMDEP ';
                 FrBrows.Colm1 := 'Kode Departemen';
                 FrBrows.Colm2 := 'Nama Departemen';
                end;
             3030104:
               Begin
                 FrBrows.Fi:=' distinct (KodeSubGrp) KodeSubGrp, NamaSubGrp';
                 Frbrows.Ordr :=' KodeSubGrp,NamaSubGrp ';
                 FrBrows.Colm1 := 'Kode Group';
                 FrBrows.Colm2 := 'Nama Group';
                End;
              303703,303803:
                 Begin
                 FrBrows.Fi:=' distinct (KodeCust) KodeCust, NamaCustSupp';
                 Frbrows.Ordr :=' KodeCust,NamaCustSupp ';
                 FrBrows.Colm1 := 'Kode CustSupp';
                 FrBrows.Colm2 := 'Nama CustSupp';
                End;
              2402:
               begin
                 FrBrows.Fi:=' distinct Ket1,NamaProject' ;
                 Frbrows.Ordr :=' Ket1 ';
                 FrBrows.Colm1 := 'Ket1 ';
                 FrBrows.Colm2 := 'NamaProject';
               end;
             2403:
               Begin
                 FrBrows.Fi:=' distinct NOSJ ' ;
                 Frbrows.Ordr :=' NOSJ ';
                 FrBrows.Colm1 := 'Surat Jalan ';

               end;
             End;
            End;

    end;
    ShowModal;
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
        1005,10051, 100413 : ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('perkiraan').Index]);
        10054 : ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('Nomor').Index]);
        1103 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('Kode').Index]);
        1006 : ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeVls').Index]);
        10141,10142,30074,303241,303242,303321 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeCustSupp').Index]);
        300173,300174,300175,30073,300833,30079,300933,300733,300633,300533,300433,300333,251010,252010,301010,302010 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('nobukti').Index]);
        30083,300350,30054,2530101,2530201,2540101,2540201,25501,2560101,2560201,25701,25711,25721,25731,30093,30004 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('nobukti').Index]);
        40851,40861,40361,3030101,3031101,3030201,3031201,2401,4010201,4010203,303701,4011:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('nobukti').Index]);
        3030104:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeSubGrp').Index]);
        303801:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('Nobukti').Index]);
        2402:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('Ket1').Index]);
        2403:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('NOSJ').Index]);
        30314,60:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeCust').Index]);
        3032411:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeCustSupp').Index]);
        6101,6102:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('Filter').Index]);
        20406:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('Kode').Index]);
        30084,300855,30085,300755,300655,300555,300455,300355,251020,252020,301020,302020,
        2530103,2530203,2540103,2540203,25503,2560103,2560203,25703,25713,25723,25733,3030103,3031103,3030203,3031203 :
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeCustSupp').Index]);
        303703,303803:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeCust').Index]);
        251030,252030,301030,302030:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('AccPersediaan').Index]);
        251040,252040,301040,302040:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('Acchutpiut').Index]);
        2530102,2530202,2540102,2540202,25502,2560102,2560202,25702,25712,25722,25732, 40362,3030102,3031102,3030202,3031202,4010202,4010204,303702,303802:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeBrg').Index]);
        40852,40862:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KodeSubGrp').Index]);
        401020201,4010205:
        ListBox1.Items.add(TdxTreeListNode(xList.Items[i]).Strings[FrBrows.GridBrows.ColumnByFieldName('KdDep').Index]);
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
  if CompareText(varName,'Perkiraan')=0 then
   value:='Perkiraan : '+Perkiraan12.Text+' ('+NamaPerkiraan12.Caption+') s/d '+Perkiraan13.Text+' ('+NamaPerkiraan13.Caption+')';
  if CompareText(varName,'Periode')=0 then
   value := 'Periode : '+DateToStr(TglAwal)+' s/d '+DateToStr(TglAkhir);
  if CompareText(VarName,'nmKlien')=0 then
     Value := mNamaKlien ;
  if CompareText(VarName,'IDUSER')=0 then
     Value := IDUser ;
  if CompareText(VarName,'Divisi')=0 then
     Value := '';
  if CompareText(VarName,'Lawan')=0 then
  Begin
   if KodeReport=20102 then Value:=Perkiraan.Text;
  end;
  if dxPageControl1.ActivePageIndex=0 then
  begin
    DataBersyarat('select Perkiraan, Keterangan from dbPerkiraan where Perkiraan=:0',[Perkiraan.Text],DM.QuTemp);
    if CompareText(VarName,'Perkiraan')=0 then
      Value := 'Perkiraan : '+Perkiraan.Text+' ('+DM.QuTemp.FieldByName('Keterangan').AsString+')';
    if CompareText(VarName,'Periode')=0 then
    begin
      if KodeReport=20102 then
      begin
        if Awal.Text=Akhir.Text then
          Value:=FormatDateTime('DD MMMM yyyy',Awal.Date)
        else
          Value:=Awal.Text +' s/d ' + Akhir.Text;
      end else
      Value := 'Periode : '+Awal.Text +' s/d ' + Akhir.Text;
    end;
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
      20301 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      20302 : if CompareText(VarName,'Periode')=0 then Value := 's/d Tanggal : '+TglAkhir8.Text;
      20303 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      20304 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      20305 : if CompareText(VarName,'Periode')=0 then Value := 's/d Tanggal : '+TglAkhir8.Text;
    end;
    case KodeReport of
      20401,20406 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      20402 : if CompareText(VarName,'Periode')=0 then Value := 's/d Tanggal : '+TglAkhir8.Text;
      20403 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      20404: if CompareText(VarName,'Periode')=0 then Value := 'Periode : '+TglAwal8.Text+' s/d '+TglAkhir8.Text;
      20405 : if CompareText(VarName,'Periode')=0 then Value := 's/d Tanggal : '+TglAkhir8.Text;
      204041 : if CompareText(VarName,'Periode')=0 then Value := 'Periode : Bulan : '+IntToStr(Bulan8.AsInteger) +' Tahun : '+IntToStr(Tahun8.AsInteger);
    end;
  end else
  if dxPageControl1.ActivePageIndex=8 then
  begin
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+TglAwal9.Text+' s/d '+TglAkhir9.Text;
  end;
   if dxPageControl1.ActivePageIndex=23 then
  begin
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+awal23.Text+' s/d '+akhir23.Text;
  end;
  if dxPageControl1.ActivePageIndex=9 then
  begin
    if CompareText(VarName,'Periode')=0 then
      Value := Bulan10.Text +' - ' +tahun10.Text  ;
    if CompareText(VarName,'Gudang')=0 then
      Value := Gudang10.Text ;
  end;
  if dxPageControl1.ActivePageIndex=10 then
  begin
    if CompareText(VarName,'Periode')=0 then
    begin
      if KodeReport=864 then
        Value := 'Sampai Tanggal '+FormatDateTime('dd MMMM yyyy',SDTanggal11.Date)
      else if (KodeReport=82001) or (KodeReport=82002) or (KodeReport=869) or (KodeReport=870)then
      begin
        if FormatDateTime('yyyyMM',TglAwal11.Date)=FormatDateTime('yyyyMM',TglAkhir11.Date) then
           Value := 'Periode '+FormatDateTime('dd',TglAwal11.Date)+' - '+FormatDateTime('dd MMMM yyyy',TglAkhir11.Date)
        else
           Value := 'Periode '+FormatDateTime('dd MMMM yyyy',TglAwal11.Date)+' - '+FormatDateTime('dd MMMM yyyy',TglAkhir11.Date);
      end;
    end;
  end;
  if (dxPageControl1.ActivePageIndex=11) or (KodeReport=303321) then
  begin
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+TglAwal13.Text+' s/d '+TglAkhir13.Text;
  end;
  if dxPageControl1.ActivePageIndex=12 then
  begin
    if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+TglAwal14.Text+' s/d '+TglAkhir14.Text;
  end;
  if dxPageControl1.ActivePageIndex=15 then
  begin
  if CompareText(VarName,'Periode')=0 then
      Value := 'Periode : '+Awal15.Text +' s/d ' + Akhir15.Text;
  end;
  if dxPageControl1.ActivePageIndex=16 then
  begin
  if CompareText(VarName,'Periode')=0 then
  Value := Bulan16.Text +' - ' +tahun16.Text  ;
  end;
  if dxPageControl1.ActivePageIndex=17 then
  begin
  if CompareText(VarName,'PeriodeBln')=0 then
  Value := Bulan17.Text +' - ' +tahun17.Text  ;
  if CompareText(VarName,'Gudang')=0 then
  Value := KodeGdg17.Text ;
  end;

  if dxPageControl1.ActivePageIndex=19 then
  begin
  if CompareText(VarName,'periode')=0 then
   Value := 'Periode : '+Tgl19.Text;
  end;

  if dxPageControl1.ActivePageIndex=20 then
  begin
  if CompareText(VarName,'gudang')=0 then
  Value := KodeGdg20.Text ;
  end;
  if dxPageControl1.ActivePageIndex=21 then
  begin
  if CompareText(VarName,'gudang')=0 then
  Value := KodeGdg21.Text ;
  if CompareText(VarName,'Periode')=0 then
  Value :='Periode :' +blnawal21.Text +' - ' + thnawal21.Text + '   s/d   ' + blnakhir21.Text +' - '+thnakhir21.Text ;
  end;
end;

procedure TFrReportPreview.DotMatrixClick(Sender: TObject);
begin
  frxReport1.DotMatrixReport := DotMatrix.Checked;
end;

procedure TFrReportPreview.TampilIsiKasBank;
begin
  Case KodeReport of
    20101,20109 : KodeBrows:=100403;
    20102,201081,201082,201083,201084,201085 : KodeBrows:=100404;
    201061,201062,201063,201064 : KodeBrows:=100410;
    //201071,201072,201073,201074,201075 : kodebrows:=100406;
    201071,201072,201073,201074,201075 : kodebrows:=20012;
  end;
  Application.CreateForm(TFrBrows, FrBrows);
  FrBrows.IsiData:=Perkiraan.Text;
  FrBrows.showmodal;
  if FrBrows.ModalResult=mrOk then
  begin
    with FrBrows.QuBrows do
    begin
      Case KodeReport of
        20101, 20102,201081,201082,201083,201084,201085,
        201061,201062,201063,201064,20109 : Perkiraan.Text:=fieldbyname('Perkiraan').AsString;
        //201071,201072,201073,201074,201075 : Perkiraan.Text:=fieldbyname('Bank').AsString;
        201071,201072,201073,201074,201075 : Perkiraan.Text:=fieldbyname('Perkiraan').AsString;
      end;

      //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
    end;
  end else
    ActiveControl:=Perkiraan;
end;

procedure TFrReportPreview.PerkiraanKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_Return then
  begin
    case KodeReport of
    20101,20102,201061,201062,201063,201064,201081,201082,201083,201084,201085,
    201071,201072,201073,201074,201075,20109:
      begin
          if DataBersyarat('Declare @Perkiraan varchar(25) '+
                       'Set @Perkiraan=:0 '+
                       'select a.Perkiraan,b.keterangan from dbposthutpiut a '+
                       'left outer join dbperkiraan b on b.perkiraan=a.perkiraan '+
                       'where a.Kode=Case when '+IntToStr(KodeReport) +' in (20101,20109) then ''KAS'' '+
                       '                  when '+IntToStr(KodeReport) +' in (20102,201081,201082,201083,201084) then ''BANK'' '+
                       '                  when '+IntToStr(KodeReport) +' in (201061,201062,201063,201064) then ''DP'' '+
                       'end and a.Perkiraan=@Perkiraan '+
                       'union '+
                       'Select distinct a.Bank Perkiraan,'''' Keterangan '+
                       'From dbGiro a '+
                       'where a.Tipe=''PT'' and a.Bank=@Perkiraan and a.TglCair Is null '+
                       'order by a.Perkiraan',
             [Perkiraan.Text],DM.QuCari)=true then
          begin
            with DM.QuCari do
            begin
              Perkiraan.Text:=fieldbyname('Perkiraan').AsString;
              //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
            end;
          end else
          begin
            TampilIsiKasBank;
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
    20301,20302, 20303, 20304, 20305, 20401,20402, 20403, 20404, 20405,20406,30362,204041 :
      begin
        if (KodeReport=20301) or (KodeReport=20302) or (KodeReport=20303) or (KodeReport=20304) or (KodeReport=20305) then
          xHTPT:='HT'
        else if  (KodeReport=30362) or (KodeReport=20401) or (KodeReport=20402) or (KodeReport=20403) or (KodeReport=20404) or (KodeReport=204041)or (KodeReport=20405) or (KodeReport=20406)then
          xHTPT:='PT';
        if length(Perkiraan8.Text)=0 then
        begin
          if (KodeReport=20301) or (KodeReport=20302) or (KodeReport=20303) or (KodeReport=20304) or (KodeReport=20305) then
             KodeBrows:=100409
          else if (KodeReport=30362) or (KodeReport=20401) or (KodeReport=20402) or (KodeReport=20403) or (KodeReport=20404) or (KodeReport=204041)or (KodeReport=20405) or (KodeReport=20406) then
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
            if (KodeReport=20301) or (KodeReport=20302) or (KodeReport=20303) or (KodeReport=20304) or (KodeReport=20305) then
             KodeBrows:=100409
          else if (KodeReport=20401) or (KodeReport=20402) or (KodeReport=20403) or (KodeReport=20404) or (KodeReport=204041)or (KodeReport=20405) then
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
  if (KodeReport =20301)or(KodeReport =20302)or(KodeReport =20303)or(KodeReport =20304)or(KodeReport =20305) Then
   Begin
    if (length((Sender as TEdit).Text)=0)  then
   begin
     KodeBrows:=10141;
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
     if DataBersyarat('select a.KodeCustsupp, a.NamaCustSupp NamaCust, A.Alamat, A.Telpon '+
                        'from vwBrowsSupp A '+
                        'where a.isaktif=1 and KodeCustsupp=:0 '+
                        'Order by a.kodecustsupp',[(Sender as TEdit).Text], DM.QuCari)=True then
     begin
       (Sender as TEdit).Text:=DM.QuCari.fieldbyname('KodeCustSupp').AsString;
       if (Sender as TEdit).Name='Awal8' then
           Akhir8.Text :=(Sender as TEdit).Text;
     end else
     begin
       KodeBrows:=10141;
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
   end
  else
  Begin
   if (length((Sender as TEdit).Text)=0)  then
   begin
     KodeBrows:=10145;
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
       KodeBrows:=10145;
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

procedure TFrReportPreview.frxReport1ProgressStart(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  Button2.Enabled:=False;
  Button1.Enabled:=False;
  CancelB.Enabled:=False;
  SpeedButton2.Enabled:=False;
end;

procedure TFrReportPreview.frxReport1ProgressStop(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  Button2.Enabled:=True;
  Button1.Enabled:=True;
  CancelB.Enabled:=True;
  SpeedButton2.Enabled:=True;
end;

procedure TFrReportPreview.JenisPakai14DropDown(Sender: TObject);
begin
  ComboBox_AutoWidth(JenisPakai14);
end;

procedure TFrReportPreview.Persediaan10DropDown(Sender: TObject);
begin
  ComboBox_AutoWidth(Persediaan10);
end;

procedure TFrReportPreview.Persediaan11DropDown(Sender: TObject);
begin
  ComboBox_AutoWidth(Persediaan11);
end;

procedure TFrReportPreview.Devisi13KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return Then
 begin
   begin
     if (length(Devisi13.Text)=0)  then
     begin
       KodeBrows:=1004;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=Devisi13.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Devisi13.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
         //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
       end else
       begin
        if Devisi13.Enabled=true then
        ActiveControl:=Devisi3;
       end;
     end else
     begin
       if MyFindField('dbDevisi','Devisi',Devisi13.Text)=true then
       begin
         Devisi13.Text:=DM.QuCari.fieldbyname('Devisi').AsString;
         //NamaDivisi.Text:=DM.QuCari.fieldbyname('NamaDevisi').AsString;
       end else
       begin
         KodeBrows:=1004;
         Application.CreateForm(Tfrbrows, frbrows);
         FrBrows.IsiData:=Devisi13.Text;
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           Devisi13.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
           //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
         end else
         begin
           if Devisi13.Enabled=true then
           ActiveControl:=Devisi13;
         end;
       end;
     end;
   end;
 end;

end;

procedure TFrReportPreview.Perkiraan12KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_Return then
  begin
    if length(Perkiraan12.Text)=0 then
    begin
      KodeBrows:=1005;
      Application.CreateForm(TFrBrows, FrBrows);
      FrBrows.IsiData:=Perkiraan2.Text;
      FrBrows.showmodal;
      if FrBrows.ModalResult=mrOk then
      begin
        with FrBrows.QuBrows do
        begin
          Perkiraan12.Text:=fieldbyname('Perkiraan').AsString;
          NamaPerkiraan12.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
        ActiveControl:=Perkiraan12;
    end else
    begin
      if DataBersyarat('select Perkiraan,Keterangan from dbPerkiraan where  tipe=1 and Perkiraan=:0 order by Perkiraan',
         [Perkiraan12.Text],DM.QuCari)=true then
      begin
        with DM.QuCari do
        begin
          Perkiraan12.Text:=fieldbyname('Perkiraan').AsString;
          //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
      begin
        KodeBrows:=1005;
        Application.CreateForm(TFrBrows, FrBrows);
        FrBrows.IsiData:=Perkiraan12.Text;
        FrBrows.showmodal;
        if FrBrows.ModalResult=mrOk then
        begin
          with FrBrows.QuBrows do
          begin
            Perkiraan12.Text:=fieldbyname('Perkiraan').AsString;
            //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
          end;
        end else
          ActiveControl:=Perkiraan12;
      end;
    end;
  end;

end;

procedure TFrReportPreview.Perkiraan13KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_Return then
  begin
    if length(Perkiraan13.Text)=0 then
    begin
      KodeBrows:=1005;
      Application.CreateForm(TFrBrows, FrBrows);
      FrBrows.IsiData:=Perkiraan13.Text;
      FrBrows.showmodal;
      if FrBrows.ModalResult=mrOk then
      begin
        with FrBrows.QuBrows do
        begin
          Perkiraan13.Text:=fieldbyname('Perkiraan').AsString;
          NamaPerkiraan13.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
        ActiveControl:=Perkiraan13;
    end else
    begin
      if DataBersyarat('select Perkiraan,Keterangan from dbPerkiraan where  tipe=1 and Perkiraan=:0 order by Perkiraan',
         [Perkiraan13.Text],DM.QuCari)=true then
      begin
        with DM.QuCari do
        begin
          Perkiraan13.Text:=fieldbyname('Perkiraan').AsString;
          //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
      begin
        KodeBrows:=1005;
        Application.CreateForm(TFrBrows, FrBrows);
        FrBrows.IsiData:=Perkiraan13.Text;
        FrBrows.showmodal;
        if FrBrows.ModalResult=mrOk then
        begin
          with FrBrows.QuBrows do
          begin
            Perkiraan13.Text:=fieldbyname('Perkiraan').AsString;
            //NamaPerkiraan.Caption:=fieldbyname('Keterangan').AsString;
          end;
        end else
          ActiveControl:=Perkiraan13;
      end;
    end;
  end;

end;

procedure TFrReportPreview.Perkiraan4KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_Return then
  begin
    if length(Perkiraan4.Text)=0 then
    begin
      KodeBrows:=1005;
      Application.CreateForm(TFrBrows, FrBrows);
      FrBrows.IsiData:=Perkiraan4.Text;
      FrBrows.showmodal;
      if FrBrows.ModalResult=mrOk then
      begin
        with FrBrows.QuBrows do
        begin
          Perkiraan4.Text:=fieldbyname('Perkiraan').AsString;
          NamaPerkiraan4.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
        ActiveControl:=Perkiraan4;
    end else
    begin
      if DataBersyarat('select Perkiraan,Keterangan from dbPerkiraan where  tipe=1 and Perkiraan=:0 order by Perkiraan',
         [Perkiraan4.Text],DM.QuCari)=true then
      begin
        with DM.QuCari do
        begin
          Perkiraan4.Text:=fieldbyname('Perkiraan').AsString;
          NamaPerkiraan4.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
      begin
        KodeBrows:=1005;
        Application.CreateForm(TFrBrows, FrBrows);
        FrBrows.IsiData:=Perkiraan4.Text;
        FrBrows.showmodal;
        if FrBrows.ModalResult=mrOk then
        begin
          with FrBrows.QuBrows do
          begin
            Perkiraan4.Text:=fieldbyname('Perkiraan').AsString;
            NamaPerkiraan4.Caption:=fieldbyname('Keterangan').AsString;
          end;
        end else
          ActiveControl:=Perkiraan4;
      end;
    end;
  end;
end;

procedure TFrReportPreview.Perkiraan5KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_Return then
  begin
    if length(Perkiraan5.Text)=0 then
    begin
      KodeBrows:=1005;
      Application.CreateForm(TFrBrows, FrBrows);
      FrBrows.IsiData:=Perkiraan5.Text;
      FrBrows.showmodal;
      if FrBrows.ModalResult=mrOk then
      begin
        with FrBrows.QuBrows do
        begin
          Perkiraan5.Text:=fieldbyname('Perkiraan').AsString;
          NamaPerkiraan5.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
        ActiveControl:=Perkiraan5;
    end else
    begin
      if DataBersyarat('select Perkiraan,Keterangan from dbPerkiraan where  tipe=1 and Perkiraan=:0 order by Perkiraan',
         [Perkiraan5.Text],DM.QuCari)=true then
      begin
        with DM.QuCari do
        begin
          Perkiraan5.Text:=fieldbyname('Perkiraan').AsString;
          NamaPerkiraan5.Caption:=fieldbyname('Keterangan').AsString;
        end;
      end else
      begin
        KodeBrows:=1005;
        Application.CreateForm(TFrBrows, FrBrows);
        FrBrows.IsiData:=Perkiraan5.Text;
        FrBrows.showmodal;
        if FrBrows.ModalResult=mrOk then
        begin
          with FrBrows.QuBrows do
          begin
            Perkiraan5.Text:=fieldbyname('Perkiraan').AsString;
            NamaPerkiraan5.Caption:=fieldbyname('Keterangan').AsString;
          end;
        end else
          ActiveControl:=Perkiraan5;
      end;
    end;
  end;
end;

procedure TFrReportPreview.Divisi4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return then
  begin
    if length(Divisi4.Text)=0 then
     begin
       KodeBrows:=251050;
       Application.CreateForm(Tfrbrows, frbrows);
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Divisi4.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
         NamaDivisi4.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
       end else
       begin
         if Divisi4.Enabled=true then
         ActiveControl:=Divisi4;
       end;
     end else
     begin
       if MyFindField('dbDevisi','Devisi',Divisi4.Text)=true then
       begin
         Divisi4.Text:=DM.QuCari.fieldbyname('Devisi').AsString;
         NamaDivisi4.Text:=DM.QuCari.fieldbyname('NamaDevisi').AsString;
       end else
       begin
         KodeBrows:=1004;
         Application.CreateForm(Tfrbrows, frbrows);
         FrBrows.IsiData:=Divisi4.Text;
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           Divisi4.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
           NamaDivisi4.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
         end else
         begin
           if Divisi4.Enabled=true then
           ActiveControl:=Divisi4;
         end;
       end;
     end;
  end;

end;

procedure TFrReportPreview.KodeTipe15KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=vk_Return then
  begin
    if length(Kodetipe15.Text)=0 then
     begin
       KodeBrows:=251050;
       Application.CreateForm(Tfrbrows, frbrows);
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         KodeTipe15.Text:=FrBrows.QuBrows.fieldbyname('Kodetipe').AsString;
       end else
       begin
         if KodeTipe15.Enabled=true then
         ActiveControl:=KodeTipe15;
       end;
     end else
     begin
       if MyFindField('DbTipeTrans','KodeTipe',KodeTipe15.Text)=true then
       begin
         KodeTipe15.Text:=DM.QuCari.fieldbyname('Kodetipe').AsString;
       end else
       begin
         KodeBrows:=251050;
         Application.CreateForm(Tfrbrows, frbrows);
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           KodeTipe15.Text:=FrBrows.QuBrows.fieldbyname('Kodetipe').AsString;
         end else
         begin
           if KodeTipe15.Enabled=true then
           ActiveControl:=KodeTipe15;
         end;
       end;
     end;
  end;
end;

procedure TFrReportPreview.KodeSubTipe15KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if key=vk_return Then
 begin
   if (length(KodeSubTipe15.Text)=0)  then
   begin
       KodeBrows:=30056;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.NoKira:=KOdetipe15.Text;
       frbrows.Showmodal;
     if FrBrows.ModalResult=mrOk then
     begin
       KodeSubTipe15.Text:=FrBrows.QuBrows.fieldbyname('KodeSubTipe').AsString;
       //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
     end else
     begin
      if KodeSubTipe15.Enabled=true then
      ActiveControl:=KodeSubTipe15;
     end;
   end else
   begin
     if MyFindField('DbSubTipeTrans','kodeSubtipeTrans',KodeSubTipe15.Text)=true then
     begin
       KodeSubTipe15.Text:=DM.QuCari.fieldbyname('KodeSubTipe').AsString;
       //NamaDivisi.Text:=DM.QuCari.fieldbyname('NamaDevisi').AsString;
     end else
     begin
       KodeBrows:=30056;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.nokira:=KodeTipe15.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         KodeSubTipe15.Text:=FrBrows.QuBrows.fieldbyname('KodeSubTipe').AsString;
         //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
       end else
       begin
         if KodeSubTipe15.Enabled=true then
         ActiveControl:=KodeSubTipe15;
       end;
     end;
   end;
 end;
end;

procedure TFrReportPreview.CbojnsChange(Sender: TObject);
begin
if Cbojns.ItemIndex=0 then
 Begin
   button2.Visible:=true;
   if (KodeReport=4010201) or (KodeReport=4010202)or (KodeReport=401020201) Then
   Begin
    Label98.Visible:=False;
    CboOto.Visible:=False;
   end;
 end
else if Cbojns.ItemIndex=1 then
Begin
   button2.Visible:=False;
   if (KodeReport=4010201) or (KodeReport=4010202)or (KodeReport=401020201) Then
   Begin
   Label98.Visible:=True;
   CboOto.Visible:=True;
   end;
end;
end;

procedure TFrReportPreview.KodeGdg17KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return then
  begin
    if length(kodeGDg17.Text)=0 then
     begin
       KodeBrows:=916;
       Application.CreateForm(Tfrbrows, frbrows);
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         kodeGDg17.Text:=FrBrows.QuBrows.fieldbyname('KodeGDG').AsString;
       end else
       begin
         if kodeGDg17.Enabled=true then
         ActiveControl:=kodeGDg17;
       end;
     end else
     begin
       if MyFindField('DBGudang','KodeGdg',kodeGDg17.Text)=true then
       begin
         kodeGDg17.Text:=DM.QuCari.fieldbyname('KodeGdg').AsString;
       end else
       begin
         KodeBrows:=916;
         Application.CreateForm(Tfrbrows, frbrows);
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           kodeGDg17.Text:=FrBrows.QuBrows.fieldbyname('kodeGdg').AsString;
         end else
         begin
           if kodeGDg17.Enabled=true then
           ActiveControl:=kodeGDg17;
         end;
       end;
     end;
  end;
end;

procedure TFrReportPreview.KodeGdg18KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key=vk_Return then
  begin
  if KodeReport=50104 Then
   Begin
    if length(kodeGDg18.Text)=0 then
     begin
       KodeBrows:=9161;
       Application.CreateForm(Tfrbrows, frbrows);
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         kodeGDg18.Text:=FrBrows.QuBrows.fieldbyname('KodeGDG').AsString;
       end else
       begin
         if kodeGDg18.Enabled=true then
         ActiveControl:=kodeGDg18;
       end;
     end else
     begin
       if MyFindField('DBGudang','KodeGdg',kodeGDg18.Text)=true then
       begin
         kodeGDg18.Text:=DM.QuCari.fieldbyname('KodeGdg').AsString;
       end else
       begin
         KodeBrows:=9161;
         Application.CreateForm(Tfrbrows, frbrows);
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           kodeGDg18.Text:=FrBrows.QuBrows.fieldbyname('kodeGdg').AsString;
         end else
         begin
           if kodeGDg18.Enabled=true then
           ActiveControl:=kodeGDg18;
         end;
       end;
     end;
    end
    else
    Begin
     if length(kodeGDg18.Text)=0 then
     begin
       KodeBrows:=9162;
       Application.CreateForm(Tfrbrows, frbrows);
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         kodeGDg18.Text:=FrBrows.QuBrows.fieldbyname('KodeGDG').AsString;
       end else
       begin
         if kodeGDg18.Enabled=true then
         ActiveControl:=kodeGDg18;
       end;
     end else
     begin
       if MyFindField('DBGudang','KodeGdg',kodeGDg18.Text)=true then
       begin
         kodeGDg18.Text:=DM.QuCari.fieldbyname('KodeGdg').AsString;
       end else
       begin
         KodeBrows:=9162;
         Application.CreateForm(Tfrbrows, frbrows);
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           kodeGDg18.Text:=FrBrows.QuBrows.fieldbyname('kodeGdg').AsString;
         end else
         begin
           if kodeGDg18.Enabled=true then
           ActiveControl:=kodeGDg18;
         end;
       end;
     end;
    end;
  end;
end;

procedure TFrReportPreview.KodeGdg19KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key=vk_Return then
  begin
    if length(kodeGDg19.Text)=0 then
     begin
       KodeBrows:=916;
       Application.CreateForm(Tfrbrows, frbrows);
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         kodeGDg19.Text:=FrBrows.QuBrows.fieldbyname('KodeGDG').AsString;
       end else
       begin
         if kodeGDg19.Enabled=true then
         ActiveControl:=kodeGDg19;
       end;
     end else
     begin
       if MyFindField('DBGudang','KodeGdg',kodeGDg19.Text)=true then
       begin
         kodeGDg19.Text:=DM.QuCari.fieldbyname('KodeGdg').AsString;
       end else
       begin
         KodeBrows:=916;
         Application.CreateForm(Tfrbrows, frbrows);
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           kodeGDg19.Text:=FrBrows.QuBrows.fieldbyname('kodeGdg').AsString;
         end else
         begin
           if kodeGDg19.Enabled=true then
           ActiveControl:=kodeGDg19;
         end;
       end;
     end;
  end;
end;

procedure TFrReportPreview.KodeGdg20KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key=vk_Return then
  begin
    if length(kodeGDg20.Text)=0 then
     begin
       KodeBrows:=916;
       Application.CreateForm(Tfrbrows, frbrows);
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         kodeGDg20.Text:=FrBrows.QuBrows.fieldbyname('KodeGDG').AsString;
       end else
       begin
         if kodeGDg20.Enabled=true then
         ActiveControl:=kodeGDg20;
       end;
     end else
     begin
       if MyFindField('DBGudang','KodeGdg',kodeGDg20.Text)=true then
       begin
         kodeGDg20.Text:=DM.QuCari.fieldbyname('KodeGdg').AsString;
       end else
       begin
         KodeBrows:=916;
         Application.CreateForm(Tfrbrows, frbrows);
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           kodeGDg20.Text:=FrBrows.QuBrows.fieldbyname('kodeGdg').AsString;
         end else
         begin
           if kodeGDg20.Enabled=true then
           ActiveControl:=kodeGDg20;
         end;
       end;
     end;
  end;
end;

procedure TFrReportPreview.KodeGdg21KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return then
  begin
    if length(kodeGDg21.Text)=0 then
     begin
       KodeBrows:=916;
       Application.CreateForm(Tfrbrows, frbrows);
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         kodeGDg21.Text:=FrBrows.QuBrows.fieldbyname('KodeGDG').AsString;
       end else
       begin
         if kodeGDg21.Enabled=true then
         ActiveControl:=kodeGDg21;
       end;
     end else
     begin
       if MyFindField('DBGudang','KodeGdg',kodeGDg21.Text)=true then
       begin
         kodeGDg21.Text:=DM.QuCari.fieldbyname('KodeGdg').AsString;
       end else
       begin
         KodeBrows:=916;
         Application.CreateForm(Tfrbrows, frbrows);
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           kodeGDg21.Text:=FrBrows.QuBrows.fieldbyname('kodeGdg').AsString;
         end else
         begin
           if kodeGDg21.Enabled=true then
           ActiveControl:=kodeGDg21;
         end;
       end;
     end;
  end;
end;

procedure TFrReportPreview.KodeBrg21KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return then
  begin
   if (KodeGdg21.Text='G01' )   Then
   Begin
    if length(KodeBrg21.Text)=0 then
     begin
       KodeBrows:=9171;
       Application.CreateForm(Tfrbrows, frbrows);
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         KodeBrg21.Text:=FrBrows.QuBrows.fieldbyname('KodeBrg').AsString;
       end else
       begin
         if KodeBrg21.Enabled=true then
         ActiveControl:=KodeBrg21;
       end;
     end else
     begin
       if MyFindField('DBbarang','KodeBrg',KodeBrg21.Text)=true then
       begin
         KodeBrg21.Text:=DM.QuCari.fieldbyname('KodeBrg').AsString;
       end else
       begin
         KodeBrows:=9171;
         Application.CreateForm(Tfrbrows, frbrows);
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           KodeBrg21.Text:=FrBrows.QuBrows.fieldbyname('Kodebrg').AsString;
         end else
         begin
           if KodeBrg21.Enabled=true then
           ActiveControl:=KodeBrg21;
         end;
       end;
     end;
    end
    else
    Begin
      if length(KodeBrg21.Text)=0 then
     begin
       KodeBrows:=9171;
       Application.CreateForm(Tfrbrows, frbrows);
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         KodeBrg21.Text:=FrBrows.QuBrows.fieldbyname('KodeBrg').AsString;
       end else
       begin
         if KodeBrg21.Enabled=true then
         ActiveControl:=KodeBrg21;
       end;
     end else
     begin
       if MyFindField('Dbarang','KodeBrg',KodeBrg21.Text)=true then
       begin
         KodeBrg21.Text:=DM.QuCari.fieldbyname('KodeBrg').AsString;
       end else
       begin
         KodeBrows:=9171;
         Application.CreateForm(Tfrbrows, frbrows);
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           KodeBrg21.Text:=FrBrows.QuBrows.fieldbyname('Kodebrg').AsString;
         end else
         begin
           if KodeBrg21.Enabled=true then
           ActiveControl:=KodeBrg21;
         end;
       end;
     end;
    end;
  end;
end;

procedure TFrReportPreview.Group17KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return then
  begin
    if length(Group17.Text)=0 then
     begin
       KodeBrows:=1100113;
       Application.CreateForm(Tfrbrows, frbrows);
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Group17.Text:=FrBrows.QuBrows.fieldbyname('KodeGrp').AsString;
       end else
       begin
         if Group17.Enabled=true then
         ActiveControl:=Group17;
       end;
     end else
     begin
       if MyFindField('dbGroup','KodeGrp',Group17.Text)=true then
       begin
         Group17.Text:=DM.QuCari.fieldbyname('KodeGrp').AsString;
       end else
       begin
         KodeBrows:=1100113;
         Application.CreateForm(Tfrbrows, frbrows);
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           Group17.Text:=FrBrows.QuBrows.fieldbyname('KodeGrp').AsString;
         end else
         begin
           if Group17.Enabled=true then
           ActiveControl:=Group17;
         end;
       end;
     end;
  end;
end;

procedure TFrReportPreview.Divisi2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_return Then
 begin
   if (Divisi2.Text = '-')  then
   begin
      if Perkiraan.Visible=true then
      ActiveControl := Perkiraan;
   end else
   begin
     if (length(Divisi2.Text)=0)  then
     begin
       KodeBrows:=1004;
       Application.CreateForm(Tfrbrows, frbrows);
       FrBrows.IsiData:=Divisi2.Text;
       frbrows.Showmodal;
       if FrBrows.ModalResult=mrOk then
       begin
         Divisi2.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
         //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
       end else
       begin
        if Divisi2.Enabled=true then
        ActiveControl:=Divisi;
       end;
     end else
     begin
       if MyFindField('dbDevisi','Devisi',Divisi2.Text)=true then
       begin
         Divisi2.Text:=DM.QuCari.fieldbyname('Devisi').AsString;
         //NamaDivisi.Text:=DM.QuCari.fieldbyname('NamaDevisi').AsString;
       end else
       begin
         KodeBrows:=1004;
         Application.CreateForm(Tfrbrows, frbrows);
         FrBrows.IsiData:=Divisi2.Text;
         frbrows.Showmodal;
         if FrBrows.ModalResult=mrOk then
         begin
           Divisi2.Text:=FrBrows.QuBrows.fieldbyname('Devisi').AsString;
           //NamaDivisi.Text:=FrBrows.QuBrows.fieldbyname('NamaDevisi').AsString;
         end else
         begin
           if Divisi2.Enabled=true then
           ActiveControl:=Divisi;
         end;
       end;
     end;
   end;
 end;
end;

end.



