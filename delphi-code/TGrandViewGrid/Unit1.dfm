object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 247
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object vg1: TGrandViewGrid
    Left = 40
    Top = 8
    Width = 417
    Height = 177
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goColMoving, goEditing, goTabs, goMultiSelection, goThumbTracking, goColDblClickMaxWidth, goCellMerge, goShowRowNo, goAutoThemeAdapt, goAllowCheckBoxGrayed, goBoolClickBoxSwitch]
    OnEditButtonClick = vg1EditButtonClick
    OnQueryEditorMode = vg1QueryEditorMode
    OnQueryEditProperty = vg1QueryEditProperty
    OnQueryEditStyle = vg1QueryEditStyle
    OnQueryReadOnly = vg1QueryReadOnly
    OptionExs = [goAllowSelectRow, goAllowSelectAll, goHideEditOnExit, goReturnKeyAsTab]
    ReadOnly = False
    OnQueryCellAttribute = vg1QueryCellAttribute
    OnQueryCellValue = vg1QueryCellValue
    OnUpdateCellValue = vg1UpdateCellValue
    ColWidths = (
      20
      72
      72
      72
      72)
    RowHeights = (
      18
      18
      18
      18
      18)
  end
end
