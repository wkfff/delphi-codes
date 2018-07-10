//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSPrVwAdvC11.res");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxBarC11.bpi");
USEPACKAGE("dxBarExtItemsC11.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vcljpg.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxComnC11.bpi");
USEUNIT("dxPSPrVwAdv.pas");
USEFORMNS("dxPSPrVwAdv.pas", dxPSPrVwAdv, dxfmPreviewWdxBar);
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
