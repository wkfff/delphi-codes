{ *********************************************************************** }
{                                                                         }
{   广联达文件类相关公共函数单元                                          }
{                                                                         }
{   设计：Linc 2006.01.18                                                 }
{   备注：                                                                }
{   审核：                                                                }
{                                                                         }
{   Copyright (c) 1994-2008 GrandSoft Corporation                         }
{                                                                         }
{ *********************************************************************** }
{                                                                         }
{   修改：                                                                }
{                                                                         }
{   2008.05.01 - Linc                                                     }
{                                                                         }
{     1、添加对 FPC 编译器的支持，同时支持 x86 和 x64 应用                }
{                                                                         }
{   2007.09.21 - Linc                                                     }
{                                                                         }
{     1、改进 AbsolutePath 的实现                                         }
{                                                                         }
{   2006.01.18 - Linc                                                     }
{                                                                         }
{     1、由 GrandFuncLib 拆分出来                                         }
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
    vtFile,    { 文件  }
    vtProduct, { 产品  }
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
//设计: Linc 2007.05.21
//功能: 合成一个相对的路径 （包括相对路径 ... 的处理）
//参数：
//注意：如果 ARelative 已经是一个存在的文件则直接退出返回 ARelative
//      若相对路径首字符为'\'，表示根目录
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
//设计: Linc 2005.09.21
//功能: 判断特殊文件
//参数：
////////////////////////////////////////////////////////////////////////////////
function IsDirNotation(const AName: string): Boolean;
begin
  Result := (AName = '.') or (AName = '..');
end;

////////////////////////////////////////////////////////////////////////////////
//说明：删除匹配的所有文件
//参数: AFileMask -- 带匹配符的文件名
//注意：不递归迭代删除子文件
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
//说明：删除目录（包括子目录及所有文件）
//参数：APath -- 要删除的路径
//返回：True -- 删除成功；False -- 删除失败
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
    if nAttr and faDirectory <> 0 then { 递归删除目录 }
      Result := DeleteTree(strFile)
    else begin
      if nAttr and faReadOnly <> 0 then { 去除只读属性 }
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
//设计：Linc 2008.09.26
//功能：扩展环境变量查找
//参数：
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
//设计：Linc 2008.09.26
//功能：解析带环境变量的文件名
//参数：
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
//说明：返回文件名（不包括扩展名及路径）
//参数：FileName -- 带路径及扩展名的文件名
//返回：不带路径及扩展名的文件名
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
//创建：Tu Jianhua 2004.1.14
//功能：判断一个文件是否已被打开
//参数：AFileName -- 文件名
//返回：True -- 已被打开；False -- 没有被打开
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
//设计：Linc 2008.07.17
//功能：文件时间转换到本地时间
//参数：
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
//设计: Linc 2004.07.30
//功能: 查找文件；去掉编译器的 WARNING
//参数：
//注意：首先查找当前目录的文件，再查找当前子目录下的文件
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
//设计: Linc 2003.09.21
//功能: 取得运行命令行的输出
//参数：
//说明：zhangjq 2012.05.08
//      1、Unicode环境下CreateProcess的第二个参数lpCommandLine可能被修改，故不能为const;
//      2、Console程序或cmd.exe在通过Readln, Writeln输入输出时, 默认的codepage为
//         DefaultSystemCodePage(中文操作系统为936)，故缓存应该设置为AnsiString；
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
//说明：返回当前运行EXE文件名
//参数：无
//返回：当前运行EXE文件名
////////////////////////////////////////////////////////////////////////////////
function GetExeFileName: string;
begin
  Result := GetModuleName(0);
end;

////////////////////////////////////////////////////////////////////////////////
//设计: Linc 2007.09.21
//功能: 返回当前运行 EXE 所在目录下文件的全路径
//参数：
////////////////////////////////////////////////////////////////////////////////
function GetExeModule(const AFileName: string): string;
begin
  Result := GetModuleName(0);
  if AFileName <> '' then Result := ExtractFilePath(Result) + AFileName;
end;

////////////////////////////////////////////////////////////////////////////////
//说明：返回当前运行EXE文件的路径
//参数：无
//返回：当前运行EXE文件的路径
////////////////////////////////////////////////////////////////////////////////
function GetExePath: string;
begin
  Result := GetModuleName(0);
  Result := ExtractFilePath(Result);
end;

////////////////////////////////////////////////////////////////////////////////
//说明：取匹配的所有文件名列表
//参数：AFileName -- 带匹配符的文件名
//       AFileList -- 匹配文件名列表
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
//设计：Linc 2010.11.18
//功能：获取文件大小
//参数：
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
//设计：Linc 2009.07.27
//功能：短文件名转换为长文件名
//参数：
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
//设计：Linc 2009.07.27
//功能：长文件名转换为短文件名
//参数：
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
//设计: Linc 2004.10.11
//功能: 获取当前所在模块的路径，模块可以是 EXE、DLL、OCX 等
//参数：
////////////////////////////////////////////////////////////////////////////////
function GetModuleFullPath(const AFileName: string): string;
begin
  Result := GetModuleFileName(HInstance);
  if AFileName <> '' then Result := ExtractFilePath(Result) + AFileName;
end;

////////////////////////////////////////////////////////////////////////////////
//设计：Linc 2007.11.14
//功能：必须去除 IIS 进程中诸如 \\?\C:\Inetpub\... 中的 \\?\
//参数：
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
//说明：根据给定的文件名前缀在指定目录下取唯一的临时文件名
//参数： APrefix -- 文件名前缀
//        APath -- 临时文件所在的目录
//返回：指定目录下以APrefix为前缀的临时文件名
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
//设计: Linc 2004.11.22
//功能: 获取操作系统可接受的文件名
//参数：
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
//说明：获取文件、产品版本号
//参数：AFileName-文件名；AVerType-版本类型（文件还是产品）
//返回：版本串，如3.1.0.34
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
//说明：取Windows系统目录
//参数：无
//返回：Windows系统目录
//      对应环境变量：windir
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
//说明：取Windows系统目录
//参数：无
//返回：Windows系统目录
//      对应环境变量：TEMP
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
//设计：Linc 2007.12.17
//功能：返回符合公司规范的文件路径
//参数：APath：基础路径；AProductName：当前产品名称；AVersion：当前产品版本
//注意：xxxx\CompanyName\ProductName\ProductVersion
////////////////////////////////////////////////////////////////////////////////
function GetProductPath(const APath, AProductName, AVersion: string): string;
begin
  Result := Format(defGrandSoftProductPathFmt, [IncludeTrailingPathDelimiter(APath), AProductName, AVersion]);
end;

////////////////////////////////////////////////////////////////////////////////
//设计：Linc 2007.12.17
//功能：返回符合公司规范的注册表路径
//参数：AProductName：当前产品名称；AVersion：当前产品版本
//注意：xxx\Software\CompanyName\ProductName\ProductVersion
////////////////////////////////////////////////////////////////////////////////
function GetProductRegKey(const AProductName, AVersion: string): string;
begin
  Result := Format(defGrandSoftRegKeyFmt, [AProductName, AVersion]);
end;

////////////////////////////////////////////////////////////////////////////////
//设计：Linc 2007.12.17
//功能：获取特殊文件夹路径，实现类似 SHGetSpecialFolderPath 的功能
//参数：
//注意：注册表里面可能会用 %USERPROFILE% 之类的环境变量
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
//设计：zhangjq 2013.05.14
//功能：获取特殊文件夹路径，动态调用shell32.dll里的 SHGetSpecialFolderPathA(W) 函数
//参数：
//说明: shlobj 单元静态定义了SHGetSpecialFolderPath函数，考虑到资源占用，不能直接
//      引用Shlobj单元，但CSIDL等常量的定义都在shlobj单元 ~.~
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
//设计：Linc 2007.12.18
//功能：获取应用程序公共组件安装目录
//参数：
//注意：C:\Program Files\Common Files\
//      对应环境变量：CommonProgramFiles
////////////////////////////////////////////////////////////////////////////////
function GetCommonProgramFilesPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_PROGRAM_FILES_COMMON);
end;

////////////////////////////////////////////////////////////////////////////////
//设计：Linc 2007.12.18
//功能：获取开始菜单目录
//参数：
//注意：
////////////////////////////////////////////////////////////////////////////////
function GetCommonStartMenuPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_COMMON_STARTMENU);
end;

////////////////////////////////////////////////////////////////////////////////
//设计：Linc 2007.12.18
//功能：获取应用程序安装目录
//参数：
//注意：C:\Program Files\
//      对应系统环境变量：ProgramFiles
////////////////////////////////////////////////////////////////////////////////
function GetProgramFilesPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_PROGRAM_FILES);
end;

////////////////////////////////////////////////////////////////////////////////
//设计：Linc 2007.12.17
//功能：获取全局的应用程序数据目录
//参数：
//注意：Gets the path for the application data that is shared among all users.
//      ms-help://MS.NETFramework.v20.en/cpref17/html/P_System_Windows_Forms_Application_CommonAppDataPath.htm
//      XP：C:\Documents and Settings\All Users\Application Data
//      Vista/WIn7：c:\ProgramData
//      对应系统环境变量：ALLUSERSPROFILE
////////////////////////////////////////////////////////////////////////////////
function GetCommonAppDataPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_COMMON_APPDATA);
end;

////////////////////////////////////////////////////////////////////////////////
//设计：Linc 2007.12.17
//功能：获取当前用户的应用程序数据目录
//参数：
//注意：Gets the path for the application data of a user.
//      ms-help://MS.NETFramework.v20.en/cpref17/html/P_System_Windows_Forms_Application_UserAppDataPath.htm
//      XP：C:\Documents and Settings\username\Application Data.
//      Vista/WIn7：C:\Users\username\AppData\Roaming
//      对应系统环境变量：APPDATA
////////////////////////////////////////////////////////////////////////////////
function GetUserAppDataPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_APPDATA);
end;

////////////////////////////////////////////////////////////////////////////////
//设计：Linc 2007.12.17
//功能：获取全局的用户文档目录
//参数：
//注意：C:\Documents and Settings\All Users\Documents
////////////////////////////////////////////////////////////////////////////////
function GetCommonDocumentsPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_COMMON_DOCUMENTS);
end;

////////////////////////////////////////////////////////////////////////////////
//设计：Linc 2007.12.17
//功能：获取当前用户的文档目录
//参数：
//注意：C:\Documents and Settings\UserName\My Documents
////////////////////////////////////////////////////////////////////////////////
function GetUserDocumentsPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_PERSONAL);
end;

////////////////////////////////////////////////////////////////////////////////
//设计：zhangjq 2012.08.24
//参数：None
//功能：获取公共桌面路径
////////////////////////////////////////////////////////////////////////////////
function  GetCommonDesktopPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_COMMON_DESKTOPDIRECTORY);
end;

////////////////////////////////////////////////////////////////////////////////
//设计：zhangjq 2012.08.24
//参数：None
//功能：获取用户桌面路径
////////////////////////////////////////////////////////////////////////////////
function GetUserDesktopPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_DESKTOP);
end;

////////////////////////////////////////////////////////////////////////////////
//设计: Linc 2005.07.16
//功能: 注册一个 DLL、OCX
//参数：
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
//设计: Linc 2005.07.16
//功能: 卸载一个 DLL、OCX
//参数：
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
//设计：Linc 2010.03.12
//功能：在环境变量定义的搜索路径中查找文件的完整路径
//参数：
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
//说明：如果字符串最后不是\，加\
//参数：S -- 字符串
//返回：字符串S后添加\后的字符串
//注意：建议直接使用 SysUtils.IncludeTrailingPathDelimiter 代替
////////////////////////////////////////////////////////////////////////////////
function Slash(const S: string): string;
begin
  Result := IncludeTrailingPathDelimiter(S);
end;

////////////////////////////////////////////////////////////////////////////////
//设计：Linc 2010.01.19
//功能：加载文件内容
//参数：
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
//设计：Linc 2010.01.19
//功能：保存文件内容
//参数：
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
//设计：Linc 2011.08.25
//功能：删除自身 EXE
//参数：
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