{*------------------------------------------------------------------------------
  Base class to represent Records in Delphi language
  The structure builder will create these objects from the parser informations.

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   Initial revision
  @Version   2006/12/01   TridenT   Extracted from Structure.pas file
-------------------------------------------------------------------------------}

unit uDocRecord;

interface

uses
  Windows, SysUtils, Classes, Contnrs, uTAGComment, uOptions,
  uDocClass;

type

  /// Specialized TDOCClass for Interface structure
  TDOCRecord = class(TDOCClass)
  public
    function CategoryType: TOutputCategoryList; override;
    function GetTemplateName : string; override;
  end;

implementation

function TDOCRecord.CategoryType: TOutputCategoryList;
begin
  Result:=ocRecords;
end;


function TDOCRecord.GetTemplateName: string;
begin
  Result := 'Record';
end;

end.

