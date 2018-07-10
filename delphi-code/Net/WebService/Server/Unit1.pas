unit Unit1;

interface

uses
  SysUtils, Classes, Forms, Controls, StdCtrls, MainImpl;

type
  TForm1 = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses SockApp, GrandUiUtils;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  o: TMain;
begin
  o:= TMain.create;
  ShowPrompt(o.GetMsg('hi'));
  o.Free;
end;

initialization
  TWebAppSockObjectFactory.Create('Test')

end.
