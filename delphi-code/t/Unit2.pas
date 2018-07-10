unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    mmo1: TMemo;
    btn1: TButton;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  GSPInterface, GSPEngineUtils;

{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
var
  bHas: Boolean;
  oModel1: IGSPModel;
  oDb: IGSPDatabase;
  oEntTbl, oEdoTbl, oWallFaceTbl, oFinishTbl, oAttachTbl, oWallFaceGCL, oFloor: IGSPTable;
  oRe, oFinishView: IGSPView;
  oInnerWallFace, oTemp, ot2: IGSPRecordList;
  I: Integer;
  J: Integer;
  nEntID: Integer;
begin
  oModel1 := GSPEngine.CreateModel;
  GSPEngine.CreateModelXMLReader.Read('E:\GAEA\trunk\GCL\Release\Bin\sysinfo.gsp', oModel1);
  oDb := oModel1.Find('Business');

  oEntTbl := oDb.FindTable('Element');
  oEdoTbl := oDb.FindTable('ElementDrawObj');
  oWallFaceTbl := oDb.FindTable('ElementDrawObj');
  oFinishTbl := oDb.FindTable('Room_GCL');
  oAttachTbl := oDb.FindTable('WallFaceFinish_Attached');
  oWallFaceGCL := oDb.FindTable('WallFaceFinish_GCL');
  oFloor := oDb.FindTable('Floor');

  oInnerWallFace := oEdoTbl.CreateRecordList('EDOID=-1');
  ot2 := oEdoTbl.CreateRecordList('EDOID=-1');
  // 内墙面
  oRe := oEdoTbl.CreateStaticView('~ElementID.ElementTypeID=36');
  oTemp := oWallFaceGCL.CreateRecordList('InnerOuterFlag=0');
  for I := 0 to oRe.RecordCount - 1 do
  begin
    nEntID := oRe.Records[I].AsInteger['ElementID'];
    for J := 0 to oTemp.Count - 1 do
    begin
      if oTemp.Records[J].AsInteger['ElementID'] = nEntID then
        oInnerWallFace.Add(oRe.Records[I]);
    end;
  end;


  //
  for I := 0 to oInnerWallFace.Count - 1 do
  begin
    nEntID := oInnerWallFace.Records[I].AsInteger['ElementID'];
    bHas := False;
    for J := 0 to oAttachTbl.RecordCount - 1 do
    begin
      if oAttachTbl.Records[J].AsInteger['WallFaceFinishID'] = nEntID then
      begin
        bHas := True;
        Break;
      end;
    end;
    if not bHas then
      ot2.Add(oInnerWallFace.Records[I]);
  end;


  mmo1.Clear;
  mmo1.Lines.Add('图元id     构件id     楼层');

  for I := 0 to ot2.Count - 1 do
    mmo1.Lines.Add(ot2.Records[I].Asstring['EDOID']+
      '     '+ot2.Records[I].Asstring['ElementID']+
      '     '+ oFloor.FindByID(oEntTbl.FindByID(ot2.Records[I].AsInteger['ElementID']).AsInteger['FloorID']).AsString['Description']);

  mmo1.Lines.Add('');











end;

procedure TForm2.btn2Click(Sender: TObject);
var
  oModel1, oModel2: IGSPModel;
  oDb1, oDb2: IGSPDatabase;
  otbl1, otbl2: IGSPTable;
  I: Integer;
  oRecord: IGSPRecord;                                                       
  oRecord2: IGSPRecord;
begin
  oModel1 := GSPEngine.CreateModel;
  GSPEngine.CreateModelXMLReader.Read('E:\GAEA\trunk\GCL\Release\Bin\sysinfo.gsp', oModel1);
  oDb1 := oModel1.Find('DB');
  otbl1 := oDb1.FindTable('DisplayStyle');

  oModel2 := GSPEngine.CreateModel;
  GSPEngine.CreateModelXMLReader.Read('E:\GAEA\G5D\Trunk\G5D2\GCL5D\Release\Bin\sysinfo.gsp', oModel2);
  oDb2 := oModel2.Find('DB');
  otbl2 := oDb2.FindTable('DisplayStyle');

  if otbl1.RecordCount >= otbl2.RecordCount then
  begin
    for I := 0 to otbl1.RecordCount - 1 do
    begin
      oRecord := otbl1.Records[I];
      oRecord2 := otbl2.Locate('DisplayStyleID', oRecord.AsInteger['DisplayStyleID']);
      if (oRecord2 <> nil) then
      begin
        if oRecord.AsInteger['BorderColor'] <> oRecord2.AsInteger['BorderColor'] then
          mmo1.Lines.Add(IntToStr(oRecord.AsInteger['DisplayStyleID'])+'  BorderColor')
        else if oRecord.AsInteger['FillColor'] <> oRecord2.AsInteger['FillColor'] then
          mmo1.Lines.Add(IntToStr(oRecord.AsInteger['DisplayStyleID'])+'  FillColor')
        else if oRecord.AsInteger['SolidColor'] <> oRecord2.AsInteger['SolidColor'] then
          mmo1.Lines.Add(IntToStr(oRecord.AsInteger['DisplayStyleID'])+'  SolidColor')
        else if oRecord.AsInteger['Transparent'] <> oRecord2.AsInteger['Transparent'] then
          mmo1.Lines.Add(IntToStr(oRecord.AsInteger['DisplayStyleID'])+'  Transparent');



      end;
    end;
  end
  else begin
    for I := 0 to otbl2.RecordCount - 1 do
    begin
      oRecord := otbl2.Records[I];
      oRecord2 := otbl1.Locate('DefDisplayStyleID', oRecord.AsInteger['DefDisplayStyleID']);
      if (oRecord2 <> nil) then
      begin
        if oRecord.AsInteger['BorderColor'] <> oRecord2.AsInteger['BorderColor'] then
          mmo1.Lines.Add(IntToStr(oRecord.AsInteger['DefDisplayStyleID'])+'  BorderColor')
        else if oRecord.AsInteger['FillColor'] <> oRecord2.AsInteger['FillColor'] then
          mmo1.Lines.Add(IntToStr(oRecord.AsInteger['DefDisplayStyleID'])+'  FillColor')
        else if oRecord.AsInteger['SolidColor'] <> oRecord2.AsInteger['SolidColor'] then
          mmo1.Lines.Add(IntToStr(oRecord.AsInteger['DefDisplayStyleID'])+'  SolidColor')
        else if oRecord.AsInteger['Transparent'] <> oRecord2.AsInteger['Transparent'] then
          mmo1.Lines.Add(IntToStr(oRecord.AsInteger['DefDisplayStyleID'])+'  Transparent');
      end;
    end;


  end;

end;

end.
