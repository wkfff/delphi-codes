unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  Inf = interface
    function GetMsg: string;
    procedure SetMsg(AMsg: string);
    property Msg: string read GetMsg write SetMsg;
  end;


  Inf1 = interface(Inf)
//    function GetMsg: string;
//    procedure SetMsg(AMsg: string);
//    property Msg: string read GetMsg write SetMsg;
  end;
  Inf2 = interface(Inf)
//    function GetMsg: string;
//    procedure SetMsg(AMsg: string);
//    property Msg: string read GetMsg write SetMsg;
  end;
  TInf1 = class(TInterfacedObject, Inf1)
    FMsg :string;
  public
    function GetMsg: string;
    procedure SetMsg(AMsg: string);
  end;
  TInf2 = class(TInterfacedObject, Inf2)
    FMsg :string;
  public
    function GetMsg: string;
    procedure SetMsg(AMsg: string);
  end;


  TTest = class

  public
    class procedure Show(AMsg: Inf1); overload;
    class procedure Show(AMsg: Inf2); overload;
  end;



  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
var
  o: Inf1;
  o2: Inf2;
begin
  o := TInf1.Create;
  o.Msg := '1';
  TTest.Show(o);
  o2 := TInf2.Create;
  o2.Msg := '2';
  TTest.Show(o2);

end;

{ TTest }

class procedure TTest.Show(AMsg: Inf1);
begin
  ShowMessage(AMsg.Msg);
end;

class procedure TTest.Show(AMsg: Inf2);
begin
  ShowMessage(AMsg.Msg);
end;

{ TInf1 }

function TInf1.GetMsg: string;
begin
  Result := FMsg;
end;

procedure TInf1.SetMsg(AMsg: string);
begin
  FMsg := AMsg;
end;

{ TInf2 }

function TInf2.GetMsg: string;
begin
  Result := FMsg;
end;

procedure TInf2.SetMsg(AMsg: string);
begin
  FMsg := AMsg;
end;

end.
