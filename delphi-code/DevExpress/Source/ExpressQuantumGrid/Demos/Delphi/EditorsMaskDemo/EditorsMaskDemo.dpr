program EditorsMaskDemo;

uses
  Forms,
  EditorsMaskDemoMain in 'EditorsMaskDemoMain.pas' {EditorsMaskDemoMainForm},
  EditorsMaskDemoData in 'EditorsMaskDemoData.pas' {EditorsMaskDemoMainDM: TDataModule},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo},
  BaseForm in '..\BaseForm.pas' {fmBaseForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid EditorsMask Demo';
  Application.CreateForm(TEditorsMaskDemoMainForm, EditorsMaskDemoMainForm);
  Application.CreateForm(TEditorsMaskDemoMainDM, EditorsMaskDemoMainDM);
  Application.Run;
end.
