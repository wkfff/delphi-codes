//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarC11.res");
USERES("dxBarReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxcomnC11.bpi");
USEPACKAGE("dxBarC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEUNIT("dxBarConverter.pas");
USEUNIT("dxBarReg.pas");
USEUNIT("dxStatusBarReg.pas");
USEUNIT("dxStatusIndicatorEditor.pas");
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
