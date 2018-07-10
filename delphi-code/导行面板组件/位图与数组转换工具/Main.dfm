object FrmMain: TFrmMain
  Left = 269
  Top = 193
  Width = 693
  Height = 357
  Caption = #20301#22270#19982#25968#32452#36716#25442#24037#20855
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 380
    Top = 0
    Width = 305
    Height = 323
    Align = alRight
    Caption = #25968#32452#26174#31034#21306
    TabOrder = 0
    object Memo1: TMemo
      Left = 2
      Top = 44
      Width = 301
      Height = 277
      Align = alClient
      BevelKind = bkFlat
      BorderStyle = bsNone
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object CoolBar1: TCoolBar
      Left = 2
      Top = 15
      Width = 301
      Height = 29
      AutoSize = True
      Bands = <
        item
          Control = ToolBar1
          ImageIndex = -1
          Width = 297
        end>
      object ToolBar1: TToolBar
        Left = 9
        Top = 0
        Width = 284
        Height = 25
        Caption = 'ToolBar1'
        Flat = True
        TabOrder = 0
        object ToolButton3: TToolButton
          Left = 0
          Top = 0
          Caption = 'ToolButton3'
          ImageIndex = 0
          OnClick = ToolButton3Click
        end
        object ToolButton4: TToolButton
          Left = 23
          Top = 0
          Caption = 'ToolButton4'
          ImageIndex = 1
          OnClick = ToolButton4Click
        end
        object ToolButton5: TToolButton
          Left = 46
          Top = 0
          Caption = 'ToolButton5'
          ImageIndex = 2
          OnClick = ToolButton5Click
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 312
    Top = 0
    Width = 68
    Height = 323
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object SpeedButton1: TSpeedButton
      Left = 9
      Top = 72
      Width = 49
      Height = 22
      Caption = '>>'
      Flat = True
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 9
      Top = 120
      Width = 49
      Height = 22
      Caption = '<<'
      Flat = True
      OnClick = SpeedButton2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 312
    Height = 323
    Align = alClient
    Caption = #20301#22270#26174#31034#21306
    TabOrder = 2
    object CoolBar2: TCoolBar
      Left = 2
      Top = 15
      Width = 308
      Height = 29
      AutoSize = True
      Bands = <
        item
          Control = ToolBar2
          ImageIndex = -1
          Width = 304
        end>
      object ToolBar2: TToolBar
        Left = 9
        Top = 0
        Width = 291
        Height = 25
        Caption = 'ToolBar2'
        Flat = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Caption = 'ToolButton1'
          ImageIndex = 0
          OnClick = ToolButton1Click
        end
        object ToolButton2: TToolButton
          Left = 23
          Top = 0
          Caption = 'ToolButton2'
          ImageIndex = 1
          OnClick = ToolButton2Click
        end
      end
    end
    object ScrollBox1: TScrollBox
      Left = 2
      Top = 44
      Width = 308
      Height = 277
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      ParentColor = False
      TabOrder = 1
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 304
        Height = 273
        AutoSize = True
        Stretch = True
      end
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 152
    Top = 88
  end
  object SaveDialog1: TSaveDialog
    Filter = 'txt(*.txt)|*.txt'
    Left = 476
    Top = 80
  end
  object OpenDialog1: TOpenDialog
    Filter = 'txt(*.txt)|*.txt'
    Left = 476
    Top = 152
  end
end
