object frmMDIChild: TfrmMDIChild
  Left = 273
  Top = 222
  Width = 368
  Height = 219
  Caption = 'frmMDIChild'
  Color = clBtnFace
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Editor: TRichEdit
    Left = 0
    Top = 0
    Width = 360
    Height = 185
    Align = alClient
    TabOrder = 0
    OnMouseDown = EditorMouseDown
  end
end
