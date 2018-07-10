program ViewChartStackedDemo;

uses
  Forms,
  BaseForm in '..\BaseForm.pas',
  ViewChartStackedDemoMain in 'ViewChartStackedDemoMain.pas' {frmMain},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid ViewChart Stacked Diagrams Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
