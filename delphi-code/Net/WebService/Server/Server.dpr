program Server;

{$APPTYPE GUI}

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {WebModule2: TWebModule},
  MainImpl in 'MainImpl.pas',
  MainIntf in 'MainIntf.pas',
  SockApp;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TWebModule2, WebModule2);
  Application.Run;
end.
