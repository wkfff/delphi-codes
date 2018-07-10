program StylesCardViewDemo;

uses
  Forms,
  StylesCardViewDemoMain in 'StylesCardViewDemoMain.pas' {StylesCardViewDemoMainForm},
  StylesCardViewDemoData in 'StylesCardViewDemoData.pas' {StylesCardViewDemoMainDM: TDataModule},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo},
  BaseForm in '..\BaseForm.pas',
  DemoUtils in '..\DemoUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid StylesCardView Demo';
  Application.CreateForm(TStylesCardViewDemoMainForm, StylesCardViewDemoMainForm);
  Application.CreateForm(TStylesCardViewDemoMainDM, StylesCardViewDemoMainDM);
  Application.Run;
end.
