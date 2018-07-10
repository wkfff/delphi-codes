unit BaseForm;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ComCtrls,
{$IFDEF EXPRESSBARS}
  dxBar, dxStatusBar,
{$ENDIF}
  cxClasses, cxStyles, cxGridTableView, cxLookAndFeels, cxGridCardView;

type
{$IFDEF EXPRESSBARS}
  TdxBaseMenuItem = TdxBarItem;
{$ELSE}
  TdxBaseMenuItem = TMenuItem;
{$ENDIF}

  TfmBaseForm = class(TForm)
    lbDescription: TLabel;
    miAbout: TMenuItem;
    miExit: TMenuItem;
    miFile: TMenuItem;
    mmMain: TMainMenu;
    StyleRepository: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyle14: TcxStyle;
    cxStyle15: TcxStyle;
    cxStyle16: TcxStyle;
    cxStyle17: TcxStyle;
    cxStyle18: TcxStyle;
    cxStyle19: TcxStyle;
    cxStyle20: TcxStyle;
    cxStyle21: TcxStyle;
    cxStyle22: TcxStyle;
    cxStyle23: TcxStyle;
    cxStyle24: TcxStyle;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    GridCardViewStyleSheetDevExpress: TcxGridCardViewStyleSheet;
    sbMain: TStatusBar;
    procedure miAboutClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
  private
    FLookAndFeel: TcxLookAndFeel;
    procedure CreateSkinsMenuItem;
  protected
    function CanUseStyleSheet: Boolean;
    function GetMenuItemChecked(AMenuItem: TObject): Boolean;
    function IsNeedLookAndFeelMenuItem: Boolean; virtual;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); virtual;
    procedure UpdateCardViewStyleSheet(ACardView: TcxGridCardView);
    procedure UpdateTableViewStyleSheet(ATableView: TcxGridTableView);
    //
    function FindMenuItem(const AMenuItemName: string; out AItem: TdxBaseMenuItem): Boolean;
    procedure MenuItemCheckSubItemWithTag(const AMenuItemName: string; ATag: Integer);
    procedure MenuItemSetChecked(const AMenuItemName: string; AChecked: Boolean); overload;
    procedure MenuItemSetChecked(Sender: TObject; AChecked: Boolean); overload;
    procedure MenuItemSetEnabled(const AMenuItemName: string; AEnabled: Boolean); overload;
    procedure MenuItemSetEnabled(Sender: TObject; AEnabled: Boolean); overload;
    procedure MenuItemSetVisible(const AMenuItemName: string; AVisible: Boolean); overload;
    procedure MenuItemSetVisible(Sender: TObject; AVisible: Boolean); overload;
  public
  {$IFDEF EXPRESSBARS}
    BarManager: TdxBarManager;
    StatusBar: TdxStatusBar;
  {$ELSE}
    function StatusBar: TStatusBar;
  {$ENDIF}
    procedure AfterConstruction; override;
    destructor Destroy; override;
    procedure PlaceControls; virtual;
  end;

var
  fmBaseForm: TfmBaseForm;

implementation

{$R *.dfm}

uses
{$IFDEF EXPRESSSKINS}
  {$I ..\dxSkins.inc}
  dxSkinsStrs, dxSkinsForm, dxSkinInfo,
{$IFDEF EXPRESSPAGECONTROL}
  dxSkinscxPCPainter,
{$ENDIF}
{$IFDEF EXPRESSSCHEDULER}
  dxSkinscxSchedulerPainter,
{$ENDIF}
{$IFDEF EXPRESSDOCKINGLIBRARY}
  dxSkinsdxDockControlPainter,
{$ENDIF}
{$IFDEF EXPRESSNAVBAR}
  dxSkinsdxNavBarPainter,
{$ENDIF}
{$IFDEF EXPRESSBARS}
  dxSkinsdxBarPainter,
  dxSkinsdxStatusBarPainter,
{$IFDEF EXPRESSPAGECONTROL}
  {$IFDEF EXPRESSEDITORS}
    dxBarSkinnedCustForm,
  {$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
  dxGDIPlusAPI, cxLookAndFeelPainters, AboutDemoForm;

{$IFDEF EXPRESSBARS}
const
  BarVisibility: array[Boolean] of TdxBarItemVisible = (ivNever, ivAlways);
{$ENDIF}

const
  LevelGroupIndex: Integer = 200;

{$IFDEF EXPRESSBARS}
procedure dxBarConvertMainMenu(AMenu: TMainMenu; ABarManager: TdxBarManager);

  function AddCategory(AName: string): Integer;
  var
    ACategoryName: string;
  begin
    with ABarManager.Categories do
    begin
      ACategoryName := AName;
      Result := IndexOf(ACategoryName);
      if Result < 0 then
        Result := Add(ACategoryName);
    end;
  end;

  function ConvertItem(AItemLinks: TdxBarItemLinks; AMenuItem: TMenuItem;
    ACategory: Integer; ANeedCreateCategory: Boolean): TdxBarItem;
  var
    ABarItem, AChildItem: TdxBarItem;
    AItemLink: TdxBarItemLink;
    ABeginGroup: Boolean;
    AMenuItemName: string;
  begin
    if AMenuItem.Parent = nil then
      ABarItem := nil
    else
    begin
      if AMenuItem.Count = 0 then
        ABarItem := TdxBarButton.Create(ABarManager.Owner)
      else
      begin
        ABarItem := TdxBarSubItem.Create(ABarManager.Owner);
        Inc(LevelGroupIndex);
      end;
      ABarItem.Category := ACategory;
    end;

    with AMenuItem do
    begin
      if ABarItem <> nil then
      begin
        ABarItem.Action := Action;
        ABarItem.ImageIndex := ImageIndex;
        ABarItem.Caption := Caption;
        ABarItem.Enabled := Enabled;
        ABarItem.HelpContext := HelpContext;
        ABarItem.Hint := Hint;
        ABarItem.ShortCut := ShortCut;
        ABarItem.Tag := Tag;
        ABarItem.OnClick := OnClick;
        if ABarItem is TdxBarButton then
          with TdxBarButton(ABarItem) do
          begin
            if Checked or RadioItem or AutoCheck then
              ButtonStyle := bsChecked;
            if RadioItem then
            begin
              if AMenuItem.GroupIndex <> 0 then
                GroupIndex := AMenuItem.GroupIndex
              else
                GroupIndex := LevelGroupIndex;
            end;
            Down := Checked;
          end;

        if (Count > 0) and ANeedCreateCategory then
          ACategory := AddCategory(GetTextOf(Caption));
      end;

      ABeginGroup := False;
      while Count > 0 do
        if Items[0].Caption = '-' then
        begin
          ABeginGroup := True;
          Items[0].Free;
        end
        else
        begin
          AChildItem := ConvertItem(AItemLinks, Items[0], ACategory, (Parent = nil) and (AMenu is TMainMenu));
          if Parent = nil then
            AItemLink := AItemLinks.Add
          else
            AItemLink := TdxBarSubItem(ABarItem).ItemLinks.Add;
          AItemLink.Item := AChildItem;
          if ABeginGroup then
          begin
            AItemLink.BeginGroup := True;
            ABeginGroup := False;
          end;
        end;
    end;

    AMenuItemName := AMenuItem.Name;
    if AMenuItem.Parent <> nil then
      AMenuItem.Free;
    if ABarItem <> nil then
      ABarItem.Name := AMenuItemName;

    Result := ABarItem;
  end;

var
  ACategoryName, APopupMenuName: string;
  ACategory: Integer;
  ABarPopupMenu: TdxBarPopupMenu;
  AItemLinks: TdxBarItemLinks;
begin
  Screen.Cursor := crHourGlass;
  try
    ACategoryName := 'Menus';
    ABarPopupMenu := nil;
    if ABarManager.MainMenuBar = nil then
      with ABarManager.Bars.Add do
      begin
        Caption := 'Main Menu';
        DockingStyle := dsTop;
        IsMainMenu := True;
        Visible := True;
      end;
    AItemLinks := ABarManager.MainMenuBar.ItemLinks;
    if ABarManager.Images = nil then
      ABarManager.Images := AMenu.Images;

    ACategory := AddCategory(ACategoryName);

    ABarManager.BeginUpdate;
    try
      ConvertItem(AItemLinks, AMenu.Items, ACategory, False);
    finally
      ABarManager.EndUpdate;
    end;

    AMenu.Free;
    ABarManager.Categories.Move(ACategory, ABarManager.Categories.Count - 1);
    if ABarPopupMenu <> nil then
      ABarPopupMenu.Name := APopupMenuName;
    Inc(LevelGroupIndex);
  finally
    Screen.Cursor := crDefault;
  end;
end;
{$ENDIF}

type

  { TcxLookAndFeelCustomMenuBuilder }

  TcxLookAndFeelCustomMenuBuilder = class(TObject)
  protected
    class procedure MenuItemClickHandler(ASender: TObject); virtual;
  public
    procedure AddButton(AParent: TObject; const ACaption: string; ATag: Integer); virtual; abstract;
    function AddSubItem(AParent: TObject; const ACaption: string): TObject; virtual; abstract;
    function FirstSubItem(AParent: TObject): TObject; virtual; abstract;
  end;

  TcxLookAndFeelCustomMenuBuilderClass = class of TcxLookAndFeelCustomMenuBuilder;

type
  { TcxLookAndFeelMenuBuilder }

  TcxLookAndFeelMenuBuilder = class(TcxLookAndFeelCustomMenuBuilder)
  protected
    class procedure MenuItemClickHandler(ASender: TObject); override;
  public
    procedure AddButton(AParent: TObject; const ACaption: string; ATag: Integer); override;
    function AddSubItem(AParent: TObject; const ACaption: string): TObject; override;
    function CreateMenuItem(const ACaption: string; AParent: TMenuItem): TMenuItem;
    function FirstSubItem(AParent: TObject): TObject; override;
  end;

{$IFDEF EXPRESSBARS}

  { TcxLookAndFeelBarsMenuBuilder }

  TcxLookAndFeelBarsMenuBuilder = class(TcxLookAndFeelCustomMenuBuilder)
  protected
    class procedure MenuItemClickHandler(ASender: TObject); override;
  public
    procedure AddButton(AParent: TObject; const ACaption: string; ATag: Integer); override;
    function AddSubItem(AParent: TObject; const ACaption: string): TObject; override;
    function FirstSubItem(AParent: TObject): TObject; override;
  end;

{$ENDIF}

var
  FSkinNames: TStringList;
  FSkinResources: TStringList;
{$IFDEF EXPRESSSKINS}
  FSkinController: TdxSkinController;
{$ENDIF}

procedure PopulateSkinNames;
{$IFDEF EXPRESSSKINS}

  procedure PopulateSkinNamesByResources;
  var
    I: Integer;
  begin
    FSkinResources := TStringList.Create;
    dxSkinsPopulateSkinResources(HInstance, FSkinResources, FSkinNames);
    for I := 0 to FSkinNames.Count - 1 do
      if SameText(FSkinNames[I], sdxDefaultUserSkinData) then
      begin
        FSkinNames.Delete(I);
        Break;
      end;
  end;

  procedure PopulateSkinNamesByExtendedPainters;
  var
    ADefaultSkinIndex, I: Integer;
  begin
    for I := 0 to cxLookAndFeelPaintersManager.Count - 1 do
    begin
      if cxLookAndFeelPaintersManager[I].LookAndFeelStyle = lfsSkin then
        FSkinNames.Add(cxLookAndFeelPaintersManager[I].LookAndFeelName);
    end;
    ADefaultSkinIndex := FSkinNames.IndexOf(sdxSkinsUserSkinName);
    if ADefaultSkinIndex >= 0 then
      FSkinNames.Delete(ADefaultSkinIndex);
  end;

{$ENDIF}
begin
  if FSkinNames = nil then
  begin
    FSkinNames := TStringList.Create;
{$IFDEF EXPRESSSKINS}
  {$IFDEF DXSKINDYNAMICLOADING}
    PopulateSkinNamesByResources;
  {$ELSE}
    PopulateSkinNamesByExtendedPainters;
  {$ENDIF}
{$ENDIF}
  end;
end;

procedure dxBuildLookAndFeelMenu(AParent: TObject;
  AMenuBuilderClass: TcxLookAndFeelCustomMenuBuilderClass); overload;
var
  AMenuBuilder: TcxLookAndFeelCustomMenuBuilder;
  I: Integer;
begin
  AMenuBuilder := AMenuBuilderClass.Create;
  try
    AMenuBuilder.AddButton(AParent, 'Native', 4);
    AMenuBuilder.AddButton(AParent, 'Standard', 1);
    AMenuBuilder.AddButton(AParent, 'Flat', 0);
    AMenuBuilder.AddButton(AParent, 'UltraFlat', 2);
    AMenuBuilder.AddButton(AParent, 'Office11', 3);
    PopulateSkinNames;
    if FSkinNames.Count > 0 then
    begin
      AParent := AMenuBuilder.AddSubItem(AParent, 'Skins');
      for I := 0 to FSkinNames.Count - 1 do
        AMenuBuilder.AddButton(AParent, FSkinNames[I], I + 5);
    end;
    AMenuBuilder.MenuItemClickHandler(AMenuBuilder.FirstSubItem(AParent));
  finally
    AMenuBuilder.Free;
  end;
end;

procedure dxBuildLookAndFeelMenu(AMenuItem: TMenuItem); overload;
begin
  dxBuildLookAndFeelMenu(AMenuItem, TcxLookAndFeelMenuBuilder);
end;

{$IFDEF EXPRESSBARS}
procedure dxBuildLookAndFeelMenu(AMenuItem: TdxBarSubItem); overload;
begin
  dxBuildLookAndFeelMenu(AMenuItem, TcxLookAndFeelBarsMenuBuilder);
end;
{$ENDIF}

{ TcxLookAndFeelCustomMenuBuilder }

class procedure TcxLookAndFeelCustomMenuBuilder.MenuItemClickHandler(ASender: TObject);

  procedure SelectLookAndFeelKind(AValue: TcxLookAndFeelKind);
  begin
    RootLookAndFeel.Kind := AValue;
    RootLookAndFeel.NativeStyle := False;
    RootLookAndFeel.SkinName := '';
  end;

{$IFDEF EXPRESSSKINS}

  procedure SelectSkin(ASkinIndex: Integer);
  {$IFDEF DXSKINDYNAMICLOADING}
  var
    AStream: TStream;
  {$ENDIF}
  begin
    RootLookAndFeel.NativeStyle := False;
  {$IFDEF DXSKINDYNAMICLOADING}
    AStream := TResourceStream.Create(hInstance,
      FSkinResources[Integer(FSkinNames.Objects[ASkinIndex])], PChar(sdxResourceType));
    try
      dxSkinsUserSkinLoadFromStream(AStream);
      RootLookAndFeel.SkinName := sdxSkinsUserSkinName;
    finally
      AStream.Free;
    end;
  {$ELSE}
    RootLookAndFeel.SkinName := FSkinNames[ASkinIndex];
  {$ENDIF}
  end;

{$ENDIF}

begin
  case TComponent(ASender).Tag of
    0..3:
      SelectLookAndFeelKind(TcxLookAndFeelKind(TComponent(ASender).Tag));
    4:
      RootLookAndFeel.NativeStyle := True;
  {$IFDEF EXPRESSSKINS}
    else
      SelectSkin(TComponent(ASender).Tag - 5);
  {$ENDIF}
  end;
end;

{ TcxLookAndFeelMenuBuilder }

procedure TcxLookAndFeelMenuBuilder.AddButton(
  AParent: TObject; const ACaption: string; ATag: Integer);
var
  AMenuItem: TMenuItem;
begin
  AMenuItem := CreateMenuItem(ACaption, AParent as TMenuItem);
  AMenuItem.OnClick := MenuItemClickHandler;
  AMenuItem.RadioItem := True;
  AMenuItem.Tag := ATag;
end;

function TcxLookAndFeelMenuBuilder.AddSubItem(
  AParent: TObject; const ACaption: string): TObject;
begin
  Result := CreateMenuItem(ACaption, AParent as TMenuItem);
end;

function TcxLookAndFeelMenuBuilder.CreateMenuItem(
  const ACaption: string; AParent: TMenuItem): TMenuItem;
begin
  Result := TMenuItem.Create(AParent);
  Result.Caption := ACaption;
  AParent.Add(Result);
end;

function TcxLookAndFeelMenuBuilder.FirstSubItem(AParent: TObject): TObject;
begin
  Result := (AParent as TMenuItem).Items[0];
end;

class procedure TcxLookAndFeelMenuBuilder.MenuItemClickHandler(ASender: TObject);

  procedure UncheckMenuItems(AParentItem: TMenuItem);
  var
    AMenuItem: TMenuItem;
    I: Integer;
  begin
    for I := 0 to AParentItem.Count - 1 do
    begin
      AMenuItem := AParentItem[I];
      AMenuItem.Checked := AMenuItem = ASender;
      UncheckMenuItems(AMenuItem);
    end;
  end;

begin
  case TComponent(ASender).Tag of
    0..4:
      UncheckMenuItems((ASender as TMenuItem).Parent);
    else
      UncheckMenuItems((ASender as TMenuItem).Parent.Parent);
  end;
  inherited MenuItemClickHandler(ASender);
end;

{$IFDEF EXPRESSBARS}

{ TcxLookAndFeelBarsMenuBuilder }

procedure TcxLookAndFeelBarsMenuBuilder.AddButton(
  AParent: TObject; const ACaption: string; ATag: Integer);
var
  AButton: TdxBarButton;
  AParentSubItem: TdxBarSubItem;
begin
  AParentSubItem := AParent as TdxBarSubItem;
  AButton := AParentSubItem.BarManager.AddButton;
  AButton.OnClick := MenuItemClickHandler;
  AButton.Caption := ACaption;
  AButton.ButtonStyle := bsChecked;
  AButton.GroupIndex := LevelGroupIndex;
  AButton.Tag := ATag;
  AParentSubItem.ItemLinks.Add(AButton);
end;

function TcxLookAndFeelBarsMenuBuilder.AddSubItem(
  AParent: TObject; const ACaption: string): TObject;
var
  AParentSubItem: TdxBarSubItem;
  ASubItem: TdxBarSubItem;
begin
  AParentSubItem := AParent as TdxBarSubItem;
  ASubItem := AParentSubItem.BarManager.AddSubItem;
  ASubItem.Caption := ACaption;
  AParentSubItem.ItemLinks.Add(ASubItem);
  Result := ASubItem;
end;

function TcxLookAndFeelBarsMenuBuilder.FirstSubItem(AParent: TObject): TObject;
begin
  Result := (AParent as TdxBarSubItem).ItemLinks[0].Item;
end;

class procedure TcxLookAndFeelBarsMenuBuilder.MenuItemClickHandler(ASender: TObject);
begin
  (ASender as TdxBarButton).Down := True;
  inherited MenuItemClickHandler(ASender);
end;

{$ENDIF}

procedure RegisterAssistants;
begin
{$IFDEF EXPRESSSKINS}
  FSkinController := TdxSkinController.Create(nil);
{$ENDIF}
end;

procedure UnregisterAssistants;
begin
{$IFDEF EXPRESSSKINS}
  FreeAndNil(FSkinController);
{$ENDIF}
  FreeAndNil(FSkinResources);
  FreeAndNil(FSkinNames);
end;

{ TfmBaseForm }

procedure TfmBaseForm.AfterConstruction;
{$IFDEF EXPRESSBARS}

  procedure StatusBarPanelAssign(ADXPanel: TdxStatusBarPanel; APanel: TStatusPanel);
  begin
    ADXPanel.Width := APanel.Width;
  end;

  var
    I: Integer;
{$ENDIF}
begin
  inherited;
  FLookAndFeel := TcxLookAndFeel.Create(nil);
  FLookAndFeel.OnChanged := LookAndFeelChanged;
{$IFDEF EXPRESSBARS}
  BarManager := TdxBarManager.Create(Self);
  dxBarConvertMainMenu(mmMain, BarManager);
  BarManager.Style := bmsUseLookAndFeel;
{$ENDIF}
  PlaceControls;
  if IsNeedLookAndFeelMenuItem then
    CreateSkinsMenuItem;
{$IFDEF EXPRESSBARS}
  StatusBar := TdxStatusBar.Create(Self);
  StatusBar.PaintStyle := stpsUseLookAndFeel;
  StatusBar.Panels.Add.PanelStyleClass := TdxStatusBarTextPanelStyle;
  TdxStatusBarTextPanelStyle(StatusBar.Panels[0].PanelStyle).AutoHint := True;
  for I := 0 to sbMain.Panels.Count - 1 do
  begin
    if StatusBar.Panels.Count > I then
      StatusBarPanelAssign(StatusBar.Panels[I], sbMain.Panels[I])
    else
      StatusBarPanelAssign(StatusBar.Panels.Add, sbMain.Panels[I]);
  end;
  StatusBar.ParentShowHint := sbMain.ParentShowHint;
  StatusBar.ShowHint := sbMain.ShowHint;
  StatusBar.Parent := Self;
  sbMain.Free;
{$ENDIF}
end;

destructor TfmBaseForm.Destroy;
begin
  FreeAndNil(FLookAndFeel);
  inherited Destroy;
end;

procedure TfmBaseForm.miAboutClick(Sender: TObject);
begin
  ShowAboutDemoForm;
end;

procedure TfmBaseForm.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfmBaseForm.CreateSkinsMenuItem;
var
  AMenuItem: {$IFDEF EXPRESSBARS}TdxBarItemLink{$ELSE}TMenuItem{$ENDIF};
  ACaption: string;
begin
{$IFDEF EXPRESSSKINS}
  ACaption := '&Skins';
{$ELSE}
  ACaption := 'LookAnd&Feel';
{$ENDIF}
{$IFDEF EXPRESSBARS}
  AMenuItem := BarManager.MainMenuBar.ItemLinks.AddItem(TdxBarSubItem);
  AMenuItem.UserCaption := ACaption;
  AMenuItem.Index := 1;
  dxBuildLookAndFeelMenu(AMenuItem.Item as TdxBarSubItem);
{$ELSE}
  AMenuItem := NewItem(ACaption, 0, False, True, nil, 0, 'miSkins');
  mmMain.Items.Insert(1, AMenuItem);
  dxBuildLookAndFeelMenu(AMenuItem);
{$ENDIF}
end;

{$IFDEF EXPRESSBARS}

function TfmBaseForm.FindMenuItem(const AMenuItemName: string; out AItem: TdxBaseMenuItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  if BarManager <> nil then
  begin
    for I := 0 to BarManager.ItemCount - 1 do
      if SameText(BarManager.Items[I].Name, AMenuItemName) then
      begin
        Result := True;
        AItem := BarManager.Items[I];
        Break;
      end;
  end;
end;

{$ELSE}

function TfmBaseForm.StatusBar: TStatusBar;
begin
  Result := sbMain;
end;

function TfmBaseForm.FindMenuItem(const AMenuItemName: string; out AItem: TdxBaseMenuItem): Boolean;

  function FindMenuItem(AParent: TMenuItem; out AItem: TdxBaseMenuItem): Boolean;
  var
    I: Integer;
  begin
    Result := SameText(AParent.Name, AMenuItemName);
    if Result then
      AItem := AParent
    else
      for I := 0 to AParent.Count - 1 do
      begin
        Result := FindMenuItem(AParent[I], AItem);
        if Result then Break;
      end;
  end;

begin
  Result := FindMenuItem(mmMain.Items, AItem);
end;
{$ENDIF}

procedure TfmBaseForm.PlaceControls;
begin
{$IFDEF EXPRESSBARS}
  BarManager.MainMenuControl.DockControl.Top := 0;
{$ENDIF}
end;

function TfmBaseForm.CanUseStyleSheet: Boolean;
begin
  Result := FLookAndFeel.SkinPainter = nil;
end;

function TfmBaseForm.GetMenuItemChecked(AMenuItem: TObject): Boolean;
begin
{$IFDEF EXPRESSBARS}
  if AMenuItem is TdxBarButton then
    Result := TdxBarButton(AMenuItem).Down
  else
{$ENDIF}
   Result := (AMenuItem as TMenuItem).Checked;
end;

function TfmBaseForm.IsNeedLookAndFeelMenuItem: Boolean;
begin
  Result := Pos('STYLES', UpperCase(ExtractFileName(Application.ExeName))) = 0;
end;

procedure TfmBaseForm.LookAndFeelChanged(
  Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
end;

procedure TfmBaseForm.UpdateCardViewStyleSheet(ACardView: TcxGridCardView);
begin
  if ACardView <> nil then
  begin
    if CanUseStyleSheet then
      ACardView.Styles.StyleSheet := GridCardViewStyleSheetDevExpress
    else
      ACardView.Styles.StyleSheet := nil;
  end;
end;

procedure TfmBaseForm.UpdateTableViewStyleSheet(ATableView: TcxGridTableView);
begin
  if ATableView <> nil then
  begin
    if CanUseStyleSheet then
      ATableView.Styles.StyleSheet := GridTableViewStyleSheetDevExpress
    else
      ATableView.Styles.StyleSheet := nil;
  end;
end;

procedure TfmBaseForm.MenuItemCheckSubItemWithTag(const AMenuItemName: string; ATag: Integer);
var
  AMenuItem: TdxBaseMenuItem;
{$IFDEF EXPRESSBARS}
  ASubMenuItem: TdxBarSubItem;
{$ENDIF}
  I: Integer;
begin
  if FindMenuItem(AMenuItemName, AMenuItem) then
  begin
  {$IFDEF EXPRESSBARS}
    ASubMenuItem := AMenuItem as TdxBarSubItem;
    for I := 0 to ASubMenuItem.ItemLinks.Count - 1 do
    begin
      with ASubMenuItem.ItemLinks[I] do
        MenuItemSetChecked(Item, Item.Tag = ATag);
    end;
  {$ELSE}
    for I := 0 to AMenuItem.Count - 1 do
      AMenuItem.Items[I].Checked := AMenuItem.Items[I].Tag = ATag;
  {$ENDIF}
  end;
end;

procedure TfmBaseForm.MenuItemSetChecked(const AMenuItemName: string; AChecked: Boolean);
var
  AMenuItem: TdxBaseMenuItem;
begin
  if FindMenuItem(AMenuItemName, AMenuItem) then
  {$IFDEF EXPRESSBARS}
    (AMenuItem as TdxBarButton).Down := AChecked;
  {$ELSE}
    AMenuItem.Checked := AChecked;
  {$ENDIF}
end;

procedure TfmBaseForm.MenuItemSetChecked(Sender: TObject; AChecked: Boolean);
begin
{$IFDEF EXPRESSBARS}
  (Sender as TdxBarButton).Down := AChecked;
{$ELSE}
  (Sender as TMenuItem).Checked := AChecked;
{$ENDIF}
end;

procedure TfmBaseForm.MenuItemSetEnabled(Sender: TObject; AEnabled: Boolean);
begin
{$IFDEF EXPRESSBARS}
  (Sender as TdxBarItem).Enabled := AEnabled;
{$ELSE}
  (Sender as TMenuItem).Enabled := AEnabled;
{$ENDIF}
end;

procedure TfmBaseForm.MenuItemSetEnabled(const AMenuItemName: string; AEnabled: Boolean);
var
  AMenuItem: TdxBaseMenuItem;
begin
  if FindMenuItem(AMenuItemName, AMenuItem) then
    AMenuItem.Enabled := AEnabled;
end;

procedure TfmBaseForm.MenuItemSetVisible(const AMenuItemName: string; AVisible: Boolean);
var
  AMenuItem: TdxBaseMenuItem;
begin
  if FindMenuItem(AMenuItemName, AMenuItem) then
  {$IFDEF EXPRESSBARS}
    AMenuItem.Visible := BarVisibility[AVisible];
  {$ELSE}
    AMenuItem.Visible := AVisible;
  {$ENDIF}
end;

procedure TfmBaseForm.MenuItemSetVisible(Sender: TObject; AVisible: Boolean);
begin
{$IFDEF EXPRESSBARS}
  (Sender as TdxBarItem).Visible := BarVisibility[AVisible];
{$ELSE}
  (Sender as TMenuItem).Visible := AVisible;
{$ENDIF}
end;

initialization
  dxUnitsLoader.AddUnit(@RegisterAssistants, @UnregisterAssistants);

finalization
  dxUnitsLoader.RemoveUnit(@UnregisterAssistants);
end.
