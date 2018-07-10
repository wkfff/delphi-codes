unit Class2;

interface

type
  TClass2 = class
  private
    FID: Integer;
  public
    function Reduce(ANumber: Integer): Integer;
    property ID: Integer read FID write FID;
    constructor Create(AID: Integer);
  end;

implementation

{ TClass2 }

constructor TClass2.Create(AID: Integer);
begin
  FID := AID;
end;

function TClass2.Reduce(ANumber: Integer): Integer;
begin
  Result := FID - ANumber;
end;

end.
