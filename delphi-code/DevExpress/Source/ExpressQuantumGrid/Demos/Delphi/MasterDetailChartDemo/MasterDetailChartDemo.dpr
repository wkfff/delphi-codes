program MasterDetailChartDemo;

uses
  Forms,
  MasterDetailChartDemoMain in 'MasterDetailChartDemoMain.pas' {frmMain},
  BaseForm in '..\BaseForm.pas',
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid Master-Detail Chart Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
