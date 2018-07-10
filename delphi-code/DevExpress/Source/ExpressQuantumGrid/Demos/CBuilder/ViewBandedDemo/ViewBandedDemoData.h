//---------------------------------------------------------------------------

#ifndef ViewBandedDemoDataH
#define ViewBandedDemoDataH
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
#include <Db.hpp>
//---------------------------------------------------------------------------
class TViewBandedDemoDataDM : public TDataModule
{
__published:	// IDE-managed Components
  TDatabase *DataBase;
  TTable *tblUSERS;
  TDataSource *dsUSERS;
  TDataSource *dsPROJECTS;
  TTable *tblPROJECTS;
  TAutoIncField *tblPROJECTSID;
  TStringField *tblPROJECTSNAME;
  TIntegerField *tblPROJECTSMANAGERID;
  TTable *tlbITEMS;
  TAutoIncField *tlbITEMSID;
  TStringField *tlbITEMSNAME;
  TBooleanField *tlbITEMSTYPE;
  TIntegerField *tlbITEMSPROJECTID;
  TSmallintField *tlbITEMSPRIORITY;
  TSmallintField *tlbITEMSSTATUS;
  TIntegerField *tlbITEMSCREATORID;
  TDateTimeField *tlbITEMSCREATEDDATE;
  TIntegerField *tlbITEMSOWNERID;
  TDateTimeField *tlbITEMSLASTMODIFIEDDATE;
  TDateTimeField *tlbITEMSFIXEDDATE;
  TMemoField *tlbITEMSDESCRIPTION;
  TMemoField *tlbITEMSRESOLUTION;
  TDataSource *dsITEMS;
        TAutoIncField *tblUSERSID;
        TStringField *tblUSERSFNAME;
        TStringField *tblUSERSLNAME;
        TStringField *tblUSERSPHONE;
        TStringField *tblUSERSName;
        void __fastcall tblUSERSCalcFields(TDataSet *DataSet);
private:	// User declarations
public:		// User declarations
  __fastcall TViewBandedDemoDataDM(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TViewBandedDemoDataDM *ViewBandedDemoDataDM;
//---------------------------------------------------------------------------
#endif
