unit EditorsInPlaceDemoData;

interface

uses
  SysUtils, Classes, DB, cxStyles, ImgList, Controls,
  cxGridTableView, cxGridBandedTableView, cxClasses, cxGridCardView, Forms, DBTables;

type
  TEditorsInPlaceDemoDataDM = class(TDataModule)
    dsCars: TDataSource;
    dsOrders: TDataSource;
    dsCustomers: TDataSource;
    DataBase: TDataBase;
    tblCars: TTable;
    tblOrders: TTable;
    tblCustomers: TTable;
    tblCustomersID: TIntegerField;
    tblCustomersFirstName: TStringField;
    tblCustomersLastName: TStringField;
    tblCustomersCompany: TStringField;
    tblCustomersPrefix: TStringField;
    tblCustomersTitle: TStringField;
    tblCustomersAddress: TStringField;
    tblCustomersCity: TStringField;
    tblCustomersState: TStringField;
    tblCustomersZipCode: TStringField;
    tblCustomersSource: TStringField;
    tblCustomersCustomer: TStringField;
    tblCustomersHomePhone: TStringField;
    tblCustomersFaxPhone: TStringField;
    tblCustomersSpouse: TStringField;
    tblCustomersOccupation: TStringField;
    tblCustomersDescription: TMemoField;
    PaymentTypeImages: TImageList;
    tblOrdersID: TAutoIncField;
    tblOrdersCustomerID: TIntegerField;
    tblOrdersProductID: TIntegerField;
    tblOrdersPurchaseDate: TDateTimeField;
    tblOrdersTime: TDateTimeField;
    tblOrdersPaymentType: TStringField;
    tblOrdersDescription: TMemoField;
    tblOrdersQuantity: TIntegerField;
    tblOrdersPaymentAmount: TCurrencyField;
    dsCities: TDataSource;
    tblCities: TTable;
    tblCarsID: TAutoIncField;
    tblCarsTrademark: TStringField;
    tblCarsModel: TStringField;
    tblCarsHP: TSmallintField;
    tblCarsLiter: TFloatField;
    tblCarsCyl: TSmallintField;
    tblCarsTransmissSpeedCount: TSmallintField;
    tblCarsTransmissAutomatic: TStringField;
    tblCarsMPG_City: TSmallintField;
    tblCarsMPG_Highway: TSmallintField;
    tblCarsCategory: TStringField;
    tblCarsDescription: TMemoField;
    tblCarsHyperlink: TStringField;
    tblCarsPicture: TBlobField;
    tblCarsPrice: TFloatField;
    tblCarsCar: TStringField;
    procedure tblCarsCalcFields(DataSet: TDataSet);
    procedure tblCarsTransmissSpeedCountSetText(Sender: TField;
      const Text: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditorsInPlaceDemoDataDM: TEditorsInPlaceDemoDataDM;

implementation

{$R *.dfm}

uses
  DemoUtils;

procedure TEditorsInPlaceDemoDataDM.tblCarsCalcFields(DataSet: TDataSet);
begin
  SetStringFieldValue(tblCarsCar, tblCarsTrademark.AsString + ' ' +
    tblCarsModel.AsString);
end;

procedure TEditorsInPlaceDemoDataDM.tblCarsTransmissSpeedCountSetText(
  Sender: TField; const Text: String);
begin
  if Text <> '' then
    tblCarsTransmissSpeedCount.AsInteger := StrToInt(Text[1]);
end;

end.
