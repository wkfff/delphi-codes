unit UF_OpenGLBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, OpenGL;

type
  TOpenGLBase = class(TForm)
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FDC:HDC;
    FRC:HGLRC;
  protected
    procedure SetupPixelFormat(DC:HDC); // 设置象素格式
    procedure GLInit; virtual;
    procedure Draw; virtual;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TForm1 }

procedure TOpenGLBase.Draw;
begin

end;

procedure TOpenGLBase.GLInit;
begin
  glEnable(GL_DEPTH_TEST);
//  glEnable(GL_CULL_FACE);
  glEnable(GL_NORMALIZE);
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
end;

procedure TOpenGLBase.SetupPixelFormat(DC: HDC);
const
   pfd:TPIXELFORMATDESCRIPTOR = (
        nSize:sizeof(TPIXELFORMATDESCRIPTOR);       // 结构大小
        nVersion:1;                                 // 版本号
        dwFlags:PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or
                PFD_DOUBLEBUFFER;                  // 支持双缓存
        iPixelType:PFD_TYPE_RGBA;                  // 颜色类型
        cColorBits:24;                             // 颜色深度
        cRedBits:0; cRedShift:0;                   // 颜色位数)
        cGreenBits:0;  cGreenShift:0;
        cBlueBits:0; cBlueShift:0;
        cAlphaBits:0;  cAlphaShift:0;              // 没有Alpha缓存
        cAccumBits: 0;
        cAccumRedBits: 0;                          // 没有积累缓存
        cAccumGreenBits: 0;        
        cAccumBlueBits: 0;
        cAccumAlphaBits: 0;
        cDepthBits:16;                             // 深度缓存
        cStencilBits:0;                            // 没有模板缓存
        cAuxBuffers:0;                             // 没有辅助缓存
        iLayerType:PFD_MAIN_PLANE;                 // 主层
   bReserved: 0;
   dwLayerMask: 0;
   dwVisibleMask: 0;
   dwDamageMask: 0;
   );
var
  pixelFormat:integer;
begin
  //选择设置像素格式
  pixelFormat := ChoosePixelFormat(DC, @pfd);
  Assert(pixelFormat <> 0);
  assert(SetPixelFormat(DC, pixelFormat, @pfd));
end;

procedure TOpenGLBase.FormPaint(Sender: TObject);
begin
  Draw;
end;

procedure TOpenGLBase.FormCreate(Sender: TObject);
begin
   FDC:=GetDC(Handle);        //你可以在这里使用任何的窗口控制
   SetupPixelFormat(FDC);
   FRC:=wglCreateContext(FDC); //  创建渲染环境FRC
   wglMakeCurrent(FDC, FRC);   // 激活OpenGL 窗口
   GLInit;                   // 初始化OpenGL
end;

procedure TOpenGLBase.FormDestroy(Sender: TObject);
begin
  if FRC <> 0 then
  begin
    wglMakeCurrent(0, 0); // 解除设备关联
    wglDeleteContext(FRC);
  end;
  ReleaseDC(Handle, FDC);
end;

end.
 