// =============================================================================================
// AutomatedQA SDK - Copyright (c) AutomatedQA Corp.
//
// This file is part of AutomatedQA SDK
//
// =============================================================================================

unit BasePlugin;

interface

uses
  PluginBaseExtRegistrator, {$I uses.inc};

type
  TaqBasePluginClass = class of TaqBasePlugin;

  TaqBasePlugin = class(TInterfacedObject,
                        IaqKeyItem,
                        IaqBasePlugin)
  private
    FRegInfo: TRegPluginInfo;
    FBaseManager: IaqBaseManager;
    function GetDisposed: Boolean;

  protected
    function SelfKey: TGUID; // helper

    { IaqKeyItem }
    procedure GetKey(out Value: TGUID); virtual; stdcall; 

    { IaqBasePlugin }
    procedure Initialize(const AManager: IaqBaseManager); virtual; safecall;
    procedure Update; virtual; safecall;
    procedure Finalize; virtual; safecall;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); virtual; safecall;

    property Disposed: Boolean read GetDisposed;
    property BaseManager : IaqBaseManager read FBaseManager;
  public
    constructor Create(const ARegInfo: TRegPluginInfo);
  end;

implementation

{ TaqBasePlugin}

constructor TaqBasePlugin.Create(const ARegInfo: TRegPluginInfo);
begin
  inherited Create;
  FRegInfo := ARegInfo
end;

{ TaqBasePlugin.IaqKeyItem }

procedure TaqBasePlugin.GetKey(out Value: TGUID);
begin
  Value := FRegInfo.Key;
end;

{ TaqBasePlugin.IaqBasePlugin }

procedure TaqBasePlugin.Initialize(const AManager: IaqBaseManager);
begin
  Assert(FBaseManager = nil);
  FBaseManager := AManager;
end;

procedure TaqBasePlugin.Update;
begin
  Assert(not Disposed);
end;

procedure TaqBasePlugin.Finalize;
begin
  FBaseManager := nil;
end;

procedure TaqBasePlugin.BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE);
begin
end;

function TaqBasePlugin.GetDisposed: Boolean;
begin
  Result := FBaseManager = nil;
end;

function TaqBasePlugin.SelfKey: TGUID;
begin
  GetKey(Result);
end;

end.
