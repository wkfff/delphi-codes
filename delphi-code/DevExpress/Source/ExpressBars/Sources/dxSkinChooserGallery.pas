{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars components                                      }
{                                                                   }
{       Copyright (c) 1998-2011 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxSkinChooserGallery;

interface

uses
  Classes, SysUtils, Graphics, dxRibbonGallery, cxLookAndFeelPainters, dxSkinsCore;

type

  { TdxSkinChooserOptions }

  TdxSkinChooserGalleryOptions = class(TdxCustomRibbonGalleryOptions)
  protected
    function IsItemImagePositionStored: Boolean; override;
  public
    constructor Create(AOwner: TdxCustomRibbonGalleryItem); override;
  published
    property ColumnCount;
    property ItemAllowDeselect default True;
    property ItemImagePosition;
    property ItemImageSize;
    property ShowItemHint;
    property SpaceAfterGroupHeader;
    property SpaceBetweenGroups;
    property SpaceBetweenItemCaptionAndDescription;
    property SpaceBetweenItemImageAndText;
    property SpaceBetweenItemsAndBorder;
    property SpaceBetweenItemsHorizontally;
    property SpaceBetweenItemsVertically;
  end;

  { TdxSkinChooserGalleryGroupItem }

  TdxSkinChooserGalleryGroupItem = class(TdxRibbonGalleryGroupItem)
  private
    FSkinName: string;
  public
    property SkinName: string read FSkinName write FSkinName;
  end;

  { TdxSkinChooserGalleryItem }

  TdxSkinChooserGallerySkinChangedEvent = procedure(Sender: TObject;
    const ASkinName: string) of object;

  TdxSkinChooserGalleryItem = class(TdxCustomRibbonGalleryItem, IcxLookAndFeelPainterListener)
  private
    FSkinIconSize: TdxSkinIconSize;
    FSkinIconSizeInDropDown: TdxSkinIconSize;
    FOnSkinChanged: TdxSkinChooserGallerySkinChangedEvent;
    procedure AddSkin(ASkinDetails: TdxSkinDetails);
    procedure DoSkinChanged(const ASkinName: string);
    procedure PopulateGallery;

    function GetGalleryOptions: TdxSkinChooserGalleryOptions;
    function GetGroupIndex(const AName: string): Integer;
    function GetSelectedSkinName: string;
    function IsSkinIconSizeStored: Boolean;
    function IsSkinIconSizeInDropDownStored: Boolean;
    procedure SetGalleryOptions(AValue: TdxSkinChooserGalleryOptions);
    procedure SetSelectedSkinName(const AValue: string);
    procedure SetSkinIconSize(AValue: TdxSkinIconSize);
    procedure SetSkinIconSizeInDropDown(AValue: TdxSkinIconSize);
  protected
    procedure DoGroupItemClick(AItem: TdxRibbonGalleryGroupItem); override;
    function GetGroupItemClass: TdxRibbonGalleryGroupItemClass; override;
    function GetGalleryOptionsClass: TCustomdxRibbonGalleryOptionsClass; override;
    class function GetNewCaption: string; override;
    // IcxLookAndFeelPainterListener
    procedure IcxLookAndFeelPainterListener.PainterAdded = PainterChanged;
    procedure IcxLookAndFeelPainterListener.PainterRemoved = PainterChanged;
    procedure PainterChanged(APainter: TcxCustomLookAndFeelPainter);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    property SelectedSkinName: string read GetSelectedSkinName write SetSelectedSkinName;
  published
    property GalleryOptions: TdxSkinChooserGalleryOptions read GetGalleryOptions write SetGalleryOptions;
    property GalleryInRibbonOptions;
    property GalleryInMenuOptions;
    property ItemLinks;
    property ItemOptions;
    property SkinIconSize: TdxSkinIconSize read FSkinIconSize write SetSkinIconSize stored IsSkinIconSizeStored;
    property SkinIconSizeInDropDown: TdxSkinIconSize read FSkinIconSizeInDropDown write SetSkinIconSizeInDropDown stored IsSkinIconSizeInDropDownStored;
    property OnCloseUp;
    property OnHotTrackedItemChanged;
    property OnPopup;
    property OnSkinChanged: TdxSkinChooserGallerySkinChangedEvent read FOnSkinChanged write FOnSkinChanged;
  end;

implementation

uses
  cxLookAndFeels, dxBar, cxGraphics, dxGDIPlusClasses;

{ TdxSkinChooserGalleryOptions }

constructor TdxSkinChooserGalleryOptions.Create(AOwner: TdxCustomRibbonGalleryItem);
begin
  inherited Create(AOwner);
  ItemAllowDeselect := True;
  ItemImagePosition := gipTop;
end;

function TdxSkinChooserGalleryOptions.IsItemImagePositionStored: Boolean;
begin
  Result := ItemImagePosition <> gipTop;
end;

{ TdxSkinChooserGalleryItem }

constructor TdxSkinChooserGalleryItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSkinIconSize := sis16;
  FSkinIconSizeInDropDown := sis48;
  cxLookAndFeelPaintersManager.AddListener(Self);
  PopulateGallery;
end;

destructor TdxSkinChooserGalleryItem.Destroy;
begin
  cxLookAndFeelPaintersManager.RemoveListener(Self);
  inherited Destroy;
end;

class function TdxSkinChooserGalleryItem.GetNewCaption: string;
begin
  Result := 'New Skin Chooser';
end;

procedure TdxSkinChooserGalleryItem.PainterChanged(APainter: TcxCustomLookAndFeelPainter);
begin
  PopulateGallery;
end;

procedure TdxSkinChooserGalleryItem.DoGroupItemClick(AItem: TdxRibbonGalleryGroupItem);
var
  ASkinName: string;
begin
  if AItem <> nil then
    ASkinName := (AItem as TdxSkinChooserGalleryGroupItem).SkinName
  else
    ASkinName := '';
  DoSkinChanged(ASkinName);
end;

function TdxSkinChooserGalleryItem.GetGroupItemClass: TdxRibbonGalleryGroupItemClass;
begin
  Result := TdxSkinChooserGalleryGroupItem;
end;

function TdxSkinChooserGalleryItem.GetGalleryOptionsClass: TCustomdxRibbonGalleryOptionsClass;
begin
  Result := TdxSkinChooserGalleryOptions;
end;

procedure TdxSkinChooserGalleryItem.AddSkin(ASkinDetails: TdxSkinDetails);
var
  ABitmap, ABitmapInDropDown: TBitmap;
  AItem: TdxSkinChooserGalleryGroupItem;
begin
  ABitmap := ASkinDetails.Icons[SkinIconSize].GetAsBitmap;
  ABitmapInDropDown := ASkinDetails.Icons[SkinIconSizeInDropDown].GetAsBitmap;
  try
    AItem := GalleryCategories[GetGroupIndex(ASkinDetails.GroupName)].Items.Add as TdxSkinChooserGalleryGroupItem;
    AItem.Caption := ASkinDetails.DisplayName;
    AItem.Glyph := ABitmap;
    AItem.GlyphInDropDown := ABitmapInDropDown;
    AItem.SkinName := ASkinDetails.Name;
  finally
    ABitmapInDropDown.Free;
    ABitmap.Free;
  end;
end;

procedure TdxSkinChooserGalleryItem.DoSkinChanged(const ASkinName: string);
begin
  if Assigned(FOnSkinChanged) then
    FOnSkinChanged(Self, ASkinName);
end;

procedure TdxSkinChooserGalleryItem.PopulateGallery;
var
  APainter: TcxCustomLookAndFeelPainter;
  ASkinDetails: TdxSkinDetails;
  I: Integer;
begin
  if not (csDesigning in ComponentState) then
  begin
    GalleryCategories.BeginUpdate;
    try
      GalleryCategories.Clear;
      for I := 0 to cxLookAndFeelPaintersManager.Count - 1 do
      begin
        APainter := cxLookAndFeelPaintersManager[I];
        if not APainter.IsInternalPainter then
        begin
          if APainter.GetPainterDetails(ASkinDetails) then
            AddSkin(ASkinDetails);
        end;
      end;
    finally
      GalleryCategories.EndUpdate;
    end;
  end;
end;

function TdxSkinChooserGalleryItem.GetGalleryOptions: TdxSkinChooserGalleryOptions;
begin
  Result := inherited GalleryOptions as TdxSkinChooserGalleryOptions;
end;

function TdxSkinChooserGalleryItem.GetGroupIndex(const AName: string): Integer;
begin
  Result := 0;
  while (Result < GalleryCategories.Count) and (GalleryCategories[Result].Header.Caption <> AName) do
    Inc(Result);
  if Result = GalleryCategories.Count then
  begin
    with GalleryCategories.Add do
    begin
      Header.Visible := True;
      Header.Caption := AName;
    end;
    Result := GalleryCategories.Count - 1;
  end;
end;

function TdxSkinChooserGalleryItem.GetSelectedSkinName: string;
begin
  if SelectedGroupItem <> nil then
    Result := (SelectedGroupItem as TdxSkinChooserGalleryGroupItem).SkinName
  else
    Result := '';
end;

function TdxSkinChooserGalleryItem.IsSkinIconSizeStored: Boolean;
begin
  Result := FSkinIconSize <> sis16;
end;

function TdxSkinChooserGalleryItem.IsSkinIconSizeInDropDownStored: Boolean;
begin
  Result := FSkinIconSizeInDropDown <> sis48;
end;

procedure TdxSkinChooserGalleryItem.SetGalleryOptions(AValue: TdxSkinChooserGalleryOptions);
begin
  GalleryOptions.Assign(AValue);
end;

procedure TdxSkinChooserGalleryItem.SetSelectedSkinName(const AValue: string);

  function FindSkinItemInGroup(AGroup: TdxRibbonGalleryGroup; const AName: string): TdxRibbonGalleryGroupItem;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to AGroup.Items.Count - 1 do
      if SameText(AName, (AGroup.Items[I] as TdxSkinChooserGalleryGroupItem).SkinName) then
      begin
        Result := AGroup.Items[I];
        Break;
      end;
  end;

  function FindSkinItem(const AName: string): TdxRibbonGalleryGroupItem;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to GalleryGroups.Count - 1 do
    begin
      Result := FindSkinItemInGroup(GalleryGroups.Items[I], AName);
      if Result <> nil then Break;
    end;
  end;

begin
  SelectedGroupItem := FindSkinItem(AValue);
end;

procedure TdxSkinChooserGalleryItem.SetSkinIconSize(AValue: TdxSkinIconSize);
begin
  if AValue <> FSkinIconSize then
  begin
    FSkinIconSize := AValue;
    PopulateGallery;
  end;
end;

procedure TdxSkinChooserGalleryItem.SetSkinIconSizeInDropDown(AValue: TdxSkinIconSize);
begin
  if AValue <> FSkinIconSizeInDropDown then
  begin
    FSkinIconSizeInDropDown := AValue;
    PopulateGallery;
  end;
end;

initialization
  dxBarRegisterItem(TdxSkinChooserGalleryItem, TdxRibbonGalleryControl, True);

finalization
  dxBarUnregisterItem(TdxSkinChooserGalleryItem);
end.
