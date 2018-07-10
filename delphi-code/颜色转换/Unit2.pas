unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    edt1: TEdit;
    edtR: TEdit;
    edtG: TEdit;
    edtB: TEdit;
    btn1: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
begin
  edt1.Text :='$' +
    IntToHex(TColor(RGB(StrToInt(edtR.Text), StrToInt(edtG.Text), StrToInt(edtB.Text))), 8);
end;


end.
