program SLOC;

uses
  FastMM4,
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm},
  LOCSCore in 'LOCSCore.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
