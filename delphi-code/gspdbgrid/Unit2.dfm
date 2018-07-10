object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 472
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object gdb1: TGSPDBGrid
    Left = 32
    Top = 32
    Width = 369
    Height = 145
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goEditing, goTabs, goThumbTracking, goColDblClickMaxWidth, goCellMerge, goShowRowNo, goAutoThemeAdapt, goAllowCheckBoxGrayed, goBoolClickBoxSwitch]
    OnQueryEditStyle = gdb1QueryEditStyle
    OnQueryCellValue = gdb1QueryCellValue
  end
  object grndvwgrd1: TGrandViewGrid
    Left = 48
    Top = 200
    Width = 425
    Height = 177
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goEditing, goTabs, goThumbTracking, goColDblClickMaxWidth, goCellMerge, goShowRowNo, goAutoThemeAdapt, goAllowCheckBoxGrayed, goBoolClickBoxSwitch]
    TabOrder = 1
    OnDropDownListSelected = grndvwgrd1DropDownListSelected
    OnGetDropDownList = grndvwgrd1GetDropDownList
    OnKeyDown = grndvwgrd1KeyDown
    OnKeyPress = grndvwgrd1KeyPress
    OnKeyUp = grndvwgrd1KeyUp
    OnQueryEditHide = grndvwgrd1QueryEditHide
    OnQueryEditStyle = grndvwgrd1QueryEditStyle
    OnQueryReadOnly = grndvwgrd1QueryReadOnly
    ReadOnly = False
    OnQueryCellAttribute = grndvwgrd1QueryCellAttribute
    OnQueryCellValue = grndvwgrd1QueryCellValue
    ColWidths = (
      67
      72
      72
      72
      72)
  end
  object btn1: TButton
    Left = 592
    Top = 152
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 2
    OnClick = btn1Click
  end
  object btnNew: TButton
    Left = 496
    Top = 256
    Width = 75
    Height = 25
    Caption = 'btnNew'
    TabOrder = 3
    OnClick = btnNewClick
  end
  object btnDel: TButton
    Left = 626
    Top = 256
    Width = 75
    Height = 25
    Caption = 'btnDel'
    TabOrder = 4
  end
  object gspvwprxy1: TGSPViewProxy
    Left = 416
    Top = 40
  end
  object gdb2: TGSPDBDataSource
    Left = 416
    Top = 88
    object gspvwprvdrtm1: TGSPViewProviderItem
      View = gspvwprxy1
    end
  end
end
