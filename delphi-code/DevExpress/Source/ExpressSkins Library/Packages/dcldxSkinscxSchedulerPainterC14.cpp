//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinscxSchedulerC14.res");
USEPACKAGE("dxSkinscxSchedulerPainterC14.bpi");
USEPACKAGE("cxSchedulerC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dcldxSkinsCoreC14.bpi");
USEPACKAGE("dcldxSkinsDesignHelperC14.bpi");
USEUNIT("dxSkinscxSchedulerPainterReg.pas");
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
