inherited cxGridLayoutViewCustomizationForm: TcxGridLayoutViewCustomizationForm
  Left = 611
  Top = 172
  ActiveControl = nil
  Caption = 'dxLayoutControlCustomizeForm2'
  ClientHeight = 524
  ClientWidth = 747
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcMain: TdxLayoutControl
    Width = 747
    Height = 524
    LayoutLookAndFeel = llfMain
    inherited tvItems: TcxTreeView
      Left = 43
      Top = 134
      Height = 329
      TabStop = False
    end
    inherited tvAvailableItems: TcxTreeView
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnClose: TcxButton
      Left = 10000
      Top = 10000
      ModalResult = 1
      TabOrder = 25
      TabStop = False
      Visible = False
    end
    inherited cbTabbedView: TcxCheckBox
      Left = 10000
      Top = 10000
      TabStop = False
      TabOrder = 24
      Visible = False
    end
    inherited btnShowDesignSelectors: TcxButton
      Left = 141
      Top = 44
      TabStop = False
    end
    inherited btnHighlightRoot: TcxButton
      Left = 118
      Top = 44
      TabStop = False
    end
    inherited btnRestore: TcxButton
      Left = 95
      Top = 44
      TabStop = False
    end
    inherited btnStore: TcxButton
      Left = 72
      Top = 44
      TabStop = False
    end
    inherited btnRedo: TcxButton
      Left = 43
      Top = 44
      TabStop = False
    end
    inherited btnUndo: TcxButton
      Left = 20
      Top = 44
      TabStop = False
    end
    inherited btnAlignBy: TcxButton
      Left = 124
      Top = 106
      TabStop = False
    end
    inherited btnTreeViewItemsDelete: TcxButton
      Left = 95
      Top = 106
      TabStop = False
    end
    inherited btnTreeViewCollapseAll: TcxButton
      Left = 66
      Top = 106
      TabStop = False
    end
    inherited btnTreeViewExpandAll: TcxButton
      Left = 43
      Top = 106
      TabStop = False
    end
    inherited btnAvailableItemsViewAsList: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnAvailableItemsDelete: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnAddItem: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnAddGroup: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnAvailableItemsCollapseAll: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnAvailableItemsExpandAll: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited cxButton1: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    object btnOk: TcxButton [21]
      Left = 581
      Top = 489
      Width = 75
      Height = 25
      Action = acOk
      ModalResult = 1
      TabOrder = 22
    end
    object btnCancel: TcxButton [22]
      Left = 662
      Top = 489
      Width = 75
      Height = 25
      Action = acCancel
      TabOrder = 23
    end
    object gMain: TcxGrid [23]
      Left = 10000
      Top = 10000
      Width = 707
      Height = 429
      TabOrder = 19
      Visible = False
    end
    object cbSaveData: TcxCheckBox [24]
      Left = 137
      Top = 491
      Caption = 'Save data'
      State = cbsChecked
      Style.HotTrack = False
      TabOrder = 21
      Width = 121
    end
    object cbSaveLayout: TcxCheckBox [25]
      Left = 10
      Top = 491
      Caption = 'Save layout'
      State = cbsChecked
      Style.HotTrack = False
      TabOrder = 20
      Width = 121
    end
    inherited lcMainGroup_Root: TdxLayoutGroup
      Index = -1
    end
    inherited lcMainGroup2: TdxLayoutGroup
      Parent = lcMainTemplateCardGroup
      Index = 0
    end
    inherited liUndo: TdxLayoutItem
      Index = 0
    end
    inherited liRedo: TdxLayoutItem
      Index = 1
    end
    inherited lsSeparator4: TdxLayoutSeparatorItem
      Index = 2
    end
    inherited liStore: TdxLayoutItem
      Index = 3
    end
    inherited liRestore: TdxLayoutItem
      Index = 4
    end
    inherited liHighlightRoot: TdxLayoutItem
      Index = 5
    end
    inherited liShowDesignSelectors: TdxLayoutItem
      Index = 6
    end
    inherited lcMainGroup1: TdxLayoutGroup
      Parent = lcMainGroup5
      LayoutDirection = ldTabbed
      Index = 2
    end
    inherited lcgTreeView: TdxLayoutGroup
      Index = 0
    end
    inherited lgTreeView: TdxLayoutGroup
      Index = 0
    end
    inherited lcMainItem10: TdxLayoutItem
      Index = 0
    end
    inherited lcMainItem9: TdxLayoutItem
      Index = 1
    end
    inherited lcMainSeparatorItem3: TdxLayoutSeparatorItem
      Index = 2
    end
    inherited lcMainItem7: TdxLayoutItem
      Index = 3
    end
    inherited lsAlignBy: TdxLayoutSeparatorItem
      Index = 4
    end
    inherited liAlignBy: TdxLayoutItem
      Index = 5
    end
    inherited lcMainItem6: TdxLayoutItem
      Index = 1
    end
    inherited lcgAvailableItems: TdxLayoutGroup
      Index = 1
    end
    inherited lgAvailableItems: TdxLayoutGroup
      Index = 0
    end
    inherited lcMainItem15: TdxLayoutItem
      Index = 0
    end
    inherited lcMainItem14: TdxLayoutItem
      Index = 1
    end
    inherited lcMainSeparatorItem1: TdxLayoutSeparatorItem
      Index = 2
    end
    inherited lcMainItem13: TdxLayoutItem
      Index = 3
    end
    inherited liAddItem: TdxLayoutItem
      Index = 4
    end
    inherited liAddCustomItem: TdxLayoutItem
      Index = 5
    end
    inherited lcMainItem11: TdxLayoutItem
      Index = 6
    end
    inherited lcMainSeparatorItem2: TdxLayoutSeparatorItem
      Index = 7
    end
    inherited lcMainItem3: TdxLayoutItem
      Index = 8
    end
    inherited lcMainItem8: TdxLayoutItem
      Index = 1
    end
    inherited lcMainGroup3: TdxLayoutGroup
      AlignHorz = ahClient
      Index = 1
    end
    inherited lcMainItem4: TdxLayoutItem
      Parent = nil
      Index = -1
    end
    inherited lcMainItem1: TdxLayoutItem
      AlignHorz = ahLeft
      Parent = nil
      Index = -1
    end
    object liGridViewContainer: TdxLayoutItem
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'dxLayoutControl1'
      CaptionOptions.Visible = False
      Parent = lcMainGroup5
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object lcMainGroup5: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Parent = lcMainTemplateCardGroup
      ButtonOptions.Buttons = <>
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object lcMainSplitterItem1: TdxLayoutSplitterItem
      CaptionOptions.Text = 'Splitter'
      Parent = lcMainGroup5
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      Index = 1
    end
    object liOk: TdxLayoutItem
      CaptionOptions.Text = 'cxButton2'
      CaptionOptions.Visible = False
      Parent = lcMainGroup4
      Control = btnOk
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liCancel: TdxLayoutItem
      CaptionOptions.Text = 'cxButton3'
      CaptionOptions.Visible = False
      Parent = lcMainGroup4
      Control = btnCancel
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object lcMainTemplateCardGroup: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Template Card'
      Parent = lcMainTabbedGroup
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object lcMainTabbedGroup: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      Parent = lcMainGroup_Root
      ButtonOptions.Buttons = <>
      LayoutDirection = ldTabbed
      ShowBorder = False
      OnTabChanged = lcMainTabbedGroupTabChanged
      Index = 0
    end
    object lcMainViewLayoutGroup: TdxLayoutGroup
      CaptionOptions.Text = 'View Layout'
      Parent = lcMainTabbedGroup
      ButtonOptions.Buttons = <>
      Index = 1
    end
    object lcMainItem16: TdxLayoutItem
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'cxGrid1'
      CaptionOptions.Visible = False
      Parent = lcMainViewLayoutGroup
      Control = gMain
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liSaveData: TdxLayoutItem
      AlignHorz = ahLeft
      AlignVert = avCenter
      CaptionOptions.Text = 'cxCheckBox1'
      CaptionOptions.Visible = False
      Parent = lcMainGroup3
      Control = cbSaveData
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object lcMainGroup4: TdxLayoutGroup
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Group'
      Parent = lcMainGroup3
      ButtonOptions.Buttons = <>
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object liSaveLayout: TdxLayoutItem
      AlignHorz = ahLeft
      AlignVert = avCenter
      CaptionOptions.Text = 'cxCheckBox1'
      CaptionOptions.Visible = False
      Parent = lcMainGroup3
      Control = cbSaveLayout
      ControlOptions.ShowBorder = False
      Index = 0
    end
  end
  inherited alMain: TActionList
    inherited acClose: TAction
      ShortCut = 0
    end
    object acCancel: TAction
      Category = 'Buttons'
      Caption = 'acCancel'
      OnExecute = acCancelExecute
    end
    object acOk: TAction
      Category = 'Buttons'
      Caption = 'acOk'
      OnExecute = acOkExecute
    end
  end
  inherited ilActions: TcxImageList
    FormatVersion = 1
  end
  inherited ilItems: TcxImageList
    FormatVersion = 1
  end
  inherited ilHelper: TcxImageList
    FormatVersion = 1
  end
  object dxLayoutLookAndFeelList1: TdxLayoutLookAndFeelList
    Left = 152
    Top = 392
    object llfMain: TdxLayoutCxLookAndFeel
    end
  end
end
