program UnboundDesignDefinedDemo;

uses
  Forms,
  UnboundDesignDefinedDemoMain in 'UnboundDesignDefinedDemoMain.pas' {UnboundDesignDefinedDemoMainForm},
  BaseForm in '..\BaseForm.pas',
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressQuantumGrid UnboundDesignDefined Demo';
  Application.CreateForm(TUnboundDesignDefinedDemoMainForm, UnboundDesignDefinedDemoMainForm);
  Application.Run;
end.
