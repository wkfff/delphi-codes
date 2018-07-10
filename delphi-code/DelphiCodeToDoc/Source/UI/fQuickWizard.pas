{*------------------------------------------------------------------------------
  Minimal wizard to choose project file or folder with source

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   v0.0     Initial revision
  @Version   2004/30/08   Patrick   v0.1     Some UNC support and other stuff
-------------------------------------------------------------------------------}

unit fQuickWizard;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  Dialogs, JvBrowseFolder, StdCtrls, JvLabel, ExtCtrls, JvToolEdit
  , Mask, JvGnugettext, JvSelectDirectory, JvBaseDlg, Buttons,
  JvComponent, JvDialogs, JvExStdCtrls, JvRadioButton, JvExControls,
  JvStaticText, JvExExtCtrls, JvPanel, JvComponentBase;

type
  TQuickWizardForm = class(TForm)
    leProjectName: TLabeledEdit;
    btnOk: TButton;
    BrowseFolder: TJvBrowseForFolderDialog;
    btnCancel: TButton;
    btnRoot: TSpeedButton;
    btnOutput: TSpeedButton;
    ebRoot: TLabeledEdit;
    ebOutput: TLabeledEdit;
    EditProjectFile: TLabeledEdit;
    JvOpenDialog1: TJvOpenDialog;
    btnProjectFile: TSpeedButton;
    JvRadioButton1: TJvRadioButton;
    JvRadioButton2: TJvRadioButton;
    JvStaticText1: TJvStaticText;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ChooseProject(Sender: TObject);
    procedure ChooseSourcesFolder(Sender: TObject);
    procedure ChooseOutput(Sender: TObject);
    procedure AssertControls(Sender: TObject);
  private
    { Private declarations }
    
    FRoot, FProjectFile, FOutput : string;
    procedure SetDirEditText(const Edit : TCustomEdit; const Dir : string);
    procedure SetRootDirectory(const Value : TFilename);
    procedure SetOutputDirectory(const Value: TFilename);
    function DoBrowse(const Title : string ; const Dir : TFileName): boolean;
    procedure DefaultOutput;
    function FormValid: boolean;

  public
    { Public declarations }
    function GetRootDirectory: TFilename;
    function GetProjectFile: TFilename;
    function GetOutputDirectory: TFilename;
    function GetProjectName: string;
    function IsProjectSelected: boolean;
  end;

var
  QuickWizardForm: TQuickWizardForm;

implementation

uses
  { DONE -opatrick -cproposed changes :  added uses section }
  Graphics    { TCanvas }
  ,StrUtils;

{$R *.dfm}

resourcestring
  wpEmptyDirectory = 'Root directory and Output directory must be filled !';

function TQuickWizardForm.GetProjectName: string;
begin
  Result := leProjectName.Text;
end;

function TQuickWizardForm.GetOutputDirectory: TFilename;
begin
  { receiving code expects path delimiter }
  Result := FOutput;
  if AnsiRightStr(FOutput,1) <> PathDelim then
  FOutput := FOutput + PathDelim;
end;

procedure TQuickWizardForm.SetOutputDirectory(const Value: TFilename);
begin
  FOutput := Value;
  if AnsiRightStr(FOutput,1) <> PathDelim then
  FOutput := FOutput + PathDelim;
  SetDirEditText(ebOutput, FOutput);
end;

function TQuickWizardForm.GetRootDirectory: TFilename;
begin
  { receiving code expects path delimiter }
  Result := FRoot + PathDelim;
end;

procedure TQuickWizardForm.SetRootDirectory(const Value: TFilename);
begin
  FRoot := Value;
  SetDirEditText(ebRoot, Value);
  { make life a little easier }
  { suggestion : make the default directory suffix configurable? }
  if (FOutput = '') then
    DefaultOutput;
end;

procedure TQuickWizardForm.FormCreate(Sender: TObject);
begin
  TP_GlobalIgnoreClassProperty(TControl, 'HelpKeyword');
  TP_GlobalIgnoreClassProperty(TNotebook, 'Pages');
  TranslateComponent(self);

  { as we're using the JVCL, we can just load this bitmap at runtime }
  btnRoot.Glyph.LoadFromResourceName(Hinstance, 'JvDirectoryEditGLYPH'{'JV_FEDITBMP'});
  btnOutput.Glyph.Assign(btnRoot.Glyph);
  btnProjectFile.Glyph.Assign(btnRoot.Glyph);
  AssertControls(nil);
  DefaultOutput;
end;

{ replacement for the VCL MinimizeName function,
  handles UNC }
{ assumptions: legal Windows path\filenames -
  X:\path\path\path\file or
  \\host\path\path\path\file }  

function MinimizeName(const Filename: TFileName; Canvas: TCanvas;
  MaxLen: Integer): TFileName;
var
  SL : TStringList;
  Changed, IsUNC : boolean;
const
  MinLengths : array[boolean] of integer = (2, 4);  
begin
  Changed := false;
  SL := TStringList.Create;
  SL.Delimiter := PathDelim;
  { cleanse the pathname and avoid spaces confusing the TStringList }
  SL.DelimitedText := StringReplace(ExcludeTrailingPathDelimiter(FileName), ' ', '?', [rfReplaceAll]);
  IsUNC := SL[0] = '';

  try
    while
      { does not fit }
      ((not Changed and (Canvas.TextWidth(SL.DelimitedText) > MaxLen)) or
      { does not fit with removed segments and the ...}
      (Changed and (Canvas.TextWidth(SL.DelimitedText + '\...') > MaxLen))) and
      { we haven;t given up because there's no path left
        tip: make the edit bigger in this case }
      (SL.Count > MinLengths[IsUnc] ) do
    begin
      Changed := true;
      SL.Delete(SL.Count - 2)  // UNC: delete last but one path fragment past the host name
    end;

    if Changed then
      { indicate path was amended for display }
      SL.Insert(SL.Count - 1, '...');

    Result := StringReplace(SL.DelimitedText, '?', ' ', [rfReplaceAll]);
  finally
    SL.Free;
  end;

end;

function TQuickWizardForm.DoBrowse(const Title : string ; const Dir : TFileName) : boolean;
var
  InitialDir : string;
begin
  InitialDir := Dir;
  if (Dir <> '') then
  begin
    if not DirectoryExists(Dir) then
    { TODO -opatrick -cproposed changes : exception handling for this failing? }
    { create the directory upon browsing, as otherwise the component doesn't normally
      handle this well, and alternative approaches aren't as appealing }
      ForceDirectories(Dir);
  end
  else
    {todo -cproposed changes -opatrick: PMM addition to default the root}
    InitialDir := GetCurrentDir;

  BrowseFolder.Directory := InitialDir;
  BrowseFolder.Title := Title;
  Result := BrowseFolder.execute;
end;

function TQuickWizardForm.FormValid : boolean;
begin
  Result := ((JvRadioButton1.Checked and (FProjectFile <> ''))
         or (JvRadioButton2.Checked and (FRoot <> '')))
         and (FOutput <> '');
end;

procedure TQuickWizardForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  { perform validation at this event }
  if (ModalResult = mrOk) and not FormValid then
  begin
    CanClose := false;
    MessageDlg(wpEmptyDirectory, mtError, [mbOK], 0)
  end;
end;

procedure TQuickWizardForm.ChooseProject(Sender: TObject);
begin
  if JvOpenDialog1.Execute then
  begin
    FProjectFile:=JvOpenDialog1.FileName;
    SetDirEditText(EditProjectFile, FProjectFile);
  end;
end;

procedure TQuickWizardForm.ChooseSourcesFolder(Sender: TObject);
begin
  if DoBrowse(ebRoot.EditLabel.Caption, FRoot) then
    SetRootDirectory(BrowseFolder.Directory);
end;


procedure TQuickWizardForm.ChooseOutput(Sender: TObject);
begin
  if DoBrowse(ebOutput.EditLabel.Caption, FOutput) then
    SetOutputDirectory(BrowseFolder.Directory);
end;

{ helper wrapper to set the edit text }
procedure TQuickWizardForm.SetDirEditText(const Edit : TCustomEdit; const Dir: string);
begin
  Edit.Text := MinimizeName(Dir, Canvas, Edit.Width - 16);
end;

procedure TQuickWizardForm.DefaultOutput;
begin
  // OLD - SetOutputDirectory(FRoot + PathDelim + 'out');
  { Problem is default directory is automatically created, based on
    FRoot and maybe I don't want to create one! }
  SetOutputDirectory(ExtractFilePath(Application.ExeName) + 'out');
end;

procedure TQuickWizardForm.AssertControls(Sender: TObject);
begin
  btnOk.Enabled := FormValid;
end;

function TQuickWizardForm.IsProjectSelected: boolean;
begin
  result:=JvRadioButton1.Checked;
end;

function TQuickWizardForm.GetProjectFile: TFilename;
begin
  result:=FProjectFile;
end;

end.
