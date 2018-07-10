program Project2;


var
 accum: Integer;

function sum(x, y: Integer): Integer;
var
  t: Integer;
begin
   t := x + y;
   accum := accum + t;
   Result := t;
end;

begin
  sum(1, 2);
end.
