unit ClassParser;

interface

uses
  Classes, SysUtils;

type
  TClassParser = class
  public
    procedure ParseClass(AFile: string; AClasses: TStrings);
    procedure ParseClassImpl(AFile, AClass: string; AClassImpl: TStrings);
  end;

var
  GClassParser: TClassParser;

implementation

uses
  RegExpr;

{ TClassParser }

procedure TClassParser.ParseClass(AFile: string; AClasses: TStrings);
var
  bClassDefBegin: Boolean;
  bIntfBegin: Boolean;
  oList, oClassInfoList: TStringList;
  I: Integer;
  oClassRegex: TRegExpr;
  sLine: string;
begin
  if not FileExists(AFile) then Exit;

  oList := TStringList.Create;
  oClassRegex := TRegExpr.Create;
  try
    oClassRegex.Expression :=  '[ ]*([A-z]*)[ ]*=.*[(class)(interface)].*';
    oClassRegex.Compile;

    bIntfBegin := False;
    bClassDefBegin := False;
    oClassInfoList := nil;
    oList.LoadFromFile(AFile);
    for I := 0 to oList.Count - 1 do
    begin
      sLine := oList[I];
      if SameText(Trim(sLine), 'implementation') then
      begin
        Break;
      end;

      if SameText(Trim(sLine), 'interface') then
      begin
        bIntfBegin := True;
        Continue;
      end;

      if bIntfBegin then
      begin
        if oClassRegex.Exec(sLine) and (Pos(';', sLine) < 1) then
        begin
          bClassDefBegin := True;
          oClassInfoList := TStringList.Create;
          AClasses.AddObject(oClassRegex.Match[1], oClassInfoList);
        end;

        if bClassDefBegin then
        begin
          if oClassInfoList <> nil then
            oClassInfoList.Add(sLine);
          if SameText(Trim(sLine), 'end;') then
          begin
            oClassInfoList := nil;
            bClassDefBegin := False;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(oList);
    FreeAndNil(oClassRegex);
  end;
end;

procedure TClassParser.ParseClassImpl(AFile, AClass: string;
  AClassImpl: TStrings);
var
  bClassImplBegin: Boolean;
  bImplBegin: Boolean;
  oList: TStringList;
  I: Integer;
  oClassRegex: TRegExpr;
  sLine: string;
  sReg: string;
begin
  if not FileExists(AFile) then Exit;

  oList := TStringList.Create;
  oClassRegex := TRegExpr.Create;
  try
    sReg := Format('[ ]*[(procedure)(function)][ ]*%s\..*', [AClass]);
    oClassRegex.Expression := sReg;
    oClassRegex.ModifierI := False;
    oClassRegex.Compile;

    bImplBegin := False;
    bClassImplBegin := False;
    oList.LoadFromFile(AFile);
    for I := 0 to oList.Count - 1 do
    begin
      sLine := oList[I];
      if SameText(Trim(sLine), 'implementation') then
      begin
        bImplBegin := True;
        Continue;
      end;

      if bImplBegin then
      begin
        if oClassRegex.Exec(sLine) then
          bClassImplBegin := True;

        if bClassImplBegin then
        begin
          AClassImpl.Add(sLine);
          if SameText(TrimRight(sLine), 'end;') then
            bClassImplBegin := False;
        end;
      end;
    end;
  finally
    oList.Free;
    oClassRegex.Free;
  end;
end;

initialization
  GClassParser := TClassParser.Create;

finalization
  GClassParser.Free;
  
end.
