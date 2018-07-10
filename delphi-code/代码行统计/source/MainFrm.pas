unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Dock, TB2Toolbar, TBX, TB2Item, GIFImg, ExtCtrls, Buttons,
  StdCtrls, TBXExtItems, Menus, ToolWin, ComCtrls, ImgList, Grids, LOCSCore;

type
  TMainForm = class(TForm)
    tbdcDock: TTBXDock;
    ilImages: TImageList;
    tb1: TTBXToolbar;
    tbtmChooseFile: TTBItem;
    tbtmChooseProject: TTBItem;
    tbtmRun: TTBItem;
    tbsprtrtm1: TTBSeparatorItem;
    tbtmSave: TTBItem;
    tbtmOption: TTBItem;
    tbsprtrtm2: TTBSeparatorItem;
    tbtmHelp: TTBItem;
    tbtmExit: TTBItem;
    tbtmLook: TTBItem;
    pnl4: TPanel;
    pnl2: TPanel;
    spl1: TSplitter;
    pnl1: TPanel;
    sgdDetailResult: TStringGrid;
    pnl3: TPanel;
    grp1: TGroupBox;
    spl2: TSplitter;
    tvProjects: TTreeView;
    mmoResult: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgdDetailResultDrawCell(Sender: TObject; ACol, ARow: Integer; Rect:
        TRect; State: TGridDrawState);
    procedure tbtmChooseFileClick(Sender: TObject);
  private
    FCurrFileName: string;
    FFileList: TStringList;
    procedure FillFileList;
  end;

var
  MainForm: TMainForm;

implementation

resourcestring
  SNumber = '序号';
  SFileName = '文件名';
  SBlankLine = '空白行数';
  SCommentLine = '注释行数';
  SCodeLine = '代码行数';
  STotalLine = '总行数';
  SDelphiFilter = 'delphi文件(*.pas, *.dpr, *.dfm)|*.pas;*.dpr;*.dfm';

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FFileList := TStringList.Create;
end;

procedure TMainForm.FillFileList;
var
  I: Integer;
begin
  FFileList.Clear;
  for I := 0 to tvProjects.Items.Count - 1 do
  begin
//    if FileExists(tvpr) then
      File
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFileList);
end;

procedure TMainForm.sgdDetailResultDrawCell(Sender: TObject; ACol, ARow:
    Integer; Rect: TRect; State: TGridDrawState);
var
  w, h: Integer;
  I: Integer;
begin
  // 画列标题
  if ARow = 0 then
  begin
    with (Sender as TStringGrid).Canvas do
    begin
      case ACol of
      0: begin
           w := TextWidth(SNumber);
           h := TextHeight(SNumber);
           TextOut((Rect.Left + Rect.Right - w) div 2,
             (Rect.Top + Rect.Bottom - h) div 2, SNumber);
         end;
      1: begin
           w := TextWidth(SFileName);
           h := TextHeight(SFileName);
           TextOut((Rect.Left + Rect.Right - w) div 2,
             (Rect.Top + Rect.Bottom - h) div 2, SFileName);
         end;
      2: begin
           w := TextWidth(SBlankLine);
           h := TextHeight(SBlankLine);
           TextOut((Rect.Left + Rect.Right - w) div 2,
             (Rect.Top + Rect.Bottom - h) div 2, SBlankLine);
         end;
      3: begin
           w := TextWidth(SCommentLine);
           h := TextHeight(SCommentLine);
           TextOut((Rect.Left + Rect.Right - w) div 2,
             (Rect.Top + Rect.Bottom - h) div 2, SCommentLine);
         end;
      4: begin
           w := TextWidth(SCodeLine);
           h := TextHeight(SCodeLine);
           TextOut((Rect.Left + Rect.Right - w) div 2,
             (Rect.Top + Rect.Bottom - h) div 2, SCodeLine);
         end;

      5: begin
           w := TextWidth(STotalLine);
           h := TextHeight(STotalLine);
           TextOut((Rect.Left + Rect.Right - w) div 2,
             (Rect.Top + Rect.Bottom - h) div 2, STotalLine);
         end;
      end;
    end;
  end;

  { TODO :  画代码行统计的结果 }
  (Sender as TStringGrid).RowCount := 51;

  // 画行标号
  if (ACol = 0) and (not(ARow = 0)) then
    (Sender as TStringGrid).Canvas.TextOut(Rect.Left + 2, Rect.Top + 4, IntToStr(ARow));
end;

procedure TMainForm.tbtmChooseFileClick(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  try
    Filter := SDelphiFilter;
    if Execute then
      FCurrFileName := FileName;
  finally
    Free;
  end;
end;

end.
