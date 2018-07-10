unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GSPInterface, GSPEngineUtils;

type

  IMyInterface = interface
    procedure Show;
  end;

  TMyClassa = class(TInterfacedObject, IMyInterface)
  public
    procedure Show;
  end;


  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TMyClassa }

procedure TMyClassa.Show;
var
  im: IGSPModel;
begin
  im := GSPEngine().CreateModel();
  GSPEngine.CreateModelXMLReader.Read();

end;

end.
