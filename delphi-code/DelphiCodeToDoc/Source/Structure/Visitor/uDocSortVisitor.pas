{*------------------------------------------------------------------------------
  Sort visitor for TDOCTemplate class
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
-------------------------------------------------------------------------------}
unit uDocSortVisitor;

interface

uses
  Windows, SysUtils, Classes, Contnrs,
  uDocBaseVisitor, uDocTemplate, uOptions;

type

  /// Sort class visitor
  TDOCSortVisitor = class(TDOCBaseVisitor)
  protected
    procedure DoVisit(const DocTemplate : TDOCTemplate; const DocListOwner : TDOCTemplateList);override;
    procedure DoVisit(const DocTemplateList : TDOCTemplateList;
     const DocOwnerList : TDOCTemplate);override;
  public
    constructor Create(const DocOptions : TDOCOptions);override;
    destructor Destroy;override;
  end;

implementation

uses
  ComCtrls;

{ TDOCVisitor }

constructor TDOCSortVisitor.Create(const DocOptions : TDOCOptions);
begin
  inherited;
  FDeepFirst := False;
end;

destructor TDOCSortVisitor.Destroy;
begin
  inherited;
end;

procedure TDOCSortVisitor.DoVisit(const DocTemplateList: TDOCTemplateList;
 const DocOwnerList : TDOCTemplate);
begin
  if not(DocTemplateList is TDOCParameterList) then
  begin
    // What to do with DocTemplate !
    DocTemplateList.Sort(DocTemplateListSortCompare);
  end;
end;

procedure TDOCSortVisitor.DoVisit(const DocTemplate: TDOCTemplate; const DocListOwner : TDOCTemplateList);
begin
  // Nothing
end;

end.
