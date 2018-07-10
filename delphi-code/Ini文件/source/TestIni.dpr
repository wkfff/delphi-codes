program TestIni;

uses
  FastMM4,
  Forms,
  IniFrm in 'IniFrm.pas' {MainForm},
  TOTInfosDataModel in 'TOTInfosDataModel.pas',
  DMByRecord in 'DMByRecord.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
