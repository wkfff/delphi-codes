object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 247
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnMouseMove = FormMouseMove
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 216
    Top = 136
    Width = 16
    Height = 13
    Caption = 'lbl1'
  end
  object mmo1: TMemo
    Left = 160
    Top = 64
    Width = 185
    Height = 19
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'mmo1')
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
  object btn1: TButton
    Left = 248
    Top = 184
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 1
    OnClick = btn1Click
  end
end
