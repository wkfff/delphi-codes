unit MasterDetailTableDemoData;

interface

uses
  Forms, SysUtils, Classes, DB, cxStyles, cxClasses, cxGridTableView,
  DBTables, DemoUtils;

type
  TMasterDetailTableDemoMainDM = class(TDataModule)
    dsFilms: TDataSource;
    dsFilmsPersonsStaff: TDataSource;
    dsPersons: TDataSource;
    dsPersonsLine: TDataSource;
    tblFilms: TTable;
    tblFilmsPersonsStaff: TTable;
    tblPersons: TTable;
    tblPersonsLine: TTable;
    DataBase: TDataBase;
    tblPersonsID: TAutoIncField;
    tblPersonsFIRSTNAME: TStringField;
    tblPersonsSECONDNAME: TStringField;
    tblPersonsGENDER: TBooleanField;
    tblPersonsDATEOFBIRTH: TDateTimeField;
    tblPersonsBIRTHCOUNTRY: TIntegerField;
    tblPersonsLOCATIONOFBIRTH: TStringField;
    tblPersonsBIOGRAPHY: TMemoField;
    tblPersonsNICKNAME: TStringField;
    tblPersonsNAME: TStringField;
    procedure tblPersonsCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MasterDetailTableDemoMainDM: TMasterDetailTableDemoMainDM;

implementation

{$R *.dfm}

procedure TMasterDetailTableDemoMainDM.tblPersonsCalcFields(
  DataSet: TDataSet);
begin
  SetStringFieldValue(tblPersonsNAME,
    tblPersonsFIRSTNAME.Value + ' ' + tblPersonsSECONDNAME.Value);
end;

end.
