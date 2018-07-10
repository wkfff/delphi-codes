//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPScxCommonC11.res");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPScxCommonC11.bpi");
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
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxPSLnksC11.bpi");
USEPACKAGE("dcldxPSCoreC11.bpi");
USEUNIT("dxPScxCommonReg.pas");
USEUNIT("dxPScxDBEditorLnkReg.pas");
USEUNIT("dxPScxEditorLnkReg.pas");
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
