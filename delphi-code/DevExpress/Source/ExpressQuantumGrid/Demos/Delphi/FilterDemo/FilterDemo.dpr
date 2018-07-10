program FilterDemo;

uses
  Forms,
  FilterDemoMain in 'FilterDemoMain.pas' {frmMain},
  BaseForm in '..\BaseForm.pas',
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid Filter Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
