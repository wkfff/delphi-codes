unit UnitDll2;

interface

uses
  UnitDll1;

  procedure dll2_p1();

implementation

procedure dll2_p1();
begin
  GDll1_g1 := 'dll2_p1';
end;

end.
