unit ClassParser;

interface

uses
  Classes, SysUtils;

type
  TTokenType = (ttUnit, ttUses1, ttUses2, ttInterface, ttImplementation,
    ttInitialization, ttFinalization, ttUnitEnd,
    ttWord, ttUnKnowen, ttEof, ttError);

  TToken = record
    FType: TTokenType;
    FValue: string;
  end;

  TClassParser = class
  protected
    FTextFile: TextFile;
    FClasses: TStrings;
    FLineStr: string;
    FIndex, FLineStrLen: Integer;
    FSingleLineComment, FMultiLineComment: Boolean;
    FCommentState: Integer;
    FCurToken: TToken;
  protected
    procedure OpenFile(AFile: string);
    procedure CloseFile;
    function GetToken: TToken;
    function TokenType(s: string): TTokenType;
    function IsBlankChar(s: string): Boolean;
  protected
    procedure ReadUnit;
    procedure ReadInterface;
    procedure ReadUses1;
    procedure ReadImplementation;
    procedure ReadUses2;
    procedure ReadInitialization;
    procedure ReadFinalization;
    procedure ReadUnitEnd;
  protected
    procedure DoParse; virtual;
    procedure ParseInterface;
    procedure ParseImplementation;
  public
    procedure ParseClassA(AFile: string; AClasses: TStrings);
    procedure ParseClass(AFile: string; AClasses: TStrings);
    procedure ParseClassImpl(AFile, AClass: string; AClassImpl: TStrings);
  end;

var
  GClassParser: TClassParser;

implementation

uses
  RegExpr;

procedure RaiseError(Msg: string = '');
begin
  Raise Exception.Create(Msg);
end;

{ TClassParser }

procedure TClassParser.CloseFile;
begin
  Close(FTextFile);
end;

procedure TClassParser.DoParse;
begin
  FCurToken := GetToken;
  ReadUnit;
  ReadInterface;
  ReadUses1;
  ReadImplementation;
  ReadUses2;
  ReadInitialization;
  ReadFinalization;
  ReadUnitEnd;
end;

function TClassParser.GetToken: TToken;
var
  s: string;
begin
  if (FLineStr = '') or (FIndex > FLineStrLen) then
  begin
    if Eof(FTextFile) then
    begin
      Result.FType := ttEof;
      Result.FValue := '';
    end
    else begin
      Readln(FTextFile, FLineStr);
      FIndex := 1;
      FLineStrLen := Length(FLineStr);
    end;
  end
  else begin
    while (FIndex < FLineStrLen + 1) and
      IsBlankChar(FLineStr[FIndex]) do
    begin
      Inc(FIndex);
      Break;
    end;
    while (FIndex < FLineStrLen + 1) do
    begin
      case FCommentState of
        0: begin
             if FLineStr[FIndex] = '/' then
               FCommentState := 1
             else if FLineStr[FIndex] = '{' then
               FCommentState := 3
             else if FLineStr[FIndex] = '(' then
               FCommentState := 6
             else if IsBlankChar(FLineStr[FIndex]) then
             begin
               Inc(FIndex);
               Break;
             end;
           end;
        1: begin
             if FLineStr[FIndex] = '/' then
               FCommentState := 2
             else
               FCommentState := 0;
           end;
        2: begin
             if FLineStr[FIndex] = #13 then
             begin
               FCommentState := 0;
               Result := GetToken;
               Exit;
             end;
           end;
        3: begin
             if FLineStr[FIndex] <> '$' then
               FCommentState := 4
             else
               FCommentState := 0;
           end;
        4: begin
             if FLineStr[FIndex] = '}' then
               FCommentState := 5;
           end;
        5: begin
             FCommentState := 0;
             Result := GetToken;
             Exit;
           end;
        6: begin
             if FLineStr[FIndex] = '*' then
               FCommentState := 7
             else
               FCommentState := 0;
           end;
        7: begin
             if FLineStr[FIndex] = '*' then
               FCommentState := 8;
           end;
        8: begin
             if FLineStr[FIndex] = ')' then
               FCommentState := 5
             else
               FCommentState := 7;
           end
        else
          RaiseError();
      end;
      s := s + FLineStr[FIndex];
      Inc(FIndex);
    end;
    with Result do
    begin
      FType := TokenType(s);
      FValue := s;
    end;
  end;
end;

function TClassParser.IsBlankChar(s: string): Boolean;
begin
  Result := (s = #9) or (s = #10) or (s = #13);     //tab ' '
end;

procedure TClassParser.OpenFile(AFile: string);
begin
  AssignFile(FTextFile, AFile);
  Reset(FTextFile);
end;

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

procedure TClassParser.ParseClassA(AFile: string; AClasses: TStrings);
begin
  if FileExists(AFile) then
  begin
    FClasses := AClasses;
    OpenFile(AFile);
    try
      DoParse;
    finally
      CloseFile;
    end;
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

procedure TClassParser.ParseImplementation;
begin

end;

procedure TClassParser.ParseInterface;
begin
  while FCurToken.FType <> ttImplementation do
  begin

    FCurToken := GetToken;
  end;
end;

procedure TClassParser.ReadFinalization;
begin

end;

procedure TClassParser.ReadImplementation;
begin
  while FCurToken.FType <> ttImplementation do
  begin
    FCurToken := GetToken;
  end;
  if FCurToken.FType  <> ttImplementation then// in [ttUnKnowen, ttEof, ttError] then
    raise Exception.Create('error');
  ParseImplementation;
end;

procedure TClassParser.ReadInitialization;
begin

end;

procedure TClassParser.ReadInterface;
begin
  while FCurToken.FType <> ttInterface do
  begin
    FCurToken := GetToken;
  end;
  if FCurToken.FType  <> ttInterface then// in [ttUnKnowen, ttEof, ttError] then
    raise Exception.Create('error');
  ParseInterface;  
end;

procedure TClassParser.ReadUnit;
begin
  if FCurToken.FType <> ttUnit then
    RaiseError;
end;

procedure TClassParser.ReadUnitEnd;
begin

end;

procedure TClassParser.ReadUses1;
begin

end;

procedure TClassParser.ReadUses2;
begin

end;

function TClassParser.TokenType(s: string): TTokenType;
begin
  if SameText(s, 'interface') then
    Result := ttInterface
  else if SameText(s, 'implementation') then
    Result := ttImplementation
  else if s <> '' then
    Result := ttWord
  else
    Result := ttError;
//  (ttComment, ttWord, ttReturn, ttMultiLineCommentEnd,
//    ttInterface, ttImplementation, ttUnKnowen, ttEof, ttError);
end;

initialization
  GClassParser := TClassParser.Create;

finalization
  GClassParser.Free;
  
end.
