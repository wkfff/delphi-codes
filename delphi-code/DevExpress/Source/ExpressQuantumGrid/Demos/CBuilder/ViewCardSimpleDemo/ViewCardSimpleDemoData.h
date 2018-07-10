//---------------------------------------------------------------------------

#ifndef ViewCardSimpleDemoDataH
#define ViewCardSimpleDemoDataH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxClasses.hpp"
#include "cxGridCardView.hpp"
#include "cxGridTableView.hpp"
#include "cxStyles.hpp"
#include <DB.hpp>
#include <DBTables.hpp>
#include <Db.hpp>
//---------------------------------------------------------------------------
class TViewCardSimpleDemoMainDM : public TDataModule
{
__published:	// IDE-managed Components
  TDatabase *DataBase;
  TTable *tlbDEPARTMENTS;
  TAutoIncField *tlbDEPARTMENTSID;
  TStringField *tlbDEPARTMENTSNAME;
  TDataSource *dsDEPARTMENTS;
  TDataSource *dsUSERS;
  TTable *tlbUSERS;
private:	// User declarations
public:		// User declarations
  __fastcall TViewCardSimpleDemoMainDM(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TViewCardSimpleDemoMainDM *ViewCardSimpleDemoMainDM;
//---------------------------------------------------------------------------
#endif
