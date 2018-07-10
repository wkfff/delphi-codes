{*------------------------------------------------------------------------------
  Base visitor for TDOCTemplate class
  A visitor will scan the structure tree for all TDOCTemplate including lists,
   a will apply rules for each node found.
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
-------------------------------------------------------------------------------}
unit uDocBaseVisitor;

interface

uses
  Windows, SysUtils, Classes, Contnrs,
  uDocTemplate, uOptions;

type

  /// Base visitor to scan structure
  TDOCBaseVisitor = class
  private
    FDocOptions : TDOCOptions; /// Options of the project
    FPreviousItem : TDOCTemplate; /// Previously visited item
    FNextItem : TDOCTemplate; /// Next visited item
    procedure FVisitAllNestedList(const DocTemplate: TDOCTemplate);
    procedure FVisitDocTemplateList(const DocTemplateList : TDocTemplateList;
     const DocOwnerList : TDOCTemplate);
  protected
    FDeepFirst : boolean; /// Scan deeply first into lists or process item first
    property PreviousItem : TDOCTemplate read FPreviousItem;
    property NextItem : TDOCTemplate read FNextItem;
    property DocOptions : TDOCOptions read FDocOptions;
    procedure FVisitDocTemplate(const DocTemplate : TDOCTemplate; const DocListOwner : TDOCTemplateList);
    procedure AfterFullVisit;virtual;
    procedure BeforeFullVisit;virtual;
    procedure DoVisit(const DocTemplate : TDOCTemplate;
     const DocListOwner : TDOCTemplateList);overload;virtual;
    procedure DoVisit(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate);overload;virtual;
    procedure BeforeVisit(const DocTemplate : TDOCTemplate);overload;virtual;
    procedure BeforeVisit(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate);overload;virtual;
    procedure AfterVisit(const DocTemplate : TDOCTemplate);overload;virtual;
    procedure AfterVisit(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate);overload;virtual;
    function IsVisitEnabled(const DocTemplate : TDOCTemplate) : Boolean; overload; virtual;
    function IsVisitEnabled(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate) : Boolean; overload; virtual;
  public
    constructor Create(const DocOptions : TDOCOptions);virtual;
    destructor Destroy;override;
    procedure Visit(const DocTemplate: TDOCTemplate);overload;
    procedure Visit(const DocTemplateList: TDOCTemplateList;
     const DocOwnerList : TDOCTemplate);overload;
    function EvaluateItemDisplay(const DocItem: TDOCTemplate): Boolean;
  end;

implementation

uses
  uDocMember;

/// Thing to do after a full visit (generally some finalizations)
procedure TDOCBaseVisitor.AfterFullVisit;
begin
  // Empty
end;

{*------------------------------------------------------------------------------
  Things to do after the visit of a DocTemplate
  @param DocTemplate Item that was last visited
-------------------------------------------------------------------------------}
procedure TDOCBaseVisitor.AfterVisit(const DocTemplate: TDOCTemplate);
begin
  // Empty
end;

{*------------------------------------------------------------------------------
  Things to do after the visit of a DocTemplateList
  @param DocTemplateList List that was last visited
-------------------------------------------------------------------------------}
procedure TDOCBaseVisitor.AfterVisit(const DocTemplateList: TDOCTemplateList;
  const DocOwnerList: TDOCTemplate);
begin
  // Empty
end;

/// Thing to do before a full visit (generally some initializations)
procedure TDOCBaseVisitor.BeforeFullVisit;
begin
  // Empty
end;

{*------------------------------------------------------------------------------
  Things to do before the visit of a DocTemplate
  @param DocTemplate Item that will be next visited
-------------------------------------------------------------------------------}
procedure TDOCBaseVisitor.BeforeVisit(const DocTemplate: TDOCTemplate);
begin
  // Empty
end;

{*------------------------------------------------------------------------------
  Things to do before the visit of a DocTemplateList
  @param DocTemplateList List that will be next visited
-------------------------------------------------------------------------------}
procedure TDOCBaseVisitor.BeforeVisit(const DocTemplateList: TDOCTemplateList;
  const DocOwnerList: TDOCTemplate);
begin
  // Empty
end;

/// Create a TDOCBaseVisitor instance
constructor TDOCBaseVisitor.Create(const DocOptions : TDOCOptions);
begin
  FDocOptions := DOCOptions;
  FDeepFirst := False;
  FPreviousItem := nil;
  FNextItem := nil;
end;

/// Destroy a previously created TDOCBaseVisitor instance
destructor TDOCBaseVisitor.Destroy;
begin
  inherited;
end;

{*------------------------------------------------------------------------------
  Do the real visit for this item. This should be written by descendant
  @param DocTemplate   The item to mtry to visit
  @param DocListOwner   Owner list for this item
------------------------------------------------------------------------------*}
procedure TDOCBaseVisitor.DoVisit(const DocTemplate: TDOCTemplate;
  const DocListOwner: TDOCTemplateList);
begin
  // Empty - Implemented by descendant
end;

{*------------------------------------------------------------------------------
  Do the real visit for this list. This should be written by descendant
  @param DocTemplateList   List to try to visit
  @param DocOwnerList   Owner for this list
------------------------------------------------------------------------------*}
procedure TDOCBaseVisitor.DoVisit(const DocTemplateList: TDOCTemplateList;
  const DocOwnerList: TDOCTemplate);
begin
  // Empty - Implemented by descendant
end;

{*------------------------------------------------------------------------------
  Start a visit from a DocTemplate
  @param DocTemplate Start point of the visit
-------------------------------------------------------------------------------}
procedure TDOCBaseVisitor.Visit(const DocTemplate: TDOCTemplate);
begin
  BeforeFullVisit;
  FVisitDocTemplate(DocTemplate, nil);
  AfterFullVisit;
end;

{*------------------------------------------------------------------------------
  Start a visit from a DocTemplateList
  @param DocTemplateList Start point of the visit
-------------------------------------------------------------------------------}
procedure TDOCBaseVisitor.Visit(const DocTemplateList: TDOCTemplateList;
 const DocOwnerList : TDOCTemplate);
begin
  BeforeFullVisit;
  FVisitDocTemplateList(DocTemplateList, DocOwnerList);
  AfterFullVisit;
end;

{*------------------------------------------------------------------------------
  Try to visit the DocTemplate if the visit is enabled for this item.
  It will also call BeforeVisit (before) and AfterVisit (after) function
  and also the DoVisit
  @param DocTemplate   The item to mtry to visit
  @param DocListOwner   Owner list for this item
------------------------------------------------------------------------------*}
procedure TDOCBaseVisitor.FVisitDocTemplate(const DocTemplate: TDOCTemplate; const DocListOwner : TDOCTemplateList);
begin
  assert(assigned(DocTemplate));
  // Is visit autorized for this item ?
  if(IsVisitEnabled(DocTemplate)) then
  begin
    BeforeVisit(DocTemplate);
    // Visit nested before
    if(FDeepFirst = True) then FVisitAllNestedList(DocTemplate);
    // Visit the Template
    DoVisit(DocTemplate, DocListOwner);
    // And then nested
    if(FDeepFirst = False) then FVisitAllNestedList(DocTemplate);
    AfterVisit(DocTemplate);
  end;
end;

{*------------------------------------------------------------------------------
  Try to visit the DocTemplateList if the visit is enabled for this item.
  It will also call BeforeVisit (before) and AfterVisit (after) function
  and also the DoVisit
  @param DocTemplateList   List to try to visit
  @param DocOwnerList   Owner for this list
------------------------------------------------------------------------------*}
procedure TDOCBaseVisitor.FVisitDocTemplateList(const DocTemplateList: TDocTemplateList;
 const DocOwnerList : TDOCTemplate);
var
  DocTemplateIndex : integer;
begin
  // Is visit autoprized for this item ?
  if(IsVisitEnabled(DocTemplateList, DocOwnerList)) then
  begin
    BeforeVisit(DocTemplateList, DocOwnerList);
    if(FDeepFirst = False) then DoVisit(DocTemplateList, DocOwnerList);
    // Apply visitor for all items
    for DocTemplateIndex := 0 to DocTemplateList.Count - 1 do
    begin
      FVisitDocTemplate(DocTemplateList.Items[DocTemplateIndex], DocTemplateList);
    end;
    if(FDeepFirst = True) then DoVisit(DocTemplateList, DocOwnerList);
    AfterVisit(DocTemplateList, DocOwnerList);
  end;

end;

{*------------------------------------------------------------------------------
  Test if visit is enabled for this item
  @param DocTemplate   DocTemplate to test if visit is enabled
  @return TRUE if visit is enabled for this item
------------------------------------------------------------------------------*}
function TDOCBaseVisitor.IsVisitEnabled(const DocTemplate: TDOCTemplate): Boolean;
begin
  Result := True;
end;

{*------------------------------------------------------------------------------
  Test if visit is enabled for this item
  @param DocTemplateList   List to test if visit is enabled
  @param DocOwnerList    Owner for this list
  @return TRUE if visit is enabled for this item
------------------------------------------------------------------------------*}
function TDOCBaseVisitor.IsVisitEnabled(const DocTemplateList: TDOCTemplateList;
  const DocOwnerList: TDOCTemplate): Boolean;
begin
  Result := True;
end;

{*------------------------------------------------------------------------------
  Visit nested TDOCTemplateList list this item
  @param DocTemplate   Item holding lists to visit
------------------------------------------------------------------------------*}
procedure TDOCBaseVisitor.FVisitAllNestedList(const DocTemplate: TDOCTemplate);
var
  DocTemplateListIndex : integer;
begin
  // Get each list
  for DocTemplateListIndex := 0 to DocTemplate.TemplateListList.Count - 1 do
  begin
    // Visit each list
    FVisitDocTemplateList(DocTemplate.TemplateListList.Items[DocTemplateListIndex] as TDOCTemplateList,
     DocTemplate);
  end;
end;

{*------------------------------------------------------------------------------
  Evaluate if the visit of this DocTemplate is enabled
  @param DocItem   Item to evaluate visit
  @return TRUE is visit is enabled for this item
------------------------------------------------------------------------------*}
function TDOCBaseVisitor.EvaluateItemDisplay(const DocItem: TDOCTemplate): Boolean;
begin
  Result := (DocItem.CategoryType in DocOptions.OutputFilteringCategory)
   and not (not FDocOptions.DisplayHiddenItems and DocItem.Hidden);
  if DocItem is TDocMember then
  begin
    // Filter member by visibility option
    Result := Result and ((DocItem as TDocMember).MemberVisibility in FDocOptions.VisibilitySet);
  end;
end;

end.
