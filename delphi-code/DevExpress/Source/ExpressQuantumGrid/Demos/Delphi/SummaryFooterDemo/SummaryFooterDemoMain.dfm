inherited SummaryFooterDemoMainForm: TSummaryFooterDemoMainForm
  Left = 188
  Top = 70
  Caption = 'ExpressQuantumGrid Summary Footer Demo'
  ClientHeight = 529
  ClientWidth = 856
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited lbDescription: TLabel
    Width = 856
    Caption = 
      'Options/Summary above provides runtime summary facilities. Click' +
      ' '#39'About this demo'#39' for more information.'
  end
  inherited sbMain: TStatusBar
    Top = 510
    Width = 856
  end
  object Grid: TcxGrid [2]
    Left = 0
    Top = 16
    Width = 856
    Height = 494
    Align = alClient
    TabOrder = 1
    OnFocusedViewChanged = GridFocusedViewChanged
    object tvCars: TcxGridDBTableView
      DataController.DataSource = SummaryFooterDemoDataDM.dsCars
      DataController.KeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsSelection.MultiSelect = True
      OptionsView.CellAutoHeight = True
      OptionsView.Footer = True
      OptionsView.Indicator = True
      Preview.MaxLineCount = 1
      Preview.RightIndent = 10
      Styles.StyleSheet = GridTableViewStyleSheetDevExpress
      object tvCarsTrademark: TcxGridDBColumn
        DataBinding.FieldName = 'Trademark'
        Width = 100
      end
      object tvCarsModel: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
        Width = 180
      end
      object tvCarsPicture: TcxGridDBColumn
        DataBinding.FieldName = 'Picture'
        PropertiesClassName = 'TcxBlobEditProperties'
        Properties.BlobEditKind = bekPict
        Properties.PictureGraphicClassName = 'TJPEGImage'
      end
      object tvCarshp: TcxGridDBColumn
        DataBinding.FieldName = 'hp'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.Increment = 10.000000000000000000
      end
      object tvCarsliter: TcxGridDBColumn
        DataBinding.FieldName = 'liter'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.Increment = 0.100000000000000000
      end
      object tvCarscyl: TcxGridDBColumn
        DataBinding.FieldName = 'cyl'
        PropertiesClassName = 'TcxSpinEditProperties'
      end
      object tvCarsTransmissSpeedCount: TcxGridDBColumn
        DataBinding.FieldName = 'TransmissSpeedCount'
        PropertiesClassName = 'TcxSpinEditProperties'
        Width = 130
      end
      object tvCarsTransmissAutomatic: TcxGridDBColumn
        Caption = 'Automatic Transmission'
        DataBinding.FieldName = 'TransmissAutomatic'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'Yes'
        Properties.ValueUnchecked = 'No'
        Width = 135
      end
      object tvCarsMPG_City: TcxGridDBColumn
        DataBinding.FieldName = 'MPG_City'
        Width = 70
      end
      object tvCarsMPG_Highway: TcxGridDBColumn
        DataBinding.FieldName = 'MPG_Highway'
        Width = 100
      end
      object tvCarsCategory: TcxGridDBColumn
        DataBinding.FieldName = 'Category'
        Width = 70
      end
      object tvCarsDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        PropertiesClassName = 'TcxBlobEditProperties'
        Properties.BlobEditKind = bekMemo
        Properties.MemoScrollBars = ssVertical
      end
      object tvCarsHyperlink: TcxGridDBColumn
        DataBinding.FieldName = 'Hyperlink'
        PropertiesClassName = 'TcxHyperLinkEditProperties'
        Width = 150
      end
      object tvCarsPrice: TcxGridDBColumn
        DataBinding.FieldName = 'Price'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Width = 80
      end
    end
    object tvOrders: TcxGridDBTableView
      DataController.DataSource = SummaryFooterDemoDataDM.dsOrders
      DataController.DetailKeyFieldNames = 'ProductID'
      DataController.KeyFieldNames = 'ID'
      DataController.MasterKeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          FieldName = 'CustomerID'
          Column = tvOrdersCustomerID
        end
        item
          Kind = skSum
          FieldName = 'PaymentAmount'
          Column = tvOrdersPaymentAmount
        end
        item
          Kind = skSum
          FieldName = 'Quantity'
          Column = tvOrdersQuantity
        end
        item
          Kind = skMax
          FieldName = 'PurchaseDate'
          Column = tvOrdersPurchaseDate
        end
        item
          Kind = skMin
          FieldName = 'Time'
          Column = tvOrdersTime
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.Indicator = True
      Styles.StyleSheet = GridTableViewStyleSheetDevExpress
      object tvOrdersCustomerID: TcxGridDBColumn
        Caption = 'Customer'
        DataBinding.FieldName = 'CustomerID'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'ID'
        Properties.ListColumns = <
          item
            FieldName = 'Name'
          end>
        Properties.ListSource = SummaryFooterDemoDataDM.dsCustomers
        Width = 100
      end
      object tvOrdersPurchaseDate: TcxGridDBColumn
        DataBinding.FieldName = 'PurchaseDate'
        PropertiesClassName = 'TcxDateEditProperties'
        Width = 60
      end
      object tvOrdersTime: TcxGridDBColumn
        DataBinding.FieldName = 'Time'
        PropertiesClassName = 'TcxTimeEditProperties'
        Properties.TimeFormat = tfHourMin
        Width = 50
      end
      object tvOrdersPaymentType: TcxGridDBColumn
        DataBinding.FieldName = 'PaymentType'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Alignment.Vert = taVCenter
        Properties.Images = SummaryFooterDemoDataDM.PaymentTypeImages
        Properties.Items = <
          item
            Description = 'Am. Express'
            ImageIndex = 3
            Value = 'AmEx'
          end
          item
            Description = 'Cash'
            ImageIndex = 0
            Value = 'Cash'
          end
          item
            Description = 'Master'
            ImageIndex = 2
            Value = 'Master'
          end
          item
            Description = 'Visa'
            ImageIndex = 1
            Value = 'Visa'
          end>
      end
      object tvOrdersPaymentAmount: TcxGridDBColumn
        DataBinding.FieldName = 'PaymentAmount'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.Alignment.Horz = taRightJustify
      end
      object tvOrdersDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        PropertiesClassName = 'TcxBlobEditProperties'
        Properties.BlobEditKind = bekMemo
      end
      object tvOrdersQuantity: TcxGridDBColumn
        DataBinding.FieldName = 'Quantity'
        PropertiesClassName = 'TcxSpinEditProperties'
        Width = 30
      end
    end
    object lvCars: TcxGridLevel
      GridView = tvCars
      MaxDetailHeight = 200
      object lvOrders: TcxGridLevel
        GridView = tvOrders
      end
    end
  end
  inherited mmMain: TMainMenu
    object miOptions: TMenuItem [1]
      Caption = 'Options'
      object miSummaries: TMenuItem
        Caption = 'Su&mmary'
        Hint = 'Displays the brief description of the current demo features'
        object miCustomizeSummaries: TMenuItem
          Caption = '&Customize Summaries...'
          Hint = 'Press to customize summaries'
          OnClick = miCustomizeSummariesClick
        end
        object N2: TMenuItem
          Caption = '-'
        end
        object miSelectedRecordOnly: TMenuItem
          AutoCheck = True
          Caption = 'C&alculate on selected records only'
          Hint = 'Check to calculate on selected records only'
          OnClick = miSelectedRecordOnlyClick
        end
        object miIgnoreNullValues: TMenuItem
          AutoCheck = True
          Caption = '&Ignore Null Values when calculating'
          Hint = 
            'Ignore Null values when calculating Count and Average summary ki' +
            'nds'
          OnClick = miIgnoreNullValuesClick
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miFooter: TMenuItem
        AutoCheck = True
        Caption = 'Show &Footer'
        Hint = 'Show view footer '
        OnClick = miFooterClick
      end
      object miMultiSelect: TMenuItem
        AutoCheck = True
        Caption = '&Multi Select'
        Hint = 'Check to select more than one record'
        OnClick = miMultiSelectClick
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
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = Grid
    PopupMenus = <>
    Left = 440
    Top = 8
  end
end
