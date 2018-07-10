unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GSPEngineUtils, GSPInterface, ComCtrls, GrandUiUtils,
  ShellAPI;

type
  TForm2 = class(TForm)
    btn2: TButton;
    pb1: TProgressBar;
    stat1: TStatusBar;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure stat1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
  private
    FProjDataModel : IGSPModel;
    FProjFile : string;
    FMax: Integer;
    FForeignkeyInfo: string;
    procedure OpenProjDataFile();
    procedure RemoveReplicateEdos();
    procedure RemoveNotExistFK();
    procedure GetForeignkeyInfo(AForeignkeyInf: string; var AList: TStringList);    
    function IsNotExistFK: Boolean;
    procedure SaveModel();
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  CDir :string = '';

implementation

resourcestring
SRecordErr = '记录数据错误';
SRepeatedRecord = '数据不唯一';
STip = '提示：%s';
SOpenFile = '请选择文件';
SRepairBegin = '开始修复';
SRepairEnd = '修复完毕';
SCopyTo = '可以拷贝到工程文件中了';
rsTableForeignKey = '表外键字段';
rsNotExist = '在其主表中不存在';
const
  pdbBusiness = 'business';


{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
begin
        ShellExecute(0, 'open', 'Explorer.exe', 'C:\', nil, SW_SHOWNORMAL);
end;

procedure TForm2.btn2Click(Sender: TObject);
begin
  pb1.Position := 0;
  FProjFile := '';
  stat1.Panels[0].Text := Format(STip, [SOpenFile]);
  OpenProjDataFile;
  if not FileExists(FProjFile) then
  begin
    if FProjFile <> '' then
      ShowPrompt('请选择要修复的ProjData.GSP文件');
    Exit;
  end;

  stat1.Panels[0].Text := Format(STip, [SRepairBegin]);
  btn2.Enabled := False;
  Application.ProcessMessages;
  if Assigned(FProjDataModel) then
    FProjDataModel := nil;

  FProjDataModel := GSPEngineUtils.GSPEngine().CreateModel();
  try
    GSPEngine.CreateModelXMLReader.Read(FProjFile, FProjDataModel);
    FProjDataModel.Mode := gmLoad;
  except

  end;
  try
    FProjDataModel.Mode := gmRuntime;
  except
    on E: Exception do
    begin
      if (Pos(SRecordErr, E.Message) > 0) and
         (Pos(SRepeatedRecord, E.Message) > 0) then
      begin
        btn2.Enabled := False;
        stat1.Panels[0].Text := Format(STip, [SRepairBegin]);
        RemoveReplicateEdos;
//        SaveModel;
      end
      // 外键不存在
      else if (Pos(rsTableForeignKey, E.Message) > 0)
       and (Pos(rsNotExist, E.Message) > 0) then
      begin
        btn2.Enabled := False;
        stat1.Panels[0].Text := Format(STip, [SRepairBegin]);

//        FGSPModel.Mode := gmLoad;
        FForeignkeyInfo := E.Message;
        RemoveNotExistFK;
      end
      else begin
        ShowPrompt(E.Message);
        btn2.Enabled := True;
        stat1.Panels[0].Text := Format(STip, [SOpenFile]);
      end;

      SaveModel;
    end;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var

ProgressBarStyle: Integer;
begin
  //stat1.Components[1]. := '请打开一个GSP文件';
  pb1.Parent := stat1;
  ProgressBarStyle := GetWindowLong(pb1.Handle,GWL_EXSTYLE);
　ProgressBarStyle := ProgressBarStyle - WS_EX_STATICEDGE;
　SetWindowLong(pb1.Handle, GWL_EXSTYLE, ProgressBarStyle);
  pb1.Min := 0;
  stat1.Panels[0].Text := Format(STip, [SOpenFile]);
end;

procedure TForm2.GetForeignkeyInfo(AForeignkeyInf: string;
  var AList: TStringList);
const
  CLinkerChar = ']';
  CNextChar = '[';
var
   sOtherSectionInf: string;
   oParams, oList: TStrings;
   I: Integer;
begin
  sOtherSectionInf := AForeignkeyInf;
  oList := TStringList.Create;
  AList.Clear;
   try
     //现将字符串用“] ”分割，再根据“[”分割出数据
    oList.StrictDelimiter := True;
    oList.Delimiter := CLinkerChar;
    oList.DelimitedText := sOtherSectionInf;
    if oList.Count <= 1 then  Exit
    else
    begin
      oParams := TStringList.Create;
      try
        oParams.StrictDelimiter := True;
        oParams.Delimiter := CNextChar;
        for I := 0 to oList.Count - 2 do
        begin
            oParams.DelimitedText := oList[I];
            AList.Add(oParams[1]);
        end;
      finally
        oParams.Free;
      end;
    end;
   finally
     oList.Free;
   end;
end;

function TForm2.IsNotExistFK: Boolean;
begin
  Result := False;
  FProjDataModel.Mode := gmLoad;
  try
    FProjDataModel.Mode := gmRuntime;
    Result := True;
  except
    on E: Exception do
    begin
      // 外键不存在
      if (Pos(rsTableForeignKey, E.Message) > 0)
       and (Pos(rsNotExist, E.Message) > 0) then
      begin
        btn2.Enabled := False;
        stat1.Panels[0].Text := Format(STip, [SRepairBegin]);
        FForeignkeyInfo := E.Message;
      end;
    end;
  end;

end;

procedure TForm2.OpenProjDataFile;
begin
  with TOpenDialog.Create(nil) do
  try
    InitialDir := CDir;
    Filter := '*.GSP|*.GSP';
    if Execute then
    begin
      FProjFile := FileName;
      CDir := ExtractFileDir(FileName);
    end;
  finally
    Free;
  end;
end;

procedure TForm2.RemoveReplicateEdos;
  procedure Clean(ATable, AID: string);
  var
    oTable: IGSPTable;
    oRecord: IGSPRecord;
    PreID, CurID, itN: Integer;
  begin
    oTable :=  FProjDataModel.FindTable('Business', ATable);
    oTable.Sort(AID);
    itN := oTable.RecordCount - 1;
    while itN > 0 do
    begin
      CurID := oTable.Records[itN].AsInteger[AID];
      Dec(itN);
      oRecord := oTable.Records[itN];
      PreID := oRecord.AsInteger[AID];
      while (PreID = CurID) do
      begin
        oTable.Delete(itN);
        Dec(itN);
        if itN > 0 then
        begin
          oRecord := oTable.Records[itN];
          PreID := oRecord.AsInteger[AID];
        end
        else
          Break;
      end;
    end;
  end;
var
  oTbls : IGSPTables;
  I,nCount: Integer;
  sTableName, sPKName: string;
begin
  try
    oTbls := FProjDataModel.Find('business').Tables;
    nCount := oTbls.Count;
    FMax := nCount;
    pb1.Max := FMax;
    for I := 0 to nCount - 1 do
    begin
      pb1.Position := I;
      Application.ProcessMessages;
      sTableName := oTbls[I].Name;
      sPKName := oTbls[I].TableSchema.PrimaryKey;
      if (sPKName <> '') then
        Clean(sTableName, sPKName);
    end;
  except
    on E: Exception do
    begin
      FProjDataModel := nil;
      btn2.Enabled := True;
      stat1.Panels[0].Text := Format(STip, [SOpenFile]);
      ShowPrompt(E.Message);
    end;
  end;
end;

procedure TForm2.SaveModel;
begin
  if not Assigned(FProjDataModel) then
    Exit;
  FProjDataModel.Mode := gmLoad;
  try
    FProjDataModel.Mode := gmRuntime;
    GSPEngineUtils.GSPEngine().CreateModelXMLWriter.Write(
      ExtractFilePath(Application.ExeName) + 'ProjData.GSP', FProjDataModel);
    pb1.Position := FMax;
    stat1.Panels[0].Text := Format(STip, [SRepairEnd]);
    ShowPrompt('文件已修复，可以将文件拷贝到工程中了');
  except
    on E: Exception do
    begin
      btn2.Enabled := True;
      stat1.Panels[0].Text := Format(STip, [SOpenFile]);
      ShowMessage('文件仍存在错误：'+E.Message);
    end;
  end;
  FProjDataModel := nil;
  btn2.Enabled := True;
end;

procedure TForm2.stat1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
　if Panel = stat1.Panels[2] then
　　with pb1 do begin
　　　Top := Rect.Top;
　　　Left := Rect.Left+1;
　　　Width := Rect.Right - Rect.Left -1;
　　　Height := Rect.Bottom - Rect.Top;
　　end;
end;

procedure TForm2.RemoveNotExistFK;
var
  oList: TStringList;
  oOwnertable: IGSPTable;
  oReocord: IGSPRecord;
  I: Integer;
  bFindField: Boolean;
  bNeedRepair: Boolean;
begin
//  Result := False;
//  if bNeedRepair then
//  begin
  while not IsNotExistFK do
  begin
    oList := TStringList.Create;
    try
      GetForeignkeyInfo(FForeignkeyInfo, oList);
      if oList.Count = 3 then
      begin
        oOwnertable := FProjDataModel.FindTable(pdbBusiness, oList[0]);
        bFindField := (oOwnertable.TableSchema.FieldSchemas.Find(oList[1]) <> nil);
        if bFindField then
        begin
          for I := oOwnertable.recordcount - 1 downto 0 do
          begin
            oReocord := oOwnertable.Records[I];
            if (oReocord.AsString[oList[1]] = oList[2])
             and  (oReocord.AsInteger[oList[1]] = StrToInt(oList[2])) then
            begin
              try
                oOwnertable.Remove(oReocord);
              except
                //删除失败，则赋值为null
                if oOwnertable.TableKind = tkPropTable then
                begin
                  oReocord.FindField(oList[1]).DataIsNull := True;
                end;
              end;
            end;
          end;
//          Result := True;
        end;
      end;
    finally
      oList.Free;
    end;
  end;
end;

end.
