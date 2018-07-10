{*------------------------------------------------------------------------------
  Base class to represent constants in Delphi language
  The structure builder will create these objects from the parser informations.

  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   Initial revision
  @Version   2006/12/01   TridenT   Extracted from Structure.pas file
-------------------------------------------------------------------------------}

unit uDocConstant;

interface

uses
  Windows, SysUtils, Classes, Contnrs, 
  uOptions,
  uDocTemplate, uDocMember;

type
  
  /// Specialized TDOCTemplate class for Constant structure
  TDOCConstant = class(TDOCMember)
  private
    FIsResourcestring: boolean;
  public
    constructor Create(const st: string; const rp: TDocTemplate); override;
    property IsResourcestring : boolean read FIsResourcestring write FIsResourcestring;
    function CategoryType: TOutputCategoryList; override;
    function GetTemplateName : string; override;
  end;

implementation

function TDOCConstant.CategoryType: TOutputCategoryList;
begin
  if(FIsResourcestring) then Result := ocResourcestrings
  else Result := ocConstants;
end;

constructor TDOCConstant.Create(const st: string; const rp: TDocTemplate);
begin
  inherited;
  FIsResourcestring := False;
end;

function TDOCConstant.GetTemplateName: string;
begin
  Result := 'Constant';
end;

end.
