unit TGGCModel;
interface
type
  TGGCModel = class(TGrandRefCntIntfObject, IGGCModel)
  private
    FGSPModel: IGSPModel;
    FRegions: IGGCRegions;
    FElements: IGGCElements;
    FElementDrawObjs: IGGCElementDrawObjs;
    FCADElementDrawObjs: IGGCCADEdoContainer;
    function GetGSPModel: IGSPModel;
    function GetRegions: IGGCRegions;
    function GetElements: IGGCElements;
    function GetElementDrawObjs: IGGCElementDrawObjs;
    function GetCADElementDrawObjs: IGGCCADEdoContainer;
  public
    constructor Create(const AProjectModel, ASysInfo, AParamPolyModel: IGSPModel;
        const AProductCode: string; const AGEPEngine: IGEPEngine; ARepairMode:
        Boolean = False; const AProcessBadRecord: TProcessBadRecord4LoadData = nil);
    destructor Destroy; override;
    function NewTempCADElementDrawObjs: IGGCCADEdoContainer;
    property ProjectModel: IGSPModel read GetGSPModel;
  end;
implementation
constructor TGGCModel.Create(const AProjectModel, ASysInfo, AParamPolyModel:
    IGSPModel; const AProductCode: string; const AGEPEngine: IGEPEngine;
    ARepairMode: Boolean = False; const AProcessBadRecord:
    TProcessBadRecord4LoadData = nil);
begin
  Assert(AProjectModel <> nil);
  Assert(ASysInfo <> nil);
  Assert(AProductCode <> '');
  Assert(AGEPEngine <> nil);

  FGSPModel := AProjectModel;
  FRegions := TGGCRegionsFactory.CreateRegions(AProjectModel.FindTable(pdbBusiness, ptnElement));
  //ARepairMode, AProcessBadRecord两个函数改成变量
  FElements := TGGCElements.Create(FRegions,
      AProjectModel.Find(pdbBusiness),
      AProjectModel.Find(AProductCode),
      AParamPolyModel,
      AGEPEngine, ASysInfo);

  FElementDrawObjs := TGGCElementDrawObjs.Create(FRegions, FElements,
      AProjectModel.FindTable(pdbBusiness, ptnElementDrawObj),
      AProjectModel.FindTable(AProductCode, ptnElementDrawObj),
      ASysInfo,
      AGEPEngine,
      AParamPolyModel);
//
//  FCADElementDrawObjs := TGGCCADEdoContainer.Create(FElementDrawObjs,
//      AProjectModel.FindTable(pdbBusiness, ptnCADOptions),
//      Self);
//  InitElementRefManager(ASysInfo.FindTable('DB', 'ElementReferenceDict'));
end;
destructor TGGCModel.Destroy;
begin
// FinalizeElementRefManager;
  FCADElementDrawObjs := nil;
  FElementDrawObjs := nil;   
  FElements := nil;
  FRegions := nil;
  inherited;
end;
function TGGCModel.GetCADElementDrawObjs: IGGCCADEdoContainer;
begin
  Result := FCADElementDrawObjs;
end;
function TGGCModel.GetElementDrawObjs: IGGCElementDrawObjs;
begin
  Result := FElementDrawObjs;
end;
function TGGCModel.GetElements: IGGCElements;
begin
  Result := FElements;
end;
function TGGCModel.GetGSPModel: IGSPModel;
begin
  result := FGSPModel;
end;
function TGGCModel.GetRegions: IGGCRegions;
begin
  Result := FRegions;
end;
function TGGCModel.NewTempCADElementDrawObjs: IGGCCADEdoContainer;
begin
//  Result := TGGCCADEdoContainer.Create(FElementDrawObjs,
//    FGSPModel.FindTable(pdbBusiness, ptnCADOptions), Self, True);
end;
