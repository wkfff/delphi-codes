//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPScxGridLnkC11.res");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vcljpg.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("xmlrtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dxComnC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxExportC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("cxGridC11.bpi");
USEPACKAGE("dxLayoutControlC11.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxPSdxLCLnkC11.bpi");
USEPACKAGE("dxPSLnksC11.bpi");
USEPACKAGE("dxPScxCommonC11.bpi");
USEUNIT("dxPScxGridLnk.pas");
USEUNIT("dxPScxGridLayoutViewLnk.pas");
USEFORMNS("dxPScxGridLnk.pas", dxPScxGridLnk, dxfmGridReportLinkDesignWindow);
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
