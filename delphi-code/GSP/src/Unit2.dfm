object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #28165#38500'ProjData.GSP'#37325#22797#25968#25454
  ClientHeight = 197
  ClientWidth = 336
  Color = clSkyBlue
  TransparentColorValue = clTeal
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btn2: TButton
    Left = 96
    Top = 56
    Width = 161
    Height = 41
    Caption = #20462#22797'ProjData.GSP'#25991#20214
    Default = True
    TabOrder = 0
    OnClick = btn2Click
  end
  object pb1: TProgressBar
    Left = 207
    Top = 103
    Width = 93
    Height = 33
    Align = alCustom
    TabOrder = 1
  end
  object stat1: TStatusBar
    Left = 0
    Top = 178
    Width = 336
    Height = 19
    Panels = <
      item
        Text = #25552#31034#65306
        Width = 150
      end
      item
        Text = #36827#24230
        Width = 30
      end
      item
        Style = psOwnerDraw
        Width = 150
      end>
    OnDrawPanel = stat1DrawPanel
  end
  object btn1: TButton
    Left = 136
    Top = 104
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 3
    OnClick = btn1Click
  end
end
