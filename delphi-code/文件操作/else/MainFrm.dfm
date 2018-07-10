object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 581
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
  object mmoFileContent: TMemo
    Left = 0
    Top = 0
    Width = 738
    Height = 105
    Align = alTop
    Lines.Strings = (
      '')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object grpDir: TGroupBox
    Left = 536
    Top = 159
    Width = 194
    Height = 216
    Caption = #25991#20214#21644#36335#24452#25805#20316
    TabOrder = 1
  end
  object grpFile: TGroupBox
    Left = 8
    Top = 120
    Width = 313
    Height = 187
    Caption = #25991#20214#35835#20889
    TabOrder = 2
    object btnShow: TButton
      Left = 81
      Top = 25
      Width = 67
      Height = 32
      Caption = #35835#21462
      TabOrder = 0
      OnClick = btnShowClick
    end
    object btnChoose: TButton
      Left = 10
      Top = 25
      Width = 65
      Height = 32
      Caption = #36873#25321
      TabOrder = 1
      OnClick = btnChooseClick
    end
  end
  object grpFileName: TGroupBox
    Left = 328
    Top = 159
    Width = 161
    Height = 216
    Caption = #25991#20214#21517#25805#20316
    TabOrder = 3
  end
  object dlgOpen: TOpenDialog
    Left = 16
    Top = 496
  end
end
