//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxEditorsC15.res");
USERES("cxEditReg.dcr");
USERES("cxExtEditReg.dcr");
USERES("cxFilterControlReg.dcr");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("dcldb.bpi");
USEPACKAGE("dcldxCoreC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
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
