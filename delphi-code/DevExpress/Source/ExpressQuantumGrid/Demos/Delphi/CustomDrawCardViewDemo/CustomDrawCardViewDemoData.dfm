object CustomDrawCardViewDemoMainDM: TCustomDrawCardViewDemoMainDM
  OldCreateOrder = False
  Left = 310
  Top = 163
  Height = 334
  Width = 491
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
  object tblCountries: TTable
    Active = True
    DatabaseName = 'DemosDB'
    TableName = 'Countries.DB'
    Left = 40
    Top = 64
  end
  object dsCountries: TDataSource
    DataSet = tblCountries
    Left = 40
    Top = 128
  end
  object tlbPERSONSLINE: TTable
    Active = True
    DatabaseName = 'DemosDB'
    TableName = 'PERSONSLINE.DB'
    Left = 128
    Top = 64
  end
  object dsPERSONSLINE: TDataSource
    DataSet = tlbPERSONSLINE
    Left = 128
    Top = 128
  end
  object qrePersons: TQuery
    Active = True
    DatabaseName = 'DemosDB'
    DataSource = dsPERSONSLINE
    RequestLive = True
    SQL.Strings = (
      
        'select PERSONS.ID as PERSONID, BIOGRAPHY, BIRTHCOUNTRY, BIRTHNAM' +
        'E, DATEOFBIRTH, FIRSTNAME, GENDER, HOMEPAGE, LOCATIONOFBIRTH, NI' +
        'CKNAME, SECONDNAME, PERSONLINEID from FILMSPERSONSSTAFF,  PERSON' +
        'S where FILMSPERSONSSTAFF.PERSONID = PERSONS.ID and PERSONLINEID' +
        ' = :ID ')
    Left = 224
    Top = 64
    ParamData = <
      item
        DataType = ftAutoInc
        Name = 'ID'
        ParamType = ptUnknown
      end>
  end
  object dsPresons: TDataSource
    DataSet = qrePersons
    Left = 224
    Top = 128
  end
  object StyleRepository: TcxStyleRepository
    Left = 128
    Top = 8
    object stBlueDark: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 12937777
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object stGold: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 4707838
      TextColor = clBlack
    end
    object stBlueLight: TcxStyle
      AssignedValues = [svColor]
      Color = 16247513
    end
    object stBlueBright: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 16749885
      TextColor = clWhite
    end
    object stYellowLight: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 14811135
      TextColor = clBlack
    end
    object stGreyLight: TcxStyle
      AssignedValues = [svColor]
      Color = 14872561
    end
    object stBlueSky: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object stDefault: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clWindow
      TextColor = clBlack
    end
  end
end
