//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPScxSSLnkC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("cxSpreadSheetC15.bpi");
USEPACKAGE("dxPSCoreC15.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxComnC15.bpi");
USEUNIT("dxPScxSSLnk.pas");
USEFORMNS("dxPScxSSLnk.pas", dxPScxSSLnk, fmdxSpreadSheetDesignWindow);
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
