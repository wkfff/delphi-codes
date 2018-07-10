unit TokenUtils;

{ AFS 2 Jan
  procedureal code that works on the parse tree
  not put on the class as it's most fairly specific stuff
    (but has been put here because 2 or more processes use it )
  and needs to know both classes - TParseTreeNode and TSoruceTOken
  }

{(*}
(*------------------------------------------------------------------------------
 Delphi Code formatter source code 

The Original Code is TokenUtils, released May 2003.
The Initial Developer of the Original Code is Anthony Steele. 
Portions created by Anthony Steele are Copyright (C) 1999-2008 Anthony Steele.
All Rights Reserved. 
Contributor(s): Anthony Steele. 

The contents of this file are subject to the Mozilla Public License Version 1.1
(the "License"). you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.mozilla.org/NPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied.
See the License for the specific language governing rights and limitations 
under the License.

Alternatively, the contents of this file may be used under the terms of
the GNU General Public License Version 2 or later (the "GPL") 
See http://www.gnu.org/licenses/gpl.html
------------------------------------------------------------------------------*)
{*)}

interface

// TridenT
uses Classes, ParseTreeNode, SourceToken;

{ make a new return token }
function NewReturn: TSourceToken;
function NewSpace(const piLength: integer): TSourceToken;

procedure InsertTokenAfter(const pt, ptNew: TSourceToken);
procedure InsertTokenBefore(const pt, ptNew: TSourceToken);

function InsertReturnAfter(const pt: TSourceToken): TSourceToken;
function InsertSpacesBefore(const pt: TSourceToken;
  const piSpaces: integer): TSourceToken;

{ effectively remove the token by making it empty }
procedure BlankToken(const pt: TSourceToken);

{ return the name of the procedure around any parse tree node or source token
  empty string if there is none }
function GetProcedureName(const pcNode: TParseTreeNode; const pbFullName: boolean;
  const pbTopmost: boolean): string;


{ depending on context, one of Procedure, function, constructor, destructor }
function GetBlockType(const pcNode: TParseTreeNode): string;


function ExtractNameFromFunctionHeading(const pcNode: TParseTreeNode;
  const pbFullName: boolean): string;

function IsClassFunctionOrProperty(const pt: TSourceToken): boolean;

function RHSExprEquals(const pt: TSourceToken): boolean;

function RHSTypeEquals(const pt: TSourceToken): boolean;


function RoundBracketLevel(const pt: TSourceToken): integer;
function SquareBracketLevel(const pt: TSourceToken): integer;
function AllBracketLevel(const pt: TSourceToken): integer;
function BlockLevel(const pt: TSourceToken): integer;
function CaseLevel(const pt: TSourceToken): integer;

function InRoundBrackets(const pt: TSourceToken): boolean;

function SemicolonNext(const pt: TSourceToken): boolean;


{ true if the token is in code, ie in procedure/fn body,
  init section, finalization section, etc

  False if it is vars, consts, types etc
  or in asm }
function IsClassHelperWords(const pt: TSourceToken): boolean;

function InStatements(const pt: TSourceToken): boolean;
function InProcedureDeclarations(const pt: TsourceToken): boolean;
function InDeclarations(const pt: TsourceToken): boolean;

function IsCaseColon(const pt: TSourceToken): boolean;
function IsLabelColon(const pt: TSourceToken): boolean;

function IsFirstSolidTokenOnLine(const pt: TSourceToken): boolean;

function IsUnaryOperator(const pt: TSourceToken): boolean;

function InFormalParams(const pt: TSourceToken): boolean;

function IsActualParamOpenBracket(const pt: TSourceToken): boolean;
function IsFormalParamOpenBracket(const pt: TSourceToken): boolean;

function IsMultiLineComment(const pcToken: TSourceToken): boolean;
function IsSingleLineComment(const pcToken: TSourceToken): boolean;

function IsBlankLineEnd(const pcToken: TSourceToken): boolean;

function VarIdentCount(const pcNode: TParseTreeNode): integer;
function IdentListNameCount(const pcNode: TParseTreeNode): integer;

function ProcedureHasBody(const pt: TParseTreeNode): boolean;

function FirstSolidChild(const pt: TParseTreeNode): TParseTreeNode;

function InFilesUses(const pt: TParseTreeNode): boolean;


function Root(const pt: TParseTreeNode): TParseTreeNode;

function JCFUnitName(const pt: TParseTreeNode): string;

{ identifying identifiers is tricky
since delphi is more lenient about
what is allowed as an identifier for a variable or proc name  -
 directive names can be reused
 and in expressions involving OLE automation servers,
 all sorts of reserved words like "begin" and "end" can be used.
 Values are

 idStrict: no reserved words at all allowed.
  Used for unit names, type names, class names, etc
 idAllowDirectives: some directives can be reused.
  Used for procedure names, constant or variable names etc
 idAny: any textual token is valid
  used in expressions, which might involve a late-binding COM server with property names like "begin" and "end"
 }

type
  TIdentifierStrictness = (idStrict, idAllowDirectives, idAny);

{ use to build a parse tree}
function IsIdentifierToken(const pt: TSourceToken; const peStrictness: TIdentifierStrictness): boolean;
{ use on a built parse tree }
function IsIdentifier(const pt: TSourceToken; const peStrictness: TIdentifierStrictness): boolean;

function IsSymbolOperator(const pt: TSourceToken): boolean;

function IsClassDirective(const pt: TSourceToken): boolean;
function IsDfmIncludeDirective(const pt: TSourceToken): boolean;
function IsGenericResIncludeDirective(const pt: TSourceToken): boolean;
function IsHintDirective(const pt: TSourceToken): boolean;
function IsPropertyDirective(const pt: TSourceToken): boolean;
function IsDirectiveInContext(const pt: TSourceToken): Boolean;

// TridenT
function IsTAGComment(const pt: TSourceToken): boolean;
function IsCurlyComment(const pt: TSourceToken): boolean;
function IsStandardComment(const pt: TSourceToken): boolean;
function IsComment(const pt: TSourceToken): boolean;
function IsSlashComment(const pt: TSourceToken): boolean;
 //function CanFollowTAGComment(const pts: TTokenTypeSet): boolean;
 //function CanFollowTAGComment(const pt: TSourceToken): boolean;
function IsBlockComment(const pt: TSourceToken): boolean;
function IsBracketStarComment(const pt: TSourceToken): boolean;

function StartsLiteralString(const pt: TSourceToken): boolean;

function NextToWhiteSpace(const pt: TSourceToken): boolean;
function IsInImplementationPart(const pcNode: TParseTreeNode): boolean;
function IsDottedProcedureName(const phNode : TParseTreeNode): boolean;
function GetIdentList(const idNode: TObject; const idList: TStringList): integer;
function GetDottedIdentifier(const idNode: TObject): string;
function GetSingleIdentifier(const idNode: TObject): string;
//function CompilerDirectiveLineBreak(const pt: TSourceToken; const pbBefore: Boolean): TTriOptionStyle;

function IsInsideAsm(const pt: TSourceToken): boolean;
function HasAsmCaps(const pt: TSourceToken): boolean;


implementation

uses
  { delphi }
  SysUtils, Windows,
  { local }
  //JcfSettings,
  JcfUnicode,
  JcfStringUtils,
  ParseTreeNodeType, Tokens, Nesting,
  AsmKeywords;


function NewReturn: TSourceToken;
begin
  Result := TSourceToken.Create;
  Result.TokenType := ttReturn;
  Result.SourceCode := WideLineBreak;
end;

function NewSpace(const piLength: integer): TSourceToken;
begin
  Assert(piLength > 0, 'Bad space length of' + IntToStr(piLength));

  Result := TSourceToken.Create;
  Result.TokenType := ttWhiteSpace;
  Result.SourceCode := WideStringRepeat(WideSpace, piLength);
end;

procedure InsertTokenAfter(const pt, ptNew: TSourceToken);
begin
  Assert(pt <> nil);
  Assert(pt.Parent <> nil);
  Assert(ptNew <> nil);

  ptNew.FileName := pt.FileName;
  pt.Parent.InsertChild(pt.IndexOfSelf + 1, ptNew);
end;

procedure InsertTokenBefore(const pt, ptNew: TSourceToken);
begin
  Assert(pt <> nil);
  Assert(pt.Parent <> nil);
  Assert(ptNew <> nil);

  ptNew.FileName := pt.FileName;
  pt.Parent.InsertChild(pt.IndexOfSelf, ptNew);
end;

function InsertReturnAfter(const pt: TSourceToken): TSourceToken;
begin
  Assert(pt <> nil);
  Assert(pt.Parent <> nil);

  Result := NewReturn;

  InsertTokenAfter(pt, Result);
end;

function InsertSpacesBefore(const pt: TSourceToken;
  const piSpaces: integer): TSourceToken;
begin
  Assert(pt <> nil);
  Assert(pt.Parent <> nil);

  Result := NewSpace(piSpaces);
  Result.FileName := pt.FileName;
  pt.Parent.InsertChild(pt.IndexOfSelf, Result);
end;

procedure BlankToken(const pt: TSourceToken);
begin
  pt.TokenType  := ttWhiteSpace;
  pt.SourceCode := '';
end;

{ given a function header parse tree node, extract the fn name underneath it }
function ExtractNameFromFunctionHeading(const pcNode: TParseTreeNode;
  const pbFullName: boolean): string;
var
  liLoop:      integer;
  lcChildNode: TParseTreeNode;
  lcSourceToken: TSourceToken;
  lcNameToken: TSourceToken;
  lcPriorToken1, lcPriorToken2: TSourceToken;
begin
  lcNameToken := nil;

  { function heading is of one of these forms
      function foo(param: integer): integer;
      function foo: integer;
      function TBar.foo(param: integer): integer;
      function TBar.foo: integer;

    within the fn heading, the name will be last identifier before nFormalParams or ':'

  }
  for liLoop := 0 to pcNode.ChildNodeCount - 1 do
  begin
    lcChildNode := pcNode.ChildNodes[liLoop];

    if lcChildNode.NodeType = nFormalParams then
      break;

    if lcChildNode is TSourceToken then
    begin
      lcSourceToken := TSourceToken(lcChildNode);

      { keep the name of the last identifier }
      if lcSourceToken.TokenType in IdentiferTokens then
        lcNameToken := lcSourceToken
      else if lcSourceToken.TokenType = ttColon then
        break;
    end
    else if (lcChildNode.NodeType = nIdentifier) then
    begin
      lcNameToken := TSourceToken(lcChildNode.LastLeaf);
    end;
  end;

  if lcNameToken = nil then
    Result := ''
  else if pbFullName then
  begin
    Result := lcNameToken.SourceCode;

    // is it a qualified name
    lcPriorToken1 := lcNameToken.PriorSolidToken;
    if (lcPriorToken1 <> nil) and (lcPriorToken1.TokenType = ttDot) then
    begin
      lcPriorToken2 := lcPriorToken1.PriorSolidToken;
      if (lcPriorToken2 <> nil) and (lcPriorToken2.TokenType in IdentiferTokens) then
      begin
        Result := lcPriorToken2.SourceCode + lcPriorToken1.SourceCode +
          lcNameToken.SourceCode;
      end;
    end;
  end
  else
  begin
    // just the proc name, no prefix
    Result := lcNameToken.SourceCode;
  end;
end;

function GetProcedureName(const pcNode: TParseTreeNode; const pbFullName: boolean;
  const pbTopmost: boolean): string;
var
  lcFunction, lcTemp, lcHeading: TParseTreeNode;
begin
  Assert(pcNode <> nil);

  lcFunction := pcNode.GetParentNode(ProcedureNodes);

  if lcFunction = nil then
  begin
    // not in a function, procedure or method
    Result := '';
    exit;
  end;

  if pbTopmost then
  begin
    { find the top level function }
    lcTemp := lcFunction.GetParentNode(ProcedureNodes);
    while lcTemp <> nil do
    begin
      lcFunction := lcTemp;
      lcTemp     := lcFunction.GetParentNode(ProcedureNodes);
    end;
  end;

  lcHeading := lcFunction.GetImmediateChild(ProcedureHeadings);

  Result := ExtractNameFromFunctionHeading(lcHeading, pbFullName)
end;

function GetBlockType(const pcNode: TParseTreeNode): string;
var
  lcFunction: TParseTreeNode;
begin
  lcFunction := pcNode.GetParentNode(ProcedureNodes + [nInitSection]);

  if lcFunction = nil then
  begin
    Result := '';
    exit;
  end;

  case lcFunction.NodeType of
    nProcedureDecl:
      Result := 'procedure';
    nFunctionDecl:
      Result := 'function';
    nConstructorDecl:
      Result := 'constructor';
    nDestructorDecl:
      Result := 'destructor';
    nInitSection:
      Result := 'initialization section';
    else
      Result := '';
  end;
end;

function IsClassFunctionOrProperty(const pt: TSourceToken): boolean;
begin
  Result := pt.IsOnRightOf(ProcedureHeadings + [nProperty], [ttClass]);
end;


function RHSExprEquals(const pt: TSourceToken): boolean;
begin
  Result := pt.IsOnRightOf(nExpression, ttEquals);
end;

function RHSTypeEquals(const pt: TSourceToken): boolean;
begin
  Result := pt.IsOnRightOf(nType, ttEquals);
end;


function RoundBracketLevel(const pt: TSourceToken): integer;
begin
  if pt = nil then
    Result := 0
  else
    Result := pt.Nestings.GetLevel(nlRoundBracket);
end;

function InRoundBrackets(const pt: TSourceToken): boolean;
begin
  if pt = nil then
    Result := False
  else
    Result := (pt.Nestings.GetLevel(nlRoundBracket) > 0);
end;


function SquareBracketLevel(const pt: TSourceToken): integer;
begin
  if pt = nil then
    Result := 0
  else
    Result := pt.Nestings.GetLevel(nlSquareBracket);
end;

function AllBracketLevel(const pt: TSourceToken): integer;
begin
  Result := RoundBracketLevel(pt) + SquareBracketLevel(pt);
end;

function BlockLevel(const pt: TSourceToken): integer;
begin
  if pt = nil then
    Result := 0
  else
    Result := pt.Nestings.GetLevel(nlBlock);
end;

function CaseLevel(const pt: TSourceToken): integer;
begin
  if pt = nil then
    Result := 0
  else
    Result := pt.Nestings.GetLevel(nlCaseSelector);
end;


function SemicolonNext(const pt: TSourceToken): boolean;
var
  lcNext: TSourceToken;
begin
  Result := False;

  if pt <> nil then
  begin
    lcNext := pt.NextSolidToken;
    if lcNext <> nil then
      Result := (lcNext.TokenType = ttSemiColon);
  end;
end;

function InStatements(const pt: TSourceToken): boolean;
begin
  Result := pt.HasParentNode(nStatementList) or pt.HasParentNode(nBlock);
  Result := Result and ( not pt.HasParentNode(nAsm));
end;

function IsCLassHelperWords(const pt: TSourceToken): boolean;
var
  lcNext: TSourceToken;
begin
  Result := (pt.TokenType in [ttClass, ttHelper, ttFor]);

  if Result then
  begin
    { must be just under a class def }
    Result := pt.HasParentNode(nClassType, 1);

    { class not followed by "helper" is not a class helper word }
    if Result and (pt.TokenType = ttClass) then
    begin
      lcNext := pt.NextSolidToken;
      if (lcNext <> nil) and (lcNext.TokenType <> ttHelper) then
        Result := False;
    end;
  end;
end;

function InProcedureDeclarations(const pt: TsourceToken): boolean;
begin
  if pt.HasParentNode(ProcedureNodes) then
  begin
    Result := (pt.HasParentNode(InProcedureDeclSections));
       //or pt.HasParentNode(ProcedureNodes, 1);
  end
  else
    Result := False;
end;

function InDeclarations(const pt: TsourceToken): boolean;
begin
  Result := ( not InStatements(pt)) and ( not pt.HasParentNode(nAsm)) and
    pt.HasParentNode(nDeclSection);
end;

function IsLabelColon(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType = ttColon) and pt.HasParentNode(nStatementLabel, 1);
end;


function IsCaseColon(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType = ttColon) and pt.HasParentNode(nCaseLabels, 1);
end;

function IsFirstSolidTokenOnLine(const pt: TSourceToken): boolean;
begin
  Result := pt.IsSolid and (pt.SolidTokenOnLineIndex = 0);
end;

function IsUnaryOperator(const pt: TSourceToken): boolean;
begin
  Result := (pt <> nil) and (pt.TokenType in PossiblyUnarySymbolOperators);
  if not Result then
    exit;

  { now must find if there is another token before it,
    ie true for the minus sign in '-2' but false for '2-2' }

  Result := pt.HasParentNode(nUnaryOp, 1);
end;

function InFormalParams(const pt: TSourceToken): boolean;
begin
  Result := (RoundBracketLevel(pt) = 1) and pt.HasParentNode(nFormalParams);
end;

function IsActualParamOpenBracket(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType = ttOpenBracket) and (pt.HasParentNode(nActualParams, 1));
end;

function IsFormalParamOpenBracket(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType = ttOpenBracket) and (pt.HasParentNode(nFormalParams, 1));
end;


function IsMultiLineComment(const pcToken: TSourceToken): boolean;
begin
  Result := False;

  if pcToken.TokenType <> ttComment then
    exit;

  // double-slash coments are never multiline
  if (pcToken.CommentStyle = eDoubleSlash) then
    exit;

  // otherwise, if it contains a return it's not single line 
  if (Pos(WideString(WideLineBreak), pcToken.SourceCode) <= 0) then
    exit;

  Result := True;
end;

function IsSingleLineComment(const pcToken: TSourceToken): boolean;
begin
  if pcToken.TokenType <> ttComment then
    Result := False
  else
    Result := not IsMultiLineComment(pcToken);
end;

function IsBlankLineEnd(const pcToken: TSourceToken): boolean;
var
  lcPrev: TSourceToken;
begin
  Result := False;
  if (pcToken <> nil) and (pcToken.TokenType = ttReturn) then
  begin
    lcPrev := pcToken.PriorToken;
    Result := (lcPrev <> nil) and (lcPrev.TokenType = ttReturn);
  end;
end;

{ count the number of identifiers in the var decl
  e.g. "var i,j,k,l: integer" has 4 vars
}
function VarIdentCount(const pcNode: TParseTreeNode): integer;
var
  lcIdents: TParseTreeNode;
begin
  Result := 0;
  if pcNode.NodeType <> nVarDecl then
    exit;

  { the ident list is an immediate child of the var node }
  lcIdents := pcNode.GetImmediateChild(nIdentList);
  Assert(lcIdents <> nil);

  Result := IdentListNameCount(lcIdents);
end;

function IdentListNameCount(const pcNode: TParseTreeNode): integer;
var
  liLoop:     integer;
  lcLeafItem: TParseTreeNode;
begin
  Result := 0;
  if pcNode.NodeType <> nIdentList then
    exit;

  {and under it we find words (names), commas and assorted white space
   count the names }
  for liLoop := 0 to pcNode.ChildNodeCount - 1 do
  begin
    lcLeafItem := pcNode.ChildNodes[liLoop];
    if (lcLeafItem is TSourceToken) and
      (TSourceToken(lcLeafItem).TokenType = ttWord) then
      Inc(Result);
  end;
end;

function ProcedureHasBody(const pt: TParseTreeNode): boolean;
var
  lcProcedureNode: TParseTreeNode;
begin
  Result := False;
  if pt = nil then
    exit;

  lcProcedureNode := pt.GetParentNode(ProcedureNodes);
  if lcProcedureNode = nil then
    exit;

  Result := lcProcedureNode.HasChildNode(nBlock, 1);
end;

function IsDfmIncludeDirective(const pt: TSourceToken): boolean;
begin
  // form dfm comment
  Result := (pt.TokenType = ttComment) and AnsiSameText(pt.SourceCode, '{$R *.dfm}') and
    pt.HasParentNode(nImplementationSection, 4);
end;

function IsGenericResIncludeDirective(const pt: TSourceToken): boolean;
begin
  // form dfm comment
  Result := (pt.TokenType = ttComment) and AnsiSameText(pt.SourceCode, '{$R *.res}');
end;


{ get the first child node that is not a space leaf}
function FirstSolidChild(const pt: TParseTreeNode): TParseTreeNode;
var
  liLoop:  integer;
  lcChild: TParseTreeNode;
begin
  Result := nil;
  for liLoop := 0 to pt.ChildNodeCount - 1 do
  begin
    lcChild := pt.ChildNodes[liLoop];

    if (lcChild is TSourceToken) then
    begin
      if TSourceToken(lcChild).IsSolid then
      begin
        Result := lcChild;
        break;
      end;
    end
    else
    begin
      Result := lcChild;
      break;
    end;
  end;
end;

{ these uses clauses can specify file names for the units }
function InFilesUses(const pt: TParseTreeNode): boolean;
begin
  Assert(pt <> nil);
  Result := pt.HasParentNode(nUses) and
    pt.HasParentNode([nProgram, nPackage, nLibrary]);
end;

function Root(const pt: TParseTreeNode): TParseTreeNode;
begin
  Result := pt;
  while (Result <> nil) and (Result.Parent <> nil) do
    Result := Result.Parent;
end;

function JCFUnitName(const pt: TParseTreeNode): string;
var
  lcRoot: TParseTreeNode;
  lcUnitHeader: TParseTreeNode;
  lcName: TSourceToken;
begin
  Result := '';

  { go to the top }
  lcRoot := Root(pt);
  if lcRoot = nil then
    exit;

  { find the unit header }
  lcUnitHeader := lcRoot.GetImmediateChild(nUnitHeader);
  if lcUnitHeader = nil then
    exit;

  { tokens therein are of the form 'program foo' or 'unit bar' }
  lcName := TSourceToken(lcUnitHeader.FirstLeaf);
  lcName := lcName.NextSolidToken;
  if lcName = nil then
    exit;

  if (lcName.TokenType = ttWord) then
    Result := lcName.SourceCode;
end;

function IsIdentifierToken(const pt: TSourceToken; const peStrictness: TIdentifierStrictness): boolean;
const
  DIRECTIVE_IDENTIFIER_NAMES = [ttOut, ttOperator, ttHelper, ttSealed, ttStatic, ttUnsafe, ttAbstract];
begin
  if pt = nil then
  begin
    Result := False;
    exit;
  end;

  if pt.WordType in IdentifierTypes then
  begin
    Result := True;
    exit;
  end;

  case peStrictness of
    idStrict:
      // accept only identifier names
      Result := False;
    idAllowDirectives:
      // also accept directives
      Result := (pt.TokenType in DIRECTIVE_IDENTIFIER_NAMES);
    idAny:
      // accept any textual token
      Result := StrIsAlpha(pt.SourceCode);
    else
    begin
      Result := False;
      Assert(false);
    end;
  end;

end;

function IsIdentifier(const pt: TSourceToken; const peStrictness: TIdentifierStrictness): boolean;
begin
  Result := IsIdentifierToken(pt, peStrictness);

  if Result then
    Result := pt.HasParentNode(nIdentifier, 1);
end;

function IsSymbolOperator(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType in Operators) and (not StrIsAlpha(pt.SourceCode));
end;

function IsClassDirective(const pt: TSourceToken): boolean;
begin
  { property Public: Boolean;
    function Protected: Boolean
    are both legal so have to check that we're not in a property or function def. }

  Result := (pt.TokenType in ClassDirectives) and
    pt.HasParentNode(nClassVisibility, 1) and
    ( not (pt.HasParentNode(ProcedureNodes + [nProperty])));

end;

function IsTAGComment(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType = ttComment) and (pt.CommentStyle in TAG_COMMENTS);
end;
function IsCurlyComment(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType = ttComment) and (pt.CommentStyle = eCurlyBrace);
end;

function IsBracketStarComment(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType = ttComment) and (pt.CommentStyle = eBracketStar);
end;

function IsBlockComment(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType = ttComment) and ((pt.CommentStyle = eCurlyBrace) or
    (pt.CommentStyle = eBracketStar));
end;

function IsStandardComment(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType = ttComment) and (pt.CommentStyle = eStandard);
end;

function IsHintDirective(const pt: TSourceToken): boolean;
begin
  Result := (pt <> nil) and (pt.TokenType in HintDirectives);

  if Result then
    Result := pt.HasParentNode(nHintDirectives, 1);
end;

function IsPropertyDirective(const pt: TSourceToken): boolean;
begin
  Result := (pt <> nil) and (pt.TokenType in PropertyDirectives);

  if Result then
    Result := (pt.HasParentNode(nPropertySpecifier, 1));
end;

{ directives can occur in other contexts - they are valid proc & variable names
  so we need to know if this one was parsed as a directive }
function IsDirectiveInContext(const pt: TSourceToken): Boolean;
begin
  Result := pt.HasParentNode(DirectiveNodes) or
    IsPropertyDirective(pt) or IsClassDirective(pt) or IsHintDirective(pt);
end;

function StartsLiteralString(const pt: TSourceToken): boolean;

  function InLiteralString(const pt: TSourceToken): boolean;
  begin
    Result := (pt <> nil) and pt.HasParentNode(nLiteralString, 2);
  end;

begin
  Result := (pt.TokenType in LiteralStringStarters) and InLiteralString(pt);
  if Result then
  begin
    // is this actually the first solid token in the literal string?
    Result := not InLiteralString(pt.PriorToken);
  end;
end;

{ true if this token is preceeded or followed by a non-empty whitespace }
function NextToWhiteSpace(const pt: TSourceToken): Boolean;
var
  lcPrior, lcNext: TSourceToken;
begin
  if pt = nil then
  begin
    Result := False;
  end
  else
  begin
    lcPrior := pt.PriorToken;
    Result := (lcPrior <> nil) and (lcPrior.TokenType = ttWhiteSpace) and (lcPrior.SourceCode <> '');

    if not Result then
    begin
      lcNext := pt.NextToken;
      Result := (lcNext <> nil) and (lcNext.TokenType = ttWhiteSpace) and (lcNext.SourceCode <> '');
    end;
  end;
end;

{
function CompilerDirectiveLineBreak(const pt: TSourceToken; const pbBefore: Boolean): TTriOptionStyle;
begin
  if InStatements(pt) then
  begin
    if pbBefore then
      Result := FormatSettings.Returns.BeforeCompilerDirectStatements
    else
      Result := FormatSettings.Returns.AfterCompilerDirectStatements;
  end
  else if pt.HasParentNode(nUses)  then
  begin
    if pbBefore then
      Result := FormatSettings.Returns.BeforeCompilerDirectUses
    else
      Result := FormatSettings.Returns.AfterCompilerDirectUses;
  end
  else
  begin
    if pbBefore then
      Result := FormatSettings.Returns.BeforeCompilerDirectGeneral
    else
      Result := FormatSettings.Returns.AfterCompilerDirectGeneral;
  end;
end;
}

function IsComment(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType = ttComment);
end;

function IsSlashComment(const pt: TSourceToken): boolean;
begin
  Result := (pt.TokenType = ttComment) and (pt.CommentStyle = eDoubleSlash);
end;


{function CanFollowTAGComment(const pts: TTokenTypeSet): boolean;
begin
  result:= (pts *(ProcedureWords + [ttUnit])<>[];
end;

// Token that can be followed by TAG comments are
// Procedure, Function, Constructor, Destructor
// Unit
function CanFollowTAGComment(const pt: TSourceToken): boolean;
begin
  result:= pt.TokenType in (ProcedureWords + [ttUnit]);
end;
}

// Return True if inside program / library or Implementation's unit
function IsInImplementationPart(const pcNode: TParseTreeNode): boolean;
begin
   if(pcNode.HasParentNode(TopOfProgramSections)) then
   begin
     // Inside a program / library / Package, so as inside an implementation section
     Result := True;
   end
   else
   begin
     // So we are inside a unit
     Result := pcNode.HasParentNode(nImplementationSection);
   end;
end;

function IsDottedProcedureName(const phNode : TParseTreeNode): boolean;
var
  Node: TParseTreeNode;
begin
  Result := False;
  if (phNode.NodeType in ProcedureHeadings) and (phNode.HasChildNode(nIdentifier)) then
  begin
    Node := phNode.GetImmediateChild(nIdentifier);
    // Node is NIL for procedure/function type declarations
    if (Node <> nil) then
    begin
      // Skip generics
      if(Node.HasChildNode(nGeneric)) then
       Result := ((Node.GetImmediateChild(nGeneric).NextLeafNode as TSourceToken).TokenType = ttDot)
      else // normal node
       Result := ((Node.FirstSolidLeaf as TSourceToken).NextSolidToken.TokenType = ttDot);
    end;
  end;
end;

{*------------------------------------------------------------------------------
  Get a dotted identifier list from anode
  @param   idNode  Node currently processed (TParseTreeNode)
  @return  the identifier name
-------------------------------------------------------------------------------}
function GetDottedIdentifier(const idNode: TObject): string;
var
  lcNode:     TParseTreeNode;
  IndexChild: integer;
begin
  lcNode := TParseTreeNode(idNode);
  assert(lcNode.NodeType = nDottedIdentifier);
  Result := '';
  for IndexChild := 0 to lcNode.ChildNodeCount - 1 do
  begin
    if lcNode.ChildNodes[IndexChild].NodeType = nIdentifier then
    begin
      if Result <> '' then
       Result := Result + '.';
       Result := Result + lcNode.ChildNodes[IndexChild].FirstSolidLeaf.Describe;
    end;
  end;
end;

function GetNextIdentifierNode(const idNode: TObject): string;
var
  lcNode:     TParseTreeNode;
  IndexChild: integer;
begin
  lcNode := TParseTreeNode(idNode);
  assert(lcNode.NodeType = nDottedIdentifier);
  Result := '';
  for IndexChild := 0 to lcNode.ChildNodeCount - 1 do
  begin
    if lcNode.ChildNodes[IndexChild].NodeType = nIdentifier then
    begin
      if Result <> '' then
       Result := Result + '.';
       Result := Result + lcNode.ChildNodes[IndexChild].FirstSolidLeaf.Describe;
    end;
  end;
end;

{*------------------------------------------------------------------------------
  Get an identifier list from anode
  @param   idNode  Node currently processed (TParseTreeNode)
  @param   idList  The StringList to add the identifiers name
-------------------------------------------------------------------------------}
function GetIdentList(const idNode: TObject;
  const idList: TStringList): integer;
var
  lcNode:     TParseTreeNode;
  IndexChild: integer;
  tmpIdentifier : string;
begin
  assert(idList <> nil);
  lcNode := TParseTreeNode(idNode);
  assert(lcNode.NodeType = nIdentList);
  for IndexChild := 0 to lcNode.ChildNodeCount - 1 do
  begin
    tmpIdentifier := '';
    if lcNode.ChildNodes[IndexChild].NodeType = nIdentifier then
     tmpIdentifier := lcNode.ChildNodes[IndexChild].FirstSolidLeaf.Describe
    else
     if (lcNode.ChildNodes[IndexChild].NodeType = nDottedIdentifier) then
      tmpIdentifier := GetDottedIdentifier(lcNode.ChildNodes[IndexChild]);
    // Skip empty identifier if Child is comma
    if tmpIdentifier <> '' then idList.Add(tmpIdentifier);
  end;
  Result := idList.Count;
end;

function GetSingleIdentifier(const idNode: TObject): string;
var
  lcNode:  TParseTreeNode;
begin
  lcNode := TParseTreeNode(idNode);
  if(lcNode.NodeType = nDottedIdentifier) then result:=GetDottedIdentifier(idNode)
  else
  begin
    if(lcNode.HasChildNode(nDottedIdentifier,1)) then
     result:=GetDottedIdentifier(lcNode.GetImmediateChild(nDottedIdentifier))
    else Result:=lcNode.FirstSolidLeaf.Describe;
  end;
end;

function IsInsideAsm(const pt: TSourceToken): boolean;
begin
   Result := pt.HasParentNode(nAsm) and not (pt.TokenType in [ttAsm, ttEnd]);
end;

function HasAsmCaps(const pt: TSourceToken): boolean;
begin
  if pt.TokenType = ttComment then
  begin
    Result := False;
  end
  else
  begin
    Result := pt.HasParentNode(nAsmOpcode, 2) or IsAsmParamKeyword(pt.SourceCode);
  end;
end;

end.
