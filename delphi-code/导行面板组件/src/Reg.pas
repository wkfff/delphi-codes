unit Reg;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,NavBar,DesignEditors,DesignIntf;

type
  TmrNavBarComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TNavGroupsPropertyEdit = class(TClassProperty)
  public
    procedure Edit;override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure Register;

implementation

uses DesignBar;

procedure Register;
begin
  RegisterComponents('NavExpress',[TmrNavBar]);
  RegisterComponentEditor(TmrNavBar, TmrNavBarComponentEditor);
  RegisterPropertyEditor(TypeInfo(TNavGroups),TmrNavBar,'NavGroups',TNavGroupsPropertyEdit);
end;

{ TmrNavBarComponentEditor }

procedure TmrNavBarComponentEditor.ExecuteVerb(Index: Integer);
var
  DesginWindow:TFrmDesignBar;
begin
  inherited;
  if Index = 0 then
  begin
    DesginWindow := TFrmDesignBar.Create(nil);
    DesginWindow.Designer := Designer;
    DesginWindow.NavBar := TmrNavBar(Component);
    DesginWindow.Show;
  end;

end;

function TmrNavBarComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Edit Groups'
  else Result := '';
end;

function TmrNavBarComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TNavGroupsPropertyEdit }

procedure TNavGroupsPropertyEdit.Edit;
var
  DesginWindow:TFrmDesignBar;
begin
  inherited;
  DesginWindow := TFrmDesignBar.Create(nil);
  DesginWindow.Designer := Designer;
  DesginWindow.NavBar := TmrNavBar(GetComponent(0));
  DesginWindow.Show;
end;

function TNavGroupsPropertyEdit.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

end.
