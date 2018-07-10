program Clear;

uses
  FastMM4,
  Forms,
  Unit2 in 'src\Unit2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
