unit NavBar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,CommCtrl,TypInfo;

type
  TmrNavBar = class;
  TScrollBarKind = (sbHorizontal, sbVertical);
  TScrollBarInc = 1..32767;
  //滚动条
  TmrScrollBar = class
  private
    FOwner:TmrNavBar;
    FBoundRect:TRect;//滚动条区域
    FUpButtonRect:TRect;//向上按钮区域
    FDownButtonRect:TRect;//向下按钮区域
    FSlideRect:TRect;//滑块区域
    FSlideHeight:Integer; //滑块高度
    FPosition: Integer; //当前位置
    FMin: Integer;  //最小
    FMax: Integer;  //最大
    FStep:Integer;  //按钮调整大小
    FDown:Boolean;  //鼠标按下
    FOldY:Integer;

    procedure SetBoundRect(value:TRect);
    procedure SlideMove(APoint:TPoint);
  public
    constructor Create(AOwner: TmrNavBar);
    destructor Destroy; override;
    procedure CalcRect;
    procedure DrawScoll;
    procedure GetArea(APoint:TPoint;Mess:Integer);
    property BoundRect:TRect read FBoundRect write SetBoundRect;
    property Position:Integer read FPosition write FPosition;
    property Min:Integer read FMin write FMin;
    property Max:Integer read FMax write FMax;
    property Step:Integer read FStep write FStep;
  end;

  TNavItem = class(TComponent)
  private
    FText:string;
    FHint:string;
    FImageIndex:Integer;
  published
    property Text:String read FText write FText;
    property Hint:string read FHint write FHint;
    property ImageIndex:Integer read FImageIndex write FImageIndex;
  end;

  TNavGroup = class(TComponent)
  private
    FText:string;
    FList:TList;
    FOwner:TmrNavBar;
    FExpandable:Boolean;
    FExpanded:Boolean;
    FHint:string;
    FImageIndex:Integer;
    
    procedure SetNavItem(index:Integer;value:TNavItem);
    function GetNavItem(index:Integer):TNavItem;
    function GetCount:Integer;
    procedure SetExpandable(value:Boolean);
    procedure SetExpanded(value:Boolean);
  public
    constructor Create(AOwner: TmrNavBar);
    destructor Destroy; override;
    function Add:TNavItem;  //添加项
    procedure Delete(index:Integer);overload;  //删除项
    procedure Delete(NavItem:TNavItem);overload; //
    procedure Clear; //清空
    property NavItems[index:Integer]:TNavItem read GetNavItem write SetNavItem;
    property Count:Integer read GetCount;
  published
    property Text:String read FText write FText;
    property Expandable:Boolean read FExpandable write SetExpandable;
    property Expanded:Boolean read FExpanded write SetExpanded;
    property Hint:string read FHint write FHint;
    property ImageIndex:Integer read FImageIndex write FImageIndex;
  end;

  TNavGroups = class(TPersistent)
  private
    FList:TList;
    FOwner:TmrNavBar;
    
    function GetNavGroups(index:Integer):TNavGroup;
    procedure SetNavGroups(index:Integer;value:TNavGroup);
    function GetCount:Integer;
  public
    constructor Create(AOwner: TmrNavBar);
    destructor Destroy; override;
    function Add:TNavGroup;  //添加组
    procedure Delete(index:Integer);overload;  //删除组
    procedure Delete(NavGroup:TNavGroup);overload;
    procedure Clear; //清空组
    property NavGroups[index:Integer]:TNavGroup read GetNavGroups write SetNavGroups;
    property Count:Integer read GetCount;
  end;
  
  //显示样式类
  TBaseViewStyle = class(TPersistent)
  private
    FOwner:TmrNavBar;
    FOwnerWindowPro:TWndMethod;
    FScrollBar:TmrScrollBar;
    FClecked:Boolean;
    FItemHeight:Integer;  //列表高度
    
  protected
    TopLeft:TPoint;
    procedure WindowPro(var Message: TMessage);virtual;
    property Owner:TmrNavBar read FOwner;
    procedure InitPosition;
  public
    constructor Create(AOwner: TmrNavBar); virtual;
    destructor Destroy; override;
    procedure CalcRect;virtual;
    procedure DrawItem;virtual;
    procedure DrawGroup;virtual;
    procedure DrawStyle;virtual;
    procedure UpDateGroup;virtual;
    property ScrollBar:TmrScrollBar read FScrollBar;
    property ItemHeight:Integer read FItemHeight;
  end;

  //默认样式类型
  TDefaultViewStyle = class(TBaseViewStyle)
  private
    FClRect:TRect;//客户区
    FTitleRect:TRect;//标头区
    FAfterBodyRect:TRect;//尾部
    FSplitterRect:TRect;//分割条
    FListRect:TRect;//列表显示区
    FGroupRect:TRect; //组头显示区
    FVScrollRect:TRect;//垂直滚动条区
    FGroupPageIndex:Integer;  //当前分页
    FGroupPageCount:Integer;  //分组总页数
    FGroupPageSize:Integer; //当前页大小
    FGroupUpPageRect:TRect; //组上翻页按钮区域
    FGroupDownPageRect:TRect; //组下翻页按钮区域
    
    procedure SelectItem(X,Y,Mess:Integer);
    procedure SelectGroup(X,Y,Mess:Integer);
    procedure GroupUpBtnClick(X,Y,Mess:Integer);
    procedure GroupDownBtnClick(X,Y,Mess:Integer);
  protected
    procedure WindowPro(var Message: TMessage);override;
    procedure GetArea(X,Y,Mess:Integer);
    procedure ItemClick(X,Y,Index:Integer);
  public
    procedure CalcRect;override;
    procedure DrawGroup;override;
    procedure DrawItem;override;
    procedure DrawStyle;override;
    procedure UpDateGroup;override;
  end;
  

  TGroupItemClickEvent = procedure (Sender:TObject;GroupItem:TNavItem) of object;
  
  TmrNavBar = class(TCustomControl)
  private
    FViewStyle:TBaseViewStyle;
    FNavGroups:TNavGroups;
    FSelectGroup:TNavGroup; //当前选中分组
    FSelectItem:TNavItem; //当前选中项
    FImageList:TImageList;
    FGroupItemClick:TGroupItemClickEvent;

    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
    procedure SetImageList(value:TImageList);
    
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Paint; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SelectGroup:TNavGroup read FSelectGroup write FSelectGroup;
    property SelectItem:TNavItem read FSelectItem write FSelectItem;
    property ViewStyle:TBaseViewStyle read FViewStyle write FViewStyle;
  published
    property NavGroups:TNavGroups read FNavGroups write FNavGroups;
    property ImageList:TImageList read FImageList write SetImageList;
    property OnGroupItemClick:TGroupItemClickEvent read FGroupItemClick write FGroupItemClick;
  end;

implementation

{$R image.res}

procedure GetBmp(BmpName:string;var Bmp:TBitmap ;var MaskDC:HDC);
begin
  Bmp.LoadFromResourceName(HInstance,BmpName);
  MaskDC := CreateCompatibleDC(Bmp.Canvas.Handle);
  SelectObject(MaskDC, Bmp.MaskHandle);
end;

{ TmrNavBar }

constructor TmrNavBar.Create(AOwner: TComponent);
begin
  inherited;
  DoubleBuffered := True;
  Parent := TWinControl(AOwner);
  Width := 100;
  Height := 200;
  FNavGroups := TNavGroups.Create(Self);
  FViewStyle := TDefaultViewStyle.Create(Self);
  FViewStyle.CalcRect;
  if FNavGroups.Count > 0 then
    FSelectGroup := FNavGroups.NavGroups[0]; 
end;

procedure TmrNavBar.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Data', ReadData, WriteData,True);
end;

destructor TmrNavBar.Destroy;
begin
  FViewStyle.Free;
  FNavGroups.Free;
  inherited;
end;

procedure TmrNavBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FImageList then
    begin
      FImageList := nil;
      Invalidate;
    end;
  end;
end;

procedure TmrNavBar.Paint;
begin
  inherited;
  FViewStyle.DrawStyle;
end;

procedure TmrNavBar.ReadData(Reader: TReader);
var
  i,j:Integer;
  Count:Integer;
  SubCount:Integer;
  NavGroup:TNavGroup;
  NavItem:TNavItem;
begin
  FNavGroups.Clear;
  Reader.ReadListBegin;
  Count := Reader.ReadInteger;
  for i := 0 to Count - 1 do
  begin
    NavGroup := FNavGroups.Add;
    SubCount := Reader.ReadInteger;
    NavGroup.Text := Reader.ReadString;
    NavGroup.Expandable := Reader.ReadBoolean;
    NavGroup.Expanded := Reader.ReadBoolean;
    NavGroup.Hint := Reader.ReadString;
    NavGroup.ImageIndex := Reader.ReadInteger;
    NavGroup.Name := Reader.ReadString;
    for j := 0 to SubCount -1 do
    begin
      NavItem := NavGroup.Add;
      NavItem.Text := Reader.ReadString;
      NavItem.Hint := Reader.ReadString;
      NavItem.ImageIndex := Reader.ReadInteger;
      NavItem.Name := Reader.ReadString;
    end;
  end;
  Reader.ReadListEnd;
end;

procedure TmrNavBar.SetImageList(value: TImageList);
begin
  FImageList := value;
  Invalidate;  
end;

procedure TmrNavBar.WriteData(Writer: TWriter);
var
  i,j:Integer;
begin
  Writer.WriteListBegin;
  Writer.WriteInteger(FNavGroups.Count);
  for i := 0 to FNavGroups.Count - 1 do
  begin
    Writer.WriteInteger(FNavGroups.NavGroups[i].Count);
    Writer.WriteString(FNavGroups.NavGroups[i].Text);
    Writer.WriteBoolean(FNavGroups.NavGroups[i].Expandable);
    Writer.WriteBoolean(FNavGroups.NavGroups[i].Expanded);
    Writer.WriteString(FNavGroups.NavGroups[i].Hint);
    Writer.WriteInteger(FNavGroups.NavGroups[i].ImageIndex);
    Writer.WriteString(FNavGroups.NavGroups[i].Name);
    for j := 0 to FNavGroups.NavGroups[i].Count -1 do
    begin
      Writer.WriteString(FNavGroups.NavGroups[i].NavItems[j].Text);
      Writer.WriteString(FNavGroups.NavGroups[i].NavItems[j].Hint);
      Writer.WriteInteger(FNavGroups.NavGroups[i].NavItems[j].ImageIndex);
      Writer.WriteString(FNavGroups.NavGroups[i].NavItems[j].Name);
    end;
  end;
  Writer.WriteListEnd;
end;

{ TBaseViewStyle }

procedure TBaseViewStyle.CalcRect;
begin

end;

constructor TBaseViewStyle.Create(AOwner: TmrNavBar);
begin
  inherited Create;
  FOwner := AOwner;
  FOwnerWindowPro := AOwner.WindowProc;
  AOwner.WindowProc := WindowPro;
  FScrollBar := TmrScrollBar.Create(AOwner);
   
end;


destructor TBaseViewStyle.Destroy;
begin
  FScrollBar.Free;
  
  inherited;
end;

procedure TBaseViewStyle.DrawGroup;
begin

end;

procedure TBaseViewStyle.DrawItem;
begin

end;

procedure TBaseViewStyle.DrawStyle;
begin

end;

procedure TBaseViewStyle.InitPosition;
begin
  TopLeft.X := 0;
  TopLeft.Y := 0;
  ScrollBar.Position := 0;
end;

procedure TBaseViewStyle.UpDateGroup;
begin

end;

procedure TBaseViewStyle.WindowPro(var Message: TMessage);
begin

  FOwnerWindowPro(Message);
end;

{ TDefaultViewStyle }

procedure TDefaultViewStyle.CalcRect;
begin
  inherited;
  //客户区
  FClRect := Owner.GetClientRect;
  InflateRect(FClRect,-1,-1);
  //标题区
  FTitleRect := FClRect;
  FTitleRect.Bottom := FTitleRect.Top + 25;
  //尾部区域
  FAfterBodyRect := FClRect;
  FAfterBodyRect.Top := FAfterBodyRect.Bottom - 25;

  //UpPagerect
  FGroupUpPageRect := FAfterBodyRect;
  FGroupUpPageRect.Right := FGroupUpPageRect.Left + (FAfterBodyRect.Bottom - FAfterBodyRect.Top);
  InflateRect(FGroupUpPageRect,-5,-5);

  //DownPageRect
  FGroupDownPageRect := FGroupUpPageRect;
  OffsetRect(FGroupDownPageRect,(FGroupUpPageRect.Right - FGroupUpPageRect.Left) + 5,0);
  
  //分割区
  FSplitterRect := FAfterBodyRect;

  if FGroupPageSize * (FGroupPageIndex + 1) > FOwner.NavGroups.Count then
    FSplitterRect.Bottom := FSplitterRect.Top - (FOwner.NavGroups.Count-FGroupPageSize * FGroupPageIndex) * 25
  else
    FSplitterRect.Bottom := FSplitterRect.Top - FGroupPageSize * 25 ;
  FSplitterRect.Top := FSplitterRect.Bottom - 10;

  //组头显示区
  FGroupRect := FAfterBodyRect;
  FGroupRect.Top := FSplitterRect.Bottom;
  FGroupRect.Bottom := FAfterBodyRect.Top;

  //列表显示区
  FListRect := FClRect;
  FListRect.Top := FTitleRect.Bottom;
  FListRect.Bottom := FSplitterRect.Top;


  FItemHeight := FTitleRect.Bottom - FTitleRect.Top - 5;

  //垂直滚动条区域
  FVScrollRect := FListRect;
  FVScrollRect.Left := FVScrollRect.Right - 17;
  FListRect.Right := FListRect.Right - 17;
  
  ScrollBar.BoundRect := FVScrollRect;
  if FOwner.SelectGroup <> nil then
  begin
    ScrollBar.Min := 0;
    ScrollBar.Max := FItemHeight * (FOwner.SelectGroup.Count) - (FListRect.Bottom - FListRect.Top);
    ScrollBar.Step := FItemHeight;
    ScrollBar.CalcRect;
  end;
  TopLeft.Y := FTitleRect.Bottom - ScrollBar.Position;
end;

procedure TDefaultViewStyle.DrawGroup;
const
  ROP_DSPDxax = $00E20746;
var
  i:Integer;
  TempRect:TRect;
  TempPageSize:Integer;
  Bmp:TBitmap;
  MaskDC:HDC;
  ImageRect:TRect;
  TempImages:TImageList;
begin
  inherited;
  Bmp := TBitmap.Create;
  if FGroupPageSize * (FGroupPageIndex + 1) > FOwner.NavGroups.Count then
    TempPageSize := FOwner.NavGroups.Count - FGroupPageSize * (FGroupPageIndex)
  else
    TempPageSize := FGroupPageSize;
  for i := FGroupPageIndex * FGroupPageSize  to FGroupPageIndex * FGroupPageSize + TempPageSize - 1 do
  begin
    TempRect := FSplitterRect;
    TempRect.Top := FSplitterRect.Bottom + (TempPageSize - (FGroupPageIndex * FGroupPageSize + TempPageSize - i)) * 25;
    TempRect.Bottom := TempRect.Top + 25;
    with FOwner.Canvas do
    begin
      if FOwner.NavGroups.NavGroups[i] = FOwner.SelectGroup then
      begin
        Brush.Color := $0006B6F9;
        GetBmp('SELECTBAR',Bmp,MaskDC);
      end
      else
      begin
        Brush.Color := $00D08155;
        GetBmp('TITLEBAR',Bmp,MaskDC);
      end;
      FillRect(TempRect);

      StretchDraw(TempRect,Bmp);
      Pen.Color := $00965029;
      MoveTo(TempRect.Left,TempRect.Bottom - 1);
      LineTo(TempRect.Right,TempRect.Bottom - 1);

      if FOwner.ImageList <> nil then
      begin
        ImageRect := TempRect;
        ImageRect.Right := ImageRect.Left + (TempRect.Bottom - TempRect.Top);
        ImageRect.Bottom := ImageRect.Top + (TempRect.Bottom - TempRect.Top);
        InflateRect(ImageRect,-2,-2);
        FOwner.ImageList.GetBitmap(FOwner.NavGroups.NavGroups[i].ImageIndex,Bmp);
        StretchDraw(ImageRect,Bmp);
         
      end;

      Brush.Style := bsClear;
      TextOut(TempRect.Left + 32,
        TempRect.Top + (TempRect.Bottom - TempRect.Top - TextHeight('A')) div 2,
        FOwner.NavGroups.NavGroups[i].Text);
    end;
  end;
  Bmp.Free;
end;

procedure TDefaultViewStyle.DrawItem;
var
  i:Integer;
  StrRect:TRect;
  Bmp:TBitmap;
  MaskDC:HDC;
  ImageRect:TRect;
begin
  inherited;
  Bmp := TBitmap.Create;
  if FOwner.SelectGroup <> nil then
  begin
    for i := 0 to FOwner.SelectGroup.Count - 1 do
    begin
      StrRect := FClRect;
      StrRect.Top := TopLeft.Y + i * FItemHeight;
      StrRect.Bottom := StrRect.Top + FItemHeight;
      with FOwner.Canvas do
      begin
        if StrRect.Top < FTitleRect.Top then
          Continue;
        if FOwner.SelectGroup.NavItems[i] = FOwner.SelectItem then
        begin
          Brush.Color := $00F5D3BA;
          GetBmp('SELECTITEM',Bmp,MaskDC);
          StretchDraw(StrRect,Bmp);
        end
        else
        begin
          Brush.Color := clWhite;
          FillRect(StrRect);
        end;

        if FOwner.ImageList <> nil then
        begin
          ImageRect := StrRect;
          ImageRect.Right := ImageRect.Left + (StrRect.Bottom - StrRect.Top);
          ImageRect.Bottom := ImageRect.Top + (StrRect.Bottom - StrRect.Top);
          InflateRect(ImageRect,-2,-2);
          FOwner.ImageList.GetBitmap(FOwner.SelectGroup.NavItems[i].ImageIndex,Bmp);
          StretchDraw(ImageRect,Bmp);
        end;
        
        Brush.Style := bsClear;
        TextOut(TopLeft.X + 32,
          StrRect.Top + (StrRect.Bottom - StrRect.Top - FOwner.Canvas.TextHeight('A')) div 2,
          FOwner.SelectGroup.NavItems[i].Text);
      end;
    end;
    
  end;
  Bmp.Free;
end;

procedure TDefaultViewStyle.DrawStyle;
var
  TempRect:TRect;
  Bmp:TBitmap;
  MaskDC : HDC; 
begin
  inherited;
  Bmp := TBitmap.Create;
  CalcRect;
  with Owner.Canvas do
  begin
    Brush.Color := $00965029;
    FillRect(Owner.GetClientRect);
    Brush.Color := clWhite;
    FillRect(FClRect);
    
    DrawItem;

    Brush.Color := $00D08155;
    FillRect(FTitleRect);
    GetBmp('TITLEBAR',Bmp,MaskDC);
    StretchDraw(FTitleRect,Bmp);

    if FOwner.SelectGroup <> nil then
    begin
      with FOwner.Canvas do
      begin
        Brush.Style := bsClear;
        TextOut(FTitleRect.Left + 32,
          FTitleRect.Top + (FTitleRect.Bottom - FTitleRect.Top - FOwner.Canvas.TextHeight('A')) div 2,
          FOwner.SelectGroup.Text);
      end;
    end;

    Brush.Color := $00D08155;
    FillRect(FSplitterRect);
    GetBmp('TITLEBAR',Bmp,MaskDC);
    StretchDraw(FSplitterRect,Bmp);
    Pen.Color := $00965029;
    MoveTo(FSplitterRect.Left,FSplitterRect.Bottom - 1);
    LineTo(FSplitterRect.Right,FSplitterRect.Bottom - 1);

    DrawGroup;

    Brush.Color := $00F2BE9F;
    FillRect(FAfterBodyRect);

    GetBmp('AFTERBAR',Bmp,MaskDC);
    StretchDraw(FAfterBodyRect,Bmp);

    //GroupUpPage
    Brush.Color := $00965029;
    TempRect := FGroupUpPageRect;
    InflateRect(TempRect,1,1);
    FillRect(TempRect);
    Brush.Color := $00F2BE9F;
    FillRect(FGroupUpPageRect);

    GetBmp('UPBTN',Bmp,MaskDC);
//    TransparentStretchBlt(Owner.Canvas.Handle,FGroupUpPageRect.Left,FGroupUpPageRect.Top
//            ,(FGroupUpPageRect.Right - FGroupUpPageRect.Left),
//          (FGroupUpPageRect.Bottom - FGroupUpPageRect.Top),Bmp.Canvas.Handle,0,0,
//          Bmp.Width,Bmp.Height,MaskDC,0,0);
    StretchDraw(FGroupUpPageRect,Bmp);

    //GroupDownPage
    Brush.Color := $00965029;
    TempRect := FGroupDownPageRect;
    InflateRect(TempRect,1,1);
    FillRect(TempRect);
    Brush.Color := $00F2BE9F;
    FillRect(FGroupDownPageRect);

    GetBmp('DOWNBTN',Bmp,MaskDC);
//    TransparentStretchBlt(Owner.Canvas.Handle,FGroupDownPageRect.Left,FGroupDownPageRect.Top
//            ,(FGroupDownPageRect.Right - FGroupDownPageRect.Left),
//          (FGroupDownPageRect.Bottom - FGroupDownPageRect.Top),Bmp.Canvas.Handle,0,0,
//          Bmp.Width,Bmp.Height,MaskDC,0,0);
    StretchDraw(FGroupDownPageRect,Bmp);

    ScrollBar.DrawScoll;
  end;

  Bmp.Free;
end;

procedure TDefaultViewStyle.GetArea(X, Y,Mess: Integer);
var
  Point:TPoint;
begin
  Point.X := X;
  Point.Y := Y;
  if PtInRect(FTitleRect,Point) then
  begin
    //
  end
  else if PtInRect(FListRect,Point) then
  begin
    SelectItem(X,Y,Mess);    
  end
  else if PtInRect(FSplitterRect,Point) then
  begin
    //
  end
  else if PtInRect(FVScrollRect,Point) then
  begin
    ScrollBar.GetArea(Point,Mess);
  end
  else if PtInRect(FGroupRect,Point) then
  begin
    SelectGroup(X,Y,Mess);
  end
  else if PtInRect(FGroupUpPageRect,Point) then
  begin
    GroupUpBtnClick(X,Y,Mess);
  end
  else if PtInRect(FGroupDownPageRect,Point) then
  begin
    GroupDownBtnClick(X,Y,Mess);
  end;
end;

procedure TDefaultViewStyle.GroupDownBtnClick(X, Y, Mess: Integer);
begin
  case Mess of
    WM_LBUTTONUP:
    begin
      if FClecked then
      begin
        if FGroupPageIndex < FGroupPageCount - 1 then
        begin
          Inc(FGroupPageIndex);
          FOwner.Invalidate;
        end;
      end;
      FClecked := False;
    end;
    WM_MOUSEMOVE:
    begin

    end;
    WM_LBUTTONDOWN:
    begin
      FClecked := True;
    end;
  end;
end;

procedure TDefaultViewStyle.GroupUpBtnClick(X, Y, Mess: Integer);
begin
  case Mess of
    WM_LBUTTONUP:
    begin
      if FClecked then
      begin
        if FGroupPageIndex > 0 then
        begin
          Dec(FGroupPageIndex);
          FOwner.Invalidate;
        end;
      end;
      FClecked := False;
    end;
    WM_MOUSEMOVE:
    begin

    end;
    WM_LBUTTONDOWN:
    begin
      FClecked := True;
    end;
  end;
end;

procedure TDefaultViewStyle.ItemClick(X, Y, Index: Integer);
begin

end;

procedure TDefaultViewStyle.SelectGroup(X, Y, Mess: Integer);
begin
  case Mess of
    WM_LBUTTONUP:
    begin
      if FClecked then
      begin
        begin
          FOwner.SelectGroup := FOwner.NavGroups.NavGroups
            [(Y - FSplitterRect.Bottom) div 25 + FGroupPageIndex * FGroupPageSize];
          InitPosition;
          FOwner.Invalidate;
        end;
      end;
      FClecked := False;
    end;
    WM_MOUSEMOVE:
    begin
    end;
    WM_LBUTTONDOWN:
    begin
      FClecked := True;
    end;
  end;
end;

procedure TDefaultViewStyle.SelectItem(X, Y, Mess: Integer);
var
  index:Integer;
begin
  case Mess of
    WM_LBUTTONUP:
    begin
      if FClecked then
      begin
        if FOwner.SelectGroup <> nil then
        begin
          if FOwner.SelectGroup.Count = 0 then
            Exit;
          index := (Y - TopLeft.Y) div FItemHeight;
          if index > FOwner.SelectGroup.Count - 1 then
            Exit;
          FOwner.SelectItem := FOwner.SelectGroup.NavItems[index];
          FOwner.Invalidate;
          FOwner.OnGroupItemClick(FOwner,FOwner.SelectItem);
        end;
      end;
      FClecked := False; 
    end;
    WM_MOUSEMOVE:
    begin

    end;
    WM_LBUTTONDOWN:
    begin
      FClecked := True;
    end;
  end;
end;

procedure TDefaultViewStyle.UpDateGroup;
begin
  FGroupPageSize := 5;
  FGroupPageCount := FOwner.NavGroups.Count div FGroupPageSize;
  if FOwner.NavGroups.Count mod FGroupPageSize > 0 then
    Inc(FGroupPageCount);
end;

procedure TDefaultViewStyle.WindowPro(var Message: TMessage);
begin
  case Message.Msg of
    WM_LBUTTONUP:
    begin
      GetArea(TWMRButtonUp(Message).Pos.x,TWMRButtonUp(Message).Pos.y,Message.Msg);
    end;
    WM_MOUSEMOVE:
    begin
      GetArea(TWMRButtonUp(Message).Pos.x,TWMRButtonUp(Message).Pos.y,Message.Msg);
    end;
    WM_LBUTTONDOWN:
    begin
      GetArea(TWMRButtonUp(Message).Pos.x,TWMRButtonUp(Message).Pos.y,Message.Msg);    
    end;
    WM_SIZE:
    begin
      CalcRect;
    end;
  end;
  inherited;

end;


{ TmrScrollBar }

procedure TmrScrollBar.CalcRect;
begin
  //向上按钮区域
  FUpButtonRect := FBoundRect;
  FUpButtonRect.Bottom := FUpButtonRect.Top + (FUpButtonRect.Right - FUpButtonRect.Left);
  InflateRect(FUpButtonRect,-1,-1);
  //向下按钮区域
  FDownButtonRect := FBoundRect;
  FDownButtonRect.Top := FDownButtonRect.Bottom - (FDownButtonRect.Right - FDownButtonRect.Left);
  InflateRect(FDownButtonRect,-1,-1);

  if Max > 0 then
    FSlideHeight := Trunc((FBoundRect.Bottom - FBoundRect.Top) / (Max - Min + (FBoundRect.Bottom - FBoundRect.Top)) * (FDownButtonRect.Top - FUpButtonRect.Bottom - 2))
  else
    FSlideHeight := (FDownButtonRect.Top - 1 - FUpButtonRect.Bottom -1);

  //滑块
  FSlideRect := FBoundRect;
  InflateRect(FSlideRect,-1,-1);
  if Position > 0 then
    FSlideRect.Top := FUpButtonRect.Bottom + 1 + Trunc((FPosition / (Max - Min)) * (FDownButtonRect.Top - 1 - FUpButtonRect.Bottom -1 - FSlideHeight ))
  else
    FSlideRect.Top := FUpButtonRect.Bottom + 1;

  if FSlideRect.Top + FSlideHeight > FDownButtonRect.Top - 1 then
    FSlideHeight := FDownButtonRect.Top - 1 - FSlideRect.Top;

  FSlideRect.Bottom := FSlideRect.Top + FSlideHeight;
end;

constructor TmrScrollBar.Create(AOwner: TmrNavBar);
begin
  FOwner := AOwner;
end;

destructor TmrScrollBar.Destroy;
begin

  inherited;
end;

procedure TmrScrollBar.DrawScoll;
var
  TempRect:TRect;
  Bmp:TBitmap;
  MaskDC:HDC;
begin
  Bmp := TBitmap.Create;
  with FOwner,FOwner.Canvas do
  begin
    //绘制背景
    Brush.Color := clWhite;
    FillRect(FBoundRect);
    //绘制向上按钮
    TempRect := FUpButtonRect;
    Brush.Color := $00965029;
    FillRect(TempRect);
    InflateRect(TempRect,-1,-1);
    Brush.Color := $00F2BE9F;
    FillRect(TempRect);
    GetBmp('SUPBTN',Bmp,MaskDC);
    StretchDraw(TempRect,Bmp);


    //绘制向下按钮
    TempRect := FDownButtonRect;
    Brush.Color := $00965029;
    FillRect(TempRect);
    InflateRect(TempRect,-1,-1);
    Brush.Color := $00F2BE9F;
    FillRect(TempRect);

    GetBmp('SDOWNBTN',Bmp,MaskDC);
    StretchDraw(TempRect,Bmp);

    //绘制滑块
    TempRect := FSlideRect;
    Brush.Color := $00965029;
    FillRect(TempRect);
    InflateRect(TempRect,-1,-1);
    Brush.Color := $00F2BE9F;
    FillRect(TempRect);
    GetBmp('SLIDE',Bmp,MaskDC);
    StretchDraw(TempRect,Bmp);
  end;
  Bmp.Free;
end;

procedure TmrScrollBar.GetArea(APoint: TPoint; Mess: Integer);
begin
  case Mess of
    WM_LBUTTONDOWN:
    begin
      FDown := True;
      FOldY := APoint.Y;
    end;
    WM_MOUSEMOVE:
    begin
      if PtInRect(FSlideRect,APoint) then
      begin
        if FDown then
        begin
          SlideMove(APoint);
        end;
      end;
    end;
    WM_LBUTTONUP:
    begin
      if PtInRect(FUpButtonRect,APoint) then
      begin
        if FDown then
        if Position > FMin then
        begin
          Position := Position - FStep;
          FOwner.Invalidate;
        end;
      end;
      
      if PtInRect(FDownButtonRect,APoint) then
      begin
        if FDown then
        if Position < FMax then
        begin
          Position := Position + FStep;
          FOwner.Invalidate;
        end;
      end;
      
      if PtInRect(FSlideRect,APoint) then
      begin

        if (Max > 0) and (Position mod Step > 0) then
        begin
          if APoint.Y > FOldY then
            Position := Position + (Step - Position mod Step)
          else
            Position := Position - (Step - Position mod Step);
          if Position < Min then
            Position := Min;
          if Position > Max then
            Position := Max;
          FOwner.Invalidate;
        end;  
      end;
      
      FDown := False;  
    end;
  end;

end;

procedure TmrScrollBar.SetBoundRect(value: TRect);
begin
  FBoundRect := value;
  CalcRect;  
end;

procedure TmrScrollBar.SlideMove(APoint: TPoint);
var
  TempPosition:Integer;
  Temp:Extended;
begin
  Temp := (FDownButtonRect.Top - 1 - FUpButtonRect.Bottom -1 - FSlideHeight );
  if Temp = 0 then
    Exit;
  TempPosition := Trunc(((APoint.Y - FOldY)) / ( (FDownButtonRect.Top - 1 - FUpButtonRect.Bottom -1 - FSlideHeight )) * (Max - Min));
  TempPosition := Position + TempPosition;
  if (TempPosition <= Max) and
        (TempPosition >= Min) then
  begin
    Position := TempPosition;
    FOwner.Invalidate;
    FOldY := APoint.Y;
  end;
end;

{ TNavGroup }

function TNavGroup.Add: TNavItem;
begin
  Result := TNavItem.Create(FOwner);
  FList.Add(Result);
end;

procedure TNavGroup.Clear;
var
  i:Integer;
begin
  if FList.Count > 0 then
  for i:= FList.Count - 1 to 0 do
  begin
    Delete(i);
  end;
end;

constructor TNavGroup.Create(AOwner: TmrNavBar);
begin
  FOwner := AOwner;
  FList := TList.Create;
end;

procedure TNavGroup.Delete(index: Integer);
begin
  if (index < 0) or (index >= FList.Count) then
    Exit;
  TNavItem(FList[index]).Free;
  FList.Delete(index);
end;

procedure TNavGroup.Delete(NavItem: TNavItem);
begin
  Delete(FList.IndexOf(NavItem));
end;

destructor TNavGroup.Destroy;
begin
  FList.Free;
  inherited;
end;

function TNavGroup.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TNavGroup.GetNavItem(index: Integer): TNavItem;
begin
  Result := TNavItem(FList[index]);
end;

procedure TNavGroup.SetExpandable(value: Boolean);
begin
  FExpandable := value;
  FOwner.Invalidate;
end;

procedure TNavGroup.SetExpanded(value: Boolean);
begin
  FExpanded := value;
  FOwner.Invalidate;
end;

procedure TNavGroup.SetNavItem(index: Integer; value: TNavItem);
begin
  if index < FList.Count -1 then
    Exit;
  FList[index] := value;
end;

{ TNavGroups }

function TNavGroups.Add: TNavGroup;
begin
  Result := TNavGroup.Create(FOwner);
  FList.Add(Result);
  FOwner.ViewStyle.UpDateGroup;
  if FOwner.SelectGroup = nil then
    FOwner.SelectGroup := Result;
end;

procedure TNavGroups.Clear;
var
  i:Integer;
begin
  FOwner.SelectGroup := nil;
  if FList.Count > 0 then
  for i := FList.Count -1 to 0 do
  begin
    TNavGroup(FList[i]).Clear;
    TNavGroup(FList[i]).Free;
    FList.Delete(i);
  end;
  FOwner.ViewStyle.UpDateGroup;
end;

constructor TNavGroups.Create(AOwner: TmrNavBar);
begin
  FOwner := AOwner;
  FList := TList.Create;
end;

procedure TNavGroups.Delete(index: Integer);
begin
  if (index < 0) or (index > FList.Count -1) then
    Exit;
  if FOwner.SelectGroup = TNavGroup(FList[index]) then
  begin
    if index >0 then
    begin
      FOwner.SelectGroup := TNavGroup(FList[index - 1]);
    end
    else
    begin
      FOwner.SelectGroup := nil;
    end;
  end;
  TNavGroup(FList[index]).Clear;
  TNavGroup(FList[index]).Free;
  FList.Delete(index);
  FOwner.ViewStyle.UpDateGroup;
end;

procedure TNavGroups.Delete(NavGroup: TNavGroup);
begin
  Delete(FList.IndexOf(NavGroup));
end;

destructor TNavGroups.Destroy;
begin
  FList.Free;
  inherited;
end;

function TNavGroups.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TNavGroups.GetNavGroups(index: Integer): TNavGroup;
begin
  Result := TNavGroup(FList[index]);
end;

procedure TNavGroups.SetNavGroups(index: Integer; value: TNavGroup);
begin
  FList[index] := value;
end;

end.
