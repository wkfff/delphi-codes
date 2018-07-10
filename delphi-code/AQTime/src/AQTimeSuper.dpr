program AQTimeSuper;

uses
  FastMM4,
  Forms,
  SysUtils,
  Windows,
  Mainfrm in 'Mainfrm.pas' {MainForm},
  DebuggerEngine_TLB in 'DebuggerEngine_TLB.pas',
  AQtime_TLB in 'AQtime_TLB.pas',
  AQtimeHelpers in 'AQtimeHelpers.pas',
  AppConsts in 'AppConsts.pas',
  getoptlib in 'getoptlib.pas',
  GAEAGetOpt in 'GAEAGetOpt.pas',
  AppCommandLine in 'AppCommandLine.pas';

{$R *.res}
{$APPTYPE CONSOLE}

var
  H: HWND;
  opt: TOptItem;
  sHelpInfo: string;

begin
  if ParamCount > 0 then
  begin
    try
      with TCommandLine do
      begin
        aqtimeprojectfile := '';
        sql := False;
        accessfile := '';
        outputfile := '';
      end;

      for opt in GetOpt('hp:sa:o:', ['help', 'aqtproject=', 'sqlserver', 'access=', 'output=']) do
      begin
        if SameText(opt.Opt, 'h') then
        begin
          sHelpInfo :=  sLineBreak+
            '自动化运行AQTime工程，并处理运行结果。'+sLineBreak+
            sLineBreak+
            'AQTimeSuper [-h] [-p aqtimeprojectfile] [-s] '+
            '[-a accessfile] [-o outputfile]'+sLineBreak+
            sLineBreak+
            '  -h 命令行帮助信息'+ sLineBreak+
            '  -p 运行aqtime的工程'+sLineBreak+
            '  aqtimeprojectfile aqtime的工程文件'+sLineBreak+
            '  -s 将分析结果提交到sql-server服务器上'+sLineBreak+
            '  -a 将分析结果保存到access数据库文件中，要保证该文件已存在'+sLineBreak+
            '  accessfile access数据库文件'+sLineBreak+
            '  -o 将类的内存泄露信息保存到文件中'+sLineBreak+
            '  outputfile 内存泄露信息文件'+sLineBreak
            ;
          Writeln(PAnsiChar(sHelpInfo));
        end
        else if SameText(opt.Opt, 'p') then
        begin
          TCommandLine.aqtimeprojectfile := opt.Arg;
        end
        else if SameText(opt.Opt, 's') then
        begin
          TCommandLine.sql := True;
        end
        else if SameText(opt.Opt, 'a') then
        begin
          TCommandLine.accessfile := opt.Arg;
        end
        else if SameText(opt.Opt, 'o') then
        begin
          TCommandLine.outputfile := opt.Arg;
        end
        else
          // none
          ;
      end;

      TMainForm.Execute;
    except
      on E:Exception do
        Writeln(E.Classname, ': ', E.Message);
    end;
  end
  else begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TMainForm, MainForm);

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
