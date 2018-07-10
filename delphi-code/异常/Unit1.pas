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
  procedure A;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.A;
var
  i, j: Integer;
begin
  i := 0;
  try
    try
      j := 18 div i;
    except
      ShowMessage('before raise: A');
      raise;
      ShowMessage('after raise: A');
    end;
    ShowMessage('after except: A');
  finally
    ShowMessage('finally: A');
  end;

  ShowMessage('after finally: A');
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  a;
//  try
//    ShowMessage('call A');
//   a;
//     ShowMessage('after call A');
//  except
//    ShowMessage('catch: A');
//  end;


end;

end.
