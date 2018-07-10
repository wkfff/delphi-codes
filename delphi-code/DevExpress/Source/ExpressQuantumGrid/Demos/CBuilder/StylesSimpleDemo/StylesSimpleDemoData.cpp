//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "StylesSimpleDemoData.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxGridTableView"
#pragma link "cxStyles"
#pragma resource "*.dfm"
TStylesSimpleDemoMainDM *StylesSimpleDemoMainDM;
//---------------------------------------------------------------------------
__fastcall TStylesSimpleDemoMainDM::TStylesSimpleDemoMainDM(TComponent* Owner)
  : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
