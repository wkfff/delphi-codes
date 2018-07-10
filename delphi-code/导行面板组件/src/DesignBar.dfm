object FrmDesignBar: TFrmDesignBar
  Left = 360
  Top = 200
  Width = 461
  Height = 325
  Caption = 'MRNavBar'#23646#24615#32534#36753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 320
    Height = 291
    Align = alClient
    Caption = #32452#21015#34920
    TabOrder = 0
    object TreeView1: TTreeView
      Left = 2
      Top = 15
      Width = 316
      Height = 274
      Align = alClient
      BevelKind = bkFlat
      BorderStyle = bsNone
      Indent = 19
      PopupMenu = PopupMenu1
      ReadOnly = True
      TabOrder = 0
      OnClick = TreeView1Click
      OnEdited = TreeView1Edited
    end
  end
  object GroupBox2: TGroupBox
    Left = 320
    Top = 0
    Width = 133
    Height = 291
    Align = alRight
    Caption = #25805#20316
    TabOrder = 1
    object SpeedButton1: TSpeedButton
      Left = 34
      Top = 40
      Width = 65
      Height = 22
      Caption = #28155#21152#32452
      Flat = True
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 34
      Top = 72
      Width = 65
      Height = 22
      Caption = #28155#21152#39033
      Flat = True
      OnClick = SpeedButton2Click
    end
    object SpeedButton3: TSpeedButton
      Left = 34
      Top = 104
      Width = 65
      Height = 22
      Caption = #21024#38500
      Flat = True
      OnClick = SpeedButton3Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 120
    Top = 120
    object N1: TMenuItem
      Caption = #28155#21152#32452
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #28155#21152#39033
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #21024#38500
      OnClick = N3Click
    end
  end
end
