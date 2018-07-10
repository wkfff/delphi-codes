library ServerDll;

uses
  ActiveX,
  ComObj,
  WebBroker,
  ISAPIApp,
  ISAPIThreadPool,
  Unit3 in 'Unit3.pas' {WebModule3: TWebModule},
  MainImpl in 'MainImpl.pas',
  MainIntf in 'MainIntf.pas';

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  Application.CreateForm(TWebModule3, WebModule3);
  Application.Run;
end.
