program LayoutViewDemo;

uses
  Forms,
  LayoutViewDemoMain in 'LayoutViewDemoMain.pas' {frmMain},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo},
  BaseForm in '..\BaseForm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid LayoutView Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
