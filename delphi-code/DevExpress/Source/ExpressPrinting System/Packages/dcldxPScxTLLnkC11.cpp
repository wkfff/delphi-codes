//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPScxTLLnkC11.res");
USEPACKAGE("designide.bpi");
USEPACKAGE("dcldxPSCoreC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("dxPScxTLLnkC11.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
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
USEPACKAGE("dclstd.bpi");
USEPACKAGE("dcldb.bpi");
USEPACKAGE("dcldxCoreC11.bpi");
USEPACKAGE("dxPSLnksC11.bpi");
USEPACKAGE("dxPScxCommonC11.bpi");
USEPACKAGE("cxExportC11.bpi");
USEPACKAGE("cxTreeListC11.bpi");
USEUNIT("dxPScxTLLnkPredefinedStyleSheets.pas");
USEUNIT("dxPScxTLLnkReg.pas");
USEFORMNS("dxPScxTLLnkPredefinedStyleSheets.pas", dxPScxTLLnkPredefinedStyleSheets, dxdmPScxTreeListLnkPredefinedStyles);
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