//---------------------------------------------------------------------------

#ifndef MasterDetailTableDemoDataH
#define MasterDetailTableDemoDataH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxClasses.hpp"
#include "cxGridTableView.hpp"
#include "cxStyles.hpp"
#include <DB.hpp>
#include <DBTables.hpp>
//---------------------------------------------------------------------------
class TMasterDetailTableDemoMainDM : public TDataModule
{
__published:	// IDE-managed Components
  TDataSource *dsFilms;
  TDataSource *dsFilmsPersonsStaff;
  TDataSource *dsPersons;
  TDataSource *dsPersonsLine;
  TTable *tblFilms;
  TTable *tblFilmsPersonsStaff;
  TTable *tblPersons;
  TAutoIncField *tblPersonsID;
  TStringField *tblPersonsFIRSTNAME;
  TStringField *tblPersonsSECONDNAME;
  TBooleanField *tblPersonsGENDER;
  TStringField *tblPersonsNAME;
  TDateTimeField *tblPersonsDATEOFBIRTH;
  TIntegerField *tblPersonsBIRTHCOUNTRY;
  TStringField *tblPersonsLOCATIONOFBIRTH;
  TMemoField *tblPersonsBIOGRAPHY;
  TStringField *tblPersonsNICKNAME;
  TTable *tblPersonsLine;
  TDatabase *DataBase;
  void __fastcall tblPersonsCalcFields(TDataSet *DataSet);
private:	// User declarations
public:		// User declarations
  __fastcall TMasterDetailTableDemoMainDM(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMasterDetailTableDemoMainDM *MasterDetailTableDemoMainDM;
//---------------------------------------------------------------------------
#endif
