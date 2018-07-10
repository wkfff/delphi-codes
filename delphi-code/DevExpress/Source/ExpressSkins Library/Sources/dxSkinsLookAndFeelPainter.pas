{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{                    ExpressSkins Library                            }
{                                                                    }
{           Copyright (c) 2006-2011 Developer Express Inc.           }
{                     ALL RIGHTS RESERVED                            }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSKINS AND ALL ACCOMPANYING     }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
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

unit dxSkinsLookAndFeelPainter;

{$I cxVer.inc}

interface

uses
  Windows, Classes, Graphics, SysUtils, ImgList, 
  cxLookAndFeels, cxLookAndFeelPainters,
  dxCore, cxGraphics, cxGeometry, cxClasses, dxGdiPlusApi,
  dxSkinsCore, dxSkinInfo, dxSkinsStrs;

type
  { TdxSkinLookAndFeelPainterInfo }

  TdxSkinLookAndFeelPainterInfo = class(TdxSkinInfo);
  TdxSkinLookAndFeelPainterInfoClass = class of TdxSkinLookAndFeelPainterInfo;

  { TcxSkinLookAndFeelPainter }

  TdxSkinLookAndFeelPainter = class(TcxOffice11LookAndFeelPainter)
  private
    FSkinDetails: TdxSkinDetails;
    FSkinInfo: TdxSkinLookAndFeelPainterInfo;
    FSkinResInstance: THandle;
    FSkinResName: string;
    function GetSkinDetails: TdxSkinDetails;
    function GetSkinInfo: TdxSkinLookAndFeelPainterInfo;
  protected
    procedure DrawContent(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect; AState: Integer;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False); override;
    procedure DrawFooterBorderEx(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders); override;
    procedure DrawSchedulerNavigationButtonContent(ACanvas: TcxCanvas;
      const ARect: TRect; const AArrowRect: TRect; AIsNextButton: Boolean;
      AState: TcxButtonState); override;
    function IsColorAssigned(AColor: TColor): Boolean;
    function IsColorPropertyAssigned(AColor: TdxSkinColor): Boolean;
    function GetSkinInfoClass: TdxSkinLookAndFeelPainterInfoClass; virtual;
  public
    constructor Create(const ASkinResName: string; ASkinResInstance: THandle); virtual;
    destructor Destroy; override;
    function GetPainterData(var AData): Boolean; override;
    function GetPainterDetails(var ADetails): Boolean; override;
    function LookAndFeelName: string; override;
    function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    // colors
    function DefaultContentColor: TColor; override;
    function DefaultContentEvenColor: TColor; override;
    function DefaultContentOddColor: TColor; override;
    function DefaultContentTextColor: TColor; override;
    function DefaultEditorBackgroundColorEx(AKind: TcxEditStateColorKind): TColor; override;
    function DefaultEditorTextColorEx(AKind: TcxEditStateColorKind): TColor; override;
    function DefaultFilterBoxTextColor: TColor; override;
    function DefaultFixedSeparatorColor: TColor; override;
    function DefaultFooterColor: TColor; override;
    function DefaultGridDetailsSiteColor: TColor; override;
    function DefaultGridLineColor: TColor; override;
    function DefaultGroupByBoxTextColor: TColor; override;
    function DefaultGroupColor: TColor; override;
    function DefaultGroupTextColor: TColor; override;
    function DefaultHeaderBackgroundColor: TColor; override;
    function DefaultHeaderBackgroundTextColor: TColor; override;
    function DefaultHeaderColor: TColor; override;
    function DefaultHeaderTextColor: TColor; override;
    function DefaultHyperlinkTextColor: TColor; override;
    function DefaultPreviewTextColor: TColor; override;
    function DefaultRecordSeparatorColor: TColor; override;
    function DefaultSchedulerBackgroundColor: TColor; override;
    function DefaultSchedulerBorderColor: TColor; override;
    function DefaultSchedulerControlColor: TColor; override;
    function DefaultSchedulerNavigatorColor: TColor; override;
    function DefaultSchedulerTimeRulerColor: TColor; override;
    function DefaultSchedulerTimeRulerTextColor: TColor; override;
    function DefaultSchedulerViewSelectedTextColor: TColor; override;
    function DefaultSchedulerViewTextColor: TColor; override;
    function DefaultSelectionColor: TColor; override;
    function DefaultSelectionTextColor: TColor; override;
    function DefaultSeparatorColor: TColor; override;
    function DefaultSizeGripAreaColor: TColor; override;
    function DefaultTimeGridMajorScaleTextColor: TColor; override;
    function DefaultTimeGridMinorScaleTextColor: TColor; override;

    function DefaultDateNavigatorHeaderColor: TColor; override;
    function DefaultDateNavigatorHeaderTextColor(AIsHighlight: Boolean): TColor; override;
    function DefaultDateNavigatorHolydayTextColor: TColor; override;
    function DefaultDateNavigatorInactiveTextColor: TColor; override;
    function DefaultDateNavigatorSelectionColor: TColor; override;
    function DefaultDateNavigatorSelectionTextColor: TColor; override;
    function DefaultDateNavigatorSeparator1Color: TColor; override;
    function DefaultDateNavigatorSeparator2Color: TColor; override;
    function DefaultDateNavigatorTextColor: TColor; override;
    function DefaultDateNavigatorTodayFrameColor: TColor; override;
    function DefaultDateNavigatorTodayTextColor: TColor; override;

    function DefaultVGridBandLineColor: TColor; override;
    function DefaultVGridCategoryColor: TColor; override;
    function DefaultVGridCategoryTextColor: TColor; override;
    function DefaultVGridHeaderColor: TColor; override;
    function DefaultVGridHeaderTextColor: TColor; override;
    function DefaultVGridLineColor: TColor; override;
    // borders
    procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
    procedure DrawContainerBorder(ACanvas: TcxCanvas; const R: TRect; AStyle: TcxContainerBorderStyle;
      AWidth: Integer; AColor: TColor; ABorders: TcxBorders); override;
    procedure DrawSeparator(ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean); override;
    // buttons
    function AdjustGroupButtonDisplayRect(const R: TRect; AButtonCount, AButtonIndex: Integer): TRect; override;
    function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; override;
    function ButtonColor(AState: TcxButtonState): TColor; override;
    function ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect; override;
    function ButtonGroupBorderSizes(AButtonCount, AButtonIndex: Integer): TRect; override;
    function ButtonSymbolColor(AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor; override;
    function ButtonTextOffset: Integer; override;
    function ButtonTextShift: Integer; override;
    procedure DrawButton(ACanvas: TcxCanvas; R: TRect; const ACaption: string;
      AState: TcxButtonState; ADrawBorder: Boolean = True;
      AColor: TColor = clDefault; ATextColor: TColor = clDefault;
      AWordWrap: Boolean = False; AIsToolButton: Boolean = False); override;
    procedure DrawButtonGroupBorder(ACanvas: TcxCanvas; R: TRect; AInplace, ASelected: Boolean); override;
    procedure DrawButtonInGroup(ACanvas: TcxCanvas; R: TRect;
      AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
      ABackgroundColor: TColor); override;
    procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect;
      AExpanded: Boolean; AColor: TColor = clDefault); override;
    procedure DrawExpandButtonEx(ACanvas: TcxCanvas; const R: TRect;
      AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0); override;
    function DrawExpandButtonFirst: Boolean; override;
    procedure DrawGroupExpandButton(ACanvas: TcxCanvas; const R: TRect;
      AExpanded: Boolean; AState: TcxButtonState); override;
    procedure DrawSmallExpandButton(ACanvas: TcxCanvas; R: TRect; AExpanded: Boolean;
      ABorderColor: TColor; AColor: TColor = clDefault); override;
    function ExpandButtonSize: Integer; override;
    function GroupExpandButtonSize: Integer; override;
    function SmallExpandButtonSize: Integer; override;
    function IsButtonHotTrack: Boolean; override;
    function IsPointOverGroupExpandButton(const R: TRect; const P: TPoint): Boolean; override;
    // scroll bars
    function ScrollBarMinimalThumbSize(AVertical: Boolean): Integer; override;
    procedure DrawScrollBarBackground(ACanvas: TcxCanvas; const R: TRect;
      AHorizontal: Boolean); override;
    procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // label line
    procedure DrawLabelLine(ACanvas: TcxCanvas; const R: TRect;
      AOuterColor, AInnerColor: TColor; AIsVertical: Boolean); override;
    function LabelLineHeight: Integer; override;
    // size grip
    function SizeGripSize: TSize; override;
    procedure DoDrawSizeGrip(ACanvas: TcxCanvas; const ARect: TRect); override;
    // SmallCloseButton
    function SmallCloseButtonSize: TSize; override;
    procedure DrawSmallCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    // RadioGroup
    procedure DrawRadioButton(ACanvas: TcxCanvas; X, Y: Integer;
      AButtonState: TcxButtonState; AChecked, AFocused: Boolean;
      ABrushColor: TColor;  AIsDesigning: Boolean = False); override;
    function RadioButtonSize: TSize; override;
    // Checkbox
    function CheckButtonSize: TSize; override;
    procedure DrawCheckButton(ACanvas: TcxCanvas; R: TRect;
      AState: TcxButtonState; ACheckState: TcxCheckBoxState); override;
    // Editors
    procedure DrawClock(ACanvas: TcxCanvas; const ARect: TRect;
      ADateTime: TDateTime; ABackgroundColor: TColor); override;
    procedure DrawEditorButton(ACanvas: TcxCanvas; const ARect: TRect;
      AButtonKind: TcxEditBtnKind; AState: TcxButtonState;
      APosition: TcxEditBtnPosition = cxbpRight); override;
    function EditButtonTextOffset: Integer; override;
    function EditButtonSize: TSize; override;
    function EditButtonTextColor: TColor; override;
    function GetContainerBorderColor(AIsHighlightBorder: Boolean): TColor; override;
    function GetContainerBorderWidth(ABorderStyle: TcxContainerBorderStyle): Integer; override;
    // Navigator
    procedure DrawNavigatorGlyph(ACanvas: TcxCanvas; AImageList: TCustomImageList;
      AImageIndex: TImageIndex; AButtonIndex: Integer; const AGlyphRect: TRect;
      AEnabled: Boolean; AUserGlyphs: Boolean); override;
    function NavigatorGlyphSize: TSize; override;
    // ProgressBar
    procedure DrawProgressBarBorder(ACanvas: TcxCanvas; ARect: TRect; AVertical: Boolean); override;
    procedure DrawProgressBarChunk(ACanvas: TcxCanvas; ARect: TRect; AVertical: Boolean); override;
    function ProgressBarBorderSize(AVertical: Boolean): TRect; override;
    function ProgressBarTextColorEx(AIsFilledArea: Boolean): TColor; override;
    // GroupBox
    procedure DrawGroupBoxBackground(ACanvas: TcxCanvas; ABounds: TRect;
      ARect: TRect); override;
    procedure DrawGroupBoxCaption(ACanvas: TcxCanvas; ACaptionRect: TRect;
      ACaptionPosition: TcxGroupBoxCaptionPosition); override;
    procedure DrawGroupBoxContent(ACanvas: TcxCanvas; ABorderRect: TRect;
      ACaptionPosition: TcxGroupBoxCaptionPosition; ABorders: TcxBorders = cxBordersAll); override;
    procedure DrawGroupBoxExpandButton(ACanvas: TcxCanvas;
      const R: TRect; AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0); override;
    function GroupBoxBorderSize(ACaption: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition): TRect; override;
    procedure DrawGroupBoxFrame(ACanvas: TcxCanvas; R: TRect; AEnabled: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition; ABorders: TcxBorders = cxBordersAll); override;
    function GroupBoxTextColor(AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TColor; override;
    function IsGroupBoxTransparent(AIsCaption: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition): Boolean; override;
    function PanelTextColor: TColor; override;
    // Header
    procedure DrawHeader(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False;
      AIsGroup: Boolean = False); override;
    procedure DrawHeaderEx(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    procedure DrawHeaderSeparator(ACanvas: TcxCanvas; const ABounds: TRect;
      AIndentSize: Integer; AColor: TColor; AViewParams: TcxViewParams); override;
    function HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders; override;
    function HeaderDrawCellsFirst: Boolean; override;
    // Grid
    procedure DrawGroupByBox(ACanvas: TcxCanvas; const ARect: TRect;
      ATransparent: Boolean; ABackgroundColor: TColor; const ABackgroundBitmap: TBitmap); override;
    function GridDrawHeaderCellsFirst: Boolean; override;
    function GridGroupRowStyleOffice11ContentColor(AHasData: Boolean): TColor; override;
    function GridGroupRowStyleOffice11SeparatorColor: TColor; override;
    function GridGroupRowStyleOffice11TextColor: TColor; override;
    function PivotGridHeadersAreaColor: TColor; override;
    function PivotGridHeadersAreaTextColor: TColor; override;
    // Layout View
    procedure LayoutViewDrawRecordCaption(ACanvas: TcxCanvas; const ABounds: TRect;
      APosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState); override;
    procedure LayoutViewDrawRecordContent(ACanvas: TcxCanvas; const ABounds: TRect;
      ACaptionPosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState; ABorders: TcxBorders = cxBordersAll); override;
    procedure LayoutViewDrawRecordExpandButton(ACanvas: TcxCanvas;
      const ABounds: TRect; AState: TcxButtonState; AExpanded: Boolean); override;
    procedure LayoutViewDrawItem(ACanvas: TcxCanvas; const ABounds: TRect;
      AState: TcxButtonState; ABorders: TcxBorders = []); override;
    function LayoutViewGetPadding(AElement: TcxLayoutElement): TRect; override;
    function LayoutViewGetSpacing(AElement: TcxLayoutElement): TRect; override;
    // Footer
    procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); override;
    procedure DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect); override;
    procedure DrawFooterCellContent(ACanvas: TcxCanvas; const ABounds: TRect;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    procedure DrawFooterContent(ACanvas: TcxCanvas; const ARect: TRect;
      const AViewParams: TcxViewParams); override;
    function FooterCellBorderSize: Integer; override;
    function FooterDrawCellsFirst: Boolean; override;
    function FooterSeparatorColor: TColor; override;
    // filter
    function FilterCloseButtonSize: TPoint; override;
    procedure DrawFilterCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    procedure DrawFilterPanel(ACanvas: TcxCanvas; const ARect: TRect;
      ATransparent: Boolean; ABackgroundColor: TColor; const ABackgroundBitmap: TBitmap); override;
    // Panel
    procedure DrawPanelBorders(ACanvas: TcxCanvas; const ABorderRect: TRect); override;
    procedure DrawPanelContent(ACanvas: TcxCanvas; const ABorderRect: TRect; ABorder: Boolean); override;
    // TrackBar
    procedure DrawTrackBarTrack(ACanvas: TcxCanvas; const ARect, ASelection: TRect;
      AShowSelection, AEnabled, AHorizontal: Boolean; ATrackColor: TColor); override;
    procedure DrawTrackBarThumb(ACanvas: TcxCanvas; const ARect: TRect;
      AState: TcxButtonState; AHorizontal: Boolean;
      ATicks: TcxTrackBarTicksAlign; AThumbColor: TColor); override;
    function TrackBarThumbSize(AHorizontal: Boolean): TSize; override;
    function TrackBarTrackSize: Integer; override;
    // Splitter
    procedure DrawSplitter(ACanvas: TcxCanvas; const ARect: TRect;
      AHighlighted: Boolean; AClicked: Boolean; AHorizontal: Boolean); override;
    function GetSplitterSize(AHorizontal: Boolean): TSize; override;
    // Indicator
    procedure DrawIndicatorCustomizationMark(ACanvas: TcxCanvas;
      const R: TRect; AColor: TColor); override;
    procedure DrawIndicatorImage(ACanvas: TcxCanvas; const R: TRect; AKind: TcxIndicatorKind); override;
    procedure DrawIndicatorItem(ACanvas: TcxCanvas; const R: TRect;
      AKind: TcxIndicatorKind; AColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    procedure DrawIndicatorItemEx(ACanvas: TcxCanvas; const R: TRect;
      AKind: TcxIndicatorKind; AColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    function IndicatorDrawItemsFirst: Boolean; override;
    // ms outlook
    procedure DrawMonthHeader(ACanvas: TcxCanvas; const ABounds: TRect;
      const AText: string; ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    procedure DrawSchedulerEventProgress(ACanvas: TcxCanvas;
      const ABounds, AProgress: TRect; AViewParams: TcxViewParams; ATransparent: Boolean); override;
    function SchedulerEventProgressOffsets: TRect; override;
    function SchedulerNavigationButtonTextColor(AIsNextButton: Boolean;
      AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor; override;
    // Scheduler
    procedure CalculateSchedulerNavigationButtonRects(AIsNextButton: Boolean;
      ACollapsed: Boolean; APrevButtonTextSize: TSize; ANextButtonTextSize: TSize;
      var ABounds: TRect; out ATextRect: TRect; out AArrowRect: TRect); override;
    procedure DrawSchedulerNavigatorButton(ACanvas: TcxCanvas; R: TRect;
      AState: TcxButtonState); override;
    procedure SchedulerNavigationButtonSizes(AIsNextButton: Boolean;
      var ABorders: TRect; var AArrowSize: TSize; var AHasTextArea: Boolean); override;
    // Layout Control
    function LayoutControlEmptyAreaColor: TColor; override;
    procedure DrawLayoutControlBackground(ACanvas: TcxCanvas; const R: TRect); override;
    // Popup
    procedure DrawEditPopupWindowBorder(ACanvas: TcxCanvas; var R: TRect;
      ABorderStyle: TcxEditPopupBorderStyle; AClientEdge: Boolean); override;
    function GetEditPopupWindowBorderWidth(AStyle: TcxEditPopupBorderStyle): Integer; override;
    function GetEditPopupWindowClientEdgeWidth(AStyle: TcxEditPopupBorderStyle): Integer; override;
    procedure DrawWindowContent(ACanvas: TcxCanvas; const ARect: TRect); override;
    // Printing System
    function PrintPreviewPageBordersWidth: TRect; override;
    procedure DrawPrintPreviewBackground(ACanvas: TcxCanvas; const R: TRect); override;
    procedure DrawPrintPreviewPageBackground(ACanvas: TcxCanvas;
      const ABorderRect, AContentRect: TRect; ASelected, ADrawContent: Boolean); override;
    // DateNavigator
    procedure DrawDateNavigatorDateHeader(ACanvas: TcxCanvas; var R: TRect); override;
    // CalcEdit
    function CalcEditButtonTextColor(AButtonKind: TcxCalcButtonKind): TColor; override;
    // Customization Form
    function GetCustomizationFormListBackgroundColor: TColor; override;
    //
    property SkinDetails: TdxSkinDetails read GetSkinDetails;
    property SkinInfo: TdxSkinLookAndFeelPainterInfo read GetSkinInfo;
  end;

  TdxSkinLookAndFeelPainterClass = class of TdxSkinLookAndFeelPainter;

implementation

uses
  Math;

const
  ButtonStateToSkinState: array[TcxButtonState] of TdxSkinElementState = (
    esActive, esNormal, esHot, esPressed, esDisabled
  );

function cxRectExclude(const R, ABordersWidth: TRect; ABorders: TcxBorders): TRect;
begin
  Result := R;
  if not (bLeft in ABorders) then
    Dec(Result.Left, ABordersWidth.Left);
  if not (bTop in ABorders) then
    Dec(Result.Top, ABordersWidth.Top);
  if not (bRight in ABorders) then
    Inc(Result.Right, ABordersWidth.Right);
  if not (bBottom in ABorders) then
    Inc(Result.Bottom, ABordersWidth.Bottom);
end;

procedure dxSkinElementMakeDisable(ABitmap: TcxBitmap32);
var
  AColor: TRGBQuad;
  AColors: TRGBColors;
  I, AGray: Integer;
begin
  ABitmap.GetBitmapColors(AColors);
  try
    for I := 0 to Length(AColors) - 1 do
    begin
      AColor := AColors[I];
      AGray := (2 * AColor.rgbReserved + AColor.rgbBlue + AColor.rgbGreen + AColor.rgbRed) div 5;
      AColor.rgbBlue := AGray;
      AColor.rgbGreen := AGray;
      AColor.rgbRed := AGray;
      AColors[I] := AColor;
    end;
  finally
    ABitmap.SetBitmapColors(AColors);
  end;
end;

{ TdxSkinLookAndFeelPainter }

constructor TdxSkinLookAndFeelPainter.Create(
  const ASkinResName: string; ASkinResInstance: THandle);
begin
  inherited Create;
  FSkinResName := ASkinResName;
  FSkinResInstance := ASkinResInstance;
end;

destructor TdxSkinLookAndFeelPainter.Destroy;
begin
  FreeAndNil(FSkinDetails);
  FreeAndNil(FSkinInfo);
  inherited Destroy;
end;

function TdxSkinLookAndFeelPainter.GetPainterData(var AData): Boolean;
begin
  TObject(AData) := SkinInfo;
  Result := True;
end;

function TdxSkinLookAndFeelPainter.GetPainterDetails(var ADetails): Boolean;
begin
  Result := SkinDetails <> nil;
  if Result then
    TObject(ADetails) := SkinDetails;
end;

function TdxSkinLookAndFeelPainter.LookAndFeelName: string;
begin
  Result := SkinInfo.Skin.Name;
end;

function TdxSkinLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsSkin;
end;

function TdxSkinLookAndFeelPainter.DefaultContentColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(ContentColor) then
      Result := ContentColor.Value
    else
      Result := inherited DefaultContentColor;
end;

function TdxSkinLookAndFeelPainter.DefaultContentEvenColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(ContentEvenColor) then
      Result := ContentEvenColor.Value
    else
      Result := inherited DefaultContentEvenColor
end;

function TdxSkinLookAndFeelPainter.DefaultContentOddColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(ContentOddColor) then
      Result := ContentOddColor.Value
    else
      Result := inherited DefaultContentOddColor;
end;

function TdxSkinLookAndFeelPainter.DefaultContentTextColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(ContentTextColor) then
      Result := ContentTextColor.Value
    else
      Result := inherited DefaultContentTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultEditorBackgroundColorEx(
  AKind: TcxEditStateColorKind): TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(EditorBackgroundColors[AKind]) then
      Result := EditorBackgroundColors[AKind].Value
    else
      if AKind in [esckReadOnly, esckInactive] then
        Result := DefaultEditorBackgroundColorEx(esckNormal)
      else
        Result := inherited DefaultEditorBackgroundColorEx(AKind);
end;

function TdxSkinLookAndFeelPainter.DefaultEditorTextColorEx(
  AKind: TcxEditStateColorKind): TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(EditorTextColors[AKind]) then
      Result := EditorTextColors[AKind].Value
    else
      if AKind in [esckReadOnly, esckInactive] then
        Result := DefaultEditorTextColorEx(esckNormal)
      else
        Result := inherited DefaultEditorTextColorEx(AKind);
end;

function TdxSkinLookAndFeelPainter.DefaultFilterBoxTextColor: TColor;
begin
  with SkinInfo do
    if FilterPanel = nil then
      Result := inherited DefaultFilterBoxTextColor
    else
      Result := FilterPanel.TextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultFixedSeparatorColor: TColor;
begin
  with SkinInfo do
    if GridFixedLine = nil then
      Result := inherited DefaultFixedSeparatorColor
    else
      Result := GridFixedLine.Color;
end;

function TdxSkinLookAndFeelPainter.DefaultFooterColor: TColor;
begin
  Result := DefaultHeaderColor;
end;

function TdxSkinLookAndFeelPainter.DefaultGridDetailsSiteColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(ContentColor) then
      Result := ContentColor.Value
    else
      Result := inherited DefaultGridDetailsSiteColor
end;

function TdxSkinLookAndFeelPainter.DefaultGridLineColor: TColor;
begin
  with SkinInfo do
    if GridLine = nil then
      Result := inherited DefaultGridLineColor
    else
      Result := GridLine.Color;
end;

function TdxSkinLookAndFeelPainter.DefaultGroupColor: TColor;
begin
  with SkinInfo do
    if GridGroupRow = nil then
      Result := inherited DefaultGroupColor
    else
      Result := GridGroupRow.Color;
end;

function TdxSkinLookAndFeelPainter.DefaultGroupByBoxTextColor: TColor;
begin
  with SkinInfo do
    if GridGroupByBox = nil then
      Result := inherited DefaultGroupByBoxTextColor
    else
      Result := GridGroupByBox.TextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultGroupTextColor: TColor;
begin
  with SkinInfo do
    if GridGroupRow = nil then
      Result := inherited DefaultGroupTextColor
    else
      Result := GridGroupRow.TextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultHeaderBackgroundColor: TColor;
begin
  with SkinInfo do
    if HeaderBackgroundColor = nil then
      Result := inherited DefaultHeaderBackgroundColor
    else
      Result := HeaderBackgroundColor.Value;
end;

function TdxSkinLookAndFeelPainter.DefaultHeaderBackgroundTextColor: TColor;
begin
  with SkinInfo do
    if HeaderBackgroundTextColor = nil then
      Result := inherited DefaultHeaderBackgroundTextColor
    else
      Result := HeaderBackgroundTextColor.Value;
end;

function TdxSkinLookAndFeelPainter.DefaultHeaderColor: TColor;
begin
  with SkinInfo do
    if Header = nil then
      Result := inherited DefaultHeaderColor
    else
      Result := Header.Color;
end;

function TdxSkinLookAndFeelPainter.DefaultHeaderTextColor: TColor;
begin
  with SkinInfo do
    if Header = nil then
      Result := inherited DefaultHeaderTextColor
    else
      Result := Header.TextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultHyperlinkTextColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(HyperLinkTextColor) then
      Result := HyperLinkTextColor.Value
    else
      Result := inherited DefaultHyperlinkTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultPreviewTextColor: TColor;
begin
  Result := DefaultHyperlinkTextColor;
end;

function TdxSkinLookAndFeelPainter.LayoutControlEmptyAreaColor: TColor;
begin
  with SkinInfo do
    if LayoutControlColor = nil then
      Result := inherited LayoutControlEmptyAreaColor
    else
      Result := LayoutControlColor.Value;
end;

procedure TdxSkinLookAndFeelPainter.DrawLayoutControlBackground(
  ACanvas: TcxCanvas; const R: TRect);
begin
  ACanvas.FillRect(R, LayoutControlEmptyAreaColor);
end;

procedure TdxSkinLookAndFeelPainter.DrawEditPopupWindowBorder(ACanvas: TcxCanvas; var R: TRect;
  ABorderStyle: TcxEditPopupBorderStyle; AClientEdge: Boolean);
begin
  ACanvas.FrameRect(R, GetContainerBorderColor(False));
  InflateRect(R, -1, -1);
end;

function TdxSkinLookAndFeelPainter.GetEditPopupWindowBorderWidth(AStyle: TcxEditPopupBorderStyle): Integer;
begin
  Result := 1;
end;

function TdxSkinLookAndFeelPainter.GetEditPopupWindowClientEdgeWidth(AStyle: TcxEditPopupBorderStyle): Integer;
begin
  Result := 2;
end;

function TdxSkinLookAndFeelPainter.DefaultSelectionColor: TColor;
begin
  with SkinInfo do
    if SelectionColor = nil then
      Result := inherited DefaultSelectionColor
    else
      Result := SelectionColor.Value;
end;

function TdxSkinLookAndFeelPainter.DefaultSchedulerTimeRulerColor: TColor;
begin
  with SkinInfo do
    if Assigned(SchedulerTimeRuler) and IsColorAssigned(SchedulerTimeRuler.Color) then
      Result := SchedulerTimeRuler.Color
    else
      Result := inherited DefaultSchedulerTimeRulerColor;
end;

function TdxSkinLookAndFeelPainter.DefaultSchedulerTimeRulerTextColor: TColor;
begin
  with SkinInfo do
    if Assigned(SchedulerTimeRuler) and IsColorAssigned(SchedulerTimeRuler.TextColor) then
      Result := SchedulerTimeRuler.TextColor
    else
      Result := inherited DefaultSchedulerTimeRulerTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultSelectionTextColor: TColor;
begin
  with SkinInfo do
    if SelectionTextColor = nil then
      Result := inherited DefaultSelectionTextColor
    else
      Result := SelectionTextColor.Value;  
end;

function TdxSkinLookAndFeelPainter.DefaultSeparatorColor: TColor;
begin
  with SkinInfo do
    if CardViewSeparator = nil then
      Result := inherited DefaultSeparatorColor
    else
      Result := CardViewSeparator.Color;
end;

function TdxSkinLookAndFeelPainter.DefaultSchedulerBackgroundColor: TColor;
begin
  with SkinInfo do
    if ContentColor = nil then
      Result := inherited DefaultSchedulerBackgroundColor
    else
      Result := ContentColor.Value;
end;

function TdxSkinLookAndFeelPainter.DefaultSchedulerBorderColor: TColor;
begin
  with SkinInfo do
    if ContainerBorderColor = nil then
      Result := inherited DefaultSchedulerBorderColor
    else
      Result := ContainerBorderColor.Value;
end;

function TdxSkinLookAndFeelPainter.DefaultSchedulerControlColor: TColor;
begin
  with SkinInfo do
    if ContentColor = nil then
      Result := inherited DefaultSchedulerControlColor
    else
      Result := ContentColor.Value;
end;

function TdxSkinLookAndFeelPainter.DefaultSchedulerNavigatorColor: TColor;
begin
  with SkinInfo do
    if SchedulerNavigatorColor = nil then
      Result := inherited DefaultSchedulerNavigatorColor
    else
      Result := SchedulerNavigatorColor.Value;
end;

function TdxSkinLookAndFeelPainter.DefaultSchedulerViewSelectedTextColor: TColor;
begin
  Result := DefaultSchedulerViewTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultSchedulerViewTextColor: TColor;
begin
  with SkinInfo do
    if SchedulerAppointment[True] = nil then
      Result := inherited DefaultSchedulerViewTextColor
    else
      Result := SchedulerAppointment[True].TextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultSizeGripAreaColor: TColor;
begin
  Result := clDefault;
  with SkinInfo do
    if FormContent <> nil then
      Result := FormContent.Color;
  if Result = clDefault then
    Result := inherited DefaultSizeGripAreaColor; 
end;

function TdxSkinLookAndFeelPainter.DefaultTimeGridMajorScaleTextColor: TColor;
begin
  with SkinInfo do
    if (SchedulerTimeGridHeader[False] <> nil) and
      IsColorAssigned(SchedulerTimeGridHeader[False].TextColor)
    then
      Result := SchedulerTimeGridHeader[False].TextColor
    else
      Result := inherited DefaultTimeGridMajorScaleTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultTimeGridMinorScaleTextColor: TColor;
begin
  Result := DefaultTimeGridMajorScaleTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultRecordSeparatorColor: TColor;
begin
  with SkinInfo do
    if GridFixedLine = nil then
      Result := inherited DefaultRecordSeparatorColor
    else
      Result := GridFixedLine.Color;
end;

function TdxSkinLookAndFeelPainter.DefaultDateNavigatorHeaderColor: TColor;
begin
  Result := DefaultHeaderColor;
end;

function TdxSkinLookAndFeelPainter.DefaultDateNavigatorHeaderTextColor(
  AIsHighlight: Boolean): TColor;
begin
  Result := DefaultHeaderTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultDateNavigatorTextColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(CalendarDayTextColor) then
      Result := CalendarDayTextColor.Value
    else
      Result := inherited DefaultDateNavigatorTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultDateNavigatorHolydayTextColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(CalendarHolidayTextColor) then
      Result := CalendarHolidayTextColor.Value
    else
      Result := inherited DefaultDateNavigatorHolydayTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultDateNavigatorInactiveTextColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(CalendarInactiveDayTextColor) then
      Result := CalendarInactiveDayTextColor.Value
    else
      Result := inherited DefaultDateNavigatorInactiveTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultDateNavigatorSelectionColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(CalendarSelectedDayColor) then
      Result := CalendarSelectedDayColor.Value
    else
      Result := inherited DefaultDateNavigatorSelectionColor;
end;

function TdxSkinLookAndFeelPainter.DefaultDateNavigatorSelectionTextColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(CalendarSelectedDayTextColor) then
      Result := CalendarSelectedDayTextColor.Value
    else
      Result := inherited DefaultDateNavigatorSelectionTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultDateNavigatorSeparator1Color: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(CalendarSeparatorColor) then
      Result := CalendarSeparatorColor.Value
    else
      Result := inherited DefaultDateNavigatorSeparator1Color;
end;

function TdxSkinLookAndFeelPainter.DefaultDateNavigatorSeparator2Color: TColor;
begin
  Result := clNone;
end;

function TdxSkinLookAndFeelPainter.DefaultDateNavigatorTodayFrameColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(CalendarTodayFrameColor) then
      Result := CalendarTodayFrameColor.Value
    else
      Result := inherited DefaultDateNavigatorTodayFrameColor;
end;

function TdxSkinLookAndFeelPainter.DefaultDateNavigatorTodayTextColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(CalendarTodayTextColor) then
      Result := CalendarTodayTextColor.Value
    else
      Result := inherited DefaultDateNavigatorTodayTextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultVGridBandLineColor: TColor;
begin
  with SkinInfo do
  begin
    if VGridLine[True] = nil then
      Result := inherited DefaultVGridBandLineColor
    else
      Result := VGridLine[True].Color;
  end;
end;

function TdxSkinLookAndFeelPainter.DefaultVGridCategoryColor: TColor;
begin
  with SkinInfo do
    if VGridCategory = nil then
      Result := inherited DefaultVGridCategoryColor
    else
      Result := VGridCategory.Color;
end;

function TdxSkinLookAndFeelPainter.DefaultVGridCategoryTextColor: TColor;
begin
  with SkinInfo do
    if VGridCategory = nil then
      Result := inherited DefaultVGridCategoryTextColor
    else
      Result := VGridCategory.TextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultVGridHeaderColor: TColor;
begin
  with SkinInfo do
    if VGridRowHeader = nil then
      Result := inherited DefaultVGridHeaderColor
    else
      Result := VGridRowHeader.Color;
end;

function TdxSkinLookAndFeelPainter.DefaultVGridHeaderTextColor: TColor;
begin
  with SkinInfo do
    if VGridRowHeader = nil then
      Result := inherited DefaultVGridHeaderTextColor
    else
      Result := VGridRowHeader.TextColor;
end;

function TdxSkinLookAndFeelPainter.DefaultVGridLineColor: TColor;
begin
  with SkinInfo do
  begin
    if VGridLine[False] = nil then
      Result := inherited DefaultVGridLineColor
    else
      Result := VGridLine[False].Color;
  end;
end;

procedure TdxSkinLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  if SkinInfo.ContainerBorderColor = nil then
    inherited DrawBorder(ACanvas, R)
  else
    ACanvas.FrameRect(R, SkinInfo.ContainerBorderColor.Value);
end;

procedure TdxSkinLookAndFeelPainter.DrawContainerBorder(ACanvas: TcxCanvas; const R: TRect; AStyle: TcxContainerBorderStyle;
  AWidth: Integer; AColor: TColor; ABorders: TcxBorders);
begin
  inherited DrawContainerBorder(ACanvas, R, cbsSingle, AWidth, AColor, ABorders);
end;

procedure TdxSkinLookAndFeelPainter.DrawSeparator(ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean);
begin
  DrawLabelLine(ACanvas, GetSeparatorBounds(R, 2, AIsVertical), clDefault, clDefault, AIsVertical);
end;

function TdxSkinLookAndFeelPainter.AdjustGroupButtonDisplayRect(
  const R: TRect; AButtonCount, AButtonIndex: Integer): TRect;
begin
  Result := inherited AdjustGroupButtonDisplayRect(R, AButtonCount, AButtonIndex);
end;

function TdxSkinLookAndFeelPainter.ButtonBorderSize(
  AState: TcxButtonState = cxbsNormal): Integer;
begin
  if SkinInfo.ButtonElements <> nil then
    Result := 0
  else
    Result := inherited ButtonBorderSize(AState);
end;

function TdxSkinLookAndFeelPainter.ButtonColor(
  AState: TcxButtonState): TColor;
begin
  Result := inherited ButtonColor(AState);
end;

function TdxSkinLookAndFeelPainter.ButtonFocusRect(
  ACanvas: TcxCanvas; R: TRect): TRect;
begin
  Result := inherited ButtonFocusRect(ACanvas, R);
end;

function TdxSkinLookAndFeelPainter.ButtonGroupBorderSizes(
  AButtonCount, AButtonIndex: Integer): TRect;
var
  AGlyphSize: TSize;
  AXOffset: Integer;
  AYOffset: Integer;
begin
  with SkinInfo do
  begin
    if EditButtonElements[False] <> nil then
    begin
      AGlyphSize := NavigatorGlyphSize;
      AXOffset := (EditButtonElements[False].Size.cx - AGlyphSize.cx) div 2;
      AYOffset := (EditButtonElements[False].Size.cy - AGlyphSize.cy) div 2;
      Result := Rect(AXOffset, AYOffset, AXOffset, AYOffset);
    end
    else
      Result := inherited ButtonGroupBorderSizes(AButtonCount, AButtonIndex);
  end;
end;

function TdxSkinLookAndFeelPainter.ButtonSymbolColor(
  AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
begin
  with SkinInfo do
    if ButtonElements = nil then
      Result := inherited ButtonSymbolColor(AState, ADefaultColor)
    else
      if (AState = cxbsDisabled) and (ButtonDisabled <> nil) then
        Result := ButtonDisabled.Value
      else
        Result := ButtonElements.TextColor;
end;

function TdxSkinLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := inherited ButtonTextOffset;
end;

function TdxSkinLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := inherited ButtonTextShift;
end;

procedure TdxSkinLookAndFeelPainter.DrawButton(ACanvas: TcxCanvas;
  R: TRect; const ACaption: string; AState: TcxButtonState; ADrawBorder: Boolean = True;
  AColor: TColor = clDefault; ATextColor: TColor = clDefault;
  AWordWrap: Boolean = False; AIsToolButton: Boolean = False);
var
  AFlags: Integer;
begin
  with ACanvas, SkinInfo do
    if ButtonElements <> nil then
    begin
      ButtonElements.Draw(ACanvas.Handle, R, 0, ButtonStateToSkinState[AState]);
      R := cxRectContent(R, ButtonElements.ContentOffset.Rect);
      if ATextColor = clDefault then
        Font.Color := ButtonSymbolColor(AState)
      else
        Font.Color := ATextColor;
      Brush.Style := bsClear;
      with R do // for compatible with standard buttons
      begin
        Dec(Bottom, Ord(Odd(Bottom - Top)));
        if (Bottom - Top) < 18 then Dec(Top);
      end;
      if AState = cxbsPressed then
        OffsetRect(R, ButtonTextShift, ButtonTextShift);
      if Length(ACaption) > 0 then
      begin
        AFlags := cxAlignVCenter or cxShowPrefix or cxAlignHCenter;
        if AWordWrap then
          AFlags := AFlags or cxWordBreak
        else
          AFlags := AFlags or cxSingleLine;
        DrawText(ACaption, R, AFlags, AState <> cxbsDisabled);
      end;
      Brush.Style := bsSolid;
    end
    else
      inherited DrawButton(ACanvas, R, ACaption, AState, ADrawBorder, AColor,
        ATextColor, AWordWrap);
end;

procedure TdxSkinLookAndFeelPainter.DrawButtonGroupBorder(ACanvas: TcxCanvas;
  R: TRect; AInplace, ASelected: Boolean);
begin
end;

procedure TdxSkinLookAndFeelPainter.DrawButtonInGroup(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
  ABackgroundColor: TColor);
begin
  DrawEditorButton(ACanvas, R, cxbkEditorBtn, AState);
end;

procedure TdxSkinLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
begin
  with SkinInfo do
  begin
    if ExpandButton = nil then
      inherited DrawExpandButton(ACanvas, R, AExpanded, AColor)
    else
      ExpandButton.Draw(ACanvas.Handle, R, Byte(AExpanded));
  end;
end;

procedure TdxSkinLookAndFeelPainter.DrawExpandButtonEx(
  ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0);
begin
  DrawExpandButton(ACanvas, R, AExpanded);
end;

function TdxSkinLookAndFeelPainter.DrawExpandButtonFirst: Boolean;
begin
  Result := inherited DrawExpandButtonFirst;
end;

procedure TdxSkinLookAndFeelPainter.DrawGroupExpandButton(
  ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AState: TcxButtonState);
begin
  inherited DrawGroupExpandButton(ACanvas,R, AExpanded, AState);
end;

procedure TdxSkinLookAndFeelPainter.DrawSmallExpandButton(
  ACanvas: TcxCanvas; R: TRect; AExpanded: Boolean;
  ABorderColor: TColor; AColor: TColor = clDefault);
begin
  with SkinInfo do
  begin
    if ExpandButton = nil then
      inherited DrawSmallExpandButton(ACanvas, R, AExpanded, ABorderColor, AColor)
    else
      ExpandButton.Draw(ACanvas.Handle, R, Byte(AExpanded));
  end; 
end;

function TdxSkinLookAndFeelPainter.ExpandButtonSize: Integer;
begin
  with SkinInfo do
  begin
    if ExpandButton = nil then
      Result := inherited ExpandButtonSize
    else
      Result := ExpandButton.Size.cy;  
  end;
end;

function TdxSkinLookAndFeelPainter.GroupExpandButtonSize: Integer;
begin
  Result := inherited GroupExpandButtonSize;
end;

function TdxSkinLookAndFeelPainter.SmallExpandButtonSize: Integer;
begin
  Result := inherited SmallExpandButtonSize;
end;

function TdxSkinLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := inherited IsButtonHotTrack;
end;

function TdxSkinLookAndFeelPainter.IsPointOverGroupExpandButton(
  const R: TRect; const P: TPoint): Boolean;
begin
  Result := inherited IsPointOverGroupExpandButton(R, P);
end;

function TdxSkinLookAndFeelPainter.ScrollBarMinimalThumbSize(AVertical: Boolean): Integer;
var
  AInfo: TdxSkinScrollInfo;
begin
  AInfo := SkinInfo.ScrollBar_Elements[not AVertical, sbpThumbnail];
  if (AInfo = nil) or (AInfo.Element = nil) then
    Result := inherited ScrollBarMinimalThumbSize(AVertical)
  else
    if AVertical then
      Result := AInfo.Element.Size.cy
    else
      Result := AInfo.Element.Size.cx;
end;

procedure TdxSkinLookAndFeelPainter.DrawScrollBarBackground(
  ACanvas: TcxCanvas; const R: TRect; AHorizontal: Boolean);
var
  AScrollInfoElement: TdxSkinScrollInfo;
begin
  AScrollInfoElement := SkinInfo.ScrollBar_Elements[AHorizontal, sbpPageUp];
  if (AScrollInfoElement = nil) or (AScrollInfoElement.Element = nil) then
    inherited DrawScrollBarBackground(ACanvas, R, AHorizontal)
  else
  begin
    AScrollInfoElement.Element.UseCache := True;
    AScrollInfoElement.Element.Draw(ACanvas.Handle, R);
  end;
end;

procedure TdxSkinLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
var
  AScrollPartInfo: TdxSkinScrollInfo;
begin
  AScrollPartInfo := SkinInfo.ScrollBar_Elements[AHorizontal, APart];
  if (AScrollPartInfo = nil) or (AScrollPartInfo.Element = nil) then
    inherited DrawScrollBarPart(ACanvas, AHorizontal, R, APart, AState)
  else
    if not ((APart in [sbpPageUp, sbpPageDown]) and (AState = cxbsNormal)) then
      AScrollPartInfo.Draw(ACanvas.Handle, R, ButtonStateToSkinState[AState]);
end;

procedure TdxSkinLookAndFeelPainter.DrawLabelLine(ACanvas: TcxCanvas;
  const R: TRect; AOuterColor, AInnerColor: TColor; AIsVertical: Boolean);
begin
  with SkinInfo do
    if LabelLine[AIsVertical] = nil then
      inherited DrawLabelLine(ACanvas, R, AOuterColor, AInnerColor, AIsVertical)
    else
      LabelLine[AIsVertical].Draw(ACanvas.Handle, R);
end;

function TdxSkinLookAndFeelPainter.LabelLineHeight: Integer;
begin
  with SkinInfo do
    if LabelLine[False] = nil then
      Result := inherited LabelLineHeight
    else
      Result := LabelLine[False].MinSize.Height;
end;

function TdxSkinLookAndFeelPainter.SizeGripSize: TSize;
begin
  with SkinInfo do
    if SizeGrip = nil then
      Result := inherited SizeGripSize
    else
      Result := SizeGrip.Size
end;

procedure TdxSkinLookAndFeelPainter.DoDrawSizeGrip(ACanvas: TcxCanvas; const ARect: TRect);
begin
  with SkinInfo do
    if SizeGrip = nil then
      inherited DoDrawSizeGrip(ACanvas, ARect)
    else
      SizeGrip.Draw(ACanvas.Handle, ARect);
end;

function TdxSkinLookAndFeelPainter.SmallCloseButtonSize: TSize;
begin
  with SkinInfo do
    if PageControlCloseButton = nil then
      Result := inherited SmallCloseButtonSize
    else
      Result := PageControlCloseButton.MinSize.Size;
end;

procedure TdxSkinLookAndFeelPainter.DrawSmallCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  with SkinInfo do
    if PageControlCloseButton = nil then
      inherited DrawSmallCloseButton(ACanvas, R, AState)
    else
      PageControlCloseButton.Draw(ACanvas.Handle, R, 0, ButtonStateToSkinState[AState]);
end;

procedure TdxSkinLookAndFeelPainter.DrawRadioButton(ACanvas: TcxCanvas;
  X, Y: Integer; AButtonState: TcxButtonState; AChecked, AFocused: Boolean;
  ABrushColor: TColor;  AIsDesigning: Boolean = False);
var
  ADestRect: TRect;
begin
  with SkinInfo do
  begin
    if RadioGroupButton <> nil then
    begin
      ADestRect := Rect(X, Y, X + RadioGroupButton.Size.cX, Y + RadioGroupButton.Size.cy);
      if ABrushColor <> clDefault then
        ACanvas.FillRect(ADestRect, ABrushColor);
      RadioGroupButton.Draw(ACanvas.Handle, ADestRect, Byte(AChecked),
        ButtonStateToSkinState[AButtonState]);
    end
    else
      inherited DrawRadioButton(ACanvas, X, Y, AButtonState, AChecked, AFocused,
        ABrushColor, AIsDesigning);
  end;      
end;

function TdxSkinLookAndFeelPainter.RadioButtonSize: TSize;
begin
  with SkinInfo do
    if RadioGroupButton <> nil then
      Result := RadioGroupButton.Size
    else
      Result := inherited RadioButtonSize;
end;

function TdxSkinLookAndFeelPainter.CheckButtonSize: TSize;
begin
  with SkinInfo do
    if CheckboxElement <> nil then
      Result := CheckboxElement.Size
    else
      Result := inherited CheckButtonSize;
end;

function TdxSkinLookAndFeelPainter.CalcEditButtonTextColor(
  AButtonKind: TcxCalcButtonKind): TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(CalcEditButtonTextColors[AButtonKind]) then
      Result := CalcEditButtonTextColors[AButtonKind].Value
    else
      Result := inherited CalcEditButtonTextColor(AButtonKind);
end;

function TdxSkinLookAndFeelPainter.GetCustomizationFormListBackgroundColor: TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(ContentColor) then
      Result := ContentColor.Value
    else
      Result := inherited GetCustomizationFormListBackgroundColor;
end;

procedure TdxSkinLookAndFeelPainter.DrawCheckButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; ACheckState: TcxCheckBoxState);
const
  ImageIndexMap: array[TcxCheckBoxState] of Integer = (0, 1, 2);
begin
  with SkinInfo do
    if CheckboxElement = nil then
      inherited DrawCheckButton(ACanvas, R, AState, ACheckState)
    else
      CheckboxElement.Draw(ACanvas.Handle, R, ImageIndexMap[ACheckState],
        ButtonStateToSkinState[AState]);
end;

procedure TdxSkinLookAndFeelPainter.DrawClock(ACanvas: TcxCanvas;
  const ARect: TRect; ADateTime: TDateTime; ABackgroundColor: TColor);

  procedure DrawHand(ACanvas: TCanvas; ACenter: TPoint;
    AAngle, L1X, L1Y, L2X, L2Y, L3: Extended; AHandColor: TColor);
  begin
    with ACanvas do
    begin
      Brush.Color := AHandColor;
      BeginPath(Handle);
      Pixels[Round(ACenter.X + L1X * cos(AAngle)),
        Round(ACenter.Y + L1Y * sin(AAngle))] := clTeal;
      Pen.Color := clTeal;
      MoveTo(Round(ACenter.X + L1X * cos(AAngle)),
        Round(ACenter.Y + L1Y * sin(AAngle)));
      LineTo(Round(ACenter.X + L3 / 2 * cos(AAngle + Pi / 2)),
        Round(ACenter.Y + L3 / 2 * sin(AAngle + Pi / 2)));
      LineTo(Round(ACenter.X + L2X * cos(AAngle + Pi)),
        Round(ACenter.Y + L2Y * sin(AAngle + Pi)));
      LineTo(Round(ACenter.X + L3 / 2 * cos(AAngle + Pi * 3 / 2)),
        Round(ACenter.Y + L3 / 2 * sin(AAngle + Pi * 3 / 2)));
      LineTo(Round(ACenter.X + L1X * cos(AAngle)),
        Round(ACenter.Y + L1Y * sin(AAngle)));
      EndPath(Handle);
      FillPath(Handle);
    end;
  end;

  procedure DrawHands(ACanvas: TCanvas; AHandColor: TColor);
  var
    AAngle: Extended;
    ACenter: TPoint;
    AHandRadiusX, AHandRadiusY: Extended;
    AHour, AMin, AMSec, ASec: Word;
  begin
    DecodeTime(ADateTime, AHour, AMin, ASec, AMSec);
    ACenter.X := (ARect.Right + ARect.Left) div 2;
    ACenter.Y := (ARect.Bottom + ARect.Top) div 2;
    AHandRadiusX := (ARect.Right - ARect.Left) / 2 - 2;
    AHandRadiusY := (ARect.Bottom - ARect.Top) / 2 - 2;
    with ACanvas do
    begin
      AAngle := Pi * 2 * ((AHour mod 12) * 60 * 60 + AMin * 60 + ASec - 3 * 60 * 60) / 12 / 60 / 60;
      DrawHand(ACanvas, ACenter, AAngle, AHandRadiusX * 0.75, AHandRadiusY * 0.75,
        AHandRadiusX * 0.15, AHandRadiusY * 0.15, 9, AHandColor);

      AAngle := Pi * 2 * (AMin * 60 + ASec - 15 * 60) / 60 / 60;
      DrawHand(ACanvas, ACenter, AAngle, AHandRadiusX * 0.85, AHandRadiusY * 0.85,
        AHandRadiusX * 0.2, AHandRadiusY * 0.2, 7, AHandColor);

      Pen.Color := AHandColor;
      MoveTo(ACenter.X, ACenter.Y);
      AAngle := Pi * 2 * (ASec - 15) / 60;
      LineTo(Round(ACenter.X + AHandRadiusX * 0.9 * cos(AAngle)),
        Round(ACenter.Y + AHandRadiusY * 0.9 * sin(AAngle)));
    end;
  end;

var
  ABitmap: TBitmap;  
begin
  with SkinInfo do
    if (ClockElements[False] = nil) or (ClockElements[True] = nil) then
      inherited DrawClock(ACanvas, ARect, ADateTime, ABackgroundColor)
    else
      begin
        ABitmap := TBitmap.Create;
        try
          ABitmap.Width := ARect.Right - ARect.Left;
          ABitmap.Height := ARect.Bottom - ARect.Top;
          ABitmap.Canvas.Brush.Color := ABackgroundColor;
          ABitmap.Canvas.FillRect(ARect);
          ClockElements[False].Draw(ABitmap.Canvas.Handle, ARect);
          DrawHands(ABitmap.Canvas, ClockElements[False].TextColor);
          ClockElements[True].Draw(ABitmap.Canvas.Handle, ARect);
          with ARect do
            BitBlt(ACanvas.Handle, Left, Top, Right - Left, Bottom - Top,
              ABitmap.Canvas.Handle, 0, 0, SRCCOPY);
        finally
          ABitmap.Free;
        end;
      end;
end;

procedure TdxSkinLookAndFeelPainter.DrawEditorButton(ACanvas: TcxCanvas;
  const ARect: TRect; AButtonKind: TcxEditBtnKind; AState: TcxButtonState;
  APosition: TcxEditBtnPosition = cxbpRight);

  procedure DrawEllipsis(R: TRect; ASize: Integer);
  var
    AColor: TColor;
  begin
    R := cxRectCenter(R, 3 * ASize + 4, ASize);
    AColor := SkinInfo.EditButtonElements[False].TextColor;
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Left + ASize, R.Top + ASize), AColor);
    ACanvas.FillRect(Rect(R.Left + ASize + 2, R.Top, R.Left + ASize * 2 + 2, R.Top + ASize), AColor);
    ACanvas.FillRect(Rect(R.Left + ASize * 2 + 4, R.Top, R.Left + ASize * 3 + 4, R.Top + ASize), AColor);
  end;

  function GetGlyphRect(const R: TRect; AElement: TdxSkinElement): TRect;
  begin
    Result := cxRectContent(R, AElement.ContentOffset.Rect);
    if SkinInfo.EditButtonMergeBorders then
    begin
      if APosition = cxbpLeft then
        Dec(Result.Left, AElement.ContentOffset.Left - 1)
      else
        Inc(Result.Right, AElement.ContentOffset.Right - 1);
    end;
  end;

const
  EllipseSizeMap: array[Boolean] of Integer = (1, 2);
var
  AElement: TdxSkinElement;
  R: TRect;
begin
  if (SkinInfo.EditButtonElements[True] = nil) or (SkinInfo.EditButtonElements[False] = nil) then
    inherited DrawEditorButton(ACanvas, ARect, AButtonKind, AState, APosition)
  else
  begin
    ACanvas.SaveClipRegion;
    try
      R := ARect;
      ACanvas.IntersectClipRect(ARect);
      AElement := SkinInfo.EditButtonElements[AButtonKind = cxbkCloseBtn];
      if SkinInfo.EditButtonMergeBorders then
      begin
        InflateRect(R, 0, 1);
        if APosition = cxbpLeft then
          Dec(R.Left)
        else
          Inc(R.Right);
      end;
      AElement.Draw(ACanvas.Handle, R, 0, ButtonStateToSkinState[AState]);

      R := GetGlyphRect(R, AElement);
      if AButtonKind = cxbkEllipsisBtn then
        DrawEllipsis(R, EllipseSizeMap[cxRectWidth(R) >= 12])
      else
        if SkinInfo.EditButtonGlyphs[AButtonKind] <> nil then
          SkinInfo.EditButtonGlyphs[AButtonKind].Glyph.Draw(ACanvas.Handle, R);
   finally
      ACanvas.RestoreClipRegion;
    end;
  end;
end;

function TdxSkinLookAndFeelPainter.EditButtonTextOffset: Integer;
begin
  Result := 1;
end;

function TdxSkinLookAndFeelPainter.EditButtonSize: TSize;
begin
  if SkinInfo.EditButtonElements[False] = nil then
    Result := inherited EditButtonSize
  else
    Result := SkinInfo.EditButtonElements[False].Size;
end;

function TdxSkinLookAndFeelPainter.EditButtonTextColor: TColor;
begin
  with SkinInfo do
    if EditButtonElements[False] = nil then
      Result := inherited EditButtonTextColor
    else
      Result := EditButtonElements[False].TextColor;
end;

function TdxSkinLookAndFeelPainter.GetContainerBorderColor(
  AIsHighlightBorder: Boolean): TColor;
var
  ASkinColor: TdxSkinColor;
begin
  with SkinInfo do
  begin
    if AIsHighlightBorder then
      ASkinColor := ContainerHighlightBorderColor
    else
      ASkinColor := ContainerBorderColor;
    if ASkinColor = nil then
      Result := inherited GetContainerBorderColor(AIsHighlightBorder)
    else
      Result := ASkinColor.Value;
  end;
end;

function TdxSkinLookAndFeelPainter.GetContainerBorderWidth(ABorderStyle: TcxContainerBorderStyle): Integer;
const
  BordersWidthMap: array [Boolean] of Integer = (1, cxContainerMaxBorderWidth);
begin
  if ABorderStyle = cbsNone then
    Result := inherited GetContainerBorderWidth(ABorderStyle)
  else
    Result := BordersWidthMap[ABorderStyle = cbsThick];
end;

procedure TdxSkinLookAndFeelPainter.DrawNavigatorGlyph(
  ACanvas: TcxCanvas; AImageList: TCustomImageList; AImageIndex: TImageIndex;
  AButtonIndex: Integer; const AGlyphRect: TRect; AEnabled, AUserGlyphs: Boolean);
var
  ABitmap: TcxAlphaBitmap;
  AElement: TdxSkinElement;
begin
  with SkinInfo do
    if (NavigatorGlyphs = nil) or (NavigatorGlyphsVert = nil) or AUserGlyphs then
      inherited DrawNavigatorGlyph(ACanvas, AImageList, AImageIndex,
        AButtonIndex, AGlyphRect, AEnabled, AUserGlyphs)
    else
      if not IsRectEmpty(AGlyphRect) then
      begin
        AElement := NavigatorGlyphs;
        if NavigatorGlyphs.ImageCount <= AImageIndex then
        begin
          AElement := NavigatorGlyphsVert;
          Dec(AImageIndex, NavigatorGlyphs.ImageCount);
        end;

        if AEnabled then
          AElement.Draw(ACanvas.Handle, AGlyphRect, AImageIndex)
        else
        begin
          ABitmap := TcxAlphaBitmap.CreateSize(AGlyphRect, True);
          try
            AElement.Draw(ABitmap.Canvas.Handle, ABitmap.ClientRect, AImageIndex);
            dxSkinElementMakeDisable(ABitmap);
            cxAlphaBlend(ACanvas.Handle, ABitmap, AGlyphRect, ABitmap.ClientRect);
          finally
            ABitmap.Free;
          end;
        end;
      end;
end;

function TdxSkinLookAndFeelPainter.NavigatorGlyphSize: TSize;
begin
  with SkinInfo do
    if NavigatorGlyphs = nil then
      Result := inherited NavigatorGlyphSize
    else
      Result := NavigatorGlyphs.Size;
end;

procedure TdxSkinLookAndFeelPainter.DrawProgressBarBorder(ACanvas: TcxCanvas;
  ARect: TRect; AVertical: Boolean);
begin
  with SkinInfo do
    if ProgressBarElements[False, AVertical] <> nil then
      ProgressBarElements[False, AVertical].Draw(ACanvas.Handle, ARect)
    else
      inherited DrawProgressBarBorder(ACanvas, ARect, AVertical);
end;

procedure TdxSkinLookAndFeelPainter.DrawProgressBarChunk(
  ACanvas: TcxCanvas; ARect: TRect; AVertical: Boolean);
begin
  with SkinInfo do
    if ProgressBarElements[True, AVertical] <> nil then
      ProgressBarElements[True, AVertical].Draw(ACanvas.Handle, ARect)
    else
      inherited DrawProgressBarChunk(ACanvas, ARect, AVertical);
end;

function TdxSkinLookAndFeelPainter.ProgressBarBorderSize(AVertical: Boolean): TRect;
begin
  with SkinInfo do
    if ProgressBarElements[False, AVertical] <> nil then
      Result := ProgressBarElements[False, AVertical].ContentOffset.Rect
    else
      Result := inherited ProgressBarBorderSize(AVertical);
end;

function TdxSkinLookAndFeelPainter.ProgressBarTextColorEx(AIsFilledArea: Boolean): TColor;
begin
  with SkinInfo do
    if IsColorPropertyAssigned(ProgressBarTextColors[AIsFilledArea]) then
      Result := ProgressBarTextColors[AIsFilledArea].Value
    else
      Result := inherited ProgressBarTextColorEx(AIsFilledArea);
end;

function TdxSkinLookAndFeelPainter.GroupBoxBorderSize(
  ACaption: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TRect;
var
  AGroupBoxInfo: TdxSkinElement;
begin
  with SkinInfo do
    if ACaption then
      AGroupBoxInfo := GroupBoxCaptionElements[ACaptionPosition]
    else
      AGroupBoxInfo := GroupBoxElements[ACaptionPosition];

  if AGroupBoxInfo = nil then
    Result := inherited GroupBoxBorderSize(ACaption, ACaptionPosition)
  else
    Result := AGroupBoxInfo.ContentOffset.Rect;
end;

procedure TdxSkinLookAndFeelPainter.DrawGroupBoxFrame(ACanvas: TcxCanvas;
  R: TRect; AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition;
  ABorders: TcxBorders = cxBordersAll); 
begin
  DrawGroupBoxContent(ACanvas, R, ACaptionPosition, ABorders);
end;

function TdxSkinLookAndFeelPainter.GroupBoxTextColor(
  AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TColor;
var
  AGroupBoxCaption: TdxSkinElement;
begin
  if ACaptionPosition = cxgpCenter then
    Result := PanelTextColor
  else
  begin
    AGroupBoxCaption := SkinInfo.GroupBoxCaptionElements[ACaptionPosition];
    if AGroupBoxCaption = nil then
      Result := inherited GroupBoxTextColor(AEnabled, ACaptionPosition)
    else
      Result := AGroupBoxCaption.TextColor;
  end;
end;

function TdxSkinLookAndFeelPainter.PanelTextColor: TColor;
begin
  with SkinInfo do
    if GroupBoxClient = nil then
      Result := inherited PanelTextColor
    else
      Result := GroupBoxClient.TextColor;
end;

function TdxSkinLookAndFeelPainter.IsGroupBoxTransparent(
  AIsCaption: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): Boolean;
var
  AGroupBoxInfo: TdxSkinElement;
begin
  with SkinInfo do
    if AIsCaption then
      AGroupBoxInfo := GroupBoxCaptionElements[ACaptionPosition]
    else
      AGroupBoxInfo := GroupBoxElements[ACaptionPosition];

  if AGroupBoxInfo = nil then
    Result := inherited IsGroupBoxTransparent(AIsCaption, ACaptionPosition)
  else
    Result := AGroupBoxInfo.IsAlphaUsed;
end;

procedure TdxSkinLookAndFeelPainter.DrawGroupBoxCaption(ACanvas: TcxCanvas;
  ACaptionRect: TRect; ACaptionPosition: TcxGroupBoxCaptionPosition);
begin
  with SkinInfo do
    if GroupBoxCaptionElements[ACaptionPosition] = nil then
      inherited DrawGroupBoxCaption(ACanvas, ACaptionRect, ACaptionPosition)
    else
      GroupBoxCaptionElements[ACaptionPosition].Draw(ACanvas.Handle, ACaptionRect);
end;

procedure TdxSkinLookAndFeelPainter.DrawGroupBoxContent(ACanvas: TcxCanvas;
  ABorderRect: TRect; ACaptionPosition: TcxGroupBoxCaptionPosition;
  ABorders: TcxBorders = cxBordersAll);
var
  ARect: TRect;
begin
  with SkinInfo do
    if (GroupBoxElements[ACaptionPosition] = nil) or (GroupBoxClient = nil) then
      inherited DrawGroupBoxContent(ACanvas, ABorderRect, ACaptionPosition)
    else
      if not IsRectEmpty(ABorderRect) then
      begin
        ARect := ABorderRect;
        ACanvas.SaveClipRegion;
        try
          ACanvas.IntersectClipRect(ABorderRect);
          with GroupBoxElements[ACaptionPosition] do
          begin
            if bLeft in ABorders then
              Inc(ARect.Left, ContentOffset.Left + Borders[bLeft].Thin);
            if bTop in ABorders then
              Inc(ARect.Top, ContentOffset.Top + Borders[bTop].Thin);
            if bRight in ABorders then
              Dec(ARect.Right, ContentOffset.Right + Borders[bRight].Thin);
            if bBottom in ABorders then
              Dec(ARect.Bottom, ContentOffset.Bottom + Borders[bBottom].Thin);
          end;
          GroupBoxClient.Draw(ACanvas.Handle, ARect);
          ACanvas.ExcludeClipRect(ARect);
          GroupBoxElements[ACaptionPosition].Draw(ACanvas.Handle, ABorderRect);
        finally
          ACanvas.RestoreClipRegion;
        end;
      end;
end;

procedure TdxSkinLookAndFeelPainter.DrawGroupBoxExpandButton(
  ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0);

  procedure DoDrawGroupBoxExpandButton(ACanvas: TcxCanvas; const R: TRect);
  begin
    with SkinInfo do
      if GroupExpandButton = nil then
        inherited DrawGroupBoxExpandButton(ACanvas, R, AState, AExpanded)
      else
        GroupExpandButton.Draw(ACanvas.Handle, R, Ord(not AExpanded), ButtonStateToSkinState[AState]);
  end;

var
  ABitmap: TcxAlphaBitmap;
  ARect: TRect;
begin
  if ARotationAngle = ra0 then
    DoDrawGroupBoxExpandButton(ACanvas, R)
  else
  begin
    if ARotationAngle in [raPlus90, raMinus90] then
      ARect := cxRectRotate(R)
    else
      ARect := R;
    ABitmap := TcxAlphaBitmap.CreateSize(ARect);
    try
      ABitmap.Clear;
      DoDrawGroupBoxExpandButton(ABitmap.cxCanvas, ABitmap.ClientRect);
      ACanvas.RotateBitmap(ABitmap, ARotationAngle);
      cxDrawImage(ACanvas.Handle, R, R, ABitmap, nil, -1, idmNormal);
    finally
      ABitmap.Free;
    end;
  end;
end;

procedure TdxSkinLookAndFeelPainter.DrawGroupBoxBackground(ACanvas: TcxCanvas;
  ABounds: TRect; ARect: TRect);
begin
  with SkinInfo do
    if GroupBoxClient = nil then
      inherited DrawGroupBoxBackground(ACanvas, ABounds, ARect)
    else
      GroupBoxClient.Draw(ACanvas.Handle, ARect);
end;

procedure TdxSkinLookAndFeelPainter.DrawHeader(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState;  AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
  ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False;
  AIsGroup: Boolean = False);

  function AdjustHeaderBounds(const ABounds: TRect; ABorders: TcxBorders): TRect;
  begin
    Result := cxRectExclude(ABounds, cxRect(1, 1, 1, 1), ABorders);
  end;

var
  AHeader: TdxSkinElement;
begin
  with SkinInfo do
    if AIsGroup then
      AHeader := HeaderSpecial
    else
      AHeader := Header;

  if AHeader = nil then
    inherited DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders,
      AState, AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
      AFont, ATextColor, ABkColor, AOnDrawBackGround, AIsLast, AIsGroup)
  else
  begin
    ACanvas.SaveClipRegion;
    try
      ACanvas.SetClipRegion(TcxRegion.Create(ABounds), roIntersect);
      AHeader.Draw(ACanvas.Handle, AdjustHeaderBounds(ABounds, ABorders), 0,
        ButtonStateToSkinState[AState]);
      DrawContent(ACanvas, HeaderContentBounds(ABounds, ABorders), ATextAreaBounds,
        Integer(AState), AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis,
        AText, AFont, ATextColor, ABkColor, AOnDrawBackground);
    finally
      ACanvas.RestoreClipRegion;
    end;
  end;
end;

procedure TdxSkinLookAndFeelPainter.DrawHeaderEx(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors;
  ABorders: TcxBorders; AState: TcxButtonState;  AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders, AState,
    AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText, AFont,
    ATextColor, ABkColor, AOnDrawBackground);
end;

procedure TdxSkinLookAndFeelPainter.DrawHeaderSeparator(ACanvas: TcxCanvas;
  const ABounds: TRect; AIndentSize: Integer; AColor: TColor; AViewParams: TcxViewParams);
begin
  with SkinInfo do
    if HeaderBackgroundColor = nil then
      inherited DrawHeaderSeparator(ACanvas, ABounds, AIndentSize, AColor, AViewParams)
    else
      ACanvas.FillRect(cxRectInflate(ABounds, -AIndentSize, 0), HeaderBackgroundColor.Value);
end;

function TdxSkinLookAndFeelPainter.HeaderBorders(
  ANeighbors: TcxNeighbors): TcxBorders;
begin
  Result := inherited HeaderBorders(ANeighbors);
  if nLeft in ANeighbors then Exclude(Result, bLeft);
  if nTop in ANeighbors then Exclude(Result, bTop);
end;

function TdxSkinLookAndFeelPainter.HeaderDrawCellsFirst: Boolean;
begin
  Result := False;
end;

procedure TdxSkinLookAndFeelPainter.DrawGroupByBox(ACanvas: TcxCanvas;
  const ARect: TRect; ATransparent: Boolean; ABackgroundColor: TColor;
  const ABackgroundBitmap: TBitmap);
begin
  with SkinInfo do
    if GridGroupByBox = nil then
      inherited DrawGroupByBox(ACanvas, ARect, ATransparent, ABackgroundColor,
        ABackgroundBitmap)
    else
      GridGroupByBox.Draw(ACanvas.Handle, ARect);
end;

function TdxSkinLookAndFeelPainter.GridDrawHeaderCellsFirst: Boolean;
begin
  with SkinInfo do
  begin
    if Header = nil then
      Result := inherited GridDrawHeaderCellsFirst
    else
      Result := not Header.IsAlphaUsed;
  end;
end;

function TdxSkinLookAndFeelPainter.GridGroupRowStyleOffice11ContentColor(AHasData: Boolean): TColor;
begin
  if SkinInfo.GridGroupRowStyleOffice11ContentColor = nil then
    Result := inherited GridGroupRowStyleOffice11ContentColor(AHasData)
  else
    Result := SkinInfo.GridGroupRowStyleOffice11ContentColor.Value;
end;

function TdxSkinLookAndFeelPainter.GridGroupRowStyleOffice11SeparatorColor: TColor;
begin
  if SkinInfo.GridGroupRowStyleOffice11SeparatorColor = nil then
    Result := inherited GridGroupRowStyleOffice11SeparatorColor
  else
    Result := SkinInfo.GridGroupRowStyleOffice11SeparatorColor.Value;
end;

function TdxSkinLookAndFeelPainter.GridGroupRowStyleOffice11TextColor: TColor;
begin
  if SkinInfo.GridGroupRowStyleOffice11TextColor = nil then
    Result := inherited GridGroupRowStyleOffice11TextColor
  else
    Result := SkinInfo.GridGroupRowStyleOffice11TextColor.Value;
end;

procedure TdxSkinLookAndFeelPainter.LayoutViewDrawRecordCaption(
  ACanvas: TcxCanvas; const ABounds: TRect; APosition: TcxGroupBoxCaptionPosition;
  AState: TcxButtonState);
const
  LayoutViewRecordState: array[TcxButtonState] of TdxSkinElementState =
    (esNormal, esNormal, esActive, esActive, esDisabled);
begin
  with SkinInfo do
    if LayoutViewRecordCaptionElements[APosition] = nil then
      inherited LayoutViewDrawRecordCaption(ACanvas, ABounds, APosition, AState)
    else
      LayoutViewRecordCaptionElements[APosition].Draw(
        ACanvas.Handle, ABounds, 0, LayoutViewRecordState[AState]);
end;

procedure TdxSkinLookAndFeelPainter.LayoutViewDrawRecordContent(
  ACanvas: TcxCanvas; const ABounds: TRect; ACaptionPosition: TcxGroupBoxCaptionPosition;
  AState: TcxButtonState; ABorders: TcxBorders = cxBordersAll);
begin
  with SkinInfo do
    if LayoutViewRecordElements[ACaptionPosition] = nil then
      inherited LayoutViewDrawRecordContent(ACanvas, ABounds, ACaptionPosition, AState, ABorders)
    else
      LayoutViewRecordElements[ACaptionPosition].Draw(ACanvas.Handle, ABounds);
end;

procedure TdxSkinLookAndFeelPainter.LayoutViewDrawRecordExpandButton(
  ACanvas: TcxCanvas; const ABounds: TRect; AState: TcxButtonState; AExpanded: Boolean);
begin
  with SkinInfo do
    if LayoutViewRecordExpandButton = nil then
      inherited LayoutViewDrawRecordExpandButton(ACanvas, ABounds, AState, AExpanded)
    else
      LayoutViewRecordExpandButton.Draw(ACanvas.Handle,
        ABounds, Ord(not AExpanded), ButtonStateToSkinState[AState]);
end;

procedure TdxSkinLookAndFeelPainter.LayoutViewDrawItem(
  ACanvas: TcxCanvas; const ABounds: TRect; AState: TcxButtonState; ABorders: TcxBorders = []);
begin
  if SkinInfo.LayoutViewItem = nil then
    inherited LayoutViewDrawItem(ACanvas, ABounds, AState, ABorders)
  else
    if AState <> cxbsNormal then
      SkinInfo.LayoutViewItem.Draw(ACanvas.Handle, ABounds, 0, ButtonStateToSkinState[AState])
    else
      if ABorders <> [] then
      begin
        ACanvas.SaveClipRegion;
        try
          ACanvas.IntersectClipRect(ABounds);
          SkinInfo.LayoutViewItem.Draw(ACanvas.Handle,
            cxRectExclude(ABounds, SkinInfo.LayoutViewItem.Image.Margins.Rect, ABorders), 0,
            ButtonStateToSkinState[AState]);
        finally
          ACanvas.RestoreClipRegion;
        end;
      end;
end;

function TdxSkinLookAndFeelPainter.LayoutViewGetPadding(AElement: TcxLayoutElement): TRect;
begin
  if SkinInfo.LayoutViewElementPadding[AElement] = nil then
    Result := inherited LayoutViewGetPadding(AElement)
  else
    Result := SkinInfo.LayoutViewElementPadding[AElement].Value.Rect;
end;

function TdxSkinLookAndFeelPainter.LayoutViewGetSpacing(AElement: TcxLayoutElement): TRect;
begin
  if SkinInfo.LayoutViewElementSpacing[AElement] = nil then
    Result := inherited LayoutViewGetSpacing(AElement)
  else
    Result := SkinInfo.LayoutViewElementSpacing[AElement].Value.Rect;
end;

function TdxSkinLookAndFeelPainter.PivotGridHeadersAreaColor: TColor;
begin
  with SkinInfo do
    if (GridGroupByBox = nil) or not IsColorAssigned(GridGroupByBox.Color) then
      Result := inherited PivotGridHeadersAreaColor
    else
      Result := GridGroupByBox.Color;
end;

function TdxSkinLookAndFeelPainter.PivotGridHeadersAreaTextColor: TColor;
begin
  with SkinInfo do
    if (GridGroupByBox = nil) or not IsColorAssigned(GridGroupByBox.TextColor) then
      Result := inherited PivotGridHeadersAreaColor
    else
      Result := GridGroupByBox.TextColor;
end;

procedure TdxSkinLookAndFeelPainter.DrawFooterBorder(
  ACanvas: TcxCanvas; const R: TRect);
var
  ABounds: TRect;
begin
  with SkinInfo do
    if FooterPanel = nil then
      inherited DrawFooterBorder(ACanvas, R)
    else
    begin
      ACanvas.SaveClipRegion;
      with FooterPanel.ContentOffset.Rect do
        ACanvas.ExcludeClipRect(Rect(R.Left, R.Top, R.Right - Right,
          R.Bottom - Bottom));
      ACanvas.ExcludeClipRect(Rect(R.Left, R.Top - 1, R.Right, R.Top));
      try
        ABounds := R;
        Dec(ABounds.Top);
        Dec(ABounds.Left, FooterPanel.ContentOffset.Left);
        FooterPanel.Draw(ACanvas.Handle, ABounds);
      finally
        ACanvas.RestoreClipRegion;
      end;
    end;
end;

procedure TdxSkinLookAndFeelPainter.DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect);
begin
  if SkinInfo.FooterCell = nil then
    inherited DrawFooterCellBorder(ACanvas, R);
end;

procedure TdxSkinLookAndFeelPainter.DrawFooterCellContent(ACanvas: TcxCanvas;
  const ABounds: TRect; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine: Boolean; const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  if SkinInfo.FooterCell <> nil then
    SkinInfo.FooterCell.Draw(ACanvas.Handle, ABounds);
  inherited DrawFooterCellContent(ACanvas, ABounds, AAlignmentHorz, AAlignmentVert,
    AMultiLine, AText, AFont, ATextColor, ABkColor, AOnDrawBackground);
end;

procedure TdxSkinLookAndFeelPainter.DrawFooterContent(ACanvas: TcxCanvas;
  const ARect: TRect; const AViewParams: TcxViewParams);
var
  R: TRect;
begin
  with SkinInfo do
  begin
    if (FooterPanel = nil) or (AViewParams.Bitmap <> nil) and
      not AViewParams.Bitmap.Empty
    then
      inherited DrawFooterContent(ACanvas, ARect, AViewParams)
    else
    begin
      with FooterPanel.ContentOffset do
        R := Classes.Rect(ARect.Left - Left, ARect.Top - FooterSeparatorSize,
          ARect.Right + Right, ARect.Bottom + Bottom);
      FooterPanel.Draw(ACanvas.Handle, R);
    end;
  end;
end;

function TdxSkinLookAndFeelPainter.FooterCellBorderSize: Integer;
begin
  with SkinInfo do
    if FooterCell = nil then
      Result := inherited FooterCellBorderSize
    else
      with FooterCell.ContentOffset do
        Result := Max(Max(Left, Top), Max(Right, Bottom));
end;

function TdxSkinLookAndFeelPainter.FooterDrawCellsFirst: Boolean;
begin
  Result := False;
end;

function TdxSkinLookAndFeelPainter.FooterSeparatorColor: TColor;
begin
  Result := DefaultGridLineColor;
end;

procedure TdxSkinLookAndFeelPainter.DrawFilterDropDownButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean);
begin
  with SkinInfo do
    if FilterButtons[AIsFilterActive] <> nil then
      FilterButtons[AIsFilterActive].Draw(ACanvas.Handle, R, 0,
        ButtonStateToSkinState[AState])
    else
      inherited DrawFilterDropDownButton(ACanvas, R, AState, AIsFilterActive);
end;

procedure TdxSkinLookAndFeelPainter.DrawFilterCloseButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  with SkinInfo do
  begin
    if EditButtonElements[True] = nil then
      inherited DrawFilterCloseButton(ACanvas, R, AState)
    else
      EditButtonElements[True].Draw(ACanvas.Handle, R, 0, ButtonStateToSkinState[AState]);
  end;
end;

procedure TdxSkinLookAndFeelPainter.DrawFilterPanel(ACanvas: TcxCanvas;
  const ARect: TRect; ATransparent: Boolean; ABackgroundColor: TColor;
  const ABackgroundBitmap: TBitmap);
begin
  with SkinInfo do
  begin
    if FilterPanel = nil then
      inherited DrawFilterPanel(ACanvas, ARect, ATransparent, ABackgroundColor,
        ABackgroundBitmap)
    else
      FilterPanel.Draw(ACanvas.Handle, ARect);
  end;
end;

procedure TdxSkinLookAndFeelPainter.DrawPanelBorders(ACanvas: TcxCanvas;
  const ABorderRect: TRect);
var
  AElement: TdxSkinElement;
begin
  AElement := SkinInfo.GroupBoxElements[cxgpCenter];
  if AElement = nil then
    DrawPanelBorders(ACanvas, ABorderRect)
  else
  begin
    ACanvas.SaveClipRegion;
    try
      ACanvas.ExcludeClipRect(cxRectContent(ABorderRect, AElement.ContentOffset.Rect));
      AElement.Draw(ACanvas.Handle, ABorderRect);
    finally
      ACanvas.RestoreClipRegion;
    end;
  end;
end;

procedure TdxSkinLookAndFeelPainter.DrawPanelContent(ACanvas: TcxCanvas;
  const ABorderRect: TRect; ABorder: Boolean);
begin
  with SkinInfo do
    if (GroupBoxClient = nil) then
      inherited DrawPanelContent(ACanvas, ABorderRect, ABorder)
    else
    begin
      GroupBoxClient.Draw(ACanvas.Handle, ABorderRect);
      if ABorder then
        DrawPanelBorders(ACanvas, ABorderRect);
    end;
end;

function TdxSkinLookAndFeelPainter.FilterCloseButtonSize: TPoint;
begin
  with SkinInfo do
    if EditButtonElements[True] = nil then
      Result := inherited FilterCloseButtonSize
    else
      Result := cxPoint(EditButtonElements[True].Size);
end;

procedure TdxSkinLookAndFeelPainter.DrawTrackBarTrack(ACanvas: TcxCanvas;
  const ARect, ASelection: TRect; AShowSelection, AEnabled, AHorizontal: Boolean; ATrackColor: TColor);
begin
  with SkinInfo do
    if TrackBarTrack[AHorizontal] = nil then
      inherited
    else
    begin
      TrackBarTrack[AHorizontal].Draw(ACanvas.Handle, ARect, 2 * Byte(not AEnabled));
      if AShowSelection then
        TrackBarTrack[AHorizontal].Draw(ACanvas.Handle, ASelection, 2 * Byte(not AEnabled) + 1);
    end;
end;

procedure TdxSkinLookAndFeelPainter.DrawTrackBarThumb(ACanvas: TcxCanvas;
  const ARect: TRect; AState: TcxButtonState; AHorizontal: Boolean;
  ATicks: TcxTrackBarTicksAlign; AThumbColor: TColor);
begin
  with SkinInfo do
  begin
    if TrackBarThumb[AHorizontal, ATicks] <> nil then
      TrackBarThumb[AHorizontal, ATicks].Draw(
        ACanvas.Handle, ARect, 0, ButtonStateToSkinState[AState])
    else
      inherited
  end;
end;

function TdxSkinLookAndFeelPainter.TrackBarThumbSize(AHorizontal: Boolean): TSize;
begin
  with SkinInfo do
  begin
    if TrackBarThumb[AHorizontal, tbtaDown] <> nil then
      Result := TrackBarThumb[AHorizontal, tbtaDown].Size
    else
      Result := inherited TrackBarThumbSize(AHorizontal);
  end;
end;

function TdxSkinLookAndFeelPainter.TrackBarTrackSize: Integer;
begin
  with SkinInfo do
  begin
    if TrackBarTrack[True] <> nil then
      Result := TrackBarTrack[True].Size.cy
    else
      Result := inherited TrackBarTrackSize;
  end;
end;

procedure TdxSkinLookAndFeelPainter.DrawContent(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; AState: Integer; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False);
const
  AlignmentsHorz: array[TAlignment] of Integer =
    (cxAlignLeft, cxAlignRight, cxAlignHCenter);
  AlignmentsVert: array[TcxAlignmentVert] of Integer =
    (cxAlignTop, cxAlignBottom, cxAlignVCenter);
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
begin
  with ACanvas do
  begin
    if AText <> '' then
    begin
      Brush.Style := bsClear;
      Font := AFont;
      Font.Color := ATextColor;
      DrawText(AText, ATextAreaBounds, AlignmentsHorz[AAlignmentHorz] or
        AlignmentsVert[AAlignmentVert] or MultiLines[AMultiLine] or
        ShowEndEllipsises[AShowEndEllipsis]);
      Brush.Style := bsSolid;
    end;
  end;
end;

procedure TdxSkinLookAndFeelPainter.DrawSplitter(ACanvas: TcxCanvas;
  const ARect: TRect; AHighlighted: Boolean; AClicked: Boolean; AHorizontal: Boolean);
const
  StateMap: array[Boolean] of TdxSkinElementState = (esNormal, esHot);
begin
  with SkinInfo do
  begin
    if Splitter[AHorizontal] = nil then
      inherited DrawSplitter(ACanvas, ARect, AHighlighted, AClicked, AHorizontal)
    else
      Splitter[AHorizontal].Draw(ACanvas.Handle , ARect, 0, StateMap[AHighlighted]);
  end;
end;

function TdxSkinLookAndFeelPainter.GetSplitterSize(AHorizontal: Boolean): TSize;
var
  AElement: TdxSkinElement;
begin
  AElement := SkinInfo.Splitter[AHorizontal];
  if AElement = nil then
    Result := inherited GetSplitterSize(AHorizontal)
  else
  begin
    Result.cx := Max(AElement.MinSize.Width, AElement.Size.cx);
    Result.cy := Max(AElement.MinSize.Height, AElement.Size.cy);
  end;
end;

procedure TdxSkinLookAndFeelPainter.DrawIndicatorCustomizationMark(
  ACanvas: TcxCanvas; const R: TRect; AColor: TColor);
const
  AIndicatorCustomizationMarkID = 2;
var
  ARect: TRect;  
begin
  with SkinInfo do
    if IndicatorImages = nil then
      inherited DrawIndicatorCustomizationMark(ACanvas, R, AColor)
    else
    begin
      with IndicatorImages.Image.Size, R do
      begin
        ARect := Rect(0, 0, cx, cy);
        OffsetRect(ARect, (Left + Right - cx) div 2, (Top + Bottom - cy) div 2);
      end;
      IndicatorImages.Draw(ACanvas.Handle, ARect, AIndicatorCustomizationMarkID);
    end;
end;

procedure TdxSkinLookAndFeelPainter.DrawIndicatorImage(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind);
const
  AIndicatorImagesMap: array[TcxIndicatorKind] of integer = (0, 0, 1, 2, 0, 0, 8);
var
  ARect: TRect;
begin
  with SkinInfo do
    if IndicatorImages = nil then
      inherited DrawIndicatorImage(ACanvas, R, AKind)
    else
      if AKind <> ikNone then
      begin
        with IndicatorImages.Image.Size, R do
        begin
          ARect := Rect(0, 0, cx, cy);
          OffsetRect(ARect, (Left + Right - cx) div 2, (Top + Bottom - cy) div 2);
        end;  
        IndicatorImages.Draw(ACanvas.Handle, ARect, AIndicatorImagesMap[AKind]);
      end;
end;

procedure TdxSkinLookAndFeelPainter.DrawIndicatorItem(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind; AColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
var
  ARect: TRect;
begin
  with R do
    ARect := Rect(Left, Top - HeaderBorderSize, Right, Bottom);
  DrawHeader(ACanvas, ARect, ARect, [], HeaderBorders([nTop, nBottom]), cxbsNormal,
    taLeftJustify, vaTop, False, False, '', nil, clNone, AColor, AOnDrawBackground);
  DrawIndicatorImage(ACanvas, R, AKind);
end;

procedure TdxSkinLookAndFeelPainter.DrawIndicatorItemEx(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind; AColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawIndicatorItem(ACanvas, R, AKind, AColor, AOnDrawBackground);
end;

procedure TdxSkinLookAndFeelPainter.DrawMonthHeader(ACanvas: TcxCanvas;
  const ABounds: TRect; const AText: string; ANeighbors: TcxNeighbors;
  const AViewParams: TcxViewParams; AArrows: TcxHeaderArrows; ASideWidth: Integer;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, ABounds, ABounds, ANeighbors, HeaderBorders(ANeighbors),
    cxbsNormal, taCenter, vaCenter, False, False, AText, AViewParams.Font,
    AViewParams.TextColor, AViewParams.Color, AOnDrawBackground);
  DrawMonthHeaderArrows(ACanvas, ABounds, AArrows, ASideWidth,
    DefaultDateNavigatorHeaderTextColor(False));
end;

procedure TdxSkinLookAndFeelPainter.DrawSchedulerEventProgress(
  ACanvas: TcxCanvas; const ABounds, AProgress: TRect;
  AViewParams: TcxViewParams; ATransparent: Boolean);
var
  AProgressBar: TdxSkinElement;
  AProgressChunk: TdxSkinElement;
begin
  with SkinInfo do
  begin
    AProgressBar := ProgressBarElements[False, False];
    AProgressChunk := ProgressBarElements[True, False];
  end;
  if (AProgressBar = nil) or (AProgressChunk = nil) then
    inherited DrawSchedulerEventProgress(ACanvas, ABounds, AProgress, AViewParams,
      ATransparent)
  else
  begin
    AProgressBar.Draw(ACanvas.Handle, ABounds);
    AProgressChunk.Draw(ACanvas.Handle, AProgress);
  end;
end;

function TdxSkinLookAndFeelPainter.SchedulerEventProgressOffsets: TRect;
var
  AProgressBar: TdxSkinElement;
begin
  with SkinInfo do
    AProgressBar := ProgressBarElements[False, False];
  if AProgressBar = nil then
    Result := SchedulerEventProgressOffsets
  else
    Result := AProgressBar.ContentOffset.Rect
end;

function TdxSkinLookAndFeelPainter.SchedulerNavigationButtonTextColor(
  AIsNextButton: Boolean; AState: TcxButtonState;
  ADefaultColor: TColor = clDefault): TColor;
var
  AElement: TdxSkinElement;
begin
  AElement := SkinInfo.SchedulerNavigationButtons[AIsNextButton];
  if AElement = nil then
    Result := inherited SchedulerNavigationButtonTextColor(AIsNextButton, AState, ADefaultColor)
  else
  begin
    Result := AElement.GetTextColor(AState);
    if Result = clDefault then
      Result := ADefaultColor;
  end;
end;

procedure TdxSkinLookAndFeelPainter.CalculateSchedulerNavigationButtonRects(
  AIsNextButton: Boolean; ACollapsed: Boolean; APrevButtonTextSize: TSize;
  ANextButtonTextSize: TSize; var ABounds: TRect; out ATextRect: TRect;
  out AArrowRect: TRect);
var
  AMinSize: TSize;
begin
  with SkinInfo do
    if SchedulerNavigationButtons[AIsNextButton] = nil then
      AMinSize := cxNullSize
    else
      AMinSize := SchedulerNavigationButtons[AIsNextButton].MinSize.Size;

  if (AMinSize.cx > 0) and (ABounds.Right - ABounds.Left < AMinSize.cx) then
    if AIsNextButton then
      ABounds.Left := ABounds.Right - AMinSize.cx
    else
      ABounds.Right := ABounds.Left + AMinSize.cx;
                                              
  inherited CalculateSchedulerNavigationButtonRects(AIsNextButton, ACollapsed,
    APrevButtonTextSize, ANextButtonTextSize, ABounds, ATextRect, AArrowRect);
end;

procedure TdxSkinLookAndFeelPainter.DrawFooterBorderEx(ACanvas: TcxCanvas;
  const R: TRect; ABorders: TcxBorders);
var
  ABounds: TRect;
begin
  with SkinInfo do
    if FooterPanel = nil then
      inherited DrawFooterBorder(ACanvas, R)
    else
    begin
      ACanvas.SaveClipRegion;
      try
        with FooterPanel.ContentOffset.Rect do
        begin
          ACanvas.ExcludeClipRect(Rect(R.Left + Left, R.Top + FooterSeparatorSize, R.Right - Right,
            R.Bottom - Bottom));
          ABounds := R;
          if not (bTop in ABorders) then
            Dec(ABounds.Top, FooterSeparatorSize);
          if not (bBottom in ABorders) then
            Inc(ABounds.Bottom, Bottom);
          if not (bLeft in ABorders) then
            Dec(ABounds.Left, Left);
          if not (bRight in ABorders) then
            Inc(ABounds.Right, Right);
        end;
        FooterPanel.Draw(ACanvas.Handle, ABounds);
      finally
        ACanvas.RestoreClipRegion;
      end;
    end;
end;

procedure TdxSkinLookAndFeelPainter.DrawSchedulerNavigationButtonContent(
  ACanvas: TcxCanvas; const ARect: TRect; const AArrowRect: TRect;
  AIsNextButton: Boolean; AState: TcxButtonState);
var
  R: TRect;
begin
  with SkinInfo do
    if SchedulerNavigationButtons[AIsNextButton] = nil then
      inherited DrawSchedulerNavigationButtonContent(ACanvas, ARect, AArrowRect,
        AIsNextButton, AState)
    else
    begin
      R := ARect;
      if AIsNextButton then
        Inc(R.Right)
      else
        Dec(R.Left);

      ACanvas.SaveClipRegion;
      try
        ACanvas.SetClipRegion(TcxRegion.Create(ARect), roIntersect);
        SchedulerNavigationButtons[AIsNextButton].Draw(ACanvas.Handle, R, 0,
          ButtonStateToSkinState[AState]);
        if SchedulerNavigationButtonsArrow[AIsNextButton] <> nil then
          SchedulerNavigationButtonsArrow[AIsNextButton].Draw(ACanvas.Handle,
            AArrowRect, 0, ButtonStateToSkinState[AState]);
      finally
        ACanvas.RestoreClipRegion;
      end;
    end;
end;

function TdxSkinLookAndFeelPainter.IsColorAssigned(AColor: TColor): Boolean;
begin
  Result := (AColor <> clNone) and (AColor <> clDefault);
end;

function TdxSkinLookAndFeelPainter.IsColorPropertyAssigned(
  AColor: TdxSkinColor): Boolean;
begin
  Result := Assigned(AColor) and IsColorAssigned(AColor.Value);
end;

function TdxSkinLookAndFeelPainter.GetSkinInfoClass: TdxSkinLookAndFeelPainterInfoClass;
begin
  Result := TdxSkinLookAndFeelPainterInfo;
end;

procedure TdxSkinLookAndFeelPainter.SchedulerNavigationButtonSizes(
  AIsNextButton: Boolean; var ABorders: TRect; var AArrowSize: TSize;
  var AHasTextArea: Boolean);
begin
  with SkinInfo do
    if (SchedulerNavigationButtons[AIsNextButton] = nil) or
       (SchedulerNavigationButtonsArrow[AIsNextButton] = nil)
    then
      inherited SchedulerNavigationButtonSizes(
        AIsNextButton, ABorders, AArrowSize, AHasTextArea)
    else
    begin
      ABorders := SchedulerNavigationButtons[AIsNextButton].ContentOffset.Rect;
      AArrowSize := SchedulerNavigationButtonsArrow[AIsNextButton].Size;
      AHasTextArea := not SchedulerNavigationButtons[AIsNextButton].Image.Empty;
    end;
end;

procedure TdxSkinLookAndFeelPainter.DrawSchedulerNavigatorButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  if SkinInfo.EditButtonElements[False] = nil then
    inherited DrawSchedulerNavigatorButton(ACanvas, R, AState)
  else
    SkinInfo.EditButtonElements[False].Draw(ACanvas.Handle, R, 0, ButtonStateToSkinState[AState]);
end;

procedure TdxSkinLookAndFeelPainter.DrawWindowContent(
  ACanvas: TcxCanvas; const ARect: TRect);
begin
  with SkinInfo do
    if FormContent = nil then
      inherited DrawWindowContent(ACanvas, ARect)
    else
      ACanvas.FillRect(ARect, FormContent.Color);
end;

function TdxSkinLookAndFeelPainter.PrintPreviewPageBordersWidth: TRect;
begin
  with SkinInfo do
    if PrintingPageBorder =  nil then
      Result := inherited PrintPreviewPageBordersWidth
    else
      Result := PrintingPageBorder.ContentOffset.Rect;
end;

procedure TdxSkinLookAndFeelPainter.DrawPrintPreviewBackground(
  ACanvas: TcxCanvas; const R: TRect);
begin
  with SkinInfo do
    if PrintingPreviewBackground =  nil then
      inherited DrawPrintPreviewBackground(ACanvas, R)
    else
    begin
      PrintingPreviewBackground.UseCache := True;
      PrintingPreviewBackground.Draw(ACanvas.Handle, R);
    end;
end;

procedure TdxSkinLookAndFeelPainter.DrawPrintPreviewPageBackground(
  ACanvas: TcxCanvas; const ABorderRect, AContentRect: TRect;
  ASelected, ADrawContent: Boolean);
const
  StateMap: array[Boolean] of TdxSkinElementState = (esNormal, esActive);
begin
  with SkinInfo do
    if PrintingPageBorder =  nil then
      inherited DrawPrintPreviewPageBackground(
        ACanvas, ABorderRect, AContentRect, ASelected, ADrawContent)
    else
    begin
      ACanvas.SaveClipRegion;
      try
        if ADrawContent then
          ACanvas.FillRect(AContentRect, clWhite);
        ACanvas.ExcludeClipRect(AContentRect);
        PrintingPageBorder.Draw(ACanvas.Handle, ABorderRect, 0, StateMap[ASelected]);
      finally
        ACanvas.RestoreClipRegion;
      end;
    end;
end;

procedure TdxSkinLookAndFeelPainter.DrawDateNavigatorDateHeader(
  ACanvas: TcxCanvas; var R: TRect);
begin
  InflateRect(R, 1, 0);
  DrawHeader(ACanvas, R, cxEmptyRect, [], [], cxbsNormal,
    taCenter, vaCenter, False, False, '', nil, 0, 0);
end;

function TdxSkinLookAndFeelPainter.IndicatorDrawItemsFirst: Boolean;
begin
  Result := True;
end;

function TdxSkinLookAndFeelPainter.GetSkinDetails: TdxSkinDetails;
var
  AStream: TStream;
begin
  if (FSkinInfo <> nil) and (FSkinInfo.Skin <> nil) then
    Result := FSkinInfo.Skin.Details
  else
  begin
    if (FSkinDetails = nil) and (FSkinResName <> '') then
    begin
      AStream := TResourceStream.Create(FSkinResInstance, FSkinResName, sdxResourceType);
      try
        FSkinDetails := TdxSkinDetails.Create;
        FSkinDetails.LoadFromStream(AStream);
      finally
        AStream.Free;
      end;
    end;
    Result := FSkinDetails;
  end;
end;

function TdxSkinLookAndFeelPainter.GetSkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if FSkinInfo = nil then
  begin
    FSkinInfo := GetSkinInfoClass.Create;
    if FSkinResName <> '' then
    begin
      FSkinInfo.Skin := TdxSkin.Create(FSkinResName, True, FSkinResInstance);
      FreeAndNil(FSkinDetails);
    end;
  end;
  Result := FSkinInfo;
end;

end.
