//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "DemoDM.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TdmDemo *dmDemo;
//---------------------------------------------------------------------------
__fastcall TdmDemo::TdmDemo(TComponent* Owner)
	: TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
