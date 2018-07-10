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
  PixelsPerInch = 96
  TextHeight = 13
  object tbxdck1: TTBXDock
    Left = 0
    Top = 0
    Width = 480
    Height = 22
    object tbxtlbr1: TTBXToolbar
      Left = 0
      Top = 0
      Caption = 'tbxtlbr1'
      TabOrder = 0
      object tbx1: TTBXSubmenuItem
        Caption = 'ac3w'
        DisplayMode = nbdmImageAndText
        DropdownCombo = True
        MaskOptions = [tboDefault]
        MinWidth = 30
        Options = [tboDropdownArrow]
        RadioItem = True
        Stretch = True
        OnClick = ac3Execute
        object tbx2: TTBXItem
          Action = ac1
          GroupIndex = 1
        end
        object tbx3: TTBXItem
          Action = ac2
          GroupIndex = 1
        end
      end
      object tbsbmntm1: TTBSubmenuItem
        Action = ac3
        DropdownCombo = True
        object tbx5: TTBXItem
          Action = ac1
        end
        object tbx4: TTBXItem
          Action = ac2
        end
      end
    end
    object ck1: TCheckBox
      Left = 104
      Top = 0
      Width = 97
      Height = 17
      Caption = 'ck1'
      TabOrder = 1
      OnClick = ck1Click
    end
  end
  object actlst1: TActionList
    Left = 232
    Top = 128
    object ac1: TAction
      AutoCheck = True
      Caption = 'ac1'
      GroupIndex = 1
      OnExecute = ac1Execute
    end
    object ac2: TAction
      AutoCheck = True
      Caption = 'ac2'
      Checked = True
      GroupIndex = 1
      OnExecute = ac2Execute
    end
    object ac3: TAction
      Caption = 'ac3'
      GroupIndex = 1
      OnExecute = ac3Execute
    end
  end
end
