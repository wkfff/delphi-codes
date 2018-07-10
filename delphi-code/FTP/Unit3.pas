unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdFTP, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient;

type
  TForm3 = class(TForm)
    IdFTP1: TIdFTP;
    mmo1: TMemo;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.btn1Click(Sender: TObject);
var
  ts : TStringList;
begin
  IdFTP1.Host := 'server-gaea';
  IdFTP1.Username := 'anonymous';
//  IdFTP1.
  IdFTP1.Connect;
  ts := TStringList.Create;
  try
//    IdFTP1.RetrieveCurrentDir;
    IdFTP1.List(ts);
    mmo1.Lines.Assign(ts);
  finally
    ts.Free;
//    IdFTP1.Disconnect
  end;
end;

end.
