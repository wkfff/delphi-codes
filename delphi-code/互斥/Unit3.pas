unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm3 = class(TForm)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FMutHandle: THandle;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  Unit1;

{$R *.dfm}

procedure TForm3.FormDestroy(Sender: TObject);
begin
  if FMutHandle <> 0 then
  begin
    if not CloseHandle(FMutHandle) then
      Assert(False);
    FMutHandle := 0;
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  FMutHandle := CreateMutex(nil, False, PChar(CTestStr));
  //工程已经打开
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    ShowMessage('3');  
    CloseHandle(FMutHandle);
    FMutHandle := 0;
  end;
end;

end.
