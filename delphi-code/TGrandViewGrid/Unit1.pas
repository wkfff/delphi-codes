unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GrandViewGrid, GrandGrid;

type
  TForm1 = class(TForm)
    vg1: TGrandViewGrid;
    procedure FormCreate(Sender: TObject);
    procedure vg1EditButtonClick(Sender: TObject; ACol, ARow: Integer);
    procedure vg1QueryCellAttribute(Sender: TObject; ACol, ARow: Integer;
        ACellAttrs: TCellAttributes; var ACellAttrInfo: TCellAttrInfo);
    procedure vg1QueryCellValue(Sender: TObject; ACol, ARow: Integer; var AValue:
        string);
    procedure vg1QueryEditorMode(Sender: TObject; ACol, ARow: Integer; var
        ACanShow: Boolean; AChar: Word);
    procedure vg1QueryEditProperty(Sender: TObject; ACol, ARow: Integer; var
        AEditProperty: TEditProperty);
    procedure vg1QueryEditStyle(Sender: TObject; ACol, ARow: Integer; var
        AEditStyle: TEditStyle);
    procedure vg1QueryReadOnly(Sender: TObject; ACol, ARow: Integer; var AReadOnly:
        Boolean);
    procedure vg1UpdateCellValue(Sender: TObject; ACol, ARow: Integer; const
        AValue: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  vg1.Canvas.TextRect(vg1.CellRect(0,0), 0, 0,'a');//.CellRect(0,0)
end;

procedure TForm1.vg1EditButtonClick(Sender: TObject; ACol, ARow: Integer);
begin
  ShowMessage('button');
end;

procedure TForm1.vg1QueryCellAttribute(Sender: TObject; ACol, ARow: Integer;
    ACellAttrs: TCellAttributes; var ACellAttrInfo: TCellAttrInfo);
begin
  ACellAttrInfo.DataType := cdtString;

end;

procedure TForm1.vg1QueryCellValue(Sender: TObject; ACol, ARow: Integer; var
    AValue: string);
begin
  if (ARow = 0) and  (ACol = 0) then
  AValue := 'a'

end;

procedure TForm1.vg1QueryEditorMode(Sender: TObject; ACol, ARow: Integer; var
    ACanShow: Boolean; AChar: Word);
begin
//
end;

procedure TForm1.vg1QueryEditProperty(Sender: TObject; ACol, ARow: Integer; var
    AEditProperty: TEditProperty);
begin
if (ARow = 0) and  (ACol = 0) then AEditProperty.Name := 'a'
end;

procedure TForm1.vg1QueryEditStyle(Sender: TObject; ACol, ARow: Integer; var
    AEditStyle: TEditStyle);
begin
   AEditStyle := esEllipsis
end;

procedure TForm1.vg1QueryReadOnly(Sender: TObject; ACol, ARow: Integer; var
    AReadOnly: Boolean);
begin
//  if ACol = 0 then AReadOnly := True;

end;

procedure TForm1.vg1UpdateCellValue(Sender: TObject; ACol, ARow: Integer; const
    AValue: string);
begin
  //if (ARow = 0) and  (ACol = 0) then AValue := 'a'

end;

end.
