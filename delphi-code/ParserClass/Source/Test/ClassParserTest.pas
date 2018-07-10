unit ClassParserTest;

interface

uses
  TestFramework, ClassParser;

type
  TClassParserTest = class(TTestCase)
     procedure TestParse;
     procedure TestParseClass;
  published
     procedure TestReg;
  end;

  TMEmu1 = (tma, tmb);
  TMEmu2 = (tmc, tmd);
  TMEmu  = TMEmu1 + TMEmu2;

implementation

uses
  Classes, RegExpr, SysUtils, StrUtils;



{ TClassParserTest }

procedure TClassParserTest.TestParse;
var
  sFile: string;
  oClasses: TStringList;
begin
  sFile := '..\Source\Test\test.txt';
  oClasses := TStringList.Create;
//  GClassParser.Parse(sFile, oClasses);
  CheckTrue(oClasses.Count = 1);
  Check(False);
end;

procedure TClassParserTest.TestParseClass;
var
  sFile: string;
  oClasses: TStringList;
begin
  sFile := 'E:\GAEA\Refactoring\GGJ2013ForPlatform\GGC\Model\GGCShape.pas';
  oClasses := TStringList.Create;
  GClassParser.ParseClass(sFile, oClasses);
  CheckTrue(oClasses.Count = 1);
  Check(False);

end;

procedure TClassParserTest.TestReg;
var
  bClassDefBegin: Boolean;
  bIntfBegin: Boolean;
  oList: TStringList;
  I: Integer;
  oClassRegex: TRegExpr;
  sLine: string;
  s: string;
  o: TMEmu;
begin
  for o in TMEmu do
    o;


  s := '  TGGCShape = class;';//(TGrandRefCntIntfObject, IGGCShape)';
  oClassRegex := TRegExpr.Create;
  try
//    oClassRegex.Expression := '[\t\n\r]*(.*)[\t\n\r]=[\t\n\r]*class.*';
    oClassRegex.Expression := '[ ]*([A-z]*)[ ]*=.*class.*';
    oClassRegex.Compile;
    AnsiContainsText(s, 'a');

      if oClassRegex.Exec(s) and (Pos(';', s) < 1) then
      begin

        bClassDefBegin := True;
        sLine := oClassRegex.Match[1];
      end;
  finally
    oClassRegex.Free;
  end;
end;

initialization

  RegisterTest('', TClassParserTest.Suite);

end.
