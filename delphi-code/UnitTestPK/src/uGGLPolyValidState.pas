unit uGGLPolyValidState;

interface

uses
  TestFramework, Classes, Contnrs, SysUtils, GGLIntersectFunc2d;

type
  TGGLPolyValidStateTest = class(TTestCase)
  private
    FGGLPolygon2dLessPointList: TObjectList;
    FGGLPolygon2dSelfIntList: TObjectList;
    FGGLPolygon2dOverlayList: TObjectList;
    FGGLPolygon2dValidList: TObjectList;
    procedure GenPolydonsLessPoint;
    procedure GenPolydonsSelfInt;
    procedure GenPolydonsOverlay;
    procedure GenPolydonsValid;    
    procedure GenPolydons;
    procedure FreePolydons;
    procedure CheckValidState(const AState: TGGLPolyValidState);
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValid;       // 合法
    procedure TestOverlay;     // 顶点或边重叠
    procedure TestSelfInt;     // 相交
    procedure TestLessPoint;   // 点的个数不够
end;

implementation

uses
  Math, GGLPositionFunc2d, GGLGeo2DTypes;

{ TGGLPolyValidStateTest }

procedure TGGLPolyValidStateTest.FreePolydons;
begin
  FreeAndNil(FGGLPolygon2dLessPointList);
  FreeAndNil(FGGLPolygon2dSelfIntList);
  FreeAndNil(FGGLPolygon2dOverlayList);
  FreeAndNil(FGGLPolygon2dValidList);
end;

procedure TGGLPolyValidStateTest.GenPolydons;
begin
  GenPolydonsLessPoint;
  GenPolydonsSelfInt;
  GenPolydonsOverlay;
  GenPolydonsValid;
end;

procedure TGGLPolyValidStateTest.SetUp;
begin
  GenPolydons;
end;

procedure TGGLPolyValidStateTest.TearDown;
begin
  FreePolydons;
end;

procedure TGGLPolyValidStateTest.TestLessPoint;
begin
  CheckValidState(pvsLessPoint);
end;

procedure TGGLPolyValidStateTest.TestOverlay;
begin
  CheckValidState(pvsOverlay);
end;

procedure TGGLPolyValidStateTest.TestSelfInt;
begin
  CheckValidState(pvsSelfInt);
end;

procedure TGGLPolyValidStateTest.TestValid;
begin
  CheckValidState(pvsValid);
end;

procedure TGGLPolyValidStateTest.CheckValidState(const AState:
    TGGLPolyValidState);
var
  I: Integer;
  oPoly: TGGLPolygon2d;
  sShouldBe, sShouldNotBe: string;
begin
  case AState of
    pvsValid:
      begin
        sShouldBe := 'should be pvsValid: %s, Poly %d';
        sShouldNotBe := 'should not be pvsValid: %s, Poly %d';
      end;
    pvsOverlay:
      begin
        sShouldBe := 'should be pvsOverlay: %s, Poly %d';
        sShouldNotBe := 'should not be pvsOverlay: %s, Poly %d';
      end;
    pvsSelfInt:
      begin
        sShouldBe := 'should be pvsSelfInt: %s, Poly %d';
        sShouldNotBe := 'should not be pvsSelfInt: %s, Poly %d';
      end;
    pvsLessPoint:
      begin
        sShouldBe := 'should be pvsLessPoint: %s, Poly %d';
        sShouldNotBe := 'should not be pvsLessPoint: %s, Poly %d';
      end;
  end;

  for I := 0 to FGGLPolygon2dLessPointList.Count - 1 do
  begin
    oPoly := TGGLPolygon2d(FGGLPolygon2dLessPointList[I]);
    if AState = pvsLessPoint then
      CheckTrue(TGGLIntersectFunc2d.PolyValidState(oPoly) = AState, Format(sShouldBe, ['LessPointList', I]))
    else
      CheckTrue(TGGLIntersectFunc2d.PolyValidState(oPoly) <> AState, Format(sShouldNotBe, ['LessPointList', I]))
  end;

  for I := 0 to FGGLPolygon2dSelfIntList.Count - 1 do
  begin
    oPoly := TGGLPolygon2d(FGGLPolygon2dSelfIntList[I]);
    if AState = pvsSelfInt then
      CheckTrue(TGGLIntersectFunc2d.PolyValidState(oPoly) = AState, Format(sShouldBe, ['SelfIntList', I]))
    else
      CheckTrue(TGGLIntersectFunc2d.PolyValidState(oPoly) <> AState, Format(sShouldNotBe, ['SelfIntList', I]))
  end;

  for I := 0 to FGGLPolygon2dOverlayList.Count - 1 do
  begin
    oPoly := TGGLPolygon2d(FGGLPolygon2dOverlayList[I]);
    if AState = pvsOverlay then
      CheckTrue(TGGLIntersectFunc2d.PolyValidState(oPoly) = AState, Format(sShouldBe, ['OverlayList', I]))
    else
      CheckTrue(TGGLIntersectFunc2d.PolyValidState(oPoly) <> AState, Format(sShouldNotBe, ['OverlayList', I]))
  end;

  for I := 0 to FGGLPolygon2dValidList.Count - 1 do
  begin
    oPoly := TGGLPolygon2d(FGGLPolygon2dValidList[I]);
    if AState = pvsValid then
      CheckTrue(TGGLIntersectFunc2d.PolyValidState(oPoly) = AState, Format(sShouldBe, ['ValidList', I]))
    else
      CheckTrue(TGGLIntersectFunc2d.PolyValidState(oPoly) <> AState, Format(sShouldNotBe, ['ValidList', I]))
  end;
end;

  {  LessPoint  }
procedure TGGLPolyValidStateTest.GenPolydonsLessPoint;
var
  oPoly: TGGLPolygon2d;
begin
  FGGLPolygon2dLessPointList := TObjectList.Create;
  // 0 个点
  oPoly := TGGLPolygon2d.Create;
  FGGLPolygon2dLessPointList.Add(oPoly);
  // 1 个直线段点
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddLinePoint(Point2d(0, 0));
  FGGLPolygon2dLessPointList.Add(oPoly);
  // 1 个弧线段点
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(0, 0), atACS, 100);
  FGGLPolygon2dLessPointList.Add(oPoly);
  // 2 个点
  // 直线段：正常
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddLinePoint(Point2d(0, 0));
  oPoly.Vertexes.AddLinePoint(Point2d(100, 100));
  FGGLPolygon2dLessPointList.Add(oPoly);
  // 直线段：端点重合
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddLinePoint(Point2d(0, 0));
  oPoly.Vertexes.AddLinePoint(Point2d(0, 0));
  FGGLPolygon2dLessPointList.Add(oPoly);
  // 弧线段
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(0, 0), atACL, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(0, 0), atACL, 200);
  FGGLPolygon2dLessPointList.Add(oPoly);
end;
procedure TGGLPolyValidStateTest.GenPolydonsOverlay;
var
  oPoly: TGGLPolygon2d;
begin
  // Overlay
  FGGLPolygon2dOverlayList := TObjectList.Create;

  // 直线
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddLinePoint(Point2d(0,0));
  oPoly.Vertexes.AddLinePoint(Point2d(100,100));
  oPoly.Vertexes.AddLinePoint(Point2d(200,0));
  oPoly.Vertexes.AddLinePoint(Point2d(150,50));
  FGGLPolygon2dOverlayList.Add(oPoly);
  // 弧线
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(0,100), atCS, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(0,-100), atCS, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(100,0), atACS, 100);
  FGGLPolygon2dOverlayList.Add(oPoly);

  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(0,0), atCL, 200);
  oPoly.Vertexes.AddLinePoint(Point2d(100,-100));
  oPoly.Vertexes.AddArcPoint(Point2d(100,100), atCS, 200);
  oPoly.Vertexes.AddLinePoint(Point2d(200,0));
  FGGLPolygon2dOverlayList.Add(oPoly);
  // 弧线、直线
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(0,0), atCS, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(100,0), atCS, 100);
  oPoly.Vertexes.AddLinePoint(Point2d(100,-100));
  oPoly.Vertexes.AddLinePoint(Point2d(0,-100));  
  oPoly.Vertexes.AddLinePoint(Point2d(50,-100));  
  FGGLPolygon2dOverlayList.Add(oPoly);
end;

procedure TGGLPolyValidStateTest.GenPolydonsSelfInt;
var
  oPoly: TGGLPolygon2d;
begin
  // SelfInt
  FGGLPolygon2dSelfIntList := TObjectList.Create;
  
 // 直线
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddLinePoint(Point2d(0,0));
  oPoly.Vertexes.AddLinePoint(Point2d(100,100));
  oPoly.Vertexes.AddLinePoint(Point2d(200,0));
  oPoly.Vertexes.AddLinePoint(Point2d(0,50));
  FGGLPolygon2dSelfIntList.Add(oPoly);
  // 顺时针
  // 弧线
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(-100,0), atCL, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(0,-100), atCS, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(200,-100), atCS, 100);
  FGGLPolygon2dSelfIntList.Add(oPoly);

  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(0,100), atCS, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(0,-100), atCS, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(200,-100), atCS, 100);
  FGGLPolygon2dSelfIntList.Add(oPoly);
  // 弧线、直线
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(0,0), atCS, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(100,0), atCS, 100);
  oPoly.Vertexes.AddLinePoint(Point2d(100,-100));
  oPoly.Vertexes.AddLinePoint(Point2d(0,-100));  
  oPoly.Vertexes.AddLinePoint(Point2d(100,0));  
  FGGLPolygon2dSelfIntList.Add(oPoly);

  // 逆时针
  // 弧线
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(0,100), atACS, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(0,-100), atACS, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(-200,-100), atACS, 100);
  FGGLPolygon2dSelfIntList.Add(oPoly);
  // 弧线、直线
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(0,0), atACS, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(-100,0), atACS, 100);
  oPoly.Vertexes.AddLinePoint(Point2d(-100,-100));
  oPoly.Vertexes.AddLinePoint(Point2d(0,-100));
  oPoly.Vertexes.AddLinePoint(Point2d(-100,0));  
  FGGLPolygon2dSelfIntList.Add(oPoly);
end;

procedure TGGLPolyValidStateTest.GenPolydonsValid;
var
  oPoly: TGGLPolygon2d;
begin
  //Valid
  FGGLPolygon2dValidList := TObjectList.Create;
  // 直线
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddLinePoint(Point2d(0,0));
  oPoly.Vertexes.AddLinePoint(Point2d(100,100));
  oPoly.Vertexes.AddLinePoint(Point2d(200,0));
  FGGLPolygon2dValidList.Add(oPoly);
  // 弧线
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(0,0), atCS, 100);
  oPoly.Vertexes.AddArcPoint(Point2d(100,0), atCS, 100);
  FGGLPolygon2dValidList.Add(oPoly);
  // 弧线、直线
  oPoly := TGGLPolygon2d.Create;
  oPoly.Vertexes.AddArcPoint(Point2d(0,0), atCS, 100);
  oPoly.Vertexes.AddLinePoint(Point2d(100,0));
  oPoly.Vertexes.AddArcPoint(Point2d(100,-100), atCS, 100);
  oPoly.Vertexes.AddLinePoint(Point2d(-100,-100));
  FGGLPolygon2dValidList.Add(oPoly);
end;

initialization
  RegisterTest(TGGLPolyValidStateTest.Suite);
end.
