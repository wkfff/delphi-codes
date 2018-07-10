inherited CellLevelMultiselectDemoMainForm: TCellLevelMultiselectDemoMainForm
  Left = 107
  Top = 75
  Caption = 'ExpressQuantumGrid CellLevelMultiselect Demo'
  ClientHeight = 465
  ClientWidth = 714
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited lbDescription: TLabel
    Width = 714
    Caption = 
      'Experiment with cell selection. Click '#39'About this demo'#39' for more' +
      ' information.'
  end
  inherited sbMain: TStatusBar
    Top = 405
    Width = 714
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 424
    Width = 714
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Color = 16247513
    TabOrder = 1
    object Label1: TLabel
      Left = 4
      Top = 8
      Width = 71
      Height = 13
      Caption = 'Selected rows:'
    end
    object Label2: TLabel
      Left = 4
      Top = 24
      Width = 86
      Height = 13
      Caption = 'Selected columns:'
    end
    object Label3: TLabel
      Left = 160
      Top = 8
      Width = 70
      Height = 13
      Caption = 'Selected Cells:'
    end
    object Label4: TLabel
      Left = 160
      Top = 24
      Width = 92
      Height = 13
      Caption = 'Selected Summary:'
    end
    object lblSelectedRows: TLabel
      Left = 96
      Top = 8
      Width = 45
      Height = 13
      AutoSize = False
      Caption = 'lblSelectedRows'
    end
    object lblSelectedColumns: TLabel
      Left = 96
      Top = 24
      Width = 44
      Height = 13
      AutoSize = False
      Caption = 'lblSelectedColumns'
    end
    object lblSelectedCells: TLabel
      Left = 259
      Top = 8
      Width = 73
      Height = 13
      Caption = 'lblSelectedCells'
    end
    object lblSelectedSummary: TLabel
      Left = 258
      Top = 24
      Width = 95
      Height = 13
      Caption = 'lblSelectedSummary'
    end
  end
  object Grid: TcxGrid [3]
    Left = 0
    Top = 16
    Width = 714
    Height = 389
    Align = alClient
    TabOrder = 2
    object TableView: TcxGridTableView
      OnMouseDown = TableViewMouseDown
      OnSelectionChanged = TableViewSelectionChanged
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsSelection.InvertSelect = False
      OptionsSelection.MultiSelect = True
      OptionsSelection.CellMultiSelect = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      OptionsView.IndicatorWidth = 40
      Styles.OnGetHeaderStyle = TableViewStylesGetHeaderStyle
      OnCustomDrawIndicatorCell = TableViewCustomDrawIndicatorCell
    end
    object Level: TcxGridLevel
      GridView = TableView
    end
  end
  inherited StyleRepository: TcxStyleRepository
    Left = 336
    Top = 88
    PixelsPerInch = 96
    object styleSelected: TcxStyle [24]
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object styleNormal: TcxStyle [25]
      AssignedValues = [svColor]
      Color = clBtnFace
    end
    inherited GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet
      BuiltIn = True
    end
    inherited GridCardViewStyleSheetDevExpress: TcxGridCardViewStyleSheet
      BuiltIn = True
    end
  end
end
