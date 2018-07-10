program MDIDemo;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm},
  ChildFrm in 'ChildFrm.pas' {ChildForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
