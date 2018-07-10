{*------------------------------------------------------------------------------
  Resources for PDFGenerator

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2009 - Under GNU GPL licence

  @Author    TridenT
-------------------------------------------------------------------------------}
unit uDocGenPDF_Tools;

interface

uses
  Classes;

{gnugettext: scan-all text-domain='DCTD_ignore' }

const
  HTML_INLUDE_PATH = 'html\'; /// HTML files path to retrieve
  PDF_FILE_EXT = '.pdf'; /// PDF file extention
  BOOK_FILE_EXT = '.book'; /// book file extention
  PDF_OUTPUT_PATH : string = 'pdf'; /// base output file for PDF

{gnugettext: reset }


function PDFGenHeader(const PdfName : string): string;

implementation

uses
  SysUtils, JclStrings;

resourcestring

{gnugettext: scan-all text-domain='DCTD_ignore' }

/// HEAD section
PDF_COMMON_HEADER = '#HTMLDOC 1.8.24 Open Source'+NativeLineBreak
 + '-t pdf13 -f %s.pdf --webpage --title --textcolor #000000 --linkcolor'
 + ' #0000ff --linkstyle underline --size Universal --left 0.50in --right 0.50in'
 + ' --top 0.50in --bottom 0.50in --header .t. --footer h.1 --nup 1 --tocheader'
 + ' .t. --tocfooter ..i --portrait --color --no-pscommands --no-xrxcomments'
 + ' --compression=1 --jpeg=0 --fontsize 8.0 --fontspacing 1.0 --headingfont'
 + ' Helvetica --bodyfont Times --headfootsize 8.0 --headfootfont Helvetica'
 + ' --charset iso-8859-1 --links --embedfonts --pagemode document --pagelayout'
 + ' single --firstpage p1 --pageeffect none --pageduration 10 --effectduration'
 + ' 1.0 --no-encryption --permissions all  --owner-password ""  --user-password'
 + ' "" --browserwidth 1025 --strict';

{gnugettext: reset }

{*------------------------------------------------------------------------------
  Return PDF header section
  @return string representing the section
------------------------------------------------------------------------------*}
function PDFGenHeader(const PdfName : string): string;
begin
  result := Format(PDF_COMMON_HEADER, [PdfName]);
end;


end.
