//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxLayoutControlC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxComnC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vcljpg.bpi");
USEPACKAGE("cxDataC11.bpi");
USEUNIT("dxLayoutLookAndFeels.pas");
USEUNIT("dxLayoutControl.pas");
USEUNIT("dxLayoutContainer.pas");
USEUNIT("dxLayoutControlAdapters.pas");
USEUNIT("dxLayoutCustomizeForm.pas");
USEUNIT("dxLayoutEditForm.pas");
USEUNIT("dxLayoutDragAndDrop.pas");
USEUNIT("dxLayoutSelection.pas");
USEUNIT("dxLayoutCommon.pas");
USEUNIT("dxLayoutcxEditAdapters.pas");
USEFORMNS("dxLayoutCustomizeForm.pas", dxLayoutCustomizeForm, dxLayoutControlCustomizeForm);
USEFORMNS("dxLayoutEditForm.pas", dxLayoutEditForm, LayoutEditForm);
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
