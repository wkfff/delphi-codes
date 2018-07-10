unit Class1Test;

interface

uses
  SysUtils, TestFramework, Class1;

type
  TClass1Test = class(TTestCase)
  private
    FClass1: TClass1;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAdd;
  end;

implementation

{ TClass1Test }

procedure TClass1Test.SetUp;
begin
  inherited;
  FClass1 := TClass1.Create(2);
end;

procedure TClass1Test.TearDown;
begin
  FreeAndNil(FClass1);
  inherited;
end;

procedure TClass1Test.TestAdd;
begin
  Check(FClass1.Add(3) = 5);
end;

end.
