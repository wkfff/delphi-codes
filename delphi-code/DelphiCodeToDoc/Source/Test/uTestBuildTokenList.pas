unit uTestBuildTokenList;

interface

uses
  TestFramework, BuildTokenList, Converter, JcfUnicodeFiles, SysUtils;

type
  TTestBuildTokenList = class(TTestCase)
  private
    FConverter: TConverter;
    FTokeniser: TBuildTokenList;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
//    procedure TestChar;
    procedure TestBuildTokenList;
  end;

implementation

uses
  Windows;

const
  CTestFileName = '..\..\Test\TestUnit1.pas';


{ TTestBuildTokenList }

procedure TTestBuildTokenList.SetUp;
var
  lsSourceCode: WideString;
  leContentType: TFileContentType;
begin
//  FConverter := TConverter.Create;
    ExpandFileName(CTestFileName);
  ReadTextFile(CTestFileName, lsSourceCode, leContentType);
//  FConverter.InputCode := lsSourceCode;
  FTokeniser := TBuildTokenList.Create;
  FTokeniser.SourceCode := lsSourceCode;
end;



procedure TTestBuildTokenList.TearDown;
begin
//  FConverter.Clear;
//  FConverter.Free;
  FTokeniser.Free;
end;

procedure TTestBuildTokenList.TestBuildTokenList;
begin
  FTokeniser.BuildTokenList;
end;

//procedure TTestBuildTokenList.TestChar;
//resourcestring
//  s1 = '¹¦ÄÜ£º';
//  s2 = '£º';
//var
//  I: Integer;
//  s: string;
//begin
//  for I := 1 to Length(s1)  do
//  begin
//    s := s1[I];
//    OutputDebugString(PWideChar(s));
//  end;
//
//
//  Check(True, 'dele');
////
//end;


end.
