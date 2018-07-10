//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "SummaryFooterDemoData.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxGridTableView"
#pragma link "cxStyles"
#pragma resource "*.dfm"
TSummaryFooterDemoDataDM *SummaryFooterDemoDataDM;
//---------------------------------------------------------------------------
__fastcall TSummaryFooterDemoDataDM::TSummaryFooterDemoDataDM(TComponent* Owner)
  : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TSummaryFooterDemoDataDM::tblCustomersCalcFields(
      TDataSet *DataSet)
{
  tblCustomersName->AsString = tblCustomersFirstName->AsString + " " +
    tblCustomersLastName->AsString;
}
//---------------------------------------------------------------------------

