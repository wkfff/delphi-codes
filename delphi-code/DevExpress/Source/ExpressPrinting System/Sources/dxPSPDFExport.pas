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

unit dxPSPDFExport;

interface

{$I cxVer.inc}

uses
  Windows, Classes, SysUtils, Graphics, cxGraphics, dxPSCore, dxBkGnd, cxClasses,
  dxPrnPg, dxPSPDFExportCore, dxPSReportRenderCanvas, cxDrawTextUtils, cxGeometry,
  dxPSFillPatterns, dxPSGlbl, dxPrnDlg;

type
  TdxPSPDFReportRenderCanvas = class;

  { TdxPSPDFReportExportProvider }

  TdxPSPDFReportExportProvider = class(TdxPSCustomReportExportProvider)
  private
    FOptions: TdxPSPDFReportExportOptions;
    FPage: TdxPSPDFPage;
    FPageContent: TdxPSPDFPageContent;
    FPDFFile: TdxPSPDFFile;
    procedure SetOptions(AOptions: TdxPSPDFReportExportOptions);
    procedure SetPage(AValue: TdxPSPDFPage);
  protected
    procedure AssignSettings(APDFFile: TdxPSPDFFile);
    procedure ExportPage(APageIndex: Integer); virtual;
    function ScaleValue(AValue: Integer): Integer;
  public
    constructor Create(AReportLink: TBasedxReportLink); override;
    destructor Destroy; override;
    procedure Build; override;
    procedure SaveToStream(AStream: TStream); override;
    //
    property Options: TdxPSPDFReportExportOptions read FOptions write SetOptions;
    property Page: TdxPSPDFPage read FPage write SetPage;
    property PageContent: TdxPSPDFPageContent read FPageContent;
    property PDFFile: TdxPSPDFFile read FPDFFile;
  end;

  { TdxPSPDFReportRenderCanvas }

  TdxPSPDFReportRenderCanvas = class(TdxPSReportRenderScreenCanvas)
  private
    FCustomDrawBounds: TRect;
    FCustomDrawMetaFile: TMetafile;
    FCustomDrawMetaFileCanvas: TMetafileCanvas;
    FPageSize: TPoint;
    FProvider: TdxPSPDFReportExportProvider;
    FRegion: TcxRegion;
    FSavedRegions: TcxObjectList;
    FTextWidthConversionFactor: Double;
    function AbsoluteRect(const R: TRect): TRect;
    function GetPageContent: TdxPSPDFPageContent;
    procedure InternalDrawText(const ABounds: TRect; const AText: string;
      AFont: TFont; ATextColor: TColor; AFormat: TcxTextOutFormat; AMaxLineCount: Integer;
      AVertical: Boolean; ADirection: TcxVerticalTextOutDirection);
    procedure InternalFillRect(const R: TRect; ABackColor, AForeColor: TColor;
      APattern: TdxPSFillPatternClass; APatternBrush: TBrush);
    procedure SelectFont(AFont: TFont; ATextColor: TColor);
  protected
    procedure DrawPictureStretch(APicture: TGraphic;
      const R: TRect; ANumerator, ADenominator: Integer); override;
    procedure DrawPictureTile(APicture: TGraphic; const R: TRect;
      APictureWidth, APictureHeight, ANumerator, ADenominator: Integer); override;
    function GetIsPrinterCanvas: Boolean; override;
    function GetSupportsTransparentImagesDrawing: Boolean; override;
    //
    property TextWidthConversionFactor: Double read FTextWidthConversionFactor;
  public
    constructor Create(AProvider: TdxPSPDFReportExportProvider);
    destructor Destroy; override;
    function CalculateLineThickness(AUnitsPerPixel, AUnitsPerPoint: Integer): Integer; override;
    procedure DeviceToLogicalCoordinates(var R: TRect); override;
    procedure LogicalToDeviceCoordinates(var R: TRect); override;
    procedure SetCanvasExts(const APageSize: TPoint; AMappingMode: TdxPSReportRenderCanvasMappingMode;
      AScaleNumerator, AScaleDenominator: Integer; const AViewPort: TRect); override;
    procedure ResetPageRegion;
    procedure PrepareLogicalUnits; override;
    procedure UnprepareLogicalUnits; override;
    // Custom Draw
    function BeginCustomDraw(const AClipBounds: TRect;
      AFont: TFont; AColor: TColor): TCanvas; override;
    procedure EndCustomDraw(var ACanvas: TCanvas); override;
    //
    function ExcludeClipRect(const R: TRect): Integer; override;
    function IntersectClipRgn(const R: TRect): Integer; override;
    procedure IntersectClipRgnEx(ARegion: HRGN);
    procedure RestoreClipRgn; override;
    procedure RestoreState; override;
    procedure SaveClipRgn; override;
    procedure SaveState; override;
    procedure SetClipRect(const R: TRect); override;
    // Text
    function CalculateTextRect(const AText: string; var R: TRect;
      AFormat: TcxTextOutFormat = CXTO_DEFAULT_FORMAT; AFont: TFont = nil;
      AMaxLineCount: Integer = 0; ALeftIndent: Integer = 0; ARightIndent: Integer = 0;
      ATextColor: TColor = clDefault): Integer; override;
    procedure DrawText(var R: TRect; const AText: string; AFont: TFont;
      AFormat: DWORD; ATextColor: TColor = clDefault; AMaxLineCount: Integer = 0); override;
    procedure DrawTextLine(const ATextRect, AClipBounds: TRect; ATextWidth: Integer;
      const AText: WideString; ATextColor: TColor = clDefault;
      ADirection: TcxRotationAngle = ra0; ABreakExtraSpacing: Integer = 0);
    procedure RotatedTextOut(const ABounds: TRect; const AText: string;
      AFont: TFont; AAlignHorz: TcxTextAlignX = taCenterX;
      AAlignVert: TcxTextAlignY = taCenterY; AWordBreak: Boolean = True;
      ADirection: TcxVerticalTextOutDirection = vtdBottomToTop); override;
    //
    procedure DrawEllipseFrame(const R: TRect; AColor: TColor; AThickness: Integer); override;
    procedure DrawExpandButton(R: TRect; AEdgeStyle: TdxCheckButtonEdgeStyle;
      AMarlettFont, ASymbolFont: TFont; AExpanded, AShadow, AFillInterior: Boolean;
      ABorderColor, ABackgroundColor: TColor; ALineThickness: Integer); override;
    procedure DrawFrame(const R: TRect; ATopLeftColor, ARightBottomColor: TColor;
      ABorderWidth: Integer = 1; ABorders: TcxBorders = cxBordersAll); override;
    procedure DrawRoundFrame(const R: TRect; AEllipseWidth, AEllipseHeight: Integer;
      AColor: TColor; AThickness: Integer);  override;
    procedure FillEdge(ARegion: HRGN; ABackColor: TColor; AEdgeColor: TColor;
      AIsVerticalOrientation: Boolean; AEdgePattern: TClass); override;
    procedure FillEllipse(const R: TRect; ABackColor, AForeColor: TColor;
      APattern: TdxPSFillPatternClass; APatternBrush: TBrush); override;
    procedure FillRect(const R: TRect; AColor: TColor); override;
    procedure FillRectEx(const R: TRect; AColor: TColor;
      APattern: TdxPSFillPatternClass; APatternBrush: TBrush); virtual;
    procedure FillRegion(ARegion: HRGN; ABackColor, AForeColor: TColor;
      APattern: TdxPSFillPatternClass; APatternBrush: TBrush); override;
    procedure FillRoundRect(R: TRect; AEllipseWidth, AEllipseHeight: Integer;
      ABackColor, AForeColor: TColor; APattern: TdxPSFillPatternClass; APatternBrush: TBrush); override;
    function IsRectVisible(const R: TRect): Boolean; override;
    procedure Pie(const R: TRect; const APoint1, APoint2: TPoint; AColor: TColor);
    procedure Polyline(const APoints: array of TPoint; AColor: TColor; ALineWidth: Integer); override;
    procedure Polygon(const APoints: array of TPoint; AColor: TColor;
      ABackgroundColor: TColor; ALineWidth: Integer; AFillMode: Integer = ALTERNATE); override;
    //
    property PageContent: TdxPSPDFPageContent read GetPageContent;
    property PageSize: TPoint read FPageSize;
    property Provider: TdxPSPDFReportExportProvider read FProvider;
    property Region: TcxRegion read FRegion;
  end;

function dxPSExportToPDF(AReportLink: TBasedxReportLink): Boolean;
function dxPSExportToPDFStream(AStream: TStream; AReportLink: TBasedxReportLink;
  AShowSettingsDialog: Boolean = True; ADefaultSettings: TdxPSPDFReportExportOptions = nil): Boolean;
function dxPSExportToPDFFile(const AFileName: string; AReportLink: TBasedxReportLink;
  AShowSettingsDialog: Boolean = True; ADefaultSettings: TdxPSPDFReportExportOptions = nil): Boolean; 
implementation

uses
  Types, Math, Dialogs, ShellApi, dxCore, dxPSPDFExportDialog, dxPSPDFMetaFileParser,
  dxPSEdgePatterns, dxPSPDFStrings, cxControls;

const
  sdxPdfSaveDialogFilter = 'PDF Document (*.pdf)|*.pdf;';

type
  TBasedxReportLinkAccess = class(TBasedxReportLink);

  { TdxPSPDFExportCustomTextHelper }

  TdxPSPDFExportCustomTextHelper = class(TObject)
  private
    FHasEndEllipsis: Boolean;
    FPDFCanvas: TdxPSPDFReportRenderCanvas;
    FRows: TcxTextRows;
    FTextParams: TcxTextParams;
    function GetLastTextRow: PcxTextRow;
    function GetTextRow(Index: Integer): PcxTextRow;
    function GetTextRowCount: Integer;
    function GetTextRowText(Index: Integer): WideString;
  public
    constructor Create(APDFCanvas: TdxPSPDFReportRenderCanvas; ATextFormat: Cardinal); virtual;
    function CalculateBreakExtractSpacing(const AWidth: Integer; ARow: PcxTextRow): Integer; virtual;
    function CalculateTextRect(const ABounds: TRect): TRect; virtual; abstract;
    function CalculateTextRowOutRect(ATextRow: PcxTextRow; var R: TRect;
      out ABreakExtraSpacing: Integer): TRect; virtual; abstract;
    function CalculateTextOutParams(const ABounds: TRect;
      AMaxLineCount: Integer; const AText: string): TRect; virtual;
    function CalculateTotalTextHeight: Integer;
    procedure CalculateEndEllipsis(DC: HDC; const R: TRect; ARow: PcxTextRow);
    //
    property PDFCanvas: TdxPSPDFReportRenderCanvas read FPDFCanvas;
    property LastTextRow: PcxTextRow read GetLastTextRow;
    property TextParams: TcxTextParams read FTextParams;
    property TextRow[Index: Integer]: PcxTextRow read GetTextRow;
    property TextRowCount: Integer read GetTextRowCount;
    property TextRowText[Index: Integer]: WideString read GetTextRowText;
  end;

  { TdxPSPDFExportHorizontalTextHelper }

  TdxPSPDFExportHorizontalTextHelper = class(TdxPSPDFExportCustomTextHelper)
  public
    function CalculateTextRect(const ABounds: TRect): TRect; override;
    function CalculateTextRowOutRect(ATextRow: PcxTextRow;
      var R: TRect; out ABreakExtraSpacing: Integer): TRect; override;
  end;

  { TdxPSPDFExportVerticalTextHelper }

  TdxPSPDFExportVerticalTextHelper = class(TdxPSPDFExportCustomTextHelper)
  public
    function CalculateTextRect(const ABounds: TRect): TRect; override;
    function CalculateTextRowOutRect(ATextRow: PcxTextRow;
      var R: TRect; out ABreakExtraSpacing: Integer): TRect; override;
    function CalculateTextOutParams(const ABounds: TRect;
      AMaxLineCount: Integer; const AText: string): TRect; override;
  end;

  { TdxPSPDFEdgePattern }

  TdxPSPDFEdgePattern = class(TdxPSPDFCustomPattern)
  private
    FColor: TColor;
    FLines: TRects;
  protected
    function GetContentData: string; override;
    procedure InitializePixels(APattern: TdxPSEdgePatternClass; AIsVertical: Boolean);
    //
    property Color: TColor read FColor;
  public
    constructor Create(AOwner: TdxPSPDFPatternList; AColor: TColor;
      AEdgePattern: TdxPSEdgePatternClass; AIsVertical: Boolean);
    destructor Destroy; override;
  end;

function dxPDFCalcTextRowExtents(AHandle: TCanvasHandle; AText: PWideChar;
  ATextLength: Integer; AExpandTabs: Boolean; PDFCanvas: TdxPSPDFReportRenderCanvas): TSize;
var
  AWideStr: WideString;
begin
  SetString(AWideStr, AText, ATextLength);
  Result := cxCalcTextExtents(AHandle, AText, ATextLength, AExpandTabs);
  Result.cx := Round(PDFCanvas.PageContent.TextWidth(AWideStr) * PDFCanvas.TextWidthConversionFactor);
end;

function dxPSExportToPDF(AReportLink: TBasedxReportLink): Boolean;
var
  ADestFileName: string;
  AOptions: TdxPSPDFReportExportOptions;
  ASaveDialog: TSaveDialog;
begin
  AOptions := AReportLink.PDFExportOptions;
  Result := dxPSShowPDFSettingsDialog(AOptions);
  if Result then
  begin
    ASaveDialog := TSaveDialog.Create(nil);
    try
      ASaveDialog.Filter := sdxPDFSaveDialogFilter;
      ASaveDialog.InitialDir := ExtractFilePath(AOptions.DefaultFileName);
      ASaveDialog.FileName := ExtractFileName(AOptions.DefaultFileName);
      ASaveDialog.Options := ASaveDialog.Options + [ofOverwritePrompt];
      ASaveDialog.DefaultExt := sdxPDFExt;
      Result := ASaveDialog.Execute;
      if Result then
      begin
        ADestFileName := ChangeFileExt(ASaveDialog.FileName, sdxPDFExt);
        Result := dxPSExportToPDFFile(ADestFileName, AReportLink, False, AOptions);
        if Result and AReportLink.PDFExportOptions.OpenDocumentAfterExport then
          ShellExecute(0, 'open', PChar(ADestFileName), '', '', SW_SHOW);
      end;
    finally
      ASaveDialog.Free;
    end;
  end;
end;

function dxPSExportToPDFStream(AStream: TStream;
  AReportLink: TBasedxReportLink; AShowSettingsDialog: Boolean = True;
  ADefaultSettings: TdxPSPDFReportExportOptions = nil): Boolean;
var
  AProvider: TdxPSPDFReportExportProvider;
begin
  AProvider := TdxPSPDFReportExportProvider.Create(AReportLink);
  try
    if Assigned(ADefaultSettings) then
      AProvider.Options := ADefaultSettings
    else
      AProvider.Options := AReportLink.PDFExportOptions;

    if AShowSettingsDialog then
      Result := dxPSShowPDFSettingsDialog(AProvider.Options)
    else
      Result := True;
      
    if Result then
    begin
      AProvider.Build;
      AProvider.SaveToStream(AStream);
    end;
  finally
    AProvider.Free;
  end;
end;

function dxPSExportToPDFFile(const AFileName: string;
  AReportLink: TBasedxReportLink; AShowSettingsDialog: Boolean = True;
  ADefaultSettings: TdxPSPDFReportExportOptions = nil): Boolean;
var
  AStream: TFileStream;
begin
  Result := False;
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    Result := dxPSExportToPDFStream(AStream,
      AReportLink, AShowSettingsDialog, ADefaultSettings);
  finally
    FreeAndNil(AStream);
    if not Result then
      DeleteFile(AFileName);
  end;
end;

function CreateTextExportHelper(ACanvas: TdxPSPDFReportRenderCanvas;
  AFormat: TcxTextOutFormat; AVertical: Boolean): TdxPSPDFExportCustomTextHelper;
begin
  if AVertical then
    Result := TdxPSPDFExportVerticalTextHelper.Create(ACanvas, AFormat)
  else
    Result := TdxPSPDFExportHorizontalTextHelper.Create(ACanvas, AFormat);
end;

{ TdxPSPDFEdgePattern }

constructor TdxPSPDFEdgePattern.Create(AOwner: TdxPSPDFPatternList;
  AColor: TColor; AEdgePattern: TdxPSEdgePatternClass; AIsVertical: Boolean);
begin
  inherited Create(AOwner, AEdgePattern.SignificantBitCount, AEdgePattern.SignificantBitCount);
  InitializePixels(AEdgePattern, AIsVertical);
  FColor := AColor;
end;

destructor TdxPSPDFEdgePattern.Destroy;
begin
  SetLength(FLines, 0);
  inherited Destroy;
end;

function TdxPSPDFEdgePattern.GetContentData: string;

  function GetLinesData: string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to Length(FLines) - 1 do
      Result := Result + dxPDFEncodeBounds(FLines[I], PatternHeight) + sdxPDFSpace;
  end;

begin
  Result := Format('%s rg %s f', [dxPDFEncodeColor(Color), GetLinesData]);
end;

procedure TdxPSPDFEdgePattern.InitializePixels(
  APattern: TdxPSEdgePatternClass; AIsVertical: Boolean);

  function CompactLine(var APrev, ACurrent: TRect): Boolean;
  begin
    Result := True;
    if (APrev.Top = ACurrent.Top) and
       (APrev.Bottom = ACurrent.Bottom) and
       (APrev.Right = ACurrent.Left)
    then
      APrev.Right := ACurrent.Right
    else
      if (APrev.Left = ACurrent.Left) and
         (APrev.Right = ACurrent.Right) and
         (APrev.Bottom = ACurrent.Top)
      then
        APrev.Bottom := ACurrent.Bottom
      else
        Result := False;
  end;

var
  AIndex: Integer;
  ASize, I, J: Integer;
begin
  AIndex := 0;
  ASize := APattern.SignificantBitCount;
  SetLength(FLines, ASize * ASize);
  for I := 0 to ASize - 1 do
  begin
    for J := 0 to ASize - 1 do
      if APattern.Bits(Ord(Odd(J))) and (1 shl I) <> 0 then
      begin
        if AIsVertical then
          FLines[AIndex] := Bounds(J, I, 1, 1)
        else
          FLines[AIndex] := Bounds(I, J, 1, 1);
        if (AIndex = 0) or not CompactLine(FLines[AIndex - 1], FLines[AIndex]) then
          Inc(AIndex);
      end;
  end;
  I := AIndex - 1;
  while I > 1 do
  begin
    if CompactLine(FLines[I - 1], FLines[I]) then
      Dec(AIndex);
    Dec(I);
  end;
  SetLength(FLines, AIndex);
end;

{ TdxPSPDFExportCustomTextHelper }

constructor TdxPSPDFExportCustomTextHelper.Create(
  APDFCanvas: TdxPSPDFReportRenderCanvas; ATextFormat: Cardinal);
begin
  inherited Create;
  FPDFCanvas := APDFCanvas;
  FTextParams := PDFCanvas.CalculateTextParams(ATextFormat or CXTO_CALCROWCOUNT);
end;

function TdxPSPDFExportCustomTextHelper.CalculateBreakExtractSpacing(
  const AWidth: Integer; ARow: PcxTextRow): Integer;
begin
  if ARow.BreakCount > 0 then
    Result := (AWidth - ARow.TextExtents.cx) div ARow.BreakCount
  else
    Result := 0;
end;

function TdxPSPDFExportCustomTextHelper.CalculateTextOutParams(
  const ABounds: TRect; AMaxLineCount: Integer; const AText: string): TRect;
var
  ATextRowCount: Integer;
begin
  Result := cxPrepareRect(ABounds, TextParams, 0, 0);
  cxMakeTextRows(PDFCanvas.Canvas.Handle, PChar(AText), Length(AText), Result,
    TextParams, FRows, ATextRowCount, AMaxLineCount);
  if TextParams.EndEllipsis and (TextRowCount > 0) then
    CalculateEndEllipsis(PDFCanvas.Canvas.Handle, ABounds, LastTextRow);
  Result := CalculateTextRect(Result);
end;

procedure TdxPSPDFExportCustomTextHelper.CalculateEndEllipsis(
  DC: HDC; const R: TRect; ARow: PcxTextRow);
var
  AWidth: Integer;
begin
  AWidth := cxRectWidth(R);
  FHasEndEllipsis := ARow^.TextExtents.cx > AWidth;
  if FHasEndEllipsis then
  begin
    cxPrepareEndEllipsis(DC, ARow, TextParams, @dxPDFCalcTextRowExtents, AWidth, PDFCanvas);
    Inc(ARow^.TextExtents.cx, TextParams.EndEllipsisWidth);
  end;
end;

function TdxPSPDFExportCustomTextHelper.CalculateTotalTextHeight: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to TextRowCount - 1 do
    Inc(Result, TextRow[I].TextExtents.cy);
end;

function TdxPSPDFExportCustomTextHelper.GetLastTextRow: PcxTextRow;
begin
  Result := TextRow[TextRowCount - 1];
end;

function TdxPSPDFExportCustomTextHelper.GetTextRow(Index: Integer): PcxTextRow;
begin
  Result := cxGetTextRow(FRows, Index);
end;

function TdxPSPDFExportCustomTextHelper.GetTextRowCount: Integer;
begin
  Result := FRows.Count;
end;

function TdxPSPDFExportCustomTextHelper.GetTextRowText(Index: Integer): WideString;
var
  ARow: PcxTextRow;
begin
  ARow := TextRow[Index];
  if Assigned(ARow) then
  begin
    SetString(Result, ARow^.Text, ARow^.TextLength);
    if FHasEndEllipsis and (Index = TextRowCount - 1) then
      Result := Result + '...';
    if FTextParams.HidePrefix then
      Result := RemoveAccelChars(Result, False);
  end
  else
    Result := '';
end;

{ TdxPSPDFExportHorizontalTextHelper }

function TdxPSPDFExportHorizontalTextHelper.CalculateTextRect(const ABounds: TRect): TRect;
var
  AHeight: Integer;
begin
  Result := ABounds;
  AHeight := CalculateTotalTextHeight;
  case TextParams.TextAlignY of
    taCenterY:
      Result := cxRectCenter(ABounds, cxRectWidth(ABounds), AHeight);
    taBottom:
      Result.Top := Result.Bottom - AHeight;
  end;
  if TextParams.PreventTopExceed then
    Result := cxRectSetTop(Result, Max(Result.Top, ABounds.Top));
end;

function TdxPSPDFExportHorizontalTextHelper.CalculateTextRowOutRect(
  ATextRow: PcxTextRow; var R: TRect; out ABreakExtraSpacing: Integer): TRect;
var
  APoint: TPoint;
  ASize: TSize;
begin
  APoint := R.TopLeft;
  ABreakExtraSpacing := 0;
  ASize := ATextRow.TextExtents;
  case TextParams.TextAlignX of
    taCenterX:
      APoint.X := Max(R.Left, (R.Right + R.Left - ASize.cx) div 2);
    taRight:
      APoint.X := R.Right - ASize.cx;
    taJustifyX, taDistributeX:
      begin
        ASize.cx := cxRectWidth(R);
        ABreakExtraSpacing := CalculateBreakExtractSpacing(ASize.cx, ATextRow);
      end;
  end;
  Inc(R.Top, ASize.cy);
  if TextParams.PreventLeftExceed then
    APoint.X := Max(APoint.X, R.Left);
  Result := Bounds(APoint.X, APoint.Y, ASize.cx, ASize.cy);
end;

{ TdxPSPDFExportVerticalTextHelper }

function TdxPSPDFExportVerticalTextHelper.CalculateTextRect(const ABounds: TRect): TRect;
var
  AHeight: Integer;
begin
  Result := ABounds;
  AHeight := CalculateTotalTextHeight;
  case TextParams.TextAlignY of
    taCenterY:
      Result := cxRectCenter(ABounds, AHeight, cxRectHeight(ABounds));
    taBottom:
      Result.Left := Result.Right - AHeight
  end;
end;

function TdxPSPDFExportVerticalTextHelper.CalculateTextRowOutRect(
  ATextRow: PcxTextRow; var R: TRect; out ABreakExtraSpacing: Integer): TRect;
var
  APoint: TPoint;
  ASize: TSize;
begin
  ABreakExtraSpacing := 0;
  APoint := Point(R.Left, R.Bottom);
  ASize := ATextRow.TextExtents;
  case TextParams.TextAlignX of
    taCenterX:
      APoint.Y := Max(R.Top, (R.Bottom + R.Top + ASize.cx) div 2);
    taRight:
      APoint.Y := R.Top + ATextRow.TextExtents.cx;
    taJustifyX, taDistributeX:
      begin
        ASize.cx := cxRectHeight(R);
        ABreakExtraSpacing := CalculateBreakExtractSpacing(ASize.cx, ATextRow);
      end;
  end;
  Inc(R.Left, ASize.cy);
  if TextParams.PreventLeftExceed then
    APoint.Y := Max(APoint.Y, R.Top);
  Result := Bounds(APoint.X, APoint.Y, ASize.cy, ASize.cx);
end;

function TdxPSPDFExportVerticalTextHelper.CalculateTextOutParams(
  const ABounds: TRect; AMaxLineCount: Integer; const AText: string): TRect;
begin
  Result := inherited CalculateTextOutParams(cxRectRotate(ABounds), AMaxLineCount, AText);
end;

{ TdxPSPDFReportExportProvider }

constructor TdxPSPDFReportExportProvider.Create(AReportLink: TBasedxReportLink);
begin
  inherited Create(AReportLink);
  FOptions := TdxPSPDFReportExportOptions.Create;
  FPDFFile := TdxPSPDFFile.Create;
end;

destructor TdxPSPDFReportExportProvider.Destroy;
begin
  FreeAndNil(FOptions);
  FreeAndNil(FPDFFile);
  inherited Destroy;
end;

procedure TdxPSPDFReportExportProvider.AssignSettings(APDFFile: TdxPSPDFFile);
begin
  APDFFile.EmbedFonts := Options.EmbedFonts;
  APDFFile.UseCIDFonts := Options.UseCIDFonts;
  APDFFile.JPEGQuality := Options.JPEGQuality;
  APDFFile.CompressStreams := Options.CompressStreams;
  APDFFile.UseJPEGCompression := Options.UseJPEGCompression;
  APDFFile.DocumentInfo.Author := Options.Author;
  APDFFile.DocumentInfo.Creator := Options.Creator;
  APDFFile.DocumentInfo.Keywords := Options.Keywords;
  APDFFile.DocumentInfo.Subject := Options.Subject;
  APDFFile.DocumentInfo.Title := Options.Title;
  APDFFile.DocumentInfo.Producer := 'ExpressPrinting System';
  APDFFile.SecurityOptions.Assign(Options.SecurityOptions);
end;

procedure TdxPSPDFReportExportProvider.Build;
var
  APageIndex: Integer;
begin
  AssignSettings(PDFFile);
  ReportLink.IsCurrentLink := True;
  ReportLink.RebuildReport;

  case Options.PageRangeInfo.PageRanges of
    prCurrent:
      ExportPage(ReportLink.CurrentPage - 1);
    prAll:
      for APageIndex := 0 to ReportLink.PageCount - 1 do
        ExportPage(APageIndex);
    prRange:
      for APageIndex := 0 to Options.PageRangeInfo.PageIndexCount - 1 do
        ExportPage(Options.PageRangeInfo.PageIndex[APageIndex] - 1);
  end;
end;

procedure TdxPSPDFReportExportProvider.ExportPage(APageIndex: Integer);
var
  ACanvas: TdxPSPDFReportRenderCanvas;
begin
  if (APageIndex >= 0) and (APageIndex < ReportLink.PageCount) then
  begin
    ACanvas := TdxPSPDFReportRenderCanvas.Create(Self);
    try
      Page := PDFFile.AddPage;
      Page.PageWidth := ScaleValue(RenderInfo.PageSize.X);
      Page.PageHeight := ScaleValue(RenderInfo.PageSize.Y);
      TBasedxReportLinkAccess(ReportLink).PaintPageEx(
        ACanvas, Page.PageBounds, APageIndex, APageIndex, 100);
    finally
      ACanvas.Free;
    end;
  end;
end;

procedure TdxPSPDFReportExportProvider.SaveToStream(AStream: TStream);
begin
  PDFFile.SaveToStream(AStream);
end;

function TdxPSPDFReportExportProvider.ScaleValue(AValue: Integer): Integer;
begin
  Result := MulDiv(AValue, RenderInfo.PointsPerInch, RenderInfo.UnitsPerInch);
end;

procedure TdxPSPDFReportExportProvider.SetOptions(AOptions: TdxPSPDFReportExportOptions);
begin
  FOptions.Assign(AOptions);
end;

procedure TdxPSPDFReportExportProvider.SetPage(AValue: TdxPSPDFPage);
begin
  if FPage <> AValue then
  begin
    FPage := AValue;
    if FPage = nil then
      FPageContent := nil
    else
      FPageContent := FPage.Content;
  end;
end;

{ TdxPSPDFReportRenderCanvas }

constructor TdxPSPDFReportRenderCanvas.Create(AProvider: TdxPSPDFReportExportProvider);
const
  MaxRegionSize = 30000;
begin
  inherited Create;
  FProvider := AProvider;
  FRegion := TcxRegion.Create(Bounds(0, 0, MaxRegionSize, MaxRegionSize));
  FSavedRegions := TcxObjectList.Create;
  FTextWidthConversionFactor := 1;
end;

destructor TdxPSPDFReportRenderCanvas.Destroy;
begin
  FreeAndNil(FSavedRegions);
  FreeAndNil(FRegion);
  inherited Destroy;
end;

function TdxPSPDFReportRenderCanvas.CalculateLineThickness(
  AUnitsPerPixel, AUnitsPerPoint: Integer): Integer;
begin
  Result := AUnitsPerPixel;
end;

procedure TdxPSPDFReportRenderCanvas.DeviceToLogicalCoordinates(var R: TRect);
begin
  R.Top := MulDiv(R.Top, PixelsNumerator, PixelsDenominator);
  R.Left := MulDiv(R.Left, PixelsNumerator, PixelsDenominator);
  R.Right := MulDiv(R.Right, PixelsNumerator, PixelsDenominator);
  R.Bottom := MulDiv(R.Bottom, PixelsNumerator, PixelsDenominator);
end;

procedure TdxPSPDFReportRenderCanvas.LogicalToDeviceCoordinates(var R: TRect);
begin
  R.Top := MulDiv(R.Top, PixelsDenominator, PixelsNumerator);
  R.Left := MulDiv(R.Left, PixelsDenominator, PixelsNumerator);
  R.Right := MulDiv(R.Right, PixelsDenominator, PixelsNumerator);
  R.Bottom := MulDiv(R.Bottom, PixelsDenominator, PixelsNumerator);
end;

procedure TdxPSPDFReportRenderCanvas.SetCanvasExts(
  const APageSize: TPoint; AMappingMode: TdxPSReportRenderCanvasMappingMode;
  AScaleNumerator, AScaleDenominator: Integer; const AViewPort: TRect);
var
  AScaleFactor: Double;
begin
  inherited SetCanvasExts(APageSize, AMappingMode, AScaleNumerator, AScaleDenominator, AViewPort);
  AScaleFactor := AScaleDenominator / AScaleNumerator;
  PageContent.CoordsConversionFactor := cxRectWidth(AViewPort) / APageSize.X * AScaleFactor;
  FPageSize := Point(Round(APageSize.X / AScaleFactor), Round(APageSize.Y / AScaleFactor));
  ResetPageRegion;
end;

function TdxPSPDFReportRenderCanvas.AbsoluteRect(const R: TRect): TRect;
begin
  Result := cxRectOffset(R, WindowOrg, False);
end;

procedure TdxPSPDFReportRenderCanvas.DrawPictureStretch(
  APicture: TGraphic; const R: TRect; ANumerator, ADenominator: Integer);
begin
  if IsRectVisible(R) then
  begin
    if APicture.InheritsFrom(TMetafile) then
      dxPDFExportMetaFile(Self, TMetafile(APicture), R, ANumerator, ADenominator)
    else
    begin
      PageContent.BeginPaint(WindowOrg, Region.Handle);
      try
        PageContent.DrawGraphic(R, APicture);
      finally
        PageContent.EndPaint;
      end;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.InternalDrawText(
  const ABounds: TRect; const AText: string; AFont: TFont; ATextColor: TColor;
  AFormat: TcxTextOutFormat; AMaxLineCount: Integer; AVertical: Boolean;
  ADirection: TcxVerticalTextOutDirection);

  function GetRotationAngle: TcxRotationAngle;
  begin
    if not AVertical then
      Result := ra0
    else
      if ADirection = vtdTopToBottom then
        Result := raMinus90
      else
        Result := raPlus90;
  end;

var
  ABreakExtraSpacing: Integer;
  ATextExportHelper: TdxPSPDFExportCustomTextHelper;
  ATextRow: PcxTextRow;
  ATextRowRect: TRect;
  I: Integer;
  R: TRect;
begin
  SaveState;
  try
    SelectFont(AFont, ATextColor);
    ATextExportHelper := CreateTextExportHelper(Self, AFormat, AVertical);
    try
      R := ATextExportHelper.CalculateTextOutParams(ABounds, AMaxLineCount, AText);
      for I := 0 to ATextExportHelper.TextRowCount - 1 do
      begin
        ATextRow := ATextExportHelper.TextRow[I];
        ATextRowRect := ATextExportHelper.CalculateTextRowOutRect(ATextRow, R, ABreakExtraSpacing);
        if not IsRectEmpty(ATextRowRect) then
        begin
          DrawTextLine(ATextRowRect, ABounds, ATextRow.TextExtents.cx,
            ATextExportHelper.TextRowText[I], ATextColor, GetRotationAngle,
            ABreakExtraSpacing);
        end;
      end;
    finally
      ATextExportHelper.Free;
    end;
  finally
    RestoreState;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.DrawTextLine(const ATextRect: TRect;
  const AClipBounds: TRect; ATextWidth: Integer; const AText: WideString;
  ATextColor: TColor = clDefault; ADirection: TcxRotationAngle = ra0;
  ABreakExtraSpacing: Integer = 0);
var
  ACharsSpacing: Double;
begin
  if Length(AText) > 0 then
  begin
    SaveClipRgn;
    try
      IntersectClipRgn(AClipBounds);
      if IsRectVisible(ATextRect) then
      begin
        PageContent.BeginPaint(WindowOrg, Region.Handle);
        try
          SelectFont(Font, ATextColor);
          ATextWidth := Round(ATextWidth / TextWidthConversionFactor);
          ACharsSpacing := (ATextWidth - PageContent.TextWidth(AText)) / Length(AText);
          if ACharsSpacing < -1 / PageContent.CoordsConversionFactor then
          begin
            PageContent.AdjustFontSize(AText, ATextWidth);
            ACharsSpacing := 0;
          end;
          PageContent.DrawText(ATextRect, AText, ADirection,
            ACharsSpacing, ABreakExtraSpacing * (1 - ACharsSpacing));
        finally
          PageContent.EndPaint;
        end;
      end;
    finally
      RestoreClipRgn;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.DrawPictureTile(APicture: TGraphic;
  const R: TRect; APictureWidth, APictureHeight, ANumerator, ADenominator: Integer);
begin
  if IsRectVisible(R) then 
  begin
    PageContent.BeginPaint(WindowOrg, Region.Handle);
    try
      PageContent.FillRectByGraphic(R,
        MulDiv(APictureWidth, ADenominator, ANumerator),
        MulDiv(APictureHeight, ADenominator, ANumerator), APicture);
    finally
      PageContent.EndPaint
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.InternalFillRect(const R: TRect;
  ABackColor, AForeColor: TColor; APattern: TdxPSFillPatternClass; APatternBrush: TBrush);

  procedure PrepareBrushOrigin(ABitmap: TcxBitmap; R: TRect);
  var
    P: TPoint;
  begin
    if Assigned(APattern) and APattern.RequiredBrushOrigin then
    begin
      LogicalToDeviceCoordinates(R);
      P := Point(R.Left mod ABitmap.Width, R.Top mod ABitmap.Height);
    end
    else
      P := BrushOrg;

    SetBrushOrgEx(ABitmap.Canvas.Handle, P.X, P.Y, nil);
  end;

  function CreatePatternBitmap: TcxBitmap;
  begin
    Result := TcxBitmap.Create;
    Result.SetSize(APatternBrush.Bitmap.Width, APatternBrush.Bitmap.Height);
    Result.Canvas.Font.Assign(Font);
    Result.Canvas.Font.Color := AForeColor;
    Result.Canvas.Brush.Assign(APatternBrush);
    SetBkColor(Result.Canvas.Handle, ColorToRGB(ABackColor));
    PrepareBrushOrigin(Result, R);
  end;

var
  ABitmap: TcxBitmap;
begin
  if IsSolidFillPattern(APattern, APatternBrush) then
  begin
    if Assigned(APatternBrush) then
      ABackColor := APatternBrush.Color;
    PageContent.FillRect(R, ABackColor);
  end
  else
    if APatternBrush.Style <> bsSolid then
      PageContent.FillRectByBrush(R, APatternBrush.Color, APatternBrush.Style)
    else
    begin
      ABitmap := CreatePatternBitmap;
      try
        ABitmap.Canvas.FillRect(ABitmap.ClientRect);
        PageContent.FillRectByGraphic(R, ABitmap.Width, ABitmap.Height, ABitmap);
      finally
        ABitmap.Free;
      end;
    end;
end;

function TdxPSPDFReportRenderCanvas.GetIsPrinterCanvas: Boolean;
begin
  Result := True;
end;

function TdxPSPDFReportRenderCanvas.GetSupportsTransparentImagesDrawing: Boolean;
begin
  Result := False;
end;

procedure TdxPSPDFReportRenderCanvas.DrawEllipseFrame(
  const R: TRect; AColor: TColor; AThickness: Integer);
begin
  if IsRectVisible(R) then
  begin
    PageContent.BeginPaint(WindowOrg, Region.Handle);
    try
      PageContent.DrawEllipseFrame(R, AColor, AThickness);
    finally
      PageContent.EndPaint;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.DrawExpandButton(R: TRect;
  AEdgeStyle: TdxCheckButtonEdgeStyle; AMarlettFont, ASymbolFont: TFont;
  AExpanded, AShadow, AFillInterior: Boolean; ABorderColor, ABackgroundColor: TColor;
  ALineThickness: Integer);

  procedure DrawExpandButtonBorders(const R: TRect; AEdgeStyle: TdxCheckButtonEdgeStyle);
  var
    ATopLeftColor, ARightBottomColor: TColor;
  begin
    if AEdgeStyle <> cbesNone then
    begin
      GetBorderColors(AEdgeStyle, ABorderColor, True, ARightBottomColor, ATopLeftColor);
      PageContent.DrawFrame(cxRectInflate(R, -ALineThickness, -ALineThickness),
        ALineThickness, ATopLeftColor, ARightBottomColor, cxBordersAll);
      if AEdgeStyle in [cbes3D, cbesSoft3D, cbesBoldFlat] then
      begin
        GetBorderColors(AEdgeStyle, ABorderColor, False, ARightBottomColor, ATopLeftColor);
        PageContent.DrawFrame(R, ALineThickness, ATopLeftColor, ARightBottomColor, cxBordersAll);
      end;
    end;
  end;

  procedure DrawExpandButtonGlyph(R: TRect; AExpanded: Boolean);
  begin
    InflateRect(R, -6 * ALineThickness, -6 * ALineThickness);
    PageContent.FillRect(cxRectCenter(R, cxRectWidth(R), ALineThickness), ABorderColor);
    if not AExpanded then
      PageContent.FillRect(cxRectCenter(R, ALineThickness, cxRectHeight(R)), ABorderColor);
  end;

begin
  if IsRectVisible(R) then
  begin
    PageContent.BeginPaint(WindowOrg, 0);
    try
      ALineThickness := ALineThickness div 2;
      if AFillInterior then
        PageContent.FillRect(cxRectInflate(R, -ALineThickness, -ALineThickness), ABackgroundColor);
      InflateRect(R, ALineThickness, ALineThickness);
      DrawExpandButtonBorders(R, AEdgeStyle);
      DrawExpandButtonGlyph(R, AExpanded);
      PageContent.Fill;
    finally
      PageContent.EndPaint;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.DrawFrame(const R: TRect;
  ATopLeftColor, ARightBottomColor: TColor; ABorderWidth: Integer = 1;
  ABorders: TcxBorders = cxBordersAll);
begin
  if IsRectVisible(R) and (ABorders <> []) and
    ((ATopLeftColor <> clNone) or (ARightBottomColor <> clNone)) then
  begin
    PageContent.BeginPaint(WindowOrg, Region.Handle);
    try
      PageContent.DrawFrame(R, ABorderWidth, ATopLeftColor, ARightBottomColor, ABorders);
    finally
      PageContent.EndPaint;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.DrawRoundFrame(const R: TRect;
  AEllipseWidth, AEllipseHeight: Integer; AColor: TColor; AThickness: Integer);
begin
  if IsRectVisible(R) then
  begin
    PageContent.BeginPaint(WindowOrg, Region.Handle);
    try
      PageContent.DrawRoundFrame(R, AEllipseWidth, AEllipseHeight, AColor, AThickness);
    finally
      PageContent.EndPaint;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.DrawText(
  var R: TRect; const AText: string; AFont: TFont; AFormat: DWORD;
  ATextColor: TColor = clDefault; AMaxLineCount: Integer = 0);
begin
  InternalDrawText(R, AText, AFont, ATextColor, AFormat, AMaxLineCount, False, vtdTopToBottom);
end;

procedure TdxPSPDFReportRenderCanvas.FillEdge(ARegion: HRGN; ABackColor: TColor;
  AEdgeColor: TColor; AIsVerticalOrientation: Boolean; AEdgePattern: TClass);
var
  APattern: TdxPSPDFCustomPattern;
  ARect: TRect;
begin
  if AEdgePattern.InheritsFrom(TdxPSEdgePattern) and (GetRgnBox(ARegion, ARect) <> NULLREGION) then
  begin
    SaveClipRgn;
    try
      IntersectClipRgnEx(ARegion);
      if not Region.IsEmpty then
      begin
        PageContent.BeginPaint(WindowOrg, Region.Handle);
        try
          APattern := PageContent.PatternList.AddPattern(
            TdxPSPDFEdgePattern.Create(PageContent.PatternList, AEdgeColor,
              TdxPSEdgePatternClass(AEdgePattern), AIsVerticalOrientation));
          PageContent.FillRectByPattern(ARect, APattern);
        finally
          PageContent.EndPaint;
        end;
      end;
    finally
      RestoreClipRgn;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.FillEllipse(const R: TRect;
  ABackColor, AForeColor: TColor; APattern: TdxPSFillPatternClass;
  APatternBrush: TBrush);
begin
  if IsRectVisible(R) then
  begin
    PageContent.BeginPaint(WindowOrg, Region.Handle);
    try
      PageContent.WriteEllipse(R);
      PageContent.Clip;
      InternalFillRect(R, ABackColor, AForeColor, APattern, APatternBrush);
    finally
      PageContent.EndPaint;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.FillRect(const R: TRect; AColor: TColor);
begin
  FillRectEx(R, AColor, TdxPSSolidFillPattern, nil);
end;

procedure TdxPSPDFReportRenderCanvas.FillRectEx(const R: TRect;
  AColor: TColor; APattern: TdxPSFillPatternClass; APatternBrush: TBrush);
begin
  if IsRectVisible(R) and ((AColor <> clNone) or Assigned(APatternBrush)) then
  begin
    PageContent.BeginPaint(WindowOrg, Region.Handle);
    try
      InternalFillRect(R, AColor, clNone, APattern, APatternBrush);
    finally
      PageContent.EndPaint;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.FillRegion(ARegion: HRGN;
  ABackColor, AForeColor: TColor; APattern: TdxPSFillPatternClass;
  APatternBrush: TBrush);
var
  ARect: TRect;
begin
  if GetRgnBox(ARegion, ARect) <> NULLREGION then
  begin
    SaveClipRgn;
    try
      IntersectClipRgnEx(ARegion);
      if not Region.IsEmpty then
      begin
        PageContent.BeginPaint(WindowOrg, Region.Handle);
        try
          InternalFillRect(ARect, ABackColor, AForeColor, APattern, APatternBrush);
        finally
          PageContent.EndPaint;
        end;
      end;
    finally
      RestoreClipRgn;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.FillRoundRect(R: TRect;
  AEllipseWidth, AEllipseHeight: Integer; ABackColor, AForeColor: TColor;
  APattern: TdxPSFillPatternClass; APatternBrush: TBrush);
begin
  if IsRectVisible(R) then
  begin
    PageContent.BeginPaint(WindowOrg, Region.Handle);
    try
      PageContent.WriteRoundRect(R, AEllipseWidth, AEllipseHeight);
      PageContent.Clip;
      InternalFillRect(R, ABackColor, AForeColor, APattern, APatternBrush);
    finally
      PageContent.EndPaint;
    end;
  end;
end;

function TdxPSPDFReportRenderCanvas.IsRectVisible(const R: TRect): Boolean;
begin
  Result := not IsRectEmpty(R) and Region.RectInRegion(AbsoluteRect(R));
end;

procedure TdxPSPDFReportRenderCanvas.Pie(
  const R: TRect; const APoint1, APoint2: TPoint; AColor: TColor);
begin
  if IsRectVisible(R) then
  begin
    PageContent.BeginPaint(WindowOrg, Region.Handle);
    try
      PageContent.Pie(R, APoint1, APoint2, AColor);
    finally
      PageContent.EndPaint;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.Polyline(
  const APoints: array of TPoint; AColor: TColor; ALineWidth: Integer);
begin
  if Length(APoints) > 1 then
  begin
    PageContent.BeginPaint(WindowOrg, Region.Handle);
    try
      PageContent.Polyline(APoints, ALineWidth, AColor);
    finally
      PageContent.EndPaint;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.Polygon(const APoints: array of TPoint;
  AColor, ABackgroundColor: TColor; ALineWidth: Integer; AFillMode: Integer = ALTERNATE);
begin
  if Length(APoints) > 1 then
  begin
    PageContent.BeginPaint(WindowOrg, Region.Handle);
    try
      PageContent.Polygon(APoints, ALineWidth, AColor, ABackgroundColor, AFillMode);
    finally
      PageContent.EndPaint;
    end;
  end;
end;

procedure TdxPSPDFReportRenderCanvas.RotatedTextOut(
  const ABounds: TRect; const AText: string; AFont: TFont;
  AAlignHorz: TcxTextAlignX = taCenterX; AAlignVert: TcxTextAlignY = taCenterY;
  AWordBreak: Boolean = True; ADirection: TcxVerticalTextOutDirection = vtdBottomToTop);
var
  AFormat: Cardinal;
begin
  AFormat := cxMakeFormat(AAlignHorz, AAlignVert);
  if AWordBreak then
    AFormat := AFormat or CXTO_WORDBREAK;
  InternalDrawText(ABounds, AText, AFont, clDefault, AFormat, 0, True, ADirection);
end;

function TdxPSPDFReportRenderCanvas.CalculateTextRect(const AText: string;
  var R: TRect; AFormat: TcxTextOutFormat = CXTO_DEFAULT_FORMAT; AFont: TFont = nil;
  AMaxLineCount: Integer = 0; ALeftIndent: Integer = 0; ARightIndent: Integer = 0;
  ATextColor: TColor = clDefault): Integer;
var
  ABreakExtraSpacing: Integer;
  ATextExportHelper: TdxPSPDFExportCustomTextHelper;
  ATextRowRect: TRect;
  I: Integer;
  R1: TRect;
begin
  SaveState;
  try
    SelectFont(AFont, ATextColor);
    ATextExportHelper := CreateTextExportHelper(Self, AFormat, False);
    try
      R1 := ATextExportHelper.CalculateTextOutParams(R, AMaxLineCount, AText);
      for I := 0 to ATextExportHelper.TextRowCount - 1 do
      begin
        ATextRowRect := ATextExportHelper.CalculateTextRowOutRect(
          ATextExportHelper.TextRow[I], R1, ABreakExtraSpacing);
        R.Top := Min(R.Top, ATextRowRect.Top);
        R.Right := Max(R.Right, ATextRowRect.Right);
        R.Bottom := Max(R.Bottom, ATextRowRect.Bottom);
        R.Left := Min(R.Left, ATextRowRect.Left);
      end;
      if AFormat and CXTO_AUTOINDENTS <> 0 then
      begin
        Inc(R.Bottom, cxTextSpace * ATextExportHelper.TextParams.OnePixel);
        Inc(R.Right, cxTextSpace * ATextExportHelper.TextParams.OnePixel);
      end;
      if AFormat and CXTO_CALCROWCOUNT = 0 then
        Result := cxRectHeight(R)
      else
        Result := ATextExportHelper.TextRowCount;
    finally
      ATextExportHelper.Free;
    end;
  finally
    RestoreState;
  end;
end;

function TdxPSPDFReportRenderCanvas.GetPageContent: TdxPSPDFPageContent;
begin
  Result := Provider.PageContent;
end;

function TdxPSPDFReportRenderCanvas.ExcludeClipRect(const R: TRect): Integer;
var
  R1: TRect;
begin
  Region.Combine(TcxRegion.Create(AbsoluteRect(R)), roSubtract);
  Result := GetRgnBox(Region.Handle, R1);
end;

function TdxPSPDFReportRenderCanvas.IntersectClipRgn(const R: TRect): Integer;
var
  R1: TRect;
begin
  Region.Combine(TcxRegion.Create(AbsoluteRect(R)), roIntersect);
  Result := GetRgnBox(Region.Handle, R1);
end;

procedure TdxPSPDFReportRenderCanvas.IntersectClipRgnEx(ARegion: HRGN);
var
  ATempRegion: TcxRegion;
begin
  ATempRegion := TcxRegion.Create(cxNullRect);
  CombineRgn(ATempRegion.Handle, ATempRegion.Handle, ARegion, RGN_OR);
  ATempRegion.Offset(cxPointInvert(WindowOrg));
  Region.Combine(ATempRegion, roIntersect);
end;

procedure TdxPSPDFReportRenderCanvas.SetClipRect(const R: TRect);
begin
  Region.Combine(TcxRegion.Create(AbsoluteRect(R)), roSet);
end;

function TdxPSPDFReportRenderCanvas.BeginCustomDraw(
  const AClipBounds: TRect; AFont: TFont; AColor: TColor): TCanvas;
begin
  SaveState;
  SaveClipRgn;
  FCustomDrawBounds := AClipBounds;
  PrepareCanvasForCustomDraw(AFont, AColor);
  FCustomDrawMetaFile := TMetafile.Create;
  FCustomDrawMetaFile.Width := cxRectWidth(FCustomDrawBounds);
  FCustomDrawMetaFile.Height := cxRectHeight(FCustomDrawBounds);
  FCustomDrawMetaFileCanvas := TMetafileCanvas.Create(FCustomDrawMetaFile, 0);
  FCustomDrawMetaFileCanvas.Brush.Assign(Brush);
  FCustomDrawMetaFileCanvas.Font.Assign(Font);
  SetWindowOrgEx(FCustomDrawMetaFileCanvas.Handle, FCustomDrawBounds.Left, FCustomDrawBounds.Top, nil);
  Result := FCustomDrawMetaFileCanvas;
end;

procedure TdxPSPDFReportRenderCanvas.EndCustomDraw(var ACanvas: TCanvas);
begin
  FreeAndNil(FCustomDrawMetaFileCanvas);
  DrawPicture(FCustomDrawMetaFile, FCustomDrawBounds, ppmStretch, 1, 1);
  FreeAndNil(FCustomDrawMetaFile);
  RestoreClipRgn;
  RestoreState;
end;

procedure TdxPSPDFReportRenderCanvas.ResetPageRegion;
begin
  Region.Handle := CreateRectRgn(0, 0, PageSize.X, PageSize.Y);
end;

procedure TdxPSPDFReportRenderCanvas.PrepareLogicalUnits;
begin
  inherited PrepareLogicalUnits;
  FTextWidthConversionFactor := PixelsNumerator / 96 *
    PageContent.CoordsConversionFactor * 100 / Provider.ReportLink.RealScaleFactor;
end;

procedure TdxPSPDFReportRenderCanvas.UnprepareLogicalUnits;
begin
  PageContent.CoordsConversionFactor := 1;
  FTextWidthConversionFactor := 1;
  inherited UnprepareLogicalUnits;
end;

procedure TdxPSPDFReportRenderCanvas.RestoreClipRgn;
var
  ALastRegion: TcxRegion;
begin
  ALastRegion := TcxRegion(FSavedRegions.Last);
  FSavedRegions.Remove(ALastRegion);
  Region.Combine(ALastRegion, roSet)
end;

procedure TdxPSPDFReportRenderCanvas.RestoreState;
begin
  inherited RestoreState;
  RestoreClipRgn;
end;

procedure TdxPSPDFReportRenderCanvas.SaveClipRgn;
var
  ARegion: TcxRegion;
begin
  ARegion := TcxRegion.Create;
  ARegion.Combine(Region, roSet, False);
  FSavedRegions.Add(ARegion);
end;

procedure TdxPSPDFReportRenderCanvas.SaveState;
begin
  SaveClipRgn;
  inherited SaveState;
end;

procedure TdxPSPDFReportRenderCanvas.SelectFont(AFont: TFont; ATextColor: TColor);
begin
  Font := AFont;
  if ATextColor = clDefault then
    ATextColor := Font.Color;
  if (ATextColor = clDefault) or (ATextColor = clNone) then
    ATextColor := clWindowText;
  PageContent.Font := Provider.PDFFile.AddFont(Font);
  PageContent.FontSize := -Font.Height;
  PageContent.FontColor := ATextColor;
end;

end.
