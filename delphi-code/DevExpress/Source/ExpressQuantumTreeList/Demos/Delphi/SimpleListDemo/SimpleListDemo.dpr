program SimpleListDemo;

uses
  Forms,
  SimpleListDemoMain in 'SimpleListDemoMain.pas' {SimpleListDemoMainForm},
  SimpleListDemoData in 'SimpleListDemoData.pas' {SimpleListDemoDataDM: TDataModule},
  DemoRating in '..\Common\DemoRating.pas' {DemoRatingForm},
  DemoBasicMain in '..\Common\DemoBasicMain.pas' {DemoBasicMainForm},
  AboutDemoForm in '..\Common\AboutDemoForm.pas' {formAboutDemo},
  DemoUtils in '..\Common\DemoUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumTreeList SimpleList Demo';
  Application.HelpFile := '..\..\Help\ExpressQuantumTreeList.hlp';
  Application.CreateForm(TSimpleListDemoMainForm, SimpleListDemoMainForm);
  Application.CreateForm(TSimpleListDemoDataDM, SimpleListDemoDataDM);
  Application.Run;
end.
