{*------------------------------------------------------------------------------
  Module that centralize all Options.
  This module contains the TDOCOptions, and all informations for each option :
   Name, Description, Values, translations, etc ...
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   Initial revision
  @version   2004/08/06   TridenT   Added 'CommentDecoratorChar' option
  @version   2004/09/04   TridenT   Added 'HideEmptyOutputBlock' option
  @version   2005/09/05   TridenT   Added 'AllowHtmlInDescription' option
  @version   2007/04/01   TridenT   Added ocRecords in OutputFilteringCategory option
  @version   2007/04/17   TridenT   Added 'MethodCommentFromAncestor' option
  @version   2007/12/06   TridenT   Added ofNone OutputFormat (no documentation)
  @version   2008/11/26   TridenT   Added
-------------------------------------------------------------------------------}

unit uOptions;

interface

uses
  Classes, SysUtils;

type
  /// OutPut format Styles for the Generated Documentation
  TOutputFormat  = (ofNone, ofHTML, ofCHM, ofPDF); // ofTEXT, , ofXML
  /// List of keywords for Member visiblity
  TMemberVisibility = (mvPrivate, mvProtected, mvPublic, mvPublished
   , mvAutomated);
  /// Set of Member visibility
  TVisibilitySet = set of TMemberVisibility;
  /// List of member category
  TOutputCategoryList = (ocUnits, ocConstants, ocResourcestrings, ocTypes
   , ocVariables, ocFunctions, ocRecords, ocClasses, ocFields, ocMethods
   , ocProperties, ocEvents);
  /// Set of member category
  TOutputCategoryListSet = set of TOutputCategoryList;
  /// List of supported TAG recognition
  TTagComment    = (tcINLINE, tcJAVADOC, tcJEDI, tcXMLDoc);
  /// Set of TAG recognition
  TTagCommentSet = set of TTagComment;
  /// List of language supported by the application
  TLanguage      = (lEnglish, lFrench);
  /// Return value for managing project's configuration file
  TRWOptionsError = (oeNoError, oeNoErrorButUpgraded, oeUnknown, oeIDStartNOK, oeIDEndNOK, oeTechLevelNOK);
  /// CSS configuration
  TCssConfiguration = (ccInternal, ccCustom);

  {*----------------------------------------------------------------------------
    Holder for all Options module
    Parser, structure builder, Generator and the DelphiCodeToDoc application
    share this class that contains all options.
  -----------------------------------------------------------------------------}
  TDOCOptions = class(TPersistent)
    // Must be a TPersistent to have published property saved
  private
    // Internal field
    FApplicationPath : TFilename; /// Path of the application. Set at application startup
    FProjectFolder: string; /// Folder of the project using these options
    // Property Field
    FRecurseDirectory: boolean; /// Search inside sub-directoryes
    FTitle: string; /// Title of the project
    FHTMLlink: string;  /// HTML link to the project page, or author page
    FCopyright: string; /// Copyright of the author
    FAuthor: string;  /// Information about the author (name, email for example)
    FName: string;  /// Name of the project, use as a basename for the output files
    FCustomFooter: TFileName; /// Author's Footer filename insert in each generated files
    FOutputFolder: TFileName; /// Where all output files will be saved
    FCustomHeader: TFileName; /// Author's Header filename insert in each generated files
    FLanguage: TLanguage; /// Ouput Language of the documentation
    FOutputFormat: TOutputFormat; /// Output format od the documentation
    FConditionalDefines: TStringList; /// List of defines needed to interprete source code
    FSummary: string;  /// Summary of the project (only one line)
    FDescription: TStringList; /// Project's Description, few lines are permitted
    FTagCommentSet: TTagCommentSet; ///  TAG that will be extracted to the documentation
    FVisibilitySet: TVisibilitySet; /// Visibility filter wanted for the output
    FBoolsAsChecks: boolean;  ///  See Checkmarks or boolean expression for options
    FLaunchBrowser: boolean; /// Launch browser at the end of the documentation generation
    FAlphaSort: boolean;  /// Alphabetical sort of the Unit, Class, and member name
    FWarnEmptyTAG: boolean; /// Add a warning message in the documentation if some TAGs are missing
    FHideEmptyTAGSection: boolean;  /// Empty TAG section will be hide
    FSkipFirstTAGLine: boolean; /// Skip first TAG line, that are sometimes decorator
    FSkipLastTAGLine: boolean;  /// Skip last TAG line, that are sometimes decorator
    FParseImplementationSection: boolean; /// Also Parse implementation section (for TAG)
    FBracketStarJavaDocCharPrefix: char; /// JavaDoc Prefix for BracketStar comments
    FInLineJavaDocCharPrefix: char; /// JavaDoc Prefix for Inline comments
    FCurlyJavaDocCharPrefix: char; /// JavaDoc Prefix for Curly comments
    FHideEmptyOutputBlock: boolean; /// Hide any empty output block
    FOutputFilteringCategory : TOutputCategoryListSet; /// Show/Hide some members category
    FFilesIncludeList: TStringList; /// List of included items (files or folders)
    FFilesExcludeList: TStringList; /// List of exluded items (files or folders)
    FAllowHtmlInDescription: boolean; /// Keep description as string or Encode for html
    FPropertyCommentFromAssessors: boolean; /// Get comment from assessors for uncommented properties
    FDisplayHiddenItems: Boolean; /// Display items defined only in implementation section
    FMethodCommentFromAncestor: boolean; /// Get comment from ancestor for uncommented methods
    FCssConfiguration : TCssConfiguration; /// What CSS file to use
    FCssCustomFile : TFilename; /// When CssConfiguration set to cfCustom, this file CSS will be used
    // end properties
    function GetEffectiveOutputFolder: string;
  published
    // General options
    // Application Options
    property BoolsAsChecks: boolean Read FBoolsAsChecks Write FBoolsAsChecks stored True;
    property LaunchBrowser: boolean Read FLaunchBrowser Write FLaunchBrowser stored True;
    // Input options
    property Name: string Read FName Write FName stored True;
    property Title: string Read FTitle Write FTitle stored True;
    property Summary: string Read FSummary Write FSummary stored True;
    property Description: TStringList Read FDescription Write FDescription stored True;
    property Author: string Read FAuthor Write FAuthor stored True;
    property HTMLlink: string Read FHTMLlink Write FHTMLlink stored True;
    property Copyright: string Read FCopyright Write FCopyright stored True;
    property RecurseDirectory: boolean Read FRecurseDirectory
      Write FRecurseDirectory stored True;
    property ConditionalDefines: TStringList
      Read FConditionalDefines Write FConditionalDefines stored True;
    property ParseImplementationSection: boolean
      Read FParseImplementationSection Write FParseImplementationSection stored True;
    // Output options
    property CustomHeader: TFileName Read FCustomHeader Write FCustomHeader stored True;
    property CustomFooter: TFileName Read FCustomFooter Write FCustomFooter stored True;
    property Language: TLanguage Read FLanguage Write FLanguage stored True;
    property OutputFormat: TOutputFormat
      Read FOutputFormat Write FOutputFormat stored True;
    property OutputFolder: TFileName Read FOutputFolder Write FOutputFolder stored True;
    property VisibilitySet: TVisibilitySet Read FVisibilitySet
      Write FVisibilitySet stored True;
    property TagCommentSet: TTagCommentSet Read FTagCommentSet
      Write FTagCommentSet stored True;
    property AlphaSort: boolean Read FAlphaSort Write FAlphaSort stored True;
    property WarnEmptyTAG: boolean Read FWarnEmptyTAG Write FWarnEmptyTAG stored True;
    property HideEmptyTAGSection: boolean Read FHideEmptyTAGSection
      Write FHideEmptyTAGSection stored True;
    property HideEmptyOutputBlock: boolean Read FHideEmptyOutputBlock
      Write FHideEmptyOutputBlock stored True;
    property OutputFilteringCategory:TOutputCategoryListSet read FOutputFilteringCategory
     write FOutputFilteringCategory stored True;
    property CssConfiguration : TCssConfiguration read FCssConfiguration
     write FCssConfiguration stored True;
    property CssCustomFile : TFilename read FCssCustomFile write FCssCustomFile stored True;
    // JavaDoc Support
    property SkipFirstTAGLine: boolean Read FSkipFirstTAGLine
      Write FSkipFirstTAGLine stored True;
    property SkipLastTAGLine: boolean Read FSkipLastTAGLine
      Write FSkipLastTAGLine stored True;
    // JavaDoc Prefix
    property InLineJavaDocCharPrefix: char Read FInLineJavaDocCharPrefix
      Write FInLineJavaDocCharPrefix stored True;
    property CurlyJavaDocCharPrefix: char Read FCurlyJavaDocCharPrefix
      Write FCurlyJavaDocCharPrefix stored True;
    property BracketStarJavaDocCharPrefix: char
      Read FBracketStarJavaDocCharPrefix Write FBracketStarJavaDocCharPrefix stored True;
    property FilesIncludeList: TStringList read FFilesIncludeList write FFilesIncludeList stored True;
    property FilesExcludeList: TStringList read FFilesExcludeList write FFilesExcludeList stored True;
    property AllowHtmlInDescription: boolean read FAllowHtmlInDescription write FAllowHtmlInDescription;
    property PropertyCommentFromAssessors: boolean read FPropertyCommentFromAssessors write FPropertyCommentFromAssessors;
    property DisplayHiddenItems : Boolean read FDisplayHiddenItems write FDisplayHiddenItems stored True;
    property MethodCommentFromAncestor: boolean read FMethodCommentFromAncestor write FMethodCommentFromAncestor stored True;
  public
    // Internal options
    ApplicationLanguage: string;  /// ISO language name used in the application
    GeneratorLanguage: string; /// ISO language name used in the doc generated
    procedure SetDefaultValue;
    constructor Create(ApplicationPath : TFilename); virtual;
    destructor Destroy; override;
    function SaveToFile(Filename : TFilename): TRWOptionsError;
    function LoadFromFile(Filename : TFilename): TRWOptionsError;
    function IsValidCustomCssFile(out AbsoluteCssFile : TFilename) : Boolean;
    procedure FixOptions;
    property EffectiveOutputFolder: string read GetEffectiveOutputFolder;
  end;

  {*----------------------------------------------------------------------------
    Description of options by short name and name
    Each option need to be describe with the following fields
  -----------------------------------------------------------------------------}
  TPropertyDescription = record
    iName: string; /// The name of the property inside the class : pdName_____
    iCaption: string; /// he written Caption of this options in the application : pdCaption_____
    iReadOnly: boolean; ///The possibility for the user to modify this option at runtime
    iChanged: TNotifyEvent; ///A notify method to react immediately about a changed value for this option
  end;

{gnugettext: scan-all text-domain='DCTD_ignore' }
resourcestring
  // Name for Options
  pdNameBoolsAsChecks = 'BoolsAsChecks';
  pdNameName      = 'Name';
  pdNameTitle     = 'Title';
  pdNameSummary   = 'Summary';
  pdNameDescription = 'Description';
  pdNameAuthor    = 'Author';
  pdNameHTMLLink  = 'HTMLlink';
  pdNameCopyright = 'Copyright';
  pdNameRecurseDirectory = 'RecurseDirectory';
  pdNameConditionalDefines = 'ConditionalDefines';
  pdNameCustomHeader = 'CustomHeader';
  pdNameCustomFooter = 'CustomFooter';
  pdNameLanguage  = 'Language';
  pdNameOutputFormat = 'OutputFormat';
  pdNameOutputFolder = 'OutputFolder';
  pdNameVisibilitySet = 'VisibilitySet';
  pdNameTagCommentSet = 'TagCommentSet';
  pdNameLaunchBrowser = 'LaunchBrowser';
  pdNameSortAlpha = 'AlphaSort';
  pdNameWarnEmptyTAG = 'WarnEmptyTAG';
  pdNameHideEmptyTAGSection = 'HideEmptyTAGSection';
  pdNameSkipFirstTAGLine = 'SkipFirstTAGLine';
  pdNameSkipLastTAGLine = 'SkipLastTAGLine';
  pdNameParseImplementationSection = 'ParseImplementationSection';
  pdNameHideEmptyOutputBlock = 'HideEmptyOutputBlock';
  pdNameOutputFilteringCategory = 'OutputFilteringCategory';
  pdNameBracketStarJavaDocCharPrefix = 'BracketStarJavaDocCharPrefix';
  pdNameInLineJavaDocCharPrefix = 'InLineJavaDocCharPrefix';
  pdNameCurlyJavaDocCharPrefix = 'CurlyJavaDocCharPrefix';
  pdNameFilesIncludeList = 'FilesIncludeList';
  pdNameFilesExcludeList = 'FilesExcludeList';
  pdNameAllowHtmlInDescription = 'AllowHtmlInDescription';
  pdNamePropertyCommentFromAssessors = 'PropertyCommentFromAssessors';
  pdNameDisplayHiddenItems = 'DisplayHiddenItems';
  pdNameMethodCommentFromAncestor = 'MethodCommentFromAncestor';
  pdNameCssConfiguration = 'CssConfiguration';
  pdNameCssCustomFile = 'CssCustomFile';
{gnugettext: reset }

  // Caption  for Options
  pdCaptionBoolsAsChecks = 'Bools as Checks';
  pdCaptionName      = 'Project''s Name';
  pdCaptionTitle     = 'Project''s Title';
  pdCaptionSummary   = 'Project''s Summary';
  pdCaptionDescription = 'Project''s Description';
  pdCaptionAuthor    = 'Project''s Author';
  pdCaptionHTMLLink  = 'HTML Link';
  pdCaptionCopyright = 'Author''s Copyright';
  //pdCaptionRootDirectory = 'Root Directory';
  pdCaptionRecurseDirectory = 'Recurse Directory';
  pdCaptionConditionalDefines = 'Conditional Defines';
  pdCaptionCustomHeader = 'Custom Header';
  pdCaptionCustomFooter = 'Custom Footer';
  pdCaptionLanguage  = 'Documentation Language';
  pdCaptionOutputFormat = 'Output Format';
  pdCaptionOutputFolder = 'Output Folder';
  pdCaptionVisibilitySet = 'Member visibility filter';
  pdCaptionTagCommentSet = 'Comment syntax recognition';
  pdCaptionLaunchBrowser = 'Launch Browser after Build?';
  psCaptionSortAlpha = 'Alpha sort of members';
  psCaptionWarnEmptyTAG = 'Warn when TAG are empty';
  pdCaptionHideEmptyTAGSection = 'Hide empty TAG section from report';
  pdCaptionSkipFirstTAGLine = 'Skip first TAG line in comment block';
  pdCaptionSkipLastTAGLine = 'Skip last TAG line in comment block';
  pdCaptionParseImplementationSection = 'Parse Implementation Section';
  pdCaptionBracketStarJavaDocCharPrefix = 'BracketStart Prefix  (*';
  pdCaptionInLineJavaDocCharPrefix = 'Inline Prefix  //';
  pdCaptionCurlyJavaDocCharPrefix = 'Curly Prefix {';
  pdCaptionHideEmptyOutputBlock = 'Hide empty block from report';
  pdCaptionOutputFilteringCategory = 'Output Filtering Category';
  pdCaptionFilesIncludeList = 'Included Files list';
  pdCaptionFilesExcludeList = 'Excluded Files list';
  pdCaptionAllowHtmlInDescription = 'Allow Html in Description';
  pdCaptionPropertyCommentFromAssessors = 'Get (undocumented) method comments from assessors';
  pdCaptionDisplayHiddenItems = 'Display hidden items (defined in implementation only)';
  pdCaptionMethodCommentFromAncestor = 'Get overriden method comment from ancestor';
  pdCaptionCssConfiguration = 'Css Configuration';
  pdCaptionCssCustomFile = 'Custom CSS file';

  // Caption for Custom Category
  ccApplicationOptions = 'Application options';
  ccInputOptions  = 'Input options';
  ccOutputOptions = 'Output options';
  ccJavaDocSupportOptions = 'JavaDoc support options';
  ccJavaDocPrefixOptions = 'JavaDoc Prefix (only one character)';
  ccFilesList = 'Files and folders list';
  ccCommentRules = 'Comment Rules';

  oeTextNoError      = 'No error';
  oeTextUpgraded     = 'Project upgraded';
  oeTextUnknown      = 'Unknown error';
  oeTextIDStartNOK   = 'Starting ID doesn''t match with this application';
  oeTextIDEndNOK     = 'Ending ID doesn''t match with this application';
  oeTextTechLevelNOK = 'The file is not compatible with this application revision';

  L_InsertProjectTitle = 'Insert your project''s title here';
  L_InsertAuthorName = 'Insert author''s name here';
  L_Project1 = 'Project1';
  L_EnterProjectSummary = 'Enter your project''s summary in a single line';
  L_EnterProjectDescription = 'Enter your project''s multilines description';


const
  /// List of Applications properties
  C_APPLICATION_PROPERTYS_DESCRIPTION: array[1..2] of TPropertyDescription =
    ((iName: pdNameBoolsAsChecks; iCaption: pdCaptionBoolsAsChecks; iReadOnly: False)
    , (iName: pdNameLaunchBrowser; iCaption: pdCaptionLaunchBrowser; iReadOnly: False)
    );

  /// list of Input properties
  C_INPUT_PROPERTYS_DESCRIPTION: array[1..9] of TPropertyDescription =
    ((iName: pdNameName; iCaption: pdCaptionName; iReadOnly: False)
    , (iName: pdNameSummary; iCaption: pdCaptionSummary; iReadOnly: False)
    , (iName: pdNameDescription; iCaption: pdCaptionDescription; iReadOnly: False)
    , (iName: pdNameAuthor; iCaption: pdCaptionAuthor; iReadOnly: False)
    //, (iName: pdNameHTMLLink; iCaption: pdCaptionHTMLLink; iReadOnly: False)
    , (iName: pdNameCopyright; iCaption: pdCaptionCopyright; iReadOnly: False)
    //, (iName: pdNameRootDirectory; iCaption: pdCaptionRootDirectory; iReadOnly: True)
    , (iName: pdNameRecurseDirectory; iCaption: pdCaptionRecurseDirectory;
    iReadOnly: False)
    , (iName: pdNameConditionalDefines; iCaption: pdCaptionConditionalDefines;iReadOnly: False)
    , (iName: pdNameParseImplementationSection;
    iCaption: pdCaptionParseImplementationSection; iReadOnly: True)
    , (iName: pdNameAllowHtmlInDescription; iCaption: pdCaptionAllowHtmlInDescription;
      iReadOnly: False)
    );

  /// List of Output properties
  C_OUTPUT_PROPERTYS_DESCRIPTION: array[1..13] of TPropertyDescription =
    ( //(iName: pdNameCustomHeader; iCaption: pdCaptionCustomHeader; iReadOnly: True)
      //, (iName: pdNameCustomFooter; iCaption: pdCaptionCustomFooter; iReadOnly: True)
    (iName: pdNameLanguage; iCaption: pdCaptionLanguage; iReadOnly: True)
    , (iName: pdNameOutputFormat; iCaption: pdCaptionOutputFormat; iReadOnly: False)
    , (iName: pdNameOutputFolder; iCaption: pdCaptionOutputFolder; iReadOnly: False)
    , (iName: pdNameVisibilitySet; iCaption: pdCaptionVisibilitySet; iReadOnly: False)
    , (iName: pdNameTagCommentSet; iCaption: pdCaptionTagCommentSet; iReadOnly: True)
    , (iName: pdNameSortAlpha; iCaption: psCaptionSortAlpha; iReadOnly: False)
    , (iName: pdNameWarnEmptyTAG; iCaption: psCaptionWarnEmptyTAG; iReadOnly: False)
    , (iName: pdNameHideEmptyTAGSection; iCaption: pdCaptionHideEmptyTAGSection;iReadOnly: False)
    , (iName: pdNameHideEmptyOutputBlock; iCaption: pdCaptionHideEmptyOutputBlock;iReadOnly: False)
    , (iName: pdNameOutputFilteringCategory; iCaption: pdCaptionOutputFilteringCategory;iReadOnly: False)
    , (iName: pdNameDisplayHiddenItems; iCaption: pdCaptionDisplayHiddenItems;iReadOnly: False)
    , (iName: pdNameCssConfiguration; iCaption: pdCaptionCssConfiguration;iReadOnly: False)
    , (iName: pdNameCssCustomFile; iCaption: pdCaptionCssCustomFile;iReadOnly: False)
    );

  /// List of JavaDoc properties
  C_JAVADOC_SUPPORT_PROPERTYS_DESCRIPTION: array[1..2] of TPropertyDescription =
    ((iName: pdNameSkipFirstTAGLine; iCaption: pdCaptionSkipFirstTAGLine;
    iReadOnly: False)
    , (iName: pdNameSkipLastTAGLine; iCaption: pdCaptionSkipLastTAGLine; iReadOnly: False)
    );

  /// List of javaDoc prefix properties
  C_JAVADOC_PREFIX_PROPERTYS_DESCRIPTION: array[1..3] of TPropertyDescription =
    ((iName: pdNameBracketStarJavaDocCharPrefix;
    iCaption: pdCaptionBracketStarJavaDocCharPrefix; iReadOnly: False)
    , (iName: pdNameInLineJavaDocCharPrefix; iCaption: pdCaptionInLineJavaDocCharPrefix;
    iReadOnly: False)
    , (iName: pdNameCurlyJavaDocCharPrefix; iCaption: pdCaptionCurlyJavaDocCharPrefix;
    iReadOnly: False)
    );

  /// List of file list properties
  C_FILES_LIST_PROPERTYS_DESCRIPTION: array[1..2] of TPropertyDescription =
    ((iName: pdNameFilesIncludeList; iCaption: pdCaptionFilesIncludeList;
    iReadOnly: False)
    , (iName: pdNameFilesExcludeList; iCaption: pdCaptionFilesExcludeList; iReadOnly: False)
    );

  /// List of comment rules properties
  C_COMMENT_RULES: array[1..2] of TPropertyDescription =
    ((iName: pdNamePropertyCommentFromAssessors; iCaption: pdCaptionPropertyCommentFromAssessors;
    iReadOnly: False)
    ,(iName: pdNameMethodCommentFromAncestor; iCaption: pdCaptionMethodCommentFromAncestor;
    iReadOnly: False)
    );

{*------------------------------------------------------------------------------
  Technical level of saved project's file is the compatibility level of fiels.
  When adding informations to the project file, the TL change to reflect
  an incompatibility

  TL01 : First release
  TL02 : Added description, changed summary from TStringList to string
  TL03 : Added FilesIncludeList and FileExcludeList, Deleted RootDirectory
  TL04 : Changed format from raw binary component stream to XML format
  TL05 : Added ocRecords and ocUnits in TOutputCategoryList enum
------------------------------------------------------------------------------*}
  C_OPTIONS_TECHNICAL_LEVEL: integer = $05;

  /// Error code return by some functions
  RWOptionsErrorStrings: array [TRWOptionsError] of string =
    (oeTextNoError, oeTextUpgraded, oeTextUnknown, oeTextIDStartNOK
     , oeTextIDEndNOK, oeTextTechLevelNOK);

  {gnugettext: scan-all text-domain='DCTD_ignore' }
  /// STARTING ID in the project file
  C_OPTIONS_IDENTIFICATION_START: string = 'DelphiCodeToDoc Options START';
  /// ENDING ID in the project file
  C_OPTIONS_IDENTIFICATION_END: string   = 'DelphiCodeToDoc Options END';
{gnugettext: reset }

implementation

uses JvAppStorage, JvAppXMLStorage, JclStrings, JclFileUtils; //Forms; // for Application variable

{*------------------------------------------------------------------------------
  Creates a TDOCOptions reference
  @param ApplicationPath path of the currently executing application
------------------------------------------------------------------------------*}
constructor TDOCOptions.Create(ApplicationPath : TFileName);
begin
  inherited Create;
  FDescription := TStringList.Create;
  FConditionalDefines := TStringList.Create;
  FFilesIncludeList := TStringList.Create;
  FFilesExcludeList := TStringList.Create;
  FApplicationPath := ApplicationPath;
end;

/// Destroy a TDOCOption reference
destructor TDOCOptions.Destroy;
begin
  FreeAndNil(FFilesIncludeList);
  FreeAndNil(FFilesExcludeList);
  FreeAndNil(FConditionalDefines);
  FreeAndNil(FDescription);
  inherited;
end;

/// Fix options that may have a spurious content
procedure TDOCOptions.FixOptions;
begin
  // Fix space at the beginning or end of lines for files
  TrimStrings(FFilesIncludeList, True);
  TrimStrings(FFilesExcludeList, True);
end;

{*------------------------------------------------------------------------------
  Get the folder from absolute or relative path
  @return Absolute path with the ending separator
------------------------------------------------------------------------------*}
function TDOCOptions.GetEffectiveOutputFolder: string;
begin
  Result := OutputFolder;
  if not PathIsAbsolute(Result) then
    Result := PathCanonicalize(PathAddSeparator(FProjectFolder) + Result);
  Result := PathAddSeparator(Result);
end;

function TDOCOptions.IsValidCustomCssFile(out AbsoluteCssFile : TFilename): Boolean;
var
  tmpCssCustomFile : TFilename;
begin
  Result := False;
  AbsoluteCssFile := '';
  if(FCssConfiguration = ccCustom) then
  begin
    if(not PathIsAbsolute(FCssCustomFile)) then
    begin
      tmpCssCustomFile := PathCanonicalize(PathAddSeparator(GetCurrentDir) + FCssCustomFile);
    end else tmpCssCustomFile := FCssCustomFile;

    if FileExists(tmpCssCustomFile) then
    begin
      AbsoluteCssFile := tmpCssCustomFile;
      Result := True;
    end;
  end;
end;

/// Set all options to a default value
procedure TDOCOptions.SetDefaultValue;
begin
  FTitle     := L_InsertProjectTitle;
  FHTMLlink  := 'http://dephicodetodoc.sf.net (Replace by your webpage for example)';
  FCopyright := 'Add your copyright informations and link here.';
  FAuthor    := L_InsertAuthorName;
  FName      := L_Project1;
  FCustomFooter := 'UNDER CONSTRUCTION';
  FOutputFolder := FApplicationPath+'out\';
  FCustomHeader := 'UNDER CONSTRUCTION';
  FLanguage  := lEnglish;
  FOutputFormat := ofCHM;//ofCHM;
  FConditionalDefines.Add('MSWINDOWS');
  FConditionalDefines.Add('WIN32');
  FConditionalDefines.Add('DELPHI5_UP');
  FSummary   := L_EnterProjectSummary;
  FDescription.Add(L_EnterProjectDescription);
  FAlphaSort     := True;
  FTagCommentSet := [tcInline, tcJavaDoc];
  FVisibilitySet := [mvPrivate, mvProtected, mvPublic, mvPublished, mvAutomated];
  FBoolsAsChecks := True;
  FRecurseDirectory := True;
  FLaunchBrowser := True;
  FWarnEmptyTAG  := True;
  FHideEmptyTAGSection := False;
  FSkipFirstTAGLine := True;
  FSkipLastTAGLine := True;
  FParseImplementationSection := True;
  FInLineJavaDocCharPrefix := '/';
  FCurlyJavaDocCharPrefix := '*';
  FBracketStarJavaDocCharPrefix := '*';
  FHideEmptyOutputBlock:= True;
  FOutputFilteringCategory := [ocUnits, ocConstants, ocTypes, ocVariables
   , ocFunctions, ocRecords, ocClasses, ocFields, ocMethods, ocProperties, ocEvents];
  FAllowHtmlInDescription := false;
  FPropertyCommentFromAssessors := True;
  FDisplayHiddenItems := True;
  FMethodCommentFromAncestor := True;
  FCssConfiguration := ccInternal;
  FCssCustomFile := '';
end;

{*------------------------------------------------------------------------------
  Create application storage and setup (FACTORY)
  @param fn Name of the application file storage
  @return A newly created TJvAppXMLFileStorage object
------------------------------------------------------------------------------*}
function CreateApplicationStorage(fn : TFileName) : TJvAppXMLFileStorage;
begin
  // Init XML option storage
  Result := TJvAppXMLFileStorage.Create(nil);
  Result.AutoFlush := FALSE;
  Result.AutoReload := FALSE;
  Result.Location := flCustom;
  Result.FileName := fn;
  Result.StorageOptions.AutoEncodeValue := TRUE;
  Result.StorageOptions.EnumerationAsString := TRUE;
  Result.StorageOptions.BooleanAsString := TRUE;
  Result.StorageOptions.BooleanStringTrueValues := 'TRUE';
  Result.StorageOptions.BooleanStringFalseValues := 'FALSE';
  Result.RootNodeName := 'DelphiCodeToDoc_Project';
end;


{*------------------------------------------------------------------------------
  Load Project's Options from a stream
  The startup of the Stream is first verified, then read.
  @param Stream TStream of Project's options.
  @return TRWOptionsError error code.
------------------------------------------------------------------------------*}
function TDOCOptions.LoadFromFile(Filename : TFilename): TRWOptionsError;
var
  JvAppXMLFileStorage : TJvAppXMLFileStorage;
  Read_TL : integer;
  IsProjectUpgraded : Boolean;
begin
  IsProjectUpgraded := False;
  // Update JvAppXMLFileStorage with XML file
  JvAppXMLFileStorage := CreateApplicationStorage(Filename);
  JvAppXMLFileStorage.ReadOnly := TRUE;
  JvAppXMLFileStorage.Reload;

  // Check Technical Level
  Result := oeTechLevelNOK;
  Read_TL := JvAppXMLFileStorage.ReadInteger('TechnicalLevel');
  if Read_TL<>C_OPTIONS_TECHNICAL_LEVEL then
  begin
    // Manage old tech level
    // From TL04, previous file were not XML !
    // From TL05, add ocUnits and ocRecords to the project
    if(Read_TL = 4) then
    begin
      IsProjectUpgraded := True;
    end
    else exit; // Exit on error in Tech level not handles
  end;

  // Check the ClassName (START ID)
  Result := oeIDStartNOK;
  if JvAppXMLFileStorage.ReadString('ClassName')<>Self.ClassName then
  begin
    exit;
  end;

  // Load TDOCOptions properties from XML storage
  JvAppXMLFileStorage.ReadPersistent(self.ClassName,self);
  FreeAndNil(JvAppXMLFileStorage);
  FProjectFolder := ExtractFilePath(FileName);
  Result := oeNoError;
  // Fix TL
  if(IsProjectUpgraded) then
  begin
    if(Read_TL = 4) then
    begin
      FOutputFilteringCategory := FOutputFilteringCategory + [ocRecords, ocUnits];
    end;
    // Signal project was upgraded
    Result := oeNoErrorButUpgraded;
  end;
  // Fix options
  FixOptions;
end;

{*------------------------------------------------------------------------------
  Save Project's Options to a stream
  Identification strings are written to string, and all options in raw mode.
  @param Stream TStream destination of Project's options
  @return TRWOptionsError error code.
------------------------------------------------------------------------------*}
function TDOCOptions.SaveToFile(Filename : TFilename): TRWOptionsError;
var
  JvAppXMLFileStorage : TJvAppXMLFileStorage;
begin
  //Result := oeUnknown;
  // Init XML option storage
  JvAppXMLFileStorage := CreateApplicationStorage(Filename);
  // Save infos
  JvAppXMLFileStorage.WriteInteger('TechnicalLevel',C_OPTIONS_TECHNICAL_LEVEL);
  JvAppXMLFileStorage.WriteString('ClassName',TDOCOptions.ClassName);
  // Save TDOCOptions properties to XML storage
  JvAppXMLFileStorage.WritePersistent(self.ClassName,self);
  JvAppXMLFileStorage.Flush;
  FreeAndNil(JvAppXMLFileStorage);
  Result := oeNoError;
end;

end.
