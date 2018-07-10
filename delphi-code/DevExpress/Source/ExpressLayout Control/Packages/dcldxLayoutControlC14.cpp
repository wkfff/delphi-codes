//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxLayoutControlC14.res");
USERES("dxLayoutControlReg.dcr");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dxComnC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("dxLayoutControlC14.bpi");
USEPACKAGE("dcldb.bpi");
USEPACKAGE("dcldxCoreC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("dclcxEditorsC14.bpi");
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
