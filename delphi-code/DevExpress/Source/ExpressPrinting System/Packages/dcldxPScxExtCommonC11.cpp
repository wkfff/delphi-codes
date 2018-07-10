//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPScxExtCommonC11.res");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPScxExtCommonC11.bpi");
USEPACKAGE("rtl.bpi");
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
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("dxComnC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxPSLnksC11.bpi");
USEPACKAGE("dxPScxCommonC11.bpi");
USEPACKAGE("dcldxPSCoreC11.bpi");
USEUNIT("dxPScxExtDBEditorLnkReg.pas");
USEUNIT("dxPScxExtEditorLnkReg.pas");
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
