unit uManageTestClasses;

interface

uses
  uTestBuildTokenList, uTestJcfUnicode, TestFramework;

implementation

resourcestring
  sTest = 'test';


initialization
  RegisterTest('', TTestBuildTokenList.Suite);
//  RegisterTest('', TTestJcfUnicode.Suite);

end.
