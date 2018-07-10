unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    edt1: TEdit;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TMyThread = class(TThread)
  private
    FAnswer: Integer;
  protected
    procedure GiveAnswer;
    procedure Execute; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  oThread: TMyThread;
  I, Answer: Integer;
begin
  oThread := TMyThread.Create(False);
end;

{ TMyThread }

procedure TMyThread.Execute;
var
  I: Integer;
begin
  inherited;
  FreeOnTerminate := True;
  FAnswer := 0;
  for I := 1 to 200000000 do
    Inc(FAnswer, Round(Abs(Sin(Sqrt(I)))));
  Synchronize(GiveAnswer);

end;
procedure TMyThread.GiveAnswer;
begin
  form1.edt1.Text := IntToStr(FAnswer);
  ShowMessage('done');
end;

end.
