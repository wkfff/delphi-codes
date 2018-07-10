unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniOptionsTest;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
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

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  s: string;
begin
  IniOptions.LoadFromFile('cfg.ini');
  s := s + csIniSQLServerServer + ':' + IniOptions.SQLServerServer + #13;
  s := s + csIniSQLServerUID + ':' +  IniOptions.SQLServerUID + #13;
  s := s + csIniSQLServerPWD + ':' +  IniOptions.SQLServerPWD + #13;
  s := s + csIniSQLServerAuthentication + ':' +  IniOptions.SQLServerAuthentication + #13;
  s := s + csIniSQLServerBJDB + ':' +  IniOptions.SQLServerBJDB + #13;
  s := s + csIniSQLServerXADB + ':' +  IniOptions.SQLServerXADB + #13;

  mmo1.Lines.Text := s;

end;

end.
