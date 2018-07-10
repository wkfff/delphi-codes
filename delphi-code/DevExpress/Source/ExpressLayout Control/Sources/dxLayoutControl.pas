{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressLayoutControl main components                     }
{                                                                    }
{           Copyright (c) 2001-2011 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSLAYOUTCONTROL AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit dxLayoutControl;

{$I cxVer.inc}

interface

uses
  Messages, Windows, SysUtils, Classes, Menus, Graphics, DB,
  Forms, Controls {after Forms for D12},
  StdCtrls, ExtCtrls, IniFiles, Contnrs, ImgList,
  dxCore, dxMessages, cxClasses, cxGeometry, cxGraphics, cxControls,
  cxLookAndFeels, cxLibraryConsts, cxLookAndFeelPainters, cxDBEdit,
  dxLayoutLookAndFeels, dxLayoutCommon, dxLayoutSelection, cxPC, dxLayoutContainer;

const
  htAvailableItems = 40;
  htTreeViewItems = 50;

type
  TdxCustomLayoutControl = class;
  TdxLayoutControlPainter = class;
  TdxLayoutControlPainterClass = class of TdxLayoutControlPainter;
  TdxLayoutControlViewInfo = class;
  TdxLayoutControlViewInfoClass = class of TdxLayoutControlViewInfo;

  { TdxLayoutControlPersistent }

  TdxLayoutControlPersistent = class(TPersistent)
  private
    FControl: TdxCustomLayoutControl;
  protected
    procedure Changed; virtual;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AControl: TdxCustomLayoutControl); virtual;
    property Control: TdxCustomLayoutControl read FControl;
  end;

  { conatiner }

  TdxLayoutControlContainerPainter = class(TdxLayoutContainerPainter);

  TdxLayoutControlContainerViewInfo = class(TdxLayoutContainerViewInfo);

  { TdxLayoutControlContainer }

  TdxLayoutControlContainer = class(TdxLayoutContainer)
  private
    FControl: TdxCustomLayoutControl;
    function GetPainter: TdxLayoutControlContainerPainter;
    function GetViewInfo: TdxLayoutControlContainerViewInfo;
  protected
    function GetPainterClass: TdxLayoutContainerPainterClass; override;
    function GetViewInfoClass: TdxLayoutContainerViewInfoClass; override;
    // storing custom properties
    procedure GetItemStoredCustomProperties(AItem: TdxCustomLayoutItem;
      AProperties: TStrings); override;
    procedure GetItemStoredCustomPropertyValue(AItem: TdxCustomLayoutItem;
      const AName: string; var AValue: Variant); override;
    procedure SetItemStoredCustomPropertyValue(AItem: TdxCustomLayoutItem;
      const AName: string; const AValue: Variant); override;
    function GetStoredProperties(AProperties: TStrings): Boolean; override;
    procedure GetStoredPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetStoredPropertyValue(const AName: string; const AValue: Variant); override;

    property Painter: TdxLayoutControlContainerPainter read GetPainter;
  public
    constructor Create(AControl: TdxCustomLayoutControl); reintroduce; virtual;

    property Control: TdxCustomLayoutControl read FControl;
    property ViewInfo: TdxLayoutControlContainerViewInfo read GetViewInfo;
  end;
  TdxLayoutControlContainerClass = class of TdxLayoutControlContainer;

  { controls }

  { TdxStoringOptions }

  TdxStoringOptions = class(TPersistent)
  private
    FIniFileName: string;
    FRegistryPath: string;
    FStoreToIniFile: Boolean;
    FStoreToRegistry: Boolean;
  protected
    function CanStoreToIniFile: Boolean;
    function CanStoreToRegistry: Boolean;
    function CanRestoreFromIniFile: Boolean;
    function CanRestoreFromRegistry: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property IniFileName: string read FIniFileName write FIniFileName;
    property RegistryPath: string read FRegistryPath write FRegistryPath;
    property StoreToIniFile: Boolean read FStoreToIniFile write FStoreToIniFile default False;
    property StoreToRegistry: Boolean read FStoreToRegistry write FStoreToRegistry default False;
  end;

  TdxLayoutItemOptions = class(TdxLayoutControlPersistent)
  private
    FAutoControlAreaAlignment: Boolean;
    FAutoControlTabOrders: Boolean;
    FFocusControlOnItemCaptionClick: Boolean;
    FShowLockedGroupChildren: Boolean;
    FSizableHorz: Boolean;
    FSizableVert: Boolean;

    procedure SetAutoControlAreaAlignment(Value: Boolean);
    procedure SetAutoControlTabOrders(Value: Boolean);
    procedure SetShowLockedGroupChildren(Value: Boolean);
  protected
    procedure Changed; override;
  public
    constructor Create(AControl: TdxCustomLayoutControl); override;
    procedure Assign(Source: TPersistent); override;
  published
    property AutoControlAreaAlignment: Boolean read FAutoControlAreaAlignment write SetAutoControlAreaAlignment default True;
    property AutoControlTabOrders: Boolean read FAutoControlTabOrders write SetAutoControlTabOrders default True;
    property FocusControlOnItemCaptionClick: Boolean read FFocusControlOnItemCaptionClick write FFocusControlOnItemCaptionClick default False;
    property ShowLockedGroupChildren: Boolean read FShowLockedGroupChildren write SetShowLockedGroupChildren default True;
    property SizableHorz: Boolean read FSizableHorz write FSizableHorz default False;
    property SizableVert: Boolean read FSizableVert write FSizableVert default False;
  end;

  TdxLayoutAutoContentSize = (acsWidth, acsHeight);
  TdxLayoutAutoContentSizes = set of TdxLayoutAutoContentSize;

  { TdxCustomLayoutControl }

  { TdxCustomLayoutControlHandler }

  TdxCustomLayoutControlHandler = class(TcxIUnknownObject)
  private
    FControl: TdxCustomLayoutControl;
    function GetViewInfo: TdxLayoutControlViewInfo;
  protected
    property Control: TdxCustomLayoutControl read FControl;
    property ViewInfo: TdxLayoutControlViewInfo read GetViewInfo;
  public
    constructor Create(AControl: TdxCustomLayoutControl); virtual;
  end;

  { TdxCustomLayoutControl }

  TdxLayoutControlGetItemStoredPropertiesEvent = procedure (Sender: TdxCustomLayoutControl;
    AItem: TdxCustomLayoutItem; AProperties: TStrings) of object;
  TdxLayoutControlGetItemStoredPropertyValueEvent = procedure (Sender: TdxCustomLayoutControl;
    AItem: TdxCustomLayoutItem; const AName: string; var AValue: Variant) of object;
  TdxLayoutControlSetItemStoredPropertyValueEvent = procedure (Sender: TdxCustomLayoutControl;
    AItem: TdxCustomLayoutItem; const AName: string; const AValue: Variant) of object;
  TdxLayoutControlGetStoredPropertiesEvent = procedure (Sender: TdxCustomLayoutControl;
    AProperties: TStrings) of object;
  TdxLayoutControlGetStoredPropertyValueEvent = procedure (Sender: TdxCustomLayoutControl;
    const AName: string; var AValue: Variant) of object;
  TdxLayoutControlSetStoredPropertyValueEvent = procedure (Sender: TdxCustomLayoutControl;
    const AName: string; const AValue: Variant) of object;

  TdxCustomLayoutControl = class(TcxControl,
    IdxLayoutControl,
    IdxLayoutFontHelper,
    IdxLayoutItemsHelper,
    IdxLayoutComponent,
    IdxLayoutDragAndDropHelper,
    IdxLayoutLookAndFeelUser,
    IdxSkinSupport,
    IdxCustomizeControlsHelper,
    IcxEditorFieldLink,
    IdxLayoutContainer)
  private
    FBoldFont: TFont;
    FDragDropHitTest: TdxCustomLayoutHitTest;
    FLeftPos: Integer;
    FRightButtonPressed: Boolean;
    FTopPos: Integer;
    FRedrawOnResize: Boolean;

    // Objects
    FOptionsItem: TdxLayoutItemOptions;
    FOptionsStoring: TdxStoringOptions;
    FLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    FPainter: TdxLayoutControlPainter;
    FViewInfo: TdxLayoutControlViewInfo;

    FContainer: TdxLayoutControlContainer;

    // Customization
    FIsPopupShown: Boolean;
    // Storing
    FStoredStream: TMemoryStream;

    FOnCustomization: TNotifyEvent;
    FOnGetItemStoredProperties: TdxLayoutControlGetItemStoredPropertiesEvent;
    FOnGetItemStoredPropertyValue: TdxLayoutControlGetItemStoredPropertyValueEvent;
    FOnSetItemStoredPropertyValue: TdxLayoutControlSetItemStoredPropertyValueEvent;
    FOnGetStoredProperties: TdxLayoutControlGetStoredPropertiesEvent;
    FOnGetStoredPropertyValue: TdxLayoutControlGetStoredPropertyValueEvent;
    FOnSetStoredPropertyValue: TdxLayoutControlSetStoredPropertyValueEvent;
    // Get/Set Properties
    function GetAutoContentSizes: TdxLayoutAutoContentSizes;
    function GetContentBounds: TRect;
    function GetCustomization: Boolean;
    function GetCustomizeAvailableItemsViewKind: TdxLayoutAvailableItemsViewKind;
    function GetCustomizeForm: TdxLayoutControlCustomCustomizeForm;
    function GetCustomizeFormBounds: TRect;
    function GetCustomizeFormClass: TdxLayoutControlCustomCustomizeFormClass;
    function GetCustomizeFormTabbedView: Boolean;
    function GetHighlightRoot: Boolean;
    function GetIsLayoutLoading: Boolean;
    function GetItems: TdxLayoutGroup;
    function GetLayoutDirection: TdxLayoutDirection;
    function GetMenuItems: TdxLayoutCustomizeFormMenuItems;
    function GetOccupiedClientHeight: Integer;
    function GetOccupiedClientWidth: Integer;
    function GetOptionsImage: TdxLayoutImageOptions;
    function GetShowDesignSelectors: Boolean;
    function GetUndoRedoManager: TdxUndoRedoManager;
    procedure SetAutoContentSizes(Value: TdxLayoutAutoContentSizes);
    procedure SetCustomization(Value: Boolean);
    procedure SetCustomizeAvailableItemsViewKind(Value: TdxLayoutAvailableItemsViewKind);
    procedure SetCustomizeFormBounds(const AValue: TRect);
    procedure SetCustomizeFormClass(AValue: TdxLayoutControlCustomCustomizeFormClass);
    procedure SetCustomizeFormTabbedView(Value: Boolean);
    procedure SetHighlightRoot(Value: Boolean);
    procedure SetLayoutDirection(Value: TdxLayoutDirection);
    procedure SetLayoutLookAndFeel(Value: TdxCustomLayoutLookAndFeel);
    procedure SetLeftPos(Value: Integer);
    procedure SetMenuItems(Value: TdxLayoutCustomizeFormMenuItems);
    procedure SetOptionsImage(Value: TdxLayoutImageOptions);
    procedure SetOptionsItem(Value: TdxLayoutItemOptions);
    procedure SetShowDesignSelectors(Value: Boolean);
    procedure SetTopPos(Value: Integer);

    // Items
    function GetAutoControlAlignment: Boolean;
    function GetAutoControlTabOrders: Boolean;
    function GetAbsoluteItem(Index: Integer): TdxCustomLayoutItem;
    function GetAbsoluteItemCount: Integer;
    function GetAlignmentConstraint(Index: Integer): TdxLayoutAlignmentConstraint;
    function GetAlignmentConstraintCount: Integer;
    function GetAvailableItem(Index: Integer): TdxCustomLayoutItem;
    function GetAvailableItemCount: Integer;
    procedure SetAutoControlAlignment(Value: Boolean);
    procedure SetAutoControlTabOrders(Value: Boolean);

    // Storing
    procedure SetOptionsStoring(Value: TdxStoringOptions);
    function GetIniFileName: string;
    function GetRegistryPath: string;
    function GetStoreInIniFile: Boolean;
    function GetStoreInRegistry: Boolean;
    procedure SetIniFileName(const Value: string);
    procedure SetRegistryPath(const Value: string);
    procedure SetStoreInIniFile(const Value: Boolean);
    procedure SetStoreInRegistry(const Value: Boolean);

    procedure CreateHandlers;
    procedure DestroyHandlers;

    // Other
    procedure ContainerChangedHandler(Sender: TObject);
    procedure ContainerSelectionChangedHandler(Sender: TObject);
    procedure InitializeSubControlsCxLookAndFeel;
    procedure RefreshBoldFont;

    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure CMChildKey(var Message: TCMChildKey); message CM_CHILDKEY;
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMTabStopChanged(var Message: TMessage); message CM_TABSTOPCHANGED;
    procedure DXMPlaceControls(var Message: TMessage); message DXM_LAYOUT_PLACECONTROLS;
    procedure DXMBuildSelectionLayer(var Message: TMessage); message DXM_LAYOUT_BUILDSELECTIONLAYER;
    procedure DXMInvalidateSelectionLayer(var Message: TMessage); message DXM_LAYOUT_INVALIDATESELECTIONLAYER;
    procedure DXMCustomizeFormUpdate(var Message: TMessage); message DXM_REFRESHCUSTOMIZATION;
  protected
    //IdxLayoutFontHelper
    function GetBoldFont: TFont;
    function GetDefaultFont: TFont;
    //IdxLayoutLookAndFeelUser
    procedure IdxLayoutLookAndFeelUser.BeginLookAndFeelDestroying = BeginLayoutLookAndFeelUserDestroying;
    procedure IdxLayoutLookAndFeelUser.EndLookAndFeelDestroying = EndLayoutLookAndFeelUserDestroying;
    procedure IdxLayoutLookAndFeelUser.LookAndFeelChanged = LayoutLookAndFeelUserChanged;
    procedure IdxLayoutLookAndFeelUser.LookAndFeelDestroyed = LayoutLookAndFeelUserDestroyed;
    procedure BeginLayoutLookAndFeelUserDestroying; stdcall;
    procedure EndLayoutLookAndFeelUserDestroying; stdcall;
    procedure LayoutLookAndFeelUserChanged; stdcall;
    procedure LayoutLookAndFeelUserDestroyed; stdcall;
    //IdxLayoutComponent
    procedure SelectionChanged; stdcall;
    //IdxCustomizeControlsHelper
    function CanProcessChildren: Boolean; virtual;
    //IdxLayoutDragAndDropHelper
    procedure IdxLayoutDragAndDropHelper.BeginDragAndDrop = BeginDragAndDrop;
    function IdxLayoutDragAndDropHelper.CanDragAndDrop = CanDragAndDrop;
    procedure IdxLayoutDragAndDropHelper.FinishDragAndDrop = FinishDragAndDrop;
    //IdxLayoutContainer
    function GetContainer: TdxLayoutContainer;
    //IdxLayoutControl
    function CanGetHitTest(const P: TPoint): Boolean;
    function CanProcessKeyboard: Boolean;
    function CanUpdate: Boolean;
    function CreateCustomizationControlHelper(AItem: TdxLayoutItem): TdxControlsDesignSelectorHelper;
    procedure CustomizationChanged;
    function GetCanvas: TcxCanvas;
    function IdxLayoutControl.GetClientBounds = GetContainerClientBounds;
    function IdxLayoutControl.GetClientRect = GetContainerClientRect;
    function GetContainerClientBounds: TRect;
    function GetContainerClientRect: TRect;
    function GetIsFocusControlOnItemCaptionClick: Boolean;
    function GetIsSizableHorz: Boolean;
    function GetIsSizableVert: Boolean;
    function GetScrollOffset: TPoint;
    function GetShowLockedGroupChildren: Boolean;
    function GetSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass;
    procedure MakeVisible(AItem: TdxCustomLayoutItem);
    procedure PostPlaceControls;
    procedure SizeAdjustment;
    procedure IdxLayoutControl.PostInvalidateSelectionLayer = PostInvalidateSelectionLayer;
    function IdxLayoutControl.GetLayoutLookAndFeel = GetLayoutLookAndFeel;
    function GetItemsOwner: TComponent;
    function GetItemsParent: TcxControl;
    function GetItemsParentComponent: TComponent;

    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
  {$IFNDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    function GetCursor(X, Y: Integer): TCursor; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    function DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetParentBackground(Value: Boolean); override;
    procedure WriteState(Writer: TWriter); override;
    procedure WndProc(var Message: TMessage); override;

    // Conditions
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function CanFocusOnClick(X, Y: Integer): Boolean; override;
    function HasBackground: Boolean; override;
    function IsInternalControl(AControl: TControl): Boolean; override;
    function NeedRedrawOnResize: Boolean; override;

    // Notifications
    procedure BoundsChanged; override;
    procedure FontChanged; override;

    // Mouse
    procedure DblClick; override;
    function GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseLeave(AControl: TControl); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    // Scrollbars
    procedure InitScrollBarsParameters; override;
    function NeedsToBringInternalControlsToFront: Boolean; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode; var AScrollPos: Integer); override;

    // Drag and Drop
    function AllowAutoDragAndDropAtDesignTime(X, Y: Integer; Shift: TShiftState): Boolean; override;
    function AllowDragAndDropWithoutFocus: Boolean; override;
    function CanDrag(X, Y: Integer): Boolean; override;
    function CanDragAndDrop: Boolean;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; override;
    function StartDragAndDrop(const P: TPoint): Boolean; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;

    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
    function GetCxLookAndFeel: TcxLookAndFeel;
    function GetPainterClass: TdxLayoutControlPainterClass; virtual;
    function GetViewInfoClass: TdxLayoutControlViewInfoClass; virtual;

    function CanMultiSelect: Boolean; virtual;
    function CanShowSelection: Boolean; virtual;
    procedure CustomizeFormPostUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
    procedure DoCustomization; virtual;
    procedure DoGetItemStoredProperties(AItem: TdxCustomLayoutItem; AProperties: TStrings); virtual;
    procedure DoGetItemStoredPropertyValue(AItem: TdxCustomLayoutItem;
      const AName: string; var AValue: Variant); virtual;
    procedure DoSetItemStoredPropertyValue(AItem: TdxCustomLayoutItem;
      const AName: string; const AValue: Variant); virtual;
    procedure DoGetStoredProperties(AProperties: TStrings); virtual;
    procedure DoGetStoredPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure DoSetStoredPropertyValue(const AName: string; const AValue: Variant); virtual;
    function GetAlignmentConstraintClass: TdxLayoutAlignmentConstraintClass; virtual;
    function GetContainerClass: TdxLayoutControlContainerClass; virtual;
    function GetDesignSelectorRect: TRect;
    function IsToolSelected: Boolean;
    function IsUpdateLocked: Boolean;
    procedure LayoutChanged(ANeedPack: Boolean = True); virtual;

    // scroll
    procedure ScrollContent(APrevPos, ACurPos: Integer; AHorzScrolling: Boolean);
    procedure CheckLeftPos(var Value: Integer);
    procedure CheckPositions;
    procedure CheckTopPos(var Value: Integer);

    // selections
    procedure PostBuildSelectionLayer; virtual;
    procedure PostInvalidateSelectionLayer(const R: TRect); virtual;

    // storing
    function OldLoadFromIniFile(const AFileName: string): Boolean;
    function OldLoadFromRegistry(const ARegistryPath: string): Boolean;
    function OldLoadFromStream(AStream: TStream): Boolean;
    function StoringSupports: Boolean;

    // IdxLayoutItemsHelper
    procedure AddAvailableItem(AItem: TdxCustomLayoutItem);
    procedure ExtractAvailableItem(AItem: TdxCustomLayoutItem);
    function GetRoot: TdxLayoutGroup;
    procedure SetRootGroup(Value: TdxLayoutGroup);

    // IcxEditorFieldLink
    function CreateFieldControls(X, Y: Integer; ADataSource: TDataSource; AFieldList: TList): Boolean;
    procedure DoCreateFieldControl(AControl: TControl; AField: TField);
    function NeedCreateCaption: Boolean;

    // undo
    procedure CancelLastUndo;
    procedure SaveToUndo;

    procedure CreateBoldFont;
    procedure CreateContainer;
    procedure CreateOptions;
    procedure DestroyBoldFont;
    procedure DestroyContainer;
    procedure DestroyOptions;

    property BoldFont: TFont read FBoldFont;
    property cxLookAndFeel: TcxLookAndFeel read GetCxLookAndFeel;
    property IsLayoutLoading: Boolean read GetIsLayoutLoading;
    property MenuItems: TdxLayoutCustomizeFormMenuItems read GetMenuItems write SetMenuItems;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginDragAndDrop; override;
    procedure GetTabOrderList(List: TList); override;
  {$IFDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}

    procedure Clear;
    function CreateAlignmentConstraint: TdxLayoutAlignmentConstraint;
    function FindItem(AControl: TControl): TdxLayoutItem; overload;
    function FindItem(AControlHandle: THandle): TdxLayoutItem; overload;
    function FindItem(const AName: string): TdxCustomLayoutItem; overload;
    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; overload;
    function GetHitTest(X, Y: Integer): TdxCustomLayoutHitTest; overload;

    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate(ANeedPack: Boolean = True);

    function CreateGroup(AGroupClass: TdxLayoutGroupClass = nil; AParent: TdxLayoutGroup = nil): TdxLayoutGroup;
    function CreateItem(AItemClass: TdxCustomLayoutItemClass = nil; AParent: TdxLayoutGroup = nil): TdxCustomLayoutItem;
    function CreateItemForControl(AControl: TControl; AParent: TdxLayoutGroup = nil): TdxLayoutItem;

    // Storing
    function CanRestore: Boolean;
    procedure Restore;
    procedure Store;

    procedure LoadFromIniFile(const AFileName: string);
    procedure LoadFromRegistry(const ARegistryPath: string);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToIniFile(const AFileName: string; ARecreate: Boolean = True);
    procedure SaveToRegistry(const ARegistryPath: string; ARecreate: Boolean = True);
    procedure SaveToStream(AStream: TStream);

    property AutoSize;

    property AutoContentSizes: TdxLayoutAutoContentSizes read GetAutoContentSizes write SetAutoContentSizes;
    property Container: TdxLayoutControlContainer read FContainer;
    property LayoutDirection: TdxLayoutDirection read GetLayoutDirection write SetLayoutDirection;
    property LeftPos: Integer read FLeftPos write SetLeftPos;
    property TopPos: Integer read FTopPos write SetTopPos;

    property LookAndFeel: TdxCustomLayoutLookAndFeel read FLayoutLookAndFeel write SetLayoutLookAndFeel;
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read FLayoutLookAndFeel write SetLayoutLookAndFeel;

    property RedrawOnResize: Boolean read FRedrawOnResize write FRedrawOnResize;

    // Customization properties
    property Customization: Boolean read GetCustomization write SetCustomization;
    property CustomizeAvailableItemsViewKind: TdxLayoutAvailableItemsViewKind read GetCustomizeAvailableItemsViewKind
      write SetCustomizeAvailableItemsViewKind;
    property CustomizeForm: TdxLayoutControlCustomCustomizeForm read GetCustomizeForm;
    property CustomizeFormBounds: TRect read GetCustomizeFormBounds write SetCustomizeFormBounds;
    property CustomizeFormClass: TdxLayoutControlCustomCustomizeFormClass read GetCustomizeFormClass write SetCustomizeFormClass;
    property CustomizeFormTabbedView: Boolean read GetCustomizeFormTabbedView write SetCustomizeFormTabbedView;
    property ShowDesignSelectors: Boolean read GetShowDesignSelectors write SetShowDesignSelectors;
    property HighlightRoot: Boolean read GetHighlightRoot write SetHighlightRoot;

    property ContentBounds: TRect read GetContentBounds;
    property OccupiedClientWidth: Integer read GetOccupiedClientWidth;
    property OccupiedClientHeight: Integer read GetOccupiedClientHeight;

    // Options
    property OptionsImage: TdxLayoutImageOptions read GetOptionsImage write SetOptionsImage;

    // Item properies
    property OptionsItem: TdxLayoutItemOptions read FOptionsItem write SetOptionsItem;
    property AutoControlAlignment: Boolean read GetAutoControlAlignment write SetAutoControlAlignment default True;
    property AutoControlTabOrders: Boolean read GetAutoControlTabOrders write SetAutoControlTabOrders default True;
    property AbsoluteItemCount: Integer read GetAbsoluteItemCount;
    property AbsoluteItems[Index: Integer]: TdxCustomLayoutItem read GetAbsoluteItem;
    property AvailableItemCount: Integer read GetAvailableItemCount;
    property AvailableItems[Index: Integer]: TdxCustomLayoutItem read GetAvailableItem;
    property AlignmentConstraintCount: Integer read GetAlignmentConstraintCount;
    property AlignmentConstraints[Index: Integer]: TdxLayoutAlignmentConstraint read GetAlignmentConstraint;
    property Items: TdxLayoutGroup read GetItems;

    // Storing properties
    property OptionsStoring: TdxStoringOptions read FOptionsStoring write SetOptionsStoring;
    property IniFileName: string read GetIniFileName write SetIniFileName;
    property RegistryPath: string read GetRegistryPath write SetRegistryPath;
    property StoreInIniFile: Boolean read GetStoreInIniFile write SetStoreInIniFile;
    property StoreInRegistry: Boolean read GetStoreInRegistry write SetStoreInRegistry;

    // Undo
    property UndoRedoManager: TdxUndoRedoManager read GetUndoRedoManager;

    property Painter: TdxLayoutControlPainter read FPainter;
    property ViewInfo: TdxLayoutControlViewInfo read FViewInfo;

    property OnCustomization: TNotifyEvent read FOnCustomization write FOnCustomization;
    property OnGetItemStoredProperties: TdxLayoutControlGetItemStoredPropertiesEvent
      read FOnGetItemStoredProperties write FOnGetItemStoredProperties;
    property OnGetItemStoredPropertyValue: TdxLayoutControlGetItemStoredPropertyValueEvent
      read FOnGetItemStoredPropertyValue write FOnGetItemStoredPropertyValue;
    property OnSetItemStoredPropertyValue: TdxLayoutControlSetItemStoredPropertyValueEvent
      read FOnSetItemStoredPropertyValue write FOnSetItemStoredPropertyValue;
    property OnGetStoredProperties: TdxLayoutControlGetStoredPropertiesEvent
      read FOnGetStoredProperties write FOnGetStoredProperties;
    property OnGetStoredPropertyValue: TdxLayoutControlGetStoredPropertyValueEvent
      read FOnGetStoredPropertyValue write FOnGetStoredPropertyValue;
    property OnSetStoredPropertyValue: TdxLayoutControlSetStoredPropertyValueEvent
      read FOnSetStoredPropertyValue write FOnSetStoredPropertyValue;
  end;

  TdxLayoutControl = class(TdxCustomLayoutControl)
  published
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusOnClick;
    property Font;
    property MenuItems default dxDefaultLayoutCustomizeFormMenuItems;
    property ParentBackground default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;  // obsolete
    property Visible;

    property AutoContentSizes stored False; // obsolete
    property AutoControlAlignment stored False; // obsolete
    property AutoControlTabOrders stored False; // obsolete
    property AutoSize;

    property LookAndFeel stored False; // obsolete
    property LayoutLookAndFeel;

    property RedrawOnResize default True;
    
    // Customization properties
    property CustomizeFormTabbedView default False;
    property ShowDesignSelectors default True;
    property HighlightRoot default True;

    // Options
    property OptionsImage;
    property OptionsItem;

    // Storing properties
    property OptionsStoring;
    property IniFileName stored False; // obsolete
    property RegistryPath stored False; // obsolete
    property StoreInIniFile stored False; // obsolete
    property StoreInRegistry stored False; // obsolete

    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;

    property OnCustomization;
    property OnGetItemStoredProperties;
    property OnGetItemStoredPropertyValue;
    property OnSetItemStoredPropertyValue;
    property OnGetStoredProperties;
    property OnGetStoredPropertyValue;
    property OnSetStoredPropertyValue;
  end;

  { hit tests }

  TdxLayoutCustomizeFormAvailableItemsHitTest = class(TdxLayoutCustomizeFormHitTest)
  public
    function HitTestCode: Integer; override;
  end;

  TdxLayoutCustomizeFormTreeViewItemsHitTest = class(TdxLayoutCustomizeFormHitTest)
  public
    function HitTestCode: Integer; override;
  end;

  { TdxLayoutControlPainter }

  TdxLayoutControlPainter = class(TdxCustomLayoutControlHandler)
  protected
    function GetInternalCanvas: TcxCanvas; virtual;
    procedure MakeCanvasClipped(ACanvas: TcxCanvas);

    procedure DrawBackground(ACanvas: TcxCanvas); virtual;
    procedure DrawDesignSelector(ACanvas: TcxCanvas); virtual;
    procedure DrawItems(ACanvas: TcxCanvas); virtual;
    procedure DrawDesignFeatures(ACanvas: TcxCanvas);

    property InternalCanvas: TcxCanvas read GetInternalCanvas;
  public
    function GetCanvas: TcxCanvas; virtual;

    procedure Paint; virtual;
  end;

  { TdxLayoutControlViewInfo }
  
  TdxLayoutControlViewInfo = class(TdxCustomLayoutControlHandler)
  private
    FCanvas: TcxCanvas;

    function GetClientHeight: Integer;
    function GetClientWidth: Integer;
    function GetContainerViewInfo: TdxLayoutControlContainerViewInfo;
    function GetContentHeight: Integer;
    function GetContentWidth: Integer;
    function GetItemsViewInfo: TdxLayoutGroupViewInfo;
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
  protected
    procedure CreateViewInfos; virtual;
    procedure DestroyViewInfos; virtual;
    procedure RecreateViewInfos;

    procedure AlignItems; virtual;
    procedure AutoAlignControls; virtual;
    procedure CalculateItemsViewInfo; virtual;
    function GetIsTransparent: Boolean; virtual;
    function HasBackground: Boolean;
    procedure InvalidateRect(const R: TRect; EraseBackground: Boolean);
    function IsCustomization: Boolean;
    procedure PrepareData; virtual;

    function GetCanvas: TcxCanvas; virtual;
    function GetClientBounds: TRect; virtual;
    function GetContentBounds: TRect; virtual;

    property Canvas: TcxCanvas read GetCanvas;
    property ContainerViewInfo: TdxLayoutControlContainerViewInfo read GetContainerViewInfo;
    property IsTransparent: Boolean read GetIsTransparent;
  public
    constructor Create(AControl: TdxCustomLayoutControl); override;
    destructor Destroy; override;
    procedure Calculate; virtual;
    function GetItemWithMouse(const P: TPoint): TdxCustomLayoutItem;

    property ClientBounds: TRect read GetClientBounds;
    property ClientHeight: Integer read GetClientHeight;
    property ClientWidth: Integer read GetClientWidth;
    property ContentBounds: TRect read GetContentBounds;
    property ContentHeight: Integer read GetContentHeight;
    property ContentWidth: Integer read GetContentWidth;
    property ItemsViewInfo: TdxLayoutGroupViewInfo read GetItemsViewInfo;
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read GetLayoutLookAndFeel;
  end;

var
  dxLayoutDesignTimeSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass;

implementation

{$R *.res}

uses
  Types, TypInfo, Registry, Math, Variants,
  UxTheme, Themes,
  cxContainer, dxOffice11, cxButtons, dxLayoutControlAdapters, dxLayoutCustomizeForm,
  dxLayoutStrs, dxLayoutDragAndDrop, dxHooks;

type
  TControlAccess = class(TControl);
  TdxLayoutItemAccess = class(TdxLayoutItem);
  TdxLayoutGroupAccess = class(TdxLayoutGroup);
  TdxCustomLayoutItemViewInfoAccess = class(TdxCustomLayoutItemViewInfo);
  TdxLayoutItemViewInfoAccess = class(TdxLayoutItemViewInfo);
  TdxLayoutGroupViewInfoAccess = class(TdxLayoutGroupViewInfo);
  TdxCustomLayoutItemAccess = class(TdxCustomLayoutItem);
  TdxUndoRedoManagerAccess = class(TdxUndoRedoManager);

const
  ScrollStep = 10;

  dxLayoutSignature: Integer = $4C434458;

function dxGetSelectionMarker(const P: TPoint; AMarkerWidth: Integer): TRect;
begin
  Result := cxRectInflate(cxRect(P, P), (AMarkerWidth - 1) div 2, (AMarkerWidth - 1) div 2);
  Inc(Result.Bottom);
  Inc(Result.Right);
end;

function dxGetSelectionMarkers(const ABorderBounds: TRect; AMarkerWidth: Integer): TRects;
var
  AMiddleX, AMiddleY: Integer;
begin
  SetLength(Result, 8);
  with ABorderBounds do
  begin
    AMiddleX := (Left + Right - 1) div 2;
    AMiddleY := (Top + Bottom - 1) div 2;
    Result[0] := dxGetSelectionMarker(TopLeft, AMarkerWidth);
    Result[1] := dxGetSelectionMarker(Point(AMiddleX, Top), AMarkerWidth);
    Result[2] := dxGetSelectionMarker(Point(Right - 1, Top), AMarkerWidth);
    Result[3] := dxGetSelectionMarker(Point(Right - 1, AMiddleY), AMarkerWidth);
    Result[4] := dxGetSelectionMarker(Point(Right - 1, Bottom - 1), AMarkerWidth);
    Result[5] := dxGetSelectionMarker(Point(AMiddleX, Bottom - 1), AMarkerWidth);
    Result[6] := dxGetSelectionMarker(Point(Left, Bottom - 1), AMarkerWidth);
    Result[7] := dxGetSelectionMarker(Point(Left, AMiddleY), AMarkerWidth);
  end;
end;

procedure dxDrawSelectionMarkers(ACanvas: TcxCanvas; AMarkers: TRects;
  ABorderColor, ABorderMarkerInnerColor: TColor);

  procedure DrawSelectionBorderMarker(const R: TRect);
  begin
    ACanvas.Brush.Color := ABorderMarkerInnerColor;
    ACanvas.Pen.Color := ABorderColor;
    ACanvas.Canvas.Rectangle(R);
    ACanvas.ExcludeClipRect(R);
  end;

var
  I: Integer;
begin
  for I := Low(AMarkers) to High(AMarkers) do
    DrawSelectionBorderMarker(AMarkers[I]);
end;

type

  { TdxCustomizationControlHelper }

  TdxCustomizationControlHelper = class(TdxControlsDesignSelectorHelper)
  private
    FLayoutControl: TdxCustomLayoutControl;
    FLayoutItem: TdxLayoutItem;
    procedure SetLayoutControl(AValue: TdxCustomLayoutControl);
    procedure SetLayoutItem(AValue: TdxLayoutItem);
  protected
    function DoControlWndProc(var Message: TMessage): Boolean; override;
    function GetChildClass: TdxControlsDesignSelectorHelperClass; override;

    function IsActiveDesignSelector: Boolean; override;
    function IsHitTestTransparent(const P: TPoint): Boolean; override;
    function IsSelected: Boolean; override;
    function IsValid: Boolean; override;

    function CanDrawDesignSelector: Boolean; override;

    function IsCustomization: Boolean;
    function IsDesigning: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
    property LayoutControl: TdxCustomLayoutControl read FLayoutControl write SetLayoutControl;
    property LayoutItem: TdxLayoutItem read FLayoutItem write SetLayoutItem;
  end;

  { TdxDesignCustomizationHelper }

  TdxDesignCustomizationHelper = class
  private
    FLayoutControls: TcxComponentList;
    function GetCount: Integer;
    function GetItem(AIndex: Integer): TdxCustomLayoutControl;
  protected
    function FindActiveDesigner(out ADesigner: IdxLayoutDesignerHelper): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    class procedure AddLayout(ALayout: TdxCustomLayoutControl);
    class procedure RemoveLayout(ALayout: TdxCustomLayoutControl);

    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TdxCustomLayoutControl read GetItem;
  end;

  { TdxLayoutControlAdapterDefs }

  PControlAdapterRecord = ^TControlAdapterRecord;
  TControlAdapterRecord = record
    ControlClass: TControlClass;
    AdapterClass: TdxCustomLayoutControlAdapterClass;
  end;

  TdxLayoutControlAdapterDefs = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TControlAdapterRecord;
    procedure ClearItems;
  protected
    procedure Delete(AIndex: Integer);
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TControlAdapterRecord read GetItem;
  public
    constructor Create;
    destructor Destroy; override;
    function GetAdapterClass(AControl: TControl): TdxCustomLayoutControlAdapterClass;
    procedure Register(AControlClass: TControlClass;
      AAdapterClass: TdxCustomLayoutControlAdapterClass);
    procedure Unregister(AControlClass: TControlClass;
      AAdapterClass: TdxCustomLayoutControlAdapterClass);
  end;

var
  FdxLayoutControlAdapterDefs: TdxLayoutControlAdapterDefs;
  FDesignCustomizationHelper: TdxDesignCustomizationHelper;

function dxDesignCustomizationHelper: TdxDesignCustomizationHelper;
begin
  if FDesignCustomizationHelper = nil then
    FDesignCustomizationHelper := TdxDesignCustomizationHelper.Create;
  Result := FDesignCustomizationHelper;
end;

{ TdxCustomizationControlHelper }

procedure TdxCustomizationControlHelper.Assign(Source: TPersistent);
var
  AItem: TdxCustomizationControlHelper;
begin
  if Source is TdxCustomizationControlHelper then
  begin
    AItem := Source as TdxCustomizationControlHelper;
    FLayoutItem := AItem.LayoutItem;
    FLayoutControl := AItem.LayoutControl;
  end;
  inherited Assign(Source);
end;

function TdxCustomizationControlHelper.DoControlWndProc(var Message: TMessage): Boolean;
begin
  case Message.Msg of
    WM_PAINT, WM_ERASEBKGND, WM_NCPAINT, CM_TEXTCHANGED:
      if IsValid and ((Control = nil) or not (csPaintCopy in Control.ControlState)) then
        LayoutControl.PostInvalidateSelectionLayer(LayoutItem.ViewInfo.ControlViewInfo.Bounds);
  end;
  Result := inherited DoControlWndProc(Message);
end;

function TdxCustomizationControlHelper.GetChildClass: TdxControlsDesignSelectorHelperClass;
begin
  Result := TdxCustomizationControlHelper;
end;

function TdxCustomizationControlHelper.IsActiveDesignSelector: Boolean;
begin
  Result := inherited IsActiveDesignSelector and TdxLayoutItemAccess(LayoutItem).IsDesignSelectorVisible;
end;

function TdxCustomizationControlHelper.IsHitTestTransparent(const P: TPoint): Boolean;
begin
  if LayoutControl.Customization then
    Result := True
  else
    Result := inherited IsHitTestTransparent(P);
end;

function TdxCustomizationControlHelper.IsSelected: Boolean;
begin
  Result := (not LayoutControl.Customization and LayoutItem.ViewInfo.Selected) or
    (LayoutControl.Customization and LayoutControl.Container.IsComponentSelected(LayoutItem.Control));
end;

function TdxCustomizationControlHelper.IsCustomization: Boolean;
begin
  Result := LayoutControl.Customization;
end;

function TdxCustomizationControlHelper.IsDesigning: Boolean;
begin
  Result := TdxLayoutItemAccess(LayoutItem).IsDesigning;
end;

function TdxCustomizationControlHelper.IsValid: Boolean;
begin
  Result := inherited IsValid and (LayoutItem <> nil) and (LayoutControl <> nil) and (LayoutItem.ViewInfo <> nil);
end;

function TdxCustomizationControlHelper.CanDrawDesignSelector: Boolean;
begin
  Result := inherited CanDrawDesignSelector and LayoutItem.ActuallyVisible;
end;

procedure TdxCustomizationControlHelper.SetLayoutControl(AValue: TdxCustomLayoutControl);
begin
  if FLayoutControl <> AValue then
  begin
    FLayoutControl := AValue;
    CheckChildren;
  end;
end;

procedure TdxCustomizationControlHelper.SetLayoutItem(AValue: TdxLayoutItem);
begin
  if AValue <> FLayoutItem then
  begin
    FLayoutItem := AValue;
    CheckChildren;
  end;
end;

{ TdxDesignCustomizationHelper }

function IsParentFocused(AParent: THandle): Boolean;
begin
  Result := (AParent <> 0) and ((AParent = GetFocus) or IsChildClassWindow(AParent) and IsParentFocused(GetParent(AParent)));
end;

function ProcessKeyboardMessage(AKey: WPARAM; AFlags: LPARAM): Boolean;

  function SelectItemParent(AComponent: TComponent): Boolean;
  var
    AIntf: IdxLayoutSelectableItem;
  begin
    Result := Supports(AComponent, IdxLayoutSelectableItem, AIntf);
    if Result then
      AIntf.SelectParent;
  end;

  function KeyPressed: Boolean;
  begin
    Result := (AFlags shr 31) and 1 = 0;
  end;

var
  AList: TcxComponentList;
  ADesigner: IdxLayoutDesignerHelper;
begin
  Result := KeyPressed;
  if Result then
  begin
    AList := TcxComponentList.Create;
    try
      if dxDesignCustomizationHelper.FindActiveDesigner(ADesigner) and ADesigner.CanProcessKeyboard then
        ADesigner.GetSelection(AList);
      Result := (AList.Count > 0);
      if Result then
        case AKey of
          VK_DELETE:
            begin
              ADesigner.DeleteSelection;
              Result := False;
            end;
          VK_ESCAPE:
            Result := SelectItemParent(AList[0]);
        else
          Result := False;
        end;
    finally
      AList.Free;
    end;
  end;
end;

procedure dxLayoutKeyboardHook(ACode, WParam, LParam: Integer; var AHookResult: Integer);
begin
  if (ACode = HC_ACTION) and ProcessKeyboardMessage(wParam, lParam) then
    AHookResult := 1
end;


function ProcessMouseMessage(AMessage: WPARAM; AMessageData: TMouseHookStruct): Boolean;
var
  I: Integer;
  ALayout: TdxCustomLayoutControl;
  P: TPoint;
  AControl: TWinControl;
begin
  Result := False;
  for I := 0 to dxDesignCustomizationHelper.Count - 1 do
  begin
    ALayout := dxDesignCustomizationHelper.Items[I];
    if not ALayout.IsDesigning and (ALayout.Parent.Handle = AMessageData.hwnd) and (GetCapture = 0) and
      PtInRect(ALayout.BoundsRect, ALayout.Parent.ScreenToClient(AMessageData.pt)) then
    begin
      Result := True;
      P := ALayout.ScreenToClient(AMessageData.pt);
      if ALayout.HScrollBarVisible and PtInRect(ALayout.HScrollBar.BoundsRect, P) then
        AControl := ALayout.HScrollBar
      else
        if ALayout.VScrollBarVisible and PtInRect(ALayout.VScrollBar.BoundsRect, P) then
          AControl := ALayout.VScrollBar
        else
        begin
          AControl := ALayout;
          with ALayout.ScreenToClient(AMessageData.pt) do
            SetCursor(Screen.Cursors[ALayout.GetCursor(X, Y)]);
        end;
      P := AControl.ScreenToClient(AMessageData.pt);
      AControl.Perform(AMessage, GetMouseKeys, LPARAM(PointToSmallPoint(P)));
      Break;
    end;
  end;
end;

{
function MouseHookProc(Code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if (Code = HC_ACTION) and ProcessMouseMessage(wParam, PMouseHookStruct(lParam)^) then
  begin
    CallNextHookEx(FMouseHookHandle, Code, wParam, lParam);
    Result := 1;
  end
  else
    Result := CallNextHookEx(FMouseHookHandle, Code, wParam, lParam);
end;
}

constructor TdxDesignCustomizationHelper.Create;
begin
  inherited;
  FLayoutControls := TcxComponentList.Create(False);
  dxSetHook(htKeyboard, dxLayoutKeyboardHook);
  //SetHook(FMouseHookHandle, WH_MOUSE, MouseHookProc);
end;

destructor TdxDesignCustomizationHelper.Destroy;
begin
  //ReleaseHook(FMouseHookHandle);
  dxReleaseHook(dxLayoutKeyboardHook);
  FreeAndNil(FLayoutControls);
  inherited;
end;

class procedure TdxDesignCustomizationHelper.AddLayout(ALayout: TdxCustomLayoutControl);
begin
  if dxDesignCustomizationHelper.FLayoutControls.IndexOf(ALayout) = -1 then
    dxDesignCustomizationHelper.FLayoutControls.Add(ALayout);
end;

class procedure TdxDesignCustomizationHelper.RemoveLayout(ALayout: TdxCustomLayoutControl);
begin
  dxDesignCustomizationHelper.FLayoutControls.Extract(ALayout);
end;

function TdxDesignCustomizationHelper.FindActiveDesigner(out ADesigner: IdxLayoutDesignerHelper): Boolean;
var
  I: Integer;
  ALayout: TdxCustomLayoutControl;
begin
  Result := False;
  for I := 0 to FLayoutControls.Count - 1 do
  begin
    ALayout := FLayoutControls[I] as TdxCustomLayoutControl;
    Result := Supports(ALayout.Container, IdxLayoutDesignerHelper, ADesigner) and ADesigner.IsActive and ALayout.HandleAllocated and
      ((ALayout.Handle = GetFocus) or ((ALayout.Parent <> nil) and ALayout.Parent.HandleAllocated and IsParentFocused(ALayout.Parent.Handle)));
    if Result then
      Break;
  end;
end;

function TdxDesignCustomizationHelper.GetCount: Integer;
begin
  Result := FLayoutControls.Count;
end;

function TdxDesignCustomizationHelper.GetItem(AIndex: Integer): TdxCustomLayoutControl;
begin
  Result := FLayoutControls[AIndex] as TdxCustomLayoutControl;
end;

{ TdxLayoutControlAdapterDefs }

constructor TdxLayoutControlAdapterDefs.Create;
begin
  inherited;
  FItems := TList.Create;
end;

destructor TdxLayoutControlAdapterDefs.Destroy;
begin
  ClearItems;
  FItems.Free;
  inherited;
end;

function TdxLayoutControlAdapterDefs.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxLayoutControlAdapterDefs.GetItem(Index: Integer): TControlAdapterRecord;
begin
  Result := PControlAdapterRecord(FItems[Index])^;
end;

procedure TdxLayoutControlAdapterDefs.ClearItems;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Delete(I);
end;

procedure TdxLayoutControlAdapterDefs.Delete(AIndex: Integer);
begin
  Dispose(PControlAdapterRecord(FItems[AIndex]));
  FItems.Delete(AIndex);
end;

function TdxLayoutControlAdapterDefs.GetAdapterClass(AControl: TControl): TdxCustomLayoutControlAdapterClass;
var
  I: Integer;
  AControlAdapterRecord: TControlAdapterRecord;
begin
  for I := Count - 1 downto 0 do
  begin
    AControlAdapterRecord := Items[I];
    if AControl.InheritsFrom(AControlAdapterRecord.ControlClass) then
    begin
      Result := AControlAdapterRecord.AdapterClass;
      Exit;
    end;
  end;
  Result := TdxCustomLayoutControlAdapter;
end;

procedure TdxLayoutControlAdapterDefs.Register(AControlClass: TControlClass;
  AAdapterClass: TdxCustomLayoutControlAdapterClass);
var
  AControlAdapterRecord: PControlAdapterRecord;
begin
  New(AControlAdapterRecord);
  with AControlAdapterRecord^ do
  begin
    ControlClass := AControlClass;
    AdapterClass := AAdapterClass;
  end;
  FItems.Add(AControlAdapterRecord);
end;

procedure TdxLayoutControlAdapterDefs.Unregister(AControlClass: TControlClass;
  AAdapterClass: TdxCustomLayoutControlAdapterClass);
var
  I: Integer;
  AControlAdapterRecord: TControlAdapterRecord;
begin
  for I := 0 to Count - 1 do
  begin
    AControlAdapterRecord := Items[I];
    with AControlAdapterRecord do
      if (ControlClass = AControlClass) and (AdapterClass = AAdapterClass) then
      begin
        Delete(I);
        Break;
      end;
  end;
  if Count = 0 then
    FreeAndNil(FdxLayoutControlAdapterDefs);
end;

{ TdxLayoutControlPersistent }

constructor TdxLayoutControlPersistent.Create(AControl: TdxCustomLayoutControl);
begin
  inherited Create;
  FControl := AControl;
end;

procedure TdxLayoutControlPersistent.Changed;
begin
end;

function TdxLayoutControlPersistent.GetOwner: TPersistent;
begin
  Result := FControl;
end;

{ TdxLayoutControlContainer }

constructor TdxLayoutControlContainer.Create(AControl: TdxCustomLayoutControl);
begin
  inherited Create(AControl);
  FControl := AControl;
end;

function TdxLayoutControlContainer.GetPainterClass: TdxLayoutContainerPainterClass;
begin
  Result := TdxLayoutControlContainerPainter;
end;

function TdxLayoutControlContainer.GetStoredProperties(
  AProperties: TStrings): Boolean;
begin
  Result := inherited GetStoredProperties(AProperties);
  Control.DoGetStoredProperties(AProperties);
end;

procedure TdxLayoutControlContainer.GetStoredPropertyValue(const AName: string;
  var AValue: Variant);
begin
  inherited GetStoredPropertyValue(AName, AValue);
  Control.DoGetStoredPropertyValue(AName, AValue);
end;

function TdxLayoutControlContainer.GetViewInfoClass: TdxLayoutContainerViewInfoClass;
begin
  Result := TdxLayoutControlContainerViewInfo;
end;

procedure TdxLayoutControlContainer.GetItemStoredCustomProperties(
  AItem: TdxCustomLayoutItem; AProperties: TStrings);
begin
  Control.DoGetItemStoredProperties(AItem, AProperties);
end;

procedure TdxLayoutControlContainer.GetItemStoredCustomPropertyValue(
  AItem: TdxCustomLayoutItem; const AName: string; var AValue: Variant);
begin
  Control.DoGetItemStoredPropertyValue(AItem, AName, AValue);
end;

procedure TdxLayoutControlContainer.SetItemStoredCustomPropertyValue(
  AItem: TdxCustomLayoutItem; const AName: string; const AValue: Variant);
begin
  Control.DoSetItemStoredPropertyValue(AItem, AName, AValue);
end;

procedure TdxLayoutControlContainer.SetStoredPropertyValue(const AName: string;
  const AValue: Variant);
begin
  inherited SetStoredPropertyValue(AName, AValue);
  Control.DoSetStoredPropertyValue(AName, AValue);
end;

function TdxLayoutControlContainer.GetPainter: TdxLayoutControlContainerPainter;
begin
  Result := TdxLayoutControlContainerPainter(inherited Painter);
end;

function TdxLayoutControlContainer.GetViewInfo: TdxLayoutControlContainerViewInfo;
begin
  Result := TdxLayoutControlContainerViewInfo(inherited ViewInfo);
end;

{ TdxStoringOptions }

procedure TdxStoringOptions.Assign(Source: TPersistent);
var
  ASourceOptions: TdxStoringOptions;
begin
  if Source is TdxStoringOptions then
  begin
    ASourceOptions := TdxStoringOptions(Source);
    IniFileName := ASourceOptions.IniFileName;
    RegistryPath := ASourceOptions.RegistryPath;
    StoreToIniFile := ASourceOptions.StoreToIniFile;
    StoreToRegistry := ASourceOptions.StoreToRegistry;
  end
  else
    inherited;
end;

function TdxStoringOptions.CanStoreToIniFile: Boolean;
begin
  Result := StoreToIniFile and (IniFileName <> '');
end;

function TdxStoringOptions.CanStoreToRegistry: Boolean;
begin
  Result := StoreToRegistry and (RegistryPath <> '');
end;

function TdxStoringOptions.CanRestoreFromIniFile: Boolean;
begin
  Result := CanStoreToIniFile and FileExists(IniFileName);
end;

function TdxStoringOptions.CanRestoreFromRegistry: Boolean;
var
  ARegistry: TRegistry;
begin
  Result := CanStoreToRegistry;
  if Result then
  begin
    ARegistry := TRegistry.Create(KEY_ALL_ACCESS);
    try
      Result := ARegistry.OpenKey(RegistryPath, False);
      ARegistry.CloseKey;
    finally
      ARegistry.Free;
    end;
  end;
end;

{ TdxLayoutItemOptions }

constructor TdxLayoutItemOptions.Create(AControl: TdxCustomLayoutControl);
begin
  inherited;
  FAutoControlAreaAlignment := True;
  FAutoControlTabOrders := True;
  FShowLockedGroupChildren := True;
end;

procedure TdxLayoutItemOptions.Assign(Source: TPersistent);
begin
  if Source is TdxLayoutItemOptions then
  begin
    Control.BeginUpdate;
    try
      AutoControlAreaAlignment := TdxLayoutItemOptions(Source).AutoControlAreaAlignment;
      AutoControlTabOrders := TdxLayoutItemOptions(Source).AutoControlTabOrders;
      FocusControlOnItemCaptionClick := TdxLayoutItemOptions(Source).FocusControlOnItemCaptionClick;
      SizableHorz := TdxLayoutItemOptions(Source).SizableHorz;
      SizableVert := TdxLayoutItemOptions(Source).SizableVert;
      ShowLockedGroupChildren := TdxLayoutItemOptions(Source).ShowLockedGroupChildren;
    finally
      Control.CancelUpdate;
      Changed;
    end;
  end
  else
    inherited;
end;

procedure TdxLayoutItemOptions.Changed;
begin
  Control.LayoutChanged;
end;

procedure TdxLayoutItemOptions.SetAutoControlAreaAlignment(Value: Boolean);
begin
  if FAutoControlAreaAlignment <> Value then
  begin
    FAutoControlAreaAlignment := Value;
    Changed;
  end;
end;

procedure TdxLayoutItemOptions.SetAutoControlTabOrders(Value: Boolean);
begin
  if FAutoControlTabOrders <> Value then
  begin
    FAutoControlTabOrders := Value;
    Changed;
  end;
end;

procedure TdxLayoutItemOptions.SetShowLockedGroupChildren(Value: Boolean);
begin
  if FShowLockedGroupChildren <> Value then
  begin
    FShowLockedGroupChildren := Value;
    Control.CustomizeFormPostUpdate([cfutAvailableItems, cfutVisibleItems]);
  end;
end;

{ TdxCustomLayoutControl }

constructor TdxCustomLayoutControl.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls, csOpaque];
  ParentBackground := False;
  RedrawOnResize := True;
  Width := 300;
  Height := 250;

  CreateOptions;
  FStoredStream := TMemoryStream.Create;
  CreateBoldFont;

  GetLayoutLookAndFeel.AddUser(Self);
  InitializeSubControlsCxLookAndFeel;

  CreateContainer;
  CreateHandlers;

  if IsDesigning then
    dxDesignCustomizationHelper.AddLayout(Self);
end;

destructor TdxCustomLayoutControl.Destroy;
begin
  dxDesignCustomizationHelper.RemoveLayout(Self);
  Customization := False;
  if not IsDesigning then
    Store;
  DestroyHandlers;
  DestroyContainer;
  LayoutLookAndFeel := nil;
  GetLayoutLookAndFeel.RemoveUser(Self);
  DestroyBoldFont;
  FreeAndNil(FStoredStream);
  DestroyOptions;
  inherited Destroy;
end;

procedure TdxCustomLayoutControl.BeginDragAndDrop;
begin
  DragAndDropState := ddsInProcess;
  inherited BeginDragAndDrop;
end;

procedure TdxCustomLayoutControl.GetTabOrderList(List: TList);
begin
  if (List.Count > 0) and (List.Last = Self) then
    List.Extract(List.Last);
  Container.GetTabOrderList(List);
end;

function TdxCustomLayoutControl.GetAutoControlAlignment: Boolean;
begin
  Result := OptionsItem.AutoControlAreaAlignment;
end;

function TdxCustomLayoutControl.GetAutoControlTabOrders: Boolean;
begin
  Result := OptionsItem.AutoControlTabOrders;
end;

function TdxCustomLayoutControl.GetAbsoluteItem(Index: Integer): TdxCustomLayoutItem;
begin
  Result := FContainer.AbsoluteItems[Index];
end;

function TdxCustomLayoutControl.GetAbsoluteItemCount: Integer;
begin
  Result := FContainer.AbsoluteItemCount;
end;

function TdxCustomLayoutControl.GetAlignmentConstraint(Index: Integer): TdxLayoutAlignmentConstraint;
begin
  Result := FContainer.AlignmentConstraints[Index];
end;

function TdxCustomLayoutControl.GetAlignmentConstraintCount: Integer;
begin
  Result := FContainer.AlignmentConstraintCount;
end;

function TdxCustomLayoutControl.GetAvailableItem(Index: Integer): TdxCustomLayoutItem;
begin
  Result := FContainer.AvailableItems[Index];
end;

function TdxCustomLayoutControl.GetAvailableItemCount: Integer;
begin
  Result := FContainer.AvailableItemCount;
end;

function TdxCustomLayoutControl.GetContentBounds: TRect;
begin
  Result := ViewInfo.ContentBounds;
end;

function TdxCustomLayoutControl.GetCustomization: Boolean;
begin
  Result := Container.Customization;
end;

function TdxCustomLayoutControl.GetCustomizeAvailableItemsViewKind: TdxLayoutAvailableItemsViewKind;
begin
  Result := Container.CustomizeAvailableItemsViewKind;
end;

function TdxCustomLayoutControl.GetCustomizeForm: TdxLayoutControlCustomCustomizeForm;
begin
  Result := Container.CustomizeForm;
end;

function TdxCustomLayoutControl.GetCustomizeFormBounds: TRect;
begin
  Result := Container.CustomizeFormBounds;
end;

function TdxCustomLayoutControl.GetCustomizeFormClass: TdxLayoutControlCustomCustomizeFormClass;
begin
  Result := Container.CustomizeFormClass;
end;

function TdxCustomLayoutControl.GetCustomizeFormTabbedView: Boolean;
begin
  Result := Container.CustomizeFormTabbedView;
end;

function TdxCustomLayoutControl.GetHighlightRoot: Boolean;
begin
  Result := Container.HighlightRoot;
end;

function TdxCustomLayoutControl.GetIsLayoutLoading: Boolean;
begin
  Result := Container.IsLayoutLoading;
end;

function TdxCustomLayoutControl.GetItems: TdxLayoutGroup;
begin
  Result := Container.Root;
end;

function TdxCustomLayoutControl.GetOccupiedClientWidth: Integer;
begin
  Result := TdxLayoutGroupViewInfoAccess(ViewInfo.ItemsViewInfo).CalculateWidth;
end;

function TdxCustomLayoutControl.GetOptionsImage: TdxLayoutImageOptions;
begin
  if Container <> nil then 
    Result := Container.ImageOptions
  else
    Result := nil;
end;

function TdxCustomLayoutControl.GetShowDesignSelectors: Boolean;
begin
  Result := Container.ShowDesignSelectors;
end;

function TdxCustomLayoutControl.GetOccupiedClientHeight: Integer;
begin
  Result := TdxLayoutGroupViewInfoAccess(ViewInfo.ItemsViewInfo).CalculateHeight;
end;

function TdxCustomLayoutControl.GetLayoutDirection: TdxLayoutDirection;
begin
  Result := Items.LayoutDirection;
end;

function TdxCustomLayoutControl.GetMenuItems: TdxLayoutCustomizeFormMenuItems;
begin
  Result := Container.MenuItems;
end;

function TdxCustomLayoutControl.GetAutoContentSizes: TdxLayoutAutoContentSizes;
begin
  Result := TdxLayoutAutoContentSizes(Items.AutoAligns);
end;

function TdxCustomLayoutControl.GetUndoRedoManager: TdxUndoRedoManager;
begin
  Result := Container.UndoRedoManager;
end;

procedure TdxCustomLayoutControl.SetAutoContentSizes(Value: TdxLayoutAutoContentSizes);
begin
  Items.AutoAligns := TdxLayoutAutoAligns(Value);
end;

procedure TdxCustomLayoutControl.SetAutoControlAlignment(Value: Boolean);
begin
  OptionsItem.AutoControlAreaAlignment := Value;
end;

procedure TdxCustomLayoutControl.SetAutoControlTabOrders(Value: Boolean);
begin
  OptionsItem.AutoControlTabOrders := Value;
end;

procedure TdxCustomLayoutControl.SetCustomization(Value: Boolean);
begin
  Container.Customization := Value;
end;

procedure TdxCustomLayoutControl.SetCustomizeAvailableItemsViewKind(Value: TdxLayoutAvailableItemsViewKind);
begin
  Container.CustomizeAvailableItemsViewKind := Value;
end;

procedure TdxCustomLayoutControl.SetCustomizeFormBounds(const AValue: TRect);
begin
  Container.CustomizeFormBounds := AValue;
end;

procedure TdxCustomLayoutControl.SetCustomizeFormClass(
  AValue: TdxLayoutControlCustomCustomizeFormClass);
begin
  Container.CustomizeFormClass := AValue;
end;

procedure TdxCustomLayoutControl.SetCustomizeFormTabbedView(Value: Boolean);
begin
  Container.CustomizeFormTabbedView := Value;
end;

procedure TdxCustomLayoutControl.SetShowDesignSelectors(Value: Boolean);
begin
  Container.ShowDesignSelectors := Value;
end;

procedure TdxCustomLayoutControl.SetHighlightRoot(Value: Boolean);
begin
  Container.HighlightRoot := Value;
end;

procedure TdxCustomLayoutControl.SetOptionsImage(Value: TdxLayoutImageOptions);
begin
  Container.ImageOptions := Value;
end;

procedure TdxCustomLayoutControl.SetOptionsItem(Value: TdxLayoutItemOptions);
begin
  FOptionsItem.Assign(Value);
end;

procedure TdxCustomLayoutControl.SetLayoutDirection(Value: TdxLayoutDirection);
begin
  Items.LayoutDirection := Value;
end;

procedure TdxCustomLayoutControl.SetLeftPos(Value: Integer);
var
  APrevLeftPos: Integer;
begin
  CheckLeftPos(Value);
  if FLeftPos <> Value then
  begin
    Update;
    APrevLeftPos := FLeftPos;
    FLeftPos := Value;
    LayoutChanged(False);
    ScrollContent(APrevLeftPos, FLeftPos, True);
  end;
end;

procedure TdxCustomLayoutControl.SetMenuItems(Value: TdxLayoutCustomizeFormMenuItems);
begin
  Container.MenuItems := Value;
end;

procedure TdxCustomLayoutControl.SetLayoutLookAndFeel(Value: TdxCustomLayoutLookAndFeel);
begin
  if FLayoutLookAndFeel <> Value then
  begin
    GetLayoutLookAndFeel.RemoveUser(Self);
    FLayoutLookAndFeel := Value;
    GetLayoutLookAndFeel.AddUser(Self);
    LayoutLookAndFeelUserChanged;
  end;
end;

procedure TdxCustomLayoutControl.SetTopPos(Value: Integer);
var
  APrevTopPos: Integer;
begin
  CheckTopPos(Value);
  if FTopPos <> Value then
  begin
    Update;
    APrevTopPos := FTopPos;
    FTopPos := Value;
    LayoutChanged(False);
    ScrollContent(APrevTopPos, FTopPos, False);
  end;
end;


function TdxCustomLayoutControl.GetIniFileName: string;
begin
  Result := OptionsStoring.IniFileName;
end;

function TdxCustomLayoutControl.GetRegistryPath: string;
begin
  Result := OptionsStoring.RegistryPath;
end;

function TdxCustomLayoutControl.GetStoreInIniFile: Boolean;
begin
  Result := OptionsStoring.StoreToIniFile;
end;

function TdxCustomLayoutControl.GetStoreInRegistry: Boolean;
begin
  Result := OptionsStoring.StoreToRegistry;
end;

procedure TdxCustomLayoutControl.SetIniFileName(const Value: string);
begin
  OptionsStoring.IniFileName := Value;
end;

procedure TdxCustomLayoutControl.SetRegistryPath(const Value: string);
begin
  OptionsStoring.RegistryPath := Value;
end;

procedure TdxCustomLayoutControl.SetStoreInIniFile(const Value: Boolean);
begin
  OptionsStoring.StoreToIniFile := Value;
end;

procedure TdxCustomLayoutControl.SetStoreInRegistry(const Value: Boolean);
begin
  OptionsStoring.StoreToRegistry := Value;
end;

procedure TdxCustomLayoutControl.SetOptionsStoring(Value: TdxStoringOptions);
begin
  FOptionsStoring.Assign(Value);
end;

procedure TdxCustomLayoutControl.CreateHandlers;
begin
  FPainter := GetPainterClass.Create(Self);
  FViewInfo := GetViewInfoClass.Create(Self);
end;

procedure TdxCustomLayoutControl.DestroyHandlers;
begin
  FreeAndNil(FViewInfo);
  FreeAndNil(FPainter);
end;

procedure TdxCustomLayoutControl.RefreshBoldFont;
begin
  FBoldFont.Assign(Font);
  with FBoldFont do
    Style := Style + [fsBold];
  dxLayoutTextMetrics.Unregister(FBoldFont);
end;

procedure TdxCustomLayoutControl.ContainerChangedHandler(Sender: TObject);
begin
  CheckPositions;
  Invalidate;
  PostBuildSelectionLayer;
end;

procedure TdxCustomLayoutControl.ContainerSelectionChangedHandler(Sender: TObject);
begin
  if IsDesigning then
    InvalidateRect(GetDesignSelectorRect, True);
end;

procedure TdxCustomLayoutControl.InitializeSubControlsCxLookAndFeel;
begin
  GetLayoutLookAndFeel.InitializeSubControlCxLookAndFeel(HScrollBar.LookAndFeel);
  GetLayoutLookAndFeel.InitializeSubControlCxLookAndFeel(VScrollBar.LookAndFeel);
  GetLayoutLookAndFeel.InitializeSubControlCxLookAndFeel(SizeGrip.LookAndFeel);
end;

procedure TdxCustomLayoutControl.WMContextMenu(var Message: TWMContextMenu);
begin
  FIsPopupShown := True;
  try
    inherited;
  finally
    FIsPopupShown := False;
  end;
end;

procedure TdxCustomLayoutControl.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS;
end;

procedure TdxCustomLayoutControl.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if not IsDestroying then
    Container.KillFocus;
end;

procedure TdxCustomLayoutControl.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  inherited;
  if Customization and not IsDesigning and (DragAndDropState = ddsNone) then
  begin
    P := ScreenToClient(GetMouseCursorPos);
    SetCursor(Screen.Cursors[GetCursor(P.X, P.Y)]);
  end;
end;

procedure TdxCustomLayoutControl.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if not IsDestroying then
    Container.SetFocus;
end;

procedure TdxCustomLayoutControl.CMChildKey(var Message: TCMChildKey);
begin                               
  if not Container.IsCustomization and Container.IsChildKey(Message.CharCode) and
      Container.FocusedController.SetNextFocusControl(Message.Sender) then
    Message.Result := 1
  else
    inherited;
end;

procedure TdxCustomLayoutControl.CMControlChange(var Message: TCMControlChange);
var
  AControl: TControl;
  P: TPoint;
  AGroup: TdxLayoutGroup;
  AIndex: Integer;
begin
  inherited;
  AControl := Message.Control;
  if not (IsLoading or IsDestroying) and Message.Inserting and not IsInternalControl(AControl) and
    not (csAncestor in AControl.ComponentState) and (FindItem(AControl) = nil) then
  begin
    P := AControl.BoundsRect.TopLeft;
    AGroup := GetHitTest(P).GetGroupForInsert;
    if AGroup = nil then
      AGroup := Items;
    AIndex := AGroup.ViewInfo.GetInsertionPos(P);
    AGroup.CreateItemForControl(AControl).VisibleIndex := AIndex;
  end;
end;

procedure TdxCustomLayoutControl.CMControlListChange(var Message: TCMControlListChange);
var
  AControl: TControl;
  AItem: TdxLayoutItem;
begin
  inherited;
  if Container <> nil {IsDestroying} then
  begin
    AControl := Message.Control;
    if not IsInternalControl(AControl) and not Message.Inserting then
    begin
      AItem := FindItem(AControl);
      if (AItem <> nil) and not TdxLayoutItemAccess(AItem).ControlLocked then
        AItem.Free;
    end;
  end;
end;

procedure TdxCustomLayoutControl.CMDialogChar(var Message: TCMDialogChar);
begin
  if TdxCustomLayoutItemAccess(Items).ProcessDialogChar(Message.CharCode) then
    Message.Result := 1
  else
    inherited;
end;

procedure TdxCustomLayoutControl.CMDialogKey(var Message: TCMDialogKey);

  function FindFocusedItem: TdxLayoutItem;
  var
    AWnd: THandle;
  begin
    AWnd := GetFocus;
    repeat
      Result := FindItem(AWnd);
      AWnd := GetAncestor(AWnd, GA_PARENT);
    until (Result <> nil) or (AWnd = 0);
  end;

var
  AFocusedItem: TdxLayoutItem;
begin
  AFocusedItem := FindFocusedItem;
  if (AFocusedItem <> nil) and TdxCustomLayoutItemAccess(Items).ProcessDialogKey(Message.CharCode, Message.KeyData, AFocusedItem) then
    Message.Result := 1
  else
    inherited;
end;

procedure TdxCustomLayoutControl.CMHintShow(var Message: TCMHintShow);
var
  P: TPoint;
begin
  P := ScreenToClient(GetMouseCursorPos);
  if not Container.IsCustomization and Container.ShowHint(Message.HintInfo^, P.X, P.Y) then
    Message.Result := 0
  else
    inherited;
end;

procedure TdxCustomLayoutControl.CMTabStopChanged(var Message: TMessage);
begin
  inherited;
  TabStop := True;
end;

procedure TdxCustomLayoutControl.DXMPlaceControls(var Message: TMessage);
begin
  Container.Painter.PlaceControls(ViewInfo.ItemsViewInfo);
end;

procedure TdxCustomLayoutControl.DXMBuildSelectionLayer(var Message: TMessage);
begin
  Container.BuildSelectionLayer;
end;

procedure TdxCustomLayoutControl.DXMInvalidateSelectionLayer(var Message: TMessage);
var
  R: TRect;
begin
  with Message do
    R := Rect(WParamLo, WParamHi, LParamLo, LParamHi);
  Container.InvalidateSelectionLayer(R);
end;

procedure TdxCustomLayoutControl.DXMCustomizeFormUpdate(var Message: TMessage);
var
  AMSG: TMsg;
  AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes;
begin
  AUpdateTypes := TdxLayoutCustomizeFormUpdateTypes(Byte(Message.WParam));
  while PeekMessage(AMsg, Handle, DXM_REFRESHCUSTOMIZATION, DXM_REFRESHCUSTOMIZATION, PM_REMOVE) do
    AUpdateTypes := AUpdateTypes + TdxLayoutCustomizeFormUpdateTypes(Byte(AMsg.wParam));
  Container.CustomizeFormUpdate(AUpdateTypes);
end;

function TdxCustomLayoutControl.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  if IsDesigning then
    Result := False
  else
  begin
    Result := True;
    if (ViewInfo.ItemsViewInfo.AlignHorz <> ahClient) and (Align in [alNone, alLeft, alRight]) then
      NewWidth := cxRectWidth(ContentBounds);
    if (ViewInfo.ItemsViewInfo.AlignVert <> avClient) and (Align in [alNone, alTop, alBottom]) then
      NewHeight := cxRectHeight(ContentBounds);
  end;
end;

procedure TdxCustomLayoutControl.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  if not Customization then
    inherited
end;

procedure TdxCustomLayoutControl.AlignControls(AControl: TControl; var Rect: TRect);
begin
end;

function TdxCustomLayoutControl.AllowAutoDragAndDropAtDesignTime(X, Y: Integer;
  Shift: TShiftState): Boolean;
begin
  Result := not GetDesignHitTest(X, Y, Shift);
end;

function TdxCustomLayoutControl.AllowDragAndDropWithoutFocus: Boolean;
begin
  Result := Customization;
end;

procedure TdxCustomLayoutControl.BoundsChanged;
begin
  if IsDestroying then
    Exit;
  BeginUpdate;
  try
    inherited;
  finally
    EndUpdate(False);
  end;
end;

function TdxCustomLayoutControl.CanDrag(X, Y: Integer): Boolean;
begin
  Result := inherited CanDrag(X, Y) and not IsDesigning;
end;

function TdxCustomLayoutControl.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := not IsDesigning and (FocusOnClick or Customization) and
    MayFocus and CanFocus and Container.CanFocusOnClick(X, Y);
end;

procedure TdxCustomLayoutControl.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TdxCustomLayoutControl.DblClick;
begin
  inherited;
  if IsDesigning then
    Customization := True;
end;

procedure TdxCustomLayoutControl.FontChanged;
begin
  inherited;
  dxLayoutTextMetrics.Unregister(Font);
  RefreshBoldFont;
  LayoutLookAndFeelUserChanged;
end;

procedure TdxCustomLayoutControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  inherited GetChildren(Proc, Root);
  if Owner = Root then
    FContainer.StoreChildren(Proc);
end;

function TdxCustomLayoutControl.GetCursor(X, Y: Integer): TCursor;
var
  AHitTest: TdxCustomLayoutHitTest;
begin
  Result := crDefault;
  if DragAndDropState = ddsNone then
  begin
    AHitTest := GetHitTest(X, Y);
    Result := AHitTest.GetCursor;
    if (Result = crDefault) and (AHitTest.Item <> nil) then
      Result := TdxCustomLayoutItemAccess(AHitTest.Item).GetCursor(X, Y);
    if Result = crDefault then
      Result := inherited GetCursor(X, Y);
  end;
end;

procedure TdxCustomLayoutControl.DoEnter;
begin
  inherited;
  if not IsDestroying then
    Container.DoEnter;
end;

procedure TdxCustomLayoutControl.DoExit;
begin
  if not IsDestroying then
    Container.DoExit;
  inherited DoExit;
end;

function TdxCustomLayoutControl.DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean;
var
  APopupMenu: TPopupMenu;
begin
  if Customization then
  begin
    APopupMenu := Container.CustomizeForm.LayoutPopupMenu;
    Result := (APopupMenu <> nil) and ShowPopupMenu(Self, APopupMenu, X, Y);
  end
  else
    Result := inherited DoShowPopupMenu(AMenu, X, Y);
end;

procedure TdxCustomLayoutControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Container.KeyDown(Key, Shift);
end;

type
  TGrabHandleInfo = record
    P: TPoint;
    Contains: Boolean;
  end;
  PGrabHandleInfo = ^TGrabHandleInfo;

function CheckMarker(Window: HWND; Data: PGrabHandleInfo): BOOL; stdcall;
var
  R: TRect;
begin
  if cxGetClassName(Window) = 'TGrabHandle' then
  begin
    GetWindowRect(Window, R);
    Data.Contains := cxRectPtIn(R, Data.P);
    Result := not Data.Contains;
  end
  else
    Result := True;
end;

function TdxCustomLayoutControl.GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean;
var
  AHitTest: TdxCustomLayoutHitTest;
  AInfo: TGrabHandleInfo;
begin
  Result := inherited GetDesignHitTest(X, Y, Shift);
  if not Result then
  begin
    AHitTest := GetHitTest(X, Y);
    Result := not (ssRight in Shift) and not FRightButtonPressed and
      (AHitTest is TdxCustomLayoutItemHitTest) and not IsToolSelected;
    if Result then
    begin
      AInfo.P := GetMouseCursorPos;
      AInfo.Contains := False;
      EnumChildWindows(Handle, @CheckMarker, Integer(@AInfo));
      Result := not AInfo.Contains;
    end;
  end;
  FRightButtonPressed := ssRight in Shift;
end;

function TdxCustomLayoutControl.HasBackground: Boolean;
begin
  Result := ThemeServices.ThemesEnabled and ParentBackground;
end;

function TdxCustomLayoutControl.IsInternalControl(AControl: TControl): Boolean;
begin
  Result := inherited IsInternalControl(AControl) or (AControl is TdxSelectionLayer);
end;

function TdxCustomLayoutControl.NeedRedrawOnResize: Boolean;
begin
  Result := RedrawOnResize and ViewInfo.LayoutLookAndFeel.NeedRedrawOnResize;
end;

procedure TdxCustomLayoutControl.Loaded;
begin
  inherited;
  Container.CheckIndexes;
  if not IsDesigning then
    Restore;
  LayoutChanged(False);
  LayoutLookAndFeelUserChanged;
end;

procedure TdxCustomLayoutControl.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  AForm: TCustomForm;
begin
  inherited;
  if not IsDesigning and Customization then
  begin
    AForm := GetParentForm(Self);
    if AForm <> nil then
      AForm.SetFocus;
  end;
  Container.MouseDown(Button, Shift, X, Y);
end;

procedure TdxCustomLayoutControl.MouseLeave(AControl: TControl);
begin
  inherited;
  Container.MouseLeave(AControl);
end;

procedure TdxCustomLayoutControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  Container.MouseMove(Shift, X, Y);
  inherited MouseMove(Shift, X, Y);
end;

procedure TdxCustomLayoutControl.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Container.MouseUp(Button, Shift, X, Y);
end;

procedure TdxCustomLayoutControl.Paint;
begin
  if not IsUpdateLocked then
  begin
    inherited;
    Painter.Paint;
  end;
end;

procedure TdxCustomLayoutControl.SetName(const Value: TComponentName);
var
  AOldName: string;
begin
  AOldName := Name;
  inherited;
  Container.CheckItemNames(AOldName, Name);
end;

procedure TdxCustomLayoutControl.SetParentBackground(Value: Boolean);
begin
  if Value then
    ControlStyle := ControlStyle - [csOpaque]
  else
    ControlStyle := ControlStyle + [csOpaque];
  inherited;
end;

procedure TdxCustomLayoutControl.WriteState(Writer: TWriter);
begin
  if HandleAllocated then
    SendMessage(Handle, WM_SETREDRAW, 0, 0);
  try
    TdxCustomLayoutItemAccess(Items).RestoreItemControlSize;
    inherited;
  finally
    if HandleAllocated then
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
    LayoutChanged;
  end;
end;

procedure TdxCustomLayoutControl.WndProc(var Message: TMessage);

  function PtInDesignSelectorRect(const P: TPoint): Boolean;
  var
    AControl: TControl;
    AHitTest: TdxCustomLayoutHitTest;
  begin
    Result := False;
    AControl := ControlAtPos(P, True);
    if (AControl <> nil) and not (AControl is TWinControl) then
    begin
      AHitTest := GetHitTest(P);
      Result := (AHitTest <> nil) and
        (AHitTest is TdxLayoutItemHitTest) and
        TdxLayoutItemViewInfoAccess((AHitTest as TdxLayoutItemHitTest).Item.ViewInfo).PtInDesignSelectorRect(P);
    end;
  end;

begin
  case Message.Msg of
    WM_LBUTTONDOWN:
      if (IsDesigning or Customization) and HandleAllocated and (GetCapture <> Handle) and
          (Customization or PtInDesignSelectorRect(SmallPointToPoint(TWMMouse(Message).Pos))) then
        SetCaptureControl(Self);
  end;
  inherited WndProc(Message);
end;

procedure TdxCustomLayoutControl.InitScrollBarsParameters;
begin
  inherited;
  SetScrollBarInfo(sbHorizontal, 0, ViewInfo.ContentWidth - 1,
    ScrollStep, ViewInfo.ClientWidth, LeftPos, True, True);
  SetScrollBarInfo(sbVertical, 0, ViewInfo.ContentHeight - 1,
    ScrollStep, ViewInfo.ClientHeight, TopPos, True, True);
end;

function TdxCustomLayoutControl.NeedsToBringInternalControlsToFront: Boolean;
begin
  Result := True;
end;

procedure TdxCustomLayoutControl.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);

  function GetContentPos: Integer;
  begin
    if AScrollBarKind = sbHorizontal then
      Result := LeftPos
    else
      Result := TopPos;
  end;

  procedure SetContentPos(Value: Integer);
  begin
    if AScrollBarKind = sbHorizontal then
      LeftPos := Value
    else
      TopPos := Value;
  end;

  function GetPageScrollStep: Integer;
  begin
    if AScrollBarKind = sbHorizontal then
      Result := ClientWidth
    else
      Result := ClientHeight;
  end;

begin
  inherited;
  case AScrollCode of
    scLineUp:
      SetContentPos(GetContentPos - ScrollStep);
    scLineDown:
      SetContentPos(GetContentPos + ScrollStep);
    scPageUp:
      SetContentPos(GetContentPos - GetPageScrollStep);
    scPageDown:
      SetContentPos(GetContentPos + GetPageScrollStep);
    scTrack:
      SetContentPos(AScrollPos);
  end;
  AScrollPos := GetContentPos;
end;

function TdxCustomLayoutControl.CanDragAndDrop: Boolean;
begin
  Result := not IsDesigning or not (csInline in Owner.ComponentState);
end;

function TdxCustomLayoutControl.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  if FDragDropHitTest <> nil then
    Result := FDragDropHitTest.GetDragAndDropObjectClass
  else
    Result := TdxLayoutDragAndDropObject;
end;

function TdxCustomLayoutControl.StartDragAndDrop(const P: TPoint): Boolean;
var
  AItem: TdxCustomLayoutItem;
  AHitTest: TdxCustomLayoutHitTest;
begin
  Result := False;
  AHitTest := GetHitTest(P);
  AItem := AHitTest.GetSourceItem;
  if CanDragAndDrop and AHitTest.CanDragAndDrop and (AItem <> nil) and TdxCustomLayoutItemAccess(AItem).CanDragAndDrop then
  begin
    FDragDropHitTest := AHitTest;
    (DragAndDropObject as TdxLayoutCustomDragAndDropObject).Init(dsControl, AItem, P);
    Result := True;
  end;
end;

procedure TdxCustomLayoutControl.EndDragAndDrop(Accepted: Boolean);
begin
  FDragDropHitTest := nil;
  inherited;
end;

function TdxCustomLayoutControl.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := FLayoutLookAndFeel;
  if Result = nil then
    Result := dxLayoutDefaultLookAndFeel;
end;

function TdxCustomLayoutControl.GetCxLookAndFeel: TcxLookAndFeel;
begin
  Result := inherited LookAndFeel;
end;

procedure TdxCustomLayoutControl.BeginLayoutLookAndFeelUserDestroying;
begin
  BeginUpdate;
end;

procedure TdxCustomLayoutControl.EndLayoutLookAndFeelUserDestroying;
begin
  EndUpdate;
end;

procedure TdxCustomLayoutControl.LayoutLookAndFeelUserChanged;
begin
  if IsDestroying then
    Exit;
  if (LayoutLookAndFeel <> nil) and not DoubleBuffered then
    DoubleBuffered := LayoutLookAndFeel.NeedDoubleBuffered;
  InitializeSubControlsCxLookAndFeel;
  if (Items <> nil) and (GetLayoutLookAndFeel <> nil) then
    TdxCustomLayoutItemAccess(Items).LayoutLookAndFeelUserChanged;
  InvalidateControl(Self, True, True);
  CustomizeFormPostUpdate([cfutView]);
end;

procedure TdxCustomLayoutControl.LayoutLookAndFeelUserDestroyed;
begin
  LayoutLookAndFeel := nil;
end;

procedure TdxCustomLayoutControl.SelectionChanged;
begin
  TdxCustomLayoutItemAccess(Items).SelectionChanged;
end;

function TdxCustomLayoutControl.CanProcessChildren: Boolean;
begin
  Result := True;
end;

function TdxCustomLayoutControl.GetPainterClass: TdxLayoutControlPainterClass;
begin
  Result := TdxLayoutControlPainter;
end;

function TdxCustomLayoutControl.GetViewInfoClass: TdxLayoutControlViewInfoClass;
begin
  Result := TdxLayoutControlViewInfo;
end;

function TdxCustomLayoutControl.CanMultiSelect: Boolean;
begin
  Result := True;
end;

function TdxCustomLayoutControl.CanShowSelection: Boolean;
begin
  Result := True;
end;

procedure TdxCustomLayoutControl.PostBuildSelectionLayer;
begin
  if HandleAllocated then
    PostMessage(Handle, DXM_LAYOUT_BUILDSELECTIONLAYER, 0, 0);
end;

procedure TdxCustomLayoutControl.PostInvalidateSelectionLayer(const R: TRect);
begin
  if HandleAllocated then
    with R do
      PostMessage(Handle, DXM_LAYOUT_INVALIDATESELECTIONLAYER, MakeWParam(Left, Top), MakeLParam(Right, Bottom));
end;

procedure TdxCustomLayoutControl.CheckLeftPos(var Value: Integer);
begin
  Value := Max(Min(Value, ViewInfo.ContentWidth - ViewInfo.ClientWidth), 0);
end;

procedure TdxCustomLayoutControl.CheckPositions;
begin
  LeftPos := LeftPos;
  TopPos := TopPos;
end;

procedure TdxCustomLayoutControl.CheckTopPos(var Value: Integer);
begin
  Value := Max(Min(Value, ViewInfo.ContentHeight - ViewInfo.ClientHeight), 0);
end;

procedure TdxCustomLayoutControl.CustomizeFormPostUpdate(AUpdateTypes: TdxLayoutCustomizeFormUpdateTypes);
begin
  if HandleAllocated then
    PostMessage(Handle, DXM_REFRESHCUSTOMIZATION, Byte(AUpdateTypes), 0);
end;

procedure TdxCustomLayoutControl.DoCustomization;
begin
  PostBuildSelectionLayer;
  CallNotify(FOnCustomization, Self);
end;

procedure TdxCustomLayoutControl.DoGetItemStoredProperties(
  AItem: TdxCustomLayoutItem; AProperties: TStrings);
begin
  if Assigned(FOnGetItemStoredProperties) then
    FOnGetItemStoredProperties(Self, AItem, AProperties);
end;

procedure TdxCustomLayoutControl.DoGetItemStoredPropertyValue(
  AItem: TdxCustomLayoutItem; const AName: string; var AValue: Variant);
begin
  if Assigned(FOnGetItemStoredPropertyValue) then
    FOnGetItemStoredPropertyValue(Self, AItem, AName, AValue);
end;

procedure TdxCustomLayoutControl.DoSetItemStoredPropertyValue(
  AItem: TdxCustomLayoutItem; const AName: string; const AValue: Variant);
begin
  if Assigned(FOnSetItemStoredPropertyValue) then
    FOnSetItemStoredPropertyValue(Self, AItem, AName, AValue);
end;

procedure TdxCustomLayoutControl.DoGetStoredProperties(AProperties: TStrings);
begin
  if Assigned(FOnGetStoredProperties) then
    FOnGetStoredProperties(Self, AProperties);
end;

procedure TdxCustomLayoutControl.DoGetStoredPropertyValue(const AName: string; var AValue: Variant);
begin
  if Assigned(FOnGetStoredPropertyValue) then
    FOnGetStoredPropertyValue(Self, AName, AValue);
end;

procedure TdxCustomLayoutControl.DoSetStoredPropertyValue(const AName: string; const AValue: Variant);
begin
  if Assigned(FOnSetStoredPropertyValue) then
    FOnSetStoredPropertyValue(Self, AName, AValue);
end;

function TdxCustomLayoutControl.GetAlignmentConstraintClass: TdxLayoutAlignmentConstraintClass;
begin
  Result := TdxLayoutAlignmentConstraint;
end;

function TdxCustomLayoutControl.GetContainerClass: TdxLayoutControlContainerClass;
begin
  Result := TdxLayoutControlContainer;
end;

function TdxCustomLayoutControl.GetDesignSelectorRect: TRect;
const
  Offset = 3;
  Width = 16;
begin
  with ClientBounds do
    Result := Rect(Right - Width - Offset, Bottom - Width - Offset, Right - Offset, Bottom - Offset);
end;

function TdxCustomLayoutControl.IsToolSelected: Boolean;
begin
  Result := IsDesigning and (dxLayoutDesignTimeHelper <> nil) and
    dxLayoutDesignTimeHelper.IsToolSelected;
end;

function TdxCustomLayoutControl.IsUpdateLocked: Boolean;
begin
  Result := Container.IsUpdateLocked;
end;

procedure TdxCustomLayoutControl.LayoutChanged(ANeedPack: Boolean = True);
begin
  Container.LayoutChanged(ANeedPack);
end;

procedure TdxCustomLayoutControl.ScrollContent(APrevPos, ACurPos: Integer;
  AHorzScrolling: Boolean);
var
  ADelta: Integer;
  AScrollBounds: TRect;
begin
  if not HandleAllocated then Exit;
  ADelta := -(ACurPos - APrevPos);
  AScrollBounds := ViewInfo.ClientBounds;
  //ValidateRect(Handle, @AScrollBounds);
  ScrollWindowEx(Handle, Ord(AHorzScrolling) * ADelta, Ord(not AHorzScrolling) * ADelta,
    @AScrollBounds, nil, 0, nil, SW_INVALIDATE or SW_ERASE{ or SW_SCROLLCHILDREN bug in WinAPI});
  UpdateWindow(Handle);
end;

function TdxCustomLayoutControl.StoringSupports: Boolean;
begin
  Result := True;
end;

function TdxCustomLayoutControl.OldLoadFromIniFile(const AFileName: string): Boolean;
var
  AIniFile: TMemIniFile;
begin
  AIniFile := TMemIniFile.Create(AFileName);
  try
    Result := Container.LoadPreviousVersions(AIniFile);
  finally
    AIniFile.Free;
  end;
end;

function TdxCustomLayoutControl.OldLoadFromRegistry(const ARegistryPath: string): Boolean;
var
  AIniFile: TRegistryIniFile;
begin
  AIniFile := TRegistryIniFile.Create(ARegistryPath);
  try
    Result := Container.LoadPreviousVersions(AIniFile);
  finally
    AIniFile.Free;
  end;
end;

function TdxCustomLayoutControl.OldLoadFromStream(AStream: TStream): Boolean;

  function GetBufferSize: Integer;
  var
    APosition: Integer;
    ASignature: Integer;
    AVersion: Word;
  begin
    APosition := AStream.Position;
    AStream.Read(Result, SizeOf(Result));
    AStream.Read(ASignature, SizeOf(ASignature));
    AStream.Read(AVersion, SizeOf(AVersion));
    if ASignature <> dxLayoutSignature then
    begin
      Result := -1;
      AStream.Position := APosition;
    end;
  end;

var
  AIniFile: TMemIniFile;
  AStrings: TStringList;
  ABufferSize: Integer;
  AMemoryStream: TMemoryStream;
begin
  AIniFile := TMemIniFile.Create('');
  AStrings := TStringList.Create;
  try
    ABufferSize := GetBufferSize;
    if ABufferSize > -1 then
    begin
      AMemoryStream := TMemoryStream.Create;
      try
        AMemoryStream.CopyFrom(AStream, ABufferSize);
        AMemoryStream.Position := 0;
        AStrings.LoadFromStream(AMemoryStream);
      finally
        AMemoryStream.Free;
      end;
    end
    else
      AStrings.LoadFromStream(AStream);

    AIniFile.SetStrings(AStrings);
    Result := Container.LoadPreviousVersions(AIniFile);
  finally
    AStrings.Free;
    AIniFile.Free;
  end;
end;

function TdxCustomLayoutControl.GetBoldFont: TFont;
begin
  Result := BoldFont;
end;

function TdxCustomLayoutControl.GetDefaultFont: TFont;
begin
  Result := Font;
end;

procedure TdxCustomLayoutControl.AddAvailableItem(AItem: TdxCustomLayoutItem);
begin
  Container.AddAvailableItem(AItem);
end;

procedure TdxCustomLayoutControl.ExtractAvailableItem(AItem: TdxCustomLayoutItem);
begin
  Container.ExtractAvailableItem(AItem);
end;

function TdxCustomLayoutControl.GetRoot: TdxLayoutGroup;
begin
  Result := Items;
end;

procedure TdxCustomLayoutControl.SetRootGroup(Value: TdxLayoutGroup);
begin
  Container.SetRootGroup(Value);
end;

function TdxCustomLayoutControl.CreateFieldControls(X, Y: Integer; ADataSource: TDataSource; AFieldList: TList): Boolean;
begin
  Result := False;
end;

procedure TdxCustomLayoutControl.DoCreateFieldControl(AControl: TControl; AField: TField);
var
  AItem: TdxLayoutItem;
begin
  AItem := FindItem(AControl);
  if AItem <> nil then
    AItem.Caption := AField.DisplayName;
end;

function TdxCustomLayoutControl.NeedCreateCaption: Boolean;
begin
  Result := False;
end;

procedure TdxCustomLayoutControl.CancelLastUndo;
begin
  if [csLoading, csReading, csDestroying] * ComponentState = [] then
    Container.CancelLastUndo;
end;

procedure TdxCustomLayoutControl.SaveToUndo;
begin
  if [csLoading, csReading, csDestroying] * ComponentState = [] then
    Container.SaveToUndo;
end;

procedure TdxCustomLayoutControl.CreateBoldFont;
begin
  FBoldFont := TFont.Create;
  RefreshBoldFont;
end;

procedure TdxCustomLayoutControl.CreateContainer;
begin
  FContainer := GetContainerClass.Create(Self);
  FContainer.OnChanged := ContainerChangedHandler;
  FContainer.OnSelectionChanged := ContainerSelectionChangedHandler;
end;

procedure TdxCustomLayoutControl.CreateOptions;
begin
  FOptionsStoring := TdxStoringOptions.Create;
  FOptionsItem := TdxLayoutItemOptions.Create(Self);
end;

procedure TdxCustomLayoutControl.DestroyBoldFont;
begin
  dxLayoutTextMetrics.Unregister(FBoldFont);
  dxLayoutTextMetrics.Unregister(Font);
  FreeAndNil(FBoldFont);
end;

procedure TdxCustomLayoutControl.DestroyContainer;
begin
  FreeAndNil(FContainer);
end;

procedure TdxCustomLayoutControl.DestroyOptions;
begin
  FreeAndNil(FOptionsItem);
  FreeAndNil(FOptionsStoring);
end;

function TdxCustomLayoutControl.CanGetHitTest(const P: TPoint): Boolean;
begin
  Result := IsWindowVisible(Handle) and PtInRect(ClientBounds, P) and not
    (ShowDesignSelectors and PtInRect(GetDesignSelectorRect, P));
end;

function TdxCustomLayoutControl.CanProcessKeyboard: Boolean;
begin
  Result := (dxLayoutDragAndDropObject = nil) and (dxLayoutSizingDragAndDropObject = nil) and not FIsPopupShown;
end;

function TdxCustomLayoutControl.CanUpdate: Boolean;
begin
  Result := HandleAllocated;
end;

function TdxCustomLayoutControl.CreateCustomizationControlHelper(
  AItem: TdxLayoutItem): TdxControlsDesignSelectorHelper;
begin
  Result := TdxCustomizationControlHelper.Create(AItem.Control);
  TdxCustomizationControlHelper(Result).LayoutControl := Self;
  TdxCustomizationControlHelper(Result).LayoutItem := AItem;
end;

procedure TdxCustomLayoutControl.CustomizationChanged;
begin
  DoCustomization;
end;

function TdxCustomLayoutControl.GetCanvas: TcxCanvas;
begin
  Result := ViewInfo.Canvas;
end;

function TdxCustomLayoutControl.GetContainerClientBounds: TRect;
begin
  Result := ClientBounds;
end;

function TdxCustomLayoutControl.GetContainerClientRect: TRect;
begin
  Result := ClientRect;
end;

function TdxCustomLayoutControl.GetItemsParent: TcxControl;
begin
  Result := Self;
end;

function TdxCustomLayoutControl.GetItemsParentComponent: TComponent;
begin
  Result := Self;
end;

function TdxCustomLayoutControl.GetItemsOwner: TComponent;
begin
  Result := Owner;
end;

function TdxCustomLayoutControl.GetIsFocusControlOnItemCaptionClick: Boolean;
begin
  Result := OptionsItem.FocusControlOnItemCaptionClick;
end;

function TdxCustomLayoutControl.GetIsSizableHorz: Boolean;
begin
  Result := OptionsItem.SizableHorz;
end;

function TdxCustomLayoutControl.GetIsSizableVert: Boolean;
begin
  Result := OptionsItem.SizableVert;
end;

function TdxCustomLayoutControl.GetScrollOffset: TPoint;
begin
  Result := Point(LeftPos, TopPos);
end;

function TdxCustomLayoutControl.GetShowLockedGroupChildren: Boolean;
begin
  Result := OptionsItem.ShowLockedGroupChildren;
end;

function TdxCustomLayoutControl.GetSelectionHelperClass: TdxLayoutRunTimeSelectionHelperClass;
begin
  if IsDesigning then
    Result := dxLayoutDesignTimeSelectionHelperClass
  else
    Result := dxLayoutRunTimeSelectionHelperClass;
end;

procedure TdxCustomLayoutControl.MakeVisible(AItem: TdxCustomLayoutItem);
var
  R, AClientR: TRect;

  procedure MakeVisibleInOneDirection(AItemMin, AItemMax,
    AClientMin, AClientMax: Integer; AIsHorizontal: Boolean);
  var
    AOffset: Integer;

    procedure ChangeOffset(ADelta: Integer);
    begin
      Inc(AOffset, ADelta);
      Dec(AItemMin, ADelta);
      Dec(AItemMax, ADelta);
    end;

    procedure ApplyOffset;
    begin
      if AIsHorizontal then
        LeftPos := LeftPos + AOffset
      else
        TopPos := TopPos + AOffset;
    end;

  begin
    AOffset := 0;
    if AItemMin > AClientMax then
      ChangeOffset(AItemMax - AClientMax)
    else
      if AItemMax < AClientMin then
        ChangeOffset(AItemMin - AClientMin);
    ApplyOffset;
  end;

  procedure MakeActuallyVisible(AItem: TdxCustomLayoutItem);
  begin
    if AItem.Parent <> nil then
    begin
      AItem.Parent.ItemIndex := AItem.Index;
      MakeActuallyVisible(AItem.Parent);
    end;
  end;

  function CanBeActuallyVisible(AItem: TdxCustomLayoutItem): Boolean;
  begin
    Result := (AItem.Visible or IsDesigning) and (AItem.IsRoot or (AItem.Parent <> nil) and TdxLayoutGroupAccess(AItem.Parent).AllowShowChild(AItem) and CanBeActuallyVisible(AItem.Parent));
  end;

begin
  if not CanBeActuallyVisible(AItem) then Exit;
  if not AItem.ActuallyVisible then
    MakeActuallyVisible(AItem);
  R := AItem.ViewInfo.Bounds;
  AClientR := Container.ViewInfo.ClientBounds;
  MakeVisibleInOneDirection(R.Left, R.Right, AClientR.Left, AClientR.Right, True);
  MakeVisibleInOneDirection(R.Top, R.Bottom, AClientR.Top, AClientR.Bottom, False);
end;

procedure TdxCustomLayoutControl.PostPlaceControls;
begin
  if HandleAllocated then
    PostMessage(Handle, DXM_LAYOUT_PLACECONTROLS, 0, 0)
end;

procedure TdxCustomLayoutControl.SizeAdjustment;

  procedure ChainSizeAdjustments(AControl: TControl);
  begin
    if (AControl <> nil) and TControlAccess(AControl).AutoSize then
    begin
      TControlAccess(AControl).AdjustSize;
      ChainSizeAdjustments(AControl.Parent);
    end;
  end;

begin
  ChainSizeAdjustments(Self);
  UpdateScrollBars;
end;

function TdxCustomLayoutControl.GetContainer: TdxLayoutContainer;
begin
  Result := FContainer;
end;

procedure TdxCustomLayoutControl.Clear;
begin
  Container.Clear;
end;

function TdxCustomLayoutControl.CreateAlignmentConstraint: TdxLayoutAlignmentConstraint;
begin
  Result := FContainer.CreateAlignmentConstraint;
end;

function TdxCustomLayoutControl.FindItem(AControl: TControl): TdxLayoutItem;
begin
  Result := Container.FindItem(AControl);
end;

function TdxCustomLayoutControl.FindItem(AControlHandle: THandle): TdxLayoutItem;
begin
  Result := Container.FindItem(AControlHandle);
end;

function TdxCustomLayoutControl.FindItem(const AName: string): TdxCustomLayoutItem;
begin
  Result := Container.FindItem(AName);
end;

function TdxCustomLayoutControl.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;
begin
  Result := Container.GetHitTest(P);
end;

function TdxCustomLayoutControl.GetHitTest(X, Y: Integer): TdxCustomLayoutHitTest;
begin
  Result := GetHitTest(Point(X, Y));
end;

procedure TdxCustomLayoutControl.BeginUpdate;
begin
  Container.BeginUpdate;
end;

procedure TdxCustomLayoutControl.CancelUpdate;
begin
  Container.CancelUpdate;
end;

procedure TdxCustomLayoutControl.EndUpdate(ANeedPack: Boolean = True);
begin
  Container.EndUpdate(ANeedPack);
end;

function TdxCustomLayoutControl.CreateGroup(AGroupClass: TdxLayoutGroupClass = nil;
  AParent: TdxLayoutGroup = nil): TdxLayoutGroup;
begin
  Result := Container.CreateGroup(AGroupClass, AParent);
end;

function TdxCustomLayoutControl.CreateItem(AItemClass: TdxCustomLayoutItemClass = nil;
  AParent: TdxLayoutGroup = nil): TdxCustomLayoutItem;
begin
  Result := Container.CreateItem(AItemClass, AParent);
end;

function TdxCustomLayoutControl.CreateItemForControl(AControl: TControl;
  AParent: TdxLayoutGroup = nil): TdxLayoutItem;
begin
  Result := Container.CreateItemForControl(AControl, AParent);
end;

function TdxCustomLayoutControl.CanRestore: Boolean;
begin
  Result := OptionsStoring.CanRestoreFromIniFile or OptionsStoring.CanRestoreFromRegistry or (FStoredStream.Size > 0);
end;

procedure TdxCustomLayoutControl.Restore;
begin
  if not CanRestore then
    Exit;
  if OptionsStoring.CanRestoreFromRegistry then
    LoadFromRegistry(OptionsStoring.RegistryPath)
  else
    if OptionsStoring.CanRestoreFromIniFile then
      LoadFromIniFile(OptionsStoring.IniFileName)
    else
    begin
      FStoredStream.Position := 0;
      LoadFromStream(FStoredStream);
    end;
end;

procedure TdxCustomLayoutControl.Store;
begin
  if OptionsStoring.CanStoreToIniFile then
    SaveToIniFile(OptionsStoring.IniFileName);
  if OptionsStoring.CanStoreToRegistry then
    SaveToRegistry(OptionsStoring.RegistryPath);
  if not IsDestroying then
  begin
    FStoredStream.Clear;
    SaveToStream(FStoredStream);
  end;
end;

procedure TdxCustomLayoutControl.LoadFromIniFile(const AFileName: string);
begin
  if AFileName = '' then Exit;
  BeginUpdate;
  try
    if not OldLoadFromIniFile(AFileName) then
      Container.RestoreFromIniFile(AFileName);
  finally
    EndUpdate(False);
  end;
end;

procedure TdxCustomLayoutControl.LoadFromRegistry(const ARegistryPath: string);
begin
  if ARegistryPath = '' then Exit;
  BeginUpdate;
  try
    if not OldLoadFromRegistry(ARegistryPath) then
      Container.RestoreFromRegistry(ARegistryPath);
  finally
    EndUpdate;
  end;
end;

procedure TdxCustomLayoutControl.LoadFromStream(AStream: TStream);
var
  APosition: Int64;
begin
  BeginUpdate;
  try
    APosition := AStream.Position;
    if not OldLoadFromStream(AStream) then
    begin
      AStream.Position := APosition;
      Container.RestoreFromStream(AStream);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TdxCustomLayoutControl.SaveToIniFile(const AFileName: string; ARecreate: Boolean = True);
begin
  if AFileName = '' then Exit;
  Container.StoreToIniFile(AFileName, ARecreate);
end;

procedure TdxCustomLayoutControl.SaveToRegistry(const ARegistryPath: string; ARecreate: Boolean = True);
begin
  if ARegistryPath = '' then Exit;
  Container.StoreToRegistry(ARegistryPath, ARecreate);
end;

procedure TdxCustomLayoutControl.SaveToStream(AStream: TStream);
begin
  Container.StoreToStream(AStream);
end;

{ THitTests }

{ TdxLayoutCustomizeFormAvailableItemsHitTest }

function TdxLayoutCustomizeFormAvailableItemsHitTest.HitTestCode: Integer;
begin
  Result := htAvailableItems;
end;

{ TdxLayoutCustomizeFormTreeViewItemsHitTest }

function TdxLayoutCustomizeFormTreeViewItemsHitTest.HitTestCode: Integer;
begin
  Result := htTreeViewItems;
end;

{ TdxCustomLayoutControlHandler }

constructor TdxCustomLayoutControlHandler.Create(AControl: TdxCustomLayoutControl);
begin
  inherited Create;
  FControl := AControl;
end;

function TdxCustomLayoutControlHandler.GetViewInfo: TdxLayoutControlViewInfo;
begin
  Result := FControl.ViewInfo;
end;

{ TdxLayoutControlPainter }

function TdxLayoutControlPainter.GetInternalCanvas: TcxCanvas;
begin
  Result := FControl.Canvas;
end;

procedure TdxLayoutControlPainter.MakeCanvasClipped(ACanvas: TcxCanvas);
begin
  ACanvas.IntersectClipRect(ViewInfo.ClientBounds);
end;

procedure TdxLayoutControlPainter.DrawBackground(ACanvas: TcxCanvas);
begin
  if not ViewInfo.IsTransparent then
    ViewInfo.LayoutLookAndFeel.DrawLayoutControlBackground(ACanvas, ViewInfo.ClientBounds);
end;

procedure TdxLayoutControlPainter.DrawDesignSelector(ACanvas: TcxCanvas);
begin
  if Control.Container.IsDesignSelectorsVisible then
    cxDrawDesignRect(ACanvas, Control.GetDesignSelectorRect, Control.Container.IsComponentSelected(Control));
end;

procedure TdxLayoutControlPainter.DrawItems(ACanvas: TcxCanvas);
begin
  Control.Container.Painter.DrawItems(ACanvas);
end;

procedure TdxLayoutControlPainter.DrawDesignFeatures(ACanvas: TcxCanvas);
begin
  Control.Container.Painter.DrawDesignFeatures(ACanvas);
end;

function TdxLayoutControlPainter.GetCanvas: TcxCanvas;
begin
  Result := InternalCanvas;
  MakeCanvasClipped(Result);
end;

procedure TdxLayoutControlPainter.Paint;
var
  ACanvas: TcxCanvas;
begin
  ACanvas := GetCanvas;
  ACanvas.SaveState;
  try
    DrawBackground(ACanvas);
    DrawItems(ACanvas);
    DrawDesignFeatures(ACanvas);
    DrawDesignSelector(ACanvas);
  finally
    ACanvas.RestoreState;
  end;
end;

{ TdxLayoutControlViewInfo }

constructor TdxLayoutControlViewInfo.Create(AControl: TdxCustomLayoutControl);
begin
  inherited;
  CreateViewInfos;
end;

destructor TdxLayoutControlViewInfo.Destroy;
begin
  DestroyViewInfos;
  FCanvas.Free;
  inherited;
end;

function TdxLayoutControlViewInfo.GetClientHeight: Integer;
begin
  Result := cxRectHeight(ClientBounds);
end;

function TdxLayoutControlViewInfo.GetClientWidth: Integer;
begin
  Result := cxRectWidth(ClientBounds);
end;

function TdxLayoutControlViewInfo.GetContainerViewInfo: TdxLayoutControlContainerViewInfo;
begin
  Result := Control.Container.ViewInfo;
end;

function TdxLayoutControlViewInfo.GetContentHeight: Integer;
begin
  Result := cxRectHeight(ContentBounds);
end;

function TdxLayoutControlViewInfo.GetContentWidth: Integer;
begin
  Result := cxRectWidth(ContentBounds);
end;

function TdxLayoutControlViewInfo.GetItemsViewInfo: TdxLayoutGroupViewInfo;
begin
  Result := ContainerViewInfo.ItemsViewInfo;
end;

function TdxLayoutControlViewInfo.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := FControl.GetLayoutLookAndFeel;
end;

procedure TdxLayoutControlViewInfo.CreateViewInfos;
begin
end;

procedure TdxLayoutControlViewInfo.DestroyViewInfos;
begin
end;

procedure TdxLayoutControlViewInfo.RecreateViewInfos;
begin
  DestroyViewInfos;
  CreateViewInfos;
end;

procedure TdxLayoutControlViewInfo.AlignItems;
var
  I: Integer;

  procedure ProcessConstraint(AConstraint: TdxLayoutAlignmentConstraint);
  var
    AItemViewInfos: TList;

    procedure RetrieveItemViewInfos;
    var
      I: Integer;
      AViewInfo: TdxCustomLayoutItemViewInfo;
    begin
      for I := 0 to AConstraint.Count - 1 do
      begin
        AViewInfo := AConstraint.Items[I].ViewInfo;
        if AViewInfo <> nil then
          AItemViewInfos.Add(AViewInfo);
      end;
    end;

    function GetSide: TdxLayoutSide;
    begin
      if AConstraint.Kind in [ackLeft, ackRight] then
        Result := sdLeft
      else
        Result := sdTop;
    end;

    function AlignItemViewInfos: Boolean;
    var
      AMaxBorderValue, I: Integer;

      function GetBorderValue(AItemViewInfoIndex: Integer): Integer;
      begin
        with TdxCustomLayoutItemViewInfoAccess(AItemViewInfos[AItemViewInfoIndex]) do
          case AConstraint.Kind of
            ackLeft:
              Result := Bounds.Left - CalculateOffset(sdLeft);
            ackTop:
              Result := Bounds.Top - CalculateOffset(sdTop);
            ackRight:
              Result := Bounds.Right + CalculateOffset(sdRight);
            ackBottom:
              Result := Bounds.Bottom + CalculateOffset(sdBottom);
          else
            Result := 0;
          end;
      end;

      function FindMaxBorderValue: Integer;
      var
        I: Integer;
      begin
        Result := -MaxInt;
        for I := 0 to AItemViewInfos.Count - 1 do
          Result := Max(Result, GetBorderValue(I));
      end;

      procedure ChangeOffset(AItemViewInfoIndex, ADelta: Integer);
      begin
        with TdxCustomLayoutItemViewInfo(AItemViewInfos[AItemViewInfoIndex]) do
          Offsets[GetSide] := Offsets[GetSide] + ADelta;
      end;

      function AreItemViewInfosAligned: Boolean;
      var
        I, ABorderValue: Integer;
      begin
        ABorderValue := 0;
        for I := 0 to AItemViewInfos.Count - 1 do
          if I = 0 then
            ABorderValue := GetBorderValue(I)
          else
          begin
            Result := GetBorderValue(I) = ABorderValue;
            if not Result then Exit;
          end;
        Result := True;
      end;

    begin
      AMaxBorderValue := FindMaxBorderValue;
      for I := 0 to AItemViewInfos.Count - 1 do
        ChangeOffset(I, AMaxBorderValue - GetBorderValue(I));
      CalculateItemsViewInfo;
      Result := AreItemViewInfosAligned;
    end;

    procedure ResetOffsets;
    var
      I: Integer;
    begin
      for I := 0 to AItemViewInfos.Count - 1 do
        TdxCustomLayoutItemViewInfo(AItemViewInfos[I]).ResetOffset(GetSide);
      CalculateItemsViewInfo;
    end;

  begin
    AItemViewInfos := TList.Create;
    try
      RetrieveItemViewInfos;
      while not AlignItemViewInfos do  //!!! to think about invisible items if items will be deleted
      begin
        ResetOffsets;
        if AItemViewInfos.Count > 2 then
          AItemViewInfos.Count := AItemViewInfos.Count - 1
        else
          Break;
      end;
    finally
      AItemViewInfos.Free;
    end;
  end;

begin
  for I := 0 to FControl.AlignmentConstraintCount - 1 do
    ProcessConstraint(FControl.AlignmentConstraints[I]);
end;

procedure TdxLayoutControlViewInfo.AutoAlignControls;
begin
  ContainerViewInfo.AutoAlignControls;
end;

procedure TdxLayoutControlViewInfo.CalculateItemsViewInfo;
begin
  ContainerViewInfo.CalculateItemsViewInfo;
end;

function TdxLayoutControlViewInfo.GetIsTransparent: Boolean;
begin
  Result := HasBackground;
end;

function TdxLayoutControlViewInfo.HasBackground: Boolean;
begin
  Result := Control.HasBackground;
end;

procedure TdxLayoutControlViewInfo.InvalidateRect(const R: TRect; EraseBackground: Boolean);
begin
  Control.InvalidateRect(R, EraseBackground);
end;

function TdxLayoutControlViewInfo.IsCustomization: Boolean;
begin
  Result := Control.Container.IsCustomization;
end;

procedure TdxLayoutControlViewInfo.PrepareData;
begin
  RecreateViewInfos;
end;

function TdxLayoutControlViewInfo.GetCanvas: TcxCanvas;
begin
  if Control.HandleAllocated then
  begin
    FreeAndNil(FCanvas);
    Result := Control.Canvas;
  end
  else
  begin
    if FCanvas = nil then
      FCanvas := TcxScreenCanvas.Create;
    Result := FCanvas;
  end;
end;

function TdxLayoutControlViewInfo.GetClientBounds: TRect;
begin
  Result := FControl.ClientBounds;
end;

function TdxLayoutControlViewInfo.GetContentBounds: TRect;
begin
  Result := ContainerViewInfo.ContentBounds;
end;

procedure TdxLayoutControlViewInfo.Calculate;
begin
  ContainerViewInfo.Calculate;
end;

function TdxLayoutControlViewInfo.GetItemWithMouse(const P: TPoint): TdxCustomLayoutItem;
begin
  Result := ContainerViewInfo.GetItemWithMouse(P);
end;

initialization
  dxLayoutDesignTimeSelectionHelperClass := TdxLayoutRunTimeSelectionHelper;

finalization
  FreeAndNil(FDesignCustomizationHelper);
end.
