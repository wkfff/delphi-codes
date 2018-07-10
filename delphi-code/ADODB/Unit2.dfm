object Form2: TForm2
  Left = 0
  Top = 0
  Caption = #21516#27493#33267#24037#31243'ProjData.GSP'#20013
  ClientHeight = 350
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 28
    Top = 311
    Width = 187
    Height = 19
    Caption = #27880#24847#65306#21516#27493#21069#20808#20851#38381#24037#31243
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btn1: TButton
    Left = 376
    Top = 216
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 0
    Visible = False
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 100
    Top = 287
    Width = 81
    Height = 25
    Caption = 'btn2'
    TabOrder = 1
    Visible = False
    OnClick = btn2Click
  end
  object btn5: TButton
    Left = 231
    Top = 306
    Width = 130
    Height = 36
    Action = ac1
    Caption = #21516#27493#21040#24037#31243#25991#20214#20013
    TabOrder = 2
  end
  object grp1: TGroupBox
    Left = 8
    Top = 0
    Width = 503
    Height = 89
    Caption = 'grp1'
    TabOrder = 3
    object btn3: TButton
      Left = 14
      Top = 24
      Width = 195
      Height = 25
      Caption = #36873#25321#20462#25913#30340#22320#21306'ProjData.GSP'#25991#20214
      TabOrder = 0
      OnClick = btn3Click
    end
    object edt1: TEdit
      Left = 14
      Top = 55
      Width = 475
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
      OnChange = edt1Change
    end
  end
  object grp2: TGroupBox
    Left = 8
    Top = 95
    Width = 503
    Height = 81
    Caption = 'grp2'
    TabOrder = 4
    object btn4: TButton
      Left = 14
      Top = 16
      Width = 195
      Height = 25
      Caption = #36873#25321#24037#31243#25991#20214'GCL9'
      TabOrder = 0
      OnClick = btn4Click
    end
    object edt2: TEdit
      Left = 14
      Top = 47
      Width = 475
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
      OnChange = edt2Change
    end
    object btn6: TButton
      Left = 283
      Top = 16
      Width = 182
      Height = 25
      Caption = #36873#25321#36890#29992'ProjData.GSP'#25991#20214
      TabOrder = 2
      OnClick = btn6Click
    end
  end
  object grp3: TGroupBox
    Left = 8
    Top = 182
    Width = 502
    Height = 107
    Caption = 'grp3'
    TabOrder = 5
    object lbl2: TLabel
      Left = 20
      Top = 72
      Width = 131
      Height = 16
      Caption = 'OR '#21516#27493#26500#20214#33539#22260#65306'['
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 223
      Top = 72
      Width = 4
      Height = 13
      Caption = ','
    end
    object lbl4: TLabel
      Left = 303
      Top = 72
      Width = 5
      Height = 16
      Caption = ']'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object ck1: TCheckBox
      Left = 29
      Top = 32
      Width = 97
      Height = 17
      Caption = '0-14 '#30333#24422#30922
      TabOrder = 0
    end
    object ck2: TCheckBox
      Left = 141
      Top = 31
      Width = 97
      Height = 17
      Caption = '15-29 '#39532#38064#21338
      TabOrder = 1
    end
    object ck3: TCheckBox
      Left = 268
      Top = 31
      Width = 97
      Height = 17
      Caption = '30-53  '#24352#27704#24535
      TabOrder = 2
    end
    object ck4: TCheckBox
      Left = 402
      Top = 31
      Width = 97
      Height = 17
      Caption = '54- '#21016#26611
      TabOrder = 3
    end
    object edt3: TEdit
      Left = 157
      Top = 69
      Width = 60
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 4
      OnKeyPress = edt3KeyPress
    end
    object edt4: TEdit
      Left = 237
      Top = 69
      Width = 60
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 5
    end
  end
  object btn7: TButton
    Left = 400
    Top = 306
    Width = 118
    Height = 36
    Action = ac2
    TabOrder = 6
  end
  object btn8: TButton
    Left = 8
    Top = 317
    Width = 75
    Height = 25
    Caption = 'btn8'
    TabOrder = 7
    OnClick = btn8Click
  end
  object actlst1: TActionList
    OnUpdate = actlst1Update
    Left = 328
    Top = 192
    object ac1: TAction
      Caption = #21516#27493
      OnExecute = ac1Execute
    end
    object ac2: TAction
      Caption = #21516#27493
      OnExecute = ac2Execute
    end
  end
end
