program CellLevelMultiselectDemo;

uses
  Forms,
  CellLevelMultiselectDemoMain in 'CellLevelMultiselectDemoMain.pas' {CellLevelMultiselectDemoMainForm},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo},
  BaseForm in '..\BaseForm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid CellLevelMultiselect Demo';
  Application.CreateForm(TCellLevelMultiselectDemoMainForm, CellLevelMultiselectDemoMainForm);
  Application.Run;
end.
