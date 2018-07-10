// ABoutBox display Project Infos
unit fAbout;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, SysUtils, Grids, ValEdit;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    OKButton: TButton;
    Copyright: TLabel;
    ProductVersion: TMemo;
    ProductIcon: TImage;
    ProductDescription: TMemo;
    ProductName: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure AskTranslations;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.DFM}

uses JvGnugettext;

procedure TAboutBox.AskTranslations;
begin
  TranslateComponent(ProductDescription);
end;

procedure TAboutBox.FormCreate(Sender: TObject);
const
  InfoNum = 10;
  InfoStr: array[1..InfoNum] of string = ('CompanyName', 'FileDescription'
    , 'FileVersion', 'InternalName', 'LegalCopyright', 'LegalTradeMarks'
    , 'OriginalFileName', 'ProductName', 'ProductVersion', 'Comments');
var
  S:     string;
  n, Len, i: DWORD;
  Buf:   PChar;
  Value: PChar;
begin
  AskTranslations;
  
  S := Application.ExeName;
  n := GetFileVersionInfoSize(PChar(S), n);
  if n > 0 then
  begin
    Buf := AllocMem(n);
    GetFileVersionInfo(PChar(S), 0, n, Buf);
    for i := 1 to InfoNum do
    begin
      if VerQueryValue(Buf, PChar('StringFileInfo\040904E4\' + InfoStr[i]),
        Pointer(Value), Len) then
      begin
        if Value <> PChar('') then
        begin
          ProductVersion.Lines.Add(InfoStr[i] + ' = [' + Value + ']');
          if i = 7 then
          begin
            ProductName.Caption := Value
          end;
        end
      end
    end;
    FreeMem(Buf, n);
  end
  else    begin
    ProductVersion.Lines.Add('No version information found')
  end;
end;

end.
