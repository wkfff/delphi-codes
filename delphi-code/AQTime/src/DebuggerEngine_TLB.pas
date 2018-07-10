unit DebuggerEngine_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 6/19/2009 3:52:35 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: DebuggerEngine.tlb (1)
// LIBID: {7D216319-F771-4975-94AC-DE08ED453632}
// LCID: 0
// Helpfile: 
// HelpString: DebuggerEngine Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Hint: TypeInfo 'DebuggerEngine' changed to 'DebuggerEngine_'
//   Hint: Parameter 'Type' of IaqDebugProcess.VirtualQuery changed to 'Type_'
//   Hint: Member 'String' of 'IaqDebugString' changed to 'String_'
//   Hint: TypeInfo 'DebuggerEngine' changed to 'DebuggerEngine_'
//   Hint: Member 'String' of 'IaqDebugString' changed to 'String_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses ActiveX;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  DebuggerEngineMajorVersion = 6;
  DebuggerEngineMinorVersion = 21;

  LIBID_DebuggerEngine: TGUID = '{7D216319-F771-4975-94AC-DE08ED453632}';

  IID_IaqDebuggerEngineModule: TGUID = '{7D216319-F771-4975-94AC-DE08ED453646}';
  IID_IaqDebuggerEngine: TGUID = '{7D216319-F771-4975-94AC-DE08ED453645}';
  IID_IaqDebugListener: TGUID = '{7D216319-F771-4975-94AC-DE08ED453634}';
  IID_IaqDebugProcess: TGUID = '{7D216319-F771-4975-94AC-DE08ED453635}';
  IID_IaqDebugProcessObject: TGUID = '{7D216319-F771-4975-94AC-DE08ED453637}';
  IID_IaqDebugThread: TGUID = '{7D216319-F771-4975-94AC-DE08ED453639}';
  IID_IEnumUnknown: TGUID = '{00000100-0000-0000-C000-000000000046}';
  IID_IaqDebugModule: TGUID = '{7D216319-F771-4975-94AC-DE08ED453638}';
  IID_IaqBreakpoint: TGUID = '{7D216319-F771-4975-94AC-DE08ED453642}';
  IID_IaqDebugBreakpoint: TGUID = '{7D216319-F771-4975-94AC-DE08ED453643}';
  IID_IaqDebugStack: TGUID = '{7D216319-F771-4975-94AC-DE08ED453644}';
  IID_IaqDebugProcessOptions: TGUID = '{7D216319-F771-4975-94AC-DE08ED453636}';
  IID_IaqDebugException: TGUID = '{7D216319-F771-4975-94AC-DE08ED453640}';
  IID_IaqDebugString: TGUID = '{7D216319-F771-4975-94AC-DE08ED453641}';
  IID_IaqClrDebugListener: TGUID = '{7D216319-F771-4975-94AC-DE08ED453647}';
  CLASS_DebuggerEngine_: TGUID = '{7D216319-F771-4975-94AC-DE08ED453633}';
  IID_IaqClrDebugAppDomain: TGUID = '{7D216319-F771-4975-94AC-DE08ED453649}';
  IID_IaqClrDebugAssembly: TGUID = '{7D216319-F771-4975-94AC-DE08ED453650}';
  IID_IaqClrDebugModule: TGUID = '{7D216319-F771-4975-94AC-DE08ED453651}';
  IID_IaqClrDebugException: TGUID = '{7D216319-F771-4975-94AC-DE08ED453648}';
  IID_IaqClrDebugStack: TGUID = '{7D216319-F771-4975-94AC-DE08ED453652}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IaqDebuggerEngineModule = interface;
  IaqDebuggerEngine = interface;
  IaqDebuggerEngineDisp = dispinterface;
  IaqDebugListener = interface;
  IaqDebugProcess = interface;
  IaqDebugProcessObject = interface;
  IaqDebugThread = interface;
  IEnumUnknown = interface;
  IaqDebugModule = interface;
  IaqBreakpoint = interface;
  IaqDebugBreakpoint = interface;
  IaqDebugStack = interface;
  IaqDebugProcessOptions = interface;
  IaqDebugException = interface;
  IaqDebugString = interface;
  IaqClrDebugListener = interface;
  IaqClrDebugAppDomain = interface;
  IaqClrDebugAssembly = interface;
  IaqClrDebugModule = interface;
  IaqClrDebugException = interface;
  IaqClrDebugStack = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DebuggerEngine_ = IaqDebuggerEngine;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//

  ULONG_PTR = LongWord; 

// *********************************************************************//
// Interface: IaqDebuggerEngineModule
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453646}
// *********************************************************************//
  IaqDebuggerEngineModule = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453646}']
    function Get_Engine: IaqDebuggerEngine; safecall;
    property Engine: IaqDebuggerEngine read Get_Engine;
  end;

// *********************************************************************//
// Interface: IaqDebuggerEngine
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7D216319-F771-4975-94AC-DE08ED453645}
// *********************************************************************//
  IaqDebuggerEngine = interface(IDispatch)
    ['{7D216319-F771-4975-94AC-DE08ED453645}']
    function StartProcess(const pListener: IaqDebugListener; const AppPath: WideString; 
                          const CmdLine: WideString; const WorkDir: WideString; 
                          pEnvironmentVariables: PSafeArray; const DllForInjecting: WideString; 
                          const WinStation: WideString; bNotifyInMainThread: WordBool; 
                          out pVal: IaqDebugProcess): WordBool; safecall;
    function StartProcessAsUser(const pListener: IaqDebugListener; const AppPath: WideString; 
                                const CmdLine: WideString; const WorkDir: WideString; 
                                hUserToken: LongWord; hStdInput: LongWord; hStdOutput: LongWord; 
                                hStdError: LongWord; pEnvironmentVariables: PSafeArray; 
                                const DllForInjecting: WideString; const WinStation: WideString; 
                                bNotifyInMainThread: WordBool; out pVal: IaqDebugProcess): WordBool; safecall;
    function AttachToProcess(const pListener: IaqDebugListener; ProcessId: LongWord; 
                             pEnvironmentVariables: PSafeArray; const DllForInjecting: WideString; 
                             bNotifyInMainThread: WordBool; out pVal: IaqDebugProcess): WordBool; safecall;
    function CeStartProcess(const pListener: IaqDebugListener; const AppPath: WideString; 
                            const CmdLine: WideString; const WorkDir: WideString; 
                            const DllForInjecting: WideString; bNotifyInMainThread: WordBool; 
                            out pVal: IaqDebugProcess): WordBool; safecall;
    procedure Finalize; safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqDebuggerEngineDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7D216319-F771-4975-94AC-DE08ED453645}
// *********************************************************************//
  IaqDebuggerEngineDisp = dispinterface
    ['{7D216319-F771-4975-94AC-DE08ED453645}']
    function StartProcess(const pListener: IaqDebugListener; const AppPath: WideString; 
                          const CmdLine: WideString; const WorkDir: WideString; 
                          pEnvironmentVariables: {??PSafeArray}OleVariant; 
                          const DllForInjecting: WideString; const WinStation: WideString; 
                          bNotifyInMainThread: WordBool; out pVal: IaqDebugProcess): WordBool; dispid 1;
    function StartProcessAsUser(const pListener: IaqDebugListener; const AppPath: WideString; 
                                const CmdLine: WideString; const WorkDir: WideString; 
                                hUserToken: LongWord; hStdInput: LongWord; hStdOutput: LongWord; 
                                hStdError: LongWord; 
                                pEnvironmentVariables: {??PSafeArray}OleVariant; 
                                const DllForInjecting: WideString; const WinStation: WideString; 
                                bNotifyInMainThread: WordBool; out pVal: IaqDebugProcess): WordBool; dispid 2;
    function AttachToProcess(const pListener: IaqDebugListener; ProcessId: LongWord; 
                             pEnvironmentVariables: {??PSafeArray}OleVariant; 
                             const DllForInjecting: WideString; bNotifyInMainThread: WordBool; 
                             out pVal: IaqDebugProcess): WordBool; dispid 3;
    function CeStartProcess(const pListener: IaqDebugListener; const AppPath: WideString; 
                            const CmdLine: WideString; const WorkDir: WideString; 
                            const DllForInjecting: WideString; bNotifyInMainThread: WordBool; 
                            out pVal: IaqDebugProcess): WordBool; dispid 4;
    procedure Finalize; dispid 5;
  end;

// *********************************************************************//
// Interface: IaqDebugListener
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453634}
// *********************************************************************//
  IaqDebugListener = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453634}']
    procedure OnCreateProcess(const pProcess: IaqDebugProcess); safecall;
    procedure OnTerminateProcess(const pProcess: IaqDebugProcess; IsKilled: WordBool); safecall;
    procedure OnResumeProcess(const pProcess: IaqDebugProcess); safecall;
    procedure OnSuspendProcess(const pProcess: IaqDebugProcess); safecall;
    procedure OnDetachFromProcess(const pProcess: IaqDebugProcess); safecall;
    procedure OnLoadModule(const pModule: IaqDebugModule); safecall;
    procedure OnUnloadModule(const pModule: IaqDebugModule); safecall;
    procedure OnModuleStarted(const pModule: IaqDebugModule); safecall;
    procedure OnCreateThead(const pThread: IaqDebugThread); safecall;
    procedure OnExitThread(const pThread: IaqDebugThread); safecall;
    procedure OnDebugString(const str: IaqDebugString); safecall;
    procedure OnOutputDebugStringCalled(const str: IaqDebugString); safecall;
    procedure OnException(const pException: IaqDebugException); safecall;
    procedure OnInjectDll; safecall;
    procedure OnBreakpoint(const pBreakPoint: IaqDebugBreakpoint); safecall;
    procedure OnUserBreakpoint(const pBreakPoint: IaqBreakpoint); safecall;
    procedure OnSetThreadName(const pThread: IaqDebugThread; const Name: WideString); safecall;
  end;

// *********************************************************************//
// Interface: IaqDebugProcess
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453635}
// *********************************************************************//
  IaqDebugProcess = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453635}']
    function Get_ProcessId: LongWord; safecall;
    function Get_MainThread: IaqDebugThread; safecall;
    function Get_ImageBase: Largeuint; safecall;
    function Get_IsExists: WordBool; safecall;
    function Get_IsSuspended: WordBool; safecall;
    procedure Suspend; safecall;
    procedure Resume; safecall;
    procedure Terminate; safecall;
    procedure Detach; safecall;
    function Get_Modules: IEnumUnknown; safecall;
    function Get_ModuleByAddress(Address: Largeuint): IaqDebugModule; safecall;
    function Get_Threads: IEnumUnknown; safecall;
    function Get_EventThread: IaqDebugThread; safecall;
    function ReadProcessMemory(StartAddress: Largeuint; out lpBuffer: PSafeArray; 
                               var pSize: LongWord): WordBool; safecall;
    function WriteProcessMemory(StartAddress: Largeuint; lpBuffer: PSafeArray; 
                                out pSizeWritten: LongWord): WordBool; safecall;
    function GetExitCode(out pExitCode: Integer): WordBool; safecall;
    function VirtualProtect(StartAddress: Largeuint; Size: LongWord; dwProtect: LongWord; 
                            out pdwOldProtect: LongWord): WordBool; safecall;
    function VirtualAlloc(Address: Largeuint; Size: LongWord; dwAllocationType: LongWord; 
                          dwProtect: LongWord): Largeuint; safecall;
    procedure VirtualFree(Address: Largeuint; Size: LongWord; dwFreeType: LongWord); safecall;
    procedure VirtualQuery(Address: Largeuint; out pBaseAddress: Largeuint; 
                           out pAllocationBase: Largeuint; out AllocationProtect: LongWord; 
                           out RegionSize: Largeuint; out State: LongWord; out Protect: LongWord; 
                           out Type_: LongWord); safecall;
    function GetStack(UseStack: WordBool; ThreadId: LongWord; Size: LongWord): IaqDebugStack; safecall;
    procedure Discard; safecall;
    procedure ExecuteInjectedDllRoutine(Address: Largeuint; TransferDataBufferAddress: Largeuint; 
                                        DataArray: PSafeArray); safecall;
    function MakeUnloadLast(const DllPath: WideString): WordBool; safecall;
    function Get_ProcessIsStartedByDebugger: WordBool; safecall;
    function Get_ProcessIs64bit: WordBool; safecall;
    function Get_Options: IaqDebugProcessOptions; safecall;
    procedure GenerateDump(const FileName: WideString; const pException: IaqDebugException); safecall;
    property ProcessId: LongWord read Get_ProcessId;
    property MainThread: IaqDebugThread read Get_MainThread;
    property ImageBase: Largeuint read Get_ImageBase;
    property IsExists: WordBool read Get_IsExists;
    property IsSuspended: WordBool read Get_IsSuspended;
    property Modules: IEnumUnknown read Get_Modules;
    property ModuleByAddress[Address: Largeuint]: IaqDebugModule read Get_ModuleByAddress;
    property Threads: IEnumUnknown read Get_Threads;
    property EventThread: IaqDebugThread read Get_EventThread;
    property ProcessIsStartedByDebugger: WordBool read Get_ProcessIsStartedByDebugger;
    property ProcessIs64bit: WordBool read Get_ProcessIs64bit;
    property Options: IaqDebugProcessOptions read Get_Options;
  end;

// *********************************************************************//
// Interface: IaqDebugProcessObject
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453637}
// *********************************************************************//
  IaqDebugProcessObject = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453637}']
    function Get_Process: IaqDebugProcess; safecall;
    function Get_CreatorThread: IaqDebugThread; safecall;
    property Process: IaqDebugProcess read Get_Process;
    property CreatorThread: IaqDebugThread read Get_CreatorThread;
  end;

// *********************************************************************//
// Interface: IaqDebugThread
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453639}
// *********************************************************************//
  IaqDebugThread = interface(IaqDebugProcessObject)
    ['{7D216319-F771-4975-94AC-DE08ED453639}']
    function Get_ThreadId: LongWord; safecall;
    procedure Set_Priority(pPriority: SYSINT); safecall;
    function Get_Priority: SYSINT; safecall;
    function Get_IsSuspended: WordBool; safecall;
    procedure Suspend; safecall;
    procedure Resume; safecall;
    function GetExitCode(out pExitCode: Integer): WordBool; safecall;
    procedure GetRegisters(out pEAX: Largeuint; out pEBX: Largeuint; out pECX: Largeuint; 
                           out pEDX: Largeuint; out pESI: Largeuint; out pEDI: Largeuint; 
                           out pESP: Largeuint; out pEBP: Largeuint; out pEIP: Largeuint); safecall;
    procedure GetRegistersEx(out pR8: Largeuint; out pR9: Largeuint; out pR10: Largeuint; 
                             out pR11: Largeuint; out pR12: Largeuint; out pR13: Largeuint; 
                             out pR14: Largeuint; out pR15: Largeuint); safecall;
    function Get_StackTop: ULONG_PTR; safecall;
    procedure ReserveSpaceAtStack(Bytes: LongWord); safecall;
    function Get_ThreadName: WideString; safecall;
    property ThreadId: LongWord read Get_ThreadId;
    property Priority: SYSINT read Get_Priority write Set_Priority;
    property IsSuspended: WordBool read Get_IsSuspended;
    property StackTop: ULONG_PTR read Get_StackTop;
    property ThreadName: WideString read Get_ThreadName;
  end;

// *********************************************************************//
// Interface: IEnumUnknown
// Flags:     (0)
// GUID:      {00000100-0000-0000-C000-000000000046}
// *********************************************************************//
  IEnumUnknown = interface(IUnknown)
    ['{00000100-0000-0000-C000-000000000046}']
    procedure RemoteNext(celt: LongWord; out rgelt: IUnknown; out pceltFetched: LongWord); safecall;
    procedure Skip(celt: LongWord); safecall;
    procedure Reset; safecall;
    procedure Clone(out ppenum: IEnumUnknown); safecall;
  end;

// *********************************************************************//
// Interface: IaqDebugModule
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453638}
// *********************************************************************//
  IaqDebugModule = interface(IaqDebugProcessObject)
    ['{7D216319-F771-4975-94AC-DE08ED453638}']
    function Get_LoadAddress: Largeuint; safecall;
    function Get_FileSize: LongWord; safecall;
    function Get_ImageSize: LongWord; safecall;
    function Get_Name: WideString; safecall;
    function Get_IsFirstModule: WordBool; safecall;
    function SetBreakpoint(RVA: Largeuint): IaqDebugBreakpoint; safecall;
    procedure RemoveBreakpoint(RVA: Largeuint); safecall;
    procedure RemoveAllBreakpoints; safecall;
    property LoadAddress: Largeuint read Get_LoadAddress;
    property FileSize: LongWord read Get_FileSize;
    property ImageSize: LongWord read Get_ImageSize;
    property Name: WideString read Get_Name;
    property IsFirstModule: WordBool read Get_IsFirstModule;
  end;

// *********************************************************************//
// Interface: IaqBreakpoint
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453642}
// *********************************************************************//
  IaqBreakpoint = interface(IaqDebugProcessObject)
    ['{7D216319-F771-4975-94AC-DE08ED453642}']
    function Get_Module: IaqDebugModule; safecall;
    function Get_RVA: Largeuint; safecall;
    function Get_Address: Largeuint; safecall;
    property Module: IaqDebugModule read Get_Module;
    property RVA: Largeuint read Get_RVA;
    property Address: Largeuint read Get_Address;
  end;

// *********************************************************************//
// Interface: IaqDebugBreakpoint
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453643}
// *********************************************************************//
  IaqDebugBreakpoint = interface(IaqBreakpoint)
    ['{7D216319-F771-4975-94AC-DE08ED453643}']
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pbEnabled: WordBool); safecall;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
  end;

// *********************************************************************//
// Interface: IaqDebugStack
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453644}
// *********************************************************************//
  IaqDebugStack = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453644}']
    function Get_Size: LongWord; safecall;
    function Get_Modules(no: LongWord): IaqDebugModule; safecall;
    function Get_Addresses(no: LongWord): ULONG_PTR; safecall;
    property Size: LongWord read Get_Size;
    property Modules[no: LongWord]: IaqDebugModule read Get_Modules;
    property Addresses[no: LongWord]: ULONG_PTR read Get_Addresses;
  end;

// *********************************************************************//
// Interface: IaqDebugProcessOptions
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453636}
// *********************************************************************//
  IaqDebugProcessOptions = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453636}']
    procedure SetDefault; safecall;
    function Get_AllowToObtainStackForDebugString: WordBool; safecall;
    procedure Set_AllowToObtainStackForDebugString(pRes: WordBool); safecall;
    function Get_AllowClrDebug: WordBool; safecall;
    procedure Set_AllowClrDebug(pRes: WordBool); safecall;
    property AllowToObtainStackForDebugString: WordBool read Get_AllowToObtainStackForDebugString write Set_AllowToObtainStackForDebugString;
    property AllowClrDebug: WordBool read Get_AllowClrDebug write Set_AllowClrDebug;
  end;

// *********************************************************************//
// Interface: IaqDebugException
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453640}
// *********************************************************************//
  IaqDebugException = interface(IaqDebugProcessObject)
    ['{7D216319-F771-4975-94AC-DE08ED453640}']
    function Get_Address: Largeuint; safecall;
    function Get_Code: Integer; safecall;
    function GetDescription(const HexFormatString: WideString): WideString; safecall;
    function GetStack(UseStack: WordBool; Size: LongWord): IaqDebugStack; safecall;
    function Get_FirstChance: LongWord; safecall;
    function Get_ExceptionRecord: ULONG_PTR; safecall;
    property Address: Largeuint read Get_Address;
    property Code: Integer read Get_Code;
    property FirstChance: LongWord read Get_FirstChance;
    property ExceptionRecord: ULONG_PTR read Get_ExceptionRecord;
  end;

// *********************************************************************//
// Interface: IaqDebugString
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453641}
// *********************************************************************//
  IaqDebugString = interface(IaqDebugProcessObject)
    ['{7D216319-F771-4975-94AC-DE08ED453641}']
    function Get_String_: WideString; safecall;
    property String_: WideString read Get_String_;
  end;

// *********************************************************************//
// Interface: IaqClrDebugListener
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453647}
// *********************************************************************//
  IaqClrDebugListener = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453647}']
    procedure OnCreateAppDomain(const pDomain: IaqClrDebugAppDomain); safecall;
    procedure OnExitAppDomain(const pDomain: IaqClrDebugAppDomain); safecall;
    procedure OnLoadAssembly(const pAssembly: IaqClrDebugAssembly); safecall;
    procedure OnUnloadAssembly(const pAssembly: IaqClrDebugAssembly); safecall;
    procedure OnLoadClrModule(const pModule: IaqClrDebugModule); safecall;
    procedure OnUnloadClrModule(const pModule: IaqClrDebugModule); safecall;
    procedure OnClrException(const pException: IaqClrDebugException); safecall;
  end;

// *********************************************************************//
// Interface: IaqClrDebugAppDomain
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453649}
// *********************************************************************//
  IaqClrDebugAppDomain = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453649}']
    function Get_Name: WideString; safecall;
    function Get_Id: Integer; safecall;
    property Name: WideString read Get_Name;
    property Id: Integer read Get_Id;
  end;

// *********************************************************************//
// Interface: IaqClrDebugAssembly
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453650}
// *********************************************************************//
  IaqClrDebugAssembly = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453650}']
    function Get_Name: WideString; safecall;
    function Get_Domain: IaqClrDebugAppDomain; safecall;
    property Name: WideString read Get_Name;
    property Domain: IaqClrDebugAppDomain read Get_Domain;
  end;

// *********************************************************************//
// Interface: IaqClrDebugModule
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453651}
// *********************************************************************//
  IaqClrDebugModule = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453651}']
    function Get_Name: WideString; safecall;
    function Get_Assembly: IaqClrDebugAssembly; safecall;
    property Name: WideString read Get_Name;
    property Assembly: IaqClrDebugAssembly read Get_Assembly;
  end;

// *********************************************************************//
// Interface: IaqClrDebugException
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453648}
// *********************************************************************//
  IaqClrDebugException = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453648}']
    function Get_ClsName: WideString; safecall;
    function Get_Message: WideString; safecall;
    function Get_ThreadId: LongWord; safecall;
    function Get_Stack: IaqClrDebugStack; safecall;
    function Get_Process: IaqDebugProcess; safecall;
    property ClsName: WideString read Get_ClsName;
    property Message: WideString read Get_Message;
    property ThreadId: LongWord read Get_ThreadId;
    property Stack: IaqClrDebugStack read Get_Stack;
    property Process: IaqDebugProcess read Get_Process;
  end;

// *********************************************************************//
// Interface: IaqClrDebugStack
// Flags:     (256) OleAutomation
// GUID:      {7D216319-F771-4975-94AC-DE08ED453652}
// *********************************************************************//
  IaqClrDebugStack = interface(IUnknown)
    ['{7D216319-F771-4975-94AC-DE08ED453652}']
    function Get_Size: LongWord; safecall;
    function Get_Modules(Index: LongWord): IaqClrDebugModule; safecall;
    function Get_Tokens(Index: LongWord): LongWord; safecall;
    function Get_Names(Index: LongWord): WideString; safecall;
    function Get_Offsets(Index: LongWord): LongWord; safecall;
    procedure StackRanges(Index: LongWord; out pStart: Largeuint; out pEnd: Largeuint); safecall;
    property Size: LongWord read Get_Size;
    property Modules[Index: LongWord]: IaqClrDebugModule read Get_Modules;
    property Tokens[Index: LongWord]: LongWord read Get_Tokens;
    property Names[Index: LongWord]: WideString read Get_Names;
    property Offsets[Index: LongWord]: LongWord read Get_Offsets;
  end;

// *********************************************************************//
// The Class CoDebuggerEngine_ provides a Create and CreateRemote method to          
// create instances of the default interface IaqDebuggerEngine exposed by              
// the CoClass DebuggerEngine_. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDebuggerEngine_ = class
    class function Create: IaqDebuggerEngine;
    class function CreateRemote(const MachineName: string): IaqDebuggerEngine;
  end;

implementation

uses ComObj;

class function CoDebuggerEngine_.Create: IaqDebuggerEngine;
begin
  Result := CreateComObject(CLASS_DebuggerEngine_) as IaqDebuggerEngine;
end;

class function CoDebuggerEngine_.CreateRemote(const MachineName: string): IaqDebuggerEngine;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DebuggerEngine_) as IaqDebuggerEngine;
end;

end.
