program Project4;

uses
  Forms,
  Unit4 in 'Unit4.pas' {Form4},
  Unit1 in 'Unit1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
