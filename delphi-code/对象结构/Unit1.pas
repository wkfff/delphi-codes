unit Unit1;

interface

type
  IMyInterface = interface
    ['{E4AF9FB7-E327-46DC-88EA-6E5A7B576E19}']
  end;
  TMyInterfaceaa = class(TInterfacedObject, IMyInterface)
  private
    pid: Integer;
    pname: string;
  end;

  TMyInterface = class(TMyInterfaceaa, IMyInterface)
  private
    id: Integer;
    name: string;
  public
    constructor Create();
  end;

  TB = class;
  TB = class
    FB: Pointer;
  end;

  function GetImplObject(const AIntf: IInterface): TObject;
  procedure test1;
  procedure test2;
  procedure test3;


implementation

uses
  SysUtils;


procedure freet(o: TObject);
begin
  FreeAndNil(o);
end;

procedure freev(var o: TObject);
begin
  FreeAndNil(o);
end;

function icc(i: Integer): Integer;
begin
  Result := i+1;
end;

procedure test3;
var
  i: Integer;
  o1, o2: TB;
begin
  i := 1;
  i := icc(i);

  o1 := TB.Create;
  o2 := TB.Create;
  o2.FB := Pointer(o1);
  freev(TObject(o1));



end;

procedure test2;
var
  i: Integer;
  o1, o2: TMyInterface;
  s: string;
begin
  o1 := TMyInterface.Create;

  o2 := TMyInterface.Create;
  i := o1.id;
  s := o2.name;
  freet(o1);
  freev(TObject(o2));
end;

procedure test1;
var
  o: TObject;
  o1, o2: TMyInterface;
  i1, i2: IMyInterface;
begin
  o1 := TMyInterface.Create;
  i1 := o1 as IMyInterface;// TMyInterface.Create;
  i2 := i1;
  o := GetImplObject(i1);
  o2 := TMyInterface(o);

           //get o1's classname
//           PShortString(PPointer(PInteger(o1)^ +vmtClassName)^)^




end;


function GetImplObject(const AIntf: IInterface): TObject;
{$IFDEF CPUX64}
begin
  try
    Result := AIntf as TObject;
  except
    Result := nil;
  end;
end;
{$ELSE}
const
  AddByte = $04244483; // opcode for ADD DWORD PTR [ESP+4], Shortint
  AddLong = $04244481; // opcode for ADD DWORD PTR [ESP+4], Longint
type
  PAdjustSelfThunk = ^TAdjustSelfThunk;
  TAdjustSelfThunk = packed record
    case AddInstruction: Longint of
      AddByte: (AdjustmentByte: ShortInt);
      AddLong: (AdjustmentLong: Longint);
  end;
  PInterfaceMT = ^TInterfaceMT;
  TInterfaceMT = packed record
    QueryInterfaceThunk: PAdjustSelfThunk;
  end;
  TInterfaceRef = ^PInterfaceMT;
var
  QueryInterfaceThunk: PAdjustSelfThunk;
begin
  try
    Result := Pointer(AIntf);
    if Assigned(Result) then
    begin
      QueryInterfaceThunk := TInterfaceRef(AIntf)^.QueryInterfaceThunk;
      case QueryInterfaceThunk.AddInstruction of
        AddByte:
          Inc(PAnsiChar(Result), QueryInterfaceThunk.AdjustmentByte);
        AddLong:
          Inc(PAnsiChar(Result), QueryInterfaceThunk.AdjustmentLong);
      else
        Result := nil;
      end;
    end;
  except
    Result := nil;
  end;
end;
{$ENDIF}

{ TMyInterface }

constructor TMyInterface.Create;
begin
  pid := $965432;
  pname := 'xyz';
  id := $123456;
  name := 'abcdef';
end;

end.
