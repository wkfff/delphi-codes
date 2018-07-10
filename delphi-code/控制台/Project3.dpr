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
  // 应藏控制台窗口 保险起见，每日构造和制作升级规则包用两个EXE。
    SetConsoleTitle(PChar('Debug Window'));
    // 没有这句话，运行EXE的时候控制台窗口无法隐藏
    writeln('Hello World!');
    H := FindWindow('ConsoleWindowClass', 'Debug Window');
    if H <> 0 then
      ShowWindow(H, SW_HIDE);


    Application.Run;
  end;
end.
