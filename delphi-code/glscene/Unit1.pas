unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GLWin32Viewer, GLMisc, GLScene, GLObjects;

type
  TForm1 = class(TForm)
    glScene: TGLScene;
    glViewer: TGLSceneViewer;
    glCube: TGLCube;
    glCamera: TGLCamera;
    gLight: TGLLightSource;
    glLine: TGLLines;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
