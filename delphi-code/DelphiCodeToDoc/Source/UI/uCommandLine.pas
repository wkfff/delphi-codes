{*-------------------------------------------------------------------------------
  Command line process and generation
  This is the Console (DOS) part of the user interface
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   Initial revision
-------------------------------------------------------------------------------}
unit uCommandLine;

interface
uses
  SysUtils, Classes, uMessages;

// Specific to Command line
function VerifyCommand : boolean;
function IsLegalCommandLine : boolean;
function cmdCheckExecute : boolean;
function cmdBuildExecute: boolean;
function cmdOpenProject: boolean;
procedure FinishProcess;


implementation

uses JclFileUtils, uDocProject, uOptions, uOldOptions;

type
  TAppParam = (apAppExeName=0, apConfigFile);
  TObservedStringList = class(TStringList)
  public
    function Add(const S: string): Integer; override;
  end;

var
  cmdDebugMSG : TStrings;
  cmdUserMSG : TStrings;


// Verify if the command line is legal
function IsLegalCommandLine : boolean;
begin
  Result:=false;
  // Config file legal ?
  if ParamCount=integer(High(TAppParam)) then
   if FileExists(ParamStr(Integer(apConfigFile))) then Result:=true;
  // End of verify
end;


//Verify the command ans send informations to gui
function VerifyCommand : boolean;
begin
  if IsLegalCommandLine then
  begin
    Result:=true;
    WriteLn(Format(rsUsingConfigFile,[ParamStr(Integer(apConfigFile))]));
  end
  else
  begin
    Result:=false;
    WriteLn(rsIllegalCall);
    WriteLn(rsApplicationUsage);
  end;
end;

// Check the project. Return TRUE if checked
function cmdCheckExecute : boolean;
begin
  // Check if Project can be built
  if DocProject.Check then
   Result:=true
  else
  begin
    WriteLn(L_CheckingAborted);
    Result:=false;
  end;
end;

// Build the project
function cmdBuildExecute: boolean;
begin
  // Build Project documentation
  Assert(DocProject.isChecked);
  // Verify if all files are built !
  if DocProject.Build then Result:=true
  else
  begin
    result:=false;
    WriteLn(L_BuildError);
  end;
end;

function cmdReadXMLConfig(fn : TFilename): TRWOptionsError;
begin
  // For command line, complete the filename will the file path at the begining !
  Result:=DocProject.DocOptions.LoadFromFile(GetCurrentDir + PathDelim + fn);
end;

function cmdReadDCTDConfig(fn : TFilename): TRWOptionsError;
var
  FS:  TFileStream;
  DocOptions_TL03 : TDOCOptions_TL03;
begin
  DocOptions_TL03 := TDOCOptions_TL03.Create(nil);
  FS := TFileStream.Create(fn, fmOpenRead);
  try
    Result := DocOptions_TL03.LoadFromStream(FS);
  finally
    FS.Free;
  end;
  DocOptions_TL03.CopyToTL04(DocProject.DocOptions);
  FreeAndNil(DocOptions_TL03);
end;

function cmdOpenProject: boolean;
var
  Res: TRWOptionsError;
  ConfigFilename : TFilename;
begin
  // Create New Project
  DocProject := TDOCProject.Create;
  DocProject.DocOptions.SetDefaultValue;
  ConfigFilename := ParamStr(integer(apConfigFile));
  if Uppercase(ExtractFileExt(ConfigFilename)) = '.DCD' then
   Res := cmdReadDCTDConfig(ConfigFilename)
   else if Uppercase(ExtractFileExt(ConfigFilename)) = '.XML' then
    Res := cmdReadXMLConfig(ConfigFilename)
     else Res := oeUnknown;
  if Res = oeNoError then
  begin
    Result:=true;
    DocProject.SetDestinationMessages(cmdUserMSG, cmdDebugMSG);
    DocProject.State := psNew;
  end
  else
  begin
    Result:=false;
    WriteLn(L_ProjectLoadingError);
  end;
end;

procedure FinishProcess;
begin
  WriteLn(L_BuildSuccess);
  // Free project !!! 
  FreeAndNil(DocProject);
  // Exit with no error - Send ErrorLevel to 0
end;


{ TObservedStringList }

function TObservedStringList.Add(const S: string): Integer;
begin
  result:= inherited Add(S);
  WriteLn(S);
end;

initialization
  cmdDebugMSG:= TObservedStringList.Create;
  cmdUserMSG:= TObservedStringList.Create;

finalization
  FreeAndNil(cmdDebugMSG);
  FreeAndNil(cmdUserMSG);

end.
