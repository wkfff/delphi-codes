//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USERES("SimpleListDemo.res");
USEFORM("SimpleListDemoMain.cpp", SimpleListDemoMainForm);
USEFORM("SimpleListDemoData.cpp", SimpleListDemoDataDM); /* TDataModule: File Type */
USEFORM("..\Common\DemoRating.cpp", DemoRatingForm);
USEFORM("..\Common\AboutDemoForm.cpp", formAboutDemo);
USEFORM("..\Common\DemoBasicMain.cpp", DemoBasicMainForm);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
  try
  {
     Application->Initialize();
     Application->HelpFile = "..\\..\\Help\\ExpressQuantumTreeList.hlp";
     Application->Title = "ExpressQuantumTreeList SimpleListDemo";
     Application->CreateForm(__classid(TSimpleListDemoDataDM), &SimpleListDemoDataDM);
     Application->CreateForm(__classid(TSimpleListDemoMainForm), &SimpleListDemoMainForm);
     Application->Run();
  }
  catch (Exception &exception)
  {
     Application->ShowException(&exception);
  }
  catch (...)
  {
     try
     {
       throw Exception("");
     }
     catch (Exception &exception)
     {
       Application->ShowException(&exception);
     }
  }
  return 0;
}
//---------------------------------------------------------------------------
