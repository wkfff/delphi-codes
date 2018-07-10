unit SummaryFooterDemoData;

interface

uses
  Forms,
  SysUtils, Classes, DB, cxStyles, ImgList, Controls, cxClasses,
  cxGridTableView, DBTables, DemoUtils;

type
  TSummaryFooterDemoDataDM = class(TDataModule)
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
    tblCustomersName: TStringField;
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
    procedure tblCustomersCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SummaryFooterDemoDataDM: TSummaryFooterDemoDataDM;

implementation

{$R *.dfm}

procedure TSummaryFooterDemoDataDM.tblCustomersCalcFields(
  DataSet: TDataSet);
begin
  SetStringFieldValue(tblCustomersName, tblCustomersFirstName.Value + ' ' +
    tblCustomersLastName.Value);
end;

end.
