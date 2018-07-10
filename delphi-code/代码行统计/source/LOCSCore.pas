unit LOCSCore;

interface

uses
  SysUtils, Windows, StrUtils;

type
  ILOCS = interface
    procedure Count(const AFileName: string);
  end;

  TLOCS = class(TInterfacedObject, ILOCS)
  private
    FTotalLines: Integer;
    FCodeLines: Integer;
    FCommentLines: Integer;
    FBlankLines: Integer;
  public
    procedure Count(const AFileName: string); virtual; abstract;
    property TotalLines: Integer read FTotalLines;
    property CodeLines: Integer read FCodeLines;
    property CommentLines: Integer read FCommentLines;
    property BlankLines: Integer read FBlankLines;
  end;

  TLODCS = class(TLOCS)
  public
    procedure Count(const AFileName: string); override;
  end;

  TLORCS = class(TLOCS)
    procedure Count(const AFileName: string); override;
  end;

implementation

const
  CTlLnsFlg = 0;
  CBlkLnsFlg = 1;
  CCmtLnsFlg = 2;
  CCdLnsFlg = 3;

{ TLODCS }

procedure TLODCS.Count(const AFileName: string);
var
  oFile: TextFile;
  sALine: string;
  bMCLStar: Boolean;
  bMCLBrkt: Boolean;
begin
  FTotalLines := 0;
  FCodeLines := 0;
  FCommentLines := 0;
  FBlankLines := 0;
  sALine := '';
  bMCLStar := False;
  bMCLBrkt := False;

  try
    AssignFile(oFile, AFileName);
    Reset(oFile);
    while not Eof(oFile) do
    begin
      Readln(oFile, sALine);
      sALine := Trim(sALine);

      // 空行
      if SameText(sALine, '') then
        FBlankLines := FBlankLines + 1

      // 单行注释
      else if AnsiStartsText('//', sALine) then
        FCommentLines := FCommentLines + 1
      else begin

        // (* 注释开始
        if not bMCLBrkt then
        begin
          if bMCLStar then
            FCommentLines := FCommentLines + 1
          else if AnsiStartsText('(*', sALine) then
          begin
            bMCLStar := True;
            FCommentLines := FCommentLines + 1;
          end;
        end;

        // { 注释开始
        if not bMCLStar then
        begin
          if bMCLBrkt then
            FCommentLines := FCommentLines + 1
          else if (AnsiStartsText('{', sALine) and (not AnsiStartsText('{$', sALine))) then
          begin
            bMCLBrkt := True;
            FCommentLines := FCommentLines + 1;
          end;
        end;

        // 代码行
        if not(bMCLStar or bMCLBrkt) then
          FCodeLines := FCodeLines + 1;

        // (* 注释结束
        if AnsiContainsText(sALine, '*)') then
            bMCLStar := False;

        // { 注释结束
        if AnsiContainsText(sALine, '}')then
            bMCLBrkt := False
      end;

      // 总行数加1
      FTotalLines := FTotalLines + 1;
    end;
  finally
    CloseFile(oFile);
  end;
end;

{ TLORCS }

procedure TLORCS.Count(const AFileName: string);
var
  oFile: TextFile;
  sALine: string;
  bMCLStar: Boolean;
begin
  FTotalLines := 0;
  FCodeLines := 0;
  FCommentLines := 0;
  FBlankLines := 0;
  sALine := '';
  bMCLStar := False;

  try
    AssignFile(oFile, AFileName);
    Reset(oFile);
    while not Eof(oFile) do
    begin
      Readln(oFile, sALine);
      sALine := Trim(sALine);

      // 空行
      if SameText(sALine, '') then
        FBlankLines := FBlankLines + 1

      // 单行注释
      else if AnsiStartsText('#', sALine) then
        FCommentLines := FCommentLines + 1
      else begin

        // =begin 注释开始
        if bMCLStar then
          FCommentLines := FCommentLines + 1
        else if AnsiStartsText('=begin', sALine) then
        begin
          bMCLStar := True;
          FCommentLines := FCommentLines + 1;
        end;

        // 代码行
        if not bMCLStar then
          FCodeLines := FCodeLines + 1;

        // =end 注释结束
        if AnsiContainsText(sALine, '=end') then
            bMCLStar := False;
      end;

      // 总行数加1
      FTotalLines := FTotalLines + 1;
    end;
  finally
    CloseFile(oFile);
  end;
end;

end.
