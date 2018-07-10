object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MDI Demo'
  ClientHeight = 418
  ClientWidth = 648
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mmMain
  OldCreateOrder = False
  Position = poScreenCenter
  WindowMenu = miWindows
  PixelsPerInch = 96
  TextHeight = 13
  object mmMain: TMainMenu
    Left = 8
    Top = 384
    object miFile: TMenuItem
      Caption = #25991#20214'(&F)'
      object miOpen: TMenuItem
        Caption = #25171#24320'(&O)'
        OnClick = miOpenClick
      end
    end
    object miWindows: TMenuItem
      Caption = #31383#21475
    end
    object miPingpu: TMenuItem
      Caption = #24179#38138
      OnClick = miPingpuClick
    end
    object miCascade: TMenuItem
      Caption = #23618#21472
      OnClick = miCascadeClick
    end
  end
end
