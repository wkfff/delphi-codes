{*------------------------------------------------------------------------------
  Inheritance fix visitor for TDOCTemplate class
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
-------------------------------------------------------------------------------}
unit uDocInheritanceFixVisitor;

interface

uses
  Windows, SysUtils, Classes, Contnrs,
  uDocBaseVisitor, uDocTemplate, uDocClassTree, uDocClass, uDocMethod, uOptions;

type
  /// Visitor that fix inheritance for function description
  TDOCInheritanceFixVisitor = class(TDOCBaseVisitor)
  private
    FInheritedCommentsAdded : integer; /// Number of items commented (from inheritance)
    FDocClassTree : TDOCClassesTree; /// Global Class Tree
  protected
    procedure DoVisit(const DocTemplate : TDOCTemplate; const DocListOwner : TDOCTemplateList);override;
    procedure DoVisit(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate);override;
    procedure BeforeFullVisit;override;
    procedure BeforeVisit(const DocTemplate : TDOCTemplate);override;
    procedure BeforeVisit(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate);override;
    procedure AfterVisit(const DocTemplate : TDOCTemplate);override;
    procedure AfterVisit(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate);override;
    function RecurseSearch(const DocMethod : TDOCMethod; const MethodsClass : TDOCClass) : TDOCTemplate;
  public
    property InheritedCommentsAdded : integer read FInheritedCommentsAdded;
    constructor Create(const DocOptions : TDOCOptions);override;
    destructor Destroy;override;
    procedure SetDocClassTreeReference(const ClassTree : TDOCClassesTree);
  end;

implementation

uses
  ComCtrls,
  uTagComment;

{ TDOCVisitor }

procedure TDOCInheritanceFixVisitor.AfterVisit(const DocTemplate: TDOCTemplate);
begin
end;

procedure TDOCInheritanceFixVisitor.AfterVisit(
  const DocTemplateList: TDOCTemplateList; const DocOwnerList: TDOCTemplate);
begin

end;

procedure TDOCInheritanceFixVisitor.BeforeFullVisit;
begin
  // This Visitor is not a Deep first !
  FDeepFirst := False;
end;

procedure TDOCInheritanceFixVisitor.BeforeVisit(const DocTemplate: TDOCTemplate);
begin
end;

procedure TDOCInheritanceFixVisitor.BeforeVisit(
  const DocTemplateList: TDOCTemplateList; const DocOwnerList: TDOCTemplate);
begin
end;

constructor TDOCInheritanceFixVisitor.Create(const DocOptions : TDOCOptions);
begin
  inherited;
  FInheritedCommentsAdded := 0;
end;

destructor TDOCInheritanceFixVisitor.Destroy;
begin
  inherited;
end;

procedure TDOCInheritanceFixVisitor.DoVisit(const DocTemplateList: TDOCTemplateList;
 const DocOwnerList : TDOCTemplate);
begin
  // Nothing
end;

{*------------------------------------------------------------------------------
  Set the Class tree reference for further use
  @param ClassTree   Class tree to get
------------------------------------------------------------------------------*}
procedure TDOCInheritanceFixVisitor.SetDocClassTreeReference(
  const ClassTree: TDOCClassesTree);
begin
  FDocClassTree := ClassTree;
end;

procedure TDOCInheritanceFixVisitor.DoVisit(const DocTemplate: TDOCTemplate; const DocListOwner : TDOCTemplateList);
var
  DocMethod : TDOCMethod;
  MethodsClass : TDOCClass;
begin
  // Process only Methods attached to Class
  if((DocTemplate is TDOCMethod) and (DocTemplate.RelatedParent is TDOCClass)) then
  begin
    DocMethod := DocTemplate as TDOCMethod;
    // Is the description comment empty ?
    if(DocMethod.TAGHolderList.ExistContentByDocTag(dtDescriptionTAG) = False) then
    begin
      // Description empty, try to find the same method in ancestor class ?
      // Only one level deep !!!! Add multilevel !
      // Get class
      MethodsClass := DocMethod.RelatedParent as TDOCClass;
      RecurseSearch(DocMethod, MethodsClass);
    end;
  end;
end;

{*------------------------------------------------------------------------------
  Search in ancestor class an overridden method with a complete description
  @param DocMethod   Method to search
  @param MethodsClass   Class of this method
  @return Overridden method with non-empty description
------------------------------------------------------------------------------*}
function TDOCInheritanceFixVisitor.RecurseSearch(const DocMethod : TDOCMethod; const MethodsClass : TDOCClass) : TDOCTemplate;
var
  IndexInheritedClass : integer;
  InheritedClass : TDOCClass;
  InheritedMethod : TDOCMethod;
begin
  Result := nil;
  for IndexInheritedClass := 0 to MethodsClass.ClassHierarchyList.Count - 1 do
  begin
    // Get InheritedClass
    InheritedClass := FDocClassTree.FindClassByName(MethodsClass.ClassHierarchyList[IndexInheritedClass]);
    // Check really found
    if(assigned(InheritedClass)) then
    begin
      // Does this class have a method with same name and same Overload ID ?
      InheritedMethod := (InheritedClass.MethodList as TDOCMethodList).FindItemById(DocMethod.OverloadID) as TDOCMethod;
      if(assigned(InheritedMethod)) then
      begin
        // An inherited method is found ! good !
        // Is there a description comment associated ?
        if(InheritedMethod.TAGHolderList.ExistContentByDocTag(dtDescriptionTAG) = True) then
        begin
          Result := InheritedMethod;
          // Copy comments from inherited
          DocMethod.CopyCommentsFrom(InheritedMethod);
          // Increase statistics
          inc(FInheritedCommentsAdded);
          // exit ! This is not very nice, but it will be refactored next time !
          exit;
        end;
      end;
      // Not found in this class previous class
      Result := RecurseSearch(DocMethod, InheritedClass);
      if assigned(Result) then exit;
    end;
  end;
end;


end.
