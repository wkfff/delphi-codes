//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxRibbonC11.res");
USERES("dxRibbonReg.dcr");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxComnC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxBarC11.bpi");
USEPACKAGE("dxRibbonC11.bpi");
USEPACKAGE("dcldxCoreC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("dcldxBarC11.bpi");
USEUNIT("dxRibbonBackstageViewReg.pas");
USEUNIT("dxRibbonGalleryFilterEd.pas");
USEUNIT("dxRibbonGalleryReg.pas");
USEUNIT("dxRibbonGalleryDesigner.pas");
USEUNIT("dxRibbonReg.pas");
USEUNIT("dxSkinChooserGalleryReg.pas");
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
