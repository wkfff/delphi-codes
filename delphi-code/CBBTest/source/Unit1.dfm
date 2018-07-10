object Form1: TForm1
  Left = 0
  Top = 0
  Width = 644
  Height = 408
  AutoScroll = True
  Caption = 'Form1'
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
    Left = 16
    Top = 32
    Width = 217
    Height = 265
    Caption = 'grp1'
    TabOrder = 0
    object mmo1: TMemo
      Left = 2
      Top = 15
      Width = 213
      Height = 248
      Align = alClient
      Lines.Strings = (
        'mmo1')
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object edt1: TFloatSpinEdit
    Left = 400
    Top = 136
    Width = 121
    Height = 22
    MaxLength = 5
    TabOrder = 1
    Text = '0'
    Visible = False
    FormatString = '0.00'
    Increment = 1.000000000000000000
  end
  object btn1: TButton
    Left = 432
    Top = 240
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 2
    OnClick = btn1Click
  end
  object pnl3: TPanel
    Left = 256
    Top = 8
    Width = 337
    Height = 337
    Caption = 'pnl3'
    TabOrder = 3
    object wzrdpg1: TWizardPage
      Left = 1
      Top = 1
      Width = 335
      Height = 335
      ActivePage = ts2
      Align = alClient
      OwnerDraw = True
      TabHeight = 20
      TabOrder = 0
      TabWidth = 20
      object ts1: TTabSheet
        Caption = 'ts1'
        object lbl1: TLabel
          Left = 41
          Top = 79
          Width = 63
          Height = 13
          Caption = 'asdfasdfasdf'
        end
        object pnl1: TPanel
          Left = 32
          Top = 65
          Width = 185
          Height = 41
          Caption = 'pnl1'
          TabOrder = 0
        end
      end
      object ts2: TTabSheet
        Caption = 'ts2'
        ImageIndex = 1
        object edt2: TEdit
          Left = 168
          Top = 112
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'edt2'
        end
        object pnl2: TPanel
          Left = 104
          Top = 88
          Width = 185
          Height = 41
          Caption = 'pnl2'
          TabOrder = 1
        end
      end
      object ts3: TTabSheet
        Caption = 'ts3'
        ImageIndex = 2
      end
    end
  end
  object edt3: TCrossEdit
    Left = 56
    Top = 323
    Width = 121
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    EditType = etString
    MaxValue = 2147483647.000000000000000000
  end
  object btn2: TButton
    Left = 183
    Top = 337
    Width = 75
    Height = 25
    Caption = 'btn2'
    TabOrder = 5
    OnClick = btn2Click
  end
  object explrdrp1: TExplorerDrop
    DestinationControl = mmo1
    Enabled = True
    OnDropped = explrdrp1Dropped
    Left = 64
    Top = 88
  end
  object shlbrwsr1: TShellBrowser
    InitialDir = 'D:\Program Files (x86)\CodeGear\RAD Studio\5.0\bin'
    Title = #36873#25321#25991#20214#22841#65306
    RootID = fiNone
    Options = [fdReturnOnlyFSDirs, fdStatusText]
    Left = 320
    Top = 200
  end
end
