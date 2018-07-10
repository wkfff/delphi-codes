program MRICU;

uses
  Windows, Messages;

//{$R *.res}

const
  szAppName : PChar = 'MiniApp';
function WndProc(AWnd:HWND; message:UINT; wp:WPARAM; lp:LPARAM):LRESULT;stdcall;
begin
  Result := 0;
  case message of
    WM_DESTROY:
       PostQuitMessage(0);
    else
       Result := DefWindowProc(AWnd, message, wp, lp);
  end;
end;
var
  wc : WNDCLASS;
  HMainWnd : HWND;
  AMsg : MSG;
begin
  with wc do begin
    style := CS_VREDRAW or CS_HREDRAW;
    lpfnWndProc := @WndProc;
    cbClsExtra := 0;
    cbWndExtra := 0;
    hIcon := LoadIcon(0, IDI_APPLICATION);
    hCursor := LoadCursor(0, IDC_ARROW);
    hbrBackground := GetSysColorBrush(COLOR_WINDOW);
    hInstance := HInstance;
    lpszMenuName := nil;
    lpszClassName := szAppName;
  end;
  RegisterClass(wc);
  HMainWnd := CreateWindow(szAppName,
                           szAppName,
                           WS_OVERLAPPEDWINDOW,
                           Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),
                           Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),
                           HWND_DESKTOP, 0,
                           HInstance, nil);
  ShowWindow(HMainWnd, CmdShow);
  UpdateWindow(HMainWnd);
  while GetMessage(AMsg, 0, 0, 0) do begin
    TranslateMessage(AMsg);
    DispatchMessage(AMsg);
  end;
end.
