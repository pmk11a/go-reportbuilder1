
{******************************************}
{                                          }
{             FastReport v3.0              }
{              Search dialog               }
{                                          }
{         Copyright (c) 1998-2005          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxSearchDialog;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrxSearchDialog = class(TForm)
    ReplacePanel: TPanel;
    ReplaceL: TLabel;
    ReplaceE: TEdit;
    Panel2: TPanel;
    TextL: TLabel;
    TextE: TEdit;
    Panel3: TPanel;
    OkB: TButton;
    CancelB: TButton;
    SearchL: TGroupBox;
    CaseCB: TCheckBox;
    TopCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
  end;


implementation

uses frxRes;

{$R *.DFM}

var
  LastText: String;

procedure TfrxSearchDialog.FormCreate(Sender: TObject);
begin
  Caption := frxGet(300);
  TextL.Caption := frxGet(301);
  SearchL.Caption := frxGet(302);
  ReplaceL.Caption := frxGet(303);
  TopCB.Caption := frxGet(304);
  CaseCB.Caption := frxGet(305);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
end;

procedure TfrxSearchDialog.FormShow(Sender: TObject);
begin
  TextE.Text := LastText;
  TextE.SetFocus;
  TextE.SelectAll;
end;

procedure TfrxSearchDialog.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
    LastText := TextE.Text;
end;

end.



//6a95de70c0b2694f37b8c182c56ecec2