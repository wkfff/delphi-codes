unit Class2Test;

interface

uses
  SysUtils, TestFramework, Class2;

type
  TClass2Test = class(TTestCase)
  private
    FClass2: TClass2;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestReduceFirst;
    procedure TestReduceSecond;
  end;

implementation

{ TClass1Test }

procedure TClass2Test.SetUp;
begin
  inherited;
  FClass2 := TClass2.Create(2);
end;

procedure TClass2Test.TearDown;
begin
  FreeAndNil(FClass2);
  inherited;
end;

procedure TClass2Test.TestReduceFirst;
begin
  Check(FClass2.Reduce(3) = -1);
end;

procedure TClass2Test.TestReduceSecond;
begin
  Check(FClass2.Reduce(3) = 1, 'deliberately failure');
end;

end.
