object MasterDetailTableDemoMainDM: TMasterDetailTableDemoMainDM
  OldCreateOrder = False
  Left = 270
  Top = 205
  Height = 387
  Width = 658
  object dsFilms: TDataSource
    DataSet = tblFilms
    Left = 48
    Top = 96
  end
  object dsFilmsPersonsStaff: TDataSource
    DataSet = tblFilmsPersonsStaff
    Left = 48
    Top = 192
  end
  object dsPersons: TDataSource
    DataSet = tblPersons
    Left = 144
    Top = 192
  end
  object dsPersonsLine: TDataSource
    DataSet = tblPersonsLine
    Left = 216
    Top = 192
  end
  object tblFilms: TTable
    Active = True
    DatabaseName = 'DemosDB'
    IndexFieldNames = 'ID'
    TableName = 'Films.DB'
    Left = 48
    Top = 56
  end
  object tblFilmsPersonsStaff: TTable
    Active = True
    DatabaseName = 'DemosDB'
    IndexFieldNames = 'FILMID'
    MasterFields = 'ID'
    MasterSource = dsFilms
    TableName = 'FilmsPersonsStaff.DB'
    Left = 48
    Top = 152
  end
  object tblPersons: TTable
    Active = True
    DatabaseName = 'DemosDB'
    OnCalcFields = tblPersonsCalcFields
    TableName = 'Persons.DB'
    Left = 144
    Top = 152
    object tblPersonsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object tblPersonsFIRSTNAME: TStringField
      FieldName = 'FIRSTNAME'
      Size = 50
    end
    object tblPersonsSECONDNAME: TStringField
      FieldName = 'SECONDNAME'
      Size = 50
    end
    object tblPersonsGENDER: TBooleanField
      FieldName = 'GENDER'
    end
    object tblPersonsNAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'NAME'
      Size = 50
      Calculated = True
    end
    object tblPersonsDATEOFBIRTH: TDateTimeField
      FieldName = 'DATEOFBIRTH'
    end
    object tblPersonsBIRTHCOUNTRY: TIntegerField
      FieldName = 'BIRTHCOUNTRY'
    end
    object tblPersonsLOCATIONOFBIRTH: TStringField
      FieldName = 'LOCATIONOFBIRTH'
      Size = 50
    end
    object tblPersonsBIOGRAPHY: TMemoField
      FieldName = 'BIOGRAPHY'
      BlobType = ftMemo
    end
    object tblPersonsNICKNAME: TStringField
      FieldName = 'NICKNAME'
      Size = 50
    end
  end
  object tblPersonsLine: TTable
    Active = True
    DatabaseName = 'DemosDB'
    TableName = 'PersonsLine.DB'
    Left = 216
    Top = 152
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
    Left     = 48
    Top = 8
  end
end
