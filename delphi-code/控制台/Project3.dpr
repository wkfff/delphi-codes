program Project3;

uses
  Forms,
  Windows,
  Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

{$APPTYPE CONSOLE}

var
H: HWND;

begin
  if ParamCount > 1 then
  begin
    Writeln('a');
    Readln
  end
  else begin
    Application.Initialize;
    Application.CreateForm(TForm2, Form2);
  // Ӧ�ؿ���̨���� ���������ÿ�չ�����������������������EXE��
    SetConsoleTitle(PChar('Debug Window'));
    // û����仰������EXE��ʱ�����̨�����޷�����
    writeln('Hello World!');
    H := FindWindow('ConsoleWindowClass', 'Debug Window');
    if H <> 0 then
      ShowWindow(H, SW_HIDE);


    Application.Run;
  end;
end.
