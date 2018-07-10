unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

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

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  A: Integer;
begin
  a := -1;
  case A of
    0: ;//ShowMessage('0');
    1: ShowMessage('1');
    2: ShowMessage('2');
    3: ;
    else ShowMessage('else');
  end;
end;

end.
