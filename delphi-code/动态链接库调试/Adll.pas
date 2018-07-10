unit Adll;

interface

type
  TMyClass = class
  public
    FNum: Integer;
    FInfo: string;
    procedure TF;
  end;

procedure Test; stdcall;

implementation

procedure Test;
var
  o: TMyClass;
begin
  o := nil;
  o.TF;
  //Assert(False);
end;

{ TMyClass }

procedure TMyClass.TF;
begin
  FNum := $12345678;
  FInfo := 'abcdef';
end;

end.
