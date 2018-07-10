{*------------------------------------------------------------------------------
  CHM Generator
  It provides all classes and functions to build CHM files from the structure
   builder.
  This generator is also based on uDocGeneratorHtml unit.

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
-------------------------------------------------------------------------------}
unit uDocGeneratorChm;

interface
uses
  SysUtils, Classes,
  uDocGeneratorVisitor, uDocGeneratorHtml,
  Tokens, uDocStructure,
  uDocTemplate, uDocMethod, uDocFunction, uDocField, uDocEvent, uDocVar,uDocType,
  uDocConstant, uDocProperty, uDocClass, uDocUnit;

type
  /// CHM generator class derived from TDocGeneratorHtml
  TDocGeneratorChm = class(TDocGeneratorHtml)
  private
    FCHMProjectLines : TStrings;  /// CHM Project strings
    FCHMIndexLines : TStrings;  /// CHM Index strings
    FCHMTOCLines : TStrings;  /// CHM TOC strings
    procedure ProcessProject(const pStructure: TDOCStructure);
    procedure ProcessUnits(const pStructure: TDOCStructure);
    procedure ProcessUnit(const pUnit: TDOCUnit);
    procedure ProcessClasses(const pClasses: TDOCClassList);
    procedure ProcessClass(const pClass: TDOCClass);
    procedure ProcessFields(const pFields: TDOCFieldList);
    procedure ProcessField(const pField: TDOCField);
    procedure ProcessMethods(const pMethods: TDOCMethodList);
    procedure ProcessMethod(const pMethod: TDOCMethod);
    procedure ProcessProperties(const pProperties:TDOCPropertyList);
    procedure ProcessProperty(const pProperty:TDOCProperty);
    procedure ProcessEvents(const pEvents: TDOCEventList);
    procedure ProcessEvent(const pEvent:TDOCEvent);
    procedure ProcessTypes(const pTypes : TDOCTypeList);
    procedure ProcessType(const pType: TDOCType);
    procedure ProcessConstants(const pConstants: TDOCConstantList);
    procedure ProcessConstant(const pConstant: TDOCConstant);
    procedure ProcessVariables(const pVariables: TDOCVarList);
    procedure ProcessVariable(const pVariable: TDOCVar);
    procedure ProcessFunctions(const pFunctions: TDOCFunctionList);
    procedure ProcessFunction(const pFunction: TDOCFunction);
    function GetChmBaseConfigFileName : string;
   public
    function GetOutputFile : TFileName; override;
    constructor Create(const DocStructure : TDOCStructure); override;
    destructor Destroy; override;
    procedure Execute; override;
    procedure OnConStdOut(Sender: TObject; s: String);
    procedure OnConStdErr(Sender: TObject; s: String);
    procedure OnConRun(Sender: TOBject);
    procedure OnConEnd(Sender: TOBject);
  end;

implementation

uses
  JclFileUtils, JclStrings, JvGnuGettext, JclShell,
   uOptions, RedCon, Dialogs, Forms,
  uDocGenCHM_Tools, uDocParameter,
  uDocGenHtmlVisitor;

resourcestring
  rsBuildingCHMProjectFiles='Building CHM project files';
  rsCompilingCHMFile='Compiling CHM file';
  rsWaitWhileBuildingCHM = 'Please, wait while building the CHM file';

var
  /// Redirected console object
  fCon : TRedirectedConsole;

/// Execute the document generator process
procedure TDocGeneratorChm.Execute;
const
  CHMBuildCmdCall = 'cmd';
  CHMBuildCmdParameters = '/c ';
  CHMBuildCmdFileName = 'hhc\hhc.exe';
  CHMBuildCmdParameter = ' "%s.hhp"';
var
  CmdLine : string;
  Parameters: string;
{$IFNDEF DCTD_CONSOLE}
  formWaitingMsg : TForm;
{$ENDIF}
  OutputPath : string;
begin
  OutputPath := ExtractFilePath(GetOutputFile);
  // Build 'chm' output directory if not exists
  if not DirectoryExists(OutputPath) then
   ForceDirectories(OutputPath);

  // Create Strings
  FCHMProjectLines := TStringList.Create;
  FCHMIndexLines := TStringList.Create;
  FCHMTOCLines := TStringList.Create;
  //
  CmdLine := ExtractFilePath(Application.ExeName)+CHMBuildCmdFileName;
  Parameters := Format(CHMBuildCmdParameter,[DocOptions.Name]);
  fCon := TRedirectedConsole.Create(CmdLine, Parameters);
  fCon.OnStdOut := OnConStdOut;
  fCon.OnStdErr := OnConStdErr;
  fCon.OnRun := OnConRun;
  fCon.OnEnd := OnConEnd;

  // Process HTML files creation
  inherited Execute();

  // Build project file (*.hpp)
  SendStatusMessage(rsBuildingCHMProjectFiles);
  ProcessProject(DocStructure);
  // Save CHM config Files
  FCHMProjectLines.SaveToFile(GetChmBaseConfigFileName+HHP_FILE_EXT);
  FCHMIndexLines.SaveToFile(GetChmBaseConfigFileName+HHK_FILE_EXT);
  FCHMTOCLines.SaveToFile(GetChmBaseConfigFileName+HHC_FILE_EXT);
  FreeAndNil(FCHMProjectLines);
  FreeAndNil(FCHMIndexLines);
  FreeAndNil(FCHMTOCLines);
  // Launch CHM creation
  SendStatusMessage(rsCompilingCHMFile);
  chdir(DocOptions.EffectiveOutputFolder);
  // Launch HHC.EXE
{$IFNDEF DCTD_CONSOLE}
  formWaitingMsg := CreateMessageDialog(rsWaitWhileBuildingCHM, mtInformation, []);
  formWaitingMsg.BorderStyle := bsDialog;
  formWaitingMsg.FormStyle := fsStayOnTop;
  formWaitingMsg.BorderIcons:=[];
  formWaitingMsg.Show;
{$ENDIF}
  fCon.Run;
  FreeAndNil(fCon);
  // Move generated files
  FileMove(GetChmBaseConfigFileName+HHP_FILE_EXT, OutputPath, True);
  FileMove(GetChmBaseConfigFileName+HHK_FILE_EXT, OutputPath, True);
  FileMove(GetChmBaseConfigFileName+HHC_FILE_EXT, OutputPath, True);
  FileMove(DocOptions.EffectiveOutputFolder + PathDelim + DocOptions.Name
   + CHM_FILE_EXT , OutputPath, True);
{$IFNDEF DCTD_CONSOLE}
  FreeAndNil(formWaitingMsg);
{$ENDIF}
  chdir(ExtractFilePath(Application.ExeName));
end;


{*------------------------------------------------------------------------------
  Create a TDocGeneratorChm instance by calling its inherited contructor
  @param  DocStructure Structure supporting this generator
-------------------------------------------------------------------------------}
constructor TDocGeneratorChm.Create(const DocStructure: TDOCStructure);
begin
  inherited;
end;

/// Destroy a TDocGeneratorChm instance
destructor TDocGeneratorChm.Destroy;
begin
  //
end;


{*------------------------------------------------------------------------------
  Return the name of the main generated file from Generator
  @return Created CHM filename
-------------------------------------------------------------------------------}
function TDocGeneratorChm.GetOutputFile: TFileName;
begin
  result := DocOptions.EffectiveOutputFolder + CHM_OUTPUT_PATH + PathDelim +
   DocOptions.Name + CHM_FILE_EXT;
end;

{*------------------------------------------------------------------------------
  Return the name of the main generated file from Generator
  @return  Name based on folder and project's name
-------------------------------------------------------------------------------}
function TDocGeneratorChm.GetChmBaseConfigFileName: string;
begin
  Result := DocOptions.EffectiveOutputFolder + DocOptions.Name;
end;

{*------------------------------------------------------------------------------
  Event executed at the end of the DOS capture
  @param Sender   Sender of the event
------------------------------------------------------------------------------*}
procedure TDocGeneratorChm.OnConEnd(Sender: TOBject);
begin
  // nothing
end;

{*------------------------------------------------------------------------------
  Event executed during the DOS capture.
  It only process the application pending messages, in order to refresh or
   repaint current controls.
  @param Sender   Event sender
------------------------------------------------------------------------------*}
procedure TDocGeneratorChm.OnConRun(Sender: TOBject);
begin
  Application.ProcessMessages;
end;

{*------------------------------------------------------------------------------
  Event executed during DOS capture errors.
  It relays the error messages to the OnConStdOut event
  @param Sender   Event sender
  @param s   Error text
  @return Event sender
------------------------------------------------------------------------------*}
procedure TDocGeneratorChm.OnConStdErr(Sender: TObject; s: String);
begin
  OnConStdOut(Sender,s);
end;

{*------------------------------------------------------------------------------
  Event executed during the DOS capture to get the output.
  It copies it to the message status of the main application
  @param Sender   Sender of the event
  @param s   Text captured
------------------------------------------------------------------------------*}
procedure TDocGeneratorChm.OnConStdOut(Sender: TObject; s: String);
var
  UpdatedStdOut : TStringList;
  IndexLine : integer;
begin
  UpdatedStdOut := TStringList.Create;
  UpdatedStdOut.SetText(PWideChar(s));
  for IndexLine:=0 to UpdatedStdOut.Count-1 do
  begin
    if(length(UpdatedStdOut.Strings[IndexLine]) > 0) then
     SendStatusMessage('[HHC] ' + UpdatedStdOut.Strings[IndexLine]);
  end;
  FreeAndNil(UpdatedStdOut);
end;

{*------------------------------------------------------------------------------
  Add the class in the CHM project
  @param  pClass The class to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessClass(const pClass: TDOCClass);
begin
  // Add Class heading to project file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(pClass.Name,pClass.BuildPathName,true));
  // Add Class file to Project file
  FCHMProjectLines.Add(CHMGenProjectFilesFile(pClass.BuildPathName));
  // Process members
  if ocClasses in DocOptions.OutputFilteringCategory then ProcessClasses(pClass.ClassList);
  if ocConstants in DocOptions.OutputFilteringCategory then ProcessConstants(pClass.ConstantList);
  if ocVariables in DocOptions.OutputFilteringCategory then ProcessVariables(pClass.VarList);
  if ocFields in DocOptions.OutputFilteringCategory then ProcessFields(pClass.FieldList);
  if ocProperties in DocOptions.OutputFilteringCategory then ProcessProperties(pClass.PropertyList);
  if ocMethods in DocOptions.OutputFilteringCategory then ProcessMethods(pClass.MethodList as TDOCMethodList);
  if ocEvents in DocOptions.OutputFilteringCategory then processEvents(pClass.EventList);
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;

{*------------------------------------------------------------------------------
  Add all classes in the CHM project
  @param  pUnit The unit with the classes to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessClasses(const pClasses: TDOCClassList);
var
  IndexClass: integer;
begin
  // Add Classes section to TOC files
  FCHMTOCLines.Add(CHMGenTocSimpleHeading('Classes'));
  for IndexClass:=0 to pClasses.Count-1 do
   if EvaluateItemDisplay(pClasses.Items[IndexClass]) then
    ProcessClass(pClasses.Items[IndexClass] as TDOCClass);
  // Close Units section
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;

{*------------------------------------------------------------------------------
  Add the constant in the CHM project
  @param  pConstant The constant to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessConstant(const pConstant: TDOCConstant);
begin
  // Add Constant heading to project file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(pConstant.Name,pConstant.BuildPathName,false));
  // Add Constant file to Project file
  FCHMProjectLines.Add(CHMGenProjectFilesFile(pConstant.BuildPathName));
end;

{*------------------------------------------------------------------------------
  Add all Constants in the CHM project
  @param  pUnit The unit with the Constants to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessConstants(const pConstants: TDOCConstantList);
var
  IndexConstant: integer;
begin
  // Add Constants section to TOC files
  FCHMTOCLines.Add(CHMGenTocSimpleHeading('Constants'));
  for IndexConstant:=0 to pConstants.Count-1 do
   if EvaluateItemDisplay(pConstants.Items[IndexConstant]) then
    ProcessConstant(pConstants.Items[IndexConstant] as TDOCConstant);
  // Close Units section
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;

{*------------------------------------------------------------------------------
  Add the Event in the CHM project
  @param  pEvent The Event to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessEvent(const pEvent: TDOCEvent);
begin
  // Add Event heading to project file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(pEvent.Name,pEvent.BuildPathName,false));
  // Add Event file to Project file
  FCHMProjectLines.Add(CHMGenProjectFilesFile(pEvent.BuildPathName));
end;

{*------------------------------------------------------------------------------
  Add all Events in the CHM project
  @param  pClass The class with the Events to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessEvents(const pEvents: TDOCEventList);
var
  IndexEvent: integer;
begin
  // Add Events section to TOC files
  FCHMTOCLines.Add(CHMGenTocSimpleHeading('Events'));
  for IndexEvent:=0 to pEvents.count-1 do
   if EvaluateItemDisplay(pEvents.Items[IndexEvent]) then
    ProcessEvent(pEvents.Items[IndexEvent] as TDOCEvent);
  // Close Units section
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;

{*------------------------------------------------------------------------------
  Add the Field in the CHM project
  @param  pField The Field to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessField(const pField: TDOCField);
begin
  // Add Field heading to project file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(pField.Name,pField.BuildPathName,false));
  // Add Field file to Project file
  FCHMProjectLines.Add(CHMGenProjectFilesFile(pField.BuildPathName));
end;

{*------------------------------------------------------------------------------
  Add all Fields in the CHM project
  @param  pClass The class with the Fields to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessFields(const pFields: TDOCFieldList);
var
  IndexField: integer;
begin
  // Add Fields section to TOC files
  FCHMTOCLines.Add(CHMGenTocSimpleHeading('Fields'));
  for IndexField:=0 to pFields.Count-1 do
   if EvaluateItemDisplay(pFields.Items[IndexField]) then
    ProcessField(pFields.Items[IndexField] as TDOCField);
  // Close Units section
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;

{*------------------------------------------------------------------------------
  Add the Function in the CHM project
  @param  pFunction The Function to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessFunction(const pFunction: TDOCFunction);
begin
  // Add Function heading to project file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(pFunction.Name,pFunction.BuildPathName,false));
  // Add Function file to Project file
  FCHMProjectLines.Add(CHMGenProjectFilesFile(pFunction.BuildPathName));
end;

{*------------------------------------------------------------------------------
  Add all Functions in the CHM project
  @param  pUnit The unit with the Functions to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessFunctions(const pFunctions: TDOCFunctionList);
var
  IndexFunction: integer;
begin
  // Add Fields section to TOC files
  FCHMTOCLines.Add(CHMGenTocSimpleHeading('Functions'));
  for IndexFunction:=0 to pFunctions.Count-1 do
   if EvaluateItemDisplay(pFunctions.Items[IndexFunction]) then
    ProcessFunction(pFunctions.Items[IndexFunction] as TDOCFunction);
  // Close Units section
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;

{*------------------------------------------------------------------------------
  Add the Method in the CHM project
  @param  pMethod The Method to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessMethod(const pMethod: TDOCMethod);
begin
  // Add Method heading to project file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(pMethod.Name,pMethod.BuildPathName,false));
  // Add Method file to Project file
  FCHMProjectLines.Add(CHMGenProjectFilesFile(pMethod.BuildPathName));
end;

{*------------------------------------------------------------------------------
  Add all classes in the CHM project
  @param  pUnit The unit with the classes to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessMethods(const pMethods: TDOCMethodList);
var
  IndexMethod: integer;
begin
  // Add Methods section to TOC files
  FCHMTOCLines.Add(CHMGenTocSimpleHeading('Methods'));
  for IndexMethod:=0 to pMethods.Count-1 do
   if EvaluateItemDisplay(pMethods.Items[IndexMethod]) then
    ProcessMethod(pMethods.Items[IndexMethod] as TDOCMethod);
  // Close Units section
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;

{*------------------------------------------------------------------------------
  Add the project in the CHM project
  @param  pStructure The project structure to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessProject(const pStructure: TDOCStructure);
begin
  // Add OPTIONS section in Project file
  FCHMProjectLines.Add(CHMGenProjectOptions(DocOptions.Name));
  // Add WINDOWS section in Project file
  FCHMProjectLines.Add(CHMGenProjectWindows(DocOptions.Name));
  // Add FILES start section
  FCHMProjectLines.Add(CHMGenProjectFilesStart);
  // Add project file to Project file
  FCHMProjectLines.Add(CHMGenProjectFilesFile(pStructure.BuildPathName));

  // Add HEAD section to TOC file
  FCHMTOCLines.Add(CHMGenTocHead);
  // Add BODY start section to TOC file
  FCHMTOCLines.Add(CHMGenTocBodyStart);
  // Add Project heading to TOC file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(DocOptions.Name,pStructure.BuildPathName,false));
  // Add Project heading to TOC file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(pStructure.ClassTree.Name
   ,pStructure.ClassTree.BuildPathName,false));

  // Process all unit files in structure
  ProcessUnits(pStructure);
  // ###BUG Workaround - If last line in TOC is a heading (folder), then it shows
  //  as a page. So, I added the TOC file at the end.
  // Add CSS_File heading to TOC file
  FCHMTOCLines.Add(CHMGenTocSimpleHeading('End',false));
  // Add INFOTYPES section to project file
  FCHMProjectLines.Add(CHMGenProjectInfoTypesStart);
  // Add BODY end section to TOC file
  FCHMTOCLines.Add(CHMGenTocBodyEnd);
end;

{*------------------------------------------------------------------------------
  Add all Properties in the CHM project
  @param  pClass The class with the Properties to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessProperties(const pProperties: TDOCPropertyList);
var
  IndexProperty: integer;
begin
  // Add Properties section to TOC files
  FCHMTOCLines.Add(CHMGenTocSimpleHeading('Properties'));
  for IndexProperty:=0 to pProperties.Count-1 do
   if EvaluateItemDisplay(pProperties.Items[IndexProperty]) then
    ProcessProperty(pProperties.Items[IndexProperty] as TDOCProperty);
  // Close Properties section
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;

{*------------------------------------------------------------------------------
  Add the Property in the CHM project
  @param  pProperty The Property to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessProperty(const pProperty: TDOCProperty);
begin
  // Add Property heading to project file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(pProperty.Name,pProperty.BuildPathName,false));
  // Add Property file to Project file
  FCHMProjectLines.Add(CHMGenProjectFilesFile(pProperty.BuildPathName));
end;

{*------------------------------------------------------------------------------
  Add the Type in the CHM project
  @param  pType The Type to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessType(const pType: TDOCType);
begin
  // Add Type heading to project file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(pType.Name,pType.BuildPathName,false));
  // Add Type file to Project file
  FCHMProjectLines.Add(CHMGenProjectFilesFile(pType.BuildPathName));
end;

{*------------------------------------------------------------------------------
  Add all Types in the CHM project
  @param  pUnit The unit with the Types to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessTypes(const pTypes : TDOCTypeList);
var
  IndexType: integer;
begin
  // Add Types section to TOC files
  FCHMTOCLines.Add(CHMGenTocSimpleHeading('Types'));
  for IndexType:=0 to pTypes.Count-1 do
   if EvaluateItemDisplay(pTypes.Items[IndexType]) then
    ProcessType(pTypes.Items[IndexType] as TDOCType);
  // Close Units section
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;

{*------------------------------------------------------------------------------
  Add the Unit in the CHM project
  @param  pUnit The Unit to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessUnit(const pUnit: TDOCUnit);
begin
  // Add unit heading to project file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(pUnit.Name,pUnit.BuildPathName,true));
  // Add unit file to Project file
  FCHMProjectLines.Add(CHMGenProjectFilesFile(pUnit.BuildPathName));

  if ocClasses in DocOptions.OutputFilteringCategory then ProcessClasses(pUnit.ClassList);
  if ocTypes in DocOptions.OutputFilteringCategory then ProcessTypes(pUnit.TypeList);
  if ocConstants in DocOptions.OutputFilteringCategory then ProcessConstants(pUnit.ConstantList);
  if ocVariables in DocOptions.OutputFilteringCategory then ProcessVariables(pUnit.VarList);
  if ocFunctions in DocOptions.OutputFilteringCategory then ProcessFunctions(pUnit.FunctionList as TDOCFunctionList);
  // Close unit heading
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;

{*------------------------------------------------------------------------------
  Add all Units in the CHM project
  @param  pStructure The project structure with the Units to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessUnits(const pStructure: TDOCStructure);
var
  IndexUnit: integer;
begin
  // Add Units section to TOC files
  FCHMTOCLines.Add(CHMGenTocSimpleHeading('Units'));
  for IndexUnit:=0 to pStructure.UnitList.Count-1 do
   ProcessUnit(pStructure.UnitList[IndexUnit] as TDOCUnit);
  // Close Units section
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;

{*------------------------------------------------------------------------------
  Add the Variable in the CHM project
  @param  pVariable The Variable to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessVariable(const pVariable: TDOCVar);
begin
  // Add Variable heading to project file
  FCHMTOCLines.Add(CHMGenTocLinkedHeading(pVariable.Name,pVariable.BuildPathName,false));
  // Add Variable file to Project file
  FCHMProjectLines.Add(CHMGenProjectFilesFile(pVariable.BuildPathName));
end;

{*------------------------------------------------------------------------------
  Add all Variables in the CHM project
  @param  pUnit The unit with the Variables to add
-------------------------------------------------------------------------------}
procedure TDocGeneratorChm.ProcessVariables(const pVariables: TDOCVarList);
var
  IndexVariable: integer;
begin
  // Add Variables section to TOC files
  FCHMTOCLines.Add(CHMGenTocSimpleHeading('Variables'));
  for IndexVariable:=0 to pVariables.Count-1 do
   if EvaluateItemDisplay(pVariables.Items[IndexVariable]) then
    ProcessVariable(pVariables.Items[IndexVariable] as TDOCVar);
  // Close Units section
  FCHMTOCLines.Add(CHMGenTocClosingFolder);
end;
                                                       
end.
