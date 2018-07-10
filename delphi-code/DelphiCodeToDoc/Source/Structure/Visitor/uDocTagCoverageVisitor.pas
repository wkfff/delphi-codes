{*------------------------------------------------------------------------------
  TAG coverage update visitor for TDOCTemplate class
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
-------------------------------------------------------------------------------}
unit uDocTagCoverageVisitor;

interface

uses
  Windows, SysUtils, Classes, Contnrs,
  uDocBaseVisitor, uDocTemplate, uOptions;

type

  TDOCTagCoverageVisitor = class(TDOCBaseVisitor)
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
    function IsVisitEnabled(const DocTemplate : TDOCTemplate) : Boolean; override;
  public
    constructor Create(const DocOptions : TDOCOptions);override;
    destructor Destroy;override;
  end;

implementation

uses
  ComCtrls,
  uDocMember;

{ TDOCVisitor }

procedure TDOCTagCoverageVisitor.AfterVisit(const DocTemplate: TDOCTemplate);
begin
  if(assigned(DocTemplate.RelatedParent)) then
  begin
    DocTemplate.RelatedParent.TagCoverageHolder.AddChildStats(DocTemplate.TagCoverageHolder);
  end;
end;

procedure TDOCTagCoverageVisitor.AfterVisit(
  const DocTemplateList: TDOCTemplateList; const DocOwnerList: TDOCTemplate);
begin

end;

procedure TDOCTagCoverageVisitor.BeforeFullVisit;
begin
  // This Visitor is a Deep first !
  FDeepFirst := True;
end;

procedure TDOCTagCoverageVisitor.BeforeVisit(const DocTemplate: TDOCTemplate);
begin
  // Reset childs and self statistics
  DocTemplate.TagCoverageHolder.SelfStats.InitStats;
  DocTemplate.TagCoverageHolder.ChildsStats.InitStats;
  DocTemplate.TagCoverageHolder.TotalStats.InitStats;
end;

procedure TDOCTagCoverageVisitor.BeforeVisit(
  const DocTemplateList: TDOCTemplateList; const DocOwnerList: TDOCTemplate);
begin

end;

constructor TDOCTagCoverageVisitor.Create(const DocOptions : TDOCOptions);
begin
  inherited;
end;

destructor TDOCTagCoverageVisitor.Destroy;
begin
  inherited;
end;

procedure TDOCTagCoverageVisitor.DoVisit(const DocTemplateList: TDOCTemplateList;
 const DocOwnerList : TDOCTemplate);
begin
  // Nothing
end;

function TDOCTagCoverageVisitor.IsVisitEnabled(
  const DocTemplate: TDOCTemplate): Boolean;
begin
  Result := inherited IsVisitEnabled(DocTemplate);
  if(Result = True) then
  begin
    Result := EvaluateItemDisplay(DocTemplate);
  end;
end;

procedure TDOCTagCoverageVisitor.DoVisit(const DocTemplate: TDOCTemplate; const DocListOwner : TDOCTemplateList);
begin
  // What to do with DocTemplate !
  DocTemplate.UpdateTagCoverage;
end;

end.
