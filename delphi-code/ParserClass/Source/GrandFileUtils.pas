{ *********************************************************************** }
{                                                                         }
{   �������ļ�����ع���������Ԫ                                          }
{                                                                         }
{   ��ƣ�Linc 2006.01.18                                                 }
{   ��ע��                                                                }
{   ��ˣ�                                                                }
{                                                                         }
{   Copyright (c) 1994-2008 GrandSoft Corporation                         }
{                                                                         }
{ *********************************************************************** }
{                                                                         }
{   �޸ģ�                                                                }
{                                                                         }
{   2008.05.01 - Linc                                                     }
{                                                                         }
{     1����Ӷ� FPC ��������֧�֣�ͬʱ֧�� x86 �� x64 Ӧ��                }
{                                                                         }
{   2007.09.21 - Linc                                                     }
{                                                                         }
{     1���Ľ� AbsolutePath ��ʵ��                                         }
{                                                                         }
{   2006.01.18 - Linc                                                     }
{                                                                         }
{     1���� GrandFuncLib ��ֳ���                                         }
{                                                                         }
{ *********************************************************************** }

unit GrandFileUtils;

{$I CompVers.inc}

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  SysUtils, Windows, Classes;

type
  TVerType = (
    vtFile,    { �ļ�  }
    vtProduct, { ��Ʒ  }
    vtBuild    { Build }
  );

function  AbsolutePath(const ABase, ARelative: string): string;
function  ExtractFileNameOnly(const AFileName: string): string;

function  DeleteFiles(const AFileMask: string): Integer;
function  DeleteTree(const APath: string): Boolean;

function  ExpandEnvironmentFileName(const AFile: string): string;

function  FileIsOpened(const AFileName: string): Boolean;
function  FileTime2DateTime(AFileTime: TFileTime): TDateTime;

procedure FindFiles(const AFileType, APath: string; AFileList: TStrings);
procedure GetFiles(const APath: string; AFileList: TStrings);

function  GetExeFileName: string;
function  GetExePath: string;
function  GetExeModule(const AFileName: string): string;

function  GetLongFileName(const AFileName: string): string;
function  GetShortFileName(const AFileName: string): string;

function  GetModuleFullPath(const AFileName: string): string;
function  GetModuleFileName(AModule: HMODULE): string;

function  GetCommandLineOutput(const ACommandLine, AWorkDir: string;
  out ExitCode: LongWord): string;
function  GetFileTimes(const FileName: string;
  out Created, Accessed, Modified: TDateTime): Boolean;
function  GetFileSize(const FileName: string): Int64;

function  IsValidFileName(const AName: string): Boolean;
function  GetValidFileName(const AName: string): string;

function  GetVersion(const AFileName: string = '';
  AVerType: TVerType = vtFile): string;

function  GetTempFile(const APrefix: string;
  const APath: string = ''): string;
function  GetWinSysDir: string;
function  GetWinTempDir: string;

function  GetProductPath(const APath, AProductName,
  AVersion: string): string;
function  GetProductRegKey(const AProductName, AVersion: string): string;

function  GetCommonProgramFilesPath: string;
function  GetCommonStartMenuPath: string;

function  GetProgramFilesPath: string;

function  GetCommonAppDataPath: string;
function  GetUserAppDataPath: string;

function  GetCommonDocumentsPath: string;
function  GetUserDocumentsPath: string;

function  GetCommonDesktopPath: string;
function  GetUserDesktopPath: string;

function  RegisterServer(const AFile: string): Boolean;
function  UnregisterServer(const AFile: string): Boolean;

function  SearchFilePath(const AFileName: string;
  out AFileFullPath: string): Boolean;

function  Slash(const S: string): string; deprecated;

function  LoadDataFromFile(const AFile: string): AnsiString;
procedure SaveDataToFile(const AFile: string; const AData: AnsiString);

procedure DeleteSelf;

implementation

uses
  StrUtils, Registry;

const
  conShellFolderKey     = '\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders';
  conWindowsFolderKey   = '\Software\Microsoft\Windows\CurrentVersion';

  conCommonFilesDir     = 'CommonFilesDir';
  conCommonStartMenu    = 'Common Start Menu';
  conProgramFilesDir    = 'ProgramFilesDir';
  conCommonDesktop      = 'Common Desktop';
  conUserDeskTop        = 'Desktop';

  conAppDataName        = 'AppData';
  conPersonalName       = 'Personal';

  conCommonAppDataName  = 'Common AppData';
  conCommonDocumentsName = 'Common Documents';

  defGrandSoftProductPathFmt = '%sGrandSoft\%s\%s';
  defGrandSoftRegKeyFmt = '\Software\GrandSoft\%s\%s';

const
  { Copy from shlobj.pas }
  CSIDL_DESKTOP                       = $0000; { <desktop> }
  CSIDL_INTERNET                      = $0001; { Internet Explorer (icon on desktop) }
  CSIDL_PROGRAMS                      = $0002; { Start Menu\Programs }
  CSIDL_PERSONAL                      = $0005; { My Documents.  This is equivalent to CSIDL_MYDOCUMENTS in XP and above }
  CSIDL_STARTUP                       = $0007; { Start Menu\Programs\Startup }
  CSIDL_STARTMENU                     = $000b; { <user name>\Start Menu }

  { For Windows >= XP }
  CSIDL_DESKTOPDIRECTORY              = $0010; { <user name>\Desktop }
  CSIDL_FONTS                         = $0014; { windows\fonts }
  CSIDL_COMMON_STARTMENU              = $0016; { All Users\Start Menu }
  CSIDL_COMMON_PROGRAMS               = $0017; { All Users\Start Menu\Programs }
  CSIDL_COMMON_STARTUP                = $0018; { All Users\Startup }
  CSIDL_COMMON_DESKTOPDIRECTORY       = $0019; { All Users\Desktop }
  CSIDL_APPDATA                       = $001a; { <user name>\Application Data }
  CSIDL_LOCAL_APPDATA                 = $001c; { <user name>\Local Settings\Application Data (non roaming) }
  CSIDL_COMMON_APPDATA                = $0023; { All Users\Application Data }
  CSIDL_WINDOWS                       = $0024; { GetWindowsDirectory() }
  CSIDL_SYSTEM                        = $0025; { GetSystemDirectory() }
  CSIDL_PROGRAM_FILES                 = $0026; { C:\Program Files }

  CSIDL_PROFILE                       = $0028; { USERPROFILE }
  CSIDL_PROGRAM_FILES_COMMON          = $002b; { C:\Program Files\Common }
  CSIDL_COMMON_DOCUMENTS              = $002e; { All Users\Documents }

const
{$IFDEF UNICODE}
  conPathCombine        = 'PathCombineW';
{$ELSE}
  conPathCombine        = 'PathCombineA';
{$ENDIF}
  conShlwapiDll         = 'shlwapi.dll';

  conInValidChars: array[0..8] of string = (
    '\',
    '/',
    ':',
    '*',
    '?',
    '"',
    '<',
    '>',
    '|'
  );

////////////////////////////////////////////////////////////////////////////////
//���: Linc 2007.05.21
//����: �ϳ�һ����Ե�·�� ���������·�� ... �Ĵ���
//������
//ע�⣺��� ARelative �Ѿ���һ�����ڵ��ļ���ֱ���˳����� ARelative
//      �����·�����ַ�Ϊ'\'����ʾ��Ŀ¼
////////////////////////////////////////////////////////////////////////////////
function AbsolutePath(const ABase, ARelative: string): string;
var
  PathCombine: function (lpszDest: PChar; const lpszDir, lpszFile: PChar):
    PChar; stdcall;
  nHandle: THandle;
begin
  Result := ARelative;
  nHandle := LoadLibrary(conShlwapiDll);
  Assert(nHandle <> 0);
  if nHandle <> 0 then
  try
    @PathCombine := GetProcAddress(nHandle, conPathCombine);
    Assert(Assigned(PathCombine), conPathCombine);
    SetLength(Result, MAX_PATH);
    PathCombine(PChar(Result), PChar(ABase), PChar(ARelative));
    Result := StrPas(PChar(Result));
  finally
    FreeLibrary(nHandle);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//���: Linc 2005.09.21
//����: �ж������ļ�
//������
////////////////////////////////////////////////////////////////////////////////
function IsDirNotation(const AName: string): Boolean;
begin
  Result := (AName = '.') or (AName = '..');
end;

////////////////////////////////////////////////////////////////////////////////
//˵����ɾ��ƥ��������ļ�
//����: AFileMask -- ��ƥ������ļ���
//ע�⣺���ݹ����ɾ�����ļ�
////////////////////////////////////////////////////////////////////////////////
function DeleteFiles(const AFileMask: string): Integer;
var
  cSearchRec: TSearchRec;
  strFilePath: string;
begin
  Result := 0;
  strFilePath := ExtractFilePath(AFileMask);
  if FindFirst(AFileMask, faAnyFile, cSearchRec) = 0 then
  repeat
    if (cSearchRec.Name <> '') and not IsDirNotation(cSearchRec.Name) then
      if SysUtils.DeleteFile(strFilePath + cSearchRec.Name) then
        Inc(Result);
  until FindNext(cSearchRec) <> 0;
  SysUtils.FindClose(cSearchRec);
end;

////////////////////////////////////////////////////////////////////////////////
//˵����ɾ��Ŀ¼��������Ŀ¼�������ļ���
//������APath -- Ҫɾ����·��
//���أ�True -- ɾ���ɹ���False -- ɾ��ʧ��
////////////////////////////////////////////////////////////////////////////////
function DeleteTree(const APath: string): Boolean;
var
  strPath,
  strFile: string;
  cSearchRec: TSearchRec;
  nAttr: Integer;
begin
  Result := True;
  if not DirectoryExists(APath) then
    Exit;
  strPath := IncludeTrailingPathDelimiter(APath);
  if FindFirst(strPath + '*.*', faAnyFile, cSearchRec) = 0 then
  repeat
    if (cSearchRec.Name = '') or IsDirNotation(cSearchRec.Name) then
      Continue;
    strFile := strPath + cSearchRec.Name;
    nAttr := cSearchRec.Attr;
    if nAttr and faDirectory <> 0 then { �ݹ�ɾ��Ŀ¼ }
      Result := DeleteTree(strFile)
    else begin
      if nAttr and faReadOnly <> 0 then { ȥ��ֻ������ }
      begin
        nAttr := nAttr and not faReadOnly;
        SetFileAttributes(PChar(strFile), nAttr);
      end;
      if not SysUtils.DeleteFile(strFile) then
        Result := False;
    end;
  until FindNext(cSearchRec) <> 0;
  SysUtils.FindClose(cSearchRec);
  if Result then Result := SysUtils.RemoveDir(strPath);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2008.09.26
//���ܣ���չ������������
//������
////////////////////////////////////////////////////////////////////////////////
function GetEnvironmentVariableEx(const AName: string): string;
begin
  if SameText(AName, 'cd') then
    Result := GetCurrentDir
  else if SameText(AName, 'exe') then
    Result := ExtractFileDir(GetModuleName(0))
  else Result := SysUtils.GetEnvironmentVariable(AName);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2008.09.26
//���ܣ������������������ļ���
//������
////////////////////////////////////////////////////////////////////////////////
function ExpandEnvironmentFileName(const AFile: string): string;
var
  nStart, nEnd: Integer;
  strEnv, strValue: string;
begin
  Result := AFile;
  if AFile = '' then
    Exit
  else nStart := Pos('%', Result);
  while nStart <> 0 do
  begin
    nEnd := PosEx('%', Result, nStart + 1);
    if nEnd <= 0 then
      Break;
    strEnv := Copy(Result, nStart + 1, nEnd - nStart - 1);
    strValue := GetEnvironmentVariableEx(strEnv);
    strEnv := '%' + strEnv + '%';
    Result := StringReplace(Result, strEnv, strValue, [rfReplaceAll, rfIgnoreCase]);
    nStart := PosEx('%', Result, nStart);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//˵���������ļ�������������չ����·����
//������FileName -- ��·������չ�����ļ���
//���أ�����·������չ�����ļ���
////////////////////////////////////////////////////////////////////////////////
function ExtractFileNameOnly(const AFileName: string): string;
var
  nDotPos: Integer;
begin
  Result := ExtractFileName(AFileName);
  nDotPos := LastDelimiter('.', Result);
  if nDotPos <> 0 then Result := Copy(Result, 1, nDotPos-1);
end;

////////////////////////////////////////////////////////////////////////////////
//������Tu Jianhua 2004.1.14
//���ܣ��ж�һ���ļ��Ƿ��ѱ���
//������AFileName -- �ļ���
//���أ�True -- �ѱ��򿪣�False -- û�б���
////////////////////////////////////////////////////////////////////////////////
function FileIsOpened(const AFileName: string): Boolean;
var
  hHandle: THandle;
begin
  Assert(FileExists(AFileName));
  hHandle := CreateFile(PChar(AFileName), GENERIC_READ, 0, nil,
                        OPEN_EXISTING, 0, 0);
  Result := hHandle = INVALID_HANDLE_VALUE;
  if not Result then CloseHandle(hHandle);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2008.07.17
//���ܣ��ļ�ʱ��ת��������ʱ��
//������
////////////////////////////////////////////////////////////////////////////////
function FileTime2DateTime(AFileTime: TFileTime): TDateTime;
var
  LocalFileTime: TFileTime;
  SystemTime: TSystemTime;
begin
  FileTimeToLocalFileTime(AFileTime, LocalFileTime);
  FileTimeToSystemTime(LocalFileTime, SystemTime);
  Result := SystemTimeToDateTime(SystemTime);
end;

////////////////////////////////////////////////////////////////////////////////
//���: Linc 2004.07.30
//����: �����ļ���ȥ���������� WARNING
//������
//ע�⣺���Ȳ��ҵ�ǰĿ¼���ļ����ٲ��ҵ�ǰ��Ŀ¼�µ��ļ�
////////////////////////////////////////////////////////////////////////////////
procedure FindFiles(const AFileType, APath: string; AFileList: TStrings);
var
  strType,
  strPath: string;
  cSearchRec: TSearchRec;
begin
  Assert(AFileList <> nil);

  strPath := IncludeTrailingPathDelimiter(APath);
  if AFileType = '' then
    strType := '*.*'
  else strType := AFileType;
  if FindFirst(strPath + strType, faAnyFile and (not faDirectory), cSearchRec) = 0 then
  repeat
    if cSearchRec.Name <> '' then
      AFileList.Add(strPath + cSearchRec.Name);
  until FindNext(cSearchRec) <> 0;
  SysUtils.FindClose(cSearchRec);
  if FindFirst(strPath + '*.*', faDirectory, cSearchRec) = 0 then
  repeat
    if (cSearchRec.Name <> '') and not IsDirNotation(cSearchRec.Name) then
      FindFiles(strType, strPath + cSearchRec.Name, AFileList);
  until FindNext(cSearchRec) <> 0;
  SysUtils.FindClose(cSearchRec);
end;

////////////////////////////////////////////////////////////////////////////////
//���: Linc 2003.09.21
//����: ȡ�����������е����
//������
//˵����zhangjq 2012.05.08
//      1��Unicode������CreateProcess�ĵڶ�������lpCommandLine���ܱ��޸ģ��ʲ���Ϊconst;
//      2��Console�����cmd.exe��ͨ��Readln, Writeln�������ʱ, Ĭ�ϵ�codepageΪ
//         DefaultSystemCodePage(���Ĳ���ϵͳΪ936)���ʻ���Ӧ������ΪAnsiString��
////////////////////////////////////////////////////////////////////////////////
function GetCommandLineOutput(const ACommandLine, AWorkDir: string;
  out ExitCode: LongWord): string;
var
  strCommandLine,
  strWorkDir: string;
  strOutLine,
  strBuffer: AnsiString;
  bRunResult: Boolean;
  nBytesRead: Cardinal;
  nStdOutPipeRead,
  nStdOutPipeWrite: THandle;
  PI: TProcessInformation;
  SA: TSecurityAttributes;
  SI: TStartupInfo;
begin
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  if not CreatePipe(nStdOutPipeRead, nStdOutPipeWrite, @SA, 0) then
    RaiseLastOSError;
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE);
      hStdOutput := nStdOutPipeWrite;
      hStdError := nStdOutPipeWrite;
    end;
    if DirectoryExists(AWorkDir) then
      strWorkDir := AWorkDir
    else strWorkDir := GetCurrentDir;
    strCommandLine := ACommandLine;
    UniqueString(strCommandLine);
    bRunResult := CreateProcess(nil, PChar(strCommandLine), nil, nil, True, 0, nil,
      PChar(strWorkDir), SI, PI);
    CloseHandle(nStdOutPipeWrite);
    if bRunResult then
    try
      strOutLine := '';
      SetLength(strBuffer, MAXBYTE);
      repeat
        nBytesRead := 0;
        bRunResult := ReadFile(nStdOutPipeRead, PAnsiChar(strBuffer)^, Length(strBuffer), nBytesRead, nil);
        if nBytesRead > 0 then
          strOutLine := strOutLine + Copy(strBuffer, 1, nBytesRead);
      until not bRunResult or (nBytesRead = 0);
      WaitForSingleObject(PI.hProcess, INFINITE);
      GetExitCodeProcess(PI.hProcess, ExitCode);
    finally
      CloseHandle(PI.hThread);
      CloseHandle(PI.hProcess);
    end
    else RaiseLastOSError;
  finally
    CloseHandle(nStdOutPipeRead);
    Result := string(strOutLine);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//˵�������ص�ǰ����EXE�ļ���
//��������
//���أ���ǰ����EXE�ļ���
////////////////////////////////////////////////////////////////////////////////
function GetExeFileName: string;
begin
  Result := GetModuleName(0);
end;

////////////////////////////////////////////////////////////////////////////////
//���: Linc 2007.09.21
//����: ���ص�ǰ���� EXE ����Ŀ¼���ļ���ȫ·��
//������
////////////////////////////////////////////////////////////////////////////////
function GetExeModule(const AFileName: string): string;
begin
  Result := GetModuleName(0);
  if AFileName <> '' then Result := ExtractFilePath(Result) + AFileName;
end;

////////////////////////////////////////////////////////////////////////////////
//˵�������ص�ǰ����EXE�ļ���·��
//��������
//���أ���ǰ����EXE�ļ���·��
////////////////////////////////////////////////////////////////////////////////
function GetExePath: string;
begin
  Result := GetModuleName(0);
  Result := ExtractFilePath(Result);
end;

////////////////////////////////////////////////////////////////////////////////
//˵����ȡƥ��������ļ����б�
//������AFileName -- ��ƥ������ļ���
//       AFileList -- ƥ���ļ����б�
////////////////////////////////////////////////////////////////////////////////
procedure GetFiles(const APath: string; AFileList: TStrings);
var
  cSearchRec: TSearchRec;
begin
  Assert(AFileList <> nil);

  AFileList.Clear;
  if FindFirst(APath, faAnyFile, cSearchRec) = 0 then
  repeat
    if cSearchRec.Name <> '' then
      AFileList.Add(cSearchRec.Name);
  until FindNext(cSearchRec) <> 0;
  SysUtils.FindClose(cSearchRec);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2010.11.18
//���ܣ���ȡ�ļ���С
//������
////////////////////////////////////////////////////////////////////////////////
function GetFileSize(const FileName: string): Int64;
var
  iSize: Int64Rec absolute Result;
  nHandle: THandle;
begin
  Result := 0;
  nHandle := FileOpen(FileName, fmOpenRead or fmShareDenyNone);
  if nHandle <> 0 then
  try
    iSize.Lo := Windows.GetFileSize(nHandle, @iSize.Hi);
    if (iSize.Lo = $FFFFFFFF) and (GetLastError <> 0) then
      iSize.Hi := $FFFFFFFF;
  finally
    FileClose(nHandle);
  end;
end;

function GetFileTimes(const FileName: string;
  out Created, Accessed, Modified: TDateTime): Boolean;
var
  nHandle: THandle;
  Info1, Info2, Info3: TFileTime;
  SysTimeStruct: SYSTEMTIME;
  TimeZoneInfo: TTimeZoneInformation;
  Bias: Double;
begin
  Result := False;
  Bias := 0;
  nHandle := FileOpen(FileName, fmOpenRead or fmShareDenyNone);
  if nHandle <> 0 then
  try
    if GetTimeZoneInformation(TimeZoneInfo) <> $FFFFFFFF then
      Bias := TimeZoneInfo.Bias / 1440; // 60x24
    GetFileTime(nHandle, @Info1, @Info2, @Info3);
    if FileTimeToSystemTime(Info1, SysTimeStruct) then
      Created := SystemTimeToDateTime(SysTimeStruct) - Bias;
    if FileTimeToSystemTime(Info2, SysTimeStruct) then
      Accessed := SystemTimeToDateTime(SysTimeStruct) - Bias;
    if FileTimeToSystemTime(Info3, SysTimeStruct) then
      Modified := SystemTimeToDateTime(SysTimeStruct) - Bias;
    Result := True;
  finally
    FileClose(nHandle);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2009.07.27
//���ܣ����ļ���ת��Ϊ���ļ���
//������
////////////////////////////////////////////////////////////////////////////////
function GetLongFileName(const AFileName: string): string;
const
{$IFDEF UNICODE}
  defGetLongPathName = 'GetLongPathNameW';
{$ELSE}
  defGetLongPathName = 'GetLongPathNameA';
{$ENDIF}
var
  nHandle: Integer;
  nRet: LongWord;
  GetLongPathName: function(ShortPathName: PChar; LongPathName: PChar; cchBuffer: Integer): Integer stdcall;
begin
  nHandle := GetModuleHandle(kernel32);
  Assert(nHandle <> 0);
  @GetLongPathName := GetProcAddress(nHandle, defGetLongPathName);
  if not Assigned(GetLongPathName) then
    Result := AFileName
  else begin
    SetLength(Result, 2 * MAX_PATH);
    nRet := GetLongPathName(PChar(AFileName), PChar(Result), Length(Result));
    if nRet = 0 then
      Result := ''
    else SetLength(Result, nRet);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2009.07.27
//���ܣ����ļ���ת��Ϊ���ļ���
//������
////////////////////////////////////////////////////////////////////////////////
function GetShortFileName(const AFileName: string): string;
begin
{
  if ExtractFileDrive(AFileName) = '' then
    Result := AFileName
  else begin
    Result := ExtractFilePath(AFileName);
    Result := ExtractShortPathName(Result);
    Result := IncludeTrailingPathDelimiter(Result) + ExtractFileName(AFileName);
    if Length(Result) > MAX_PATH then Result := ExtractShortPathName(AFileName);
  end;
}
  Result := SysUtils.ExtractShortPathName(AFileName);
end;

////////////////////////////////////////////////////////////////////////////////
//���: Linc 2004.10.11
//����: ��ȡ��ǰ����ģ���·����ģ������� EXE��DLL��OCX ��
//������
////////////////////////////////////////////////////////////////////////////////
function GetModuleFullPath(const AFileName: string): string;
begin
  Result := GetModuleFileName(HInstance);
  if AFileName <> '' then Result := ExtractFilePath(Result) + AFileName;
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2007.11.14
//���ܣ�����ȥ�� IIS ���������� \\?\C:\Inetpub\... �е� \\?\
//������
////////////////////////////////////////////////////////////////////////////////
function GetModuleFileName(AModule: HMODULE): string;
const
  defKernelPathPrex     = '\\?\';
begin
  Result := GetModuleName(AModule);
  if CompareMem(PCHar(defKernelPathPrex), PChar(Result), Length(defKernelPathPrex)) then
    Delete(Result, 1, Length(defKernelPathPrex));
end;

////////////////////////////////////////////////////////////////////////////////
//˵�������ݸ������ļ���ǰ׺��ָ��Ŀ¼��ȡΨһ����ʱ�ļ���
//������ APrefix -- �ļ���ǰ׺
//        APath -- ��ʱ�ļ����ڵ�Ŀ¼
//���أ�ָ��Ŀ¼����APrefixΪǰ׺����ʱ�ļ���
////////////////////////////////////////////////////////////////////////////////
function GetTempFile(const APrefix: string; const APath: string): string;
var
  sPath: string;
begin
  SetLength(Result, MAX_PATH);
  sPath := Trim(APath);
  if sPath = '' then
    sPath := GetCurrentDir;
  if GetTempFileName(PChar(sPath), PChar(APrefix), 0, PChar(Result)) = 0 then
    Result := ''
  else SetLength(Result, StrLen(PChar(Result)));
end;

function IsValidFileName(const AName: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  if AName = '' then Result := False;
  for I := Low(conInValidChars) to High(conInValidChars) do
    if Pos(conInValidChars[I], AName) > 0 then
    begin
      Result := False;
      Exit;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
//���: Linc 2004.11.22
//����: ��ȡ����ϵͳ�ɽ��ܵ��ļ���
//������
////////////////////////////////////////////////////////////////////////////////
function GetValidFileName(const AName: string): string;
const
  defValidChar          = '_';
var
  I: Integer;
begin
  Result := AName;
  for I := Low(conInValidChars) to High(conInValidChars) do
    Result := StringReplace(Result, conInValidChars[I], defValidChar, [rfReplaceAll]);
end;

////////////////////////////////////////////////////////////////////////////////
//˵������ȡ�ļ�����Ʒ�汾��
//������AFileName-�ļ�����AVerType-�汾���ͣ��ļ����ǲ�Ʒ��
//���أ��汾������3.1.0.34
///////////////////////////////////////////////////////////////////////////////
function GetVersion(const AFileName: string; AVerType: TVerType): string;
var
  strFile: string;
  nInfoSize, dwHandle: DWORD;
  cFileInfo: PVSFixedFileInfo;
  nVerSize: DWORD;
  strVerBuf: AnsiString;
begin
  Result := '';
  if AFileName <> '' then
    strFile := AFileName
  else strFile := GetModuleName(HInstance);
  nInfoSize := GetFileVersionInfoSize(PChar(strFile), dwHandle);
  if nInfoSize = 0 then
    Exit;
  SetLength(strVerBuf, nInfoSize);
  if not GetFileVersionInfo(PChar(strFile), dwHandle, nInfoSize, Pointer(strVerBuf)) then
    Exit;
  if VerQueryValue(Pointer(strVerBuf), '\', Pointer(cFileInfo), nVerSize) then
    case AVerType of
      vtFile:
        Result := Format('%d.%d.%d.%d', [HIWORD(cFileInfo.dwFileVersionMS),
          LOWORD(cFileInfo.dwFileVersionMS), HIWORD(cFileInfo.dwFileVersionLS),
            LOWORD(cFileInfo.dwFileVersionLS)]);
      vtProduct:
        Result := Format('%d.%d', [HIWORD(cFileInfo.dwProductVersionMS),
          LOWORD(cFileInfo.dwProductVersionMS) {, HIWORD(cFileInfo.dwProductVersionLS),
          LOWORD(cFileInfo.dwProductVersionLS)}]);
      vtBuild:
        Result := Format('%d', [LOWORD(cFileInfo.dwFileVersionLS)]);
    end;
end;

////////////////////////////////////////////////////////////////////////////////
//˵����ȡWindowsϵͳĿ¼
//��������
//���أ�WindowsϵͳĿ¼
//      ��Ӧ����������windir
////////////////////////////////////////////////////////////////////////////////
function GetWinSysDir: string;
var
  nRet: LongWord;
begin
  SetLength(Result, MAX_PATH);
  nRet := GetSystemDirectory(PChar(Result), MAX_PATH);
  if nRet = 0 then
    Result := ''
  else begin
    SetLength(Result, nRet);
    Result := ExcludeTrailingPathDelimiter(Result);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//˵����ȡWindowsϵͳĿ¼
//��������
//���أ�WindowsϵͳĿ¼
//      ��Ӧ����������TEMP
////////////////////////////////////////////////////////////////////////////////
function GetWinTempDir: string;
var
  nRet: LongWord;
begin
  SetLength(Result, MAX_PATH);
  nRet := GetTempPath(MAX_PATH, PChar(Result));
  if nRet = 0 then
    Result := ''
  else begin
    SetLength(Result, nRet);
    Result := ExcludeTrailingPathDelimiter(Result);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2007.12.17
//���ܣ����ط��Ϲ�˾�淶���ļ�·��
//������APath������·����AProductName����ǰ��Ʒ���ƣ�AVersion����ǰ��Ʒ�汾
//ע�⣺xxxx\CompanyName\ProductName\ProductVersion
////////////////////////////////////////////////////////////////////////////////
function GetProductPath(const APath, AProductName, AVersion: string): string;
begin
  Result := Format(defGrandSoftProductPathFmt, [IncludeTrailingPathDelimiter(APath), AProductName, AVersion]);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2007.12.17
//���ܣ����ط��Ϲ�˾�淶��ע���·��
//������AProductName����ǰ��Ʒ���ƣ�AVersion����ǰ��Ʒ�汾
//ע�⣺xxx\Software\CompanyName\ProductName\ProductVersion
////////////////////////////////////////////////////////////////////////////////
function GetProductRegKey(const AProductName, AVersion: string): string;
begin
  Result := Format(defGrandSoftRegKeyFmt, [AProductName, AVersion]);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2007.12.17
//���ܣ���ȡ�����ļ���·����ʵ������ SHGetSpecialFolderPath �Ĺ���
//������
//ע�⣺ע���������ܻ��� %USERPROFILE% ֮��Ļ�������
////////////////////////////////////////////////////////////////////////////////
function GetShellFolderPath(const ARoot: HKEY; const AKey, AName: string;
  out APath: string): Boolean;
begin
  with TRegistry.Create(KEY_READ) do
  try
    RootKey := ARoot;
    if OpenKey(AKey, False) then
    begin
      if ValueExists(AName) then
        APath := ReadString(AName)
      else APath := GetEnvironmentVariableEx(AName);
      APath := ExpandEnvironmentFileName(APath);
      CloseKey;
    end;
  finally
    Free;
  end;
  Result := DirectoryExists(APath);
  if Result then
  begin
{
    APath := ExtractShortPathName(APath);
}
    APath := IncludeTrailingPathDelimiter(APath);
  end
  else APath := '';
end;

type
  TSHGetSpecialFolderPathFunc = function (hwndOwner: HWND; lpszPath: PChar;
    nFolder: Integer; fCreate: BOOL): BOOL; stdcall;

const
  shell32               = 'shell32.dll';
{$IFDEF Unicode}
  defSHGetSpecialFolderPath = 'SHGetSpecialFolderPathW';
{$ELSE}
  defSHGetSpecialFolderPath = 'SHGetSpecialFolderPathA';
{$ENDIF}

////////////////////////////////////////////////////////////////////////////////
//��ƣ�zhangjq 2013.05.14
//���ܣ���ȡ�����ļ���·������̬����shell32.dll��� SHGetSpecialFolderPathA(W) ����
//������
//˵��: shlobj ��Ԫ��̬������SHGetSpecialFolderPath���������ǵ���Դռ�ã�����ֱ��
//      ����Shlobj��Ԫ����CSIDL�ȳ����Ķ��嶼��shlobj��Ԫ ~.~
////////////////////////////////////////////////////////////////////////////////
function GetSpecialFolderPath(ACSIDL: Integer): string;
var
  hShell32Inst: THandle;
  pGetSpecialFolderPathFunc: Pointer;
  bRet: Boolean;
begin
  hShell32Inst := LoadLibrary(shell32);
  if hShell32Inst <> 0 then
  begin
    pGetSpecialFolderPathFunc := GetProcAddress(hShell32Inst, defSHGetSpecialFolderPath);
    Assert(pGetSpecialFolderPathFunc <> nil, defSHGetSpecialFolderPath);
    SetLength(Result, MAX_PATH);
    bRet := TSHGetSpecialFolderPathFunc(pGetSpecialFolderPathFunc)(0,
      PChar(Result), ACSIDL, False);
    if bRet then
    begin
      Result := StrPas(PChar(Result));
      Result := IncludeTrailingPathDelimiter(Result);
    end
    else
      Result := '';
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2007.12.18
//���ܣ���ȡӦ�ó��򹫹������װĿ¼
//������
//ע�⣺C:\Program Files\Common Files\
//      ��Ӧ����������CommonProgramFiles
////////////////////////////////////////////////////////////////////////////////
function GetCommonProgramFilesPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_PROGRAM_FILES_COMMON);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2007.12.18
//���ܣ���ȡ��ʼ�˵�Ŀ¼
//������
//ע�⣺
////////////////////////////////////////////////////////////////////////////////
function GetCommonStartMenuPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_COMMON_STARTMENU);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2007.12.18
//���ܣ���ȡӦ�ó���װĿ¼
//������
//ע�⣺C:\Program Files\
//      ��Ӧϵͳ����������ProgramFiles
////////////////////////////////////////////////////////////////////////////////
function GetProgramFilesPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_PROGRAM_FILES);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2007.12.17
//���ܣ���ȡȫ�ֵ�Ӧ�ó�������Ŀ¼
//������
//ע�⣺Gets the path for the application data that is shared among all users.
//      ms-help://MS.NETFramework.v20.en/cpref17/html/P_System_Windows_Forms_Application_CommonAppDataPath.htm
//      XP��C:\Documents and Settings\All Users\Application Data
//      Vista/WIn7��c:\ProgramData
//      ��Ӧϵͳ����������ALLUSERSPROFILE
////////////////////////////////////////////////////////////////////////////////
function GetCommonAppDataPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_COMMON_APPDATA);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2007.12.17
//���ܣ���ȡ��ǰ�û���Ӧ�ó�������Ŀ¼
//������
//ע�⣺Gets the path for the application data of a user.
//      ms-help://MS.NETFramework.v20.en/cpref17/html/P_System_Windows_Forms_Application_UserAppDataPath.htm
//      XP��C:\Documents and Settings\username\Application Data.
//      Vista/WIn7��C:\Users\username\AppData\Roaming
//      ��Ӧϵͳ����������APPDATA
////////////////////////////////////////////////////////////////////////////////
function GetUserAppDataPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_APPDATA);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2007.12.17
//���ܣ���ȡȫ�ֵ��û��ĵ�Ŀ¼
//������
//ע�⣺C:\Documents and Settings\All Users\Documents
////////////////////////////////////////////////////////////////////////////////
function GetCommonDocumentsPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_COMMON_DOCUMENTS);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2007.12.17
//���ܣ���ȡ��ǰ�û����ĵ�Ŀ¼
//������
//ע�⣺C:\Documents and Settings\UserName\My Documents
////////////////////////////////////////////////////////////////////////////////
function GetUserDocumentsPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_PERSONAL);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�zhangjq 2012.08.24
//������None
//���ܣ���ȡ��������·��
////////////////////////////////////////////////////////////////////////////////
function  GetCommonDesktopPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_COMMON_DESKTOPDIRECTORY);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�zhangjq 2012.08.24
//������None
//���ܣ���ȡ�û�����·��
////////////////////////////////////////////////////////////////////////////////
function GetUserDesktopPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_DESKTOP);
end;

////////////////////////////////////////////////////////////////////////////////
//���: Linc 2005.07.16
//����: ע��һ�� DLL��OCX
//������
////////////////////////////////////////////////////////////////////////////////
function RegisterServer(const AFile: string): Boolean;
type
  TCOMFunc = function: HRESULT;
const
  S_OK = $00000000;
var
  nHandle: THandle;
  DllRegServ: TCOMFunc;
begin
  Result := False;

  nHandle := LoadLibrary(Pchar(AFile));
  if nHandle <> INVALID_HANDLE_VALUE then
  try
    DllRegServ := GetProcAddress(nHandle, 'DllRegisterServer');
    Result := Assigned(DllRegServ) and (DllRegServ() = S_OK);
  finally
    FreeLibrary(nHandle);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//���: Linc 2005.07.16
//����: ж��һ�� DLL��OCX
//������
////////////////////////////////////////////////////////////////////////////////
function UnregisterServer(const AFile: string): Boolean;
type
  TCOMFunc = function: HRESULT;
const
  S_OK = $00000000;
var
  nHandle: THandle;
  DllUnRegServ: TCOMFunc;
  DllCanUnloadNow: TCOMFunc;
begin
  Result := False;
  
  nHandle := LoadLibrary(Pchar(AFile));
  if nHandle <> INVALID_HANDLE_VALUE then
  try
    DllUnRegServ := GetProcAddress(nHandle, 'DllUnregisterServer');
    DllCanUnloadNow := GetProcAddress(nHandle, 'DllCanUnloadNow');
    Result := Assigned(DllCanUnloadNow) and (DllCanUnloadNow() = S_OK) and
      Assigned(DllUnRegServ) and (DllUnRegServ() = S_OK);
  finally
    FreeLibrary(nHandle);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2010.03.12
//���ܣ��ڻ����������������·���в����ļ�������·��
//������
////////////////////////////////////////////////////////////////////////////////
function SearchFilePath(const AFileName: string;
  out AFileFullPath: string): Boolean;
var
  S: string;
  P: PChar;
  nLen: Integer;
begin
  S := SysUtils.GetEnvironmentVariable('PATH');
  SetLength(AFileFullPath, MAX_PATH);
  P := nil;
  nLen := SearchPath(PChar(S), PChar(AFileName), nil, Length(AFileFullPath), PChar(AFileFullPath), P);
  Result := nLen > 0;
  if Result then SetLength(AFileFullPath, nLen);
end;

////////////////////////////////////////////////////////////////////////////////
//˵��������ַ��������\����\
//������S -- �ַ���
//���أ��ַ���S�����\����ַ���
//ע�⣺����ֱ��ʹ�� SysUtils.IncludeTrailingPathDelimiter ����
////////////////////////////////////////////////////////////////////////////////
function Slash(const S: string): string;
begin
  Result := IncludeTrailingPathDelimiter(S);
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2010.01.19
//���ܣ������ļ�����
//������
////////////////////////////////////////////////////////////////////////////////
function LoadDataFromFile(const AFile: string): AnsiString;
begin
  with TFileStream.Create(AFile, fmOpenRead or fmShareDenyWrite) do
  try
    SetLength(Result, Size);
    Read(PAnsiChar(Result)^, Size);
  finally
    Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2010.01.19
//���ܣ������ļ�����
//������
////////////////////////////////////////////////////////////////////////////////
procedure SaveDataToFile(const AFile: string; const AData: AnsiString);
begin
  with TFileStream.Create(AFile, fmCreate or fmShareDenyWrite) do
  try
    Size := Length(AData);
    Position := 0;
    Write(PAnsiChar(AData)^, Length(AData));
  finally
    Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//��ƣ�Linc 2011.08.25
//���ܣ�ɾ������ EXE
//������
////////////////////////////////////////////////////////////////////////////////
procedure DeleteSelf;
var
  oList: TStringList;
  strFileName, strBatFileName: string;
begin
  strFileName := GetModuleFileName(0);
  strBatFileName := ChangeFileExt(strFileName, '.bat');
  oList := TStringList.Create;
  with oList do
  try
    Add(':exec');
    Add('del "' + strFileName + '"');
    Add('if exist "' + strFileName + '" goto exec');
    Add('del "' + strBatFileName + '"');
    SaveToFile(strBatFileName);
  finally
    Free;
  end;
  WinExec(PAnsiChar(AnsiString(strBatFileName)), SW_HIDE);
end;

end.