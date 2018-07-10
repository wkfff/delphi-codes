unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls,StdCtrls, NavBar, ComCtrls, ImgList,TypInfo;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    mrNavBar1: TmrNavBar;
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
