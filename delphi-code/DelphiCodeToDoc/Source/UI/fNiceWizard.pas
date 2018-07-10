unit fNiceWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvComponent, JvStaticText, StdCtrls, JvExStdCtrls,
  JvEdit, JvWizard, JvWizardRouteMapList, JvMemo, JvxCheckListBox, Grids,
  JvExGrids, JvGrids, ValEdit, JvListBox, Buttons, JvExButtons, JvBitBtn,
  Mask, JvExMask, JvToolEdit, JvBaseDlg, JvSelectDirectory, JvDialogs,
  ComCtrls, JvExComCtrls, JvComCtrls, JvCheckBox, JvCombobox, JvGroupBox,
  JvRadioButton,uOptions, JvLabel, ExtCtrls, JvExExtCtrls, JvRadioGroup,
  JvBrowseFolder, JvComponentBase, JvStatusBar;

type
  TNiceWizardForm = class(TForm)
    JvWizard1: TJvWizard;
    JvWizardWelcome: TJvWizardWelcomePage;
    JvWizardDescription: TJvWizardInteriorPage;
    JvWizardFiles: TJvWizardInteriorPage;
    JvWizardRouteMapList1: TJvWizardRouteMapList;
    JvWizardComments: TJvWizardInteriorPage;
    JvWizardJavaDoc: TJvWizardInteriorPage;
    JvWizardXMLDoc: TJvWizardInteriorPage;
    JvWizardOutputFormat: TJvWizardInteriorPage;
    JvWizardHTMLoutput: TJvWizardInteriorPage;
    JvWizardCHMoutput: TJvWizardInteriorPage;
    JvWizardTEXToutput: TJvWizardInteriorPage;
    JvWizardAdvanced: TJvWizardInteriorPage;
    Edit_ProjectName: TJvEdit;
    JvStaticText1: TJvStaticText;
    JvStaticText2: TJvStaticText;
    Edit_Authors: TJvEdit;
    JvStaticText3: TJvStaticText;
    JvWizardFinish: TJvWizardInteriorPage;
    Edit_ProjectSummary: TJvEdit;
    Memo_ProjectDescription: TJvMemo;
    JvStaticText4: TJvStaticText;
    ListBoxIncludePath: TJvListBox;
    JvStaticText5: TJvStaticText;
    btnDelete: TJvBitBtn;
    btnReplace: TJvBitBtn;
    btnSelectFile: TJvBitBtn;
    btnSelectFolder: TJvBitBtn;
    Edit_Path: TJvEdit;
    btnAdd: TJvBitBtn;
    DialogSelectFile: TJvOpenDialog;
    JvPageControl1: TJvPageControl;
    tsIncludeList: TTabSheet;
    tsExcludeList: TTabSheet;
    ListBoxExcludePath: TJvListBox;
    JvStaticText6: TJvStaticText;
    JvStaticText7: TJvStaticText;
    CheckBox_ParseImplementation: TJvCheckBox;
    CheckBox_RecurseDirectories: TJvCheckBox;
    CheckBox_AlphaSortMembers: TJvCheckBox;
    ComboBox_DocumentationLanguage: TJvComboBox;
    JvStaticText9: TJvStaticText;
    JvCheckBox_HideEmptyBlock: TJvCheckBox;
    JvCheckBox_HideEmptyTAGSection: TJvCheckBox;
    JvGroupBox_MemberVisibilityFilter: TJvGroupBox;
    JvCheckBox_Private: TJvCheckBox;
    JvCheckBox_Protected: TJvCheckBox;
    JvCheckBox_Public: TJvCheckBox;
    JvCheckBox_Published: TJvCheckBox;
    JvCheckBox_Automated: TJvCheckBox;
    JvGroupBox_OutputMemberFilter: TJvGroupBox;
    JvCheckBox_Constants: TJvCheckBox;
    JvCheckBox_Types: TJvCheckBox;
    JvCheckBox_Variables: TJvCheckBox;
    JvCheckBox_Functions: TJvCheckBox;
    JvCheckBox_Classes: TJvCheckBox;
    JvCheckBox_Fields: TJvCheckBox;
    JvCheckBox_Methods: TJvCheckBox;
    JvCheckBox_Properties: TJvCheckBox;
    JvCheckBox_Events: TJvCheckBox;
    CheckBox_ViewDocumentationAfterBuild: TJvCheckBox;
    JvGroupBox3: TJvGroupBox;
    JvStaticText10: TJvStaticText;
    JvStaticText11: TJvStaticText;
    JvStaticText12: TJvStaticText;
    Edit_BracketstarPrefix: TJvEdit;
    Edit_CurlyPrefix: TJvEdit;
    Edit_InlinePrefix: TJvEdit;
    CheckBox_SkipFirstLine: TJvCheckBox;
    CheckBox_SkipLastLine: TJvCheckBox;
    DirectoryEdit_OutputDirectory: TJvDirectoryEdit;
    JvStaticText13: TJvStaticText;
    JvWizardPDFOutput: TJvWizardInteriorPage;
    JvWizardHLPOutput: TJvWizardInteriorPage;
    rbCssInternal: TJvRadioButton;
    rbCssCustom: TJvRadioButton;
    JvGroupBox_CSSConfiguration: TJvGroupBox;
    JvMemo_ConditionalDefines: TJvMemo;
    JvLabel1: TJvLabel;
    JvRadioGroup_OutputFormat: TJvRadioGroup;
    JvGroupBox_CommentsSystem: TJvGroupBox;
    CheckBox_SupportJavaDoc: TJvCheckBox;
    CheckBox_SupportInline: TJvCheckBox;
    CheckBox_SupportXMLDoc: TJvCheckBox;
    CheckBox_WarnWhenEmptyTag: TJvCheckBox;
    CheckBox_SupportJEDI: TJvCheckBox;
    JvStaticText8: TJvStaticText;
    JvStaticText14: TJvStaticText;
    editCssCustomFilename: TJvFilenameEdit;
    CheckBox_AllowHtmlInDescription: TJvCheckBox;
    JvBrowseForFolderDialog: TJvBrowseForFolderDialog;
    CheckBox_DisplayHiddenItems: TJvCheckBox;
    JvStaticText15: TJvStaticText;
    JvCheckBox_Records: TJvCheckBox;
    JvStaticText16: TJvStaticText;
    JvEdit_Copyright: TJvEdit;
    JvGroupBox1: TJvGroupBox;
    CheckBox_PropertyCommentFromAssessors: TJvCheckBox;
    CheckBox_MethodCommentFromAncestor: TJvCheckBox;
    JvCheckBox_Units: TJvCheckBox;
    JvStaticText17: TJvStaticText;
    JvCheckBox_Resourcestring: TJvCheckBox;
    procedure btnSelectFileClick(Sender: TObject);
    procedure btnSelectFolderClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure JvPageControl1Change(Sender: TObject);
    procedure JvWizard1FinishButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JavaDocCharChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit_ProjectSummaryChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DocOptionsToWizard(const DocOptions: TDOCOptions);
    procedure WizardToDocOption(DocOptions: TDOCOptions);
  end;

var
  NiceWizardForm: TNiceWizardForm;

implementation

{$R *.dfm}

uses ShellAPI,JvGnugettext,StrUtils;

resourcestring
 L_CancelThisWizard = 'Are you sure you want to cancel this wizard ?';

var
  FilesActiveList: TJvListBox;

procedure TNiceWizardForm.btnSelectFileClick(Sender: TObject);
begin
  if DialogSelectFile.Execute then
  begin
    Edit_Path.Text:=DialogSelectFile.FileName;
    // Memorize Directory for Folder dialog
    JvBrowseForFolderDialog.Directory := ExtractFilePath(Edit_Path.Text);
    // Path is already memorized for file Dialog, thanks to NoChangeDir option
  end;
end;

procedure TNiceWizardForm.btnSelectFolderClick(Sender: TObject);
begin
  if JvBrowseForFolderDialog.Execute then
  begin
    Edit_Path.Text:=JvBrowseForFolderDialog.Directory+ PathDelim;
    // Memorize Directory for File dialog
    DialogSelectFile.InitialDir := JvBrowseForFolderDialog.Directory+ PathDelim;;
    // Must reset filename, otherwise InitialDir is not used !
    DialogSelectFile.FileName:='';
  end;
end;

procedure TNiceWizardForm.btnAddClick(Sender: TObject);
begin
  if Edit_Path.Text<>'' then
    FilesActiveList.ItemIndex:=FilesActiveList.Items.Add(Edit_Path.Text);
end;

procedure TNiceWizardForm.btnReplaceClick(Sender: TObject);
begin
  if FilesActiveList.ItemIndex<>-1 then
    if Edit_Path.Text<>'' then
      FilesActiveList.Items.Strings[FilesActiveList.ItemIndex]:=Edit_Path.Text;
end;

procedure TNiceWizardForm.btnDeleteClick(Sender: TObject);
begin
  if FilesActiveList.ItemIndex<>-1 then
    FilesActiveList.Items.Delete(FilesActiveList.ItemIndex);
end;

procedure TNiceWizardForm.JvPageControl1Change(Sender: TObject);
begin
  if JvPageControl1.ActivePage=tsIncludeList then FilesActiveList:=ListboxIncludePath
   else if JvPageControl1.ActivePage=tsExcludeList then FilesActiveList:=ListboxExcludePath
    else JvPageControl1.ActivePage:=nil;
end;


/// Fill wizards controls with DocOptions values
procedure TNiceWizardForm.DocOptionsToWizard(const DocOptions: TDOCOptions);
begin
  CheckBox_ViewDocumentationAfterBuild.Checked:=DocOptions.LaunchBrowser;
  Edit_ProjectName.Text:=DocOptions.Name;
  //DocOptions.Title
  Edit_ProjectSummary.Text:=DocOptions.Summary;
  Memo_ProjectDescription.Clear;
  Memo_ProjectDescription.Lines.Assign(DocOptions.Description);
  Edit_Authors.Text:=DocOptions.Author;
  //DocOptions.HTMLlink
  JvEdit_Copyright.Text := DocOptions.Copyright;
  CheckBox_RecurseDirectories.Checked:=DocOptions.RecurseDirectory;
  //DocOptions.ConditionalDefines => JvMemo_ConditionalDefines
  JvMemo_ConditionalDefines.Clear;
  JvMemo_ConditionalDefines.Lines.Assign(DocOptions.ConditionalDefines);
  CheckBox_ParseImplementation.Checked:=DocOptions.ParseImplementationSection;
  //DocOptions.CustomHeader
  //DocOptions.CustomFooter
  ComboBox_DocumentationLanguage.ItemIndex:=integer(DocOptions.Language);
  JvRadioGroup_OutputFormat.ItemIndex:=integer(DocOptions.OutputFormat);
  DirectoryEdit_OutputDirectory.Text:=DocOptions.OutputFolder;
  //(mvPrivate, mvProtected, mvPublic, mvPublished, mvAutomated);
  JvCheckBox_Private.Checked:=(mvPrivate in DocOptions.VisibilitySet);
  JvCheckBox_Protected.Checked:=(mvProtected in DocOptions.VisibilitySet);
  JvCheckBox_Public.Checked:=(mvPublic in DocOptions.VisibilitySet);
  JvCheckBox_Published.Checked:=(mvPublished in DocOptions.VisibilitySet);
  JvCheckBox_Automated.Checked:=(mvAutomated in DocOptions.VisibilitySet);
  //(tcINLINE, tcJAVADOC, tcJEDI, tcXMLDoc);
  CheckBox_SupportInline.Checked:=(tcINLINE in DocOptions.TagCommentSet);
  CheckBox_SupportJAVADOC.Checked:=(tcJAVADOC in DocOptions.TagCommentSet);
  CheckBox_SupportJEDI.Checked:=(tcJEDI in DocOptions.TagCommentSet);
  CheckBox_SupportXMLDoc.Checked:=(tcXMLDoc in DocOptions.TagCommentSet);

  CheckBox_AlphaSortMembers.Checked:=DocOptions.AlphaSort;
  CheckBox_WarnWhenEmptyTag.Checked:=DocOptions.WarnEmptyTAG;
  JvCheckBox_HideEmptyTAGSection.Checked:=DocOptions.HideEmptyTAGSection;
  JvCheckBox_HideEmptyBlock.Checked:=DocOptions.HideEmptyOutputBlock;
  // TOutputCategoryList
  JvCheckBox_Units.Checked:=(ocUnits in DocOptions.OutputFilteringCategory);
  JvCheckBox_Constants.Checked:=(ocConstants in DocOptions.OutputFilteringCategory);
  JvCheckBox_Types.Checked:=(ocTypes in DocOptions.OutputFilteringCategory);
  JvCheckBox_Variables.Checked:=(ocVariables in DocOptions.OutputFilteringCategory);
  JvCheckBox_Functions.Checked:=(ocFunctions in DocOptions.OutputFilteringCategory);
  JvCheckBox_Classes.Checked:=(ocClasses in DocOptions.OutputFilteringCategory);
  JvCheckBox_Records.Checked:=(ocRecords in DocOptions.OutputFilteringCategory);
  JvCheckBox_Fields.Checked:=(ocFields in DocOptions.OutputFilteringCategory);
  JvCheckBox_Methods.Checked:=(ocMethods in DocOptions.OutputFilteringCategory);
  JvCheckBox_Properties.Checked:=(ocProperties in DocOptions.OutputFilteringCategory);
  JvCheckBox_Events.Checked:=(ocEvents in DocOptions.OutputFilteringCategory);
  JvCheckBox_Resourcestring.Checked := (ocResourcestrings in DocOptions.OutputFilteringCategory);

  CheckBox_SkipFirstLine.Checked:=DocOptions.SkipFirstTAGLine;
  CheckBox_SkipLastLine.Checked:=DocOptions.SkipLastTAGLine;
  Edit_InlinePrefix.Text:=DocOptions.InLineJavaDocCharPrefix;
  Edit_BracketstarPrefix.Text:=DocOptions.BracketStarJavaDocCharPrefix;
  Edit_CurlyPrefix.Text:=DocOptions.CurlyJavaDocCharPrefix;
  ListBoxIncludePath.Clear;
  ListBoxIncludePath.Items.Assign(DocOptions.FilesIncludeList);
  ListBoxExcludePath.Clear;
  ListBoxExcludePath.Items.Assign(DocOptions.FilesExcludeList);
  CheckBox_AllowHtmlInDescription.Checked:=DocOptions.AllowHtmlInDescription;
  CheckBox_PropertyCommentFromAssessors.Checked:=DocOptions.PropertyCommentFromAssessors;
  CheckBox_DisplayHiddenItems.Checked := DocOptions.DisplayHiddenItems;
  CheckBox_MethodCommentFromAncestor.Checked := DocOptions.MethodCommentFromAncestor;
  rbCssInternal.Checked := (DocOptions.CssConfiguration = ccInternal);
  rbCssCustom.Checked := (DocOptions.CssConfiguration = ccCustom);
  editCssCustomFilename.Filename := DocOptions.CssCustomFile;
end;

procedure TNiceWizardForm.Edit_ProjectSummaryChange(Sender: TObject);
begin
end;

/// Fill DocOptions with wizards controls values
procedure TNiceWizardForm.WizardToDocOption(DocOptions: TDOCOptions);
begin
  DocOptions.LaunchBrowser:=CheckBox_ViewDocumentationAfterBuild.Checked;
  DocOptions.Name:=Edit_ProjectName.Text;
  //DocOptions.Title
  DocOptions.Summary:=Edit_ProjectSummary.Text;
  DocOptions.Description.Clear;
  DocOptions.Description.Assign(Memo_ProjectDescription.Lines);
  DocOptions.Author:=Edit_Authors.Text;
  //DocOptions.HTMLlink
  DocOptions.Copyright := JvEdit_Copyright.Text;
  DocOptions.RecurseDirectory:=CheckBox_RecurseDirectories.Checked;
  //DocOptions.ConditionalDefines => JvMemo_ConditionalDefines
  DocOptions.ConditionalDefines.Clear;
  DocOptions.ConditionalDefines.Assign(JvMemo_ConditionalDefines.Lines);

  DocOptions.ParseImplementationSection:=CheckBox_ParseImplementation.Checked;
  //DocOptions.CustomHeader
  //DocOptions.CustomFooter
  DocOptions.Language:=TLanguage(ComboBox_DocumentationLanguage.ItemIndex);
  DocOptions.OutputFormat:=TOutputFormat(JvRadioGroup_OutputFormat.ItemIndex);
  DocOptions.OutputFolder:=DirectoryEdit_OutputDirectory.Text;
  // Add Path delimiter if not at the end
  if AnsiRightStr(DirectoryEdit_OutputDirectory.Text,1) <> PathDelim then
  DocOptions.OutputFolder:=DocOptions.OutputFolder+PathDelim;
  //(mvPrivate, mvProtected, mvPublic, mvPublished, mvAutomated);
  DocOptions.VisibilitySet:=[];
  if JvCheckBox_Private.Checked then DocOptions.VisibilitySet:=DocOptions.VisibilitySet+[mvPrivate];
  if JvCheckBox_Protected.Checked then DocOptions.VisibilitySet:=DocOptions.VisibilitySet+[mvProtected];
  if JvCheckBox_Public.Checked then DocOptions.VisibilitySet:=DocOptions.VisibilitySet+[mvPublic];
  if JvCheckBox_Published.Checked then DocOptions.VisibilitySet:=DocOptions.VisibilitySet+[mvPublished];
  if JvCheckBox_Automated.Checked then DocOptions.VisibilitySet:=DocOptions.VisibilitySet+[mvAutomated];
  //(tcINLINE, tcJAVADOC, tcJEDI, tcXMLDoc);
  if CheckBox_SupportInline.Checked then DocOptions.TagCommentSet:=DocOptions.TagCommentSet+[tcINLINE];
  if CheckBox_SupportJAVADOC.Checked then DocOptions.TagCommentSet:=DocOptions.TagCommentSet+[tcJAVADOC];
  if CheckBox_SupportJEDI.Checked then DocOptions.TagCommentSet:=DocOptions.TagCommentSet+[tcJEDI];
  if CheckBox_SupportXMLDoc.Checked then DocOptions.TagCommentSet:=DocOptions.TagCommentSet+[tcXMLDoc];

  DocOptions.AlphaSort:=CheckBox_AlphaSortMembers.Checked;
  DocOptions.WarnEmptyTAG:=CheckBox_WarnWhenEmptyTag.Checked;
  DocOptions.HideEmptyTAGSection:=JvCheckBox_HideEmptyTAGSection.Checked;
  DocOptions.HideEmptyOutputBlock:=JvCheckBox_HideEmptyBlock.Checked;
  // TOutputCategoryList = (ocConstants, ocTypes, ocVariables, ocFunctions
  //  , ocClasses, ocFields, ocMethods, ocProperties, ocEvents, ocResourcestrings);
  DocOptions.OutputFilteringCategory := [];
  if JvCheckBox_Units.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocUnits];
  if JvCheckBox_Constants.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocConstants];
  if JvCheckBox_Types.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocTypes];
  if JvCheckBox_Variables.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocVariables];
  if JvCheckBox_Functions.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocFunctions];
  if JvCheckBox_Classes.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocClasses];
  if JvCheckBox_Records.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocRecords];
  if JvCheckBox_Fields.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocFields];
  if JvCheckBox_Methods.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocMethods];
  if JvCheckBox_Properties.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocProperties];
  if JvCheckBox_Events.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocEvents];
  if JvCheckBox_Resourcestring.Checked then DocOptions.OutputFilteringCategory:=DocOptions.OutputFilteringCategory+[ocResourcestrings];

  DocOptions.SkipFirstTAGLine:=CheckBox_SkipFirstLine.Checked;
  DocOptions.SkipLastTAGLine:=CheckBox_SkipLastLine.Checked;

  DocOptions.InLineJavaDocCharPrefix:=Edit_InlinePrefix.Text[1];
  DocOptions.BracketStarJavaDocCharPrefix:=Edit_BracketstarPrefix.Text[1];
  DocOptions.CurlyJavaDocCharPrefix:=Edit_CurlyPrefix.Text[1];

  DocOptions.FilesIncludeList.Clear;
  DocOptions.FilesIncludeList.Assign(ListBoxIncludePath.Items);
  DocOptions.FilesExcludeList.Clear;
  DocOptions.FilesExcludeList.Assign(ListBoxExcludePath.Items);

  DocOptions.AllowHtmlInDescription:=CheckBox_AllowHtmlInDescription.Checked;
  DocOptions.PropertyCommentFromAssessors:=CheckBox_PropertyCommentFromAssessors.Checked;
  DocOptions.DisplayHiddenItems := CheckBox_DisplayHiddenItems.Checked;
  DocOptions.MethodCommentFromAncestor := CheckBox_MethodCommentFromAncestor.Checked;

  if rbCssInternal.Checked then DocOptions.CssConfiguration := ccInternal
  else if rbCssCustom.Checked then DocOptions.CssConfiguration := ccCustom;
  DocOptions.CssCustomFile := editCssCustomFilename.Filename;

  // Fix options
  DocOptions.FixOptions;
end;

procedure TNiceWizardForm.JvWizard1FinishButtonClick(Sender: TObject);
begin
  // Test controls value
  // quit with ModalResult
  ModalResult:=mrOk;
end;

procedure TNiceWizardForm.FormCreate(Sender: TObject);
begin
  FilesActiveList:=ListboxIncludePath;
  TranslateComponent(self);
  // #Temporary workaround# - Force English in language output listbox
  ComboBox_DocumentationLanguage.AddItem('English',nil);
end;

procedure TNiceWizardForm.JavaDocCharChange(Sender: TObject);
var
  CharEdit: TJvEdit;
begin
  CharEdit:=(Sender as TJvEdit);
  if Length(CharEdit.Text)=0 then CharEdit.Text:='*'
  else if Length(CharEdit.Text)>1 then CharEdit.Text:=CharEdit.Text[1];
end;

procedure TNiceWizardForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult=mrOK then CanClose:=True
  else
   if (MessageDlg(L_CancelThisWizard,mtWarning, [mbOK, mbCancel], 0) =mrCancel) then
    CanClose:=false;
end;

end.
