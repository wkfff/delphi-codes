unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

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
  arr: array of string;
  s: string;
  I: Integer;
begin
  SetLength(arr, 3);
  arr[0] := 'a';
  arr[1] := 'b';
  arr[2] := 'c';

  SetLength(arr, 5);
  arr[4] := 'e';

  for I := 0 to Length(arr) - 1 do
    s := s + arr[I];

  mmo1.Lines.Text := s;
end;

end.
