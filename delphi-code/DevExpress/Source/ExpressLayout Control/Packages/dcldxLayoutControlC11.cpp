//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxLayoutControlC11.res");
USERES("dxLayoutControlReg.dcr");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vcljpg.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dxComnC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("dxLayoutControlC11.bpi");
USEPACKAGE("dcldb.bpi");
USEPACKAGE("dcldxCoreC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("dclcxEditorsC11.bpi");
USEUNIT("dxLayoutLookAndFeelListDesignForm.pas");
USEUNIT("dxLayoutImport.pas");
USEUNIT("dxLayoutControlReg.pas");
USEFORMNS("dxLayoutLookAndFeelListDesignForm.pas", dxLayoutLookAndFeelListDesignForm, dxLayoutLookAndFeelListDesignForm);
USEFORMNS("dxLayoutImport.pas", dxLayoutImport, fmImport);
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
