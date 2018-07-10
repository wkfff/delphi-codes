unit CustomDrawCardViewDemoData;

interface

uses
  SysUtils, Classes, DB, cxStyles, cxClasses, cxGridTableView, Forms, DBTables;

type
  TCustomDrawCardViewDemoMainDM = class(TDataModule)
    DataBase: TDataBase;
    tblCountries: TTable;
    dsCountries: TDataSource;
    tlbPERSONSLINE: TTable;
    dsPERSONSLINE: TDataSource;
    qrePersons: TQuery;
    dsPresons: TDataSource;
    StyleRepository: TcxStyleRepository;
    stBlueDark: TcxStyle;
    stGold: TcxStyle;
    stBlueLight: TcxStyle;
    stBlueBright: TcxStyle;
    stYellowLight: TcxStyle;
    stGreyLight: TcxStyle;
    stBlueSky: TcxStyle;
  end;

var
  CustomDrawCardViewDemoMainDM: TCustomDrawCardViewDemoMainDM;

implementation

{$R *.dfm}

end.
