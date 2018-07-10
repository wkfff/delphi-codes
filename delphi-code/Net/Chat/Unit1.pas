unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdTCPServer;

type
  TForm1 = class(TForm)
    idtcpsrvr1: TIdTCPServer;
    mmo1: TMemo;
    lst1: TListBox;
    lbl1: TLabel;
    cbb1: TComboBox;
    lbl2: TLabel;
    mmo2: TMemo;
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
