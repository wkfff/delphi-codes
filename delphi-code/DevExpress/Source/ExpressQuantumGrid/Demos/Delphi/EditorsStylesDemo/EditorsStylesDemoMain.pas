unit EditorsStylesDemoMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxTreeView,
  cxControls, cxContainer, cxListView, cxListBox, cxLookAndFeels, cxStyles, StdCtrls,
  Menus, ImgList, ActnList, cxTrackBar, cxProgressBar, ComCtrls, ExtCtrls, cxHint,
  cxLookAndFeelPainters, cxImage, cxButtons, ToolWin, JPEG, cxSplitter,
  cxLabel, EditorsStylesDemoBase, cxGroupBox, cxMemo, cxSpinEdit, cxFontNameComboBox, BaseForm,
  cxPC, cxGraphics, cxGridTableView, cxClasses, cxPCdxBarPopupMenu,
  cxGridCardView;

type
  TEditorsStylesDemoDemoMainForm = class(TfmBaseForm)
    ilMain: TImageList;
    OpenDialog: TOpenDialog;
    cxGroupBox: TcxGroupBox;
    miStyle: TMenuItem;
    cxGroupBox1: TcxGroupBox;
    cxTreeView: TcxTreeView;
    cxSplitter: TcxSplitter;
    gbDescription: TcxGroupBox;
    cxSplitter1: TcxSplitter;
    cxHintStyleController: TcxHintStyleController;
    miStyleCurrentPage: TMenuItem;
    miStyleAllPages: TMenuItem;
    miCurDisplayStyle: TMenuItem;
    miCurDefLightBlue: TMenuItem;
    miCurDefLightGray: TMenuItem;
    miCurDefWood: TMenuItem;
    miCurHintStyle: TMenuItem;
    miDefDisplayStyle: TMenuItem;
    miDefHintStyle: TMenuItem;
    miDefLightBlue: TMenuItem;
    miDefLightGray: TMenuItem;
    miDefWood: TMenuItem;
    miHintStyleLightInfo: TMenuItem;
    miHintStyleLightSlideLeft: TMenuItem;
    miHintStyleBlueSlideUp: TMenuItem;
    miHintStyleRoundedInfo: TMenuItem;
    miCurHintStyleRoundedInfo: TMenuItem;
    miCurHintStyleBlueSlideUp: TMenuItem;
    miCurHintStyleLightSlideLeft: TMenuItem;
    miCurHintStyleLightInfo: TMenuItem;
    miFileOpen: TMenuItem;
    miFileSave: TMenuItem;
    N3: TMenuItem;
    nohints1: TMenuItem;
    N4: TMenuItem;
    nohints2: TMenuItem;
    miCurDefRainyDay: TMenuItem;
    miCurDefBrick: TMenuItem;
    miCurDefDeepSea: TMenuItem;
    miDefRainyDay: TMenuItem;
    miDefBrick: TMenuItem;
    miDefDeepSea: TMenuItem;
    miCurHintStyleStandard: TMenuItem;
    miHintStyleStandard: TMenuItem;
    PageControl: TcxPageControl;
    N1: TMenuItem;
    procedure cxTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
    procedure miHintStyleClick(Sender: TObject);
    procedure miCurHintStyleClick(Sender: TObject);
    procedure miCurDisplayStyleClick(Sender: TObject);
    procedure miDefaultDisplayStyleClick(Sender: TObject);
    procedure miFileOpenClick(Sender: TObject);
    procedure miFileSaveClick(Sender: TObject);
    procedure nohints2Click(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FDefaultHintStyle: Boolean;
    FDefaultDisplayStyle: Boolean;
    FCurrentDisplayStyle: TcxStyleSheetType;
    procedure AdjustDescriptionsPageControl;
    procedure SetNoHintStyle;
    procedure SetStandardHintStyle;
    procedure UpdateFileNameStatusPanel(AFileName: string);
    procedure FillTreeViewItems;
    procedure SetLightInfoHintStyle;
    procedure SetLightSlideLeftHintStyle;
    procedure SetBlueSlideUpHintStyle;
    procedure SetRoundedInfoHintStyle;
    procedure SetHintStyle(AHintType: TcxHintType);
    procedure AdjustFileMenu;
  public
    property DefaultHintStyle: Boolean read FDefaultHintStyle write FDefaultHintStyle;
    property DefaultDisplayStyle: Boolean read FDefaultDisplayStyle write FDefaultDisplayStyle;
  end;

var
  EditorsStylesDemoDemoMainForm: TEditorsStylesDemoDemoMainForm;

implementation

{$R *.dfm}

uses
  dxUxTheme, AboutDemoForm;

var
  ActiveFrame: TEditorsStylesDemoBaseFrame;

procedure TEditorsStylesDemoDemoMainForm.cxTreeViewChange(Sender: TObject; Node: TTreeNode);

  procedure UpdateCurrentHintStyle(AHintType: TcxHintType; ADefaultHintStyle: Boolean);
  begin
    if not ADefaultHintStyle then
    begin
      MenuItemCheckSubItemWithTag('miDefHintStyle', -1);
      MenuItemCheckSubItemWithTag('miCurHintStyle', Ord(AHintType));
    end;
  end;

  procedure AdjustFrameDisplayStyle(AFrame: TEditorsStylesDemoBaseFrame;
    ADefaultDisplayStyle: Boolean);
  begin
    if ADefaultDisplayStyle then
      ActiveFrame.ChangeDisplayStyle(FCurrentDisplayStyle)
    else
    begin
      MenuItemCheckSubItemWithTag('miCurDisplayStyle', Integer(AFrame.DisplayStyle));
      AFrame.DisplayStyle := AFrame.DisplayStyle;
    end;
  end;

  procedure AdjustFileNameStatusPanel;
  begin
    UpdateFileNameStatusPanel(ExtractFileName(ActiveFrame.FileName));
  end;

  procedure AdjustNotePane(AFrame: TEditorsStylesDemoBaseFrame);
  begin
    gbDescription.Color := AFrame.GetStyleBackgroundColor;
    gbDescription.CaptionBkColor := AFrame.GetStyleBackgroundColor;
  end;

var
  AFrame: TEditorsStylesDemoBaseFrame;
  AControlClassName: string;
begin
  AControlClassName := '';
  if Node <> nil then
  begin
    if Node.Parent <> nil then
    begin
      AControlClassName := Node.Text;
      Node := Node.Parent;
    end;
    AFrame := TEditorsStylesDemoBaseFrame(Node.Data);
    if (ActiveFrame <> nil) then
      ActiveFrame.Flickering := False;
    if (AFrame <> nil) and (AControlClassName <> '') then
      AFrame.FlickerControls(AControlClassName);
    if ActiveFrame <> AFrame then
    begin
      if (ActiveFrame <> nil) and (AFrame <> nil) then
      begin
        ActiveFrame.Visible := False;
        ActiveFrame.Parent := nil;
      end;
      ActiveFrame := AFrame;
      ActiveFrame.Parent := cxGroupBox;
 	  ActiveFrame.Visible := True;
      UpdateCurrentHintStyle(ActiveFrame.HintStyle, DefaultHintStyle);
      AdjustFrameDisplayStyle(ActiveFrame, DefaultDisplayStyle);
      AdjustFileMenu;
      AdjustNotePane(AFrame);
      PageControl.ActivePage := PageControl.Pages[Node.Index];
      AdjustFileNameStatusPanel;
      MenuItemSetVisible('miStyle', AFrame.StyleMenuVisible);
    end;
  end;
end;

procedure TEditorsStylesDemoDemoMainForm.FillTreeViewItems;
var
  I: Integer;
  ANode: TTreeNode;
  AStrings: TStringList;

  procedure AddChildNodes(AExtEditorTypes: TcxExtEditorTypes);
  var
    J: Integer;
  begin
    cxGetEditorsNamesListByTypes(AStrings, AExtEditorTypes);
    for J := 0 to AStrings.Count - 1 do
      cxTreeView.Items.AddChild(ANode, AStrings[J]);
    ANode.AlphaSort;
  end;

begin
  cxTreeView.Items.Clear;
  AStrings := TStringList.Create;
  for I := 0 to EditorsStylesDemoFrameManager.FramesCount - 1 do
  begin
    EditorsStylesDemoFrameManager[I].OnFileNameChanged := UpdateFileNameStatusPanel;
    ANode := cxTreeView.Items.AddChildObject(
      nil, EditorsStylesDemoFrameManager[I].Name, EditorsStylesDemoFrameManager[I]);
    AddChildNodes(EditorsStylesDemoFrameManager[I].GetExtEditorTypes(EditorsStylesDemoFrameManager[I]));
  end;
end;

procedure TEditorsStylesDemoDemoMainForm.FormDestroy(Sender: TObject);
begin
  ActiveFrame.Close;
  ActiveFrame.Parent := nil;
end;

procedure TEditorsStylesDemoDemoMainForm.SetBlueSlideUpHintStyle;
begin
  if not ShowHint then ShowHint := True;
  with cxHintStyleController do
  begin
    HintStyle.Standard := False;
    HintStyle.Animate := cxhaSlideUpward;
    HintStyle.Color := 15580039;
    HintStyle.Font.Color := 11353897;
    HintStyle.Font.Height := -13;
    HintStyle.Font.Style := [];
    HintStyle.IconType := cxhiCustom;
    HintStyle.IconSize := cxisDefault;
    HintStyle.Rounded := False;
  end;
end;

procedure TEditorsStylesDemoDemoMainForm.SetLightInfoHintStyle;
begin
  if not ShowHint then ShowHint := True;
  with cxHintStyleController do
  begin
    HintStyle.Standard := False;
    HintStyle.Animate := cxhaFadeIn;
    HintStyle.Color := clInfoBk;
    HintStyle.Font.Color := clBlack;
    HintStyle.Font.Height := -11;
    HintStyle.Font.Style := [];
    HintStyle.IconType := cxhiInformation;
    HintStyle.IconSize := cxisDefault;
    HintStyle.Rounded := False;
  end;
end;

procedure TEditorsStylesDemoDemoMainForm.SetLightSlideLeftHintStyle;
begin
  if not ShowHint then ShowHint := True;
  with cxHintStyleController do
  begin
    HintStyle.Standard := False;
    HintStyle.Animate := cxhaSlideFromLeft;
    HintStyle.Color := $00EDCBB6;
    HintStyle.Font.Color := clBlack;
    HintStyle.Font.Height := -13;
    HintStyle.Font.Style := [];
    HintStyle.IconType := cxhiCurrentApplication;
    HintStyle.IconSize := cxisSmall;
    HintStyle.Rounded := False;
  end;
end;

procedure TEditorsStylesDemoDemoMainForm.SetRoundedInfoHintStyle;
begin
  if not ShowHint then ShowHint := True;
  with cxHintStyleController do
  begin
    HintStyle.Standard := False;
    HintStyle.Animate := cxhaFadeIn;
    HintStyle.Color := clInfoBk;
    HintStyle.Font.Color := clBlack;
    HintStyle.Font.Height := -11;
    HintStyle.Font.Style := [];
    HintStyle.IconType := cxhiInformation;
    HintStyle.IconSize := cxisDefault;
    HintStyle.Rounded := True;
  end;
end;

procedure TEditorsStylesDemoDemoMainForm.AdjustDescriptionsPageControl;
var
  I: Integer;
  APage: TcxTabSheet;
begin
  for I := 0 to EditorsStylesDemoFrameManager.FramesCount - 1 do
  begin
    APage := TcxTabSheet.Create(PageControl);
    APage.PageControl := PageControl;
    APage.Caption := EditorsStylesDemoFrameManager[I].BriefName;
    EditorsStylesDemoFrameManager[I].pnlDescription.Parent := APage;
    EditorsStylesDemoFrameManager[I].pnlDescription.Visible := True;
    EditorsStylesDemoFrameManager[I].pnlDescription.Align := alClient;
    EditorsStylesDemoFrameManager[I].memDescrip.Properties.WordWrap := True;
    APage.ImageIndex := APage.TabIndex;
  end;
end;

procedure TEditorsStylesDemoDemoMainForm.SetNoHintStyle;
begin
  ShowHint := False;
end;

procedure TEditorsStylesDemoDemoMainForm.SetStandardHintStyle;
begin
  if not ShowHint then ShowHint := True;
  cxHintStyleController.HintStyle.Standard := True;
end;

procedure TEditorsStylesDemoDemoMainForm.SetHintStyle(AHintType: TcxHintType);
begin
  case AHintType of
    hcstLightInfo:
      SetLightInfoHintStyle;
    hcstLightSlideLeft:
      SetLightSlideLeftHintStyle;
    hcstBlueSlideUp:
      SetBlueSlideUpHintStyle;
    hcstRoundedInfo:
      SetRoundedInfoHintStyle;
    hcstStandard:
      SetStandardHintStyle;
    hcstNoHint:
      SetNoHintStyle;
    else
      SetLightInfoHintStyle;
  end;
end;

procedure TEditorsStylesDemoDemoMainForm.miHintStyleClick(Sender: TObject);
begin
  DefaultHintStyle := True;
  MenuItemSetChecked(Sender, True);
  MenuItemCheckSubItemWithTag('miCurHintStyle', -1);
  SetHintStyle(TcxHintType(TMenuItem(Sender).Tag));
end;

procedure TEditorsStylesDemoDemoMainForm.miCurHintStyleClick(Sender: TObject);
begin
  DefaultHintStyle := False;
  MenuItemSetChecked(Sender, True);
  MenuItemCheckSubItemWithTag('miDefHintStyle', -1);
  ActiveFrame.HintStyle := TcxHintType(TComponent(Sender).Tag);
  SetHintStyle(TcxHintType(TComponent(Sender).Tag));
end;

procedure TEditorsStylesDemoDemoMainForm.miCurDisplayStyleClick(Sender: TObject);
begin
  MenuItemSetChecked(Sender, True);
  MenuItemCheckSubItemWithTag('miDefDisplayStyle', -1);
  DefaultDisplayStyle := False;
  ActiveFrame.DisplayStyle := TcxStyleSheetType(TComponent(Sender).Tag);
  gbDescription.Color := ActiveFrame.GetStyleBackgroundColor;
  gbDescription.CaptionBkColor := ActiveFrame.GetStyleBackgroundColor;
end;

procedure TEditorsStylesDemoDemoMainForm.miDefaultDisplayStyleClick(Sender: TObject);
begin
  MenuItemSetChecked(Sender, True);
  MenuItemCheckSubItemWithTag('miCurDisplayStyle', -1);
  DefaultDisplayStyle := True;
  FCurrentDisplayStyle := TcxStyleSheetType(TComponent(Sender).Tag);
  ActiveFrame.ChangeDisplayStyle(TcxStyleSheetType(TComponent(Sender).Tag));
  gbDescription.Color := ActiveFrame.GetStyleBackgroundColor;
  gbDescription.CaptionBkColor := ActiveFrame.GetStyleBackgroundColor;
end;

procedure TEditorsStylesDemoDemoMainForm.miFileOpenClick(Sender: TObject);
begin
  ActiveFrame.OpenFile(Self);
end;

procedure TEditorsStylesDemoDemoMainForm.miFileSaveClick(Sender: TObject);
begin
  ActiveFrame.SaveFile(Self);
end;

procedure TEditorsStylesDemoDemoMainForm.AdjustFileMenu;
begin
  MenuItemSetVisible('miFileOpen', ActiveFrame.MenuOpenFileVisible);
  MenuItemSetVisible('miFileSave', ActiveFrame.MenuSaveFileVisible);
end;

procedure TEditorsStylesDemoDemoMainForm.UpdateFileNameStatusPanel(AFileName: string);
begin
  StatusBar.Panels[1].Text := ExtractFileName(AFileName);
end;

procedure TEditorsStylesDemoDemoMainForm.nohints2Click(Sender: TObject);
begin
  DefaultHintStyle := True;
  MenuItemCheckSubItemWithTag('miCurHintStyle', -1);
  MenuItemSetChecked(Sender, True);
  SetHintStyle(TcxHintType(TComponent(Sender).Tag));
end;

procedure TEditorsStylesDemoDemoMainForm.PageControlChange(Sender: TObject);
var
 APageIndex: Integer;
begin
  APageIndex := PageControl.ActivePage.TabIndex;
  if APageIndex <> -1 then
    gbDescription.Caption := EditorsStylesDemoFrameManager[APageIndex].Description;
end;

procedure TEditorsStylesDemoDemoMainForm.FormShow(Sender: TObject);
begin
  inherited;
  AdjustDescriptionsPageControl;
  FillTreeViewItems;
  cxTreeView.Items.GetFirstNode.Expand(True);
  cxTreeView.Items.GetFirstNode.Selected := True;
  cxTreeViewChange(Sender, cxTreeView.Items.GetFirstNode);
  FDefaultHintStyle := False;
  FDefaultDisplayStyle := False;
  FCurrentDisplayStyle := shtLightBlue;
end;

end.
