program ParserClass;

uses
  FastMM4,
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm},
  ClassParser in 'ClassParser.pas',
  SimpleClassParser in 'SimpleClassParser.pas',
  Config in 'Config.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
