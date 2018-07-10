unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
    mmo2: TMemo;
    btn1: TButton;
    btn2: TButton;
    fllst1: TFileListBox;
    dirlst1: TDirectoryListBox;
    btn3: TButton;
    dlgOpen1: TOpenDialog;
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    FFileList: TStringList;
    function SlashSep(const Path, S: String): String;
    function ReadDirectoryNames(const ParentDirectory: string;
  DirectoryList: TStringList): Integer;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  fllst1.Directory := 'E:\CJ材价产品自动化工具项目';
end;

procedure TForm1.btn3Click(Sender: TObject);
var
  sl: TStringList;
  I: Integer;
begin
  mmo1.Lines.Text := '';
  sl := TStringList.Create;
  try
    ReadDirectoryNames('E:\CJ材价产品自动化工具项目', sl);
    for I := 0 to sl.Count - 1 do
      mmo1.Lines.Text := mmo1.Lines.Text + sl.Strings[I] + #13;
  finally
    FreeAndNil(sl);
  end;
end;


function TForm1.SlashSep(const Path, S: String): String;
begin
  if AnsiLastChar(Path)^ <> '\' then
    Result := Path + '\' + S
  else
    Result := Path + S;
end;

function TForm1.ReadDirectoryNames(const ParentDirectory: string;
  DirectoryList: TStringList): Integer;
var
  Status: Integer;
  SearchRec: TSearchRec;
begin
  Result := 0;
  Status := FindFirst(SlashSep(ParentDirectory, '*.*'), faDirectory, SearchRec);
  try
    while Status = 0 do
    begin
      if (SearchRec.Attr and faDirectory = faDirectory) then
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        begin
          DirectoryList.Add(SearchRec.Name);
          Inc(Result);
        end;
      end;
      Status := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);
  end;
end;

end.
