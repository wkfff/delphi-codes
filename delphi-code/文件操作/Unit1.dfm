object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 473
  ClientWidth = 726
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
    Left = 32
    Top = 8
    Width = 241
    Height = 209
    Lines.Strings = (
      'mmo1')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object mmo2: TMemo
    Left = 376
    Top = 16
    Width = 297
    Height = 201
    Lines.Strings = (
      'mmo2')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object btn1: TButton
    Left = 168
    Top = 408
    Width = 75
    Height = 25
    Caption = 'file'
    TabOrder = 2
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 448
    Top = 408
    Width = 75
    Height = 25
    Caption = 'dir'
    TabOrder = 3
  end
  object fllst1: TFileListBox
    Left = 32
    Top = 240
    Width = 217
    Height = 154
    FileType = [ftDirectory, ftNormal]
    ItemHeight = 13
    TabOrder = 4
  end
  object dirlst1: TDirectoryListBox
    Left = 424
    Top = 223
    Width = 209
    Height = 179
    ItemHeight = 16
    TabOrder = 5
  end
  object btn3: TButton
    Left = 304
    Top = 392
    Width = 75
    Height = 25
    Caption = 'btn3'
    TabOrder = 6
    OnClick = btn3Click
  end
  object dlgOpen1: TOpenDialog
    Left = 672
    Top = 368
  end
end
