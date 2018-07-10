inherited frmMain: TfrmMain
  Left = 300
  Top = 120
  Caption = 'ExpressQuantumGrid Filter Demo'
  ClientHeight = 542
  ClientWidth = 704
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited lbDescription: TLabel
    Width = 704
    Caption = 
      '  This demo shows the advanced filter capabilities of the Table/' +
      'Card view'
  end
  inherited sbMain: TStatusBar
    Top = 523
    Width = 704
  end
  object Grid: TcxGrid [2]
    Left = 0
    Top = 44
    Width = 704
    Height = 479
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    object TableView: TcxGridTableView
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.PercentWildcard = '*'
      DataController.Filter.UnderscoreWildcard = '?'
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoSortByDisplayText]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DateTimeHandling.Filters = [dtfRelativeDays, dtfRelativeDayPeriods, dtfRelativeWeeks, dtfRelativeMonths, dtfRelativeYears, dtfPastFuture, dtfMonths, dtfYears]
      DateTimeHandling.IgnoreTimeForFiltering = True
      DateTimeHandling.Grouping = dtgRelativeToToday
      Filtering.ColumnPopup.MaxDropDownItemCount = 30
      FilterRow.Visible = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Indicator = True
      object TableViewOrderID: TcxGridColumn
        Caption = 'Order ID'
        DataBinding.ValueType = 'Integer'
        Width = 49
      end
      object TableViewCompany: TcxGridColumn
        Caption = 'Company'
        Width = 205
      end
      object TableViewCountry: TcxGridColumn
        Caption = 'Country'
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.ClearKey = 46
        Properties.DropDownAutoSize = True
        Properties.DropDownRows = 25
        Properties.KeyFieldNames = 'ID'
        Properties.ListColumns = <
          item
            Caption = 'Name'
            Fixed = True
            SortOrder = soAscending
            Width = 265
            FieldName = 'NAME'
          end
          item
            Caption = 'Flag'
            Fixed = True
            RepositoryItem = erMainFlag
            Width = 60
            FieldName = 'NATIONALFLAG'
          end>
        Properties.ListOptions.GridLines = glHorizontal
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsCountries
        Width = 110
      end
      object TableViewProduct: TcxGridColumn
        Caption = 'Product'
        Width = 130
      end
      object TableViewOrderDate: TcxGridColumn
        Caption = 'Order Date'
        DataBinding.ValueType = 'DateTime'
        Width = 130
      end
      object TableViewQuantity: TcxGridColumn
        Caption = 'Quantity'
        DataBinding.ValueType = 'Integer'
        Width = 50
      end
    end
    object GridLevel1: TcxGridLevel
      GridView = TableView
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 16
    Width = 704
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clGray
    TabOrder = 1
    object pnlMaskInfo: TPanel
      Left = 1
      Top = 1
      Width = 702
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      Caption = 
        'You can use * and ? symbols in the filter row to define a filter' +
        ' mask (for example: Express* for all products beginning with Exp' +
        'ress)'
      Color = clInfoBk
      TabOrder = 0
    end
  end
  inherited mmMain: TMainMenu
    Left = 300
    Top = 120
    object miView: TMenuItem [1]
      Caption = '&View'
      object miColumnFilterPopupMultiSelect: TMenuItem
        Caption = 'Column Filter Popup MultiSelect'
        Checked = True
        OnClick = miColumnFilterPopupMultiSelectClick
      end
      object miApplyMultiSelectChanges: TMenuItem
        Caption = 'Apply MultiSelect changes'
        object miApplyMultiSelectChangesImmediately: TMenuItem
          Caption = 'Immediately'
          GroupIndex = 1
          RadioItem = True
          OnClick = miApplyMultiSelectChangesClick
        end
        object miApplyMultiSelectChangesOnButtonClick: TMenuItem
          Tag = 1
          Caption = 'On button click'
          GroupIndex = 1
          RadioItem = True
          OnClick = miApplyMultiSelectChangesClick
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miColumnFilterPopupFilteredList: TMenuItem
        Caption = 'Column Filter Popup filtered list'
        Checked = True
        OnClick = miColumnFilterPopupFilteredListClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miFilterRow: TMenuItem
        Caption = 'Filter Row'
        Checked = True
        OnClick = miFilterRowClick
      end
      object miApplyFilterRowChanges: TMenuItem
        Caption = 'Apply Filter Row changes'
        object miApplyFilterRowChangesOnCellExit: TMenuItem
          Caption = 'On cell exit'
          GroupIndex = 2
          RadioItem = True
          OnClick = miApplyFilterRowChangesClick
        end
        object miApplyFilterRowChangesImmediately: TMenuItem
          Tag = 1
          Caption = 'Immediately'
          GroupIndex = 2
          RadioItem = True
          OnClick = miApplyFilterRowChangesClick
        end
      end
    end
    object miDateTimeFilters: TMenuItem [2]
      Caption = '&DateTime Filters'
      object miDateTimeFilterRelativeDays: TMenuItem
        Caption = 'Relative Days'
        Checked = True
        OnClick = miDateTimeFilterClick
      end
      object miDateTimeFilterRelativeDayPeriods: TMenuItem
        Tag = 1
        Caption = 'Relative Day Periods'
        Checked = True
        OnClick = miDateTimeFilterClick
      end
      object miDateTimeFilterRelativeWeeks: TMenuItem
        Tag = 2
        Caption = 'Relative Weeks'
        Checked = True
        OnClick = miDateTimeFilterClick
      end
      object miDateTimeFilterRelativeMonths: TMenuItem
        Tag = 3
        Caption = 'Relative Months'
        Checked = True
        OnClick = miDateTimeFilterClick
      end
      object miDateTimeFilterRelativeYears: TMenuItem
        Tag = 4
        Caption = 'Relative Years'
        Checked = True
        OnClick = miDateTimeFilterClick
      end
      object miDateTimeFilterPastFuture: TMenuItem
        Tag = 5
        Caption = 'Past/Future'
        Checked = True
        OnClick = miDateTimeFilterClick
      end
      object miDateTimeFilterMonths: TMenuItem
        Tag = 6
        Caption = 'Months'
        Checked = True
        OnClick = miDateTimeFilterClick
      end
      object miDateTimeFilterYears: TMenuItem
        Tag = 7
        Caption = 'Years'
        Checked = True
        OnClick = miDateTimeFilterClick
      end
    end
  end
  inherited StyleRepository: TcxStyleRepository
    inherited GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet
      BuiltIn = True
    end
    inherited GridCardViewStyleSheetDevExpress: TcxGridCardViewStyleSheet
      BuiltIn = True
    end
  end
  object dbMain: TDatabase
    Connected = True
    DatabaseName = 'DemosDB'
    DriverName = 'STANDARD'
    Params.Strings = (
      'PATH=..\..\Data'
      'DEFAULT DRIVER=PARADOX'
      'ENABLE BCD=FALSE')
    SessionName = 'Default'
    Left = 232
    Top = 120
  end
  object dsCompanies: TDataSource
    DataSet = tblCompanies
    Left = 232
    Top = 156
  end
  object tblCompanies: TTable
    Active = True
    DatabaseName = 'DemosDB'
    TableName = 'COMPANIES.DB'
    Left = 260
    Top = 156
    object tblCompaniesCOMPANYNAME: TStringField
      FieldName = 'COMPANYNAME'
      Size = 50
    end
    object tblCompaniesCOUNTRYID: TIntegerField
      FieldName = 'COUNTRYID'
    end
  end
  object tblCountries: TTable
    Active = True
    DatabaseName = 'DemosDB'
    IndexFieldNames = 'ID'
    TableName = 'COUNTRIES.DB'
    Left = 260
    Top = 188
  end
  object tblProducts: TTable
    Active = True
    DatabaseName = 'DemosDB'
    IndexFieldNames = 'ID'
    TableName = 'PRODUCTS.DB'
    Left = 260
    Top = 220
    object tblProductsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object tblProductsName: TStringField
      FieldName = 'Name'
      Size = 100
    end
  end
  object dsCountries: TDataSource
    DataSet = tblCountries
    Left = 232
    Top = 188
  end
  object erMain: TcxEditRepository
    Left = 300
    Top = 156
    object erMainFlag: TcxEditRepositoryImageItem
      Properties.GraphicClassName = 'TJPEGImage'
      Properties.Stretch = True
    end
  end
end
