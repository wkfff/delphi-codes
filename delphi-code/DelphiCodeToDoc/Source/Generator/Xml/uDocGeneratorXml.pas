{*------------------------------------------------------------------------------
  XML Generator
  It provides all classes and functions to build XML files from the structure
   builder.

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   Initial revision
  @TODO      Link must be built by the HTMLGenerator and not the HTML canvas
-------------------------------------------------------------------------------}
unit uDocGeneratorXml;

interface

uses
  SysUtils, Classes, XMLintf,
  uDocGeneratorVisitor, uDocTemplate, uDocClassTree, uDocMember, Tokens,
  uDocMethod, uOptions, uDocStructure, uDocGeneratorbase;

// Define XML_GENERATOR_ENABLED to enable XML generator (under development)

{$IFDEF XML_GENERATOR_ENABLED}

type
  /// XML documentation generator
  TDocGeneratorXml = class(TDOCGeneratorBase)
  private
    FXmlDoc : IXMLDocument;
    FGenHTML: TStringList; /// Output writer component
    FXmlOutputFolder : TFileName; /// Output folder to store HTML page
    procedure AddLine(const st: string);
    function GetClassTreeLink(const DocItem: TDOCTemplate): string;
    function GetMemberVisibility(dm: TDOCTemplate): string;
    function GetImgFolder: string;
    procedure WriteClassHierarchy(const ClassHierarchy: TDOCClassesTree);
    procedure IterateClassNode(const CurrentClassNodeNode : TDOCClassNode);
    procedure WriteMemberVisibilityText(const DocMember: TDOCMember);
    procedure WritePageFooter;
    procedure WriteLegend;
    procedure WritePageHeader(const DocItem: TDOCTemplate);
    procedure WriteTAGSection(const TAGType: TCommentStyle;
      const DocItem: TDOCTemplate; const SectionName: string);
    procedure WriteSimpleTAGSection(const TAGType: TCommentStyle;
      const DocItem: TDOCTemplate; const SectionName: string);
    procedure WriteReturnTAGSection(const DOCMethod: TDOCMethod);
    procedure WriteParamReturnTAGSection(const DOCMethod: TDOCMethod);
    function GetRelativePathToParent(const DocItem: TDOCTemplate): string;
    function GetRelativePathToItem(const DocItem, DocLink: TDOCTemplate): string;
    procedure WriteTemplateSection(const DocTemplate: TDOCTemplate);
    function GetCssFolder: string;
    procedure WriteDocTemplateList(const DocTemplateList : TDOCTemplateList;
      const OutputCategory : TOutputCategoryList; const stSectionCaption : string;
      const stItemCaption : string);
  protected
    property XmlOutputFolder : TFileName read FXmlOutputFolder;
    procedure DoVisit(const DocTemplate: TDOCTemplate); override;
    procedure BuildFolders; override;
   public
    function GetOutputFile : TFileName; override;
    constructor Create(const DocStructure : TDOCStructure); override; // reintroduce
  end;

{$ENDIF}

implementation

{$IFDEF XML_GENERATOR_ENABLED}

uses
  JclFileUtils, JclStrings, JvGnuGettext, XMLdoc,
  uDocGenHTML_Tools, uDocClass, uDocProperty, uDocUnit, uDocParameter, uDocType,
  uDocGenHtmlVisitor;

function ClassHierarchyListToString(CHList : TClassHierarchyList): string;
var
  Index: Integer;
begin
  Result:='';
  For Index:=0 to CHList.Count-1 do
  begin
   if Index<>0 then Result:=Result+',';
   Result:=Result+CHList.Strings[Index];
  end;
end;

{*------------------------------------------------------------------------------
  Add a line to the output
  Since every output type have a different way to write the output, the AddLine
  method is overloaded.
  It simply add the HTML in the stream.
  @param  st  String to add to the stream
-------------------------------------------------------------------------------}
procedure TDocGeneratorXml.AddLine(const st: string);
begin
  FGenHTML.Add(st);
end;

procedure TDocGeneratorXml.DoVisit(const DocTemplate: TDOCTemplate);
var
  HTMLFileName: TFilename;
begin
  inherited;

  // ------- AFTER VISIT ------
  // Create XML file
  FXmlDoc := TXMLDocument.Create(nil);
  FXmlDoc.Active := True;
  //  ------ DO VISIT ------
  WritePageHeader(DocTemplate);
  //PreviousItem := nil;
  //NextItem     := nil;
  WriteTemplateSection(DocTemplate);
  WritePageFooter;
  // ------- AFTER VISIT ------
  // Close HTMLFile
  HTMLFileName:=FXmlOutputFolder + DocTemplate.BuildPathName + XML_FILE_EXT;
  try
    ForceDirectories(ExtractFilepath(HTMLFileName));
    FGenHTML.SaveToFile(HTMLFileName);
  finally
    // free interface
    FXmlDoc := nil;
  end;
end;

///  Add the toolbar to the HTML page
procedure TDocGeneratorXml.AddToolBar(const DocItem: TDOCTemplate);
var
  PrevLink, NextLink: string;
begin
  if assigned(PreviousItem) then
  begin
    PrevLink := HTMLBuildLink(Format('%s (%s)', [L_Previous, PreviousItem.Name]),
      PreviousItem.GetFileName)
  end
  else begin
    PrevLink := L_Previous
  end;
  if assigned(NextItem) then
  begin
    NextLink := HTMLBuildLink(Format('%s (%s)', [L_Next, NextItem.Name]), NextItem.GetFileName)
  end
  else begin
    NextLink := L_Next
  end;

  AddLine(HTMLGenToolbar(DocStructure.BuildPathName, GetClassTreeLink(DocItem),
    GetHTMLIndex(DocItem), PrevLink, NextLink));
end;

procedure TDocGeneratorXml.BuildFolders;
var
  CSSFile: TStringList;
begin
  inherited;

  FHtmlOutputFolder:=DocOptions.EffectiveOutputFolder+'html'+PathDelim;
  // Build 'html' output directory if not exists
  if not DirectoryExists(FHtmlOutputFolder) then
   ForceDirectories(FHtmlOutputFolder);
  // Build '_Resources\css' output directory if not exists
  if not DirectoryExists(GetCssFolder()) then
   ForceDirectories(GetCssFolder());
  // Build '_Resources\img' output directory if not exists
  if not DirectoryExists(GetImgFolder()) then
   ForceDirectories(GetImgFolder());

  CSSFile := TStringList.Create;
  CSSFile.Add(HTMLGenCSS);
  FCSSFilename := GetCssFolder() + CSS_BASE_FILENAME + CSS_FILE_EXT;
  try
    CSSFile.SaveToFile(FCSSFilename);
  finally
    FreeAndNil(CSSFile);
  end;

end;

constructor TDocGeneratorXml.Create(const DocStructure: TDOCStructure);
begin
  inherited;
  CreateVisitor(TDocGenHtmlVisitor);
end;

{*------------------------------------------------------------------------------
  Get relative path to the class tree from a DocTemplate
  @param DocItem   Entry point to get the relative path from
------------------------------------------------------------------------------*}
function TDocGeneratorXml.GetClassTreeLink(const DocItem: TDOCTemplate): string;
var
  RelativeIndexFile: TFilename;
begin
  RelativeIndexFile:=PathGetRelativePath(ExtractFilePath(
   FHtmlOutputFolder + DocItem.BuildPathName + HTML_FILE_EXT)
   ,FHtmlOutputFolder)+PathDelim+DocStructure.ClassTree.BuildPathName;
  Result := HTMLBuildLink(L_ClassTree, RelativeIndexFile);
end;

{*------------------------------------------------------------------------------
  Build the Index documentation section
  @return     String containing the HTML section of Index
-------------------------------------------------------------------------------}
function TDocGeneratorXml.GetHTMLIndex(const DocItem: TDOCTemplate): string;
var
  RelativeIndexFile: TFilename;
begin
  RelativeIndexFile:=PathGetRelativePath(ExtractFilePath(
   FHtmlOutputFolder + DocItem.BuildPathName + HTML_FILE_EXT)
   ,FHtmlOutputFolder)+PathDelim+DocStructure.BuildPathName;
  Result := HTMLBuildLink(L_Index, RelativeIndexFile);
end;

/// Return the name of the main generated file from Generator
function TDocGeneratorXml.GetOutputFile: TFileName;
begin
  result := FHtmlOutputFolder + DocStructure.BuildPathName + HTML_FILE_EXT;
end;

{*------------------------------------------------------------------------------
  Build the HTML member visibility symbols
  @param  dm  TDOCTemplate to take visiblity
  @return     String containing the HTML representation of member visibility
-------------------------------------------------------------------------------}
function TDocGeneratorXml.GetHTMLMemberVisibility(dm: TDOCTemplate): string;
var
  tmpVisibility : string;
begin
  if(dm is TDOCMember) then
  begin
    tmpVisibility := MemberVisibilitySymbol[TDOCMember(dm).MemberVisibility];
    if TDOCMember(dm).StrictVisibility then
     tmpVisibility := StrictVisibilitySymbol + tmpVisibility;
    Result := '  (' + tmpVisibility + ')';
  end
  else
  begin
    // Non-member template, return empty string
    Result := '';
  end;
end;

function TDocGeneratorXml.GetImgFolder: string;
begin
  Result := FHtmlOutputFolder + RESOURCES_FOLDER + PathDelim + IMG_FOLDER + PathDelim;
end;

{*------------------------------------------------------------------------------
  Build the class section of the documentation
  Write Fields, methods, properties and events
  @param  DocClass  TDOCClass to generate
 ------------------------------------------------------------------------------}
procedure TDocGeneratorXml.WriteClassHierarchy(
  const ClassHierarchy: TDOCClassesTree);
begin
  // CLASS HIERARCHY SECTION
  AddLine(HTMLGenLinesSectionInit(L_ClassHierarchy));
  ClassHierarchy.Iterate(IterateClassNode);
  AddLine(HTMLGenLinesSectionEnd());
end;

procedure TDocGeneratorXml.IterateClassNode(const CurrentClassNodeNode : TDOCClassNode);
var
  RightAlignement : string;
  Index : integer;
begin
  RightAlignement := '';
  for Index := 0 to CurrentClassNodeNode.NestedLevel - 1 do
  begin
    RightAlignement := RightAlignement + '&nbsp&nbsp';
  end;
  RightAlignement := RightAlignement + ' * ';
  if(assigned(CurrentClassNodeNode.DocClassLink)) then
  begin
    AddLine(HTMLGenLinesSectionLine(RightAlignement +
     HTMLBuildLink(CurrentClassNodeNode.Name,
     CurrentClassNodeNode.DocClassLink.BuildPathName)));
  end
  else
  begin
    AddLine(HTMLGenLinesSectionLine(CurrentClassNodeNode.Name));
  end;

end;

/// Write Legend - Member visibility symbol - at the end of he document
procedure TDocGeneratorXml.WriteLegend;
begin
  // LEGEND SECTION
  AddLine(HTMLGenTableSectionInit(L_Legend, L_Symbol, L_Visibility));
  AddLine(HTMLGenTableSectionLine(MemberVisibilitySymbol[mvPrivate], L_Private));
  AddLine(HTMLGenTableSectionLine(MemberVisibilitySymbol[mvProtected], L_Protected));
  AddLine(HTMLGenTableSectionLine(MemberVisibilitySymbol[mvPublic], L_Public));
  AddLine(HTMLGenTableSectionLine(MemberVisibilitySymbol[mvPublished], L_Published));
  AddLine(HTMLGenTableSectionLine(MemberVisibilitySymbol[mvAutomated], L_Automated));
  AddLine(HTMLGenTableSectionLine(StrictVisibilitySymbol, L_Strict));
  AddLine(HTMLGenTableSectionEnd);
end;

{*------------------------------------------------------------------------------
  Write in HTML doc the member visibility in text format.
  It handles the case where member has STRICT visibility keyword.
  @param  DocMember  TDOCMember to generate visibility
 ------------------------------------------------------------------------------}
procedure TDocGeneratorXml.WriteMemberVisibilityText(const DocMember: TDOCMember);
var
  tmpVisibility : string;
begin
  tmpVisibility:=MemberVisibilityName.Strings[integer(DocMember.MemberVisibility)];
  if DocMember.StrictVisibility then
   tmpVisibility := 'STRICT '+ tmpVisibility;
  AddLine(HTMLGenSimpleSection(L_Visibility, tmpVisibility));
end;


/// Write documentation Page footer
procedure TDocGeneratorXml.WritePageFooter;
begin
  AddLine(HTMLGenFooter(DocOptions.Copyright));
end;

/// Write documentation Page header
procedure TDocGeneratorXml.WritePageHeader(const DocItem: TDOCTemplate);
var
  CSSRelativeFile: String;
begin
  CSSRelativeFile:=PathGetRelativePath(ExtractFilePath(
   FHtmlOutputFolder + DocItem.BuildPathName + HTML_FILE_EXT)
   ,GetCssFolder()) + PathDelim + CSS_BASE_FILENAME + CSS_FILE_EXT;
  // Replace Windows file path separator '\' with web path separator '/'
  CharReplace(CSSRelativeFile,'\','/');
  // HEADER SECTION - Add CSSFilename !
  AddLine(HTMLGenHead(DocOptions.Name,DocOptions.Summary,CSSRelativeFile));
end;

{*------------------------------------------------------------------------------
  Build a colored TAG section of a Template
  @param  TAGType  TCommentStyle to search
  @param  DocItem  TDOCTemplate holding the TAG
  @param  SectionName string containing the name of the section
 ------------------------------------------------------------------------------}
procedure TDocGeneratorXml.WriteTAGSection(const TAGType: TCommentStyle;
  const DocItem: TDOCTemplate; const SectionName: string);
var
  TAGStrings: TStringList;
begin
  if not DocItem.TAGHolderList.ExistContentByStyle(TAGType) then
  begin
    // Exit if TAG is empty and Options is ON
    if DocOptions.HideEmptyTAGSection then exit;
    if TAGType in OPTIONAL_TAG_COMMENT then exit;
  end;
  TAGStrings := DocItem.TAGHolderList.GetContentByStyle(TAGType);
  begin
    AddLine(HTMLGenLinesSectionInit(SectionName));
    AddLine(HTMLGenLinesSectionLineColored(StringsToHTMLStrings(TAGStrings,DocOptions.AllowHtmlInDescription)));
    AddLine(HTMLGenLinesSectionEnd);
  end;
end;

{*------------------------------------------------------------------------------
  Build a simple TAG section (no color) from a Template
  @param  TAGType  TCommentStyle to search
  @param  DocItem  TDOCTemplate holding the TAG
  @param  SectionName string containing the name of the section
 ------------------------------------------------------------------------------}
procedure TDocGeneratorXml.WriteSimpleTAGSection(const TAGType: TCommentStyle;
  const DocItem: TDOCTemplate; const SectionName: string);
var
  TAGStrings: TStringList;
begin
  if not DocItem.TAGHolderList.ExistContentByStyle(TAGType) then
  begin
    // Exit if TAG is empty and Options is ON
    if DocOptions.HideEmptyTAGSection then exit;
    // Always hide optional TAG if empty, because it is optional !
    if TAGType in OPTIONAL_TAG_COMMENT then exit;
  end;
  TAGStrings := DocItem.TAGHolderList.GetContentByStyle(TAGType);
  AddLine(HTMLGenSimpleColoredSection(SectionName, StringsToHTMLStrings(TAGStrings,DocOptions.AllowHtmlInDescription)));
end;

{*------------------------------------------------------------------------------
  Build the specific @return TAG section from a Method
  @param  DOCMethod  TDOCMethod holding the TAG
 ------------------------------------------------------------------------------}
procedure TDocGeneratorXml.WriteReturnTAGSection(const DOCMethod: TDOCMethod);
var
  TAGStrings: TStringList;
begin
  if not DOCMethod.TAGHolderList.ExistContentByStyle(eReturnTAG) then
  begin
    // Exit if TAG is empty and Options is ON
    if DocOptions.HideEmptyTAGSection then exit;
  end;
  TAGStrings := DOCMethod.TAGHolderList.GetContentByStyle(eReturnTAG);
  AddLine(HTMLGenTableSectionInit(L_Return, L_Types, L_Description));
  AddLine(HTMLGenTableSectionLine(DOCMethod.RelatedType,
    StringsToHTMLStrings(TAGStrings,DocOptions.AllowHtmlInDescription)));
  AddLine(HTMLGenTableSectionEnd);
end;

procedure TDocGeneratorXml.WriteParamReturnTAGSection(const DocMethod: TDOCMethod);
var
  IndexParameter : integer;
begin
  // PARAMETERS SECTION
  AddLine(HTMLGenTableSectionInit(L_Parameters, L_Parameter, L_Description));
  for IndexParameter := 0 to DocMethod.ParameterList.Count - 1 do
  begin
    AddLine(HTMLGenTableSectionLine(DocMethod.ParameterList[IndexParameter].Name +
      ' : ' + DocMethod.ParameterList[IndexParameter].RelatedType,
      StringsToHTMLStrings(DocMethod.TAGHolderList.GetContentByStyle(
      eParamTAG, DocMethod.ParameterList[IndexParameter].Name),DocOptions.AllowHtmlInDescription)));
  end;
  AddLine(HTMLGenTableSectionEnd);
  // RETURN SECTION
  if DocMethod.RelatedType <> '' then WriteReturnTAGSection(DocMethod);
end;

function TDocGeneratorXml.GetRelativePathToParent(const DocItem: TDOCTemplate): string;
begin
  // Verify if parent is allowed !
  if(assigned(DocItem.RelatedParent)) then
  { TODO 1 -oTridenT -cBug : Add visiblity and options check to nuild link }
   // parent is always ../[ParentsName]
   Result:= '../'+DocItem.RelatedParent.Name
  else Result := '';
end;

function TDocGeneratorXml.GetRelativePathToItem(const DocItem, DocLink: TDOCTemplate): string;
begin
  assert(assigned(DocItem));
  if assigned(DocLink) then
  begin
   Result:=PathGetRelativePath(ExtractFilePath(
   FHtmlOutputFolder + DocItem.BuildPathName + HTML_FILE_EXT)
   ,ExtractFilePath(FHtmlOutputFolder + DocLink.BuildPathName + HTML_FILE_EXT))
   +PathDelim + DocLink.GetFileName;
  end
  else Result:= '';
end;


procedure TDocGeneratorXml.WriteTemplateSection(const DocTemplate: TDOCTemplate);
var
  tmpProperty: TDOCProperty;
  DocClass : TDOCClass;
  DocUnit : TDOCUnit;
begin
  // TOOLBAR SECTION
  AddToolBar(DocTemplate);
  // ITEM NAME SECTION
  AddLine(HTMLGenSimpleSection(L_Name, DocTemplate.Name));
  // RELATED PARENT SECTION - ignore TDOCStructure
  if(not ((DocTemplate is TDOCStructure) or (DocTemplate is TDOCClassesTree))) then
   AddLine(HTMLGenSimpleSection(L_Parent,HTMLBuildLink(DocTemplate.GetParentName,
    GetRelativePathToParent(DocTemplate))));
  // HIERARCHY SECTION - Only class ans affiliate
  if (DocTemplate is TDOCClass) then
   AddLine(HTMLGenSimpleSection(L_ClassHierarchy, ClassHierarchyListToString((DocTemplate as TDOCClass).ClassHierarchyList)));
  // CLASS TREE
  if (DocTemplate is TDOCClassesTree) then
    WriteClassHierarchy(DocTemplate as TDOCClassesTree);
  // VISIBILITY SECTION
  if (DocTemplate is TDOCMember) then
   WriteMemberVisibilityText(DocTemplate as TDOCMember);
  // DESCRIPTION SECTION - All except TDOCClassesTree
  if not (DocTemplate is TDOCClassesTree) then
   WriteTAGSection(eDescriptionTAG, DocTemplate, L_Description);
  // AUTHOR SECTION - Unit (and classes ?)
  if ((DocTemplate is TDOCUnit) or (DocTemplate is TDOCStructure))then
   WriteTAGSection(eAuthorTAG, DocTemplate, L_Author);
  // REVISION SECTION - Unit (and classes ?)
  if (DocTemplate is TDOCUnit) then
   WriteTAGSection(eVersionTAG, DocTemplate, L_Version);
  // TODO SECTION - Unit (and classes ?)
  if (DocTemplate is TDOCUnit) then
   WriteSimpleTAGSection(eTodoTAG, DocTemplate, L_Todo);
  // EXCEPTION SECTION
  if (DocTemplate is TDOCMethod) then
   WriteSimpleTAGSection(eThrowsTAG, DocTemplate, L_Exception);
  // ADDITIONNAL COMMENT SECTION
  if (DocTemplate is TDOCMethod) then
   WriteSimpleTAGSection(eAdditionalCommentTAG, DocTemplate, L_AdditionalComment);
  // SOURCECODE SECTION
  if ((DocTemplate is TDOCMember) and not (DocTemplate is TDOCClass)) then
   AddLine(HTMLGenSimpleSection(L_SourceCode, DocTemplate.BodySource));
  // Specific to TDOCStructure because no copy from DocOptions to TAG
   { TODO -oTridenT -cRefactoring : copy author and description from DocOptions  to TAG for TDOCStructure }
  // FILES/UNITS SECTION
  if(DocTemplate is TDOCStructure) then
    WriteDocTemplateList((DocTemplate as TDOCStructure).UnitList, ocUnits,
      L_Units, L_Unit);
  // METHOD (PARAMETERS - RETURN) SECTION
  if (DocTemplate is TDOCMethod) then
   WriteParamReturnTAGSection(DocTemplate as TDOCMethod);
  // For Procedure type
  if (DocTemplate is TDOCFunctionType) then
   WriteParamReturnTAGSection((DocTemplate as TDOCFunctionType).DocFunction);


  // PROPERTY SECTION
  if (DocTemplate is TDOCProperty) then
  begin
    // Read/Write Access SECTION
    tmpProperty:=DocTemplate as TDOCProperty;
    if tmpProperty.HasReadSpecifier then
      AddLine(HTMLGenSimpleSection(L_ReadAccess, HTMLBuildLink(
       tmpProperty.ReadSpecifier,GetRelativePathToItem(tmpProperty, tmpProperty.ReadAssessor) )));
    if tmpProperty.HasWriteSpecifier then
      AddLine(HTMLGenSimpleSection(L_WriteAccess, HTMLBuildLink(
       tmpProperty.WriteSpecifier,GetRelativePathToItem(tmpProperty, tmpProperty.WriteAssessor) )));
  end;
  // CLASS SECTION
  if(DocTemplate is TDOCClass) then
  begin
    DocClass := DocTemplate as TDOCClass;
    { TODO : Add nested type section }
    // CONSTANTS SECTION
    WriteDocTemplateList(DocClass.ConstantList, ocConstants, L_Constants, L_Constant);
    // VARIABLES SECTION
    WriteDocTemplateList(DocClass.VarList, ocVariables, L_Variables, L_Variable);
    // CLASSES SECTION
    WriteDocTemplateList(DocClass.ClassList, ocClasses, L_Classes, L_Class);
    // START OF MEMBERS MULTI SECTION
    if not DocOptions.HideEmptyOutputBlock or (DocClass.MembersCount>0) then
    begin
      AddLine(HTMLGenMultiSectionInit(L_Members));
      //   FIELDS SECTION
      WriteDocTemplateList(DocClass.FieldList, ocFields, L_Fields, L_Field);
      //   METHODS SECTION
      WriteDocTemplateList(DocClass.MethodList, ocMethods, L_Methods, L_Method);
      //   PROPERTYS SECTION
      WriteDocTemplateList(DocClass.PropertyList, ocProperties, L_Properties, L_Property);
      //   EVENTS SECTION
      WriteDocTemplateList(DocClass.EventList, ocEvents, L_Events, L_Event);
      AddLine(HTMLGenTableSectionEnd);
    end;
  end;  // END OF MEMBERS MULTI SECTION

  // UNIT SECTION
  if(DocTemplate is TDOCUnit) then
  begin
    DocUnit := DocTemplate as TDOCUnit;
    { TODO : Add nested type section }
    // TYPES SECTION
    WriteDocTemplateList(DocUnit.TypeList, ocTypes, L_Types, L_Type);
    // CONSTANTS SECTION
    WriteDocTemplateList(DocUnit.ConstantList, ocConstants, L_Constants, L_Constant);
    // VARIABLES SECTION
    WriteDocTemplateList(DocUnit.VarList, ocVariables, L_Variables, L_Variable);
    // METHODS SECTION
    WriteDocTemplateList(DocUnit.FunctionList, ocMethods, L_Methods, L_Method);
    // CLASSES SECTION
    WriteDocTemplateList(DocUnit.ClassList, ocClasses, L_Classes, L_Class);
  end;
  // LINKS SECTION
{$IFNDEF HIDE_LINKS_SECTION}
  AddLine(HTMLGenSimpleSection(L_Links, L_UnderConstruction));
{$ENDIF}
  // LEGEND SECTION
  if((DocTemplate is TDOCUnit) or (DocTemplate is TDOCClass)) then
   WriteLegend;
  // TOOLBAR SECTION
  AddToolBar(DocTemplate);
end;


procedure TDocGeneratorXml.WriteDocTemplateList(const DocTemplateList : TDOCTemplateList;
  const OutputCategory : TOutputCategoryList; const stSectionCaption : string;
  const stItemCaption : string);
var
  IndexItem : integer;
begin
  // CONSTANTS SECTION
  if OutputCategory in DocOptions.OutputFilteringCategory then
  begin
    if not DocOptions.HideEmptyOutputBlock or (DocTemplateList.Count>0) then
    begin
      AddLine(HTMLGenTableSectionInit(stSectionCaption, stItemCaption, L_Description));
      for IndexItem := 0 to DocTemplateList.Count - 1 do
      begin
        if(EvaluateItemDisplay(DocTemplateList.Items[IndexItem])) then
        AddLine(HTMLGenTableSectionLine(
          HTMLBuildLink(DocTemplateList.Items[IndexItem].Name,
           DocTemplateList.Items[IndexItem].BuildRelativePathName)
           +GetHTMLMemberVisibility(DocTemplateList.Items[IndexItem]),
           DocTemplateList.Items[IndexItem].TAGHolderList.GetSummary));
      end;
      AddLine(HTMLGenTableSectionEnd);
    end;
  end;
end;

function TDocGeneratorXml.GetCssFolder: string;
begin
  Result := FHtmlOutputFolder + RESOURCES_FOLDER + PathDelim + CSS_FOLDER + PathDelim;
end;

{$ENDIF}

end.
