//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "BaseForm.h"
#include "AboutDemoForm.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmBaseForm::TfmBaseForm(TComponent* Owner): TForm(Owner)
{

};
//---------------------------------------------------------------------------
void __fastcall TfmBaseForm::miAboutClick(TObject *Sender)
{
	ShowAboutDemoForm();
}
//---------------------------------------------------------------------------
void __fastcall TfmBaseForm::miExitClick(TObject *Sender)
{
	Close();
}
//---------------------------------------------------------------------------

