object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 455
  ClientWidth = 725
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object glViewer: TGLSceneViewer
    Left = 0
    Top = 0
    Width = 725
    Height = 455
    Camera = glCamera
    FieldOfView = 155.209182739257800000
    Align = alClient
  end
  object glScene: TGLScene
    Left = 24
    Top = 16
    object glCube: TGLCube
      ShowAxes = True
    end
    object gLight: TGLLightSource
      ConstAttenuation = 1.000000000000000000
      Position.Coordinates = {0000803F00004040000000400000803F}
      SpotCutOff = 180.000000000000000000
    end
    object glLine: TGLLines
      ShowAxes = True
      LineColor.Color = {EBE0E03EE4DB5B3F9A93133F0000803F}
      LineWidth = 4.000000000000000000
      Nodes = <
        item
        end
        item
          X = 1.000000000000000000
          Y = 2.000000000000000000
          Z = 3.000000000000000000
        end
        item
          Y = 1.000000000000000000
          Z = 3.000000000000000000
        end
        item
          X = 1.000000000000000000
          Y = 1.000000000000000000
          Z = 1.000000000000000000
        end
        item
          X = 3.000000000000000000
          Y = 4.000000000000000000
          Z = 6.000000000000000000
        end>
      NodesAspect = lnaCube
      NodeSize = 0.100000001490116100
      Options = []
    end
    object glCamera: TGLCamera
      DepthOfView = 100.000000000000000000
      FocalLength = 50.000000000000000000
      TargetObject = glCube
      Position.Coordinates = {0000803F0000803F0000803F0000803F}
    end
  end
end
