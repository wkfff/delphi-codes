unit EBarMegaDemoMain;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxBar, ExtCtrls, dxsbar, dxBarExtItems, ComCtrls, StdCtrls,
  OleCtrls, dxBarExtDBItems, dxBarDBNav, Db, DBTables, Variants,
{$IFDEF DELPHI12}
  SHDocVw_TLB12,
{$ELSE}
  SHDocVw_TLB,
{$ENDIF}
  Grids, DBGrids, ActiveX, RichEdit, Menus, ImgList, ActnList, EBarsUtils,
  cxClasses;

type
  TEBarMegaDemoMainForm = class(TForm)
    dxSideBarStore: TdxSideBarStore;
    dxSideBarStoreItem1: TdxStoredSideItem;
    dxSideBarStoreItem2: TdxStoredSideItem;
    dxSideBarStoreItem3: TdxStoredSideItem;
    BarManager: TdxBarManager;
    dxBarButtonNew: TdxBarLargeButton;
    dxBarButtonOpen: TdxBarLargeButton;
    dxBarButtonClose: TdxBarLargeButton;
    dxBarButtonSave: TdxBarLargeButton;
    dxBarButtonSaveAs: TdxBarLargeButton;
    dxBarSubItemFile: TdxBarSubItem;
    dxBarSubItemEdit: TdxBarSubItem;
    dxBarSubItemFormat: TdxBarSubItem;
    dxBarButtonPrint: TdxBarLargeButton;
    dxBarButtonExit: TdxBarLargeButton;
    dxBarButtonUndo: TdxBarLargeButton;
    dxBarButtonCut: TdxBarLargeButton;
    dxBarButtonCopy: TdxBarLargeButton;
    dxBarButtonPaste: TdxBarLargeButton;
    dxBarButtonClear: TdxBarLargeButton;
    dxBarButtonSelectAll: TdxBarLargeButton;
    dxBarButtonFind: TdxBarLargeButton;
    dxBarButtonReplace: TdxBarLargeButton;
    dxBarComboFontSize: TdxBarCombo;
    dxBarButtonBold: TdxBarLargeButton;
    dxBarButtonItalic: TdxBarLargeButton;
    dxBarButtonUnderline: TdxBarLargeButton;
    dxBarButtonBullets: TdxBarLargeButton;
    dxBarButtonAlignLeft: TdxBarLargeButton;
    dxBarButtonCenter: TdxBarLargeButton;
    dxBarButtonAlignRight: TdxBarLargeButton;
    dxBarButtonURLDetection: TdxBarLargeButton;
    dxBarSubItemHelp: TdxBarSubItem;
    dxBarButtonFont: TdxBarLargeButton;
    Splitter: TSplitter;
    OpenDialog: TOpenDialog;
    dxBarPopupMenu: TdxBarPopupMenu;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    FontDialog: TFontDialog;
    dxBarComboFontName: TdxBarFontNameCombo;
    dxBarComboFontColor: TdxBarColorCombo;
    LargeImage: TImageList;
    SmallImage: TImageList;
    dxBackBtn: TdxBarLargeButton;
    dxForwardBtn: TdxBarLargeButton;
    dxStopBtn: TdxBarLargeButton;
    dxRefreshBtn: TdxBarLargeButton;
    dxHomeBtn: TdxBarLargeButton;
    dxSearchBtn: TdxBarLargeButton;
    dxAddressCombo: TdxBarCombo;
    dxLinks: TdxBarStatic;
    dxProductsBtn: TdxBarLargeButton;
    dxDownloadsBtn: TdxBarLargeButton;
    BackPopupMenu: TdxBarPopupMenu;
    ForwardPopupMenu: TdxBarPopupMenu;
    dxBarHistory: TdxBarLargeButton;
    dxCityCombo: TdxBarTreeViewCombo;
    dxProductsCombo: TdxBarLookupCombo;
    dxDate: TdxBarDateCombo;
    dxIESelectAllBtn: TdxBarLargeButton;
    dxIEView: TdxBarSubItem;
    dxIEStop: TdxBarLargeButton;
    dxGo: TdxBarSubItem;
    dxIERefreshBtn: TdxBarLargeButton;
    dxIEBackBtn: TdxBarLargeButton;
    dxIEForwardBtn: TdxBarLargeButton;
    dxFavorites: TdxBarSubItem;
    dxIELinks: TdxBarSubItem;
    dxClearBtn: TdxBarLargeButton;
    dxBarDBNavigator: TdxBarDBNavigator;
    GridImageList: TImageList;
    dxFilter: TdxBarSubItem;
    dxDBNavig: TdxBarSubItem;
    dxOptions: TdxBarButton;
    Panel3: TPanel;
    dxFORUMBtn: TdxBarLargeButton;
    dxTypeCombo: TdxBarImageCombo;
    dxSideBarPopupMenu: TdxSideBarPopupMenu;
    FindDialog: TFindDialog;
    ReplaceDialog: TReplaceDialog;
    dxBarGroup: TdxBarGroup;
    dxBSPosition: TdxBarStatic;
    dxBSStatus: TdxBarStatic;
    dxBarProgress: TdxBarProgressItem;
    Panel1: TPanel;
    dxSideBar: TdxSideBar;
    Image: TImage;
    Panel2: TPanel;
    Nb: TNotebook;
    PanelRE: TPanel;
    Editor: TRichEdit;
    HTMLPanel: TPanel;
    DBGrid1: TDBGrid;
    dxBDStatus: TdxBarDockControl;
    dxBSIEStatus: TdxBarStatic;
    dxBarButtonAbout: TdxBarLargeButton;
    dxBarButtonDXDownloads: TdxBarLargeButton;
    dxBarButtonDXOntheweb: TdxBarLargeButton;
    dxBarButtonHelp: TdxBarLargeButton;
    dxBarButtonProducts: TdxBarLargeButton;
    dxBarButtonForum: TdxBarLargeButton;
    dxBarDBNavFirst1: TdxBarDBNavButton;
    dxBarDBNavPrev1: TdxBarDBNavButton;
    dxBarDBNavNext1: TdxBarDBNavButton;
    dxBarDBNavLast1: TdxBarDBNavButton;
    dxBarDBNavInsert1: TdxBarDBNavButton;
    dxBarDBNavDelete1: TdxBarDBNavButton;
    dxBarDBNavEdit1: TdxBarDBNavButton;
    dxBarDBNavPost1: TdxBarDBNavButton;
    dxBarDBNavCancel1: TdxBarDBNavButton;
    dxBarDBNavRefresh1: TdxBarDBNavButton;
    dxBarButton1: TdxBarLargeButton;
    ilDisabledImages: TImageList;
    ilHotImages: TImageList;
    Images: TImageList;
    dxBarLargeButton1: TdxBarLargeButton;
    dxBarLargeButton2: TdxBarLargeButton;
    procedure FormCreate(Sender: TObject);
    procedure dxSideBarItemClick(Sender: TObject; Item: TdxSideBarItem);
    procedure dxBarButtonNewClick(Sender: TObject);
    procedure dxBarButtonOpenClick(Sender: TObject);
    procedure dxBarButtonCloseClick(Sender: TObject);
    procedure EditorChange(Sender: TObject);
    procedure EditorSelectionChange(Sender: TObject);
    procedure dxBarButtonExitClick(Sender: TObject);
    procedure dxBarButtonSaveClick(Sender: TObject);
    procedure dxBarButtonSaveAsClick(Sender: TObject);
    procedure dxBarButtonPrintClick(Sender: TObject);
    procedure dxBarButtonUndoClick(Sender: TObject);
    procedure dxBarButtonCutClick(Sender: TObject);
    procedure dxBarButtonCopyClick(Sender: TObject);
    procedure dxBarButtonPasteClick(Sender: TObject);
    procedure dxBarButtonClearClick(Sender: TObject);
    procedure dxBarButtonSelectAllClick(Sender: TObject);
    procedure dxBarButtonFindClick(Sender: TObject);
    procedure dxBarButtonReplaceClick(Sender: TObject);
    procedure dxBarButtonFontClick(Sender: TObject);
    procedure dxBarButtonBulletsClick(Sender: TObject);
    procedure dxBarButtonProtectedClick(Sender: TObject);
    procedure dxBarComboFontColorChange(Sender: TObject);
    procedure dxBarComboFontColorClick(Sender: TObject);
    procedure dxBarComboHighlightClick(Sender: TObject);
    procedure dxBarButtonURLDetectionClick(Sender: TObject);
    procedure dxBarComboFontNameChange(Sender: TObject);
    procedure dxBarComboFontNameClick(Sender: TObject);
    procedure dxBarComboFontSizeChange(Sender: TObject);
    procedure dxBarComboFontSizeClick(Sender: TObject);
    procedure dxBarButtonBoldClick(Sender: TObject);
    procedure dxBarButtonItalicClick(Sender: TObject);
    procedure dxBarButtonUnderlineClick(Sender: TObject);
    procedure dxBarButtonAlignLeftClick(Sender: TObject);
    procedure dxBarButtonCenterClick(Sender: TObject);
    procedure dxBarButtonAlignRightClick(Sender: TObject);
    procedure dxAddressComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dxAddressComboDrawItem(Sender: TdxBarCustomCombo;
      AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
    procedure dxStopBtnClick(Sender: TObject);
    procedure dxRefreshBtnClick(Sender: TObject);
    procedure dxHomeBtnClick(Sender: TObject);
    procedure dxProductsBtnClick(Sender: TObject);
    procedure dxAddressComboChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dxBackBtnClick(Sender: TObject);
    procedure dxForwardBtnClick(Sender: TObject);
    procedure dxBarHistoryClick(Sender: TObject);
    procedure dxSearchBtnClick(Sender: TObject);
    procedure dxCityComboChange(Sender: TObject);
    procedure dxClearBtnClick(Sender: TObject);
    procedure dxProductsComboChange(Sender: TObject);
    procedure dxDateChange(Sender: TObject);
    procedure dxOptionsClick(Sender: TObject);
    procedure dxTypeComboChange(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure ReplaceDialogReplace(Sender: TObject);
  private
    FUpdating: Boolean;
    FHistoryIndex: Integer;
    FHistoryList: TStringList;
    FUpdateCombo: Boolean;
    FFileName : string;
    FAddress : string;
    FHTML: TWebBrowser;
    procedure UpdateToolBar( index : integer);
    procedure FindAddress;
  public
    function SaveFile(ASaveAs: Boolean): Boolean;
    function AskSaveFile: Boolean;
    procedure SetModified(Value: Boolean);
    procedure ShowItems(AShow: Boolean);
    procedure SetFilter;
    procedure StatusTextChange(Sender: TObject; const Text: WideString);
    procedure TitleChange(Sender: TObject; const Text: WideString);
    procedure DocumentComplete(Sender: TObject; {$IFDEF DELPHI12}const{$ENDIF} pDisp: IDispatch; var URL: OleVariant);
    procedure ProgressChange(Sender: TObject; Progress, ProgressMax: Integer);
    procedure BeforeNavigate(Sender: TObject; {$IFDEF DELPHI12}const{$ENDIF} pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant; var Cancel: WordBool);

  end;

var EBarMegaDemoMainForm : TEBarMegaDemoMainForm;

implementation

uses EBarMegaDemoOptions, EBarMegaDemoData, dxCore;

{$R *.DFM}
{$R windowsxp.res}

procedure TEBarMegaDemoMainForm.FormCreate(Sender: TObject);
const
  Filter = 'Rich Text Files (*.RTF)|*.RTF';
begin
  FHTML := TWebBrowser.Create(HTMLPanel);
  TWinControl(FHTML).Parent := HTMLPanel;

  FHTML.OnDocumentComplete := DocumentComplete;
  FHTML.OnProgressChange := ProgressChange;
  FHTML.OnBeforeNavigate2 := BeforeNavigate;
  FHTML.OnStatusTextChange := StatusTextChange;
  FHTML.OnTitleChange := TitleChange;

  FHTML.Align := alClient;

  FAddress := '';
  ShortDateFormat := 'mm/dd/yyyy';
  FUpdateCombo := True;
  OpenDialog.Filter := Filter;
  SaveDialog.Filter := Filter;
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir := OpenDialog.InitialDir;
  Editor.Clear;
  PanelRE.Visible := False;
  SetModified(False);
  ShowItems(False);
  BarManager.LockUpdate := True;
  UpdateToolBar(0);
  BarManager.LockUpdate := False;
  FHistoryIndex := -1;
  FHistoryList := TStringList.Create;
  with EBarMegaDemoMainDM do
  begin
    tblProducts.Close;
    tblContacts.Close;
    tblProducts.Open;
    tblContacts.Open;
  end;
  dxDate.Text := '';
  Editor.Lines.LoadFromFile('lipsum.rtf');
  SetModified(False);
  ShowItems(True);
  dxSideBarItemClick(nil, dxSideBar.Groups[0].Items[0]);
  dxSideBar.SelectedItem := dxSideBar.Groups[0].Items[0];
end;

procedure TEBarMegaDemoMainForm.UpdateToolBar(Index: Integer);

type TVisibleItems = set of Char;

const
  VisibleBars: array [0..3] of TVisibleItems = ([#0], [#0..#3,#9], [#0, #4..#6,#9], [#0,#7,#8]);
  VisibleCategories: array [0..3] of TVisibleItems = ([#0,#4,#5], [#0..#5], [#0,#1,#5,#4,#6,#7,#8,#10,#11], [#0,#4,#5,#9,#12]);
var
  I : Integer;
begin
  with BarManager do
  begin
    for I := 0 to Categories.Count - 1 do
      CategoryVisible[I] := dxCharInSet(Chr(I), VisibleCategories[Index]);
    for I := Bars.Count - 1 downto 0 do
      if (not dxCharInSet(Chr(I), VisibleBars[Index])) or (I = 0) then
      begin
        Bars[I].Visible := False;
        Bars[I].Hidden := True;
      end;
    for I := 0 to ItemCount - 1 do
      if (Items[I].Tag = 0 ) or (Items[I].Tag = Index) then
       Items[I].Visible := ivAlways
      else
       Items[I].Visible := ivNever;
    for i := 0 to Bars.Count - 1 do
      if dxCharInSet(Chr(I), VisibleBars[Index]) or (I = 0) then
      begin
        Bars[I].Visible := True;
        Bars[I].Hidden := False;
      end;
    NB.PageIndex := Index;
  end;
  dxBSIEStatus.Caption := '';
  dxBSStatus.Caption := '';
  dxBSPosition.Caption := '';
  dxBarProgress.Position := 0;
  dxBSIEStatus.Glyph := nil;
  if Index = 2 then
    dxBSIEStatus.Glyph.Assign(Image.Picture.Bitmap);
end;

procedure TEBarMegaDemoMainForm.dxSideBarItemClick(Sender: TObject;
  Item: TdxSideBarItem);
begin
  Caption := 'ExpressBars Mega Demo';
  LockWindowUpdate(Self.Handle);
  BarManager.LockUpdate := True;
  UpdateToolBar(Item.Tag);
  BarManager.LockUpdate := False;
  LockWindowUpdate(0);
end;

procedure TEBarMegaDemoMainForm.dxBarButtonNewClick(Sender: TObject);
var
  Res : Integer;
begin
  if Editor.Modified then
  begin
    Res := Application.MessageBox(PChar(Format('Do you want to save the changes you made ?',
      [FFileName])), PChar(FFileName), MB_ICONQUESTION or MB_YESNOCANCEL);
    case Res of
      ID_YES:
        if SaveFile(False) then
          Editor.Lines.Clear
        else
          exit;
      ID_NO:
        Editor.Lines.Clear;
      ID_CANCEL:
        exit;
    end;
  end;
  Editor.Lines.Clear;
  FFileName := '';
  ShowItems(True);
end;

function TEBarMegaDemoMainForm.AskSaveFile: Boolean;
var
 Res: Integer;
begin
  Result := True;
  if Editor.Modified then
  begin
    Res := Application.MessageBox(PChar(Format('Do you want to save the changes you made to "%s"?',
    [FFileName])), PChar(FFileName), MB_ICONQUESTION or MB_YESNOCANCEL);
    if Res = ID_CANCEL then
      Result := False;
    if Res = ID_YES then
      Result := SaveFile(False);
  end;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonCloseClick(Sender: TObject);
begin
  if not AskSaveFile then exit;
  Editor.Lines.Clear;
  ShowItems(False);
end;

procedure TEBarMegaDemoMainForm.dxBarButtonOpenClick(Sender: TObject);
begin
  if not AskSaveFile then exit;
  OpenDialog.FileName := '';
  if OpenDialog.Execute then
  begin
    FFileName := OpenDialog.FileName;
    Editor.Lines.LoadFromFile(FFileName);
    SetModified(False);
    ShowItems(True);
  end;
end;


procedure TEBarMegaDemoMainForm.EditorChange(Sender: TObject);
begin
  if Editor = nil then Exit;
  Editor.OnSelectionChange(Editor);
  SetModified(Editor.Modified);
  dxBarButtonUndo.Caption := '&Undo';
  dxBarButtonUndo.Enabled := SendMessage(Editor.Handle, EM_CANUNDO, 0, 0) <> 0;
end;

procedure TEBarMegaDemoMainForm.EditorSelectionChange(Sender: TObject);
var Col, Row : integer;
begin

  Row := SendMessage(Editor.Handle, EM_LINEFROMCHAR, Editor.SelStart, 0);
  Col := Editor.SelStart - SendMessage(Editor.Handle, EM_LINEINDEX, Row, 0);

  with Editor, SelAttributes do
  begin
    FUpdating := True;
    try
       dxBSPosition.Caption :=
         Format('Line: %3d   Col: %3d', [1 + Row, 1 + Col]);

       dxBarButtonCopy.Enabled := SelLength > 0;
       dxBarButtonCut.Enabled := dxBarButtonCopy.Enabled;
       dxBarButtonPaste.Enabled := ((SendMessage(Editor.Handle, EM_CANPASTE, 0, 0) <> 0) and dxBarButtonSave.Enabled);
       dxBarButtonClear.Enabled := dxBarButtonCopy.Enabled;

       dxBarComboFontSize.Text := IntToStr(Size);
       dxBarComboFontName.Text := Name;

       dxBarButtonBold.Down := fsBold in Style;
       dxBarButtonItalic.Down := fsItalic in Style;
       dxBarButtonUnderline.Down := fsUnderline in Style;

       dxBarButtonBullets.Down := Boolean(Paragraph.Numbering);
       case Ord(Paragraph.Alignment) of
         0: dxBarButtonAlignLeft.Down := True;
         1: dxBarButtonAlignRight.Down := True;
         2: dxBarButtonCenter.Down := True;
       end;
       dxBarButtonURLDetection.Down := Boolean(SendMessage(Editor.Handle, EM_GETAUTOURLDETECT, 0, 0));

       dxBarComboFontColor.Color := Editor.SelAttributes.Color;
    finally
      FUpdating := False;
    end;
  end;
end;

function TEBarMegaDemoMainForm.SaveFile(ASaveAs: Boolean): Boolean;
begin
  if ASaveAs or (FFileName = '') then
  begin
    SaveDialog.FileName := FFileName;
    Result := SaveDialog.Execute;
    if not Result then Exit;
    FFileName := SaveDialog.FileName;
  end;
  Editor.Lines.SaveToFile(FFileName);
  SetModified(False);
  Result := True;
end;

procedure TEBarMegaDemoMainForm.SetModified(Value: Boolean);
begin
  Editor.Modified := Value;
  if Value then
    dxBSStatus.Caption := 'Modified'
  else
    dxBSStatus.Caption := '';
  if FFileName <> '' then
    dxBarButtonSave.Enabled := Value;
end;

procedure TEBarMegaDemoMainForm.ShowItems(AShow: Boolean);
var
  AVisible: TdxBarItemVisible;
begin
  if not AShow then
  begin
    dxBSStatus.Caption := '';
    dxBSPosition.Caption := '';
  end;
  BarManager.Groups[0].Enabled := AShow;
  if AShow then AVisible := ivAlways
  else AVisible := ivInCustomizing;

  dxBarSubItemEdit.Visible := AVisible;
  dxBarSubItemFormat.Visible := AVisible;

  PanelRE.Visible := AShow;
  Editor.Repaint;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonExitClick(Sender: TObject);
begin
  Close;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonSaveClick(Sender: TObject);
begin
  SaveFile(False);
end;

procedure TEBarMegaDemoMainForm.dxBarButtonSaveAsClick(Sender: TObject);
begin
  SaveFile(True);
end;

procedure TEBarMegaDemoMainForm.dxBarButtonPrintClick(Sender: TObject);
begin
  if PrintDialog.Execute then
    Editor.Print(FFileName);
end;

procedure TEBarMegaDemoMainForm.dxBarButtonUndoClick(Sender: TObject);
begin
  SendMessage(Editor.Handle, EM_UNDO, 0, 0);
end;

procedure TEBarMegaDemoMainForm.dxBarButtonCutClick(Sender: TObject);
begin
  Editor.CutToClipboard;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonCopyClick(Sender: TObject);
begin
  Editor.CopyToClipboard;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonPasteClick(Sender: TObject);
begin
  Editor.PasteFromClipboard;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonClearClick(Sender: TObject);
begin
  Editor.ClearSelection;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonSelectAllClick(Sender: TObject);
begin
  Editor.SelectAll;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonFindClick(Sender: TObject);
begin
  Editor.SelLength := 0;
  FindDialog.Execute;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonReplaceClick(Sender: TObject);
begin
  Editor.SelLength := 0;
  ReplaceDialog.Execute;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);
end;

procedure TEBarMegaDemoMainForm.dxBarButtonBulletsClick(Sender: TObject);
begin
  Editor.Paragraph.Numbering := TNumberingStyle(dxBarButtonBullets.Down);
end;

procedure TEBarMegaDemoMainForm.dxBarButtonProtectedClick(Sender: TObject);
begin
  Editor.SelAttributes.Protected := not Editor.SelAttributes.Protected;
end;

procedure TEBarMegaDemoMainForm.dxBarComboFontColorChange(Sender: TObject);
begin
  if not FUpdating then
    Editor.SelAttributes.Color := dxBarComboFontColor.Color;
end;

procedure TEBarMegaDemoMainForm.dxBarComboFontColorClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);
end;

procedure TEBarMegaDemoMainForm.dxBarComboHighlightClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);
end;

procedure TEBarMegaDemoMainForm.dxBarButtonURLDetectionClick(Sender: TObject);
var
  URLDetection : Boolean;
begin
  URLdetection := Boolean(SendMessage(Editor.Handle, EM_GETAUTOURLDETECT, 0, 0));
  URLdetection := not URLdetection;
  SendMessage(Editor.Handle, EM_AUTOURLDETECT, Longint(URLdetection), 0);
end;

procedure TEBarMegaDemoMainForm.dxBarComboFontNameChange(Sender: TObject);
begin
  if not FUpdating then
    Editor.SelAttributes.Name := dxBarComboFontName.Text;
end;

procedure TEBarMegaDemoMainForm.dxBarComboFontNameClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);
end;

procedure TEBarMegaDemoMainForm.dxBarComboFontSizeChange(Sender: TObject);
begin
  if not FUpdating then
    Editor.SelAttributes.Size := StrToInt(dxBarComboFontSize.Text);
end;

procedure TEBarMegaDemoMainForm.dxBarComboFontSizeClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);
end;

procedure TEBarMegaDemoMainForm.dxBarButtonBoldClick(Sender: TObject);
begin
  with Editor.SelAttributes do
    if dxBarButtonBold.Down then
      Style := Style + [fsBold]
    else
      Style := Style - [fsBold];
end;

procedure TEBarMegaDemoMainForm.dxBarButtonItalicClick(Sender: TObject);
begin
  with Editor.SelAttributes do
    if dxBarButtonItalic.Down then
      Style := Style + [fsItalic]
    else
      Style := Style - [fsItalic];
end;

procedure TEBarMegaDemoMainForm.dxBarButtonUnderlineClick(Sender: TObject);
begin
  with Editor.SelAttributes do
    if dxBarButtonUnderline.Down then
      Style := Style + [fsUnderline]
    else
      Style := Style - [fsUnderline];
end;

procedure TEBarMegaDemoMainForm.dxBarButtonAlignLeftClick(Sender: TObject);
begin
  if TdxBarLargeButton(Sender).Down then
    Editor.Paragraph.Alignment := TAlignment(0)
  else
    Editor.Paragraph.Alignment := taLeftJustify;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonCenterClick(Sender: TObject);
begin
  if TdxBarLargeButton(Sender).Down then
    Editor.Paragraph.Alignment := TAlignment(2)
  else
    Editor.Paragraph.Alignment := taLeftJustify;
end;

procedure TEBarMegaDemoMainForm.dxBarButtonAlignRightClick(Sender: TObject);
begin
  if TdxBarLargeButton(Sender).Down then
    Editor.Paragraph.Alignment := TAlignment(1)
  else
    Editor.Paragraph.Alignment := taLeftJustify;
end;

procedure TEBarMegaDemoMainForm.dxAddressComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    dxAddressCombo.Items.Insert(0, FAddress);
end;

procedure TEBarMegaDemoMainForm.dxAddressComboDrawItem(Sender: TdxBarCustomCombo;
  AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
var
  RectText: TRect;
begin
  with Sender,Canvas,ARect do
  begin
    Brush.Color := clWindow;
    FillRect(ARect);
    RectText := ARect;
    Inc(RectText.Left, 16);
    if AIndex >= 0 then
      RectText.Right := RectText.Left + TextWidth(Items[AIndex]) + 4;
    if odSelected in AState then
    begin
      Brush.Color := clHighlight;
      FillRect(RectText);
    end;
    if AIndex >= 0 then
    begin
      Draw(Left + 1, Top + 2, Image.Picture.Bitmap);
      TextOut(RectText.Left + 2, Top , Items[AIndex]);
    end
    else
      if Sender.Text <> '' then begin
        Draw(Left + 1, Top + 2, Image.Picture.Bitmap);
        TextOut(RectText.Left + 2, Top , Sender.Text);
      end;
    if odSelected in AState then
      DrawFocusRect(RectText);
  end;
end;

procedure TEBarMegaDemoMainForm.FindAddress;
var Flags, TargetFrameName, PostData, Headers: OleVariant;
begin
  FHTML.Navigate(FAddress, Flags, TargetFrameName, PostData, Headers);
end;


procedure TEBarMegaDemoMainForm.dxStopBtnClick(Sender: TObject);
begin
  if FHistoryIndex <> -1 then FHTML.Stop;
end;

procedure TEBarMegaDemoMainForm.dxRefreshBtnClick(Sender: TObject);
begin
  if FHistoryIndex <> -1 then FHTML.Refresh;
end;

procedure TEBarMegaDemoMainForm.dxHomeBtnClick(Sender: TObject);
begin
 FAddress := 'http://www.devexpress.com/';
 FindAddress;
end;

procedure TEBarMegaDemoMainForm.dxProductsBtnClick(Sender: TObject);
begin
 FAddress := TdxBarLargeButton(Sender).Hint;
 FindAddress;
end;

procedure TEBarMegaDemoMainForm.dxAddressComboChange(Sender: TObject);
begin
  if FUpdateCombo then
  begin
    FAddress := dxAddressCombo.Text;
    FindAddress;
  end;
end;

procedure TEBarMegaDemoMainForm.FormDestroy(Sender: TObject);
begin
  FHTML.Stop;
  FHistoryList.Free;
  FHTML.Free;
end;

procedure TEBarMegaDemoMainForm.dxBackBtnClick(Sender: TObject);
begin
  FAddress := FHistoryList[FHistoryIndex - 1];
  FindAddress;
end;

procedure TEBarMegaDemoMainForm.dxForwardBtnClick(Sender: TObject);
begin
  FAddress := FHistoryList[FHistoryIndex + 1];
  FindAddress;
end;

procedure TEBarMegaDemoMainForm.dxBarHistoryClick(Sender: TObject);
begin
  if TdxBarLargeButton(Sender).ClickItemLink <> nil then
  begin
    FAddress := TdxBarLargeButton(Sender).ClickItemLink.UserCaption;
    FindAddress;
  end;
end;

procedure TEBarMegaDemoMainForm.dxSearchBtnClick(Sender: TObject);
begin
  FHTML.GoSearch;
end;

procedure TEBarMegaDemoMainForm.dxCityComboChange(Sender: TObject);
begin
  SetFilter;
end;

procedure TEBarMegaDemoMainForm.SetFilter;
const
  PaymentStr: array [0..3] of string = ('CASH', 'VISA', 'MASTER', 'AMEX');
var
  Filter: string;
  I: integer;
begin
  Filter := '';

  with dxCityCombo do
    if Text <> '' then
      if SelectedNode.Count = 0 then
        Filter := 'City = ''' + Text + ''''
      else
      begin
        for I := 0 to SelectedNode.Count - 1 do
          if Filter = '' then
            Filter := Filter + '( City = ''' + SelectedNode.Item[I].Text + ''' )'
          else
            Filter := Filter + ' or ( City = ''' + SelectedNode.Item[I].Text + ''' )';
      end;
    if Filter <> '' then
      Filter := '(' + Filter + ')';
    if dxProductsCombo.Text <> '' then
      if Filter = '' then
        Filter := '( ProductID = ' + EBarMegaDemoMainDM.tblProducts.FieldByName('ID').AsString + ')'
      else Filter := Filter + ' and ( ProductID = ' + EBarMegaDemoMainDM.tblProducts.FieldByName('ID').AsString + ')';
    if dxDate.Text <> '' then
      if Filter = '' then
        Filter := '( PurchaseDate = ''' + DateToStr(dxDate.Date) + ''')'
      else
        Filter := Filter + ' and ( PurchaseDate = ''' + DateToStr(dxDate.Date) + ''')';
    if dxTypeCombo.Text <> '' then
      if Filter = '' then
        Filter := '( PaymentType = ''' + PaymentStr[dxTypeCombo.ItemIndex] + ''')'
      else
        Filter := Filter + ' and ( PaymentType = ''' + PaymentStr[dxTypeCombo.ItemIndex] + ''')';
  EBarMegaDemoMainDM.tblContacts.Filter := Filter;
  EBarMegaDemoMainDM.tblContacts.Filtered := True;
end;

procedure TEBarMegaDemoMainForm.dxClearBtnClick(Sender: TObject);
begin
  dxCityCombo.Text := '';
  dxProductsCombo.KeyValue := null;
  dxProductsCombo.Text := '';
  dxDate.Text := '';
  dxTypeCombo.ItemIndex := -1;
  EBarMegaDemoMainDM.tblContacts.Filter := '';
  EBarMegaDemoMainDM.tblContacts.Filtered := False;
end;

procedure TEBarMegaDemoMainForm.dxProductsComboChange(Sender: TObject);
begin
  SetFilter;
end;

procedure TEBarMegaDemoMainForm.dxDateChange(Sender: TObject);
begin
  SetFilter;
end;

procedure TEBarMegaDemoMainForm.dxOptionsClick(Sender: TObject);
begin
  EBarMegaDemoOptionsForm.Show;
end;

procedure TEBarMegaDemoMainForm.dxTypeComboChange(Sender: TObject);
begin
  SetFilter;
end;

procedure TEBarMegaDemoMainForm.ProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
begin
  dxBarProgress.Max := ProgressMax;
  dxBarProgress.Position := Progress;
end;

procedure TEBarMegaDemoMainForm.DocumentComplete(Sender: TObject; {$IFDEF DELPHI12}const{$ENDIF} pDisp: IDispatch; var URL: OleVariant);
begin
  dxBarProgress.Position := 0;
end;

procedure TEBarMegaDemoMainForm.FindDialogFind(Sender: TObject);
var
  StartPos, FindLength, FoundAt: Integer;
  Flags: TSearchTypes;
  P: TPoint;
  CaretR, R, IntersectR: TRect;
begin
  with Editor, TFindDialog(Sender) do
  begin
    if frDown in Options then
    begin
      if SelLength = 0 then StartPos := SelStart
      else StartPos := SelStart + SelLength;
      FindLength := Length(Text) - StartPos;
    end
    else
    begin
      StartPos := SelStart;
      FindLength := -StartPos;
    end;
    Flags := [];
    if frMatchCase in Options then Include(Flags, stMatchCase);
    if frWholeWord in Options then Include(Flags, stWholeWord);
    Screen.Cursor := crHourglass;
    FoundAt := Editor.FindText(FindText, StartPos, FindLength, Flags);
    if not (frReplaceAll in Options) then Screen.Cursor := crDefault;
    if FoundAt > -1 then
      if frReplaceAll in Options then
      begin
        SelStart := FoundAt;
        SelLength := Length(FindText);
      end
      else
      begin
        SetFocus;
        SelStart := FoundAt;
        SelLength := Length(FindText);

        GetCaretPos(P);
        P := ClientToScreen(P);
        CaretR := Rect(P.X, P.Y, P.X + 2, P.Y + 20);
        GetWindowRect(Handle, R);
        if IntersectRect(IntersectR, CaretR, R) then
          if P.Y < Screen.Height div 2 then
            Top := P.Y + 40
          else
            Top := P.Y - (R.Bottom - R.Top + 20);
      end
    else
      if not (frReplaceAll in Options) then
        Application.MessageBox('Text not found', 'Information', MB_ICONINFORMATION);
  end;
end;

procedure TEBarMegaDemoMainForm.ReplaceDialogReplace(Sender: TObject);
var
  ReplacedCount, OldSelStart, PrevSelStart: Integer;
  S: string;
begin
  with Editor, TReplaceDialog(Sender) do
  begin
    ReplacedCount := 0;
    OldSelStart := SelStart;
    if frReplaceAll in Options then
      Screen.Cursor := crHourglass;
    repeat
      if (SelLength > 0) and ((SelText = FindText) or
        (not (frMatchCase in Options) and
         (AnsiUpperCase(SelText) = AnsiUpperCase(FindText)))) then
      begin
        SelText := ReplaceText;
        Inc(ReplacedCount);
      end;
      PrevSelStart := SelStart;
      FindDialogFind(Sender);
    until not (frReplaceAll in Options) or (SelStart = PrevSelStart);
    if frReplaceAll in Options then
    begin
      Screen.Cursor := crDefault;
      if ReplacedCount = 0 then S := 'Text not found'
      else
      begin
        SelStart := OldSelStart;
        S := Format('Replace All', [ReplacedCount]);
      end;
      Application.MessageBox(PChar(S), 'Information',
        MB_ICONINFORMATION);
    end;
  end;
end;

procedure TEBarMegaDemoMainForm.BeforeNavigate(Sender: TObject; {$IFDEF DELPHI12}const{$ENDIF} pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant; var Cancel: WordBool);
var
  NewIndex, I: Integer;
  NAddress: string;
begin

  NAddress := URL;
  if NAddress = '' then NAddress := FAddress;
  if NAddress = '' then exit;

  NewIndex := FHistoryList.IndexOf(NAddress);
  if NewIndex = -1 then
  begin
    FHistoryList.Add(NAddress);
    NewIndex := FHistoryList.IndexOf(NAddress);
  end;

  FUpdateCombo := False;
  dxAddressCombo.Text := NAddress;
  FUpdateCombo := True;


  with ForwardPopupMenu.ItemLinks do
  begin
   Clear;
   for I := FHistoryList.Count - 1 downto NewIndex + 1 do
    with Add do
     begin
      Index := 0;
      Item := dxBarHistory;
      UserCaption := FHistoryList[i];
     end;
  end;

  with BackPopupMenu.ItemLinks do
  begin
   Clear;
   for i := 0 to NewIndex - 1 do
    with Add do
     begin
      Index := 0;
      Item := dxBarHistory;
      UserCaption := FHistoryList[I];
     end;
  end;

  FHistoryIndex := NewIndex;

  if FHistoryIndex = 0 then
  begin
    dxBackBtn.Enabled := False;
    dxIEBackBtn.Enabled := False;
  end else
  begin
    dxBackBtn.Enabled := True;
    dxIEBackBtn.Enabled := True;
  end;

  if FHistoryIndex = FHistoryList.Count - 1 then
  begin
    dxForwardBtn.Enabled := False;
    dxIEForwardBtn.Enabled := False;
  end else
  begin
    dxForwardBtn.Enabled := True;
    dxIEForwardBtn.Enabled := True;
  end;
end;

procedure TEBarMegaDemoMainForm.StatusTextChange(Sender: TObject; const Text: WideString);
begin
  if Text = '' then
    dxBSIEStatus.Caption := 'Done'
  else
    dxBSIEStatus.Caption := TCaption(Text);
end;

procedure TEBarMegaDemoMainForm.TitleChange(Sender: TObject; const Text: WideString);
begin
  Caption := TCaption(Text);
end;

end.
