//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPScxGridLnkC15.res");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("xmlrtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("dxComnC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExportC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("cxGridC15.bpi");
USEPACKAGE("dxLayoutControlC15.bpi");
USEPACKAGE("dxPSCoreC15.bpi");
USEPACKAGE("dxPSdxLCLnkC15.bpi");
USEPACKAGE("dxPSLnksC15.bpi");
USEPACKAGE("dxPScxCommonC15.bpi");
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
