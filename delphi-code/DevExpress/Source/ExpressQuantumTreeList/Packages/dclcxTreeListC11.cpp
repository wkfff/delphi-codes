//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxTreeListC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxExportC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("cxTreeListC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dclcxEditorsC11.bpi");
USEPACKAGE("designide.bpi");
USEFORMNS("cxTLEditor.pas", Cxtldsgnedtrs, cxTreeListBandColumnDesigner);
USEFORMNS("cxTLItemsEditor.pas", Cxtlitemsedtr, frmItemsEditor);
USEFORMNS("cxTLPredefinedStyles.pas", Cxtlpredefinedstyles, cxdmTreeListPredefinedStyles); /* TDataModule: DesignClass */
USEUNIT("cxTLReg.pas");
USERES("cxTLReg.dcr");
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
