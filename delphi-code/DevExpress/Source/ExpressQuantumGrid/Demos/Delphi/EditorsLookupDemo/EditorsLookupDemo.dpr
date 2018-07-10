program EditorsLookupDemo;

uses
  Forms,
  EditorsLookupDemoMain in 'EditorsLookupDemoMain.pas' {EditorsLookupDemoMainForm},
  EditorsLookupDemoData in 'EditorsLookupDemoData.pas' {EditorsLookupDemoDataDM: TDataModule},
  EditorsLookupDemoNewUser in 'EditorsLookupDemoNewUser.pas' {EditorsLookupDemoNewUserForm},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo},
  BaseForm in '..\BaseForm.pas' {fmBaseForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid EditorsLookupDemo';
  Application.CreateForm(TEditorsLookupDemoDataDM, EditorsLookupDemoDataDM);
  Application.CreateForm(TEditorsLookupDemoMainForm, EditorsLookupDemoMainForm);
  Application.CreateForm(TEditorsLookupDemoNewUserForm, EditorsLookupDemoNewUserForm);
  Application.Run;
end.
