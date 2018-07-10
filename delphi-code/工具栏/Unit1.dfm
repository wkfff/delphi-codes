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
      object tbxtm1: TTBXItem
        Caption = 'a'
      end
      object tbxtm2: TTBXItem
        Caption = 'b'
      end
      object tbsbmntmc: TTBSubmenuItem
        Caption = 'c'
        object tbxtm3: TTBXItem
          Caption = 'c1'
        end
        object tbxsbmntm1: TTBXSubmenuItem
          Caption = 'd1'
          object tbsbmntm1: TTBSubmenuItem
            Caption = 'd11'
          end
          object tbsbmntm2: TTBSubmenuItem
            Caption = 'd22'
          end
        end
        object tbsbmntm3: TTBSubmenuItem
          Caption = 'e'
          object tbxtm4: TTBXItem
            Caption = 'e1'
          end
        end
      end
    end
  end
end
