object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 458
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 240
    Top = 400
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 0
    OnClick = btn1Click
  end
  object mmo1: TMemo
    Left = 24
    Top = 8
    Width = 513
    Height = 225
    Lines.Strings = (
      'mmo1')
    TabOrder = 1
  end
  object lb1: TListBox
    Left = 560
    Top = 0
    Width = 178
    Height = 458
    Align = alRight
    ItemHeight = 13
    TabOrder = 2
  end
end
