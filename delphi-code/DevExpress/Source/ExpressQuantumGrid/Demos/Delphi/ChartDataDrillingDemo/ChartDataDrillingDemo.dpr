program ChartDataDrillingDemo;

uses
  Forms,
  ChartDataDrillingDemoMain in 'ChartDataDrillingDemoMain.pas' {frmMain},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo},
  BaseForm in '..\BaseForm.pas' {fmBaseForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid ChartDataDrilling Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
