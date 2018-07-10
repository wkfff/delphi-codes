//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "StylesCardViewDemoData.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxGridTableView"
#pragma link "cxStyles"
#pragma link "cxDBEditRepository"
#pragma link "cxEdit"
#pragma link "cxEditRepositoryItems"
#pragma link "cxGridCardView"
#pragma resource "*.dfm"
TStylesCardViewDemoMainDM *StylesCardViewDemoMainDM;
//---------------------------------------------------------------------------
__fastcall TStylesCardViewDemoMainDM::TStylesCardViewDemoMainDM(TComponent* Owner)
  : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TStylesCardViewDemoMainDM::tblPersonsCalcFields(
      TDataSet *DataSet)
{
  tblPersonsFullName->AsString = tblPersonsFIRSTNAME->AsString + " " +
    tblPersonsSECONDNAME->AsString + " " + "(" +
    IntToStr(tblPersonsID->AsInteger) + ")";
}
//---------------------------------------------------------------------------

