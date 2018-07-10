unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    function InnerGetSystemTime: Double;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  DateUtils;

{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
var
  oT1, oT2, oT3: TSystemTime;
  sMsg1, sMsg2: string;
  odt1, odt2: TDateTime;
begin
//  GetSystemTime(oT1);
//  sMsg1 := IntToStr(oT1.wMinute) + ' ' +
//          IntToStr(oT1.wSecond) + ' ' +
//          IntToStr(oT1.wMilliseconds);
//
//  ShowMessage(sMsg1);
//  GetSystemTime(oT2);
//  sMsg2 := sMsg1 + #13 +
//          IntToStr(oT2.wMinute) + ' ' +
//          IntToStr(oT2.wSecond) + ' ' +
//          IntToStr(oT2.wMilliseconds);
//
//  ShowMessage(sMsg2);
  ShowMessage(FormatDateTime('c":"zzz', Now));
  odt1 := Time;
  ShowMessage(DateTimeToStr(odt1));
  odt2 := Time;
//  MilliSecondsBetween(odt2, odt1);
//  odt2 - odt1
  ShowMessage(DateTimeToStr(odt1) + #13#10 +
              DateTimeToStr(odt2) + #13#10 +
              IntToStr(MilliSecondsBetween(odt2, odt1)));
end;

function TForm2.InnerGetSystemTime: Double;
const
  CTime = 60;
  CMi = 1000;
begin
     //      数组排序  时间
end;

end.
