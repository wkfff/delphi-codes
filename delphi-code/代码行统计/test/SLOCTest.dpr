program SLOCTest;

uses
  FastMM4,
  Forms,
  TestFramework,
  GUITestRunner,
  SlocCoreTest in 'SlocCoreTest.pas';

{$R *.res}

begin
  Application.Initialize;
  GUITestRunner.RunRegisteredTests;
end.
