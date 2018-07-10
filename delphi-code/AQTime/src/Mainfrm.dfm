object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'AQTimeSuper'
  ClientHeight = 623
  ClientWidth = 808
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 808
    Height = 147
    Align = alTop
    TabOrder = 0
    DesignSize = (
      808
      147)
    object lbl1: TLabel
      Left = 17
      Top = 10
      Width = 97
      Height = 13
      Caption = #36873#25321'AQTime'#33050#26412#65306
    end
    object edt1: TEdit
      Left = 17
      Top = 29
      Width = 711
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
    end
    object btn2: TButton
      Left = 739
      Top = 28
      Width = 56
      Height = 23
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 1
      OnClick = btn2Click
    end
    object btnTest: TButton
      Left = 630
      Top = -2
      Width = 75
      Height = 25
      Caption = 'TEST'
      TabOrder = 2
      Visible = False
      OnClick = btnTestClick
    end
    object grpShow: TGroupBox
      Left = 389
      Top = 56
      Width = 406
      Height = 76
      Anchors = [akTop, akRight]
      Caption = #26174#31034
      TabOrder = 3
      object btnShowResult: TButton
        Left = 310
        Top = 16
        Width = 93
        Height = 49
        Action = actShowResult
        TabOrder = 0
      end
      object rbSQL: TRadioButton
        Left = 16
        Top = 16
        Width = 113
        Height = 17
        Caption = #36830#25509#33267'SQL-Server'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = rbSQLClick
      end
      object rbAccess: TRadioButton
        Left = 16
        Top = 47
        Width = 113
        Height = 17
        Caption = #25171#24320'Access'#25968#25454
        TabOrder = 2
        OnClick = rbAccessClick
      end
      object mmo1: TMemo
        Left = 127
        Top = 16
        Width = 177
        Height = 49
        Hint = 
          #35831#36755#20837#35201#36807#28388#30340#31867#30340#21069#32512#65292#22914#13#10'TGGL;TGCL'#65288#29992';'#20998#38548#65289#13#10'|'#35831#36755#20837#35201#36807#28388#30340#31867#30340#21069#32512#65292#22914#13#10'TGGL;TGCL'#65288#29992';'#20998#38548#65289#13 +
          #10
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        Lines.Strings = (
          'T;TGCL;TGGL')
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
    end
    object grp2: TGroupBox
      Left = 17
      Top = 52
      Width = 366
      Height = 80
      Caption = #36816#34892
      TabOrder = 4
      object btnRun: TButton
        Left = 9
        Top = 17
        Width = 97
        Height = 56
        Action = actRun
        TabOrder = 0
      end
      object btn1: TButton
        Left = 115
        Top = 48
        Width = 160
        Height = 25
        Action = actExportToMDB
        TabOrder = 1
      end
      object btnExportToSql: TButton
        Left = 115
        Top = 17
        Width = 160
        Height = 25
        Action = actExportToSQLServer
        TabOrder = 2
      end
      object btnQuit: TButton
        Left = 283
        Top = 17
        Width = 79
        Height = 56
        Action = actQuit
        TabOrder = 3
      end
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 147
    Width = 808
    Height = 476
    Align = alClient
    TabOrder = 1
    object spl1: TSplitter
      Left = 265
      Top = 1
      Width = 5
      Height = 474
      Beveled = True
    end
    object grp1: TGroupBox
      Left = 270
      Top = 1
      Width = 537
      Height = 474
      Align = alClient
      Caption = #22534#26632#20449#24687
      TabOrder = 0
      object grndGridStackInfo: TGrandViewGrid
        Left = 2
        Top = 15
        Width = 533
        Height = 457
        Align = alClient
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goEditing, goTabs, goThumbTracking, goColDblClickMaxWidth, goCellMerge, goShowRowNo, goAutoThemeAdapt, goAllowCheckBoxGrayed, goBoolClickBoxSwitch]
        ReadOnly = True
        OnQueryCellValue = grndGridStackInfoQueryCellValue
        ColWidths = (
          20
          72
          72
          72
          72)
      end
    end
    object pnl3: TPanel
      Left = 1
      Top = 1
      Width = 264
      Height = 474
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 1
      object spl2: TSplitter
        Left = 1
        Top = 143
        Width = 262
        Height = 8
        Cursor = crVSplit
        Align = alTop
      end
      object extgrpbx1: TExtGroupBox
        Left = 1
        Top = 1
        Width = 262
        Height = 142
        Align = alTop
        Caption = #21382#21490#35760#24405
        Gradient.DrawStyle = gtTopToBottom
        TabOrder = 0
        object grndGridInst: TGrandViewGrid
          Left = 2
          Top = 19
          Width = 258
          Height = 121
          Align = alClient
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goEditing, goTabs, goThumbTracking, goColDblClickMaxWidth, goCellMerge, goShowRowNo, goAutoThemeAdapt, goAllowCheckBoxGrayed, goBoolClickBoxSwitch]
          OnClick = grndGridInstClick
          ColCount = 3
          ReadOnly = True
          OnQueryCellValue = grndGridInstQueryCellValue
          ColWidths = (
            20
            72
            72)
        end
      end
      object extgrpbx2: TExtGroupBox
        Left = 1
        Top = 151
        Width = 262
        Height = 322
        Align = alClient
        Caption = #31867#20869#23384#27844#38706#20449#24687
        Gradient.DrawStyle = gtTopToBottom
        TabOrder = 1
        object grndGrid: TGrandViewGrid
          Left = 2
          Top = 19
          Width = 258
          Height = 301
          Align = alClient
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goEditing, goTabs, goThumbTracking, goColDblClickMaxWidth, goCellMerge, goShowRowNo, goAutoThemeAdapt, goAllowCheckBoxGrayed, goBoolClickBoxSwitch]
          OnClick = grndGridClick
          ColCount = 4
          ReadOnly = True
          OnQueryCellValue = grndGridQueryCellValue
          ColWidths = (
            20
            72
            72
            72)
          RowHeights = (
            18
            18
            18
            18
            18)
        end
      end
    end
  end
  object actlst1: TActionList
    OnUpdate = actlst1Update
    Left = 696
    Top = 64
    object actRun: TAction
      Caption = #36816#34892
      OnExecute = actRunExecute
    end
    object actExportToMDB: TAction
      Caption = #23548#20986#21040'Access'#25968#25454#24211
      OnExecute = actExportToMDBExecute
    end
    object actExportToSQLServer: TAction
      Caption = #23548#20986#21040'SQLServer'#26381#21153#22120
      OnExecute = actExportToSQLServerExecute
    end
    object actShowResult: TAction
      Caption = #26174#31034#32467#26524
      OnExecute = actShowResultExecute
    end
    object actQuit: TAction
      Caption = #20851#38381'AQTime'
      OnExecute = actQuitExecute
    end
  end
end
