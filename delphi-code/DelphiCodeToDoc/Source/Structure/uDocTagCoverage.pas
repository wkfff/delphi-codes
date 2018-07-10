{*------------------------------------------------------------------------------
  Handle TAGs statistics and verification
  These information are valid for one DocTemplate

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2007/01/04   TridenT   Initial revision
-------------------------------------------------------------------------------}
unit uDocTagCoverage;

interface

uses
  Windows, SysUtils, Classes, Contnrs, uTAGComment, Generics.Collections;

type
  /// Evaluation of tags count and documented tags count
  TTagCoverageItem = class
  private
    FEvaluatedCount : integer; /// Number of imperative TAGs detected
    FDocumentedCount : integer; /// Number of imperative TAGs documented
  public
    property EvaluatedCount : integer read FEvaluatedCount;
    property DocumentedCount : integer read FDocumentedCount;
    procedure InitStats;
    procedure AddEvaluation(const bIsDocumented : Bool);
    function GetDocumentedTagRatio : double;
    procedure AddStats(const Eval, Doc : integer);
  end;

  /// Checked TAG for a DocTemplate element
  TCheckedTagItem = class
  public
    DocTag : TDOCTag;  /// Tag identifier
    subID : string;  /// Additional Text identifier (used mainly for parameters)
    bIsDocumented : Boolean;  /// True if TAG is documented
  end;

  TCheckedTagList = class(TObjectList<TCheckedTagItem>);

  /// Tag coverage class holder
  TTagCoverageHolder = class
  private
    FSelfStats : TTagCoverageItem; /// Statistics for this item
    FChildsStats : TTagCoverageItem; /// Statistics for all childs item
    FTotalStats : TTagCoverageItem; /// Total Statistics including childs
    FCheckedTagList : TCheckedTagList; /// List of checked Tags (of TCheckedTagItem)
  public
    property SelfStats : TTagCoverageItem read FSelfStats;
    property ChildsStats : TTagCoverageItem read FChildsStats;
    property TotalStats : TTagCoverageItem read FTotalStats;
    property CheckedTagList : TCheckedTagList Read FCheckedTagList;
    constructor Create;virtual;
    destructor Destroy;override;
    procedure Clear;
    procedure AddEvaluation(const DocTag : TDOCTag; const bDocumented : Boolean;
     const subID : string = '');
    procedure AddChildStats(const ChildHolderStats: TTagCoverageHolder);
  end;

implementation

{ TTagCoverageItem }

{*------------------------------------------------------------------------------
  Add an evaluation of a TAG and update statistics
  @param bIsDocumented TRUE if the tag is documented
-------------------------------------------------------------------------------}
procedure TTagCoverageItem.AddEvaluation(const bIsDocumented: Bool);
begin
  // Increase number of evaluated TAG (imperative)
  inc(FEvaluatedCount);
  // Increase number of documented TAG if so
  if( bIsDocumented = True) then inc(FDocumentedCount);
end;

{*------------------------------------------------------------------------------
  Add statistics directly
  @param Eval Number of evaluated tags
  @param Doc Number of docmented tags
-------------------------------------------------------------------------------}
procedure TTagCoverageItem.AddStats(const Eval, Doc: integer);
begin
  inc(FEvaluatedCount, Eval);
  inc(FDocumentedCount, Doc);
end;

{*------------------------------------------------------------------------------
  Get tag coverage statistics (Documented / Evaluated)
  @return Percentage of documented TAGs
-------------------------------------------------------------------------------}
function TTagCoverageItem.GetDocumentedTagRatio: double;
begin
   if(FEvaluatedCount = 0) then Result := 100.0
   else Result := (FDocumentedCount * 100.0) / FEvaluatedCount;
end;

procedure TTagCoverageItem.InitStats;
begin
  FEvaluatedCount := 0;
  FDocumentedCount := 0;
end;

{ TTagCoverageHolder }

procedure TTagCoverageHolder.AddChildStats(const ChildHolderStats: TTagCoverageHolder);
begin
  FChildsStats.AddStats(ChildHolderStats.TotalStats.EvaluatedCount,
   ChildHolderStats.TotalStats.FDocumentedCount);
  FTotalStats.AddStats(ChildHolderStats.TotalStats.EvaluatedCount,
   ChildHolderStats.TotalStats.FDocumentedCount);
end;

procedure TTagCoverageHolder.AddEvaluation(const DocTag: TDOCTag;
  const bDocumented: Boolean; const subID: string);
var
  NewTagVerify : TCheckedTagItem;
begin
  // Increase number of evaluated TAG (imperative)
  FSelfStats.AddEvaluation(bDocumented);
  FTotalStats.AddEvaluation(bDocumented);
  // Add TAG to verified list
  NewTagVerify := TCheckedTagItem.Create;
  NewTagVerify.DocTag := DocTag;
  NewTagVerify.subID := subID;
  NewTagVerify.bIsDocumented := bDocumented;
  FCheckedTagList.Add(NewTagVerify);
end;

/// Clear all statistics
procedure TTagCoverageHolder.Clear;
begin
  FSelfStats.InitStats;
  FChildsStats.InitStats;
  FTotalStats.InitStats;
  FCheckedTagList.Clear;
end;

constructor TTagCoverageHolder.Create;
begin
  FSelfStats := TTagCoverageItem.Create;
  FChildsStats := TTagCoverageItem.Create;
  FTotalStats :=TTagCoverageItem.Create;
  FCheckedTagList := TCheckedTagList.Create(True);
end;

destructor TTagCoverageHolder.Destroy;
begin
  FreeAndNil(FSelfStats);
  FreeAndNil(FChildsStats);
  FreeAndNil(FTotalStats);
  FreeAndNil(FCheckedTagList);
  inherited;
end;

end.
