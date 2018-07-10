unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TBX, TB2Item, TB2Dock, TB2Toolbar;

type
  TForm1 = class(TForm)
    tbxdck1: TTBXDock;
    tbxtlbr1: TTBXToolbar;
    tbxtm1: TTBXItem;
    tbxtm2: TTBXItem;
    tbsbmntmc: TTBSubmenuItem;
    tbxtm3: TTBXItem;
    tbxsbmntm1: TTBXSubmenuItem;
    tbsbmntm1: TTBSubmenuItem;
    tbsbmntm2: TTBSubmenuItem;
    tbsbmntm3: TTBSubmenuItem;
    tbxtm4: TTBXItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
