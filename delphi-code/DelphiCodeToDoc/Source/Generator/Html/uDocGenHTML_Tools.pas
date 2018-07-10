{*------------------------------------------------------------------------------
  Resources for HTMLGenerator
  All strings to be translate are localized here.
  Parts of HTML Canvas are also written here.

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   v0.0     Initial revision
-------------------------------------------------------------------------------}


unit uDocGenHTML_Tools;

interface

uses Classes;

{gnugettext: scan-all text-domain='DCTD_ignore' }

const
  HTM_FILE_FILTER : string = '*.htm'; /// HTML file filter
  HTML_FILE_EXT: string = '.htm'; /// HTML file extention
  RESOURCES_FOLDER: string = '_Resources'; /// Base resources folder
  CSS_FOLDER : string = 'css'; /// CSS folder
  CSS_FILE_EXT: string  = '.css'; /// CSS file extention
  CSS_BASE_FILENAME :string = 'DelphiCodeToDoc'; /// CSS base filename (without extention)
  HTML_EOL : string ='<br />';  /// HTML sign for EndOfLine
  IMG_FOLDER : string = 'img'; /// Images (pictures) folder

{gnugettext: reset }

resourcestring
  // Word localization
  L_Project        = 'Project';
  L_Summary        = 'Summary';
  L_UnderConstruction = '#UnderConstruction#'; // TridenT comments2
  L_Description    = 'Description';
  L_Todo           = 'Todo';
  L_Author         = 'Author';
  L_Files          = 'Files';
  L_File           = 'File';
  L_Links          = 'Links';
  L_Unit           = 'Unit';
  L_Units          = 'Units';
  L_Version        = 'Version';
  L_Classes        = 'Classes';
  L_Class          = 'Class';
  L_Types          = 'Types';
  L_Type           = 'Type';
  L_Constants      = 'Constants';
  L_Constant       = 'Constant';
  L_Variables      = 'Variables';
  L_Variable       = 'Variable';
  L_Functions      = 'Functions';
  L_Function       = 'Function';
  L_ClassHierarchy = 'Class Hierarchy';
  L_ClassTree      = 'Class Tree';
  L_RelatedUnit    = 'Related Unit';
  L_Parent         = 'Parent';
  L_Members        = 'Members';
  L_Fields         = 'Fields';
  L_Field          = 'Field';
  L_Methods        = 'Methods';
  L_Method         = 'Method';
  L_Properties     = 'Properties';
  L_Property       = 'Property';
  L_Events         = 'Events';
  L_Event          = 'Event';
  L_Symbol         = 'Symbol';
  L_Legend         = 'Legend';
  L_Visibility     = 'Visibility';
  L_Private        = 'Private';
  L_Protected      = 'Protected';
  L_Public         = 'Public';
  L_Published      = 'Published';
  L_Automated      = 'Automated';
  L_Strict         = 'Strict';
  L_Member         = 'Member';
  L_RelatedClass   = 'Related Class';
  L_SourceCode     = 'Source code';
  L_Parameters     = 'Parameters';
  L_Parameter      = 'Parameter';
  L_Return         = 'Return';
  L_Content        = 'Content';
  L_Index          = 'Index';
  L_Previous       = 'Previous';
  L_Next           = 'Next';
  L_Exception      = 'Exception';
  L_AdditionalComment = 'Additionnal Comments';
  L_ReadAccess     = 'Read Access';
  L_WriteAccess    = 'Write Access';
  L_Exports        = 'Exports';
  L_Name           = 'Name';

function HTMLGenHead(const Name, Summary,CSSFilename: string): string;
function HTMLGenToolbar(const ProjectName, ContentName, IndexName ,PreviousItemName, NextItemName: string): string;
function HTMLGenSimpleSection(const SectionName, Item: string): string;
function HTMLGenSimpleColoredSection(const SectionName, Item: string): string;
function HTMLGenLinesSectionInit(const SectionName: string): string;
function HTMLGenLinesSectionColoredInit(const SectionName: string): string;
function HTMLGenLinesSectionLine(const Item: string): string;
function HTMLGenLinesSectionLineColored(const Item: string): string;
function HTMLGenLinesSectionEnd: string;
function HTMLGenTableSectionInit(const SectionName, IndexName1, IndexName2: string): string;
function HTMLGenTableSectionLine(const ItemName, ItemDescription: string): string;
function HTMLGenTableSectionEnd: string;
function HTMLGenFooter(const CopyrightString: string) : string;
function HTMLGenCSS: string;
function HTMLGenMultiSectionInit(const SectionName: string): string;
function HTMLGenMultiSectionEnd: string;
function HTMLBuildLink(const st : string; const Link : string) : string;
function StringsToHTMLStrings(const sl: TStringList; const EnableCharEncode:boolean) : string;


implementation

uses
  { delphi }
  SysUtils,
  JclStrings,
  JvStrToHtml;


{gnugettext: scan-all text-domain='DCTD_ignore' }

const

/// *HEAD SECTION %ProjectName, %Summary, %CSSFile, %ProjectName
HTML_COMMON_HEAD =
    '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'+NativeLineBreak
  + '<html xmlns="http://www.w3.org/1999/xhtml">'+NativeLineBreak
  + '<head>'+NativeLineBreak
  + '<title>%s - %s</title>'+NativeLineBreak
  + '<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'+NativeLineBreak
  + '<link rel="stylesheet" href="%s" type="text/css" />'+NativeLineBreak
  + '</head>' + NativeLineBreak
  + '<body>' + NativeLineBreak
  + '<div id="header">' + NativeLineBreak
  + '<h1>%s</h1>' + NativeLineBreak
  + '</div>' + NativeLineBreak
  + '<div id="content">' + NativeLineBreak
  + '<blockquote>' + NativeLineBreak
  + '<table cellpadding="0" border="0" cellspacing="1" width="100%%">' + NativeLineBreak
  + '<tr>' + NativeLineBreak 
  + '<!-- Generated style  by default for all text -->' + NativeLineBreak
  + '<td class="Generated">' + NativeLineBreak;
 
/// *TOOLBAR SECTION %ProjectName; %ContentName, %IndexName; %PreviousItemName, %NextItemName
HTML_COMMON_TOOLBAR =
 '<table class="toolbar">'+NativeLineBreak
+'  <tr>'+NativeLineBreak
+'    <td><b>%s</b></td>'+NativeLineBreak
+'    <td class="Normal">'+NativeLineBreak
+'      <div align="center">%s</div>'+NativeLineBreak
+'    </td>'+NativeLineBreak
+'    <td class="Normal">'+NativeLineBreak
+'      <div align="center">%s</div>'+NativeLineBreak
+'    </td>'+NativeLineBreak
+'    <td class="Normal">'+NativeLineBreak
+'      <div align="center">%s</div>'+NativeLineBreak
+'    </td>'+NativeLineBreak
+'    <td class="Normal">'+NativeLineBreak
+'      <div align="center">%s</div>'+NativeLineBreak
+'    </td>'+NativeLineBreak
+'  </tr>'+NativeLineBreak
+'</table><br />'+NativeLineBreak;

/// *SIMPLE-LINE SECTION %SectionName; %Item;
HTML_COMMON_SIMPLE_SECTION =
 '<span class="SectionName">%s</span><br />'+NativeLineBreak
+'<table class="simplesection">'+NativeLineBreak
+'  <tr>'+NativeLineBreak
+'    <td class="tabletab">&nbsp;</td>'+NativeLineBreak
+'    <td class="Generated">%s</td>'+NativeLineBreak
+'  </tr>'+NativeLineBreak
+'</table>'+NativeLineBreak
+'<br />'+NativeLineBreak;

/// * COMMON LINES SECTION INIT %SectionName
HTML_COMMON_LINES_SECTION_INIT =
 '<span class="SectionName">%s</span><br />'+NativeLineBreak
+'<table class="simplesection">'+NativeLineBreak;

/// * Unit description section %SectionName
HTML_COMMON_LINES_COLORED_SECTION_INIT =
 '<span class="SectionName">%s</span><br />'+NativeLineBreak
+'<table class="DescriptionSection">'+NativeLineBreak;


/// COMMON LINES SECTION LINE %Item
HTML_COMMON_LINES_SECTION_LINE =
 '  <tr> '+NativeLineBreak
+'    <td class="tabletab">&nbsp;</td>'+NativeLineBreak
+'    <td class="Generated"> '+NativeLineBreak
+'      <p>%s</p>'+NativeLineBreak
+'    </td>'+NativeLineBreak
+'  </tr>'+NativeLineBreak;

/// * COMMON LINES SECTION COLORED LINE %Item
HTML_COMMON_LINES_SECTION_LINE_COLORED =
 '  <tr> '+NativeLineBreak
+'    <td class="tabletab">&nbsp;</td>'+NativeLineBreak
+'    <td class="Generated">%s</td>'+NativeLineBreak
+'  </tr>'+NativeLineBreak;

/// * COMMON LINES END SECTION
HTML_COMMON_LINES_SECTION_END =
   '</table>'+NativeLineBreak
 + '<br />'+NativeLineBreak;

// HTML COMMON TABLE SECTION with 2 indexes

/// * %SectionName% %IndexName1; %IndexName2
HTML_COMMON_TABLE_INIT =
 '<span class="SectionName">%s</span><br />'+NativeLineBreak
+'<table class="TableNameAndDescription">'+NativeLineBreak
+'  <tr> '+NativeLineBreak
+'    <td class="tabletab">&nbsp;</td>'+NativeLineBreak
+'    <td> '+NativeLineBreak
+'      <table class="Table2Column">'+NativeLineBreak
+'        <tr class="TrItem">'+NativeLineBreak
+'          <td class="IndexName">%s</td>'+NativeLineBreak
+'          <td class="IndexName">%s</td>'+NativeLineBreak
+'        </tr>'+NativeLineBreak;

/// * %ItemName; %ItemDescription
HTML_COMMON_TABLE_LINE =
 '        <tr class="TrItem">'+NativeLineBreak
+'          <td class="TdFirstColumn">%s</td>'+NativeLineBreak
+'          <td>%s</td>'+NativeLineBreak
+'        </tr>'+NativeLineBreak;



/// * no parameter
HTML_COMMON_TABLE_END =
 '      </table>'+NativeLineBreak
+'    </td>'+NativeLineBreak
+'  </tr>'+NativeLineBreak
+ '</table><br />'+NativeLineBreak;

/// Unit description section %SectionName; %Item
HTML_COMMON_SIMPLE_COLORED_SECTION =
 '<span class="SectionName">%s</span><br />'+NativeLineBreak
+'<table width="95%%" border="0" bgcolor="#FFFFCC" cellspacing="0">'+NativeLineBreak
+'  <tr>'+NativeLineBreak
+'    <td width="10" bgcolor="#FFFFFF">&nbsp;</td>'+NativeLineBreak
+'    <td class="Generated">%s</td>'+NativeLineBreak
+'  </tr>'+NativeLineBreak
+'</table><br />'+NativeLineBreak;

/// FOOTER SECTION
HTML_SECTION_FOOTER =
 '<hr width="100%%" align="left" />'+NativeLineBreak
+'<span class="Footer">%s<br />'+NativeLineBreak
+'Created with DelphiCodeToDoc. To obtain the latest revision,'
+' please visit <a href="http://dephicodetodoc.sourceforge.net/">'
+'<b>http://dephicodetodoc.sourceforge.net/</b></a><br />'+NativeLineBreak
+'</span>'+NativeLineBreak
+'</td></tr>'+NativeLineBreak
+'</table>'+NativeLineBreak
+'</blockquote>'+NativeLineBreak
+'</div>'+NativeLineBreak
+'</body>'+NativeLineBreak
+'</html>'+NativeLineBreak;

/// MULTI SECTION %SectionName;
HTML_COMMON_MULTI_SECTION_INIT =
 '<span class="SectionName">%s</span><br />'+NativeLineBreak
+'<table class="simplesection">'+NativeLineBreak
+'  <tr>'+NativeLineBreak
+'    <td class="tabletab">&nbsp;</td>'+NativeLineBreak
+'    <td>';

/// End of MULTI table
HTML_COMMON_MULTI_END =
 '    </td>'+NativeLineBreak
+'  </tr>'+NativeLineBreak
+'</table><br />'+NativeLineBreak;

/// CSS default file
//###TOO LONG ???

HTML_CSS_FILE =
    'div#header{display:inline}' + NativeLineBreak
  + 'div#content{margin:0px;border-top:4px solid #666;border-left:4px solid #666;border-right:2px solid #666;border-bottom:2px solid #666;background:#fffff7;}' + NativeLineBreak
  + 'div#toolbar{width:100%;margin:0;padding:0;border-top:0;border-left:0;border-right:0;border-bottom:0;background:#99CCFF;}' + NativeLineBreak
  + '.Table2Column{width:100%;padding:0px 0px 0px 0px;border-width:0px 0px 0px 0px;background-color:Black;margin:0px 0px 0px 0px;}' + NativeLineBreak
  + '.RowBorder{padding:0px 0px 0px 0px;border-width:0px 0px 0px 0px;background-color:White;}' + NativeLineBreak
  + '.tabletab{width:10px;}' + NativeLineBreak
  + '.TableNameAndDescription{width:100%;}' + NativeLineBreak
  + '.TdFirstColumn{width:33%;}' + NativeLineBreak
  + '.TrItem{padding:0px 0px 0px 0px;border-width:0px 0px 0px 0px;background-color:White;margin:0px 0px 0px 0px;border:1px dotted Green;}' + NativeLineBreak
  + '.toolbar{width:100%;border:0;padding:0;background:#99CCFF;}' + NativeLineBreak
  + '.simplesection{width:95%;border:0;padding:0;}' + NativeLineBreak
  + '.DescriptionSection{width:95%;border:0;padding:0;background:#FFFFCC;}' + NativeLineBreak
  + 'h1{display:inline;background:#666;margin:10pt;padding:1pt;color:#ffffff;}' + NativeLineBreak
  + '.tableheader{font-size:large;background-color:#9F9F9F;}' + NativeLineBreak
  + 'body{color:#070707;background-color:#ccc;margin:10px;padding:0;}' + NativeLineBreak
  + '.SectionName{color:#000000;font-weight:bold;}' + NativeLineBreak
  + '.Generated{color:#9900FF;font-family:Verdana,Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-weight:normal}' + NativeLineBreak
  + '.IndexName{color:#000000;background-color:#CCCCCC;}' + NativeLineBreak
  + '.Normal{color:#000000;}' + NativeLineBreak
  + '.Footer{color:#000000;font-family:Verdana,Arial,Helvetica,sans-serif;font-size:xx-small;font-style:normal;font-weight:normal}' + NativeLineBreak
  + 'a:hover{color:#FF0000;text-decoration:underline}' + NativeLineBreak
  + '.DescriptionItem{width:100%;border:1px Black solid;}';


/// Label linked to a file %FileName, %Label
HTML_LINKED_LABEL =
 '<a href="%s">%s</a>';

{gnugettext: reset }

{*------------------------------------------------------------------------------
  Generate HTML HEAD section
  @param Name   Project name
  @param Summary   Project summary
  @param CSSFilename   Css filename
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenHead(const Name, Summary,CSSFilename: string): string;
begin
  Result := Format(HTML_COMMON_HEAD, [Name, Summary, CSSFilename, Name]);
end;

// TOOLBAR SECTION %ProjectName; %ContentName, %IndexName; %PreviousItemName, %NextItemName
{*------------------------------------------------------------------------------
  Build the HTML toobar
  @param ProjectName   Name of the project
  @param ContentName   Name of the content
  @param IndexName   Index name
  @param PreviousItemName   Previous item link
  @param NextItemName   Netx item link
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenToolbar(const ProjectName, ContentName, IndexName
 ,PreviousItemName, NextItemName: string): string;
begin
  Result := Format(HTML_COMMON_TOOLBAR, [ProjectName, ContentName, IndexName
 ,PreviousItemName, NextItemName]);
end;

{*------------------------------------------------------------------------------
  Build q si;ple HT:L section
  @param SectionName   Name of the section
  @param Item   Item link
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenSimpleSection(const SectionName, Item: string): string;
begin
  Result := Format(HTML_COMMON_SIMPLE_SECTION, [SectionName, Item]);
end;

{*------------------------------------------------------------------------------
  Build the start of a lines section
  @param SectionName   Name of the section
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenLinesSectionInit(const SectionName: string): string;
begin
  Result := Format(HTML_COMMON_LINES_SECTION_INIT, [SectionName]);
end;

{*------------------------------------------------------------------------------
  Build the start of a colored lines section
  @param SectionName   Name of the section
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenLinesSectionColoredInit(const SectionName: string): string;
begin
  Result := Format(HTML_COMMON_LINES_COLORED_SECTION_INIT, [SectionName]);
end;

{*------------------------------------------------------------------------------
  Build a line of a lines section
  @param Item   Text to add
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenLinesSectionLine(const Item: string): string;
begin
  Result := Format(HTML_COMMON_LINES_SECTION_LINE, [Item]);
end;

{*------------------------------------------------------------------------------
  Build a line of a colored lines section
  @param Item   Text to add
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenLinesSectionLineColored(const Item: string): string;
begin
  Result := Format(HTML_COMMON_LINES_SECTION_LINE_COLORED, [Item]);
end;

{*------------------------------------------------------------------------------
  Build the end of a lines section
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenLinesSectionEnd: string;
begin
  Result := Format(HTML_COMMON_LINES_SECTION_END, []);
end;

{*------------------------------------------------------------------------------
  Build the start of a table section
  @param SectionName   Name of the section
  @param IndexName1   Name of column 1
  @param IndexName2   Name of column 2
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenTableSectionInit(const SectionName, IndexName1, IndexName2: string): string;
begin
  Result := Format(HTML_COMMON_TABLE_INIT, [SectionName, IndexName1, IndexName2]);
end;

{*------------------------------------------------------------------------------
  Add a line to a table section
  @param ItemName   Name of the item to add
  @param ItemDescription   Description of the item
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenTableSectionLine(const ItemName, ItemDescription: string): string;
begin
  Result := Format(HTML_COMMON_TABLE_LINE, [ItemName , ItemDescription]);
end;

{*------------------------------------------------------------------------------
  Build a line of a Table section
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenTableSectionEnd: string;
begin
  Result := Format(HTML_COMMON_TABLE_END, []);
end;

{*------------------------------------------------------------------------------
  Build a simple colored section
  @param SectionName   Name of the section
  @param Item   LText to add
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenSimpleColoredSection(const SectionName, Item: string): string;
begin
  Result := Format(HTML_COMMON_SIMPLE_COLORED_SECTION, [SectionName, Item]);
end;

{*------------------------------------------------------------------------------
  Build a footer section containing copyright informations
  @param CopyrightString   Custom copyright text
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenFooter(const CopyrightString: string) : string;
begin
  Result := Format(HTML_SECTION_FOOTER, [CopyrightString]);
end;

{*------------------------------------------------------------------------------
  Build the CSS file section
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenCSS: string;
begin
  Result := HTML_CSS_FILE;
end;


{*------------------------------------------------------------------------------
  Build the start of a Multi section
  @param SectionName   Name of the section
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenMultiSectionInit(const SectionName: string): string;
begin
  Result := Format(HTML_COMMON_MULTI_SECTION_INIT, [SectionName]);
end;

{*------------------------------------------------------------------------------
  Build the end of a Multi section
  @return string representing the section
------------------------------------------------------------------------------*}
function HTMLGenMultiSectionEnd: string;
begin
  Result := Format(HTML_COMMON_MULTI_END, []);
end;

{*------------------------------------------------------------------------------
  Build a link in HTML representation
  @param  st  description of the link (visual part of the link)
  @param  Link  file or reference where the link will lead
  @return HTML string of the hyperlink
 ------------------------------------------------------------------------------}
function HTMLBuildLink(const st : string; const Link : string) : string;
begin
  if Link<>'' then
  begin
    //<a href="LinkedFile.htm">Label</a>
    Result:=Format(HTML_LINKED_LABEL,[Link+HTML_FILE_EXT,st]);
    // Replace Windows file path separator '\' with web path separator '/'
    CharReplace(Result,'\','/');
  end
  else Result := st;
end;

{*------------------------------------------------------------------------------
  Convert a string to html string with EOL
  @param sl   Source String to convert
  @param NoCharEncode   True if HTML convertion is asked
  @return string compliant to html
------------------------------------------------------------------------------*}
function StringsToHTMLStrings(const sl: TStringList; const EnableCharEncode:boolean) : string;
var
  IndexLine: integer;
begin
  Result:='';
  if not assigned(sl) then exit;
  for IndexLine:=0 to sl.Count-1 do
  begin
    // Encode line to HTML is asked
    if EnableCharEncode=False then
     Result:=Result+sl.Strings[IndexLine]
    else
      // StringToHtml() will broke UNICODE !
      Result:=Result+StringToHtml(sl.Strings[IndexLine]);
    if IndexLine<(sl.Count-1) then Result:=Result+HTML_EOL;
  end;
end;

end.
