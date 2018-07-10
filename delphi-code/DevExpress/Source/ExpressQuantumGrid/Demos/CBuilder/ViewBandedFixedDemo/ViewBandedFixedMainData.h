//---------------------------------------------------------------------------

#ifndef ViewBandedFixedDemoDataH
#define ViewBandedFixedDemoDataH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxClasses.hpp"
#include "cxGridBandedTableView.hpp"
#include "cxStyles.hpp"
#include <DB.hpp>
#include <DBTables.hpp>
//---------------------------------------------------------------------------
class TViewBandedFixedDemoDMMain : public TDataModule
{
__published:	// IDE-managed Components
  TTable *tblSCHEDULER;
  TAutoIncField *tblSCHEDULERID;
  TIntegerField *PROJECTID;
  TIntegerField *USERID;
  TSmallintField *SUNDAY;
  TSmallintField *MONDAY;
  TSmallintField *TUESDAY;
  TSmallintField *WEDNESDAY;
  TSmallintField *THURSDAY;
  TSmallintField *FRIDAY;
  TSmallintField *SATURDAY;
  TFloatField *RowAvg;
  TFloatField *RowSum;
  TStringField *UserName;
  TStringField *FirstName;
  TStringField *MiddleName;
  TStringField *LastName;
  TDataSource *dsSCHEDULER;
  TDataSource *dsUSERS;
  TTable *tblUSERS;
  TAutoIncField *tblUSERSID;
  TStringField *tblUSERSFNAME;
  TStringField *tblUSERSMNAME;
  TStringField *tblUSERSLNAME;
  TStringField *tblUSERSEMAIL;
  TStringField *tblUSERSPHONE;
  TIntegerField *tblUSERSDEPARTMENTID;
  TTable *tblPROJECTS;
  TAutoIncField *tblPROJECTSID;
  TStringField *tblPROJECTSNAME;
  TIntegerField *tblPROJECTSMANAGERID;
  TDataSource *dsPROJECTS;
  TDatabase *DataBase;
  void __fastcall tblSCHEDULERCalcFields(TDataSet *DataSet);
private:	// User declarations
public:		// User declarations
  __fastcall TViewBandedFixedDemoDMMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TViewBandedFixedDemoDMMain *ViewBandedFixedDemoDMMain;
//---------------------------------------------------------------------------
#endif
