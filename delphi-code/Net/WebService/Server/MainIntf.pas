{ Invokable interface IMain }

unit MainIntf;

interface

uses InvokeRegistry, Types, XSBuiltIns;

type

  { Invokable interfaces must derive from IInvokable }
  IMain = interface(IInvokable)
  ['{D8D3C8FF-3504-4676-A912-48C03B2C3363}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function GetMsg(AMsg: string): String; stdcall;
  end;

implementation

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IMain));

end.
