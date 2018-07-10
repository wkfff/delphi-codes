//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSDBTeeChartC11.res");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dcldxPSTeeChartC11.bpi");
USEPACKAGE("dxPSDBTeeChartC11.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcljpg.bpi");
USEPACKAGE("dxComnC11.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSTeeChartC11.bpi");
USEPACKAGE("dcldxPSCoreC11.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
USEPACKAGE("teedb.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5C11.bpi");
USEPACKAGE("teedb5C11.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6C11.bpi");
USEPACKAGE("teedb6C11.bpi");
#elif defined(TEE7)
USEPACKAGE("tee711.bpi");
USEPACKAGE("teedb711.bpi");
#elif defined(TEE8)
USEPACKAGE("tee811.bpi");
USEPACKAGE("teedb811.bpi");
#elif defined(TEE9)
USEPACKAGE("tee911.bpi");
USEPACKAGE("teedb911.bpi");
#endif
USEUNIT("dxPSDBTCLnkReg.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
