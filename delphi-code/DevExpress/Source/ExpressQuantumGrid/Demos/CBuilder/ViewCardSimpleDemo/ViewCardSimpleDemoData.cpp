//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "ViewCardSimpleDemoData.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxGridCardView"
#pragma link "cxGridTableView"
#pragma link "cxStyles"
#pragma resource "*.dfm"
TViewCardSimpleDemoMainDM *ViewCardSimpleDemoMainDM;
//---------------------------------------------------------------------------
__fastcall TViewCardSimpleDemoMainDM::TViewCardSimpleDemoMainDM(TComponent* Owner)
  : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
