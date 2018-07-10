unit AQtimeHelpers;

interface

uses
  Windows;

 procedure EnableProfiling(Enabled : WordBool);
 procedure SetCurrentThreadName(Name : WideString);
 function GetCurrentThreadName : WideString;
 procedure GenerateResults;

implementation

type EnableProfilingProc = procedure(Value : WordBool); stdcall;
type SetThreadNameProc = procedure(Name : WideString); stdcall;
type GetThreadNameProc = procedure(out Name : WideString); stdcall;
type GenerateResultsProc = procedure; stdcall;

var
  pEnableProfiling : EnableProfilingProc;
  pSetThreadName : SetThreadNameProc;
  pGetThreadName : GetThreadNameProc;
  pTakeSnapshot : GenerateResultsProc;

procedure EnableProfiling(Enabled : WordBool);
begin
  if @pEnableProfiling <> nil then
    pEnableProfiling(Enabled);
end;

procedure SetCurrentThreadName(Name : WideString);
begin
  if @pSetThreadName <> nil then
    pSetThreadName(Name);
end;

function GetCurrentThreadName : WideString;
begin
  Result := '';
  if @pGetThreadName <> nil then
    pGetThreadName(Result);
end;

procedure GenerateResults;
begin
  if @pTakeSnapshot <> nil then
    pTakeSnapshot;
end;

procedure InitializeFunctions;
var
  hModule : Cardinal;
begin
  pEnableProfiling := nil;
  pSetThreadName := nil;
  pGetThreadName := nil;

  hModule := GetModuleHandle('aqProf.dll');
  if hModule = 0 then
    Exit;

  pEnableProfiling := GetProcAddress(hModule, 'EnableProfiling');
  pSetThreadName := GetProcAddress(hModule, 'SetCurrentThreadName');
  pGetThreadName := GetProcAddress(hModule, 'GetCurrentThreadName');
  pTakeSnapshot := GetProcAddress(hModule, 'TakeSnapshot');
end;

initialization
  InitializeFunctions();

end.
