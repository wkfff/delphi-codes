object QuickWizardForm: TQuickWizardForm
  Left = 299
  Top = 216
  BorderStyle = bsDialog
  Caption = 'Project Wizard'
  ClientHeight = 369
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    425
    369)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOutput: TSpeedButton
    Left = 401
    Top = 305
    Width = 19
    Height = 19
    OnClick = ChooseOutput
  end
  object btnRoot: TSpeedButton
    Left = 401
    Top = 241
    Width = 19
    Height = 19
    Enabled = False
    OnClick = ChooseSourcesFolder
  end
  object btnProjectFile: TSpeedButton
    Left = 401
    Top = 161
    Width = 19
    Height = 19
    OnClick = ChooseProject
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 49
    Align = alTop
    Color = clWhite
    TabOrder = 9
  end
  object ebRoot: TLabeledEdit
    Left = 16
    Top = 240
    Width = 385
    Height = 21
    EditLabel.Width = 163
    EditLabel.Height = 13
    EditLabel.Caption = 'Enter the folder of your source files'
    Enabled = False
    ReadOnly = True
    TabOrder = 1
    OnChange = AssertControls
  end
  object ebOutput: TLabeledEdit
    Left = 16
    Top = 304
    Width = 385
    Height = 21
    EditLabel.Width = 119
    EditLabel.Height = 13
    EditLabel.Caption = 'Enter the output directory'
    ReadOnly = True
    TabOrder = 2
    OnChange = AssertControls
  end
  object leProjectName: TLabeledEdit
    Left = 16
    Top = 72
    Width = 387
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 142
    EditLabel.Height = 13
    EditLabel.Caption = 'Enter the name of your project'
    TabOrder = 0
    Text = 'Project1'
  end
  object btnOk: TButton
    Left = 256
    Top = 338
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 344
    Top = 338
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object EditProjectFile: TLabeledEdit
    Left = 16
    Top = 160
    Width = 385
    Height = 21
    EditLabel.Width = 200
    EditLabel.Height = 13
    EditLabel.Caption = 'Enter the location of your project file (*.dpr)'
    ReadOnly = True
    TabOrder = 5
    OnChange = AssertControls
  end
  object JvRadioButton1: TJvRadioButton
    Left = 16
    Top = 120
    Width = 176
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Select a Delphi Project file (*.dpr)'
    Checked = True
    TabOrder = 6
    TabStop = True
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    LinkedControls = <
      item
        Control = EditProjectFile
      end
      item
        Control = btnProjectFile
      end>
  end
  object JvRadioButton2: TJvRadioButton
    Left = 16
    Top = 200
    Width = 200
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Select a folder with source files (*.pas)'
    TabOrder = 7
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    LinkedControls = <
      item
        Control = ebRoot
      end
      item
        Control = btnRoot
      end>
  end
  object JvStaticText1: TJvStaticText
    Left = 48
    Top = 16
    Width = 353
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'Quick Wizard : Enter your project information'
    Color = clWhite
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Layout = tlTop
    ParentColor = False
    TabOrder = 8
    TextMargins.X = 0
    TextMargins.Y = 0
    WordWrap = False
  end
  object BrowseFolder: TJvBrowseForFolderDialog
    Options = [odOnlyDirectory, odNewDialogStyle]
    Position = fpFormCenter
    RootDirectory = fdDesktop
    Left = 24
    Top = 8
  end
  object JvOpenDialog1: TJvOpenDialog
    Filter = 'Delphi project file (*.dpr)|*.dpr'
    FilterIndex = 0
    Height = 382
    Width = 563
    Left = 56
    Top = 8
  end
end
