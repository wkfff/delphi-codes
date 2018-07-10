unit TestMain;

interface

uses
  SysUtils, TestFramework, Class1Test, Class2Test;

implementation

function UnitTests: TTestSuite;
var
  oTestSuite: TTestSuite;
begin
  oTestSuite := TTestSuite.Create('some tests');
  oTestSuite.AddTests(TClass1Test);
  oTestSuite.AddTests(TClass2Test);
  Result := oTestSuite;
end;

initialization
RegisterTest('module1', unitTests);
RegisterTest('module2', UnitTests);

end.
