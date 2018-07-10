unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ChildFrm;

type
  TMainForm = class(TForm)
    mmMain: TMainMenu;
    miFile: TMenuItem;
    miOpen: TMenuItem;
    miWindows: TMenuItem;
    miPingpu: TMenuItem;
    miCascade: TMenuItem;
    procedure miCascadeClick(Sender: TObject);
    procedure miOpenClick(Sender: TObject);
    procedure miPingpuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


procedure TMainForm.miCascadeClick(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.miOpenClick(Sender: TObject);
var
  oChildForm: TChildForm;
begin
  oChildForm := TChildForm.Create(Application);
  try
//    oChildForm.Show;
  finally
//    FreeAndNil(oChildForm);
  end;
end;

procedure TMainForm.miPingpuClick(Sender: TObject);
begin
  Tile;
end;

end.
