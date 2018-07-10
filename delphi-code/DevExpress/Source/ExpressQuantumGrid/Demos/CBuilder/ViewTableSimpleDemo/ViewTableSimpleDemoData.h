//---------------------------------------------------------------------------

#ifndef ViewTableSimpleDemoDataH
#define ViewTableSimpleDemoDataH
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
#include <Db.hpp>
//---------------------------------------------------------------------------
class TViewTableSimpleDemoMainDM : public TDataModule
{
__published:	// IDE-managed Components
  TDatabase *DataBase;
  TTable *tlbGENRES;
  TAutoIncField *tlbGENRESID;
  TStringField *tlbGENRESNAME;
  TDataSource *dsGENRES;
  TUpdateSQL* UpdateSQL;
  TQuery *qreFilms;
  TQuery *qreMaxFilmsID;
  TIntegerField* qreMaxFilmsIDMAXOFID;
  TBlobField *qreFilmsICON;
  TStringField *qreFilmsCAPTION;
  TIntegerField *qreFilmsYEAR;
  TStringField *qreFilmsTAGLINE;
  TStringField *qreFilmsPLOTOUTLINE;
  TIntegerField *qreFilmsRUNTIME;
  TStringField *qreFilmsCOLOR;
  TBlobField *qreFilmsPHOTO;
  TStringField *qreFilmsWEBSITE;
  TDataSource *dsFilms;
  TTable *tblFilms;
  TAutoIncField *tblFilmsID;
  TStringField *tblFilmsCAPTION;
  TIntegerField *tblFilmsYEAR;
  TStringField *tblFilmsTAGLINE;
  TStringField *tblFilmsPLOTOUTLINE;
  TIntegerField *tblFilmsRUNTIME;
  TStringField *tblFilmsCOLOR;
  TBlobField *tblFilmsPHOTO;
  TBlobField *tblFilmsICON;
  TStringField *tblFilmsWEBSITE;
  TTable *tblFilmsGenres;
  TAutoIncField *tblFilmsGenresID;
  TIntegerField *tblFilmsGenresFILMID;
  TIntegerField *tblFilmsGenresGENREID;
  void __fastcall qreFilmsAfterDelete(TDataSet *DataSet);
  void __fastcall qreFilmsBeforeDelete(TDataSet *DataSet);
  void __fastcall qreFilmsAfterPost(TDataSet *DataSet);
  void __fastcall qreFilmsAfterInsert(TDataSet *DataSet);
private:	// User declarations
  bool FUpdating;
public:		// User declarations
  __fastcall TViewTableSimpleDemoMainDM(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TViewTableSimpleDemoMainDM *ViewTableSimpleDemoMainDM;
//---------------------------------------------------------------------------
#endif
 