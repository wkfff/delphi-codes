{*-------------------------------------------------------------------------------
  Visit comment structure
  The core of the builder. It takes data from the parser, and build comments,
  and TAG comments

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   v0.0     Initial revision
-------------------------------------------------------------------------------}
 

unit VisitComment;

interface

uses BaseVisitor, uDocStructure, Classes, ParseTreeNode,
  ParseTreeNodeType, Tokens, uDocTemplate, uDocClass, uDocUnit, uDocMethod,
  uDocFunction;


type
  /// Comments TAG visitor
  TVInterfaceComment = class(TBaseTreeNodeVisitor)
  private
    FCurrentUnit:     TDOCUnit;
    FCurrentMethod:   TDOCMethod;
    FCurrentFunction: TDOCFunction;
    FLastTaggedNode:  TParseTreeNode;
    mDebug: string; /// Debug message
    procedure GetTAG(const tagNode: TObject);
    function ExtractSubID(const tagNode: TObject): string;
    function GetUnitTemplate(const TaggedNode: TParseTreeNode): TDOCTemplate;
    function GetProcedureTemplate(const TaggedNode: TParseTreeNode): TDOCTemplate;
    function GetIdentifierTemplate(const TaggedNode: TParseTreeNode): TDOCTemplate;
    function GetPropertyTemplate(const TaggedNode: TParseTreeNode): TDOCTemplate;
    procedure ExtractTAG(const etNode: TObject; const DocTemplate: TDOCTemplate;
      const SubID: string = '');
    procedure GetClassType(const ctNode: TObject);
    procedure GetInterfaceType(const ctNode: TObject);
    procedure GetVarDecl(const ctNode: TObject);
    procedure GetConstDecl(const ctNode: TObject);
    procedure GetTypeDecl(const ctNode: TObject);
    procedure GetProcedureDecl(const ctNode: TObject);
    procedure GetPropertyDecl(const ctNode: TObject);
    function GetUpperClass(const ctNode: TObject): TDOCClass;
    procedure ScanClassForProperties(const DocClass:TDOCClass);
    function BuildMethodIdString(const mNode : TParseTreeNode; const mName : string) : string;
  protected
  public
    constructor Create; override;
    procedure PreVisitParseTreeNode(const pcNode: TObject); override;
    procedure PostVisitParseTreeNode(const pcNode: TObject); override;
    function VisitSourceToken(const pcNode: TObject): Boolean; override;
    function FinalSummary(out psMessage: string): boolean; override;
    function IsIncludedInSettings: boolean; override;
    procedure AfterFullVisit; override;
    procedure FixPropertiesEmptyComment(const ClassList : TDOCClassList);
  end;

implementation

uses
  { delphi }
  SysUtils,
  JclStrings,
  { JCF  }
  SourceToken, TokenUtils, uTAGComment, Dialogs,
  uDocProject, uDocProperty, uDocType;

{ TVInterfaceStructure }

function TVInterfaceComment.FinalSummary(out psMessage: string): boolean;
begin
  //
  psMessage := mDebug;
  Result    := True;
end;

function TVInterfaceComment.IsIncludedInSettings: boolean;
begin
  Result := True;
end;

procedure TVInterfaceComment.PreVisitParseTreeNode(const pcNode: TObject);
var
  lcNode: TParseTreeNode;
  tmpNode : TParseTreeNode;
begin
  lcNode := TParseTreeNode(pcNode);
 // Var + Block + ProcedureDecl => var inside a procedure, ignore !
 if(lcNode.HasParentNode(nVarSection) = True) then
 begin
   tmpNode := lcNode.GetParentNode(nVarSection);
   if(tmpNode.HasParentNode(nBlock) = True) then
   begin
      tmpNode := tmpNode.GetParentNode(nBlock);
      if(tmpNode.Parent.NodeType in  ProcedureNodes) then exit;
   end;
 end;

  if lcNode.NodeType = nUnitName then
  begin
    FCurrentUnit := DocProject.GetStructure.UnitList.FindItemByName(
     GetSingleIdentifier(lcNode)) as TDOCUnit
  end;
  if (lcNode.NodeType = nClassType) or (lcNode.NodeType = nRecordType) then
   GetClassType(lcNode);
  if lcNode.NodeType = nInterfaceType then GetInterfaceType(lcNode);
  if lcNode.NodeType = nVarDecl then GetVarDecl(lcNode);
  if lcNode.NodeType = nConstDecl then GetConstDecl(lcNode);
  if lcNode.NodeType = nTypeDecl then GetTypeDecl(lcNode);
  if lcNode.NodeType in ProcedureHeadings then GetProcedureDecl(lcNode);
  if lcNode.NodeType = nProperty then GetPropertyDecl(lcNode);
  if lcNode.NodeType in TAGNodes then GetTAG(lcNode);
end;

procedure TVInterfaceComment.GetTAG(const tagNode: TObject);
var
  lcNode:      TParseTreeNode;
  TaggedNode:  TParseTreeNode;
  DocTemplate: TDOCTemplate;
  tmpSubID:    string;
begin
  lcNode := TParseTreeNode(tagNode);
  Assert(lcNode.HasParentNode(
    [nCurlyBlock, nBracketStarBlock, nInlineComment, nEndOfLineComment]));

  // Get CurlyBlock or Inline parent's Node
  // Warning : Inline can exist AFTER the parent (same line)
  if lcNode.HasParentNode([nCurlyBlock, nBracketStarBlock, nInlineComment]) then
  begin
    TaggedNode := lcNode.GetParentNode([nCurlyBlock, nBracketStarBlock, nInlineComment]).Parent;
    // Hanlde case where comments are  just after a procedure heading
    if(TaggedNode.NodeType in ProcedureNodes) then
     //if(TaggedNode.HasChildNode(ProcedureHeadings)) then
      TaggedNode := TaggedNode.GetImmediateChild(ProcedureHeadings);
  end
  else
   if lcNode.HasParentNode([nEndOfLineComment]) then TaggedNode := FLastTaggedNode
    else TaggedNode := nil;

  // Special case : nInlineComment + AdditionnalComment + InsideCpdtStmt
  if lcNode.HasParentNode(nInlineComment) then
   if lcNode.NodeType=nTAGAdditionalComment then
    if lcNode.HasParentNode(nCompoundStatement) then
     if lcNode.HasParentNode(ProcedureNodes) then
      TaggedNode := lcNode.GetParentNode(ProcedureNodes).GetImmediateChild(ProcedureHeadings);

  if not assigned(TaggedNode) then
  begin
    mDebug := mDebug + Format('Null tagged node [%s]', [lcNode.Describe]) + NativeLineBreak;
    exit;
  end;
  //Options for Curly and BracketStar Block only
  if lcNode.HasParentNode([nCurlyBlock, nBracketStarBlock]) then
  begin
    // Verify if it is First or last TAG comment of the Curly block
    assert(lcNode.PriorLeafNode is TSourceToken);
    assert(lcNode.NextLeafNode is TSourceToken);
    // Verify if FirstTAG must be skipped
    if DocProject.DocOptions.SkipFirstTAGLine then
     if IsBlockComment(TSourceToken(lcNode.PriorLeafNode)) then exit;
    // Verify if LastTAG must be skip
    if DocProject.DocOptions.SkipLastTAGLine then
      if IsBlockComment(TSourceToken(lcNode.NextLeafNode)) then exit;
  end;

  case TaggedNode.NodeType of
    nUnitHeader: DOCTemplate := GetUnitTemplate(TaggedNode);
    nFunctionHeading: DOCTemplate := GetProcedureTemplate(TaggedNode);
    nConstructorHeading: DOCTemplate := GetProcedureTemplate(TaggedNode);
    nDestructorHeading: DOCTemplate := GetProcedureTemplate(TaggedNode);
    nProcedureHeading: DOCTemplate := GetProcedureTemplate(TaggedNode);
    nIdentifier: DOCTemplate := GetIdentifierTemplate(TaggedNode);
    nProperty: DOCTemplate:= GetPropertyTemplate(TaggedNode);
    else
    begin
      DocTemplate:=nil;
    end;
  end;

  if assigned(DocTemplate) then
  begin
    tmpSubID := ExtractSubID(tagNode);
    ExtractTAG(tagNode, DocTemplate, tmpSubID);
  end
  else
  begin
    assert(assigned(TaggedNode));
    mDebug := mDebug + Format('Null Tagged DocTemplate [%s]', [TaggedNode.Describe]) + NativeLineBreak;
  end;

end;

// Source Tokens are only LEAF !
function TVInterfaceComment.VisitSourceToken(const pcNode: TObject): Boolean;
begin
  result:=false;
end;

function TVInterfaceComment.BuildMethodIdString(
  const mNode: TParseTreeNode; const mName : string): string;
var
  MethodIdentification : string;
  FormalParamNode : TParseTreeNode;
  FormalParamsNode : TParseTreeNode;
  IndexFormalParam : integer;
  tmpIdentList: TStringList;
  IndexIdent: integer;
  ParamType : string;
  TotalParamCount : integer;
begin
  TotalParamCount := 0;
  // Get method name
  MethodIdentification := mName + '(';
  // Add parameters Insert (const, var ?)
  if(mNode.HasChildNode(nFormalParams) = True) then
  begin
    FormalParamsNode := mNode.GetImmediateChild(nFormalParams);
    for IndexFormalParam := 0 to FormalParamsNode.ChildNodeCount() - 1 do
    begin
      FormalParamNode := FormalParamsNode.ChildNodes[IndexFormalParam];
      if(FormalParamNode.NodeType = nFormalParam) then
      begin
        tmpIdentList := TStringList.Create;
        assert(FormalParamNode.HasChildNode(nIdentList));
        GetIdentList(FormalParamNode.GetImmediateChild(nIdentList), tmpIdentList);
        // Verify if Parameter have a type
        if FormalParamNode.HasChildNode(nType) then
        begin
          ParamType := GetSingleIdentifier(FormalParamNode.GetImmediateChild(nType));
        end
        else  // Mark as untyped
        begin
          ParamType := 'Untyped'
        end;
        for IndexIdent := 0 to tmpIdentList.Count - 1 do
        begin
          // Add parameter name
          if(TotalParamCount > 0) then MethodIdentification := MethodIdentification + ';';
          MethodIdentification := MethodIdentification + tmpIdentList[IndexIdent];
          MethodIdentification := MethodIdentification + ':' + ParamType;
          Inc(TotalParamCount);
        end;
        FreeAndNil(tmpIdentList);
      end;
    end;
  end;
  MethodIdentification := MethodIdentification + ')';
  // Finally, upcase string
  Result := UpperCase(MethodIdentification);
end;

constructor TVInterfaceComment.Create;
begin
  inherited;
  HasPreVisit := True;
  HasPostVisit := False;
  HasSourceTokenVisit := False;
  mDebug := '';
  // Initialize internal variables
  FCurrentUnit := nil;
  FCurrentMethod := nil;
  FCurrentFunction := nil;
  FLastTaggedNode := nil;
end;

procedure TVInterfaceComment.PostVisitParseTreeNode(const pcNode: TObject);
begin
  //
end;

function TVInterfaceComment.GetUnitTemplate(
  const TaggedNode: TParseTreeNode): TDOCTemplate;
begin
  Result := DocProject.GetStructure.UnitList.FindItemByName(GetSingleIdentifier(TaggedNode.GetImmediateChild(nUnitName)));
end;

procedure TVInterfaceComment.ExtractTAG(const etNode: TObject;
  const DocTemplate: TDOCTemplate; const SubID: string = '');
var
  lcNode: TParseTreeNode;
begin
  lcNode := TParseTreeNode(etNode);
  DocTemplate.TAGHolderList.AddTAG(TSourceToken(lcNode.FirstLeaf).SourceCode
    , lcNode.NodeType, SubID);
end;

function TVInterfaceComment.GetProcedureTemplate(
  const TaggedNode: TParseTreeNode): TDOCTemplate;
var
  IdentifierNode, ClassNode: TParseTreeNode;
  CurrentClass : TDOCClass;
  DottedNameToIgnore : string;
  ProcOverloadId : WORD;
  MethodListToSearch : TDOCMethodList;
  MethodName : string;
begin
  // Autorize Interface parse
  assert(FCurrentUnit <> nil);
  // Get Identifier
  Assert(TaggedNode.HasChildNode(nIdentifier));
  // WARNING! Simple function (not member) have no identifier node!
  IdentifierNode := TaggedNode.GetImmediateChild(nIdentifier).FirstSolidLeaf;
  if (TSourceToken(IdentifierNode.NextLeafNode).SourceCode = '.')
   or (TaggedNode.HasParentNode(ObjectTypes)) then

  begin
    if not TaggedNode.HasParentNode(ObjectTypes) then
    begin
      DottedNameToIgnore := '';
      ClassNode := nil;
      while(TSourceToken(IdentifierNode.NextLeafNode).SourceCode = '.') do
      begin
        if ClassNode <>nil then
        begin
          DottedNameToIgnore:= DottedNameToIgnore + TSourceToken(ClassNode).SourceCode + ' . ';
        end;
        ClassNode := IdentifierNode;
        IdentifierNode := ClassNode.NextLeafNode.NextLeafNode;
      end;
      // WARNING! Class can be defined ONLY in IMPLEMENTATION SECTION, so
      // no reference will be find in Class list (from Interface)
      CurrentClass := FCurrentUnit.FlatClassList.FindItemByName(TSourceToken(ClassNode).SourceCode) as TDOCClass;
      
    end
    else // Only test if Class is already found
    begin
      // Method is describe in Class definition type. Try to Find class
      CurrentClass := GetUpperClass(TaggedNode);
    end;

    if assigned(CurrentClass) then
    begin
      // New Method detection with Overload support
      // Search parameters and its type
      MethodListToSearch := CurrentClass.MethodList as TDOCMethodList;
    end
    else MethodListToSearch := nil;
  end
  else // so it's a simple function, not method
  begin
      // New function detection with Overload support
      MethodListToSearch := FCurrentUnit.FunctionList as TDOCMethodList;
  end;
  MethodName := TSourceToken(IdentifierNode).SourceCode;
  ProcOverloadId := TDOCMethod.ComputeOverloadID(BuildMethodIdString(TaggedNode, MethodName));
  if(assigned(MethodListToSearch)) then
   Result := MethodListToSearch.FindItemById(ProcOverloadId)
  else Result := nil;
end;

function TVInterfaceComment.GetPropertyTemplate(
  const TaggedNode: TParseTreeNode): TDOCTemplate;
var
  IdentifierNode: TParseTreeNode;
  CurrentClass: TDOCClass;
begin
  IdentifierNode := TaggedNode.GetImmediateChild(nIdentifier).FirstSolidLeaf;
  CurrentClass := GetUpperClass(TaggedNode);
  assert(assigned(CurrentClass));
  result:= CurrentClass.PropertyList.FindItemByName(TSourceToken(IdentifierNode).SourceCode)
end;



function TVInterfaceComment.GetIdentifierTemplate(
  const TaggedNode: TParseTreeNode): TDOCTemplate;

  // Test if TaggedNode is Member
  function tnIsMember(const TaggedNode: TParseTreeNode): boolean;
  begin
    Result := TaggedNode.HasParentNode(nClassDeclarations);
  end;

  // Test if TaggedNode is Class (or Interface)
  function tnIsClass(const tn: TParseTreeNode): boolean;
  begin
    Result := False;
    if tn.HasParentNode(nTypeDecl) then
    begin
      if (tn.GetParentNode(nTypeDecl).HasChildNode(nClassType)) or
        (tn.GetParentNode(nTypeDecl).HasChildNode(nInterfaceType)) or
        (tn.GetParentNode(nTypeDecl).HasChildNode(nRecordType)) then
      begin
        Result := True
      end
    end;
  end;

  // Test if TaggedNode is Constant
  function tnIsConstant(const tn: TParseTreeNode): boolean;
  begin
    Result := tn.HasParentNode(nConstDecl);
  end;

  // Test if TaggedNode is Variable
  function tnIsVariable(const tn: TParseTreeNode): boolean;
  begin
    Result := tn.HasParentNode(nVarDecl);
  end;

  // Test if TaggedNode is Type
  function tnIsType(const tn: TParseTreeNode): boolean;
  begin
    Result := False;
    if tn.HasParentNode(nTypeDecl) then
    begin
      if tn.GetParentNode(nTypeDecl).HasChildNode(nType) then
      begin
        Result := True
      end
    end;
  end;

  // Test if TaggedNode is FunctionType
  function tnIsFunctionType(const tn: TParseTreeNode): boolean;
  begin
    Result := False;
    if tn.HasParentNode(nTypeDecl) then
    begin
      if tn.GetParentNode(nTypeDecl).HasChildNode(nProcedureType) then
      begin
        Result := True
      end
    end;
  end;

  // Test if TaggedNode is Property
  function tnIsProperty(const tn: TParseTreeNode): boolean;
  begin
    Result := tn.HasParentNode(nProperty);
  end;
var
  IdentifierNode: TParseTreeNode;
  CurrentClass: TDOCClass;
begin
  Result := nil;
  IdentifierNode := TaggedNode.FirstSolidLeaf;
  // Assume it can only be a CLASS definition
  // But it can be another type !

  // Test if Member
  if tnIsMember(TaggedNode) then
  begin
    CurrentClass := GetUpperClass(TaggedNode);
    // #TridenT# Redundant
    if assigned(CurrentClass) then
    begin
     Result := CurrentClass.FieldList.FindItemByName(TSourceToken(IdentifierNode).SourceCode);
     if Result=nil then Result := CurrentClass.PropertyList.FindItemByName(TSourceToken(IdentifierNode).SourceCode);
     if Result=nil then Result := CurrentClass.MethodList.FindItemByName(TSourceToken(IdentifierNode).SourceCode);
     if Result=nil then Result := CurrentClass.EventList.FindItemByName(TSourceToken(IdentifierNode).SourceCode);
     if Result=nil then Result := CurrentClass.VarList.FindItemByName(TSourceToken(IdentifierNode).SourceCode);
     if Result=nil then Result := CurrentClass.ConstantList.FindItemByName(TSourceToken(IdentifierNode).SourceCode);
     if Result=nil then Result := FCurrentUnit.FlatClassList.FindItemByName(TSourceToken(IdentifierNode).SourceCode) as TDOCClass;
    end;
  end
  else  // test if Class
  begin
    if tnIsClass(TaggedNode) then
    begin
      Result := FCurrentUnit.FlatClassList.FindItemByName(TSourceToken(IdentifierNode).SourceCode) as TDOCClass;
    end
    else  // Test if constant
    begin
      if tnIsConstant(TaggedNode) then
      begin
        Result := FCurrentUnit.ConstantList.FindItemByName(TSourceToken(IdentifierNode).SourceCode)
      end
      else  // Test if Variable
      begin
        if tnIsVariable(TaggedNode) then
        begin
          Result := FCurrentUnit.VarList.FindItemByName(TSourceToken(IdentifierNode).SourceCode)
        end
        else  // Test if Type
        begin
          if tnIsType(TaggedNode) then
          begin
            Result := FCurrentUnit.TypeList.FindItemByName(TSourceToken(IdentifierNode).SourceCode);
            if(tnIsFunctionType(TaggedNode)) then
             Result := (Result as TDOCFunctionType).DocFunction;
          end
          {else
          begin
            if tnIsProperty(TaggedNode) then
            begin
              Result := CurrentUnit.FindType(TSourceToken(IdentifierNode).SourceCode)
            end
          end}
        end
      end
    end
  end
end;

procedure TVInterfaceComment.GetClassType(const ctNode: TObject);
var
  lcNode: TParseTreeNode;
  lcIntermediateNode : TParseTreeNode;
  ClassName: string;
begin
  lcNode := TParseTreeNode(ctNode);
  // Verify if it is a forward declaration
  if (lcNode.HasChildNode(nClassBody) or lcNode.HasChildNode(nClassHeritage)) then
  begin
    Assert(FCurrentUnit <> nil);
    lcIntermediateNode := lcNode.GetParentNode(nTypeDecl);
    if(assigned(lcIntermediateNode)) then
    begin
      if(lcIntermediateNode.HasChildren and lcIntermediateNode.HasChildNode(nIdentifier)) then
      begin
        ClassName:=lcNode.GetParentNode(
          nTypeDecl).GetImmediateChild(nIdentifier).FirstSolidLeaf.Describe;
        FCurrentUnit.FlatClassList.FindItemByName(ClassName);
      end;
    end;
  end;
end;

procedure TVInterfaceComment.GetInterfaceType(const ctNode: TObject);
var
  lcNode: TParseTreeNode;
  InterfaceName: string;
begin
  lcNode := TParseTreeNode(ctNode);
  // Verify if it is a forward declaration
  if (lcNode.HasChildNode(nInterfaceBody) or lcNode.HasChildNode(
    nInterfaceHeritage)) then
  begin
    Assert(FCurrentUnit <> nil);
    InterfaceName := lcNode.GetParentNode(
      nTypeDecl).GetImmediateChild(nIdentifier).FirstSolidLeaf.Describe;
    FCurrentUnit.FlatClassList.FindItemByName(ClassName);
  end;
end;

procedure TVInterfaceComment.GetVarDecl(const ctNode: TObject);
var
  lcNode: TParseTreeNode;
begin
  lcNode := TParseTreeNode(ctNode);
  // Get First Identifier
  if lcNode.HasChildNode(nIdentifier) then
    FLastTaggedNode := lcNode.FirstSolidLeaf.GetParentNode(nIdentifier);
end;

procedure TVInterfaceComment.GetConstDecl(const ctNode: TObject);
var
  lcNode: TParseTreeNode;
begin
  lcNode := TParseTreeNode(ctNode);
  // Get First Identifier
  if lcNode.HasChildNode(nIdentifier) then
   FLastTaggedNode := lcNode.FirstSolidLeaf.GetParentNode(nIdentifier);
end;

procedure TVInterfaceComment.GetTypeDecl(const ctNode: TObject);
var
  lcNode: TParseTreeNode;
begin
  lcNode := TParseTreeNode(ctNode);
  // Get First Identifier
  if lcNode.HasChildNode(nIdentifier) then
   FLastTaggedNode := lcNode.FirstSolidLeaf.GetParentNode(nIdentifier);
end;

/// Find TAG's SubID if exist. Only Param and Version have SubID, other is null
function TVInterfaceComment.ExtractSubID(const tagNode: TObject): string;
var
  lcNode: TParseTreeNode;
begin
  lcNode := TParseTreeNode(tagNode);
  Result := '';
  if lcNode.NodeType = nTAGParam then
  begin
    Result := TSourceToken(lcNode.GetParentNode(nTAGComment).FirstLeaf.NextLeafNode).SourceCode
  end;
end;

procedure TVInterfaceComment.GetProcedureDecl(const ctNode: TObject);
var
  lcNode: TParseTreeNode;
begin
  lcNode := TParseTreeNode(ctNode);
  // Detect ProcedureType
  if lcNode.HasParentNode(nProcedureType) then
  begin
    // skip procedure type,
  end
  else
  begin
    // Get First Identifier
    if lcNode.HasChildNode(nIdentifier) then
     FLastTaggedNode := lcNode.GetImmediateChild(nIdentifier);
  end;
end;


procedure TVInterfaceComment.GetPropertyDecl(const ctNode: TObject);
var
  lcNode: TParseTreeNode;
begin
  lcNode := TParseTreeNode(ctNode);
  // Get First Identifier
  if lcNode.HasChildNode(nIdentifier) then
    FLastTaggedNode :=  lcNode.GetImmediateChild(nIdentifier);
end;

procedure TVInterfaceComment.AfterFullVisit;
begin
  if Docproject.DocOptions.PropertyCommentFromAssessors then
   FixPropertiesEmptyComment(FCurrentUnit.ClassList);
end;

function TVInterfaceComment.GetUpperClass(
  const ctNode: TObject): TDOCClass;
var
  lcNode: TParseTreeNode;
  tmpClassName: string;
begin
  lcNode := TParseTreeNode(ctNode);
  if lcNode.HasParentNode(ObjectBodies) or lcNode.HasParentNode(ObjectTypes) then
  begin
   tmpClassName := lcNode.GetParentNode(nTypeDecl).GetImmediateChild(nIdentifier).FirstSolidLeaf.Describe;
   Result := FCurrentUnit.FlatClassList.FindItemByName(tmpClassName) as TDOCClass;
  end
  else Result := nil;
end;

procedure TVInterfaceComment.ScanClassForProperties(const DocClass:TDOCClass);
type
  TAssessorType = (atRead, atWrite);
var
  IndexProperty : integer;
  tmpDocProperty: TDOCProperty;

  function GetAssessor(const AssessorName: string) : TDOCTemplate;
  begin
    assert(assigned(DocClass));
    result:= DocClass.FieldList.FindItemByName(AssessorName);
    if not assigned(result) then
     result:= DocClass.MethodList.FindItemByName(AssessorName);
  end;

  // Set Field comment for property
  procedure UpdateCommentWithAssessor(const DocAssessor: TDocTemplate);
  begin
      if(assigned(DocAssessor)) then
      tmpDocProperty.TAGHolderList.AddTAG(DocAssessor.TAGHolderList.GetSummary
        , nTAGDescription, '');
  end;

begin
    for IndexProperty:=0 to DocClass.PropertyList.Count-1 do
    begin
      tmpDocProperty:=DocClass.PropertyList.Items[IndexProperty] as TDOCProperty;
      // Scan Empty property comments
      if not tmpDocProperty.TAGHolderList.ExistContentByStyle(eDescriptionTAG) then
      begin
        // test if Read or write specifier is a field
        if(tmpDocProperty.HasReadSpecifier and assigned(tmpDocProperty.ReadAssessor) and
         tmpDocProperty.ReadAssessor.TAGHolderList.ExistContentByStyle(eDescriptionTAG)) then
         UpdateCommentWithAssessor(tmpDocProperty.ReadAssessor)
        else
        if(tmpDocProperty.HasWriteSpecifier and assigned(tmpDocProperty.WriteAssessor) and
         tmpDocProperty.WriteAssessor.TAGHolderList.ExistContentByStyle(eDescriptionTAG)) then
         UpdateCommentWithAssessor(tmpDocProperty.WriteAssessor);
      end;
    end;
end;

procedure TVInterfaceComment.FixPropertiesEmptyComment(const ClassList : TDOCClassList);
var
  IndexClass : integer;
  tmpDocClass : TDOCClass;
begin
  for IndexClass:=0 to ClassList.Count-1 do
  begin
    tmpDocClass := ClassList.Items[IndexClass] as TDOCClass;
    ScanClassForProperties(tmpDocClass);
    // Scan nested class
    FixPropertiesEmptyComment(tmpDocClass.ClassList);
  end;
end;

end.


