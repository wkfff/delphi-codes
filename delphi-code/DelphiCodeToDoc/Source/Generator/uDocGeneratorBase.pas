{*------------------------------------------------------------------------------
  Base document generator
  Write your own generator based on TDOCGeneratorBase

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2006/12/01   TridenT   Initial revision
-------------------------------------------------------------------------------}
unit uDocGeneratorBase;

interface

uses
  SysUtils, Classes,
  uDocGeneratorVisitor, uDocTemplate, uDocClassTree, uDocMember, Tokens,
  uDocMethod, uOptions, uDocStructure;

type
  {*----------------------------------------------------------------------------
    Evaluate if the visit of this DocTemplate is enabled
    @param DocItem   Item to evaluate visit
    @return TRUE is visit is enabled for this item
  -----------------------------------------------------------------------------}
  TEvaluateItemDisplay = function(const DocItem: TDOCTemplate): Boolean of object;


  /// Base class for all document generators
  TDOCGeneratorBase = class
  private
    FDocStructure : TDOCStructure; /// Structure of the project
    FGeneratorVisitor : TDOCGeneratorVisitor; /// Visitor used to access all items in the structure
    FDOCOptions : TDOCOptions; /// Options of the project
    FMessageStrings: TStrings; /// Messages for the user interface
    FEvaluateItemDisplay : TEvaluateItemDisplay;
    function GetPrevious: TDOCTemplate;
    function GetNext: TDOCTemplate;
  protected
    property EvaluateItemDisplay : TEvaluateItemDisplay read FEvaluateItemDisplay;
    property PreviousItem : TDOCTemplate read GetPrevious;
    property NextItem : TDOCTemplate read GetNext;
    property DOCOptions : TDOCOptions read FDOCOptions;
    property DocStructure : TDOCStructure read FDocStructure;
    procedure SendStatusMessage(const stMessage: string);
    procedure DoVisit(const DocTemplate: TDOCTemplate); virtual;
    procedure BuildFolders; virtual;
    procedure CreateVisitor(const VisitorClass : TDOCGeneratorVisitorClass);
  public
    property MessageStrings: TStrings Read FMessageStrings Write FMessageStrings;
    function VerifyCondition(out ErrorMessage: string): boolean;
    function GetOutputFile : TFileName; virtual;
    constructor Create(const DocStructure : TDOCStructure); virtual; // reintroduce
    destructor Destroy; override;
    procedure Execute; virtual;
  end;

implementation

uses
  JvGnuGettext, Forms, // for Application.ProcessMessage
  uDocUnit;

resourcestring
  rsGeneratingUnit = 'Generating Unit : %s';

var
  /// translation for the rsGeneratingUnit string
  TranslatedGeneratingUnit : string;

/// Build folders needed for this generator
procedure TDOCGeneratorBase.BuildFolders;
begin
  // Empty
end;

{*------------------------------------------------------------------------------
  Create a new TDOCGeneratorBase instance
  @param DocStructure   Structure of the project
------------------------------------------------------------------------------*}
constructor TDOCGeneratorBase.Create(const DocStructure: TDOCStructure);
begin
  FDocStructure := DocStructure;
  FDOCOptions := DocStructure.DOCOptions;
end;

{*------------------------------------------------------------------------------
  Create (Class Factory) and link a new visitor for this generator
  @param VisitorClass   Class of the visitor
------------------------------------------------------------------------------*}
procedure TDOCGeneratorBase.CreateVisitor(
  const VisitorClass: TDOCGeneratorVisitorClass);
begin
  FGeneratorVisitor := VisitorClass.Create(DocStructure);
  FGeneratorVisitor.VisitingCallback := self.DoVisit;
  FEvaluateItemDisplay := FGeneratorVisitor.EvaluateItemDisplay;
end;

/// destroy a previsouly created TDOCGeneratorBase instance
destructor TDOCGeneratorBase.Destroy;
begin
  FreeAndNil(FGeneratorVisitor);
end;

{*------------------------------------------------------------------------------
  Visit and Build documentation for this DocTemplate
  @param DocTemplate   Item to document
------------------------------------------------------------------------------*}
procedure TDOCGeneratorBase.DoVisit(const DocTemplate: TDOCTemplate);
begin
  // notify generatio, of unit
  if(DocTemplate is TDOCUnit) then
  begin
    // notify a Unit building - Use pre-translated string
    SendStatusMessage(Format(TranslatedGeneratingUnit, [DocTemplate.Name]));
  end;
end;

/// Execute the generator (build the document)
procedure TDOCGeneratorBase.Execute;
begin
  // Intialize (BeforeFullVisit)
  BuildFolders();
  // be sure to be in application language
  JvGnuGettext.UseLanguage(DocOptions.ApplicationLanguage);
  // Translate and store few strings
  TranslatedGeneratingUnit := rsGeneratingUnit;
  // Go to Generator language
  JvGnuGettext.UseLanguage(DocOptions.GeneratorLanguage);
  // Visit
  FGeneratorVisitor.Visit(FDOCStructure);
  // finalize (AfterFullVisit)
  // Back in Application language
  JvGnuGettext.UseLanguage(DocOptions.ApplicationLanguage);
end;

{*------------------------------------------------------------------------------
  Get Next visited item
  @return Next visited item
------------------------------------------------------------------------------*}
function TDOCGeneratorBase.GetNext: TDOCTemplate;
begin
  Result := FGeneratorVisitor.NextItem;
end;

{*------------------------------------------------------------------------------
  Get the main output file of the final documentation
  @return Filename of the main documentation entry point
------------------------------------------------------------------------------*}
function TDOCGeneratorBase.GetOutputFile: TFileName;
begin
  // Empty
end;

{*------------------------------------------------------------------------------
  Get previously visited item
  @return Previously visited item
------------------------------------------------------------------------------*}
function TDOCGeneratorBase.GetPrevious: TDOCTemplate;
begin
  Result := FGeneratorVisitor.PreviousItem;
end;

{*------------------------------------------------------------------------------
  Verify if all conditions met to build the documentation
  @param ErrorMessage   string to display if an error is detected
  @return TRUE if all conditions OK  
------------------------------------------------------------------------------*}
function TDOCGeneratorBase.VerifyCondition(out ErrorMessage: string): boolean;
begin
  Result := True;
end;

{*------------------------------------------------------------------------------
  Send a message reflecting the status of the operations in progress
  @param    stMessage  string to display
-------------------------------------------------------------------------------}
procedure TDOCGeneratorBase.SendStatusMessage(const stMessage: string);
begin
  if assigned(FMessageStrings) then
  begin
    FMessageStrings.Add(stMessage);
    // Notify main application (not very nice!)
    Application.ProcessMessages;
  end;
end;

end.
