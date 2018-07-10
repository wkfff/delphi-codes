// =============================================================================================
// AutomatedQA SDK - Copyright (c) AutomatedQA Corp.
//
// This file is part of AutomatedQA SDK
//
// =============================================================================================

unit BaseWindowPlugin;

interface

uses
  BasePlugin, Controls, {$I uses.inc};

type
  // Platfrom-specific definition.
  TaqControl = TWinControl;

  //
  // TaqBaseWindowPlugin is a base class of windowed plugins.
  //
  TaqBaseWindowPlugin = class(TaqBasePlugin,
                              IaqExtendedPlugin,
                              IaqWindowProvider)
  private
    FControl: TaqControl;
    FUIShell: IaqUIShell;
    FVisible: Boolean;

  protected
    procedure InternalCreateControl();
    procedure OnAfterSetSite(); virtual;

    // Creates underlying window.
    function CreateControl(): TaqControl; virtual; abstract;
    // Returns image resource name.
    function GetPanelImageName(): string; virtual;
    // Called when the underlying window is about to show.
    procedure ControlShow(); virtual;
    // Called when the underlying window is about to hide.
    procedure ControlHide(); virtual;

    { IaqBasePlugin }
    procedure Initialize(const AManager: IaqBaseManager); override;
    procedure Update(); override;
    procedure Finalize(); override;

    { IaqExtendedPlugin }
    function Get_Name(): WideString; virtual; safecall; abstract;
    function Get_Category(): WideString; virtual; safecall;
    function Get_Image(): AQ_RESOURCE_INFO; safecall;
    function Get_HelpFileName(): WideString; virtual; safecall;
    function Get_HelpContext(): Integer; virtual; safecall;

    { IaqWindowProvider }
    function Get_CreatePaneAtStartup(): WordBool; virtual; safecall;
    function Get_AcceptsHandleType(SiteHandleType: AQ_HANDLE_TYPE): WordBool; safecall;
    procedure Set_Visible(Param1: WordBool); safecall;
    function Get_Visible(): WordBool; safecall;
    procedure SetSite(SiteHandleType: AQ_HANDLE_TYPE; SiteHandle: UINT_PTR); safecall;
    procedure SetBounds(Left: Integer; Top: Integer; Width: Integer; Height: Integer); virtual; safecall;

    property Control: TaqControl read FControl;
    property UIShell: IaqUIShell read FUIShell;
    property Visible: Boolean read FVisible;
  public
  end;

implementation

uses
  SysUtils, Forms, Windows, Menus;  

resourcestring
  SEUnsupportedSiteHandleType = 'Unsupported parent site''s handle type';
  SEControlNil = 'CreateControl should return a value';

type
  TaqControlFriend = class(TaqControl);

{ TaqBaseWindowPlugin }

function TaqBaseWindowPlugin.GetPanelImageName: string;
begin
  Result := '';
end;

procedure TaqBaseWindowPlugin.ControlShow;
begin
  FVisible := True;
end;

procedure TaqBaseWindowPlugin.ControlHide;
begin
  FVisible := False;
end;

procedure TaqBaseWindowPlugin.InternalCreateControl;
begin
  if FControl = nil then
  begin
    FControl := CreateControl;
    FControl.HelpContext := Get_HelpContext;
    TaqControlFriend(FControl).Text := Get_Name;

    // TestComplete specific
    if FControl is TCustomForm then
       TCustomForm(FControl).BorderStyle := bsNone;
  end;
end;

procedure TaqBaseWindowPlugin.OnAfterSetSite();
begin
end;

{ TaqBaseWindowPlugin.IaqBasePlugin }

procedure TaqBaseWindowPlugin.Initialize(const AManager: IaqBaseManager);
begin
  inherited Initialize(AManager);
  FVisible := False;

  // It's always a good idea to cache interfaces at the initialization point
  // to avoid extra calls to QueryInterface later.
  FUIShell := BaseManager.Managers[IaqUIShell] as IaqUIShell;
end;

procedure TaqBaseWindowPlugin.Update;
begin
end;

procedure TaqBaseWindowPlugin.Finalize;
begin
  // Release references to cached interfaces.
  FUIShell := nil;
  FreeAndNil(FControl);
  inherited Finalize;
end;

{ TaqBaseWindowPlugin.IaqExtendedPlugin }

function TaqBaseWindowPlugin.Get_Category: WideString;
begin
  Result := '';
end;

function TaqBaseWindowPlugin.Get_Image: AQ_RESOURCE_INFO;
var
  ImageName: string;
begin
  ImageName := GetPanelImageName;
  if ImageName <> '' then
    Result := Windows.LoadBitmap(hInstance, PChar(ImageName))
  else
    Result := 0;
end;

function TaqBaseWindowPlugin.Get_HelpFileName: WideString;
begin
  Result := '';
end;

function TaqBaseWindowPlugin.Get_HelpContext: Integer;
begin
  Result := 0;
end;

{ TaqBaseWindowPlugin.IaqWindowProvider }

function TaqBaseWindowPlugin.Get_CreatePaneAtStartup: WordBool;
begin
  // NOTE: For now, all windowed plug-ins are marked to be created at startup
  // by default. It is strongly recommended to override this
  // in TaqBaseWindowPlugin descendants with the False value.
  Result := True;
end;

function TaqBaseWindowPlugin.Get_AcceptsHandleType(SiteHandleType: AQ_HANDLE_TYPE): WordBool; safecall;
begin
  Result := SiteHandleType = htWindowHandle;
end;

procedure TaqBaseWindowPlugin.Set_Visible(Param1: WordBool); safecall;
begin
  Assert(Control <> nil);
  if ((Control.ParentWindow <> 0) or (Control.Parent <> nil)) and
      (Control.Visible <> Param1) then
  begin
    Control.Visible := Param1;
    if Param1 then
      ControlShow
    else
      ControlHide;
  end;
end;

function TaqBaseWindowPlugin.Get_Visible(): WordBool;
begin
  Result := FVisible;
  if (Control <> nil) then
     Assert(FVisible = Control.Visible);
end;

procedure TaqBaseWindowPlugin.SetSite(SiteHandleType: AQ_HANDLE_TYPE; SiteHandle: UINT_PTR); safecall;
begin
  Assert(Get_AcceptsHandleType(SiteHandleType));

  InternalCreateControl;

  if Control = nil then
    raise Exception.Create(SEControlNil);

  // Hide Control before detaching it from the parent.
  if SiteHandle = 0 then
    Set_Visible(False);
  if SiteHandleType = htWindowHandle then
    Control.ParentWindow := SiteHandle
  else if SiteHandleType = htVCLForm then
    Control.Parent := TWinControl(SiteHandle);
  // Force Control to explicitly recreate its handle now.
  if SiteHandle <> 0 then
    Control.HandleNeeded;

  OnAfterSetSite();
end;

procedure TaqBaseWindowPlugin.SetBounds(Left: Integer; Top: Integer; Width: Integer; Height: Integer); safecall;
begin
  Assert(Control <> nil);
  if (Control.Parent <> nil) or (Control.ParentWindow <> 0) then
    Control.SetBounds(Left, Top, Width, Height);
end;


end.
