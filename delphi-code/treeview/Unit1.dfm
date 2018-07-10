object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 411
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object tv1: TGSPTreeView
    Left = 56
    Top = 24
    Width = 161
    Height = 305
    Indent = 19
    TabOrder = 0
  end
  object btn1: TButton
    Left = 264
    Top = 360
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 1
    OnClick = btn1Click
  end
  object RichTreeView1: TRichTreeView
    Left = 312
    Top = 24
    Width = 257
    Height = 305
    Ctl3D = True
    Indent = 19
    ParentCtl3D = False
    TabOrder = 2
    Checkboxes = True
    OnStateChanged = RichTreeView1StateChanged
  end
end
