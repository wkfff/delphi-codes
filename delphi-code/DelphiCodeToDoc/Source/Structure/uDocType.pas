{*------------------------------------------------------------------------------
  Base class to represent types in Delphi language
  The structure builder will create these objects from the parser informations.

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   Initial revision
  @Version   2006/12/01   TridenT   Extracted from Structure.pas file
-------------------------------------------------------------------------------}

unit uDocType;

interface

uses
  Windows, SysUtils, Classes, Contnrs, 
  uTAGComment, uOptions, uDocFunction, uDocMethod,
  uDocMember, uDocTemplate;

type
  /// Specialized TDOCTemplate class for Type structure
  TDOCType = class(TDOCMember)
  public
    function CategoryType: TOutputCategoryList; override;
    function GetTemplateName : string; override;
  end;

  /// Function type is a Special Type handling also a function description
  TDOCFunctionType = class(TDOCType)
  public
    DocFunction : TDOCFunction; /// Function prototype linked to the type
    constructor Create(const st: string; const rp: TDocTemplate); override;
    destructor Destroy; override;
    procedure UpdateTagCoverage; override;
  end;

implementation

function TDOCType.CategoryType: TOutputCategoryList;
begin
  Result:=ocTypes;
end;

function TDOCType.GetTemplateName: string;
begin
  Result := 'Type';
end;

{ TDOCFunctionType }

constructor TDOCFunctionType.Create(const st: string; const rp: TDocTemplate);
begin
  inherited;
  // Create associated function
  DocFunction := TDOCFunction.Create(st, Self);
end;

destructor TDOCFunctionType.Destroy;
begin
  FreeAndNil(DocFunction);
  inherited;
end;

procedure TDOCFunctionType.UpdateTagCoverage;
var
  IndexParam : integer;
begin
  inherited;
  //DocFunction.UpdateTagCoverage;
  for IndexParam := 0 to DocFunction.ParameterList.Count - 1 do
  begin
    // Method must have a @param TAG for each parameter
    CheckTagCoverage(dtParamTAG, DocFunction.ParameterList.Items[IndexParam].Name);  //dtParamTAG
  end;
  // Check also return value for function
  if(DocFunction.MethodType = mtFunction) then
   CheckTagCoverage(dtReturnTAG);
end;

end.

