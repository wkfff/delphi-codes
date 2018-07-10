unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, ComCtrls, ToolWin, ExtDlgs, Buttons;

type

  TArrayList = array of array of Byte;

  TFrmMain = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    CoolBar2: TCoolBar;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    OpenPictureDialog1: TOpenPictureDialog;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    FMemoryStream:TMemoryStream;
  
    procedure WriteRGBArray(R,G,B:TArrayList;Stream:TStream);
    procedure ReadRGBArray(out R, G, B:TArrayList;Stream:TStream);

    procedure OutArray(ArrayName:string;ArrayList:TArrayList);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation


 

{$R *.dfm}

procedure TFrmMain.ToolButton2Click(Sender: TObject);
begin
  Image1.Picture.Bitmap := nil;
end;

procedure TFrmMain.ToolButton1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

procedure TFrmMain.ToolButton5Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure OutBitmapArray(Bmp:TBitmap;ArrayName:string;Memo:TMemo;ArrayList:TArrayList);
var

  i,j:Integer;
  Str:string;
begin
  Memo.Lines.Add(ArrayName + ' : ' + 'Array [0..'+ IntToStr(bmp.Height - 1)
            +'] of Array [0..'+ IntToStr(bmp.Width - 1) +'] of byte = (');
  for i:= 0 to High(ArrayList) do
  begin
    Str := '(';
    for j := 0 to High(ArrayList[0]) do
    begin
      Str := Str + IntToStr(ArrayList[i,j]);
      if j < High(ArrayList[0]) then
        Str := Str + ',';
    end;
    if i < High(ArrayList) then
      Str := Str + '),'
    else
      Str := Str + ')';
    Memo.Lines.Add(Str);
  end;
  Memo.Lines.Add(');');
  Memo.Lines.Add('');
  Memo.Lines.Add('');
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
var
  ab, ag, ar: TArrayList;
  bmp: TBitmap;
  i, j: integer;
  p: PByteArray;
begin
  bmp := Image1.Picture.Bitmap;
  setLength(ab, bmp.Height, bmp.Width);
  setLength(ag, bmp.Height, bmp.Width);
  setLength(ar, bmp.Height, bmp.Width);

  for i := 0 to bmp.Height - 1 do
  begin
    p := bmp.ScanLine[i];
    for j := 0 to bmp.Width - 1 do  
    begin
      ab[i, j] := (p[j]);
      ag[i, j] := (p[j + 1]);
      ar[i, j] := (p[j + 2]);
    end;
  end;

  Memo1.Lines.BeginUpdate;
  OutBitmapArray(bmp,'BmpRArray',Memo1,ar);
  OutBitmapArray(bmp,'BmpGArray',Memo1,ag);
  OutBitmapArray(bmp,'BmpBArray',Memo1,ab);
  Memo1.Lines.EndUpdate;
  WriteRGBArray(ar,ag,ab,FMemoryStream);
end;

procedure TFrmMain.WriteRGBArray(R, G, B: TArrayList; Stream: TStream);
var
  H,W:Integer;
begin
  Stream.Size := 0;
  H := High(R);
  W := High(R[0]);
  Stream.Write(H,SizeOf(Integer));
  Stream.Write(W,SizeOf(Integer));
  Stream.Write(R,H * W);
  Stream.Write(G,H * W);
  Stream.Write(B,H * W);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FMemoryStream := TMemoryStream.Create;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FMemoryStream.Free;
end;

procedure TFrmMain.ToolButton4Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    FMemoryStream.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TFrmMain.ReadRGBArray(out R, G, B: TArrayList; Stream: TStream);
var
  H,W:Integer;
  mR,mG,mB:TArrayList;
begin
  Stream.Position := 0;
  Stream.Read(H,SizeOf(Integer));
  Stream.Read(W,SizeOf(Integer));
  SetLength(mR,H,W);
  SetLength(mG,H,W);
  SetLength(mB,H,W);

  Stream.Read(mR,H * W);
  Stream.Read(mG,H * W);
  Stream.Read(mB,H * W);

  OutArray('RArray',mR);
end;

procedure TFrmMain.ToolButton3Click(Sender: TObject);
var
  R,G,B:TArrayList;
begin
  if OpenDialog1.Execute then
  begin
    FMemoryStream.LoadFromFile(OpenDialog1.FileName);
    ReadRGBArray(R,G,B,FMemoryStream);
    ShowMessage('');
//    Memo1.Clear;
//    Memo1.Lines.BeginUpdate;
//    OutArray('RArray',R);
//    OutArray('GArray',G);
//    OutArray('BArray',B);
//    Memo1.Lines.EndUpdate;
  end;
end;

procedure TFrmMain.OutArray(ArrayName: string;
  ArrayList: TArrayList);
var
  i,j:Integer;
  Str:string;
begin
  Memo1.Lines.Add(ArrayName + ' : ' + 'Array [0..'+ IntToStr(High(ArrayList))
            +'] of Array [0..'+ IntToStr(High(ArrayList[0])) +'] of byte = (');
  for i:= 0 to High(ArrayList) do
  begin
    Str := '(';
    for j := 0 to High(ArrayList[0]) do
    begin
      Str := Str + IntToStr(ArrayList[i,j]);
      if j < High(ArrayList[0]) then
        Str := Str + ',';
    end;
    if i < High(ArrayList) then
      Str := Str + '),'
    else
      Str := Str + ')';
    Memo1.Lines.Add(Str);
  end;
  Memo1.Lines.Add(');');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('');
end;

procedure TFrmMain.SpeedButton2Click(Sender: TObject);
var
  mm:array [0..144] of array [0..200] of Byte;
  Memory:TMemoryStream;
  i,j:Integer;
begin
  for i:=0 to High(MM) do
  begin
    for j:=0 to High(MM[0]) do
    begin
      mm[i,j] := i + j;
    end;
  end;
  Memory := TMemoryStream.Create;
  Memory.Write(mm,High(MM) * High(MM[0]));
  Memory.SaveToFile('c:\array.txt');
  Memory.Free;
end;

end.
