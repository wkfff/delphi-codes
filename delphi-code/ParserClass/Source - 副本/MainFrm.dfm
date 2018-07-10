object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = #25552#21462#31867
  ClientHeight = 605
  ClientWidth = 966
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object spl3: TSplitter
    Left = 449
    Top = 51
    Width = 11
    Height = 529
    Beveled = True
    Color = clBlack
    ParentColor = False
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 966
    Height = 51
    Align = alTop
    TabOrder = 0
    object lbl1: TLabel
      Left = 15
      Top = 6
      Width = 477
      Height = 39
      Caption = 
        '1 '#36873#25321#30446#24405#65292#21015#20986#30446#24405#19979#30340#25152#26377'pas'#25991#20214#13#10'2 '#36873#25321#25991#20214#65292#21015#20986'pas'#25991#20214#20013#30340#31867#13#10'3 '#36873#25321#31867#65292#35813#31867#30340#30456#20851#20195#30721#20250#36755#20986#21040#35813#31243#24207#19979#30340#20004 +
        #20010#25991#20214#20013#65292#28982#21518#21487#20197#29992#23545#27604#24037#20855#36827#34892#27604#36739
    end
  end
  object stat1: TStatusBar
    Left = 0
    Top = 580
    Width = 966
    Height = 25
    Panels = <
      item
        Text = #25552#31034#65306
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object pnl4: TPanel
    Left = 0
    Top = 51
    Width = 449
    Height = 529
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pnl4'
    TabOrder = 2
    object grp1: TGroupBox
      Left = 0
      Top = 0
      Width = 449
      Height = 529
      Align = alClient
      Caption = #37325#26500'GGC'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      object spl1: TSplitter
        Left = 201
        Top = 15
        Height = 512
        ExplicitLeft = 186
        ExplicitTop = 16
        ExplicitHeight = 473
      end
      object pnl2: TPanel
        Left = 2
        Top = 15
        Width = 199
        Height = 512
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'pnl2'
        TabOrder = 0
        object pnl3: TPanel
          Left = 0
          Top = 0
          Width = 199
          Height = 41
          Align = alTop
          BevelInner = bvLowered
          Caption = 'pnl3'
          TabOrder = 0
          DesignSize = (
            199
            41)
          object cbbRef: TComboBox
            Left = 13
            Top = 12
            Width = 177
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 0
            OnChange = cbbRefChange
            OnMouseEnter = cbbRefMouseEnter
          end
        end
        object grp5: TGroupBox
          Left = 0
          Top = 41
          Width = 199
          Height = 471
          Align = alClient
          Caption = #25991#20214#21517
          TabOrder = 1
          object lstRef: TListBox
            Left = 2
            Top = 36
            Width = 195
            Height = 433
            Align = alClient
            ItemHeight = 13
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            OnClick = lstRefClick
            OnMouseMove = lstRefMouseMove
            ExplicitLeft = 3
            ExplicitTop = 13
            ExplicitHeight = 454
          end
          object edt1: TEdit
            Left = 2
            Top = 15
            Width = 195
            Height = 21
            Align = alTop
            TabOrder = 1
            Text = 'search'
            OnChange = edt1Change
            ExplicitLeft = 24
            ExplicitTop = 136
            ExplicitWidth = 121
          end
        end
      end
      object pnl6: TPanel
        Left = 204
        Top = 15
        Width = 243
        Height = 512
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnl6'
        TabOrder = 1
        object grp3: TGroupBox
          Left = 0
          Top = 0
          Width = 243
          Height = 512
          Align = alClient
          Caption = #31867#21517
          TabOrder = 0
          object lstRefClass: TListBox
            Left = 2
            Top = 36
            Width = 239
            Height = 474
            Align = alClient
            ItemHeight = 13
            TabOrder = 0
            OnClick = lstRefClassClick
            ExplicitTop = 15
            ExplicitHeight = 495
          end
          object edt2: TEdit
            Left = 2
            Top = 15
            Width = 239
            Height = 21
            Align = alTop
            TabOrder = 1
            Text = 'search'
            OnChange = edt2Change
            ExplicitLeft = 122
            ExplicitTop = 232
            ExplicitWidth = 121
          end
        end
      end
    end
  end
  object pnl5: TPanel
    Left = 460
    Top = 51
    Width = 506
    Height = 529
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnl5'
    TabOrder = 3
    object grp2: TGroupBox
      Left = 0
      Top = 0
      Width = 506
      Height = 529
      Align = alClient
      Caption = #20135#21697'GGC'
      Color = clBtnFace
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      object spl4: TSplitter
        Left = 217
        Top = 15
        Height = 512
        ExplicitLeft = 186
        ExplicitTop = 16
        ExplicitHeight = 473
      end
      object pnl7: TPanel
        Left = 2
        Top = 15
        Width = 215
        Height = 512
        Align = alLeft
        Caption = 'pnl2'
        TabOrder = 0
        object pnl8: TPanel
          Left = 1
          Top = 1
          Width = 213
          Height = 41
          Align = alTop
          BevelInner = bvLowered
          Caption = 'pnl3'
          TabOrder = 0
          DesignSize = (
            213
            41)
          object cbbNew: TComboBox
            Left = 11
            Top = 11
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 0
            OnChange = cbbNewChange
            OnMouseEnter = cbbNewMouseEnter
          end
        end
        object grp6: TGroupBox
          Left = 1
          Top = 42
          Width = 213
          Height = 469
          Align = alClient
          Caption = #25991#20214#21517
          TabOrder = 1
          object lstNew: TListBox
            Left = 2
            Top = 36
            Width = 209
            Height = 431
            Align = alClient
            ItemHeight = 13
            TabOrder = 0
            OnClick = lstNewClick
            OnMouseMove = lstNewMouseMove
            ExplicitTop = 15
            ExplicitHeight = 452
          end
          object edt3: TEdit
            Left = 2
            Top = 15
            Width = 209
            Height = 21
            Align = alTop
            TabOrder = 1
            Text = 'search'
            OnChange = edt3Change
            ExplicitLeft = 92
            ExplicitTop = 248
            ExplicitWidth = 121
          end
        end
      end
      object pnl9: TPanel
        Left = 220
        Top = 15
        Width = 284
        Height = 512
        Align = alClient
        Caption = 'pnl6'
        TabOrder = 1
        object grp4: TGroupBox
          Left = 1
          Top = 1
          Width = 282
          Height = 510
          Align = alClient
          Caption = #31867#21517
          TabOrder = 0
          object lstNewClass: TListBox
            Left = 2
            Top = 36
            Width = 278
            Height = 472
            Align = alClient
            ItemHeight = 13
            TabOrder = 0
            OnClick = lstNewClassClick
            ExplicitTop = 15
            ExplicitHeight = 493
          end
          object edt4: TEdit
            Left = 2
            Top = 15
            Width = 278
            Height = 21
            Align = alTop
            TabOrder = 1
            Text = 'search'
            OnChange = edt4Change
            ExplicitLeft = 73
            ExplicitTop = 184
            ExplicitWidth = 121
          end
        end
      end
    end
  end
end
