unit uTestJcfUnicode;

interface

uses
  JcfUnicode, TestFramework;

type
  TTestJcfUnicode = class(TTestCase)
  published
    procedure TestWideCharIsHigh;
  end;

implementation

{ TTestJcfUnicode }

procedure TTestJcfUnicode.TestWideCharIsHigh;
resourcestring
  s = '����';

begin
  Check(WideCharIsHigh(WideChar(s[1])));
  Check(WideCharIsHigh(WideChar('��')));
end;

end.
