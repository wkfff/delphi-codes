unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FMutHandle: THandle;
  public
    { Public declarations }
  end;

var
  Form4: TForm4;


implementation

uses
  Unit1;

{$R *.dfm}

procedure TForm4.btn1Click(Sender: TObject);
begin
   FMutHandle := CreateMutex(nil, False, PChar(CTestStr));
  //工程已经打开
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    ShowMessage('4');
    CloseHandle(FMutHandle);
    FMutHandle := 0;
  end;
end;

procedure TForm4.btn2Click(Sender: TObject);
begin
  FMutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, PChar(CTestStr));
  if FMutHandle <> 0 then    // 互斥对象已建立，说明已有实例存在
  begin
    ShowMessage('opened4');
  end
  else
    ShowMessage('opened4  0');
end;

procedure TForm4.FormDestroy(Sender: TObject);
begin
            if FMutHandle <> 0 then
            begin
              if not CloseHandle(FMutHandle) then
                Assert(False);
              FMutHandle := 0;
            end;
end;

end.
