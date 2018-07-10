unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMainForm = class(TForm)
    btnShow: TButton;
    mmoFileContent: TMemo;
    dlgOpen: TOpenDialog;
    grpDir: TGroupBox;
    grpFile: TGroupBox;
    btnChoose: TButton;
    grpFileName: TGroupBox;
    procedure btnShowClick(Sender: TObject);
    procedure btnChooseClick(Sender: TObject);
  private
    FFileName: string;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

const
  CTestFileTXT = 'testFileTXT.txt';

{$R *.dfm}

{-----------------------------------------------------------------------------
  作者：liul-a 2010.08.25
  参数：
  返回：
  功能：文本文件读写
-----------------------------------------------------------------------------}
procedure TMainForm.btnChooseClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    FFileName := dlgOpen.FileName;
end;

procedure TMainForm.btnShowClick(Sender: TObject);
var
  oFile: TextFile;
  s: string;
begin
  AssignFile(oFile, CTestFileTXT);
  try
    Reset(oFile);
    Readln(oFile, s);
    mmoFileContent.Lines.Text := s;
  finally
    CloseFile(oFile);
  end;

end;

end.
