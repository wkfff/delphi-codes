//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPScxSchedulerLnkC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("dxPScxCommonC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxSchedulerC14.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxComnC14.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dxPSLnksC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxExportC14.bpi");
USEUNIT("dxPScxSchedulerLnk.pas");
USEFORMNS("dxPScxSchedulerLnk.pas", dxPScxSchedulerLnk, cxfmSchedulerReportLinkDesignWindow);
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
