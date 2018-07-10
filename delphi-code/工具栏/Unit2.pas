unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TBX, TB2Item, TB2Dock, TB2Toolbar, ActnList, StdCtrls;

type
  TForm1 = class(TForm)
    tbxdck1: TTBXDock;
    tbxtlbr1: TTBXToolbar;
    tbx1: TTBXSubmenuItem;
    tbx2: TTBXItem;
    tbx3: TTBXItem;
    actlst1: TActionList;
    ac1: TAction;
    ac2: TAction;
    ac3: TAction;
    tbsbmntm1: TTBSubmenuItem;
    tbx4: TTBXItem;
    tbx5: TTBXItem;
    ck1: TCheckBox;
    procedure ac1Execute(Sender: TObject);
    procedure ac2Execute(Sender: TObject);
    procedure ac3Execute(Sender: TObject);
    procedure ck1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ac1Execute(Sender: TObject);
begin
//
end;

procedure TForm1.ac2Execute(Sender: TObject);
begin
//
end;

procedure TForm1.ac3Execute(Sender: TObject);
begin
//
end;

procedure TForm1.ck1Click(Sender: TObject);
begin
    ac1.Checked := False;
    ac2.Checked := False;

  if ck1.Checked then
  begin
    ac1.GroupIndex := 1;
    ac2.GroupIndex := 2;
  end
  else begin
    ac1.GroupIndex := 1;
    ac2.GroupIndex := 1;
  end;
end;

end.
