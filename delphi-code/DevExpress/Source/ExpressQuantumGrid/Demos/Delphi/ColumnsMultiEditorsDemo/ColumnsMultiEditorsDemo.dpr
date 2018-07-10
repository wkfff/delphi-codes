program ColumnsMultiEditorsDemo;

uses
  Forms,
  ColumnsMultiEditorsDemoDS in 'ColumnsMultiEditorsDemoDS.pas',
  ColumnsMultiEditorsDemoMain in 'ColumnsMultiEditorsDemoMain.pas' {ColumnsMultiEditorsDemoMainForm},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo},
  BaseForm in '..\BaseForm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid ColumnsMultiEditors Demo';
  Application.CreateForm(TColumnsMultiEditorsDemoMainForm, ColumnsMultiEditorsDemoMainForm);
  Application.Run;
end.
