//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPScxPCProdC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcljpg.bpi");
USEPACKAGE("dxComnC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("designide.bpi");
USEUNIT("dxPScxPageControlProducer.pas");
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
