unit SlocCoreTest;

interface

uses
  SysUtils, TestFramework, LOCSCore;

type
  TSlocCoreTest = class(TTestCase)
  published
    procedure TestSloc4Ruby;
    procedure TestSloc4Delphi;
  end;

const
  CRubyFile = '..\data\ruby\test.rb';
  CRubyDir = '';
  CRTotalLines = 15;
  CRCodeLines = 3;
  CRComentLines = 6;
  CRBlankLines = 6;

  CDelphiFile = '..\data\delphi\test.pas';
  CDelphiDir = '';
  CDTotalLines = 47;
  CDCodeLines = 20;
  CDComentLines = 14;
  CDBlankLines = 13;

implementation

{ TSlocCoreTest }

procedure TSlocCoreTest.TestSloc4Delphi;
var
  oLocrs: TLODCS;
begin
  oLocrs := TLODCS.Create;
  try
    oLocrs.Count(CDelphiFile);
    Check(oLocrs.TotalLines = CDTotalLines,
      'total lines:' + IntToStr(oLocrs.TotalLines) + '=' + IntToStr(CDTotalLines));

    Check(oLocrs.BlankLines = CDBlankLines,
      'blank lines:' + IntToStr(oLocrs.BlankLines) + '=' + IntToStr(CDBlankLines));

    Check(oLocrs.CommentLines = CDComentLines,
      'commend lines:' + IntToStr(oLocrs.CommentLines) + '=' + IntToStr(CDComentLines));

    Check(oLocrs.CodeLines= CDCodeLines,
      'code lines:' + IntToStr(oLocrs.CodeLines) + '=' + IntToStr(CDCodeLines));
  finally
    FreeAndNil(oLocrs);
  end;
end;

procedure TSlocCoreTest.TestSloc4Ruby;
var
  oLocrs: TLORCS;
begin
  oLocrs := TLORCS.Create;
  try
    oLocrs.Count(CRubyFile);
    Check(oLocrs.TotalLines = CRTotalLines,
      'total lines:' + IntToStr(oLocrs.TotalLines) + '=' + IntToStr(CRTotalLines));

    Check(oLocrs.BlankLines = CRBlankLines,
      'blank lines:' + IntToStr(oLocrs.BlankLines) + '=' + IntToStr(CRBlankLines));

    Check(oLocrs.CommentLines = CRComentLines,
      'commend lines:' + IntToStr(oLocrs.CommentLines) + '=' + IntToStr(CRComentLines));

    Check(oLocrs.CodeLines= CRCodeLines,
      'code lines:' + IntToStr(oLocrs.CodeLines) + '=' + IntToStr(CRCodeLines));
  finally
    FreeAndNil(oLocrs);
  end;
end;

initialization
RegisterTest(TSlocCoreTest.Suite);

end.
