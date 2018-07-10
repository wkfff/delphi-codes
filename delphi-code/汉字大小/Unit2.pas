unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TForm2 = class(TForm)
    mmo1: TMemo;
    lbl1: TLabel;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetInfoWidth(AText: string): Integer;

var
  Form2: TForm2;

const
  ciDis = 10;
  cs_Length = 'Length_%d';
  cs_Angle = 'Angle_%d';
  CInfoEditHeight = 13;
  CInfoEditWidth = 180;


resourcestring
  S = '关闭工程前的最后一次设置结果可以予以保留，下次打开该软件时设置应不变';

implementation

{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
begin
  with TLabel.Create(nil) do
  try
    Parent := Form2;
    lbl1.Caption := IntToStr(Length(S))+ '#'+
    IntToStr(Canvas.TextHeight(S))+ ':'+
    IntToStr(Canvas.TextWidth(S));
  finally
    Free;
  end;
end;

procedure TForm2.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y:
    Integer);
begin
  mmo1.Width := CInfoEditWidth + 10;
  mmo1.Height := Round((GetInfoWidth(S)/CInfoEditWidth)+ 0.5)*CInfoEditHeight + 6;
  mmo1.Text := S;

  mmo1.Top := y;
  mmo1.Left := x;
end;

function GetInfoWidth(AText: string): Integer;
begin
  Result := Max(CInfoEditWidth, (Length(AText)) * 6);
end;


end.
