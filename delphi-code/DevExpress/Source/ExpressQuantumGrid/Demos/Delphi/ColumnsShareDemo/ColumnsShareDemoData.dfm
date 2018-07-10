object ColumnsShareDemoMainDM: TColumnsShareDemoMainDM
  OldCreateOrder = False
  Left = 310
  Top = 163
  Height = 378
  Width = 325
  object tblProjects: TTable
    Active = True
    DatabaseName = 'DemosDB'
    TableName = 'PROJECTS.DB'
    Left = 40
    Top = 56
    object tblProjectsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object tblProjectsNAME: TStringField
      FieldName = 'NAME'
      Size = 100
    end
    object tblProjectsMANAGERID: TIntegerField
      DisplayWidth = 50
      FieldName = 'MANAGERID'
    end
  end
  object dsProjects: TDataSource
    DataSet = tblProjects
    Left = 96
    Top = 56
  end
  object dsItems: TDataSource
    DataSet = tblItems
    Left = 80
    Top = 120
  end
  object tblItems: TTable
    Active = True
    DatabaseName = 'DemosDB'
    TableName = 'ITEMS.DB'
    Left = 40
    Top = 120
    object tblItemsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object tblItemsNAME: TStringField
      DisplayWidth = 35
      FieldName = 'NAME'
      Size = 50
    end
    object tblItemsTYPE: TBooleanField
      DisplayWidth = 15
      FieldName = 'TYPE'
    end
    object tblItemsPROJECTID: TIntegerField
      DisplayWidth = 50
      FieldName = 'PROJECTID'
    end
    object tblItemsPRIORITY: TSmallIntField
      FieldName = 'PRIORITY'
    end
    object tblItemsSTATUS: TSmallIntField
      FieldName = 'STATUS'
    end
    object tblItemsCREATORID: TIntegerField
      DisplayWidth = 20
      FieldName = 'CREATORID'
    end
    object tblItemsCREATEDDATE: TDateTimeField
      DisplayWidth = 10
      FieldName = 'CREATEDDATE'
    end
    object tblItemsOWNERID: TIntegerField
      DisplayWidth = 20
      FieldName = 'OWNERID'
    end
    object tblItemsLASTMODIFIEDDATE: TDateTimeField
      FieldName = 'LASTMODIFIEDDATE'
    end
    object tblItemsFIXEDDATE: TDateTimeField
      DisplayWidth = 10
      FieldName = 'FIXEDDATE'
    end
    object tblItemsDESCRIPTION: TMemoField
      FieldName = 'DESCRIPTION'
      BlobType = ftMemo
    end
    object tblItemsRESOLUTION: TMemoField
      FieldName = 'RESOLUTION'
      BlobType = ftMemo
    end
  end
  object tblUsers: TTable
    Active = True
    DatabaseName = 'DemosDB'
    OnCalcFields = tblUsersCalcFields
    IndexFieldNames = 'ID'
    TableName = 'USERS.DB'
    Left = 40
    Top = 176
    object tblUsersID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object tblUsersUserName: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'UserName'
      Calculated = True
    end
    object tblUsersFNAME: TStringField
      FieldName = 'FNAME'
      Size = 25
    end
    object tblUsersMNAME: TStringField
      FieldName = 'MNAME'
    end
    object tblUsersLNAME: TStringField
      FieldName = 'LNAME'
      Size = 25
    end
    object tblUsersCOUNTRY: TStringField
      FieldName = 'COUNTRY'
      Size = 15
    end
    object tblUsersPOSTALCODE: TStringField
      FieldName = 'POSTALCODE'
      Size = 10
    end
    object tblUsersCITY: TStringField
      FieldName = 'CITY'
      Size = 15
    end
    object tblUsersADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 60
    end
    object tblUsersPHONE: TStringField
      FieldName = 'PHONE'
      Size = 24
    end
    object tblUsersFAX: TStringField
      FieldName = 'FAX'
      Size = 24
    end
    object tblUsersEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 50
    end
    object tblUsersHOMEPAGE: TStringField
      FieldName = 'HOMEPAGE'
      Size = 50
    end
    object tblUsersDEPARTMENTID: TIntegerField
      FieldName = 'DEPARTMENTID'
    end
    object tblUsersDepartment: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'Department'
      LookupDataSet = tblDepartments
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'DEPARTMENTID'
      Lookup = True
    end
  end
  object dsUsers: TDataSource
    DataSet = tblUsers
    Left = 88
    Top = 176
  end
  object dsProjectTeam: TDataSource
    DataSet = tblProjectTeam
    Left = 240
    Top = 112
  end
  object tblProjectTeam: TTable
    Active = True
    DatabaseName = 'DemosDB'
    IndexFieldNames = 'ProjectID'
    TableName = 'PROJECTTEAM.DB'
    Left = 160
    Top = 112
    object tblProjectTeamID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object tblProjectTeamPROJECTID: TIntegerField
      FieldName = 'PROJECTID'
    end
    object tblProjectTeamUSERID: TIntegerField
      DisplayWidth = 50
      FieldName = 'USERID'
    end
    object tblProjectTeamFUNCTION: TStringField
      FieldName = 'FUNCTION'
      Size = 50
    end
  end
  object Database: TDatabase
    Connected = True
    DatabaseName = 'DemosDB'
    DriverName = 'STANDARD'
    Params.Strings = (
      'PATH=..\..\Data'
      'DEFAULT DRIVER=PARADOX'
      'ENABLE BCD=FALSE')
    SessionName = 'Default'
    Left = 40
    Top = 8
  end
  object dsDepartments: TDataSource
    DataSet = tblDepartments
    Left = 120
    Top = 232
  end
  object tblDepartments: TTable
    Active = True
    DatabaseName = 'DemosDB'
    TableName = 'DEPARTMENTS.DB'
    Left = 40
    Top = 232
  end
  object imStat: TImageList
    Left = 216
    Top = 232
    Bitmap = {
      494C010108000900080010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00008000000080000000800000008000000080
      000000800000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF00008000000080000000800000FFFFFF00FFFFFF0000000000FFFFFF000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF000080000080808000C0C0C000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF
      FF000000000000FFFF00FFFFFF00FFFFFF000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF000080000000800000008000000080
      000000800000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00FFFFFF0000800000008000000080000080808000C0C0C000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF000080000000800000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000FFFF00C0C0C0000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000080808000FFFF
      FF000080000000800000FFFFFF00008000000080000080808000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000808000008080000000000000FFFFFF0000800000008000000080
      000000800000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008000008080800080808000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000080800000808000000000
      000000000000000000008080000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000080000080808000C0C0
      C000FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF000000000000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFF0000808000000000
      0000FFFF00000000000080800000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008000008080
      8000FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF00000000
      000000000000FFFF0000FFFF000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000080
      0000FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF00008000000080000000800000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00C0C0C0000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000FF000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF0080808000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF008080800000FFFF00FFFFFF0000FFFF000000800000000000FFFF
      FF0000FFFF00FFFFFF0000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF008080800000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF000000000080808000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF0000800000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF0000FFFF000000800000000000FFFF
      FF0000FFFF000000000080808000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF000080000000800000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF0000800000FFFFFF00FFFFFF0080808000FFFFFF00000080000000000000FF
      FF00000000008080800000000000000000000000000000800000008000000080
      0000008000000080000000800000008000000080000000800000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008080800000FFFF000000800000000000FFFF
      FF00000000008080800000000000000000000000000000800000008000000080
      000000800000008000000080000000800000008000000080000000800000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF000080000000800000FFFFFF00FFFFFF008080800000FFFF00FFFFFF000000
      0000808080000000000000000000000000000000000000800000008000000080
      0000008000000080000000800000008000000080000000800000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF0000FFFF000000
      0000808080000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF000080000000800000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00008000000080000000800000FFFFFF00FFFFFF0000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF0000800000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF000080000000800000008000000080000000800000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFE00E007F801C003C000
      E007F801C003C000E007F801C003C000E007F801C003C000E007F801C003C000
      E007F801C003C000E007F801C003C001E0079001C003C003E0070001C003C007
      E0070001C003C00FE0070001C003C00FE00F9801C003C00FE01FF801C003C00F
      E03FF801C003C00FFFFFFFFFFFFFFFFFFF3FFF1FFC03FFFFFE1FFE1FC001F003
      FC0FFE1FC001F003F807FE3FC001F003F007FF1FC001F003FE1FFE1FC001F003
      FE1FFE1FC0038003FE1FFE1FC0038003FE1FFE1FC0078003FE1FFE1FC007F003
      FE1FFE1FC00FF003FE1FFE1FC00FF003FE1FFE1FC00FF007FE1FFE1FC00FF00F
      FE3FFE3FC00FF01FFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
