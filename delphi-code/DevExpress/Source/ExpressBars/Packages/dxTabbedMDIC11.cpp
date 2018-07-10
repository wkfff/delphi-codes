//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxTabbedMDIC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEUNIT("dxTabbedMDI.pas");
USEUNIT("dxTabbedMDIStrs.pas");
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
