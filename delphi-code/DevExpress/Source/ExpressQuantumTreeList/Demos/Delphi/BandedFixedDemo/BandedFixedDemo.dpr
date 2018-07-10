program BandedFixedDemo;

uses
  Forms,
  BandedFixedDemoMain in 'BandedFixedDemoMain.pas' {BandedFixedDemoMainForm},
  BandedFixedDemoData in 'BandedFixedDemoData.pas' {BandedFixedDemoDataDM: TDataModule},
  DemoRating in '..\Common\DemoRating.pas' {DemoRatingForm},
  DemoBasicMain in '..\Common\DemoBasicMain.pas' {DemoBasicMainForm},
  AboutDemoForm in '..\Common\AboutDemoForm.pas' {formAboutDemo},
  DemoUtils in '..\Common\DemoUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumTreeList BandedFixedDemo';
  Application.HelpFile := '..\..\Help\ExpressQuantumTreeList.hlp';
  Application.CreateForm(TBandedFixedDemoMainForm, BandedFixedDemoMainForm);
  Application.CreateForm(TBandedFixedDemoDataDM, BandedFixedDemoDataDM);
  Application.Run;
end.
