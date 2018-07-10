object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 400
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object spl1: TSplitter
    Left = 185
    Top = 0
    Height = 400
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 400
    Align = alLeft
    TabOrder = 0
    object spl2: TSplitter
      Left = 1
      Top = 121
      Width = 183
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object drwgrd1: TDrawGrid
      Left = 1
      Top = 1
      Width = 183
      Height = 120
      Align = alTop
      TabOrder = 0
    end
    object pnl2: TPanel
      Left = 1
      Top = 124
      Width = 183
      Height = 275
      Align = alClient
      TabOrder = 1
    end
  end
  object edt1: TEdit
    Left = 188
    Top = 0
    Width = 284
    Height = 400
    Align = alClient
    TabOrder = 1
    Text = 'edt1'
  end
end
