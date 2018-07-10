unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type


  TA = class
  private
    FA: string;
    procedure SetA(const Value: string);
  published
  public
    property A: string read FA write SetA;
    constructor Create(A: string);
  end;

  TB = class(TA)
  public
    constructor Create(A: string; B: string); reintroduce;
  end;

  TForm1 = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    FB: TB;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TB }

constructor TB.Create(A: string; B: string);
begin
  inherited Create(A);
end;

{ TA }

constructor TA.Create(A: string);
begin
  FA := A;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  FB := TB.Create('a', 'b');
  ShowMessage(FB.A);
  fB.free;
end;

procedure TA.SetA(const Value: string);
begin
  FA := Value;
end;

end.
