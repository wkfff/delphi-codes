{*------------------------------------------------------------------------------
  Function type comment fix visitor for TDOCTemplate class
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
-------------------------------------------------------------------------------}
unit uDocFunctionTypeCommentFixVisitor;

interface

uses
  Windows, SysUtils, Classes, Contnrs,
  uDocBaseVisitor, uDocTemplate, uDocClassTree;

type

  /// A visitor that fix function type comment
  TDOCFunctionTypeCommentFixVisitor = class(TDOCBaseVisitor)
  protected
    procedure DoVisit(const DocTemplate : TDOCTemplate; const DocListOwner : TDOCTemplateList);override;
    procedure BeforeFullVisit;override;
  end;

implementation

uses
  ComCtrls,
  uDocMethod, uDocType, uTagComment;

{ TDOCVisitor }

procedure TDOCFunctionTypeCommentFixVisitor.BeforeFullVisit;
begin
  // This Visitor is not a Deep first !
  FDeepFirst := False;
end;

procedure TDOCFunctionTypeCommentFixVisitor.DoVisit(const DocTemplate: TDOCTemplate; const DocListOwner : TDOCTemplateList);
var
  DocFunctionType : TDOCFunctionType;
begin
  // Process only Methods attached to Class
  if(DocTemplate is TDOCFunctionType) then
  begin
    DocFunctionType := DocTemplate as TDOCFunctionType;
    DocFunctionType.TAGHolderList.CopyContent(DocFunctionType.DocFunction.TAGHolderList);
  end;
end;

end.
