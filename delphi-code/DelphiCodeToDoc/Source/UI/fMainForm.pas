{*------------------------------------------------------------------------------
  User interface of DelphiCodeToDoc
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence
  @Author    TridenT
  @Version   2003/12/01   TridenT   v0.0     Initial revision
-------------------------------------------------------------------------------}

unit fMainForm;

interface

uses
  Classes, Forms, ImgList, Controls, StdActns, JvDialogActns, ActnList,
  XPStyleActnCtrls, ActnMan, ActnMenus, ToolWin, ActnCtrls, ComCtrls,
  JvStatusBar, JvComponent, JvLookOut, SysUtils, StdCtrls, JvInspector,
  JvComCtrls, JvGnugettext, JvExComCtrls, JvExControls, JvComponentBase, Types,
  JvExStdCtrls, JvRichEdit, ExtCtrls, JvExExtCtrls, JvSplit, JvSplitter;

type
  TMainForm = class(TForm)
    JvExpress1: TJvExpress;
    ebInformation: TJvExpressButton;
    ebConfiguration: TJvExpressButton;
    ebProjectFiles: TJvExpressButton;
    ebReference: TJvExpressButton;
    ebMessages: TJvExpressButton;
    ImageListSmall: TImageList;
    ImageListLarge: TImageList;
    ActionManager1: TActionManager;
    ActionNewproject: TAction;
    ActionQuickWizardProject: TAction;
    ActionOpenProject: TJvOpenFileAction;
    ActionSaveAsProject: TJvSaveFileAction;
    FileExit1: TFileExit;
    ActionAbout: TAction;
    ActionAddFiles: TAction;
    ActionCheck: TAction;
    ActionBuild: TAction;
    ActionInformation: TAction;
    ActionConfiguration: TAction;
    ActionProject: TAction;
    ActionReference: TAction;
    ActionMessages: TAction;
    StatusBar1: TStatusBar;
    JvPageControl1: TJvPageControl;
    tsInformation: TTabSheet;
    tsConfiguration: TTabSheet;
    tsProjectFiles: TTabSheet;
    tsReference: TTabSheet;
    tsMessages: TTabSheet;
    mDebug: TMemo;
    JvInspector1: TJvInspector;
    JvInspectorDotNETPainter1: TJvInspectorDotNETPainter;
    mUser: TMemo;
    tvReference: TJvTreeView;
    LabelMustCheckBefore: TLabel;
    ActionCloseProject: TAction;
    ActionLanguageEnglish: TAction;
    ActionToolBar1: TActionToolBar;
    ActionMainMenuBar1: TActionMainMenuBar;
    Memo1: TMemo;
    ActionCheckAndBuild: TAction;
    ActionViewOutput: TAction;
    ActionPurgeOutputFolder: TAction;
    ActionSaveProject: TAction;
    ActionClearMessages: TAction;
    ActionFullWizardProject: TAction;
    ActionImportOldProject: TJvOpenFileAction;
    tsQuality: TTabSheet;
    ebQuality: TJvExpressButton;
    ActionQuality: TAction;
    tvQuality: TJvTreeView;
    JvRichEditTagDetails: TJvRichEdit;
    JvSplitter1: TJvSplitter;
    procedure ActionAboutExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionInformationExecute(Sender: TObject);
    procedure ActionConfigurationExecute(Sender: TObject);
    procedure ActionProjectExecute(Sender: TObject);
    procedure ActionReferenceExecute(Sender: TObject);
    procedure ActionQualityExecute(Sender: TObject);
    procedure ActionMessagesExecute(Sender: TObject);
    procedure ActionFullWizardProjectExecute(Sender: TObject);
    procedure ActionCheckExecute(Sender: TObject);
    procedure ActionBuildExecute(Sender: TObject);
    procedure ActionCloseProjectExecute(Sender: TObject);
    procedure ActionManager1Update(Action: TBasicAction; var Handled: boolean);
    procedure ActionSaveAsProjectAccept(Sender: TObject);
    procedure ActionImportOldProjectAccept(Sender: TObject);
    procedure ActionLoadProjectAccept(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AskChangeLanguage(Sender: TObject);
    procedure ActionCheckAndBuildExecute(Sender: TObject);
    procedure ActionViewOutputExecute(Sender: TObject);
    procedure ActionPurgeOutputFolderExecute(Sender: TObject);
    procedure ActionSaveProjectExecute(Sender: TObject);
    procedure ActionSaveAsProjectJvSaveDialogShow(Sender: TObject);
    procedure ActionClearMessagesExecute(Sender: TObject);
    procedure ActionQuickWizardProjectExecute(Sender: TObject);
    procedure JvInspector1DataValueChanged(Sender: TObject;
      Data: TJvCustomInspectorData);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tvQualitySelectionChange(Sender: TObject);
    procedure tvQualityCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    { Private declarations }
    EnableActions: Boolean;
    procedure AddTranslationsToMenu;
    procedure AddConfigurationPropertys;
    procedure ChangeChkState(const Item: TJvCustomInspectorItem);
    procedure iieBoolsAsChecks(Sender: TObject);
    procedure UpdateReferences;
    procedure UpdateQuality;
    procedure SetTitle;
  public
    { Public declarations }
    procedure AddUserMessage(const st: string);
    procedure AddDebugMessage(const st: string);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses fAbout, uDocProject, JvInspExtraEditors, TypInfo, fQuickWizard
  , JvMemo, JclShell, uOptions, uOldOptions, Dialogs, StrUtils, Graphics, uMessages
  , JclFileUtils, Windows, fNiceWizard, uDOCTemplate, uAppSettings;

resourcestring
 RS_PROJECT_CHANGES_CONFIRM = 'The project [%s] has changed.'+#13+#10+'Do you want to save these modifications ?';

{*------------------------------------------------------------------------------
  This is the reply to the selection of Menu>About
  @Param Sender default Sender Object
-------------------------------------------------------------------------------}
procedure TMainForm.ActionAboutExecute(Sender: TObject);
var
  AboutBox: TAboutBox;
begin
  AboutBox := TAboutBox.Create(self);
  AboutBox.ShowModal;
  AboutBox.Release;
end;

// Add translations found with SearchTranslations to menu
procedure TMainForm.AddTranslationsToMenu;
var
  IndexLanguage: integer;
  tmpAction:     TAction;
  LanguageFound: boolean;
begin
  LanguageFound := False;
  // Initialization to prevent compilation warning
  tmpAction:=nil;
  for IndexLanguage := 0 to AvailableLanguages.Count - 1 do
  begin
    // Create Action
    tmpAction := TAction.Create(ActionManager1);
    tmpAction.ActionList := ActionManager1;
    tmpAction.Assign(ActionLanguageEnglish);
    //tmpAction.Name:='ActionLanguage'+AvailableLanguages.Strings[IndexLanguage];
    tmpAction.AutoCheck := False;
    tmpAction.Caption := AvailableLanguages.Strings[IndexLanguage] +
      ' (' + AvailableLanguagesCode.Strings[IndexLanguage] + ')';
    tmpAction.Tag := IndexLanguage;
    tmpAction.GroupIndex := 1;
    // Add Action to ActionMenu
    ActionManager1.AddAction(tmpAction
      , ActionManager1.FindItemByAction(ActionLanguageEnglish));
    // Autodetect language used by comparing CurrentLanguage and Available language
    if AnsiStartsText(AvailableLanguagesCode.Strings[IndexLanguage]
      , GetCurrentLanguage) then
    begin
      tmpAction.Checked := True;
      LanguageFound     := True;
    end;
  end;
  // if autodetect failed, Set English (last language in list) as standard
  Assert(Assigned(tmpAction));
  if not LanguageFound then
    tmpAction.Checked := True;

  // Hide TAction Template
  ActionLanguageEnglish.Visible := False;
end;


procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Ignore some classes for translation
  IgnoreTranslations;
  // Search for existing Translations
  SearchTranslations;
  AddTranslationsToMenu;
  // Translate the form
  TranslateComponent(self);
  //TranslateComponent(JvInspector1);
  self.Caption := Application.Title;
  ActionInformationExecute(self);
  // Set divider to 50% of inspector's width
  JvInspector1.Divider := JvInspector1.Width div 2;
  // Enable actions
  EnableActions:=True;
end;

procedure TMainForm.ActionInformationExecute(Sender: TObject);
begin
  ebInformation.Down := True;
  tsInformation.Show;
end;

procedure TMainForm.ActionConfigurationExecute(Sender: TObject);
begin
  ebConfiguration.Down := True;
  tsConfiguration.Show;
end;

procedure TMainForm.ActionProjectExecute(Sender: TObject);
begin
  ebProjectFiles.Down := True;
  tsProjectFiles.Show;
end;

procedure TMainForm.ActionReferenceExecute(Sender: TObject);
begin
  ebReference.Down := True;
  tsReference.Show;
end;

procedure TMainForm.ActionQualityExecute(Sender: TObject);
begin
  ebQuality.Down := True;
  tsQuality.Show;
  tvQuality.SetFocus;
end;

procedure TMainForm.ActionMessagesExecute(Sender: TObject);
begin
  ebMessages.Down := True;
  tsMessages.Show;
end;

procedure TMainForm.ChangeChkState(const Item: TJvCustomInspectorItem);
var
  I: integer;
begin
  if Item is TJvInspectorBooleanItem then
  begin
    TJvInspectorBooleanItem(Item).ShowAsCheckbox := DocProject.DocOptions.BoolsAsChecks
  end;
  for I := 0 to Item.Count - 1 do
  begin
    ChangeChkState(Item[I])
  end;
end;

function AddProperty(const Cat: TJvInspectorCustomCategoryItem;
  const Prop: TPropertyDescription): TJvCustomInspectorItem;
begin
  Result := TJvInspectorPropData.New(Cat, DocProject.DocOptions,
    GetPropInfo(DocProject.DocOptions, Prop.iName));
  Result.ReadOnly := Prop.iReadOnly;
  // Must force translation of Prop.iCaption, maybe because of resourcestrings
  //  include in a const table !
  if Prop.iReadOnly then
  begin
    Result.DisplayName := gettext(Prop.iCaption) + gettext(' (ReadOnly)')
  end
  else begin
    Result.DisplayName := gettext(Prop.iCaption)
  end;

  if Prop.iName = pdNameBoolsAsChecks then
  begin
    Result.OnValueChanged :=
      MainForm.iieBoolsAsChecks
  end;
  MainForm.ChangeChkState(Result);
end;

procedure TMainForm.AddConfigurationPropertys;
var
  InspCat:   TJvInspectorCustomCategoryItem;
  InspCatInput : TJvInspectorCustomCategoryItem;
  IndexProp: integer;
begin
  JvInspector1.BeginUpdate;
  JvInspector1.Root.SortKind := iskNone;
  JvInspector1.SelectedIndex := 0;
  // APPLICATION
  InspCat := TJvInspectorCustomCategoryItem.Create(JvInspector1.Root, nil);
  InspCat.DisplayName := ccApplicationOptions;
  InspCat.Expanded := True;
  for IndexProp := low(C_APPLICATION_PROPERTYS_DESCRIPTION)
    to high(C_APPLICATION_PROPERTYS_DESCRIPTION) do
  begin
    AddProperty(InspCat, C_APPLICATION_PROPERTYS_DESCRIPTION[IndexProp])
  end;
  // INPUT
  InspCatInput := TJvInspectorCustomCategoryItem.Create(JvInspector1.Root, nil);
  InspCatInput.DisplayName := ccInputOptions;
  InspCatInput.Expanded := True;
  for IndexProp := low(C_INPUT_PROPERTYS_DESCRIPTION)
    to high(C_INPUT_PROPERTYS_DESCRIPTION) do
  begin
    AddProperty(InspCatInput, C_INPUT_PROPERTYS_DESCRIPTION[IndexProp])
  end;
  // PROPERTIES COMMENT
  InspCat := TJvInspectorCustomCategoryItem.Create(InspCatInput, nil);
  InspCat.DisplayName := ccCommentRules;
  InspCat.Expanded := True;
  for IndexProp := low(C_COMMENT_RULES) to high(C_COMMENT_RULES) do
  begin
    AddProperty(InspCat, C_COMMENT_RULES[IndexProp])
  end;

  // JAVADOC PREFIX
  InspCat := TJvInspectorCustomCategoryItem.Create(InspCatInput, nil);
  InspCat.DisplayName := ccJavaDocPrefixOptions;
  InspCat.Expanded := True;
  for IndexProp := low(C_JAVADOC_PREFIX_PROPERTYS_DESCRIPTION)
    to high(C_JAVADOC_PREFIX_PROPERTYS_DESCRIPTION) do
  begin
    AddProperty(InspCat, C_JAVADOC_PREFIX_PROPERTYS_DESCRIPTION[IndexProp])
  end;

  // Files
  InspCat := TJvInspectorCustomCategoryItem.Create(InspCatInput, nil);
  InspCat.DisplayName := ccFilesList;
  InspCat.Expanded := True;
  for IndexProp := low(C_FILES_LIST_PROPERTYS_DESCRIPTION)
    to high(C_FILES_LIST_PROPERTYS_DESCRIPTION) do
  begin
    AddProperty(InspCat, C_FILES_LIST_PROPERTYS_DESCRIPTION[IndexProp])
  end;

  // OUTPUT
  InspCat := TJvInspectorCustomCategoryItem.Create(JvInspector1.Root, nil);
  InspCat.DisplayName := ccOutputOptions;
  InspCat.Expanded := True;
  for IndexProp := low(C_OUTPUT_PROPERTYS_DESCRIPTION)
    to high(C_OUTPUT_PROPERTYS_DESCRIPTION) do
  begin
    AddProperty(InspCat, C_OUTPUT_PROPERTYS_DESCRIPTION[IndexProp])
  end;
  // JAVADOC SUPPORT
  InspCat := TJvInspectorCustomCategoryItem.Create(InspCat, nil);
  InspCat.DisplayName := ccJavaDocSupportOptions;
  InspCat.Expanded := True;
  for IndexProp := low(C_JAVADOC_SUPPORT_PROPERTYS_DESCRIPTION)
    to high(C_JAVADOC_SUPPORT_PROPERTYS_DESCRIPTION) do
  begin
    AddProperty(InspCat, C_JAVADOC_SUPPORT_PROPERTYS_DESCRIPTION[IndexProp])
  end;
  // End of build
  JvInspector1.EndUpdate;
  //ReTranslateComponent(JvInspector1);
end;

procedure TMainForm.iieBoolsAsChecks(Sender: TObject);
begin
  JvInspector1.BeginUpdate;
  try
    ChangeChkState(JvInspector1.Root);
  finally
    JvInspector1.EndUpdate;
  end;
end;

procedure TMainForm.ActionFullWizardProjectExecute(Sender: TObject);
begin
  NiceWizardForm := TNiceWizardForm.Create(self);
  if not assigned(DocProject) then
  begin
    DocProject := TDOCProject.Create;
    DocProject.DocOptions.SetDefaultValue;
    DocProject.SetDestinationMessages(mUser.Lines, mDebug.Lines);
    DocProject.State := psNew;
    DocProject.FileName := 'untitled.xml';
  end;
  NiceWizardForm.DocOptionsToWizard(Docproject.DocOptions);
  if NiceWizardForm.ShowModal = mrOk then
  begin
    NiceWizardForm.WizardToDocOption(Docproject.DocOptions);
    AddConfigurationPropertys;
    ActionConfigurationExecute(self);
    DocProject.State := psNew;
    SetTitle;
  end
  else
  begin
    // Cancel the project
    FreeAndNil(DocProject);
    AddDebugMessage(L_WizardCanceled);
  end;
  NiceWizardForm.Release;
end;

procedure TMainForm.ActionCheckExecute(Sender: TObject);
begin
  EnableActions:=FALSE;
  // Go to the Messages panel
  ActionMessages.Execute;
  // Check if Project can be built
  if DocProject.Check then
  begin
    LabelMustCheckBefore.Visible := False;
    // UpdateReference
    UpdateReferences;
    UpdateQuality;
    tvReference.Visible := True;
    //ActionBuild.Enabled := True;
    AddUserMessage(L_CheckedSuccess);
  end
  else  begin
    LabelMustCheckBefore.Visible := True;
    // UpdateReference
    UpdateReferences;
    tvReference.Visible := False;
    AddUserMessage(L_CheckingAborted);
    // Go to the Messages panel
    ActionMessages.Execute;
    // Show Error Panel
    MessageDlg(MSG_ASSERTION_ERROR, mtError, [mbOK], 0);
  end;
  EnableActions:=TRUE;
end;

procedure TMainForm.ActionBuildExecute(Sender: TObject);
begin
  EnableActions:=FALSE;
  // Build Project documentation
  Assert(DocProject.isChecked);
  // Go to the Messages panel
  ActionMessagesExecute(self);
  // Verify if all files are built !
  if DocProject.Build then
  begin
    AdduserMessage(L_BuildSuccess);
    AddDebugMessage(L_BuildDone);
    // Go to the Quality panel
    ActionQuality.Execute;
    // Launch the browser ?
    if DocProject.DocOptions.LaunchBrowser then
     ActionViewOutputExecute(Sender);
  end
  else  begin
    AdduserMessage(L_BuildError);
    // Show Error panel
    MessageDlg(MSG_ASSERTION_ERROR, mtError, [mbOK], 0);
  end;
  EnableActions:=TRUE;
end;

procedure TMainForm.AddDebugMessage(const st: string);
begin
  mDebug.Lines.Add(st);
end;

{*------------------------------------------------------------------------------
                                                                                
  
  @param st ParameterDescription
  @return None      
------------------------------------------------------------------------------*}
procedure TMainForm.AddUserMessage(const st: string);
begin
  mUser.Lines.Add(st);
  StatusBar1.SimpleText := st;
end;

procedure RecurseSetCheck(const tn: TTreeNode; const Value: boolean);
var
  Index: integer;
  jvtn:  TJvTreeNode;
begin
  assert(tn is TJvTreeNode);
  jvtn := tn as TJvTreeNode;
  jvtn.Checked := Value;
  // Issue : Checkmarks doesn't work !!!
  //jvtn.Bold:=Value;
  for Index := 0 to jvtn.Count - 1 do
  begin
    RecurseSetCheck(jvtn.Item[Index], Value)
  end;
end;

// List project's units and classes in a TreeView
procedure TMainForm.UpdateQuality;
begin
  tvQuality.Items.BeginUpdate;
  DocProject.GetStructure.ConvertAllToTreeNode(tvQuality.Items);
  tvQuality.ItemIndex := 0;
  tvQuality.SelectItem(tvQuality.TopItem);
  tvQuality.TopItem.Expand(False);
  tvQuality.Items.EndUpdate;
end;

procedure TMainForm.UpdateReferences;
begin
  // TODO: save reference informations if exists
  // Clear top Reference if exist  (inside convert function)
  //if tvReference.TopItem <> nil then tvReference.TopItem.Delete;
  //DocProject.GetStructure.ConvertToTreeNode(tvReference.Items);
  DocProject.GetStructure.ClassTree.ConvertToTreeNodes(tvReference.Items);
  tvReference.FullExpand;
  // Add checkmark to all Nodes
  RecurseSetCheck(tvReference.Items.GetFirstNode, True);
  // TODO : retrieve reference information if exist
end;

procedure TMainForm.ActionCloseProjectExecute(Sender: TObject);
var
  CanClose : Boolean;
begin
  CanClose := True;
  if assigned(DocProject) then
  begin
    if DocProject.State <> psSaved then
     case MessageDlg(Format(RS_PROJECT_CHANGES_CONFIRM,[DocProject.DocOptions.Name]), mtWarning, [mbYes, mbNo, mbCancel], 0) of
       idYes:
       begin
        ActionSaveProjectExecute(self);
        CanClose := (DocProject.State = psSaved);
       end;
       idNo: CanClose := True; // Modifications will be lost
       idCancel: CanClose := False;
     end;
  end;

  if CanClose then
  begin
    // Free Configuration list
    JvInspector1.Root.Clear;
    // Close project
    if Assigned(DocProject) then
    begin
      FreeAndNil(DocProject)
    end;
    // Clear reference list
    tvReference.Items.Clear;
    // Clear TAG coverage list
    tvQuality.Items.Clear;
    JvRichEditTagDetails.Clear;
    AddUserMessage(L_ProjectClosed);
    Self.Caption := Application.Title;
  end;
end;

procedure TMainForm.ActionManager1Update(Action: TBasicAction; var Handled: boolean);
begin
  if EnableActions then
  begin
    ActionMainMenuBar1.Enabled:=True;
    ActionToolBar1.Enabled:=True;
  end
  else
  begin
    ActionMainMenuBar1.Enabled:=False;
    ActionToolBar1.Enabled:=False;
  end;

   if assigned(DocProject) then
   begin
    case DocProject.State of
      psNew:
      begin
        ActionQuickWizardProject.Enabled := False;
        ActionFullWizardProject.Enabled := False;
        ActionCloseProject.Enabled := True;
        ActionCheck.Enabled := False;
        ActionBuild.Enabled := False;
        ActionCheckAndBuild.Enabled := True;
        ActionOpenProject.Enabled := True;
        ActionImportOldProject.Enabled := True;
        ActionSaveProject.Enabled := True;
        ActionSaveAsProject.Enabled := True;
        ActionViewOutput.Enabled := True;
        ActionPurgeOutputFolder.Enabled := True;
      end;
      psSaved:
      begin
        ActionQuickWizardProject.Enabled := False;
        ActionFullWizardProject.Enabled := False;
        ActionCloseProject.Enabled := True;
        ActionCheck.Enabled := False;
        ActionBuild.Enabled := False;
        ActionCheckAndBuild.Enabled := True;
        ActionOpenProject.Enabled := True;
        ActionImportOldProject.Enabled := True;
        ActionSaveProject.Enabled := True;
        ActionSaveAsProject.Enabled := True;
        ActionViewOutput.Enabled := True;
        ActionPurgeOutputFolder.Enabled := True;
      end;
      psModified:
      begin
        ActionQuickWizardProject.Enabled := False;
        ActionFullWizardProject.Enabled := False;
        ActionCloseProject.Enabled := True;
        ActionCheck.Enabled := False;
        ActionBuild.Enabled := False;
        ActionCheckAndBuild.Enabled := True;
        ActionOpenProject.Enabled := True;
        ActionImportOldProject.Enabled := True;
        ActionSaveProject.Enabled := True;
        ActionSaveAsProject.Enabled := True;
        ActionViewOutput.Enabled := True;
        ActionPurgeOutputFolder.Enabled := True;
      end;
      else // Unknown state !
      begin
        ActionQuickWizardProject.Enabled := False;
        ActionFullWizardProject.Enabled := False;
        ActionCloseProject.Enabled := False;
        ActionCheck.Enabled := False;
        ActionBuild.Enabled := False;
        ActionCheckAndBuild.Enabled := False;
        ActionOpenProject.Enabled := False;
        ActionImportOldProject.Enabled := False;
        ActionSaveProject.Enabled := False;
        ActionSaveAsProject.Enabled := False;
        ActionViewOutput.Enabled := False;
        ActionPurgeOutputFolder.Enabled := False;
      end;
    end
   end
   else // Project doesn't exist or Actions disables
   begin
    ActionQuickWizardProject.Enabled := True;
    ActionFullWizardProject.Enabled := True;
    ActionCloseProject.Enabled := False;
    ActionCheck.Enabled := False;
    ActionBuild.Enabled := False;
    ActionCheckAndBuild.Enabled := False;
    ActionOpenProject.Enabled := True;
    ActionImportOldProject.Enabled := True;
    ActionSaveProject.Enabled := False;
    ActionSaveAsProject.Enabled := False;
    ActionViewOutput.Enabled := False;
    ActionPurgeOutputFolder.Enabled := False;
   end;
  handled := True;
end;

// TODO - Extract SaveToStream option !
procedure TMainForm.ActionSaveAsProjectAccept(Sender: TObject);
var
  Res: TRWOptionsError;
begin
  Assert(assigned(DocProject));
  Res:=DocProject.DocOptions.SaveToFile(ActionSaveAsProject.Dialog.FileName);
  if Res = oeNoError then
  begin
    DocProject.FileName:=ActionSaveAsProject.Dialog.FileName;
    DocProject.State:=psSaved;
    SetTitle;
  end
  else
  begin
    AddUserMessage(L_ProjectSavingError);
    AddDebugMessage(L_ProjectSavingError + ':' + RWOptionsErrorStrings[Res]);
    MessageDlg(L_ProjectSavingError, mtError, [mbOK], 0);
  end;
end;

// TODO - Extract LoadToStream option !
procedure TMainForm.ActionImportOldProjectAccept(Sender: TObject);
var
  FS:  TFileStream;
  Res: TRWOptionsError;
  DocOptions_TL03 : TDOCOptions_TL03;
begin
  if assigned(DocProject) then
  begin
    ActionCloseProjectExecute(Sender)
  end;
  // Create New Project
  DocProject := TDOCProject.Create;
  DocProject.DocOptions.SetDefaultValue;
  DocOptions_TL03 := TDOCOptions_TL03.Create(nil);
  FS := TFileStream.Create(ActionImportOldProject.Dialog.FileName, fmOpenRead);
  try
    Res := DocOptions_TL03.LoadFromStream(FS);
  finally
    FS.Free;
  end;
  DocOptions_TL03.CopyToTL04(DocProject.DocOptions);
  FreeAndNil(DocOptions_TL03);
  // Ask for a redraw of Configuration Tree
  iieBoolsAsChecks(self);
  JvInspector1.Invalidate;
  if Res = oeNoError then
  begin
    AddConfigurationPropertys;
    DocProject.SetDestinationMessages(mUser.Lines, mDebug.Lines);
    DocProject.FileName:=ChangeFileExt(ActionImportOldProject.Dialog.FileName,'.xml');
    // imported project need to be saved in new format
    DocProject.State:=psModified;
    SetTitle;
    // Go to the Messages panel
    ActionConfigurationExecute(self);
  end
  else
  begin
    // Create new project aborted
    AddUserMessage(L_ProjectLoadingError);
    AddDebugMessage(L_ProjectLoadingError + ': ' + RWOptionsErrorStrings[Res]);
    MessageDlg(L_ProjectLoadingError + ': ' + RWOptionsErrorStrings[Res]
     , mtError, [mbOK], 0);
    FreeAndNil(DocProject);
  end;
end;

// TODO - Extract LoadToStream option !
procedure TMainForm.ActionLoadProjectAccept(Sender: TObject);
var
  Res: TRWOptionsError;
begin
  if assigned(DocProject) then
  begin
    ActionCloseProjectExecute(Sender)
  end;
  // Create New Project
  DocProject := TDOCProject.Create;
  DocProject.DocOptions.SetDefaultValue;

  Res:=DocProject.DocOptions.LoadFromFile(ActionOpenProject.Dialog.FileName);

  // Ask for a redraw of Configuration Tree
  iieBoolsAsChecks(self);
  JvInspector1.Invalidate;
  if((Res = oeNoError) or (Res = oeNoErrorButUpgraded)) then
  begin
    AddConfigurationPropertys;
    DocProject.SetDestinationMessages(mUser.Lines, mDebug.Lines);
    DocProject.FileName:=ActionOpenProject.Dialog.FileName;
    // Upgraded project must be saved !
    if(Res = oeNoErrorButUpgraded) then
    begin
      DocProject.State:=psModified;
      AddUserMessage(rsProjectWasUpgraded);
    end
    else DocProject.State:=psSaved;
    SetTitle;
    // Go to the Messages panel
    ActionConfigurationExecute(self);
  end
  else
  begin
    // Create new project aborted
    AddUserMessage(L_ProjectLoadingError);
    AddDebugMessage(L_ProjectLoadingError + ': ' + RWOptionsErrorStrings[Res]);
    MessageDlg(L_ProjectLoadingError + ': ' + RWOptionsErrorStrings[Res]
     , mtError, [mbOK], 0);
    FreeAndNil(DocProject);
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ActionCloseProjectExecute(Sender);
end;

procedure TMainForm.AskChangeLanguage(Sender: TObject);
const
  ActionCodeForEnglish = 999;
var
  LCode: string;
begin
  if (Sender is TAction) then
  begin
    if (Sender as TAction).Tag = ActionCodeForEnglish then
    begin
      LCode := 'en'
    end
    else begin
      LCode := AvailableLanguagesCode.Strings[(Sender as TAction).Tag]
    end;
    AppSettings.ApplicationLanguage := LCode;
    UseLanguage(LCode);
    ReTranslateComponent(self);
    Self.Caption := Application.Title;
    //ReTranslateComponent(JvInspector1);
  end;
end;

procedure TMainForm.ActionCheckAndBuildExecute(Sender: TObject);
const
  DebugStringSeparator = 160;
begin
  // Add delimiter for this action
  AddDebugMessage(StringOfChar('-',DebugStringSeparator));
  // Check the project
  ActionCheckExecute(Sender);
  // and build if checked ok
  if DocProject.isChecked then
  begin
   ActionBuildExecute(Sender);
  end;
end;

procedure TMainForm.ActionViewOutputExecute(Sender: TObject);
begin
  if(DocProject.OutputMainFileName <> '') then
  begin
    AddUserMessage(L_LaunchBrowser);
    ShellExecEx(DocProject.OutputMainFileName);
  end;
end;

procedure TMainForm.ActionPurgeOutputFolderExecute(Sender: TObject);
begin
  assert(assigned(DocProject));
  if MessageBox(0, PWideChar(Format(L_COnfirmDeleteHTMfiles,[Docproject.DocOptions.OutputFolder]))
   ,'DelphiCodeToDoc', MB_ICONWARNING or MB_OKCANCEL)=idOK then
    if DocProject.PurgeOutputFolder then Sysutils.Beep;
  ActionMessagesExecute(Sender);
end;


procedure TMainForm.ActionSaveProjectExecute(Sender: TObject);
begin
  // Verify if project has already been saved (have a defined name)
  case DocProject.State of
   psNew:
   begin
    // Call SaveAs Action
    ActionSaveAsProject.Dialog.FileName:=DocProject.DocOptions.Name;
    ActionSaveAsProject.Execute;
   end;
   psSaved:
   begin
    // Nothing to do, project always saved !
    ActionSaveAsProject.Dialog.FileName:=DocProject.FileName;
    ActionSaveAsProjectAccept(self);    
   end;
   psModified:
   begin
    ActionSaveAsProject.Dialog.FileName:=DocProject.FileName;
    ActionSaveAsProjectAccept(self);
   end;
   else
    raise Exception.Create('Unknown project state !')
  end;
end;

procedure TMainForm.ActionSaveAsProjectJvSaveDialogShow(Sender: TObject);
begin
  // Set project's Name before showing Dialog in Project is new !
  // THIS DON'T WORK !!!
  if (DocProject.State=psNew) and (DocProject.Filename='') then
   ActionSaveAsProject.Dialog.FileName:=Docproject.DocOptions.Name+'.xml';
end;

/// Clear Output messages (Debug and user)
procedure TMainForm.ActionClearMessagesExecute(Sender: TObject);
begin
  mDebug.Clear;
  mUser.Clear;
end;

procedure TMainForm.ActionQuickWizardProjectExecute(Sender: TObject);
begin
  QuickWizardForm := TQuickWizardForm.Create(self);
  if QuickWizardForm.ShowModal = mrOk then
  begin
    DocProject := TDOCProject.Create;
    DocProject.DocOptions.SetDefaultValue;
    // get informations from wizard
    if QuickWizardForm.IsProjectSelected then
      Docproject.DocOptions.FilesIncludeList.Add(QuickWizardForm.GetProjectFile)
    else
      Docproject.DocOptions.FilesIncludeList.Add(QuickWizardForm.GetRootDirectory);
    DocProject.DocOptions.OutputFolder := QuickWizardForm.GetOutputDirectory;
    DocProject.DocOptions.Name := QuickWizardForm.GetProjectName;
    AddConfigurationPropertys;
    DocProject.SetDestinationMessages(mUser.Lines, mDebug.Lines);
    AddUserMessage(L_WizardSuccess);
    DocProject.State := psNew;
    SetTitle;
    // Go to the Messages panel
    ActionConfigurationExecute(self);
  end
  else
  begin
    AddDebugMessage(L_WizardCanceled)
  end;
  QuickWizardForm.Release;
end;

procedure TMainForm.SetTitle;
begin
  if assigned(DocProject) then
  begin
   case DocProject.State of
   psNew: Caption := Application.Title + ' - ' + 'untitled.xml *';
   psSaved: Caption := Application.Title + ' - ' + Docproject.FileName;
   psModified: Caption := Application.Title + ' - ' + Docproject.FileName + ' *';
   end
  end
  else Caption := Application.Title;
end;

// When changing selection, write a report for the selected node
procedure TMainForm.tvQualityCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  NewColor : TColor;
  NodeValue : Double;
begin
  NodeValue := TDOCTemplate(Node.Data).TagCoverageHolder.TotalStats.GetDocumentedTagRatio;
  if(NodeValue >= 100.0) then NewColor := clBlue
   else if(NodeValue >= 50.0) then NewColor := clWebOrangeRed
       else NewColor := clRed;
  (Sender as TJvTreeView).Canvas.Font.Color := NewColor;
  DefaultDraw := True;
end;

procedure TMainForm.tvQualitySelectionChange(Sender: TObject);
begin
  // Write report to Edit box
  if(TObject(tvQuality.Selected.Data) is TDOCTemplate) then
   DocProject.GetStructure.FillTagDetail(TDOCTemplate(tvQuality.Selected.Data), JvRichEditTagDetails);
end;

procedure TMainForm.JvInspector1DataValueChanged(Sender: TObject;
  Data: TJvCustomInspectorData);
begin
  if assigned(DocProject) then
   if DocProject.State = psSaved then
   begin
    DocProject.State := psModified;
    SetTitle;
   end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if assigned(Docproject) then ActionCloseProjectExecute(self);
  CanClose := not assigned(DocProject);
end;

initialization
  TJvInspectorColorItem.RegisterAsDefaultItem;
  TJvInspectorTImageIndexItem.RegisterAsDefaultItem;
end.
