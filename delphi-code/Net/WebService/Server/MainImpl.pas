{ Invokable implementation File for TMain which implements IMain }

unit MainImpl;

interface

uses InvokeRegistry, Types, XSBuiltIns, MainIntf;

type

  { TMain }
  TMain = class(TInvokableClass, IMain)
  public
    function GetMsg(AMsg: string): String; stdcall;
  end;

implementation


{ TMain }

function TMain.GetMsg(AMsg: string): String;
begin
  Result := AMsg + 'Mytest';
end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TMain);
end.

