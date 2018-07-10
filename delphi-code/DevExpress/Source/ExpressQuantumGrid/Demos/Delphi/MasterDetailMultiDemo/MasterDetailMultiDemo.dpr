program MasterDetailMultiDemo;

uses
  Forms,
  MasterDetailMultiDemoMain in 'MasterDetailMultiDemoMain.pas' {MasterDetailMultiDemoMainForm},
  MasterDetailMultiDemoData in 'MasterDetailMultiDemoData.pas' {MasterDetailMultiDemoMainDM: TDataModule},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo},
  BaseForm in '..\BaseForm.pas',
  DemoUtils in '..\DemoUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid MasterDetailMulti Demo';
  Application.CreateForm(TMasterDetailMultiDemoMainDM, MasterDetailMultiDemoMainDM);
  Application.CreateForm(TMasterDetailMultiDemoMainForm, MasterDetailMultiDemoMainForm);
  Application.Run;
end.
