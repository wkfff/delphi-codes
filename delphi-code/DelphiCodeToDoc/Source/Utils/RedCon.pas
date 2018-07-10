unit RedCon;

(*
simple yet working console i/o redirection
(c) 2002-2004 bhoc@pentagroup.ch
freeware

there are two Data events (OnStdOut and OnStdErr) that return a string;
two other events just signal that the program is running or that it has ended.
the SendData() method will submit a string to an open application such as cmd.exe.

sample:

procedure TForm1.Button1Click(Sender: TObject);
begin
  fCon := TRedirectedConsole.Create(Edit1.Text);
  fCon.OnStdOut := OnConStdOut;
  fCon.OnStdErr := OnConStdErr;
  fCon.OnRun := OnConRun;
  fCon.OnEnd := OnConEnd;
  fCon.Run;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fCon.Free;
end;

procedure TForm1.OnConStdOut(Sender: TObject; s: String);
begin
  memo1.Lines.Append(s);
end;

procedure TForm1.OnConStdErr(Sender: TObject; s: String);
begin
  memo2.Lines.Append(s);
end;

procedure TForm1.OnConRun(Sender: TOBject);
begin
  Application.ProcessMessages;
  Sleep(10);
end;

procedure TForm1.OnConEnd(Sender: TOBject);
begin
  MessageBox(Application.Handle, 'Program has ended', 'Program Ended', MB_OK or MB_ICONINFORMATION or MB_SETFOREGROUND);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  fCon.SendData(edit2.Text + #13#10);
end;

*)

interface

uses windows;

type
  TOnData = procedure(Sender: TObject; Data: String) of object;
  TOnRun = procedure(Sender: TObject) of object;
  TRedirectedConsole = Class(TObject)
  private
    fExitTimeOut: Integer;
    fStdInRead, fStdInWrite: THandle;
    fStdOutRead, fStdOutWrite: THandle;
    fStdErrRead, fStdErrWrite: THandle;
    fSA: TSecurityAttributes;
    fPI: TProcessInformation;
    fSI: TStartupInfo;
    fDestroying: Boolean;
    fCmdLine: String;
    fOnStdOut, fOnStdErr: TOnData;
    fOnRun, fOnEnd: TOnRun;
    fIsRunning: Boolean;
    fHidden: boolean;
    fMerge: boolean;
    fStdOut, fStdErr: String;
    fParameters: string;
    function ReadHandle(h: THandle; var s: string): integer;
    Procedure EndProcess(hProc: THandle);
  protected
  public
    constructor Create(CommandLine: String; Parameters: string = '');
    destructor Destroy; override;
    procedure Run;
    procedure Stop;
    procedure SendData(s: String);
    property ExitTimeOut: integer read fExitTimeout write fExitTimeout;
    property OnStdOut: TOnData read fOnStdOut write fOnStdOut;
    property OnStdErr: TOnData read fOnStdErr write fOnStdErr;
    property OnRun: TOnRun read fOnRun write fOnRun;
    property OnEnd: TOnRun read fOnEnd write fOnEnd;
    property MergeOutput: boolean read fMerge write fMerge;
    property IsRunning: boolean read fIsRunning;
    property HideWindow: boolean read fHidden write fHidden;
    property StdOut: string read fStdOut;
    property StdErr: string read fStdErr;
  end;

implementation

uses
  SysUtils;

const BufSize = 1024;

constructor TRedirectedConsole.Create(CommandLine: String; Parameters: string = '');
begin
  inherited Create;
  fCmdLine := CommandLine;
  fParameters := Parameters;
  fExitTimeOut := 5000;
  fIsRunning := False;
  fHidden := True;
  fMerge := False;
  fDestroying := False;
  FillChar(fSA, SizeOf(fSA), 0);
  fSA.nLength := SizeOf(fSA);
  fSA.lpSecurityDescriptor := nil;
  fSA.bInheritHandle := True;
  CreatePipe(fStdInRead, fStdInWrite, @fSA, BufSize);
  CreatePipe(fStdOutRead, fStdOutWrite, @fSA, BufSize);
  CreatePipe(fStdErrRead, fStdErrWrite, @fSA, BufSize);
end;

destructor TRedirectedConsole.Destroy;
begin
  fDestroying := True;
  fOnEnd := nil;
  fOnRun := nil;
  fOnStdOut := nil;
  fOnStdErr := nil;
  Stop;
  CloseHandle(fStdInWrite);
  CloseHandle(fStdOutRead);
  CloseHandle(fStdErrRead);
  inherited;
end;

function TRedirectedConsole.ReadHandle(h: THandle; var s: String): integer;
var
  BytesWaiting: Cardinal;
  Buf: Array[1..BufSize] of AnsiChar; //char;
{$IFDEF VER100}
  BytesRead: Integer;
{$ELSE}
  BytesRead: Cardinal;
{$ENDIF}
begin
  Result := 0;
  PeekNamedPipe(h, nil, 0, nil, @BytesWaiting, nil);
  if BytesWaiting > 0 then
  begin
    if BytesWaiting > BufSize then
      BytesWaiting := BufSize;
    ReadFile(h, Buf[1], BytesWaiting, BytesRead, nil);
    s := Copy(string(Buf), 1, BytesRead);
    Result := BytesRead;
  end;
end;

procedure TRedirectedConsole.SendData(s: String);
var
{$IFDEF VER100}
  BytesWritten: Integer;
{$ELSE}
  BytesWritten: Cardinal;
{$ENDIF}
begin
  if fIsRunning then
  begin
    WriteFile(fStdInWrite, s[1], Length(s), BytesWritten, nil);
  end;
end;

procedure TRedirectedConsole.Stop;
begin
  if fIsRunning then
    EndProcess(fPI.hProcess);
end;

procedure TRedirectedConsole.EndProcess(hProc: THandle);
var
  hLib: THandle;
  hRT: THandle;
  pExitProcess: pointer;
  iTI: THandle; //Integer;
  bTerminated: Boolean;
begin
  bTerminated := False;
  hLib := LoadLibrary('KERNEL32');
  if hLib <> 0 then
  begin
    pExitProcess := GetProcAddress(hLib, 'ExitProcess');
    if pExitProcess <> nil then
    begin
      hRT := CreateRemoteThread(hProc, nil, 0, pExitProcess, nil, 0, iTI);
      if hRT <> 0 then
      begin
        bTerminated := (WaitForSingleObject(hRT, fExitTimeOut) = WAIT_OBJECT_0);
        CloseHandle(hRT);
      end;
    end;
    FreeLibrary(hLib);
  end;
  if not bTerminated then
  begin
    TerminateProcess(hProc, 0);
    WaitForSingleObject(hProc, fExitTimeOut);
  end;
  fIsRunning := False;
end;

procedure TRedirectedConsole.Run;
var
  s: String;
  hProcOld: THandle;
begin
  fStdOut := '';
  fStdErr := '';
  FillChar(fSI, SizeOf(fSI), 0);
  fSI.cb := SizeOf(fSI);
  if fHidden then
    fSI.wShowWindow := SW_HIDE
  else
    fSI.wShowWindow := SW_SHOWDEFAULT;
  fSI.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
  fSI.hStdInput := fStdInRead;
  fSI.hStdOutput := fStdOutWrite;
  if fMerge then
    fSI.hStdError := fStdOutWrite
  else
    fSI.hStdError := fStdErrWrite;
  if CreateProcess(PChar(fCmdLine), PChar(fParameters), nil, nil, True, CREATE_NEW_PROCESS_GROUP or NORMAL_PRIORITY_CLASS, nil, nil, fSI, fPI) then
  begin
    hProcOld := fPI.hProcess;
    fIsRunning := True;
    CloseHandle(fStdOutWrite);
    CloseHandle(fStdErrWrite);
    CloseHandle(fStdInRead);
    CloseHandle(fPI.hThread);
    While ((WaitForSingleObject(fPI.hProcess, 10) = WAIT_TIMEOUT) and fIsRunning) do
    begin
      if fDestroying then
        exit;
      if ReadHandle(fStdOutRead, s) > 0 then
        if Assigned(fOnStdOut) then
          fOnStdOut(Self, s)
        else
          fStdOut := Concat(fStdOut, s);
      if ReadHandle(fStdErrRead, s) > 0 then
        if Assigned(fOnStdErr) then
          fOnStdErr(Self, s)
        else
          fStdErr := Concat(fStdErr, s);
      if Assigned(fOnRun) then
        fOnRun(Self);
    end;
    if fDestroying then
      exit;
    if ReadHandle(fStdOutRead, s) > 0 then
      if Assigned(fOnStdOut) then
        fOnStdOut(Self, s)
      else
        fStdOut := Concat(fStdOut, s);
    if ReadHandle(fStdErrRead, s) > 0 then
      if Assigned(fOnStdErr) then
        fOnStdErr(Self, s)
      else
        fStdErr := Concat(fStdErr, s);
    if (fPI.hProcess = hProcOld) then
      CloseHandle(fPI.hProcess);
    fIsRunning := False;
    if Assigned(fOnEnd) then
      fOnEnd(Self);
  end
  else
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

end.
