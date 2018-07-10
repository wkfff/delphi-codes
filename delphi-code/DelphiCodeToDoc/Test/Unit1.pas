unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure A(A: string);
    procedure B(B: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{*-------------------------
  功能 这是可以的
  @Author : l
  功能 ：功能
  参数 ：爱爱爱
  返回 ：嗷嗷嗷
  @param  A
  @return A
--------------------------}
procedure TForm1.FormCreate(Sender: TObject);
begin
//
end;

{*------------------------------------------------------------------------------
  A      中文
  参数 ： 啊啊
  @param  A    啊的
  @return A
-------------------------------------------------------------------------------}
procedure TForm1.A(A: string);
begin
//
end;

{*------------------------------------------------------------------------------
  B
  @param  B
  @return b
-------------------------------------------------------------------------------}
procedure TForm1.B(B: string);
begin
//
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//
end;


end.
