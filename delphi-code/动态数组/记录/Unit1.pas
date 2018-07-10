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

  FMR = record
    FID: Integer;
    FName: string;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  arrA: array of FMR;
  S: string;
  oFMR: FMR;
  I: Integer;
begin
  SetLength(arrA, 10);
  oFMR.FID := 0;
  oFMR.FName := 'a';
  arrA[0] := oFMR;
  arrA[1] := oFMR;
  oFMR.FID := 1;
  arrA[3] := oFMR;

  for I := 0 to Length(arrA) - 1 do
  begin
    S := S + IntToStr(arrA[I].FID) + ' ' + arrA[I].FName + #13;
  end;
  mmo1.Lines.Text := S;


end;

end.
