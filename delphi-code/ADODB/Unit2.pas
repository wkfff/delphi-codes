unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADOConst, ADODB, GSPEngineUtils, GSPInterface, StdCtrls, DB, ActnList,
  IniFiles, GrandZipFile, ShellAPI, GrandUIUtils;

type

  TByteSet = set of Byte;
  TForm2 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    btn5: TButton;
    actlst1: TActionList;
    ac1: TAction;
    grp1: TGroupBox;
    btn3: TButton;
    edt1: TEdit;
    grp2: TGroupBox;
    btn4: TButton;
    edt2: TEdit;
    lbl1: TLabel;
    grp3: TGroupBox;
    ck1: TCheckBox;
    ck2: TCheckBox;
    ck3: TCheckBox;
    ck4: TCheckBox;
    btn6: TButton;
    btn7: TButton;
    ac2: TAction;
    edt3: TEdit;
    lbl2: TLabel;
    edt4: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    btn8: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ac1Execute(Sender: TObject);
    procedure ac2Execute(Sender: TObject);
    procedure actlst1Update(Action: TBasicAction; var Handled: Boolean);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure edt1Change(Sender: TObject);
    procedure edt2Change(Sender: TObject);
    procedure edt3KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
   FDAOcon: TADOConnection;
   FCommonGSP: string;
   FRegionGSP: string;
   FGCL9File: string;
   FGCLProjDataFile: string;

   FTempDir: string;

   FIniFile: TIniFile;


    { Private declarations }
    procedure T1;
    procedure T2(var aTable: TADOTable);
    function Sync: Boolean;
    procedure MyZip;
    procedure MyExtract;
    function GetRange: TByteSet;
    function DeleteDirectory(const Source:String): Boolean;
    procedure Syn;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

const
  CCnnstr = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;';
  CMDBFile = 'E:\workspace\ADODB\SysInfo.mdb';


  FProj = 'E:\workspace\ADODB\ProjData.GSP';
  Fg1 = 'E:\workspace\ADODB\g.GSP';

  ptnEntQtyDict = 'EntQtyDict';
  ptnEntTypeDict = 'EntTypeDict';

  ptnQtyDict = 'QtyDict';

  pfnEntTypeName = 'EntTypeName';
  pfnEntTypeID = 'EntTypeID';
  pfnQtyCode = 'QtyCode';
  pfnQtyName = 'QtyName';
  pfnQtyID = 'QtyID';
  pfnCombineFactoryID = 'CombineFactoryID';
  pfnCombineInfo = 'CombineInfo';

  pfnElementTypeID = 'ElementTypeID';
  pfnCode = 'Code';
  pfnDescription = 'Description';


  asql = 'update EntQtyDict ' +
        'set EntQtyDict.EntTypeName=' +
        '(SELECT EntTypeDict.EntTypeName FROM EntTypeDict ' +
        'WHERE EntTypeDict.EntTypeID=EntQtyDict.EntTypeID)';

  CRegionGSP = 'RegionGSP';
  CGCLFile = 'GCLFile';
  CVAR = 'VAR';
  CTemp = 'temp';

  procedure ExecuteSQL(const AQry: TADOQuery; const ASQL: string);

implementation


{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
const
  ini = 'cfg.ini';
var
  bnew: Boolean;
  s: string;
begin
  bnew := False;
//  if not FileExists(ini) then
//  begin
//    FileCreate(ini);
//    bnew := True;
//  end;

//    CreateFile( ini,0,FILE_SHARE_READ,nil,CREATE_NEW ,FILE_ATTRIBUTE_NORMAL,FILE_FLAG_WRITE_THROUGH);
  FIniFile := TIniFile.Create('cfg.ini');
//  if bnew then
//  begin
//    FIniFile.WriteString(CVAR, CRegionGSP, '');
//    FIniFile.WriteString(CVAR, CGCLFile, '');
//  end;

  FRegionGSP := FIniFile.ReadString(CVAR, CRegionGSP, '');
  s := FIniFile.ReadString(CVAR, CGCLFile, '');
  if Pos('.GCL9', s) > -1 then
    FGCL9File := s
  else
    FGCLProjDataFile := s;

  edt1.Text := FRegionGSP;
  edt2.Text := s;

  FTempDir := ExtractFilePath(Application.Exename) + CTemp;
end;

function TForm2.GetRange: TByteSet;
var
  a,b: Integer;
  I: Integer;
  t: Boolean;
begin
  a := -1;
  b := -1;
  if ck1.Checked then
    Result := [0..14];
  if ck2.Checked then
    Result := Result + [15..29];
  if ck3.Checked then
    Result := Result + [30..53];
  if ck4.Checked then
    Result := Result + [54..255];

  if (edt3.Text <> '') and (edt4.Text <> '') then
  begin
    if TryStrToInt(edt3.Text, a) and TryStrToInt(edt4.Text, b) then
      Result := [a..b];
  end;

end;

procedure TForm2.ac1Execute(Sender: TObject);
begin
  MyExtract;
  if Sync then
  begin
    MyZip;
    DeleteDirectory(FTempDir);
    ShowMessage('ok');
  end;
end;

procedure TForm2.ac2Execute(Sender: TObject);
begin
  if Sync then
    ShowMessage('ok');
end;

procedure TForm2.actlst1Update(Action: TBasicAction; var Handled: Boolean);
begin
//  btn5.Enabled := (FileExists(FGCL9File) or FileExists(FGCLProjDataFile))
//    and FileExists(FRegionGSP);
  ac1.Enabled := FileExists(FGCL9File) and  FileExists(FRegionGSP);
  ac2.Enabled :=  FileExists(FGCLProjDataFile) and FileExists(FRegionGSP);
end;

procedure TForm2.btn1Click(Sender: TObject);
begin
  Exit;
  T1;
  ShowMessage('');
end;

procedure TForm2.btn2Click(Sender: TObject);
var
  I: Integer;
  oModel: IGSPModel;
  oTbl, oEntTypeTbl: IGSPTable;
  oRecord: IGSPRecord;
  nTypeID: Integer;
begin
  oModel := GSPEngineUtils.GSPEngine().CreateModel();
  GSPEngineUtils.GSPEngine().CreateModelXMLReader().read(FGCLProjDataFile, oModel);
  oModel.BeginTransaction;
  try
    oTbl := oModel.FindTable('business', ptnQtyDict);

    for I := 0 to oTbl.RecordCount - 1 do
    begin
      oRecord := oTbl.records[I];
      if (not SameText(oRecord.AsString[pfnCode], 'SL')) and
        (oRecord.AsInteger[pfnCombineFactoryID] = 2) then
      begin
        oRecord.AsInteger[pfnCombineFactoryID] := 14;
        oRecord.AsString[pfnCombineInfo] := 'SignValueName=' + oRecord.AsString['Description'];
      end;
    end;

    GSPEngineUtils.GSPEngine().CreateModelXMLWriter.Write(FGCLProjDataFile, oModel);
    oModel.EndTransaction;
    ShowMessage('ok');
  except
    oModel.Rollback;
    ShowMessage('e');
  end;
//
end;

procedure TForm2.btn3Click(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  try
    if Execute then
    begin
//      FCommonGSP := FileName;
      FRegionGSP := FileName;
      edt1.Text := FRegionGSP;
    end;
  finally
    Free;
  end;
end;

procedure TForm2.btn4Click(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  try
    Filter := '*.GCL9|*.GCL9';
    if Execute then
    begin
//      FRegionGSP := FileName;
      FGCL9File := FileName;
//      if FileExists(FGCLProjDataFile) then
        edt2.Text := FGCL9File;
    end;
  finally
    Free;
  end;

end;

procedure TForm2.btn6Click(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  try
    if Execute then
      FGCLProjDataFile := FileName;
    if FileExists(FGCLProjDataFile) then
      edt2.Text := FGCLProjDataFile;
  finally
    Free;
  end;
end;

procedure TForm2.btn8Click(Sender: TObject);
var
  oM1: IGSPModel;
  oTble: IGSPTable;
  I: Integer;
begin
  oM1 := GSPEngineUtils.GSPEngine().CreateModel();
  GSPEngineUtils.GSPEngine().CreateModelXMLReader.read('E:\GAEA\branch\task-works-1858\trunk\GCL\CalcRule\00-规则模版库\27-打包导库工具\Bin\Sysinfo.gsp', oM1);

  oTble := oM1.FindTable('DB', 'RegionDB');
  for I := 0 to oTble.RecordCount - 1 do
  begin
    oTble.Records[I].AsString['UpgradeNo'] := '9.11.-1.1900';
  end;

  GSPEngineUtils.GSPEngine().CreateModelXMLWriter.Write('F:\share\SysInfo.GSP', oM1);
end;

function TForm2.DeleteDirectory(const Source: String): Boolean;
var
 fo: TSHFILEOPSTRUCT;
begin
 FillChar(fo, SizeOf(fo), 0);
 with fo do
 begin
   Wnd := 0;
   wFunc := FO_DELETE;
   pFrom := PChar(source+#0);
   pTo := PChar(source+#0);
   fFlags := FOF_NOCONFIRMATION+FOF_NOCONFIRMMKDIR    ;
 end;
 Result := (SHFileOperation(fo) = 0);
end;

procedure TForm2.edt1Change(Sender: TObject);
begin
  if Pos('.GSP', edt1.Text) > 0 then
  begin
    FRegionGSP := edt1.Text;
  end
  else
    FRegionGSP := '';
end;

procedure TForm2.edt2Change(Sender: TObject);
begin
  if Pos('.GCL9', edt2.Text) > 0 then
  begin
    FGCL9File := edt2.Text;
    FGCLProjDataFile := '';
  end
  else if Pos('.GSP', edt2.Text) > 0 then
  begin
    FGCLProjDataFile := edt2.Text;
    FGCL9File := '';
  end
  else begin
//    edt2.Text := '';
    FGCLProjDataFile := '';
    FGCL9File := '';
  end;
end;

procedure TForm2.edt3KeyPress(Sender: TObject; var Key: Char);
begin
//  if not (Key in ['0'..'9']) then  Key := ;
end;

procedure TForm2.MyExtract;
begin
  ForceDirectories(FTempDir);
  ExtractZipFiles(FGCL9File, FTempDir);
  FGCLProjDataFile := FTempDir + '\' + 'ProjData.GSP'; 
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FIniFile.WriteString(CVAR, CRegionGSP, FRegionGSP);
  if FGCL9File <> '' then
    FIniFile.WriteString(CVAR, CGCLFile, FGCL9File)
  else
    FIniFile.WriteString(CVAR, CGCLFile, FGCLProjDataFile);
  FIniFile.Free;
end;


procedure TForm2.T1;
var
  I: Integer;
  oQuery: TADOQuery;
  oTable: TADOTable;
begin
  FDAOcon := TADOConnection.Create(nil);
  try
    FDAOcon.ConnectionString := Format(CCnnstr, [CMDBFile]);
    FDAOcon.LoginPrompt := False;
    FDAOcon.Connected := True;
    FDAOcon.Open;

    oTable := TADOTable.Create(nil);
    try

      oTable.Connection := FDAOcon;
      oTable.TableName := ptnEntQtyDict;//ptnEntTypeDict;
      oTable.Active := True;

//
//    oQuery := TADOQuery.Create(nil);
//    try
//      oQuery.Connection := FDAOcon;
//
//      ExecuteSQL(oQuery, 'select * from EntTypeDict')
//
////      FDAOcon.BeginTrans;
////      try
//////        FDAOcon.Execute(asqL);
////        ExecuteSQL(oQuery, 'select * from EntTypeDict')
////        FDAOcon.CommitTrans;
////      except
////        FDAOcon.RollbackTrans;
////      end;
//    finally
//      oQuery.Free;
//    end;
    T2(oTable);
    finally
      oTable.Free;
    end;
  finally
    FDAOcon.Free;
  end;
end;

procedure TForm2.T2(var aTable: TADOTable);
const
  sf = 'E:\workspace\ADODB\g.gsp';
var
  oModel: IGSPModel;
  oTbl, oEntTypeTbl: IGSPTable;
  oRecord: IGSPRecord;
  nTypeID: Integer;
begin
  oModel := GSPEngineUtils.GSPEngine().CreateModel();
  GSPEngineUtils.GSPEngine().CreateModelXMLReader().read(sf, oModel);
  oEntTypeTbl := oModel.FindTable('db', ptnEntTypeDict);

  oModel.BeginTransaction;
  try
    oTbl := oModel.FindTable('db', ptnEntQtyDict);
    aTable.First;
    while not aTable.Eof do
    begin
      oRecord := oTbl.NewRecord;
//      oRecord.AsInteger[pfnEntTypeID] :=  aTable.FieldByName(pfnEntTypeID).AsInteger;
//      oRecord.AsString[pfnEntTypeName] := aTable.FieldByName(pfnEntTypeName).AsString;

      oRecord.AsInteger[pfnQtyID] :=  aTable.FieldByName(pfnQtyID).AsInteger;
      nTypeID := aTable.FieldByName(pfnEntTypeID).AsInteger;
      oRecord.AsInteger[pfnEntTypeID] := nTypeID;
      oRecord.AsInteger[pfnCombineFactoryID] :=  aTable.FieldByName('FactoryID').AsInteger;
      oRecord.AsString[pfnCombineInfo] := aTable.FieldByName(pfnCombineInfo).AsString;
      oRecord.AsString[pfnQtyCode] :=  aTable.FieldByName(pfnQtyCode).Asstring;
      oRecord.AsString[pfnQtyName] := aTable.FieldByName(pfnQtyName).AsString;

      if nTypeID >= 0 then
      begin

        oRecord.AsString[pfnEntTypeName] := oEntTypeTbl.Locate(pfnEntTypeID, VarArrayOf([nTypeID])).AsString[pfnEntTypeName];

      end else
       oRecord.AsString[pfnEntTypeName] := '';
      oTbl.Append(oRecord);
      aTable.Next;
    end;
    oModel.EndTransaction;
  except
    on E: Exception do
    begin
    oModel.Rollback;
    ShowMessage(e.Message);
    end;
  end;
  GSPEngineUtils.GSPEngine().CreateModelXMLWriter.Write('g1.gsp', oModel);
end;

function TForm2.Sync: Boolean;
var
  bIgnoreAll: Boolean;
  bReplace: Boolean;
  I: Integer;
  oM1, oProjModel: IGSPModel;
  oTbl1, oTbl2, oEntTypeTbl: IGSPTable;
  oR1, oR2: IGSPRecord;
  oRange: TByteSet;
  oBK: TButtonKind;
begin
  oRange := GetRange;
  Result := False;
  bIgnoreAll := False;
  if not FileExists(FGCLProjDataFile) then Exit;

  oM1 := GSPEngineUtils.GSPEngine().CreateModel();
  GSPEngineUtils.GSPEngine().CreateModelXMLReader.read(FRegionGSP, oM1);

  oProjModel := GSPEngineUtils.GSPEngine().CreateModel();
  GSPEngineUtils.GSPEngine().CreateModelXMLReader.read(FGCLProjDataFile, oProjModel);
  oProjModel.BeginTransaction;
  try
//    oTbl1 := oM1.FindTable('DB', ptnEntQtyDict);
    oTbl1 := oM1.FindTable('business', ptnQtyDict);
    oTbl2 := oProjModel.FindTable('business', ptnQtyDict);
    oEntTypeTbl := oProjModel.FindTable('business', 'ElementTypeDict');
    for I := 0 to oTbl2.RecordCount - 1 do
    begin
      bReplace := False;
      oR2 := oTbl2.records[I];
//      oR1 := oTbl1.Locate(pfnQtyCode + ';' + pfnQtyName, VarArrayOf([oR2.AsString[pfnCode], oR2.AsString[pfnDescription]]));
      if not (oR2.AsInteger[pfnElementTypeID] in oRange) then Continue;

      oR1 := oTbl1.Locate(pfnCode + ';' + pfnElementTypeID,
      VarArrayOf([oR2.AsString[pfnCode], oR2.AsInteger[pfnElementTypeID]]));
      if oR1 <> nil then
      begin
        if ((oR2.AsInteger[pfnCombineFactoryID] <> oR1.AsInteger[pfnCombineFactoryID]) or
           (not SameText(oR2.AsString[pfnCombineInfo], oR1.AsString[pfnCombineInfo])))
           and not bIgnoreAll then
        begin
          oBK := DlgConfirm(
             IntToStr(or2.AsInteger[pfnElementTypeID]) + ':' +
             oEntTypeTbl.Locate(pfnElementTypeID, VarArrayOf([or2.AsInteger[pfnElementTypeID]])).AsString[pfnDescription] +
             ':'  + oR1.AsString[pfnCode]
             + sLineBreak +
             IntToStr(oR2.AsInteger['QtyID'])
             + sLineBreak +
             'A:' +  IntToStr(oR1.AsInteger[pfnCombineFactoryID]) + oR1.AsString[pfnCombineInfo]
            + sLineBreak +
              'B:' +  IntToStr(oR2.AsInteger[pfnCombineFactoryID]) + oR2.AsString[pfnCombineInfo], True);
          if oBK = bkYes then
            bReplace := True
          else if oBK = bkNo then
          begin
            bReplace := False;

          end
          else begin
            if DlgConfirm('忽略所有？') = bkYes then
            begin
              bIgnoreAll := True;
              bReplace := True;
            end
            else begin
              bIgnoreAll := False;
              bReplace := False;
            end;
          end;
        end
        else
           bReplace := True;
        if bReplace then
        begin
          oR2.AsInteger[pfnCombineFactoryID] := oR1.AsInteger[pfnCombineFactoryID];
          oR2.AsString[pfnCombineInfo] := oR1.AsString[pfnCombineInfo];
        end;
      end;
    end;

    oProjModel.EndTransaction;
    GSPEngineUtils.GSPEngine().CreateModelXMLWriter.Write(FGCLProjDataFile, oProjModel);
    Result := True;
  except
    on E: Exception do
    begin
      oProjModel.Rollback;
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TForm2.MyZip;
begin
  CompressZipFiles(FGCL9File, FTempDir);
end;

procedure TForm2.Syn;
begin

end;

{-----------------------------------------------------------------------------
  作者：liul-a 2010.09.26
  参数：
  返回：
  功能： 
-----------------------------------------------------------------------------}
procedure ExecuteSQL(const AQry: TADOQuery; const ASQL: string);
begin
  Application.ProcessMessages;
  AQry.Close;
  AQry.SQL.Clear;
  AQry.SQL.Add(ASQL);
  AQry.ExecSQL;
end;


end.
