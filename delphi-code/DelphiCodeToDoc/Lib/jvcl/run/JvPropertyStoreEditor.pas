{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvPropertyStoreEditor.pas, released on 2008-01-01.

The Initial Developer of the Original Code is Jens Fudickar
All Rights Reserved.

Contributor(s):
  Jens Fudickar [jens dott fudickar att oratool dott de]

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.delphi-jedi.org

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvPropertyStoreEditor.pas 12741 2010-04-02 10:43:13Z ahuser $
unit JvPropertyStoreEditor;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Variants,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls,
  JvComponent, JvExComCtrls, JvComCtrls, ExtCtrls, JvExControls,
  JvInspector, StdCtrls, JvExStdCtrls, JvListBox, JvPropertyStore,
  JvPropertyStoreEditorIntf, JvDynControlEngineIntf, ActnList, Menus;


type
  TJvPropertyStoreEditorControl = class(TCustomControl)
    procedure JvInspectorAfterItemCreate(Sender: TObject; Item:
        TJvCustomInspectorItem);
    procedure JvInspectorBeforeItemCreate(Sender: TObject; Data:
      TJvCustomInspectorData; var ItemClass: TJvInspectorItemClass);
    procedure ListBoxOnClick(Sender: TObject);
    procedure ListBoxOnEnter(Sender: TObject);
    procedure ListBoxOnKeyPress(Sender: TObject; var Key: Char);
    procedure ListBoxOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListCopyActionExecute(Sender: TObject);
    procedure ListDeleteActionExecute(Sender: TObject);
    procedure ListDownActionExecute(Sender: TObject);
    procedure ListEditActionExecute(Sender: TObject);
    procedure ListInsertActionExecute(Sender: TObject);
    procedure ListSortDownActionExecute(Sender: TObject);
    procedure ListSortUpActionExecute(Sender: TObject);
    procedure ListUpActionExecute(Sender: TObject);
    procedure PropertyStoreTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure PropertyStoreTreeViewChanging(Sender: TObject; Node: TTreeNode; var
        AllowChange: Boolean);
    procedure PropertyStoreTreeViewEnter(Sender: TObject);
    procedure RTTIInspectorEnter(Sender: TObject);
  private
    FInspectedObject: TPersistent;
    FInspectedObjectEditorHandlerIntf: IJvPropertyEditorHandler;
    FInspectedObjectListEditorHandlerIntf: IJvPropertyListEditorHandler;
    FInspectedObjectListItemIndex: Integer;
    FPropertyStore: TComponent;
    InfoGroupBoxDynControlCaptionIntf: IJvDynControlCaption;
    InfoMemo: TWinControl;
    InfoMemoDynControlDataIntf: IJvDynControlData;
    InfoPanel: TWinControl;
    Inspector: TWinControl;
    InspectorPanel: TWinControl;
    ListBoxControlItemIndexIntf: IJvDynControlItemIndex;
    ListBoxControlItemsIntf: IJvDynControlItems;
    ListButtonPanel: TWinControl;
    ListCopyAction: TAction;
    ListCopyMenu: TMenuItem;
    ListDeleteAction: TAction;
    ListDeleteMenu: TMenuItem;
    ListDownAction: TAction;
    ListDownMenu: TMenuItem;
    ListEditAction: TAction;
    ListInsertAction: TAction;
    ListInsertMenu: TMenuItem;
    ListInspectorPanel: TWinControl;
    ListPanel: TWinControl;
    ListPopupMenu: TPopupMenu;
    ListSortUpAction: TAction;
    ListSortUpMenu: TMenuItem;
    ListSortDownAction: TAction;
    ListSortDownMenu: TMenuItem;
    ListSplitter: TSplitter;
    ListUpAction: TAction;
    ListUpMenu: TMenuItem;
    ListLineMenu: TMenuItem;
    PropertyStoreTreeViewIntf: IJvDynControlTreeView;
    RTTIInspectorControlIntf: IJvDynControlRTTIInspectorControl;
    TreePanel: TWinControl;
    TreeSplitter: TSplitter;
    procedure FillListBox;
    function GetPropCount(Instance: TPersistent): Integer;
    function GetPropName(Instance: TPersistent; Index: Integer): string;
    procedure RTTIInspectorOnCanResize(Sender: TObject; var NewWidth, NewHeight:
        Integer; var Resize: Boolean);
    procedure SetInspectedObject(const Value: TPersistent);
    procedure SetInspectedObjectListEditorHandlerIntf(const Value: IJvPropertyListEditorHandler);
    procedure SetInspectedObjectListItemIndex(const Value: Integer);
    procedure SetPropertyStore(const Value: TComponent);
    function ShowPropertyInTreeView(PropObject: TObject; const PropertyName:
        string): Boolean;
    property InspectedObject: TPersistent read FInspectedObject write
        SetInspectedObject;
    property InspectedObjectEditorHandlerIntf: IJvPropertyEditorHandler read
        FInspectedObjectEditorHandlerIntf;
    property InspectedObjectListEditorHandlerIntf: IJvPropertyListEditorHandler read FInspectedObjectListEditorHandlerIntf
        write SetInspectedObjectListEditorHandlerIntf;
    property InspectedObjectListItemIndex: Integer read FInspectedObjectListItemIndex write SetInspectedObjectListItemIndex;
    procedure ChangeInspectedObjectListEditorHandlerIntf(iObject: TObject);
    procedure SetActionsEnabled;
  protected
    procedure CreateControls;
    procedure DestroyControls;
    procedure FillTreeView(GotoNodeObject: TPersistent = nil);
    procedure FillTreeViewByComponent(TreeNodes: TTreeNodes; Parent: TTreeNode;
        aPropertyStore: TPersistent);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function OnDisplayProperty(const aPropertyName : String): Boolean;
    function OnInspectorTranslatePropertyName(const aPropertyName : String): string;
    procedure OnPropertyChange(var OldPropertyName, NewPropertyName : string);
    function OnTranslatePropertyName(const aPropertyName : String): string;
    procedure SetInformation(const iCaption, iInfo: string);
  public
    destructor Destroy; override;
    procedure GotoEditObject(EditObject: TPersistent);
  published
    property Align;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property Color;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property Enabled;
    property Font;
    property OnCanResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnResize;
    property OnStartDock;
    property OnUnDock;
    {$IFDEF JVCLThemesEnabled}
    property ParentBackground default True;
    {$ENDIF JVCLThemesEnabled}
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PropertyStore: TComponent read FPropertyStore write SetPropertyStore;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UseDockManager default True;
    property Visible;
  end;

type
  TJvPropertyStoreEditorForm = class(TJvForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPropertyStore: TComponent;
    FPropertyStoreEditorControl: TJvPropertyStoreEditorControl;
    procedure CancelButtonClick(Sender: TObject);
    procedure IntOnShow(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure SetPropertyStore(const Value: TComponent);
  protected
    procedure CreateFormControls;
    procedure DestroyFormControls;
  public
    property PropertyStore: TComponent read FPropertyStore write SetPropertyStore;
  end;

function EditPropertyStore(PropertyStore: TJvCustomPropertyStore): Boolean;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_40_PREPARATION/run/JvPropertyStoreEditor.pas $';
    Revision: '$Revision: 12741 $';
    Date: '$Date: 2010-04-02 12:43:13 +0200 (ven., 02 avr. 2010) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  RTLConsts,
  JvResources,
  TypInfo, JvDynControlEngine, JvJVCLUtils;

{$R *.dfm}

type tAccessControl = class(TControl);


function EditPropertyStore(PropertyStore: TJvCustomPropertyStore): Boolean;
var
  JvPropertyStoreEditorForm: TJvPropertyStoreEditorForm;
  SavePropertyStore : TJvCustomPropertyStore;
begin
  Result := false;
  if not Assigned(PropertyStore) then
    Exit;
  SavePropertyStore := PropertyStore.Clone(nil);
  JvPropertyStoreEditorForm := TJvPropertyStoreEditorForm.Create(Application);
  try
    JvPropertyStoreEditorForm.PropertyStore := SavePropertyStore;
    Result := JvPropertyStoreEditorForm.ShowModal = mrOk;
    if Result then
      PropertyStore.Assign(SavePropertyStore);
  finally
    SavePropertyStore.Free;
    JvPropertyStoreEditorForm.Free;
  end;
end;

procedure TJvPropertyStoreEditorForm.CancelButtonClick(Sender: TObject);
begin
  // Do Not Remove
end;

procedure TJvPropertyStoreEditorForm.CreateFormControls;
var BottomPanel: TWinControl;
  Button: TButton;
  ITmpBevelBorder: IJvDynControlBevelBorder;
begin
  BottomPanel := DefaultDynControlEngine.CreatePanelControl(Self, Self, 'BottomPanel', '', alBottom);
  if Supports(BottomPanel, IJvDynControlBevelBorder, ITmpBevelBorder) then
    ITmpBevelBorder.ControlSetBevelOuter(bvNone);
  BottomPanel.TabOrder := 0;
  Button := DefaultDynControlEngine.CreateButton(Self, BottomPanel, 'OKButton', RSPropertyStoreEditorDialogButtonOk, '', OkButtonClick);
  Button.Top := 3;
  Button.Width := 75;
  Button.Height := 25;
  Button.Left := BottomPanel.Width-2*Button.Width-10;
  Button.Anchors := [akTop, akRight];
  Button.ModalResult := mrOk;
  Button := DefaultDynControlEngine.CreateButton(Self, BottomPanel, 'CancelButton', RSPropertyStoreEditorDialogButtonCancel, '', CancelButtonClick);
  Button.Top := 3;
  Button.Width := 75;
  Button.Height := 25;
  Button.Left := BottomPanel.Width-Button.Width-5;
  Button.Anchors := [akTop, akRight];
  Button.ModalResult := mrCancel;
  BottomPanel.Height := 2*Button.Top+Button.Height+1;

  FPropertyStoreEditorControl:= TJvPropertyStoreEditorControl.Create(self);
  FPropertyStoreEditorControl.Parent := Self;
  FPropertyStoreEditorControl.Align := alClient;

  Caption := RSPropertyStoreEditorDialogCaptionEditProperties;

end;

procedure TJvPropertyStoreEditorForm.DestroyFormControls;
begin
  FreeAndNil(FPropertyStoreEditorControl);
end;

procedure TJvPropertyStoreEditorForm.FormCreate(Sender: TObject);
begin
  CreateFormControls;
  OnShow := IntOnShow;
end;

procedure TJvPropertyStoreEditorForm.FormDestroy(Sender: TObject);
begin
  DestroyFormControls;
end;

procedure TJvPropertyStoreEditorForm.IntOnShow(Sender: TObject);
begin
  if Assigned(FPropertyStoreEditorControl) then
  begin
    FPropertyStoreEditorControl.PropertyStore := PropertyStore;
  end;
end;

procedure TJvPropertyStoreEditorForm.OkButtonClick(Sender: TObject);
begin
  // Do Not Remove
end;

procedure TJvPropertyStoreEditorForm.SetPropertyStore(const Value: TComponent);
begin
  FPropertyStore := Value;
  if Assigned(FPropertyStoreEditorControl) then
    FPropertyStoreEditorControl.PropertyStore := PropertyStore;
end;

type tAccessCustomPanel = class(tCustomPanel);


destructor TJvPropertyStoreEditorControl.Destroy;
begin
  DestroyControls;
  inherited Destroy;
end;

procedure TJvPropertyStoreEditorControl.CreateControls;
var
  TreeView: TWinControl;
  EditPanel: TWinControl;
  DynControlDblClick : IJvDynControlDblClick;
  ListBox: TWinControl;
  InfoGroupBox: TWinControl;
  InfoMemoPanel: TWinControl;
  DynControlMemo: IJvDynControlMemo;
  DynControlReadOnly: IJvDynControlReadOnly;
  DynControlKey: IJvDynControlKey;
  DynControlMouse: IJvDynControlMouse;
  DynControl: IJvDynControl;
  Button: TButton;
begin
  TreePanel := DefaultDynControlEngine.CreatePanelControl(Self, Self, 'TreePanel', '', alLeft);
  TreePanel.Width := 250;
  if TreePanel is TCustomPanel then
  begin
    tAccessCustomPanel(TreePanel).BevelOuter := bvNone;
    tAccessCustomPanel(TreePanel).BorderWidth := 3;
  end;

  TreeView := DefaultDynControlEngine.CreateTreeViewControl(Self, TreePanel, 'PropertyStoreTreeViewIntf');
  Supports(TreeView, IJvDynControlTreeView, PropertyStoreTreeViewIntf);
  TreeView.Align := alClient;
  PropertyStoreTreeViewIntf.ControlSetReadOnly (True);
  PropertyStoreTreeViewIntf.ControlSetHotTrack (True);
  PropertyStoreTreeViewIntf.ControlSetOnChange (PropertyStoreTreeViewChange);
  PropertyStoreTreeViewIntf.ControlSetOnChanging (PropertyStoreTreeViewChanging);
  PropertyStoreTreeViewIntf.ControlSetSortType(stNone);
  Supports(TreeView, IJvDynControl, DynControl);
  DynControl.ControlSetOnEnter(PropertyStoreTreeViewEnter);
  if Supports(TreeView, IJvDynControlMouse, DynControlMouse) then
    DynControlMouse.ControlSetOnMouseDown(ListBoxOnMouseDown);

  TreeSplitter := TSplitter.Create(Self);
  TreeSplitter.Align := alLeft;
  TreeSplitter.Parent := Self;
  TreeSplitter.Left := TreePanel.Left+TreePanel.Width+1;
  EditPanel  := DefaultDynControlEngine.CreatePanelControl(Self, Self, 'EditPanel', '', alClient);
  if EditPanel is TPanel then
  begin
    TPanel(EditPanel).BevelOuter := bvNone;
    TPanel(EditPanel).BorderWidth := 3;
  end;
  InfoPanel  := DefaultDynControlEngine.CreatePanelControl(Self, Self, 'InfoPanel', '', alBottom);
  if InfoPanel is TCustomPanel then
  begin
    tAccessCustomPanel(InfoPanel).BevelOuter := bvNone;
  end;
  InfoPanel.Height := 100;
  InfoGroupBox := DefaultDynControlEngine.CreateGroupBoxControl(Self, InfoPanel, 'InfoGroupBox', 'Info');
  InfoGroupBox.Align := alClient;
  Supports(InfoGroupBox, IJvDynControlCaption, InfoGroupBoxDynControlCaptionIntf);
  InfoMemoPanel  := DefaultDynControlEngine.CreatePanelControl(Self, InfoGroupBox, 'InfoMemoPanel', '', alClient);
  if InfoMemoPanel is TCustomPanel then
  begin
    tAccessCustomPanel(InfoMemoPanel).BevelOuter := bvNone;
    tAccessCustomPanel(InfoMemoPanel).BorderWidth := 3;
  end;
  InfoMemo := DefaultDynControlEngine.CreateMemoControl(Self, InfoGroupbox, 'InfoMemo');
  InfoMemo.Align := alClient;
  if Supports(InfoMemo, IJvDynControlMemo, DynControlMemo) then
  begin
    DynControlMemo.ControlSetWordWrap(True);
    DynControlMemo.ControlSetScrollbars(ssVertical);
  end;
  if Supports(InfoMemo, IJvDynControlReadOnly, DynControlReadOnly) then
    DynControlReadOnly.ControlSetReadOnly(True);
  Supports(InfoMemo, IJvDynControlData, InfoMemoDynControlDataIntf);

  ListInsertAction := TAction.Create(Self);
  ListInsertAction.Caption := RSPropertyStoreEditorListButtonInsert;
  ListInsertAction.OnExecute := ListInsertActionExecute;
  ListCopyAction := TAction.Create(Self);
  ListCopyAction.Caption := RSPropertyStoreEditorListButtonCopy;
  ListCopyAction.OnExecute := ListCopyActionExecute;
  ListEditAction := TAction.Create(Self);
  ListEditAction.Caption := RSPropertyStoreEditorListButtonEdit;
  ListEditAction.OnExecute := ListEditActionExecute;
  ListDeleteAction := TAction.Create(Self);
  ListDeleteAction.Caption := RSPropertyStoreEditorListButtonDelete;
  ListDeleteAction.OnExecute := ListDeleteActionExecute;
  ListUpAction := TAction.Create(Self);
  ListUpAction.Caption := RSPropertyStoreEditorListButtonUp;
  ListUpAction.OnExecute := ListUpActionExecute;
  ListDownAction := TAction.Create(Self);
  ListDownAction.Caption := RSPropertyStoreEditorListButtonDown;
  ListDownAction.OnExecute := ListDownActionExecute;
  ListSortUpAction := TAction.Create(Self);
  ListSortUpAction.Caption := RSPropertyStoreEditorListButtonSortUp;
  ListSortUpAction.OnExecute := ListSortUpActionExecute;
  ListSortDownAction := TAction.Create(Self);
  ListSortDownAction.Caption := RSPropertyStoreEditorListButtonSortDown;
  ListSortDownAction.OnExecute := ListSortDownActionExecute;

  ListPopupMenu := TPopupMenu.Create(Self);
  ListInsertMenu := TMenuItem.Create(Self);
  ListInsertMenu.Action := ListInsertAction;
  ListPopupMenu.Items.Add(ListInsertMenu);
  ListCopyMenu := TMenuItem.Create(Self);
  ListCopyMenu.Action := ListCopyAction;
  ListPopupMenu.Items.Add(ListCopyMenu);
  ListDeleteMenu := TMenuItem.Create(Self);
  ListDeleteMenu.Action := ListDeleteAction;
//  ListPopupMenu.Items.Add(ListDeleteMenu);
  ListLineMenu := NewLine;
  ListPopupMenu.Items.Add(ListLineMenu);
  ListUpMenu := TMenuItem.Create(Self);
  ListUpMenu.Action := ListUpAction;
  ListPopupMenu.Items.Add(ListUpMenu);
  ListDownMenu := TMenuItem.Create(Self);
  ListDownMenu.Action := ListDownAction;
  ListPopupMenu.Items.Add(ListDownMenu);
  ListSortUpMenu := TMenuItem.Create(Self);
  ListSortUpMenu.Action := ListSortUpAction;
  ListPopupMenu.Items.Add(ListSortUpMenu);
  ListSortDownMenu := TMenuItem.Create(Self);
  ListSortDownMenu.Action := ListSortDownAction;
  ListPopupMenu.Items.Add(ListSortDownMenu);

  ListPanel  := DefaultDynControlEngine.CreatePanelControl(Self, EditPanel, 'ListPanel', '', alClient);
  if ListPanel is TPanel then
    TPanel(ListPanel).BevelOuter := bvNone;
  ListInspectorPanel  := DefaultDynControlEngine.CreatePanelControl(Self, ListPanel, 'ListInspectorPanel', '', alTop);
  if ListInspectorPanel is TPanel then
    TPanel(ListInspectorPanel).BevelOuter := bvNone;
  ListInspectorPanel.Height := 141;
  ListSplitter := TSplitter.Create (Self);
  ListSplitter.Parent := ListPanel;
  ListSplitter.Align := alTop;
  ListSplitter.Cursor := crVSplit;
  ListButtonPanel  := DefaultDynControlEngine.CreatePanelControl(Self, ListPanel, 'ListButtonPanel', '', alTop);
  ListButtonPanel.Height := 25;
  if ListButtonPanel is TPanel then
    TPanel(ListButtonPanel).BevelOuter := bvNone;
  Button := DefaultDynControlEngine.CreateButton(Self, ListButtonPanel, 'ListInsertButton', RSPropertyStoreEditorListButtonInsert, '', ListInsertActionExecute);
  Button.Action := ListInsertAction;
  Button.Left := 0;
  Button.Width := 40;
  Button := DefaultDynControlEngine.CreateButton(Self, ListButtonPanel, 'ListCopyButton', RSPropertyStoreEditorListButtonCopy, '', ListCopyActionExecute);
  Button.Action := ListCopyAction;
  Button.Left := 40;
  Button.Width := 40;
  Button := DefaultDynControlEngine.CreateButton(Self, ListButtonPanel, 'ListEditButton', RSPropertyStoreEditorListButtonEdit, '', ListEditActionExecute);
  Button.Action := ListEditAction;
  Button.Left := 80;
  Button.Width := 40;
  Button := DefaultDynControlEngine.CreateButton(Self, ListButtonPanel, 'ListDeleteButton', RSPropertyStoreEditorListButtonDelete, '', ListDeleteActionExecute);
  Button.Action := ListDeleteAction;
  Button.Left := 120;
  Button.Width := 40;
  Button := DefaultDynControlEngine.CreateButton(Self, ListButtonPanel, 'ListUpButton', RSPropertyStoreEditorListButtonUp, '', ListUpActionExecute);
  Button.Action := ListUpAction;
  Button.Left := 165;
  Button.Width := 40;
  Button := DefaultDynControlEngine.CreateButton(Self, ListButtonPanel, 'ListDownButton', RSPropertyStoreEditorListButtonDown, '', ListDownActionExecute);
  Button.Action := ListDownAction;
  Button.Left := 205;
  Button.Width := 40;
  Button := DefaultDynControlEngine.CreateButton(Self, ListButtonPanel, 'ListSortUpButton', RSPropertyStoreEditorListButtonSortUp, '', ListSortUpActionExecute);
  Button.Action := ListSortUpAction;
  Button.Left := 245;
  Button.Width := 50;
  Button := DefaultDynControlEngine.CreateButton(Self, ListButtonPanel, 'ListSortDownButton', RSPropertyStoreEditorListButtonSortDown, '', ListSortDownActionExecute);
  Button.Action := ListSortDownAction;
  Button.Left := 295;
  Button.Width := 60;
  ListBox := DefaultDynControlEngine.CreateListBoxControl(Self, ListPanel, 'ListBox', Nil);
  ListBox.Align := alClient;
  Supports (ListBox, IJvDynControlItems, ListBoxControlItemsIntf);
  Supports (ListBox, IJvDynControlItemIndex, ListBoxControlItemIndexIntf);
  if Supports(ListBox, IJvDynControlDblClick, DynControlDblClick) then
    DynControlDblClick.ControlSetOnDblClick(ListEditActionExecute);
  if Supports(ListBox, IJvDynControl, DynControl) then
    DynControl.ControlSetOnEnter(ListBoxOnEnter);
  if Supports(ListBox, IJvDynControl, DynControl) then
    DynControl.ControlSetOnClick(ListBoxOnClick);
  if Supports(ListBox, IJvDynControlKey, DynControlKey) then
    DynControlKey.ControlSetOnKeyPress(ListBoxOnKeyPress);
  if Supports(ListBox, IJvDynControlMouse, DynControlMouse) then
    DynControlMouse.ControlSetOnMouseDown(ListBoxOnMouseDown);

  InspectorPanel  := DefaultDynControlEngine.CreatePanelControl(Self, EditPanel, 'InspectorPanel', '', alClient);
  if InspectorPanel is TCustomPanel then
    tAccessCustomPanel(InspectorPanel).BevelOuter := bvNone;

  Inspector := DefaultDynControlEngine.CreateRTTIInspectorControl(self, InspectorPanel,
      'Inspector', OnDisplayProperty, OnTranslatePropertyName);
  Supports (Inspector, IJvDynControlRTTIInspectorControl, RTTIInspectorControlIntf);
  RTTIInspectorControlIntf.ControlOnPropertyChange := OnPropertyChange;
  RTTIInspectorControlIntf.ControlOnTranslatePropertyName := OnInspectorTranslatePropertyName;
  Inspector.Align := alClient;
  tAccessControl(Inspector).OnCanResize := RTTIInspectorOnCanResize;
  Supports(RTTIInspectorControlIntf, IJvDynControl, DynControl);
  RTTIInspectorControlIntf.ControlDividerWidth := 200;

  DynControl.ControlSetOnEnter(RTTIInspectorEnter);

  Caption := RSPropertyStoreEditorDialogCaptionEditProperties;

  SetInformation('', '');
end;

procedure TJvPropertyStoreEditorControl.DestroyControls;
begin
  FreeAndNil(ListCopyAction);
  FreeAndNil(ListCopyMenu);
  FreeAndNil(ListDeleteAction);
  FreeAndNil(ListDeleteMenu);
  FreeAndNil(ListDownAction);
  FreeAndNil(ListDownMenu);
  FreeAndNil(ListEditAction);
  FreeAndNil(ListInsertAction);
  FreeAndNil(ListInsertMenu);
  FreeAndNil(ListSortUpAction);
  FreeAndNil(ListSortUpMenu);
  FreeAndNil(ListSortDownAction);
  FreeAndNil(ListSortDownMenu);
  FreeAndNil(ListUpAction);
  FreeAndNil(ListUpMenu);
  FreeAndNil(ListLineMenu);
  PropertyStore := nil;
  InspectedObject := nil;
  FInspectedObjectEditorHandlerIntf := nil;
  FInspectedObjectListEditorHandlerIntf := nil;
  InfoGroupBoxDynControlCaptionIntf := nil;
  InfoMemoDynControlDataIntf := nil;
  ListBoxControlItemsIntf := nil;
  ListBoxControlItemIndexIntf := nil;
  PropertyStoreTreeViewIntf := nil;
  RTTIInspectorControlIntf := nil;
  FreeAndNil(TreePanel);
  FreeAndNil(InfoMemo);
  FreeAndNil(InfoPanel);
  FreeAndNil(Inspector);
  FreeAndNil(ListPanel);
  FreeAndNil(InspectorPanel);
end;

procedure TJvPropertyStoreEditorControl.FillTreeView(GotoNodeObject: TPersistent =
    nil);
begin
  if (csDestroying in Componentstate) then
    Exit;
  if not Assigned(PropertyStoreTreeViewIntf) then
    CreateControls;
  PropertyStoreTreeViewIntf.ControlItems.BeginUpdate;
  try
    PropertyStoreTreeViewIntf.ControlItems.Clear;
    FillTreeViewByComponent(PropertyStoreTreeViewIntf.ControlItems, nil, PropertyStore);
  finally
    PropertyStoreTreeViewIntf.ControlItems.EndUpdate;
  end;
  if not Assigned(GotoNodeObject ) then
    if PropertyStoreTreeViewIntf.ControlItems.Count > 0 then
      GotoEditObject(PropertyStoreTreeViewIntf.ControlItems[0].Data)
    else
      GotoEditObject(nil)
  else
    GotoEditObject(GotoNodeObject);
end;

procedure TJvPropertyStoreEditorControl.FillTreeViewByComponent(TreeNodes:
    TTreeNodes; Parent: TTreeNode; aPropertyStore: TPersistent);
var
  I: Integer;
  SubObj: TObject;
  Node: TTreeNode;
  PropName: string;
  PropertyEditorHandler: IJvPropertyEditorHandler;
  DetailPropertyEditorHandler: IJvPropertyEditorHandler;
  PropertyListEditorHandler: IJvPropertyListEditorHandler;

begin
  if not assigned(aPropertyStore) or
    not Supports(aPropertyStore, IJvPropertyEditorHandler, PropertyEditorHandler) then
    Exit;
  if not Assigned(Parent) then
  begin
    Node := TreeNodes.AddChildObject(Parent, PropertyEditorHandler.EditIntf_GetVisibleObjectName,
      aPropertyStore);
    FillTreeViewByComponent(TreeNodes, Node,
      aPropertyStore);
  end
  else
  begin
    RTTIInspectorControlIntf.ControlInspectedObject := aPropertyStore;
    for I := 0 to GetPropCount(aPropertyStore) - 1 do
    begin
      PropName := GetPropName(aPropertyStore,I);
      if PropIsType(aPropertyStore, PropName, tkClass) then
      begin
        SubObj := GetObjectProp(aPropertyStore, PropName);
        if PropertyEditorHandler.EditIntf_DisplayProperty(PropName) then
        if ShowPropertyInTreeView (aPropertyStore, PropName) then
        if Supports(SubObj, IJvPropertyEditorHandler, DetailPropertyEditorHandler) then
        if (SubObj is TPersistent)then
         begin
           Node := TreeNodes.AddChildObject(Parent,
               DetailPropertyEditorHandler.EditIntf_TranslatePropertyName(PropName),
               SubObj);
           FillTreeViewByComponent(TreeNodes, Node, TPersistent(SubObj));
         end;
      end;
    end;
    if Supports (aPropertyStore, IJvPropertyListEditorHandler, PropertyListEditorHandler) then
      for i := 0 to PropertyListEditorHandler.ListEditIntf_ObjectCount  - 1 do
      begin
        SubObj := PropertyListEditorHandler.ListEditIntf_GetObject(i);
        if Supports(SubObj, IJvPropertyEditorHandler, DetailPropertyEditorHandler) and
          (SubObj is TPersistent) then
        begin
          Node := TreeNodes.AddChildObject(Parent,
            DetailPropertyEditorHandler.EditIntf_GetVisibleObjectName, SubObj);
          FillTreeViewByComponent(TreeNodes, Node, TPersistent(SubObj));
        end;
      end;
  end;
end;

function TJvPropertyStoreEditorControl.GetPropCount(Instance: TPersistent):
    Integer;
var
  Data: PTypeData;
begin
  Data := GetTypeData(Instance.ClassInfo);
  Result := Data.PropCount;
end;

function TJvPropertyStoreEditorControl.GetPropName(Instance: TPersistent; Index:
    Integer): string;
var
  PropList: PPropList;
  PropInfo: PPropInfo;
  Data: PTypeData;
begin
  Result := '';
  Data := GetTypeData(Instance.ClassInfo);
  GetMem(PropList, Data^.PropCount * SizeOf(PPropInfo));
  try
    GetPropInfos(Instance.ClassInfo, PropList);
    PropInfo := PropList^[Index];
    Result := {$IFDEF SUPPORTS_UNICODE}UTF8ToString{$ENDIF SUPPORTS_UNICODE}(PropInfo^.Name);
  finally
    FreeMem(PropList, Data^.PropCount * SizeOf(PPropInfo));
  end;
end;

procedure TJvPropertyStoreEditorControl.GotoEditObject(EditObject: TPersistent);
var
  TreeNode: TTreeNode;
  i: Integer;
begin
  if csDestroying in Componentstate then
    Exit;
  if not Assigned(EditObject) then
  begin
    PropertyStoreTreeViewChange(nil, PropertyStoreTreeViewIntf.ControlSelected);
    Exit;
  end;
  for i  := 0 to PropertyStoreTreeViewIntf.ControlItems.Count - 1 do
  begin
    TreeNode := PropertyStoreTreeViewIntf.ControlItems[i];
    if Assigned(TreeNode.Data) and (TreeNode.Data = EditObject) then
    begin
      TreeNode.Expand(false);
      PropertyStoreTreeViewIntf.ControlSelected := TreeNode;
      Exit;
    end;
  end;
end;

procedure TJvPropertyStoreEditorControl.FillListBox;
var
  DetailObjectEditorHandler: IJvPropertyEditorHandler;
  i: Integer;
  SubObj: TObject;
begin
  if csDestroying in Componentstate then
    Exit;
  ListBoxControlItemsIntf.ControlItems.Clear;
  for i := 0 to InspectedObjectListEditorHandlerIntf.ListEditIntf_ObjectCount - 1 do
  begin
    SubObj := InspectedObjectListEditorHandlerIntf.ListEditIntf_GetObject(i);
    if Supports(SubObj, IJvPropertyEditorHandler, DetailObjectEditorHandler) then
    begin
      ListBoxControlItemsIntf.ControlItems.AddObject(DetailObjectEditorHandler.EditIntf_GetVisibleObjectName + ' - ' + ' [' + inttostr(i + 1) + '] ', SubObj);
    end;
  end;
end;

procedure TJvPropertyStoreEditorControl.JvInspectorAfterItemCreate(Sender:
    TObject; Item: TJvCustomInspectorItem);
begin
  if Assigned(Item) and Assigned(InspectedObjectEditorHandlerIntf) then
    Item.DisplayName := InspectedObjectEditorHandlerIntf.EditIntf_TranslatePropertyName(Item.Name);
end;

procedure TJvPropertyStoreEditorControl.JvInspectorBeforeItemCreate(Sender:
  TObject; Data: TJvCustomInspectorData; var ItemClass:
  TJvInspectorItemClass);
var
  PropertyEditorHandler: IJvPropertyEditorHandler;
begin
  if Assigned(Data) and
     (Data is TJvInspectorPropData) and
     Assigned(TJvInspectorPropData(Data).Instance)  then
  begin
    if Supports(TJvInspectorPropData(Data).Instance, IJvPropertyEditorHandler, PropertyEditorHandler) then
      if not PropertyEditorHandler.EditIntf_DisplayProperty(Data.Name) then
        ItemClass := nil
      else if ShowPropertyInTreeView(TJvInspectorPropData(Data).Instance, Data.Name)  then
        ItemClass := nil;
  end;
end;

procedure TJvPropertyStoreEditorControl.ListBoxOnClick(Sender: TObject);
begin
  if Assigned(ListBoxControlItemIndexIntf) then
    InspectedObjectListItemIndex := ListBoxControlItemIndexIntf.ControlItemIndex
  else
    InspectedObjectListItemIndex := -1;
end;

procedure TJvPropertyStoreEditorControl.ListBoxOnEnter(Sender: TObject);
begin
  if Assigned(ListBoxControlItemIndexIntf) then
    InspectedObjectListItemIndex := ListBoxControlItemIndexIntf.ControlItemIndex
  else
    InspectedObjectListItemIndex := -1;
end;

procedure TJvPropertyStoreEditorControl.ListBoxOnKeyPress(Sender: TObject; var Key: Char);
begin
  if Assigned(ListBoxControlItemIndexIntf) then
    InspectedObjectListItemIndex := ListBoxControlItemIndexIntf.ControlItemIndex
  else
    InspectedObjectListItemIndex := -1;
end;

procedure TJvPropertyStoreEditorControl.ListCopyActionExecute(Sender: TObject);
var
  NewObject: TPersistent;
begin
  if Assigned(InspectedObjectListEditorHandlerIntf) then
  begin
    NewObject := InspectedObjectListEditorHandlerIntf.ListEditIntf_CloneNewObject(InspectedObjectListItemIndex);
    if Assigned(NewObject) then
    begin
      FillTreeView (NewObject);
    end;
  end;
end;

procedure TJvPropertyStoreEditorControl.ListDeleteActionExecute(Sender: TObject);
var
  EditObject: TPersistent;
begin
  if Assigned(InspectedObjectListEditorHandlerIntf) then
    if (MessageDlg(RSPropertyStoreEditorDeleteEntry, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      EditObject := TPersistent(PropertyStoreTreeViewIntf.ControlSelected.Data);
      if EditObject = InspectedObjectListEditorHandlerIntf.ListEditIntf_GetObject (InspectedObjectListItemIndex) then
        if (InspectedObjectListItemIndex < InspectedObjectListEditorHandlerIntf.ListEditIntf_ObjectCount-1)
          and (InspectedObjectListItemIndex > 0) then
          EditObject := InspectedObjectListEditorHandlerIntf.ListEditIntf_GetObject (InspectedObjectListItemIndex)
        else if InspectedObjectListEditorHandlerIntf.ListEditIntf_ObjectCount-1 > 0 then
          EditObject := InspectedObjectListEditorHandlerIntf.ListEditIntf_GetObject (0)
        else
          EditObject := TPersistent(PropertyStoreTreeViewIntf.ControlSelected.Parent.Data);
      InspectedObjectListEditorHandlerIntf.ListEditIntf_DeleteObject(InspectedObjectListItemIndex);
      FillTreeView (EditObject);
    end;
end;

procedure TJvPropertyStoreEditorControl.ListDownActionExecute(Sender: TObject);
var
  EditObject: TPersistent;
  Ind : Integer;
begin
  if Assigned(InspectedObjectListEditorHandlerIntf) and (InspectedObjectListItemIndex < ListBoxControlItemsIntf.ControlItems.Count) then
  begin
    EditObject := TPersistent(PropertyStoreTreeViewIntf.ControlSelected.Data);
    Ind := InspectedObjectListItemIndex;
    InspectedObjectListEditorHandlerIntf.ListEditIntf_MoveObjectPosition(InspectedObjectListItemIndex, InspectedObjectListItemIndex+1);
    FillTreeView (EditObject);
    InspectedObjectListItemIndex := Ind +1;
  end;
end;

procedure TJvPropertyStoreEditorControl.ListEditActionExecute(Sender: TObject);
var
  EditObject: TPersistent;
begin
  if Assigned(InspectedObjectListEditorHandlerIntf) then
  begin
    EditObject := InspectedObjectListEditorHandlerIntf.ListEditIntf_GetObject(InspectedObjectListItemIndex);
    if Assigned(EditObject) then
      GotoEditObject (EditObject);
  end;
end;

procedure TJvPropertyStoreEditorControl.ListInsertActionExecute(Sender: TObject);
var
  newObject: TPersistent;
begin
  if Assigned(InspectedObjectListEditorHandlerIntf) then
  begin
    NewObject := InspectedObjectListEditorHandlerIntf.ListEditIntf_CreateNewObject;
    FillTreeView (NewObject);
  end;
end;

procedure TJvPropertyStoreEditorControl.ListBoxOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var aPos:TPoint;
begin
  if (Button = mbRight) and Assigned(InspectedObjectListEditorHandlerIntf) and
    Assigned(Sender) and (Sender is TWinControl) then
  begin
    aPos := TWinControl(Sender).ClientToScreen(Point(X, Y));
    ListPopupMenu.Popup(aPos.x,aPos.y);
  end;
end;

procedure TJvPropertyStoreEditorControl.ListUpActionExecute(Sender: TObject);
var
  EditObject: TPersistent;
  Ind : Integer;
begin
  if Assigned(InspectedObjectListEditorHandlerIntf) and (InspectedObjectListItemIndex > 0) then
  begin
    EditObject := TPersistent(PropertyStoreTreeViewIntf.ControlSelected.Data);
    Ind := InspectedObjectListItemIndex;
    InspectedObjectListEditorHandlerIntf.ListEditIntf_MoveObjectPosition(InspectedObjectListItemIndex, InspectedObjectListItemIndex-1);
    FillTreeView (EditObject);
    InspectedObjectListItemIndex := Ind -1;
  end;
end;

procedure TJvPropertyStoreEditorControl.ListSortUpActionExecute(Sender: TObject);
var
  EditObject: TPersistent;
begin
  if Assigned(InspectedObjectListEditorHandlerIntf) and (ListBoxControlItemsIntf.ControlItems.Count > 0) then
  begin
    EditObject := TPersistent(PropertyStoreTreeViewIntf.ControlSelected.Data);
    InspectedObjectListEditorHandlerIntf.ListEditIntf_SortObjects(True);
    FillTreeView (EditObject);
    InspectedObjectListItemIndex := 0;
  end;
end;

procedure TJvPropertyStoreEditorControl.ListSortDownActionExecute(Sender:
    TObject);
var
  EditObject: TPersistent;
begin
  if Assigned(InspectedObjectListEditorHandlerIntf) and (ListBoxControlItemsIntf.ControlItems.Count > 0) then
  begin
    EditObject := TPersistent(PropertyStoreTreeViewIntf.ControlSelected.Data);
    InspectedObjectListEditorHandlerIntf.ListEditIntf_SortObjects(False);
    FillTreeView (EditObject);
    InspectedObjectListItemIndex := 0;
  end;
end;

procedure TJvPropertyStoreEditorControl.Notification(AComponent: TComponent;
    Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FPropertyStore) then
  begin
    PropertyStore := nil;
    InspectedObject := nil;
  end;
end;

procedure TJvPropertyStoreEditorControl.PropertyStoreTreeViewEnter(Sender: TObject);
begin
  if Assigned(InspectedObjectEditorHandlerIntf) then
    SetInformation (InspectedObjectEditorHandlerIntf.EditIntf_GetVisibleObjectName, InspectedObjectEditorHandlerIntf.EditIntf_GetObjectHint);
end;

function TJvPropertyStoreEditorControl.OnDisplayProperty(const aPropertyName :
    String): Boolean;
begin
  if Assigned(InspectedObjectEditorHandlerIntf) then
    Result := InspectedObjectEditorHandlerIntf.EditIntf_DisplayProperty(aPropertyName)
       and InspectedObjectEditorHandlerIntf.EditIntf_IsPropertySimple(aPropertyName)
  else
    Result := False;
end;

function TJvPropertyStoreEditorControl.OnInspectorTranslatePropertyName(const
    aPropertyName : String): string;
begin
  if Assigned(InspectedObjectEditorHandlerIntf) then
    Result := InspectedObjectEditorHandlerIntf.EditIntf_TranslatePropertyName(aPropertyName)
  else
    Result := aPropertyName;
end;

procedure TJvPropertyStoreEditorControl.OnPropertyChange(var OldPropertyName,
    NewPropertyName : string);
begin
  if Assigned(InspectedObjectEditorHandlerIntf) then
    SetInformation (InspectedObjectEditorHandlerIntf.EditIntf_TranslatePropertyName(NewPropertyName),
                    InspectedObjectEditorHandlerIntf.EditIntf_GetPropertyHint(NewPropertyName));
end;

procedure TJvPropertyStoreEditorControl.PropertyStoreTreeViewChange(Sender:
    TObject; Node: TTreeNode);
begin
  if csDestroying in Componentstate then
    Exit;
  if not Assigned(Node) or
    not Assigned(Node.Data) or
    not (TObject(Node.Data) is TPersistent) or
    not (Supports(TObject(Node.Data), IJvPropertyEditorHandler)) then
    InspectedObject := nil
  else
  begin
    InspectedObject :=
      TPersistent(Node.Data);
    if Assigned(Node.Parent) and Assigned(Node.Parent.Data)
      and (TObject(Node.Parent.Data) is TPersistent)
      and (Supports(TObject(Node.Parent.Data), IJvPropertyListEditorHandler)) then
    begin
      ChangeInspectedObjectListEditorHandlerIntf(TObject(Node.Parent.Data));
      if Assigned(InspectedObjectListEditorHandlerIntf) then
        InspectedObjectListItemIndex := InspectedObjectListEditorHandlerIntf.ListEditIntf_IndexOfObject(InspectedObject);
    end;
  end;
end;

procedure TJvPropertyStoreEditorControl.PropertyStoreTreeViewChanging(Sender:
    TObject; Node: TTreeNode; var AllowChange: Boolean);
var JvPropertyEditorHandler : IJvPropertyEditorHandler;
begin
  if csDestroying in Componentstate then
    Exit;
  RTTIInspectorControlIntf.ControlSaveEditorValues;
  if Assigned(PropertyStoreTreeViewIntf.ControlSelected) and
    Assigned(PropertyStoreTreeViewIntf.ControlSelected.Data) and
    (TObject(PropertyStoreTreeViewIntf.ControlSelected.Data) is TPersistent) then
    if Supports(TObject(PropertyStoreTreeViewIntf.ControlSelected.Data),
      IJvPropertyEditorHandler, JvPropertyEditorHandler) then
      if (JvPropertyEditorHandler.EditIntf_GetVisibleObjectName  <> '') then
        PropertyStoreTreeViewIntf.ControlSelected.Text := JvPropertyEditorHandler.EditIntf_GetVisibleObjectName;
end;

procedure TJvPropertyStoreEditorControl.SetInspectedObject(const Value:
    TPersistent);
begin
  if csDestroying in Componentstate then
  begin
    FInspectedObject := nil;
    FInspectedObjectEditorHandlerIntf := nil;
    FInspectedObjectListEditorHandlerIntf := nil;
    if Assigned(RTTIInspectorControlIntf) then
      RTTIInspectorControlIntf.ControlInspectedObject := Value;
    Exit;
  end;
  FInspectedObject := Value;
  Supports(InspectedObject, IJvPropertyEditorHandler, FInspectedObjectEditorHandlerIntf);
  ChangeInspectedObjectListEditorHandlerIntf(InspectedObject);
  RTTIInspectorControlIntf.ControlSaveEditorValues;
  RTTIInspectorControlIntf.ControlInspectedObject := Value;
  if Assigned(InspectedObjectListEditorHandlerIntf) then
  begin
    ListPanel.visible := True;
    Inspector.Parent := ListInspectorPanel;
    InspectorPanel.visible := False;
    ListInspectorPanel.visible := RTTIInspectorControlIntf.ControlGetVisibleItemsCount > 0;
    ListSplitter.visible := ListInspectorPanel.visible;
    ListButtonPanel.Top := ListInspectorPanel.Top+ListInspectorPanel.Height+1;
    ListSplitter.Top := ListButtonPanel.Top-1;
    FillListBox;
  end
  else
  begin
    InspectorPanel.visible := True;
    ListPanel.visible := False;
    Inspector.Parent := InspectorPanel;
  end;
  if Assigned(InspectedObjectEditorHandlerIntf) then
    SetInformation (InspectedObjectEditorHandlerIntf.EditIntf_GetVisibleObjectName, InspectedObjectEditorHandlerIntf.EditIntf_GetObjectHint);
end;

procedure TJvPropertyStoreEditorControl.SetPropertyStore(const Value: TComponent);
begin
  if csDestroying in Componentstate then
    Exit;
  if Assigned(Value) and not Supports(Value, IJvPropertyEditorHandler) then
    Raise Exception.Create ('TJvPropertyStoreEditorControl.SetPropertyStore : PropertyStore must support IJvPropertyEditorHandler');
  ReplaceComponentReference(Self, Value, TComponent(FPropertyStore));
  FillTreeView(Value);
end;

function TJvPropertyStoreEditorControl.ShowPropertyInTreeView(PropObject: TObject;
    const PropertyName: string): Boolean;
var
  PropertyEditorHandler: IJvPropertyEditorHandler;
begin
  Result := True;
  if csDestroying in Componentstate then
    Exit;
  if not Assigned(PropObject) then
    Result := False
  else
    if Supports(PropObject, IJvPropertyEditorHandler, PropertyEditorHandler) then
    begin
      Result := (not PropertyEditorHandler.EditIntf_IsPropertySimple(PropertyName));
      Result := Result or (not RTTIInspectorControlIntf.ControlIsPropertySupported(PropertyName))
    end
    else
      Result := not RTTIInspectorControlIntf.ControlIsPropertySupported(PropertyName);
end;

function TJvPropertyStoreEditorControl.OnTranslatePropertyName(const aPropertyName :
    String): string;
begin
  Result := aPropertyName;
end;

procedure TJvPropertyStoreEditorControl.RTTIInspectorEnter(Sender:
    TObject);
begin
  if csDestroying in Componentstate then
    Exit;
  if Assigned(InspectedObjectEditorHandlerIntf) and Assigned(RTTIInspectorControlIntf) then
    SetInformation (InspectedObjectEditorHandlerIntf.EditIntf_TranslatePropertyName(RTTIInspectorControlIntf.ControlGetCurrentPropertyName),
                    InspectedObjectEditorHandlerIntf.EditIntf_GetPropertyHint(RTTIInspectorControlIntf.ControlGetCurrentPropertyName));
end;

procedure TJvPropertyStoreEditorControl.RTTIInspectorOnCanResize(Sender:
    TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
var
  Ratio: Double;
begin
  if not Assigned(RTTIInspectorControlIntf) then
    Exit;
  Ratio := Inspector.Width / RTTIInspectorControlIntf.ControlDividerWidth;
  RTTIInspectorControlIntf.ControlDividerWidth := Round(NewWidth/Ratio);
end;

procedure TJvPropertyStoreEditorControl.SetActionsEnabled;
begin
  ListInsertAction.Enabled := Assigned(FInspectedObjectListEditorHandlerIntf);
  ListCopyAction.Enabled := ListInsertAction.Enabled and (InspectedObjectListItemIndex >= 0);
  ListDownAction.Enabled := ListCopyAction.Enabled and (InspectedObjectListItemIndex < InspectedObjectListEditorHandlerIntf.ListEditIntf_ObjectCount-1);
  ListUpAction.Enabled := ListCopyAction.Enabled and (InspectedObjectListItemIndex > 0);
  ListDeleteAction.Enabled := ListCopyAction.Enabled;
  ListEditAction.Enabled := ListCopyAction.Enabled;
  ListSortUpAction.Enabled := ListInsertAction.Enabled and (InspectedObjectListEditorHandlerIntf.ListEditIntf_ObjectCount > 0);
  ListSortDownAction.Enabled := ListSortUpAction.Enabled ;
end;

procedure TJvPropertyStoreEditorControl.ChangeInspectedObjectListEditorHandlerIntf(iObject: TObject);
begin
  Supports(iObject, IJvPropertyListEditorHandler, FInspectedObjectListEditorHandlerIntf);
  InspectedObjectListEditorHandlerIntf := FInspectedObjectListEditorHandlerIntf; // Wegen dem Set-Aufruf
end;

procedure TJvPropertyStoreEditorControl.SetInformation(const iCaption, iInfo:
    string);
begin
  if csDestroying in Componentstate then
    Exit;
  InfoMemoDynControlDataIntf.ControlValue := iInfo;
  InfoGroupBoxDynControlCaptionIntf.ControlSetCaption(iCaption);
  InfoPanel.Visible := iInfo <> '';
end;

procedure TJvPropertyStoreEditorControl.SetInspectedObjectListEditorHandlerIntf(const Value:
    IJvPropertyListEditorHandler);
begin
  FInspectedObjectListEditorHandlerIntf := Value;
  InspectedObjectListItemIndex := -1;
end;

procedure TJvPropertyStoreEditorControl.SetInspectedObjectListItemIndex(const Value: Integer);
begin
  FInspectedObjectListItemIndex := Value;
  SetActionsEnabled;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.