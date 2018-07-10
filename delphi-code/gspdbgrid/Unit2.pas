unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GSPDB, GrandGrid, GrandViewGrid, GrandFilterGrid, GSPDBGrid,
  GSPEngineUtils, GSPInterface, OpenGL, StdCtrls;

type
  TGCLAutoGenLintelInfo = record
    OpenningWidthGT: Integer;
    OpenningWidthLQT: Integer;
    LintelHeight: Integer;
    LintelWidth: string;
  end;

  PGCLAutoGenLintelInfo = ^TGCLAutoGenLintelInfo;

  TGCLAutoGenLintelInfos = class
  private
    FInfos: array of TGCLAutoGenLintelInfo;
    function GetOption(Index: Integer): TGCLAutoGenLintelInfo;
    function GetCount: Integer;
    procedure SetOption(Index: Integer; Value: TGCLAutoGenLintelInfo);
  public
    constructor Create;
    destructor Destroy; override;
    property Items[Index: Integer]: TGCLAutoGenLintelInfo read GetOption write SetOption;
    property Count: Integer read GetCount;
  end;



  TForm2 = class(TForm)
    gdb1: TGSPDBGrid;
    gspvwprxy1: TGSPViewProxy;
    gdb2: TGSPDBDataSource;
    gspvwprvdrtm1: TGSPViewProviderItem;
    grndvwgrd1: TGrandViewGrid;
    btn1: TButton;
    btnNew: TButton;
    btnDel: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gdb1QueryCellValue(Sender: TObject; ACol, ARow: Integer; const
        AField: IGSPField; const ARecord: IGSPRecord; var AValue: string; var
        AHandled: Boolean);
    procedure gdb1QueryEditStyle(Sender: TObject; ACol, ARow: Integer; const
        AField: IGSPField; const ARecord: IGSPRecord; var AEditStyle: TEditStyle;
        var AHandled: Boolean);
    procedure grndvwgrd1DropDownListSelected(Sender: TObject; ACol, ARow: Integer;
        ASelItem: string);
    procedure grndvwgrd1GetDropDownList(Sender: TObject; ACol, ARow: Integer;
        AItems: TStrings; var ADropDownRows: Cardinal);
    procedure grndvwgrd1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grndvwgrd1KeyPress(Sender: TObject; var Key: Char);
    procedure grndvwgrd1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grndvwgrd1QueryCellAttribute(Sender: TObject; ACol, ARow: Integer;
        ACellAttrs: TCellAttributes; var ACellAttrInfo: TCellAttrInfo);
    procedure grndvwgrd1QueryCellValue(Sender: TObject; ACol, ARow: Integer; var
        AValue: string);
    procedure grndvwgrd1QueryEditHide(Sender: TObject; ACol, ARow: Integer;
        AEditText: string; var ACanHide: Boolean);
    procedure grndvwgrd1QueryEditStyle(Sender: TObject; ACol, ARow: Integer; var
        AEditStyle: TEditStyle);
    procedure grndvwgrd1QueryReadOnly(Sender: TObject; ACol, ARow: Integer; var
        AReadOnly: Boolean);
  private
    FModel: IGSPModel;
    FInfos: TGCLAutoGenLintelInfos;
    FMsg: string;
    { Private declarations }
    procedure BindGrid;
    function CheckInputData(const AText: string): Boolean;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

resourcestring
  SNO = '±àºÅ';
  SOpenningWidthGT = '¶´¿í©ƒ';
  SOpenningWidthLET = '¶´¿í¡Ü';
  SLintelHeight = '¹ýÁº¸ß';
  SLintelWidth = '¹ýÁº¿í';
  SFetchWallThickness = 'È¡Ç½ºñ';

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FInfos.Free;
end;

procedure TForm2.BindGrid;
begin
//  gluOrtho2D();
//
//  gspvwprxy1.ViewIntf := '';
//  gdb1.Active;
end;

procedure TForm2.btn1Click(Sender: TObject);
begin
  ShowMessage(FMsg);
  FMsg := '';
end;

procedure TForm2.btnNewClick(Sender: TObject);
begin
  grndvwgrd1.RowCount := grndvwgrd1.RowCount + 1;
end;

function TForm2.CheckInputData(const AText: string): Boolean;
var
  nValue: Integer;
begin
  Result := SameText(AText, SFetchWallThickness) or
    (TryStrToInt(AText, nValue) and (nValue >= 0) and (nValue <= 30000));
end;

procedure TForm2.FormCreate(Sender: TObject);
//var
//  p: PGCLAutoGenLintelInfo;
begin
  gdb1.ColCount:= 5;
  grndvwgrd1.ColCount:= 5;
//  gdb1.Active := True;
//  gdb1.PersistentValue := '';
//  BindGrid;
  FInfos := TGCLAutoGenLintelInfos.Create;
//  SetLength(FInfos, 2);
//  FInfos[0].LintelWidth := SFetchWallThickness;
//  FInfos[1].LintelWidth := SFetchWallThickness;
end;

procedure TForm2.gdb1QueryCellValue(Sender: TObject; ACol, ARow: Integer; const
    AField: IGSPField; const ARecord: IGSPRecord; var AValue: string; var
    AHandled: Boolean);
begin
  if ARow = 1 then
  begin
    case ACol of
      1:  AValue := 'a';
      2:  AValue := 'b';
      3:  AValue := 'c';
    end;
  end;
end;

procedure TForm2.gdb1QueryEditStyle(Sender: TObject; ACol, ARow: Integer; const
    AField: IGSPField; const ARecord: IGSPRecord; var AEditStyle: TEditStyle;
    var AHandled: Boolean);
begin
if ACol = 4 then
  begin
    AEditStyle := esDropDownList;
  end;
end;

procedure TForm2.grndvwgrd1DropDownListSelected(Sender: TObject; ACol, ARow:
    Integer; ASelItem: string);
begin
//  ASelItem
end;

procedure TForm2.grndvwgrd1GetDropDownList(Sender: TObject; ACol, ARow:
    Integer; AItems: TStrings; var ADropDownRows: Cardinal);
begin
  AItems.Clear;
  if ACol = 4 then
  begin
    AItems.Add(SFetchWallThickness);
  end;
end;

procedure TForm2.grndvwgrd1KeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  FMsg := FMsg + 'down';

end;

procedure TForm2.grndvwgrd1KeyPress(Sender: TObject; var Key: Char);
begin
  FMsg := FMsg + 'press';
  if Key = 'a' then Key := #0;

end;

procedure TForm2.grndvwgrd1KeyUp(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  FMsg := FMsg + 'up';
end;

procedure TForm2.grndvwgrd1QueryCellAttribute(Sender: TObject; ACol, ARow:
    Integer; ACellAttrs: TCellAttributes; var ACellAttrInfo: TCellAttrInfo);
begin
//  if ACol = 5 then
//    ACellAttrInfo.ImageLayout.Style

end;

procedure TForm2.grndvwgrd1QueryCellValue(Sender: TObject; ACol, ARow: Integer;
    var AValue: string);
begin
  if ARow = 0 then
  begin
    case ACol of
      0: AValue :=  SNO;
      1:  AValue := SOpenningWidthGT;
      2:  AValue := SOpenningWidthLET;
      3:  AValue := SLintelHeight;
      4:  Avalue := SLintelWidth;
    end;
  end
  else begin
    if (ACol = 0) then
      AValue := IntToStr(ARow)
    else if (ACol = 4) then
    begin
      if ARow <= FInfos.Count then
         AValue := FInfos.Items[ARow - 1].LintelWidth;
    end;
  end;
end;

procedure TForm2.grndvwgrd1QueryEditHide(Sender: TObject; ACol, ARow: Integer;
    AEditText: string; var ACanHide: Boolean);
var
  r: TGCLAutoGenLintelInfo;
  P: PGCLAutoGenLintelInfo;
begin
  if (ARow > 0) and (ACol = 4) then
  begin
    if ARow <= FInfos.Count then
    begin
      r := FInfos.Items[ARow - 1];
      P := @r;//(FInfos.Items[ARow - 1]);
      ACanHide := CheckInputData(AEditText);
      if ACanHide then
        P^.LintelWidth := AEditText;
//      FInfos.Items[ARow - 1] := r;
      FInfos.FInfos[ARow - 1] := r;
    end;
  end;
end;

procedure TForm2.grndvwgrd1QueryEditStyle(Sender: TObject; ACol, ARow: Integer;
    var AEditStyle: TEditStyle);
begin
  if ACol = 4 then
  begin
    AEditStyle := esDropDown;//List;
  end;
end;

procedure TForm2.grndvwgrd1QueryReadOnly(Sender: TObject; ACol, ARow: Integer;
    var AReadOnly: Boolean);
begin
    AReadOnly := ACol = 0;
end;

{ TGCLAutoGenLintelInfos }

constructor TGCLAutoGenLintelInfos.Create;
begin
  SetLength(FInfos, 2);
  FInfos[0].LintelWidth := SFetchWallThickness;
  FInfos[1].LintelWidth := SFetchWallThickness;
end;

destructor TGCLAutoGenLintelInfos.Destroy;
begin
//  SetLength(FInfos, 0);
  inherited;
end;

function TGCLAutoGenLintelInfos.GetCount: Integer;
begin
  Result := Length(FInfos);
end;

function TGCLAutoGenLintelInfos.GetOption(Index: Integer):
    TGCLAutoGenLintelInfo;
begin
  Result := FInfos[index];
end;

procedure TGCLAutoGenLintelInfos.SetOption(Index: Integer;
  Value: TGCLAutoGenLintelInfo);
begin
  FInfos[Index] := Value;
end;

end.
