object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 543
  ClientWidth = 746
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object grp1: TGroupBox
    Left = 0
    Top = 0
    Width = 746
    Height = 272
    Align = alTop
    Caption = 'TStringGrid'
    TabOrder = 0
    object strngrd1: TStringGrid
      Left = 2
      Top = 15
      Width = 742
      Height = 255
      Align = alClient
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing]
      TabOrder = 0
      OnDrawCell = strngrd1DrawCell
    end
  end
  object grp2: TGroupBox
    Left = 0
    Top = 272
    Width = 746
    Height = 202
    Align = alTop
    Caption = 'TDrawGrid'
    TabOrder = 1
    object drwgrd1: TDrawGrid
      Left = 2
      Top = 15
      Width = 742
      Height = 185
      Align = alClient
      ColCount = 6
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      TabOrder = 0
      OnDrawCell = drwgrd1DrawCell
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 474
    Width = 746
    Height = 69
    Align = alClient
    Caption = 'pnl1'
    TabOrder = 2
    object btn1: TButton
      Left = 192
      Top = 24
      Width = 75
      Height = 25
      Caption = 'btn1'
      TabOrder = 0
      OnClick = btn1Click
    end
  end
end
