{*------------------------------------------------------------------------------
  Create the structure of source code component from the result of the Parser
  All tools used by the Builder are in this unit.
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   v0.0     Initial revision
-------------------------------------------------------------------------------}

unit uDocStructure;

interface

uses Windows, SysUtils, Classes, Contnrs, ComCtrls
  ,uOptions,
  uDocTemplate, uDocProgram, uDocClassTree;

type
  /// Error result for the application
  TDOCError      = integer;

  /// Specialized TDOCTemplate class for the whole structure itself
  TDOCStructure = class(TDOCTemplate)
  private
    FUnits: TDOCUnitList;      /// List of all units in the structure
    FDOCOptions: TDOCOptions; /// All Options. Beware! Shared Component.
    FProgram: TDOCProgram;    /// Program (DPR file) associate with structure (also a unit)
    FClassTree : TDOCClassesTree; /// All classes in a tree
    procedure UpdateAllTagCoverage;
    procedure ConvertToTreeNode(const tnList: TTreeNodes);
    procedure FixInheritance;
    procedure FixFunctionTypeComment;
    procedure FixSelfTag;
  public
    property UnitList: TDOCUnitList read FUnits write FUnits;
    property DOCOptions: TDOCOptions Read FDOCOptions Write FDOCOptions;
    property ClassTree: TDOCClassesTree Read FClassTree Write FClassTree;
    constructor Create(const st: string; const rp: TDocTemplate); override;
    destructor Destroy; override;
    procedure SetProgram(const DocProgram:TDOCProgram);
    function GetProgram: TDOCTemplate;
    procedure ConvertAllToTreeNode(const tnNodes : TTreeNodes);
    procedure SortContent;
    procedure Clear;
    function GetTemplateName : string; override;
    procedure FillTagDetail(const ADocTemplate : TDOCTemplate; const ATextEdit : TObject);
    procedure ConsolidateProject;
    function CategoryType: TOutputCategoryList; override;
  end;



implementation

uses
  JclStrings,JclMath, JclFileUtils, StrUtils, JclSysUtils, JvRichEdit, Graphics,
  uDocUnit, uDocToNodesVisitor, uDocTagCoverageVisitor, uDocSortVisitor,
  uDocTagCoverage, uDocInheritanceFixVisitor, uDocFunctionTypeCommentFixVisitor,
  ParseTreeNodeType, uTAGComment;

{*------------------------------------------------------------------------------
  Link the Program (Delphi DPR) to the structure.
  @param  DocProgram TDOCProgram to link to the current structure
-------------------------------------------------------------------------------}
procedure TDOCStructure.SetProgram(const DocProgram:TDOCProgram);
begin
  if assigned(FProgram) then raise Exception.Create('Program already exists')
  else
  begin
    FProgram := DocProgram;
  end;
end;

{*------------------------------------------------------------------------------
  Return the linked Program (Delphi DPR)
  @return TDOCProgram linked to the current structure
-------------------------------------------------------------------------------}
function TDOCStructure.GetProgram: TDOCTemplate;
begin
  result:=FProgram;
end;

function TDOCStructure.GetTemplateName: string;
begin
  Result := 'Project Structure';
end;


function TDOCStructure.CategoryType: TOutputCategoryList;
begin
  Result:=ocUnits; // Same value as units
end;

/// Clear all units from the structure
procedure TDOCStructure.Clear;
begin
  FUnits.Clear;
  ClassTree.Clear;
  // FProgram was freed before as unit !
  FProgram := nil;
end;

/// Link all data and finalize process
procedure TDOCStructure.ConsolidateProject;
begin
  ClassTree.LinkOrphanedChilds();
  FixInheritance();
  FixFunctionTypeComment();
  FixSelfTag();
  UpdateAllTagCoverage();
end;

{*------------------------------------------------------------------------------
  Converts the structure into a treenode
  The structure has units, which hold classes, which hold fields and methods
   and events and propertys ... So, it can be represented has a treenode.
  The TreeNode wil be cleared before filling.
  @param      tnList An initiazied TreeNode
-------------------------------------------------------------------------------}
procedure TDOCStructure.ConvertAllToTreeNode(const tnNodes: TTreeNodes);
var
  DocVisitor : TDOCToNodesVisitor;
begin
  //
  tnNodes.Clear;
  DocVisitor := TDOCToNodesVisitor.Create(FDOCOptions);
  try
    DocVisitor.SetTreeNodes(tnNodes);
    DocVisitor.Visit(Self);
  finally
    FreeAndNil(DocVisitor);
  end;
end;

{*------------------------------------------------------------------------------
  Convert whole structure to a treenode
  @param tnList   Treenode to fill
------------------------------------------------------------------------------*}
procedure TDOCStructure.ConvertToTreeNode(const tnList: TTreeNodes);
var
  tnRoot, tnUnit, tnClass: TTreeNode;
  IndexUnit, IndexClass: integer;
  tmpClass, tmpUnit: TDOCTemplate;
begin
  Assert(tnList <> nil);
  // Clear the List
  tnList.Clear;
  // Add Root project
  tnRoot := tnList.Add(nil, Name);
  // Add Units
  for IndexUnit := 0 to FUnits.Count - 1 do
  begin
    tmpUnit     := UnitList[IndexUnit];
    tnUnit      := tnList.AddChild(tnRoot, tmpUnit.Name);
    tnUnit.Data := tmpUnit;
    for IndexClass := 0 to (tmpUnit as TDOCUnit).ClassList.Count - 1 do
    begin
      tmpClass     := (tmpUnit as TDOCUnit).ClassList.Items[IndexClass];
      tnClass      := tnList.AddChild(tnUnit, tmpClass.Name);
      tnClass.Data := tmpClass;
    end;
  end;
end;


{*------------------------------------------------------------------------------
  Call Create to instantiate a TDOCStructure object at runtime.
  Create allocates memory, and then initializes its properties.
  Generally, there is only one reference per application.
  @param  st  Name of the new Strcutre (mainly its identifier)
  @param  rp  Related logical parent and owner, generally a null value !
-------------------------------------------------------------------------------}
constructor TDOCStructure.Create(const st: string; const rp: TDocTemplate);
begin
  inherited;
  Name := 'Project1';
  FUnits := CreateDocTemplateList(TDOCUnitList);
  FProgram:=nil;
  // No parent to Class hierarchy
  FClassTree := TDOCClassesTree.Create('_ClassHierarchy',nil);
end;

///  Destroys of an instance of a TDOCStructure object and free its content
destructor TDOCStructure.Destroy;
begin
  FreeAndNil(FUnits);
  FreeAndNil(FClassTree);
  inherited;
end;

{*------------------------------------------------------------------------------
  Fill a RichEdit with details about Tags
  @param ADocTemplate  Selected TDOCTemplate item to extract statistics from
  @param ATextEdit     RichEdit where statistics will be written
------------------------------------------------------------------------------*}
procedure TDOCStructure.FillTagDetail(const ADocTemplate : TDOCTemplate; const ATextEdit : TObject);
const
  ST_TAGS_STATISTICS : string = '  Checked [%d],  Documented [%d],  Missing [%d]' + NativeLineBreak;
  ST_TAG_DETAIL : string = 'TAG [%s] : %s' + NativeLineBreak;
  ST_TAG_VERIFY_RESULT : array [False..True] of string = ('Missing','Documented');
var
  JvRichEdit : TJvRichEdit;
  CheckedTagItem : TCheckedTagItem;
  Stats : TTagCoverageItem;
  IndexCheckedTag : Integer;
  TagCaption : string;
  //CurrentFont : TFont;
  CurrentColor : TColor;
begin
  if ATextEdit is TJvRichEdit then
  begin
    JvRichEdit := ATextEdit as TJvRichEdit;
    JvRichEdit.Clear;
    // Add Template name and name of selected item
    JvRichEdit.AddFormatText(ADocTemplate.GetTemplateName + ' : ' + ADocTemplate.Name
     + NativeLineBreak, [fsBold]);
    // Display Total statistics
    JvRichEdit.AddFormatText('Total TAGs:',[fsUnderline]);
    Stats := ADocTemplate.TagCoverageHolder.TotalStats;
    JvRichEdit.AddFormatText(Format(ST_TAGS_STATISTICS,[Stats.EvaluatedCount,
     Stats.DocumentedCount, Stats.EvaluatedCount - Stats.DocumentedCount]),[]);
    // Display Childs statistics
    JvRichEdit.AddFormatText('Childs TAGs:',[fsUnderline]);
    Stats := ADocTemplate.TagCoverageHolder.ChildsStats;
    JvRichEdit.AddFormatText(Format(ST_TAGS_STATISTICS,[Stats.EvaluatedCount,
     Stats.DocumentedCount, Stats.EvaluatedCount - Stats.DocumentedCount]),[]);
    // Display its TAG statistics
    Stats := ADocTemplate.TagCoverageHolder.SelfStats;
    JvRichEdit.AddFormatText('Self TAGs:',[fsUnderline]);
    JvRichEdit.AddFormatText(Format(ST_TAGS_STATISTICS,[Stats.EvaluatedCount,
     Stats.DocumentedCount, Stats.EvaluatedCount - Stats.DocumentedCount]),[]);
    // Display each tag with result
    for IndexCheckedTag := 0 to ADocTemplate.TagCoverageHolder.CheckedTagList.Count - 1 do
    begin
      CheckedTagItem := ADocTemplate.TagCoverageHolder.CheckedTagList.Items[IndexCheckedTag] as TCheckedTagItem;
      TagCaption := TAGPatternList.FindItemByDocTag(CheckedTagItem.DocTag).SourceCode;
      if(CheckedTagItem.subID <> '') then
       TagCaption := TagCaption + ' ' + CheckedTagItem.subID;
      if(CheckedTagItem.bIsDocumented = False) then CurrentColor := clRed
       else CurrentColor := clBlue;
      JvRichEdit.AddFormatText(Format(ST_TAG_DETAIL,[TagCaption,
        ST_TAG_VERIFY_RESULT[CheckedTagItem.bIsDocumented]]),[], '',CurrentColor,0);
    end;
  end;
end;

/// Fix comments for function type, can be execute only at end of parse process
procedure TDOCStructure.FixFunctionTypeComment;
var
  DocVisitor : TDOCFunctionTypeCommentFixVisitor;
begin
  //
  DocVisitor := TDOCFunctionTypeCommentFixVisitor.Create(FDocOptions);
  try
    DocVisitor.Visit(Self);
  finally
    FreeAndNil(DocVisitor);
  end;
end;

/// Fix inheritance by filling items with ancestor comments
procedure TDOCStructure.FixInheritance;
var
  DocVisitor : TDOCInheritanceFixVisitor;
  InheritedFound : boolean;
begin
  // Line below not needed (compiler says it!)
  // InheritedFound := False;
  repeat
    DocVisitor := TDOCInheritanceFixVisitor.Create(FDocOptions);
    DocVisitor.SetDocClassTreeReference(ClassTree);
    try
      DocVisitor.Visit(Self);
      InheritedFound := (DocVisitor.InheritedCommentsAdded > 0);
    finally
      FreeAndNil(DocVisitor);
    end;
  until (InheritedFound = False);
end;

/// Convert some DocOptions to structure TAG
procedure TDOCStructure.FixSelfTag;
var
  IndexLine : integer;
begin
  // Clear any previous tag for self
  TAGHolderList.Clear;
  // Clear any tag coverage statistics
  TagCoverageHolder.Clear;
  // Add summary
  TAGHolderList.AddTAG(FDOCOptions.Summary, nTAGDescription, '');
  // Add description
  for IndexLine := 0 to FDOCOptions.Description.Count - 1 do
  begin
    TAGHolderList.AddTAG(FDOCOptions.Description[IndexLine], nTAGDescription, '');
  end;
  // Add Author
  TAGHolderList.AddTAG(FDOCOptions.Author, nTAGAuthor, '');
end;

/// Sort all DocTemplate element of lists in alphabetical order
procedure TDOCStructure.SortContent;
var
  DocSortVisitor : TDOCSortVisitor;
begin
  DocSortVisitor := TDOCSortVisitor.Create(FDocOptions);
  try
    DocSortVisitor.Visit(self);
  finally
    FreeAndNil(DocSortVisitor);
  end;
end;

/// Update Tag coverage for all item in structure
procedure TDOCStructure.UpdateAllTagCoverage;
var
  DocVisitor : TDOCTagCoverageVisitor;
begin
  //
  DocVisitor := TDOCTagCoverageVisitor.Create(FDocOptions);
  try
    DocVisitor.Visit(Self);
  finally
    FreeAndNil(DocVisitor);
  end;
end;

end.
