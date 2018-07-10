inherited frmMain: TfrmMain
  Left = 300
  Top = 120
  Caption = 'ExpressQuantumGrid LayoutView Demo'
  ClientHeight = 606
  ClientWidth = 688
  Constraints.MinHeight = 660
  Constraints.MinWidth = 700
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited lbDescription: TLabel
    Width = 688
    Height = 32
    Caption = 
      'This demo illustrates the basic features provided by Layout View' +
      's (runtime field customization in cards, card collapsing, multip' +
      'le selection and runtime record layout customization).'
  end
  object Grid: TcxGrid [1]
    Left = 0
    Top = 125
    Width = 688
    Height = 462
    Align = alClient
    TabOrder = 0
    LevelTabs.Slants.Positions = []
    object LayoutView: TcxGridDBLayoutView
      FilterBox.Visible = fvNever
      DataController.DataSource = dsCars
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Images = Images
      OptionsCustomize.RecordExpanding = True
      OptionsView.MinValueWidth = 40
      OptionsView.ShowItemFilterButtons = sfbAlways
      OptionsView.ShowOnlyEntireRecords = False
      OptionsView.ViewMode = lvvmSingleRow
      Styles.Content = stValues
      Styles.Selection = stRecordSelected
      Styles.Item = stItems
      Styles.RecordCaption = stRecordCaption
      object LayoutViewRecId: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'RecId'
        Visible = False
        LayoutItem = LayoutViewLayoutItem1
      end
      object LayoutViewID: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'ID'
        LayoutItem = LayoutViewLayoutItem2
      end
      object LayoutViewTrademark: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'Trademark'
        LayoutItem = LayoutViewLayoutItem3
      end
      object LayoutViewModel: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'Model'
        LayoutItem = LayoutViewLayoutItem4
      end
      object LayoutViewHP: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'HP'
        LayoutItem = LayoutViewLayoutItem5
      end
      object LayoutViewLiter: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'Liter'
        LayoutItem = LayoutViewLayoutItem6
      end
      object LayoutViewCyl: TcxGridDBLayoutViewItem
        Caption = 'Cylinder'
        DataBinding.FieldName = 'Cyl'
        LayoutItem = LayoutViewLayoutItem7
      end
      object LayoutViewTransmissSpeedCount: TcxGridDBLayoutViewItem
        Caption = 'Speed Count'
        DataBinding.FieldName = 'TransmissSpeedCount'
        LayoutItem = LayoutViewLayoutItem8
      end
      object LayoutViewTransmissAutomatic: TcxGridDBLayoutViewItem
        Caption = 'Automatic'
        DataBinding.FieldName = 'TransmissAutomatic'
        RepositoryItem = EditRepositoryAutomatic
        LayoutItem = LayoutViewLayoutItem9
      end
      object LayoutViewMPG_City: TcxGridDBLayoutViewItem
        Caption = 'City (mpg)'
        DataBinding.FieldName = 'MPG_City'
        LayoutItem = LayoutViewLayoutItem10
      end
      object LayoutViewMPG_Highway: TcxGridDBLayoutViewItem
        Caption = 'Highway (mpg)'
        DataBinding.FieldName = 'MPG_Highway'
        LayoutItem = LayoutViewLayoutItem11
      end
      object LayoutViewCategory: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'Category'
        LayoutItem = LayoutViewLayoutItem12
      end
      object LayoutViewDescription: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'Description'
        RepositoryItem = EditRepositoryMemo
        LayoutItem = LayoutViewLayoutItem13
      end
      object LayoutViewHyperlink: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'Hyperlink'
        RepositoryItem = EditRepositoryHyperLink
        LayoutItem = LayoutViewLayoutItem14
        Options.Filtering = False
      end
      object LayoutViewPicture: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'Picture'
        RepositoryItem = EditRepositoryImage
        LayoutItem = LayoutViewLayoutItem15
      end
      object LayoutViewPrice: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'Price'
        RepositoryItem = EditRepositoryPrice
        LayoutItem = LayoutViewLayoutItem16
        Options.Filtering = False
      end
      object LayoutViewGroup_Root: TdxLayoutGroup
        AlignHorz = ahLeft
        AlignVert = avTop
        ButtonOptions.Buttons = <>
        Hidden = True
        ItemIndex = 1
        ShowBorder = False
        Index = -1
      end
      object LayoutViewGroup1: TdxLayoutGroup
        CaptionOptions.Text = 'Engine'
        Parent = LayoutViewGroup3
        ButtonOptions.Buttons = <>
        LayoutDirection = ldHorizontal
        Index = 1
      end
      object LayoutViewGroup2: TdxLayoutGroup
        CaptionOptions.Text = 'Transmission'
        Parent = LayoutViewGroup3
        ButtonOptions.Buttons = <>
        Index = 0
      end
      object LayoutViewGroup3: TdxLayoutGroup
        CaptionOptions.Text = 'New Group'
        ButtonOptions.Buttons = <>
        LayoutDirection = ldTabbed
        ShowBorder = False
        Index = -1
      end
      object LayoutViewLayoutItem1: TcxGridLayoutItem
        Index = -1
      end
      object LayoutViewLayoutItem2: TcxGridLayoutItem
        Index = -1
      end
      object LayoutViewLayoutItem3: TcxGridLayoutItem
        AlignHorz = ahClient
        AlignVert = avTop
        CaptionOptions.Visible = False
        Parent = LayoutViewGroup11
        SizeOptions.Width = 151
        Index = 0
      end
      object LayoutViewLayoutItem4: TcxGridLayoutItem
        AlignHorz = ahClient
        AlignVert = avTop
        CaptionOptions.AlignVert = tavBottom
        CaptionOptions.Visible = False
        Parent = LayoutViewGroup11
        SizeOptions.Width = 151
        Index = 1
      end
      object LayoutViewLayoutItem5: TcxGridLayoutItem
        AlignHorz = ahClient
        Parent = LayoutViewGroup8
        SizeOptions.Width = 64
        Index = 4
      end
      object LayoutViewLayoutItem6: TcxGridLayoutItem
        AlignHorz = ahClient
        Parent = LayoutViewGroup8
        SizeOptions.Width = 75
        Index = 2
      end
      object LayoutViewLayoutItem7: TcxGridLayoutItem
        AlignHorz = ahLeft
        Parent = LayoutViewGroup8
        SizeOptions.Width = 118
        Index = 0
      end
      object LayoutViewLayoutItem8: TcxGridLayoutItem
        AlignHorz = ahClient
        Parent = LayoutViewGroup10
        Index = 0
      end
      object LayoutViewLayoutItem9: TcxGridLayoutItem
        AlignHorz = ahClient
        Parent = LayoutViewGroup10
        Index = 2
      end
      object LayoutViewLayoutItem10: TcxGridLayoutItem
        AlignHorz = ahClient
        Parent = LayoutViewGroup9
        Index = 0
      end
      object LayoutViewLayoutItem11: TcxGridLayoutItem
        AlignHorz = ahClient
        Parent = LayoutViewGroup9
        Index = 2
      end
      object LayoutViewLayoutItem12: TcxGridLayoutItem
        Parent = LayoutViewGroup5
        SizeOptions.Width = 89
        Index = 0
      end
      object LayoutViewLayoutItem13: TcxGridLayoutItem
        CaptionOptions.ImageIndex = 0
        CaptionOptions.Visible = False
        Parent = LayoutViewGroup6
        SizeOptions.Height = 100
        Index = 1
      end
      object LayoutViewLayoutItem14: TcxGridLayoutItem
        CaptionOptions.ImageIndex = 1
        CaptionOptions.VisibleElements = [cveImage]
        Parent = LayoutViewGroup7
        Index = 3
      end
      object LayoutViewLayoutItem15: TcxGridLayoutItem
        CaptionOptions.Visible = False
        Parent = LayoutViewGroup11
        SizeOptions.Height = 94
        SizeOptions.Width = 212
        Index = 2
      end
      object LayoutViewLayoutItem16: TcxGridLayoutItem
        AlignVert = avBottom
        CaptionOptions.ImageIndex = 3
        Parent = LayoutViewGroup5
        SizeOptions.Width = 78
        Index = 2
      end
      object LayoutViewGroup4: TdxLayoutGroup
        CaptionOptions.Text = 'New Group'
        CaptionOptions.Visible = False
        Parent = LayoutViewGroup_Root
        SizeOptions.Width = 296
        ButtonOptions.Buttons = <>
        LayoutDirection = ldHorizontal
        Index = 0
      end
      object LayoutViewGroup5: TdxLayoutGroup
        Parent = LayoutViewGroup4
        SizeOptions.Width = 131
        ButtonOptions.Buttons = <>
        Hidden = True
        ShowBorder = False
        Index = 2
      end
      object LayoutViewGroup6: TdxLayoutGroup
        CaptionOptions.Text = 'New Group'
        CaptionOptions.Visible = False
        Parent = LayoutViewGroup_Root
        SizeOptions.Width = 267
        ButtonOptions.Buttons = <>
        LayoutDirection = ldTabbed
        ShowBorder = False
        Index = 1
      end
      object LayoutViewGroup7: TdxLayoutGroup
        CaptionOptions.ImageIndex = 2
        CaptionOptions.Text = 'Information'
        Parent = LayoutViewGroup6
        ButtonOptions.Buttons = <>
        Index = 0
      end
      object LayoutViewGroup8: TdxLayoutGroup
        CaptionOptions.Text = 'Engine'
        Parent = LayoutViewGroup7
        ButtonOptions.Buttons = <>
        LayoutDirection = ldHorizontal
        Index = 0
      end
      object LayoutViewSpaceItem1: TdxLayoutEmptySpaceItem
        CaptionOptions.Text = 'Empty Space Item'
        Parent = LayoutViewGroup4
        SizeOptions.Height = 10
        SizeOptions.Width = 11
        Index = 1
      end
      object LayoutViewGroup10: TdxLayoutGroup
        CaptionOptions.Text = 'Transmission'
        Parent = LayoutViewGroup7
        ButtonOptions.Buttons = <>
        ItemIndex = -1
        LayoutDirection = ldHorizontal
        Index = 1
      end
      object LayoutViewSeparatorItem1: TdxLayoutSeparatorItem
        CaptionOptions.Text = 'Separator'
        Parent = LayoutViewGroup5
        SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
        SizeOptions.SizableHorz = False
        SizeOptions.SizableVert = False
        Index = 1
      end
      object LayoutViewGroup9: TdxLayoutGroup
        CaptionOptions.Text = 'Fuel economy'
        Parent = LayoutViewGroup7
        ButtonOptions.Buttons = <>
        LayoutDirection = ldHorizontal
        Index = 2
      end
      object LayoutViewSpaceItem2: TdxLayoutEmptySpaceItem
        AlignHorz = ahClient
        CaptionOptions.Text = 'Empty Space Item'
        Parent = LayoutViewGroup9
        SizeOptions.Height = 10
        SizeOptions.Width = 22
        Index = 1
      end
      object LayoutViewSpaceItem3: TdxLayoutEmptySpaceItem
        CaptionOptions.Text = 'Empty Space Item'
        Parent = LayoutViewGroup8
        SizeOptions.Height = 10
        SizeOptions.Width = 21
        Index = 1
      end
      object LayoutViewSpaceItem4: TdxLayoutEmptySpaceItem
        CaptionOptions.Text = 'Empty Space Item'
        Parent = LayoutViewGroup8
        SizeOptions.Height = 10
        SizeOptions.Width = 15
        Index = 3
      end
      object LayoutViewSpaceItem5: TdxLayoutEmptySpaceItem
        CaptionOptions.Text = 'Empty Space Item'
        Parent = LayoutViewGroup10
        SizeOptions.Height = 10
        SizeOptions.Width = 30
        Index = 1
      end
      object LayoutViewGroup11: TdxLayoutGroup
        Parent = LayoutViewGroup4
        ButtonOptions.Buttons = <>
        Hidden = True
        ShowBorder = False
        Index = 0
      end
    end
    object GridLevel1: TcxGridLevel
      GridView = LayoutView
    end
  end
  object GroupBox: TcxGroupBox [2]
    Left = 0
    Top = 32
    Align = alTop
    PanelStyle.Active = True
    PanelStyle.OfficeBackgroundKind = pobkGradient
    TabOrder = 1
    Height = 93
    Width = 688
    object rgViewMode: TcxRadioGroup
      Left = 8
      Top = 5
      Caption = ' View Mode '
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Single Record'
        end
        item
          Caption = 'Single Row'
        end
        item
          Caption = 'Multiple Rows'
        end
        item
          Caption = 'Single Column'
        end
        item
          Caption = 'Multiple Columns'
        end>
      ItemIndex = 1
      TabOrder = 0
      OnClick = rgViewModeClick
      Height = 78
      Width = 233
    end
    object cbRecordCaptions: TcxCheckBox
      Left = 414
      Top = 14
      Caption = 'Record Captions'
      State = cbsChecked
      TabOrder = 1
      Transparent = True
      OnClick = cbRecordCaptionsClick
      Width = 137
    end
    object cbCenterRecords: TcxCheckBox
      Left = 263
      Top = 14
      Caption = 'Center Records'
      State = cbsChecked
      TabOrder = 2
      Transparent = True
      OnClick = cbCenterRecordsClick
      Width = 97
    end
    object cbShowOnlyEntireRecords: TcxCheckBox
      Left = 263
      Top = 37
      Caption = 'Only Entire Records'
      TabOrder = 3
      Transparent = True
      OnClick = cbShowOnlyEntireRecordsClick
      Width = 153
    end
    object cbExpandableRecords: TcxCheckBox
      Left = 414
      Top = 37
      Caption = 'Record Expand Button'
      State = cbsChecked
      TabOrder = 4
      Transparent = True
      OnClick = cbExpandableRecordsClick
      Width = 171
    end
    object cbMultiSelectRecords: TcxCheckBox
      Left = 263
      Top = 60
      Caption = 'Multi-select Records'
      TabOrder = 5
      Transparent = True
      OnClick = cbMultiSelectRecordsClick
      Width = 145
    end
    object btnCustomize: TcxButton
      Left = 563
      Top = 54
      Width = 113
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Customize Layout'
      TabOrder = 6
      OnClick = btnCustomizeClick
      LookAndFeel.NativeStyle = True
    end
  end
  inherited sbMain: TStatusBar
    Top = 587
    Width = 688
  end
  inherited mmMain: TMainMenu
    Left = 44
    Top = 138
    object miView: TMenuItem [1]
      Caption = '&View'
      object miCustomize: TMenuItem
        Caption = 'Customize...'
        OnClick = miCustomizeClick
      end
    end
  end
  inherited StyleRepository: TcxStyleRepository
    Left = 156
    Top = 139
    PixelsPerInch = 96
    object stValues: TcxStyle [24]
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic]
      TextColor = clMaroon
    end
    object stItems: TcxStyle [25]
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object stHeader: TcxStyle [26]
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object stRecordCaption: TcxStyle [27]
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic]
    end
    object stRecordSelected: TcxStyle [28]
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      TextColor = clNavy
    end
    inherited GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet
      BuiltIn = True
    end
    inherited GridCardViewStyleSheetDevExpress: TcxGridCardViewStyleSheet
      BuiltIn = True
    end
  end
  object dsCars: TDataSource
    DataSet = mdCars
    Left = 72
    Top = 138
  end
  object EditRepository: TcxEditRepository
    Left = 100
    Top = 138
    object EditRepositoryImage: TcxEditRepositoryImageItem
      Properties.GraphicClassName = 'TJPEGImage'
      Properties.Stretch = True
    end
    object EditRepositoryMemo: TcxEditRepositoryMemoItem
      Properties.VisibleLineCount = 10
    end
    object EditRepositoryHyperLink: TcxEditRepositoryHyperLinkItem
    end
    object EditRepositoryPrice: TcxEditRepositoryCurrencyItem
      Properties.AutoSelect = False
      Properties.HideSelection = False
    end
    object EditRepositoryAutomatic: TcxEditRepositoryCheckBoxItem
      Properties.ValueChecked = 'Yes'
      Properties.ValueUnchecked = 'No'
    end
  end
  object mdCars: TdxMemData
    Active = True
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F0F000000040000000C000300494400320000000100
      0A0054726164656D61726B0032000000010006004D6F64656C00020000000200
      030048500008000000060006004C6974657200020000000200040043796C0002
      000000020014005472616E736D6973735370656564436F756E74000300000001
      0013005472616E736D6973734175746F6D617469630002000000020009004D50
      475F43697479000200000002000C004D50475F48696768776179000700000001
      00090043617465676F727900000000000E000C004465736372697074696F6E00
      3200000001000A0048797065726C696E6B000000000011000800506963747572
      650008000000060006005072696365000101000000010D0000004D6572636564
      65732D42656E7A010E000000534C35303020526F616473746572012E010177BE
      9F1A2FDD13400108000105000103000000596573011000011700010600000053
      504F5254534B060000456E67696E6520342C3936362D636320534F4843203234
      2D76616C7665203930B020562D382E20486967682D7072657373757265206469
      652D6361737420616C6C6F792063796C696E64657220626C6F636B2C20616C6C
      6F792068656164732E200D0A0D0A4E657420706F776572203330322068702040
      20352C3630302072706D0D0A0D0A4E657420746F7271756520333339206C622D
      667420746F72717565204020322C3730302D342C3235302072706D0D0A0D0A43
      6F6D7072657373696F6E20726174696F2031302E303A312E0D0A0D0A4675656C
      20726571756972656D656E74205072656D69756D20756E6C65616465642C2039
      312070756D70206F6374616E652E0D0A0D0A4675656C20616E642069676E6974
      696F6E2073797374656D204D4520322E3820656E67696E65206D616E6167656D
      656E742E20496E74656772617465642073657175656E7469616C206D756C7469
      706F696E74206675656C20696E6A656374696F6E20616E642070686173656420
      7477696E2D737061726B2069676E6974696F6E20696E636C7564657320696E64
      6976696475616C2063796C696E64657220636F6E74726F6C206F66206675656C
      2073707261792C20737061726B2074696D696E672F706861736520616E642061
      6E74696B6E6F636B2E2054776F20686967682D656E657267792069676E697469
      6F6E20636F696C7320616E642074776F20737061726B20706C75677320706572
      2063796C696E6465722C2077697468203130302C3030302D6D696C6520737061
      726B20706C756720696E74657276616C732E20456C656374726F6E6963207468
      726F74746C6520636F6E74726F6C2E0D0A0D0A496E74616B652073797374656D
      204D61676E657369756D20322D7374616765207265736F6E616E636520696E74
      616B65206D616E69666F6C6420696E637265617365732072756E6E6572206C65
      6E677468206174206C6F7765722072706D20666F7220696D70726F7665642072
      6573706F6E73652E20537461696E6C6573732D737465656C2065786861757374
      2073797374656D2077697468206475616C206368726F6D652066696E69736865
      72732E0D0A0D0A5472616E736D697373696F6E20456C656374726F6E69632035
      2D7370656564206175746F6D617469632077697468206472697665722D616461
      707469766520636F6E74726F6C2E20546F75636820536869667420616C6C6F77
      732064726976657220746F206D616E75616C6C7920646F776E73686966742061
      6E6420616C6C6F77207570736869667473206279206E756467696E6720746865
      207368696674206C6576657220746F20746865206C656674206F722072696768
      742066726F6D2074686520447269766520706F736974696F6E2E204472697665
      722D73656C65637461626C652077696E746572206D6F64652073746172747320
      76656869636C65206D6F76696E6720696E20326E642067656172206F72206120
      7370656369616C207365636F6E642052657665727365206765617220746F2068
      656C7020696D70726F76652074616B656F6666206F6E20736C69707065727920
      73757266616365732E20446973706C617920696E20696E737472756D656E7420
      636C757374657220696E646963617465732073656C6563746564206765617220
      72616E676520616E642077696E7465722F7374616E64617264206D6F64652E0D
      0A0D0A526561722061786C6520726174696F20322E38323A310D0A200D0A0D0A
      2A204D53525020696E636C756465732024363635207472616E73706F72746174
      696F6E20616E642068616E646C696E672063686172676520616E64206578636C
      7564657320616C6C2074617865732C207469746C652F646F63756D656E746172
      7920666565732C20726567697374726174696F6E2C20746167732C204D657263
      656465732D42656E7A204465616C657220707265702C206C61626F7220616E64
      20696E7374616C6C6174696F6E20636861726765732C20696E737572616E6365
      2C206F7074696F6E616C2065717569706D656E7420616E64206163636573736F
      726965732C206365727469666963617465206F6620636F6D706C69616E636520
      6F72206E6F6E2D636F6D706C69616E636520666565732C20616E642066696E61
      6E636520636861726765732E2041637475616C20707269636573206D61792076
      617279206279204465616C65722E200D0A200D0A0117000000687474703A2F2F
      7777772E6D657263656465732E636F6D0000000001000000008075F440}
    SortOptions = []
    Left = 128
    Top = 138
    object mdCarsID: TAutoIncField
      FieldName = 'ID'
    end
    object mdCarsTrademark: TStringField
      FieldName = 'Trademark'
      Size = 50
    end
    object mdCarsModel: TStringField
      FieldName = 'Model'
      Size = 50
    end
    object mdCarsHP: TSmallintField
      FieldName = 'HP'
    end
    object mdCarsLiter: TFloatField
      FieldName = 'Liter'
    end
    object mdCarsCyl: TSmallintField
      FieldName = 'Cyl'
    end
    object mdCarsTransmissSpeedCount: TSmallintField
      FieldName = 'TransmissSpeedCount'
    end
    object mdCarsTransmissAutomatic: TStringField
      FieldName = 'TransmissAutomatic'
      Size = 3
    end
    object mdCarsMPG_City: TSmallintField
      FieldName = 'MPG_City'
    end
    object mdCarsMPG_Highway: TSmallintField
      FieldName = 'MPG_Highway'
    end
    object mdCarsCategory: TStringField
      FieldName = 'Category'
      Size = 7
    end
    object mdCarsDescription: TMemoField
      FieldName = 'Description'
      BlobType = ftMemo
      Size = 10
    end
    object mdCarsHyperlink: TStringField
      FieldName = 'Hyperlink'
      Size = 50
    end
    object mdCarsPicture: TBlobField
      FieldName = 'Picture'
      BlobType = ftParadoxOle
      Size = 10
    end
    object mdCarsPrice: TFloatField
      FieldName = 'Price'
    end
  end
  object Images: TcxImageList
    FormatVersion = 1
    DesignInfo = 12058672
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000101010108282
          82FF828282FF828282FF818181FF818181FF818181FFBBB8B4FFBBB8B4FFBBB8
          B4FFBBB8B4FFBBB8B4FFBBB8B4FFBBB8B4FFBBB8B4FFBBB8B4FF404040408F8F
          8FFFFDFDFDFFADBBD7FFF9F9F9FFF9F9F9FFF9F9F9FFBBB8B4FFFEFDFCFFFDFB
          F8FFEDD8CBFFC1805CFFF5E9E0FFFAF3ECFFFAF2E9FFBBB8B4FF404040409999
          99FF959596FFADBBD7FFE2C1A3FFE2C1A3FFE2C1A3FFBBB8B4FFFDFBF8FFFDF9
          F5FFC6855BFFC57941FFCE997AFFFAF2E9FFF9F0E6FFBBB8B4FF40404040A2A2
          A2FFFAFAFAFFADBBD7FFEBEBEBFFEBEBEBFFEBEBEBFFBBB8B4FFFDF9F5FFE9D2
          C4FFD38F55FFD28C4FFFBE6B30FFF3E4D8FFF8EEE2FFBBB8B4FF40404040AAAA
          AAFFE2C1A3FFADBBD7FFE2C1A3FFE2C1A3FFE2C1A3FFBBB8B4FFFCF7F2FFDFBA
          A2FFD1966BFFCD9675FFD08442FFCD9775FFF7ECDFFFBBB8B4FF40404040AFAF
          AFFFFBFBFBFFADBBD7FFF0F0F0FFF0F0F0FFF0F0F0FFBBB8B4FFFBF5EFFFFAF3
          ECFFFAF2E9FFF9F0E6FFCF9060FFB66028FFF0DFCEFFBBB8B4FF40404040B5B5
          B5FFE2C1A3FFADBBD7FFE2C1A3FFE2C1A3FFE2C1A3FFBBB8B4FFFAF3ECFFFAF2
          E9FFF9F0E6FFF8EEE2FFD7AC90FFB6622DFFC88E6DFFBBB8B4FF40404040B8B8
          B8FF959596FFADBBD7FFF4F4F4FFF5F5F5FFF5F5F5FFBBB8B4FFFAF2E9FFF9F0
          E6FFF8EEE2FFF7ECDFFFF6EADCFFBE7A55FFC38561FFBBB8B4FF40404040BBBB
          BBFFE2C1A3FFADBBD7FFE2C1A3FFE2C1A3FFE2C1A3FFBBB8B4FFBBB8B4FFBBB8
          B4FFBBB8B4FFBBB8B4FFBBB8B4FFBBB8B4FFBBB8B4FFBBB8B4FF40404040BDBD
          BDFFFDFDFDFFADBBD7FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF7F7F7FFF6F6
          F6FFF5F5F5FFF4F4F4FFFCFCFCFFBDBDBDFF000000000000000040404040BEBE
          BEFFE2C1A3FFADBBD7FFE2C1A3FFE2C1A3FFE2C1A3FFE2C1A3FFE2C1A3FFE2C1
          A3FFE2C1A3FFE2C1A3FFE2C1A3FFBEBEBEFF000000000000000040404040BFBF
          BFFFFDFDFDFFADBBD7FFFAFAFAFFFAFAFAFFFBFBFBFFFAFAFAFFFAFAFAFFF9F9
          F9FFF8F8F8FFF6F6F6FFFDFDFDFFBFBFBFFF000000000000000040404040C0C0
          C0FFE2C1A3FFADBBD7FFE2C1A3FFE2C1A3FFE2C1A3FFE2C1A3FFE2C1A3FFE2C1
          A3FFC0C0C0FFCBCBCBFFDBDBDBFFB3B3B3EF000000000000000040404040C0C0
          C0FF959596FFADBBD7FFFBFBFBFFFCFCFCFFFCFCFCFFFCFCFCFFFBFBFBFFFAFA
          FAFFCBCBCBFFE2E2E2FFB4B4B4EF24242430000000000000000040404040C0C0
          C0FFFFFFFFFFADBBD7FFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFAFA
          FAFFDBDBDBFFB4B4B4EF2424243000000000000000000000000010101010C0C0
          C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
          C0FFB4B4B4EF2424243000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000006D6D6DBFB2B2B2FF41414170000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000003E3E3E70BDBEBEFF949595FF44444470000000000000
          0000000000001005042042241F8F613D36BF7F6559EF8A8877FF6F645ABF4C3A
          3580080302101B1B1B30A1A1A1EF999A9AFF7F8080CF00000000000000000000
          0000290E0760602915EF6A3926FF744939FF687158FF698B71FF7D9C84FF94AD
          9AFF938C81F08A8787E1A0A0A0FF808282CF0909091000000000000000002E11
          086075310BFF6C2600FF6D2702FF60421CFF63836DFF747B75FF7F827FFF8990
          8AFF8C908AFF9FA0A0FF838281E1090909100000000000000000180904408B41
          0EFF814004FF4D611BFF50631AFF758274FF7B9279FF8CB289FF8FAF8EFF95AD
          97FF9A9F99FF918F90FF886C67FF1005042000000000000000005C2B0C9FA354
          05FF4B8223FF238514FF688C60FF76906CFF8DBB80FF8BB57FFF89AE7FFF87A8
          81FF89A98BFFA0A19DFF78645FFF492B269F00000000000000009D5410EFB96B
          01FF469927FF2A9D0DFF73816CFF92C571FF90C076FF8EBA77FF8DB97CFF89B3
          7FFF89AE84FF90A58BFF8A7B78FF5A2F26EF0000000000000000B46C13FFCC8A
          0FFF60B241FF3BB11EFF7A8C6FFF97CE70FF95CE80FF93CA80FF8FBE7BFF86C4
          8AFF89B07AFF84A377FF8D8782FF452A13FF0000000000000000BE7E1FFFDBA6
          2CFFD7B848FF6CD170FF7B8B77FFA0DD95FFBED894FFAFD493FFA9C686FF8CC1
          81FF8BAE73FF87AA83FF81887BFF2C461BFF0000000000000000B87F2BEFE8BC
          4FFFF0D075FFCCE19DFF87A291FF9CC68EFF9CDF99FF9BDFA6FF8FCE96FF92C2
          81FF8FBD78FF94A18AFF44653FFF273A14EF00000000000000007650259FEECA
          6AFFF7DF9AFFF4EEBFFFC8E6C3FF89908BFF96C995FF9CD481FF8FD191FF82C9
          87FF8BAF8BFF7E8D7AFF0E570EFF262C139F00000000000000001E11093089B2
          3FFFFAE3A9FFFEF1CAFFD9EDCBFFB5D7B0FF87A290FF8F9C88FF95A48BFF8F9E
          8EFF6E936CFF2A7324FF246023FF120A0430000000000000000000000000182B
          06606EC44DFFCFE498FFC1DD89FFD4E0A1FF48DA8BFF4BCE85FF58BC73FF46AE
          6CFF308E39FF2C7B3AFF1D1D1160000000000000000000000000000000000000
          0000182B066018A00FEF1DC221FFA1C759FFB4C971FF8DC065FF5FC478FF54BA
          82FF5E8D69EF24281E6000000000000000000000000000000000000000000000
          0000000000001005042021370980426D35BF438836EF557F30EF426B3EBF2F2A
          1E70090F08200000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000090B1016A7C4FF16A7C4FF001C223000000000000000000138
          456016A7C4FF16A7C4FF00090B10000000000000000000000000000000000000
          00000000000016A7C4FF73D8E6FF77E0ECFF16A7C4FF16A7C4FF16A7C4FF1BAE
          C9FF37D5E6FF27C8DCFF16A7C4FF000000000000000000000000000000000000
          00000000000016A7C4FF98EAF3FF89E7F1FF74DFECFF6DE1EDFF59D9E8FF50DB
          EAFF41D8E8FF33D4E6FF16A7C4FF000000000000000000000000000000000000
          00000000000016A7C4FF9FEBF4FF8BE4EEFF6AD3E3FF74D6E5FF6DD5E4FF4CCD
          DFFF47D5E6FF37CFE1FF16A7C4FF000000000000000000000000012F395016A7
          C4FF16A7C4FF6BD3E3FF87DFEBFF8EDFEAFF16A7C4FF16A7C4FF16A7C4FF16A7
          C4FF61D5E5FF3FD0E2FF24BAD2FF16A7C4FF16A7C4FF0013172016A7C4FF50CD
          E0FF61D4E4FF84E6F0FF7DD8E6FF16A7C4FFA7A7A7FFA7A7A7FFA7A7A7FFA7A7
          A7FF16A7C4FF5AD0E1FF45D8E8FF2BC5DBFF22C1D7FF16A7C4FF16A7C4FF62DF
          ECFF6FE1EEFF64D5E4FF16A7C4FFA7A7A7FFFEFEFEFFFDFDFDFFF7F7F7FFE5E5
          E5FFA7A7A7FF16A7C4FF45D2E3FF42D8E8FF33D4E6FF16A7C4FF16A7C4FF44CB
          DEFF65DFECFF54CEE0FF16A7C4FFA7A7A7FFF9F9F9FFF9F9F9FFF4F4F4FFE5E5
          E5FFA7A7A7FF16A7C4FF43CBDEFF4DDAE9FF27BED5FF16A7C4FF0000000016A7
          C4FF47CBDEFF4DCDDFFF16A7C4FFA7A7A7FFE8E8E8FFEEEEEEFFE9E9E9FFDADA
          DAFFA7A7A7FF16A7C4FF4CCCDFFF34BDD4FF16A7C4FF00000000000000000013
          172016A7C4FF5FDEECFF16A7C4FFA7A7A7FFBCBCBCFFD5D5D5FFD2D2D2FFB9B9
          B9FFA7A7A7FF16A7C4FF71E1EEFF16A7C4FF000000000000000000000000012F
          395016A7C4FF55DCEAFF4FD1E2FF16A7C4FFA7A7A7FFA7A7A7FFA7A7A7FFA7A7
          A7FF16A7C4FF70D7E6FF7CE4EFFF16A7C4FF001C2230000000000000000016A7
          C4FF40D7E8FF4CDAE9FF58DDEBFF52D1E2FF16A7C4FF16A7C4FF16A7C4FF16A7
          C4FF8BE0ECFF95E9F2FF86E6F0FF78E3EFFF16A7C4FF000000000000000016A7
          C4FF33CEE1FF3BD0E2FF16A7C4FF5CDDEBFF68E0EDFF74E2EEFF81E5F0FF8DE8
          F1FF90E5EFFF16A7C4FF91E8F2FF7BE0ECFF16A7C4FF00000000000000000009
          0B1016A7C4FF16A7C4FF012F395016A7C4FF16A7C4FF6BE0EDFF77E3EFFF16A7
          C4FF16A7C4FF012F395016A7C4FF16A7C4FF00090B1000000000000000000000
          00000000000000000000000000000000000016A7C4FF62DEECFF6EE1EDFF16A7
          C4FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000C6F84AF16A7C4FF16A7C4FF0141
          5070000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000503
          020C3A1D1988793C1ADA934811ED7F3E16E046221A9D09040517010305070537
          6882075DB0D50263C4E70056B3D8073A6E8C01070D11000000000603020B6A38
          1DBFC4680FFFD16700FFD77A1AFFD6740EFFC96102FF6B3921D3145191C02D97
          F1FF3B9BF3FF2E91F0FF4A9CF1FF0373E6FF0756A5CC01070E1249260F7BD17D
          2BFFDF882DFFFCF4ECFFFDF9F4FFF8E6D4FFE2852BFF776957FF279FFBFF45A9
          F7FFEFF2F4FFEFF2F3FFE9EEF3FF4097F0FF006EE6FF073D74949E5A21DBE89D
          4FFFFDF7F0FFE5AD74FFE09E5BFFDB8E3FFFC8690BFF4B8BBDFF45B7FFFF30A1
          F5FF79C0F8FFE5EDF3FF007AECFF1783ECFF0074EBFF0661BEE3BF7530F0F2B7
          79FFFFFEFCFFFCF5EEFFFBF3EAFFE29A50FFBD640DFF4AA1E2FF52C0FFFF49B2
          F8FFEEF2F4FFF2F3F4FFD9E7F2FF0E83EDFF097DECFF0669CCEFAF6826DAF5B7
          78FFFEFAF4FFE8AA6AFFE59E55FFE49E56FFD7883CFF60A2D4FF5FCEFFFF4CB9
          FDFF9DD6FCFFEAF0F4FF2A9AF2FF2391F0FF1688F0FF0C65BFE35B300677F0B0
          70FFF9C791FFFEFBF7FFFEF8F2FFFAE9D8FFF4BB89FF7A7F78FF4DB5E1FF59BF
          FAFF7FD1FFFFEAF0F4FFE6EFF3FF4CAAF6FF1D8DEEFF09407696070300099757
          18BDF3B779FFFBC48AFFFFCA9AFFA3975EFF2A7210FF0C860BFF048A17FF127E
          30FF3996A3FF6FC9FFFF6DC4FDFF3AA4F3FF1363AED301080F14000000000A05
          000D6A360A88BB6F36D8857936FA008711FF04B41CFF6FD87AFFC8ECC4FF0AB3
          12FF008802FF2A868BFC3089DDDD114A86990109121700000000000000000000
          0000000000000B0B00240A761DF223C54BFFB6EABDFFEEF4E6FFEEF4E5FFA5E4
          ABFF13BC20FF017708F70311122F000000000000000000000000000000000000
          0000000000000027055A23B252FF3CC96BFF59CD76FF4AC862FFBEE6BBFFF3F6
          EAFF35C342FF01A30FFF0121006A000000000000000000000000000000000000
          00000000000006400B7A2EBE63FF29C265FF41C76BFFF0F5E9FFF5F7ECFF79D6
          86FF08B317FF07AD17FF0231058B000000000000000000000000000000000000
          0000000000000431075525B755FF3DC976FFF3F6EDFF98E1B4FFC3E9C7FF19B9
          3AFF12BA29FF09A318FF02210366000000000000000000000000000000000000
          000000000000010D0215169B2FE839C773FFBAECCFFFEDF4E8FFF0F5EAFFACE7
          BEFF1FC245FF097215F10008001B000000000000000000000000000000000000
          000000000000000000000430074C19AB3BF63FC773FF91E1B2FFD3EFD9FF3EC7
          70FF138E2EFA011C025900000000000000000000000000000000000000000000
          0000000000000000000000000000032005330A7118AD0E972BE70E912AE80860
          15B20218033B0000000000000000000000000000000000000000}
      end>
  end
end
