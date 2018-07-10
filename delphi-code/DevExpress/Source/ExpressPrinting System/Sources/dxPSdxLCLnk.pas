{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2011 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPSdxLCLnk;

interface

{$I cxVer.inc}
{$I dxPS.inc}

uses
  Classes, Windows, Graphics, Controls, ComCtrls, dxLayoutLookAndFeels,
  dxLayoutControl, dxLayoutContainer, dxBase, dxPrnPg, dxPSCore, dxPSContainerLnk, cxDrawTextUtils,
  dxPSReportRenderCanvas, cxGeometry, cxGraphics, dxLayoutCommon;

type
  TdxLayoutControlReportLink = class;
  TdxLayoutControlReportLinkOptionsBehavior = class;
  TdxLayoutControlReportLinkOptionsPagination = class;
  TdxLayoutControlReportLinkOptionsTransparent = class;

  { Report Items}

  TdxLCCacheItemKind = (ikLayoutItem, ikLayoutGroup, ikLayoutItemCaption, ikControl);

  TdxLCBoundsCacheItem = class
  public
    Component: TComponent; // nil if ItemKind =  ikItemCaption
    Bounds: TRect;
    EmbeddedLink: Boolean;
  end;

  TdxReportLayoutControlHost = class(TdxReportWinControlHost)
  protected
    function GetControlItem: TdxReportVisualItem; override;
  end;

  TdxReportLayoutCaptionTextCell = class(TdxReportCellString)
  protected
    function GetDefaultDTFormat: DWORD; override;
  end;
  TdxReportLayoutCaptionTextCellClass = class of TdxReportLayoutCaptionTextCell;

  TdxReportLayoutCaptionImageCell = class(TdxReportCellImage);
  TdxReportLayoutCaptionImageCellClass = class of TdxReportLayoutCaptionImageCell;

  TdxReportCustomLayoutCaptionCell = class(TdxReportCell)
  private
    FTextItem: TdxReportLayoutCaptionTextCell;
    FImageItem: TdxReportCellImage;
    function GetItem: TdxCustomLayoutItem;
    function GetCaptionBounds: TRect;
    function GetCaptionOptions: TdxCustomLayoutItemCaptionOptions;
    function GetHasImageItem: Boolean;
    function GetHasTextItem: Boolean;
    function GetImageBounds: TRect;
    function GetImageOptions: TdxCustomLayoutItemImageOptions;
    function GetTextBounds: TRect;
    function GetViewInfo: TdxCustomLayoutItemViewInfo;
  protected
    procedure AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas); virtual;

    function CreateImageCell(AReportLink: TBasedxReportLink): TdxReportCellImage; virtual;
    function CreateTextCell(AReportLink: TBasedxReportLink): TdxReportLayoutCaptionTextCell; virtual;
    function GetReportLayoutCaptionImageCellClass: TdxReportLayoutCaptionImageCellClass; virtual;
    function GetReportLayoutCaptionTextCellClass: TdxReportLayoutCaptionTextCellClass; virtual;

    function IsImageVisible: Boolean; virtual;
    function IsTextVisible: Boolean; virtual;

    property CaptionBounds: TRect read GetCaptionBounds;
    property ImageBounds: TRect read GetImageBounds;
    property TextBounds: TRect read GetTextBounds;

    property CaptionOptions: TdxCustomLayoutItemCaptionOptions read GetCaptionOptions;
    property ImageOptions: TdxCustomLayoutItemImageOptions read GetImageOptions;
  public
    procedure Initialize(AReportLink: TBasedxReportLink); virtual;

    property ImageItem: TdxReportCellImage read FImageItem;
    property Item: TdxCustomLayoutItem read GetItem;
    property HasImageItem: Boolean read GetHasImageItem;
    property HasTextItem: Boolean read GetHasTextItem;
    property TextItem: TdxReportLayoutCaptionTextCell read FTextItem;
    property ViewInfo: TdxCustomLayoutItemViewInfo read GetViewInfo;
  end;

  TdxReportCustomLayoutCaptionCellClass = class of TdxReportCustomLayoutCaptionCell;

  TdxCustomReportLayoutItemClass = class of TdxCustomReportLayoutItem;

  TdxLCGetLayoutItemViewInfoEvent = procedure(AItem: TdxCustomLayoutItem; var AViewInfo: TdxCustomLayoutItemViewInfo) of object;

  TdxCustomReportLayoutItem = class(TdxReportGroup)
  private
    FCaptionItem: TdxReportCustomLayoutCaptionCell;
    FOnGetLayoutItemViewInfo: TdxLCGetLayoutItemViewInfoEvent;
    function GetHasCaptionItem: Boolean;
    function GetItem: TdxCustomLayoutItem;
    function GetItemBounds: TRect;
    function GetViewInfo: TdxCustomLayoutItemViewInfo;
  protected
    procedure AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas); virtual;
    procedure Initialize(AReportLink: TBasedxReportLink); virtual;
    function GetCaptionCellClass: TdxReportCustomLayoutCaptionCellClass; virtual;
    function CreateCaptionCell(AReportLink: TBasedxReportLink): TdxReportCustomLayoutCaptionCell; virtual;
    function IsCaptionVisible: Boolean;
    function NeedCreateCaptionCell: Boolean; virtual;

    function GetFontIndex: Integer;

    property ItemBounds: TRect read GetItemBounds;
    property ViewInfo: TdxCustomLayoutItemViewInfo read GetViewInfo;
  public
    property Item: TdxCustomLayoutItem read GetItem;
    property CaptionItem: TdxReportCustomLayoutCaptionCell read FCaptionItem;
    property HasCaptionItem: Boolean read GetHasCaptionItem;
    property OnGetLayoutItemViewInfo: TdxLCGetLayoutItemViewInfoEvent read FOnGetLayoutItemViewInfo write FOnGetLayoutItemViewInfo;
  end;

  { TdxReportLayoutGroup }

  TdxReportLayoutGroup = class;

  TdxReportLayoutGroupCaptionTextCell = class(TdxReportLayoutCaptionTextCell)
  private
    FCaptionLayout: TdxCaptionLayout;
  public
    procedure DrawContent(ACanvas: TdxPSReportRenderCustomCanvas; AStage: TdxPSRenderStages); override;
    property CaptionLayout: TdxCaptionLayout read FCaptionLayout write FCaptionLayout;
  end;

  TdxReportLayoutGroupCaptionImageCell = class(TdxReportLayoutCaptionImageCell);

  TdxReportLayoutGroupCaptionCell = class(TdxReportCustomLayoutCaptionCell)
  private
    function GetGroup: TdxLayoutGroup;
  protected
    function CreateTextCell(AReportLink: TBasedxReportLink): TdxReportLayoutCaptionTextCell; override;
    function CreateImageCell(AReportLink: TBasedxReportLink): TdxReportCellImage; override;
    function GetReportLayoutCaptionImageCellClass: TdxReportLayoutCaptionImageCellClass; override;
    function GetReportLayoutCaptionTextCellClass: TdxReportLayoutCaptionTextCellClass; override;
  public
    property Group: TdxLayoutGroup read GetGroup;
  end;

  TdxPSReportLayoutGroupStandardLookAndFeel = class;

  TdxPSReportLayoutGroupStandardLookAndFeelPainter = class(TdxPSReportGroupStandardLookAndFeelPainter)
  protected
    procedure DrawCaptionText(ACanvas: TdxPSReportRenderCustomCanvas); override;
  public
    function LookAndFeel: TdxPSReportLayoutGroupStandardLookAndFeel; overload; virtual;
  end;

  TdxPSReportLayoutGroupStandardLookAndFeel = class(TdxPSReportGroupStandardLookAndFeel)
  protected
    function GetBorderEdgeThickness(AGroup: TdxReportGroup; ASide: TdxCellSide): Integer; override;
    function GetCaptionHeight(AGroup: TdxReportGroup): Integer; override;
    function GetCaptionTextBounds(AGroup: TdxReportGroup): TRect; override;
    class function GetPainterClass: TdxPSReportGroupLookAndFeelPainterClass; override;
  end;

  TdxPSReportLayoutGroupWebLookAndFeel = class(TdxPSReportGroupWebLookAndFeel)
  protected
    function GetCaptionBounds(AGroup: TdxReportGroup): TRect; override;
  end;

  TdxPSReportLayoutGroupOfficeLookAndFeel = class(TdxPSReportLayoutGroupStandardLookAndFeel)
  protected
    function GetBorderSides(AGroup: TdxReportGroup): TdxCellSides; override;
    function GetCaptionIndent: Integer; override;
  public
    class function DefaultBorderSides: TdxCellSides; override;
    class function Name: string; override;
  end;

  TdxReportLayoutGroup = class(TdxCustomReportLayoutItem)
  private
    function GetGroup: TdxLayoutGroup;
  protected
    procedure AdjustBorderOuterBounds(var R: TRect); override;
    function GetCaptionCellClass: TdxReportCustomLayoutCaptionCellClass; override;

    function GetCaptionSide: TdxCellSide;
  public
    property Group: TdxLayoutGroup read GetGroup;
  end;

  TdxReportLayoutBasicItem = class(TdxCustomReportLayoutItem);

  TdxReportLayoutNonLabeledItem = class(TdxCustomReportLayoutItem)
  protected
    function NeedCreateCaptionCell: Boolean; override;
  end;

  TdxReportLayoutEmptySpaceItem = class(TdxReportLayoutNonLabeledItem);

  TdxReportLayoutDirectionalItem = class(TdxReportLayoutNonLabeledItem)
  private
    FSeparatorItem: TdxReportCell;
    function GetHasSeparatorItem: Boolean;
    function GetLayoutItem: TdxLayoutDirectionalItem;
    function GetSeparatorBounds: TRect;
  protected
    procedure AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas); override;
    procedure Initialize(AReportLink: TBasedxReportLink); override;
    function NeedCreateCaptionCell: Boolean; override;
    function CreateSeparatorCell(AReportLink: TBasedxReportLink): TdxReportCell; virtual;

    property SeparatorBounds: TRect read GetSeparatorBounds;
  public
    property LayoutItem: TdxLayoutDirectionalItem read GetLayoutItem;
    property SeparatorItem: TdxReportCell read FSeparatorItem;
    property HasSeparatorItem: Boolean read GetHasSeparatorItem;
  end;

  TdxReportLayoutSeparatorItem = class(TdxReportLayoutDirectionalItem);
  TdxReportLayoutSplitterItem = class(TdxReportLayoutDirectionalItem);

  { TdxReportLayoutLabeledItem }

  TdxReportLayoutLabeledItemCaptionCell = class(TdxReportCustomLayoutCaptionCell)
  private
    function GetCaptionOptions: TdxLayoutLabeledItemCustomCaptionOptions;
  protected
    function CreateTextCell(AReportLink: TBasedxReportLink): TdxReportLayoutCaptionTextCell; override;

    property CaptionOptions: TdxLayoutLabeledItemCustomCaptionOptions read GetCaptionOptions;
  end;

  TdxReportLayoutLabeledItem = class(TdxReportLayoutBasicItem)
  private
    function GetLayoutItem: TdxLayoutCustomLabeledItem;
  protected
    function GetCaptionCellClass: TdxReportCustomLayoutCaptionCellClass; override;
  public
    property LayoutItem: TdxLayoutCustomLabeledItem read GetLayoutItem;
  end;

  TdxReportLayoutItem = class(TdxReportLayoutLabeledItem)
  private
    FControlItem: TdxReportVisualItem;
    function GetAdapter: TdxCustomLayoutControlAdapter;
    function GetControl: TControl;
    function GetControlBounds: TRect;
    function GetHasControlItem: Boolean;
    function GetIsControlAccessible: Boolean;
    function GetViewInfo: TdxLayoutItemViewInfo;
  protected
    procedure AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas); override;
    procedure Initialize(AReportLink: TBasedxReportLink); override;

    function CreateControlCell(AReportLink: TdxLayoutControlReportLink): TdxReportVisualItem; virtual;
    function NeedCreateControlCell: Boolean; virtual;

    property Adapter: TdxCustomLayoutControlAdapter read GetAdapter;
    property ControlBounds: TRect read GetControlBounds;
    property IsControlAccessible: Boolean read GetIsControlAccessible;
  public
    function LayoutItem: TdxLayoutItem;

    property Control: TControl read GetControl;
    property ControlItem: TdxReportVisualItem read FControlItem;
    property HasControlItem: Boolean read GetHasControlItem;
    property ViewInfo: TdxLayoutItemViewInfo read GetViewInfo;
  end;

  { Definitions }

  TdxPSCustomLayoutItemDefinition = class(TdxPSCustomContainerItemDefinition)
  private
    function GetLayoutItem: TdxCustomLayoutItem;
    function GetReportItem: TdxCustomReportLayoutItem;
    procedure SetLayoutItem(Value: TdxCustomLayoutItem);
  protected
    procedure AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas); virtual;
    procedure SaveOriginalItemSize; virtual;
    procedure SetupOriginalControlSize; virtual;
  public
    function OptionsPagination: TdxLayoutControlReportLinkOptionsPagination; reintroduce; overload;
    property LayoutItem: TdxCustomLayoutItem read GetLayoutItem write SetLayoutItem;
    property ReportItem: TdxCustomReportLayoutItem read GetReportItem;
  end;
  
  TdxPSLayoutGroupDefinition = class(TdxPSCustomLayoutItemDefinition)
  private
    function GetLayoutItem: TdxLayoutGroup;
  protected
    procedure AddDelimitersHorz(AList: TList); override;
    procedure AddDelimitersVert(AList: TList); override;
  public
    property LayoutItem: TdxLayoutGroup read GetLayoutItem;
  end;

  TdxPSLayoutBasicItemDefinition = class(TdxPSCustomLayoutItemDefinition)
  protected
    procedure AddDelimitersHorz(AList: TList); override;
    procedure AddDelimitersVert(AList: TList); override;
  end;

  TdxPSLayoutLabeledItemDefinition = class(TdxPSLayoutBasicItemDefinition);

  TdxPSLayoutItemDefinition = class(TdxPSLayoutLabeledItemDefinition)
  private
    function GetLayoutItem: TdxLayoutItem;
    function GetReportItem: TdxReportLayoutItem;
  protected
    procedure SaveOriginalItemSize; override;
    procedure SetupOriginalControlSize; override;
  public
    constructor Create(AReportLink: TdxCustomContainerReportLink; AComponent: TComponent; AReportItem: TdxReportVisualItem); override;

    property LayoutItem: TdxLayoutItem read GetLayoutItem;
    property ReportItem: TdxReportLayoutItem read GetReportItem;
  end;
  
  { Producers }
    
  TdxPSLayoutControlObjectProducer = class(TdxPSCustomProducer)
  public
    function ReportLink: TdxLayoutControlReportLink; reintroduce; overload;
    function RootContainer: TdxLayoutControl; reintroduce; overload;
  end;

  TdxPSLayoutLookAndFeelProducerClass = class of TdxPSLayoutLookAndFeelProducer;

  TdxPSLayoutLookAndFeelProducer = class(TdxPSLayoutControlObjectProducer)
  protected
    function GetContentColor: TColor; virtual;
    function GetGroupCaptionColor: TColor; virtual;
    function GetIsContentTransparent: Boolean; virtual;
    function GetIsGroupCaptionTransparent: Boolean; virtual;
    function GetTransparentColor: TColor; virtual;

    procedure InitializeReportLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel); virtual;
    class function ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass; virtual;

    property GroupCaptionColor: TColor read GetGroupCaptionColor;
    property IsGroupCaptionTransparent: Boolean read GetIsGroupCaptionTransparent;
  public
    function LayoutLookAndFeel: TdxCustomLayoutLookAndFeel; overload; virtual;
    class function LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass; virtual;

    class function PairClass: TClass; override;
    class procedure Register; override;
    class procedure Unregister; override;

    property ContentColor: TColor read GetContentColor;
    property IsContentTransparent: Boolean read GetIsContentTransparent;
    property TransparentColor: TColor read GetTransparentColor;
  end;

  TdxPSLayoutStandardLookAndFeelProducer = class(TdxPSLayoutLookAndFeelProducer)
  protected
    function GetTransparentColor: TColor; override;
    class function ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass; override;
  public
    function LayoutLookAndFeel: TdxLayoutStandardLookAndFeel; reintroduce; overload;
    class function LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass; override;
  end;

  TdxPSLayoutOfficeLookAndFeelProducer = class(TdxPSLayoutStandardLookAndFeelProducer)
  protected
    class function ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass; override;
  public
    function LayoutLookAndFeel: TdxLayoutOfficeLookAndFeel; reintroduce; overload;
    class function LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass; override;
  end;

  TdxPSLayoutWebLookAndFeelProducer = class(TdxPSLayoutLookAndFeelProducer)
  protected
    function GetGroupCaptionColor: TColor; override;
    function GetTransparentColor: TColor; override;
    procedure InitializeReportLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel); override;
    class function ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass; override;
  public
    function LayoutLookAndFeel: TdxLayoutWebLookAndFeel; reintroduce; overload;
    class function LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass; override;

    property GroupCaptionColor;
    property IsGroupCaptionTransparent;
  end;

  TdxPSCustomLayoutItemProducerClass = class of TdxPSCustomLayoutItemProducer;

  TdxPSCustomLayoutItemProducer = class(TdxPSLayoutControlObjectProducer)
  private
    function GetLayoutItemBounds: TRect;
  protected
    function GetContentColor: TColor; virtual;
    function GetIsContentTransparent: Boolean; virtual;
    function GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel; virtual;
    function GetLayoutLookAndFeelProducer: TdxPSLayoutLookAndFeelProducer;

    procedure InitializeReportItem(AnItem: TdxReportCell); virtual;
    class function ReportItemClass: TdxReportCellClass; virtual;

    function OptionsTransparent: TdxLayoutControlReportLinkOptionsTransparent; reintroduce; overload;

    procedure AdjustBounds; virtual;
    procedure SaveOriginalItemSize;
  public
    function Definition: TdxPSCustomLayoutItemDefinition; reintroduce; overload;
    class function DefinitionClass: TdxPSCustomContainerItemDefinitionClass; override;

    function LayoutItem: TdxCustomLayoutItem;
    class function LayoutItemClass: TdxCustomLayoutItemClass; virtual;

    class function PairClass: TClass; override;
    function ProducingObjectFriendlyName: string; override;
    procedure Reposition; override;

    class procedure Register; override;
    class procedure Unregister; override;

    property ContentColor: TColor read GetContentColor;
    property IsContentTransparent: Boolean read GetIsContentTransparent;
    property LayoutItemBounds: TRect read GetLayoutItemBounds;
    property LayoutLookAndFeel: TdxCustomLayoutLookAndFeel read GetLayoutLookAndFeel;
    property LayoutLookAndFeelProducer: TdxPSLayoutLookAndFeelProducer read GetLayoutLookAndFeelProducer;
  end;

  TdxPSLayoutGroupProducer = class(TdxPSCustomLayoutItemProducer)
  protected
    function GetGroupCaptionContentColor: TColor; virtual;
    function GetIsGroupCaptionTransparent: Boolean; virtual;
    procedure InitializeReportItem(AnItem: TdxReportCell); override;
    class function ReportItemClass: TdxReportCellClass; override;
  public
    function Definition: TdxPSLayoutGroupDefinition; reintroduce; overload;
    class function DefinitionClass: TdxPSCustomContainerItemDefinitionClass; override;

    function LayoutItem: TdxLayoutGroup;
    class function LayoutItemClass: TdxCustomLayoutItemClass; override;

    function ProducingObjectFriendlyName: string; override;
    procedure Reposition; override;

    property GroupCaptionContentColor: TColor read GetGroupCaptionContentColor;
    property IsGroupCaptionTransparent: Boolean read GetIsGroupCaptionTransparent;
  end;

  TdxPSLayoutBasicItemProducer = class(TdxPSCustomLayoutItemProducer)
  protected
    function GetContentColor: TColor; override;
    procedure InitializeReportItem(AnItem: TdxReportCell); override;
    class function ReportItemClass: TdxReportCellClass; override;
  public
    class function DefinitionClass: TdxPSCustomContainerItemDefinitionClass; override;
    class function LayoutItemClass: TdxCustomLayoutItemClass; override;
  end;

  TdxPSLayoutEmptySpaceItemProducer = class(TdxPSLayoutBasicItemProducer)
  public
    class function LayoutItemClass: TdxCustomLayoutItemClass; override;
  end;

  TdxPSLayoutDirectionalItemProducer = class(TdxPSLayoutBasicItemProducer);

  TdxPSLayoutSeparatorItemProducer = class(TdxPSLayoutDirectionalItemProducer)
  protected
    class function ReportItemClass: TdxReportCellClass; override;
  public
    class function LayoutItemClass: TdxCustomLayoutItemClass; override;
  end;

  TdxPSLayoutSplitterItemProducer = class(TdxPSLayoutDirectionalItemProducer)
  protected
    class function ReportItemClass: TdxReportCellClass; override;
  public
    class function LayoutItemClass: TdxCustomLayoutItemClass; override;
  end;

  TdxPSLayoutCustomLabeledItemProducer = class(TdxPSLayoutBasicItemProducer);

  TdxPSLayoutLabeledItemProducer = class(TdxPSLayoutCustomLabeledItemProducer)
  protected
    class function ReportItemClass: TdxReportCellClass; override;
  public
    class function DefinitionClass: TdxPSCustomContainerItemDefinitionClass; override;

    function LayoutItem: TdxLayoutLabeledItem;
    class function LayoutItemClass: TdxCustomLayoutItemClass; override;
  end;

  TdxPSLayoutItemProducer = class(TdxPSLayoutCustomLabeledItemProducer)
  private
    function GetControl: TControl;
    function GetHasControl: Boolean;
  protected
    class function ReportItemClass: TdxReportCellClass; override;
  public
    constructor Create(AReportLink: TdxCustomContainerReportLink; AnObject: TComponent); override;

    function Definition: TdxPSLayoutItemDefinition; reintroduce; overload;
    class function DefinitionClass: TdxPSCustomContainerItemDefinitionClass; override;

    function LayoutItem: TdxLayoutItem;
    class function LayoutItemClass: TdxCustomLayoutItemClass; override;

    function ProducingObjectFriendlyName: string; override;
    procedure Reposition; override;

    property Control: TControl read GetControl;
    property HasControl: Boolean read GetHasControl;
  end;

  { Caches }

  TdxPSCustomLayoutObjectProducerCache = class(TdxPSContainerReportLinkCustomCache)
  public
    function ReportLink: TdxLayoutControlReportLink; reintroduce; overload;
  end;

  TdxPSLayoutItemProducerCache = class(TdxPSCustomLayoutObjectProducerCache)
  private
    function GetItem(Index: Integer): TdxPSCustomLayoutItemProducer;
    function GetProducer(AProducerClass: TdxPSCustomLayoutItemProducerClass;
      ALayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
  protected
    property Items[Index: Integer]: TdxPSCustomLayoutItemProducer read GetItem;
  public
    property Producers[AProducerClass: TdxPSCustomLayoutItemProducerClass;
      ALayoutItem: TdxCustomLayoutItem]: TdxPSCustomLayoutItemProducer read GetProducer; default;
  end;

  TdxPSLayoutLookAndFeelProducerCache = class(TdxPSCustomLayoutObjectProducerCache)
  private
    function GetItem(Index: Integer): TdxPSLayoutLookAndFeelProducer;
    function GetProducer(AProducerClass: TdxPSLayoutLookAndFeelProducerClass;
      ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducer;
  protected
    property Items[Index: Integer]: TdxPSLayoutLookAndFeelProducer read GetItem;
  public
    property Producers[AProducerClass: TdxPSLayoutLookAndFeelProducerClass;
      ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel]: TdxPSLayoutLookAndFeelProducer read GetProducer; default;
  end;

  TdxPSNativeLayoutControlProducer = class(TdxPSNativePrintableControlProducer)
  public
    function Control: TdxCustomLayoutControl; reintroduce; overload;
    class function ControlClass: TControlClass; override;

    class function HasNativeSupportForBorders: Boolean; override;

    function ObjectExpandHeight: Boolean; override;
    function ObjectExpandWidth: Boolean; override;
  end;

  TdxPSLayoutControlProducer = class(TdxPSRootContainerProducer)
  private
    function GetAvailableBounds: TRect;
    function GetProducer(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
  protected
    procedure CreateLayoutItems(AnItem: TdxReportVisualItem); virtual;
    procedure GetLayoutItemList(AnItems: TList);
    function HostClass: TdxReportCellClass; override;
    procedure InitializeHost(ACell: TdxReportCell); override;
    procedure InitializeItem(AnItem: TdxReportVisualItem); override;
    function ItemClass: TdxReportVisualItemClass; override;
    procedure ReportLinkInitializeItem(AnItem: TdxReportVisualItem);

    property AvailableBounds: TRect read GetAvailableBounds;
    property Producers[LayoutItem: TdxCustomLayoutItem]: TdxPSCustomLayoutItemProducer read GetProducer;
  public
    class function CanHasAvailableChildren: Boolean; override;
    class function Reenterable: Boolean; override;

    function Control: TdxLayoutControl; reintroduce; overload;
    class function ControlClass: TControlClass; override;

    class function HasNativeSupportForBorders: Boolean; override;

    function ObjectExpandHeight: Boolean; override;
    function ObjectExpandWidth: Boolean; override;

    function ReportLink: TdxLayoutControlReportLink; reintroduce; overload;
    procedure Reposition; override;
  end;

  PdxPSLayoutCacheFontItem = ^TdxPSLayoutCacheFontItem;
  TdxPSLayoutCacheFontItem = record
    CaptionOptions: TdxLayoutLookAndFeelCaptionOptions;
    FontIndex: Integer;
  end;

  { Options }

  TdxLayoutControlReportLinkOptionsBehaviorClass = class of TdxLayoutControlReportLinkOptionsBehavior;

  TdxLayoutControlReportLinkOptionsBehavior = class(TdxCustomContainerReportLinkOptionsPagination)
  private
    FActiveTabToTop: Boolean;
    FExpandGroups: Boolean;
    FSkipEmptyGroups: Boolean;
    FUnwrapTabs: Boolean;
    procedure SetActiveTabToTop(Value: Boolean);
    procedure SetExpandGroups(Value: Boolean);
    procedure SetSkipEmptyGroups(Value: Boolean);
    procedure SetUnwrapTabs(Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property ActiveTabToTop: Boolean read FActiveTabToTop write SetActiveTabToTop default True;
    property ExpandGroups: Boolean read FExpandGroups write SetExpandGroups default True;
    property SkipEmptyGroups: Boolean read FSkipEmptyGroups write SetSkipEmptyGroups default True;
    property UnwrapTabs: Boolean read FUnwrapTabs write SetUnwrapTabs default False;
  end;

  TdxLayoutControlReportLinkOptionsPaginationClass = class of TdxLayoutControlReportLinkOptionsPagination;

  TdxLayoutControlReportLinkOptionsPagination = class(TdxCustomContainerReportLinkOptionsPagination)
  private
    FGroups: Boolean;
    FItems: Boolean;
    procedure SetGroups(Value: Boolean);
    procedure SetItems(Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property Groups: Boolean read FGroups write SetGroups default True;
    property Items: Boolean read FItems write SetItems default True;
  end;

  TdxLayoutControlReportLinkOptionsSizeClass = class of TdxLayoutControlReportLinkOptionsSize;

  TdxLayoutControlReportLinkOptionsSize = class(TdxCustomContainerReportLinkOptions)
  private
    FAutoWidth: Boolean;
    procedure SetAutoWidth(Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property AutoWidth: Boolean read FAutoWidth write SetAutoWidth default True;
  end;

  TdxLayoutControlReportLinkOptionsTransparent = class(TdxCustomContainerReportLinkOptionsTransparent)
  private
    FGroups: Boolean;
    FItems: Boolean;
    procedure SetGroups(Value: Boolean);
    procedure SetItems(Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property Groups: Boolean read FGroups write SetGroups default True;
    property Items: Boolean read FItems write SetItems default True;
  end;

  { Report Link }

  TdxLayoutControlReportLink = class(TdxCustomContainerReportLink, IUnknown, IdxReportLinkController)
  private
    FCachedBounds: TList;
    FCachedFonts: TList;
    FCurrentLayoutItem: TdxCustomLayoutItem;
    FLayoutItemProducerCache: TdxPSLayoutItemProducerCache;
    FLayoutLookAndFeelProducerCache: TdxPSLayoutLookAndFeelProducerCache;
    FOptionsBehavior: TdxLayoutControlReportLinkOptionsBehavior;
    FOptionsSize: TdxLayoutControlReportLinkOptionsSize;
    function GetAvailableBounds: TRect;
    function GetCachedBoundsCount: Integer;
    function GetCachedBoundsItem(Index: Integer): TdxLCBoundsCacheItem;
    function GetCachedFontItem(Index: Integer): PdxPSLayoutCacheFontItem;
    function GetCachedFontItemCount: Integer;
    function GetCurrentHost: TdxReportCell;
    function GetLayoutControl: TdxLayoutControl;
    function GetLayoutItemProducer(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
    function GetLayoutLookAndFeelProducer(LayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducer;
    function GetOptionsPagination: TdxLayoutControlReportLinkOptionsPagination;
    function GetOptionsTransparent: TdxLayoutControlReportLinkOptionsTransparent;
    function GetRootLayoutGroup: TdxLayoutGroup;
    procedure SetOptionsBehavior(Value: TdxLayoutControlReportLinkOptionsBehavior);
    procedure SetOptionsPagination(Value: TdxLayoutControlReportLinkOptionsPagination);
    procedure SetOptionsSize(Value: TdxLayoutControlReportLinkOptionsSize);
    procedure SetOptionsTransparent(Value: TdxLayoutControlReportLinkOptionsTransparent);
  protected
    function DoIsComponentProcessed(AComponent: TComponent): Boolean; override;
    function GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean; override;
    procedure InternalRestoreDefaults; override;

    procedure CacheControlsBounds;
    procedure ConstructReport(AReportCells: TdxReportCells); override;
    procedure PostCheckEmbeddedControls;
    procedure PrepareConstruct; override;
    procedure PrepareLookAndFeels;
    procedure RepositionControls; override;

    procedure AddHiddenItem(ATreeView: TTreeView; AParent: TTreeNode; AnItem: TdxCustomLayoutItem);
    procedure AddItem(ATreeView: TTreeView; AParent: TTreeNode; AnItem: TdxCustomLayoutItem);
    function IsComponentEditable(AComponent: TComponent): Boolean; override;
    procedure LoadControlsTree(ATreeView: TTreeView); override;
    procedure LoadHiddenControlsTree(ATreeView: TTreeView); override;
    function AddBoundsToCache(AComponent: TComponent; const ABounds: TRect): Integer;
    function AddCaptionOptionsFontToCache(ACaptionOptions: TdxLayoutLookAndFeelCaptionOptions): Integer;
    procedure ClearCachedBounds;
    procedure ClearCachedFonts;
    function FindBoundsByComponent(AComponent: TComponent; var ABounds: TRect; ASetEmbedded: Boolean): Boolean;
    function FindFontIndexByCaptionOptions(ACaptionOptions: TdxLayoutLookAndFeelCaptionOptions): Integer;
    procedure FreeAndNilCachedBounds;
    procedure FreeAndNilCachedFonts;

    procedure CreateOptions; override;
    procedure DestroyOptions; override;
    function GetOptionsPaginationClass: TdxCustomContainerReportLinkOptionsPaginationClass; override;
    function GetOptionsSizeClass: TdxLayoutControlReportLinkOptionsSizeClass; virtual;
    function GetOptionsTransparentClass: TdxCustomContainerReportLinkOptionsTransparentClass; override;

    function FindReportGroupLookAndFeel(ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSReportGroupLookAndFeel;
    function FindReportItemByLayoutItem(ALayoutItem: TdxCustomLayoutItem): TdxReportCell;
    procedure GetLayoutItemList(AControl: TdxLayoutControl; AnItems: TList);
    // IdxReportLinkController
    function GetControlSiteBounds(AControl: TControl): TRect; override;

    procedure AdjustLayoutBounds(const R: TRect);

    property AvailableBounds: TRect read GetAvailableBounds;
    property CachedBoundsCount: Integer read GetCachedBoundsCount;
    property CachedBoundsItem[Index: Integer]: TdxLCBoundsCacheItem read GetCachedBoundsItem;
    property CachedBounds: TList read FCachedBounds;

    property CachedFontItemCount: Integer read GetCachedFontItemCount;
    property CachedFontItems[Index: Integer]: PdxPSLayoutCacheFontItem read GetCachedFontItem;
    property CachedFonts: TList read FCachedFonts;

    property CurrentHost: TdxReportCell read GetCurrentHost;
    property CurrentLayoutItem: TdxCustomLayoutItem read FCurrentLayoutItem Write FCurrentLayoutItem;
    property LayoutItemProducerCache: TdxPSLayoutItemProducerCache read FLayoutItemProducerCache;
    property LayoutItemProducers[LayoutItem: TdxCustomLayoutItem]: TdxPSCustomLayoutItemProducer read GetLayoutItemProducer;
    property LayoutLookAndFeelProducerCache: TdxPSLayoutLookAndFeelProducerCache read FLayoutLookAndFeelProducerCache;
    property LayoutLookAndFeelProducers[LayoutLookAndFeel: TdxCustomLayoutLookAndFeel]: TdxPSLayoutLookAndFeelProducer read GetLayoutLookAndFeelProducer;
    property RootLayoutGroup: TdxLayoutGroup read GetRootLayoutGroup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    class function Aggregable: Boolean; override;

    property LayoutControl: TdxLayoutControl read GetLayoutControl;
  published
    property OptionsBehavior: TdxLayoutControlReportLinkOptionsBehavior read FOptionsBehavior write SetOptionsBehavior;
    property OptionsPagination: TdxLayoutControlReportLinkOptionsPagination read GetOptionsPagination write SetOptionsPagination;
    property OptionsSize: TdxLayoutControlReportLinkOptionsSize read FOptionsSize write SetOptionsSize;
    property OptionsTransparent: TdxLayoutControlReportLinkOptionsTransparent read GetOptionsTransparent write SetOptionsTransparent;
  end;

  { Design Window }

  TdxPSLayoutControlDesignWindow = class(TdxfmCustomContainerDesignWindow)
  private
    function GetLayoutReportLink: TdxLayoutControlReportLink;
  protected
    procedure DoInitialize; override;

    procedure SetOptionsGroupsByIndex(AnIndex: Integer; AValue: Boolean); override;
    procedure SetOptionsPaginationByIndex(AnIndex: Integer; AValue: Boolean); override;
    procedure SetOptionsSizeByIndex(AnIndex: Integer; AValue: Boolean); override;
    procedure SetOptionsTabsByIndex(AnIndex: Integer; AValue: Boolean); override;
    procedure SetOptionsTransparentByIndex(AnIndex: Integer; AValue: Boolean); override;

    procedure InitializeControlsTree; override;
    procedure InitializeHiddenControlsTree; override;
    function IsBoldNode(ANode: TTreeNode): Boolean; override;
  public
    property LayoutReportLink: TdxLayoutControlReportLink read GetLayoutReportLink;
  end;

implementation

uses
  Variants, Messages, SysUtils, StdCtrls, Forms, cxClasses, dxPSGlbl, dxPSRes,
  dxPSUtl, dxLayoutControlAdapters, cxControls, ImgList, Types;

const
  LayoutBorderStyleMap: array[TdxLayoutBorderStyle] of TdxPSCellBorderClass =
    (TdxPSCellNullBorder, TdxPSCellUltraFlatBorder, TdxPSCellSunkenSoftBorder, TdxPSCellSunkenBorder);
  LayoutCaptionAlignHorzMap: array[TAlignment] of TcxTextAlignX = (taLeft, taRight, taCenterX);
  LayoutCaptionAlignVertMap: array[TdxAlignmentVert] of TcxTextAlignY = (taTop, taCenterY, taBottom);
  LayoutGroupCaptionAlignHorzMap: array[TAlignment] of TcxTextAlignX = (taLeft, taRight, taCenterX);

type
  TcxControlAccess = class(TcxControl);
  TdxLayoutControlAccess = class(TdxLayoutControl);
  TdxLayoutContainerAccess = class(TdxLayoutContainer);
  TdxCustomContainerReportLinkAccess = class(TdxCustomContainerReportLink);
  TdxCustomLayoutControlAccess = class(TdxCustomLayoutControl);
  TdxLayoutCustomLabeledItemAccess = class(TdxLayoutCustomLabeledItem);
  TdxCustomLayoutItemAccess = class(TdxCustomLayoutItem);
  TdxCustomLayoutLookAndFeelAccess = class(TdxCustomLayoutLookAndFeel);
  TdxLayoutControlViewInfoAccess = class(TdxLayoutControlViewInfo);
  TdxLayoutItemAccess = class(TdxLayoutItem);
  TdxCustomLayoutItemViewInfoAccess = class(TdxCustomLayoutItemViewInfo);
  TdxCustomLayoutItemCaptionViewInfoAccess = class(TdxCustomLayoutItemCaptionViewInfo);
  TdxCustomLayoutItemCaptionOptionsAccess = class(TdxCustomLayoutItemCaptionOptions);
  TdxCustomLayoutItemImageOptionsAccess = class(TdxCustomLayoutItemImageOptions);
  TdxPSReportGroupLookAndFeelAccess = class(TdxPSReportGroupLookAndFeel);

var
  FPreparationFont: TFont;

function dxGetPreparedFontIndex(ACaptionOptions: TdxLayoutLookAndFeelCaptionOptions; AReportLink: TBasedxReportLink; AFontHelper: IdxLayoutFontHelper): Integer;
begin
  with FPreparationFont do
  begin
    Assign(ACaptionOptions.GetFont(AFontHelper));
    Color := ACaptionOptions.GetTextColor;
    if ACaptionOptions.HotTrack and (htsUnderlineCold in ACaptionOptions.HotTrackStyles) then
      Style := Style + [fsUnderline];
    if not dxIsTrueTypeFont(FPreparationFont) then
      Name := AFontHelper.GetDefaultFont.Name;
  end;
  Result := AReportLink.AddFontToPool(FPreparationFont);
end;

{ Helpers }

function GetLayoutItemRelativeBounds(ALayoutItemViewInfo: TdxCustomLayoutItemViewInfo): TRect;

  function GetLayoutContainerViewInfo: TdxLayoutContainerViewInfo;
  begin
    Result := ALayoutItemViewInfo.ContainerViewInfo;
  end;

  function GetScrollLeft: Integer;
  begin
    Result := GetLayoutContainerViewInfo.GetScrollOffset.X;
  end;

  function GetScrollTop: Integer;
  begin
    Result := GetLayoutContainerViewInfo.GetScrollOffset.Y;
  end;

  function GetParentLeft: Integer;
  begin
    Result := ALayoutItemViewInfo.ParentViewInfo.Bounds.Left;
  end;

  function GetParentTop: Integer;
  begin
    Result := ALayoutItemViewInfo.ParentViewInfo.Bounds.Top;
  end;

  function IsRoot(AViewInfo: TdxCustomLayoutItemViewInfo): Boolean;
  begin
    Result := TdxCustomLayoutItemViewInfoAccess(AViewInfo).Item.IsRoot;
  end;

begin
  if ALayoutItemViewInfo <> nil then
  begin
    Result := ALayoutItemViewInfo.Bounds;
    if IsRoot(ALayoutItemViewInfo) or IsRoot(ALayoutItemViewInfo.ParentViewInfo) then
      OffsetRect(Result, GetScrollLeft, GetScrollTop)
    else
      OffsetRect(Result, -GetParentLeft, -GetParentTop);
  end
  else
    Result := cxNullRect;
end;

{ Factories }

type
  TdxPSLayoutItemProducerFactory = class(TdxCustomClassMaps)
  private
    function GetProducerClass(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducerClass;
  public
    class function Instance: TdxPSLayoutItemProducerFactory; reintroduce; overload;
    property ProducerClasses[LayoutItem: TdxCustomLayoutItem]: TdxPSCustomLayoutItemProducerClass read GetProducerClass; default;
  end;

  TdxPSLayoutLookAndFeelProducerFactory = class(TdxCustomClassMaps)
  private
    function GetProducerClass(LayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducerClass;
  public
    class function Instance: TdxPSLayoutLookAndFeelProducerFactory; reintroduce; overload;
    property ProducerClasses[LayoutLookAndFeel: TdxCustomLayoutLookAndFeel]: TdxPSLayoutLookAndFeelProducerClass read GetProducerClass; default;
  end;

{ TdxPSLayoutItemProducerFactory }

function dxPSLayoutItemProducerFactory: TdxPSLayoutItemProducerFactory;
begin
  Result := TdxPSLayoutItemProducerFactory.Instance;
end;

class function TdxPSLayoutItemProducerFactory.Instance: TdxPSLayoutItemProducerFactory;
begin
  Result := inherited Instance as TdxPSLayoutItemProducerFactory;
end;

function TdxPSLayoutItemProducerFactory.GetProducerClass(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducerClass;
begin
  Result := TdxPSCustomLayoutItemProducerClass(PairClasses[LayoutItem.ClassType]);
end;

{ TdxPSLayoutLookAndFeelProducerFactory }

function dxPSLayoutLookAndFeelProducerFactory: TdxPSLayoutLookAndFeelProducerFactory;
begin
  Result := TdxPSLayoutLookAndFeelProducerFactory.Instance;
end;

class function TdxPSLayoutLookAndFeelProducerFactory.Instance: TdxPSLayoutLookAndFeelProducerFactory;
begin
  Result := inherited Instance as TdxPSLayoutLookAndFeelProducerFactory;
end;

function TdxPSLayoutLookAndFeelProducerFactory.GetProducerClass(LayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducerClass;
begin
  Result := TdxPSLayoutLookAndFeelProducerClass(PairClasses[LayoutLookAndFeel.ClassType]);
end;

{ TdxReportLayoutControlHost }

function TdxReportLayoutControlHost.GetControlItem: TdxReportVisualItem;
begin
  if CellCount <> 0 then
    Result := Cells[0]
  else
    Result := nil;
end;

{ TdxReportCaptionTextCell }

function TdxReportLayoutCaptionTextCell.GetDefaultDTFormat: DWORD;
begin
  Result := inherited GetDefaultDTFormat;
  Result := Result and not CXTO_AUTOINDENTS;
end;

{ TdxReportCustomLayoutCaptionCell }

procedure TdxReportCustomLayoutCaptionCell.AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas);
begin
  BoundsRect := CaptionBounds;
  if HasTextItem then
    TextItem.BoundsRect := TextBounds;
  if HasImageItem then
    ImageItem.BoundsRect := ImageBounds;
end;

procedure TdxReportCustomLayoutCaptionCell.Initialize(AReportLink: TBasedxReportLink);
begin
  BoundsRect := CaptionBounds;
  Transparent := True;
  CellSides := [];
  FontIndex := Parent.FontIndex;
  if IsTextVisible then
    FTextItem := CreateTextCell(AReportLink);
  if IsImageVisible then
    FImageItem := CreateImageCell(AReportLink);
end;

function TdxReportCustomLayoutCaptionCell.CreateImageCell(AReportLink: TBasedxReportLink): TdxReportCellImage;
var
  ABitmap: TBitmap;
  AImageIndex: Integer;
  AImageList: TCustomImageList;
begin
  Result := GetReportLayoutCaptionImageCellClass.Create(Self);
  with Result do
  begin
    Transparent := True;
    BoundsRect := ImageBounds;
    CellSides := [];
    ImageLayout := ilImageCenterCenter;
    ImageTransparent := True;
    TdxCustomLayoutItemImageOptionsAccess(ImageOptions).GetCurrentImage(ABitmap, AImageList, AImageIndex);
    Image := ABitmap;
    ImageList := AImageList;
    ImageIndex := AImageIndex;
  end;
end;

function TdxReportCustomLayoutCaptionCell.CreateTextCell(AReportLink: TBasedxReportLink): TdxReportLayoutCaptionTextCell;
begin
  Result := GetReportLayoutCaptionTextCellClass.Create(Self);
  with Result do
  begin
    BoundsRect := TextBounds;
    CellSides := [];
    HidePrefix := True;
    Transparent := True;
    TextAlignX := LayoutCaptionAlignHorzMap[CaptionOptions.AlignHorz];
    Text := ViewInfo.CaptionViewInfo.Text;
    HidePrefix := True;
    Multiline := False;
    TextAlignY := taTop;
    FontIndex := Parent.FontIndex;
  end;
end;

function TdxReportCustomLayoutCaptionCell.GetReportLayoutCaptionImageCellClass: TdxReportLayoutCaptionImageCellClass;
begin
  Result := TdxReportLayoutCaptionImageCell;
end;

function TdxReportCustomLayoutCaptionCell.GetReportLayoutCaptionTextCellClass: TdxReportLayoutCaptionTextCellClass;
begin
  Result := TdxReportLayoutCaptionTextCell;
end;

function TdxReportCustomLayoutCaptionCell.IsImageVisible: Boolean;
begin
  Result := ViewInfo.CaptionViewInfo.IsImageVisible;
end;

function TdxReportCustomLayoutCaptionCell.IsTextVisible: Boolean;
begin
  Result := ViewInfo.CaptionViewInfo.IsTextVisible;
end;

function TdxReportCustomLayoutCaptionCell.GetViewInfo: TdxCustomLayoutItemViewInfo;
begin
  Result := (Parent as TdxCustomReportLayoutItem).ViewInfo;
end;

function TdxReportCustomLayoutCaptionCell.GetItem: TdxCustomLayoutItem;
begin
  Result := (Parent as TdxCustomReportLayoutItem).Item;
end;

function TdxReportCustomLayoutCaptionCell.GetCaptionBounds: TRect;
begin
  Result := ViewInfo.CaptionViewInfo.Bounds;
  with ViewInfo.Bounds do
    OffsetRect(Result, -Left, -Top);
end;

function TdxReportCustomLayoutCaptionCell.GetCaptionOptions: TdxCustomLayoutItemCaptionOptions;
begin
  Result := Item.CaptionOptions;
end;

function TdxReportCustomLayoutCaptionCell.GetHasImageItem: Boolean;
begin
  Result := (ImageItem <> nil) and (IndexOf(ImageItem) > -1);
end;

function TdxReportCustomLayoutCaptionCell.GetHasTextItem: Boolean;
begin
  Result := (TextItem <> nil) and (IndexOf(TextItem) > -1);
end;

function TdxReportCustomLayoutCaptionCell.GetImageBounds: TRect;
begin
  Result := ViewInfo.CaptionViewInfo.ImageAreaBounds;
  with ViewInfo.CaptionViewInfo.Bounds do
    OffsetRect(Result, -Left, -Top);
end;

function TdxReportCustomLayoutCaptionCell.GetImageOptions: TdxCustomLayoutItemImageOptions;
begin
  Result := TdxCustomLayoutItemCaptionOptionsAccess(CaptionOptions).ImageOptions;
end;

function TdxReportCustomLayoutCaptionCell.GetTextBounds: TRect;
begin
  Result := ViewInfo.CaptionViewInfo.TextAreaBounds;
  with ViewInfo.CaptionViewInfo.Bounds do
    OffsetRect(Result, -Left, -Top);
end;

{ TdxCustomReportLayoutItem }

procedure TdxCustomReportLayoutItem.AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas);
begin
  BoundsRect := ItemBounds;
  if HasCaptionItem then
    CaptionItem.AdjustBounds(ACanvas);
end;

procedure TdxCustomReportLayoutItem.Initialize(AReportLink: TBasedxReportLink);
begin
  if NeedCreateCaptionCell then
  begin
    FontIndex := GetFontIndex;
    FCaptionItem := CreateCaptionCell(AReportLink);
  end;
end;

function TdxCustomReportLayoutItem.GetCaptionCellClass: TdxReportCustomLayoutCaptionCellClass;
begin
  Result := TdxReportCustomLayoutCaptionCell;
end;

function TdxCustomReportLayoutItem.CreateCaptionCell(AReportLink: TBasedxReportLink): TdxReportCustomLayoutCaptionCell;
begin
  Result := GetCaptionCellClass.Create(Self);
  Result.Initialize(AReportLink);
end;

function TdxCustomReportLayoutItem.IsCaptionVisible: Boolean;
begin
  Result := TdxCustomLayoutItemViewInfoAccess(ViewInfo).HasCaption;
end;

function TdxCustomReportLayoutItem.NeedCreateCaptionCell: Boolean;
begin
  Result := IsCaptionVisible;
end;

function TdxCustomReportLayoutItem.GetFontIndex: Integer;
begin
  if FontIndex = 0 then
    Result := dxGetPreparedFontIndex(ViewInfo.CaptionViewInfo.Options, ReportLink, Item.Container.ILayoutFontHelper)
  else
    Result := FontIndex; 
end;

function TdxCustomReportLayoutItem.GetHasCaptionItem: Boolean;
begin
  Result := (CaptionItem <> nil) and (IndexOf(CaptionItem) > -1);
end;

function TdxCustomReportLayoutItem.GetItem: TdxCustomLayoutItem;
begin
  Result := TdxCustomLayoutItem(Data);
end;

function TdxCustomReportLayoutItem.GetItemBounds: TRect;
begin
  Result := GetLayoutItemRelativeBounds(ViewInfo);
end;

function TdxCustomReportLayoutItem.GetViewInfo: TdxCustomLayoutItemViewInfo;
begin
  Result := Item.ViewInfo;
  if Assigned(OnGetLayoutItemViewInfo) then
    OnGetLayoutItemViewInfo(Item, Result);
end;

{ TdxReportLayoutGroupCaptionTextCell }

procedure TdxReportLayoutGroupCaptionTextCell.DrawContent(ACanvas: TdxPSReportRenderCustomCanvas; AStage: TdxPSRenderStages);

  function IsVertical: Boolean;
  begin
    Result := CaptionLayout in [clLeft, clRight];
  end;

  function GetDirection: TcxVerticalTextOutDirection;
  begin
    if CaptionLayout = clLeft then
      Result := vtdBottomToTop
    else
      Result := vtdTopToBottom;
  end;

begin
  if IsVertical then
  begin
    DrawBackground(ACanvas);
    if IsTextDrawn then
      ACanvas.RotatedTextOut(BoundsRect, Text, Font, TextAlignX, TextAlignY, False, GetDirection);
  end
  else
    inherited;
end;

{ TdxReportLayoutGroupCaptionCell }

function TdxReportLayoutGroupCaptionCell.CreateTextCell(AReportLink: TBasedxReportLink): TdxReportLayoutCaptionTextCell;
begin
  Result := inherited CreateTextCell(AReportLink);
  with Result do
  begin
    TextAlignX := taCenterX;
    TextAlignY := taCenterY;
  end;
  (Result as TdxReportLayoutGroupCaptionTextCell).CaptionLayout := Group.CaptionOptions.Layout;
  Result.AdjustFont := True;
end;

function TdxReportLayoutGroupCaptionCell.CreateImageCell(AReportLink: TBasedxReportLink): TdxReportCellImage;
const
  ARotationAngleMap: array[TdxCaptionLayout] of TcxRotationAngle = (raPlus90, ra0, raMinus90, ra0);
var
  AGlyph: TBitmap;
  ABitmap: TcxAlphaBitmap;
  AImageIndex: Integer;
  AImageList: TCustomImageList;
begin
  Result := inherited CreateImageCell(AReportLink);
  Result.ImageIndex := -1;
  Result.ImageList := nil;
  if TdxCustomLayoutItemImageOptionsAccess(ImageOptions).GetCurrentImage(AGlyph, AImageList, AImageIndex) then
  begin
    with TdxCustomLayoutItemImageOptionsAccess(ImageOptions).GetImageSize do
      ABitmap := TcxAlphaBitmap.CreateSize(cx, cy);
    try
      dxDrawItemGlyph(ABitmap.cxCanvas, Group,
        ABitmap.ClientRect, ARotationAngleMap[Group.CaptionOptions.Layout]);
      TdxReportLayoutGroupCaptionImageCell(Result).Image := ABitmap;
    finally
      ABitmap.Free;
    end;
  end;
end;

function TdxReportLayoutGroupCaptionCell.GetReportLayoutCaptionImageCellClass: TdxReportLayoutCaptionImageCellClass;
begin
  Result := TdxReportLayoutGroupCaptionImageCell;
end;

function TdxReportLayoutGroupCaptionCell.GetReportLayoutCaptionTextCellClass: TdxReportLayoutCaptionTextCellClass;
begin
  Result := TdxReportLayoutGroupCaptionTextCell;
end;

function TdxReportLayoutGroupCaptionCell.GetGroup: TdxLayoutGroup;
begin
  Result := TdxLayoutGroup(inherited Item);
end;

{ TdxPSReportLayoutGroupStandardLookAndFeelPainter }

procedure TdxPSReportLayoutGroupStandardLookAndFeelPainter.DrawCaptionText(ACanvas: TdxPSReportRenderCustomCanvas);
begin
// do nothing;
end;

function TdxPSReportLayoutGroupStandardLookAndFeelPainter.LookAndFeel: TdxPSReportLayoutGroupStandardLookAndFeel;
begin
  Result := inherited LookAndFeel as TdxPSReportLayoutGroupStandardLookAndFeel;
end;

{ TdxPSReportLayoutGroupStandardLookAndFeel }

function TdxPSReportLayoutGroupStandardLookAndFeel.GetBorderEdgeThickness(AGroup: TdxReportGroup; ASide: TdxCellSide): Integer;
begin
  if ASide = TdxReportLayoutGroup(AGroup).GetCaptionSide then
  begin
    Result := BorderThickness;
    if Renderer.IsRendering and (Renderer.LineThickness <> 0) then
      Result := Result * Renderer.LineThickness;
    if AGroup.ShowCaption then
      Inc(Result, GetCaptionAreaHeight(AGroup));
    if Renderer.IsRendering and (Renderer.LineThickness <> 0) then
      Result := Result div Renderer.LineThickness;
  end
  else
    Result := TdxReportLayoutGroup(AGroup).InternalGetBorderEdgeThickness(ASide);
end;

function TdxPSReportLayoutGroupStandardLookAndFeel.GetCaptionHeight(AGroup: TdxReportGroup): Integer;
var
  R: TRect;
begin
  R := GetCaptionTextBounds(AGroup);
  if (AGroup as TdxReportLayoutGroup).GetCaptionSide in [csLeft, csRight] then
    Result := cxRectWidth(R)
  else
    Result := cxRectHeight(R);
end;

function TdxPSReportLayoutGroupStandardLookAndFeel.GetCaptionTextBounds(AGroup: TdxReportGroup): TRect;
var
  ALayoutGroup: TdxReportLayoutGroup;
begin
  Result := cxNullRect;
  ALayoutGroup := AGroup as TdxReportLayoutGroup;
  if ALayoutGroup.HasCaptionItem then
    Result := ALayoutGroup.CaptionItem.BoundsRect;
end;

class function TdxPSReportLayoutGroupStandardLookAndFeel.GetPainterClass: TdxPSReportGroupLookAndFeelPainterClass;
begin
  Result := TdxPSReportLayoutGroupStandardLookAndFeelPainter;
end;

{ TdxPSReportLayoutGroupWebLookAndFeel }

function TdxPSReportLayoutGroupWebLookAndFeel.GetCaptionBounds(AGroup: TdxReportGroup): TRect;
var
  ALayoutGroup: TdxReportLayoutGroup;
begin
  ALayoutGroup := AGroup as TdxReportLayoutGroup;
  if AGroup.ShowCaption then
  begin
    Result := AGroup.BoundsRect;
    OffsetRect(Result, -Result.Left, -Result.Top);
    InflateRect(Result, -BorderThickness * Renderer.LineThickness, -BorderThickness * Renderer.LineThickness);
    case ALayoutGroup.GetCaptionSide of
      csLeft: Result.Right := Result.Left + GetCaptionHeight(AGroup);
      csTop: Result.Bottom := Result.Top + GetCaptionHeight(AGroup);
      csRight: Result.Left := Result.Right - GetCaptionHeight(AGroup);
      csBottom: Result.Top := Result.Bottom - GetCaptionHeight(AGroup);
    end;
  end
  else
    Result := cxNullRect;
end;

{ TdxPSReportLayoutGroupOfficeLookAndFeel }

class function TdxPSReportLayoutGroupOfficeLookAndFeel.DefaultBorderSides: TdxCellSides;
begin
  Result := TdxPSReportGroupOfficeLookAndFeel.DefaultBorderSides;
end;

class function TdxPSReportLayoutGroupOfficeLookAndFeel.Name: string;
begin
  Result := TdxPSReportGroupOfficeLookAndFeel.Name;
end;

function TdxPSReportLayoutGroupOfficeLookAndFeel.GetBorderSides(AGroup: TdxReportGroup): TdxCellSides;
begin
  Result := [TdxReportLayoutGroup(AGroup).GetCaptionSide];
end;

function TdxPSReportLayoutGroupOfficeLookAndFeel.GetCaptionIndent: Integer;
begin
  Result := 0;
end;

{ TdxReportLayoutGroup }

procedure TdxReportLayoutGroup.AdjustBorderOuterBounds(var R: TRect);
begin
  if ShowCaption and (LookAndFeel <> nil) then
    case GetCaptionSide of
      csLeft: Inc(R.Left, TdxPSReportGroupLookAndFeelAccess(LookAndFeel).GetCaptionHeight(Self) div 2);
      csTop: Inc(R.Top, TdxPSReportGroupLookAndFeelAccess(LookAndFeel).GetCaptionHeight(Self) div 2);
      csRight: Dec(R.Right, TdxPSReportGroupLookAndFeelAccess(LookAndFeel).GetCaptionHeight(Self) div 2);
      csBottom: Dec(R.Bottom, TdxPSReportGroupLookAndFeelAccess(LookAndFeel).GetCaptionHeight(Self) div 2);
    end;
end;

function TdxReportLayoutGroup.GetCaptionCellClass: TdxReportCustomLayoutCaptionCellClass;
begin
  Result := TdxReportLayoutGroupCaptionCell;
end;

function TdxReportLayoutGroup.GetCaptionSide: TdxCellSide;
const
  ResultMap: array[TdxCaptionLayout] of TdxCellSide = (csLeft, csTop, csRight, csBottom);
begin
  Result := ResultMap[Group.CaptionOptions.Layout];
end;

function TdxReportLayoutGroup.GetGroup: TdxLayoutGroup;
begin
  Result := TdxLayoutGroup(Item);
end;

{ TdxReportLayoutNonLabeledItem }

function TdxReportLayoutNonLabeledItem.NeedCreateCaptionCell: Boolean;
begin
  Result := False;
end;

{ TdxReportLayoutDirectionalItem }

procedure TdxReportLayoutDirectionalItem.AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas);
begin
  inherited;
  if HasSeparatorItem then
    SeparatorItem.BoundsRect := SeparatorBounds;
end;

procedure TdxReportLayoutDirectionalItem.Initialize(AReportLink: TBasedxReportLink);
begin
  inherited;
  FSeparatorItem := CreateSeparatorCell(AReportLink);
end;

function TdxReportLayoutDirectionalItem.NeedCreateCaptionCell: Boolean;
begin
  Result := False;
end;

function TdxReportLayoutDirectionalItem.CreateSeparatorCell(AReportLink: TBasedxReportLink): TdxReportCell;
const
  CellSidesMap: array[Boolean] of TdxCellSides = ([csTop], [csLeft]);
begin
  Result := TdxReportCell.Create(Self);
  with Result do
  begin
    BoundsRect := SeparatorBounds;
    Transparent := True;
    CellSides := CellSidesMap[LayoutItem.IsVertical];
  end;
end;

function TdxReportLayoutDirectionalItem.GetHasSeparatorItem: Boolean;
begin
  Result := (SeparatorItem <> nil) and (IndexOf(SeparatorItem) > -1);
end;

function TdxReportLayoutDirectionalItem.GetLayoutItem: TdxLayoutDirectionalItem;
begin
  Result := inherited Item as TdxLayoutDirectionalItem;
end;

function TdxReportLayoutDirectionalItem.GetSeparatorBounds: TRect;
begin
  Result := ViewInfo.Bounds;
  with ViewInfo.Bounds do
    OffsetRect(Result, -Left, -Top);
  if LayoutItem.IsVertical then
    OffsetRect(Result, Result.Right div 2, 0)
  else
    OffsetRect(Result, 0, Result.Bottom div 2);
end;

{ TdxReportLayoutLabeledItemCaptionCell }

function TdxReportLayoutLabeledItemCaptionCell.CreateTextCell(AReportLink: TBasedxReportLink): TdxReportLayoutCaptionTextCell;
begin
  Result := inherited CreateTextCell(AReportLink);
  // todo: ?  Result.TextAlignY := LayoutCaptionAlignVertMap[CaptionOptions.AlignVert];
  Result.Multiline := CaptionOptions.Width <> 0;
  Result.AdjustFont := True;
end;

function TdxReportLayoutLabeledItemCaptionCell.GetCaptionOptions: TdxLayoutLabeledItemCustomCaptionOptions;
begin
  Result := inherited CaptionOptions as TdxLayoutLabeledItemCustomCaptionOptions;
end;

{ TdxReportLayoutLabeledItem }

function TdxReportLayoutLabeledItem.GetCaptionCellClass: TdxReportCustomLayoutCaptionCellClass;
begin
  Result := TdxReportLayoutLabeledItemCaptionCell;
end;

function TdxReportLayoutLabeledItem.GetLayoutItem: TdxLayoutCustomLabeledItem;
begin
  Result := inherited Item as TdxLayoutCustomLabeledItem;
end;

{ TdxReportLayoutItem }

function TdxReportLayoutItem.LayoutItem: TdxLayoutItem;
begin
  Result := inherited LayoutItem as TdxLayoutItem;
end;

procedure TdxReportLayoutItem.AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas);
begin
  inherited;
  if HasControlItem then
    ControlItem.BoundsRect := ControlBounds;
end;

function TdxReportLayoutItem.CreateControlCell(AReportLink: TdxLayoutControlReportLink): TdxReportVisualItem;

  function LayoutItemProducer: TdxPSCustomLayoutItemProducer;
  begin
    Result := AReportLink.LayoutItemProducers[LayoutItem];
  end;

  function HasBorder(AControl: TWinControl): Boolean;
  var
    V: Variant;
  begin
    Result := csFramed in Control.ControlStyle;
    if not Result and AControl.HandleAllocated then
      Result := (GetWindowLong(AControl.Handle, GWL_STYLE) and WS_BORDER = WS_BORDER) or
                (GetWindowLong(AControl.Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE = WS_EX_CLIENTEDGE);
    if not Result and dxPSUtl.HasProperty(AControl, 'BorderStyle') then
    begin
      V := dxPSUtl.GetProperty(AControl, 'BorderStyle');
      Result := not VarIsNull(V) and (V <> Forms.bsNone);
    end;
  end;

const
  CellSidesMap: array[Boolean] of TdxCellSides = ([], csAll);
begin
  if Control is TWinControl then
  begin
    Result := AReportLink.ActiveBuilder.BuildNestedContainer(TWinControl(Control), Self);
    if not AReportLink.Producers[Control].HasNativeSupportForBorders then
      with LayoutItemProducer.LayoutLookAndFeel.ItemOptions do
      begin
        TdxReportWinControlHost(Result).ControlItem.BorderClass := LayoutBorderStyleMap[ControlBorderStyle];
        TdxReportWinControlHost(Result).ControlItem.BorderColor := ControlBorderColor;
        if not (TdxReportWinControlHost(Result).ControlItem is TdxReportCellGraphic) then
          TdxReportWinControlHost(Result).ControlItem.CellSides := CellSidesMap[LayoutItem.ControlOptions.ShowBorder or HasBorder(TWinControl(Control))];
      end;
  end
  else
    Result := AReportLink.ActiveBuilder.BuildControl(Control, Self);

  Result.BoundsRect := ControlBounds;
  Result.CellSides := [];
end;

procedure TdxReportLayoutItem.Initialize(AReportLink: TBasedxReportLink);
begin
  inherited;
  if NeedCreateControlCell then
    FControlItem := CreateControlCell(AReportLink as TdxLayoutControlReportLink);
end;

function TdxReportLayoutItem.NeedCreateControlCell: Boolean;
begin
  Result := TdxLayoutItemAccess(LayoutItem).HasControl;
end;

function TdxReportLayoutItem.GetAdapter: TdxCustomLayoutControlAdapter;
begin
  Result := TdxLayoutItemAccess(LayoutItem).ControlAdapter;
end;

function TdxReportLayoutItem.GetControl: TControl;
begin
  Result := LayoutItem.Control;
end;

function TdxReportLayoutItem.GetControlBounds: TRect;
begin
  with ViewInfo do
  begin
    Result := ControlViewInfo.ControlBounds;
    with Bounds do
      OffsetRect(Result, -Left, -Top);
  end;
end;

function TdxReportLayoutItem.GetHasControlItem: Boolean;
begin
  Result := (ControlItem <> nil) and (IndexOf(ControlItem) > -1);
end;

function TdxReportLayoutItem.GetIsControlAccessible: Boolean;
begin
  Result := (LayoutItem.Control <> nil) and LayoutItem.Control.Visible;
end;

function TdxReportLayoutItem.GetViewInfo: TdxLayoutItemViewInfo;
begin
  Result := TdxLayoutItemViewInfo(inherited ViewInfo);
end;

{ TdxPSCustomLayoutItemDefinition }

function TdxPSCustomLayoutItemDefinition.OptionsPagination: TdxLayoutControlReportLinkOptionsPagination;
begin
  Result := inherited OptionsPagination as TdxLayoutControlReportLinkOptionsPagination;
end;

procedure TdxPSCustomLayoutItemDefinition.AdjustBounds(ACanvas: TdxPSReportRenderCustomCanvas);
begin
  ReportItem.AdjustBounds(ACanvas);
end;

procedure TdxPSCustomLayoutItemDefinition.SaveOriginalItemSize;
begin
end;

procedure TdxPSCustomLayoutItemDefinition.SetupOriginalControlSize;
begin
end;

function TdxPSCustomLayoutItemDefinition.GetLayoutItem: TdxCustomLayoutItem;
begin
  Result := Component as TdxCustomLayoutItem;
end;

function TdxPSCustomLayoutItemDefinition.GetReportItem: TdxCustomReportLayoutItem;
begin
  Result := inherited ReportItem as TdxCustomReportLayoutItem;
end;

procedure TdxPSCustomLayoutItemDefinition.SetLayoutItem(Value: TdxCustomLayoutItem);
begin
  Component := Value;
end;

{ TdxPSLayoutGroupDefinition }

procedure TdxPSLayoutGroupDefinition.AddDelimitersHorz(AList: TList);
begin
  inherited;
  if OptionsPagination.Groups then AddReportItemToDelimitersHorz(AList);
end;

procedure TdxPSLayoutGroupDefinition.AddDelimitersVert(AList: TList);
begin
  inherited;
  if OptionsPagination.Groups then AddReportItemToDelimitersVert(AList);
end;

function TdxPSLayoutGroupDefinition.GetLayoutItem: TdxLayoutGroup;
begin
  Result := inherited LayoutItem as TdxLayoutGroup;
end;

{ TdxPSLayoutBasicItemDefinition }

procedure TdxPSLayoutBasicItemDefinition.AddDelimitersHorz(AList: TList);
begin
  inherited;
  if OptionsPagination.Items then AddReportItemToDelimitersHorz(AList);
end;

procedure TdxPSLayoutBasicItemDefinition.AddDelimitersVert(AList: TList);
begin
  inherited;
  if OptionsPagination.Items then AddReportItemToDelimitersVert(AList);
end;

{ TdxPSLayoutItemDefinition }

constructor TdxPSLayoutItemDefinition.Create(AReportLink: TdxCustomContainerReportLink; AComponent: TComponent; AReportItem: TdxReportVisualItem);
begin
  inherited;
end;

procedure TdxPSLayoutItemDefinition.SaveOriginalItemSize;
begin
  with TdxLayoutItemAccess(LayoutItem) do
    if Control <> nil then SaveOriginalControlSize;
end;

procedure TdxPSLayoutItemDefinition.SetupOriginalControlSize;
begin
  with ReportItem do
    if HasControlItem then
      LayoutItem.OriginalControlSize := Point(ControlItem.Width, ControlItem.Height);
end;

function TdxPSLayoutItemDefinition.GetLayoutItem: TdxLayoutItem;
begin
  Result := inherited LayoutItem as TdxLayoutItem;
end;

function TdxPSLayoutItemDefinition.GetReportItem: TdxReportLayoutItem;
begin
  Result := inherited ReportItem as TdxReportLayoutItem;
end;

{ TdxPSLayoutControlObjectProducer }

function TdxPSLayoutControlObjectProducer.ReportLink: TdxLayoutControlReportLink;
begin
  Result := inherited ReportLink as TdxLayoutControlReportLink;
end;

function TdxPSLayoutControlObjectProducer.RootContainer: TdxLayoutControl;
begin
  Result := inherited RootContainer as TdxLayoutControl;
end;

{ TdxPSLayoutLookAndFeelProducer }

function TdxPSLayoutLookAndFeelProducer.LayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := inherited ProducingObject as TdxCustomLayoutLookAndFeel;
end;

class function TdxPSLayoutLookAndFeelProducer.LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass;
begin
  Result := TdxCustomLayoutLookAndFeel;
end;

class function TdxPSLayoutLookAndFeelProducer.PairClass: TClass;
begin
  Result := LayoutLookAndFeelClass;
end;

class procedure TdxPSLayoutLookAndFeelProducer.Register;
begin
  dxPSLayoutLookAndFeelProducerFactory.Register(Self);
end;

class procedure TdxPSLayoutLookAndFeelProducer.Unregister;
begin
  dxPSLayoutLookAndFeelProducerFactory.Unregister(Self);
end;

function TdxPSLayoutLookAndFeelProducer.GetContentColor: TColor;
begin
  Result := LayoutLookAndFeel.GroupOptions.GetColor;
end;

function TdxPSLayoutLookAndFeelProducer.GetGroupCaptionColor: TColor;
begin
  Result := LayoutLookAndFeel.GroupOptions.GetColor;
end;

function TdxPSLayoutLookAndFeelProducer.GetIsContentTransparent: Boolean;
begin
  Result := ColorToRGB(ContentColor) = ColorToRGB(TransparentColor);
end;

function TdxPSLayoutLookAndFeelProducer.GetIsGroupCaptionTransparent: Boolean;
begin
  Result := ColorToRGB(GroupCaptionColor) = ColorToRGB(TransparentColor);
end;

function TdxPSLayoutLookAndFeelProducer.GetTransparentColor: TColor;
begin
  Result := clDefault;
end;

procedure TdxPSLayoutLookAndFeelProducer.InitializeReportLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel);
begin
  ALookAndFeel.Color := LayoutLookAndFeel.GroupOptions.GetColor;
  ALookAndFeel.Data := LayoutLookAndFeel;
  ALookAndFeel.FontIndex := ReportLink.FindFontIndexByCaptionOptions(LayoutLookAndFeel.GroupOptions.CaptionOptions);
  ALookAndFeel.CaptionFontIndex := ALookAndFeel.FontIndex;
end;

class function TdxPSLayoutLookAndFeelProducer.ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass;
begin
  Result := TdxPSReportLayoutGroupStandardLookAndFeel;
end;

{ TdxPSLayoutStandardLookAndFeelProducer }

function TdxPSLayoutStandardLookAndFeelProducer.LayoutLookAndFeel: TdxLayoutStandardLookAndFeel;
begin
  Result := inherited LayoutLookAndFeel as TdxLayoutStandardLookAndFeel;
end;

class function TdxPSLayoutStandardLookAndFeelProducer.LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass;
begin
  Result := TdxLayoutStandardLookAndFeel;
end;

function TdxPSLayoutStandardLookAndFeelProducer.GetTransparentColor: TColor;
begin
  Result := clBtnFace;
end;

class function TdxPSLayoutStandardLookAndFeelProducer.ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass;
begin
  Result := TdxPSReportLayoutGroupStandardLookAndFeel;
end;

{ TdxPSLayoutOfficeLookAndFeelProducer }

function TdxPSLayoutOfficeLookAndFeelProducer.LayoutLookAndFeel: TdxLayoutOfficeLookAndFeel;
begin
  Result := inherited LayoutLookAndFeel as TdxLayoutOfficeLookAndFeel;
end;

class function TdxPSLayoutOfficeLookAndFeelProducer.LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass;
begin
  Result := TdxLayoutOfficeLookAndFeel;
end;

class function TdxPSLayoutOfficeLookAndFeelProducer.ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass;
begin
  Result := TdxPSReportLayoutGroupOfficeLookAndFeel;
end;

{ TdxPSLayoutWebLookAndFeelProducer }

function TdxPSLayoutWebLookAndFeelProducer.LayoutLookAndFeel: TdxLayoutWebLookAndFeel;
begin
  Result := inherited LayoutLookAndFeel as TdxLayoutWebLookAndFeel;
end;

class function TdxPSLayoutWebLookAndFeelProducer.LayoutLookAndFeelClass: TdxCustomLayoutLookAndFeelClass;
begin
  Result := TdxLayoutWebLookAndFeel;
end;

function TdxPSLayoutWebLookAndFeelProducer.GetGroupCaptionColor: TColor;
begin
  Result := LayoutLookAndFeel.GroupOptions.CaptionOptions.GetColor;
end;

function TdxPSLayoutWebLookAndFeelProducer.GetTransparentColor: TColor;
begin
  Result := clWindow;
end;

procedure TdxPSLayoutWebLookAndFeelProducer.InitializeReportLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel);
begin
  inherited;
  with TdxPSReportGroupWebLookAndFeel(ALookAndFeel) do
  begin
    BorderThickness := LayoutLookAndFeel.GroupOptions.FrameWidth;
    BorderColor := LayoutLookAndFeel.GroupOptions.GetFrameColor;
    CaptionColor := LayoutLookAndFeel.GroupOptions.CaptionOptions.GetColor;
    CaptionSeparatorColor := LayoutLookAndFeel.GroupOptions.GetFrameColor;
    CaptionSeparatorThickness := LayoutLookAndFeel.GroupOptions.CaptionOptions.SeparatorWidth;
  end;
end;

class function TdxPSLayoutWebLookAndFeelProducer.ReportLookAndFeelClass: TdxPSReportGroupLookAndFeelClass;
begin
  Result := TdxPSReportLayoutGroupWebLookAndFeel;
end;

{ TdxPSCustomLayoutItemProducer }

function TdxPSCustomLayoutItemProducer.Definition: TdxPSCustomLayoutItemDefinition;
begin
  Result := inherited Definition as TdxPSCustomLayoutItemDefinition;
end;

class function TdxPSCustomLayoutItemProducer.DefinitionClass: TdxPSCustomContainerItemDefinitionClass;
begin
  Result := TdxPSCustomLayoutItemDefinition;
end;

function TdxPSCustomLayoutItemProducer.LayoutItem: TdxCustomLayoutItem;
begin
  Result := inherited ProducingObject as TdxCustomLayoutItem;
end;

class function TdxPSCustomLayoutItemProducer.LayoutItemClass: TdxCustomLayoutItemClass;
begin
  Result := TdxCustomLayoutItem;
end;

class function TdxPSCustomLayoutItemProducer.PairClass: TClass;
begin
  Result := LayoutItemClass;
end;

function TdxPSCustomLayoutItemProducer.ProducingObjectFriendlyName: string;
begin
  Result := LayoutItem.Caption;
  if Result = '' then
    Result := inherited ProducingObjectFriendlyName;
end;

procedure TdxPSCustomLayoutItemProducer.Reposition;
begin
end;

class procedure TdxPSCustomLayoutItemProducer.Register;
begin
  inherited;
  dxPSLayoutItemProducerFactory.Register(Self);
end;

class procedure TdxPSCustomLayoutItemProducer.Unregister;
begin
  if Self <> TdxPSCustomLayoutItemProducer then
    dxPSLayoutItemProducerFactory.Unregister(Self);
  inherited;
end;

function TdxPSCustomLayoutItemProducer.GetContentColor: TColor;
begin
  Result := LayoutLookAndFeelProducer.ContentColor;
end;

function TdxPSCustomLayoutItemProducer.GetIsContentTransparent: Boolean;
begin
  Result := LayoutLookAndFeelProducer.IsContentTransparent;
end;

function TdxPSCustomLayoutItemProducer.GetLayoutLookAndFeel: TdxCustomLayoutLookAndFeel;
begin
  Result := LayoutItem.ViewInfo.LayoutLookAndFeel;
end;

function TdxPSCustomLayoutItemProducer.GetLayoutLookAndFeelProducer: TdxPSLayoutLookAndFeelProducer;
begin
  Result := ReportLink.LayoutLookAndFeelProducers[LayoutLookAndFeel];
end;

procedure TdxPSCustomLayoutItemProducer.InitializeReportItem(AnItem: TdxReportCell);
begin
  AnItem.BoundsRect := LayoutItemBounds;
  AnItem.CellSides := [];
  AnItem.Color := ContentColor;
  AnItem.Data := Integer(LayoutItem);
  //AnItem.ExcludeFromClipRgn := True;
  AnItem.Transparent := False;
  ReportLink.CreateItemDefinition(LayoutItem, AnItem);
  with AnItem as TdxCustomReportLayoutItem do
    Initialize(ReportLink);
end;

class function TdxPSCustomLayoutItemProducer.ReportItemClass: TdxReportCellClass;
begin
  Result := TdxCustomReportLayoutItem;
end;

function TdxPSCustomLayoutItemProducer.OptionsTransparent: TdxLayoutControlReportLinkOptionsTransparent;
begin
  Result := inherited OptionsTransparent as TdxLayoutControlReportLinkOptionsTransparent;
end;

procedure TdxPSCustomLayoutItemProducer.AdjustBounds;
begin
  Definition.AdjustBounds(Canvas);
end;

procedure TdxPSCustomLayoutItemProducer.SaveOriginalItemSize;
begin
  Definition.SaveOriginalItemSize;
end;

function TdxPSCustomLayoutItemProducer.GetLayoutItemBounds: TRect;
begin
  Result := GetLayoutItemRelativeBounds(LayoutItem.ViewInfo);
end;

{ TdxPSLayoutGroupProducer }

function TdxPSLayoutGroupProducer.Definition: TdxPSLayoutGroupDefinition;
begin
  Result := inherited Definition as TdxPSLayoutGroupDefinition;
end;

class function TdxPSLayoutGroupProducer.DefinitionClass: TdxPSCustomContainerItemDefinitionClass;
begin
  Result := TdxPSLayoutGroupDefinition;
end;

function TdxPSLayoutGroupProducer.ProducingObjectFriendlyName: string;
begin
  Result := LayoutItem.Caption;
  if Result = '' then
    Result := cxGetResourceString(@sdxLayoutGroupDefaultCaption);
end;

procedure TdxPSLayoutGroupProducer.Reposition;
begin
end;

function TdxPSLayoutGroupProducer.LayoutItem: TdxLayoutGroup;
begin
  Result := inherited LayoutItem as TdxLayoutGroup;
end;

class function TdxPSLayoutGroupProducer.LayoutItemClass: TdxCustomLayoutItemClass;
begin
  Result := TdxLayoutGroup;
end;

function TdxPSLayoutGroupProducer.GetGroupCaptionContentColor: TColor;
begin
  Result := LayoutLookAndFeelProducer.GroupCaptionColor;
end;

function TdxPSLayoutGroupProducer.GetIsGroupCaptionTransparent: Boolean;
begin
  Result := LayoutLookAndFeelProducer.IsGroupCaptionTransparent;
end;

procedure TdxPSLayoutGroupProducer.InitializeReportItem(AnItem: TdxReportCell);
begin
  inherited;
  with TdxReportLayoutGroup(AnItem) do
  begin
    LookAndFeel := Self.ReportLink.FindReportGroupLookAndFeel(LayoutLookAndFeel);
    Transparent := OptionsTransparent.Groups;
    CellSides := [];

    if TdxCustomLayoutItemViewInfoAccess(LayoutItem.ViewInfo).HasBorder then
      CellSides := TdxPSReportGroupLookAndFeelAccess(LookAndFeel).GetBorderSides(TdxReportGroup(AnItem));

    CalculateCaptionTextWidth(Canvas);
  end;
end;

class function TdxPSLayoutGroupProducer.ReportItemClass: TdxReportCellClass;
begin
  Result := TdxReportLayoutGroup;
end;

{ TdxPSLayoutBasicItemProducer }

class function TdxPSLayoutBasicItemProducer.DefinitionClass: TdxPSCustomContainerItemDefinitionClass;
begin
  Result := TdxPSLayoutBasicItemDefinition;
end;

class function TdxPSLayoutBasicItemProducer.LayoutItemClass: TdxCustomLayoutItemClass;
begin
  Result := TdxLayoutBasicItem;
end;

function TdxPSLayoutBasicItemProducer.GetContentColor: TColor;
begin
  Result := ReportLink.LayoutLookAndFeelProducers[LayoutItem.ViewInfo.LayoutLookAndFeel].ContentColor;
end;

procedure TdxPSLayoutBasicItemProducer.InitializeReportItem(AnItem: TdxReportCell);
begin
  inherited;
  AnItem.Transparent := OptionsTransparent.Items;
end;

class function TdxPSLayoutBasicItemProducer.ReportItemClass: TdxReportCellClass;
begin
  Result := TdxReportLayoutBasicItem;
end;

{ TdxPSLayoutEmptySpaceItemProducer }

class function TdxPSLayoutEmptySpaceItemProducer.LayoutItemClass: TdxCustomLayoutItemClass;
begin
  Result := TdxLayoutEmptySpaceItem;
end;

{ TdxPSLayoutSeparatorItemProducer }

class function TdxPSLayoutSeparatorItemProducer.LayoutItemClass: TdxCustomLayoutItemClass;
begin
  Result := TdxLayoutSeparatorItem;
end;

class function TdxPSLayoutSeparatorItemProducer.ReportItemClass: TdxReportCellClass;
begin
  Result := TdxReportLayoutSeparatorItem;
end;

{ TdxPSLayoutSplitterItemProducer }

class function TdxPSLayoutSplitterItemProducer.LayoutItemClass: TdxCustomLayoutItemClass;
begin
  Result := TdxLayoutSplitterItem;
end;

class function TdxPSLayoutSplitterItemProducer.ReportItemClass: TdxReportCellClass;
begin
  Result := TdxReportLayoutSplitterItem;
end;

{ TdxPSLayoutLabeledItemProducer }

class function TdxPSLayoutLabeledItemProducer.DefinitionClass: TdxPSCustomContainerItemDefinitionClass;
begin
  Result := TdxPSLayoutLabeledItemDefinition;
end;

function TdxPSLayoutLabeledItemProducer.LayoutItem: TdxLayoutLabeledItem;
begin
  Result := inherited LayoutItem as TdxLayoutLabeledItem;
end;

class function TdxPSLayoutLabeledItemProducer.LayoutItemClass: TdxCustomLayoutItemClass;
begin
  Result := TdxLayoutLabeledItem;
end;

class function TdxPSLayoutLabeledItemProducer.ReportItemClass: TdxReportCellClass;
begin
  Result := TdxReportLayoutLabeledItem;
end;

{ TdxPSLayoutItemProducer }

constructor TdxPSLayoutItemProducer.Create(AReportLink: TdxCustomContainerReportLink; AnObject: TComponent);
begin
  inherited;
end;

function TdxPSLayoutItemProducer.Definition: TdxPSLayoutItemDefinition;
begin
  Result := inherited Definition as TdxPSLayoutItemDefinition;
end;

class function TdxPSLayoutItemProducer.DefinitionClass: TdxPSCustomContainerItemDefinitionClass;
begin
  Result := TdxPSLayoutItemDefinition;
end;

function TdxPSLayoutItemProducer.LayoutItem: TdxLayoutItem;
begin
  Result := inherited LayoutItem as TdxLayoutItem;
end;

class function TdxPSLayoutItemProducer.LayoutItemClass: TdxCustomLayoutItemClass;
begin
  Result := TdxLayoutItem;
end;

function TdxPSLayoutItemProducer.ProducingObjectFriendlyName: string;
begin
  Result := LayoutItem.Caption;
  if Result = '' then
    Result := cxGetResourceString(@sdxLayoutItemDefaultCaption);
  Result := dxPSUtl.DropColon(Result);
end;

procedure TdxPSLayoutItemProducer.Reposition;
begin
  if HasControl then
  begin
    ReportLink.Producers[Control].Reposition;
    Definition.SetupOriginalControlSize;
  end;
end;

class function TdxPSLayoutItemProducer.ReportItemClass: TdxReportCellClass;
begin
  Result := TdxReportLayoutItem;
end;

function TdxPSLayoutItemProducer.GetControl: TControl;
begin
  Result := LayoutItem.Control;
end;

function TdxPSLayoutItemProducer.GetHasControl: Boolean;
begin
  Result := (Control <> nil) and Control.Visible;
end;

{ TdxPSCustomLayoutObjectProducerCache }

function TdxPSCustomLayoutObjectProducerCache.ReportLink: TdxLayoutControlReportLink;
begin
  Result := inherited ReportLink as TdxLayoutControlReportLink;
end;

{ TdxPSLayoutItemProducerCache }

function TdxPSLayoutItemProducerCache.GetItem(Index: Integer): TdxPSCustomLayoutItemProducer;
begin
  Result := TdxPSCustomLayoutItemProducer(inherited Items[Index]);
end;

function TdxPSLayoutItemProducerCache.GetProducer(AProducerClass: TdxPSCustomLayoutItemProducerClass;
  ALayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
var
  Index: Integer;
begin
  Index := IndexOfByClass(AProducerClass);
  if Index = -1 then
    Index := Add(AProducerClass.Create(ReportLink, ALayoutItem));
  Result := Items[Index];
  Result.Initialize(ALayoutItem);
end;

{ TdxPSLayoutLookAndFeelProducerCache }

function TdxPSLayoutLookAndFeelProducerCache.GetItem(Index: Integer): TdxPSLayoutLookAndFeelProducer;
begin
  Result := TdxPSLayoutLookAndFeelProducer(inherited Items[Index]);
end;

function TdxPSLayoutLookAndFeelProducerCache.GetProducer(AProducerClass: TdxPSLayoutLookAndFeelProducerClass;
  ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducer;
var
  Index: Integer;
begin
  Index := IndexOfByClass(AProducerClass);
  if Index = -1 then
    Index := Add(AProducerClass.Create(ReportLink, ALayoutLookAndFeel));
  Result := Items[Index];
  Result.Initialize(ALayoutLookAndFeel);
end;

{ TdxPSNativeLayoutControlProducer }

class function TdxPSNativeLayoutControlProducer.HasNativeSupportForBorders: Boolean;
begin
  Result := True;
end;

function TdxPSNativeLayoutControlProducer.ObjectExpandHeight: Boolean;
begin
  Result := True;
end;

function TdxPSNativeLayoutControlProducer.ObjectExpandWidth: Boolean;
begin
  Result := True;
end;

function TdxPSNativeLayoutControlProducer.Control: TdxCustomLayoutControl;
begin
  Result := inherited Control as TdxCustomLayoutControl;
end;

class function TdxPSNativeLayoutControlProducer.ControlClass: TControlClass;
begin
  Result := TdxCustomLayoutControl;
end;

{ TdxPSLayoutControlProducer }

class function TdxPSLayoutControlProducer.CanHasAvailableChildren: Boolean;
begin
  Result := False;
end;

class function TdxPSLayoutControlProducer.Reenterable: Boolean;
begin
  Result := False;
end;

function TdxPSLayoutControlProducer.Control: TdxLayoutControl;
begin
  Result := inherited Control as TdxLayoutControl;
end;

class function TdxPSLayoutControlProducer.ControlClass: TControlClass;
begin
  Result := TdxCustomLayoutControl;
end;

class function TdxPSLayoutControlProducer.HasNativeSupportForBorders: Boolean;
begin
  Result := False;
end;

function TdxPSLayoutControlProducer.ObjectExpandHeight: Boolean;
begin
  Result := True;
end;

function TdxPSLayoutControlProducer.ObjectExpandWidth: Boolean;
begin
  Result := True;
end;

function TdxPSLayoutControlProducer.ReportLink: TdxLayoutControlReportLink;
begin
  Result := inherited ReportLink as TdxLayoutControlReportLink;
end;

procedure TdxPSLayoutControlProducer.Reposition;

  procedure CalculateViewInfo;
  begin
    Control.ViewInfo.Calculate;
  end;

  procedure SetupOriginalControlSize(AnItems: TList);
  var
    I, Index: Integer;
    Item: TdxCustomLayoutItem;
  begin
    for I := 0 to AnItems.Count - 1 do
    begin
      Item := AnItems[I];
      if ReportLink.IsComponentProcessed(Item) then
        if (Item is TdxLayoutGroup) or ReportLink.FindDefinition(TdxLayoutItem(Item).Control, Index) then
          Producers[Item].Reposition
        else
      else
        Item.Visible := False;
    end;
    CalculateViewInfo;
  end;

  procedure UpdateItemsBounds(AnItems: TList);
  var
    I: Integer;
    Item: TdxCustomLayoutItem;
  begin
    for I := 0 to AnItems.Count - 1 do
    begin
      Item := AnItems[I];
      if ReportLink.IsComponentProcessed(Item) then
        Producers[Item].AdjustBounds;
    end;
  end;

  procedure RestoreOriginalControlSize(AnItems: TList);
  var
    I: Integer;
    Item: TdxCustomLayoutItem;
  begin
    for I := 0 to AnItems.Count - 1 do
    begin
      Item := AnItems[I];
      Item.Visible := True;
      if ReportLink.IsComponentProcessed(Item) then
        Producers[Item].SaveOriginalItemSize;
    end;
    CalculateViewInfo;
  end;

var
  Items: TList;
  Cell: TdxReportCell;
begin
  Control.BeginUpdate;
  try
    Items := TList.Create;
    try
      GetLayoutItemList(Items);
      SetupOriginalControlSize(Items);
      try
        UpdateItemsBounds(Items);
      finally
        RestoreOriginalControlSize(Items);
      end;
    finally
      Items.Free;
    end;
  finally
    Control.EndUpdate;
  end;

  with TdxReportCell(Definition.SizeChangeReportItem) do
  begin
    Cell := Cells[0].Cells[0];

    Cells[0].Height := Cell.Height;
    Cells[0].Width := Cell.Width;

    Height := Cell.Height;
    Width := Cell.Width;
  end;
end;

procedure TdxPSLayoutControlProducer.CreateLayoutItems(AnItem: TdxReportVisualItem);

  function CreateReportItem(AParent: TdxReportCell; ALayoutItem: TdxCustomLayoutItem): TdxReportCell;
  begin
    ReportLink.CurrentLayoutItem := ALayoutItem;
    try
      with Producers[ALayoutItem] do
      begin
        Result := ReportItemClass.Create(AParent);
        InitializeReportItem(Result);
      end;
      ReportLinkInitializeItem(Result);
    finally
      ReportLink.CurrentLayoutItem := nil;
    end;
  end;

  procedure ProduceItem(AParent: TdxReportCell; ALayoutItem: TdxCustomLayoutItem);
  var
    I: Integer;
    LayoutItem: TdxCustomLayoutItem;
  begin
    if not ReportLink.DoIsComponentProcessed(ALayoutItem) then
      Exit;
    AParent := CreateReportItem(AParent, ALayoutItem);
    if ALayoutItem is TdxLayoutGroup then
      with TdxLayoutGroup(ALayoutItem) do
        for I := 0 to VisibleCount - 1 do
        begin
          LayoutItem := VisibleItems[I];
          if not LayoutItem.ActuallyVisible then Continue;
          if ReportLink.DoIsComponentProcessed(LayoutItem) then
            ProduceItem(AParent, LayoutItem);
        end;
  end;

begin
  ProduceItem(TdxReportCell(AnItem), Control.Items); // Root is always processed
end;

procedure TdxPSLayoutControlProducer.GetLayoutItemList(AnItems: TList);
begin
  ReportLink.GetLayoutItemList(Control, AnItems);
end;

function TdxPSLayoutControlProducer.HostClass: TdxReportCellClass;
begin
  Result := TdxReportLayoutControlHost;
end;

procedure TdxPSLayoutControlProducer.InitializeHost(ACell: TdxReportCell);
begin
  inherited;
  ACell.Height := Control.ViewInfo.ContentHeight;
  ACell.Width := Control.ViewInfo.ContentWidth;
end;

procedure TdxPSLayoutControlProducer.InitializeItem(AnItem: TdxReportVisualItem);
begin
  inherited;
  AnItem.BorderClass := TdxPSCellNullBorder;
  AnItem.Height := Control.ViewInfo.ContentHeight;
  AnItem.Width := Control.ViewInfo.ContentWidth;
  AnItem.CellSides := [];
  AnItem.Transparent := True;

  CreateLayoutItems(AnItem);
end;

function TdxPSLayoutControlProducer.ItemClass: TdxReportVisualItemClass;
begin
  Result := TdxReportCell;
end;

procedure TdxPSLayoutControlProducer.ReportLinkInitializeItem(AnItem: TdxReportVisualItem);
begin
  ReportLink.DoInitializeItem(AnItem);
  ReportLink.DoInitializeItemOptionsPlace(AnItem);
end;

function TdxPSLayoutControlProducer.GetAvailableBounds: TRect;
begin
  Result := ReportLink.AvailableBounds;
end;

function TdxPSLayoutControlProducer.GetProducer(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
begin
  Result := ReportLink.LayoutItemProducers[LayoutItem];
end;

{ TdxLayoutControlReportLinkOptionsBehavior }

procedure TdxLayoutControlReportLinkOptionsBehavior.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxLayoutControlReportLinkOptionsBehavior then
    with TdxLayoutControlReportLinkOptionsBehavior(Source) do
    begin
      Self.ActiveTabToTop := ActiveTabToTop;
      Self.ExpandGroups := ExpandGroups;
      Self.SkipEmptyGroups := SkipEmptyGroups;
      Self.UnwrapTabs := UnwrapTabs;
    end;
end;

procedure TdxLayoutControlReportLinkOptionsBehavior.RestoreDefaults;
begin
  inherited;
  ActiveTabToTop := True;
  ExpandGroups := True;
  SkipEmptyGroups := True;
  UnwrapTabs := False;
end;

procedure TdxLayoutControlReportLinkOptionsBehavior.SetActiveTabToTop(Value: Boolean);
begin
  if ActiveTabToTop <> Value then
  begin
    FActiveTabToTop := Value;
    Changed;
  end;
end;

procedure TdxLayoutControlReportLinkOptionsBehavior.SetExpandGroups(Value: Boolean);
begin
  if ExpandGroups <> Value then
  begin
    FExpandGroups := Value;
    Changed;
  end;
end;

procedure TdxLayoutControlReportLinkOptionsBehavior.SetSkipEmptyGroups(Value: Boolean);
begin
  if SkipEmptyGroups <> Value then
  begin
    FSkipEmptyGroups := Value;
    Changed;
  end;
end;

procedure TdxLayoutControlReportLinkOptionsBehavior.SetUnwrapTabs(Value: Boolean);
begin
  if UnwrapTabs <> Value then
  begin
    FUnwrapTabs := Value;
    Changed;
  end;
end;

{ TdxLayoutControlReportLinkOptionsPagination }

procedure TdxLayoutControlReportLinkOptionsPagination.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxLayoutControlReportLinkOptionsPagination then
    with TdxLayoutControlReportLinkOptionsPagination(Source) do
    begin
      Self.Groups := Groups;
      Self.Items := Items;
    end;
end;

procedure TdxLayoutControlReportLinkOptionsPagination.RestoreDefaults;
begin
  inherited;
  Controls := False;
  Groups := True;
  Items := True;
end;

procedure TdxLayoutControlReportLinkOptionsPagination.SetGroups(Value: Boolean);
begin
  if FGroups <> Value then
  begin
    FGroups := Value;
    Changed;
  end;
end;

procedure TdxLayoutControlReportLinkOptionsPagination.SetItems(Value: Boolean);
begin
  if FItems <> Value then
  begin
    FItems := Value;
    Changed;
  end;
end;

{ TdxLayoutControlReportLinkOptionsSize }

procedure TdxLayoutControlReportLinkOptionsSize.Assign(Source: TPersistent);
begin
  if Source is TdxLayoutControlReportLinkOptionsSize then
    AutoWidth := TdxLayoutControlReportLinkOptionsSize(Source).AutoWidth;
  inherited;
end;

procedure TdxLayoutControlReportLinkOptionsSize.RestoreDefaults;
begin
  inherited;
  AutoWidth := True;
end;

procedure TdxLayoutControlReportLinkOptionsSize.SetAutoWidth(Value: Boolean);
begin
  if FAutoWidth <> Value then
  begin
    FAutoWidth := Value;
    Changed;
  end;
end;

{ TdxLayoutControlReportLinkOptionsTransparent }

procedure TdxLayoutControlReportLinkOptionsTransparent.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxLayoutControlReportLinkOptionsTransparent then
    with TdxLayoutControlReportLinkOptionsTransparent(Source) do
    begin
      Self.Groups := Groups;
      Self.Items := Items;
    end;
end;

procedure TdxLayoutControlReportLinkOptionsTransparent.RestoreDefaults;
begin
  Groups := True;
  Items := True;
  inherited;
end;

procedure TdxLayoutControlReportLinkOptionsTransparent.SetGroups(Value: Boolean);
begin
  if FGroups <> Value then
  begin
    FGroups := Value;
    Changed;
  end;
end;

procedure TdxLayoutControlReportLinkOptionsTransparent.SetItems(Value: Boolean);
begin
  if FItems <> Value then
  begin
    FItems := Value;
    Changed;
  end;
end;

{ TdxLayoutControlReportLink }

constructor TdxLayoutControlReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FCachedFonts := TList.Create;
  FCachedBounds := TList.Create;
  FLayoutItemProducerCache := TdxPSLayoutItemProducerCache.Create(Self);
  FLayoutLookAndFeelProducerCache := TdxPSLayoutLookAndFeelProducerCache.Create(Self);
  FOptionsBehavior := TdxLayoutControlReportLinkOptionsBehavior.Create(Self);
end;

destructor TdxLayoutControlReportLink.Destroy;
begin
  FreeAndNil(FOptionsBehavior);
  FreeAndNil(FLayoutLookAndFeelProducerCache);
  FreeAndNil(FLayoutItemProducerCache);
  FreeAndNilCachedFonts;
  FreeAndNilCachedBounds;
  inherited;
end;

class function TdxLayoutControlReportLink.Aggregable: Boolean;
begin
  Result := True;
end;

function TdxLayoutControlReportLink.DoIsComponentProcessed(AComponent: TComponent): Boolean;
begin
  Result := inherited DoIsComponentProcessed(AComponent) and
    (not (AComponent is TdxLayoutItem) or inherited DoIsComponentProcessed((AComponent as TdxLayoutItem).Control));
end;

function TdxLayoutControlReportLink.GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean;
begin
  Result := ([ucMarginLeft, ucMarginRight] * AUpdateCodes <> []) and OptionsSize.AutoWidth;
end;

procedure TdxLayoutControlReportLink.InternalRestoreDefaults;
begin
  inherited;
  OptionsSize.RestoreDefaults;
  OptionsBehavior.RestoreDefaults;
end;

procedure TdxLayoutControlReportLink.CacheControlsBounds;

  procedure EnumItems(AGroup: TdxLayoutGroupViewInfo);
  var
    I: Integer;
    ControlViewInfo: TdxLayoutItemControlViewInfo;
  begin
    for I := 0 to AGroup.ItemViewInfoCount - 1 do
      if AGroup.ItemViewInfos[I] is TdxLayoutItemViewInfo then
      begin
        ControlViewInfo := TdxLayoutItemViewInfo(AGroup.ItemViewInfos[I]).ControlViewInfo;
        if ControlViewInfo <> nil then
          AddBoundsToCache(ControlViewInfo.Control, ControlViewInfo.ControlBounds);
      end
      else
        if AGroup.ItemViewInfos[I] is TdxLayoutGroupViewInfo then
          EnumItems(TdxLayoutGroupViewInfo(AGroup.ItemViewInfos[I]))
  end;

begin
  EnumItems(LayoutControl.ViewInfo.ItemsViewInfo);
end;

procedure TdxLayoutControlReportLink.ConstructReport(AReportCells: TdxReportCells);
var
  AList: TList;

  procedure SetItemStates;

    procedure SetItemState(AItem: TdxCustomLayoutItem);
    var
      AGroup: TdxLayoutGroup;
      I: Integer;
    begin
      if AItem is TdxLayoutGroup then
      begin
        AGroup := AItem as TdxLayoutGroup;
        if OptionsBehavior.ExpandGroups then
          AGroup.Expanded := True;
        if AGroup.LayoutDirection = ldTabbed then
        begin
          AGroup.LayoutDirection := ldVertical;
          if not OptionsBehavior.UnwrapTabs then
            for I := 0 to AGroup.Count - 1 do
              if AGroup[I].Visible and (AGroup.ItemIndex <> AGroup[I].Index) then
                AGroup[I].Visible := False;
          if OptionsBehavior.ActiveTabToTop then
            AGroup.Items[AGroup.ItemIndex].Index := 0;
        end;
        if OptionsBehavior.SkipEmptyGroups then
          for I := 0 to AGroup.VisibleCount - 1 do
            if (AGroup.VisibleItems[I] is TdxLayoutGroup) and ((AGroup.VisibleItems[I] as TdxLayoutGroup).VisibleCount = 0) then
              AGroup.VisibleItems[I].Visible := False;
        for I := 0 to AGroup.VisibleCount - 1 do
          SetItemState(AGroup.VisibleItems[I]);
      end;
    end;

  begin
    SetItemState(LayoutControl.Items);
    TdxLayoutContainerAccess(LayoutControl.Container).DoCalculateRoot(False);
  end;

var
  ACanLockPaint: Boolean;
begin
  ACanLockPaint := Assigned(LayoutControl.Parent) and
    LayoutControl.Parent.HandleAllocated and LayoutControl.Parent.Visible;
  AList := TList.Create;
  try
    if ACanLockPaint then
      SendMessage(LayoutControl.Parent.Handle, WM_SETREDRAW, 0, 0);
    LayoutControl.BeginUpdate;
    AdjustLayoutBounds(AvailableBounds);
    try
      dxLayoutStoreItemStates(AList, LayoutControl.Container);
      with OptionsBehavior do
        dxLayoutSetItemStates(LayoutControl.Container, UnwrapTabs, ActiveTabToTop, SkipEmptyGroups, ExpandGroups);
      inherited ConstructReport(AReportCells);
      PostCheckEmbeddedControls;
    finally
      AdjustLayoutBounds(cxNullRect);
      dxLayoutRestoreItemStates(AList, LayoutControl.Container);
      LayoutControl.EndUpdate;
    end;
  finally
    AList.Free;
    if ACanLockPaint then
    begin
      SendMessage(LayoutControl.Parent.Handle, WM_SETREDRAW, 1, 0);
      RedrawWindow(LayoutControl.Parent.Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
    end;
  end;
end;

procedure TdxLayoutControlReportLink.PostCheckEmbeddedControls;
var
  I: Integer;
  LayoutItem: TdxLayoutItem;
  ReportItem: TdxReportCell;
  ADataItem: TdxReportVisualItem;
  BottomPosition: Integer;
  NeedAddBorder: Boolean;

  procedure DoCheckBounds(ACell: TdxReportCell; ATopOffset: Integer);
  var
    I: Integer;
  begin
    for I := 0 to ACell.CellCount - 1 do
      DoCheckBounds(ACell.Cells[I], ATopOffset + ACell.Cells[I].Top);
      for I := 0 to ACell.DataItemCount - 1 do
      begin
        if ADataItem = nil then
          ADataItem := ACell.DataItems[I];
        NeedAddBorder := NeedAddBorder or
          (ACell.DataItems[I].BoundsRect.Bottom + ATopOffset > BottomPosition);
      end;
  end;

begin
  for I := 0 to CachedBoundsCount - 1 do
  begin
    ADataItem := nil;
    NeedAddBorder := False;
    if not CachedBoundsItem[I].EmbeddedLink then Continue;
    LayoutItem := LayoutControl.FindItem(TControl(CachedBoundsItem[I].Component));
    Assert(LayoutItem <> nil);
    ReportItem := FindReportItemByLayoutItem(LayoutItem);
    Assert(ReportItem <> nil);
    BottomPosition := ReportItem.Cells[0].Height;
    DoCheckBounds(ReportItem.Cells[0], 0);
    if (ADataItem <> nil) and NeedAddBorder then
      with TdxReportCellString(ReportItem.AddDataItem(TdxReportCellString)) do
      begin
        BoundsRect := ReportItem.Cells[0].BoundsRect;
        Width := Width - 1;
        CellSides := [csBottom];
        BorderClass := ADataItem.BorderClass;
        BorderColor := ADataItem.BorderColor;
      end;
  end;
end;

procedure TdxLayoutControlReportLink.PrepareConstruct;
begin
  ClearCachedBounds;
  LayoutControl.ViewInfo.Calculate;
  CacheControlsBounds;
  inherited;
  ClearCachedFonts;
  PrepareLookAndFeels;
end;

procedure TdxLayoutControlReportLink.PrepareLookAndFeels;

  procedure CreateReportLookAndFeel(ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel);
  var
    ReportLookAndFeel: TdxPSReportGroupLookAndFeel;
  begin
    if ALayoutLookAndFeel = nil then Exit;

    AddCaptionOptionsFontToCache(ALayoutLookAndFeel.GroupOptions.CaptionOptions);
    AddCaptionOptionsFontToCache(ALayoutLookAndFeel.ItemOptions.CaptionOptions);

    with LayoutLookAndFeelProducers[ALayoutLookAndFeel] do
    begin
      ReportLookAndFeel := CreateGroupLookAndFeel(ReportLookAndFeelClass, False);
      InitializeReportLookAndFeel(ReportLookAndFeel);
      ReportLookAndFeel.Prepare(ScreenCanvas);
    end;
  end;

  procedure CreateReportLookAndFeels(ALookAndFeels: TList);
  var
    I: Integer;
  begin
    for I := 0 to ALookAndFeels.Count - 1 do
      CreateReportLookAndFeel(TdxCustomLayoutLookAndFeel(ALookAndFeels[I]));
  end;

  procedure EnumerateLayoutGroup(AGroup: TdxLayoutGroup; ALookAndFeels: TList);
  var
    I: Integer;
    Child: TdxCustomLayoutItem;
    LookAndFeel: TdxCustomLayoutLookAndFeel;
  begin
    for I := 0 to AGroup.Count - 1 do
    begin
      Child := AGroup.Items[I];
      if Child.Visible then
      begin
        LookAndFeel := Child.ViewInfo.LayoutLookAndFeel;
        if ALookAndFeels.IndexOf(LookAndFeel) = -1 then
          ALookAndFeels.Add(LookAndFeel);
        if Child is TdxLayoutGroup then
          EnumerateLayoutGroup(TdxLayoutGroup(Child), ALookAndFeels);
      end;
    end;
  end;

var
  LookAndFeels: TList;
begin
  LookAndFeels := TList.Create;
  try
    LookAndFeels.Add(LayoutControl.ViewInfo.LayoutLookAndFeel);
    LookAndFeels.Add(LayoutControl.Items.ViewInfo.LayoutLookAndFeel);
    EnumerateLayoutGroup(LayoutControl.Items, LookAndFeels);

    CreateReportLookAndFeels(LookAndFeels);
  finally
    LookAndFeels.Free;
  end;
end;

procedure TdxLayoutControlReportLink.RepositionControls;
begin
  Producers[LayoutControl].Reposition;
end;

procedure TdxLayoutControlReportLink.AddHiddenItem(ATreeView: TTreeView;
  AParent: TTreeNode; AnItem: TdxCustomLayoutItem);
var
  Index, I: Integer;
begin
  AParent := AddNode(ATreeView, AParent, AnItem, not FindHiddenComponent(AnItem, Index));
  if AnItem is TdxLayoutGroup then
    for I := 0 to TdxLayoutGroup(AnItem).VisibleCount - 1 do
      AddHiddenItem(ATreeView, AParent, TdxLayoutGroup(AnItem).VisibleItems[I]);
end;

procedure TdxLayoutControlReportLink.AddItem(ATreeView: TTreeView;
  AParent: TTreeNode; AnItem: TdxCustomLayoutItem);
var
  Index, I: Integer;
begin
  if not FindHiddenComponent(AnItem, Index) then
  begin
    AParent := AddNode(ATreeView, AParent, AnItem, not FindExcludedComponent(AnItem, Index));
    if AnItem is TdxLayoutGroup then
      for I := 0 to TdxLayoutGroup(AnItem).VisibleCount - 1 do
        AddItem(ATreeView, AParent, TdxLayoutGroup(AnItem).VisibleItems[I]);
  end;
end;

function TdxLayoutControlReportLink.IsComponentEditable(AComponent: TComponent): Boolean;
begin
  Result := inherited IsComponentEditable(AComponent) and (AComponent <> LayoutControl.Items);
end;

procedure TdxLayoutControlReportLink.LoadControlsTree(ATreeView: TTreeView);
begin
  ATreeView.Items.Clear;
  if Container <> nil then
    AddItem(ATreeView, AddNode(ATreeView, nil, Container, True), RootLayoutGroup);
end;

procedure TdxLayoutControlReportLink.LoadHiddenControlsTree(ATreeView: TTreeView);
begin
  ATreeView.Items.Clear;
  if Container <> nil then
    AddHiddenItem(ATreeView, AddNode(ATreeView, nil, Container, True), RootLayoutGroup);
end;

function TdxLayoutControlReportLink.AddBoundsToCache(
  AComponent: TComponent; const ABounds: TRect): Integer;
var
  AItem: TdxLCBoundsCacheItem;
begin
  AItem := TdxLCBoundsCacheItem.Create;
  AItem.Component := AComponent;
  AItem.Bounds := ABounds;
  Result := CachedBounds.Add(AItem);
end;

function TdxLayoutControlReportLink.AddCaptionOptionsFontToCache(ACaptionOptions: TdxLayoutLookAndFeelCaptionOptions): Integer;
var
  Item: PdxPSLayoutCacheFontItem;
begin
  New(Item);
  Item^.CaptionOptions := ACaptionOptions;
  Item^.FontIndex := dxGetPreparedFontIndex(ACaptionOptions, Self, LayoutControl);
  CachedFonts.Add(Item);

  Result := Item^.FontIndex;
end;

procedure TdxLayoutControlReportLink.ClearCachedBounds;
var
  I: Integer;
begin
  for I := 0 to CachedBoundsCount - 1 do
    CachedBoundsItem[I].Free;
  CachedBounds.Clear;
end;

procedure TdxLayoutControlReportLink.ClearCachedFonts;
var
  I: Integer;
begin
  for I := 0 to CachedFontItemCount - 1 do
    Dispose(PdxPSLayoutCacheFontItem(CachedFontItems[I]));
  CachedFonts.Clear;
end;

function TdxLayoutControlReportLink.FindBoundsByComponent(
  AComponent: TComponent; var ABounds: TRect; ASetEmbedded: Boolean): Boolean;
var
  I: Integer;
begin
  Result := AComponent <> nil;
  if not Result then Exit;
  for I := 0 to CachedBoundsCount - 1 do
    if AComponent = CachedBoundsItem[I].Component then
    begin
      ABounds := CachedBoundsItem[I].Bounds;
      CachedBoundsItem[I].EmbeddedLink := ASetEmbedded;
      Exit;
    end;
  Result := False;
end;

function TdxLayoutControlReportLink.FindFontIndexByCaptionOptions(ACaptionOptions: TdxLayoutLookAndFeelCaptionOptions): Integer;
var
  I: Integer;
  Item: PdxPSLayoutCacheFontItem;
begin
  for I := 0 to CachedFontItemCount - 1 do
  begin
    Item := CachedFontItems[I];
    if Item^.CaptionOptions = ACaptionOptions then
    begin
      Result := Item^.FontIndex;
      Exit;
    end;
  end;
  Result := 0;
end;

procedure TdxLayoutControlReportLink.FreeAndNilCachedBounds;
begin
  ClearCachedBounds;
  FreeAndNil(FCachedBounds)
end;

procedure TdxLayoutControlReportLink.FreeAndNilCachedFonts;
begin
  ClearCachedFonts;
  FreeAndNil(FCachedFonts);
end;

procedure TdxLayoutControlReportLink.CreateOptions;
begin
  inherited;
  FOptionsSize := GetOptionsSizeClass.Create(Self);
end;

procedure TdxLayoutControlReportLink.DestroyOptions;
begin
  FreeAndNil(FOptionsSize);
  inherited;
end;

function TdxLayoutControlReportLink.GetOptionsPaginationClass: TdxCustomContainerReportLinkOptionsPaginationClass;
begin
  Result := TdxLayoutControlReportLinkOptionsPagination;
end;

function TdxLayoutControlReportLink.GetOptionsSizeClass: TdxLayoutControlReportLinkOptionsSizeClass;
begin
  Result := TdxLayoutControlReportLinkOptionsSize;
end;

function TdxLayoutControlReportLink.GetOptionsTransparentClass: TdxCustomContainerReportLinkOptionsTransparentClass;
begin
  Result := TdxLayoutControlReportLinkOptionsTransparent;
end;

function TdxLayoutControlReportLink.FindReportGroupLookAndFeel(ALayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSReportGroupLookAndFeel;
begin
  Result := ReportCells.FindGroupLookAndFeelByData(ALayoutLookAndFeel)
end;

function TdxLayoutControlReportLink.FindReportItemByLayoutItem(ALayoutItem: TdxCustomLayoutItem): TdxReportCell;

  function SearchCell(ACell: TdxReportCell): TdxReportCell;
  var
    I: Integer;
  begin
    Result := ACell;
    if TObject(Result.Data) = ALayoutItem then Exit;

    for I := 0 to ACell.CellCount - 1 do
    begin
      Result := SearchCell(ACell[I]);
      if Result <> nil then Exit;
    end;
    Result := nil;
  end;

begin
  Result := SearchCell(RootCell);
end;

procedure TdxLayoutControlReportLink.GetLayoutItemList(AControl: TdxLayoutControl;
  AnItems: TList);

  procedure EnumerateLayoutGroup(AGroup: TdxLayoutGroup);
  var
    I: Integer;
    Item: TdxCustomLayoutItem;
  begin
    for I := 0 to AGroup.VisibleCount - 1 do
    begin
      Item := AGroup.VisibleItems[I];
//      if IsComponentProcessed(Item) then
      begin
        AnItems.Add(Item);
        if Item is TdxLayoutGroup then
          EnumerateLayoutGroup(TdxLayoutGroup(Item));
      end;
    end;
  end;

begin
  if IsComponentProcessed(AControl.Items) then
  begin
    AnItems.Add(AControl.Items);
    EnumerateLayoutGroup(AControl.Items);
  end;
end;

// IdxReportLinkController

function TdxLayoutControlReportLink.GetControlSiteBounds(AControl: TControl): TRect;
var
  LayoutItem: TdxLayoutItem;
  ReportItem: TdxReportCell;
begin
  if not FindBoundsByComponent(AControl, Result, True) then
  begin
    if AControl.Parent <> LayoutControl then
      Result := AControl.ClientRect
    else
    begin
      LayoutItem := LayoutControl.FindItem(AControl);
      Assert(LayoutItem <> nil);
      ReportItem := FindReportItemByLayoutItem(LayoutItem);
      Assert(ReportItem <> nil);
      Result := (ReportItem as TdxReportLayoutItem).ControlBounds;
    end;
  end;
end;

procedure TdxLayoutControlReportLink.AdjustLayoutBounds(const R: TRect);
begin
  LayoutControl.BeginUpdate;
  try
    TcxControlAccess(LayoutControl).FBounds := R;
  finally
    LayoutControl.EndUpdate(False);
  end;
end;

function TdxLayoutControlReportLink.GetAvailableBounds: TRect;
begin
  Result := LayoutControl.ClientBounds;
  if not IsLoading and OptionsSize.AutoWidth then
    with RealPrinterPage.PaintRectPixels do
    begin
      Result.Left := 0;
      Result.Right := Right - Left - 1;
    end;
end;

function TdxLayoutControlReportLink.GetCachedBoundsCount: Integer;
begin
  Result := CachedBounds.Count;
end;

function TdxLayoutControlReportLink.GetCachedBoundsItem(Index: Integer): TdxLCBoundsCacheItem;
begin
  Result := TdxLCBoundsCacheItem(CachedBounds[Index]);
end;

function TdxLayoutControlReportLink.GetCachedFontItem(Index: Integer): PdxPSLayoutCacheFontItem;
begin
  Result := FCachedFonts[Index];
end;

function TdxLayoutControlReportLink.GetCachedFontItemCount: Integer;
begin
  Result := FCachedFonts.Count;
end;

function TdxLayoutControlReportLink.GetCurrentHost: TdxReportCell;
begin
  Result := FindReportItemByLayoutItem(CurrentLayoutItem);
end;

function TdxLayoutControlReportLink.GetLayoutControl: TdxLayoutControl;
begin
  Result := TdxLayoutControl(Container);
end;

function TdxLayoutControlReportLink.GetLayoutItemProducer(LayoutItem: TdxCustomLayoutItem): TdxPSCustomLayoutItemProducer;
begin
  Result := LayoutItemProducerCache[dxPSLayoutItemProducerFactory[LayoutItem], LayoutItem];
end;

function TdxLayoutControlReportLink.GetLayoutLookAndFeelProducer(LayoutLookAndFeel: TdxCustomLayoutLookAndFeel): TdxPSLayoutLookAndFeelProducer;
begin
  Result := LayoutLookAndFeelProducerCache[dxPSLayoutLookAndFeelProducerFactory[LayoutLookAndFeel], LayoutLookAndFeel];
end;

function TdxLayoutControlReportLink.GetOptionsPagination: TdxLayoutControlReportLinkOptionsPagination;
begin
  Result := inherited OptionsPagination as TdxLayoutControlReportLinkOptionsPagination;
end;

function TdxLayoutControlReportLink.GetOptionsTransparent: TdxLayoutControlReportLinkOptionsTransparent;
begin
  Result := inherited OptionsTransparent as TdxLayoutControlReportLinkOptionsTransparent;
end;

function TdxLayoutControlReportLink.GetRootLayoutGroup: TdxLayoutGroup;
begin
  Result := LayoutControl.Items;
end;

procedure TdxLayoutControlReportLink.SetOptionsBehavior(Value: TdxLayoutControlReportLinkOptionsBehavior);
begin
  FOptionsBehavior.Assign(Value);
end;

procedure TdxLayoutControlReportLink.SetOptionsPagination(Value: TdxLayoutControlReportLinkOptionsPagination);
begin
  inherited OptionsPagination := Value;
end;

procedure TdxLayoutControlReportLink.SetOptionsSize(Value: TdxLayoutControlReportLinkOptionsSize);
begin
  OptionsSize.Assign(Value);
end;

procedure TdxLayoutControlReportLink.SetOptionsTransparent(Value: TdxLayoutControlReportLinkOptionsTransparent);
begin
  inherited OptionsTransparent := Value;
end;

{ TdxPSLayoutControlDesignWindow }

procedure TdxPSLayoutControlDesignWindow.DoInitialize;
begin
  inherited;

  with LayoutReportLink.OptionsPagination do
  begin
    chbxPaginateByGroups.Checked := Groups;
    chbxPaginateByItems.Checked := Items;
  end;
  chbxPaginateByGroups.Visible := True;
  chbxPaginateByItems.Visible := True;

  with LayoutReportLink.OptionsTransparent do
  begin
    chbxTransparentGroups.Checked := Groups;
    chbxTransparentItems.Checked := Items;
  end;
  chbxTransparentGroups.Visible := True;
  chbxTransparentItems.Visible := True;

  with LayoutReportLink.OptionsBehavior do
  begin
    chbxExpandedGroups.Checked := ExpandGroups;
    chbxSkipEmptyGroups.Checked := SkipEmptyGroups;
    chbxUnwrapTabs.Checked := UnwrapTabs;
    chbxRiseActiveTabOntoTop.Checked := ActiveTabToTop;
    BehaviorsTab.TabVisible := True;
  end;

  chbxAutoWidth.Checked := LayoutReportLink.OptionsSize.AutoWidth;
  chbxAutoWidth.Visible := True;
  lblSize.Visible := True;
  imgSize.Visible := True;
end;

procedure TdxPSLayoutControlDesignWindow.SetOptionsGroupsByIndex(AnIndex: Integer; AValue: Boolean);
begin
  if LockControlsUpdate then Exit;

  if AnIndex < 2 then
  begin
    case AnIndex of
      0: LayoutReportLink.OptionsBehavior.ExpandGroups := AValue;
      1: LayoutReportLink.OptionsBehavior.SkipEmptyGroups := AValue;
    end;
    Modified := True;
  end
  else
    inherited;
end;

procedure TdxPSLayoutControlDesignWindow.SetOptionsPaginationByIndex(AnIndex: Integer;
  AValue: Boolean);
begin
  if LockControlsUpdate then Exit;

  if AnIndex > 1 then
  begin
    case AnIndex of
      2: LayoutReportLink.OptionsPagination.Groups := AValue;
      3: LayoutReportLink.OptionsPagination.Items := AValue;
    end;
    Modified := True;
  end
  else
    inherited;
end;

procedure TdxPSLayoutControlDesignWindow.SetOptionsSizeByIndex(AnIndex: Integer;
  AValue: Boolean);
begin
  if LockControlsUpdate then Exit;

  inherited;
  if AnIndex = 0 then
  begin
    LayoutReportLink.OptionsSize.AutoWidth := AValue;
    Modified := True;
  end;
end;

procedure TdxPSLayoutControlDesignWindow.SetOptionsTabsByIndex(AnIndex: Integer; AValue: Boolean);
begin
  if LockControlsUpdate then Exit;
  if AnIndex < 2 then
  begin
    case AnIndex of
      0: LayoutReportLink.OptionsBehavior.UnwrapTabs := AValue;
      1: LayoutReportLink.OptionsBehavior.ActiveTabToTop := AValue;
    end;
    Modified := True;
  end
  else
    inherited;
end;

procedure TdxPSLayoutControlDesignWindow.SetOptionsTransparentByIndex(AnIndex: Integer;
  AValue: Boolean);
begin
  if LockControlsUpdate then Exit;

  if AnIndex > 3 then
  begin
    case AnIndex of
      4: LayoutReportLink.OptionsTransparent.Groups := AValue;
      5: LayoutReportLink.OptionsTransparent.Items := AValue;
    end;
    Modified := True;
  end
  else
    inherited;
end;

procedure TdxPSLayoutControlDesignWindow.InitializeControlsTree;
var
  Root: TTreeNode;
begin
  inherited;
  Root := TreeView_GetRoot(tvControls.InnerTreeView);
  if (Root <> nil) and (Root.Count <> 0) then
    Root[0].Expand(False);
end;

procedure TdxPSLayoutControlDesignWindow.InitializeHiddenControlsTree;
var
  Root: TTreeNode;
begin
  inherited;
  Root := TreeView_GetRoot(tvHiddenControls.InnerTreeView);
  if (Root <> nil) and (Root.Count <> 0) then
    Root[0].Expand(False);
end;

function TdxPSLayoutControlDesignWindow.IsBoldNode(ANode: TTreeNode): Boolean;
begin
  Result := inherited IsBoldNode(ANode) or (TreeView_GetNodeObject(ANode).Component is TdxLayoutGroup);
end;

function TdxPSLayoutControlDesignWindow.GetLayoutReportLink: TdxLayoutControlReportLink;
begin
  Result := TdxLayoutControlReportLink(ReportLink);
end;

procedure RegisterAssistants;
begin
  TdxPSLayoutLookAndFeelProducer.Register;
  TdxPSLayoutStandardLookAndFeelProducer.Register;
  TdxPSLayoutOfficeLookAndFeelProducer.Register;
  TdxPSLayoutWebLookAndFeelProducer.Register;

  TdxPSCustomLayoutItemProducer.Register;
  TdxPSLayoutGroupProducer.Register;
  TdxPSLayoutLabeledItemProducer.Register;
  TdxPSLayoutEmptySpaceItemProducer.Register;
  TdxPSLayoutSeparatorItemProducer.Register;
  TdxPSLayoutSplitterItemProducer.Register;
  TdxPSLayoutItemProducer.Register;

  TdxPSLayoutControlProducer.Register;

  TdxPSNativeLayoutControlProducer.Register;
end;

procedure RegisterItems;
begin
  TdxReportLayoutControlHost.Register;
  TdxCustomReportLayoutItem.Register;
  TdxReportLayoutGroup.Register;
  TdxReportLayoutLabeledItem.Register;
  TdxReportLayoutEmptySpaceItem.Register;
  TdxReportLayoutSeparatorItem.Register;
  TdxReportLayoutSplitterItem.Register;
  TdxReportLayoutItem.Register;
end;

procedure UnregisterAssistants;
begin
  TdxPSNativeLayoutControlProducer.Unregister;

  TdxPSLayoutControlProducer.Unregister;

  TdxPSLayoutItemProducer.Unregister;
  TdxPSLayoutSplitterItemProducer.Unregister;
  TdxPSLayoutSeparatorItemProducer.Unregister;
  TdxPSLayoutEmptySpaceItemProducer.Unregister;
  TdxPSLayoutLabeledItemProducer.Unregister;
  TdxPSLayoutGroupProducer.Unregister;
  TdxPSCustomLayoutItemProducer.Unregister;

  TdxPSLayoutWebLookAndFeelProducer.Unregister;
  TdxPSLayoutOfficeLookAndFeelProducer.Unregister;
  TdxPSLayoutStandardLookAndFeelProducer.Unregister;
  TdxPSLayoutLookAndFeelProducer.Unregister;

  TdxPSLayoutItemProducerFactory.ReleaseInstance;
  TdxPSLayoutLookAndFeelProducerFactory.ReleaseInstance;
end;

procedure UnregisterItems;
begin
  TdxReportLayoutItem.Unregister;
  TdxReportLayoutSplitterItem.Unregister;
  TdxReportLayoutSeparatorItem.Unregister;
  TdxReportLayoutEmptySpaceItem.Unregister;
  TdxReportLayoutLabeledItem.Unregister;
  TdxReportLayoutGroup.Unregister;
  TdxCustomReportLayoutItem.Unregister;
  TdxReportLayoutControlHost.Unregister;
end;

initialization
  FPreparationFont := TFont.Create;
  RegisterAssistants;
  RegisterItems;

  dxPSRegisterReportLink(TdxLayoutControlReportLink, TdxLayoutControl, TdxPSLayoutControlDesignWindow);

finalization
  dxPSUnregisterReportLink(TdxLayoutControlReportLink, TdxLayoutControl, TdxPSLayoutControlDesignWindow);

  UnregisterItems;
  UnregisterAssistants;
  FreeAndNil(FPreparationFont);

end.
