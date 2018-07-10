unit dxlocate;

interface

{$I cxVer.inc}

uses
  DB, Variants;

function DBTrDataSetLocate(DataSet: TDataSet; const AFieldName: string; AValue: Variant; AOptions: TLocateOptions): Boolean;

implementation

function DBTrDataSetLocate(DataSet: TDataSet; const AFieldName: string; AValue: Variant; AOptions: TLocateOptions): Boolean;
begin
  Result := DataSet.Locate(AFieldName, AValue, AOptions);
end;

end.
