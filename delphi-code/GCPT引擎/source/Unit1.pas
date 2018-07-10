unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    mmo1: TMemo;
    lb1: TListBox;
    procedure btn1Click(Sender: TObject);
  private
    procedure GetTokens(var ATokens: array of string; const AStatement: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  oTxtFile: TextFile;
  s: string;
  s2: string;
  arrTokens: array of string;
  I: Integer;
begin
  AssignFile(oTxtFile, 'test.txt');
  Reset(oTxtFile);
  while not Eof(oTxtFile) do
  begin
    Readln(oTxtFile, s);
    s2 := s2 + s;
  end;
  mmo1.Lines.Text := s2;
  SetLength(arrTokens, 200);
  GetTokens(arrtokens, s2);
  for I := 0 to Length(arrTokens) - 1 do
    if not SameText(arrTokens[I], '') then
    lb1.Items.Add(arrTokens[I])

end;

procedure TForm1.GetTokens(var ATokens: array of string; const AStatement: string);
var
  I: Integer;
begin
//  SetLength(ATokens, 20);
//  SetLength(ATokens;);
  for I := 0 to (Length(AStatement) - 1) div 2 do
  begin
    ATokens[I] := AStatement[2 * I] + AStatement[2* I+1];
  end;

end;



end.
