//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSLnksC11.res");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcljpg.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxComnC11.bpi");
USEUNIT("dxPSGrLnks.pas");
USEUNIT("dxPSImgLnk.pas");
USEUNIT("dxPSLbxLnk.pas");
USEUNIT("dxPSChLbxLnk.pas");
USEUNIT("dxPSRELnk.pas");
USEUNIT("dxPSStdGrLnk.pas");
USEUNIT("dxPSTVLnk.pas");
USEUNIT("dxPSDBCtrlLnks.pas");
USEUNIT("dxPSDBCtrlProducers.pas");
USEUNIT("dxPSLVLnk.pas");
USEFORMNS("dxPSLbxLnk.pas", dxPSLbxLnk, dxLBxReportLinkDesignWindow);
USEFORMNS("dxPSChLbxLnk.pas", dxPSChLbxLnk, dxChlbxReportLinkDesignWindow);
USEFORMNS("dxPSStdGrLnk.pas", dxPSStdGrLnk, dxGridReportLinkDesignWindow);
USEFORMNS("dxPSTVLnk.pas", dxPSTVLnk, dxfmTVReportLinkDesignWindow);
USEFORMNS("dxPSLVLnk.pas", dxPSLVLnk, dxfmLVReportLinkDesignWindow);
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
