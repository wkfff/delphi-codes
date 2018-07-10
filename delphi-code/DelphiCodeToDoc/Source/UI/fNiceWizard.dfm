object NiceWizardForm: TNiceWizardForm
  Left = 192
  Top = 107
  ActiveControl = CheckBox_AlphaSortMembers
  BorderStyle = bsDialog
  Caption = 'New Project Wizard'
  ClientHeight = 507
  ClientWidth = 762
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object JvWizard1: TJvWizard
    Left = 0
    Top = 0
    Width = 762
    Height = 507
    ActivePage = JvWizardOutputFormat
    ButtonBarHeight = 42
    ButtonStart.Caption = 'To &Start Page'
    ButtonStart.NumGlyphs = 1
    ButtonStart.Width = 85
    ButtonLast.Caption = 'To &Last Page'
    ButtonLast.NumGlyphs = 1
    ButtonLast.Width = 85
    ButtonBack.Caption = '< &Back'
    ButtonBack.NumGlyphs = 1
    ButtonBack.Width = 75
    ButtonNext.Caption = '&Next >'
    ButtonNext.NumGlyphs = 1
    ButtonNext.Width = 75
    ButtonFinish.Caption = '&Finish'
    ButtonFinish.NumGlyphs = 1
    ButtonFinish.ModalResult = 1
    ButtonFinish.Width = 75
    ButtonCancel.Caption = 'Cancel'
    ButtonCancel.NumGlyphs = 1
    ButtonCancel.ModalResult = 2
    ButtonCancel.Width = 75
    ButtonHelp.Caption = '&Help'
    ButtonHelp.NumGlyphs = 1
    ButtonHelp.Width = 75
    ShowRouteMap = True
    OnFinishButtonClick = JvWizard1FinishButtonClick
    DesignSize = (
      762
      507)
    object JvWizardWelcome: TJvWizardWelcomePage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Welcome'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 
        'Welcome to the new project wizard. It will helps you to create a' +
        ' new project step by step.'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel, bkHelp]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      WaterMark.Visible = False
      object JvStaticText8: TJvStaticText
        Left = 8
        Top = 120
        Width = 397
        Height = 17
        Caption = 
          'Press the "Next" button and fill all screens with your informati' +
          'ons about your project.'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 0
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = False
      end
    end
    object JvWizardDescription: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Description'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Describe your project'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel, bkHelp]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      object JvStaticText1: TJvStaticText
        Left = 6
        Top = 82
        Width = 592
        Height = 32
        AutoSize = False
        Caption = 
          'Enter the project name below. This name is the base filename and' +
          ' is used for the title of the documentation. Try something very ' +
          'short, a single word is the best solution'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 2
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = True
      end
      object JvStaticText3: TJvStaticText
        Left = 6
        Top = 202
        Width = 594
        Height = 32
        AutoSize = False
        Caption = 
          'Enter the project summary below. The summary is display in the f' +
          'irst page of the documentation. Try to explain in few words what' +
          ' is your project.'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 1
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = True
      end
      object JvStaticText4: TJvStaticText
        Left = 6
        Top = 266
        Width = 594
        Height = 32
        AutoSize = False
        Caption = 
          'Enter the project description below. It is display in the first ' +
          'page of the documentation. Try to explain in few lines what the ' +
          'project is doing and why.'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 7
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = True
      end
      object Edit_ProjectName: TJvEdit
        Left = 6
        Top = 120
        Width = 337
        Height = 21
        AutoSize = False
        TabOrder = 0
      end
      object JvStaticText2: TJvStaticText
        Left = 6
        Top = 153
        Width = 593
        Height = 17
        AutoSize = False
        Caption = 
          'Enter the author of the documentation. If there is multiple auth' +
          'or, list all authors in a single line.'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 3
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = True
      end
      object Edit_Authors: TJvEdit
        Left = 6
        Top = 168
        Width = 337
        Height = 21
        AutoSize = False
        TabOrder = 4
      end
      object Edit_ProjectSummary: TJvEdit
        Left = 6
        Top = 232
        Width = 593
        Height = 21
        AutoSize = False
        TabOrder = 5
        OnChange = Edit_ProjectSummaryChange
      end
      object Memo_ProjectDescription: TJvMemo
        Left = 6
        Top = 296
        Width = 593
        Height = 57
        ScrollBars = ssVertical
        TabOrder = 6
      end
      object JvStaticText16: TJvStaticText
        Left = 6
        Top = 367
        Width = 594
        Height = 32
        AutoSize = False
        Caption = 
          'Enter the copyright line that will be displayed in the bottom on' +
          ' each page of the documentation. You can add HTML tag if you wan' +
          't.'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 8
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = True
      end
      object JvEdit_Copyright: TJvEdit
        Left = 6
        Top = 399
        Width = 595
        Height = 21
        AutoSize = False
        TabOrder = 9
      end
    end
    object JvWizardFiles: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Files'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Add source files to the project'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel, bkHelp]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      object JvStaticText5: TJvStaticText
        Left = 6
        Top = 157
        Width = 577
        Height = 25
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = 'List items to include or exclude'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlCenter
        TabOrder = 1
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = False
      end
      object Edit_Path: TJvEdit
        Left = 6
        Top = 183
        Width = 577
        Height = 21
        TabOrder = 4
      end
      object JvPageControl1: TJvPageControl
        Left = 6
        Top = 217
        Width = 585
        Height = 209
        ActivePage = tsIncludeList
        HotTrack = True
        TabOrder = 7
        OnChange = JvPageControl1Change
        object tsIncludeList: TTabSheet
          Caption = 'Include List'
          object ListBoxIncludePath: TJvListBox
            Left = 0
            Top = 0
            Width = 577
            Height = 181
            Align = alClient
            ItemHeight = 13
            Background.FillMode = bfmTile
            Background.Visible = False
            TabOrder = 0
          end
        end
        object tsExcludeList: TTabSheet
          Caption = 'Exclude List'
          ImageIndex = 1
          object ListBoxExcludePath: TJvListBox
            Left = 0
            Top = 0
            Width = 577
            Height = 181
            Align = alClient
            DragMode = dmAutomatic
            ItemHeight = 13
            Background.FillMode = bfmTile
            Background.Visible = False
            TabOrder = 0
          end
        end
      end
      object btnAdd: TJvBitBtn
        Left = 512
        Top = 210
        Width = 25
        Height = 25
        Hint = 'Add item to current list'
        DoubleBuffered = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000750A0000750A00000001000000000000000000002525
          250056575700595E5C002A302E00ACACAC007D7D7D00FFFFFF00FFE7FA00FFE2
          EE00AAA5A4001A1F1F0094969500FFF3FF00FFD6E200FFD8D700FFE8E800E8CE
          CE00080C0C00585A5A0053484B00DABDCF00FFE4F900FFE6E500E5B5B5006B61
          6300606969005B4E5100BC9E9C00B991A00089738500AB9AA70079646800D2C0
          C000C9867400A8696B003B42420091828800FFF1FF0002B73E0059B471008E83
          8A005A605D00C3A3B400FFCDCB00FFC9C900646161004A4B4B004B564C00C9B3
          BA0028DD5A00067A29009598940095919800634D4D00FFBABA00B3A8A8002023
          23001B80390053FF880050FF7C0000E04B0000BE36007D646A00FFB7BF00666B
          6B00AD848400747B7B00091F12003A47400000B439003BA24500D6938700B76A
          7100FF96A20061555400B57C7C00151C1C0000B931004DA15100FFD2E3002E26
          25008A615F00FD9191002233330014191800474949004E535300353F3F000000
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
          0000000000000000000000000000003333333333000000000000000000000033
          27274E3300000000000000000000003327274E33000000000000000000000033
          2727273300000000000000000000003327272733000000000000333333333333
          32272733333333333300333C3C3C3C3C3232272727274E4E3300333B3C3C3C3C
          3C323227272727273300333B3B3C3C3C3C3C3232272727273300333333333333
          3C3C3C333333333333000000000000333C3C3C33000000000000000000000033
          3C3C3C330000000000000000000000333B3C3C33000000000000000000000033
          3B3B3C3300000000000000000000003333333333000000000000}
        ParentDoubleBuffered = False
        TabOrder = 5
        OnClick = btnAddClick
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object btnReplace: TJvBitBtn
        Left = 536
        Top = 210
        Width = 25
        Height = 25
        Hint = 'Modify selected item'
        DoubleBuffered = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
          33333333333F8888883F33330000324334222222443333388F3833333388F333
          000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
          F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
          223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
          3338888300003AAAAAAA33333333333888888833333333330000333333333333
          333333333333333333FFFFFF000033333333333344444433FFFF333333888888
          00003A444333333A22222438888F333338F3333800003A2243333333A2222438
          F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
          22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
          33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
          3333333333338888883333330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        ParentDoubleBuffered = False
        TabOrder = 6
        OnClick = btnReplaceClick
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object btnDelete: TJvBitBtn
        Left = 560
        Top = 210
        Width = 25
        Height = 25
        Hint = 'Delete selected item'
        DoubleBuffered = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033338833333333333333333F333333333333
          0000333911833333983333333388F333333F3333000033391118333911833333
          38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
          911118111118333338F3338F833338F3000033333911111111833333338F3338
          3333F8330000333333911111183333333338F333333F83330000333333311111
          8333333333338F3333383333000033333339111183333333333338F333833333
          00003333339111118333333333333833338F3333000033333911181118333333
          33338333338F333300003333911183911183333333383338F338F33300003333
          9118333911183333338F33838F338F33000033333913333391113333338FF833
          38F338F300003333333333333919333333388333338FFF830000333333333333
          3333333333333333333888330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = btnDeleteClick
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object JvStaticText6: TJvStaticText
        Left = 6
        Top = 88
        Width = 462
        Height = 17
        Caption = 
          'Add source files or project files to the project. Select a direc' +
          'tory or a file, and click the Add button.'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 8
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = False
      end
      object JvStaticText7: TJvStaticText
        Left = 6
        Top = 104
        Width = 593
        Height = 17
        AutoSize = False
        Caption = 'Two lists controls where to search or ignore files.'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 9
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = False
      end
      object btnSelectFile: TJvBitBtn
        Left = 534
        Top = 157
        Width = 25
        Height = 25
        Hint = 'Select a file'
        DoubleBuffered = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000750A0000750A00000001000000000000E0924100F7A6
          430066666600AE7B6E00B5827200BB887500EAB37700C28F7900C8957C00B388
          7E00CF9C8000D5A28300D6A38400DCA98700DEAB8800B88E8B00B6918B00C196
          9300C4999500C69C9600C99E9700D2A49700D3A69800CCA19900D6A89A00D9AD
          9D00EEBDA500EFBFA800F5B3AA00F0C1AB00FAD0AE00F0C3AF00F1C5B100F9D2
          B100FAD3B100FAD4B400F2C8B500FAD5B500FBD5B600F2C9B700FAD6B800FBD7
          B800FBD7B900F4C9BA00F3CCBA00FAD8BB00FBD9BC00FADABC00F3CDBD00FBD9
          BE00FADABE00FBDABF00FADBBF00FBDBC000FADCC100FBDCC200FBDCC300FBDD
          C300FBDCC400FBDEC400FBDEC600FBDFC600FBDFC700FBE0C800FBE0C900FBE1
          CA00FCE1CA00FBE1CB00FCE1CB00FFD5CC00FCE2CC00FBE2CD00FBE3CE00FCE3
          CE00FCE4CF00FCE4D000FCE4D100FCE5D100FCE5D200FCE5D300FCE6D300FCE6
          D400FCE7D400FCE6D500FCE7D600FDE7D600FCE8D700FCE8D800FDE9D800FDE9
          D900FCEADA00FDEADA00FCEADB00FDEBDB00FCEBDC00FCEBDD00FDECDD00FDEC
          DE00FDECDF00FDEDDF00FDEEE000FDEDE100FDEEE100FDEEE200FDEFE200FDEF
          E300FDEFE400FDF0E500FEF0E500FDF1E600FDF1E700FDF2E700FDF2E800FEF2
          E900FDF3EA00FEF3EA00FDF3EB00FDF3EC00FDF4EC00FEF4EC00FDF5ED00FEF5
          ED00FEF5EE00FEF6EE00FEF6F000FEF7F100FEF8F100FEF8F200FEF8F300FEF9
          F400FEFAF500FFFAF700FFFBF700FFFBF800FFFDFB00FFFEFB0000000000FFFF
          FF008805FE000000000000000000000000000000000000000000000000000000
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
          0000000000000000000000000000000000000000000000000000888888020202
          02020202020202020288888803191816151714131211100F0288888804443F3B
          37322D2923211E1A02888888054A46403C38332E2825221B0288888807524C49
          423E3A352F2A261D028888880857534E49433F3B36312D1F028888880A5F5B54
          504A46403C373420028888880B64605C56504C478A8A3924028888880D6C6662
          5D58534D8A8A3E27028888880D726D69635E59558A8A442C028888880D78736F
          6A8A8A8A8A8A8A8A8A8888880D7F7A76708A8A8A8A8A8A8A8A8888880D83807C
          77716D688A8A1C09028888880D8684817D79746E8A8A0002888888880D898785
          827E7B758A8A0288888888880D0D0D0D0D0D0E0C0D0288888888}
        ParentDoubleBuffered = False
        TabOrder = 2
        OnClick = btnSelectFileClick
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object btnSelectFolder: TJvBitBtn
        Left = 558
        Top = 157
        Width = 25
        Height = 25
        Hint = 'Select a folder'
        DoubleBuffered = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000750A0000750A0000000100000000000000000000FFFF
          FF00000000009CFFFF00A5FFFF0096F9FB0089F0F70094F7FF0079E4F0008CF3
          FF009CF3FF005BBCCE0084EBFF0084E7FF003FB8D7004FC1E2007BE3FF0020A0
          C9007BDFFF006BBFDA00189AC600199AC6001896C0001B9CC70018799C00197A
          9D0021A2CE0025A2CF002899BF006BD7FF0042B3E20042B2DE0052BEE7006FD5
          FD0042BAEF000C72A5005AC7FF0084D7FF00F7FBFF0000000000000000000000
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
          000000000000000000008805FE00000000000000000000000000000000000000
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
          0000000000000000000000000000000000000000000000000000020202020202
          0202020202020202020202020202020202020202020202020202020218181818
          18181818181802020202021616161616161616161616180202021417031D1D1D
          1D1D1D1D1D1D1C2302021415080310101010101010121F230202141B0E030C0C
          0C0C0C0C0C0D22230202141E11040707070707079C9C200B2302142114060303
          030303039C9C24052302142514130101260101019C9C0D012302140C0F141414
          149C9C9C9C9C9C9C9C02140A09090909099C9C9C9C9C9C9C9C02140103030303
          011414149C9C14020202021A01010101140202029C9C0202020202021A1A1A1A
          020202029C9C0202020202020202020202020202020202020202}
        ParentDoubleBuffered = False
        TabOrder = 3
        OnClick = btnSelectFolderClick
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object CheckBox_RecurseDirectories: TJvCheckBox
        Left = 8
        Top = 432
        Width = 112
        Height = 17
        Caption = 'Recurse directories'
        Checked = True
        State = cbChecked
        TabOrder = 10
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object JvStaticText15: TJvStaticText
        Left = 6
        Top = 118
        Width = 593
        Height = 17
        AutoSize = False
        Caption = 
          'You can use wilcard to select files and / or folders. Examples :' +
          ' *visit*.pas, MyDir\temp*.pas, *OtherSources* '
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 11
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = False
      end
      object JvStaticText17: TJvStaticText
        Left = 6
        Top = 132
        Width = 593
        Height = 17
        AutoSize = False
        Caption = 'Absolute and relative files and folders are allowed.'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 12
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = False
      end
    end
    object JvWizardComments: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Comments'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Choose which comment system are used in your files'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel, bkHelp]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      object CheckBox_ParseImplementation: TJvCheckBox
        Left = 8
        Top = 88
        Width = 158
        Height = 17
        Caption = 'Parse implementation section'
        Checked = True
        State = cbChecked
        TabOrder = 0
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object JvGroupBox_CommentsSystem: TJvGroupBox
        Left = 8
        Top = 120
        Width = 353
        Height = 145
        Caption = 'Comment systems'
        TabOrder = 1
        object CheckBox_SupportJavaDoc: TJvCheckBox
          Left = 17
          Top = 56
          Width = 137
          Height = 17
          Caption = 'Support JavaDoc syntax'
          Checked = True
          State = cbChecked
          TabOrder = 0
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object CheckBox_SupportInline: TJvCheckBox
          Left = 17
          Top = 32
          Width = 119
          Height = 17
          Caption = 'Support Inline syntax'
          Checked = True
          State = cbChecked
          TabOrder = 1
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object CheckBox_SupportXMLDoc: TJvCheckBox
          Left = 17
          Top = 104
          Width = 136
          Height = 17
          Caption = 'Support XMLDoc syntax'
          Enabled = False
          TabOrder = 2
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object CheckBox_SupportJEDI: TJvCheckBox
          Left = 17
          Top = 80
          Width = 117
          Height = 17
          Caption = 'Support JEDI syntax'
          Enabled = False
          TabOrder = 3
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
      end
      object CheckBox_AllowHtmlInDescription: TJvCheckBox
        Left = 6
        Top = 392
        Width = 164
        Height = 17
        Caption = 'Allow Html code in Description'
        TabOrder = 2
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object JvGroupBox1: TJvGroupBox
        Left = 6
        Top = 271
        Width = 355
        Height = 90
        Caption = 'Comments rules'
        TabOrder = 3
        object CheckBox_PropertyCommentFromAssessors: TJvCheckBox
          Left = 19
          Top = 31
          Width = 306
          Height = 17
          Caption = 'If no description found for properties, get assessors comment'
          TabOrder = 0
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object CheckBox_MethodCommentFromAncestor: TJvCheckBox
          Left = 19
          Top = 54
          Width = 324
          Height = 17
          Caption = 'If no comments found for overriden methods, get it from ancestor'
          TabOrder = 1
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
      end
    end
    object JvWizardJavaDoc: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'JavaDoc'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Configure JavaDoc syntax'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel, bkHelp]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      object JvGroupBox3: TJvGroupBox
        Left = 8
        Top = 80
        Width = 281
        Height = 121
        Caption = 'JavaDoc Prefix'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object JvStaticText10: TJvStaticText
          Left = 8
          Top = 32
          Width = 209
          Height = 17
          AutoSize = False
          Caption = 'Bracketstar Prefix (*'
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          Layout = tlTop
          TabOrder = 0
          TextMargins.X = 0
          TextMargins.Y = 0
          WordWrap = False
        end
        object JvStaticText11: TJvStaticText
          Left = 8
          Top = 56
          Width = 63
          Height = 17
          Caption = 'Curly Prefix {'
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          Layout = tlTop
          TabOrder = 1
          TextMargins.X = 0
          TextMargins.Y = 0
          WordWrap = False
        end
        object JvStaticText12: TJvStaticText
          Left = 8
          Top = 80
          Width = 71
          Height = 17
          Caption = 'Inline Prefix //'
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          Layout = tlTop
          TabOrder = 2
          TextMargins.X = 0
          TextMargins.Y = 0
          WordWrap = False
        end
        object Edit_BracketstarPrefix: TJvEdit
          Left = 224
          Top = 32
          Width = 33
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 1
          ParentFont = False
          TabOrder = 3
          OnChange = JavaDocCharChange
        end
        object Edit_CurlyPrefix: TJvEdit
          Left = 224
          Top = 56
          Width = 33
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 1
          ParentFont = False
          TabOrder = 4
          OnChange = JavaDocCharChange
        end
        object Edit_InlinePrefix: TJvEdit
          Left = 224
          Top = 80
          Width = 33
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 1
          ParentFont = False
          TabOrder = 5
          OnChange = JavaDocCharChange
        end
      end
      object CheckBox_SkipFirstLine: TJvCheckBox
        Left = 8
        Top = 216
        Width = 166
        Height = 17
        Caption = 'Skip first line in block comment'
        TabOrder = 1
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object CheckBox_SkipLastLine: TJvCheckBox
        Left = 8
        Top = 232
        Width = 166
        Height = 17
        Caption = 'Skip last line in block comment'
        TabOrder = 2
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
    end
    object JvWizardXMLDoc: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'XMLDoc'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Configure XMLDoc syntax'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel, bkHelp]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      Enabled = False
    end
    object JvWizardOutputFormat: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Output Format'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Define the style of the generated documentation'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel, bkHelp]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      object CheckBox_AlphaSortMembers: TJvCheckBox
        Left = 8
        Top = 160
        Width = 125
        Height = 17
        Caption = 'Alpha sort of members'
        TabOrder = 0
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object JvStaticText9: TJvStaticText
        Left = 8
        Top = 104
        Width = 265
        Height = 17
        Caption = 'Documentation language'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 2
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = False
      end
      object JvGroupBox_MemberVisibilityFilter: TJvGroupBox
        Left = 312
        Top = 335
        Width = 209
        Height = 113
        Caption = 'Member visibility filter'
        TabOrder = 3
        object JvCheckBox_Private: TJvCheckBox
          Left = 16
          Top = 24
          Width = 54
          Height = 17
          Caption = 'Private'
          TabOrder = 0
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Protected: TJvCheckBox
          Left = 16
          Top = 40
          Width = 67
          Height = 17
          Caption = 'Protected'
          TabOrder = 1
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Public: TJvCheckBox
          Left = 16
          Top = 56
          Width = 50
          Height = 17
          Caption = 'Public'
          TabOrder = 2
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Published: TJvCheckBox
          Left = 16
          Top = 72
          Width = 67
          Height = 17
          Caption = 'Published'
          TabOrder = 3
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Automated: TJvCheckBox
          Left = 16
          Top = 88
          Width = 72
          Height = 17
          Caption = 'Automated'
          TabOrder = 4
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
      end
      object JvGroupBox_OutputMemberFilter: TJvGroupBox
        Left = 312
        Top = 96
        Width = 209
        Height = 233
        Caption = 'Output category filter'
        TabOrder = 4
        object JvCheckBox_Constants: TJvCheckBox
          Left = 16
          Top = 40
          Width = 68
          Height = 17
          Caption = 'Constants'
          TabOrder = 0
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Types: TJvCheckBox
          Left = 16
          Top = 57
          Width = 50
          Height = 17
          Caption = 'Types'
          TabOrder = 1
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Variables: TJvCheckBox
          Left = 16
          Top = 72
          Width = 64
          Height = 17
          Caption = 'Variables'
          TabOrder = 2
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Functions: TJvCheckBox
          Left = 16
          Top = 88
          Width = 67
          Height = 17
          Caption = 'Functions'
          TabOrder = 3
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Classes: TJvCheckBox
          Left = 16
          Top = 104
          Width = 57
          Height = 17
          Caption = 'Classes'
          TabOrder = 4
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Fields: TJvCheckBox
          Left = 16
          Top = 136
          Width = 48
          Height = 17
          Caption = 'Fields'
          TabOrder = 5
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Methods: TJvCheckBox
          Left = 16
          Top = 152
          Width = 62
          Height = 17
          Caption = 'Methods'
          TabOrder = 6
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Properties: TJvCheckBox
          Left = 16
          Top = 168
          Width = 68
          Height = 17
          Caption = 'Properties'
          TabOrder = 7
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Events: TJvCheckBox
          Left = 16
          Top = 183
          Width = 54
          Height = 17
          Caption = 'Events'
          TabOrder = 8
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Records: TJvCheckBox
          Left = 16
          Top = 120
          Width = 61
          Height = 17
          Caption = 'Records'
          TabOrder = 9
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Units: TJvCheckBox
          Left = 16
          Top = 24
          Width = 45
          Height = 17
          Caption = 'Units'
          TabOrder = 10
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
        object JvCheckBox_Resourcestring: TJvCheckBox
          Left = 16
          Top = 198
          Width = 92
          Height = 17
          Caption = 'Resourcestring'
          TabOrder = 11
          LinkedControls = <>
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
        end
      end
      object CheckBox_ViewDocumentationAfterBuild: TJvCheckBox
        Left = 8
        Top = 184
        Width = 166
        Height = 17
        Caption = 'View documentation after build'
        TabOrder = 5
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object JvStaticText13: TJvStaticText
        Left = 6
        Top = 246
        Width = 178
        Height = 17
        Caption = 'Output directory (Absolute or relative)'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 7
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = False
      end
      object DirectoryEdit_OutputDirectory: TJvDirectoryEdit
        Left = 6
        Top = 262
        Width = 273
        Height = 21
        DialogKind = dkWin32
        TabOrder = 6
      end
      object ComboBox_DocumentationLanguage: TJvComboBox
        Left = 8
        Top = 120
        Width = 209
        Height = 21
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        TabOrder = 1
      end
      object JvRadioGroup_OutputFormat: TJvRadioGroup
        Left = 6
        Top = 320
        Width = 185
        Height = 121
        Caption = 'Output Format'
        ItemIndex = 1
        Items.Strings = (
          'None (no output)'
          'HTML'
          'CHM')
        TabOrder = 8
        CaptionVisible = True
      end
      object CheckBox_DisplayHiddenItems: TJvCheckBox
        Left = 8
        Top = 207
        Width = 233
        Height = 17
        Caption = 'Display hidden items (not in interface section)'
        TabOrder = 9
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
    end
    object JvWizardHTMLoutput: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'HTML output'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Configure HTML documentation'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      object JvGroupBox_CSSConfiguration: TJvGroupBox
        Left = 8
        Top = 96
        Width = 353
        Height = 225
        Caption = 'CSS Configuration'
        TabOrder = 0
        object editCssCustomFilename: TJvFilenameEdit
          Left = 32
          Top = 80
          Width = 305
          Height = 21
          Enabled = False
          TabOrder = 0
        end
        object rbCssCustom: TJvRadioButton
          Left = 16
          Top = 56
          Width = 117
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Use custom CSS file'
          TabOrder = 1
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          LinkedControls = <
            item
              Control = editCssCustomFilename
            end>
        end
        object rbCssInternal: TJvRadioButton
          Left = 16
          Top = 32
          Width = 165
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Use internal CSS configuration'
          Checked = True
          TabOrder = 2
          TabStop = True
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          LinkedControls = <>
        end
      end
      object JvCheckBox_HideEmptyBlock: TJvCheckBox
        Left = 8
        Top = 344
        Width = 103
        Height = 17
        Caption = 'Hide empty block'
        TabOrder = 1
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object JvCheckBox_HideEmptyTAGSection: TJvCheckBox
        Left = 8
        Top = 368
        Width = 136
        Height = 17
        Caption = 'Hide empty TAG section'
        TabOrder = 2
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object CheckBox_WarnWhenEmptyTag: TJvCheckBox
        Left = 8
        Top = 392
        Width = 151
        Height = 17
        Caption = 'Warn when a TAG is empty'
        TabOrder = 3
        LinkedControls = <>
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
    end
    object JvWizardCHMoutput: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'CHM output'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Configure CHM documentation'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      Enabled = False
    end
    object JvWizardTEXToutput: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'TEXT output'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Configure TEXT documentation'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      Enabled = False
    end
    object JvWizardPDFOutput: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'PDF output'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Configure PDF documentation'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      Enabled = False
    end
    object JvWizardHLPOutput: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'HLP output'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Configure HLP documentation'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      Enabled = False
    end
    object JvWizardAdvanced: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Advanced'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Advanced options'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkNext, bkCancel, bkHelp]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      object JvLabel1: TJvLabel
        Left = 8
        Top = 112
        Width = 314
        Height = 13
        Caption = 
          'Symbols referenced in conditional compiler directives (one per l' +
          'ine)'
        Transparent = True
        AutoOpenURL = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
      end
      object JvMemo_ConditionalDefines: TJvMemo
        Left = 8
        Top = 128
        Width = 513
        Height = 89
        TabOrder = 0
      end
    end
    object JvWizardFinish: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Finish'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'End of the wizard'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      EnabledButtons = [bkStart, bkLast, bkBack, bkFinish, bkCancel, bkHelp]
      VisibleButtons = [bkStart, bkLast, bkBack, bkNext, bkFinish, bkCancel, bkHelp]
      object JvStaticText14: TJvStaticText
        Left = 16
        Top = 120
        Width = 569
        Height = 17
        Caption = 'Select the '#39'Finish'#39' button to end this wizard.'
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = tlTop
        TabOrder = 0
        TextMargins.X = 0
        TextMargins.Y = 0
        WordWrap = False
      end
    end
    object JvWizardRouteMapList1: TJvWizardRouteMapList
      Left = 0
      Top = 0
      Width = 145
      Height = 465
      Cursor = crHandPoint
      ActiveFont.Charset = DEFAULT_CHARSET
      ActiveFont.Color = clWindowText
      ActiveFont.Height = -11
      ActiveFont.Name = 'MS Sans Serif'
      ActiveFont.Style = [fsBold]
      Color = clActiveCaption
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clNavy
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = [fsUnderline]
      IncludeDisabled = True
      ItemText = itTitle
    end
  end
  object DialogSelectFile: TJvOpenDialog
    Filter = 'Delphi Files (*.pas; *.dpr)|*.pas;*.dpr'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Title = 'Select a Delphi source file'
    Height = 382
    Width = 563
    Left = 465
    Top = 64
  end
  object JvBrowseForFolderDialog: TJvBrowseForFolderDialog
    Title = 'Select a folder containing source files'
    Left = 497
    Top = 64
  end
end
