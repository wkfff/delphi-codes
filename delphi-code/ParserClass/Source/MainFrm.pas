unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ClassParser, Config;

type
  TMainForm = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    lstRef: TListBox;
    pnl3: TPanel;
    spl1: TSplitter;
    pnl6: TPanel;
    lstRefClass: TListBox;
    spl3: TSplitter;
    grp1: TGroupBox;
    grp2: TGroupBox;
    spl4: TSplitter;
    pnl7: TPanel;
    lstNew: TListBox;
    pnl8: TPanel;
    pnl9: TPanel;
    lstNewClass: TListBox;
    stat1: TStatusBar;
    lbl1: TLabel;
    grp3: TGroupBox;
    grp4: TGroupBox;
    grp5: TGroupBox;
    grp6: TGroupBox;
    cbbRef: TComboBox;
    pnl4: TPanel;
    pnl5: TPanel;
    cbbNew: TComboBox;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    procedure cbbNewChange(Sender: TObject);
    procedure cbbNewMouseEnter(Sender: TObject);
    procedure cbbRefChange(Sender: TObject);
    procedure cbbRefMouseEnter(Sender: TObject);
    procedure edt1Change(Sender: TObject);
    procedure edt2Change(Sender: TObject);
    procedure edt3Change(Sender: TObject);
    procedure edt4Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstNewClassClick(Sender: TObject);
    procedure lstNewClick(Sender: TObject);
    procedure lstNewMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure lstRefClassClick(Sender: TObject);
    procedure lstRefClick(Sender: TObject);
    procedure lstRefMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FRefFiles, FRefFilesTemp,
    FNewFiles, FNewFilesTemp,
    FRefClasses, FNewClasses: TStringList;
    procedure GetFiles(APath: string; AFiles, ATempFiles: TStringList; AListBox:
        TListBox);
    procedure GetClasses(AFile: string; AListBox: TListBox; AClassList:
        TStringList);
    procedure GetClassImpl(AOutFile: string; AFileListBox, AClassListBox: TListBox);
    procedure UpdateComb(AFile: string; AIsRef: Boolean; AForceUpdate: Boolean =
        False);
    procedure Search(AName: string; AListBox: TListBox; AList: TStringList);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  GrandFileUtils, GrandStrUtils, StrUtils;

const
  CRefFile = 'Left.pas';
  CProductFile = 'Right.pas';
  CConfigFile = 'config.ini';

{$R *.dfm}

procedure TMainForm.cbbNewChange(Sender: TObject);
begin
  GetFiles(cbbNew.Text, FNewFiles, FNewFilesTemp, lstNew);
  UpdateComb(cbbNew.Text, False);
end;

procedure TMainForm.cbbNewMouseEnter(Sender: TObject);
begin
  stat1.Panels[1].Text := cbbNew.Text;
end;

procedure TMainForm.cbbRefChange(Sender: TObject);
begin
  GetFiles(cbbRef.Text, FRefFiles, FRefFilesTemp, lstRef);
  UpdateComb(cbbRef.Text, True);
end;

procedure TMainForm.cbbRefMouseEnter(Sender: TObject);
begin
  stat1.Panels[1].Text := cbbRef.Text;
end;

procedure TMainForm.edt1Change(Sender: TObject);
begin
  Search(edt1.Text, lstRef, FRefFiles);
end;

procedure TMainForm.edt2Change(Sender: TObject);
begin
  Search(edt2.Text, lstRefClass, FRefClasses);
end;

procedure TMainForm.edt3Change(Sender: TObject);
begin
  Search(edt3.Text, lstNew, FNewFiles);
end;

procedure TMainForm.edt4Change(Sender: TObject);
begin
  Search(edt4.Text, lstNewClass, FNewClasses);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  s: string;
begin
  FRefFiles := TStringList.Create;
  FNewFiles := TStringList.Create;
  FRefFilesTemp := TStringList.Create;
  FNewFilesTemp := TStringList.Create;
  FRefClasses := TStringList.Create;
  FNewClasses := TStringList.Create;
  s := ExpandFileName(CConfigFile);
  IniOptions.LoadFromFile(s);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  s: string;
  I: Integer;
begin
  for I := 0 to FRefClasses.Count - 1 do
    FRefClasses.Objects[I].Free;
  for I := 0 to FNewClasses.Count - 1 do
    FNewClasses.Objects[I].Free;
  FRefFiles.Free;
  FNewFiles.Free;
  FRefFilesTemp.Free;
  FNewFilesTemp.Free;
  FRefClasses.Free;
  FNewClasses.Free;
  s := ExpandFileName(CConfigFile);
  IniOptions.SaveToFile(s);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  UpdateComb('', True, True);
end;

procedure TMainForm.GetClasses(AFile: string; AListBox: TListBox; AClassList:
    TStringList);
var
//  AClassList: TStringList;
  I: Integer;
begin
  for I := 0 to AClassList.Count - 1 do
    AClassList.Objects[I].Free;

  AClassList.Clear;
  AListBox.Clear;
  if FileExists(AFile) then
  begin
//    AClassList := TStringList.Create;
    try
      GClassParser.ParseClass(AFile, AClassList);

      AClassList.Sorted := False;
      AClassList.Sort;

      for I := 0 to AClassList.Count - 1 do
        AListBox.AddItem(AClassList[I], AClassList.Objects[I]);
    finally
//      AClassList.Free;
    end;
  end;
end;

procedure TMainForm.GetClassImpl(AOutFile: string; AFileListBox, AClassListBox:
    TListBox);
var
  I: Integer;
  oList, oTempList: TStringList;
  sClass: string;
  sFile: string;
begin
  if AClassListBox.ItemIndex > -1 then
  begin
    oList := TStringList.Create;
    oTempList := TStringList.Create;
    try
      sFile := string(AFileListBox.Items.Objects[AFileListBox.ItemIndex]);
      sClass := string(AClassListBox.Items[AClassListBox.ItemIndex]);
      GClassParser.ParseClassImpl(sFile, sClass, oList);

      oTempList.Add('unit '+sClass+';');
      oTempList.Add('interface');
      oTempList.Add('type');      

      for I := 0 to TStringList(AClassListBox.Items.Objects[AClassListBox.ItemIndex]).Count - 1 do
        oTempList.Add(TStringList(AClassListBox.Items.Objects[AClassListBox.ItemIndex])[I]);

      oTempList.Add('implementation');

      for I := 0 to oList.Count - 1 do
        oTempList.Add(oList[I]);

      oTempList.SaveToFile(AOutFile);
    finally
      oList.Free;
      oTempList.Free;
    end;
  end;
end;

procedure TMainForm.GetFiles(APath: string; AFiles, ATempFiles: TStringList;
    AListBox: TListBox);
var
  I: Integer;
  s: string;
begin
  ATempFiles.Clear;
  AFiles.Clear;
  AListBox.Clear;

  if not DirectoryExists(APath) then
    Exit;

  FindFiles('*.pas', APath, ATempFiles);

  for I := 0 to ATempFiles.Count - 1 do
  begin
    s := ExtractFileNameOnly(ATempFiles[I]);
    AFiles.AddObject(s, TObject(ATempFiles[I]));
  end;

  AFiles.Sorted := False;
  AFiles.Sort;
  for I := 0 to AFiles.Count - 1 do
    AListBox.AddItem(AFiles[I], AFiles.Objects[I]);
end;

procedure TMainForm.lstNewClassClick(Sender: TObject);
begin
  GetClassImpl(CProductFile, lstNew, lstNewClass);
end;

procedure TMainForm.lstNewClick(Sender: TObject);
begin
  edt4.Text := '';
  lstNewClass.Clear;
  if lstNew.ItemIndex > -1 then
    GetClasses(string(lstNew.Items.Objects[lstNew.ItemIndex]), lstNewClass, FNewClasses);
end;

procedure TMainForm.lstNewMouseMove(Sender: TObject; Shift: TShiftState; X, Y:
    Integer);
var
  nIndex: Integer;
  pt: TPoint;
begin
//  nIndex := Y div lstNew.ItemHeight;
  pt.X := X;
  pt.Y := Y;
  nIndex := lstNew.ItemAtPos(pt, True);
  if (nIndex > -1) and (nIndex < lstNew.Count) then
    stat1.Panels[1].Text := string(lstNew.Items.Objects[nIndex]);
end;

procedure TMainForm.lstRefClassClick(Sender: TObject);
begin
  GetClassImpl(CRefFile, lstRef, lstRefClass);
end;

procedure TMainForm.lstRefClick(Sender: TObject);
begin
  edt2.Text := '';
  lstRefClass.Clear;
  if lstRef.ItemIndex > -1 then
    GetClasses(string(lstRef.Items.Objects[lstRef.ItemIndex]), lstRefClass, FRefClasses);
end;

procedure TMainForm.lstRefMouseMove(Sender: TObject; Shift: TShiftState; X, Y:
    Integer);
var
  nIndex: Integer;
  pt: TPoint;
begin
//  nIndex := Y div lstRef.ItemHeight;
  pt.X := X;
  pt.Y := Y;
  nIndex := lstRef.ItemAtPos(pt, True);

  if (nIndex > -1) and (nIndex < lstRef.Count) then
    stat1.Panels[1].Text := string(FRefFiles.Objects[nIndex]);
end;

procedure TMainForm.Search(AName: string; AListBox: TListBox; AList:
    TStringList);
var
  I: Integer;
begin
  AListBox.Clear;
  for I := 0 to AList.Count - 1 do
    if (AName = '') or AnsiContainsText(AList[I], AName) then
      AListBox.AddItem(AList[I], AList.Objects[I]);
end;

procedure TMainForm.UpdateComb(AFile: string; AIsRef: Boolean; AForceUpdate:
    Boolean = False);
var
  I: Integer;
  n: Integer;
  s: string;
begin
  if AForceUpdate then
  begin
    s := IniOptions.RefRefFiles;
    n := Occurs(';', s);
    for I := 1 to n + 1 do
      cbbRef.AddItem(GetSubString(s, ';', I), nil);

    s := IniOptions.NewNewFiles;
    n := Occurs(';', s);
    for I := 1 to n + 1 do
      cbbNew.AddItem(GetSubString(s, ';', I), nil);

    Exit;
  end;

  if not DirectoryExists(AFile) then Exit;

  if AIsRef then
  begin
    if cbbRef.Items.IndexOf(AFile)>-1 then Exit;
    cbbRef.Clear;
    if IniOptions.RefRefFiles <> '' then
      IniOptions.RefRefFiles := IniOptions.RefRefFiles + ';';
    IniOptions.RefRefFiles := IniOptions.RefRefFiles + AFile;

    s := IniOptions.RefRefFiles;
    n := Occurs(';', s);
    for I := 1 to n + 1 do
      cbbRef.AddItem(GetSubString(s, ';', I), nil);
  end
  else begin
    if cbbNew.Items.IndexOf(AFile)>-1 then Exit;
    cbbNew.Clear;
    if IniOptions.NewNewFiles <> '' then
      IniOptions.NewNewFiles := IniOptions.NewNewFiles + ';';
    IniOptions.NewNewFiles := IniOptions.NewNewFiles + AFile;
    s := IniOptions.NewNewFiles;
    n := Occurs(';', s);
    for I := 1 to n + 1 do
      cbbNew.AddItem(GetSubString(s, ';', I), nil);
  end;
end;

end.
