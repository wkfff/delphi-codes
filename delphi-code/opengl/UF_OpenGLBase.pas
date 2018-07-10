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
    procedure SetupPixelFormat(DC:HDC); // �������ظ�ʽ
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
        nSize:sizeof(TPIXELFORMATDESCRIPTOR);       // �ṹ��С
        nVersion:1;                                 // �汾��
        dwFlags:PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or
                PFD_DOUBLEBUFFER;                  // ֧��˫����
        iPixelType:PFD_TYPE_RGBA;                  // ��ɫ����
        cColorBits:24;                             // ��ɫ���
        cRedBits:0; cRedShift:0;                   // ��ɫλ��)
        cGreenBits:0;  cGreenShift:0;
        cBlueBits:0; cBlueShift:0;
        cAlphaBits:0;  cAlphaShift:0;              // û��Alpha����
        cAccumBits: 0;
        cAccumRedBits: 0;                          // û�л��ۻ���
        cAccumGreenBits: 0;        
        cAccumBlueBits: 0;
        cAccumAlphaBits: 0;
        cDepthBits:16;                             // ��Ȼ���
        cStencilBits:0;                            // û��ģ�建��
        cAuxBuffers:0;                             // û�и�������
        iLayerType:PFD_MAIN_PLANE;                 // ����
   bReserved: 0;
   dwLayerMask: 0;
   dwVisibleMask: 0;
   dwDamageMask: 0;
   );
var
  pixelFormat:integer;
begin
  //ѡ���������ظ�ʽ
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
   FDC:=GetDC(Handle);        //�����������ʹ���κεĴ��ڿ���
   SetupPixelFormat(FDC);
   FRC:=wglCreateContext(FDC); //  ������Ⱦ����FRC
   wglMakeCurrent(FDC, FRC);   // ����OpenGL ����
   GLInit;                   // ��ʼ��OpenGL
end;

procedure TOpenGLBase.FormDestroy(Sender: TObject);
begin
  if FRC <> 0 then
  begin
    wglMakeCurrent(0, 0); // ����豸����
    wglDeleteContext(FRC);
  end;
  ReleaseDC(Handle, FDC);
end;

end.
 