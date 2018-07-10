{*------------------------------------------------------------------------------
  Resources for CHMGenerator
  All strings to be translate are localized here.
  Parts of CHM Canvas are also written here.

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   v0.0     Initial revision
-------------------------------------------------------------------------------}
unit uDocGenCHM_Tools;

interface

uses
  Classes;

function CHMGenProjectOptions(const ShortName: string): string;
function CHMGenProjectWindows(const ShortName: string): string;
function CHMGenProjectFilesStart: string;
function CHMGenProjectFilesFile(const TemplateName: string): string;
function CHMGenProjectInfoTypesStart: string;

function CHMGenTocLinkedHeading(const Name:string; const FileName:string;const isFolder:Boolean): string;
function CHMGenTocClosingFolder: string;
function CHMGenTocSimpleHeading(const Name:string;const isFolder:Boolean=true): string;
function CHMGenTocHead: string;
function CHMGenTocBodyStart: string;
function CHMGenTocBodyEnd: string;


{gnugettext: scan-all text-domain='DCTD_ignore' }

const
  HTML_INLUDE_PATH = 'html\'; /// HTML files path to retrieve
  HHP_FILE_EXT = '.hhp'; /// HHP file extention
  HHC_FILE_EXT = '.hhc'; /// HHC file extention
  HHK_FILE_EXT = '.hhk'; /// HHK file extention
  CHM_FILE_EXT = '.chm'; /// CHM file extention
  CHM_OUTPUT_PATH : string = 'chm'; /// base output file for CHM

{gnugettext: reset }

implementation

uses
  { delphi }
  SysUtils,
  JclStrings;

{gnugettext: scan-all text-domain='DCTD_ignore' }

resourcestring

// ------------------------- Project  (*.hhp) canevas   ------------------------


/// OPTIONS section : %CompiledFile, %ContentFile, %DefaultWindow, %DefaultTopic
///  , %IndexFile, %Title
CHM_COMMON_PROJECT_OPTIONS =
 '[OPTIONS]'+NativeLineBreak
//+'Binary TOC=Yes'+NativeLineBreak - gets some troubles with option !!!
+'Compatibility=1.1 or later'+NativeLineBreak
+'Compiled file=%s.chm'+NativeLineBreak
+'Contents file=%s.hhc'+NativeLineBreak
+'Default Window=%s'+NativeLineBreak
+'Default topic='+HTML_INLUDE_PATH+'%s.htm'+NativeLineBreak
+'Display compile progress=No'+NativeLineBreak
+'Full-text search=Yes'+NativeLineBreak
+'Index file=%s.hhk'+NativeLineBreak
+'Language=0x409 Anglais (États-Unis)'+NativeLineBreak
+'Title=%s'+NativeLineBreak;

/// WINDOWS section : %Name, %ContentFile, %IndexFile, %DefaultTopic, %DefaultTopic
CHM_COMMON_PROJECT_WINDOWS =
 '[WINDOWS]'+NativeLineBreak
+'%s=,"%s.hhc","%s.hhk","'+HTML_INLUDE_PATH+'%s.htm","'+HTML_INLUDE_PATH+'%s.htm",,,,,0x23520,,0x3026,[0,0,1024,768],0x1030000,,,,,,0'+NativeLineBreak;

/// FILES section
CHM_COMMON_PROJECT_FILES_START =
 '[FILES]'+NativeLineBreak;

/// each file of FILES section : %TemplateName
CHM_COMMON_PROJECT_FILES_FILE =
 HTML_INLUDE_PATH+'%s.htm';

/// INFOTYPES section
CHM_COMMON_PROJECT_INFOTYPES_START =
 '[INFOTYPES]'+NativeLineBreak;


// ------------------------- TOC      (*.hhc)  canevas  ------------------------

/// Simple HEADING section START : %HeadingName
CHM_COMMON_TOC_SIMPLE_HEADING=
 '<LI> <OBJECT type="text/sitemap">'+NativeLineBreak
+' <param name="Name" value="%s">'+NativeLineBreak
+'</OBJECT>'+NativeLineBreak;


/// Linked HEADING section START : %HeadingName, %HeadingLink
CHM_COMMON_TOC_LINKED_HEADING=
 '<LI> <OBJECT type="text/sitemap">'+NativeLineBreak
+' <param name="Name" value="%s">'+NativeLineBreak
+' <param name="Local" value="'+HTML_INLUDE_PATH+'%s.htm">'+NativeLineBreak
+'</OBJECT>'+NativeLineBreak;

/// Linked HEADING section START : %HeadingName, %HeadingLink
CHM_COMMON_TOC_LINKED_FOLDER=
 '<LI> <OBJECT type="text/sitemap">'+NativeLineBreak
+' <param name="Name" value="%s">'+NativeLineBreak
+' <param name="Local" value="'+HTML_INLUDE_PATH+'%s.htm">'+NativeLineBreak
+' <param name="ImageNumber" value="2">'+NativeLineBreak
+'</OBJECT>'+NativeLineBreak;

/// Folder type HEADING
CHM_COMMON_TOC_FOLDER= '<UL>'+NativeLineBreak;

/// HEADING section END :
CHM_COMMON_TOC_FOLDER_END= '</UL>'+NativeLineBreak;

/// HEAD section
CHM_COMMON_TOC_HEAD =
 '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">'+NativeLineBreak
+'<HTML>'+NativeLineBreak
+'<HEAD>'+NativeLineBreak
+'<meta name="GENERATOR" content="Microsoft&reg; HTML Help Workshop 4.1">'+NativeLineBreak
+'<!-- Sitemap 1.0 -->'+NativeLineBreak
+'</HEAD>'+NativeLineBreak;

/// BODY START section :
CHM_COMMON_TOC_BODY_START=
 '<BODY>'+NativeLineBreak
+'<OBJECT type="text/site properties">'+NativeLineBreak
+'	<param name="Window Styles" value="0x800227">'+NativeLineBreak
+'	<param name="ImageType" value="Folder">'+NativeLineBreak
+'</OBJECT>'+NativeLineBreak
+'<UL>'+NativeLineBreak;

/// BODY END section : 
CHM_COMMON_TOC_BODY_END=
 '</UL>'+NativeLineBreak
+'</BODY>'+NativeLineBreak
+'</HTML>'+NativeLineBreak;

// ------------------------- Index    (*.hhk)  canevas  ------------------------


{gnugettext: reset }

// ------------------------- Project  (*.hhp) functions ------------------------

{*------------------------------------------------------------------------------
  Return CHM project's option section
  @param ShortName Base file name
  @return string representing the section
------------------------------------------------------------------------------*}
function CHMGenProjectOptions(const ShortName: string): string;
begin
  result:=Format(CHM_COMMON_PROJECT_OPTIONS,[ShortName,ShortName,ShortName
   ,ShortName, ShortName, ShortName]);
end;

{*------------------------------------------------------------------------------
  Return CHM project's windows section
  @param ShortName   Base file name
  @return string representing the section
------------------------------------------------------------------------------*}
function CHMGenProjectWindows(const ShortName: string): string;
begin
  result:=Format(CHM_COMMON_PROJECT_WINDOWS,[ShortName,ShortName,ShortName,ShortName,ShortName]);
end;

{*------------------------------------------------------------------------------
  Return CHM project's file START section
  @return string representing the section
------------------------------------------------------------------------------*}
function CHMGenProjectFilesStart: string;
begin
  result:=CHM_COMMON_PROJECT_FILES_START;
end;

{*------------------------------------------------------------------------------
  Return CHM project's files (one) file section
  @param TemplateName   File to generate
  @return string representing the section
------------------------------------------------------------------------------*}
function CHMGenProjectFilesFile(const TemplateName: string): string;
begin
  result:=Format(CHM_COMMON_PROJECT_FILES_FILE,[TemplateName]);
end;

{*------------------------------------------------------------------------------
  Return CHM project's info types START section
  @return string representing the section
------------------------------------------------------------------------------*}
function CHMGenProjectInfoTypesStart: string;
begin
  result:=CHM_COMMON_PROJECT_INFOTYPES_START;
end;

// ------------------------- TOC      (*.hhc) functions ------------------------

{*------------------------------------------------------------------------------
  Return CHM TOC linked heading
  @param Name   Name of the heading
  @param FileName   File link
  @param isFolder   True if not a textual item but just a folder (container)
  @return string representing the section
------------------------------------------------------------------------------*}
function CHMGenTocLinkedHeading(const Name:string; const FileName:string
 ;const isFolder:Boolean): string;
begin
  if isFolder then
    result:=Format(CHM_COMMON_TOC_LINKED_FOLDER,[Name,FileName])+CHM_COMMON_TOC_FOLDER
  else
    result:=Format(CHM_COMMON_TOC_LINKED_HEADING,[Name,FileName]);
end;

{*------------------------------------------------------------------------------
  Return CHM TOC closing folder
  @return string representing the section
------------------------------------------------------------------------------*}
function CHMGenTocClosingFolder: string;
begin
  result:=CHM_COMMON_TOC_FOLDER_END;
end;

{*------------------------------------------------------------------------------
  Return CHM TOC simple heading
  @param Name   Heading's name
  @param isFolder   True if not a textual item but just a folder (container)
  @return string representing the section
------------------------------------------------------------------------------*}
function CHMGenTocSimpleHeading(const Name:string;const isFolder:Boolean=true): string;
begin
  result:=Format(CHM_COMMON_TOC_SIMPLE_HEADING,[Name]);
  if isFolder then result:=result+CHM_COMMON_TOC_FOLDER;
end;

{*------------------------------------------------------------------------------
  Return CHM TOC head section
  @return string representing the section
------------------------------------------------------------------------------*}
function CHMGenTocHead: string;
begin
  result:=CHM_COMMON_TOC_HEAD;
end;

{*------------------------------------------------------------------------------
  Return CHM TOC Body START section
  @return string representing the section
------------------------------------------------------------------------------*}
function CHMGenTocBodyStart: string;
begin
  result:=CHM_COMMON_TOC_BODY_START;
end;

{*------------------------------------------------------------------------------
  Return CHM TOC Body END section
  @return string representing the section  
------------------------------------------------------------------------------*}
function CHMGenTocBodyEnd: string;
begin
  result:=CHM_COMMON_TOC_BODY_END;
end;

// ------------------------- Index    (*.hhk) functions ------------------------


end.
