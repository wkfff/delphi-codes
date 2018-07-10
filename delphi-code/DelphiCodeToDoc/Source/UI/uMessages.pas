{*-------------------------------------------------------------------------------
  Shared user interface between Command line and Window
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   Initial revision
-------------------------------------------------------------------------------}
unit uMessages;

interface
uses
  SysUtils, Classes;

resourcestring
  // User Messages
  L_COnfirmDeleteHTMfiles='This will delete all generated files in the folder %s'+#13+#10
   +'Do you want to continue this action ?';
  L_WizardSuccess   = 'Wizard successfully create the project';
  L_WizardCanceled  = 'Wizard operation Canceled';
  L_CheckedSuccess  = 'Successfully Checked the project, BUILD function is now enable';
  L_CheckingAborted = 'Project checking aborted';
  L_BuildSuccess    = 'Successfully build the Project';
  L_BuildDone       = 'Build done';
  L_BuildError      = 'Error while building the Project';
  L_LaunchBrowser   = 'Launching browser to display result';
  L_ConfigurationChanged = 'Project configuration changed. You need to re-CHECK project';
  L_ProjectClosed   = 'Project closed. To start a new project, try the NEW WIZARD PROJECT';
  L_ProjectSavingError = 'Error while saving Project';
  L_ProjectLoadingError = 'Error while loading Project';
  MSG_ASSERTION_ERROR = 'Error while parsing a file.' + #13 + #10 +
    'Please, report the debug window and eventually the ' + #13 + #10 +
    'problematic file to the technical support.' + #13 + #10 +
    'See website for the details and email adress.' + #13 + #10 +
    'http://dephicodetodoc.sourceforge.net/' + #13 + #10 + 'Thanks for the report.';
  rsIllegalCall = 'Illegal call!';
  rsUsingConfigFile = 'Using config file : %s';
  rsApplicationUsage = 'Usage : DCTD_cmd.exe ConfigFile.xml';
  rsProjectWasUpgraded = 'Project file was upgraded from a previous version';

// Shared with MMI
procedure SearchTranslations;
procedure IgnoreTranslations;

var
  /// List of available languages code
  AvailableLanguagesCode: TStrings;
  /// List of available languages in string format
  AvailableLanguages: TStrings;

implementation

uses JclFileUtils, uDocProject, uOptions
  , JvGnugettext, controls
  {$IFNDEF DCTD_CONSOLE}
  ,graphics,actnmenus,ActnCtrls,JvComCtrls
  {$ENDIF}
  ;

{*------------------------------------------------------------------------------
  This procedures send some ignore class to the gnuGetText library
 ------------------------------------------------------------------------------}
procedure IgnoreTranslations;
begin
  TP_GlobalIgnoreClassProperty(TControl, 'HelpKeyword');
  {$IFNDEF DCTD_CONSOLE}
  //TP_GlobalIgnoreClass(TFont);
  //TP_GlobalIgnoreClass(TActionMainMenuBar);
  //TP_GlobalIgnoreClass(TActionToolBar);
  //TP_GlobalIgnoreClass(TJvPageControl);
  {$ENDIF}
end;

{*------------------------------------------------------------------------------
  This procedures searches the directory structure and the embedded
  translations for any valid translation files for the specified domain.
   It uses the bindtextdomain() directory. The result is a list of language
  codes that it puts into the list parameter. It is then up to the programmer
  to convert these language codes into language names.
 ------------------------------------------------------------------------------}
procedure SearchTranslations;
begin
  //AvailableLanguages     := TStringList.Create;
  //AvailableLanguagesCode := TStringList.Create;
  // Put the language codes into a listbox
  DefaultInstance.GetListOfLanguages('default', AvailableLanguagesCode);
  AvailableLanguages.Assign(AvailableLanguagesCode);
  // Convert the language names to an English language name using isotolanguagenames.mo
  DefaultInstance.BindtextdomainToFile('languagecodes', extractfilepath(
    ParamStr(0)) + 'languagecodes.mo');
  DefaultInstance.TranslateProperties(AvailableLanguages, 'languagecodes');
  // Translate the English language name to a localized language name
  DefaultInstance.TranslateProperties(AvailableLanguages, 'languagenames');
  { End of translations searches }
  AvailableLanguages.Add('English');
  AvailableLanguagesCode.Add('en');
end;

initialization
  AvailableLanguages     := TStringList.Create;
  AvailableLanguagesCode := TStringList.Create;

finalization
  FreeAndNil(AvailableLanguages);
  FreeAndNil(AvailableLanguagesCode);

end.
 
