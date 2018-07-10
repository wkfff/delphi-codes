//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSdxOCLnkC11.res");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxOrgCC11.bpi");
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
USEUNIT("dxPSdxOCLnk.pas");
USEFORMNS("dxPSdxOCLnk.pas", dxPSdxOCLnk, dxOCReportLinkDesignWindow);
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
