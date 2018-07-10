{*------------------------------------------------------------------------------
  Base visitor for generators
  It mainly adds access to Next and previous visited item
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
-------------------------------------------------------------------------------}
unit uDocGeneratorVisitor;

interface

uses
  Windows, SysUtils, Classes, Contnrs,
  uDocBaseVisitor, uDocTemplate, uDocStructure;

type

  {*----------------------------------------------------------------------------
    Visit and Build documentation for this DocTemplate
    @param DocTemplate   Item to document
  -----------------------------------------------------------------------------}
  TVisitingCallback = procedure(const DocTemplate : TDOCTemplate) of object;

  /// Base visitor linked to a generator
  TDOCGeneratorVisitor = class(TDOCBaseVisitor)
  private
    FDocStructure : TDOCStructure; /// Structure of the project to visit
    FPreviousItem: TDOCTemplate; /// Previously visited item
    FNextItem: TDOCTemplate; /// Next visited item
    FCurrentItem : TDOCTemplate; /// Current item to visit
    PreviousItemStack : TObjectQueue; /// Queue for previous items
    CurrentItemListStack : TObjectQueue; /// Queue for current items
    FVisitingCallback : TVisitingCallback; /// Visit callback from DocGenerator
  protected
    procedure AfterFullVisit;override;
    procedure BeforeFullVisit;override;
    procedure DoVisit(const DocTemplate : TDOCTemplate; const DocListOwner : TDOCTemplateList);override;
    procedure DoVisit(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate);override;
    procedure BeforeVisit(const DocTemplate : TDOCTemplate);override;
    procedure BeforeVisit(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate);override;
    procedure AfterVisit(const DocTemplate : TDOCTemplate);override;
    procedure AfterVisit(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate);override;
    function IsVisitEnabled(const DocTemplate : TDOCTemplate) : Boolean; override;
    function IsVisitEnabled(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate) : Boolean; override;
    property DocStructure : TDOCStructure read FDocStructure;
    function FindNextItem(const DocTemplate : TDOCTemplate; const DocListOwner : TDOCTemplateList) : TDOCTemplate;
  public
    property VisitingCallback : TVisitingCallback read FVisitingCallback write FVisitingCallback;
    constructor Create(const DocStructure : TDOCStructure); reintroduce; virtual;
    destructor Destroy;override;
    function VerifyCondition(out ErrorMessage: string): boolean; virtual;
    property PreviousItem : TDOCTemplate read FPreviousItem;
    property NextItem : TDOCTemplate read FNextItem;
  end;

  /// Class of TDOCGeneratorVisitor
  TDOCGeneratorVisitorClass = class of TDOCGeneratorVisitor;

implementation

uses
  ComCtrls,
  uDocUnit, uDocMember;

{ TDOCVisitor }

procedure TDOCGeneratorVisitor.AfterFullVisit;
begin
  //Build ClassHierarchy View by forcing its visit !
  // Use DoVisit instead of public Visit to prevent recursive BeforeFullVisit call
  FVisitDocTemplate(FDocStructure.ClassTree, nil);
  inherited;
end;

procedure TDOCGeneratorVisitor.AfterVisit(const DocTemplate: TDOCTemplate);
begin
  inherited;
  // Copy Current to previous item
  FPreviousItem := DocTemplate;
end;

procedure TDOCGeneratorVisitor.AfterVisit(
  const DocTemplateList: TDOCTemplateList; const DocOwnerList: TDOCTemplate);
begin
  inherited;
  // Save - Reset any previous / next
  FPreviousItem := PreviousItemStack.Pop() as TDOCTemplate;
  FNextItem := nil;
  FCurrentItem := DocOwnerList;
end;

procedure TDOCGeneratorVisitor.BeforeFullVisit;
begin
  inherited;
  assert(assigned(FDocStructure));
  assert(assigned(DocOptions));
end;

procedure TDOCGeneratorVisitor.BeforeVisit(const DocTemplate: TDOCTemplate);
begin
  inherited;
  // Search Next item
  FNextItem := nil; // Fix it
  FCurrentItem := DocTemplate;
end;

procedure TDOCGeneratorVisitor.BeforeVisit(
  const DocTemplateList: TDOCTemplateList; const DocOwnerList: TDOCTemplate);
begin
  // Save - Reset any previous / next
  // Push Previous item
  PreviousItemStack.Push(FPreviousItem);
  // Push DocTemplate owner (current item)
  FPreviousItem := nil;
  FNextItem := nil;
  //
  inherited;

end;

{*------------------------------------------------------------------------------
  Create a new TDOCGeneratorVisitor instance linked with the structure
  @param DocStructure   Structure linked to generator visitor
------------------------------------------------------------------------------*}
constructor TDOCGeneratorVisitor.Create(const DocStructure : TDOCStructure);
begin
  inherited Create(DocStructure.DOCOptions);
  FDeepFirst := False;
  FDocStructure := DocStructure;
  FPreviousItem := nil;
  FNextItem := nil;
  PreviousItemStack := TObjectQueue.Create;
  CurrentItemListStack := TObjectQueue.Create;
end;

/// Destroy a previously created TDOCGeneratorVisitor instance
destructor TDOCGeneratorVisitor.Destroy;
begin
  FDocStructure := nil;
  assert(PreviousItemStack.Count = 0);
  FreeAndNil(PreviousItemStack);
  assert(CurrentItemListStack.Count = 0);
  FreeAndNil(CurrentItemListStack);
  inherited;
end;

procedure TDOCGeneratorVisitor.DoVisit(const DocTemplateList: TDOCTemplateList;
 const DocOwnerList : TDOCTemplate);
begin
  // Implement by descendant
end;

{*------------------------------------------------------------------------------
  Search the next item that will be visited (visit enabled)
  @param DocTemplate   Item currently visited
  @param DocListOwner   Owner of the current item
  @return Next item if exists, NIL otherwise
------------------------------------------------------------------------------*}
function TDOCGeneratorVisitor.FindNextItem(const DocTemplate: TDOCTemplate;
  const DocListOwner: TDOCTemplateList): TDOCTemplate;
var
  NextDocTemplate : TDOCTemplate;
begin
  Result:=nil;
  if not assigned(DocListOwner) then exit;  
  NextDocTemplate := DocListOwner.NextItem(DocTemplate);
  while (NextDocTemplate <> nil) and (Result = nil) do
  begin
    if EvaluateItemDisplay(NextDocTemplate) then Result := NextDocTemplate
    else NextDocTemplate := DocListOwner.NextItem(NextDocTemplate);
  end;
end;

procedure TDOCGeneratorVisitor.DoVisit(const DocTemplate: TDOCTemplate; const DocListOwner : TDOCTemplateList);
begin
  // Compute next link
  FNextItem := FindNextItem(DocTemplate, DocListOwner);
  // Implement by descendant
  VisitingCallback(DocTemplate);
end;

{*------------------------------------------------------------------------------
  Verify initial conditions before building the project
  @param    ErrorMessage  string with error message if any
  @return   TRUE if confition OK, FALSE otherwise, see ErrorMessage string
-------------------------------------------------------------------------------}
function TDOCGeneratorVisitor.VerifyCondition(out ErrorMessage: string): boolean;
begin
  Result:=true;
  ErrorMessage:='';
end;

function TDOCGeneratorVisitor.IsVisitEnabled(const DocTemplate: TDOCTemplate): Boolean;
begin
  Result := inherited IsVisitEnabled(DocTemplate);
  if(Result = True) then
  begin
    Result := EvaluateItemDisplay(DocTemplate);
  end;
end;

function TDOCGeneratorVisitor.IsVisitEnabled(const DocTemplateList: TDOCTemplateList;
  const DocOwnerList: TDOCTemplate): Boolean;
begin
  Result := inherited IsVisitEnabled(DocTemplateList, DocOwnerList);
  // Filter on list and not just on object. ie A Class should not visit Fields, etc ...
end;

end.
