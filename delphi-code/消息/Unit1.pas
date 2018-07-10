unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
    pnl1: TPanel;
  private
    FCount: Integer;

    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;

    // 组件消息
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.CMMouseEnter(var Msg: TMessage);
begin
  pnl1.Color := clGreen;
end;

procedure TForm1.CMMouseLeave(var Msg: TMessage);
begin
   pnl1.Color := clBlack;
end;

procedure TForm1.WMPaint(var Msg: TWMPaint);
begin
  MessageBeep(0);
  Beep;
//  ShowMessage('hi');
  Inc(FCount);
  mmo1.Lines.Text := IntToStr(FCount);
  inherited;
end;

end.
