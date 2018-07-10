program ViewChartDemo;

uses
  Forms,
  ViewChartDemoMain in 'ViewChartDemoMain.pas' {frmMain},
  BaseForm in '..\BaseForm.pas',
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid ViewChart Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
