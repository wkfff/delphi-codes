{-----------------------------------------------------------------------------

  gcl的命令行解析单元,对GNU getopt的封装， 封装形式参照Python

  作者：duanyb
  备注：
  审核：

  Copyright (c) 1994-2007 GrandSoft Corporation

-----------------------------------------------------------------------------}
unit GAEAGetOpt;

interface

//uses
//  GCLException;
uses
  SysUtils;

type
  EGCLGetoptException = class(Exception)
  end;

  TOptItem = packed record
    Opt: string;
    Arg: string;
  end;

  TOptItemDynArray = array of TOptItem;

function GetOpt(const ShortOpt: string; const LongOpt: array of const):
    TOptItemDynArray; 
function GetOptEx(AArgc: Integer; var AArgv : array of string; const ShortOpt:
    string; const LongOpt: array of const): TOptItemDynArray;

implementation

uses
  getoptlib, GrandStrUtils;

resourcestring
  SLongOptError = '长参数必须是字符串类型';

{-----------------------------------------------------------------------------
  作者：duanyb
  参数: ShortOpt: 短参数字符串
        LongOpt: 长参数字符串
  返回：TOptItemDynArray
  功能：python风格的命令行解析函数
        Look python's getopt help for details
-----------------------------------------------------------------------------}
function GetOpt(const ShortOpt: string; const LongOpt: array of const):
    TOptItemDynArray;
begin
  Result := GetOptEx(argc, argvptr^, ShortOpt, LongOpt);
end;
  

{-----------------------------------------------------------------------------
  作者：duanyb
  参数: ShortOpt: 短参数字符串
        LongOpt: 长参数字符串
  返回：TOptItemDynArray
  功能：python风格的命令行解析函数
        Look python's getopt help for details
-----------------------------------------------------------------------------}
function GetOptEx(AArgc: Integer; var AArgv : array of string; const ShortOpt:
    string; const LongOpt: array of const): TOptItemDynArray;

type
  TShortOpts = array of Char;
  TNeedArg   = array of Boolean;

const
  CShortNeed = ':';
  CLongNeed  = '=';  

  function IsLongOptValid: Boolean;
  var
    i: Integer;
  begin
    Result := True;
    for I := Low(LongOpt) to High(LongOpt) do
      if LongOpt[I].VType <> vtAnsiString then
      begin
        Result := False;
        Break;
      end;      
  end;

  procedure ParseShortOpts(var ShortOpts: TShortOpts; var NeedArg: TNeedArg);
  var
    nIndex, nLen: Integer;
  begin
    nIndex := 1;
    SetLength(ShortOpts, 0);
    SetLength(NeedArg, 0);
    nLen := 0;
    while nIndex <= Length(ShortOpt) do
    begin
      Inc(nLen);
      SetLength(ShortOpts, nLen);
      SetLength(NeedArg, nLen);
      ShortOpts[nLen-1] := ShortOpt[nIndex];
      if (nIndex < Length(ShortOpt)) and (ShortOpt[nIndex + 1] = CShortNeed) then
      begin
        NeedArg[nLen-1] := True;
        Inc(nIndex);
      end;
      Inc(nIndex)     
    end;
  end;

  function  ContainOpt(const Opt: Char; ShortOpts: TShortOpts): Boolean;
  var
    C: Char;
  begin
    Result := False;
    for C in ShortOpts do
    begin
      Result := C = Opt;
      if Result then
        Break;
    end;
  end;
  
  procedure AddResult(const Opt: string; const Arg: string);
  var
    nLen: Integer;
  begin
    nLen := length(Result);
    SetLength(Result, nLen+1);
    Result[nLen].Opt := Opt;
    Result[nLen].Arg := Arg;
  end;
var
  long_options: array of option;
  ShortOpts: TShortOpts;
  NeedArg: TNeedArg;
  i: Integer;
  c                     : integer;
  option_index          : integer;
  sLongOpt: string;
begin
  if not IsLongOptValid then
    raise EGCLGetoptException.Create(SLongOptError);

  optind := 0; // 重置为0，两次调用不会出错。
  SetLength(Result, 0);
  ParseShortOpts(ShortOpts, NeedArg);
  SetLength(long_options,  High(LongOpt) + 1);
  for I := Low(LongOpt) to High(LongOpt) do
    with long_options[I] do
    begin
      sLongOpt := String(LongOpt[I].VAnsiString);
      if sLongOpt[Length(sLongOpt)] = CLongNeed then
//      if LongOpt[I].VString^[Length(String(LongOpt[I].VAnsiString))] = CLongNeed then
      begin
        name := Copy(sLongOpt, 1, Length(sLongOpt)-1);
        has_arg := optional_argument;
      end
      else
      begin
        name := sLongOpt;
        has_arg := no_argument;
      end;
      flag := nil;
      if (i >= Low(ShortOpts)) and (i <= High(ShortOpts)) then
        val := Ord(ShortOpts[i]);
    end;


  while (true) do
  begin
    option_index := -1;
    c := getopt_long (AArgc, AArgv, ':' + ShortOpt, long_options, option_index);
    if (c = EOF_getopt) then
    	break;

    case c of
      0:
        AddResult(long_options[option_index].name, optarg);
      Ord('?'):begin

      end;
      ord(':'): begin

      end
      else
      begin
        Assert(ContainOpt(Chr(Byte(C)), ShortOpts));
        if option_index <> -1 then
          AddResult(long_options[option_index].name, optarg)
        else
          AddResult(Chr(Byte(C)), optarg)          
      end;
    end;
  end;
end; 


end.
