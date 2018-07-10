unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    grp1: TGroupBox;
    strngrd1: TStringGrid;
    grp2: TGroupBox;
    drwgrd1: TDrawGrid;
    pnl1: TPanel;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
    procedure drwgrd1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
        State: TGridDrawState);
    procedure strngrd1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
        State: TGridDrawState);
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
begin
//  (Sender as TDrawGrid).Canvas.TextOut(Rect.Left + 2,Rect.Top + 2,'文件名');
end;

procedure TForm1.drwgrd1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect:
    TRect; State: TGridDrawState);
var
  r: TRect;
begin
//  r := drwgrd1.CellRect(0, 0);
//  (Sender as TDrawGrid).Canvas.TextOut(ACol,ARow,'aqqq');
  if ARow=0 then
  begin
    with (Sender as TDrawGrid).Canvas do
    begin
      case ACol of
        0: TextOut(Rect.Left + 2,Rect.Top + 2,'序号');
        1: TextOut(Rect.Left + 2,Rect.Top + 2,'文件名');
        2: TextOut(Rect.Left + 2,Rect.Top + 2,'空白行');
        3: TextOut(Rect.Left + 2,Rect.Top + 2,'注释行');
        4: TextOut(Rect.Left + 2,Rect.Top + 2,'代码行');
        5: TextOut(Rect.Left + 2,Rect.Top + 2,'总行数');
      end;
    end;
  end;

//  (Sender as TDrawGrid).Canvas.TextOut(Rect.Left + 2,Rect.Top + 2,'b');
//  drwgrd1.Canvas.Ellipse(acol*19,arow*19,(acol+1)*19,(arow+1)*19);
  if (ARow=0) or (ACol=0) then exit;


(Sender as TDrawGrid).Canvas.MoveTo(Rect.Left,Rect.Top);
(Sender as TDrawGrid).Canvas.LineTo(Rect.Right,Rect.Bottom);

end;

procedure TForm1.strngrd1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect:
    TRect; State: TGridDrawState);
var
  w,h: Integer;
  sTemp: string;
begin
   (Sender as TStringGrid).RowCount := 50;

//  sTemp := (Sender as TStringGrid).Cells[acol, arow];
  sTemp := 'aaaa';
  with (Sender as TStringGrid).Canvas do
  begin
    w := TextWidth(sTemp);
    h := TextHeight(sTemp);
    TextOut((Rect.Left + Rect.Right - w) div 2 ,
      (Rect.top +  Rect.Bottom - h) div 2, sTemp);
  end;
  (Sender as TStringGrid).Canvas.MoveTo(Rect.Left,Rect.Top);
end;

end.
