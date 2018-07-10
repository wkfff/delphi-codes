object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 370
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 8
    Top = 0
    Width = 464
    Height = 321
    Lines.Strings = (
      'mmo1')
    TabOrder = 0
  end
  object btn1: TButton
    Left = 192
    Top = 337
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 1
    OnClick = btn1Click
  end
  object IdFTP1: TIdFTP
    MaxLineAction = maException
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 64
    Top = 32
  end
end
