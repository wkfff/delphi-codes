program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Unit1 in 'Unit1.pas';

begin
  try
    test3;
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
