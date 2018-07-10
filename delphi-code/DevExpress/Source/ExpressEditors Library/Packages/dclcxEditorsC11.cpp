//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxEditorsC11.res");
USERES("cxEditReg.dcr");
USERES("cxExtEditReg.dcr");
USERES("cxFilterControlReg.dcr");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vcljpg.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("dcldb.bpi");
USEPACKAGE("dcldxCoreC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEUNIT("cxEditReg.pas");
USEUNIT("cxEditRepositoryEditor.pas");
USEUNIT("cxMaskEditTextEditor.pas");
USEUNIT("cxSelectEditRepositoryItem.pas");
USEUNIT("cxFilterControlReg.pas");
USEUNIT("cxEditPropEditors.pas");
USEUNIT("cxInplaceContainerReg.pas");
USEUNIT("cxExtEditReg.pas");
USEUNIT("cxShellEditorsReg.pas");
USEUNIT("cxHintEditor.pas");
USEUNIT("cxCheckGroupStatesEditor.pas");
USEUNIT("cxSplitterEditor.pas");
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
