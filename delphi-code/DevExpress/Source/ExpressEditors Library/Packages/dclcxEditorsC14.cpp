//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxEditorsC14.res");
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
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("dcldb.bpi");
USEPACKAGE("dcldxCoreC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
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
