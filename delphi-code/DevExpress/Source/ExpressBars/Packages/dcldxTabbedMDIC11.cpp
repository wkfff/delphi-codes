//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxTabbedMDIC11.res");
USERES("dxTabbedMDIReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxBarC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("dcldxBarC11.bpi");
USEPACKAGE("dxTabbedMDIC11.bpi");
USEUNIT("dxTabbedMDIReg.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
