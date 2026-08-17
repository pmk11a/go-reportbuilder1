
{******************************************}
{                                          }
{             FastReport v3.0              }
{      Language resources management       }
{                                          }
{         Copyright (c) 1998-2005          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxRes;

interface

{$I frx.inc}

uses
  Windows, SysUtils, Classes, Controls, Graphics, Forms, ImgList, TypInfo
{$IFDEF Delphi6}
, Variants
{$ENDIF};


type
  TfrxResources = class(TObject)
  private
    FDisabledButtonImages: TImageList;
    FMainButtonImages: TImageList;
    FNames: TStringList;
    FObjectImages: TImageList;
    FValues: TStringList;
    FLanguages: TStringList;
    function GetMainButtonImages: TImageList;
    function GetObjectImages: TImageList;
    procedure BuildLanguagesList;
  public
    constructor Create;
    destructor Destroy; override;
    function Get(const StrName: String): String;
    procedure Add(const Ref, Str: String);
    procedure AddStrings(const Str: String);
    procedure Clear;
    procedure LoadFromFile(const FileName: String);
    procedure LoadFromStream(Stream: TStream);
    procedure SetButtonImages(Images: TBitmap; Clear: Boolean = False);
    procedure SetObjectImages(Images: TBitmap; Clear: Boolean = False);
    procedure UpdateFSResources;
    property DisabledButtonImages: TImageList read FDisabledButtonImages;
    property MainButtonImages: TImageList read GetMainButtonImages;
    property ObjectImages: TImageList read GetObjectImages;
    property Languages: TStringList read FLanguages;
  end;

function frxResources: TfrxResources;
function frxGet(ID: Integer): String;


implementation

uses frxUtils, fs_iconst;

var
  FResources: TfrxResources = nil;


{ TfrxResources }

constructor TfrxResources.Create;
begin
  inherited;
  FDisabledButtonImages := TImageList.Create(nil);
  FDisabledButtonImages.Width := 16;
  FDisabledButtonImages.Height := 16;
  FMainButtonImages := TImageList.Create(nil);
  FMainButtonImages.Width := 16;
  FMainButtonImages.Height := 16;
  FObjectImages := TImageList.Create(nil);
  FObjectImages.Width := 22;
  FObjectImages.Height := 22;
  FNames := TStringList.Create;
  FValues := TStringList.Create;
  FNames.Sorted := True;
  FLanguages :=TStringList.Create;
  BuildLanguagesList;
end;

destructor TfrxResources.Destroy;
begin
  FLanguages.Free;
  FDisabledButtonImages.Free;
  FMainButtonImages.Free;
  FObjectImages.Free;
  FNames.Free;
  FValues.Free;
  inherited;
end;

procedure TfrxResources.Add(const Ref, Str: String);
var
  i: Integer;
begin
  i := FNames.IndexOf(Ref);
  if i = -1 then
  begin
    FNames.AddObject(Ref, Pointer(FValues.Count));
    FValues.Add(Str);
  end
  else
    FValues[Integer(FNames.Objects[i])] := Str;
end;

procedure TfrxResources.AddStrings(const Str: String);
var
  i: Integer;
  sl: TStringList;
  nm, vl: String;
begin
  sl := TStringList.Create;
  sl.Text := Str;
  for i := 0 to sl.Count - 1 do
  begin
    nm := sl[i];
    vl := Copy(nm, Pos('=', nm) + 1, MaxInt);
    nm := Copy(nm, 1, Pos('=', nm) - 1);
    if (nm <> '') and (vl <> '') then
      Add(nm, vl);
  end;
  sl.Free;
end;

procedure TfrxResources.Clear;
begin
  FNames.Clear;
  FValues.Clear;
end;

function TfrxResources.Get(const StrName: String): String;
var
  i: Integer;
begin
  i := FNames.IndexOf(StrName);
  if i <> -1 then
    Result := FValues[Integer(FNames.Objects[i])] else
    Result := StrName;
end;

function TfrxResources.GetMainButtonImages: TImageList;
var
  Images: TBitmap;
begin
  if FMainButtonImages.Count = 0 then
  begin
    Images := TBitmap.Create;
    try
      Images.LoadFromResourceName(hInstance, 'frxBUTTONS');
      SetButtonImages(Images);
    finally
      Images.Free;
    end;
  end;

  Result := FMainButtonImages;
end;

function TfrxResources.GetObjectImages: TImageList;
var
  Images: TBitmap;
begin
  if FObjectImages.Count = 0 then
  begin
    Images := TBitmap.Create;
    try
      Images.LoadFromResourceName(hInstance, 'frxOBJECTS');
      SetObjectImages(Images);
    finally
      Images.Free;
    end;
  end;

  Result := FObjectImages;
end;

procedure TfrxResources.SetButtonImages(Images: TBitmap; Clear: Boolean = False);
begin
  if Clear then
  begin
    FMainButtonImages.Clear;
    FDisabledButtonImages.Clear;
  end;
  frxAssignImages(Images, 16, 16, FMainButtonImages, FDisabledButtonImages);
end;

procedure TfrxResources.SetObjectImages(Images: TBitmap; Clear: Boolean = False);
begin
  if Clear then
    FObjectImages.Clear;
  frxAssignImages(Images, 22, 22, FObjectImages);
end;

procedure TfrxResources.LoadFromFile(const FileName: String);
var
  f: TFileStream;
begin
  if FileExists(FileName) then
  begin
    f := TFileStream.Create(FileName, fmOpenRead);
    try
      LoadFromStream(f);
    finally
      f.Free;
    end;
  end;
end;

procedure TfrxResources.LoadFromStream(Stream: TStream);
var
  sl: TStringList;
  i: Integer;
  nm, vl: String;
begin
  sl := TStringList.Create;
  try
    sl.LoadFromStream(Stream);
    Clear;
    for i := 0 to sl.Count - 1 do
    begin
      nm := sl[i];
      vl := Copy(nm, Pos('=', nm) + 1, MaxInt);
      nm := Copy(nm, 1, Pos('=', nm) - 1);
      if (nm <> '') and (vl <> '') then
        Add(nm, vl);
    end;
  finally
    sl.Free;
  end;
  UpdateFSResources;
end;

procedure TfrxResources.UpdateFSResources;
begin
  SLangNotFound := Get('SLangNotFound');
  SInvalidLanguage := Get('SInvalidLanguage');
  SIdRedeclared := Get('SIdRedeclared');
  SUnknownType := Get('SUnknownType');
  SIncompatibleTypes := Get('SIncompatibleTypes');
  SIdUndeclared := Get('SIdUndeclared');
  SClassRequired := Get('SClassRequired');
  SIndexRequired := Get('SIndexRequired');
  SStringError := Get('SStringError');
  SClassError := Get('SClassError');
  SArrayRequired := Get('SArrayRequired');
  SVarRequired := Get('SVarRequired');
  SNotEnoughParams := Get('SNotEnoughParams');
  STooManyParams := Get('STooManyParams');
  SLeftCantAssigned := Get('SLeftCantAssigned');
  SForError := Get('SForError');
  SEventError := Get('SEventError');
end;


function frxResources: TfrxResources;
begin
  if FResources = nil then
    FResources := TfrxResources.Create;
  Result := FResources;
end;

function frxGet(ID: Integer): String;
begin
  Result := frxResources.Get(IntToStr(ID));
end;


procedure TfrxResources.BuildLanguagesList;
var
  i: Integer;
  SRec: TSearchRec;
  Dir: String;
  s: String;
begin
  Dir := GetAppPath;
  FLanguages.Clear;
  i := FindFirst(Dir + '*.frc', faAnyFile, SRec);
  try
    while i = 0 do
    begin
      s := LowerCase(SRec.Name);
      s := UpperCase(Copy(s, 1, 1)) + Copy(s, 2, Length(s) - 1);
      s := StringReplace(s, '.frc', '', []);
      FLanguages.Add(s);
      i := FindNext(SRec);
    end;
    FLanguages.Sort;
  finally
    FindClose(Srec);
  end;
end;

initialization

finalization
  if FResources <> nil then
    FResources.Free;
  FResources := nil;

end.


//6a95de70c0b2694f37b8c182c56ecec2