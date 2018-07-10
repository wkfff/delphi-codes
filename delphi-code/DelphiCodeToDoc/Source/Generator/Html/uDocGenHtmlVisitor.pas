{*------------------------------------------------------------------------------
  Visitor for HTML generator
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
-------------------------------------------------------------------------------}
unit uDocGenHtmlVisitor;

interface

uses
  SysUtils, Classes,
  uDocGeneratorVisitor, uDocTemplate, uDocClassTree, uDocMember, Tokens,
  uDocMethod, uOptions;

type
  { TODO -oTridenT -cRefactoring : Separate Generator from GeneratorVisitor => just linked ? }
  { TODO -oTridenT -cBug : Encapsulate HTMLBuildLink() to test if DocTemplate is filtered or not (display only text, no link) }
  /// Visitor class for Html generator
  TDocGenHtmlVisitor = class(TDOCGeneratorVisitor)
  private
  // --------------------------------------------
  protected
    function IsVisitEnabled(const DocTemplate : TDOCTemplate) : Boolean; override;
    function IsVisitEnabled(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate) : Boolean; override;
  end;

implementation

uses
  uDocParameter;


function TDocGenHtmlVisitor.IsVisitEnabled(
  const DocTemplate: TDOCTemplate): Boolean;
begin
  Result := inherited IsVisitEnabled(DocTemplate);
  // Ignore parameters - no page for parameter, describe with methods !
  Result := Result and not (DocTemplate is TDOCParameter);
end;

function TDocGenHtmlVisitor.IsVisitEnabled( const DocTemplateList: TDOCTemplateList;
  const DocOwnerList: TDOCTemplate): Boolean;
begin
  Result := inherited IsVisitEnabled(DocTemplateList, DocOwnerList);
end;

end.
