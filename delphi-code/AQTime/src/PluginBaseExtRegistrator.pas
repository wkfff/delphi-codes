// =============================================================================================
// AutomatedQA SDK - Copyright (c) AutomatedQA Corp.
//
// This file is part of AutomatedQA SDK
//
// =============================================================================================

unit PluginBaseExtRegistrator;

interface

uses
  Classes, {$I uses.inc};

const
  CreateRegistratorFunctionName = 'GetPluginRegistrator';

type
  TCreateRegistratorFunction = function () : IaqExtensionRegistrator; safecall;

  TPluginDescription = class;

  PRegPluginInfo = ^TRegPluginInfo;
  TRegPluginInfo = record
    Key: TGuid;
    Name: WideString;
    Description: WideString;
    Conflicts: WideString;
    Depends: WideString;
    Version: AQ_PLUGIN_VERSION;
  end;

  TaqBaseExtensionRegistrator = class(TInterfacedObject,
                                      IaqKeyItem,
                                      IaqExtensionRegistrator)
  protected
    FPlugins: TList;
    function GetPluginIndexByGUID(GUID: TGuid): Integer;

    // this function must create instance of IaqBasePlugin by it description
    function CreatePluginByDescription(const PluginDescription: TPluginDescription): IaqBasePlugin; virtual; abstract;
    function AddPluginInfo(const PluginInfo : TRegPluginInfo;
                           ACustomData: Pointer;
                           DefaultSelected: Boolean) : TPluginDescription;

    { IaqKeyItem }
    procedure GetKey(out Value: TGUID); virtual; stdcall; abstract;

    { IaqExtensionRegistrator }
    function Get_Name: WideString; virtual; safecall; abstract;
    function Get_Copyright: WideString; virtual; safecall;
    function Get_TargetIntegrationCount: Integer; virtual; safecall; abstract;
    function Get_TargetIntegrationKey(Index: Integer): TGUID; virtual; safecall; abstract;
    function Get_TargetProductCount: Integer; virtual; safecall; abstract;
    function Get_TargetProductKey(Index: Integer): TGUID; virtual; safecall; abstract;
    function Get_PluginCount: Integer; safecall;
    function Get_PluginKey(Index: Integer): TGuid; safecall;
    function Get_PluginName(Index: Integer): WideString; safecall;
    function Get_PluginDescription(Index: Integer): WideString; safecall;
    function Get_PluginVersion(Index: Integer): AQ_PLUGIN_VERSION; safecall;
    function Get_PluginDefaultSelected(Index: Integer): WordBool; safecall;
    function Get_PluginDependencyCount(Index: Integer): Integer; safecall;
    function Get_PluginDependencies(Index: Integer; DependsIndex: Integer): TGuid; safecall;
    function Get_PluginConflictCount(Index: Integer): Integer; safecall;
    function Get_PluginConflicts(Index: Integer; ConflictIndex: Integer): TGuid; safecall;
    function CreatePlugin(Index: Integer): IaqBasePlugin; virtual; safecall;
  public
    constructor Create; 
    destructor Destroy; override;
  end;

  TPluginDescription = class
  private
    function  GetDependCount: Integer;
    function  GetDepends(Index: Integer): TGuid;

    function  GetConflictCount: Integer;
    function  GetConflicts(Index: Integer): TGuid;
  protected
    FKey: TGuid;
    FName: WideString;
    FDescription: WideString;
    FConflicts: array of TGuid;
    FDepends: array of TGuid;
    FVersion: AQ_PLUGIN_VERSION;
    FSelected: Boolean;
    FCustomData : Pointer;
  public
    constructor Create;
    destructor Destroy; override;

    property Key: TGuid read FKey;
    property Name: WideString read FName;
    property Description: WideString read FDescription;
    property ConflictCount: Integer read GetConflictCount;
    property Conflicts[Index: Integer]: TGuid read GetConflicts;
    property DependCount: Integer read GetDependCount;
    property Depends[Index: Integer]: TGuid read GetDepends;
    property Version: AQ_PLUGIN_VERSION read FVersion;
    property Selected: Boolean read FSelected;
    property CustomData: Pointer read FCustomData;
  end;


implementation

uses
  SysUtils;


{*************************** TPluginDescription *******************************}
constructor TPluginDescription.Create;
begin
  inherited Create;
  SetLength(FConflicts, 0);
  SetLength(FDepends, 0);
  FSelected := False;
end;

destructor TPluginDescription.Destroy;
begin
  SetLength(FConflicts, 0);
  SetLength(FDepends, 0);
  inherited Destroy;
end;

function  TPluginDescription.GetConflictCount: Integer;
begin
  Result := Length(FConflicts);
end;

function  TPluginDescription.GetDependCount: Integer;
begin
  Result := Length(FDepends);
end;

function  TPluginDescription.GetConflicts(Index: Integer): TGuid;
begin
  Result := FConflicts[Index];
end;


function  TPluginDescription.GetDepends(Index: Integer): TGuid;
begin
  Result := FDepends[Index];
end;


{*************************** TaqBaseExtensionRegistrator **********************}
constructor TaqBaseExtensionRegistrator.Create;
begin
  inherited Create;
  FPlugins := TList.Create();
end;

destructor TaqBaseExtensionRegistrator.Destroy;
var i: Integer;
begin
  for i := FPlugins.Count - 1 downto 0 do
  begin
    TObject(FPlugins[i]).Free;
    FPlugins.Delete(i);
  end;
  FreeAndNil(FPlugins);
  inherited;
end;

function TaqBaseExtensionRegistrator.AddPluginInfo(const PluginInfo : TRegPluginInfo;
               ACustomData: Pointer; DefaultSelected: Boolean) : TPluginDescription;
var StringList: TStringList;
    i: Integer;
begin
  Assert(GetPluginIndexByGUID(PluginInfo.Key) = -1);

  Result := TPluginDescription.Create;
  with Result do
  begin
    FKey := PluginInfo.Key;
    FName := PluginInfo.Name;
    FDescription := PluginInfo.Description;
    FVersion := PluginInfo.Version;
    FSelected := DefaultSelected;
    FCustomData := ACustomData;

    StringList := TStringList.Create;
    try
      if PluginInfo.Depends <> '' then
      begin
        StringList.Text := PluginInfo.Depends;
        SetLength(FDepends, StringList.Count);
        for i := 0 to StringList.Count - 1 do
          FDepends[i] := StringToGuid(StringList[i]);
      end;

      if PluginInfo.Conflicts <> '' then
      begin
        StringList.Text := PluginInfo.Conflicts;
        SetLength(FConflicts, StringList.Count);
        for i := 0 to StringList.Count - 1 do
          FConflicts[i] := StringToGuid(StringList[i]);
      end;
    finally
      StringList.Free;
    end;
  end;
  FPlugins.Add(Result);
end;


function TaqBaseExtensionRegistrator.GetPluginIndexByGUID(GUID: TGuid): Integer;
var i: Integer;
begin
  Result := -1;
  for i := 0 to FPlugins.Count - 1 do
  begin
    if IsEqualGUID(TPluginDescription(FPlugins[i]).Key, GUID) then
    begin
      Result := i;
      break;
    end;
  end;
end;


{IaqExtensionRegistrator}

function TaqBaseExtensionRegistrator.Get_Copyright: WideString;
begin
  Result := '';
end;

function TaqBaseExtensionRegistrator.Get_PluginCount: Integer;
begin
  Result := FPlugins.Count;
end;

function TaqBaseExtensionRegistrator.Get_PluginKey(Index: Integer): TGuid;
begin
  Assert( (Index >= 0) and (Index < FPlugins.Count) );
  Result := TPluginDescription(FPlugins[Index]).Key;
end;

function TaqBaseExtensionRegistrator.Get_PluginName(Index: Integer): WideString;
begin
  Assert( (Index >= 0) and (Index < FPlugins.Count) );
  Result := TPluginDescription(FPlugins[Index]).Name;
end;

function TaqBaseExtensionRegistrator.Get_PluginDescription(Index: Integer): WideString;
begin
  Assert( (Index >= 0) and (Index < FPlugins.Count) );
  Result := TPluginDescription(FPlugins[Index]).Description;
end;

function TaqBaseExtensionRegistrator.Get_PluginVersion(Index: Integer): AQ_PLUGIN_VERSION;
begin
  Assert( (Index >= 0) and (Index < FPlugins.Count) );
  Result := TPluginDescription(FPlugins[Index]).Version;
end;

function  TaqBaseExtensionRegistrator.Get_PluginDefaultSelected(Index: Integer): WordBool;
begin
  Assert( (Index >= 0) and (Index < FPlugins.Count) );
  Result := TPluginDescription(FPlugins[Index]).Selected;
end;

function  TaqBaseExtensionRegistrator.Get_PluginDependencyCount(Index: Integer): Integer;
begin
  Assert( (Index >= 0) and (Index < FPlugins.Count) );
  Result := TPluginDescription(FPlugins[Index]).DependCount;
end;

function  TaqBaseExtensionRegistrator.Get_PluginDependencies(Index: Integer; DependsIndex: Integer): TGuid;
begin
  Assert( (Index >= 0) and (Index < FPlugins.Count) );
  Assert( (DependsIndex >=0) and (DependsIndex < TPluginDescription(FPlugins[Index]).DependCount) );
  Result := TPluginDescription(FPlugins[Index]).Depends[DependsIndex];
end;

function  TaqBaseExtensionRegistrator.Get_PluginConflictCount(Index: Integer): Integer;
begin
  Assert( (Index >= 0) and (Index < FPlugins.Count) );
  Result := TPluginDescription(FPlugins[Index]).ConflictCount;
end;

function  TaqBaseExtensionRegistrator.Get_PluginConflicts(Index: Integer; ConflictIndex: Integer): TGuid;
begin
  Assert( (Index >= 0) and (Index < FPlugins.Count) );
  Assert( (ConflictIndex >=0) and (ConflictIndex < TPluginDescription(FPlugins[Index]).ConflictCount) );
  Result := TPluginDescription(FPlugins[Index]).Conflicts[ConflictIndex];
end;

function  TaqBaseExtensionRegistrator.CreatePlugin(Index: Integer): IaqBasePlugin;
begin
  Assert((Index >= 0) and (Index < FPlugins.Count));

  Result := CreatePluginByDescription(TPluginDescription(FPlugins[Index]));
end;


end.
