inherited frmMain: TfrmMain
  Left = 300
  Top = 120
  Caption = 'ExpressQuantumGrid Master-Detail Chart Demo'
  ClientHeight = 646
  ClientWidth = 892
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited lbDescription: TLabel
    Width = 892
    Height = 32
    Caption = 
      '  This demo shows how the ChartView can be used as a detail view' +
      ' in a master-detail grid. Click '#39'About this demo'#39' for more infor' +
      'mation.'
  end
  inherited sbMain: TStatusBar
    Top = 627
    Width = 892
  end
  object grMain: TcxGrid [2]
    Left = 0
    Top = 32
    Width = 892
    Height = 595
    Align = alClient
    TabOrder = 0
    object tvCustomers: TcxGridDBTableView
      DataController.DataSource = dsCustomers
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      object tvCustomersID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        Width = 34
      end
      object tvCustomersFirstName: TcxGridDBColumn
        DataBinding.FieldName = 'FirstName'
        Width = 77
      end
      object tvCustomersLastName: TcxGridDBColumn
        DataBinding.FieldName = 'LastName'
        Width = 79
      end
      object tvCustomersCompany: TcxGridDBColumn
        DataBinding.FieldName = 'Company'
        Width = 135
      end
      object tvCustomersAddress: TcxGridDBColumn
        DataBinding.FieldName = 'Address'
        Width = 133
      end
      object tvCustomersCity: TcxGridDBColumn
        DataBinding.FieldName = 'City'
        Width = 77
      end
      object tvCustomersState: TcxGridDBColumn
        DataBinding.FieldName = 'State'
        Width = 57
      end
      object tvCustomersZipCode: TcxGridDBColumn
        DataBinding.FieldName = 'ZipCode'
      end
      object tvCustomersEmail: TcxGridDBColumn
        DataBinding.FieldName = 'Email'
        Width = 181
      end
    end
    object chvOrders: TcxGridDBChartView
      Categories.DataBinding.FieldName = 'ID'
      Categories.OnGetValueDisplayText = chvOrdersCategoriesGetValueDisplayText
      DataController.DataSource = dsOrders
      DataController.DetailKeyFieldNames = 'CustomerID'
      DataController.MasterKeyFieldNames = 'ID'
      DiagramColumn.Active = True
      DiagramColumn.AxisCategory.GridLines = False
      DiagramColumn.AxisCategory.TickMarkKind = tmkNone
      Legend.Position = cppNone
      OptionsView.CategoriesPerPage = 10
      OnGetValueHint = chvOrdersGetValueHint
      object chvOrdersPaymentAmountSeries: TcxGridDBChartSeries
        DataBinding.FieldName = 'PaymentAmount'
        DisplayText = 'Payment Amount'
        SortOrder = soDescending
        ValueCaptionFormat = '$,0'
      end
      object chvOrdersProductIDSeries: TcxGridDBChartSeries
        DataBinding.FieldName = 'ProductID'
        Visible = False
      end
      object chvOrdersQuantitySeries: TcxGridDBChartSeries
        DataBinding.FieldName = 'Quantity'
        Visible = False
      end
    end
    object chvProducts: TcxGridDBChartView
      Categories.DataBinding.FieldName = 'Name'
      DataController.DataModeController.DetailInSQLMode = True
      DataController.DataSource = dsProducts
      DataController.DetailKeyFieldNames = 'CustomerID'
      DataController.MasterKeyFieldNames = 'ID'
      DiagramColumn.Active = True
      DiagramColumn.AxisValue.Title.Text = 'Copies'
      DiagramColumn.Values.VaryColorsByCategory = True
      Legend.Position = cppNone
      object chvProductsCopiesSeries: TcxGridDBChartSeries
        DataBinding.FieldName = 'SUM OF Quantity'
        DisplayText = 'Quantity'
      end
    end
    object grMainLevel1: TcxGridLevel
      GridView = tvCustomers
      MaxDetailHeight = 250
      Options.DetailTabsPosition = dtpTop
      object grMainLevel2: TcxGridLevel
        Caption = 'Orders'
        GridView = chvOrders
      end
      object grMainLevel3: TcxGridLevel
        Caption = 'Products'
        GridView = chvProducts
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
    Left = 324
    Top = 116
  end
  object dsOrders: TDataSource
    DataSet = tblOrders
    Left = 376
    Top = 172
  end
  object tblOrders: TTable
    Active = True
    DatabaseName = 'DemosDB'
    IndexFieldNames = 'CustomerID'
    TableName = 'Orders.DB'
    Left = 404
    Top = 172
    object tblOrdersID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object tblOrdersCustomerID: TIntegerField
      FieldName = 'CustomerID'
    end
    object tblOrdersProductID: TIntegerField
      FieldName = 'ProductID'
    end
    object tblOrdersPurchaseDate: TDateTimeField
      FieldName = 'PurchaseDate'
    end
    object tblOrdersTime: TDateTimeField
      FieldName = 'Time'
    end
    object tblOrdersPaymentType: TStringField
      FieldName = 'PaymentType'
      Size = 7
    end
    object tblOrdersPaymentAmount: TCurrencyField
      FieldName = 'PaymentAmount'
    end
    object tblOrdersDescription: TMemoField
      FieldName = 'Description'
      BlobType = ftMemo
      Size = 10
    end
    object tblOrdersQuantity: TIntegerField
      FieldName = 'Quantity'
    end
  end
  object tblProducts: TTable
    Active = True
    DatabaseName = 'DemosDB'
    IndexFieldNames = 'ID'
    TableName = 'PRODUCTS.DB'
    Left = 388
    Top = 144
  end
  object tblCustomers: TTable
    Active = True
    DatabaseName = 'DemosDB'
    TableName = 'Customers.DB'
    Left = 388
    Top = 116
  end
  object dsCustomers: TDataSource
    DataSet = tblCustomers
    Left = 360
    Top = 116
  end
  object qryProducts: TQuery
    Active = True
    DatabaseName = 'DemosDB'
    SQL.Strings = (
      'SELECT'
      '  O.CustomerID, P.Name, SUM(O.Quantity)'
      'FROM'
      '  Orders.db O, Products.db P'
      'WHERE'
      
        '  (O.ProductID = P.ID) AND (O.CustomerID = :CustomerID) AND (P.N' +
        'ame LIKE '#39'Express%'#39')'
      'GROUP BY'
      '  O.CustomerID, P.Name')
    Left = 404
    Top = 200
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CustomerID'
        ParamType = ptUnknown
        Value = 12
      end>
  end
  object dsProducts: TDataSource
    DataSet = qryProducts
    Left = 376
    Top = 200
  end
end
