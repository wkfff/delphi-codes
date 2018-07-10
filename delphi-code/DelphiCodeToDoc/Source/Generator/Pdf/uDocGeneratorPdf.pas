{*------------------------------------------------------------------------------
  PDF Generator
  It provides all classes and functions to build PDF files from the structure
   builder.
  This generator is based on uDocGeneratorHtml unit.

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2009 - Under GNU GPL licence

  @Author    TridenT
-------------------------------------------------------------------------------}
unit uDocGeneratorPdf;

interface
uses
  SysUtils, Classes,
  uDocGeneratorVisitor, uDocGeneratorHtml, uDocStructure;

type
  /// Pdf generator class derived from TDocGeneratorHtml
  TDocGeneratorPdf = class(TDocGeneratorHtml)
  private
    bERR003, bERR014 : Boolean;
    FBOOKProjectLines : TStrings;  /// PDF Project strings
    function GetPdfBaseConfigFileName: string;
   protected
    procedure NotifyHtmlFileCreated(const HtmlFileName : string); override;
   public
    function GetOutputFile : TFileName; override;
    constructor Create(const DocStructure : TDOCStructure); override;
    destructor Destroy; override;
    procedure Execute; override;
    procedure OnConStdOut(Sender: TObject; s: String);
    procedure OnConStdErr(Sender: TObject; s: String);
    procedure OnConRun(Sender: TOBject);
    procedure OnConEnd(Sender: TOBject);
  end;

implementation

uses
  JclFileUtils, JclStrings, JvGnuGettext, JclShell, StrUtils,
  uOptions, RedCon, Dialogs, Forms,
  uDocGenPDF_Tools, uDocParameter,
  uDocGenHtmlVisitor, uHtmlDocRegistry;

resourcestring
  rsBuildingPDFProjectFiles='Building PDF project files';
  rsWaitWhileBuildingPDF = 'Please, wait while building the PDF file';

var
  /// Redirected console object
  fCon : TRedirectedConsole;

/// Execute the document generator process
procedure TDocGeneratorPdf.Execute;
const
  PDFBuildCmdCall = 'cmd';
  PDFBuildCmdParameters = '/c ';
  PDFBuildCmdFileName = 'HTMLDoc\htmldoc.exe';
  PDFBuildCmdPath = 'HTMLDoc';
  PDFBuildCmdParameter = ' --batch %s.book';
var
  CmdLine : string;
  Parameters: string;
{$IFNDEF DCTD_CONSOLE}
  formWaitingMsg : TForm;
{$ENDIF}
  OutputPath : string;
  HtmlDocReg : THtmlDocRegistry;
begin
  OutputPath := ExtractFilePath(GetOutputFile);
  // Build 'PDF' output directory if not exists
  if not DirectoryExists(OutputPath) then
   ForceDirectories(OutputPath);

  // Create Strings
  FBOOKProjectLines := TStringList.Create;
  FBOOKProjectLines.Add(PDFGenHeader(DocOptions.Name));
  //
  CmdLine := ExtractFilePath(Application.ExeName)+PDFBuildCmdFileName;
  Parameters := Format(PDFBuildCmdParameter,[DocOptions.Name]);
  fCon := TRedirectedConsole.Create(CmdLine, Parameters);
  fCon.OnStdOut := OnConStdOut;
  fCon.OnStdErr := OnConStdErr;
  fCon.OnRun := OnConRun;
  fCon.OnEnd := OnConEnd;

  // Process HTML files creation
  inherited Execute();

  // This will create html file and execute the callback NotifyHtmlFileCreated()
  //  for each HTML file created

  // Save .BOOK config Files
  FBOOKProjectLines.SaveToFile(GetPdfBaseConfigFileName+BOOK_FILE_EXT);
  FreeAndNil(FBOOKProjectLines);
  // Launch PDF creation
  SendStatusMessage(rsBuildingPDFProjectFiles);
  chdir(DocOptions.EffectiveOutputFolder);
  // Register HTMLDoc
  HtmlDocReg := THtmlDocRegistry.Create;
  HtmlDocReg.RegisterHtmlDocPath(ExtractFilePath(Application.ExeName) + PDFBuildCmdPath);
  // Launch HTMLDoc.EXE
{$IFNDEF DCTD_CONSOLE}
  formWaitingMsg := CreateMessageDialog(rsWaitWhileBuildingPDF, mtInformation, []);
  formWaitingMsg.BorderStyle := bsDialog;
  formWaitingMsg.FormStyle := fsStayOnTop;
  formWaitingMsg.BorderIcons:=[];
  formWaitingMsg.Show;
{$ENDIF}
  fCon.Run;
  FreeAndNil(fCon);
  // unregister
  HtmlDocReg.UnRegisterHtmlDocPath;
  FreeAndNil(HtmlDocReg);

  // Move generated files ?
  FileMove(GetPdfBaseConfigFileName + BOOK_FILE_EXT, OutputPath, True);
  FileMove(DocOptions.EffectiveOutputFolder + PathDelim + DocOptions.Name
   + PDF_FILE_EXT , OutputPath, True);
{$IFNDEF DCTD_CONSOLE}
  FreeAndNil(formWaitingMsg);
{$ENDIF}
  chdir(ExtractFilePath(Application.ExeName));
end;


{*------------------------------------------------------------------------------
  Create a TDocGeneratorChm instance by calling its inherited contructor
  @param  DocStructure Structure supporting this generator
-------------------------------------------------------------------------------}
constructor TDocGeneratorPdf.Create(const DocStructure: TDOCStructure);
begin
  inherited;
  bERR003 := False;
  bERR014 := False;
end;

/// Destroy a TDocGeneratorChm instance
destructor TDocGeneratorPdf.Destroy;
begin
  //
end;


{*------------------------------------------------------------------------------
  Return the name of the main generated file from Generator
  @return Created CHM filename
-------------------------------------------------------------------------------}
function TDocGeneratorPdf.GetOutputFile: TFileName;
begin
  result := DocOptions.EffectiveOutputFolder + PDF_OUTPUT_PATH + PathDelim +
   DocOptions.Name + PDF_FILE_EXT;
end;

{*------------------------------------------------------------------------------
  Return the name of the main generated file from Generator
  @return  Name based on folder and project's name
-------------------------------------------------------------------------------}
function TDocGeneratorPdf.GetPdfBaseConfigFileName: string;
begin
  Result := DocOptions.EffectiveOutputFolder + DocOptions.Name;
end;

procedure TDocGeneratorPdf.NotifyHtmlFileCreated(const HtmlFileName: string);
var
  LinuxFilename : string;
begin
  // inherited NOT used
  LinuxFilename := HtmlFileName;
  // Replace Windows file path separator '\' with web path separator '/'
  CharReplace(LinuxFilename,'\','/');
  // replace '\' by '/'
  // Add html filename with FULL path
  FBOOKProjectLines.Add(LinuxFilename);
end;

{*------------------------------------------------------------------------------
  Event executed at the end of the DOS capture
  @param Sender   Sender of the event
------------------------------------------------------------------------------*}
procedure TDocGeneratorPdf.OnConEnd(Sender: TOBject);
begin
  // nothing
end;

{*------------------------------------------------------------------------------
  Event executed during the DOS capture.
  It only process the application pending messages, in order to refresh or
   repaint current controls.
  @param Sender   Event sender
------------------------------------------------------------------------------*}
procedure TDocGeneratorPdf.OnConRun(Sender: TOBject);
begin
  Application.ProcessMessages;
end;

{*------------------------------------------------------------------------------
  Event executed during DOS capture errors.
  It relays the error messages to the OnConStdOut event
  @param Sender   Event sender
  @param s   Error text
  @return Event sender
------------------------------------------------------------------------------*}
procedure TDocGeneratorPdf.OnConStdErr(Sender: TObject; s: String);
begin
  OnConStdOut(Sender,s);
end;

{*------------------------------------------------------------------------------
  Event executed during the DOS capture to get the output.
  It copies it to the message status of the main application
  @param Sender   Sender of the event
  @param s   Text captured
------------------------------------------------------------------------------*}
procedure TDocGeneratorPdf.OnConStdOut(Sender: TObject; s: String);
var
  UpdatedStdOut : TStringList;
  IndexLine : integer;

  DisplayStatus : Boolean;
begin
  UpdatedStdOut := TStringList.Create;
  UpdatedStdOut.SetText(PWideChar(s));
  for IndexLine:=0 to UpdatedStdOut.Count-1 do
  begin
    DisplayStatus := True;
    if(length(UpdatedStdOut.Strings[IndexLine]) > 0) then
    begin
     // skip ERR003, ERR014 errors ???
     if LeftStr(UpdatedStdOut.Strings[IndexLine], 6) = 'ERR003' then
     begin
       if(bERR003 = False) then bERR003 := True
       else DisplayStatus := False;
     end;
      if LeftStr(UpdatedStdOut.Strings[IndexLine], 6) = 'ERR014' then
     begin
       if(bERR014 = False) then bERR014 := True
       else DisplayStatus := False;
     end;

     if(DisplayStatus = True) then
      SendStatusMessage('[HTMLDoc] ' + UpdatedStdOut.Strings[IndexLine]);
    end;
  end;
  FreeAndNil(UpdatedStdOut);
end;

end.
