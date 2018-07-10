object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 437
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrdADODemoGrid: TDBGrid
    Left = 0
    Top = 0
    Width = 609
    Height = 437
    Align = alClient
    BiDiMode = bdLeftToRight
    Color = clBtnFace
    DataSource = dsADODemo
    ParentBiDiMode = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'male'
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'love'
        Width = 54
        Visible = True
      end>
  end
  object dsADODemo: TDataSource
    DataSet = tbl1
    Left = 232
    Top = 152
  end
  object conADO: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=E:\dw' +
      'orkspace\ADODB\ADODemo\DatabaseADO.mdb;Mode=Share Deny None;Pers' +
      'ist Security Info=False;Jet OLEDB:System database="";Jet OLEDB:R' +
      'egistry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine ' +
      'Type=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partia' +
      'l Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New ' +
      'Database Password="";Jet OLEDB:Create System Database=False;Jet ' +
      'OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale on Comp' +
      'act=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLE' +
      'DB:SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 128
    Top = 152
  end
  object tbl1: TADOTable
    Active = True
    Connection = conADO
    CursorType = ctStatic
    TableName = '[user]'
    Left = 328
    Top = 144
  end
end
