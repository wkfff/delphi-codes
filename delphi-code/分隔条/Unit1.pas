unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids;

type
  TForm1 = class(TForm)
    pnl1: TPanel;
    spl1: TSplitter;
    edt1: TEdit;
    drwgrd1: TDrawGrid;
    spl2: TSplitter;
    pnl2: TPanel;
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
