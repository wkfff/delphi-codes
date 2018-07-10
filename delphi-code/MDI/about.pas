unit about;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    OKButton: TButton;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation
uses XMconsts;
{$R *.dfm}

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  ProductName.Caption := sBookName;
  Version.Caption := '';
  Copyright.Caption := sStudio;
  Comments.Caption := sCore + sDiv + ArrCoreExp[1];
end;

end.

