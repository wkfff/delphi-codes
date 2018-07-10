unit Mainfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AQtime_TLB, ComObj, StdCtrls, ActnList, GrandGrid, GrandViewGrid,
  GrandFilterGrid, GSPDBGrid, ExtCtrls, GSPInterface, Contnrs, UIControls,
  Types, ActiveX;

type
  TMyStringItem = record
    Key: string;
    Value: string;
  end;
  TMyStringDynArray = array of TMyStringItem;

  TMethodInfo = record
    ClassName: string;
    MethodName: string;
    UnitName: string;
    LineNumber: Integer;
  end;
  TMethodInfoDynArray = array of TMethodInfo;
  TClassStackInfoDynArray = array of TMethodInfoDynArray;

  TStackInfo = record
    ClassName: string;
    REC_ID: Integer;
    LeakNumber: Integer;
    StackInfos: TClassStackInfoDynArray;
    procedure Add(AStackInfo: TMethodInfoDynArray);
  end;
  PStackInfo = ^TStackInfo;

  TStackInfoList = class
  private
    FList: TStringList;
    function GetInfo(Index: Integer): PStackInfo;
    procedure SetInfo(Index: Integer; const Value: PStackInfo);
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const AClassname: string; const AREC_ID, ALeakNumber: Integer);
    procedure SetStackInfo(const AClassname: string; const AInfo:
        TMethodInfoDynArray);
    property Items[Index: Integer]: PStackInfo read GetInfo write SetInfo;
    property Count: Integer read GetCount;
  end;


  TMainForm = class(TForm)
    actlst1: TActionList;
    actRun: TAction;
    actExportToMDB: TAction;
    actExportToSQLServer: TAction;
    actShowResult: TAction;
    pnl1: TPanel;
    lbl1: TLabel;
    edt1: TEdit;
    btn2: TButton;
    btnTest: TButton;
    pnl2: TPanel;
    spl1: TSplitter;
    grp1: TGroupBox;
    grndGridStackInfo: TGrandViewGrid;
    grpShow: TGroupBox;
    btnShowResult: TButton;
    rbSQL: TRadioButton;
    rbAccess: TRadioButton;
    pnl3: TPanel;
    spl2: TSplitter;
    extgrpbx1: TExtGroupBox;
    grndGridInst: TGrandViewGrid;
    extgrpbx2: TExtGroupBox;
    grndGrid: TGrandViewGrid;
    mmo1: TMemo;
    grp2: TGroupBox;
    btnRun: TButton;
    btn1: TButton;
    btnExportToSql: TButton;
    btnQuit: TButton;
    actQuit: TAction;
    procedure actExportToMDBExecute(Sender: TObject);
    procedure actExportToSQLServerExecute(Sender: TObject);
    procedure actlst1Update(Action: TBasicAction; var Handled: Boolean);
    procedure actQuitExecute(Sender: TObject);
    procedure actRunExecute(Sender: TObject);
    procedure actShowResultExecute(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure grndGridClick(Sender: TObject);
    procedure grndGridInstClick(Sender: TObject);
    procedure grndGridInstQueryCellValue(Sender: TObject; ACol, ARow: Integer; var
        AValue: string);
    procedure grndGridQueryCellValue(Sender: TObject; ACol, ARow: Integer; var
        AValue: string);
    procedure grndGridStackInfoQueryCellValue(Sender: TObject; ACol, ARow: Integer;
        var AValue: string);
    procedure rbAccessClick(Sender: TObject);
    procedure rbSQLClick(Sender: TObject);
  private
    FAQtimeObj: IAQtimeManager;
    FReportManager: IaqExportResultsToDBManager;
    FAQTimeProjectFile: string;
    FExportToFile: string;
    FPerformSuccess: Boolean;
    FStackInfoList: TStackInfoList;
    FStackInfo: PStackInfo;
    FINSTs: TMyStringDynArray;
    FStackInfoPool: TStringList;
    FMDBFile: string;
    FINST_ID: string;
    procedure Init;
    procedure RefreshGrid;
    procedure SaveLeakInfoToFile(const AOutputFile: string;const ASQL: Boolean);
    procedure QuitAQTime;
    function ShowResult(const AConnectSQL: Boolean; const AInstID: Integer; const
        AClearAllData: Boolean = False): Boolean;
    function Profile: Boolean;
    function ExportToDBFile: Boolean;
    function ExportToSQLServer: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class procedure Execute;
  end;

var
  MainForm: TMainForm;

implementation

uses
  ADODB, GrandUiUtils, AppConsts, StrUtils, GrandStrUtils, AppCommandLine;


const
  CSQLConnectionStr = 'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=aqtime;Initial Catalog=aqtime;Data Source=server-gaea';
  CUserID = 'aqtime';
  CPWD = 'UPMupm2010*#^';

  CSQLCnnStr = 'Provider=SQLOLEDB.1;Password=UPMupm2010*#^;Persist Security Info=True;User ID=aqtime;Initial Catalog=aqtime;Data Source=SERVER-GAEA';

  CMDBCnnString = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;';

  CTestAccessFile = 'F:\share\aq.mdb';

  CClassName = '类名';
  CObjectNumber= '数量';
  CStackInfo = '堆栈信息';

  CMethodName = '方法名';
  CUnitName= '单元名';
  CLineNumber = '行号';



{$R *.dfm}

procedure ExecuteSQL(AQry: TADOQuery; const ASQL: string);
begin
  AQry.Close;
  AQry.SQL.Clear;
  AQry.SQL.Add(ASQL);
  AQry.ExecSQL;
  AQry.Active := True;
  AQry.First;
end;

procedure TMainForm.actExportToMDBExecute(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  begin
    Filter := '*.mdb|*.mdb';
    if Execute then
    begin
      Filter := '*.aqt(.aqt)';
      FExportToFile := ExpandFileName(FileName);
    end
    else
      FExportToFile := '';
    Free;
  end;

  if ExportToDBFile then
    ShowPrompt('成功导出');
end;

procedure TMainForm.actExportToSQLServerExecute(Sender: TObject);
begin
  if (DlgConfirm('确认导出到server-gaea的SQL服务器上？') = bkYes) and
    ExportToSQLServer then
  begin
    ShowPrompt('成功导出');
  end;
end;

procedure TMainForm.actlst1Update(Action: TBasicAction; var Handled: Boolean);
begin
  if FileExists(FAQTimeProjectFile) then
    actRun.Enabled := True
  else
    actRun.Enabled := False;
  if FPerformSuccess then
  begin
    actExportToMDB.Enabled := True;
    actExportToSQLServer.Enabled := True;
  end
  else begin
    actExportToMDB.Enabled := False;
    actExportToSQLServer.Enabled := False;
  end;
  if FAQtimeObj <> nil then
    actQuit.Enabled := True
  else
    actQuit.Enabled := False;
end;

procedure TMainForm.actRunExecute(Sender: TObject);
begin
  if Profile then
  begin
    ShowPrompt('运行AQTime成功生成分析结果，可以导出了');
    FPerformSuccess := True;
  end
  else
    ShowPrompt('运行AQTime失败了');
end;

procedure TMainForm.actShowResultExecute(Sender: TObject);
begin
  if rbSQL.Checked then
    ShowResult(True, -1, True)
  else if rbAccess.Checked then
  begin
    with TOpenDialog.Create(nil) do
    begin
      Filter := '*.mdb|*.mdb';
      if Execute then
      begin
        FMDBFile := ExpandFileName(FileName);
      end;
      Free;
    end;
    if not FileExists(FMDBFile) then
    begin
      if FMDBFile <> '' then
        ShowPrompt('Access文件不存在');
      Exit;
    end;
    ShowResult(False, -1, False);
  end;
end;

procedure TMainForm.btn2Click(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  begin
    Filter := '*.aqt|*.aqt';
    if Execute then
    begin
      if FileExists(FileName) then
      begin
        FAQTimeProjectFile := ExpandFileName(FileName);
        edt1.Text := FAQTimeProjectFile;
      end
      else
        edt1.Text := '';
    end;
    Free;
  end;
end;

procedure TMainForm.btnTestClick(Sender: TObject);
var
  oAQtimeObj: IAQtimeManager;
  mgr1: IaqTimeIntegrationSupportManager;
  oMgr: IaqProfDataManager;
  FProfilersFactory    : IaqProfilersFactory;
  Context: IaqProfDynamicContext;
    FProjectManager : IaqProjectManager;
    FProjectManager1 : IaqContextManager;
    //FProjectManager2 : IaqContextManager2;
    //FProjectManager4 : IaqProfilersManagerExtender;
    FProjectManager5 : IaqProfilersManager;
    //FProjectManager6 : IaqProfDataManager;
    FProjectManager8 : IaqExportResultsToDBManager;

//    c1: IaqProfBaseContext;
//    c2: IaqProfDynamicContext;
begin
  oAQtimeObj := CoAQtime_.Create;
  try
    mgr1 := oAQtimeObj.IntegrationManager;
    mgr1.OpenProject('C:\Documents and Settings\liul-a\桌面\内存溢出\big.aqt');

    FProjectManager := oAQtimeObj.Manager.Managers[IID_IaqProjectManager] as IaqProjectManager;
    FProjectManager1 := oAQtimeObj.Manager.Managers[IID_IaqContextManager] as IaqContextManager;
    //FProjectManager2 := oAQtimeObj.Manager.Managers[IID_IaqContextManager2] as IaqContextManager2;
//    FProjectManager4 := oAQtimeObj.Manager.Managers[IID_IaqProfilersManagerExtender] as IaqProfilersManagerExtender;
    FProjectManager5 := oAQtimeObj.Manager.Managers[IID_IaqProfilersManager] as IaqProfilersManager;
//    FProjectManager6 := oAQtimeObj.Manager.Managers[IID_IaqProfDataManager] as IaqProfDataManager;
    FProjectManager8 := oAQtimeObj.Manager.Managers[IID_IaqExportResultsToDBManager] as IaqExportResultsToDBManager;

//    c1 := FProjectManager1.CurrentContext[IaqProfBaseContext] as IaqProfBaseContext;
//    c2 := FProjectManager1.CurrentContext[IaqProfDynamicContext] as IaqProfDynamicContext;
    //    oAQtimeObj.Manager.AddManager();


    FProfilersFactory := oAQtimeObj.Manager.Managers[IID_IaqProfilersFactory] as IaqProfilersFactory;
    FProfilersFactory.CreateDynamicContext(Context);

    oMgr := Context.DataManager;

    //oAQtimeObj.Manager.Managers[IID_IaqProfDataManager] as IaqProfDataManager;
  //  mgr1.InitializeManager(oMgr);
  //
    oMgr.TableCount;
  finally

  oAQtimeObj.Quit;
  end;
end;

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited;
  FAQtimeObj := nil;
  FReportManager := nil;
  FAQTimeProjectFile := '';
  FPerformSuccess := False;
//  FStackInfoList := TStackInfoList.Create;
  FStackInfoPool := TStringList.Create;
  SetLength(FINSTs, 0);
end;

destructor TMainForm.Destroy;
var
  I: Integer;
begin
  FAQtimeObj := nil;
  FReportManager := nil;
//  FStackInfoList.Free;
  for I := 0 to FStackInfoPool.Count - 1 do
    FStackInfoPool.Objects[I].Free;
  FStackInfoPool.Free;
  FStackInfo := nil;
  SetLength(FINSTs, 0);
  inherited;
end;

procedure TMainForm.actQuitExecute(Sender: TObject);
begin
  QuitAQTime;
end;

class procedure TMainForm.Execute;
var
  oForm: TMainForm;
begin
  CoInitialize(nil);
  oForm := TMainForm.Create(nil);
  try
    oForm.FAQTimeProjectFile := TCommandLine.aqtimeprojectfile;
    oForm.FExportToFile := TCommandLine.accessfile;
    oForm.FMDBFile := TCommandLine.accessfile;
    if oForm.Profile then
    begin
      if TCommandLine.sql then
        oForm.ExportToSQLServer;
      oForm.ExportToDBFile;
      oForm.SaveLeakInfoToFile(TCommandLine.outputfile, TCommandLine.sql);
      oForm.QuitAQTime;
    end;
  finally
    oForm.Free;
    CoUninitialize;
  end;
end;

function TMainForm.ExportToDBFile: Boolean;
begin
  Result := False;
  try
    if FileExists(FExportToFile) and (FAQtimeObj <> nil) then
    begin
      FReportManager := nil;
      FReportManager := FAQtimeObj.Manager.Managers[IID_IaqExportResultsToDBManager] as IaqExportResultsToDBManager;//ManagersByString('{35A743D2-CEA8-4491-A7AA-E1D61468FCE6}');

      FReportManager.ExportCurrentResults('Provider=Microsoft.Jet.OLEDB.4.0;'
        + 'Data Source='+FExportToFile + ';Persist Security Info=False', '', '');

      Result := True;
    end;
  except
    on E: Exception do
      ShowPrompt(E.Message);
  end;

end;

function TMainForm.ExportToSQLServer: Boolean;
begin
  Result := False;
  try
    if (FAQtimeObj <> nil) then
    begin
      FReportManager := nil;
      FReportManager := FAQtimeObj.Manager.Managers[IID_IaqExportResultsToDBManager] as IaqExportResultsToDBManager;//ManagersByString('{35A743D2-CEA8-4491-A7AA-E1D61468FCE6}');

      FReportManager.ExportCurrentResults(CSQLConnectionStr, CUserID, CPWD);

      Result := True;
    end;
  except
    on E: Exception do
      ShowPrompt(E.Message);
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
//var
//  I: Integer;
begin
//  FAQtimeObj := nil;
//  FReportManager := nil;
////  FStackInfoList.Free;
//  for I := 0 to FStackInfoPool.Count - 1 do
//    FStackInfoPool.Objects[I].Free;
//  FStackInfoPool.Free;
//  FStackInfo := nil;
//  SetLength(FINSTs, 0);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
//  FAQtimeObj := nil;
//  FReportManager := nil;
//  FAQTimeProjectFile := '';
//  FPerformSuccess := False;
////  FStackInfoList := TStackInfoList.Create;
//  FStackInfoPool := TStringList.Create;
//  SetLength(FINSTs, 0);
end;

procedure TMainForm.grndGridClick(Sender: TObject);
var
  I: Integer;
  iCount: Integer;
begin
  if FStackInfoList = nil then Exit;

  FStackInfo := FStackInfoList.GetInfo(grndGrid.Row);
  iCount := 0;
  if (FStackInfo <> nil) then
  begin
    for I := 0 to Length(FStackInfo.StackInfos) - 1 do
    begin
      iCount := iCount + Length(FStackInfo.StackInfos[I]);
    end;
  end;
  grndGridStackInfo.RowCount := iCount + 4;
  grndGridStackInfo.Invalidate;
//  RefreshGrid;
end;

procedure TMainForm.grndGridInstClick(Sender: TObject);
begin
  if (grndGridInst.Row > 0) and (grndGridInst.Row <= Length(FINSTs)) then
    ShowResult(rbSQL.Checked, StrToInt(FINSTs[grndGridInst.Row-1].Key));
end;

procedure TMainForm.grndGridInstQueryCellValue(Sender: TObject; ACol, ARow:
    Integer; var AValue: string);
begin
  if ARow = 0 then
  begin
    case ACol of
      1: AValue := 'INST_ID';
      2: AValue := '名称';
    end;
  end
  else begin
    if ARow <= Length(FINSTs)then
    begin
      case ACol of
        1: AValue := FINSTs[ARow-1].Key;
        2: AValue := FINSTs[ARow-1].Value;
      end;
    end;
  end;
end;

procedure TMainForm.grndGridQueryCellValue(Sender: TObject; ACol, ARow: Integer;
    var AValue: string);
var
  info: PStackInfo;
begin
  if ARow = 0 then
  begin
    case ACol of
      1: AValue := CClassName;
      2: AValue := CObjectNumber;
      3: AValue := CStackInfo;
    end;
  end
  else begin
    if FStackInfoList = nil then Exit;
    info := FStackInfoList.GetInfo(ARow);
    if info <> nil then
    begin
      case ACol of
        1: AValue := info.ClassName;
        2: AValue := IntToStr(info.LeakNumber);
        3: AValue := '';
      end;
    end;
  end;
end;

procedure TMainForm.grndGridStackInfoQueryCellValue(Sender: TObject; ACol, ARow:
    Integer; var AValue: string);
var
  I: Integer;
  iCount: Integer;
  iLen: Integer;
begin
  if ARow = 0 then
  begin
    case ACol of
      1: AValue := CClassName;
      2: AValue := CMethodName;
      3: AValue := CLineNumber;
      4: AValue := CUnitName;
    end;
  end
  else begin
    if (FStackInfo <> nil) then
    begin
      iCount := 0;
      for I := 0 to Length(FStackInfo.StackInfos) - 1 do
      begin
        iLen := Length(FStackInfo.StackInfos[I]);
        if ARow <= iCount + iLen then
        begin
          case ACol of
            1: AValue := FStackInfo.StackInfos[I][ARow-iCount-1].ClassName;
            2: AValue := FStackInfo.StackInfos[I][ARow-iCount-1].MethodName;
            3: AValue := IntToStr(FStackInfo.StackInfos[I][ARow-iCount-1].LineNumber);
            4: AValue := FStackInfo.StackInfos[I][ARow-iCount-1].UnitName;
          end;
          Break;
        end;
        iCount := iCount + iLen;
      end;
    end;
  end;
end;

procedure TMainForm.Init;
var
  I: Integer;
begin
  if FAQtimeObj <> nil then
    FAQtimeObj.Quit;
  FAQtimeObj := nil;

  for I := 0 to FStackInfoPool.Count - 1 do
    FStackInfoPool.Objects[I].Free;
  FStackInfoPool.Clear;
  FStackInfoList := nil;
  FStackInfo := nil;
  SetLength(FINSTs, 0);
  FMDBFile := '';
  FExportToFile := '';
end;

function TMainForm.Profile: Boolean;
var
  mgr: IaqTimeIntegrationSupportManager;
begin
  Result := False;
  try
    if FileExists(FAQTimeProjectFile) then
    begin
      FAQtimeObj := nil;
      FAQtimeObj := CoAQtime_.Create;
      mgr := FAQtimeObj.IntegrationManager;
      mgr.OpenProject(FAQTimeProjectFile);
      mgr.Start('', '');
      while mgr.ProfilingStarted do
      begin
        //doEvent
      end;
      Result := mgr.ResultReady;
    end;
  except
    on E: Exception do
      ShowPrompt(E.Message);
  end;
end;

procedure TMainForm.QuitAQTime;
begin
  try
    if FAQtimeObj <>  nil then
      FAQtimeObj.Quit;
    FAQtimeObj := nil;
    FPerformSuccess := False;
  except
    on E: Exception do
      ShowPrompt(E.Message);
  end;
end;

procedure TMainForm.rbAccessClick(Sender: TObject);
begin
  Init;
  RefreshGrid;
end;

procedure TMainForm.rbSQLClick(Sender: TObject);
begin
  Init;
  RefreshGrid;
end;

procedure TMainForm.RefreshGrid;
begin
  grndGridStackInfo.Invalidate;

  grndGridInst.RowCount := Length(FINSTs) + 2;
  grndGridInst.Invalidate;
  if FStackInfoList <> nil then
    grndGrid.RowCount := FStackInfoList.Count + 4;
  grndGrid.Invalidate;
end;

procedure TMainForm.SaveLeakInfoToFile(const AOutputFile: string;const ASQL:
    Boolean);
var
  bShowOK: Boolean;
  oTxtFile: TextFile;
  sInfo: string;
  I: Integer;
  pInfo: PStackInfo;
  item: TMyStringItem;
begin
  if FileExists(AOutputFile) then
  begin
    bShowOK := False;
    if ASQL then
      bShowOK := ShowResult(True, -1, False)
    else if FileExists(FExportToFile) then
      bShowOK := ShowResult(False, -1, False);

    if bShowOK then
    begin
      AssignFile(oTxtFile, AOutputFile);
      Rewrite(oTxtFile);
      for I := 0 to Length(FINSTs) - 1 do
      begin
        item := FINSTs[I];
        if item.Key = FINST_ID then
          Break;
      end;

      sInfo := '监测记录：'+ item.Key + '-'+item.Value+ sLineBreak;
      for I := 0 to FStackInfoList.Count - 1 do
      begin
        pInfo := FStackInfoList.Items[I];
        sInfo := sInfo + pinfo.ClassName + ':' + IntToStr(pInfo.LeakNumber) + sLineBreak;
      end;
      Writeln(oTxtFile, sInfo);
      CloseFile(oTxtFile);
    end;
  end;
end;

function TMainForm.ShowResult(const AConnectSQL: Boolean; const AInstID:
    Integer; const AClearAllData: Boolean = False): Boolean;
const
  CSQLMax = 'select max(%s) as nMax from %s';
var
  cnnSQLServer: TADOConnection;
  oQry, oQry2, oQry3: TADOQuery;
  dMaxInst_id: Integer;
  dObjID: Integer;
  dRecID: Integer;
  I, J: Integer;
  pInfo: PStackInfo;
  sClassName: string;
  sSql: string;
  arrStackInfo: TMethodInfoDynArray;
  bExist: Boolean;
  nIndex: Integer;
  arrPostFixes: TStringDynArray;

  procedure InitPostfixes;
  var
    i: Integer;
    iCount: Integer;
    s: string;
  begin
    s := Trim(mmo1.Lines.Text);
    iCount := Occurs(';', s) + 1;
    SetLength(arrPostFixes, iCount);
    for i := 1 to iCount do
    begin
      arrPostFixes[i-1] := GetSubString(s, ';', i);
    end;
  end;

  function StartWithSpecial(AStr: string): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    if Length(arrPostFixes) = 0 then
    begin
      Result := True;
      Exit;
    end;

    for i := 0 to Length(arrPostFixes) - 1 do
    begin
      if StartsText(arrPostFixes[i], AStr) then
      begin
        Result := True;
        Break;
      end;
    end;
  end;
begin
  Result := True;
  if AClearAllData then
    Init;

  if Length(FINSTs) > 0 then
  begin
    bExist := False;
    for I := 0 to Length(FINSTs) - 1 do
    begin
      if StrToInt(FINSTs[I].Key) = AInstID then
         bExist := True;
    end;
    if bExist then
    begin
      nIndex := FStackInfoPool.IndexOf(IntToStr(AInstID));
      if nIndex > -1 then
      begin
        FStackInfoList := TStackInfoList(FStackinfoPool.Objects[nIndex]);
        FStackInfo := nil;
        RefreshGrid;
        Exit;
      end
      else
        FStackInfoList := nil;
    end
    else begin
      FStackInfo := nil;
      RefreshGrid;
      Exit;
    end;
  end;

  //SetLength(FINSTs, 0);
//  FStackInfoList.Clear;
  FStackInfo := nil;
  cnnSQLServer := TADOConnection.Create(nil);
  try
    if AConnectSQL then
      cnnSQLServer.ConnectionString := CSQLCnnStr
    else begin
      cnnSQLServer.ConnectionString := Format(CMDBCnnString, [FMDBFile]);
    end;

    cnnSQLServer.LoginPrompt := False;
    cnnSQLServer.Open;
    oQry := TADOQuery.Create(nil);
    oQry2 := TADOQuery.Create(nil);
    oQry3 := TADOQuery.Create(nil);
    try
      try
        oQry.Connection := cnnSQLServer;
        oQry2.Connection := cnnSQLServer;
        oQry3.Connection := cnnSQLServer;

        //1 先得到inst_id
        ExecuteSQL(oQry, Format('select %s, %s from %s', [pfnINST_ID, pfnCAPTION, ptnINSTANCES]));
        if oQry.RecordCount > 0 then
        begin
          dMaxInst_id := -1;
          bExist := False;
          SetLength(FINSTs, oQry.RecordCount);
          J := 0;
          while not oQry.Eof do
          begin
            FINSTs[J].Key := oQry.FindField(pfnINST_ID).AsString;
            FINSTs[J].Value := oQry.FindField(pfnCAPTION).AsString;
            if AInstID <> -1 then
            begin
              if AInstID = oQry.FindField(pfnINST_ID).AsInteger then
              begin
                bExist := True;
              end;
            end;
            if oQry.FindField(pfnINST_ID).AsInteger > dMaxInst_id then
              dMaxInst_id := oQry.FindField(pfnINST_ID).AsInteger;
            Inc(J);
            oQry.Next;
          end;
        end
        else
          Exit;

        if bExist then
          dMaxInst_id := AInstID;
  //      ExecuteSQL(oQry, Format(CSQLMax, [pfnINST_ID, ptnINSTANCES]));
  //      if oQry.RecordCount > 0 then
  //        dMaxInst_id := oQry.FindField('nMax').AsInteger
  //      else
  ////        dMaxInst_id := -1;
  //        Exit;

        FStackInfoList := TStackInfoList.Create;
        FStackInfoPool.AddObject(IntToStr(dMaxInst_id), TObject(FStackInfoList));
        //2 过滤出泄露的类
        ExecuteSQL(oQry, Format('select %s, %s, %s, %s from %s ' +
          'where (%s=%d)and(%s>0)',
          [pfnINST_ID, pfnREC_ID, pfnCOL_CLASS_NAME, pfnCOL_LIVE_COUNT, ptnALLOCATION_PROFILER_CLASSES_DATA,
           pfnINST_ID, dMaxInst_id, pfnCOL_LIVE_COUNT]));

        InitPostfixes;
        while not oQry.Eof do
        begin
          sClassName := oQry.FieldByName(pfnCOL_CLASS_NAME).AsString;
          if (Trim(sClassName) <> '') and StartWithSpecial(sClassName) then
            FStackInfoList.Add(oQry.FieldByName(pfnCOL_CLASS_NAME).AsString,
              oQry.FieldByName(pfnREC_ID).AsInteger,
              oQry.FieldByName(pfnCOL_LIVE_COUNT).AsInteger);
          oQry.Next;
        end;

        //3 过滤出泄露的对象:一个类可能有多个对象
        for I := 0 to FStackInfoList.Count - 1 do
        begin
          pInfo := FStackInfoList.Items[I];
          sSql := Format('select %s, %s, %s from %s '+
            'where ((%s=%d)and(%s=%d))',
            [pfnINST_ID, pfnID, pfnCOL_CLASSRID, ptnALLOCATION_PROFILER_OBJECTS,
             pfnINST_ID, dMaxInst_id,
             pfnCOL_CLASSRID, pInfo.REC_ID]);
          ExecuteSQL(oQry, sSql);
          while not oQry.Eof do
          begin
            // 每个对象的堆栈信息
            dObjID := oQry.FieldByName(pfnID).AsInteger;
            sSql := Format('select %s, %s, %s, %s from %s '+
              'where ((%s=%d)and(%s=%d))',
              [pfnINST_ID, pfnREC_ID, pfnPARENT_ID, pfnCOL_ROUTINERID, ptnALLOCATION_PROFILER_CREATION_CALL_STACK,
               pfnINST_ID, dMaxInst_id,
               pfnPARENT_ID, dObjID]);
            ExecuteSQL(oQry2, sSql);

            // 注意堆栈的调用顺序
            SetLength(arrStackInfo, oQry2.RecordCount);
            J := 0;
            while not oQry2.Eof do
            begin
              dRecID := oQry2.FieldByName(pfnCOL_ROUTINERID).AsInteger;
              sSql := Format('select %s, %s, %s, %s, %s, %s, %s  from %s '+
                'where ((%s=%d)and(%s=%d))',
                [pfnINST_ID, pfnREC_ID, pfnCOL_CLASS_NAME, pfnCOL_ROUTINE_NAME, pfnCOL_UNIT_NAME, pfnCOL_SOURCE_LINE, pfnCOL_CLASS_NAME,
                 ptnALLOCATION_PROFILER_META_ROUTINES,
                 pfnINST_ID, dMaxInst_id,
                 pfnREC_ID, dRecID]);
              ExecuteSQL(oQry3, sSql);
              while not oQry3.Eof do
              begin
                with arrStackInfo[J] do
                begin
                  ClassName := oQry3.FieldByName(pfnCOL_CLASS_NAME).AsString;
                  MethodName := oQry3.FieldByName(pfnCOL_ROUTINE_NAME).AsString;
                  UnitName := oQry3.FieldByName(pfnCOL_UNIT_NAME).AsString;
                  LineNumber := oQry3.FieldByName(pfnCOL_SOURCE_LINE).AsInteger;
                end;
                oQry3.Next;
              end;
              Inc(J);
              oQry2.Next;
            end;

            pInfo.Add(arrStackInfo);

            oQry.Next;
          end;
        end;
      except
        on E: Exception do
        begin
          ShowPrompt(E.Message);
          Result := False;
        end;
      end;
      RefreshGrid;
    finally
      FreeAndNil(oQry);
      FreeAndNil(oQry2);
      FreeAndNil(oQry3);
    end;
  finally
    cnnSQLServer.Close;
    FreeAndNil(cnnSQLServer);
  end;
end;

{ TStackInfoList }

procedure TStackInfoList.Add(const AClassname: string; const AREC_ID,
    ALeakNumber: Integer);
var
  pInfo: PStackInfo;
begin
  if FList.IndexOf(AClassname) < 0 then
  begin
    New(pInfo);
    pInfo.ClassName := AClassname;
    pInfo.REC_ID := AREC_ID;
    pInfo.LeakNumber := ALeakNumber;
    FList.AddObject(AClassname, TObject(pInfo));
  end;
end;

procedure TStackInfoList.Clear;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
  begin
    Dispose(Pointer(FList.Objects[I]));
  end;
  FList.Clear;
end;

constructor TStackInfoList.Create;
begin
  FList := TStringList.Create;
end;

destructor TStackInfoList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TStackInfoList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TStackInfoList.GetInfo(Index: Integer): PStackInfo;
begin
  Result := nil;
  if Index < FList.Count then
    Result := PStackInfo(FList.Objects[Index]);
end;

procedure TStackInfoList.SetInfo(Index: Integer; const Value: PStackInfo);
var
  I: Integer;
  pInfo: PStackInfo;
  J: Integer;
begin
  if Index < FList.Count then
  begin
    pInfo := PStackInfo(FList.Objects[Index]);
      pInfo.ClassName := Value.ClassName;
      pInfo.REC_ID := Value.REC_ID;
      pInfo.LeakNumber := Value.LeakNumber;
      SetLength(pInfo.StackInfos, Length(Value.StackInfos));
      for I := 0 to Length(Value.StackInfos) do
      begin
        SetLength(pInfo.StackInfos[I], Length(Value.StackInfos[I]));
        for J := 0 to Length(Value.StackInfos[I]) - 1 do
        begin
          pInfo.StackInfos[I][J].ClassName := Value.StackInfos[I][J].ClassName;        
          pInfo.StackInfos[I][J].MethodName := Value.StackInfos[I][J].MethodName;
          pInfo.StackInfos[I][J].UnitName := Value.StackInfos[I][J].UnitName;
          pInfo.StackInfos[I][J].LineNumber := Value.StackInfos[I][J].LineNumber;
        end;
      end;
  end;
end;

procedure TStackInfoList.SetStackInfo(const AClassname: string; const AInfo:
    TMethodInfoDynArray);
var
  nIndex: Integer;
begin
  if FList.Find(AClassname, nIndex) then
  begin
//    PStackInfo(FList.Objects[nIndex]).StackInfo := AInfo;
  end
  else
    Assert( False);
end;

{ TStackInfo }

procedure TStackInfo.Add(AStackInfo: TMethodInfoDynArray);
var
  bFound: Boolean;
  dInfo: TMethodInfoDynArray;
  dLen: Integer;
  I: Integer;
  function SameInfo: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to dLen - 1 do
    begin
      if (dInfo[I].ClassName <> AStackInfo[I].ClassName) or
         (dInfo[I].MethodName <> AStackInfo[I].MethodName) or
         (dInfo[I].UnitName <> AStackInfo[I].UnitName) or
         (dInfo[I].LineNumber <> AStackInfo[I].LineNumber) 
      then
        Exit;
    end;
    Result := True;
  end;
begin
  bFound := False;
  dLen := Length(AStackInfo);
  for I := 0 to Length(StackInfos) - 1 do
  begin
    dInfo := StackInfos[I];
    if Length(dInfo) <> dLen then
      Continue;
    if SameInfo then
    begin
      bFound := True;
      Break;
    end;
  end;
  if not bFound then
  begin
    SetLength(StackInfos, Length(StackInfos)+1);
//    dInfo := ;
    SetLength(StackInfos[High(StackInfos)], dLen);
    for I := 0 to dLen - 1 do
    begin
      StackInfos[High(StackInfos)][I].ClassName :=  AStackInfo[I].ClassName;    
      StackInfos[High(StackInfos)][I].MethodName :=  AStackInfo[I].MethodName;
      StackInfos[High(StackInfos)][I].UnitName := AStackInfo[I].UnitName;
      StackInfos[High(StackInfos)][I].LineNumber := AStackInfo[I].LineNumber;
    end;
  end;
end;

end.
