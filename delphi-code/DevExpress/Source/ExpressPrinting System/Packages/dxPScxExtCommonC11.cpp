//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPScxExtCommonC11.res");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxPScxCommonC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
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
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxPSLnksC11.bpi");
USEUNIT("dxPScxCheckListBoxLnk.pas");
USEUNIT("dxPScxExtComCtrlsLnk.pas");
USEUNIT("dxPScxExtCommon.pas");
USEUNIT("dxPScxExtDBEditorLnks.pas");
USEUNIT("dxPScxExtEditorProducers.pas");
USEUNIT("dxPScxMCListBoxLnk.pas");
USEFORMNS("dxPScxCheckListBoxLnk.pas", dxPScxCheckListBoxLnk, cxfmCheckListBoxDesignWindow);
USEFORMNS("dxPScxMCListBoxLnk.pas", dxPScxMCListBoxLnk, cxfmMCListBoxDesignWindow);
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
