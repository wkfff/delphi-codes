unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMyClassB = class
  public
    FNum: Integer;
    FInfo: string;
    procedure TF;
  end;


  TForm5 = class(TForm)
    btn1: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.FormCreate(Sender: TObject);
type
  TTestFun = procedure (); stdcall;
var
  h: Cardinal;
  f: TTestFun;
  c: TMyClassB;
begin
  //c.TF;

  h := LoadLibrary(PAnsiChar('testdll.dll'));
  if h <> 0 then
  begin
    f := GetProcAddress(h, 'Test');
    f;
    FreeLibrary(h);
  end;
end;

{ TMyClassB }

procedure TMyClassB.TF;
begin
  FNum := $24681357;
  FInfo := 'xyzabc';
end;

end.
