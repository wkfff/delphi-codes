unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GSPInterface, GSPEngineUtils;

type
  TForm2 = class(TForm)
    btn1: TButton;
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
var
  sFile: string;
  oModel: IGSPModel;
  oTalbe: IGSPTable;
  oRecord: IGSPRecord;
  I: Integer;
  sContext: string;
begin
  with TOpenDialog.Create(nil) do
  try
    if Execute then
    begin
      sFile := FileName;
      oModel := GSPEngineUtils.GSPEngine().CreateModel();
      GSPEngineUtils.GSPEngine().CreateModelXMLReader().read(sFile, oModel);
      try
        oTalbe := oModel.FindTable('business', 'QtyGroupSetting');

        for I := 0 to oTalbe.RecordCount - 1 do
        begin
          oRecord := oTalbe.records[I];
          sContext := oRecord.AsString['GroupFieldName'];
          if
//             (Pos(sContext, #13) > 0) or
//             (Pos(sContext, #10) > 0) or
//             (Pos(sContext, #10#13) > 0) or
//             (Pos(sContext, #13#10) > 0) or
//             (Pos(sContext, sLineBreak) > 0) or
//             (Pos(sContext, ' ') > 0) //or
             //(oRecord.ID = 224)
           (Pos(sLineBreak, sContext) > 0)

          then
          OutputDebugString(PAnsiChar('id:' + IntToStr(oRecord.ID) + ':' + sContext));
          
//
        end;
      except

      end;
    end;
  finally
    Free;
  end;

  ShowMessage('ok');
end;

end.
