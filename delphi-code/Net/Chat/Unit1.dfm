object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 369
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 24
    Top = 240
    Width = 12
    Height = 13
    Caption = #23545
  end
  object lbl2: TLabel
    Left = 200
    Top = 240
    Width = 12
    Height = 13
    Caption = #35828
  end
  object mmo1: TMemo
    Left = 24
    Top = 24
    Width = 361
    Height = 207
    Lines.Strings = (
      'mmo1')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object lst1: TListBox
    Left = 408
    Top = 24
    Width = 121
    Height = 207
    ItemHeight = 13
    TabOrder = 1
  end
  object cbb1: TComboBox
    Left = 42
    Top = 237
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'cbb1'
  end
  object mmo2: TMemo
    Left = 24
    Top = 264
    Width = 505
    Height = 89
    Lines.Strings = (
      'mmo2')
    TabOrder = 3
  end
  object idtcpsrvr1: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    Left = 376
    Top = 56
  end
end
