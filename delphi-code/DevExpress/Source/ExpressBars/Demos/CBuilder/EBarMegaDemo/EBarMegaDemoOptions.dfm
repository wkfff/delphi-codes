object EBarMegaDemoOptionsForm: TEBarMegaDemoOptionsForm
  Left = 298
  Top = 223
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 374
  ClientWidth = 482
  Color = clBtnFace
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object pgOptions: TPageControl
    Left = 8
    Top = 8
    Width = 465
    Height = 327
    ActivePage = tsBars
    TabOrder = 0
    object tsBars: TTabSheet
      Caption = 'Bars'
      ImageIndex = 1
      object gbBackgroundSubMenu: TGroupBox
        Left = 177
        Top = 138
        Width = 273
        Height = 144
        Caption = 'Submenu background'
        TabOrder = 3
        object imSubMenuBackground: TImage
          Left = 2
          Top = 15
          Width = 269
          Height = 127
          Align = alClient
        end
        object btnBkSubMenuLoad: TButton
          Left = 10
          Top = 114
          Width = 41
          Height = 21
          Caption = 'Load'
          TabOrder = 0
          OnClick = btnBkSubMenuLoadClick
        end
        object btnBkSubMenuClear: TButton
          Left = 54
          Top = 114
          Width = 41
          Height = 21
          Caption = 'Clear'
          TabOrder = 1
          OnClick = btnBkSubMenuClearClick
        end
      end
      object gbBackgroundBars: TGroupBox
        Left = 177
        Top = 6
        Width = 273
        Height = 126
        Caption = 'Background'
        TabOrder = 1
        object imBarsBackground: TImage
          Left = 2
          Top = 15
          Width = 269
          Height = 109
          Align = alClient
        end
        object btnBkBarsLoad: TButton
          Left = 10
          Top = 96
          Width = 41
          Height = 21
          Caption = 'Load'
          TabOrder = 0
          OnClick = btnBkBarsLoadClick
        end
        object btnBkBarsClear: TButton
          Left = 54
          Top = 96
          Width = 41
          Height = 21
          Caption = 'Clear'
          TabOrder = 1
          OnClick = btnBkBarsClearClick
        end
      end
      object rgStyle: TRadioGroup
        Left = 8
        Top = 6
        Width = 160
        Height = 126
        Caption = 'Style'
        Items.Strings = (
          '&Standard'
          '&Enhanced'
          '&Flat'
          '&XP'
          '&Office11')
        TabOrder = 0
        OnClick = rgStyleClick
      end
      object gbBarsMiscellaneous: TGroupBox
        Left = 8
        Top = 138
        Width = 160
        Height = 144
        Caption = 'Miscellaneous'
        TabOrder = 2
        object sbFont: TSpeedButton
          Left = 134
          Top = 11
          Width = 21
          Height = 21
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333FFF33FFFFF33333300033000
            00333337773377777333333330333300033333337FF33777F333333330733300
            0333333377FFF777F33333333700000073333333777777773333333333033000
            3333333337FF777F333333333307300033333333377F777F3333333333703007
            33333333377F7773333333333330000333333333337777F33333333333300003
            33333333337777F3333333333337007333333333337777333333333333330033
            3333333333377333333333333333033333333333333733333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
          OnClick = sbFontClick
        end
        object lbFont: TLabel
          Left = 8
          Top = 14
          Width = 22
          Height = 13
          Caption = 'Font'
        end
        object lbFontName: TLabel
          Left = 8
          Top = 31
          Width = 57
          Height = 13
          Caption = 'lbFontName'
        end
        object beMiscellaneous: TBevel
          Left = 8
          Top = 47
          Width = 137
          Height = 5
          Shape = bsBottomLine
        end
        object cbUseF10ForMenu: TCheckBox
          Left = 8
          Top = 58
          Width = 124
          Height = 17
          Caption = 'Use F10 for Menu'
          TabOrder = 0
          OnClick = cbUseF10ForMenuClick
        end
        object cbCanCustomize: TCheckBox
          Left = 8
          Top = 78
          Width = 97
          Height = 17
          Caption = 'Can Customize'
          TabOrder = 1
          OnClick = cbCanCustomizeClick
        end
        object cbSunkenBorder: TCheckBox
          Left = 8
          Top = 98
          Width = 97
          Height = 17
          Caption = 'Sunken Border'
          TabOrder = 2
          OnClick = cbSunkenBorderClick
        end
        object cbAllowReset: TCheckBox
          Left = 8
          Top = 118
          Width = 97
          Height = 17
          Caption = 'Allow Reset'
          TabOrder = 3
          OnClick = cbAllowResetClick
        end
      end
    end
    object tsSideBar: TTabSheet
      Caption = 'Side Bar'
      object gbBackgroundColor: TGroupBox
        Left = 8
        Top = 6
        Width = 154
        Height = 113
        Caption = ' Background Color '
        TabOrder = 0
        object lbBeginColor: TLabel
          Left = 8
          Top = 24
          Width = 52
          Height = 13
          Caption = 'Begin color'
        end
        object lbEndColor: TLabel
          Left = 8
          Top = 44
          Width = 44
          Height = 13
          Caption = 'End color'
        end
        object lbFillStyle: TLabel
          Left = 8
          Top = 68
          Width = 38
          Height = 13
          Caption = 'Fill style'
        end
        object blStep: TLabel
          Left = 8
          Top = 92
          Width = 22
          Height = 13
          Caption = 'Step'
        end
        object pBeginColor: TPanel
          Left = 64
          Top = 20
          Width = 81
          Height = 17
          Color = clGrayText
          TabOrder = 0
          OnClick = pBeginColorClick
        end
        object pEndColor: TPanel
          Tag = 1
          Left = 64
          Top = 40
          Width = 81
          Height = 17
          Color = clGrayText
          TabOrder = 1
          OnClick = pBeginColorClick
        end
        object cbFillStyle: TComboBox
          Left = 64
          Top = 60
          Width = 81
          Height = 21
          Style = csDropDownList
          TabOrder = 2
          OnChange = cbFillStyleChange
          Items.Strings = (
            'Horz'
            'None'
            'Vert')
        end
        object seStep: TSpinEdit
          Left = 64
          Top = 84
          Width = 81
          Height = 22
          TabStop = True
          ParentColor = False
          TabOrder = 3
          OnChange = seStepChange
        end
      end
      object gbBackgroundPicture: TGroupBox
        Left = 321
        Top = 6
        Width = 129
        Height = 283
        Caption = ' Background Picture '
        TabOrder = 5
        object ImSideBarbkPicture: TImage
          Left = 2
          Top = 15
          Width = 125
          Height = 266
          Align = alClient
        end
        object btnLoad: TButton
          Left = 36
          Top = 255
          Width = 41
          Height = 21
          Caption = 'Load'
          TabOrder = 0
          OnClick = btnLoadClick
        end
        object btnClear: TButton
          Left = 80
          Top = 255
          Width = 41
          Height = 21
          Caption = 'Clear'
          TabOrder = 1
          OnClick = btnClearClick
        end
      end
      object gbFonts: TGroupBox
        Left = 173
        Top = 6
        Width = 137
        Height = 113
        Caption = ' Fonts '
        TabOrder = 1
        object beFonts: TBevel
          Left = 2
          Top = 60
          Width = 131
          Height = 8
          Shape = bsTopLine
        end
        object lbItemFontCaption: TLabel
          Left = 4
          Top = 68
          Width = 49
          Height = 13
          Caption = 'Item font:'
        end
        object lbGroupFontCaption: TLabel
          Left = 4
          Top = 16
          Width = 56
          Height = 13
          Caption = 'Group font:'
        end
        object lbGroupFont: TLabel
          Left = 8
          Top = 36
          Width = 59
          Height = 13
          Caption = 'lbGroupFont'
        end
        object lbItemFont: TLabel
          Left = 8
          Top = 88
          Width = 52
          Height = 13
          Caption = 'lbItemFont'
        end
        object spGroupFont: TSpeedButton
          Left = 112
          Top = 36
          Width = 21
          Height = 21
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333FFF33FFFFF33333300033000
            00333337773377777333333330333300033333337FF33777F333333330733300
            0333333377FFF777F33333333700000073333333777777773333333333033000
            3333333337FF777F333333333307300033333333377F777F3333333333703007
            33333333377F7773333333333330000333333333337777F33333333333300003
            33333333337777F3333333333337007333333333337777333333333333330033
            3333333333377333333333333333033333333333333733333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
          OnClick = spGroupFontClick
        end
        object spItemFont: TSpeedButton
          Left = 112
          Top = 88
          Width = 21
          Height = 21
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333FFF33FFFFF33333300033000
            00333337773377777333333330333300033333337FF33777F333333330733300
            0333333377FFF777F33333333700000073333333777777773333333333033000
            3333333337FF777F333333333307300033333333377F777F3333333333703007
            33333333377F7773333333333330000333333333337777F33333333333300003
            33333333337777F3333333333337007333333333337777333333333333330033
            3333333333377333333333333333033333333333333733333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
          OnClick = spItemFontClick
        end
      end
      object gbStyle: TGroupBox
        Left = 172
        Top = 125
        Width = 139
        Height = 76
        Caption = ' Style '
        TabOrder = 3
        object Label7: TLabel
          Left = 8
          Top = 20
          Width = 32
          Height = 13
          Caption = 'Border'
        end
        object Label8: TLabel
          Left = 8
          Top = 48
          Width = 24
          Height = 13
          Caption = 'Paint'
        end
        object cbBorderStyle: TComboBox
          Left = 46
          Top = 16
          Width = 85
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnClick = cbBorderStyleClick
          Items.Strings = (
            'None'
            'Single')
        end
        object cbPaintStyle: TComboBox
          Left = 46
          Top = 44
          Width = 85
          Height = 21
          Style = csDropDownList
          TabOrder = 1
          OnClick = cbPaintStyleClick
          Items.Strings = (
            'Flat'
            'Standard')
        end
      end
      object gbMiscellaneous: TGroupBox
        Left = 172
        Top = 207
        Width = 139
        Height = 82
        Caption = 'Miscellaneous'
        TabOrder = 4
        object cbCanSelected: TCheckBox
          Left = 8
          Top = 18
          Width = 105
          Height = 17
          Caption = 'Show Selected'
          TabOrder = 0
          OnClick = cbCanSelectedClick
        end
        object cbShowGroups: TCheckBox
          Left = 8
          Top = 42
          Width = 85
          Height = 17
          Caption = 'Show Groups'
          TabOrder = 1
          OnClick = cbShowGroupsClick
        end
      end
      object gbSideBarPopupmenu: TGroupBox
        Left = 8
        Top = 125
        Width = 154
        Height = 164
        Caption = 'Popup menu - visible items'
        TabOrder = 2
        object cbIconType: TCheckBox
          Left = 8
          Top = 18
          Width = 73
          Height = 17
          Caption = 'Icon Type'
          TabOrder = 0
          OnClick = cbSBPopupMenuClick
        end
        object cbAddGroup: TCheckBox
          Tag = 1
          Left = 8
          Top = 38
          Width = 73
          Height = 17
          Caption = 'Add Group'
          TabOrder = 1
          OnClick = cbSBPopupMenuClick
        end
        object cbRemoveGroup: TCheckBox
          Tag = 2
          Left = 8
          Top = 58
          Width = 97
          Height = 17
          Caption = 'Remove Group'
          TabOrder = 2
          OnClick = cbSBPopupMenuClick
        end
        object cbCustomize: TCheckBox
          Tag = 3
          Left = 8
          Top = 78
          Width = 73
          Height = 17
          Caption = 'Customize'
          TabOrder = 3
          OnClick = cbSBPopupMenuClick
        end
        object cbRenameGroup: TCheckBox
          Tag = 4
          Left = 8
          Top = 98
          Width = 89
          Height = 17
          Caption = 'Rename Group'
          TabOrder = 4
          OnClick = cbSBPopupMenuClick
        end
        object cbRenameItem: TCheckBox
          Tag = 5
          Left = 8
          Top = 118
          Width = 81
          Height = 17
          Caption = 'Rename Item'
          TabOrder = 5
          OnClick = cbSBPopupMenuClick
        end
        object cbRemoveItem: TCheckBox
          Tag = 6
          Left = 8
          Top = 138
          Width = 81
          Height = 17
          Caption = 'Remove Item'
          TabOrder = 6
          OnClick = cbSBPopupMenuClick
        end
      end
    end
  end
  object btnClose: TButton
    Left = 369
    Top = 341
    Width = 105
    Height = 25
    Cancel = True
    Caption = 'Close'
    TabOrder = 1
    OnClick = btnCloseClick
  end
  object ColorDialog: TColorDialog
    Ctl3D = True
    Left = 10
    Top = 330
  end
  object OpenPictureDialog: TOpenPictureDialog
    Filter = 
      'All (*.bmp;*.ico;*.emf;*.wmf)|*.bmp;*.ico;*.emf;*.wmf|Bitmaps (*' +
      '.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf' +
      '|Metafiles (*.wmf)|*.wmf'
    Left = 36
    Top = 388
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 68
    Top = 388
  end
end
