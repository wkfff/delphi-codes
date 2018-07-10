program CustomRowHeightDemo;

uses
  Forms,
  CustomRowHeightDemoMain in 'CustomRowHeightDemoMain.pas' {CustomRowHeightDemoMainForm},
  CustomRowHeightDemoData in 'CustomRowHeightDemoData.pas' {CustomRowHeightDemoDataDM: TDataModule},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo},
  BaseForm in '..\BaseForm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid CustomRowHeight Demo';
  Application.CreateForm(TCustomRowHeightDemoMainForm, CustomRowHeightDemoMainForm);
  Application.CreateForm(TCustomRowHeightDemoDataDM, CustomRowHeightDemoDataDM);
  Application.Run;
end.
