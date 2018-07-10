unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    lbl1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.FormCreate(Sender: TObject);
var
  s: string;
  sCmdLine: string;
begin
  sCmdLine := GetCommandLine;

  ShowMessage(sCmdLine);
  s := Copy(sCmdLine, Length(ParamStr(0))+1, Length(sCmdLine));
  ShowMessage(s);
//  ShowMessage(IntToStr(ParamCount)+':'+ParamStr(ParamCount));
//  if ParamCount > 1 then
//  begin
//    ShowMessage(ParamStr(1));
//    lbl1.Caption := ParamStr(1);
//  end;
  Close;
end;

end.
