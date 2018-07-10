object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'RGB'#36716#21313#20845#36827#21046
  ClientHeight = 247
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 32
    Top = 21
    Width = 7
    Height = 13
    Caption = 'R'
  end
  object lbl2: TLabel
    Left = 32
    Top = 48
    Width = 7
    Height = 13
    Caption = 'G'
  end
  object lbl3: TLabel
    Left = 32
    Top = 72
    Width = 6
    Height = 13
    Caption = 'B'
  end
  object edt1: TEdit
    Left = 200
    Top = 18
    Width = 257
    Height = 75
    TabOrder = 0
  end
  object edtR: TEdit
    Left = 54
    Top = 18
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object edtG: TEdit
    Left = 54
    Top = 45
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object edtB: TEdit
    Left = 54
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object btn1: TButton
    Left = 80
    Top = 120
    Width = 75
    Height = 25
    Caption = #36716#25442
    TabOrder = 4
    OnClick = btn1Click
  end
end
