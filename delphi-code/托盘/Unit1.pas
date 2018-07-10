unit Unit1;

interface

uses
Windows, Classes, Forms, Controls, StdCtrls, ExtCtrls;

type
  TZoomAction = (zaMinimize, zaMaximize);
  TForm1 = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure ZoomEffect(theForm: TForm; theOperation: TZoomAction);
var
rcStart: TRect;
rcEnd: TRect;
rcTray: TRect;
hwndTray : hWnd;
hwndChild: hWnd;
begin
{ Ѱ��ϵͳ��������λ��}
hwndTray := FindWindow('Shell_TrayWnd', nil);
hwndChild := FindWindowEx(hwndTray, 0, 'TrayNotifyWnd', nil);
GetWindowRect(hwndChild, rcTray);

{����������/��С�������л���ʼ/����}
if theOperation = zaMinimize then
begin
rcStart := theForm.BoundsRect;
rcEnd := rcTray;
end
else
begin
rcEnd := theForm.BoundsRect;
rcStart := rcTray;
end;

{ �����ǹؼ��Ĳ���... }
DrawAnimatedRects(theForm.Handle, IDANI_CAPTION, rcStart, rcEnd)
end;


procedure TForm1.btn1Click(Sender: TObject);
begin
  ZoomEffect(Self, zaMinimize);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ZoomEffect(Self, zaMinimize);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ZoomEffect(Self, zaMaximize);
end;

end.
