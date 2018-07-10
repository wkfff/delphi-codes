program GCJATTest;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  TestMain in 'TestMain.pas',
  Class1Test in 'Class1Test.pas',
  Class2Test in 'Class2Test.pas';

{$R *.res}

begin
  Application.Initialize;
  if IsConsole then
    TextTestRunner.RunRegisteredTests
  else
    GUITestRunner.RunRegisteredTests;

end.
