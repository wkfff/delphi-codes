//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSCoreC11.res");
USERES("dxPS.dcr.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("dclstd.bpi");
USEPACKAGE("dcldb.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcljpg.bpi");
USEPACKAGE("dxComnC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dcldxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEUNIT("dxPSDsgProxies.pas");
USEUNIT("dxPSDsgUtils.pas");
USEUNIT("dxPSPrVwDsg.pas");
USEUNIT("dxPSfmLnkDsg.pas");
USEUNIT("dxPSfmLnkAdde.pas");
USEUNIT("dxPSfmStlAdd.pas");
USEUNIT("dxPSfmStlDsg.pas");
USEUNIT("dxPSReg.pas");
USEUNIT("dxPSDBBasedXplorerReg.pas");
USEFORMNS("dxPSfmLnkDsg.pas", dxPSfmLnkDsg, dxfmReportLinkDesignWindow);
USEFORMNS("dxPSfmLnkAdde.pas", dxPSfmLnkAdde, dxfmAddReportLinkClass);
USEFORMNS("dxPSfmStlAdd.pas", dxPSfmStlAdd, dxfmSelectStyleClass);
USEFORMNS("dxPSfmStlDsg.pas", dxPSfmStlDsg, dxfmPrintStylesDesignWindow);
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
