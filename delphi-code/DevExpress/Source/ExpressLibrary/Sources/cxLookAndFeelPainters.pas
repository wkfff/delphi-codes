
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressCommonLibrary                                         }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSCOMMONLIBRARY AND ALL          }
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

unit cxLookAndFeelPainters;

{$I cxVer.inc}

interface

uses
  Windows, dxCore, dxUxTheme, dxThemeManager, dxOffice11,
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Classes, Graphics, Controls, ImgList,
  cxClasses, cxGraphics, cxGeometry;

const
  cxContainerMaxBorderWidth = 2;
  cxTextOffset = 2;
  cxHeaderTextOffset = cxTextOffset;

  cxArrowLeftBasePointIndex = 0;
  cxArrowTopPointIndex = 1;
  cxArrowRightBasePointIndex = 2;

  cxStdThumbnailMinimalSize = 8;

type
  TcxCustomLookAndFeelPainter = class;
  TcxLookAndFeelStyle = (lfsFlat, lfsStandard, lfsUltraFlat, lfsNative, lfsOffice11, lfsSkin);

  TcxArrowDirection = (adUp, adDown, adLeft, adRight);
  TcxArrowPoints = array[0..2] of TPoint;
  TcxEditBtnKind = (cxbkCloseBtn, cxbkComboBtn, cxbkEditorBtn, cxbkEllipsisBtn,
    cxbkSpinUpBtn, cxbkSpinDownBtn, cxbkSpinLeftBtn, cxbkSpinRightBtn);
  TcxEditBtnPosition = (cxbpLeft, cxbpRight);
  TcxEditStateColorKind = (esckNormal, esckDisabled, esckInactive, esckReadOnly);
  TcxButtonState = (cxbsDefault, cxbsNormal, cxbsHot, cxbsPressed, cxbsDisabled);
  TcxCalcButtonKind = (cbBack, cbCancel, cbClear, cbMC, cbMR, cbMS, cbMP,
    cbNum0, cbNum1, cbNum2, cbNum3, cbNum4, cbNum5, cbNum6, cbNum7, cbNum8,
    cbNum9, cbSign, cbDecimal, cbDiv, cbMul, cbSub, cbAdd, cbSqrt, cbPercent,
    cbRev, cbEqual, cbNone);
  TcxCheckBoxState = (cbsUnchecked, cbsChecked, cbsGrayed);
  TcxContainerBorderStyle = (cbsNone, cbsSingle, cbsThick, cbsFlat, cbs3D,
    cbsUltraFlat, cbsOffice11);
  TcxEditPopupBorderStyle = (epbsDefault, epbsSingle, epbsFrame3D, epbsFlat);
  TcxGroupBoxCaptionPosition = (cxgpTop, cxgpBottom, cxgpLeft, cxgpRight, cxgpCenter);
  TcxHeaderArrows = (haNone, haLeft, haRight, haBoth);
  TcxIndicatorKind = (ikNone, ikArrow, ikEdit, ikInsert, ikMultiDot, ikMultiArrow, ikFilter);
  TcxNeighbor = (nLeft, nTop, nRight, nBottom);
  TcxNeighbors = set of TcxNeighbor;
  TcxScrollBarPart = (sbpNone, sbpLineUp, sbpLineDown, sbpThumbnail,
    sbpPageUp, sbpPageDown);
  TcxPopupBorderStyle = (pbsNone, pbsUltraFlat, pbsFlat, pbs3D);
  TcxTrackBarTicksAlign = (tbtaUp, tbtaDown, tbtaBoth);
  TcxLayoutElement = (leGroup, leGroupWithoutBorders, leTabbedGroup,
    leRootGroup, leRootGroupWithoutBorders, leItem);

  TcxDrawBackgroundEvent = function(ACanvas: TcxCanvas; const ABounds: TRect): Boolean of object;

  IcxLookAndFeelPainterListener = interface 
  ['{7665B7CA-2C4B-48B9-ABA2-FA530E7EA468}']
    procedure PainterAdded(APainter: TcxCustomLookAndFeelPainter);
    procedure PainterRemoved(APainter: TcxCustomLookAndFeelPainter);
  end;

  { TcxCustomLookAndFeelPainter }

  TcxCustomLookAndFeelPainter = class(TPersistent)
  protected
    function DefaultDateNavigatorHeaderHighlightTextColor: TColor; virtual;
    procedure DrawBackground(ACanvas: TcxCanvas; const ARect: TRect;
      ATransparent: Boolean; ABackgroundColor: TColor; const ABackgroundBitmap: TBitmap); virtual;
    procedure DrawButtonArrow(ACanvas: TcxCanvas; const R: TRect; AColor: TColor); virtual;
    procedure DrawContent(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect; AState: Integer;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False); virtual;
    procedure DrawExpandButtonCross(ACanvas: TcxCanvas; const R: TRect;
      AExpanded: Boolean; AColor: TColor);
    procedure DrawFooterBorderEx(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders); virtual;
    procedure DrawGroupExpandButtonMark(ACanvas: TcxCanvas; const R: TRect;
      AExpanded: Boolean; AState: TcxButtonState);
    procedure DrawMonthHeaderArrows(ACanvas: TcxCanvas; const ABounds: TRect;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AColor: TColor);
    procedure DrawSortingArrow(ACanvas: TcxCanvas; const R: TRect;
      AColor1, AColor2: TColor; AAscendingSorting: Boolean);
    procedure DrawSchedulerNavigationButtonContent(ACanvas: TcxCanvas;
      const ARect: TRect; const AArrowRect: TRect; AIsNextButton: Boolean;
      AState: TcxButtonState); virtual;
    function FooterCellContentBounds(const ABounds: TRect): TRect; virtual;
    function FooterCellTextAreaBounds(const ABounds: TRect): TRect; virtual;
    function GetArrowDirection(AHorizontal: Boolean; APart: TcxScrollBarPart): TcxArrowDirection;
    function GetSeparatorBounds(const R: TRect; AWidth: Integer; AIsVertical: Boolean): TRect; virtual;
  public
    function GetPainterData(var AData): Boolean; virtual;
    function GetPainterDetails(var ADetails): Boolean; virtual;
    function IsInternalPainter: Boolean; virtual;
    function LookAndFeelName: string; virtual;
    function LookAndFeelStyle: TcxLookAndFeelStyle; virtual;
    function NeedRedrawOnResize: Boolean; virtual;

    // colors
    function DefaultContentColor: TColor; virtual;
    function DefaultContentEvenColor: TColor; virtual;
    function DefaultContentOddColor: TColor; virtual;
    function DefaultContentTextColor: TColor; virtual;
    function DefaultEditorBackgroundColor(AIsDisabled: Boolean): TColor; virtual;
    function DefaultEditorBackgroundColorEx(AKind: TcxEditStateColorKind): TColor; virtual;
    function DefaultEditorTextColor(AIsDisabled: Boolean): TColor; virtual;
    function DefaultEditorTextColorEx(AKind: TcxEditStateColorKind): TColor; virtual;
    function DefaultFilterBoxColor: TColor; virtual;
    function DefaultFilterBoxTextColor: TColor; virtual;
    function DefaultFixedSeparatorColor: TColor; virtual;
    function DefaultFooterColor: TColor; virtual;
    function DefaultFooterTextColor: TColor; virtual;
    function DefaultGridDetailsSiteColor: TColor; virtual;
    function DefaultGridLineColor: TColor; virtual;
    function DefaultGroupByBoxColor: TColor; virtual;
    function DefaultGroupByBoxTextColor: TColor; virtual;
    function DefaultGroupColor: TColor; virtual;
    function DefaultGroupTextColor: TColor; virtual;
    function DefaultHeaderBackgroundColor: TColor; virtual;
    function DefaultHeaderBackgroundTextColor: TColor; virtual;
    function DefaultHeaderColor: TColor; virtual;
    function DefaultHeaderTextColor: TColor; virtual;
    function DefaultHyperlinkTextColor: TColor; virtual;
    function DefaultInactiveColor: TColor; virtual;
    function DefaultInactiveTextColor: TColor; virtual;
    function DefaultPreviewTextColor: TColor; virtual;
    function DefaultRecordSeparatorColor: TColor; virtual;
    function DefaultSizeGripAreaColor: TColor; virtual;

    function DefaultVGridBandLineColor: TColor; virtual;
    function DefaultVGridCategoryColor: TColor; virtual;
    function DefaultVGridCategoryTextColor: TColor; virtual;
    function DefaultVGridHeaderColor: TColor; virtual;
    function DefaultVGridHeaderTextColor: TColor; virtual;
    function DefaultVGridLineColor: TColor; virtual;

    function DefaultDateNavigatorContentColor: TColor; virtual;
    function DefaultDateNavigatorHeaderColor: TColor; virtual;
    function DefaultDateNavigatorHeaderTextColor(AIsHighlight: Boolean): TColor; virtual;
    function DefaultDateNavigatorHolydayTextColor: TColor; virtual;
    function DefaultDateNavigatorInactiveTextColor: TColor; virtual;
    function DefaultDateNavigatorSelectionColor: TColor; virtual;
    function DefaultDateNavigatorSelectionTextColor: TColor; virtual;
    function DefaultDateNavigatorSeparator1Color: TColor; virtual;
    function DefaultDateNavigatorSeparator2Color: TColor; virtual;
    function DefaultDateNavigatorTextColor: TColor; virtual;
    function DefaultDateNavigatorTodayFrameColor: TColor; virtual;
    function DefaultDateNavigatorTodayTextColor: TColor; virtual;

    function DefaultSchedulerBackgroundColor: TColor; virtual;
    function DefaultSchedulerTextColor: TColor; virtual;
    function DefaultSchedulerBorderColor: TColor; virtual;
    function DefaultSchedulerControlColor: TColor; virtual;
    function DefaultSchedulerNavigatorColor: TColor; virtual;
    function DefaultSchedulerTimeRulerColor: TColor; virtual;
    function DefaultSchedulerTimeRulerTextColor: TColor; virtual;
    function DefaultSchedulerViewContentColor: TColor; virtual;
    function DefaultSchedulerViewSelectedTextColor: TColor; virtual;
    function DefaultSchedulerViewTextColor: TColor; virtual;

    function DefaultSelectionColor: TColor; virtual;
    function DefaultSelectionTextColor: TColor; virtual;
    function DefaultSeparatorColor: TColor; virtual;
    function DefaultTabColor: TColor; virtual;
    function DefaultTabTextColor: TColor; virtual;
    function DefaultTabsBackgroundColor: TColor; virtual;
    function DefaultRootTabsBackgroundColor: TColor; virtual;

    function DefaultTimeGridMajorScaleColor: TColor; virtual;
    function DefaultTimeGridMajorScaleTextColor: TColor; virtual;
    function DefaultTimeGridMinorScaleColor: TColor; virtual;
    function DefaultTimeGridMinorScaleTextColor: TColor; virtual;
    function DefaultTimeGridSelectionBarColor: TColor; virtual;

    function DefaultChartDiagramValueBorderColor: TColor; virtual;
    function DefaultChartDiagramValueCaptionTextColor: TColor; virtual;
    function DefaultChartHistogramAxisColor: TColor; virtual;
    function DefaultChartHistogramGridLineColor: TColor; virtual;
    function DefaultChartHistogramPlotColor: TColor; virtual;
    function DefaultChartPieDiagramSeriesSiteBorderColor: TColor; virtual;
    function DefaultChartPieDiagramSeriesSiteCaptionColor: TColor; virtual;
    function DefaultChartPieDiagramSeriesSiteCaptionTextColor: TColor; virtual;
    function DefaultChartToolBoxDataLevelInfoBorderColor: TColor; virtual;
    function DefaultChartToolBoxItemSeparatorColor: TColor; virtual;

    // arrow
    procedure CalculateArrowPoints(R: TRect; var P: TcxArrowPoints; AArrowDirection: TcxArrowDirection; AProportional: Boolean; AArrowSize: Integer = 0);
    procedure DrawArrow(ACanvas: TcxCanvas; const R: TRect; AArrowDirection: TcxArrowDirection; AColor: TColor); overload; virtual;
    procedure DrawArrow(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState; AArrowDirection: TcxArrowDirection; ADrawBorder: Boolean = True); overload; virtual;
    procedure DrawArrowBorder(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState); virtual;
    procedure DrawScrollBarArrow(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AArrowDirection: TcxArrowDirection); virtual;
    // border
    function BorderSize: Integer; virtual;
    procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); virtual;
    procedure DrawContainerBorder(ACanvas: TcxCanvas; const R: TRect; AStyle: TcxContainerBorderStyle;
      AWidth: Integer; AColor: TColor; ABorders: TcxBorders); virtual;
    procedure DrawSeparator(ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean); virtual;
    // buttons
    function AdjustGroupButtonDisplayRect(const R: TRect; AButtonCount, AButtonIndex: Integer): TRect; virtual;
    function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; virtual; // abstract;
    function ButtonColor(AState: TcxButtonState): TColor; virtual;
    function ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect; virtual;
    function ButtonGroupBorderSizes(AButtonCount, AButtonIndex: Integer): TRect; virtual;
    function ButtonTextOffset: Integer; virtual; // abstract;
    function ButtonTextShift: Integer; virtual; // abstract;
    function ButtonSymbolColor(AState: TcxButtonState;
      ADefaultColor: TColor = clDefault): TColor; virtual;
    function ButtonSymbolState(AState: TcxButtonState): TcxButtonState; virtual;
    procedure DrawButton(ACanvas: TcxCanvas; R: TRect; const ACaption: string;
      AState: TcxButtonState; ADrawBorder: Boolean = True; AColor: TColor = clDefault;
      ATextColor: TColor = clDefault; AWordWrap: Boolean = False; AIsToolButton: Boolean = False); virtual;
    procedure DrawButtonCross(ACanvas: TcxCanvas; const R: TRect; AColor: TColor;
      AState: TcxButtonState);
    procedure DrawButtonInGroup(ACanvas: TcxCanvas; R: TRect;
      AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
      ABackgroundColor: TColor); virtual;
    procedure DrawButtonBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); virtual; // abstract;
    procedure DrawButtonGroupBorder(ACanvas: TcxCanvas; R: TRect; AInplace, ASelected: Boolean); virtual;
    procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault); virtual; // abstract;
    procedure DrawExpandButtonEx(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0); virtual;
    function DrawExpandButtonFirst: Boolean; virtual;
    procedure DrawGroupExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AState: TcxButtonState); virtual; // abstract
    procedure DrawSmallExpandButton(ACanvas: TcxCanvas; R: TRect; AExpanded: Boolean;
      ABorderColor: TColor; AColor: TColor = clDefault); virtual;
    function ExpandButtonSize: Integer; virtual; // abstract;
    function GroupExpandButtonSize: Integer; virtual; // abstract;
    function IsButtonHotTrack: Boolean; virtual; // abstract;
    function IsPointOverGroupExpandButton(const R: TRect; const P: TPoint): Boolean; virtual;
    function SmallExpandButtonSize: Integer; virtual;
    // checkbox
    function CheckBorderSize: Integer; virtual;
    function CheckButtonColor(AState: TcxButtonState): TColor; virtual;
    function CheckButtonSize: TSize; virtual;
    procedure DrawCheck(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState;
      AChecked: Boolean; AColor: TColor); virtual;
    procedure DrawCheckBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); virtual; // abstract;
    procedure DrawCheckButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState;
      AChecked: Boolean); overload; virtual;
    procedure DrawCheckButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState;
      ACheckState: TcxCheckBoxState); overload; virtual;
    // RadioButton
    procedure DrawRadioButton(ACanvas: TcxCanvas; X, Y: Integer;
      AButtonState: TcxButtonState; AChecked, AFocused: Boolean;
      ABrushColor: TColor;  AIsDesigning: Boolean = False); virtual;
    function RadioButtonBodyColor(AState: TcxButtonState): TColor; virtual;
    function RadioButtonSize: TSize; virtual;
    // label
    procedure DrawLabelLine(ACanvas: TcxCanvas; const R: TRect;
      AOuterColor, AInnerColor: TColor; AIsVertical: Boolean); virtual;
    function LabelLineHeight: Integer; virtual;
    // header
    procedure DrawHeader(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False;
      AIsGroup: Boolean = False); virtual;
    procedure DrawHeaderEx(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); virtual;
    procedure DrawHeaderBorder(ACanvas: TcxCanvas; const R: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders); virtual;
    procedure DrawHeaderPressed(ACanvas: TcxCanvas; const ABounds: TRect); virtual;
    procedure DrawHeaderControlSection(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
      AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
      ABkColor: TColor); virtual;
    procedure DrawHeaderControlSectionBorder(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders; AState: TcxButtonState); virtual;
    procedure DrawHeaderControlSectionContent(ACanvas: TcxCanvas; const ABounds,
      ATextAreaBounds: TRect; AState: TcxButtonState; AAlignmentHorz: TAlignment;
      AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor); virtual;
    procedure DrawHeaderControlSectionText(ACanvas: TcxCanvas;
      const ATextAreaBounds: TRect; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
      AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor: TColor); virtual;
    procedure DrawHeaderSeparator(ACanvas: TcxCanvas; const ABounds: TRect;
      AIndentSize: Integer; AColor: TColor; AViewParams: TcxViewParams); virtual; 
    procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); virtual; // abstract;
    function HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders; virtual;
    function HeaderBorderSize: Integer; virtual;
    function HeaderBounds(const ABounds: TRect; ANeighbors: TcxNeighbors;
      ABorders: TcxBorders = cxBordersAll): TRect; virtual;
    function HeaderContentBounds(const ABounds: TRect; ABorders: TcxBorders): TRect; virtual;
    function HeaderDrawCellsFirst: Boolean; virtual;
    function HeaderHeight(AFontHeight: Integer): Integer; virtual;
    function HeaderControlSectionBorderSize(
      AState: TcxButtonState = cxbsNormal): Integer; virtual;
    function HeaderControlSectionTextAreaBounds(ABounds: TRect;
      AState: TcxButtonState): TRect; virtual;
    function HeaderControlSectionContentBounds(const ABounds: TRect;
      AState: TcxButtonState): TRect; virtual;
    function HeaderWidth(ACanvas: TcxCanvas; ABorders: TcxBorders;
      const AText: string; AFont: TFont): Integer; virtual;
    function IsHeaderHotTrack: Boolean; virtual;
    function SortingMarkAreaSize: TPoint; virtual;
    function SortingMarkSize: TPoint; virtual; // abstract;
    // grid
    procedure DrawGroupByBox(ACanvas: TcxCanvas; const ARect: TRect;
      ATransparent: Boolean; ABackgroundColor: TColor; const ABackgroundBitmap: TBitmap); virtual;
    function GridGroupRowStyleOffice11ContentColor(AHasData: Boolean): TColor; virtual;
    function GridGroupRowStyleOffice11SeparatorColor: TColor; virtual;
    function GridGroupRowStyleOffice11TextColor: TColor; virtual;
    function GridDrawHeaderCellsFirst: Boolean; virtual;
    function PivotGridHeadersAreaColor: TColor; virtual;
    function PivotGridHeadersAreaTextColor: TColor; virtual;
    //layout view
    procedure LayoutViewDrawItem(ACanvas: TcxCanvas; const ABounds: TRect;
      AState: TcxButtonState; ABorders: TcxBorders = []); virtual;
    procedure LayoutViewDrawRecordCaption(ACanvas: TcxCanvas; const ABounds: TRect;
      APosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState); virtual;
    procedure LayoutViewDrawRecordBorder(ACanvas: TcxCanvas; const ABounds: TRect;
      AState: TcxButtonState; ABorders: TcxBorders = []); virtual;
    procedure LayoutViewDrawRecordContent(ACanvas: TcxCanvas; const ABounds: TRect;
      ACaptionPosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState; ABorders: TcxBorders = cxBordersAll); virtual;
    procedure LayoutViewDrawRecordExpandButton(ACanvas: TcxCanvas;
      const ABounds: TRect; AState: TcxButtonState; AExpanded: Boolean); virtual;
    function LayoutViewGetPadding(AElement: TcxLayoutElement): TRect; virtual;
    function LayoutViewGetSpacing(AElement: TcxLayoutElement): TRect; virtual;

    // footer
    function FooterBorders: TcxBorders; virtual;
    function FooterBorderSize: Integer; virtual; // abstract;
    function FooterCellBorderSize: Integer; virtual; // abstract;
    function FooterCellOffset: Integer; virtual; // abstract;
    function FooterDrawCellsFirst: Boolean; virtual;
    function FooterSeparatorColor: TColor; virtual;
    function FooterSeparatorSize: Integer; virtual;
    procedure DrawFooterPanel(ACanvas: TcxCanvas; const ABounds: TRect;
      const AViewParams: TcxViewParams; ABorders: TcxBorders);
    procedure DrawFooterCell(ACanvas: TcxCanvas; const ABounds: TRect;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); virtual;
    procedure DrawFooterCellContent(ACanvas: TcxCanvas; const ABounds: TRect;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); virtual;
    procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); virtual; // abstract;
    procedure DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect); virtual; // abstract;
    procedure DrawFooterContent(ACanvas: TcxCanvas; const ARect: TRect;
      const AViewParams: TcxViewParams); virtual;
    procedure DrawFooterSeparator(ACanvas: TcxCanvas; const R: TRect); virtual;
    // filter
    procedure DrawFilterActivateButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AChecked: Boolean); virtual;
    procedure DrawFilterCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); virtual;
    procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); virtual; // abstract;
    procedure DrawFilterPanel(ACanvas: TcxCanvas; const ARect: TRect;
      ATransparent: Boolean; ABackgroundColor: TColor; const ABackgroundBitmap: TBitmap); virtual; 
    function FilterActivateButtonSize: TPoint; virtual;
    function FilterCloseButtonSize: TPoint; virtual;
    function FilterDropDownButtonSize: TPoint; virtual;
    // popup
    procedure DrawEditPopupWindowBorder(ACanvas: TcxCanvas; var R: TRect;
      ABorderStyle: TcxEditPopupBorderStyle; AClientEdge: Boolean); virtual;
    procedure DrawWindowContent(ACanvas: TcxCanvas; const ARect: TRect); virtual;
    function GetEditPopupWindowBorderWidth(AStyle: TcxEditPopupBorderStyle): Integer; virtual;
    function GetEditPopupWindowClientEdgeWidth(AStyle: TcxEditPopupBorderStyle): Integer; virtual;
    function PopupBorderStyle: TcxPopupBorderStyle; virtual;
    // tabs
    procedure DrawTab(ACanvas: TcxCanvas; R: TRect; ABorders: TcxBorders;
      const AText: string; AState: TcxButtonState; AVertical: Boolean; AFont: TFont;
      ATextColor, ABkColor: TColor; AShowPrefix: Boolean = False); virtual;
    procedure DrawTabBorder(ACanvas: TcxCanvas; R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean); virtual; // abstract;
    procedure DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AVertical: Boolean); virtual; // abstract;
    function IsDrawTabImplemented(AVertical: Boolean): Boolean; virtual;
    function IsTabHotTrack(AVertical: Boolean): Boolean; virtual;
    function TabBorderSize(AVertical: Boolean): Integer; virtual;
    // indicator
    procedure DrawIndicatorCustomizationMark(ACanvas: TcxCanvas;
      const R: TRect; AColor: TColor); virtual;
    procedure DrawIndicatorImage(ACanvas: TcxCanvas; const R: TRect; AKind: TcxIndicatorKind); virtual;
    procedure DrawIndicatorItem(ACanvas: TcxCanvas; const R: TRect;
      AKind: TcxIndicatorKind; AColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil); virtual;
    procedure DrawIndicatorItemEx(ACanvas: TcxCanvas; const R: TRect;
      AKind: TcxIndicatorKind; AColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil); virtual;
    function IndicatorDrawItemsFirst: Boolean; virtual;
    // scrollbars
    function ScrollBarMinimalThumbSize(AVertical: Boolean): Integer; virtual;
    procedure DrawScrollBarBackground(ACanvas: TcxCanvas; const R: TRect;
      AHorizontal: Boolean); virtual;
    procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); virtual;
    // PopupPanel
    function PopupPanelSize: Integer;
    procedure CalculatePopupPanelClientRect(
      var AClientRect, APanelRect, AGripRect, ACloseButtonRect: TRect;
      ACorner: TdxCorner; const ABorders, APanelBorders: TRect;
      APanelHeight: Integer = 0; AShowCloseButton: Boolean = True; AShowGripSize: Boolean = True);
    procedure DrawPopupNCPanel(AHandle: HWND;
      AMouseAboveCloseButton, ACloseButtonIsTracking: Boolean; ACorner: TdxCorner;
      ACloseButtonRect, AGripRect: TRect; ABorderColor: TColor);
    procedure DrawPopupPanelBand(ACanvas: TcxCanvas;
      const ABounds, AGripRect, ACloseButtonRect: TRect;
      AGripCorner: TdxCorner; ACloseButtonState: TcxButtonState;
      ABorders: TRect; ABorderColor: TColor;
      AShowGripSize: Boolean = True; AShowCloseButton: Boolean = True);

    // Sizegrip
    function SizeGripSize: TSize; virtual;
    procedure DoDrawSizeGrip(ACanvas: TcxCanvas; const ARect: TRect); virtual;
    procedure DrawSizeGrip(ACanvas: TcxCanvas; const ARect: TRect;
      ABackgroundColor: TColor = clDefault; ACorner: TdxCorner = coBottomRight); virtual;
    // SmallCloseButton
    function SmallCloseButtonSize: TSize; virtual;
    procedure DrawSmallCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); virtual;
    // ms outlook
    procedure CalculateSchedulerNavigationButtonRects(AIsNextButton: Boolean;
      ACollapsed: Boolean; APrevButtonTextSize: TSize; ANextButtonTextSize: TSize;
      var ABounds: TRect; out ATextRect: TRect; out AArrowRect: TRect); virtual;
    procedure DrawMonthHeader(ACanvas: TcxCanvas; const ABounds: TRect;
      const AText: string; ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil); virtual;
    procedure DrawSchedulerBorder(ACanvas: TcxCanvas; R: TRect); virtual;
    procedure DrawSchedulerEventProgress(ACanvas: TcxCanvas;
      const ABounds, AProgress: TRect; AViewParams: TcxViewParams; ATransparent: Boolean); virtual;
    procedure DrawSchedulerNavigationButton(ACanvas: TcxCanvas;
      const ARect: TRect; AIsNextButton: Boolean; AState: TcxButtonState;
      const AText: string; const ATextRect: TRect; const AArrowRect: TRect); virtual;
    procedure DrawSchedulerNavigationButtonArrow(ACanvas: TcxCanvas;
      const ARect: TRect; AIsNextButton: Boolean; AColor: TColor); virtual;
    procedure DrawSchedulerNavigatorButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); virtual;
    procedure DrawSchedulerSplitterBorder(ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean); virtual;
    function SchedulerEventProgressOffsets: TRect; virtual;
    function SchedulerNavigationButtonTextColor(AIsNextButton: Boolean;
      AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor; virtual;
    procedure SchedulerNavigationButtonSizes(AIsNextButton: Boolean;
      var ABorders: TRect; var AArrowSize: TSize; var AHasTextArea: Boolean); virtual;
    // chart view
    function ChartToolBoxDataLevelInfoBorderSize: Integer; virtual;
    // editors
    procedure DrawClock(ACanvas: TcxCanvas; const ARect: TRect;
      ADateTime: TDateTime; ABackgroundColor: TColor); virtual;
    procedure DrawEditorButton(ACanvas: TcxCanvas; const ARect: TRect;
      AButtonKind: TcxEditBtnKind; AState: TcxButtonState;
      APosition: TcxEditBtnPosition = cxbpRight); virtual;
    function EditButtonTextOffset: Integer; virtual;
    function EditButtonSize: TSize; virtual;
    function EditButtonTextColor: TColor; virtual;
    function GetContainerBorderColor(AIsHighlightBorder: Boolean): TColor; virtual;
    function GetContainerBorderWidth(ABorderStyle: TcxContainerBorderStyle): Integer; virtual;
    // DateNavigator
    procedure DrawDateNavigatorDateHeader(ACanvas: TcxCanvas; var R: TRect); virtual;
    // navigator
    procedure DrawNavigatorGlyph(ACanvas: TcxCanvas; AImageList: TCustomImageList;
      AImageIndex: TImageIndex; AButtonIndex: Integer; const AGlyphRect: TRect;
      AEnabled: Boolean; AUserGlyphs: Boolean); virtual;
    function NavigatorGlyphSize: TSize; virtual;
    // ProgressBar
    procedure DrawProgressBarBorder(ACanvas: TcxCanvas; ARect: TRect; AVertical: Boolean); virtual;
    procedure DrawProgressBarChunk(ACanvas: TcxCanvas; ARect: TRect; AVertical: Boolean); virtual;
    procedure DrawProgressBarText(ACanvas: TcxCanvas; AVertical, ASolid: Boolean;
      const AText: string; const ATextRect, AProgressBarRect, AProgressChunkRect: TRect;
      ATextColor: TColor = clDefault); virtual; 
    function ProgressBarBorderSize(AVertical: Boolean): TRect; virtual;
    function ProgressBarTextColor: TColor; virtual;
    function ProgressBarTextColorEx(AIsFilledArea: Boolean): TColor; virtual;
    // GroupBox
    procedure DrawGroupBoxBackground(ACanvas: TcxCanvas; ABounds: TRect;
      ARect: TRect); virtual;
    procedure DrawGroupBoxCaption(ACanvas: TcxCanvas; ACaptionRect: TRect;
      ACaptionPosition: TcxGroupBoxCaptionPosition); virtual;
    procedure DrawGroupBoxContent(ACanvas: TcxCanvas; ABorderRect: TRect;
      ACaptionPosition: TcxGroupBoxCaptionPosition; ABorders: TcxBorders = cxBordersAll); virtual;
    procedure DrawGroupBoxExpandButton(ACanvas: TcxCanvas;
      const R: TRect; AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0); virtual;
    procedure DrawGroupBoxFrame(ACanvas: TcxCanvas; R: TRect; AEnabled: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition; ABorders: TcxBorders = cxBordersAll); virtual;
    function GroupBoxBorderSize(ACaption: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition): TRect; virtual;
    function GroupBoxTextColor(AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TColor; virtual;
    function IsGroupBoxTransparent(AIsCaption: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition): Boolean; virtual;
    // Panel
    procedure DrawPanelBackground(ACanvas: TcxCanvas; AControl: TWinControl; ABounds: TRect;
      AColorFrom: TColor = clDefault; AColorTo: TColor = clDefault); virtual;
    procedure DrawPanelBorders(ACanvas: TcxCanvas; const ABorderRect: TRect); virtual;
    procedure DrawPanelCaption(ACanvas: TcxCanvas; const ACaptionRect: TRect;
      ACaptionPosition: TcxGroupBoxCaptionPosition); virtual;
    procedure DrawPanelContent(ACanvas: TcxCanvas; const ABorderRect: TRect;
      ABorder: Boolean); virtual;
    function PanelBorderSize: TRect; virtual;
    function PanelTextColor: TColor; virtual;
    // TrackBar
    procedure CorrectThumbRect(ACanvas: TcxCanvas; var ARect: TRect; AHorizontal: Boolean; ATicks: TcxTrackBarTicksAlign); virtual;
    procedure DrawTrackBarTrack(ACanvas: TcxCanvas; const ARect, ASelection: TRect;
      AShowSelection, AEnabled, AHorizontal: Boolean; ATrackColor: TColor); virtual;
    procedure DrawTrackBarTrackBounds(ACanvas: TcxCanvas; const ARect: TRect); virtual;
    procedure DrawTrackBarThumb(ACanvas: TcxCanvas; const ARect: TRect;
      AState: TcxButtonState; AHorizontal: Boolean;
      ATicks: TcxTrackBarTicksAlign; AThumbColor: TColor); virtual;
    procedure DrawTrackBarThumbBorderUpDown(ACanvas: TcxCanvas;
      const ALightPolyLine, AShadowPolyLine, ADarkPolyLine: TPointArray); virtual;
    procedure DrawTrackBarThumbBorderBoth(ACanvas: TcxCanvas; const ARect: TRect); virtual;
    function TrackBarThumbSize(AHorizontal: Boolean): TSize; virtual;
    function TrackBarTicksColor(AText: Boolean): TColor; virtual;
    function TrackBarTrackSize: Integer; virtual;
    // Splitter
    function GetSplitterInnerColor(AHighlighted: Boolean): TColor; virtual;
    function GetSplitterOuterColor(AHighlighted: Boolean): TColor; virtual;
    procedure DrawSplitter(ACanvas: TcxCanvas; const ARect: TRect;
      AHighlighted: Boolean; AClicked: Boolean; AHorizontal: Boolean); virtual;
    function GetSplitterSize(AHorizontal: Boolean): TSize; virtual;
    // LayoutControl
    function LayoutControlEmptyAreaColor: TColor; virtual;
    procedure DrawLayoutControlBackground(ACanvas: TcxCanvas; const R: TRect); virtual;
    // Printing System
    function PrintPreviewPageBordersWidth: TRect; virtual;
    procedure DrawPrintPreviewBackground(ACanvas: TcxCanvas; const R: TRect); virtual;
    procedure DrawPrintPreviewPageBackground(ACanvas: TcxCanvas;
      const ABorderRect, AContentRect: TRect; ASelected, ADrawContent: Boolean); virtual;
    // CalcEdit
    function CalcEditButtonTextColor(AButtonKind: TcxCalcButtonKind): TColor; virtual;
    // Customization Form
    function GetCustomizationFormListBackgroundColor: TColor; virtual;
  end;

  TcxCustomLookAndFeelPainterClass = class of TcxCustomLookAndFeelPainter;

  { TcxStandardLookAndFeelPainter }

  TcxStandardLookAndFeelPainter = class(TcxCustomLookAndFeelPainter)
  public
    function LookAndFeelName: string; override;
    function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    // border
    function BorderSize: Integer; override;
    procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
    // buttons
    function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; override;
    function ButtonTextOffset: Integer; override;
    function ButtonTextShift: Integer; override;
    procedure DrawButtonBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawGroupExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AState: TcxButtonState); override;
    function ExpandButtonSize: Integer; override;
    procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault); override;
    function IsButtonHotTrack: Boolean; override;
    // checkbox
    procedure DrawCheckBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    // header
    procedure DrawHeaderBorder(ACanvas: TcxCanvas; const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders); override;
    procedure DrawHeaderControlSectionBorder(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders; AState: TcxButtonState); override;
    procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); override;
    function HeaderBorderSize: Integer; override;
    function HeaderControlSectionBorderSize(
      AState: TcxButtonState = cxbsNormal): Integer; override;
    function SortingMarkSize: TPoint; override;
    // footer
    function FooterBorderSize: Integer; override;
    function FooterCellBorderSize: Integer; override;
    function FooterCellOffset: Integer; override;
    procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); override;
    procedure DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect); override;
    // filter
    procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    // tabs
    procedure DrawTabBorder(ACanvas: TcxCanvas; R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean); override;
    procedure DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AVertical: Boolean); override;
    function TabBorderSize(AVertical: Boolean): Integer; override;
    // scrollbars
    procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // ms outlook
    function DefaultSchedulerViewContentColor: TColor; override;
    procedure DrawMonthHeader(ACanvas: TcxCanvas; const ABounds: TRect;
      const AText: string; ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    procedure DrawSchedulerSplitterBorder(ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean); override;
    // GroupBox
    procedure DrawGroupBoxFrame(ACanvas: TcxCanvas; R: TRect; AEnabled: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition; ABorders: TcxBorders = cxBordersAll); override;
    // TrackBar
    procedure DrawTrackBarTrackBounds(ACanvas: TcxCanvas; const ARect: TRect); override;
    procedure DrawTrackBarThumbBorderUpDown(ACanvas: TcxCanvas;
      const ALightPolyLine, AShadowPolyLine, ADarkPolyLine: TPointArray); override;
    procedure DrawTrackBarThumbBorderBoth(ACanvas: TcxCanvas; const ARect: TRect); override;
  end;

  { TcxFlatLookAndFeelPainter }

  TcxFlatLookAndFeelPainter = class(TcxCustomLookAndFeelPainter)
  public
    function LookAndFeelName: string; override;
    function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    // border
    function BorderSize: Integer; override;
    procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
    // buttons
    function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; override;
    function ButtonTextOffset: Integer; override;
    function ButtonTextShift: Integer; override;
    procedure DrawButtonBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault); override;
    function ExpandButtonSize: Integer; override;
    function IsButtonHotTrack: Boolean; override;
    // checkbox
    procedure DrawCheckBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    // header
    procedure DrawHeaderBorder(ACanvas: TcxCanvas; const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders); override;
    procedure DrawHeaderControlSectionBorder(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders; AState: TcxButtonState); override;
    procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); override;
    function HeaderBorderSize: Integer; override;
    function SortingMarkSize: TPoint; override;
    // footer
    function FooterBorderSize: Integer; override;
    function FooterCellBorderSize: Integer; override;
    function FooterCellOffset: Integer; override;
    procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); override;
    procedure DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect); override;
    // filter
    procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    // tabs
    procedure DrawTabBorder(ACanvas: TcxCanvas; R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean); override;
    procedure DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AVertical: Boolean); override;
    function TabBorderSize(AVertical: Boolean): Integer; override;
    // scrollbars
    procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // ms outlook
    procedure DrawSchedulerSplitterBorder(ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean); override;
    // GroupBox
    procedure DrawGroupBoxFrame(ACanvas: TcxCanvas; R: TRect; AEnabled: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition; ABorders: TcxBorders = cxBordersAll); override;
    // Trackbar
    procedure DrawTrackBarTrackBounds(ACanvas: TcxCanvas; const ARect: TRect); override;
    procedure DrawTrackBarThumbBorderUpDown(ACanvas: TcxCanvas;
      const ALightPolyLine, AShadowPolyLine, ADarkPolyLine: TPointArray); override;
    procedure DrawTrackBarThumbBorderBoth(ACanvas: TcxCanvas; const ARect: TRect); override;
    // DateNavigator
    procedure DrawDateNavigatorDateHeader(ACanvas: TcxCanvas; var R: TRect); override;
    // Splitter
    function GetSplitterOuterColor(AHighlighted: Boolean): TColor; override;
  end;

  { TcxUltraFlatLookAndFeelPainter }

  TcxUltraFlatLookAndFeelPainter = class(TcxCustomLookAndFeelPainter)
  protected
    // filter
    function FilterDropDownButtonBorderColor(AState: TcxButtonState): TColor; virtual;
    // footer
    procedure DrawFooterBorderEx(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders); override;
    // Scheduler
    procedure DrawSchedulerNavigationButtonContent(ACanvas: TcxCanvas;
      const ARect: TRect; const AArrowRect: TRect; AIsNextButton: Boolean;
      AState: TcxButtonState); override;
    // tabs
    function TabBorderHighlightColor: TColor; virtual;
    function TabBorderDarkColor: TColor; virtual;
  public
    function LookAndFeelName: string; override;
    function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    // default
    function DefaultSchedulerBorderColor: TColor; override;
    // border
    function BorderHighlightColor: TColor; virtual;
    function BorderSize: Integer; override;
    procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
    procedure DrawSeparator(ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean); override;
    // buttons
    function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; override;
    function ButtonColor(AState: TcxButtonState): TColor; override;
    function ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect; override;
    function ButtonGroupBorderSizes(AButtonCount, AButtonIndex: Integer): TRect; override;
    function ButtonSymbolColor(AState: TcxButtonState;
      ADefaultColor: TColor = clDefault): TColor; override;
    function ButtonSymbolState(AState: TcxButtonState): TcxButtonState; override;
    function ButtonTextOffset: Integer; override;
    function ButtonTextShift: Integer; override;
    procedure DrawButtonBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawButtonInGroup(ACanvas: TcxCanvas; R: TRect;
      AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
      ABackgroundColor: TColor); override;
    procedure DrawButtonGroupBorder(ACanvas: TcxCanvas; R: TRect; AInplace, ASelected: Boolean); override;
    procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault); override;
    procedure DrawHeaderControlSectionBorder(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders; AState: TcxButtonState); override;
    procedure DrawHeaderControlSectionContent(ACanvas: TcxCanvas; const ABounds,
      ATextAreaBounds: TRect; AState: TcxButtonState; AAlignmentHorz: TAlignment;
      AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor); override;
    function ExpandButtonSize: Integer; override;
    function IsButtonHotTrack: Boolean; override;
    // checkbox
    procedure DrawCheckBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    // RadioButton
    function RadioButtonBodyColor(AState: TcxButtonState): TColor; override;
    // header
    procedure DrawHeaderBorder(ACanvas: TcxCanvas; const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders); override;
    procedure DrawHeaderEx(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); override;
    function HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders; override;
    function HeaderBorderSize: Integer; override;
    function SortingMarkSize: TPoint; override;
    // footer
    procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); override;
    procedure DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect); override;
    function FooterBorders: TcxBorders; override;
    function FooterBorderSize: Integer; override;
    function FooterCellBorderSize: Integer; override;
    function FooterCellOffset: Integer; override;
    // filter
    procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    function FilterCloseButtonSize: TPoint; override;
    // tabs
    procedure DrawTabBorder(ACanvas: TcxCanvas; R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean); override;
    procedure DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AVertical: Boolean); override;
    function TabBorderSize(AVertical: Boolean): Integer; override;
    // scrollbars
    procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // ms outlook
    procedure DrawSchedulerNavigatorButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawSchedulerSplitterBorder(ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean); override;
    // GroupBox
    procedure DrawGroupBoxFrame(ACanvas: TcxCanvas; R: TRect; AEnabled: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition; ABorders: TcxBorders = cxBordersAll); override;
    // TrackBar
    procedure DrawTrackBarTrackBounds(ACanvas: TcxCanvas; const ARect: TRect); override;
    procedure DrawTrackBarThumbBorderUpDown(ACanvas: TcxCanvas;
      const ALightPolyLine, AShadowPolyLine, ADarkPolyLine: TPointArray); override;
    procedure DrawTrackBarThumbBorderBoth(ACanvas: TcxCanvas; const ARect: TRect); override;
    // Printing System
    procedure DrawPrintPreviewBackground(ACanvas: TcxCanvas; const R: TRect); override;
    // Splitter
    function GetSplitterOuterColor(AHighlighted: Boolean): TColor; override;
    function GetSplitterSize(AHorizontal: Boolean): TSize; override;
  end;

  { TcxOffice11LookAndFeelPainter }

  TcxOffice11LookAndFeelPainter = class(TcxUltraFlatLookAndFeelPainter)
  protected
    function DefaultDateNavigatorHeaderHighlightTextColor: TColor; override;
    procedure DrawContent(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect; AState: Integer;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False); override;
    function HeaderBottomColor: TColor; virtual;
    function HeaderDarkEdgeColor: TColor; virtual;
    function HeaderHighlightEdgeColor: TColor; virtual;
    function HeaderTopColor: TColor; virtual;
    // filter
    function FilterDropDownButtonBorderColor(AState: TcxButtonState): TColor; override;
    // tabs
    function TabBorderHighlightColor: TColor; override;
    function TabBorderDarkColor: TColor; override;
    // scheduler3
    procedure DrawSchedulerNavigationButtonContent(ACanvas: TcxCanvas;
      const ARect: TRect; const AArrowRect: TRect; AIsNextButton: Boolean;
      AState: TcxButtonState); override;
  public
    function LookAndFeelName: string; override;
    function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    function NeedRedrawOnResize: Boolean; override;

    // colors
    function DefaultDateNavigatorHeaderColor: TColor; override;
    function DefaultDateNavigatorSelectionColor: TColor; override;
    function DefaultDateNavigatorSelectionTextColor: TColor; override;
    function DefaultFilterBoxColor: TColor; override;
    function DefaultFilterBoxTextColor: TColor; override;
    function DefaultFooterColor: TColor; override;
    function DefaultFooterTextColor: TColor; override;
    function DefaultGroupColor: TColor; override;
    function DefaultGroupByBoxColor: TColor; override;
    function DefaultGroupByBoxTextColor: TColor; override;
    function DefaultHeaderColor: TColor; override;
    function DefaultHeaderBackgroundColor: TColor; override;
    function DefaultSchedulerBorderColor: TColor; override;
    function DefaultSchedulerControlColor: TColor; override;
    function DefaultTabColor: TColor; override;
    function DefaultTabsBackgroundColor: TColor; override;
    function DefaultTimeGridMinorScaleColor: TColor; override;
    function DefaultTimeGridSelectionBarColor: TColor; override;
    // border
    function BorderHighlightColor: TColor; override;
    procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
    procedure DrawSeparator(ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean); override;
    // buttons
    function ButtonColor(AState: TcxButtonState): TColor; override;
    function ButtonSymbolColor(AState: TcxButtonState;
      ADefaultColor: TColor = clDefault): TColor; override;
    procedure DrawButtonBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean;
      AColor: TColor = clDefault); override;
    function DrawExpandButtonFirst: Boolean; override;
    procedure DrawSmallExpandButton(ACanvas: TcxCanvas; R: TRect; AExpanded: Boolean;
      ABorderColor: TColor; AColor: TColor = clDefault); override;
    function ExpandButtonSize: Integer; override;
    function SmallExpandButtonSize: Integer; override;
    // checkbox
    function CheckButtonColor(AState: TcxButtonState): TColor; override;
    // RadioButton
    function RadioButtonBodyColor(AState: TcxButtonState): TColor; override;
    // filter
    procedure DrawFilterDropDownButton(ACanvas: TcxCanvas;
      R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    // header
    procedure DrawHeader(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False;
      AInGroupByBox: Boolean = False); override;
    procedure DrawHeaderBorder(ACanvas: TcxCanvas; const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders); override;
    procedure DrawHeaderControlSection(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
      AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
      ABkColor: TColor); override;
    procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); override;
    function HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders; override;
    function HeaderBorderSize: Integer; override;
    function IsHeaderHotTrack: Boolean; override;
    // footer
    function FooterSeparatorColor: TColor; override;
    //LayoutView
    procedure LayoutViewDrawRecordCaption(ACanvas: TcxCanvas; const ABounds: TRect;
      APosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState); override;
    // tabs
    // scrollbars
    procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // ms outlook
    procedure DrawMonthHeader(ACanvas: TcxCanvas; const ABounds: TRect;
      const AText: string; ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    procedure DrawSchedulerNavigatorButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawSchedulerBorder(ACanvas: TcxCanvas; R: TRect); override;
    // SizeGrip
    procedure DoDrawSizeGrip(ACanvas: TcxCanvas; const ARect: TRect); override;
    // GroupBox
    procedure DrawGroupBoxFrame(ACanvas: TcxCanvas; R: TRect;
      AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition;
      ABorders: TcxBorders = cxBordersAll); override;
    function GroupBoxTextColor(AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TColor; override;
    // TrackBar
    procedure DrawTrackBarTrackBounds(ACanvas: TcxCanvas; const ARect: TRect); override;
    procedure DrawTrackBarThumbBorderUpDown(ACanvas: TcxCanvas;
      const ALightPolyLine, AShadowPolyLine, ADarkPolyLine: TPointArray); override;
    procedure DrawTrackBarThumbBorderBoth(ACanvas: TcxCanvas; const ARect: TRect); override;
    // Panel
    procedure DrawPanelBackground(ACanvas: TcxCanvas; AControl: TWinControl; ABounds: TRect;
      AColorFrom: TColor = clDefault; AColorTo: TColor = clDefault); override;
    // Layout Control
    procedure DrawLayoutControlBackground(ACanvas: TcxCanvas; const R: TRect); override;
    // DateNavigator
    procedure DrawDateNavigatorDateHeader(ACanvas: TcxCanvas; var R: TRect); override;
    // Splitter
    function GetSplitterInnerColor(AHighlighted: Boolean): TColor; override;
    function GetSplitterOuterColor(AHighlighted: Boolean): TColor; override;
  end;

  { TcxWinXPLookAndFeelPainter }

  TcxWinXPLookAndFeelPainter = class(TcxStandardLookAndFeelPainter)
  protected
    procedure DrawContent(ACanvas: TcxCanvas; ATheme: TdxTheme; APartId, AStateId: Integer;
      const ABounds, ATextAreaBounds: TRect; AAlignmentHorz: TAlignment;
      AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis, AShowPrefix: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor); reintroduce; virtual;
    procedure DrawSchedulerNavigationButtonContent(ACanvas: TcxCanvas;
      const ARect: TRect; const AArrowRect: TRect; AIsNextButton: Boolean;
      AState: TcxButtonState); override;
  public
    function LookAndFeelName: string; override;
    function LookAndFeelStyle: TcxLookAndFeelStyle; override;
    function NeedRedrawOnResize: Boolean; override;

    // colors
    function DefaultSchedulerBorderColor: TColor; override;
    // arrow
    procedure DrawArrow(ACanvas: TcxCanvas; const R: TRect; AArrowDirection: TcxArrowDirection; AColor: TColor); override;
    procedure DrawArrow(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState; AArrowDirection: TcxArrowDirection; ADrawBorder: Boolean = True); override;
    procedure DrawArrowBorder(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState); override;
    // border
    function BorderSize: Integer; override;
    procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
    procedure DrawSeparator(ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean); override;
    // buttons
    function AdjustGroupButtonDisplayRect(const R: TRect; AButtonCount, AButtonIndex: Integer): TRect; override;
    function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; override;
    function ButtonColor(AState: TcxButtonState): TColor; override;
    function ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect; override;
    function ButtonGroupBorderSizes(AButtonCount, AButtonIndex: Integer): TRect; override;
    function ButtonSymbolColor(AState: TcxButtonState;
      ADefaultColor: TColor = clDefault): TColor; override;
    function ButtonTextOffset: Integer; override;
    function ButtonTextShift: Integer; override;
    procedure DrawButton(ACanvas: TcxCanvas; R: TRect; const ACaption: string;
      AState: TcxButtonState; ADrawBorder: Boolean = True; AColor: TColor = clDefault;
      ATextColor: TColor = clDefault; AWordWrap: Boolean = False; AIsToolButton: Boolean = False); override;
    procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault); override;
    function DrawExpandButtonFirst: Boolean; override;
    procedure DrawGroupExpandButton(ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AState: TcxButtonState); override;
    procedure DrawSmallExpandButton(ACanvas: TcxCanvas; R: TRect; AExpanded: Boolean;
      ABorderColor: TColor; AColor: TColor = clDefault); override;
    function ExpandButtonSize: Integer; override;
    function GroupExpandButtonSize: Integer; override;
    function SmallExpandButtonSize: Integer; override;
    function IsButtonHotTrack: Boolean; override;
    function IsPointOverGroupExpandButton(const R: TRect; const P: TPoint): Boolean; override;
    // checkbox
    function CheckBorderSize: Integer; override;
    function CheckButtonSize: TSize; override;
    procedure DrawCheck(ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState;
      AChecked: Boolean; AColor: TColor); override;
    procedure DrawCheckBorder(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    // RadioGroup
    procedure DrawRadioButton(ACanvas: TcxCanvas; X, Y: Integer;
      AButtonState: TcxButtonState; AChecked: Boolean; AFocused: Boolean; ABrushColor: TColor;  AIsDesigning: Boolean = False); override;
    function RadioButtonSize: TSize; override;
    // header
    procedure DrawHeader(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False;
      AInGroupByBox: Boolean = False); override;
    procedure DrawHeaderPressed(ACanvas: TcxCanvas; const ABounds: TRect); override;
    procedure DrawHeaderControlSection(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
      AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
      ABkColor: TColor); override;
    procedure DrawSortingMark(ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean); override;
    function HeaderBorderSize: Integer; override;
    function HeaderControlSectionBorderSize(
      AState: TcxButtonState = cxbsNormal): Integer; override;
    function HeaderControlSectionContentBounds(const ABounds: TRect;
      AState: TcxButtonState): TRect; override;
//    function HeaderDrawCellsFirst: Boolean; override;
    function IsHeaderHotTrack: Boolean; override;
    function SortingMarkSize: TPoint; override;
    // footer
    procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); override;
    procedure DrawFooterCell(ACanvas: TcxCanvas; const ABounds: TRect;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    function FooterBorderSize: Integer; override;
    function FooterCellBorderSize: Integer; override;
    function FooterCellOffset: Integer; override;
    function FooterDrawCellsFirst: Boolean; override;
    // filter
    procedure DrawFilterCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    function FilterActivateButtonSize: TPoint; override;
    function FilterCloseButtonSize: TPoint; override;
    //LayoutView
    procedure LayoutViewDrawRecordCaption(ACanvas: TcxCanvas; const ABounds: TRect;
      APosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState); override;
    // tabs
    procedure DrawTab(ACanvas: TcxCanvas; R: TRect; ABorders: TcxBorders;
      const AText: string; AState: TcxButtonState; AVertical: Boolean; AFont: TFont;
      ATextColor, ABkColor: TColor; AShowPrefix: Boolean = False); override;
    procedure DrawTabBorder(ACanvas: TcxCanvas; R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean); override;
    procedure DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AVertical: Boolean); override;
    function IsDrawTabImplemented(AVertical: Boolean): Boolean; override;
    function IsTabHotTrack(AVertical: Boolean): Boolean; override;
    function TabBorderSize(AVertical: Boolean): Integer; override;
    // Splitter
    procedure DrawSplitter(ACanvas: TcxCanvas; const ARect: TRect;
      AHighlighted: Boolean; AClicked: Boolean; AHorizontal: Boolean); override;
    // indicator
    procedure DrawIndicatorItem(ACanvas: TcxCanvas; const R: TRect;
      AKind: TcxIndicatorKind; AColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    //function IndicatorDrawItemsFirst: Boolean; override;
    // scrollbars
    function ScrollBarMinimalThumbSize(AVertical: Boolean): Integer; override;
    procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // ms outlook
    function DefaultSchedulerViewContentColor: TColor; override;
    procedure DrawMonthHeader(ACanvas: TcxCanvas; const ABounds: TRect;
      const AText: string; ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    procedure DrawSchedulerEventProgress(ACanvas: TcxCanvas;
      const ABounds, AProgressChunk: TRect; AViewParams: TcxViewParams;
      ATransparent: Boolean); override;
    procedure DrawSchedulerNavigatorButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    procedure DrawSchedulerSplitterBorder(ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean); override;
    function SchedulerEventProgressOffsets: TRect; override;
    // SizeGrip
    function SizeGripSize: TSize; override;
    procedure DoDrawSizeGrip(ACanvas: TcxCanvas; const ARect: TRect); override;
    // CloseButton
    function SmallCloseButtonSize: TSize; override;
    // GroupBox
    procedure DrawGroupBoxFrame(ACanvas: TcxCanvas; R: TRect; AEnabled: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition; ABorders: TcxBorders = cxBordersAll); override;
    function GroupBoxTextColor(AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TColor; override;
    // Panel
    procedure DrawPanelBackground(ACanvas: TcxCanvas; AControl: TWinControl; ABounds: TRect;
      AColorFrom: TColor = clDefault; AColorTo: TColor = clDefault); override;
    // Popup
    procedure DrawEditPopupWindowBorder(ACanvas: TcxCanvas; var R: TRect;
      ABorderStyle: TcxEditPopupBorderStyle; AClientEdge: Boolean); override;
    function GetEditPopupWindowBorderWidth(AStyle: TcxEditPopupBorderStyle): Integer; override;
    function GetEditPopupWindowClientEdgeWidth(AStyle: TcxEditPopupBorderStyle): Integer; override;
    // TrackBar
    procedure CorrectThumbRect(ACanvas: TcxCanvas; var ARect: TRect; AHorizontal: Boolean; ATicks: TcxTrackBarTicksAlign); override;
    procedure DrawTrackBarTrack(ACanvas: TcxCanvas; const ARect, ASelection: TRect;
      AShowSelection, AEnabled, AHorizontal: Boolean; ATrackColor: TColor); override;
    procedure DrawTrackBarThumb(ACanvas: TcxCanvas; const ARect: TRect;
      AState: TcxButtonState; AHorizontal: Boolean;
      ATicks: TcxTrackBarTicksAlign; AThumbColor: TColor); override;
    // DateNavigator
    procedure DrawDateNavigatorDateHeader(ACanvas: TcxCanvas; var R: TRect); override;
  end;

  { TcxLookAndFeelPaintersManager }

  TcxLookAndFeelPaintersManager = class(TObject)
  private
    FListeners: TInterfaceList;
    FPainters: TcxObjectList;
    function GetCount: Integer;
    function GetItem(AIndex: Integer): TcxCustomLookAndFeelPainter;
  protected
    procedure DoPainterAdded(APainter: TcxCustomLookAndFeelPainter);
    procedure DoPainterRemoved(APainter: TcxCustomLookAndFeelPainter);
    procedure SortPainters;
    //
    property Listeners: TInterfaceList read FListeners;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure AddListener(const AListener: IcxLookAndFeelPainterListener);
    procedure RemoveListener(const AListener: IcxLookAndFeelPainterListener);

    function GetPainter(AStyle: TcxLookAndFeelStyle; out APainter: TcxCustomLookAndFeelPainter): Boolean; overload;
    function GetPainter(const AName: string; out APainter: TcxCustomLookAndFeelPainter): Boolean; overload;
    function GetPainter(AStyle: TcxLookAndFeelStyle): TcxCustomLookAndFeelPainter; overload;
    function GetPainter(const AName: string): TcxCustomLookAndFeelPainter; overload;

    function Register(APainter: TcxCustomLookAndFeelPainter): Boolean;
    function Unregister(const AName: string): Boolean;
    //
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxCustomLookAndFeelPainter read GetItem; default;
  end;

var
  cxEditStateColorKindMap: array[Boolean] of TcxEditStateColorKind = (esckDisabled, esckNormal);
  cxIndicatorImages: TImageList;
  cxLookAndFeelPaintersManager: TcxLookAndFeelPaintersManager;

function BtnStateToXPBtnState(AState: TcxButtonState): Integer;

procedure PrepareRadioButtonImageList;
procedure UpdateScrollBarBitmaps;

function cxTextRect(const R: TRect): TRect;
implementation

{$R cxLookAndFeelPainters.res}

uses
  Messages,
  Forms, SysUtils, dxThemeConsts, cxControls, cxLookAndFeels, Math, cxDrawTextUtils;

const
  FilterDropDownButtonWidth = 15;

  SortingMarkAreaWidth = 16;
  FilterActiveButtonWidth = 13;
  FilterActiveButtonHeight = 13;
  FilterCloseButtonWidth = 16;
  FilterCloseButtonHeight = 14;

  ActiveFilterButtonArrowColor = clBlue;
  cxContainerBorderWidthA1: array [TcxContainerBorderStyle] of Integer =
    (0, 1, 2, 2, 2, 1, 1);
  cxContainerBorderWidthA2: array [TcxLookAndFeelKind] of Integer =
    (2, 2, 1, 1);
  cxEditPopupClientEdgeWidthA: array[TcxEditPopupBorderStyle] of Integer =
    (0, 2, 2, 1);
  cxEditPopupWindowFrameWidthA: array[TcxEditPopupBorderStyle] of Integer =
    (0, 1, 4, 2);

type
  { TSystemPaletteChangedNotifier }

  TSystemPaletteChangedNotifier = class(TcxSystemPaletteChangedNotifier)
  protected
    procedure DoChanged; override;
  end;

  { TcxRadioButtonImageList }

  TcxRadioButtonImageList = class
  private
    FButtonMask: TBitmap;
    FList: TImageList;
    FRadioButtonCheckRect: TRect;
    FRadioButtonPattern: array of array of Integer;
    FRadioButtonRect: TRect;

    function GetImageIndex(ALookAndFeelKind: TcxLookAndFeelKind;
      AButtonState: TcxButtonState;
      AChecked, AFocused, AIsDesigning: Boolean): Integer;
    function GetImageListIndexMapIndex(ALookAndFeelKind: TcxLookAndFeelKind;
      AButtonState: TcxButtonState;
      AChecked, AFocused, AIsDesigning: Boolean): Integer;

    procedure CalculateRadioButtonSize;
    procedure PrepareRadioButtonPattern;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Draw(ACanvas: TcxCanvas; X, Y: Integer; ABrushColor: TColor;
      ALookAndFeelKind: TcxLookAndFeelKind; AButtonState: TcxButtonState;
      AChecked, AFocused, AIsDesigning: Boolean);
    function GetSize: TSize;
    procedure Prepare;
    procedure Reset;
  end;
  
var
  FCheckButtonSize: TSize;
  FRadioButtonImageList: TcxRadioButtonImageList;
  FRadioButtonImageListIndexes: array of Integer;
  FRadioButtonSize: TSize;
  FSystemPaletteChangedNotifier: TSystemPaletteChangedNotifier;
  StdScrollBitmaps: array[Boolean] of TBitmap;

function RadioButtonImageList: TcxRadioButtonImageList;
begin
  if FRadioButtonImageList = nil then
  begin
    FRadioButtonImageList := TcxRadioButtonImageList.Create;
    FRadioButtonImageList.Prepare;
  end;
  Result := FRadioButtonImageList;
end;

const
//  FilledRadioButtonListSize = 48;
  cxPixelColorMask = $FFFFFF;

procedure InternalRoundRect(ACanvas: TCanvas; const R: TRect);
begin
  ACanvas.RoundRect(R.Left, R.Top, R.Right, R.Bottom, cxRectWidth(R) - 1, cxRectHeight(R) - 1);
end;

constructor TcxRadioButtonImageList.Create;

  procedure PrepareButtonMask;
  var
    R: TRect;
  begin
    FButtonMask := TBitmap.Create;
    FButtonMask.Monochrome := True;
    FButtonMask.Width := FRadioButtonSize.cx;
    FButtonMask.Height := FRadioButtonSize.cy;

    with FButtonMask.Canvas do
    begin
      Brush.Color := clWhite;
      R := Rect(0, 0, FRadioButtonSize.cx, FRadioButtonSize.cy);
      FillRect(R);
      Brush.Color := clBlack;
      Pen.Color := clBlack;
      InternalRoundRect(FButtonMask.Canvas, R);
    end;
  end;

begin
  inherited Create;
  CalculateRadioButtonSize;
  FList := TImageList.Create(nil);
  with FList do
  begin
    Width := FRadioButtonSize.cx;
    Height := FRadioButtonSize.cy;
    Masked := True;
    ImageType := itImage;
  end;
  PrepareButtonMask;
  PrepareRadioButtonPattern;
end;

destructor TcxRadioButtonImageList.Destroy;
begin
  FreeAndNil(FList);
  FreeAndNil(FButtonMask);
  inherited Destroy;
end;

procedure TcxRadioButtonImageList.Draw(ACanvas: TcxCanvas; X, Y: Integer;
  ABrushColor: TColor; ALookAndFeelKind: TcxLookAndFeelKind;
  AButtonState: TcxButtonState; AChecked, AFocused, AIsDesigning: Boolean);

  procedure DrawGlyph(ACanvas: TcxCanvas; AImageList: TCustomImageList;
    AImageIndex: TImageIndex; const AGlyphRect: TRect; ABrushColor: TColor;
    AEnabled: Boolean; ABackgroundBitmap: TBitmap = nil);
  var
    ABitmap: TBitmap;
    ABrush: HBRUSH;
  begin
    ABitmap := nil;
    try
      if ABackgroundBitmap = nil then
      begin
        ABitmap := TBitmap.Create;
        ABitmap.Width := AImageList.Width;
        ABitmap.Height := AImageList.Height;
        ABrush := CreateSolidBrush(ColorToRGB(ABrushColor));
        Windows.FillRect(ABitmap.Canvas.Handle, Rect(0, 0, ABitmap.Width, ABitmap.Height), ABrush);
        DeleteObject(ABrush);
      end;
      if ABackgroundBitmap <> nil then
      begin
        AImageList.Draw(ABackgroundBitmap.Canvas, 0, 0, AImageIndex, AEnabled); // ??? itMask TODO
        ACanvas.Draw(AGlyphRect.Left, AGlyphRect.Top, ABackgroundBitmap);
      end else
      begin
        AImageList.Draw(ABitmap.Canvas, 0, 0, AImageIndex, AEnabled); // ??? itMask TODO
        ACanvas.Draw(AGlyphRect.Left, AGlyphRect.Top, ABitmap);
      end;
    finally
      if ABitmap <> nil then
        ABitmap.Free;
    end;
  end;

var
  AImageIndex: Integer;
begin
  AImageIndex := GetImageIndex(ALookAndFeelKind, AButtonState, AChecked,
    AFocused, AIsDesigning);
  if ABrushColor = clDefault then
    FList.Draw(ACanvas.Canvas, X, Y, AImageIndex)
  else
    DrawGlyph(ACanvas, FList, AImageIndex, Rect(X, Y, X + FList.Width,
      Y + FList.Height), ABrushColor, True);
end;

function TcxRadioButtonImageList.GetSize: TSize;
begin
  Result := Size(FList.Width, FList.Height);
end;

procedure TcxRadioButtonImageList.Prepare;
var
  AColorMap: array[0..6] of TColor;

  function GetRadioButtonBodyColor(ALookAndFeelKind: TcxLookAndFeelKind; AButtonState: TcxButtonState): TColor;
  var
    APainter: TcxCustomLookAndFeelPainter;
  begin
    if cxLookAndFeelPaintersManager.GetPainter(cxLookAndFeelStyleMap[ALookAndFeelKind], APainter) then
      Result := APainter.RadioButtonBodyColor(AButtonState)
    else
      Result := clWindow;
  end;

  procedure PrepareColorMap(ALookAndFeelKind: TcxLookAndFeelKind;
    AButtonState: TcxButtonState; AChecked, AFocused, AIsDesigning: Boolean);
  var
    I: Integer;
  begin
    AColorMap[0] := clBlack;
    AColorMap[5] := GetRadioButtonBodyColor(ALookAndFeelKind, AButtonState);
    case ALookAndFeelKind of
      lfStandard:
        begin
          AColorMap[1] := clBtnShadow;
          AColorMap[2] := clBtnHighlight;
          AColorMap[3] := cl3DDkShadow;
          AColorMap[4] := cl3DLight;
        end;
      lfFlat:
        begin
          AColorMap[1] := clBtnShadow;
          AColorMap[2] := clBtnHighlight;
          AColorMap[3] := cl3DLight;
          AColorMap[4] := cl3DLight;
        end;
      lfUltraFlat:
        begin
          if AFocused or (AButtonState in [cxbsHot, cxbsPressed]) or (AIsDesigning and
              (AButtonState <> cxbsDisabled)) then
            AColorMap[1] := clHighlight
          else
            AColorMap[1] := clBtnShadow;
          AColorMap[2] := AColorMap[1];
          AColorMap[3] := AColorMap[5];
          AColorMap[4] := AColorMap[5];
        end;
      lfOffice11: // TODO: to method
        begin
          if AButtonState = cxbsDisabled then
            AColorMap[1] := dxOffice11TextDisabledColor
          else
            if AFocused or (AButtonState in [cxbsHot, cxbsPressed]) or AIsDesigning then
              AColorMap[1] := dxOffice11SelectedBorderColor
            else
              AColorMap[1] := clBtnText;//dxOffice11BarFloatingBorderColor1; //clBtnShadow;
          AColorMap[2] := AColorMap[1];
          AColorMap[3] := AColorMap[5];
          AColorMap[4] := AColorMap[5];
        end;
    end;

    if not AChecked then
      AColorMap[6] := AColorMap[5]
    else
      if AButtonState <> cxbsDisabled then
        AColorMap[6] := clWindowText
      else
        if ALookAndFeelKind = lfOffice11 then
          AColorMap[6] := dxOffice11TextDisabledColor
        else
          AColorMap[6] := clBtnShadow;

    for I := 0 to 6 do
    begin
      AColorMap[I] := ColorToRGB(AColorMap[I]);
      AColorMap[I] := RGB(GetBValue(AColorMap[I]), GetGValue(AColorMap[I]), GetRValue(AColorMap[I]));
    end;
  end;

var
  ABitmap: TBitmap;
  AButtonState: TcxButtonState;
  AChecked, AFocused, AIsDesigning: Boolean;
  AImageListIndexMapIndex, I, J: Integer;
  ALookAndFeelKind: TcxLookAndFeelKind;
  ABitmapInfo: TBitmapInfo;
  RGBs: array of Integer;
begin
  if FList.Count > 0 then exit;
  ABitmap := TBitmap.Create;
  try
    ABitmap.Width := FRadioButtonSize.cx;
    ABitmap.Height := FRadioButtonSize.cy;
    ABitmap.PixelFormat := pf32bit;
    ABitmap.HandleType := bmDDB;
    SetLength(RGBs, ABitmap.Width * ABitmap.Height);
    ABitmapInfo.bmiHeader.biSize := SizeOf(ABitmapInfo.bmiHeader);
    ABitmapInfo.bmiHeader.biWidth := ABitmap.Width;
    ABitmapInfo.bmiHeader.biHeight := -ABitmap.Height;
    ABitmapInfo.bmiHeader.biPlanes := 1;
    ABitmapInfo.bmiHeader.biBitCount := 32;
    ABitmapInfo.bmiHeader.biCompression := BI_RGB;

    for AFocused := False to True do
      for AIsDesigning := False to True do
        for ALookAndFeelKind := Low(TcxLookAndFeelKind) to High(TcxLookAndFeelKind) do
          for AChecked := False to True do
            for AButtonState := Succ(Low(TcxButtonState)) to High(TcxButtonState) do
            begin
              PrepareColorMap(ALookAndFeelKind, AButtonState, AChecked,
                AFocused, AIsDesigning);
              for I := 0 to FRadioButtonSize.cy - 1 do
                for J := 0 to FRadioButtonSize.cx - 1 do
                  RGBs[I * ABitmap.Width + J] := AColorMap[FRadioButtonPattern[I, J]];
              SetDIBits(ABitmap.Canvas.Handle, ABitmap.Handle, 0, ABitmap.Height, RGBs, ABitmapInfo, DIB_RGB_COLORS);
              FList.Add(ABitmap, FButtonMask);
              AImageListIndexMapIndex := GetImageListIndexMapIndex(
                ALookAndFeelKind, AButtonState, AChecked, AFocused, AIsDesigning);
              if AImageListIndexMapIndex + 1 > Length(FRadioButtonImageListIndexes) then
                SetLength(FRadioButtonImageListIndexes, AImageListIndexMapIndex + 1);
              FRadioButtonImageListIndexes[AImageListIndexMapIndex] := FList.Count - 1;
            end;
  finally
    ABitmap.Free;
  end;
end;

procedure TcxRadioButtonImageList.Reset;
begin
  FList.Clear;
  Prepare;
end;

function TcxRadioButtonImageList.GetImageIndex(
  ALookAndFeelKind: TcxLookAndFeelKind; AButtonState: TcxButtonState;
  AChecked, AFocused, AIsDesigning: Boolean): Integer;
begin
  Result := FRadioButtonImageListIndexes[
    GetImageListIndexMapIndex(ALookAndFeelKind, AButtonState, AChecked,
    AFocused, AIsDesigning)];
end;

function TcxRadioButtonImageList.GetImageListIndexMapIndex(
  ALookAndFeelKind: TcxLookAndFeelKind; AButtonState: TcxButtonState;
  AChecked, AFocused, AIsDesigning: Boolean): Integer;
var
  AButtonStateIndex: Integer;
  ALookAndFeelKindCount: Integer;
begin
  AButtonStateIndex := Integer(AButtonState) - 1;
  ALookAndFeelKindCount := Integer(High(TcxLookAndFeelKind)) -
    Integer(Low(TcxLookAndFeelKind)) + 1;

  Result := (Integer(AFocused) * 2 * ALookAndFeelKindCount + Integer(AIsDesigning) * ALookAndFeelKindCount +
    Integer(ALookAndFeelKind)) * 8 + Integer(AChecked) * 4 + AButtonStateIndex;
end;

procedure TcxRadioButtonImageList.CalculateRadioButtonSize;
var
  B: Windows.TBitmap;
  HB: HBITMAP;
  ABitmap: TBitmap;
  I, J: Integer;
  FRadioButtonMaskSize: TSize;
begin
  HB := LoadBitmap(0, PChar(OBM_CHECKBOXES));
  try
    cxGetBitmapData(HB, B);
  finally
    DeleteObject(HB);
  end;
  FRadioButtonMaskSize.cx := B.bmWidth div 4;
  FRadioButtonMaskSize.cy := B.bmHeight div 3;
  ABitmap := cxCreateBitmap(FRadioButtonMaskSize);
  try
    ABitmap.Canvas.Brush.Color := 0;
    ABitmap.Canvas.FillRect(Rect(0, 0, FRadioButtonMaskSize.cx, FRadioButtonMaskSize.cy));
    DrawFrameControl(ABitmap.Canvas.Handle, Rect(0, 0, FRadioButtonMaskSize.cx,
      FRadioButtonMaskSize.cy), DFC_BUTTON, DFCS_BUTTONRADIOMASK + DFCS_FLAT);
    FRadioButtonSize.cX := 0;
    FRadioButtonSize.cY := 0;
    FRadioButtonRect.Left := -1;
    FRadioButtonRect.Top := -1;
    for J := 0 to FRadioButtonMaskSize.cx - 1 do
      for I := 0 to FRadioButtonMaskSize.cy - 1 do
        if ABitmap.Canvas.Pixels[J, I] = 0 then
        begin
          if FRadioButtonRect.Left = -1 then
            FRadioButtonRect.Left := J;
          Inc(FRadioButtonSize.cX);
          Break;
        end;
    for I := 0 to FRadioButtonMaskSize.cy - 1 do
      for J := 0 to FRadioButtonMaskSize.cx - 1 do
        if ABitmap.Canvas.Pixels[J, I] = 0 then
        begin
          if FRadioButtonRect.Top = -1 then
            FRadioButtonRect.Top := I;
          Inc(FRadioButtonSize.cY);
          Break;
        end;
    FRadioButtonRect.Right := FRadioButtonRect.Left + FRadioButtonSize.cx;
    FRadioButtonRect.Bottom := FRadioButtonRect.Top + FRadioButtonSize.cy;
    ABitmap.Canvas.Brush.Color := 0;
    ABitmap.Canvas.FillRect(Rect(0, 0, FRadioButtonMaskSize.cx, FRadioButtonMaskSize.cy));
    DrawFrameControl(ABitmap.Canvas.Handle, Rect(0, 0, FRadioButtonMaskSize.cx,
      FRadioButtonMaskSize.cy), DFC_BUTTON, DFCS_BUTTONRADIOIMAGE + DFCS_FLAT + DFCS_CHECKED);
    I := FRadioButtonRect.Top + (FRadioButtonSize.cy div 2) - 2;
    J := FRadioButtonRect.Left + (FRadioButtonSize.cx div 2) - 1;
    while ABitmap.Canvas.Pixels[J, I] = ColorToRGB(clWindowText) do
      Dec(I);
    Inc(I);
    FRadioButtonCheckRect.Top := I;
    repeat
      Inc(I);
    until ABitmap.Canvas.Pixels[J, I] <> ColorToRGB(clWindowText);
    FRadioButtonCheckRect.Bottom := I;

    I := FRadioButtonRect.Top + (FRadioButtonSize.cy div 2) - 1;
    J := FRadioButtonRect.Left + (FRadioButtonSize.cx div 2) - 2;
    while ABitmap.Canvas.Pixels[J, I] = ColorToRGB(clWindowText) do
      Dec(J);
    Inc(J);
    FRadioButtonCheckRect.Left := J;
    repeat
      Inc(J);
    until ABitmap.Canvas.Pixels[J, I] <> ColorToRGB(clWindowText);
    FRadioButtonCheckRect.Right := J;
  finally
    ABitmap.Free;
  end;
end;

procedure TcxRadioButtonImageList.PrepareRadioButtonPattern;

  procedure PrepareOuterCircle;
  var
    ABitmap: TBitmap;
    I, J: Integer;
  begin
    ABitmap := cxCreateBitmap(FRadioButtonSize, pf32bit);
    try
      ABitmap.Canvas.Brush.Color := clWhite;
      ABitmap.Canvas.FillRect(cxRect(cxNullPoint, cxPoint(FRadioButtonSize)));
      ABitmap.Canvas.Pen.Color := clBlack;
      InternalRoundRect(ABitmap.Canvas, cxRect(cxNullPoint, cxPoint(FRadioButtonSize)));
      SetLength(FRadioButtonPattern, FRadioButtonSize.cy, FRadioButtonSize.cx);
      for I := 0 to FRadioButtonSize.cy - 1 do
      begin
        for J := 0 to FRadioButtonSize.cx - 1 do
        begin
          if ABitmap.Canvas.Pixels[J, I] and cxPixelColorMask <> 0 then
            FRadioButtonPattern[I, J] := 0
          else
            if (FRadioButtonSize.cy - 1) * (FRadioButtonSize.cx - 1 - J) < I * (FRadioButtonSize.cx - 1) then
              FRadioButtonPattern[I, J] := 2
            else
              FRadioButtonPattern[I, J] := 1;
        end;
      end;
    finally
      ABitmap.Free;
    end;
  end;

  procedure PrepareInnerCircle;

    procedure FillPoint(I, J: Integer);
    var
      ASign: Integer;
    begin
      ASign := (FRadioButtonSize.cy - 1) * (FRadioButtonSize.cx - 1 - J) - I * (FRadioButtonSize.cx - 1);
      if ASign = 0 then
        if J <= FRadioButtonSize.cx div 2 - 1 then
          FRadioButtonPattern[I, J] := 3
        else
          FRadioButtonPattern[I, J] := 4
      else
        if ASign < 0 then
          FRadioButtonPattern[I, J] := 4
        else
          FRadioButtonPattern[I, J] := 3;
    end;

  var
    I, I1, J, J1: Integer;
    AFirstColumn, ALastColumn, AFirstRow, ALastRow: Integer;
  begin
    AFirstRow := 1;
    ALastRow := FRadioButtonSize.cy - 2;
    J1 := FRadioButtonSize.cx div 2 - 1;

    for I := AFirstRow to ALastRow do
    begin
      J := J1;
      while FRadioButtonPattern[I, J] = 0 do
      begin
        FRadioButtonPattern[I, J] := 5;
        Dec(J);
      end;
      J := J1 + 1;
      while FRadioButtonPattern[I, J] = 0 do
      begin
        FRadioButtonPattern[I, J] := 5;
        Inc(J);
      end;
    end;

    for I := AFirstRow to ALastRow do
    begin
      J := J1;
      while not(FRadioButtonPattern[I, J] in [1, 2]) do
      begin
        if (I = AFirstRow) or (I = ALastRow) then
          FillPoint(I, J);
        Dec(J);
      end;
      Inc(J);
      FillPoint(I, J);
      J := J1 + 1;
      while not(FRadioButtonPattern[I, J] in [1, 2]) do
      begin
        if (I = AFirstRow) or (I = ALastRow) then
          FillPoint(I, J);
        Inc(J);
      end;
      Dec(J);
      FillPoint(I, J);
    end;

    AFirstColumn := 1;
    ALastColumn := FRadioButtonSize.cx - 2;
    I1 := FRadioButtonSize.cy div 2 - 1;
    for J := AFirstColumn to ALastColumn do
    begin
      I := I1;
      while not(FRadioButtonPattern[I, J] in [1, 2]) do
      begin
        if (J = AFirstColumn) or (J = ALastColumn) then
          FillPoint(I, J);
        Dec(I);
      end;
      Inc(I);
      FillPoint(I, J);
      I := I1 + 1;
      while not(FRadioButtonPattern[I, J] in [1, 2]) do
      begin
        if (J = AFirstColumn) or (J = ALastColumn) then
          FillPoint(I, J);
        Inc(I);
      end;
      Dec(I);
      FillPoint(I, J);
    end;
  end;

  procedure PrepareCheck;
  var
    ABitmap: TBitmap;
    I, J: Integer;
    R: TRect;
  begin
    ABitmap := cxCreateBitmap(FRadioButtonSize, pf32Bit);
    try
      ABitmap.Canvas.Brush.Color := clWhite;
      ABitmap.Canvas.FillRect(cxRect(cxNullPoint, cxPoint(FRadioButtonSize)));
      ABitmap.Canvas.Pen.Color := clBlack;
      ABitmap.Canvas.Brush.Color := clBlack;
      R := cxRectOffset(FRadioButtonCheckRect, cxPointInvert(FRadioButtonRect.TopLeft));
      InternalRoundRect(ABitmap.Canvas, R);
      for I := 0 to FRadioButtonSize.cy - 1 do
      begin
        for J := 0 to FRadioButtonSize.cx - 1 do
        begin
          if ABitmap.Canvas.Pixels[J, I] and cxPixelColorMask = 0 then
            FRadioButtonPattern[I, J] := 6;
        end;
      end;
    finally
      ABitmap.Free;
    end;
  end;

begin
  PrepareOuterCircle;
  PrepareInnerCircle;
  PrepareCheck;
end;

{ TSystemPaletteChangedNotifier }

procedure TSystemPaletteChangedNotifier.DoChanged;
begin
  if FRadioButtonImageList <> nil then
    FRadioButtonImageList.Reset;
end;

{ TcxCustomLookAndFeelPainter }

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorHeaderHighlightTextColor: TColor;
begin
  if IsWinVistaOrLater then
    Result := $CC6600
  else
    Result := clHighlightText;
end;

procedure TcxCustomLookAndFeelPainter.DrawBackground(ACanvas: TcxCanvas;
  const ARect: TRect; ATransparent: Boolean; ABackgroundColor: TColor;
  const ABackgroundBitmap: TBitmap);
begin
  if not ATransparent then
  begin
    ACanvas.Brush.Color := ABackgroundColor;
    ACanvas.FillRect(ARect);
  end
  else
    if ABackgroundBitmap <> nil then
      ACanvas.FillRect(ARect, ABackgroundBitmap);
end;

procedure TcxCustomLookAndFeelPainter.DrawButtonArrow(ACanvas: TcxCanvas;
  const R: TRect; AColor: TColor);
var
  P: array[0..2] of TPoint;

  procedure CalculatePoints;
  var
    ASize: TPoint;

    function _GetSize: TPoint;
    begin
      Result.X := (R.Right - R.Left) div 2;
      if not Odd(Result.X) then Inc(Result.X);
      Result.Y := Result.X div 2 + 1;
    end;

  begin
    with R do
    begin
      ASize := _GetSize;
      P[0] := Point((Left + Right - ASize.X) div 2, MulDiv(Top + Bottom - ASize.Y, 1, 2));
      P[1] := Point(P[0].X + ASize.X - 1, P[0].Y);
      P[2] := Point(P[0].X + ASize.X div 2, P[0].Y + ASize.Y - 1);
    end;
  end;

begin
  CalculatePoints;
  with ACanvas do
  begin
    Brush.Color := AColor;
    Pen.Color := AColor;
    Polygon(P);
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawContent(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; AState: Integer; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False);
const
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
begin
  with ACanvas do
  begin
    if not Assigned(AOnDrawBackground) or not AOnDrawBackground(ACanvas, ABounds) then
    begin
      SetBrushColor(ABkColor);
      FillRect(ABounds);
    end;
    if AText <> '' then
    begin
      Brush.Style := bsClear;
      Font := AFont;
      Font.Color := ATextColor;
      DrawText(AText, ATextAreaBounds, cxAlignmentsHorz[AAlignmentHorz] or
        cxAlignmentsVert[AAlignmentVert] or MultiLines[AMultiLine] or
        ShowEndEllipsises[AShowEndEllipsis]);
      Brush.Style := bsSolid;
    end;
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawExpandButtonCross(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor);
var
  ASize, X, Y: Integer;
begin
  with R do
  begin
    ASize := Right - Left - 2 * 2;
    X := GetRangeCenter(Left, Right);
    Y := GetRangeCenter(Top, Bottom);
  end;
  ACanvas.Brush.Color := AColor;
  ACanvas.FillRect(Rect(X - ASize div 2, Y, X + ASize div 2 + 1, Y + 1));
  if not AExpanded then
    ACanvas.FillRect(Rect(X, Y - ASize div 2, X + 1, Y + ASize div 2 + 1));
end;

procedure TcxCustomLookAndFeelPainter.DrawFooterBorderEx(ACanvas: TcxCanvas;
  const R: TRect; ABorders: TcxBorders);
var
  ABounds: TRect;
begin
  DrawFooterSeparator(ACanvas, cxRectSetHeight(R, FooterSeparatorSize));
  ABounds := R;
  Inc(ABounds.Top, FooterSeparatorSize);
  DrawFooterBorder(ACanvas, ABounds);
end;

procedure TcxCustomLookAndFeelPainter.DrawGroupExpandButtonMark(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AState: TcxButtonState);
var
  Size, X, MainY, I: Integer;

  procedure DrawOneMark(Y: Integer);
  var
    ASign, ADelta: Integer;
  begin
    if AExpanded then Inc(Y, Size);
    ASign := 2 * Ord(AExpanded) - 1;
    ADelta := Ord(Odd(I - MainY));
    if not AExpanded then
      ADelta := Ord(not Boolean(ADelta));
    ACanvas.MoveTo(X + ADelta, Y - ASign * ADelta);
    ACanvas.LineTo(X + Size, Y - ASign * Size);
    ACanvas.LineTo(X + 2 * Size + 1 - ADelta, Y + ASign * (1 - ADelta));
  end;

begin
  Size := 3;
  ACanvas.Pen.Color := ButtonSymbolColor(AState);
  with R do
  begin
    X := (Left + Right - (2 * Size + 1)) div 2;
    MainY := (Top + Bottom - 2 * (Size + 1)) div 2;
    for I := MainY to MainY + 4 - 1 do
      DrawOneMark(I + Ord(I >= MainY + 2) * (Size - 1));
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawIndicatorCustomizationMark(
  ACanvas: TcxCanvas; const R: TRect; AColor: TColor);
const
  LineOffset = 3;
  LineCount = 5;
var
  X, Y, AWidth, I: Integer;

  procedure DrawLine(X, Y: Integer; AChecked: Boolean);
  begin
    with ACanvas do
    begin
      if AChecked then
        Pixels[X, Y] := Pen.Color;
      MoveTo(X + 2, Y);
      LineTo(X + AWidth, Y);
    end;
  end;

begin
  X := R.Left + LineOffset;
  AWidth := R.Right - R.Left - 2 * LineOffset;
  Y := (R.Top + R.Bottom - (2 * LineCount - 1)) div 2;
  ACanvas.Pen.Color := AColor;
  for I := 0 to LineCount - 1 do
  begin
    DrawLine(X, Y, not Odd(I));
    Inc(Y, 2);
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawIndicatorImage(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind);
var
  X, Y: Integer;
begin
  if AKind = ikNone then Exit;
  with cxIndicatorImages, R do
  begin
    X := (Left + Right - Width) div 2;
    Y := (Top + Bottom - Height) div 2;
  end;
  cxIndicatorImages.Draw(ACanvas.Canvas, X, Y, Ord(AKind) - 1);
end;

procedure TcxCustomLookAndFeelPainter.DrawMonthHeaderArrows(
  ACanvas: TcxCanvas; const ABounds: TRect; AArrows: TcxHeaderArrows;
  ASideWidth: Integer; AColor: TColor);
var
  R: TRect;

  procedure InternalDrawArrow(LeftArrow: Boolean);
  var
    X, Sign, ArrowHeight: Integer;
    P: array[1..3] of TPoint;
  begin
    with R do
    begin
      ArrowHeight := (Bottom - Top) div 2;
      if not Odd(ArrowHeight) then Inc(ArrowHeight);
      if LeftArrow then X := Left
      else X := Right;
      Sign := 2 * Byte(LeftArrow) - 1;
      P[1] := Point(X + Sign * (ASideWidth - 1), (Top + Bottom - ArrowHeight) div 2 - 1);
      P[2] := Point(P[1].X, P[1].Y + ArrowHeight + 1);
      P[3] := Point(P[1].X - Sign * (ArrowHeight div 2 + 1), P[1].Y + ArrowHeight div 2 + 1);
      ACanvas.SetBrushColor(AColor);
      ACanvas.Pen.Color := AColor;
      ACanvas.Polygon(P);
    end;
  end;

begin
  R := ABounds;
  Inc(R.Top, BorderSize);
  InflateRect(R, 0, -1);
  if AArrows in [haLeft, haBoth] then
    InternalDrawArrow(True);
  if AArrows in [haRight, haBoth] then
    InternalDrawArrow(False);
end;

procedure TcxCustomLookAndFeelPainter.DrawSortingArrow(ACanvas: TcxCanvas;
  const R: TRect; AColor1, AColor2: TColor; AAscendingSorting: Boolean);
var
  Sign, AWidth, AHeight, X, Y, ALeftSide, ARightSide: Integer;
begin
  Sign := 2 * Byte(AAscendingSorting) - 1;
  with SortingMarkSize do
  begin
    AWidth := X;
    AHeight := Y;
  end;

  X := (R.Left + R.Right) div 2;
  if not Odd(AWidth) then Dec(X);
  if AAscendingSorting then
    Y := (R.Top + R.Bottom - AHeight) div 2
  else
    Y := (R.Top + R.Bottom + AHeight) div 2 - 1;

  ALeftSide := AWidth div 2;
  if not Odd(AWidth) then Dec(ALeftSide);
  ARightSide := AWidth div 2;

  ACanvas.Pen.Color := AColor2;
  ACanvas.MoveTo(X + ARightSide, Y + Sign * (AHeight - 2));
  ACanvas.LineTo(X + ARightSide - ALeftSide,
    Y);
  ACanvas.LineTo(X + ARightSide,
    Y + Sign * (AHeight - 1));
  if not AAscendingSorting then
    ACanvas.Pen.Color := AColor1;
  ACanvas.LineTo(X - ALeftSide, Y + Sign * (AHeight - 1));
  if AAscendingSorting then
    ACanvas.Pen.Color := AColor1;
  ACanvas.LineTo(X,
    Y);
  ACanvas.LineTo(X - ALeftSide, Y + Sign * (AHeight - Ord(Odd(AWidth))
    ));
end;

function TcxCustomLookAndFeelPainter.FooterCellContentBounds(const ABounds: TRect): TRect;
begin
  Result := ABounds;
  InflateRect(Result, -FooterCellBorderSize, -FooterCellBorderSize);
end;

function TcxCustomLookAndFeelPainter.FooterCellTextAreaBounds(const ABounds: TRect): TRect;
begin
  Result := FooterCellContentBounds(ABounds);
  InflateRect(Result, -cxTextOffset, -cxTextOffset);
end;

function TcxCustomLookAndFeelPainter.GetArrowDirection(AHorizontal: Boolean;
  APart: TcxScrollBarPart): TcxArrowDirection;
const
  ArrowKind: array[Boolean, Boolean] of TcxArrowDirection =
   ((adUp, adDown), (adLeft, adRight));
begin
  Result := ArrowKind[AHorizontal, APart <> sbpLineUp];
end;

function TcxCustomLookAndFeelPainter.GetSeparatorBounds(
  const R: TRect; AWidth: Integer; AIsVertical: Boolean): TRect;
var
  P: TPoint;
begin
  P := cxRectCenter(R);
  Result := R;
  if AIsVertical then
  begin
    Result.Left := P.X - AWidth div 2;
    Result.Right := Result.Left + AWidth;
  end
  else
  begin
    Result.Top := P.Y - AWidth div 2;
    Result.Bottom := Result.Top + AWidth;
  end;
end;

function TcxCustomLookAndFeelPainter.GetPainterData(var AData): Boolean;
begin
  Result := False;
end;

function TcxCustomLookAndFeelPainter.GetPainterDetails(var ADetails): Boolean;
begin
  Result := False;
end;

function TcxCustomLookAndFeelPainter.IsInternalPainter: Boolean;
begin
  Result := False;
end;

function TcxCustomLookAndFeelPainter.LookAndFeelName: string;
begin
  Result := '';
end;

function TcxCustomLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsStandard;
end;

function TcxCustomLookAndFeelPainter.NeedRedrawOnResize: Boolean;
begin
  Result := False;
end;

function TcxCustomLookAndFeelPainter.DefaultContentColor: TColor;
begin
  Result := clWindow;
end;

function TcxCustomLookAndFeelPainter.DefaultContentOddColor: TColor;
begin
  Result := DefaultContentColor;
end;

function TcxCustomLookAndFeelPainter.DefaultContentEvenColor: TColor;
begin
  Result := DefaultContentColor;
end;

function TcxCustomLookAndFeelPainter.DefaultContentTextColor: TColor;
begin
  Result := clWindowText;
end;

function TcxCustomLookAndFeelPainter.DefaultSchedulerBackgroundColor: TColor;
begin
  Result := clWindow;
end;

function TcxCustomLookAndFeelPainter.DefaultSchedulerTextColor: TColor;
begin
  Result := clWindowText;
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorTextColor: TColor;
begin
   Result := clWindowText;
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorHolydayTextColor: TColor;
begin
  Result := clRed;
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorInactiveTextColor: TColor;
begin
  Result := clGrayText;
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorSeparator1Color: TColor;
begin
  Result := clBtnShadow;
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorSeparator2Color: TColor;
begin
  Result := clWindow;
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorTodayFrameColor: TColor;
begin
  Result := clMaroon;
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorTodayTextColor: TColor;
begin
  Result := clNavy;
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorContentColor: TColor;
begin
  Result := DefaultEditorBackgroundColor(False);
  if Result = clDefault then
    Result := DefaultContentColor; 
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorHeaderColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorHeaderTextColor(
  AIsHighlight: Boolean): TColor;
begin
  if AIsHighlight then
    Result := DefaultDateNavigatorHeaderHighlightTextColor
  else
    Result := DefaultHeaderTextColor;
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorSelectionColor: TColor;
begin
  Result := clHighlight;
end;

function TcxCustomLookAndFeelPainter.DefaultDateNavigatorSelectionTextColor: TColor;
begin
  Result := clHighlightText;
end;

function TcxCustomLookAndFeelPainter.DefaultEditorBackgroundColor(
  AIsDisabled: Boolean): TColor;
begin
  Result := DefaultEditorBackgroundColorEx(cxEditStateColorKindMap[not AIsDisabled]);
end;

function TcxCustomLookAndFeelPainter.DefaultEditorTextColor(
  AIsDisabled: Boolean): TColor;
begin
  Result := DefaultEditorTextColorEx(cxEditStateColorKindMap[not AIsDisabled]);
end;

function TcxCustomLookAndFeelPainter.DefaultEditorBackgroundColorEx(
  AKind: TcxEditStateColorKind): TColor;
begin
  Result := clDefault;
end;

function TcxCustomLookAndFeelPainter.DefaultEditorTextColorEx(
  AKind: TcxEditStateColorKind): TColor;
begin
  Result := clDefault;
end;

function TcxCustomLookAndFeelPainter.DefaultFilterBoxColor: TColor;
begin
  Result := clBtnShadow;
end;

function TcxCustomLookAndFeelPainter.DefaultFilterBoxTextColor: TColor;
begin
  Result := clBtnHighlight;
end;

function TcxCustomLookAndFeelPainter.DefaultFixedSeparatorColor: TColor;
begin
  Result := clBtnText;
end;

function TcxCustomLookAndFeelPainter.DefaultFooterColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultFooterTextColor: TColor;
begin
  Result := clBtnText;
end;

function TcxCustomLookAndFeelPainter.DefaultGridDetailsSiteColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultGridLineColor: TColor;
begin
  Result := clBtnShadow;
end;

function TcxCustomLookAndFeelPainter.DefaultGroupColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultGroupTextColor: TColor;
begin
  Result := clBtnText;
end;

function TcxCustomLookAndFeelPainter.DefaultGroupByBoxColor: TColor;
begin
  Result := clBtnShadow;
end;

function TcxCustomLookAndFeelPainter.DefaultGroupByBoxTextColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultHeaderColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultHeaderTextColor: TColor;
begin
  Result := clBtnText;
end;

function TcxCustomLookAndFeelPainter.DefaultHeaderBackgroundColor: TColor;
begin
  Result := clBtnShadow;
end;

function TcxCustomLookAndFeelPainter.DefaultHeaderBackgroundTextColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultHyperlinkTextColor: TColor;
begin
  Result := clBlue;
end;

function TcxCustomLookAndFeelPainter.DefaultInactiveColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultInactiveTextColor: TColor;
begin
  Result := clBtnText;
end;

function TcxCustomLookAndFeelPainter.DefaultPreviewTextColor: TColor;
begin
  Result := clBlue;
end;

function TcxCustomLookAndFeelPainter.DefaultRecordSeparatorColor: TColor;
begin
  Result := DefaultGridLineColor;
end;

function TcxCustomLookAndFeelPainter.DefaultSizeGripAreaColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultVGridCategoryColor: TColor;
begin
  Result := DefaultHeaderColor;
end;

function TcxCustomLookAndFeelPainter.DefaultVGridCategoryTextColor: TColor;
begin
  Result := clDefault;
end;

function TcxCustomLookAndFeelPainter.DefaultVGridHeaderColor: TColor;
begin
  Result := DefaultHeaderColor;
end;

function TcxCustomLookAndFeelPainter.DefaultVGridHeaderTextColor: TColor;
begin
  Result := DefaultHeaderTextColor;
end;

function TcxCustomLookAndFeelPainter.DefaultVGridLineColor: TColor;
begin
  Result := clBlack; //todo
end;

function TcxCustomLookAndFeelPainter.DefaultVGridBandLineColor: TColor;
begin
  Result := DefaultVGridLineColor;
end;

function TcxCustomLookAndFeelPainter.DefaultSchedulerBorderColor: TColor;
begin
  Result := $9D9DA1;
end;

function TcxCustomLookAndFeelPainter.DefaultSchedulerControlColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultSchedulerTimeRulerColor: TColor;
begin
  Result := DefaultHeaderColor;
end;

function TcxCustomLookAndFeelPainter.DefaultSchedulerTimeRulerTextColor: TColor;
begin
  Result := DefaultHeaderTextColor;
end;

function TcxCustomLookAndFeelPainter.DefaultSchedulerViewContentColor: TColor;
begin
  Result := $D5FFFF;
end;

function TcxCustomLookAndFeelPainter.DefaultSchedulerNavigatorColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultSchedulerViewSelectedTextColor: TColor;
begin
  Result := DefaultSelectionTextColor;
end;

function TcxCustomLookAndFeelPainter.DefaultSchedulerViewTextColor: TColor;
begin
  Result := clWindowText;
end;

function TcxCustomLookAndFeelPainter.DefaultSelectionColor: TColor;
begin
  Result := clHighlight;
end;

function TcxCustomLookAndFeelPainter.DefaultSelectionTextColor: TColor;
begin
  Result := clHighlightText;
end;

function TcxCustomLookAndFeelPainter.DefaultSeparatorColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultTabColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultTabTextColor: TColor;
begin
  Result := clBtnText;
end;

function TcxCustomLookAndFeelPainter.DefaultTabsBackgroundColor: TColor;
begin
  Result := clWindow;
end;

function TcxCustomLookAndFeelPainter.DefaultRootTabsBackgroundColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultTimeGridMajorScaleColor: TColor;
begin
  Result := clWhite;
end;

function TcxCustomLookAndFeelPainter.DefaultTimeGridMajorScaleTextColor: TColor;
begin
  Result := clBlack;
end;

function TcxCustomLookAndFeelPainter.DefaultTimeGridMinorScaleColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.DefaultTimeGridMinorScaleTextColor: TColor;
begin
  Result := clBtnText;
end;

function TcxCustomLookAndFeelPainter.DefaultTimeGridSelectionBarColor: TColor;
begin
  Result := clWhite;
end;

function TcxCustomLookAndFeelPainter.DefaultChartDiagramValueBorderColor: TColor;
begin
  Result := clBlack;
end;

function TcxCustomLookAndFeelPainter.DefaultChartDiagramValueCaptionTextColor: TColor;
begin
  Result := clBlack;
end;

function TcxCustomLookAndFeelPainter.DefaultChartHistogramAxisColor: TColor;
begin
  Result := clBlack;
end;

function TcxCustomLookAndFeelPainter.DefaultChartHistogramGridLineColor: TColor;
begin
  Result := clcxLightGray;
end;

function TcxCustomLookAndFeelPainter.DefaultChartHistogramPlotColor: TColor;
begin
  Result := clWhite;
end;

function TcxCustomLookAndFeelPainter.DefaultChartPieDiagramSeriesSiteBorderColor: TColor;
begin
  Result := clBtnShadow;
end;

function TcxCustomLookAndFeelPainter.DefaultChartPieDiagramSeriesSiteCaptionColor: TColor;
begin
  Result := clSkyBlue;
end;

function TcxCustomLookAndFeelPainter.DefaultChartPieDiagramSeriesSiteCaptionTextColor: TColor;
begin
  Result := clNavy;
end;

function TcxCustomLookAndFeelPainter.DefaultChartToolBoxDataLevelInfoBorderColor: TColor;
begin
  Result := clBtnShadow;
end;

function TcxCustomLookAndFeelPainter.DefaultChartToolBoxItemSeparatorColor: TColor;
begin
  Result := clBtnShadow;
end;

procedure TcxCustomLookAndFeelPainter.CalculateArrowPoints(R: TRect;
  var P: TcxArrowPoints; AArrowDirection: TcxArrowDirection; AProportional: Boolean; AArrowSize: Integer = 0);

  function _GetSize: TSize;
  begin
    if AArrowDirection in [adUp, adDown] then
    begin
      if AArrowSize = 0 then
        AArrowSize := (R.Right - R.Left - 1) div 4 + 1;
      Result.cy := AArrowSize;
      Result.cx := AArrowSize * 2 - 1;
    end
    else
    begin
      if AArrowSize = 0 then
        AArrowSize := (R.Bottom - R.Top - 1) div 4 + 1;
      Result.cx := AArrowSize;
      Result.cy := AArrowSize * 2 - 1;
    end
  end;

var
  ASize: TSize;
  ADelta: Integer;
begin
  with R do
  begin
    if AProportional then
    begin
      ADelta := (Right - Left) - (Bottom - Top);
      if ADelta > 0 then
        InflateRect(R, -ADelta div 2, 0)
      else
        InflateRect(R, 0, ADelta div 2);
    end;
    ASize := _GetSize;
    case AArrowDirection of
      adUp:
        begin
          P[cxArrowTopPointIndex] := Point((Left + Right - 1) div 2, MulDiv(Top + Bottom - ASize.cy, 1, 2){ - 1});
          P[cxArrowLeftBasePointIndex] := Point((Left + Right - ASize.cx) div 2, P[cxArrowTopPointIndex].Y + ASize.cy - 1);
          P[cxArrowRightBasePointIndex] := Point(P[cxArrowLeftBasePointIndex].X + ASize.cx - 1, P[cxArrowLeftBasePointIndex].Y);
        end;
      adDown:
        begin
          P[cxArrowRightBasePointIndex] := Point((Left + Right - ASize.cx) div 2, MulDiv(Top + Bottom - ASize.cy, 1, 2));
          P[cxArrowLeftBasePointIndex] := Point(P[cxArrowRightBasePointIndex].X + ASize.cx - 1, P[cxArrowRightBasePointIndex].Y);
          P[cxArrowTopPointIndex] := Point((Left + Right - 1) div 2, P[cxArrowRightBasePointIndex].Y + ASize.cy - 1);
        end;
      adLeft:
        begin
          P[cxArrowTopPointIndex] := Point((Left + Right - ASize.cx) div 2, (Top + Bottom (**)) div 2);
          P[cxArrowRightBasePointIndex] := Point(P[cxArrowTopPointIndex].X + ASize.cx - 1, MulDiv(Top + Bottom - ASize.cy, 1, 2));
          P[cxArrowLeftBasePointIndex] := Point(P[cxArrowRightBasePointIndex].X, P[cxArrowRightBasePointIndex].Y + ASize.cy - 1);
        end;
      adRight:
        begin
          P[cxArrowLeftBasePointIndex] := Point((Left + Right - ASize.cx) div 2, MulDiv(Top + Bottom - ASize.cy, 1, 2));
          P[cxArrowTopPointIndex] := Point(P[cxArrowLeftBasePointIndex].X + ASize.cx - 1, (Top + Bottom (**)) div 2);
          P[cxArrowRightBasePointIndex] := Point(P[cxArrowLeftBasePointIndex].X, P[cxArrowLeftBasePointIndex].Y + ASize.cy - 1);
        end;
    end;
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawArrow(ACanvas: TcxCanvas; const R: TRect; AArrowDirection: TcxArrowDirection; AColor: TColor);
var
  P: TcxArrowPoints;
begin
  CalculateArrowPoints(R, P, AArrowDirection, True);
  with ACanvas do
  begin
    Brush.Style := bsSolid;
    SetBrushColor(AColor);
    Pen.Color := AColor;
    Polygon(P);
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawArrow(ACanvas: TcxCanvas; const R: TRect;
  AState: TcxButtonState; AArrowDirection: TcxArrowDirection; ADrawBorder: Boolean = True);
var
  P: TcxArrowPoints;
begin
  CalculateArrowPoints(R, P, AArrowDirection, False);
  with ACanvas do
  begin
    Brush.Style := bsSolid;
    if ADrawBorder then
      DrawArrowBorder(ACanvas, R, AState)
    else
    begin
      SetBrushColor(ButtonColor(AState));
      FillRect(R);
    end;
    SetBrushColor(ButtonSymbolColor(AState));
    Pen.Color := Brush.Color;
    Polygon(P);
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawArrowBorder(ACanvas: TcxCanvas;
  const R: TRect; AState: TcxButtonState);
begin
  with ACanvas do
  begin
    Brush.Color := ButtonColor(AState);
    Brush.Style := bsSolid;
    FillRect(R);
  end;
  DrawButtonBorder(ACanvas, R, AState);
end;

procedure TcxCustomLookAndFeelPainter.DrawScrollBarArrow(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AArrowDirection: TcxArrowDirection);
var
  P: TcxArrowPoints;

  procedure OffsetPoints(ADelta: Integer);
  var
    I: Integer;
  begin
    for I := 0 to 2 do
    begin
      Inc(P[I].X, ADelta);
      Inc(P[I].Y, ADelta);
    end;
  end;

begin
  if AState = cxbsPressed then
    OffsetRect(R, ButtonTextShift, ButtonTextShift);
  CalculateArrowPoints(R, P, AArrowDirection, True);
  with ACanvas do
  begin
    Brush.Style := bsSolid;
    if AState <> cxbsDisabled then
      Brush.Color := ButtonSymbolColor(AState)
    else
    begin
      OffsetPoints(1);
      Brush.Color := clBtnHighlight;
      Pen.Color := Brush.Color;
      Polygon(P);
    {$IFDEF KYLIX3}
      case AArrowDirection of
        adUp: ACanvas.Canvas.Pixels[P[cxArrowRightBasePointIndex].X, P[cxArrowRightBasePointIndex].Y] := Pen.Color;
        adLeft: ACanvas.Canvas.Pixels[P[cxArrowLeftBasePointIndex].X, P[cxArrowLeftBasePointIndex].Y] := Pen.Color;
      end;
    {$ENDIF}
      OffsetPoints(-1);
      Brush.Color := clBtnShadow;
    end;
    Pen.Color := Brush.Color;
    Polygon(P);
  {$IFDEF KYLIX3}
    case AArrowDirection of
      adUp: ACanvas.Canvas.Pixels[P[cxArrowRightBasePointIndex].X, P[cxArrowRightBasePointIndex].Y] := Pen.Color;
      adLeft: ACanvas.Canvas.Pixels[P[cxArrowLeftBasePointIndex].X, P[cxArrowLeftBasePointIndex].Y] := Pen.Color;
    end;
  {$ENDIF}
  end;
end;

function TcxCustomLookAndFeelPainter.BorderSize: Integer;
begin
  Result := 0;
end;

procedure TcxCustomLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawContainerBorder(ACanvas: TcxCanvas; const R: TRect; AStyle: TcxContainerBorderStyle;
  AWidth: Integer; AColor: TColor; ABorders: TcxBorders);
begin
  case AStyle of
    cbsSingle, cbsThick:
      ACanvas.FrameRect(R, AColor, AWidth);
    cbsFlat:
      begin
        ACanvas.DrawEdge(R, True, True, ABorders);
        ACanvas.FrameRect(cxRectInflate(R, -1, -1), clBtnFace);
      end;
    cbs3D:
      begin
        ACanvas.DrawEdge(R, True, True, ABorders);
        ACanvas.DrawComplexFrame(cxRectInflate(R, -1, -1), cl3DDkShadow, cl3DLight, ABorders);
      end;
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawSeparator(ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean);
var
  ABounds: TRect;
begin
  ABounds := GetSeparatorBounds(R, BorderSize, AIsVertical);
  Dec(ABounds.Right);
  Dec(ABounds.Bottom);
  ACanvas.FillRect(ABounds, clBtnShadow);
  OffsetRect(ABounds, 1, 1);
  ACanvas.FillRect(ABounds, clBtnHighlight);
end;

function TcxCustomLookAndFeelPainter.AdjustGroupButtonDisplayRect(
  const R: TRect; AButtonCount, AButtonIndex: Integer): TRect;
begin
  Result := R;
end;

function TcxCustomLookAndFeelPainter.ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer;
begin
  Result := 0;
end;

function TcxCustomLookAndFeelPainter.ButtonColor(AState: TcxButtonState): TColor;
begin
  Result := clBtnFace;
end;

function TcxCustomLookAndFeelPainter.ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect;
begin
  Result := R;
  InflateRect(Result, -4, -4);
  if IsRectEmpty(Result) then
    Result := R;
end;

function TcxCustomLookAndFeelPainter.ButtonGroupBorderSizes(AButtonCount,
  AButtonIndex: Integer): TRect;
var
  AButtonBorderWidth: Integer;
begin
  AButtonBorderWidth := ButtonBorderSize;
  Result := Rect(AButtonBorderWidth, AButtonBorderWidth, AButtonBorderWidth,
    AButtonBorderWidth);
end;

function TcxCustomLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := 0;
end;

function TcxCustomLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := 0;
end;

function TcxCustomLookAndFeelPainter.ButtonSymbolColor(
  AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
begin
  if AState = cxbsDisabled then
    Result := clBtnShadow
  else
    if ADefaultColor = clDefault then
      Result := clBtnText
    else
      Result := ADefaultColor;
end;

function TcxCustomLookAndFeelPainter.ButtonSymbolState(AState: TcxButtonState): TcxButtonState;
begin
  Result := AState;
end;

procedure TcxCustomLookAndFeelPainter.DrawButton(ACanvas: TcxCanvas;
  R: TRect; const ACaption: string; AState: TcxButtonState; ADrawBorder: Boolean = True;
  AColor: TColor = clDefault; ATextColor: TColor = clDefault; AWordWrap: Boolean = False;
  AIsToolButton: Boolean = False);
var
  AFlags: Integer;
begin
  with ACanvas do
  begin
    if ADrawBorder then
    begin
      DrawButtonBorder(ACanvas, R, AState);
      InflateRect(R, -ButtonBorderSize(AState), -ButtonBorderSize(AState));
    end;
    if AColor = clDefault then
      Brush.Color := ButtonColor(AState)
    else
      Brush.Color := AColor;
    FillRect(R);
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
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawButtonCross(ACanvas: TcxCanvas;
  const R: TRect; AColor: TColor; AState: TcxButtonState);
var
  ASize: TPoint;

  function GetSize: TPoint;
  begin
    Result.X := FilterCloseButtonSize.X div 2;
    if not Odd(Result.X) then Dec(Result.X);
    Result.Y := Result.X;
  end;

  procedure DrawOneMark(ADelta: Integer);
  var
    P: TPoint;
    AFix: Integer;
  begin
    with R do
      P := Point((Left + Right - ASize.X) div 2 + ADelta, (Top + Bottom - ASize.Y) div 2);
    if AState = cxbsPressed then
    begin
      Inc(P.X);
      Inc(P.Y);
    end;
    AFix := 0;
    {$IFDEF WIN32}
    {$ENDIF}
    with ACanvas, P do
    begin
      MoveTo(X, Y);
      LineTo(X + ASize.X - AFix, Y + ASize.Y - AFix);
      MoveTo(X, Y + ASize.Y - 1);
      LineTo(X + ASize.X - AFix, Y - 1 + AFix);
    end;
  end;

begin
  ASize := GetSize;
  ACanvas.Pen.Color := AColor;
  DrawOneMark(0);
  DrawOneMark(1);
end;

procedure TcxCustomLookAndFeelPainter.DrawButtonInGroup(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
  ABackgroundColor: TColor);
begin
  DrawButton(ACanvas, R, '', AState);
end;

procedure TcxCustomLookAndFeelPainter.DrawButtonBorder(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawButtonGroupBorder(ACanvas: TcxCanvas;
  R: TRect; AInplace, ASelected: Boolean); 
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawExpandButtonEx(
  ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0);
var
  ABitmap: TcxBitmap;
  ARect: TRect;
begin
  DrawButton(ACanvas, R, '', AState);
  if ARotationAngle in [raMinus90, raPlus90] then
    ARect := cxRectRotate(R)
  else
    ARect := R;
  ABitmap := TcxBitmap.CreateSize(ARect);
  try
    ABitmap.cxCanvas.FillRect(ABitmap.ClientRect, ButtonColor(AState));
    DrawGroupExpandButtonMark(ABitmap.cxCanvas, ABitmap.ClientRect, AExpanded, AState);
    ACanvas.RotateBitmap(ABitmap, ARotationAngle);
    cxDrawImage(ACanvas.Handle, R, R, ABitmap, nil, -1, idmNormal);
  finally
    ABitmap.Free;
  end;
end;

function TcxCustomLookAndFeelPainter.DrawExpandButtonFirst: Boolean;
begin
  Result := True;
end;

procedure TcxCustomLookAndFeelPainter.DrawGroupExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AState: TcxButtonState);
begin
  DrawButton(ACanvas, R, '', AState);
  DrawGroupExpandButtonMark(ACanvas, R, AExpanded, AState);
end;

procedure TcxCustomLookAndFeelPainter.DrawSmallExpandButton(ACanvas: TcxCanvas;
  R: TRect; AExpanded: Boolean; ABorderColor: TColor; AColor: TColor = clDefault);
begin
  ACanvas.Brush.Color := ABorderColor;
  ACanvas.FrameRect(R);
  if AColor <> clDefault then
  begin
    InflateRect(R, -1, -1);
    ACanvas.Brush.Color := AColor;
    ACanvas.FillRect(R);
    InflateRect(R, 1, 1);
  end;
  DrawExpandButtonCross(ACanvas, R, AExpanded, clBtnText);
end;

function TcxCustomLookAndFeelPainter.ExpandButtonSize: Integer;
begin
  Result := 0;
end;

function TcxCustomLookAndFeelPainter.GroupExpandButtonSize: Integer;
begin
  Result := 15;
end;

function TcxCustomLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := False;
end;

function TcxCustomLookAndFeelPainter.IsPointOverGroupExpandButton(const R: TRect;
  const P: TPoint): Boolean;
begin
  Result := PtInRect(R, P);
end;

function TcxCustomLookAndFeelPainter.SmallExpandButtonSize: Integer;
begin
  Result := 9;
end;

function TcxCustomLookAndFeelPainter.CheckBorderSize: Integer;
begin
  Result := 2;
end;

function TcxCustomLookAndFeelPainter.CheckButtonColor(AState: TcxButtonState): TColor;
const
  Colors: array[TcxButtonState] of TColor = (clWindow, clWindow, clWindow, clBtnFace, clBtnFace);
begin
  Result := Colors[AState];
end;

function TcxCustomLookAndFeelPainter.CheckButtonSize: TSize;
begin
  Result := FCheckButtonSize;
end;

procedure TcxCustomLookAndFeelPainter.DrawCheck(ACanvas: TcxCanvas; const R: TRect;
  AState: TcxButtonState; AChecked: Boolean; AColor: TColor);
var
  ASize: TPoint;

  function GetSize: TPoint;
  begin
    with R do
    begin
      Result.X := Right - Left - 2;
      Result.Y := Bottom - Top - 2 - 2;
    end;
  end;

  procedure DrawOneCheck(ADelta: Integer);
  var
    ARoot: TPoint;
    AFix: Integer;
  begin
    with R do
    begin
      ARoot.X := (Left + Right) div 2 - 1;
      ARoot.Y := (Top + Bottom + ASize.Y) div 2 - 2 + ADelta;
    end;
    AFix := 0;
    with ACanvas do
    begin
      MoveTo(ARoot.X - (ASize.X div 2 - 1), ARoot.Y - ASize.Y div 2);
      LineTo(ARoot.X, ARoot.Y);
      LineTo(ARoot.X + ASize.X div 2 + 2 - AFix, ARoot.Y - ASize.Y + AFix);
    end;
  end;

begin
  if ACanvas.Brush.Style = bsSolid then
  begin
    ACanvas.Brush.Color := CheckButtonColor(AState);
    ACanvas.FillRect(R);
  end;
  if not AChecked then Exit;
  ASize := GetSize;
  ACanvas.Pen.Color := AColor;
  DrawOneCheck(0);
  DrawOneCheck(1);
  DrawOneCheck(2);
end;

procedure TcxCustomLookAndFeelPainter.DrawCheckBorder(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawCheckButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; ACheckState: TcxCheckBoxState);
const
  ColorMap: array[Boolean] of TColor = (clBtnText, clGrayText);
begin
  DrawCheckBorder(ACanvas, R, AState);
  InflateRect(R, -CheckBorderSize, -CheckBorderSize);
  DrawCheck(ACanvas, R, AState, ACheckState = cbsChecked,
    ColorMap[(AState = cxbsDisabled) or (ACheckState = cbsGrayed)]);
end;

procedure TcxCustomLookAndFeelPainter.DrawCheckButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AChecked: Boolean);
const
  CheckStates: array[Boolean] of TcxCheckBoxState = (cbsUnchecked, cbsChecked);
begin
  DrawCheckButton(ACanvas, R, AState, CheckStates[AChecked]);
end;

procedure TcxCustomLookAndFeelPainter.DrawRadioButton(ACanvas: TcxCanvas;
  X, Y: Integer; AButtonState: TcxButtonState; AChecked, AFocused: Boolean;
  ABrushColor: TColor; AIsDesigning: Boolean = False);
begin
  RadioButtonImageList.Draw(ACanvas, X, Y, ABrushColor,
    cxLookAndFeelKindMap[LookAndFeelStyle], AButtonState, AChecked,
    AFocused, AIsDesigning);
end;

function TcxCustomLookAndFeelPainter.RadioButtonBodyColor(AState: TcxButtonState): TColor;
begin
  case AState of
    cxbsDisabled, cxbsPressed:
      Result := clBtnFace;
    else
      Result := clWindow;
  end;
end;

function TcxCustomLookAndFeelPainter.RadioButtonSize: TSize;
begin
  Result := RadioButtonImageList.GetSize;
end;

procedure TcxCustomLookAndFeelPainter.DrawLabelLine(ACanvas: TcxCanvas;
  const R: TRect; AOuterColor, AInnerColor: TColor; AIsVertical: Boolean);
const
  BordersMap: array[Boolean] of TcxBorders = ([bTop, bBottom], [bLeft, bRight]);
begin
  if AOuterColor = clDefault then
    AOuterColor := clBtnShadow;
  if AInnerColor = clDefault then
    AInnerColor := clBtnHighlight;
  ACanvas.DrawComplexFrame(R, AOuterColor, AInnerColor, BordersMap[AIsVertical]);
end;

function TcxCustomLookAndFeelPainter.LabelLineHeight: Integer;
begin
  Result := 2;
end;

procedure TcxCustomLookAndFeelPainter.DrawHeader(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil;
  AIsLast: Boolean = False; AIsGroup: Boolean = False);
begin
  DrawHeaderBorder(ACanvas, ABounds, ANeighbors, ABorders);
  DrawContent(ACanvas, HeaderContentBounds(ABounds, ABorders), ATextAreaBounds, Integer(AState), 
    AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
    AFont, ATextColor, ABkColor, AOnDrawBackground);
end;

procedure TcxCustomLookAndFeelPainter.DrawHeaderEx(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors,
    ABorders, AState, AAlignmentHorz, AAlignmentVert, AMultiLine,
      AShowEndEllipsis, AText, AFont, ATextColor, ABkColor, AOnDrawBackground);
end;

procedure TcxCustomLookAndFeelPainter.DrawHeaderBorder(ACanvas: TcxCanvas;
  const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawHeaderPressed(ACanvas: TcxCanvas;
  const ABounds: TRect);
begin
  ACanvas.InvertRect(ABounds);
end;

procedure TcxCustomLookAndFeelPainter.DrawHeaderControlSection(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors;
  ABorders: TcxBorders; AState: TcxButtonState; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor);
begin
  DrawHeaderControlSectionBorder(ACanvas, ABounds, ABorders, AState);
  DrawHeaderControlSectionContent(ACanvas,
    HeaderControlSectionContentBounds(ABounds, AState), ATextAreaBounds, AState,
    AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
    AFont, ATextColor, ABkColor);
end;

procedure TcxCustomLookAndFeelPainter.DrawHeaderControlSectionBorder(
  ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AState: TcxButtonState);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawHeaderControlSectionContent(
  ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
  AState: TcxButtonState; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor);
begin
  ACanvas.SetBrushColor(ABkColor);
  ACanvas.FillRect(ABounds);
  DrawHeaderControlSectionText(ACanvas,
    HeaderControlSectionTextAreaBounds(ATextAreaBounds, AState), AState, AAlignmentHorz,
    AAlignmentVert, AMultiLine, AShowEndEllipsis, AText, AFont, ATextColor);
end;

procedure TcxCustomLookAndFeelPainter.DrawHeaderControlSectionText(
  ACanvas: TcxCanvas; const ATextAreaBounds: TRect; AState: TcxButtonState;
  AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
  AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor: TColor);

  procedure DoDrawText(ATextRect: TRect; ATextColor: TColor);
  const
    MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
    ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
  begin
    with ACanvas do
    begin
      if AText <> '' then
      begin
        Font := AFont;
        Font.Color := ATextColor;
        DrawText(AText, ATextRect, cxAlignmentsHorz[AAlignmentHorz] or
          cxAlignmentsVert[AAlignmentVert] or MultiLines[AMultiLine] or
          ShowEndEllipsises[AShowEndEllipsis]);
      end;
    end;
  end;
var
  R: TRect;
  AColor: TColor;
begin
  R := ATextAreaBounds;
  ACanvas.Brush.Style := bsClear;
  AColor := ATextColor;
  if AState = cxbsDisabled then
  begin
    OffsetRect(R, 1, 1);
    DoDrawText(R, clBtnHighlight);
    OffsetRect(R, -1, -1);
    AColor := clBtnShadow;
  end;
  DoDrawText(R, AColor);
  ACanvas.Brush.Style := bsSolid;
end;

procedure TcxCustomLookAndFeelPainter.DrawHeaderSeparator(ACanvas: TcxCanvas;
  const ABounds: TRect; AIndentSize: Integer; AColor: TColor;
  AViewParams: TcxViewParams);
begin
  ACanvas.FillRect(cxRectSetWidth(ABounds, AIndentSize), AViewParams);
  ACanvas.Brush.Color := AColor;
  ACanvas.FillRect(cxRectInflate(ABounds, -AIndentSize, 0));
  ACanvas.FillRect(cxRectSetLeft(ABounds, ABounds.Right - AIndentSize), AViewParams);
end;

procedure TcxCustomLookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
end;
  
function TcxCustomLookAndFeelPainter.HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders;
begin
  Result := cxBordersAll;
end;

function TcxCustomLookAndFeelPainter.HeaderBorderSize: Integer;
begin
  Result := 0;
end;

function TcxCustomLookAndFeelPainter.HeaderBounds(const ABounds: TRect;
  ANeighbors: TcxNeighbors; ABorders: TcxBorders = cxBordersAll): TRect;
begin
  Result := ABounds;
  ABorders := ABorders - HeaderBorders(ANeighbors);
  if bLeft in ABorders then
    Dec(Result.Left, HeaderBorderSize);
  if bTop in ABorders then
    Dec(Result.Top, HeaderBorderSize);
  if bRight in ABorders then
    Inc(Result.Right, HeaderBorderSize);
  if bBottom in ABorders then
    Inc(Result.Bottom, HeaderBorderSize);
end;

function TcxCustomLookAndFeelPainter.HeaderContentBounds(const ABounds: TRect;
  ABorders: TcxBorders): TRect;
begin
  Result := ABounds;
  if bLeft in ABorders then
    Inc(Result.Left, HeaderBorderSize);
  if bTop in ABorders then
    Inc(Result.Top, HeaderBorderSize);
  if bRight in ABorders then
    Dec(Result.Right, HeaderBorderSize);
  if bBottom in ABorders then
    Dec(Result.Bottom, HeaderBorderSize);
end;

function TcxCustomLookAndFeelPainter.HeaderDrawCellsFirst: Boolean;
begin
  Result := True;
end;

function TcxCustomLookAndFeelPainter.HeaderHeight(AFontHeight: Integer): Integer;
begin
  Result := AFontHeight + 2 * (HeaderBorderSize + cxHeaderTextOffset);
end;

function TcxCustomLookAndFeelPainter.HeaderControlSectionBorderSize(
  AState: TcxButtonState = cxbsNormal): Integer;
begin
  Result := 1;
end;

function TcxCustomLookAndFeelPainter.HeaderControlSectionTextAreaBounds(
  ABounds: TRect; AState: TcxButtonState): TRect;
begin
  Result := ABounds;
  if AState = cxbsPressed then
    OffsetRect(Result, 1, 1);
end;

function TcxCustomLookAndFeelPainter.HeaderControlSectionContentBounds(
  const ABounds: TRect; AState: TcxButtonState): TRect;
begin
  Result := ABounds;
  InflateRect(Result, -HeaderControlSectionBorderSize(AState),
    -HeaderControlSectionBorderSize(AState));
end;

function TcxCustomLookAndFeelPainter.HeaderWidth(ACanvas: TcxCanvas;
  ABorders: TcxBorders; const AText: string; AFont: TFont): Integer;
begin
  ACanvas.Font := AFont;
  Result := ACanvas.TextWidth(AText) + 2 * cxHeaderTextOffset;
  if bLeft in ABorders then
    Inc(Result, HeaderBorderSize);
  if bRight in ABorders then
    Dec(Result, HeaderBorderSize);
end;

function TcxCustomLookAndFeelPainter.IsHeaderHotTrack: Boolean;
begin
  Result := False;
end;

function TcxCustomLookAndFeelPainter.SortingMarkAreaSize: TPoint;
begin
  Result := Point(SortingMarkAreaWidth, SortingMarkSize.Y);
end;

function TcxCustomLookAndFeelPainter.SortingMarkSize: TPoint;
begin
  Result := Point(0, 0);
end;

procedure TcxCustomLookAndFeelPainter.DrawFooterCell(ACanvas: TcxCanvas;
  const ABounds: TRect; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine: Boolean; const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawFooterCellBorder(ACanvas, ABounds);
  DrawFooterCellContent(ACanvas, ABounds, AAlignmentHorz, AAlignmentVert,
    AMultiLine, AText, AFont, ATextColor, ABkColor, AOnDrawBackground);
end;

procedure TcxCustomLookAndFeelPainter.DrawFooterCellContent(ACanvas: TcxCanvas;
  const ABounds: TRect; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine: Boolean; const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawContent(ACanvas, FooterCellContentBounds(ABounds), FooterCellTextAreaBounds(ABounds), 0,
    AAlignmentHorz, AAlignmentVert, AMultiLine, False, AText, AFont, ATextColor, ABkColor,
    AOnDrawBackground, True);
end;

procedure TcxCustomLookAndFeelPainter.DrawGroupByBox(ACanvas: TcxCanvas;
  const ARect: TRect; ATransparent: Boolean; ABackgroundColor: TColor;
  const ABackgroundBitmap: TBitmap);
begin
  DrawBackground(ACanvas, ARect, ATransparent, ABackgroundColor, ABackgroundBitmap);
end;

function TcxCustomLookAndFeelPainter.GridGroupRowStyleOffice11ContentColor(AHasData: Boolean): TColor;
begin
  if AHasData then
    Result := clWindow
  else
    Result := dxOffice11GroupIndentColor;
end;

function TcxCustomLookAndFeelPainter.GridGroupRowStyleOffice11SeparatorColor: TColor;
begin
  Result := dxOffice11GroupRowSeparatorColor;
end;

function TcxCustomLookAndFeelPainter.GridGroupRowStyleOffice11TextColor: TColor;
begin
  Result := dxOffice11GroupRowTextColor;
end;

function TcxCustomLookAndFeelPainter.GridDrawHeaderCellsFirst: Boolean;
begin
  Result := HeaderDrawCellsFirst;
end;

function TcxCustomLookAndFeelPainter.PivotGridHeadersAreaColor: TColor;
begin
  Result := DefaultHeaderBackgroundColor;
end;

function TcxCustomLookAndFeelPainter.PivotGridHeadersAreaTextColor: TColor;
begin
  Result := DefaultHeaderBackgroundTextColor;
end;

function TcxCustomLookAndFeelPainter.LayoutViewGetPadding(AElement: TcxLayoutElement): TRect;
begin
  Result := cxNullRect;
end;

function TcxCustomLookAndFeelPainter.LayoutViewGetSpacing(AElement: TcxLayoutElement): TRect;
begin
  Result := cxNullRect;
end;

procedure TcxCustomLookAndFeelPainter.LayoutViewDrawItem(ACanvas: TcxCanvas; const ABounds: TRect;
  AState: TcxButtonState; ABorders: TcxBorders = []);
begin
  if AState = cxbsPressed then
    ACanvas.FillRect(ABounds, DefaultSelectionColor)
  else
    ACanvas.FillRect(ABounds, DefaultGroupColor);
end;

procedure TcxCustomLookAndFeelPainter.LayoutViewDrawRecordCaption(
  ACanvas: TcxCanvas; const ABounds: TRect;
  APosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState);
var
  AColor: TColor;
begin
  if AState = cxbsHot then
    AColor := DefaultSelectionColor
  else
    AColor := DefaultGroupColor;
  LayoutViewDrawRecordBorder(ACanvas, ABounds, AState, cxBordersAll);
  ACanvas.FillRect(ABounds, AColor);
end;

procedure TcxCustomLookAndFeelPainter.LayoutViewDrawRecordBorder(
  ACanvas: TcxCanvas; const ABounds: TRect;
  AState: TcxButtonState; ABorders: TcxBorders = []);
var
  ABorderColor: TColor;
begin
  if AState = cxbsHot then
    ABorderColor := DefaultSelectionColor
  else
    ABorderColor := clBtnShadow;
  ACanvas.FrameRect(ABounds, ABorderColor, 1, ABorders, True);
end;

procedure TcxCustomLookAndFeelPainter.LayoutViewDrawRecordContent(
  ACanvas: TcxCanvas; const ABounds: TRect;
  ACaptionPosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState;
  ABorders: TcxBorders = cxBordersAll);
begin
  LayoutViewDrawRecordBorder(ACanvas, ABounds, AState, ABorders);
  ACanvas.FillRect(ABounds, DefaultGroupColor);
end;

procedure TcxCustomLookAndFeelPainter.LayoutViewDrawRecordExpandButton(
  ACanvas: TcxCanvas; const ABounds: TRect; AState: TcxButtonState; AExpanded: Boolean);
begin
  DrawGroupExpandButton(ACanvas, ABounds, AExpanded, AState);
end;

function TcxCustomLookAndFeelPainter.FooterBorders: TcxBorders;
begin
  Result := cxBordersAll;
end;

function TcxCustomLookAndFeelPainter.FooterBorderSize: Integer;
begin
  Result := 0;
end;

function TcxCustomLookAndFeelPainter.FooterCellBorderSize: Integer;
begin
  Result := 0;
end;

function TcxCustomLookAndFeelPainter.FooterCellOffset: Integer;
begin
  Result := 0;
end;

function TcxCustomLookAndFeelPainter.FooterDrawCellsFirst: Boolean;
begin
  Result := True;
end;

function TcxCustomLookAndFeelPainter.FooterSeparatorColor: TColor;
begin
  Result := clBtnShadow;
end;

function TcxCustomLookAndFeelPainter.FooterSeparatorSize: Integer;
begin
  Result := 1;
end;

procedure TcxCustomLookAndFeelPainter.DrawFooterPanel(ACanvas: TcxCanvas;
  const ABounds: TRect; const AViewParams: TcxViewParams; ABorders: TcxBorders);
begin
  ACanvas.SaveClipRegion;
  try
    ACanvas.IntersectClipRect(ABounds);
    DrawFooterContent(ACanvas, ABounds, AViewParams);
    DrawFooterBorderEx(ACanvas, ABounds, ABorders);
  finally
    ACanvas.RestoreClipRegion;
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawFooterBorder(ACanvas: TcxCanvas;
  const R: TRect);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawFooterContent(ACanvas: TcxCanvas;
  const ARect: TRect; const AViewParams: TcxViewParams);
begin
  if IsRectEmpty(ARect) then Exit;
  ACanvas.FillRect(ARect, AViewParams);
end;

procedure TcxCustomLookAndFeelPainter.DrawFooterSeparator(ACanvas: TcxCanvas;
  const R: TRect);
begin
  ACanvas.Brush.Color := FooterSeparatorColor;
  ACanvas.FillRect(R);
end;

procedure TcxCustomLookAndFeelPainter.DrawFilterActivateButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AChecked: Boolean);
begin
  DrawCheckButton(ACanvas, R, AState, AChecked);
end;

procedure TcxCustomLookAndFeelPainter.DrawFilterCloseButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState);
begin
  DrawButtonBorder(ACanvas, R, AState);
  InflateRect(R, -ButtonBorderSize, -ButtonBorderSize);
  ACanvas.Brush.Color := ButtonColor(AState);
  ACanvas.FillRect(R);
  DrawButtonCross(ACanvas, R, ButtonSymbolColor(AState), ButtonSymbolState(AState));
end;

procedure TcxCustomLookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawFilterPanel(ACanvas: TcxCanvas;
  const ARect: TRect; ATransparent: Boolean; ABackgroundColor: TColor;
  const ABackgroundBitmap: TBitmap);
begin
  DrawBackground(ACanvas, ARect, ATransparent, ABackgroundColor, ABackgroundBitmap);
end;

function TcxCustomLookAndFeelPainter.FilterActivateButtonSize: TPoint;
begin
  Result := Point(FilterActiveButtonWidth, FilterActiveButtonHeight);
end;

function TcxCustomLookAndFeelPainter.FilterCloseButtonSize: TPoint;
begin
  Result := Point(FilterCloseButtonWidth, FilterCloseButtonHeight);
end;

function TcxCustomLookAndFeelPainter.FilterDropDownButtonSize: TPoint;
begin
  Result := Point(FilterDropDownButtonWidth, 0);
end;

procedure TcxCustomLookAndFeelPainter.DrawEditPopupWindowBorder(ACanvas: TcxCanvas; var R: TRect;
  ABorderStyle: TcxEditPopupBorderStyle; AClientEdge: Boolean);
begin
  case ABorderStyle of
    epbsSingle:
      ACanvas.FrameRect(R, clBtnText);
    epbsFrame3D, epbsFlat:
      begin
        ACanvas.DrawEdge(R, False, True);
        InflateRect(R, -1, -1);
        ACanvas.DrawEdge(R, False, False);
        if ABorderStyle = epbsFrame3D then
        begin
          InflateRect(R, -1, -1);
          if AClientEdge then
            ACanvas.FrameRect(R, clInactiveBorder)
          else
            ACanvas.FrameRect(R, clBtnFace);
          InflateRect(R, -1, -1);
          if AClientEdge then
            ACanvas.FrameRect(R, clBtnFace)
          else
            ACanvas.DrawEdge(R, True, True);
        end;
      end;
  end;
  InflateRect(R, -1, -1);
end;

procedure TcxCustomLookAndFeelPainter.DrawWindowContent(ACanvas: TcxCanvas;
  const ARect: TRect);
begin
  ACanvas.FillRect(ARect, clBtnFace);
end;

function TcxCustomLookAndFeelPainter.GetEditPopupWindowBorderWidth(AStyle: TcxEditPopupBorderStyle): Integer;
begin
  Result := cxEditPopupWindowFrameWidthA[AStyle];
end;

function TcxCustomLookAndFeelPainter.GetEditPopupWindowClientEdgeWidth(AStyle: TcxEditPopupBorderStyle): Integer;
begin
  Result := cxEditPopupClientEdgeWidthA[AStyle]
end;

function TcxCustomLookAndFeelPainter.PopupBorderStyle: TcxPopupBorderStyle;
begin
  Result := pbsUltraFlat;
end;

procedure TcxCustomLookAndFeelPainter.DrawTab(ACanvas: TcxCanvas; R: TRect;
  ABorders: TcxBorders; const AText: string; AState: TcxButtonState;
  AVertical: Boolean; AFont: TFont; ATextColor, ABkColor: TColor; AShowPrefix: Boolean = False);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawTabBorder(ACanvas: TcxCanvas;
  R: TRect; ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawTabsRoot(ACanvas: TcxCanvas;
  const R: TRect; ABorders: TcxBorders; AVertical: Boolean);
begin
end;

function TcxCustomLookAndFeelPainter.IsDrawTabImplemented(AVertical: Boolean): Boolean;
begin
  Result := False;
end;

function TcxCustomLookAndFeelPainter.IsTabHotTrack(AVertical: Boolean): Boolean;
begin
  Result := False;
end;

function TcxCustomLookAndFeelPainter.TabBorderSize(AVertical: Boolean): Integer;
begin
  Result := 0;
end;

procedure TcxCustomLookAndFeelPainter.DrawIndicatorItem(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind; AColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, R, R, [], HeaderBorders([nTop, nBottom]), cxbsNormal,
    taLeftJustify, vaTop, False, False, '', nil, clNone, AColor, AOnDrawBackground);
  DrawIndicatorImage(ACanvas, R, AKind);
end;

procedure TcxCustomLookAndFeelPainter.DrawIndicatorItemEx(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind; AColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeaderEx(ACanvas, R, R, [], cxBordersAll, cxbsNormal,
    taLeftJustify, vaTop, False, False, '', nil, clNone, AColor, AOnDrawBackground);
  DrawIndicatorImage(ACanvas, R, AKind);
end;

function TcxCustomLookAndFeelPainter.IndicatorDrawItemsFirst: Boolean;
begin
  Result := True;
end;

function TcxCustomLookAndFeelPainter.ScrollBarMinimalThumbSize(
  AVertical: Boolean): Integer;
begin
  Result := cxStdThumbnailMinimalSize;
end;

procedure TcxCustomLookAndFeelPainter.DrawScrollBarBackground(
  ACanvas: TcxCanvas; const R: TRect; AHorizontal: Boolean);
begin
  DrawScrollBarPart(ACanvas, AHorizontal, R, sbpPageUp, cxbsNormal);
end;

procedure TcxCustomLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
begin
end;

function TcxCustomLookAndFeelPainter.PopupPanelSize: Integer;
begin
  Result := 2 + GetSystemMetrics(SM_CYHSCROLL);
//  if Result < GetSystemMetrics(SM_CYSIZE) then
//  Result := GetSystemMetrics(SM_CYSIZE);
  Inc(Result);
  Result := Max(Max(Result, SizeGripSize.cy + 2*2), SmallCloseButtonSize.cy + 2*3);
end;

procedure TcxCustomLookAndFeelPainter.CalculatePopupPanelClientRect(
  var AClientRect, APanelRect, AGripRect, ACloseButtonRect: TRect;
  ACorner: TdxCorner; const ABorders, APanelBorders: TRect;
  APanelHeight: Integer = 0; AShowCloseButton: Boolean = True; AShowGripSize: Boolean = True);

  procedure CalculateClientRect;
  begin
    AClientRect := cxRectContent(AClientRect, ABorders);
    APanelRect := AClientRect;
    if ACorner in [coBottomLeft, coBottomRight] then
    begin
      APanelRect.Top := APanelRect.Bottom - APanelHeight;
      AClientRect.Bottom := APanelRect.Top;
    end
    else
    begin
      APanelRect.Bottom := APanelRect.Top + APanelHeight;
      AClientRect.Top := APanelRect.Bottom;
    end;
  end;

  procedure CalculateSizeGripRect;
  const
    AOffset = 2;
  var
    AGripSize: TSize;
  begin
    if AShowGripSize then
    begin
      AGripRect := APanelRect;
      AGripSize := SizeGripSize;
      with AGripRect do
      begin
        if ACorner in [coTopRight, coBottomRight] then
        begin
          Right := Right - AOffset;
          Left := Right - AGripSize.cx;
        end
        else
        begin
          Left := Left + AOffset;
          Right := Left + AGripSize.cx;
        end;
        if ACorner in [coBottomLeft, coBottomRight] then
        begin
          Bottom := Bottom - AOffset;
          Top := Bottom - AGripSize.cy;
        end
        else
        begin
          Top := Top + AOffset;
          Bottom := Top + AGripSize.cy;
        end;
      end;
    end
    else
      AGripRect := cxNullRect;
  end;

  procedure CalculateCloseButtonRect;
  begin
    if AShowCloseButton then
    begin
      ACloseButtonRect := cxRectContent(APanelRect, APanelBorders);
        if ACorner in [coTopRight, coBottomRight] then
          ACloseButtonRect.Right := ACloseButtonRect.Left + cxRectHeight(ACloseButtonRect)
        else
          ACloseButtonRect.Left := ACloseButtonRect.Right - cxRectHeight(ACloseButtonRect);
      ACloseButtonRect := cxRectCenter(ACloseButtonRect, SmallCloseButtonSize);
    end
    else
      ACloseButtonRect := cxNullRect;
  end;

begin
  if APanelHeight = 0 then
    APanelHeight := PopupPanelSize;
  CalculateClientRect;
  CalculateSizeGripRect;
  CalculateCloseButtonRect;
end;

procedure TcxCustomLookAndFeelPainter.DrawPopupNCPanel(AHandle: HWND;
  AMouseAboveCloseButton, ACloseButtonIsTracking: Boolean; ACorner: TdxCorner;
  ACloseButtonRect, AGripRect: TRect; ABorderColor: TColor);

var
  AWindowRect, AWindowBounds, ABandBounds: TRect;
  ABorderSize: Integer;
  ADC: HDC;

  procedure CalculateBounds;
  var
    AClientRect, AClientBounds: TRect;
  begin
    AWindowRect := cxGetWindowRect(AHandle);
    AClientRect := cxGetClientRect(AHandle);

    AWindowBounds := AWindowRect;
    OffsetRect(AWindowBounds, -AWindowRect.Left, -AWindowRect.Top);

    AClientBounds := AClientRect;
    MapWindowPoints(AHandle, 0, AClientBounds, 2);
    OffsetRect(AClientBounds, -AWindowRect.Left, -AWindowRect.Top);

    ABorderSize := AClientBounds.Left;

    ABandBounds := cxRectInflate(AWindowBounds, -ABorderSize, -ABorderSize);
    if ACorner in [coBottomLeft, coBottomRight] then
      ABandBounds.Top := AClientBounds.Bottom
    else
      ABandBounds.Bottom := AClientBounds.Top;

    OffsetRect(ACloseButtonRect, -AWindowRect.Left, -AWindowRect.Top);
    OffsetRect(AGripRect, -AWindowRect.Left, -AWindowRect.Top);
  end;

  function GetBorders: TRect;
  begin
    Result := cxEmptyRect;
    if ACorner in [coBottomLeft, coBottomRight] then
      Result.Top := 1
    else
      Result.Bottom := 1;
  end;

  function GetButtonState: TcxButtonState;
  begin
    if AMouseAboveCloseButton and ACloseButtonIsTracking then
      Result := cxbsPressed
    else
      if AMouseAboveCloseButton or ACloseButtonIsTracking then
        Result := cxbsHot
      else
        Result := cxbsNormal;
  end;

begin
  ADC := GetWindowDC(AHandle);
  cxPaintCanvas.BeginPaint(ADC);
  try
    CalculateBounds;
    cxPaintCanvas.FrameRect(AWindowBounds, ABorderColor, ABorderSize);
    DrawPopupPanelBand(cxPaintCanvas, ABandBounds, AGripRect, ACloseButtonRect,
      ACorner, GetButtonState, GetBorders, ABorderColor);
  finally
    cxPaintCanvas.EndPaint;
    ReleaseDC(AHandle, ADC);
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawPopupPanelBand(ACanvas: TcxCanvas;
  const ABounds, AGripRect, ACloseButtonRect: TRect;
  AGripCorner: TdxCorner; ACloseButtonState: TcxButtonState;
  ABorders: TRect; ABorderColor: TColor;
  AShowGripSize: Boolean; AShowCloseButton: Boolean);
begin
  ACanvas.SaveClipRegion;
  ACanvas.ExcludeClipRect(cxRectContent(ABounds, ABorders));
  ACanvas.FillRect(ABounds, ABorderColor);
  ACanvas.RestoreClipRegion;

  if AShowGripSize then
  begin
    DrawWindowContent(ACanvas, AGripRect);
    DrawSizeGrip(ACanvas, AGripRect, clNone, AGripCorner);
    ACanvas.ExcludeClipRect(AGripRect);
  end;

  if AShowCloseButton then
  begin
    DrawWindowContent(ACanvas, ACloseButtonRect);
    DrawSmallCloseButton(ACanvas, ACloseButtonRect, ACloseButtonState);
    ACanvas.ExcludeClipRect(ACloseButtonRect);
  end;

  DrawWindowContent(ACanvas, cxRectContent(ABounds, ABorders));
  ACanvas.ExcludeClipRect(ABounds);
end;

function TcxCustomLookAndFeelPainter.SizeGripSize: TSize;
begin
  Result := Size(GetSystemMetrics(SM_CXVSCROLL), GetSystemMetrics(SM_CYHSCROLL));
end;

procedure TcxCustomLookAndFeelPainter.DoDrawSizeGrip(ACanvas: TcxCanvas;
  const ARect: TRect);
begin
  DrawFrameControl(ACanvas.Handle, ARect, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
end;

procedure TcxCustomLookAndFeelPainter.DrawSizeGrip(ACanvas: TcxCanvas;
  const ARect: TRect; ABackgroundColor: TColor; ACorner: TdxCorner);
const
  ARotationMap: array[Boolean] of TcxRotationAngle = (ra0, ra180);
var
  ABitmap: TcxBitmap;
begin
  ABitmap := TcxBitmap.CreateSize(ARect);
  try
    ABitmap.cxCanvas.Brush := ACanvas.Brush;
    if ABackgroundColor = clNone then
      cxBitBlt(ABitmap.Canvas.Handle, ACanvas.Handle, ABitmap.ClientRect, ARect.TopLeft, SRCCOPY)
    else
      ABitmap.cxCanvas.FillRect(ABitmap.ClientRect, ABackgroundColor);
    DoDrawSizeGrip(ABitmap.cxCanvas, ABitmap.ClientRect);
    ABitmap.Rotate(ARotationMap[ACorner in [coTopLeft, coBottomLeft]],
      ACorner in [coTopRight, coBottomLeft]);
    cxDrawBitmap(ACanvas.Handle, ABitmap, ARect, cxNullPoint);
  finally
    ABitmap.Free;
  end;
end;

function TcxCustomLookAndFeelPainter.SmallCloseButtonSize: TSize;
begin
  Result := cxSize(FilterCloseButtonHeight, FilterCloseButtonHeight + 1);
end;

procedure TcxCustomLookAndFeelPainter.DrawSmallCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  DrawFilterCloseButton(ACanvas, R, AState);
end;

procedure TcxCustomLookAndFeelPainter.DrawMonthHeader(ACanvas: TcxCanvas;
  const ABounds: TRect; const AText: string; ANeighbors: TcxNeighbors;
  const AViewParams: TcxViewParams; AArrows: TcxHeaderArrows;
  ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, ABounds, ABounds, ANeighbors, HeaderBorders(ANeighbors),
    cxbsNormal, taCenter, vaCenter, False, False, AText, AViewParams.Font,
    AViewParams.TextColor, AViewParams.Color, AOnDrawBackground);
  DrawMonthHeaderArrows(ACanvas, ABounds, AArrows, ASideWidth, clWindowText);
end;

procedure TcxCustomLookAndFeelPainter.CalculateSchedulerNavigationButtonRects(
  AIsNextButton: Boolean; ACollapsed: Boolean; APrevButtonTextSize: TSize;
  ANextButtonTextSize: TSize; var ABounds: TRect; out ATextRect: TRect;
  out AArrowRect: TRect); 
const
  cxTextOffset = 5;  
var
  AArrowSize: TSize;
  AArrowZoneHeight: Integer;
  ABorders: TRect;
  AContent: TRect;
  ADelta: Integer;
  AHasTextArea: Boolean;
begin
  SchedulerNavigationButtonSizes(AIsNextButton, ABorders, AArrowSize, AHasTextArea);
  AArrowZoneHeight := 3 * AArrowSize.cy;
  if ACollapsed or not AHasTextArea then
  begin
    ATextRect := cxNullRect;
    with ABorders do
    begin
      ABounds.Top := (ABounds.Top + ABounds.Bottom - Top - Bottom - AArrowZoneHeight) div 2;
      ABounds.Bottom := ABounds.Top + AArrowZoneHeight + Bottom + Top;
    end;
    AArrowRect := cxRectCenter(ABounds, AArrowSize);
  end
  else
  begin
    AContent := cxRectContent(ABounds, ABorders);
    AArrowRect := cxRectCenter(cxRectSetHeight(AContent, AArrowZoneHeight), AArrowSize);
    ATextRect := AContent;
    Inc(ATextRect.Top, AArrowZoneHeight + cxTextOffset);
    Dec(ATextRect.Bottom, 2 * AArrowSize.cy);
    ADelta := Max(ANextButtonTextSize.cx, APrevButtonTextSize.cx) -
      (ATextRect.Bottom - ATextRect.Top); 
    if ADelta > 0 then
    begin
      OffsetRect(AArrowRect, 0, -ADelta);
      InflateRect(ATextRect, 0, ADelta);
      InflateRect(ABounds, 0, ADelta);
    end;
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawSchedulerBorder(
  ACanvas: TcxCanvas; R: TRect);
begin
  DrawBorder(ACanvas, R);
end;

procedure TcxCustomLookAndFeelPainter.DrawSchedulerEventProgress(
  ACanvas: TcxCanvas; const ABounds, AProgress: TRect; AViewParams: TcxViewParams;
  ATransparent: Boolean);
begin
  if ATransparent then
    ACanvas.FrameRect(ABounds, clGray)
  else
    ACanvas.FillRect(ABounds, AViewParams, cxBordersAll, clGray);
  ACanvas.FillRect(AProgress, clNavy);
end;

procedure TcxCustomLookAndFeelPainter.DrawSchedulerNavigationButton(
  ACanvas: TcxCanvas; const ARect: TRect; AIsNextButton: Boolean;
  AState: TcxButtonState; const AText: string; const ATextRect: TRect;
  const AArrowRect: TRect);
begin
  DrawSchedulerNavigationButtonContent(ACanvas, ARect, AArrowRect, AIsNextButton, AState);
  if not IsRectEmpty(ATextRect) and (SchedulerNavigationButtonTextColor(AIsNextButton, AState, clDefault) <> clNone) then
    cxDrawText(ACanvas, AText, ATextRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE,
      SchedulerNavigationButtonTextColor(AIsNextButton, AState, ACanvas.Font.Color), raPlus90);
end;

procedure TcxCustomLookAndFeelPainter.DrawSchedulerNavigationButtonArrow(
  ACanvas: TcxCanvas; const ARect: TRect; AIsNextButton: Boolean; AColor: TColor);
const
  ASigns: array[Boolean] of Integer = (-1, 1);  
var
  ACount: Integer;
  I: Integer;
  R1, R2: TRect;
begin
  ACanvas.Brush.Color := AColor;
  ACount := (ARect.Bottom - ARect.Top) div 2 + Integer(Odd(ARect.Bottom - ARect.Top));
  with ARect do
    if AIsNextButton then
    begin
      R1 := Rect(Left, Top, Left + 2, Top + 1);
      R2 := Rect(Left, Bottom - 1, Left + 2, Bottom);
    end
    else
    begin
      R1 := Rect(Right - 2, Top, Right, Top + 1);
      R2 := Rect(Right - 2, Bottom - 1, Right, Bottom);
    end;

  for I := 0 to ACount - 1 do
  begin
    ACanvas.FillRect(R1);
    OffsetRect(R1, ASigns[AIsNextButton], 1);
    ACanvas.FillRect(R2);
    OffsetRect(R2, ASigns[AIsNextButton], -1);
  end;

  if AIsNextButton then
    ACanvas.FillRect(cxRectSetLeft(ARect, ARect.Right - 1, 1))
  else
    ACanvas.FillRect(cxRectSetRight(ARect, ARect.Left + 1, 1));
end;

procedure TcxCustomLookAndFeelPainter.DrawSchedulerNavigationButtonContent(
  ACanvas: TcxCanvas; const ARect: TRect; const AArrowRect: TRect;
  AIsNextButton: Boolean; AState: TcxButtonState);
const
  Borders: array[Boolean] of TcxBorders =
    ([bRight, bTop, bBottom], [bLeft, bTop, bBottom]);
  BottomRightColors: array[Boolean] of TColor =
    (clBtnFace, clBtnHighlight);
  TopLeftColors: array[Boolean] of TColor =
    (clBtnHighlight, clBtnShadow);
var
  R: TRect;
begin
  R := ARect;
  ACanvas.FillRect(R, clBtnFace);
  ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnShadow, Borders[AIsNextButton]);
  InflateRect(R, 0, -1);
  if AIsNextButton then
    Inc(R.Left)
  else
    Dec(R.Right);
  ACanvas.DrawComplexFrame(R, TopLeftColors[AState = cxbsPressed],
    BottomRightColors[AState = cxbsPressed], Borders[AIsNextButton]);
  DrawSchedulerNavigationButtonArrow(ACanvas, AArrowRect, AIsNextButton,
    ButtonSymbolColor(AState));
end;

procedure TcxCustomLookAndFeelPainter.DrawSchedulerNavigatorButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  DrawButton(ACanvas, R, '', AState);
end;

procedure TcxCustomLookAndFeelPainter.DrawSchedulerSplitterBorder(
  ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams; AIsHorizontal: Boolean);
begin
end;

function TcxCustomLookAndFeelPainter.SchedulerNavigationButtonTextColor(
  AIsNextButton: Boolean; AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
begin
  Result := ButtonSymbolColor(AState, ADefaultColor);
end;

procedure TcxCustomLookAndFeelPainter.SchedulerNavigationButtonSizes(
  AIsNextButton: Boolean; var ABorders: TRect; var AArrowSize: TSize;
  var AHasTextArea: Boolean);
const
  AButtonBorders: array[Boolean] of TRect =
    ((Left: 0; Top: 6; Right: 2; Bottom: 6),
     (Left: 2; Top: 6; Right: 0; Bottom: 6));
begin
  ABorders := AButtonBorders[AIsNextButton];
  AHasTextArea := True;
  AArrowSize.cx := 7;
  AArrowSize.cy := 7;
end;

function TcxCustomLookAndFeelPainter.SchedulerEventProgressOffsets: TRect;
begin
  Result := Rect(2, 2, 2, 2);
end;

function TcxCustomLookAndFeelPainter.ChartToolBoxDataLevelInfoBorderSize: Integer;
begin
  Result := 1;
end;

procedure TcxCustomLookAndFeelPainter.DrawClock(ACanvas: TcxCanvas;
  const ARect: TRect; ADateTime: TDateTime; ABackgroundColor: TColor);

  procedure DrawDot(X, Y: Integer; AHourDot: Boolean);
  begin
    if AHourDot then
    begin
      ACanvas.Pixels[X, Y] := clTeal;
      ACanvas.Pen.Color := clAqua;
      ACanvas.Polyline([Point(X - 1, Y + 1), Point(X - 1, Y - 1), Point(X, Y - 1)]);
      ACanvas.Pen.Color := clBtnText;
      ACanvas.Polyline([Point(X, Y + 1), Point(X + 1, Y + 1), Point(X + 1, Y - 1)]);
      ACanvas.ExcludeClipRect(Rect(X - 1, Y - 1, X + 2, Y + 2));
    end;
  end;

  procedure DrawHand(ACenter: TPoint; AAngle, L1X, L1Y, L2X, L2Y, L3: Extended);
  begin
    with ACanvas.Canvas do
    begin
      Brush.Color := clTeal;
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

  procedure DrawHands;
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
    with ACanvas.Canvas do
    begin
      AAngle := Pi * 2 * ((AHour mod 12) * 60 * 60 + AMin * 60 + ASec - 3 * 60 * 60) / 12 / 60 / 60;
      DrawHand(ACenter, AAngle, AHandRadiusX * 0.75, AHandRadiusY * 0.75,
        AHandRadiusX * 0.15, AHandRadiusY * 0.15, 9);

      AAngle := Pi * 2 * (AMin * 60 + ASec - 15 * 60) / 60 / 60;
      DrawHand(ACenter, AAngle, AHandRadiusX * 0.85, AHandRadiusY * 0.85,
        AHandRadiusX * 0.2, AHandRadiusY * 0.2, 7);

      Pen.Color := clRed;
      MoveTo(ACenter.X, ACenter.Y);
      AAngle := Pi * 2 * (ASec - 15) / 60;
      LineTo(Round(ACenter.X + AHandRadiusX * 0.9 * cos(AAngle)),
        Round(ACenter.Y + AHandRadiusY * 0.9 * sin(AAngle)));
    end;
  end;

var
  AAngle: Extended;
  ACenter: TPoint;
  I: Integer;
  RX, RY: Extended;
begin
  ACenter.X := (ARect.Right + ARect.Left) div 2;
  ACenter.Y := (ARect.Bottom + ARect.Top) div 2;
  RX := (ARect.Right - ARect.Left) / 2 - 2;
  RY := (ARect.Bottom - ARect.Top) / 2 - 2;
  for I := 0 to 59 do
  begin
    AAngle := 2 * Pi * I / 60;
    DrawDot(Round(ACenter.X + RX * cos(AAngle)), Round(ACenter.Y + RY * sin(AAngle)), I mod 5 = 0);
  end;
  with ACanvas do
    FillRect(ARect, ABackgroundColor);
  DrawHands;
end;

procedure TcxCustomLookAndFeelPainter.DrawEditorButton(
  ACanvas: TcxCanvas; const ARect: TRect; AButtonKind: TcxEditBtnKind;
  AState: TcxButtonState; APosition: TcxEditBtnPosition = cxbpRight);
begin
end;

function TcxCustomLookAndFeelPainter.EditButtonTextOffset: Integer;
begin
  Result := 0;
end;

function TcxCustomLookAndFeelPainter.EditButtonSize: TSize;
begin
  Result := cxNullSize;
end;

function TcxCustomLookAndFeelPainter.EditButtonTextColor: TColor;
begin
  Result := clDefault;
end;

function TcxCustomLookAndFeelPainter.GetContainerBorderColor(
  AIsHighlightBorder: Boolean): TColor;
begin
  Result := clBtnText;
end;

function TcxCustomLookAndFeelPainter.GetContainerBorderWidth(
  ABorderStyle: TcxContainerBorderStyle): Integer;
begin
  Result := cxContainerBorderWidthA1[ABorderStyle];
end;

procedure TcxCustomLookAndFeelPainter.DrawDateNavigatorDateHeader(
  ACanvas: TcxCanvas; var R: TRect);
begin
  ACanvas.FillRect(R, DefaultDateNavigatorHeaderColor);
  ACanvas.DrawEdge(R, False, False, cxBordersAll);
  InflateRect(R, -1, -1);
end;

procedure TcxCustomLookAndFeelPainter.DrawNavigatorGlyph(ACanvas: TcxCanvas;
  AImageList: TCustomImageList; AImageIndex: TImageIndex; AButtonIndex: Integer;
  const AGlyphRect: TRect; AEnabled: Boolean; AUserGlyphs: Boolean);
begin
  cxDrawImage(ACanvas.Handle, AGlyphRect, AGlyphRect, nil, AImageList, AImageIndex,
    EnabledImageDrawModeMap[AEnabled]);
end;

function TcxCustomLookAndFeelPainter.NavigatorGlyphSize: TSize;
begin
  Result := cxNullSize;
end;

procedure TcxCustomLookAndFeelPainter.DrawProgressBarChunk(
  ACanvas: TcxCanvas; ARect: TRect; AVertical: Boolean);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawProgressBarText(
  ACanvas: TcxCanvas; AVertical, ASolid: Boolean; const AText: string;
  const ATextRect, AProgressBarRect, AProgressChunkRect: TRect;
  ATextColor: TColor = clDefault);

  procedure InternalDrawText(DC: HDC; const ATextRect: TRect);
  begin
    if AVertical then
      TextOut(DC, ATextRect.Right, ATextRect.Top, PChar(AText), Length(AText))
    else
      TextOut(DC, ATextRect.Left, ATextRect.Top, PChar(AText), Length(AText));
  end;

  procedure DrawInvertedText(ACanvas: TcxCanvas; const ATextRect: TRect);
  var
    ACopyMode: Integer;
    ATextBmp: TcxBitmap;
    ATextSavedBmp: TcxBitmap;
  begin
    ATextBmp := TcxBitmap.CreateSize(ATextRect);
    ATextSavedBmp := TcxBitmap.CreateSize(ATextRect);
    try
      ATextBmp.Canvas.Font := ACanvas.Font;
      ATextBmp.Canvas.Font.Color := clBlack;
      ATextBmp.Canvas.Brush.Color := clWhite;
      ATextBmp.Canvas.FillRect(ATextBmp.Canvas.ClipRect);
      InternalDrawText(ATextBmp.Canvas.Handle, ATextBmp.ClientRect);
      ACopyMode := ACanvas.CopyMode;
      try
        BitBlt(ATextSavedBmp.Canvas.Handle, 0, 0, ATextBmp.Width, ATextBmp.Height,
          ACanvas.Handle, ATextRect.Left, ATextRect.Top, SRCCOPY);
        BitBlt(ATextBmp.Canvas.Handle, 0, 0, ATextBmp.Width, ATextBmp.Height,
          ACanvas.Handle, ATextRect.Left, ATextRect.Top, DSTINVERT);
        InternalDrawText(ACanvas.Handle, ATextRect);
        ACanvas.CopyMode := cmSrcCopy;
        ACanvas.Draw(ATextRect.Left, ATextRect.Top, ATextSavedBmp);
        ACanvas.CopyMode := cmSrcInvert;
        ACanvas.Draw(ATextRect.Left, ATextRect.Top, ATextBmp);
      finally
        ACanvas.CopyMode := ACopyMode;
      end;
    finally
      ATextSavedBmp.Free;
      ATextBmp.Free;
    end;
  end;
  
var
  ARect: TRect;
  ATextBmp: TcxBitmap;
begin
  ACanvas.SaveState;
  try
    if AVertical then
      ACanvas.SetFontAngle(270);
    if (ATextColor = clDefault) or not ASolid then
      ATextColor := ProgressBarTextColor;
    ACanvas.Font.Color := ATextColor;

    if ASolid then
      InternalDrawText(ACanvas.Handle, ATextRect)
    else
      if ProgressBarTextColorEx(True) = clDefault then
        DrawInvertedText(ACanvas, ATextRect)
      else
        if cxRectIntersect(ARect, ATextRect, AProgressChunkRect) then
        begin
          ATextBmp := TcxBitmap.CreateSize(ARect);
          try
            cxBitBlt(ATextBmp.Canvas.Handle, ACanvas.Handle, ATextBmp.ClientRect, ARect.TopLeft, SRCCOPY);
            ACanvas.Font.Color := ProgressBarTextColorEx(False);
            InternalDrawText(ACanvas.Handle, ATextRect);
            cxBitBlt(ACanvas.Handle, ATextBmp.Canvas.Handle, ARect, cxNullPoint, SRCCOPY);
            ACanvas.SetClipRegion(TcxRegion.Create(ARect), roIntersect);
            ACanvas.Font.Color := ProgressBarTextColorEx(True);
            InternalDrawText(ACanvas.Handle, ATextRect);
          finally
            ATextBmp.Free;
          end;
        end
        else
          InternalDrawText(ACanvas.Handle, ATextRect);
  finally
    ACanvas.RestoreState;
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawProgressBarBorder(
  ACanvas: TcxCanvas; ARect: TRect; AVertical: Boolean);
begin
end;

function TcxCustomLookAndFeelPainter.ProgressBarBorderSize(AVertical: Boolean): TRect;
begin
  Result := cxEmptyRect;
end;

function TcxCustomLookAndFeelPainter.ProgressBarTextColor: TColor;
begin
  Result := ProgressBarTextColorEx(False);
end;

function TcxCustomLookAndFeelPainter.ProgressBarTextColorEx(AIsFilledArea: Boolean): TColor;
begin
  if AIsFilledArea then
    Result := clDefault
  else
    Result := clWindowText;
end;

procedure TcxCustomLookAndFeelPainter.DrawGroupBoxBackground(ACanvas: TcxCanvas;
  ABounds: TRect; ARect: TRect);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawGroupBoxCaption(ACanvas: TcxCanvas;
  ACaptionRect: TRect; ACaptionPosition: TcxGroupBoxCaptionPosition);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawGroupBoxContent(ACanvas: TcxCanvas;
  ABorderRect: TRect; ACaptionPosition: TcxGroupBoxCaptionPosition;
  ABorders: TcxBorders = cxBordersAll);
begin
end;

procedure TcxCustomLookAndFeelPainter.DrawGroupBoxExpandButton(
  ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0);
begin
  DrawExpandButtonEx(ACanvas, R, AState, AExpanded, ARotationAngle);
end;

procedure TcxCustomLookAndFeelPainter.DrawGroupBoxFrame(ACanvas: TcxCanvas;
  R: TRect; AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition;
  ABorders: TcxBorders = cxBordersAll); 
begin
end;

function TcxCustomLookAndFeelPainter.GroupBoxBorderSize(ACaption: Boolean;
  ACaptionPosition: TcxGroupBoxCaptionPosition): TRect;
begin
  Result := cxEmptyRect;
end;

function TcxCustomLookAndFeelPainter.GroupBoxTextColor(
  AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TColor;
begin
  if AEnabled then
    Result := clWindowText
  else
    Result := clBtnShadow;
end;

function TcxCustomLookAndFeelPainter.IsGroupBoxTransparent(AIsCaption: Boolean;
  ACaptionPosition: TcxGroupBoxCaptionPosition): Boolean;
begin
  Result := False;
end;

procedure TcxCustomLookAndFeelPainter.DrawPanelBorders(ACanvas: TcxCanvas;
  const ABorderRect: TRect);
begin    
end;

procedure TcxCustomLookAndFeelPainter.DrawPanelCaption(
  ACanvas: TcxCanvas; const ACaptionRect: TRect;
  ACaptionPosition: TcxGroupBoxCaptionPosition);
begin
  DrawGroupBoxCaption(ACanvas, ACaptionRect, ACaptionPosition);
end;

procedure TcxCustomLookAndFeelPainter.DrawPanelBackground(
  ACanvas: TcxCanvas; AControl: TWinControl; ABounds: TRect;
  AColorFrom: TColor = clDefault; AColorTo: TColor = clDefault);
begin
  DrawGroupBoxBackground(ACanvas, ABounds, ABounds);
end;

procedure TcxCustomLookAndFeelPainter.DrawPanelContent(
  ACanvas: TcxCanvas; const ABorderRect: TRect; ABorder: Boolean);
begin
  ACanvas.FillRect(ABorderRect, clBtnFace);
end;

function TcxCustomLookAndFeelPainter.PanelBorderSize: TRect;
begin
  Result := cxEmptyRect;
end;

function TcxCustomLookAndFeelPainter.PanelTextColor: TColor;
begin
  Result := GroupBoxTextColor(True, cxgpTop);
end;

procedure TcxCustomLookAndFeelPainter.CorrectThumbRect(ACanvas: TcxCanvas;
  var ARect: TRect; AHorizontal: Boolean; ATicks: TcxTrackBarTicksAlign);
begin
  ExtendRect(ARect, Rect(0, 0, -1, -1));
end;

procedure TcxCustomLookAndFeelPainter.DrawTrackBarTrack(ACanvas: TcxCanvas;
  const ARect, ASelection: TRect; AShowSelection, AEnabled, AHorizontal: Boolean; ATrackColor: TColor);
begin
  ACanvas.FillRect(ARect, ATrackColor);
  DrawTrackBarTrackBounds(ACanvas, ARect);
end;

procedure TcxCustomLookAndFeelPainter.DrawTrackBarTrackBounds(ACanvas: TcxCanvas; const ARect: TRect);
begin

end;

procedure TcxCustomLookAndFeelPainter.DrawTrackBarThumb(ACanvas: TcxCanvas;
  const ARect: TRect; AState: TcxButtonState; AHorizontal: Boolean;
  ATicks: TcxTrackBarTicksAlign; AThumbColor: TColor);

  procedure GetBottomRightThumbShape(const AThumbRect: TRect;
    AHorizontal: Boolean;
    var ALightPolyLine, AShadowPolyLine, ADarkPolyLine, APolygon: TPointArray);
  var
    AThumbSize: Integer;
    AMiddle: TPoint;
  begin
    SetLength(ALightPolyLine, 4);
    SetLength(AShadowPolyLine, 3);
    SetLength(ADarkPolyLine, 3);
    SetLength(APolygon, 5);

    if AHorizontal then // Bottom
    begin
      AThumbSize := cxRectWidth(AThumbRect);
      AMiddle.X := AThumbRect.Left + (AThumbSize div 2);
      AMiddle.Y := AThumbRect.Bottom - (AThumbSize div 2);

      ALightPolyLine[0] := Point(AThumbRect.Right, AThumbRect.Top);
      ALightPolyLine[1] := Point(AThumbRect.Left, AThumbRect.Top);
      ALightPolyLine[2] := Point(AThumbRect.Left, AMiddle.Y);
      ALightPolyLine[3] := Point(AMiddle.X, AThumbRect.Bottom);

      ADarkPolyLine[0] := Point(AMiddle.X, AThumbRect.Bottom);
      ADarkPolyLine[1] := Point(AThumbRect.Right, AMiddle.Y);
      ADarkPolyLine[2] := Point(AThumbRect.Right, AThumbRect.Top);

      AShadowPolyLine[0] := Point(AMiddle.X, AThumbRect.Bottom - 1);
      AShadowPolyLine[1] := Point(AThumbRect.Right - 1, AMiddle.Y);
      AShadowPolyLine[2] := Point(AThumbRect.Right - 1, AThumbRect.Top);

      APolygon[0] := Point(AThumbRect.Right - 1, AThumbRect.Top + 1);
      APolygon[1] := Point(AThumbRect.Left + 1, AThumbRect.Top + 1);
      APolygon[2] := Point(AThumbRect.Left + 1, AMiddle.Y);
      APolygon[3] := Point(AMiddle.X, AThumbRect.Bottom - 1);
      APolygon[4] := Point(AThumbRect.Right - 1, AMiddle.Y);
    end
    else // Right
    begin
      AThumbSize := cxRectHeight(AThumbRect);
      AMiddle.X := AThumbRect.Right - (AThumbSize div 2);
      AMiddle.Y := AThumbRect.Top + (AThumbSize div 2);

      ALightPolyLine[0] := Point(AThumbRect.Left, AThumbRect.Bottom);
      ALightPolyLine[1] := Point(AThumbRect.Left, AThumbRect.Top);
      ALightPolyLine[2] := Point(AMiddle.X, AThumbRect.Top);
      ALightPolyLine[3] := Point(AThumbRect.Right, AMiddle.Y);

      ADarkPolyLine[0] := Point(AThumbRect.Right, AMiddle.Y);
      ADarkPolyLine[1] := Point(AMiddle.X, AThumbRect.Bottom);
      ADarkPolyLine[2] := Point(AThumbRect.Left, AThumbRect.Bottom);

      AShadowPolyLine[0] := Point(AThumbRect.Right - 1, AMiddle.Y);
      AShadowPolyLine[1] := Point(AMiddle.X, AThumbRect.Bottom - 1);
      AShadowPolyLine[2] := Point(AThumbRect.Left, AThumbRect.Bottom - 1);

      APolygon[0] := Point(AThumbRect.Left + 1, AThumbRect.Bottom - 1);
      APolygon[1] := Point(AThumbRect.Left + 1, AThumbRect.Top + 1);
      APolygon[2] := Point(AMiddle.X, AThumbRect.Top + 1);
      APolygon[3] := Point(AThumbRect.Right - 1, AMiddle.Y);
      APolygon[4] := Point(AMiddle.X, AThumbRect.Bottom - 1);
    end;
  end;

  procedure GetTopLeftThumbShape(const AThumbRect: TRect;
    AHorizontal: Boolean;
    var ALightPolyLine, AShadowPolyLine, ADarkPolyLine, APolygon: TPointArray);
  var
    AThumbSize: Integer;
    AMiddle: TPoint;
  begin
    SetLength(ALightPolyLine, 3);
    SetLength(AShadowPolyLine, 4);
    SetLength(ADarkPolyLine, 4);
    SetLength(APolygon, 5);

    if AHorizontal then // Top
    begin
      AThumbSize := cxRectWidth(AThumbRect);
      AMiddle.X :=  AThumbRect.Left + (AThumbSize div 2);
      AMiddle.Y := AThumbRect.Top + (AThumbSize div 2);

      ALightPolyLine[0] := Point(AThumbRect.Left, AThumbRect.Bottom - 1);
      ALightPolyLine[1] := Point(AThumbRect.Left, AMiddle.Y - 1);
      ALightPolyLine[2] := Point(AMiddle.X, AThumbRect.Top - 1);

      AShadowPolyLine[0] := Point(AMiddle.X, AThumbRect.Top);
      AShadowPolyLine[1] := Point(AThumbRect.Right - 1, AMiddle.Y - 1);
      AShadowPolyLine[2] := Point(AThumbRect.Right - 1, AThumbRect.Bottom - 2);
      AShadowPolyLine[3] := Point(AThumbRect.Left, AThumbRect.Bottom - 2);

      ADarkPolyLine[0] := Point(AMiddle.X, AThumbRect.Top - 1);
      ADarkPolyLine[1] := Point(AThumbRect.Right, AMiddle.Y - 1);
      ADarkPolyLine[2] := Point(AThumbRect.Right, AThumbRect.Bottom - 1);
      ADarkPolyLine[3] := Point(AThumbRect.Left, AThumbRect.Bottom - 1);

      APolygon[0] := Point(AThumbRect.Right - 1, AThumbRect.Bottom - 2);
      APolygon[1] := Point(AThumbRect.Left + 1, AThumbRect.Bottom - 2);
      APolygon[2] := Point(AThumbRect.Left + 1, AMiddle.Y - 1);
      APolygon[3] := Point(AMiddle.X, AThumbRect.Top);
      APolygon[4] := Point(AThumbRect.Right - 1, AMiddle.Y - 1);
    end
    else // Left
    begin
      AThumbSize := cxRectHeight(AThumbRect);
      AMiddle.X := AThumbRect.Left + (AThumbSize div 2);
      AMiddle.Y := AThumbRect.Top + (AThumbSize div 2);

      ALightPolyLine[0] := Point(AThumbRect.Right - 1, AThumbRect.Top);
      ALightPolyLine[1] := Point(AMiddle.X - 1, AThumbRect.Top);
      ALightPolyLine[2] := Point(AThumbRect.Left - 1, AMiddle.Y);

      ADarkPolyLine[0] := Point(AThumbRect.Left - 1, AMiddle.Y);
      ADarkPolyLine[1] := Point(AMiddle.X - 1, AThumbRect.Bottom);
      ADarkPolyLine[2] := Point(AThumbRect.Right - 1, AThumbRect.Bottom);
      ADarkPolyLine[3] := Point(AThumbRect.Right - 1, AThumbRect.Top);

      AShadowPolyLine[0] := Point(AThumbRect.Left, AMiddle.Y);
      AShadowPolyLine[1] := Point(AMiddle.X - 1, AThumbRect.Bottom - 1);
      AShadowPolyLine[2] := Point(AThumbRect.Right - 2, AThumbRect.Bottom - 1);
      AShadowPolyLine[3] := Point(AThumbRect.Right - 2, AThumbRect.Top);

      APolygon[0] := Point(AThumbRect.Right - 2, AThumbRect.Bottom - 1);
      APolygon[1] := Point(AThumbRect.Right - 2, AThumbRect.Top + 1);
      APolygon[2] := Point(AMiddle.X - 1, AThumbRect.Top + 1);
      APolygon[3] := Point(AThumbRect.Left, AMiddle.Y);
      APolygon[4] := Point(AMiddle.X - 1, AThumbRect.Bottom - 1);
    end;
  end;

var
  ALightPolyLine, AShadowPolyLine, ADarkPolyLine, APolygon: TPointArray;
begin
  ACanvas.Pen.Color := AThumbColor;
  ACanvas.Brush.Color := AThumbColor;
  case ATicks of
    tbtaUp:
      begin
        GetTopLeftThumbShape(ARect, AHorizontal, ALightPolyLine, AShadowPolyLine, ADarkPolyLine, APolygon);
        ACanvas.Polygon(APolygon);
        DrawTrackBarThumbBorderUpDown(ACanvas, ALightPolyLine, AShadowPolyLine, ADarkPolyLine);
      end;
    tbtaDown:
      begin
        GetBottomRightThumbShape(ARect, AHorizontal, ALightPolyLine, AShadowPolyLine, ADarkPolyLine, APolygon);
        ACanvas.Polygon(APolygon);
        DrawTrackBarThumbBorderUpDown(ACanvas, ALightPolyLine, AShadowPolyLine, ADarkPolyLine);
      end;
    tbtaBoth:
    begin
      ACanvas.Canvas.FillRect(ARect);
      DrawTrackBarThumbBorderBoth(ACanvas, ARect);
    end;
  end;
end;

procedure TcxCustomLookAndFeelPainter.DrawTrackBarThumbBorderUpDown(ACanvas: TcxCanvas;
  const ALightPolyLine, AShadowPolyLine, ADarkPolyLine: TPointArray);
begin
//
end;

procedure TcxCustomLookAndFeelPainter.DrawTrackBarThumbBorderBoth(ACanvas: TcxCanvas; const ARect: TRect);
begin

end;

function TcxCustomLookAndFeelPainter.TrackBarThumbSize(AHorizontal: Boolean): TSize;
begin
  Result := cxNullSize;
end;

function TcxCustomLookAndFeelPainter.TrackBarTicksColor(AText: Boolean): TColor;
begin
  Result := clDefault;
end;

function TcxCustomLookAndFeelPainter.TrackBarTrackSize: Integer;
begin
  Result := 0;
end;

function TcxCustomLookAndFeelPainter.GetSplitterInnerColor(AHighlighted: Boolean): TColor;
begin
  Result := clWhite;
end;

function TcxCustomLookAndFeelPainter.GetSplitterOuterColor(AHighlighted: Boolean): TColor;
begin
  Result := clBtnShadow;
end;

procedure TcxCustomLookAndFeelPainter.DrawSplitter(ACanvas: TcxCanvas;
  const ARect: TRect; AHighlighted: Boolean; AClicked: Boolean; AHorizontal: Boolean);

  procedure InternalDrawSplitter(AColor: TColor; const R: TRect);

    procedure SetFirst(var P1, P2: TPoint);
    begin
      P1 := R.TopLeft;
      P2 := P1;
      if AHorizontal then
        P2.X := (R.Right + R.Left) div 2 - 5
      else
        P2.Y := (R.Top + R.Bottom) div 2 - 5;
    end;

    procedure SetNext(var P1, P2: TPoint);
    begin
      if AHorizontal then
      begin
        P1.X := P2.X + 1;
        P2.X := P1.X + 2;
      end
      else
      begin
        P1.Y := P2.Y + 1;
        P2.Y := P1.Y + 2;
      end;
    end;

    procedure SetLast(var P1, P2: TPoint);
    begin
      SetNext(P1, P2);
      if AHorizontal then
        P2.X := R.Right
      else
        P2.Y := R.Bottom;
    end;

  var
    I: Integer;
    P1, P2: TPoint;
  begin
    ACanvas.Pen.Color := AColor;
    SetFirst(P1, P2);
    ACanvas.Polyline([P1, P2]);
    for I := 0 to 2 do
    begin
      SetNext(P1, P2);
      ACanvas.Polyline([P1, P2]);
    end;
    SetLast(P1, P2);
    ACanvas.Polyline([P1, P2]);
  end;

var
  R: TRect;
  AHasInnerLine: Boolean;
  ASplitterSize: TSize;
begin
  ASplitterSize := GetSplitterSize(AHorizontal);
  AHasInnerLine := (AHorizontal and (ASplitterSize.cy > 1)) or (not AHorizontal and (ASplitterSize.cx > 1));
  R := cxRectCenter(ARect, IfThen(AHorizontal, cxRectWidth(ARect), 1), IfThen(AHorizontal, 1, cxRectHeight(ARect)));
  R := Rect(R.Left, R.Top, R.Right - IfThen(AHorizontal and not AHasInnerLine, 1, 0), R.Bottom - IfThen(AHorizontal and not AHasInnerLine, 0, 1));
  InternalDrawSplitter(GetSplitterOuterColor(AHighlighted), R);
  if AHasInnerLine then
  begin
    R := cxRectOffset(R, 1, 1);
    InternalDrawSplitter(GetSplitterInnerColor(AHighlighted), R);
  end;
end;

function TcxCustomLookAndFeelPainter.GetSplitterSize(AHorizontal: Boolean): TSize;
begin
  if AHorizontal then
    Result := Size(17, 2)
  else
    Result := Size(2, 17);
end;

function TcxCustomLookAndFeelPainter.LayoutControlEmptyAreaColor: TColor;
begin
  Result := clBtnFace;
end;

procedure TcxCustomLookAndFeelPainter.DrawLayoutControlBackground(
  ACanvas: TcxCanvas; const R: TRect);
begin
  ACanvas.FillRect(R, LayoutControlEmptyAreaColor);
end;

function TcxCustomLookAndFeelPainter.PrintPreviewPageBordersWidth: TRect;
begin
  Result := Rect(2, 2, 4, 4);
end;

procedure TcxCustomLookAndFeelPainter.DrawPrintPreviewBackground(
  ACanvas: TcxCanvas; const R: TRect);
begin
  ACanvas.FillRect(R, clBtnShadow);
end;

procedure TcxCustomLookAndFeelPainter.DrawPrintPreviewPageBackground(
  ACanvas: TcxCanvas; const ABorderRect, AContentRect: TRect;
  ASelected, ADrawContent: Boolean);
const
  FrameColorMap: array[Boolean] of TColor = (clWindowText, clHighlight);
var
  R: TRect;
begin
  ACanvas.SaveClipRegion;
  try
    R := cxRectInflate(ABorderRect, 0, 0, -2, -2);
    if ADrawContent then
      ACanvas.FillRect(AContentRect, clWindow);
    if not ASelected then
      InflateRect(R, -1, -1);
    ACanvas.ExcludeClipRect(AContentRect);
    ACanvas.FillRect(R, FrameColorMap[ASelected]);
    ACanvas.ExcludeClipRect(R);
    ACanvas.FillRect(cxRectOffset(R, 2, 2), clWindowText);
  finally
    ACanvas.RestoreClipRegion;
  end;
end;

function TcxCustomLookAndFeelPainter.CalcEditButtonTextColor(
  AButtonKind: TcxCalcButtonKind): TColor;
const
  BtnColors : array [TcxCalcButtonKind] of TColor = (
    clMaroon, clMaroon, clMaroon, clRed, clRed, clRed, clRed, clBlue, clBlue,
    clBlue, clBlue, clBlue, clBlue, clBlue, clBlue, clBlue, clBlue, clBlue,
    clBlue, clRed, clRed, clRed, clRed, clNavy, clNavy, clNavy, clRed, clBlue);
begin
  Result := BtnColors[AButtonKind];
end;

function TcxCustomLookAndFeelPainter.GetCustomizationFormListBackgroundColor: TColor;
begin
  Result := clBtnFace;
end;

{ TcxStandardLookAndFeelPainter }

function TcxStandardLookAndFeelPainter.LookAndFeelName: string;
begin
  Result := 'Standard';
end;

function TcxStandardLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsStandard;
end;

function TcxStandardLookAndFeelPainter.BorderSize: Integer;
begin
  Result := 2;
end;

procedure TcxStandardLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnHighlight);
  InflateRect(R, -1, -1);
  ACanvas.DrawComplexFrame(R, cl3DDkShadow, cl3DLight);
end;

function TcxStandardLookAndFeelPainter.ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer;
begin
  if AState = cxbsDefault then Result := 3 else Result := 2;
end;

function TcxStandardLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := 1;
end;

function TcxStandardLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := 1;
end;

procedure TcxStandardLookAndFeelPainter.DrawButtonBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
begin
  if AState = cxbsPressed then
  begin
    ACanvas.FrameRect(R, clBlack);
    InflateRect(R, -1, -1);
    ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnShadow);
  end
  else
  begin
    if AState = cxbsDefault then
    begin
      ACanvas.FrameRect(R, clBlack);
      InflateRect(R, -1, -1);
    end;
    ACanvas.DrawComplexFrame(R, clBtnHighlight, cl3DDkShadow);
    InflateRect(R, -1, -1);
    ACanvas.DrawComplexFrame(R, cl3DLight, clBtnShadow);
  end;
end;

procedure TcxStandardLookAndFeelPainter.DrawGroupExpandButton(
  ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AState: TcxButtonState);
var
  APainter: TcxCustomLookAndFeelPainter;
begin
  if cxLookAndFeelPaintersManager.GetPainter(lfsFlat, APainter) then
    APainter.DrawGroupExpandButton(ACanvas, R, AExpanded, AState)
  else
    inherited DrawGroupExpandButton(ACanvas, R, AExpanded, AState);
end;

function TcxStandardLookAndFeelPainter.ExpandButtonSize: Integer;
begin
  Result := 12;
end;

procedure TcxStandardLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
var
  ARect: TRect;

  procedure DrawButton;
  begin
    ACanvas.DrawEdge(ARect, False, False, [bLeft, bTop]);
    ACanvas.DrawEdge(ARect, False, True, [bRight, bBottom]);
    InflateRect(ARect, -1, -1);
    ACanvas.DrawEdge(ARect, False, False, [bRight, bBottom]);
    Dec(ARect.Right);
    Dec(ARect.Bottom);
    if AColor = clDefault then
      ACanvas.Brush.Color := clBtnFace
    else
      ACanvas.Brush.Color := AColor;
    ACanvas.FillRect(ARect);
  end;

begin
  ARect := R;
  DrawButton;
  DrawExpandButtonCross(ACanvas, ARect, AExpanded, clBtnText);
  ACanvas.ExcludeClipRect(R);
end;

function TcxStandardLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := False;
end;

procedure TcxStandardLookAndFeelPainter.DrawCheckBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
begin
  ACanvas.DrawEdge(R, True, False{True});
  InflateRect(R, -1, -1);
  ACanvas.DrawEdge(R, True, True{False});
end;

procedure TcxStandardLookAndFeelPainter.DrawHeaderBorder(ACanvas: TcxCanvas;
  const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders);
var
  I: TcxNeighbor;
begin
  with ACanvas do
  begin
    DrawEdge(R, False, False);
    for I := Low(I) to High(I) do
      if I in ANeighbors then
        case I of
          nLeft:
            begin
              Pixels[R.Left, R.Top + 1] := clBtnFace;  //!!!
              Pixels[R.Left, R.Bottom - 2] := clBtnFace;  //!!!
            end;
          nRight:
            begin
              Pixels[R.Right - 1, R.Top] := clBtnHighlight;
              Pixels[R.Right - 1, R.Top + 1] := clBtnFace;  //!!!
              Pixels[R.Right - 1, R.Bottom - 2] := clBtnFace;  //!!!
            end;
          nTop:;
          nBottom:;
        end;
  end;
end;

procedure TcxStandardLookAndFeelPainter.DrawHeaderControlSectionBorder(
  ACanvas: TcxCanvas; const R: TRect;
  ABorders: TcxBorders; AState: TcxButtonState);
var
  ARect: TRect;
begin
  ARect := R;
  if AState <> cxbsPressed then
  begin
    ACanvas.DrawComplexFrame(ARect, clBtnHighlight,
      cl3DDkShadow, ABorders);
    InflateRect(ARect, -1, -1);
    ACanvas.DrawComplexFrame(ARect, cl3DLight, clBtnShadow, ABorders);
  end
  else
    ACanvas.DrawComplexFrame(ARect, clBtnShadow, clBtnShadow, ABorders);
end;

procedure TcxStandardLookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
  DrawSortingArrow(ACanvas, R, clBtnShadow, clBtnHighlight, AAscendingSorting);
end;

function TcxStandardLookAndFeelPainter.HeaderBorderSize: Integer;
begin
  Result := 1;
end;

function TcxStandardLookAndFeelPainter.HeaderControlSectionBorderSize(
  AState: TcxButtonState = cxbsNormal): Integer;
begin
  if AState = cxbsPressed then
    Result := 1
  else
    Result := 2;
end;

function TcxStandardLookAndFeelPainter.SortingMarkSize: TPoint;
begin
  Result := Point(8, 7);
end;

function TcxStandardLookAndFeelPainter.FooterBorderSize: Integer;
begin
  Result := 1;
end;

function TcxStandardLookAndFeelPainter.FooterCellBorderSize: Integer;
begin
  Result := 1;
end;

function TcxStandardLookAndFeelPainter.FooterCellOffset: Integer;
begin
  Result := 1;
end;

procedure TcxStandardLookAndFeelPainter.DrawFooterBorder(ACanvas: TcxCanvas;
  const R: TRect);
begin
  ACanvas.DrawEdge(R, False, False);
end;

procedure TcxStandardLookAndFeelPainter.DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect);
begin
  ACanvas.DrawEdge(R, True, True);
end;

procedure TcxStandardLookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState; AIsFilterActive: Boolean);

  function GetArrowColor: TColor;
  begin
    if AIsFilterActive then
      Result := ActiveFilterButtonArrowColor
    else
      Result := clBtnText;
  end;

begin
  if AState <> cxbsPressed then
    ACanvas.DrawEdge(R, False, False)
  else
    ACanvas.DrawEdge(R, True, True);
  InflateRect(R, -1, -1);
  ACanvas.Brush.Color := clBtnFace;
  ACanvas.FillRect(R);
  DrawButtonArrow(ACanvas, R, GetArrowColor);
end;

procedure TcxStandardLookAndFeelPainter.DrawTabBorder(ACanvas: TcxCanvas; R: TRect;
  ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean);
const
  Colors: array[Boolean] of TColor = (clBtnShadow, clBtnHighlight);

  procedure ProcessVerticalTabBorder;
  begin
    case ABorder of
       bLeft:
         begin
           Inc(R.Top);
           if bTop in ABorders then Inc(R.Top);
           Dec(R.Bottom);
           if bBottom in ABorders then Dec(R.Bottom);
         end;
       bTop, bBottom:
         if bLeft in ABorders then Inc(R.Left);
    end;
    if ABorder = bLeft then
    begin
      ACanvas.Pixels[R.Left + 1, R.Top - 1] := Colors[True];
      ACanvas.Pixels[R.Left + 1, R.Bottom] := Colors[True];
    end;
    ACanvas.Brush.Color := Colors[ABorder <> bBottom];
  end;

  procedure ProcessHorizontalTabBorder;
  begin
    case ABorder of
       bTop:
         begin
           Inc(R.Left);
           Dec(R.Right);
         end;
       bLeft, bRight:
         begin
           if bTop in ABorders then Inc(R.Top, 2);
           if bBottom in ABorders then Dec(R.Bottom);
         end;
    end;
    if ABorder = bTop then
    begin
      ACanvas.Pixels[R.Left - 1, R.Top + 1] := Colors[True];
      ACanvas.Pixels[R.Right, R.Top + 1] := Colors[True];
    end;
    ACanvas.Brush.Color := Colors[ABorder <> bRight];
  end;

begin
  if AVertical then
    ProcessVerticalTabBorder
  else
    ProcessHorizontalTabBorder;
  ACanvas.FillRect(R);
end;

procedure TcxStandardLookAndFeelPainter.DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect;
  ABorders: TcxBorders; AVertical: Boolean);
begin
  ACanvas.DrawEdge(R, False, False, ABorders);
end;

function TcxStandardLookAndFeelPainter.TabBorderSize(AVertical: Boolean): Integer;
begin
  Result := 1;
end;

procedure TcxStandardLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);

  function GetArrowState: Integer;
  const
    States: array[Boolean, Boolean] of Integer = ((DFCS_SCROLLUP, DFCS_SCROLLDOWN),
     (DFCS_SCROLLLEFT, DFCS_SCROLLRIGHT));
  begin
    Result := States[AHorizontal, APart = sbpLineDown];
    if AState = cxbsDisabled then Result := Result or DFCS_INACTIVE
    else if AState = cxbsPressed then Result := Result or DFCS_FLAT;
  end;

  procedure DrawScrollBarButtonBorder(R: TRect);
  begin
    if (AState <> cxbsPressed) or (APart = sbpThumbnail) then
    begin
      ACanvas.DrawComplexFrame(R, clBtnFace, cl3DDkShadow);
      InflateRect(R, -1, -1);
      ACanvas.DrawComplexFrame(R, clBtnHighlight, clBtnShadow);
    end
    else
    begin
      ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnShadow);
      InflateRect(R, -1, -1);
      ACanvas.DrawComplexFrame(R, clBtnFace, clBtnFace);
    end;
  end;

begin
  if IsRectEmpty(R) or ((APart = sbpThumbnail) and (AState = cxbsDisabled)) then Exit;
  if AState = cxbsHot then AState := cxbsNormal;
  case APart of
    sbpThumbnail, sbpLineUp, sbpLineDown:
      begin
        // for compatibility with standard painting
        if APart <> sbpThumbnail then
        begin
          if AState = cxbsPressed then OffsetRect(R, 1, 1);
          DrawFrameControl(ACanvas.Canvas.Handle, R, DFC_SCROLL, GetArrowState);
          if AState = cxbsPressed then OffsetRect(R, -1, -1);
          DrawScrollBarButtonBorder(R);
        end
        else
        begin
          DrawScrollBarButtonBorder(R);
          InflateRect(R, -ButtonBorderSize, -ButtonBorderSize);
          ACanvas.Brush.Color := clBtnFace;
          ACanvas.FillRect(R);
        end;
      end;
    sbpPageUp, sbpPageDown:
      begin
        ACanvas.Brush.Bitmap := StdScrollBitmaps[AState = cxbsPressed];
        ACanvas.FillRect(R);
        ACanvas.Brush.Bitmap := nil;
        ACanvas.Brush.Style := bsSolid;
      end;
  end;
end;

procedure TcxStandardLookAndFeelPainter.DrawMonthHeader(ACanvas: TcxCanvas;
  const ABounds: TRect; const AText: string; ANeighbors: TcxNeighbors;
  const AViewParams: TcxViewParams; AArrows: TcxHeaderArrows;
  ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
const
  Borders: array[Boolean, Boolean] of TcxBorders =
  ((cxBordersAll, [bTop, bBottom, bLeft]), ([bTop, bBottom, bRight], [bTop, bBottom]));
var
  ABorders: TcxBorders;
  R: TRect;
begin
  ABorders := Borders[nLeft in ANeighbors, nRight in ANeighbors];
  ACanvas.FrameRect(ABounds, clBlack, 1, ABorders);
  R := HeaderContentBounds(ABounds, ABorders);
  DrawHeader(ACanvas, R, R, ANeighbors, cxBordersAll, cxbsNormal, taCenter,
    vaCenter, False, False, AText, AViewParams.Font, AViewParams.TextColor,
    AViewParams.Color, AOnDrawBackground);
  DrawMonthHeaderArrows(ACanvas, ABounds, AArrows, ASideWidth, clWindowText);
end;

function TcxStandardLookAndFeelPainter.DefaultSchedulerViewContentColor: TColor;
begin
  Result := clWindow;
end;

procedure TcxStandardLookAndFeelPainter.DrawSchedulerSplitterBorder(
  ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams;
  AIsHorizontal: Boolean);

  procedure DrawHorzBorders(const R: TRect; ATopColor, ABottomColor: TColor);
  begin
    ACanvas.SetBrushColor(ATopColor);
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
    ACanvas.SetBrushColor(ABottomColor);
    ACanvas.FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
  end;

  procedure DrawVertBorders(const R: TRect; ALeftColor, ARightColor: TColor);
  begin
    ACanvas.SetBrushColor(ALeftColor);
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Left + 1, R.Bottom));
    ACanvas.SetBrushColor(ARightColor);
    ACanvas.FillRect(Rect(R.Right - 1, R.Top, R.Right, R.Bottom));
  end;

begin
  if AIsHorizontal then
  begin
    DrawHorzBorders(R, clBtnFace, cl3DDkShadow);
    InflateRect(R, 1, -1);
    DrawHorzBorders(R, clBtnHighlight, clBtnShadow);
    InflateRect(R, 1, -1);
  end
  else
  begin
    DrawVertBorders(R, clBtnFace, cl3DDkShadow);
    InflateRect(R, -1, 1);
    DrawVertBorders(R, clBtnHighlight, clBtnShadow);
    InflateRect(R, -1, 1);
  end;
  ACanvas.FillRect(R, AViewParams);
end;

procedure TcxStandardLookAndFeelPainter.DrawGroupBoxFrame(ACanvas: TcxCanvas;
  R: TRect; AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition;
  ABorders: TcxBorders = cxBordersAll);
begin
  Dec(R.Right);
  Dec(R.Bottom);
  ACanvas.FrameRect(R, clBtnShadow, 1, ABorders, True);
  OffsetRect(R, 1, 1);
  ACanvas.FrameRect(R, clBtnHighlight, 1, ABorders, True);
end;

procedure TcxStandardLookAndFeelPainter.DrawTrackBarTrackBounds(ACanvas: TcxCanvas; const ARect: TRect);
var
  R: TRect;
begin
  R := ARect;
  ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnHighlight);
  InflateRect(R, -1, -1);
  ACanvas.DrawComplexFrame(R, cl3DDkShadow, cl3DLight);
end;

procedure TcxStandardLookAndFeelPainter.DrawTrackBarThumbBorderUpDown(ACanvas: TcxCanvas;
  const ALightPolyLine, AShadowPolyLine, ADarkPolyLine: TPointArray);
begin
  ACanvas.Pen.Color := clBtnHighlight;
  ACanvas.Polyline(ALightPolyLine);
  ACanvas.Pen.Color := clBtnShadow;
  ACanvas.Polyline(AShadowPolyLine);
  ACanvas.Pen.Color := cl3DDkShadow;
  ACanvas.Polyline(ADarkPolyLine);
end;

procedure TcxStandardLookAndFeelPainter.DrawTrackBarThumbBorderBoth(ACanvas: TcxCanvas; const ARect: TRect);
var
  R: TRect;
begin
  R := ARect;
  ACanvas.DrawComplexFrame(R, clBtnHighlight, cl3DDkShadow);
  InflateRect(R, -1, -1);
  ACanvas.DrawComplexFrame(R, cl3DLight, clBtnShadow);
end;

{ TcxFlatLookAndFeelPainter }

function TcxFlatLookAndFeelPainter.LookAndFeelName: string;
begin
  Result := 'Flat';
end;

function TcxFlatLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsFlat;
end;

function TcxFlatLookAndFeelPainter.BorderSize: Integer;
begin
  Result := 1;
end;

procedure TcxFlatLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  ACanvas.DrawEdge(R, True, True);
end;

function TcxFlatLookAndFeelPainter.ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer;
begin
  if AState = cxbsDefault then Result := 2 else Result := 1;
end;

function TcxFlatLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := 1;
end;

function TcxFlatLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := 1;
end;

procedure TcxFlatLookAndFeelPainter.DrawButtonBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
begin
  if AState = cxbsPressed then
    ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnHighlight)
  else
  begin
    if AState = cxbsDefault then
    begin
      ACanvas.FrameRect(R, clBlack);
      InflateRect(R, -1, -1);
    end;
    ACanvas.DrawComplexFrame(R, clBtnHighlight, clBtnShadow)
  end;
end;

procedure TcxFlatLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
var
  ARect: TRect;
begin
  ARect := R;
  DrawButton(ACanvas, ARect, '', cxbsNormal, True, AColor);
  InflateRect(ARect, -1, -1);
  DrawExpandButtonCross(ACanvas, ARect, AExpanded, clBtnText);
  ACanvas.ExcludeClipRect(R);
end;

function TcxFlatLookAndFeelPainter.ExpandButtonSize: Integer;
begin
  Result := 11;
end;

function TcxFlatLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := False;
end;

procedure TcxFlatLookAndFeelPainter.DrawCheckBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
begin
  ACanvas.DrawEdge(R, True, True);
  InflateRect(R, -1, -1);
  ACanvas.FrameRect(R, CheckButtonColor(AState));
end;

procedure TcxFlatLookAndFeelPainter.DrawHeaderBorder(ACanvas: TcxCanvas;
  const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders);
var
  I: TcxNeighbor;
begin
  with ACanvas do
  begin
    DrawEdge(R, False, False);
    for I := Low(I) to High(I) do
      if I in ANeighbors then
        case I of
          nLeft:
            begin
              Pixels[R.Left, R.Top + 1] := clBtnFace;  //!!!
              Pixels[R.Left, R.Bottom - 2] := clBtnFace;  //!!!
            end;
          nRight:
            begin
              Pixels[R.Right - 1, R.Top] := clBtnHighlight;
              Pixels[R.Right - 1, R.Top + 1] := clBtnFace;  //!!!
              Pixels[R.Right - 1, R.Bottom - 2] := clBtnFace;  //!!!
            end;
          nTop:;
          nBottom:;
        end;
  end;
end;

procedure TcxFlatLookAndFeelPainter.DrawHeaderControlSectionBorder(
  ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AState: TcxButtonState);
begin
  if AState <> cxbsPressed then
    ACanvas.DrawComplexFrame(R, clBtnHighlight, clBtnShadow, ABorders)
  else
    ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnHighlight, ABorders);
end;

procedure TcxFlatLookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
  DrawSortingArrow(ACanvas, R, clBtnShadow, clBtnHighlight, AAscendingSorting);
end;

function TcxFlatLookAndFeelPainter.HeaderBorderSize: Integer;
begin
  Result := 1;
end;

function TcxFlatLookAndFeelPainter.SortingMarkSize: TPoint;
begin
  Result := Point(8, 7);
end;

function TcxFlatLookAndFeelPainter.FooterBorderSize: Integer;
begin
  Result := 1;
end;

function TcxFlatLookAndFeelPainter.FooterCellBorderSize: Integer;
begin
  Result := 1;
end;

function TcxFlatLookAndFeelPainter.FooterCellOffset: Integer;
begin
  Result := 1;
end;

procedure TcxFlatLookAndFeelPainter.DrawFooterBorder(ACanvas: TcxCanvas;
  const R: TRect);
begin
  ACanvas.DrawEdge(R, False, False);
end;

procedure TcxFlatLookAndFeelPainter.DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect);
begin
  ACanvas.DrawEdge(R, True, True);
end;

procedure TcxFlatLookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState; AIsFilterActive: Boolean);

  function GetArrowColor: TColor;
  begin
    if AIsFilterActive then
      Result := ActiveFilterButtonArrowColor
    else
      Result := clBtnText;
  end;

begin
  if AState <> cxbsPressed then
    ACanvas.DrawEdge(R, False, False)
  else
    ACanvas.DrawEdge(R, True, True);
  InflateRect(R, -1, -1);
  ACanvas.Brush.Color := clBtnFace;
  ACanvas.FillRect(R);
  DrawButtonArrow(ACanvas, R, GetArrowColor);
end;

procedure TcxFlatLookAndFeelPainter.DrawTabBorder(ACanvas: TcxCanvas; R: TRect;
  ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean);
const
  Colors: array[Boolean] of TColor = (clBtnShadow, clBtnHighlight);

  procedure ProcessVerticalTabBorder;
  begin
    case ABorder of
       bLeft:
         begin
           Inc(R.Top);
           if bTop in ABorders then Inc(R.Top);
           Dec(R.Bottom);
           if bBottom in ABorders then Dec(R.Bottom);
         end;
       bTop, bBottom:
         if bLeft in ABorders then Inc(R.Left);
    end;
    if ABorder = bLeft then
    begin
      ACanvas.Pixels[R.Left + 1, R.Top - 1] := Colors[True];
      ACanvas.Pixels[R.Left + 1, R.Bottom] := Colors[True];
    end;
    ACanvas.Brush.Color := Colors[ABorder <> bBottom];
  end;

  procedure ProcessHorizontalTabBorder;
  begin
    case ABorder of
       bTop:
         begin
           Inc(R.Left);
           Dec(R.Right);
         end;
       bLeft, bRight:
         begin
           if bTop in ABorders then Inc(R.Top, 2);
           if bBottom in ABorders then Dec(R.Bottom);
         end;
    end;
    if ABorder = bTop then
    begin
      ACanvas.Pixels[R.Left - 1, R.Top + 1] := Colors[True];
      ACanvas.Pixels[R.Right, R.Top + 1] := Colors[True];
    end;
    ACanvas.Brush.Color := Colors[ABorder <> bRight];
  end;

begin
  if AVertical then
    ProcessVerticalTabBorder
  else
    ProcessHorizontalTabBorder;
  ACanvas.FillRect(R);
end;

procedure TcxFlatLookAndFeelPainter.DrawTabsRoot(ACanvas: TcxCanvas; const R: TRect;
  ABorders: TcxBorders; AVertical: Boolean);
begin
  ACanvas.DrawEdge(R, False, False, ABorders);
end;

function TcxFlatLookAndFeelPainter.TabBorderSize(AVertical: Boolean): Integer;
begin
  Result := 1;
end;

procedure TcxFlatLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
  R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
begin
  if IsRectEmpty(R) or ((APart = sbpThumbnail) and (AState = cxbsDisabled)) then Exit;
  if AState = cxbsHot then AState := cxbsNormal;
  case APart of
    sbpThumbnail, sbpLineUp, sbpLineDown:
      begin
        DrawButton(ACanvas, R, '', AState);
        InflateRect(R, -ButtonBorderSize, -ButtonBorderSize);
        if APart <> sbpThumbnail then
          DrawScrollBarArrow(ACanvas, R, AState, GetArrowDirection(AHorizontal, APart));
      end;
    sbpPageUp, sbpPageDown:
      begin
        ACanvas.Brush.Bitmap := StdScrollBitmaps[AState = cxbsPressed];
        ACanvas.FillRect(R);
        ACanvas.Brush.Bitmap := nil;
        ACanvas.Brush.Style := bsSolid;
      end;
  end;
end;

procedure TcxFlatLookAndFeelPainter.DrawSchedulerSplitterBorder(
  ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams;
  AIsHorizontal: Boolean);
begin
  if AIsHorizontal then
  begin
    ACanvas.SetBrushColor(clBtnHighlight);
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
    ACanvas.SetBrushColor(clBtnShadow);
    ACanvas.FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
    InflateRect(R, 1, -1);
  end
  else
  begin
    ACanvas.SetBrushColor(clBtnHighlight);
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Left + 1, R.Bottom));
    ACanvas.SetBrushColor(clBtnShadow);
    ACanvas.FillRect(Rect(R.Right - 1, R.Top, R.Right, R.Bottom));
    InflateRect(R, -1, 1);
  end;
  ACanvas.FillRect(R, AViewParams);
end;

procedure TcxFlatLookAndFeelPainter.DrawGroupBoxFrame(ACanvas: TcxCanvas;
  R: TRect; AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition;
  ABorders: TcxBorders = cxBordersAll);
begin
  ACanvas.FrameRect(R, clBtnShadow, 1, ABorders, True);
  InflateRect(R, -1, -1);
  ACanvas.FrameRect(R, clBtnHighlight, 1, ABorders, True);
end;

procedure TcxFlatLookAndFeelPainter.DrawTrackBarTrackBounds(ACanvas: TcxCanvas; const ARect: TRect);
var
  R: TRect;
begin
  R := ARect;
  ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnHighlight);
  InflateRect(R, -1, -1);
  ACanvas.DrawComplexFrame(R, clBtnFace, clBtnFace);
end;

procedure TcxFlatLookAndFeelPainter.DrawTrackBarThumbBorderUpDown(ACanvas: TcxCanvas;
  const ALightPolyLine, AShadowPolyLine, ADarkPolyLine: TPointArray);
begin
  ACanvas.Pen.Color := clBtnHighlight;
  ACanvas.Polyline(ALightPolyLine);
  ACanvas.Pen.Color := clBtnShadow;
  ACanvas.Polyline(ADarkPolyLine);
end;

procedure TcxFlatLookAndFeelPainter.DrawTrackBarThumbBorderBoth(ACanvas: TcxCanvas; const ARect: TRect);
begin
  ACanvas.DrawComplexFrame(ARect, clBtnHighlight, clBtnShadow)
end;

procedure TcxFlatLookAndFeelPainter.DrawDateNavigatorDateHeader(
  ACanvas: TcxCanvas; var R: TRect);
begin
  ACanvas.FillRect(R, DefaultDateNavigatorHeaderColor);
  ACanvas.FrameRect(R, clBtnFace, 1, [bBottom]);
  Dec(R.Bottom);
end;

function TcxFlatLookAndFeelPainter.GetSplitterOuterColor(AHighlighted: Boolean): TColor;
begin
  Result := inherited GetSplitterOuterColor(AHighlighted);
  if AHighlighted then
    Result := cl3DDkShadow;
end;

{ TcxUltraFlatLookAndFeelPainter }

function TcxUltraFlatLookAndFeelPainter.LookAndFeelName: string;
begin
  Result := 'UltraFlat';
end;

function TcxUltraFlatLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsUltraFlat;
end;

function TcxUltraFlatLookAndFeelPainter.DefaultSchedulerBorderColor: TColor;
begin
  Result := clBtnShadow;
end;

function TcxUltraFlatLookAndFeelPainter.BorderHighlightColor: TColor;
begin
  Result := clHighlight;
end;

function TcxUltraFlatLookAndFeelPainter.BorderSize: Integer;
begin
  Result := 1;
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  ACanvas.FrameRect(R, clBtnShadow);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawSeparator(ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean);
var
  ABounds: TRect;
begin
  ABounds := GetSeparatorBounds(R, BorderSize, AIsVertical);
  ACanvas.FillRect(ABounds, clBtnShadow);
end;

function TcxUltraFlatLookAndFeelPainter.ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer;
begin
  if AState = cxbsDefault then Result := 2 else Result := 1;
end;

function TcxUltraFlatLookAndFeelPainter.ButtonColor(AState: TcxButtonState): TColor;
begin
  case AState of
    cxbsHot:
      Result := GetLightSelColor;
    cxbsPressed:
      Result := GetLightDownedSelColor;
  else
    Result := inherited ButtonColor(AState);
  end;
end;

function TcxUltraFlatLookAndFeelPainter.ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect;
begin
  Result := R;
  InflateRect(Result, -3, -3);
  if IsRectEmpty(Result) then
    Result := R;
end;

function TcxUltraFlatLookAndFeelPainter.ButtonGroupBorderSizes(AButtonCount,
  AButtonIndex: Integer): TRect;
begin
  Result := Rect(1, 2, 1, 2);
  if AButtonIndex = 0 then
    Inc(Result.Left)
  else
    if AButtonIndex = AButtonCount - 1 then
      Inc(Result.Right);
end;

function TcxUltraFlatLookAndFeelPainter.ButtonSymbolColor(
  AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
begin
  if AState = cxbsPressed then
    Result := clHighlightText
  else
    Result := inherited ButtonSymbolColor(AState, ADefaultColor);
end;

function TcxUltraFlatLookAndFeelPainter.ButtonSymbolState(AState: TcxButtonState): TcxButtonState;
begin
  Result := cxbsNormal;
end;

function TcxUltraFlatLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := 2;
end;

function TcxUltraFlatLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := 0;
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawButtonBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);

  function GetBorderColor: TColor;
  begin
    case AState of
//      cxbsDefault:
//        Result := clNavy;
      cxbsDisabled:
        Result := clBtnShadow;
      cxbsNormal:
        Result := clBtnText;
    else
      Result := clHighlight;
    end;    
  end;

begin
  if AState = cxbsDefault then
  begin
    ACanvas.FrameRect(R, clWindowFrame);
    InflateRect(R, -1, -1);
    ACanvas.FrameRect(R, clWindowFrame);
  end
  else
    ACanvas.FrameRect(R, GetBorderColor);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawButtonInGroup(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
  ABackgroundColor: TColor);
begin
  Inc(R.Top);
  Dec(R.Bottom);
  if AButtonIndex = 0 then
    Inc(R.Left);
  if AButtonIndex = AButtonCount - 1 then
    Dec(R.Right);
  with ACanvas do
  begin
    if AState in [cxbsDisabled, cxbsNormal] then
    begin
      FrameRect(R, ABackgroundColor);
      InflateRect(R, -1, -1);
    end else
    begin
      Brush.Color := BorderHighlightColor;
      if AButtonIndex > 0 then
      begin
        FillRect(Rect(R.Left, R.Top, R.Left + 1, R.Bottom));
        Inc(R.Left);
      end;
      if AButtonIndex < AButtonCount - 1 then
      begin
        FillRect(Rect(R.Right - 1, R.Top, R.Right, R.Bottom));
        Dec(R.Right);
      end;
    end;
    Brush.Color := ButtonColor(AState);
    FillRect(R);
  end;
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawButtonGroupBorder(ACanvas: TcxCanvas;
  R: TRect; AInplace, ASelected: Boolean);
var
  AColor: TColor;
begin
  if AInplace then
    AColor := clBtnText
  else
    if ASelected then
      AColor := BorderHighlightColor
    else
      AColor := clBtnShadow;
  ACanvas.FrameRect(R, AColor);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
var
  ARect: TRect;
begin
  ARect := R;
  ACanvas.FrameRect(ARect, clBtnShadow);
  InflateRect(ARect, -1, -1);
  if AColor = clDefault then
    ACanvas.Brush.Color := clBtnFace
  else
    ACanvas.Brush.Color := AColor;
  ACanvas.FillRect(ARect);
  DrawExpandButtonCross(ACanvas, ARect, AExpanded, clBtnText);
  ACanvas.ExcludeClipRect(R);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawHeaderControlSectionBorder(
  ACanvas: TcxCanvas; const R: TRect; ABorders: TcxBorders; AState: TcxButtonState);
begin
  if AState <> cxbsDisabled then
    ACanvas.DrawComplexFrame(R, clBlack, clBlack, ABorders)
  else
    ACanvas.DrawComplexFrame(R, clBtnShadow, clBtnShadow, ABorders);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawHeaderControlSectionContent(
  ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
  AState: TcxButtonState; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor);
begin
  if AState in [cxbsDefault, cxbsNormal] then
    ACanvas.SetBrushColor(ABkColor)
  else
    ACanvas.SetBrushColor(ButtonColor(AState));
  ACanvas.FillRect(ABounds);
  ACanvas.Font.Color := ATextColor;
  DrawHeaderControlSectionText(ACanvas, ATextAreaBounds, AState, AAlignmentHorz,
    AAlignmentVert, AMultiLine, AShowEndEllipsis, AText, AFont, ATextColor);
end;

function TcxUltraFlatLookAndFeelPainter.ExpandButtonSize: Integer;
begin
  Result := 11;
end;

function TcxUltraFlatLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := True;
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawCheckBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
begin
  ACanvas.FrameRect(R, clBtnText);
  InflateRect(R, -1, -1);
  ACanvas.FrameRect(R, CheckButtonColor(AState));
end;

function TcxUltraFlatLookAndFeelPainter.RadioButtonBodyColor(AState: TcxButtonState): TColor;
begin
  case AState of
    cxbsHot:
      Result := GetLightSelColor;
    cxbsNormal:
      Result := clWindow{clBtnFace};
    cxbsPressed:
      Result := GetLightDownedSelColor;
    else
      Result := clBtnFace;
  end;
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawHeaderBorder(ACanvas: TcxCanvas;
  const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders);
begin
  ACanvas.Brush.Color := clBtnText;
  with R do
  begin
    if bLeft in ABorders then
      ACanvas.FillRect(Rect(Left, Top, Left + 1, Bottom));
    if bTop in ABorders then
      ACanvas.FillRect(Rect(Left, Top, Right, Top + 1));
    ACanvas.FillRect(Rect(Right - 1, Top, Right, Bottom));
    ACanvas.FillRect(Rect(Left, Bottom - 1, Right, Bottom));
  end;
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawHeaderEx(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
var
  R: TRect;
begin
  R := ATextAreaBounds;
  InflateRect(R, -1, -1);
  DrawContent(ACanvas, ABounds, R, Integer(AState), 
    AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
      AFont, ATextColor, ABkColor, AOnDrawBackground);
  R := ABounds;
  InflateRect(R, -1, -1);
  DrawHeaderBorder(ACanvas, R, ANeighbors, ABorders);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
  DrawSortingArrow(ACanvas, R, clBtnShadow, clBtnShadow, AAscendingSorting);
end;

function TcxUltraFlatLookAndFeelPainter.HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders;
begin
  Result := inherited HeaderBorders(ANeighbors);
  if nLeft in ANeighbors then Exclude(Result, bLeft);
  if nTop in ANeighbors then Exclude(Result, bTop);
end;

function TcxUltraFlatLookAndFeelPainter.HeaderBorderSize: Integer;
begin
  Result := 1;
end;

function TcxUltraFlatLookAndFeelPainter.SortingMarkSize: TPoint;
begin
  Result := Point(7, 8);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawFooterBorder(ACanvas: TcxCanvas;
  const R: TRect);
begin
  DrawFooterBorderEx(ACanvas, R, [bRight, bBottom]);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawFooterCellBorder(ACanvas: TcxCanvas;
  const R: TRect);
begin
  ACanvas.FrameRect(R, FooterSeparatorColor);
end;

function TcxUltraFlatLookAndFeelPainter.FooterBorders: TcxBorders;
begin
  Result := [bRight, bBottom];
end;

function TcxUltraFlatLookAndFeelPainter.FooterBorderSize: Integer;
begin
  Result := 1;
end;

function TcxUltraFlatLookAndFeelPainter.FooterCellBorderSize: Integer;
begin
  Result := 1;
end;

function TcxUltraFlatLookAndFeelPainter.FooterCellOffset: Integer;
begin
  Result := 2;
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean);

  function GetArrowColor: TColor;
  begin
    if AIsFilterActive then
      Result := ActiveFilterButtonArrowColor
    else
      Result := ButtonSymbolColor(AState);
  end;

begin
  ACanvas.FrameRect(R, FilterDropDownButtonBorderColor(AState));
  InflateRect(R, -1, -1);
  ACanvas.Brush.Color := ButtonColor(AState);
  ACanvas.FillRect(R);
  DrawButtonArrow(ACanvas, R, GetArrowColor);
end;

function TcxUltraFlatLookAndFeelPainter.FilterCloseButtonSize: TPoint;
begin
  Result := inherited FilterCloseButtonSize;
  Inc(Result.Y);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawTabBorder(ACanvas: TcxCanvas; R: TRect;
  ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean);
begin
  if AVertical and (ABorder = bBottom) or not AVertical and (ABorder = bRight) then
  begin
    if not AVertical then
      Dec(R.Bottom, TabBorderSize(AVertical));
    ACanvas.Brush.Color := TabBorderDarkColor;
  end
  else
    ACanvas.Brush.Color := TabBorderHighlightColor;
  ACanvas.FillRect(R);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawTabsRoot(ACanvas: TcxCanvas;
  const R: TRect; ABorders: TcxBorders; AVertical: Boolean);
begin
  ACanvas.DrawComplexFrame(R, TabBorderHighlightColor, TabBorderHighlightColor, ABorders, TabBorderSize(AVertical));
end;

function TcxUltraFlatLookAndFeelPainter.TabBorderSize(AVertical: Boolean): Integer;
begin
  Result := 1;
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
begin
  if IsRectEmpty(R) or ((APart = sbpThumbnail) and (AState = cxbsDisabled)) then Exit;
  case APart of
    sbpThumbnail, sbpLineUp, sbpLineDown:
      begin
        DrawButton(ACanvas, R, '', AState);
        if APart <> sbpThumbnail then
          DrawScrollBarArrow(ACanvas, R, AState, GetArrowDirection(AHorizontal, APart));
      end;
    sbpPageUp, sbpPageDown:
      begin
        ACanvas.Brush.Bitmap := StdScrollBitmaps[AState = cxbsPressed];
        ACanvas.FillRect(R);
        ACanvas.Brush.Bitmap := nil;
        ACanvas.Brush.Style := bsSolid;
      end;
  end;
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawSchedulerNavigationButtonContent(
  ACanvas: TcxCanvas; const ARect: TRect; const AArrowRect: TRect; AIsNextButton: Boolean;
  AState: TcxButtonState);
const
  Borders: array[Boolean] of TcxBorders =
    ([bRight, bTop, bBottom], [bLeft, bTop, bBottom]);
var
  AColor: TColor;
  R: TRect;
begin
  R := ARect;
  ACanvas.FillRect(R, clBtnFace);
  if AState = cxbsHot then
    AColor := TabBorderHighlightColor
  else
    AColor := TabBorderDarkColor;
  ACanvas.DrawComplexFrame(R, AColor, AColor, Borders[AIsNextButton]);
  DrawSchedulerNavigationButtonArrow(ACanvas, AArrowRect, AIsNextButton,
    ButtonSymbolColor(AState));
end;

function TcxUltraFlatLookAndFeelPainter.FilterDropDownButtonBorderColor(AState: TcxButtonState): TColor;
begin
  if AState = cxbsNormal then
    Result := clBtnShadow
  else
    Result := clHighlight;
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawFooterBorderEx(ACanvas: TcxCanvas;
  const R: TRect; ABorders: TcxBorders);
begin
  ACanvas.FrameRect(R, FooterSeparatorColor, FooterSeparatorSize, ABorders);
end;

function TcxUltraFlatLookAndFeelPainter.TabBorderHighlightColor: TColor;
begin
  Result := clBtnShadow;
end;

function TcxUltraFlatLookAndFeelPainter.TabBorderDarkColor: TColor;
begin
  Result := clBtnText;
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawSchedulerNavigatorButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  DrawButton(ACanvas, R, '', AState, AState in [cxbsHot, cxbsPressed]);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawSchedulerSplitterBorder(
  ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams;
  AIsHorizontal: Boolean);
begin
  ACanvas.SetBrushColor(DefaultSchedulerBorderColor);
  if AIsHorizontal then
  begin
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
    ACanvas.FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
    InflateRect(R, 1, -1);
  end
  else
  begin
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Left + 1, R.Bottom));
    ACanvas.FillRect(Rect(R.Right - 1, R.Top, R.Right, R.Bottom));
    InflateRect(R, -1, 1);
  end;
  ACanvas.FillRect(R, AViewParams);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawGroupBoxFrame(ACanvas: TcxCanvas;
  R: TRect; AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition;
  ABorders: TcxBorders = cxBordersAll);
const
  FrameColorMap: array[Boolean] of TColor = (clBtnShadow, clHighlight);
begin
  ACanvas.FrameRect(R, FrameColorMap[AEnabled], 1, ABorders, True);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawTrackBarTrackBounds(ACanvas: TcxCanvas; const ARect: TRect);
begin
  ACanvas.FrameRect(ARect, clWindowText);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawTrackBarThumbBorderUpDown(ACanvas: TcxCanvas;
  const ALightPolyLine, AShadowPolyLine, ADarkPolyLine: TPointArray);
begin
  ACanvas.Pen.Color := clWindowText;
  ACanvas.Polyline(ALightPolyLine);
  ACanvas.Polyline(ADarkPolyLine);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawTrackBarThumbBorderBoth(ACanvas: TcxCanvas; const ARect: TRect);
begin
  ACanvas.FrameRect(ARect, clWindowText);
end;

procedure TcxUltraFlatLookAndFeelPainter.DrawPrintPreviewBackground(
  ACanvas: TcxCanvas; const R: TRect); 

  function GetUltraFlatValue(Value: Byte): Byte;
  begin
    Result := Value + (255 - Value) div 3;
  end;

var
  AColor: TColor;
begin
  AColor := ColorToRGB(clBtnShadow);
  AColor := RGB(
    GetUltraFlatValue(GetRValue(AColor)),
    GetUltraFlatValue(GetGValue(AColor)),
    GetUltraFlatValue(GetBValue(AColor)));
  ACanvas.FillRect(R, AColor);
end;

function TcxUltraFlatLookAndFeelPainter.GetSplitterOuterColor(AHighlighted: Boolean): TColor;
begin
  if AHighlighted then
    Result := clHighlight
  else
    Result := inherited GetSplitterOuterColor(AHighlighted);
end;

function TcxUltraFlatLookAndFeelPainter.GetSplitterSize(AHorizontal: Boolean): TSize;
begin
  Result := inherited GetSplitterSize(AHorizontal);
  if AHorizontal then
    Result.cy := 1
  else
    Result.cx := 1;
end;

{ TcxOffice11LookAndFeelPainter }

function TcxOffice11LookAndFeelPainter.LookAndFeelName: string;
begin
  Result := 'Office11';
end;

function TcxOffice11LookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsOffice11;
end;

function TcxOffice11LookAndFeelPainter.NeedRedrawOnResize: Boolean;
begin
  Result := True;
end;

function TcxOffice11LookAndFeelPainter.DefaultDateNavigatorHeaderColor: TColor;
begin
  Result := dxOffice11DockColor1;
end;

function TcxOffice11LookAndFeelPainter.DefaultDateNavigatorSelectionColor: TColor;
begin
  Result := dxOffice11DayNavigatorSelectedColor;
end;

function TcxOffice11LookAndFeelPainter.DefaultDateNavigatorSelectionTextColor: TColor;
begin
  Result := clWindowText;
end;

function TcxOffice11LookAndFeelPainter.DefaultFilterBoxColor: TColor;
begin
  Result := dxOffice11BarFloatingBorderColor1;
end;

function TcxOffice11LookAndFeelPainter.DefaultFilterBoxTextColor: TColor;
begin
  Result := dxOffice11BarFloatingCaptionTextColor1;
end;

function TcxOffice11LookAndFeelPainter.DefaultFooterColor: TColor;
begin
  Result := dxOffice11DockColor1;  //DefaultHeaderColor;
end;

function TcxOffice11LookAndFeelPainter.DefaultFooterTextColor: TColor;
begin
  Result := DefaultHeaderTextColor;
end;

function TcxOffice11LookAndFeelPainter.DefaultGroupColor: TColor;
begin
  Result := dxOffice11GroupColor;
end;

function TcxOffice11LookAndFeelPainter.DefaultGroupByBoxColor: TColor;
begin
  Result := dxOffice11InPlaceSubItemColor{dxOffice11DockColor2};
end;

function TcxOffice11LookAndFeelPainter.DefaultGroupByBoxTextColor: TColor;
begin
  Result := dxOffice11ToolbarsColor1{dxOffice11TextEnabledColor};
end;

function TcxOffice11LookAndFeelPainter.DefaultHeaderColor: TColor;
begin
  Result := HeaderTopColor;  //dxOffice11DockColor1;
end;

function TcxOffice11LookAndFeelPainter.DefaultHeaderBackgroundColor: TColor;
begin
  Result := DefaultGroupByBoxColor;
end;

function TcxOffice11LookAndFeelPainter.DefaultSchedulerBorderColor: TColor;
begin
  Result := dxOffice11OutlookBorderColor;
end;

function TcxOffice11LookAndFeelPainter.DefaultSchedulerControlColor: TColor;
begin
  Result := dxOffice11OutlookControlColor;
end;

function TcxOffice11LookAndFeelPainter.DefaultTabColor: TColor;
begin
  Result := dxOffice11DockColor2;
end;

function TcxOffice11LookAndFeelPainter.DefaultTabsBackgroundColor: TColor;
begin
  Result := DefaultTabColor;
end;

function TcxOffice11LookAndFeelPainter.DefaultTimeGridMinorScaleColor: TColor;
begin
  Result := dxOffice11DockColor1;
end;

function TcxOffice11LookAndFeelPainter.DefaultTimeGridSelectionBarColor: TColor;
begin
  Result := DefaultSchedulerControlColor;
end;

function TcxOffice11LookAndFeelPainter.BorderHighlightColor: TColor;
begin
  Result := dxOffice11SelectedBorderColor;
end;

procedure TcxOffice11LookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  ACanvas.FrameRect(R, dxOffice11ControlBorderColor);
end;

procedure TcxOffice11LookAndFeelPainter.DrawSeparator(ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean);
var
  ABounds: TRect;
begin
  ABounds := GetSeparatorBounds(R, 2, AIsVertical);
  Dec(ABounds.Right);
  Dec(ABounds.Bottom);
  ACanvas.FillRect(ABounds, dxOffice11BarSeparatorColor1);
  OffsetRect(ABounds, 1, 1);
  ACanvas.FillRect(ABounds, dxOffice11BarSeparatorColor2);
end;

function TcxOffice11LookAndFeelPainter.ButtonColor(AState: TcxButtonState): TColor;
begin
  case AState of
    cxbsHot:
      Result := dxOffice11SelectedColor1;
    cxbsPressed:
      Result := dxOffice11SelectedDownColor1;
    cxbsDisabled:
      Result := {dxOffice11ToolbarsColor2}clBtnFace;
  else
    Result := dxOffice11DockColor1{inherited ButtonColor(AState)};
  end;
end;

function TcxOffice11LookAndFeelPainter.ButtonSymbolColor(
  AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
begin
  if (AState = cxbsPressed) and not IsXPStandardScheme then
    Result := clHighlightText
  else
    if AState = cxbsDisabled then
      Result := dxOffice11TextDisabledColor
    else
      Result := dxOffice11TextEnabledColor;
end;

procedure TcxOffice11LookAndFeelPainter.DrawButtonBorder(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState);

  function GetBorderColor: TColor;
  begin
    case AState of
      cxbsNormal:
        Result := clBtnText;
      cxbsDisabled:
        Result := dxOffice11TextDisabledColor;   
    else
      Result := dxOffice11SelectedBorderColor;
    end;
  end;

begin
  if AState = cxbsDefault then
    inherited
  else
    ACanvas.FrameRect(R, GetBorderColor);
end;

procedure TcxOffice11LookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
var
  AColor2: TColor;
  ABitmap: TBitmap;
begin
  if AExpanded then
    ABitmap := dxOffice11ExpandButtonBitmap1
  else
    ABitmap := dxOffice11ExpandButtonBitmap2;
  AColor2 := GetMiddleRGB(dxOffice11ExpandButtonColor1, ACanvas.Canvas.Pixels[R.Left, R.Top], 25);
  ABitmap.Canvas.Pixels[0, 0] := AColor2;
  AColor2 := GetMiddleRGB(dxOffice11ExpandButtonColor2, ACanvas.Canvas.Pixels[R.Right - 1, R.Bottom - 1], 25);
  ABitmap.Canvas.Pixels[10, 10] := AColor2;
  ABitmap.Canvas.Pixels[0, 10] := AColor2;
  ABitmap.Canvas.Pixels[10, 0] := AColor2;
  ACanvas.Draw(R.Left, R.Top, ABitmap);
//  ACanvas.ExcludeClipRect(R);
end;

function TcxOffice11LookAndFeelPainter.DrawExpandButtonFirst: Boolean;
begin
  Result := False;
end;

procedure TcxOffice11LookAndFeelPainter.DrawSmallExpandButton(ACanvas: TcxCanvas;
  R: TRect; AExpanded: Boolean; ABorderColor: TColor; AColor: TColor = clDefault);
begin
  DrawExpandButton(ACanvas, R, AExpanded, AColor);
end;

function TcxOffice11LookAndFeelPainter.ExpandButtonSize: Integer;
begin
  Result := 11;
end;

function TcxOffice11LookAndFeelPainter.SmallExpandButtonSize: Integer;
begin
  Result := ExpandButtonSize;
end;

function TcxOffice11LookAndFeelPainter.CheckButtonColor(AState: TcxButtonState): TColor;
begin
  case AState of
    cxbsHot, cxbsPressed, cxbsDisabled:
      Result := ButtonColor(AState);
  else
    Result := inherited CheckButtonColor(AState);
  end;
end;

function TcxOffice11LookAndFeelPainter.RadioButtonBodyColor(AState: TcxButtonState): TColor;
begin
  if AState = cxbsNormal then
    Result := clWindow
  else
    Result := ButtonColor(AState)
end;

procedure TcxOffice11LookAndFeelPainter.DrawFilterDropDownButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean);

  function GetArrowColor: TColor;
  begin
    if AIsFilterActive then
      Result := ActiveFilterButtonArrowColor
    else
      Result := ButtonSymbolColor(AState);
  end;

begin
//  inherited;
  ACanvas.FrameRect(R, FilterDropDownButtonBorderColor(AState));
  InflateRect(R, -1, -1);
  ACanvas.Brush.Color := ButtonColor(AState);
  ACanvas.FillRect(R);
  DrawButtonArrow(ACanvas, R, GetArrowColor);
end;

procedure TcxOffice11LookAndFeelPainter.DrawHeader(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
  ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False;
  AInGroupByBox: Boolean = False);
begin
  inherited DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders,
    AState, AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
    AFont, ATextColor, ABkColor, nil, AIsLast);
end;

procedure TcxOffice11LookAndFeelPainter.DrawHeaderBorder(ACanvas: TcxCanvas;
  const R: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders);
var
  AColor1, AColor2: TColor;
  Y1, Y2: Integer;
begin
  AColor1 := HeaderTopColor;
  AColor2 := HeaderBottomColor;
  if bTop in ABorders then
  begin
    ACanvas.Brush.Color := AColor1;
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
  end;
  if bBottom in ABorders then
  begin
    ACanvas.Brush.Color := HeaderDarkEdgeColor;
    ACanvas.FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
  end;
  if bLeft in ABorders then
  begin
    ACanvas.Pixels[R.Left, R.Top + 1] := AColor1;
    if nLeft in ANeighbors then
    begin
      Y1 := R.Top + 2;
      Y2 := R.Bottom - 3;
      ACanvas.Pixels[R.Left, Y1] := AColor1;
      ACanvas.Pixels[R.Left, Y2] := GetMiddleRGB(AColor1, AColor2, 25);
      ACanvas.Pixels[R.Left, R.Bottom - 2] := AColor2;
    end
    else
    begin
      Y1 := R.Top + 1;
      Y2 := R.Bottom - 2;
      ACanvas.Pixels[R.Left, R.Bottom - 2] := AColor2;
    end;
    ACanvas.Brush.Color := HeaderHighlightEdgeColor;
    ACanvas.FillRect(Rect(R.Left, Y1, R.Left + 1, Y2));
  end;
  if bRight in ABorders then
  begin
    if nRight in ANeighbors then
    begin
      Y1 := R.Top + 2;
      Y2 := R.Bottom - 3;
      ACanvas.Pixels[R.Right - 1, R.Top + 1] := AColor1;
      ACanvas.Pixels[R.Right - 1, Y1] := AColor1;
      ACanvas.Pixels[R.Right - 1, Y2] := GetMiddleRGB(AColor1, AColor2, 25);
      ACanvas.Pixels[R.Right - 1, R.Bottom - 2] := AColor2;
    end
    else
    begin
      Y1 := R.Top + 1;
      ACanvas.Pixels[R.Right - 1, R.Top] := GetMiddleRGB(AColor1, HeaderDarkEdgeColor, 50);
      Y2 := R.Bottom - 2;
      ACanvas.Pixels[R.Right - 1, R.Bottom - 2] := GetMiddleRGB(AColor2, HeaderDarkEdgeColor, 50);
    end;
    ACanvas.Brush.Color := HeaderDarkEdgeColor;
    ACanvas.FillRect(Rect(R.Right - 1, Y1, R.Right, Y2));
  end;
end;

procedure TcxOffice11LookAndFeelPainter.DrawHeaderControlSection(
  ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
  ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
  AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
  AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
  ABkColor: TColor);
begin
  DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders,
    AState, AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
    AFont, ATextColor, ABkColor);
  if AState = cxbsPressed then
    DrawHeaderPressed(ACanvas, ABounds);
end;

procedure TcxOffice11LookAndFeelPainter.DrawSortingMark(ACanvas: TcxCanvas;
  const R: TRect; AAscendingSorting: Boolean);
begin
  DrawSortingArrow(ACanvas, R, HeaderDarkEdgeColor, HeaderHighlightEdgeColor, AAscendingSorting);
end;

function TcxOffice11LookAndFeelPainter.HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders;
begin
  Result := cxBordersAll;
end;

function TcxOffice11LookAndFeelPainter.HeaderBorderSize: Integer;
begin
  Result := 1;
end;

function TcxOffice11LookAndFeelPainter.IsHeaderHotTrack: Boolean;
begin
  Result := True;
end;

function TcxOffice11LookAndFeelPainter.FooterSeparatorColor: TColor;
begin
  Result := HeaderDarkEdgeColor;
end;

procedure TcxOffice11LookAndFeelPainter.LayoutViewDrawRecordCaption(
  ACanvas: TcxCanvas; const ABounds: TRect;
  APosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState);
begin
  LayoutViewDrawRecordBorder(ACanvas, ABounds, AState, cxBordersAll);
  DrawContent(ACanvas, ABounds, cxEmptyRect, Integer(AState), taLeftJustify,
    vaTop, False, False, '', nil, clDefault, clDefault, nil, APosition = cxgpTop);
end;

procedure TcxOffice11LookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
var
  APainter: TcxCustomLookAndFeelPainter;
begin
  if cxLookAndFeelPaintersManager.GetPainter(lfsNative, APainter) then
    APainter.DrawScrollBarPart(ACanvas, AHorizontal, R, APart, AState)
  else
    inherited DrawScrollBarPart(ACanvas, AHorizontal, R, APart, AState);
end;

procedure TcxOffice11LookAndFeelPainter.DoDrawSizeGrip(ACanvas: TcxCanvas;
  const ARect: TRect);
begin
  Office11DrawSizeGrip(ACanvas.Handle, ARect);
end;

procedure TcxOffice11LookAndFeelPainter.DrawMonthHeader(
  ACanvas: TcxCanvas; const ABounds: TRect; const AText: string;
  ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
  AArrows: TcxHeaderArrows; ASideWidth: Integer;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
var
  R: TRect;
begin
  R := ABounds;
  InflateRect(R, -1, -1);
  with ACanvas do
  begin
    if not Assigned(AOnDrawBackground) or not AOnDrawBackground(ACanvas, R) then
      FillRect(R, AViewParams);
    if AText <> '' then
    begin
      Brush.Style := bsClear;
      Font := AViewParams.Font;
      Font.Color := AViewParams.TextColor;
      DrawText(AText, R, cxAlignCenter or cxSingleLine);
      Brush.Style := bsSolid;
    end;
  end;
  DrawMonthHeaderArrows(ACanvas, ABounds, AArrows, ASideWidth, clWindowText);
end;

procedure TcxOffice11LookAndFeelPainter.DrawSchedulerNavigationButtonContent(
  ACanvas: TcxCanvas; const ARect: TRect; const AArrowRect: TRect;
  AIsNextButton: Boolean; AState: TcxButtonState);
const
  Borders: array[Boolean] of TcxBorders =
    ([bRight, bTop, bBottom], [bLeft, bTop, bBottom]);
var
  ABackgroundColor: TColor;
begin
  case AState of
    cxbsPressed:
      ABackgroundColor := dxOffice11SelectedDownColor1;
    cxbsHot:
      ABackgroundColor := dxOffice11SelectedColor1;
    else
      ABackgroundColor := dxOffice11DockColor1;
  end;                                    
  ACanvas.FillRect(ARect, ABackgroundColor);
  ACanvas.DrawComplexFrame(ARect, dxOffice11OutlookBorderColor,
    dxOffice11OutlookBorderColor, Borders[AIsNextButton]);
  DrawSchedulerNavigationButtonArrow(ACanvas, AArrowRect, AIsNextButton,
    ButtonSymbolColor(AState));
end;

procedure TcxOffice11LookAndFeelPainter.DrawSchedulerNavigatorButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
var
  APainter: TcxCustomLookAndFeelPainter;
begin
  if cxLookAndFeelPaintersManager.GetPainter(lfsNative, APainter) then
    APainter.DrawSchedulerNavigatorButton(ACanvas, R, AState)
  else
    inherited DrawSchedulerNavigatorButton(ACanvas, R, AState);
end;

procedure TcxOffice11LookAndFeelPainter.DrawSchedulerBorder(
  ACanvas: TcxCanvas; R: TRect);
begin
  ACanvas.FrameRect(R, DefaultSchedulerBorderColor);
end;

function TcxOffice11LookAndFeelPainter.DefaultDateNavigatorHeaderHighlightTextColor: TColor;
begin
  Result := clHighlightText;
end;

procedure TcxOffice11LookAndFeelPainter.DrawContent(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; AState: Integer; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False);
const
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
var
  R: TRect;
  AColor1, AColor2: TColor;
begin
  with ACanvas do
  begin
    R := ABounds;
    if not Assigned(AOnDrawBackground) or not AOnDrawBackground(ACanvas, ABounds) then
    begin
      if AState = Integer(cxbsHot) then
      begin
        AColor1 := dxOffice11ToolbarsColor1;
        AColor2 := dxOffice11ToolbarsColor1;
      end
      else
      begin
        AColor1 := HeaderTopColor;
        AColor2 := HeaderBottomColor;
      end;
      with ABounds do
      begin
        if AIsFooter then
          FillRectByColor(ACanvas.Handle, Rect(Left, Top, Right, Bottom), AColor1)
        else
        begin
          FillRectByColor(ACanvas.Handle, Rect(Left, Top, Right, Bottom - 3), AColor1);
          FillGradientRect(ACanvas.Handle, Rect(Left, Bottom - 4, Right, Bottom), AColor1, AColor2, False);
        end;
      end;
    end;
    if AText <> '' then
    begin
      Brush.Style := bsClear;
      Font := AFont;
      Font.Color := ATextColor;
      DrawText(AText, ATextAreaBounds, cxAlignmentsHorz[AAlignmentHorz] or
        cxAlignmentsVert[AAlignmentVert] or MultiLines[AMultiLine] or
        ShowEndEllipsises[AShowEndEllipsis]);
      Brush.Style := bsSolid;
    end;
    if AState = Integer(cxbsHot) then
      with ABounds do
        FillGradientRect(ACanvas.Handle, Rect(Left - 1, Bottom - 2, Right, Bottom + 1),
          dxOffice11SelectedColor1, dxOffice11SelectedColor2, False);
  end;
end;

function TcxOffice11LookAndFeelPainter.HeaderBottomColor: TColor;
begin
  Result := dxOffice11ToolbarsColor2;
end;

function TcxOffice11LookAndFeelPainter.HeaderDarkEdgeColor: TColor;
begin
  Result := dxOffice11BarSeparatorColor1;
end;

function TcxOffice11LookAndFeelPainter.HeaderHighlightEdgeColor: TColor;
begin
  Result := dxOffice11BarSeparatorColor2;
end;

function TcxOffice11LookAndFeelPainter.HeaderTopColor: TColor;
begin
  Result := GetMiddleRGB(dxOffice11ToolbarsColor1, dxOffice11ToolbarsColor2, 50);
end;

function TcxOffice11LookAndFeelPainter.FilterDropDownButtonBorderColor(AState: TcxButtonState): TColor;
begin
  if AState = cxbsNormal then
    Result := HeaderDarkEdgeColor
  else
    Result := dxOffice11SelectedBorderColor;
end;

function TcxOffice11LookAndFeelPainter.TabBorderHighlightColor: TColor;
begin
  Result := HeaderDarkEdgeColor;
end;

function TcxOffice11LookAndFeelPainter.TabBorderDarkColor: TColor;
begin
  Result := inherited TabBorderDarkColor;
end;

function BtnStateToXPBtnState(AState: TcxButtonState): Integer;
const
  ButtonStates: array[TcxButtonState] of Integer =(PBS_DEFAULTED, PBS_NORMAL,
    PBS_HOT, PBS_PRESSED, PBS_DISABLED);
begin
  Result := ButtonStates[AState];
end;

procedure TcxOffice11LookAndFeelPainter.DrawGroupBoxFrame(ACanvas: TcxCanvas;
  R: TRect; AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition;
  ABorders: TcxBorders = cxBordersAll);
var
  APainter: TcxCustomLookAndFeelPainter;
begin
  if AreVisualStylesAvailable([totButton]) and
    cxLookAndFeelPaintersManager.GetPainter(lfsNative, APainter)
  then
    APainter.DrawGroupBoxFrame(ACanvas, R, AEnabled, ACaptionPosition, ABorders)
  else
    inherited DrawGroupBoxFrame(ACanvas, R, AEnabled, ACaptionPosition, ABorders);
end;

function TcxOffice11LookAndFeelPainter.GroupBoxTextColor(
  AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TColor;
var
  APainter: TcxCustomLookAndFeelPainter;
begin
  if AreVisualStylesAvailable([totButton]) and
    cxLookAndFeelPaintersManager.GetPainter(lfsNative, APainter)
  then
    Result := APainter.GroupBoxTextColor(AEnabled, ACaptionPosition)
  else
    Result := inherited GroupBoxTextColor(AEnabled, ACaptionPosition);
end;

procedure TcxOffice11LookAndFeelPainter.DrawTrackBarTrackBounds(ACanvas: TcxCanvas; const ARect: TRect);
begin
  ACanvas.FrameRect(ARect, clBtnText);
end;

procedure TcxOffice11LookAndFeelPainter.DrawTrackBarThumbBorderUpDown(ACanvas: TcxCanvas;
  const ALightPolyLine, AShadowPolyLine, ADarkPolyLine: TPointArray);
begin
  ACanvas.Pen.Color := clBtnText;
  ACanvas.Polyline(ALightPolyLine);
  ACanvas.Polyline(ADarkPolyLine);
end;

procedure TcxOffice11LookAndFeelPainter.DrawTrackBarThumbBorderBoth(ACanvas: TcxCanvas; const ARect: TRect);
begin
  ACanvas.FrameRect(ARect, clBtnText);
end;

procedure TcxOffice11LookAndFeelPainter.DrawPanelBackground(
  ACanvas: TcxCanvas; AControl: TWinControl; ABounds: TRect; AColorFrom,
  AColorTo: TColor);
begin
  if AColorFrom = clDefault then
    cxDrawTransparentControlBackground(AControl, ACanvas, ABounds)
  else
    if AColorTo = clDefault then
      ACanvas.FillRect(ABounds, AColorFrom)
    else
      with ABounds do
        FillGradientRect(ACanvas.Handle, ABounds, AColorFrom, AColorTo, False);
end;

procedure TcxOffice11LookAndFeelPainter.DrawLayoutControlBackground(
  ACanvas: TcxCanvas; const R: TRect);
begin
  FillGradientRect(ACanvas.Handle, R,
    dxOffice11ToolbarsColor1, dxOffice11ToolbarsColor2, False);
end;

procedure TcxOffice11LookAndFeelPainter.DrawDateNavigatorDateHeader(
  ACanvas: TcxCanvas; var R: TRect);
begin
  ACanvas.FillRect(R, DefaultDateNavigatorHeaderColor);
end;

function TcxOffice11LookAndFeelPainter.GetSplitterInnerColor(AHighlighted: Boolean): TColor;
begin
  Result := dxOffice11BarSeparatorColor2;
end;

function TcxOffice11LookAndFeelPainter.GetSplitterOuterColor(AHighlighted: Boolean): TColor;
begin
  if AHighlighted then
    Result := dxOffice11SelectedBorderColor
  else
    Result := dxOffice11BarSeparatorColor1;
end;

{ TcxWinXPLookAndFeelPainter }

procedure TcxWinXPLookAndFeelPainter.DrawContent(ACanvas: TcxCanvas;
  ATheme: TdxTheme; APartId, AStateId: Integer; const ABounds, ATextAreaBounds: TRect;
  AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis, AShowPrefix: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor);
const
  MultiLines: array[Boolean] of Integer = (DT_SINGLELINE, DT_WORDBREAK);
  ShowEndEllipsises: array[Boolean] of Integer = (0, DT_END_ELLIPSIS);
  ShowPrefixes: array[Boolean] of Integer = (DT_NOPREFIX, 0);
var
  R: TRect;
begin
  if AText = '' then Exit;
  R := ATextAreaBounds;
  ACanvas.Font := AFont;
  ACanvas.Font.Color := ATextColor;
  if AMultiLine then
    ACanvas.AlignMultiLineTextRectVertically(R, AText, AAlignmentVert, True,
      AShowPrefix, True, False, AShowEndEllipsis);
  DrawThemeText(ATheme, ACanvas.Handle, APartId, AStateId, AText,
    -1, DT_EDITCONTROL or SystemAlignmentsHorz[AAlignmentHorz] or SystemAlignmentsVert[AAlignmentVert] or
    ShowEndEllipsises[AShowEndEllipsis] or ShowPrefixes[AShowPrefix] or
    MultiLines[AMultiLine], 0, R);
end;

procedure TcxWinXPLookAndFeelPainter.DrawSchedulerNavigationButtonContent(
  ACanvas: TcxCanvas; const ARect: TRect; const AArrowRect: TRect;
  AIsNextButton: Boolean; AState: TcxButtonState);
const
  ARotationAngle: array[Boolean] of TcxRotationAngle = (raMinus90, raPlus90);
  AStates: array[TcxButtonState] of Integer =
    (TIS_NORMAL, TIS_NORMAL, TIS_HOT, TIS_SELECTED, TIS_DISABLED);
var
  ABitmap: TcxBitmap;
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totTab);
  if ATheme = 0 then
    inherited DrawSchedulerNavigationButtonContent(ACanvas, ARect, AArrowRect,
      AIsNextButton, AState)
  else
  begin
    ABitmap := TcxBitmap.CreateSize(ARect, pf32bit);
    try
      cxBitBlt(ABitmap.Canvas.Handle, ACanvas.Handle, ABitmap.ClientRect, ARect.TopLeft, SRCCOPY);
      ABitmap.Rotate(ARotationAngle[not AIsNextButton]);
      DrawThemeBackground(ATheme, ABitmap.Canvas.Handle, TABP_TABITEM, AStates[AState],
        Rect(0, 0, ABitmap.Width, ABitmap.Height));
      ABitmap.Rotate(ARotationAngle[AIsNextButton]);
      cxBitBlt(ACanvas.Handle, ABitmap.Canvas.Handle, ARect, cxNullPoint, SRCCOPY);
      DrawSchedulerNavigationButtonArrow(ACanvas, AArrowRect, AIsNextButton,
        ButtonSymbolColor(AState));
    finally
      ABitmap.Free;
    end;
  end;
end;

function TcxWinXPLookAndFeelPainter.LookAndFeelName: string;
begin
  Result := 'Native';
end;

function TcxWinXPLookAndFeelPainter.LookAndFeelStyle: TcxLookAndFeelStyle;
begin
  Result := lfsNative;
end;

function TcxWinXPLookAndFeelPainter.NeedRedrawOnResize: Boolean;
begin
  Result := AreVisualStylesAvailable;
end;

function cxGetThemeColor(AObjectType: TdxThemedObjectType; APartId, AStateId, APropId: Integer;
  out AColor: TColor): Boolean;
var
  ATheme: TdxTheme;
  AColorRef: TColorRef;
begin
  ATheme := OpenTheme(AObjectType);
  if ATheme <> 0 then
  begin
    AColorRef := clRed;
    Result := GetThemeColor(ATheme, APartId, AStateId, APropId, AColorRef) = S_OK;
    AColor := AColorRef;
  end
  else
    Result := False;
end;

function TcxWinXPLookAndFeelPainter.DefaultSchedulerBorderColor: TColor;
begin
  if not cxGetThemeColor(totComboBox, CP_DROPDOWNBUTTON, CBXS_NORMAL, TMT_BORDERCOLOR, Result) then
    Result := inherited DefaultSchedulerBorderColor;
end;

procedure TcxWinXPLookAndFeelPainter.DrawArrow(ACanvas: TcxCanvas;
  const R: TRect; AArrowDirection: TcxArrowDirection; AColor: TColor);
begin
  inherited; // for BCB6 conversion
end;

procedure TcxWinXPLookAndFeelPainter.DrawArrow(ACanvas: TcxCanvas;
  const R: TRect; AState: TcxButtonState; AArrowDirection: TcxArrowDirection;
  ADrawBorder: Boolean = True);
var
  ATheme: TdxTheme;
const
  States: array[TcxArrowDirection, TcxButtonState] of Integer =
   ((ABS_UPNORMAL, ABS_UPNORMAL, ABS_UPHOT, ABS_UPPRESSED, ABS_UPDISABLED),
    (ABS_DOWNNORMAL, ABS_DOWNNORMAL, ABS_DOWNHOT, ABS_DOWNPRESSED, ABS_DOWNDISABLED),
    (ABS_LEFTNORMAL, ABS_LEFTNORMAL, ABS_LEFTHOT, ABS_LEFTPRESSED, ABS_LEFTDISABLED),
    (ABS_RIGHTNORMAL, ABS_RIGHTNORMAL, ABS_RIGHTHOT, ABS_RIGHTPRESSED, ABS_RIGHTDISABLED));

begin
  ATheme := OpenTheme(totScrollBar);
  if ATheme <> 0 then
    DrawThemeBackground(ATheme, ACanvas.Handle, SBP_ARROWBTN, States[AArrowDirection, AState], @R)
  else
    inherited
end;

procedure TcxWinXPLookAndFeelPainter.DrawArrowBorder(ACanvas: TcxCanvas;
  const R: TRect; AState: TcxButtonState);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
    DrawThemeBackground(ATheme, ACanvas.Handle, BP_PUSHBUTTON, BtnStateToXPBtnState(AState), @R)
  else
    inherited;
end;

function TcxWinXPLookAndFeelPainter.BorderSize: Integer;
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totListView);
  if ATheme <> 0 then
    Result := 1 //!!! lcm corrected
  else
    Result := inherited BorderSize;
end;

procedure TcxWinXPLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
var
  ATheme: TdxTheme;
  ASavedDC: HDC;
begin
  ATheme := OpenTheme(totListView);
  if ATheme <> 0 then
  begin
    //DrawThemeEdge(ATheme, ACanvas.Handle, 0, 0, @R, EDGE_SUNKEN, BF_RECT, nil)
    ASavedDC := SaveDC(ACanvas.Handle);
    InflateRect(R, -1, -1);
    ACanvas.ExcludeClipRect(R);
    InflateRect(R, 1, 1);
    DrawThemeBackground(ATheme, ACanvas.Handle, LVP_EMPTYTEXT, 0, @R);
    RestoreDC(ACanvas.Handle, ASavedDC);
  end
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawSeparator(
  ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean);
const
  APartMap: array[Boolean] of Cardinal = (TP_SEPARATORVERT, TP_SEPARATOR);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totToolBar);
  if ATheme <> 0 then
    DrawThemeBackground(ATheme, ACanvas.Handle, APartMap[AIsVertical], TS_NORMAL, R)
  else
    inherited DrawSeparator(ACanvas, R, AIsVertical);
end;

function TcxWinXPLookAndFeelPainter.AdjustGroupButtonDisplayRect(
  const R: TRect; AButtonCount, AButtonIndex: Integer): TRect;
begin
  Result := inherited AdjustGroupButtonDisplayRect(R, AButtonCount, AButtonIndex);
  if IsThemeBackgroundPartiallyTransparent(OpenTheme(totButton), BP_PUSHBUTTON, PBS_NORMAL) then
    InflateRect(Result, 1, 1);
end;

function TcxWinXPLookAndFeelPainter.ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer;
var
  ATheme: TdxTheme;
  R: TRect;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
  begin
    R := Rect(0, 0, 100, 100);
    GetThemeBackgroundContentRect(ATheme, 0, BP_PUSHBUTTON, BtnStateToXPBtnState(AState), R, R);
    Result := R.Left;
  end
  else
    Result := inherited ButtonBorderSize;
end;

function TcxWinXPLookAndFeelPainter.ButtonColor(AState: TcxButtonState): TColor;
begin
  if not cxGetThemeColor(totButton, BP_PUSHBUTTON, BtnStateToXPBtnState(AState), TMT_COLOR, Result) then
    Result := inherited ButtonColor(AState);
end;

function TcxWinXPLookAndFeelPainter.ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect;
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totButton);
  if (ATheme <> 0) and (GetThemeBackgroundContentRect(ATheme, ACanvas.Canvas.Handle, BP_PUSHBUTTON, PBS_NORMAL, R, R) = S_OK) then
    Result := R
  else
    Result := inherited ButtonFocusRect(ACanvas, R);
end;

function TcxWinXPLookAndFeelPainter.ButtonGroupBorderSizes(AButtonCount,
  AButtonIndex: Integer): TRect;
var
  ATheme: TdxTheme;
  CR, R: TRect;
begin
  ATheme := OpenTheme(totButton);
  R := Rect(0, 0, 100, 100);
  GetThemeBackgroundContentRect(ATheme, 0, BP_PUSHBUTTON, PBS_NORMAL, R, CR);
  Result := Rect(CR.Left, CR.Top, R.Right - CR.Right, R.Bottom - CR.Bottom);
  if IsThemeBackgroundPartiallyTransparent(ATheme, BP_PUSHBUTTON, PBS_NORMAL) then
    OffsetRect(Result, -1, -1);
end;

function TcxWinXPLookAndFeelPainter.ButtonSymbolColor(
  AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
begin
  if not cxGetThemeColor(totButton, BP_PUSHBUTTON, BtnStateToXPBtnState(AState), TMT_TEXTCOLOR, Result) then
    Result := inherited ButtonSymbolColor(AState, ADefaultColor);
end;

function TcxWinXPLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := cxTextOffset;
end;

function TcxWinXPLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := 0;
end;

procedure TcxWinXPLookAndFeelPainter.DrawButton(ACanvas: TcxCanvas; R: TRect;
  const ACaption: string; AState: TcxButtonState; ADrawBorder: Boolean = True;
  AColor: TColor = clDefault; ATextColor: TColor = clDefault;
  AWordWrap: Boolean = False; AIsToolButton: Boolean = False);
const
  ButtonObjectType: array[Boolean] of TdxThemedObjectType = (totButton, totToolBar);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(ButtonObjectType[AIsToolButton]);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @R);
    DrawThemeBackground(ATheme, ACanvas.Handle, BP_PUSHBUTTON,
      BtnStateToXPBtnState(AState), R);
    DrawThemeText(ATheme, ACanvas.Handle, BP_PUSHBUTTON, BtnStateToXPBtnState(AState),
      ACaption, -1, DT_CENTER or DT_VCENTER or DT_SINGLELINE, 0, R);
  end
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
const
  States: array[Boolean] of Integer = (GLPS_CLOSED, GLPS_OPENED);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totTreeview);
  if ATheme <> 0 then
  begin
    DrawThemeBackground(ATheme, ACanvas.Handle, TVP_GLYPH, States[AExpanded], @R);
    ACanvas.ExcludeClipRect(R);
  end
  else
    inherited;
end;

function TcxWinXPLookAndFeelPainter.DrawExpandButtonFirst: Boolean;
begin
  Result := False;
end;

procedure TcxWinXPLookAndFeelPainter.DrawGroupExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AState: TcxButtonState);
const
  Buttons: array[Boolean] of Integer = (EBP_NORMALGROUPEXPAND, EBP_NORMALGROUPCOLLAPSE);
  States: array[cxbsNormal..cxbsPressed] of Integer = (EBNGE_NORMAL, EBNGE_HOT, EBNGE_PRESSED);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totExplorerBar);
  if ATheme <> 0 then
    DrawThemeBackground(ATheme, ACanvas.Handle, Buttons[AExpanded], States[AState], @R)
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawSmallExpandButton(ACanvas: TcxCanvas; R: TRect;
  AExpanded: Boolean; ABorderColor: TColor; AColor: TColor = clDefault);
begin
  if OpenTheme(totTreeview) <> 0 then
    DrawExpandButton(ACanvas, R, AExpanded)
  else
    inherited DrawSmallExpandButton(ACanvas, R, AExpanded, AColor);
end;

function TcxWinXPLookAndFeelPainter.ExpandButtonSize: Integer;
var
  ATheme: TdxTheme;
  ASize: TSize;
begin
  ATheme := OpenTheme(totTreeview);
  if ATheme <> 0 then
  begin
    GetThemePartSize(ATheme, 0, TVP_GLYPH, GLPS_OPENED, nil, TS_TRUE, @ASize);
    Result := ASize.cx;
  end
  else
    Result := inherited ExpandButtonSize;
end;

function TcxWinXPLookAndFeelPainter.GroupExpandButtonSize: Integer;
var
  ATheme: TdxTheme;
  ASize: TSize;
begin
  ATheme := OpenTheme(totExplorerBar);
  if ATheme <> 0 then
  begin
    GetThemePartSize(ATheme, 0, EBP_NORMALGROUPEXPAND, EBNGE_NORMAL, nil, TS_TRUE, @ASize);
    Result := ASize.cx;
  end
  else
    Result := inherited GroupExpandButtonSize;
end;

function TcxWinXPLookAndFeelPainter.SmallExpandButtonSize: Integer;
begin
  if OpenTheme(totTreeview) <> 0 then
    Result := ExpandButtonSize
  else
    Result := inherited SmallExpandButtonSize;
end;

function TcxWinXPLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := True;
end;

function TcxWinXPLookAndFeelPainter.IsPointOverGroupExpandButton(const R: TRect;
  const P: TPoint): Boolean;
var
  ATheme: TdxTheme;
  ARegion: HRGN;
begin
  ATheme := OpenTheme(totExplorerBar);
  if ATheme <> 0 then
  begin
    GetThemeBackgroundRegion(ATheme, 0, EBP_NORMALGROUPEXPAND, EBNGE_HOT, @R, ARegion);
    Result := PtInRegion(ARegion, P.X, P.Y);
    DeleteObject(ARegion);
  end
  else
    Result := inherited IsPointOverGroupExpandButton(R, P);
end;

function TcxWinXPLookAndFeelPainter.CheckBorderSize: Integer;
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
    Result := 0
  else
    Result := inherited CheckBorderSize;
end;

function TcxWinXPLookAndFeelPainter.CheckButtonSize: TSize;
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
    GetThemePartSize(ATheme, 0, BP_CHECKBOX, CBS_CHECKEDNORMAL, TS_TRUE, Result)
  else
    Result := inherited CheckButtonSize;
end;

procedure TcxWinXPLookAndFeelPainter.DrawCheck(ACanvas: TcxCanvas; const R: TRect;
  AState: TcxButtonState; AChecked: Boolean; AColor: TColor);
const
  States: array[Boolean, TcxButtonState] of Integer =
    ((CBS_UNCHECKEDNORMAL, CBS_UNCHECKEDNORMAL, CBS_UNCHECKEDHOT, CBS_UNCHECKEDPRESSED, CBS_UNCHECKEDDISABLED),
     (CBS_CHECKEDNORMAL, CBS_CHECKEDNORMAL, CBS_CHECKEDHOT, CBS_CHECKEDPRESSED, CBS_CHECKEDDISABLED));
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @R);
    DrawThemeBackground(ATheme, ACanvas.Handle, BP_CHECKBOX, States[AChecked, AState], @R);
  end
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawCheckBorder(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme = 0 then inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawRadioButton(ACanvas: TcxCanvas; X, Y: Integer;
  AButtonState: TcxButtonState; AChecked: Boolean; AFocused: Boolean; ABrushColor: TColor;  AIsDesigning: Boolean = False);

  function GetNativeState: Integer;
  const
    ANativeStateMap: array [Boolean, TcxButtonState] of Integer = (
      (RBS_UNCHECKEDNORMAL, RBS_UNCHECKEDNORMAL, RBS_UNCHECKEDHOT,
      RBS_UNCHECKEDPRESSED, RBS_UNCHECKEDDISABLED),
      (RBS_CHECKEDNORMAL,RBS_CHECKEDNORMAL, RBS_CHECKEDHOT,
      RBS_CHECKEDPRESSED, RBS_CHECKEDDISABLED)
    );
  begin
    Result := ANativeStateMap[AChecked, AButtonState];
  end;

var
  ARadioButtonSize: TSize;
begin
  ARadioButtonSize := RadioButtonSize;
  DrawThemeBackground(OpenTheme(totButton), ACanvas.Handle, BP_RADIOBUTTON,
    GetNativeState, Rect(X, Y, X + ARadioButtonSize.cx, Y + ARadioButtonSize.cy));
end;

function TcxWinXPLookAndFeelPainter.RadioButtonSize: TSize;
begin
  GetThemePartSize(OpenTheme(totButton), 0, BP_RADIOBUTTON, RBS_UNCHECKEDNORMAL,
    TS_TRUE, Result);
end;

procedure TcxWinXPLookAndFeelPainter.DrawHeader(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil;
  AIsLast: Boolean = False; AInGroupByBox: Boolean = False);
const
  States: array[TcxButtonState] of Integer = (HIS_NORMAL, HIS_NORMAL, HIS_HOT, HIS_PRESSED, HIS_NORMAL);

  function GetHeaderItem: Integer;
  begin
    if AIsLast and (States[AState] = HIS_NORMAL) and
      (GetOffice11Scheme in [schNormalColor, schHomestead]) then
      Result := HP_HEADERITEMRIGHT
    else
      Result := HP_HEADERITEM;
  end;

var
  ATheme: TdxTheme;
  R: TRect;
  AItem: Integer;
begin
  ATheme := OpenTheme(totHeader);
  if ATheme <> 0 then
  begin
    AItem := GetHeaderItem;
  //  DrawThemeParentBackground(0, ACanvas.Handle, @ABounds);
    DrawThemeBackground(ATheme, ACanvas.Handle, AItem, States[AState], @ABounds);
    R := ATextAreaBounds;
    if AState = cxbsPressed then OffsetRect(R, 1, 1);
    DrawContent(ACanvas, ATheme, AItem, States[AState], ABounds, R,
      AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, False, AText,
      AFont, ATextColor, ABkColor);
  end
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawHeaderPressed(ACanvas: TcxCanvas;
  const ABounds: TRect);
begin
end;

procedure TcxWinXPLookAndFeelPainter.DrawHeaderControlSection(
  ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
  ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
  AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine,
  AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
  ABkColor: TColor);
begin
  ACanvas.Brush.Color := clBtnFace;
  ACanvas.FillRect(ABounds);
  DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders,
    AState, AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
    AFont, ATextColor, ABkColor);
end;

procedure TcxWinXPLookAndFeelPainter.DrawSortingMark(
  ACanvas: TcxCanvas; const R: TRect; AAscendingSorting: Boolean);
begin
  DrawSortingArrow(ACanvas, R, clBtnShadow, clBtnShadow, AAscendingSorting);
end;

function TcxWinXPLookAndFeelPainter.HeaderBorderSize: Integer;
var
  ATheme: TdxTheme;
  R: TRect;
begin
  ATheme := OpenTheme(totHeader);
  if ATheme <> 0 then
  begin
    R := Rect(0, 0, 100, 100);
    GetThemeBackgroundContentRect(ATheme, 0, HP_HEADERITEM, HIS_NORMAL, R, R);
    Result := Max((R.Left + R.Top) div 2, 1);
  end
  else
    Result := inherited HeaderBorderSize;
end;

function TcxWinXPLookAndFeelPainter.HeaderControlSectionBorderSize(
  AState: TcxButtonState = cxbsNormal): Integer;
begin
  Result := HeaderBorderSize;
end;

function TcxWinXPLookAndFeelPainter.HeaderControlSectionContentBounds(
  const ABounds: TRect; AState: TcxButtonState): TRect;
var
  ABorderWidth: Integer;
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totHeader);
  if ATheme <> 0 then
  begin
    ABorderWidth := HeaderBorderSize;
    Result := ABounds;
    InflateRect(Result, -ABorderWidth, -ABorderWidth);
  end
  else
    Result := inherited HeaderControlSectionContentBounds(ABounds, AState);
end;

{function TcxWinXPLookAndFeelPainter.HeaderDrawCellsFirst: Boolean;
begin
  Result := False;
end;}

function TcxWinXPLookAndFeelPainter.IsHeaderHotTrack: Boolean;
begin
  Result := True;
end;

function TcxWinXPLookAndFeelPainter.SortingMarkSize: TPoint;
begin
  Result := Point(7, 8);
end;

procedure TcxWinXPLookAndFeelPainter.DrawFooterBorder(ACanvas: TcxCanvas;
  const R: TRect);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totEdit);
  if ATheme <> 0 then
    DrawThemeEdge(ATheme, ACanvas.Handle, 0, 0, @R, BDR_RAISEDINNER, BF_RECT, nil)
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawFooterCell(ACanvas: TcxCanvas;
  const ABounds: TRect; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine: Boolean; const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totTrackBar);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @ABounds);
    DrawThemeBackground(ATheme, ACanvas.Handle, TKP_TRACK, TRS_NORMAL, @ABounds);
    DrawContent(ACanvas, ATheme, TKP_TRACK, TRS_NORMAL, ABounds, FooterCellTextAreaBounds(ABounds),
      AAlignmentHorz, AAlignmentVert, AMultiLine, False, False, AText, AFont,
      ATextColor, ABkColor);
  end
  else
    inherited;
end;

function TcxWinXPLookAndFeelPainter.FooterBorderSize: Integer;
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totEdit);
  if ATheme <> 0 then
    Result := 1 //!!!
  else
    Result := inherited FooterBorderSize;
end;

function TcxWinXPLookAndFeelPainter.FooterCellBorderSize: Integer;
var
  ATheme: TdxTheme;
  R: TRect;
begin
  ATheme := OpenTheme(totTrackBar);
  if ATheme <> 0 then
  begin
    R := Rect(0, 0, 100, 100);
    GetThemeBackgroundContentRect(ATheme, 0, TKP_TRACK, TRS_NORMAL, R, R);
    Result := R.Left;
  end
  else
    Result := inherited FooterCellBorderSize;
end;

function TcxWinXPLookAndFeelPainter.FooterCellOffset: Integer;
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totTrackBar);
  if ATheme <> 0 then
    Result := 1
  else
    Result := inherited FooterCellOffset;
end;

function TcxWinXPLookAndFeelPainter.FooterDrawCellsFirst: Boolean;
begin
  Result := False;
end;

procedure TcxWinXPLookAndFeelPainter.DrawFilterCloseButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState);
const
  States: array[TcxButtonState] of Integer = (CBS_NORMAL, CBS_NORMAL, CBS_HOT,
    CBS_PUSHED, CBS_DISABLED);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totWindow);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @R);
    DrawThemeBackground(ATheme, ACanvas.Handle, WP_SMALLCLOSEBUTTON, States[AState], @R);
  end
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawFilterDropDownButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean);
const
  States: array[TcxButtonState] of Integer =(CBXS_NORMAL, CBXS_NORMAL, CBXS_HOT,
    CBXS_PRESSED, CBXS_DISABLED);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totComboBox);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @R);
    DrawThemeBackground(ATheme, ACanvas.Handle, CP_DROPDOWNBUTTON, States[AState], @R);
  end
  else
    inherited;
end;

function TcxWinXPLookAndFeelPainter.FilterActivateButtonSize: TPoint;
var
  ATheme: TdxTheme;
  ASize: TSize;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
  begin
    GetThemePartSize(ATheme, 0, BP_CHECKBOX, CBS_CHECKEDNORMAL, nil, TS_TRUE, @ASize);
    Result.X := ASize.cx; Result.Y := ASize.cy;
  end
  else
    Result := inherited FilterActivateButtonSize;
end;

function TcxWinXPLookAndFeelPainter.FilterCloseButtonSize: TPoint;
var
  ATheme: TdxTheme;
  ASize: TSize;
begin
  ATheme := OpenTheme(totWindow);
  if ATheme <> 0 then
  begin
    GetThemePartSize(ATheme, 0, WP_SMALLCLOSEBUTTON, CBXS_NORMAL, nil, TS_TRUE, @ASize);
    Result := Point(ASize.cx + 4, ASize.cy + 4);
  end
  else
    Result := inherited FilterCloseButtonSize
end;

procedure TcxWinXPLookAndFeelPainter.LayoutViewDrawRecordCaption(
  ACanvas: TcxCanvas; const ABounds: TRect;
  APosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState);
begin
  LayoutViewDrawRecordBorder(ACanvas, ABounds, AState, cxBordersAll);
  DrawTab(ACanvas, ABounds, [], '', AState, APosition <> cxgpTop, nil, clDefault, clDefault);
end;

procedure TcxWinXPLookAndFeelPainter.DrawTab(ACanvas: TcxCanvas; R: TRect;
  ABorders: TcxBorders; const AText: string; AState: TcxButtonState; AVertical: Boolean;
  AFont: TFont; ATextColor, ABkColor: TColor; AShowPrefix: Boolean = False);
const
  States: array[TcxButtonState] of Integer =
    (TIS_NORMAL, TIS_NORMAL, TIS_HOT, TIS_SELECTED, TIS_DISABLED);
var
  ATheme: TdxTheme;
  AOriginalR, ADrawR: TRect;
  B: TBitmap;
  DC: HDC;

  procedure RotateRect(var R: TRect);
  var
    I: Integer;
  begin
    with R do
    begin
      I := Right;
      Right := Bottom;
      Bottom := I;
    end;
  end;

  procedure PrepareRects;
  begin
    ADrawR := R;
    if AVertical then
    begin
      if not (bTop in ABorders) then Dec(ADrawR.Left, 2);
      if not (bBottom in ABorders) then Inc(ADrawR.Right, 2);
    end
    else
    begin
      if not (bLeft in ABorders) then Dec(ADrawR.Left, 2);
      if not (bRight in ABorders) then Inc(ADrawR.Right, 2);
    end;
    if AState = cxbsPressed then
      Inc(ADrawR.Bottom)
    else
      Dec(R.Bottom);
  end;

begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
  begin
    if AVertical then
    begin
      AOriginalR := R;
      OffsetRect(R, -R.Left, -R.Top);
      RotateRect(R);
      B := TBitmap.Create;
      B.PixelFormat := pf32bit;
      B.HandleType := bmDDB;
      B.Width := R.Right;
      B.Height := R.Bottom;
      DC := B.Canvas.Handle;
    end
    else
    begin
      B := nil;
      DC := ACanvas.Handle;
    end;

    PrepareRects;
    DrawThemeBackground(ATheme, DC, TABP_TABITEM, States[AState], @ADrawR, @R);

    if AVertical then
    begin
      ACanvas.RotateBitmap(B, raPlus90, True);
      RotateRect(R);
      RotateRect(ADrawR);
      ACanvas.CopyRect(Bounds(AOriginalR.Left, AOriginalR.Top, R.Right, R.Bottom),
        B.Canvas, R);
      B.Free;
      OffsetRect(R, AOriginalR.Left, AOriginalR.Top);
      OffsetRect(ADrawR, AOriginalR.Left, AOriginalR.Top);
    end;

    if AState = cxbsPressed then
      if AVertical then
        Dec(ADrawR.Right, 2)
      else
        Dec(ADrawR.Bottom, 2);
    DrawContent(ACanvas, ATheme, TABP_TABITEM, States[AState], R, ADrawR,
      taCenter, vaCenter, False, False, AShowPrefix, AText, AFont, ATextColor, ABkColor);
  end
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawTabBorder(ACanvas: TcxCanvas; R: TRect;
  ABorder: TcxBorder; ABorders: TcxBorders; AVertical: Boolean);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
  begin
    //
  end
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawTabsRoot(ACanvas: TcxCanvas;
  const R: TRect; ABorders: TcxBorders; AVertical: Boolean);
var
  ATheme: TdxTheme;
  AContentR, AFullR: TRect;
begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
  begin
    //DrawThemeParentBackground(0, ACanvas.Handle, @R);
    GetThemeBackgroundContentRect(ATheme, 0, TABP_PANE, 0, R, AContentR);
    AFullR := R;
    if AVertical then
    begin
      Inc(AFullR.Bottom, (R.Bottom - AContentR.Bottom) - (AContentR.Top - R.Top));
      Inc(AFullR.Right, 10);
    end
    else
    begin
      Inc(AFullR.Right, (R.Right - AContentR.Right) - (AContentR.Left - R.Left));
      Inc(AFullR.Bottom, 10);
    end;
    DrawThemeBackground(ATheme, ACanvas.Handle, TABP_PANE, 0, @AFullR, @R);
  end
  else
    inherited;
end;

function TcxWinXPLookAndFeelPainter.IsDrawTabImplemented(AVertical: Boolean): Boolean;
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
    Result := True
  else
    Result := inherited IsDrawTabImplemented(AVertical);
end;

function TcxWinXPLookAndFeelPainter.IsTabHotTrack(AVertical: Boolean): Boolean;
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
    Result := True
  else
    Result := inherited IsTabHotTrack(AVertical);
end;

function TcxWinXPLookAndFeelPainter.TabBorderSize(AVertical: Boolean): Integer;
var
  ATheme: TdxTheme;
  //R: TRect;
begin
  ATheme := OpenTheme(totTab);
  if ATheme <> 0 then
  begin
    {R := Rect(0, 0, 100, 100);
    GetThemeBackgroundContentRect(ATheme, 0, TABP_TABITEM, TIS_NORMAL, @R, R);}
    Result := 1;//R.Left;
  end
  else
    Result := inherited TabBorderSize(AVertical);
end;

procedure TcxWinXPLookAndFeelPainter.DrawSplitter(ACanvas: TcxCanvas; const ARect: TRect;
  AHighlighted: Boolean; AClicked: Boolean; AHorizontal: Boolean);
begin
end;

procedure TcxWinXPLookAndFeelPainter.DrawIndicatorItem(
  ACanvas: TcxCanvas; const R: TRect; AKind: TcxIndicatorKind; AColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
var
  APainter: TcxCustomLookAndFeelPainter;
begin
  if cxLookAndFeelPaintersManager.GetPainter(lfsFlat, APainter) then
    APainter.DrawIndicatorItem(ACanvas, R, AKind, AColor, AOnDrawBackground)
  else
    inherited DrawIndicatorItem(ACanvas, R, AKind, AColor, AOnDrawBackground);
end;

function TcxWinXPLookAndFeelPainter.ScrollBarMinimalThumbSize(AVertical: Boolean): Integer;

  function GetPartSize(ATheme: TdxTheme; ASize: Integer; out APartSize: TSize): Boolean;
  const
    ThumbnailGripKind: array[Boolean] of Integer = (SBP_GRIPPERVERT, SBP_GRIPPERHORZ);
  begin
    Result := (ATheme <> 0) and (GetThemePartSize(ATheme, 0,
      ThumbnailGripKind[AVertical], SCRBS_NORMAL, ASize, APartSize) = S_OK);
  end;

var
  ATheme: TdxTheme;
  AThumbSize, AGripSize: TSize;
begin
  ATheme := OpenTheme(totScrollBar);
  if GetPartSize(ATheme, TS_MIN, AGripSize) then
  begin
    if GetPartSize(ATheme, TS_TRUE, AThumbSize) then
    begin
      if AVertical then
        Result := Max(AGripSize.cy, AThumbSize.cy + 4)
      else
        Result := Max(AGripSize.cx, AThumbSize.cx + 4);
    end
    else
      if AVertical then
        Result := AGripSize.cy
      else
        Result := AGripSize.cx;
    Result := Max(Result, cxStdThumbnailMinimalSize);
  end
  else
    Result := cxStdThumbnailMinimalSize;
end;

procedure TcxWinXPLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
const
  ThumbnailKind: array[Boolean] of Integer = (SBP_THUMBBTNVERT, SBP_THUMBBTNHORZ);
  ThumbnailGripperKind: array[Boolean] of Integer = (SBP_GRIPPERVERT, SBP_GRIPPERHORZ);
  ThumbnailPage: array[Boolean, Boolean] of Integer =
    ((SBP_UPPERTRACKVERT, SBP_LOWERTRACKVERT), (SBP_UPPERTRACKHORZ, SBP_LOWERTRACKHORZ));

  function GetThumbnailState: Integer;
  begin
    case AState of
      cxbsHot:
        Result := SCRBS_HOT;
      cxbsPressed:
        Result := SCRBS_PRESSED;
      cxbsDisabled:
        Result := SCRBS_DISABLED;
      else
        Result := SCRBS_NORMAL;
    end;
  end;

  function CanDrawThumbnailGripper(ATheme: TdxTheme; AElement: Integer): Boolean;
  var
    ASize: TSize;
  begin
    Result := True;
    if GetThemePartSize(ATheme, 0, AElement, SCRBS_NORMAL, TS_TRUE, ASize) = S_OK then
    begin
      if AHorizontal then
        Result := ASize.cy < cxRectWidth(R)
      else
        Result := ASize.cx < cxRectHeight(R);
    end;
  end;

var
  ATheme: TdxTheme;
begin
  if IsRectEmpty(R) then Exit;

  ATheme := OpenTheme(totScrollBar);
  if ATheme = TC_NONE then
    inherited DrawScrollBarPart(ACanvas, AHorizontal, R, APart, AState)
  else
    case APart of
      sbpLineUp, sbpLineDown:
        DrawArrow(ACanvas, R, AState, GetArrowDirection(AHorizontal, APart));

      sbpPageUp, sbpPageDown:
        DrawThemeBackground(ATheme, ACanvas.Handle,
          ThumbnailPage[AHorizontal, APart = sbpPageUp], GetThumbnailState, @R);

      sbpThumbnail:
        begin
          DrawThemeBackground(ATheme, ACanvas.Handle, ThumbnailKind[AHorizontal], GetThumbnailState, @R);
          if CanDrawThumbnailGripper(ATheme, ThumbnailKind[AHorizontal]) then
            DrawThemeBackground(ATheme, ACanvas.Handle, ThumbnailGripperKind[AHorizontal], GetThumbnailState, @R);
        end;
    end;
end;

function TcxWinXPLookAndFeelPainter.DefaultSchedulerViewContentColor: TColor;
begin
  Result := $D5FFFF;
end;

procedure TcxWinXPLookAndFeelPainter.DrawMonthHeader(
  ACanvas: TcxCanvas; const ABounds: TRect; const AText: string;
  ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
  AArrows: TcxHeaderArrows; ASideWidth: Integer;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, ABounds, ABounds, ANeighbors, cxBordersAll, cxbsNormal, taCenter,
    vaCenter, False, False, AText, AViewParams.Font, AViewParams.TextColor,
    AViewParams.Color, AOnDrawBackground, not (nRight in ANeighbors));
  DrawMonthHeaderArrows(ACanvas, ABounds, AArrows, ASideWidth, clWindowText);
end;

procedure TcxWinXPLookAndFeelPainter.DrawSchedulerEventProgress(
  ACanvas: TcxCanvas; const ABounds, AProgressChunk: TRect;
  AViewParams: TcxViewParams; ATransparent: Boolean);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totProgress);
  if ATheme = 0 then
    inherited DrawSchedulerEventProgress(ACanvas, ABounds, AProgressChunk,
      AViewParams, ATransparent)
  else
  begin
    DrawThemeBackground(ATheme, ACanvas.Handle, PP_BAR, 0, ABounds);
    DrawThemeBackground(ATheme, ACanvas.Handle, PP_CHUNK, 0, AProgressChunk);
  end;
end;

function TcxWinXPLookAndFeelPainter.SchedulerEventProgressOffsets: TRect;
begin
  Result := Rect(3, 3, 3, 3);
end;

procedure TcxWinXPLookAndFeelPainter.DrawSchedulerNavigatorButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
const
  ButtonStates: array[TcxButtonState] of Integer =
    (TS_HOT, TS_HOT, TS_CHECKED, TS_PRESSED, TS_DISABLED);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totToolBar);
  if ATheme <> 0 then
    DrawThemeBackground(ATheme, ACanvas.Handle, TP_BUTTON,
      ButtonStates[AState], @R)
  else
    inherited;  
end;

procedure TcxWinXPLookAndFeelPainter.DrawSchedulerSplitterBorder(
  ACanvas: TcxCanvas; R: TRect; const AViewParams: TcxViewParams;
  AIsHorizontal: Boolean);
var
  AColor: TColor;
begin
  if (OpenTheme(totListView) <> 0) and
    cxGetThemeColor(totComboBox, CP_DROPDOWNBUTTON, CBXS_NORMAL, TMT_BORDERCOLOR, AColor) then
  begin
    ACanvas.SetBrushColor(AColor);
    if AIsHorizontal then
    begin
      ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
      ACanvas.FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
      InflateRect(R, 1, -1);
    end
    else
    begin
      ACanvas.FillRect(Rect(R.Left, R.Top, R.Left + 1, R.Bottom));
      ACanvas.FillRect(Rect(R.Right - 1, R.Top, R.Right, R.Bottom));
      InflateRect(R, -1, 1);
    end;
    ACanvas.FillRect(R, AViewParams);
  end
  else
    inherited DrawSchedulerSplitterBorder(ACanvas, R, AViewParams, AIsHorizontal);
end;

function TcxWinXPLookAndFeelPainter.SizeGripSize: TSize;
var
  ATheme: Cardinal;
begin
  ATheme := OpenTheme(totScrollBar);
  GetThemePartSize(ATheme, 0, SBP_SIZEBOX, SZB_RIGHTALIGN, TS_TRUE, Result);
end;

procedure TcxWinXPLookAndFeelPainter.DoDrawSizeGrip(ACanvas: TcxCanvas; const ARect: TRect);
var
  ATheme: Cardinal;
begin
  ATheme := OpenTheme(totScrollBar);
  if ATheme <> 0 then
    DrawThemeBackground(ATheme, ACanvas.Handle, SBP_SIZEBOX, SZB_RIGHTALIGN, ARect)
  else
    inherited;
end;

function TcxWinXPLookAndFeelPainter.SmallCloseButtonSize: TSize;
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totWindow);
  GetThemePartSize(ATheme, 0, WP_SMALLCLOSEBUTTON, CBS_NORMAL, TS_TRUE, Result);
end;

procedure TcxWinXPLookAndFeelPainter.DrawGroupBoxFrame(ACanvas: TcxCanvas;
  R: TRect; AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition;
  ABorders: TcxBorders = cxBordersAll);
const
  StateMap: array[Boolean] of Integer = (GBS_DISABLED, GBS_NORMAL);  
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totButton);
  if ATheme <> 0 then
    DrawThemeBackground(ATheme, ACanvas.Handle, BP_GROUPBOX, StateMap[AEnabled], R)
  else
    inherited DrawGroupBoxFrame(ACanvas, R, AEnabled, ACaptionPosition, ABorders);
end;

function TcxWinXPLookAndFeelPainter.GroupBoxTextColor(AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TColor;
const
  GroupBoxStateMap: array[Boolean] of Integer = (GBS_DISABLED, GBS_NORMAL);
begin
  if not cxGetThemeColor(totButton, BP_GROUPBOX, GroupBoxStateMap[AEnabled], TMT_TEXTCOLOR, Result) then
    Result := inherited GroupBoxTextColor(AEnabled, ACaptionPosition);
end;

procedure TcxWinXPLookAndFeelPainter.DrawPanelBackground(ACanvas: TcxCanvas;
  AControl: TWinControl; ABounds: TRect; AColorFrom, AColorTo: TColor);
begin
  if AColorFrom = clDefault then
    cxDrawTransparentControlBackground(AControl, ACanvas, ABounds)
  else
    ACanvas.FillRect(ABounds, AColorFrom);
end;

procedure TcxWinXPLookAndFeelPainter.DrawEditPopupWindowBorder(ACanvas: TcxCanvas; var R: TRect;
  ABorderStyle: TcxEditPopupBorderStyle; AClientEdge: Boolean);
begin
  if IsWinVistaOrLater then
    DrawThemeBackground(OpenTheme(totListBox), ACanvas.Handle, LBCP_BORDER_NOSCROLL, LBPSN_HOT, R)
  else
    ACanvas.FrameRect(R, clBtnText);
  InflateRect(R, -1, -1);
end;

function TcxWinXPLookAndFeelPainter.GetEditPopupWindowBorderWidth(AStyle: TcxEditPopupBorderStyle): Integer;
begin
  Result := 1;
end;

function TcxWinXPLookAndFeelPainter.GetEditPopupWindowClientEdgeWidth(AStyle: TcxEditPopupBorderStyle): Integer;
begin
  Result := 2;
end;

const
  AThumbThemeParts: array[TcxTrackBarTicksAlign, Boolean] of Byte = (
    (TKP_THUMBLEFT, TKP_THUMBTOP),
    (TKP_THUMBRIGHT, TKP_THUMBBOTTOM),
    (TKP_THUMBVERT, TKP_THUMB)
  );

procedure TcxWinXPLookAndFeelPainter.CorrectThumbRect(ACanvas: TcxCanvas;
  var ARect: TRect; AHorizontal: Boolean; ATicks: TcxTrackBarTicksAlign);
var
  ATheme: TdxTheme;
  AThumbSize: TSize;
begin
  ATheme := OpenTheme(totTrackBar);
  if ATheme <> 0 then
  begin
    GetThemePartSize(ATheme, ACanvas.Handle,
      AThumbThemeParts[ATicks, AHorizontal], TUS_NORMAL, ARect, TS_DRAW, AThumbSize);
    ARect.Left := ARect.Left + (cxRectWidth(ARect) - AThumbSize.cx) div 2;
    ARect.Top := ARect.Top + (cxRectHeight(ARect) - AThumbSize.cy) div 2;
    ARect.Right := ARect.Left + AThumbSize.cx;
    ARect.Bottom := ARect.Top + AThumbSize.cy;
  end
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawTrackBarTrack(ACanvas: TcxCanvas;
  const ARect, ASelection: TRect; AShowSelection, AEnabled, AHorizontal: Boolean; ATrackColor: TColor);
const
  ATrackType: array[Boolean] of Byte = (TKP_TRACKVERT, TKP_TRACK);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totTrackBar);
  if ATheme <> 0 then
    DrawThemeBackground(ATheme, ACanvas.Handle, ATrackType[AHorizontal], TUS_NORMAL, ARect)
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawTrackBarThumb(ACanvas: TcxCanvas;
  const ARect: TRect; AState: TcxButtonState;
  AHorizontal: Boolean; ATicks: TcxTrackBarTicksAlign; AThumbColor: TColor);
const
  AStateMap: array[TcxButtonState] of Byte =
    (TUS_HOT, TUS_NORMAL, TUS_HOT, TUS_PRESSED, TUS_DISABLED);
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totTrackBar);
  if ATheme <> 0 then
    DrawThemeBackground(ATheme, ACanvas.Handle, AThumbThemeParts[ATicks, AHorizontal], AStateMap[AState], ARect)
  else
    inherited;
end;

procedure TcxWinXPLookAndFeelPainter.DrawDateNavigatorDateHeader(
  ACanvas: TcxCanvas; var R: TRect);
begin
  DrawThemeBackground(OpenTheme(totHeader), ACanvas.Handle,
    HP_HEADERITEMLEFT, HIS_NORMAL, R);
end;

{ TcxLookAndFeelPaintersManager }

function cxLookAndFeelPaintersManagerSortProc(
  AItem1, AItem2: TcxCustomLookAndFeelPainter): Integer;
begin
  Result := AnsiCompareStr(AItem1.LookAndFeelName, AItem2.LookAndFeelName);
end;


constructor TcxLookAndFeelPaintersManager.Create;
begin
  inherited Create;
  FPainters := TcxObjectList.Create;
  FListeners := TInterfaceList.Create;
end;

destructor TcxLookAndFeelPaintersManager.Destroy;
begin
  FreeAndNil(FListeners);
  FreeAndNil(FPainters);
  inherited Destroy;
end;

procedure TcxLookAndFeelPaintersManager.AddListener(const AListener: IcxLookAndFeelPainterListener);
begin
  if Listeners.IndexOf(AListener) < 0 then
    Listeners.Add(AListener);
end;

procedure TcxLookAndFeelPaintersManager.DoPainterAdded(APainter: TcxCustomLookAndFeelPainter);
var
  I: Integer;
begin
  for I := Listeners.Count - 1 downto 0 do
    IcxLookAndFeelPainterListener(Listeners[I]).PainterAdded(APainter);
end;

procedure TcxLookAndFeelPaintersManager.DoPainterRemoved(APainter: TcxCustomLookAndFeelPainter);
var
  I: Integer;
begin
  for I := Listeners.Count - 1 downto 0 do
    IcxLookAndFeelPainterListener(Listeners[I]).PainterRemoved(APainter);
end;

function TcxLookAndFeelPaintersManager.GetPainter(
  AStyle: TcxLookAndFeelStyle; out APainter: TcxCustomLookAndFeelPainter): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if Items[I].LookAndFeelStyle = AStyle then
    begin
      APainter := Items[I];
      Result := True;
      Break;
    end;
end;

function TcxLookAndFeelPaintersManager.GetPainter(
  const AName: string; out APainter: TcxCustomLookAndFeelPainter): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if SameText(Items[I].LookAndFeelName, AName) then
    begin
      APainter := Items[I];
      Result := True;
      Break;
    end;
end;

function TcxLookAndFeelPaintersManager.GetPainter(AStyle: TcxLookAndFeelStyle): TcxCustomLookAndFeelPainter;
begin
  if not GetPainter(AStyle, Result) then
    Result := nil;
end;

function TcxLookAndFeelPaintersManager.GetPainter(const AName: string): TcxCustomLookAndFeelPainter;
begin
  if not GetPainter(AName, Result) then
    Result := nil;
end;

function TcxLookAndFeelPaintersManager.Register(APainter: TcxCustomLookAndFeelPainter): Boolean;
begin
  Result := GetPainter(APainter.LookAndFeelName) = nil;
  if Result then
  begin
    FPainters.Add(APainter);
    SortPainters;
    DoPainterAdded(APainter);
  end
  else
    APainter.Free;
end;

procedure TcxLookAndFeelPaintersManager.RemoveListener(const AListener: IcxLookAndFeelPainterListener);
begin
  Listeners.Remove(AListener);
end;

procedure TcxLookAndFeelPaintersManager.SortPainters;
begin
  FPainters.Sort(TListSortCompare(@cxLookAndFeelPaintersManagerSortProc));
end;

function TcxLookAndFeelPaintersManager.Unregister(const AName: string): Boolean;
var
  APainter: TcxCustomLookAndFeelPainter;
begin
  APainter := GetPainter(AName);
  Result := APainter <> nil;
  if Result then
  try
    FPainters.Remove(APainter);
    DoPainterRemoved(APainter);
  finally
    APainter.Free;
  end;
end;

function TcxLookAndFeelPaintersManager.GetCount: Integer;
begin
  Result := FPainters.Count;
end;

function TcxLookAndFeelPaintersManager.GetItem(AIndex: Integer): TcxCustomLookAndFeelPainter;
begin
  Result := TcxCustomLookAndFeelPainter(FPainters[AIndex]);
end;

procedure PrepareRadioButtonImageList;
begin
  RadioButtonImageList;
end;

procedure CalculateCheckButtonSize;
var
  AButtonsBitmap: HBITMAP;
  B: Windows.TBitmap;
begin
  AButtonsBitmap := LoadBitmap(0, PChar(OBM_CHECKBOXES));
  try
    cxGetBitmapData(AButtonsBitmap, B);
    FCheckButtonSize := Size(B.bmWidth div 4, B.bmHeight div 3);
  finally
    DeleteObject(AButtonsBitmap);
  end;
end;

procedure CreateIndicatorImages;
var
  B: TBitmap;

  procedure AddImage(const AResourceName: string);
  begin
    B.LoadFromResourceName(HInstance, AResourceName);
    if cxIndicatorImages = nil then
      cxIndicatorImages := TImageList.CreateSize(B.Width, B.Height);
    cxIndicatorImages.AddMasked(B, clWhite);
  end;

begin
  B := TBitmap.Create;
  try
    AddImage('CX_ARROWBITMAP');
    AddImage('CX_EDITBITMAP');
    AddImage('CX_INSERTBITMAP');
    AddImage('CX_MULTIDOTBITMAP');
    AddImage('CX_MULTIARROWBITMAP');
    AddImage('CX_FILTERBITMAP');
  finally
    B.Free;
  end;
end;

procedure DestroyIndicatorImages;
begin
  FreeAndNil(cxIndicatorImages);
end;

procedure CreateStdScrollBarBitmaps;
begin
  StdScrollBitmaps[False] := TBitmap.Create;
  with StdScrollBitmaps[False] do
  begin
    Width := 8;
    Height := 8;
  end;
  StdScrollBitmaps[True] := TBitmap.Create;
  with StdScrollBitmaps[True] do
  begin
    Width := 8;
    Height := 8;
  end;
  UpdateScrollBarBitmaps;
end;

procedure UpdateScrollBarBitmaps;
var
  X, Y: Integer;
begin
  if StdScrollBitmaps[False] = nil then
    CreateStdScrollBarBitmaps;
  for X := 0 to 7 do
    for Y := 0 to 7 do
      if (Y mod 2) = (X mod 2) then
      begin
        StdScrollBitmaps[False].Canvas.Pixels[X, Y] := clBtnFace;
        StdScrollBitmaps[True].Canvas.Pixels[X, Y] := clBlack;
      end
      else
      begin
        StdScrollBitmaps[False].Canvas.Pixels[X, Y] := clBtnHighlight;
        StdScrollBitmaps[True].Canvas.Pixels[X, Y] := cl3DDkShadow;
      end;
end;

function cxTextRect(const R: TRect): TRect;
begin
  Result := R;
  InflateRect(Result, -cxTextOffset, -cxTextOffset);
end;

procedure DestroyStdScrollBarBitmaps;
begin
  FreeAndNil(StdScrollBitmaps[False]);
  FreeAndNil(StdScrollBitmaps[True]);
end;

procedure RegisterStandardLookAndFeelPainters;
begin
  cxLookAndFeelPaintersManager.Register(TcxFlatLookAndFeelPainter.Create);
  cxLookAndFeelPaintersManager.Register(TcxOffice11LookAndFeelPainter.Create);
  cxLookAndFeelPaintersManager.Register(TcxStandardLookAndFeelPainter.Create);
  cxLookAndFeelPaintersManager.Register(TcxUltraFlatLookAndFeelPainter.Create);
  cxLookAndFeelPaintersManager.Register(TcxWinXPLookAndFeelPainter.Create);
end;

initialization
  cxLookAndFeelPaintersManager := TcxLookAndFeelPaintersManager.Create;
  FSystemPaletteChangedNotifier := TSystemPaletteChangedNotifier.Create(True);
  CreateIndicatorImages;
  CreateStdScrollBarBitmaps;
  CalculateCheckButtonSize;
  RegisterStandardLookAndFeelPainters;

finalization
  FreeAndNil(FSystemPaletteChangedNotifier);
  DestroyStdScrollBarBitmaps;
  DestroyIndicatorImages;
  FreeAndNil(cxLookAndFeelPaintersManager);
  FreeAndNil(FRadioButtonImageList);
end.
