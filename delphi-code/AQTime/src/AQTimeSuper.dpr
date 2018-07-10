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
            '�Զ�������AQTime���̣����������н����'+sLineBreak+
            sLineBreak+
            'AQTimeSuper [-h] [-p aqtimeprojectfile] [-s] '+
            '[-a accessfile] [-o outputfile]'+sLineBreak+
            sLineBreak+
            '  -h �����а�����Ϣ'+ sLineBreak+
            '  -p ����aqtime�Ĺ���'+sLineBreak+
            '  aqtimeprojectfile aqtime�Ĺ����ļ�'+sLineBreak+
            '  -s ����������ύ��sql-server��������'+sLineBreak+
            '  -a ������������浽access���ݿ��ļ��У�Ҫ��֤���ļ��Ѵ���'+sLineBreak+
            '  accessfile access���ݿ��ļ�'+sLineBreak+
            '  -o ������ڴ�й¶��Ϣ���浽�ļ���'+sLineBreak+
            '  outputfile �ڴ�й¶��Ϣ�ļ�'+sLineBreak
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
