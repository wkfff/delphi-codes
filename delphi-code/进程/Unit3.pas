unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  ShellAPI;

{$R *.dfm}

procedure TForm3.btn1Click(Sender: TObject);
var
  s: string;
begin
  s := 'abc';
  for I := 0 to Length(s) - 1 do
    s[0];
//  ShowMessage(s[0]);
//  ShellExecute(0, 'Open', PChar('Project5.exe'), PAnsiChar('-d'), nil, SW_SHOW);
end;

procedure TForm3.btn2Click(Sender: TObject);
begin
  WinExec(PChar('Project5.exe d e'), SW_SHOW)
end;

end.
