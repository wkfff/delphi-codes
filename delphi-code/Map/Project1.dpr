program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils, Unit1;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    ta;
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
