{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
{                                                                    }
{       Copyright (c) 1998-2011 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit cxGridLayoutViewCustomizationForm;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, StdCtrls, ComCtrls, Forms, ImgList,
  ActnList, Dialogs, Menus, cxGraphics, cxControls, cxLookAndFeels, cxCheckBox, cxButtons, cxTreeView,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxLayoutPainters, dxLayoutCommon,
  dxLayoutCustomizeForm, dxLayoutControlAdapters, dxLayoutContainer, dxLayoutcxEditAdapters,
  dxLayoutControl, cxGridLayoutView, cxGridCustomView, dxLayoutLookAndFeels,
  cxStyles, cxClasses, cxGridLevel, cxGrid;

type
  TcxGridLayoutViewCustomizationForm = class;
  TcxGridLayoutViewCustomizationFormLayoutLookAndFeel = class;

  { TcxGridLayoutViewCustomizationFormGroupViewInfo }

  TcxGridLayoutViewCustomizationFormGroupViewInfo = class(TdxLayoutGroupCxLookAndFeelViewInfo)
  private
    function GetGridLayoutViewLayoutLookAndFeel: TcxGridLayoutViewCustomizationFormLayoutLookAndFeel;
    function GetRootOffset: Integer;
  protected
    function CalculateOffset(ASide: TdxLayoutSide): Integer; override;
    function GetPadding: TRect; override;
    function GetSelectionBoundsOffset: Integer; override;
    function HasCaption: Boolean; override;

    property LayoutLookAndFeel: TcxGridLayoutViewCustomizationFormLayoutLookAndFeel read GetGridLayoutViewLayoutLookAndFeel;
  end;

  { TcxGridLayoutViewCustomizationFormGroupPainter }

  TcxGridLayoutViewCustomizationFormGroupPainter = class(TdxLayoutGroupCxLookAndFeelPainter)
  protected
    function CanDrawBorders: Boolean; override;
    function CanDrawCaption: Boolean; override;
  end;

  { TcxGridLayoutViewCustomizationFormLayoutLookAndFeel }

  TcxGridLayoutViewCustomizationFormLayoutLookAndFeel = class(TcxGridLayoutLookAndFeel)
  public
    function GetGroupPainterClass: TClass; override;
    function GetGroupViewInfoClass: TClass; override;
  end;

  { TcxGridViewLayoutContainer }

  TcxGridViewLayoutContainer = class(TdxLayoutControlContainer)
  protected
    function CalculateCustomizeFormBounds(const AFormBounds: TRect): TRect; override;
    procedure CreateCustomizeForm; override;
    function GetCustomizeForm: TdxLayoutControlCustomCustomizeForm; override;
    function GetViewInfoClass: TdxLayoutContainerViewInfoClass; override;
    procedure DestroyCustomizeForm; override;
    procedure ShowCustomizeForm; override;
  end;

  { TcxGridViewLayoutControl }

  TcxGridViewLayoutControl = class(TdxLayoutControl)
  private
    function GetContainer: TcxGridViewLayoutContainer;
    function GetLayoutLookAndFeel: TcxGridLayoutLookAndFeel;
    procedure SetLayoutLookAndFeel(Value: TcxGridLayoutLookAndFeel);
  protected
    function GetContainerClass: TdxLayoutControlContainerClass; override;
  public
    property Container: TcxGridViewLayoutContainer read GetContainer;
  published
    property LayoutLookAndFeel: TcxGridLayoutLookAndFeel read GetLayoutLookAndFeel write SetLayoutLookAndFeel;
  end;

  { TcxGridLayoutViewCustomizationForm }

  TcxGridLayoutViewCustomizationForm = class(TdxLayoutControlCustomizeForm,
    IcxGridCustomizationForm,
    IcxDialogMetricsInfoData
  )
    liGridViewContainer: TdxLayoutItem;
    lcMainGroup5: TdxLayoutGroup;
    lcMainSplitterItem1: TdxLayoutSplitterItem;
    dxLayoutLookAndFeelList1: TdxLayoutLookAndFeelList;
    llfMain: TdxLayoutCxLookAndFeel;
    acCancel: TAction;
    acOk: TAction;
    btnOk: TcxButton;
    liOk: TdxLayoutItem;
    btnCancel: TcxButton;
    liCancel: TdxLayoutItem;
    lcMainTemplateCardGroup: TdxLayoutGroup;
    lcMainTabbedGroup: TdxLayoutGroup;
    lcMainViewLayoutGroup: TdxLayoutGroup;
    gMain: TcxGrid;
    lcMainItem16: TdxLayoutItem;
    cbSaveData: TcxCheckBox;
    liSaveData: TdxLayoutItem;
    lcMainGroup4: TdxLayoutGroup;
    cbSaveLayout: TcxCheckBox;
    liSaveLayout: TdxLayoutItem;
    procedure acOkExecute(Sender: TObject);
    procedure acCancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure lcMainTabbedGroupTabChanged(Sender: TObject);
  private
    FController: TcxGridLayoutViewController;
    FGridViewLayoutControl: TcxGridViewLayoutControl;
    FLayoutLookAndFeel: TcxGridLayoutViewCustomizationFormLayoutLookAndFeel;
    FTreeViewWidth: Integer;
    FPreviewView: TcxGridLayoutView;
    function GetDataControllerSupport: IcxCustomGridDataController;
    function GetGridView: TcxGridLayoutView;
    function GetViewSupport: IcxGridViewLayoutEditorSupport;
  protected
    procedure Loaded; override;
    //IcxDialogMetricsInfoData
    function GetInfoData: Pointer; virtual;
    function GetInfoDataSize: Integer; virtual;
    procedure SetInfoData(AData: Pointer); virtual;

    function GetWndParent: THandle; override;
    procedure Localize; override;
    procedure RefreshLayoutLookAndFeel; override;

    procedure Load;
    procedure Save;

    // IcxGridCustomizationForm
    procedure GridViewChanged;
    function GetController: TcxCustomGridController;
    procedure Initialize(AController: TcxCustomGridController);
    procedure RefreshData;

    procedure CreateControls; virtual;
    procedure DoInitializeControl; override;
    function HasChanges: Boolean;
    procedure InitializeGridViewLayout; virtual;
    function IsDataChangeable: Boolean;
    function IsLayoutChangeable: Boolean;
    procedure RefreshStoring; override;

    property PreviewView: TcxGridLayoutView read FPreviewView;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ApplyChanges;
    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; override;

    property Controller: TcxGridLayoutViewController read FController;
    property DataControllerSupport: IcxCustomGridDataController read GetDataControllerSupport;
    property GridView: TcxGridLayoutView read GetGridView;
    property ViewSupport: IcxGridViewLayoutEditorSupport read GetViewSupport;
  end;

implementation

{$R *.dfm}

uses
  cxGeometry, cxGridStrs;

type
  TdxCustomLayoutItemViewInfoAccess = class(TdxCustomLayoutItemViewInfo);
  TdxLayoutContainerAccess = class(TdxLayoutContainer);
  TcxGridLayoutViewAccess = class(TcxGridLayoutView);
  TcxCustomGridControllerAccess = class(TcxCustomGridController);

{ TcxGridLayoutViewCustomizationFormGroupViewInfo }

function TcxGridLayoutViewCustomizationFormGroupViewInfo.CalculateOffset(ASide: TdxLayoutSide): Integer;
begin
  Result := inherited CalculateOffset(ASide);
  if Group.IsRoot then
    Result := Result + GetRootOffset;
end;

function TcxGridLayoutViewCustomizationFormGroupViewInfo.GetPadding: TRect;
begin
  Result := inherited GetPadding;
  if Group.IsRoot then
    Inc(Result.Top, CaptionViewInfo.Height);
end;

function TcxGridLayoutViewCustomizationFormGroupViewInfo.GetSelectionBoundsOffset: Integer;
begin
  Result := inherited GetSelectionBoundsOffset;
  if Group.IsRoot then
    Result := -Result;
end;

function TcxGridLayoutViewCustomizationFormGroupViewInfo.HasCaption: Boolean;
begin
  Result := inherited HasCaption or Group.IsRoot;
end;

function TcxGridLayoutViewCustomizationFormGroupViewInfo.GetGridLayoutViewLayoutLookAndFeel: TcxGridLayoutViewCustomizationFormLayoutLookAndFeel;
begin
  Result := TcxGridLayoutViewCustomizationFormLayoutLookAndFeel(inherited LayoutLookAndFeel);
end;

function TcxGridLayoutViewCustomizationFormGroupViewInfo.GetRootOffset: Integer;
begin
  Result := LayoutLookAndFeel.DLUToPixels(LayoutLookAndFeel.GetGroupCaptionFont(Group.Container.ILayoutFontHelper), 7);
end;

{ TcxGridLayoutViewCustomizationFormGroupPainter }

function TcxGridLayoutViewCustomizationFormGroupPainter.CanDrawBorders: Boolean;
begin
  Result := inherited CanDrawBorders or TdxCustomLayoutItemViewInfoAccess(ViewInfo).Item.IsRoot;
end;

function TcxGridLayoutViewCustomizationFormGroupPainter.CanDrawCaption: Boolean;
begin
  Result := inherited CanDrawCaption or TdxCustomLayoutItemViewInfoAccess(ViewInfo).Item.IsRoot;
end;

{ TcxGridLayoutViewCustomizationFormLayoutLookAndFeel }

function TcxGridLayoutViewCustomizationFormLayoutLookAndFeel.GetGroupPainterClass: TClass;
begin
  Result := TcxGridLayoutViewCustomizationFormGroupPainter;
end;

function TcxGridLayoutViewCustomizationFormLayoutLookAndFeel.GetGroupViewInfoClass: TClass;
begin
  Result := TcxGridLayoutViewCustomizationFormGroupViewInfo;
end;

{ TcxGridViewLayoutContainer }

function TcxGridViewLayoutContainer.CalculateCustomizeFormBounds(
  const AFormBounds: TRect): TRect;
begin
  Result := AFormBounds;
end;

procedure TcxGridViewLayoutContainer.CreateCustomizeForm;
begin
// do nothing
end;

function TcxGridViewLayoutContainer.GetViewInfoClass: TdxLayoutContainerViewInfoClass;
begin
  Result := TcxGridCustomLayoutContainerViewInfo;
end;

procedure TcxGridViewLayoutContainer.DestroyCustomizeForm;
begin
// do nothing
end;

procedure TcxGridViewLayoutContainer.ShowCustomizeForm;
begin
// do nothing
end;

function TcxGridViewLayoutContainer.GetCustomizeForm: TdxLayoutControlCustomCustomizeForm;
var
  AParentForm: TCustomForm;
begin
  AParentForm := GetParentForm(ItemsParent);
  if AParentForm is TdxLayoutControlCustomCustomizeForm then
    Result := TdxLayoutControlCustomCustomizeForm(AParentForm)
  else
    Result := nil;
end;

{ TcxGridViewLayoutControl }

function TcxGridViewLayoutControl.GetContainerClass: TdxLayoutControlContainerClass;
begin
  Result := TcxGridViewLayoutContainer;
end;

function TcxGridViewLayoutControl.GetContainer: TcxGridViewLayoutContainer;
begin
  Result := TcxGridViewLayoutContainer(inherited Container);
end;

function TcxGridViewLayoutControl.GetLayoutLookAndFeel: TcxGridLayoutLookAndFeel;
begin
  Result := TcxGridLayoutLookAndFeel(inherited LayoutLookAndFeel);
end;

procedure TcxGridViewLayoutControl.SetLayoutLookAndFeel(Value: TcxGridLayoutLookAndFeel);
begin
  inherited LayoutLookAndFeel := Value;
end;

{ TcxGridLayoutViewCustomizationForm }

constructor TcxGridLayoutViewCustomizationForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLayoutLookAndFeel := TcxGridLayoutViewCustomizationFormLayoutLookAndFeel(
    dxLayoutLookAndFeelList1.CreateItem(TcxGridLayoutViewCustomizationFormLayoutLookAndFeel));
end;

destructor TcxGridLayoutViewCustomizationForm.Destroy;
begin
  Container := nil;
  FreeAndNil(FPreviewView);
  FreeAndNil(FGridViewLayoutControl);
  FreeAndNil(FLayoutLookAndFeel);
  inherited Destroy;
end;

procedure TcxGridLayoutViewCustomizationForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  AChoice: Integer;
begin
  if (ModalResult = mrCancel) and FGridViewLayoutControl.UndoRedoManager.CanUndo then
  begin
    AChoice := MessageBox(0,
      PChar(cxGetResourceString(@scxGridLayoutViewCustomizeWarningDialogMessage)),
      PChar(cxGetResourceString(@scxGridLayoutViewCustomizeWarningDialogCaption)),
      MB_ICONWARNING or MB_YESNOCANCEL);
    CanClose := AChoice <> IDCANCEL;
    if AChoice = IDYES then
      ModalResult := mrOk;
  end;
end;

function TcxGridLayoutViewCustomizationForm.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;
begin
  if PtInRect(FGridViewLayoutControl.BoundsRect, P) then
    Result := nil
  else
    Result := inherited GetHitTest(P);
end;

procedure TcxGridLayoutViewCustomizationForm.Loaded;
begin
  inherited;
  Constraints.MinWidth := Width div 2;
end;

function TcxGridLayoutViewCustomizationForm.GetInfoData: Pointer;
begin
  FTreeViewWidth := lcMainGroup1.Width;
  Result := @FTreeViewWidth;
end;

function TcxGridLayoutViewCustomizationForm.GetInfoDataSize: Integer;
begin
  Result := SizeOf(FTreeViewWidth);
end;

procedure TcxGridLayoutViewCustomizationForm.SetInfoData(AData: Pointer);
begin
  FTreeViewWidth := PInteger(AData)^;
  lcMainGroup1.Width := FTreeViewWidth;
end;

function TcxGridLayoutViewCustomizationForm.GetWndParent: THandle;
begin
  if Controller = nil then
    Result := 0
  else
    Result := Controller.GridView.Control.Handle;
end;

procedure TcxGridLayoutViewCustomizationForm.Localize;
begin
  inherited Localize;
  acCancel.Caption := cxGetResourceString(@scxGridLayoutViewCustomizeFormCancel);
  acCancel.Hint := StripHotKey(acCancel.Caption);
  acOk.Caption := cxGetResourceString(@scxGridLayoutViewCustomizeFormOk);
  acOk.Hint := StripHotKey(acOk.Caption);
  lcMainTemplateCardGroup.Caption := cxGetResourceString(@scxGridLayoutViewCustomizeFormTemplateCard);
  lcMainViewLayoutGroup.Caption := cxGetResourceString(@scxGridLayoutViewCustomizeFormViewLayout);
end;

procedure TcxGridLayoutViewCustomizationForm.RefreshLayoutLookAndFeel;
var
  AIntf: IdxLayoutControl;
begin
  Supports(GridView, IdxLayoutControl, AIntf);
  FLayoutLookAndFeel.Assign(AIntf.GetLayoutLookAndFeel);
  FGridViewLayoutControl.LayoutLookAndFeel := FLayoutLookAndFeel;
  llfMain.LookAndFeel.MasterLookAndFeel := FLayoutLookAndFeel.LookAndFeel;
end;

procedure TcxGridLayoutViewCustomizationForm.Load;
begin
  PreviewView.BeginUpdate;
  try
    PreviewView.Assign(GridView);
    (PreviewView.DataController as IcxCustomGridDataController).AssignData(GridView.DataController);
  finally
    PreviewView.CancelUpdate;
  end;
  GridView.BeginUpdate;
  try
    ViewSupport.BeforeEditLayout(PreviewView);
  finally
    GridView.CancelUpdate;
  end;
  FGridViewLayoutControl.OptionsImage.Images := PreviewView.Images;
  FGridViewLayoutControl.Container.CopyStructure(PreviewView.Container);
end;

procedure TcxGridLayoutViewCustomizationForm.Save;
begin
  PreviewView.BeginUpdate;
  try
    TdxLayoutContainerAccess(PreviewView.Container).CopyStructure(Container);
    if IsLayoutChangeable then
      GridView.Assign(PreviewView);
  finally
    PreviewView.CancelUpdate;
  end;
end;

procedure TcxGridLayoutViewCustomizationForm.ApplyChanges;
begin
  if HasChanges then
  begin
    GridView.BeginUpdate;
    try
      Save;
      Container.UndoRedoManager.Clear;
      RefreshEnableds;
      GridView.Invalidate(True);
    finally
      GridView.EndUpdate;
    end;
  end;
  if DataControllerSupport.IsDataChangeable and cbSaveData.Checked then
    DataControllerSupport.AssignData(PreviewView.DataController);
end;

procedure TcxGridLayoutViewCustomizationForm.GridViewChanged;
begin
end;

function TcxGridLayoutViewCustomizationForm.GetController: TcxCustomGridController;
begin
  Result := FController;
end;

procedure TcxGridLayoutViewCustomizationForm.Initialize(AController: TcxCustomGridController);
begin
  FController := TcxGridLayoutViewController(AController);
  TcxCustomGridControllerAccess(AController).InitializeCustomizationForm(Self);
  CreateControls;
end;

procedure TcxGridLayoutViewCustomizationForm.RefreshData;
begin
end;

procedure TcxGridLayoutViewCustomizationForm.CreateControls;
begin
  InitializeGridViewLayout;
end;

procedure TcxGridLayoutViewCustomizationForm.DoInitializeControl;
begin
  inherited DoInitializeControl;
  acAddSplitter.Visible := False;
  liOK.Visible := ViewSupport.IsLayoutChangeable or DataControllerSupport.IsDataChangeable;
  if not liOK.Visible then
  begin
    acCancel.Caption := 'Close';
    acCancel.Hint := StripHotKey(acCancel.Caption);
    btnCancel.Default := True;
  end
  else
    btnOk.Default := True;
  liSaveData.Visible := GridView.IsDesigning and IsDataChangeable;
  liSaveLayout.Visible := GridView.IsDesigning and IsLayoutChangeable;
  if not GridView.IsDesigning then
  begin
    PreviewView.BeginUpdate;
    try
      PreviewView.Navigator.Visible := False;
      PreviewView.OptionsData.Editing := False;
      PreviewView.OptionsData.Inserting := False;
      PreviewView.OptionsData.Appending := False;
      PreviewView.OptionsData.Deleting := False;
    finally
      PreviewView.CancelUpdate;
    end;
  end
  else
  begin
    Caption := 'Layout and Data Editor - ' + GridView.Name;
  end;

  if Container <> nil then
    Container.Root.Caption := cxGetResourceString(@scxGridLayoutViewCustomizeFormTemplateCard);
end;

function TcxGridLayoutViewCustomizationForm.HasChanges: Boolean;
begin
  Result := Container.UndoRedoManager.CanUndo;
end;

procedure TcxGridLayoutViewCustomizationForm.InitializeGridViewLayout;
var
  AIntf: IdxLayoutControl;
begin
  FGridViewLayoutControl := TcxGridViewLayoutControl.Create(Self);
  FGridViewLayoutControl.CustomizeFormTabbedView := True;
  FGridViewLayoutControl.BevelKind := bkTile;

  Supports(GridView, IdxLayoutControl, AIntf);
  FGridViewLayoutControl.OptionsItem.SizableHorz := AIntf.GetIsSizableHorz;
  FGridViewLayoutControl.OptionsItem.SizableVert := AIntf.GetIsSizableVert;

  FPreviewView := gMain.CreateView(TcxCustomGridViewClass(GridView.ClassType)) as TcxGridLayoutView;
  gMain.Levels.Add.GridView := FPreviewView;

  liGridViewContainer.Control := FGridViewLayoutControl;
  liGridViewContainer.SizeOptions.SizableHorz := True;
  liGridViewContainer.SizeOptions.SizableVert := True;

  Load;

  Container := FGridViewLayoutControl.Container;  
  Container.Customization := True;
end;

function TcxGridLayoutViewCustomizationForm.IsDataChangeable: Boolean;
begin
  Result := GridView.IsDesigning and DataControllerSupport.IsDataChangeable;
end;

function TcxGridLayoutViewCustomizationForm.IsLayoutChangeable: Boolean;
begin
  Result := ViewSupport.IsLayoutChangeable and
    (not GridView.IsDesigning or cbSaveLayout.Checked);
end;

procedure TcxGridLayoutViewCustomizationForm.RefreshStoring;
begin
  acStore.Visible := False;
  liStore.Visible := False;
  acRestore.Visible := False;
  liRestore.Visible := False;
end;

function TcxGridLayoutViewCustomizationForm.GetDataControllerSupport: IcxCustomGridDataController;
begin
  Result := GridView.DataController as IcxCustomGridDataController;
end;

function TcxGridLayoutViewCustomizationForm.GetGridView: TcxGridLayoutView;
begin
  Result := Controller.GridView;
end;

function TcxGridLayoutViewCustomizationForm.GetViewSupport: IcxGridViewLayoutEditorSupport;
begin
  Result := GridView as IcxGridViewLayoutEditorSupport;
end;

procedure TcxGridLayoutViewCustomizationForm.acOkExecute(Sender: TObject);
begin
// for enabled action
end;

procedure TcxGridLayoutViewCustomizationForm.acCancelExecute(
  Sender: TObject);
begin
  Close;
end;

procedure TcxGridLayoutViewCustomizationForm.lcMainTabbedGroupTabChanged(
  Sender: TObject);
begin
  inherited;
  if (lcMainTabbedGroup.ItemIndex = 1) and HasChanges then
    TdxLayoutContainerAccess(PreviewView.Container).CopyStructure(Container);
end;

end.
