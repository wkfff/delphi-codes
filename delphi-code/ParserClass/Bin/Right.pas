unit TGGCModel;
interface
type
  TGGCModel = class(TGGCSModel, IGGCModel)
  private
    FGSPModel: IGSPModel;
    FRegions: IGGCRegions;
    FElements: IGGCElements;
    FElementDrawObjs: IGGCElementDrawObjs;
    FCADElementDrawObjs: IGGCCADEdoContainer;
    FCommandCenter: IGGCCommandCenter;
    FCADCommandProvider: IGGCCADCommandProvider;
    function GetGSPModel: IGSPModel;
    function GetRegions: IGGCRegions;
    function GetElements: IGGCElements;
    function GetElementDrawObjs: IGGCElementDrawObjs;
    function GetCADElementDrawObjs: IGGCCADEdoContainer;
    function GetCommandCenter: IGGCBaseCommandCenter;
    function CreateGSPCommand(ACommandKind: TGSPCommandKind): IGSPCommand;
    function CreateCommand(ACommandKind: Integer): IInterface;
    function FetchCommand: IInterface;
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
var
  oElementTypeDict: IGSPView;
begin
  Assert(AProjectModel <> nil);
  Assert(ASysInfo <> nil);
  Assert(AProductCode <> '');
  Assert(AGEPEngine <> nil);

  FGSPModel := AProjectModel;
  FRegions := TGGCRegions.Create(AProjectModel.FindTable(pdbBusiness, ptnElement));

  oElementTypeDict := ASysInfo.FindTable(pdbDB, ptnElementTypeDict).
      CreateStaticView();

  FElements := TGGCElements.Create(FRegions,
      oElementTypeDict,
      AProjectModel.Find(pdbBusiness),
      AProjectModel.Find(AProductCode),
      AParamPolyModel,
      AGEPEngine, ASysInfo,
      ARepairMode, AProcessBadRecord);
  //传入系统库 renjw 09.5.18 Fix Bug 2510
//  FElements.SysInfo := ASysInfo;

  FElementDrawObjs := TGGCElementDrawObjs.Create(FRegions, FElements,
      AProjectModel.FindTable(pdbBusiness, ptnElementDrawObj),
      AProjectModel.FindTable(AProductCode, ptnElementDrawObj),
      ASysInfo,
      AGEPEngine,
      AParamPolyModel,
      ARepairMode, AProcessBadRecord);

  FCADElementDrawObjs := TGGCCADEdoContainer.Create(FElementDrawObjs,
      AProjectModel.FindTable(pdbBusiness, ptnCADOptions),
      Self);

  FCommandCenter := TGGCCommandCenter.Create(True, CreateGSPCommand);
  FCADCommandProvider := TGGCCADCommandProvider.Create(FCADElementDrawObjs);
  FCommandCenter.CADCommandProvider := FCADCommandProvider;
  (GetImplObject(FCADElementDrawObjs) as TGGCCADEdoContainer).CommandCenter := FCommandCenter;

  InitElementRefManager(ASysInfo.FindTable('DB', 'ElementReferenceDict'));
end;
function TGGCModel.CreateCommand(ACommandKind: Integer): IInterface;
begin
  if FCommandCenter <> nil then
    Result := FCommandCenter.CreateCommand(ACommandKind)
  else
    Result := nil;
end;
function TGGCModel.CreateGSPCommand(ACommandKind: TGSPCommandKind): IGSPCommand;
begin
  Result := FGSPModel.CreateCommand(ACommandKind);
end;
destructor TGGCModel.Destroy;
begin
  FCADElementDrawObjs := nil;
  FElementDrawObjs := nil;   
  FElements := nil;
  FRegions := nil;
  FCommandCenter := nil;
  FCADCommandProvider := nil;
  inherited;
end;
function TGGCModel.FetchCommand: IInterface;
begin
  if FCommandCenter <> nil then
    Result := FCommandCenter.FetchCommand
  else
    Result := nil;
end;
function TGGCModel.GetCADElementDrawObjs: IGGCCADEdoContainer;
begin
  Result := FCADElementDrawObjs;
end;
function TGGCModel.GetCommandCenter: IGGCBaseCommandCenter;
begin
  Result := FCommandCenter;
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
  Result := TGGCCADEdoContainer.Create(FElementDrawObjs,
    FGSPModel.FindTable(pdbBusiness, ptnCADOptions), Self, True);
  (GetImplObject(FCADElementDrawObjs) as TGGCCADEdoContainer).CommandCenter := FCommandCenter;
end;
