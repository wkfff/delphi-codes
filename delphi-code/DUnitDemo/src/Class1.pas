unit Class1;

interface

type
  TClass1 = class
  private
    FID: Integer;
  public
    function Add(ANumber: Integer): Integer;
    property ID: Integer read FID write FID;
    constructor Create(AID: Integer);
  end;

implementation

{ TClass1 }

function TClass1.Add(ANumber: Integer): Integer;
begin
  Result := FID + ANumber;
end;

constructor TClass1.Create(AID: Integer);
begin
  FID := AID;
end;

end.
