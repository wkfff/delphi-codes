object StocksMainForm: TStocksMainForm
  Left = 105
  Top = 79
  Width = 885
  Height = 663
  Caption = 'StocksMainForm'
  Color = clBtnFace
  Menu = mnuMain
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxSpreadBook: TcxSpreadSheetBook
    Left = 0
    Top = 54
    Width = 877
    Height = 514
    Align = alClient
    DefaultStyle.Brush.BackgroundColor = 57
    DefaultStyle.Brush.ForegroundColor = 57
    DefaultStyle.Font.Name = 'MS Sans Serif'
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    OnSetSelection = cxSpreadBookSetSelection
    OnSheetPopupMenu = cxSpreadBookSheetPopupMenu
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 877
    Height = 29
    Caption = 'ToolBar1'
    Images = imgStandart
    TabOrder = 1
    object ToolBar3: TToolBar
      Left = 0
      Top = 2
      Width = 105
      Height = 22
      AutoSize = True
      Caption = 'ToolBar3'
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      Images = imgStandart
      TabOrder = 0
      object ToolButton7: TToolButton
        Left = 0
        Top = 0
        Action = actSaveSpeadSheet
      end
      object ToolButton11: TToolButton
        Left = 23
        Top = 0
        Width = 4
        Caption = 'ToolButton11'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object ToolButton8: TToolButton
        Left = 27
        Top = 0
        Action = actCut
      end
      object ToolButton9: TToolButton
        Left = 50
        Top = 0
        Action = actCopy
      end
      object ToolButton10: TToolButton
        Left = 73
        Top = 0
        Action = actPaste
      end
    end
  end
  object pnCells: TPanel
    Left = 0
    Top = 29
    Width = 877
    Height = 25
    Align = alTop
    Caption = 'pnCells'
    TabOrder = 2
    object edtCellEdit: TEdit
      Left = 127
      Top = 2
      Width = 748
      Height = 20
      TabStop = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      TabOrder = 0
      Text = 'edtCellEdit'
      OnChange = edtCellEditChange
      OnExit = edtCellEditExit
      OnKeyPress = edtCellEditKeyPress
    end
    object pnCellText: TPanel
      Left = 66
      Top = 2
      Width = 61
      Height = 20
      Alignment = taRightJustify
      BevelOuter = bvNone
      Caption = 'Cell text = '
      TabOrder = 1
    end
    object pnCellsRect: TPanel
      Left = 3
      Top = 2
      Width = 66
      Height = 20
      BevelInner = bvLowered
      BevelOuter = bvNone
      Caption = 'A1'
      Color = clBtnHighlight
      TabOrder = 2
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 568
    Width = 877
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 105
      Height = 25
      Action = actLoadData
      TabOrder = 0
    end
    object Button2: TButton
      Left = 120
      Top = 8
      Width = 105
      Height = 25
      Action = actApplyFormatting
      TabOrder = 1
    end
    object Button4: TButton
      Left = 791
      Top = 8
      Width = 75
      Height = 25
      Action = actExit
      Anchors = [akTop, akRight]
      TabOrder = 2
    end
    object Button3: TButton
      Left = 232
      Top = 8
      Width = 105
      Height = 25
      Action = actSaveSpeadSheet
      TabOrder = 3
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Spreadsheet files (*.xls)|*.xls'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 144
    Top = 121
  end
  object Query: TQuery
    DatabaseName = 'DBDEMOS'
    Constrained = True
    SQL.Strings = (
      
        'select CO_NAME, SHARES, CUR_PRICE, YRL_HIGH, YRL_LOW, PUR_PRICE,' +
        ' PUR_DATE'
      'from holdings.dbf h, master.DBF m'
      'WHERE m.SYMBOL = h.SYMBOL')
    Left = 112
    Top = 120
  end
  object imgStandart: TImageList
    Left = 232
    Top = 121
    Bitmap = {
      494C010106000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000000000000000000000000000000000000000
      0000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0080000000000000000000000080808000008080008080
      8000008080008080800080000000FFFFFF008000000080000000800000008000
      00008000000080000000FFFFFF00800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000000000000000000000808000808080000080
      8000808080000080800080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0080000000000000000000000080808000008080008080
      8000008080008080800080000000FFFFFF00800000008000000080000000FFFF
      FF00800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000000000000000000000808000808080000080
      8000808080000080800080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080000000FFFFFF0080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000FFFFFF000000000000000000FFFFFF008000
      0000800000008000000080000000000000000000000080808000008080008080
      8000008080008080800080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008000
      0000FFFFFF008000000000000000000000000000000000808000808080000080
      8000808080000080800080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008000
      0000800000000000000000000000000000000000000080808000008080008080
      8000008080008080800000808000808080000080800080808000008080008080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000080000000800000008000000080000000800000008000
      0000000000000000000000000000000000000000000000808000808080000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000808000808080000080
      80000000000000FFFF00000000000000000000FFFF0000000000808080000080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000000000000000008000
      0000000000000000000080000000000000000000000080000000800000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000000000000000008000
      0000000000000000000080000000000000008000000000000000000000008000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000000000000000008000
      0000000000000000000080000000000000008000000000000000000000008000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000000000000000000000
      0000800000008000000080000000000000008000000000000000000000008000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000080000000000000008000000080000000800000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000080000000000000008000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFF00000000FFFFFFFF00000000
      FC01FC0000000000FC01800000000000FC010000000000000001000000000000
      0001000000000000000100010000000000010003000000000003000300000000
      0007000300000000000F00030000000000FF0FC30000000001FF000300000000
      03FF800700000000FFFFF87F00000000FFFFFFFFFFFFFFFFFFFFFFFFC001F3FF
      C007001F8031ED9FC007000F8031ED6FC00700078031ED6FC00700038001F16F
      C00700018001FD1FC00700008001FC7FC007001F8FF1FEFFC007001F8FF1FC7F
      C007001F8FF1FD7FC0078FF18FF1F93FC00FFFF98FF1FBBFC01FFF758FF5FBBF
      C03FFF8F8001FBBFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object alMain: TActionList
    Images = imgStandart
    Left = 176
    Top = 120
    object actDeleteCells: TAction
      Category = 'Cells'
      Caption = 'Delete...'
      OnExecute = actCellsExecute
      OnUpdate = AlwaysEnabled
    end
    object actSaveSpeadSheet: TAction
      Category = 'File'
      Caption = '&Save SpeadSheet'
      ImageIndex = 2
      ShortCut = 16467
      OnExecute = actSaveSpeadSheetExecute
      OnUpdate = actSaveSpeadSheetUpdate
    end
    object actInsertCells: TAction
      Tag = 1
      Category = 'Cells'
      Caption = 'Insert...'
      OnExecute = actCellsExecute
      OnUpdate = AlwaysEnabled
    end
    object actExit: TAction
      Category = 'File'
      Caption = 'E&xit'
      ShortCut = 32856
      OnExecute = actExitExecute
      OnUpdate = AlwaysEnabled
    end
    object actCut: TAction
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut'
      ImageIndex = 3
      ShortCut = 16472
      OnExecute = actCutExecute
      OnUpdate = AlwaysEnabled
    end
    object actCopy: TAction
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy'
      ImageIndex = 4
      ShortCut = 16451
      OnExecute = actCopyExecute
      OnUpdate = AlwaysEnabled
    end
    object actPaste: TAction
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste'
      ImageIndex = 5
      ShortCut = 16470
      OnExecute = actPasteExecute
      OnUpdate = AlwaysEnabled
    end
    object actFormatCells: TAction
      Category = 'Cells'
      Caption = 'Format Cells...'
      OnExecute = actFormatCellsExecute
      OnUpdate = AlwaysEnabled
    end
    object actHideCells: TAction
      Category = 'Cells'
      Caption = 'Hide'
      OnExecute = actHideCellsExecute
      OnUpdate = AlwaysEnabled
    end
    object actShowCells: TAction
      Category = 'Cells'
      Caption = 'Show'
      OnExecute = actShowCellsExecute
      OnUpdate = AlwaysEnabled
    end
    object actHideCol: TAction
      Category = 'Cols'
      Caption = 'Hide'
      OnExecute = actHideColExecute
      OnUpdate = AlwaysEnabled
    end
    object actShowCol: TAction
      Category = 'Cols'
      Caption = 'Show'
      OnExecute = actShowColExecute
      OnUpdate = AlwaysEnabled
    end
    object actHideRow: TAction
      Category = 'Rows'
      Caption = 'Hide'
      OnExecute = actHideRowExecute
      OnUpdate = AlwaysEnabled
    end
    object actShowRow: TAction
      Category = 'Rows'
      Caption = 'Show'
      OnExecute = actShowRowExecute
      OnUpdate = AlwaysEnabled
    end
    object actApplyFormatting: TAction
      Category = 'Configuration'
      Caption = 'A&pply Formatting'
      OnExecute = actApplyFormattingExecute
      OnUpdate = actApplyFormattingUpdate
    end
    object actLoadData: TAction
      Category = 'File'
      Caption = '&Load Data'
      OnExecute = actLoadDataExecute
      OnUpdate = AlwaysEnabled
    end
    object actMergeCells: TAction
      Category = 'Merge'
      Caption = 'Merge cells'
      OnExecute = actMergeCellsExecute
      OnUpdate = AlwaysEnabled
    end
    object actSplitCells: TAction
      Category = 'Merge'
      Caption = 'Split cells'
      OnExecute = actSplitCellsExecute
      OnUpdate = AlwaysEnabled
    end
  end
  object pmSheetPopup: TPopupMenu
    Images = imgStandart
    Left = 264
    Top = 121
    object pmiCut: TMenuItem
      Tag = 3
      Action = actCut
    end
    object pmiCopy: TMenuItem
      Tag = 2
      Action = actCopy
    end
    object pmiPaste: TMenuItem
      Tag = 4
      Action = actPaste
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object actMerge1: TMenuItem
      Action = actMergeCells
    end
    object actSplitCells1: TMenuItem
      Action = actSplitCells
    end
    object MenuItem1: TMenuItem
      Caption = '-'
    end
    object pmiDelete: TMenuItem
      Tag = 12
      Action = actDeleteCells
    end
    object pmiInsert: TMenuItem
      Tag = 13
      Action = actInsertCells
    end
    object MenuItem2: TMenuItem
      Caption = '-'
    end
    object pmiCols: TMenuItem
      Caption = 'Cols'
      object pmiColsHide: TMenuItem
        Tag = 8
        Action = actHideCells
      end
      object pmiColsShow: TMenuItem
        Tag = 9
        Action = actShowCells
      end
    end
    object pmiRows: TMenuItem
      Caption = 'Rows'
      object pmiRowsHide: TMenuItem
        Tag = 10
        Action = actHideCells
      end
      object pmiRowsShow: TMenuItem
        Tag = 11
        Action = actShowCells
      end
    end
    object MenuItem3: TMenuItem
      Action = actShowCells
    end
    object MenuItem4: TMenuItem
      Action = actHideCells
    end
    object pmiFormatCells: TMenuItem
      Tag = 5
      Action = actFormatCells
    end
  end
  object mnuMain: TMainMenu
    Images = imgStandart
    Left = 300
    Top = 121
    object mnuFile: TMenuItem
      Caption = '&File'
      object miSaveSpreadSheet: TMenuItem
        Tag = 2
        Action = actSaveSpeadSheet
      end
      object LoadData1: TMenuItem
        Action = actLoadData
      end
      object MenuItem6: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Tag = 4
        Action = actExit
      end
    end
    object mnuEdit: TMenuItem
      Caption = '&Edit'
      object miCut: TMenuItem
        Tag = 3
        Action = actCut
      end
      object miCopy: TMenuItem
        Tag = 2
        Action = actCopy
      end
      object miPaste: TMenuItem
        Tag = 4
        Action = actPaste
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object miCells: TMenuItem
        Caption = 'C&ells'
        object miFormat: TMenuItem
          Tag = 5
          Action = actFormatCells
        end
        object miHide: TMenuItem
          Tag = 6
          Action = actHideCells
        end
        object miShow: TMenuItem
          Tag = 7
          Action = actShowCells
        end
        object miDeletecells: TMenuItem
          Tag = 12
          Action = actDeleteCells
        end
        object Insertcells1: TMenuItem
          Tag = 13
          Action = actInsertCells
        end
      end
      object miColumns: TMenuItem
        Caption = 'C&olumns'
        object MenuItem7: TMenuItem
          Tag = 8
          Action = actHideCol
        end
        object MenuItem8: TMenuItem
          Tag = 9
          Action = actShowCol
        end
      end
      object miRows: TMenuItem
        Caption = 'Ro&ws'
        object Hide3: TMenuItem
          Tag = 10
          Action = actHideRow
        end
        object Show3: TMenuItem
          Tag = 11
          Action = actShowRow
        end
      end
    end
    object mnuConfig: TMenuItem
      Caption = '&Configuration'
      object ApplyFormatting1: TMenuItem
        Action = actApplyFormatting
      end
    end
  end
end
