unit FrmMenuReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DB, ADODB, StdCtrls, Buttons, Wwdbigrd, Wwdbgrid;

type
  TFrMenuReport = class(TForm)
    QuMenu: TADOQuery;
    DataSource1: TDataSource;
    Label1: TLabel;
    Keluar: TBitBtn;
    QuUpdate: TADOQuery;
    QuMenuUserID: TStringField;
    QuMenuL0: TWordField;
    QuMenuL1: TStringField;
    QuMenuNmReport: TStringField;
    QuMenuKodeReport: TIntegerField;
    QuMenuAccess: TBooleanField;
    QuMenuIsDesign: TBooleanField;
    QuMenuIsexport: TBooleanField;
    wwDBGrid1: TwwDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure wwDBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure simpan(namafield:string;isiCek:Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    L1X, UserIDX, L0X ,kodegdgx,  Label1X, get2Digit:String;
    CB1, CB2, CB3, CB4 : Boolean;
    ModeX : integer;
    procedure simpanData(kolom: integer);
  end;
const
     LoC = LoCaseInsensitive;
     LoP = LoPartialKey;

var
  FrMenuReport: TFrMenuReport;

implementation
uses MyProcedure, MyGlobal, MyModul, FrmPemakai;
{$R *.dfm}

procedure TFrMenuReport.simpanData(kolom: integer);
var
  tuserid, tl1, tfield,xCaption: string;
begin
  tuserid := QuMenu.fieldbyname('userid').AsString;
  tl1 := QuMenu.fieldbyname('l1').AsString;
  tfield := wwDBGrid1.FieldName(kolom);
  xCaption := QuMenu.fieldbyname('nmReport').AsString;
  if kolom <> 1 then
    begin
      if QuMenu.FieldByName('kodereport').Value <> 0 then
        begin
          with QuUpdate do
            begin
              Close;
              SQL.Clear;
              SQL.Add('update dbflmenureport set ' + tfield + '=:0');
              SQL.Add('where userid=:1 and l1=:2 ');
              Prepared;
              Parameters[0].Value := not QuMenu.FieldByName(tfield).AsBoolean;
              Parameters[1].Value := tuserid;
              Parameters[2].Value := tl1;
              ExecSQL;
            end;
            LoggingData(IDUser,'U','Menu','',
                    ' Memberi user '+tuserid+' akses ke menu '+xCaption);
        end else
        begin
          with QuUpdate do
            begin
              Close;
              SQL.Clear;
              SQL.Add('update dbflmenureport set ' + tfield + '=:0');
              SQL.Add('where userid=:1 and l1 like :2 ');
              Prepared;
              Parameters[0].Value := not QuMenu.FieldByName(tfield).AsBoolean;
              Parameters[1].Value := tuserid;
              Parameters[2].Value := tl1 + '%';
              ExecSQL;
            end;
            LoggingData(IDUser,'U','Menu','',
                    ' Memberi user '+tuserid+' akses ke semua menu '+xCaption);
        end;
      QuMenu.Requery;
      QuMenu.Locate('l1',tl1,[LOC, LOP]);
      wwDBGrid1.SetActiveField(tfield);
    end;
end;

procedure TFrMenuReport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=cafree;
end;

procedure TFrMenuReport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
     SendMessage(Handle, WM_NEXTDLGCTL, 0, 0) else
  if key = 27 then
  begin
    close;
  end;
end;

procedure TFrMenuReport.FormShow(Sender: TObject);
begin
  Label1.Caption:=frPemakai.QuView.fieldbyname('userid').AsString;
  with QuMenu do
  begin
    Close;
    Prepared;
    Parameters[0].Value:=frPemakai.QuView.fieldbyname('userid').AsString;
    Open;
  end;
end;

procedure TFrMenuReport.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if (Field.DataSet.FieldByName('L0').Value=1)
      then
  begin
    ABrush.Color:=$00C0F8F7;
    AFont.Color:= clred;
  end else
  begin
    ABrush.Color:=clWindow;
    AFont.Color:=clBlack;
  end;
  if Highlight then
  begin
    if ABrush.Color=$00C0F8F7 then
    begin
      AFont.Color := clLtGray;
      ABrush.Color := $0010968C;
    end else
    begin
      AFont.Color := clWhite;
      ABrush.Color := $006C6C6C;
    end;
  end;
end;

procedure TFrMenuReport.simpan(namafield:string;isiCek:Boolean);
begin
   UseridX:=Frmenureport.QuMenu.fieldbyName('Userid').AsString;
   L1X:=Frmenureport.QuMenu.fieldbyName('L1').AsString;
   with dm.qucari do
   begin
      close;
      sql.Clear;
      sql.add('update dbflmenureport set '+namafield+'=:0 ');
      sql.add('where userid=:1 and l1 like :2 ');
      prepared;
      parameters[0].value := isiCek;
      parameters[1].value := UseridX;
      parameters[2].value := L1X+'%';
      execsql;
   end;
end;

procedure TFrMenuReport.wwDBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
   simpanData(wwDBGrid1.GetActiveCol);
end;

end.
