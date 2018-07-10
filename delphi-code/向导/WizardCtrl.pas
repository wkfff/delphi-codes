unit WizardCtrl;





interface

(*
uses
  ShareMem, SysUtils, Windows, ToolsAPI;

type
  TDumbWizard = class(TNotifierObject, IOTAWizard, IOTAMenuWizard)
    // IOTAWizard methods
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
    // IOTAMenuWizard method
    function GetMenuText: string;
  end;

procedure Register;

implementation

uses Dialogs;

function TDumbWizard.GetName: string;
begin
  Result := 'Dumb Wizard';
end;

function TDumbWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

function TDumbWizard.GetIDString: String;
begin
  Result := 'DDG.DumbWizard';
end;

procedure TDumbWizard.Execute;
begin
  MessageDlg('This is a dumb wizard.', mtInformation, [mbOk], 0);
end;

function TDumbWizard.GetMenuText: string;
begin
  Result := 'Dumb Wizard';
end;

procedure Register;
begin
  RegisterPackageWizard(TDumbWizard.Create);
end;

end.




(*
interface

uses
  Windows, Messages, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TBackNextClickEvent = procedure(Sender: TObject; var AllowChange: Boolean) of object;

  TWizardCtrl = class(TCustomControl)
  private
    { Private declarations }
    FNoteBook: TNoteBook;
    FHelpButton: TButton;
    FBackButton: TButton;
    FNextButton: TButton;
    FCancelButton: TButton;
    FHelpCaption: string;
    FBackCaption: string;
    FNextCaption: string;
    FCancelCaption: string;
    FFinishCaption: string;
    FHelpVisible: Boolean;
    FHelpLeftAlign: Boolean;
    FFinished: Boolean;
    FPageName: string;
    FOnHelpClick: TNotifyEvent;
    FOnBackClick: TBackNextClickEvent;
    FOnNextClick: TBackNextClickEvent;
    FOnCancelClick: TNotifyEvent;
    FOnFinishClick: TNotifyEvent;
    FOnPageChange: TNotifyEvent;

    procedure SetNoteBook(Value: TNoteBook);
    procedure SetHelpCaption(Value: string);
    procedure SetBackCaption(Value: string);
    procedure SetNextCaption(Value: string);
    procedure SetCancelCaption(Value: string);
    procedure SetFinishCaption(Value: string);
    procedure SetHelpVisible(Value: Boolean);
    procedure SetHelpLeftAlign(Value: Boolean);
    procedure SetPageIndex(Index: Integer);

    function GetPageIndex: Integer;

    procedure HelpButtonClick(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
    procedure CancelButtonClick (Sender: TObject);

    procedure AdjustButtons(PageIdx: Integer);
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    property PageName: string read FPageName;
    property PageIndex: Integer read GetPageIndex write SetPageIndex;
    property Finished: Boolean read FFinished;
    property HelpButton: TButton read FHelpButton;
    property BackButton: TButton read FBackButton;
    property NextButton: TButton read FNextButton;
    property CancelButton: TButton read FCancelButton;

    procedure FirstPage;
    procedure LastPage;
    procedure NextPage;
    procedure PrevPage;
  published
    { Published declarations }
    property NoteBook: TNoteBook read FNoteBook write SetNoteBook;
    property CaptionOfHelp: string read FHelpCaption write SetHelpCaption;
    property CaptionOfBack: string read FBackCaption write SetBackCaption;
    property CaptionOfNext: string read FNextCaption write SetNextCaption;
    property CaptionOfCancel: string read FCancelCaption write SetCancelCaption;
    property CaptionOfFinish: string read FFinishCaption write SetFinishCaption;
    property HelpVisible: Boolean read FHelpVisible write SetHelpVisible;
    property HelpLeftAlign: Boolean read FHelpLeftAlign write SetHelpLeftAlign;
    property BorderWidth;

    property OnHelpClick: TNotifyEvent read FOnHelpClick write FOnHelpClick;
    property OnBackClick: TBackNextClickEvent read FOnBackClick write FOnBackClick;
    property OnNextClick: TBackNextClickEvent read FOnNextClick write FOnNextClick;
    property OnCancelClick: TNotifyEvent read FOnCancelClick write FOnCancelClick;
    property OnFinishClick: TNotifyEvent read FOnFinishClick write FOnFinishClick;
    property OnPageChange: TNotifyEvent read FOnPageChange write FOnPageChange;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('DayDream', [TWizardCtrl]);
end;

constructor TWizardCtrl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alBottom;
  Height := 48;
  FHelpVisible := True;
  FHelpLeftAlign := False;
  FFinished := False;
  FPageName := '';
  BorderWidth := 7;

  FHelpButton := TButton.Create(Self);
  FHelpButton.Parent := Self;
  FHelpButton.OnClick := HelpButtonClick;
  FHelpButton.Width:=75;
  FHelpButton.Height:=23;
  FHelpButton.TabOrder := 2;
  CaptionOfHelp := '帮助';

  FBackButton := TButton.Create(Self);
  FBackButton.Parent := Self;
  FBackButton.OnClick := BackButtonClick;
  FBackButton.Width:=75;
  FBackButton.Height:=23;
  FBackButton.TabOrder := 3;
  CaptionOfBack := '< 上一步';

  FNextButton := TButton.Create(Self);
  FNextButton.Parent := Self;
  FNextButton.OnClick := NextButtonClick;
  FNextButton.Width:=75;
  FNextButton.Height:=23;
  FNextButton.TabOrder := 0;
  FNextButton.Default := True;
  CaptionOfNext := '下一步 >';
  CaptionOfFinish := '完成';

  FCancelButton := TButton.Create(Self);
  FCancelButton.Parent := Self;
  FCancelButton.OnClick := CancelButtonClick;
  FCancelButton.Width:=75;
  FCancelButton.Height:=23;
  FCancelButton.TabOrder := 1;
  CaptionOfCancel := '取消';
end;

destructor  TWizardCtrl.Destroy;
begin
  FHelpButton.Free;
  FBackButton.Free;
  FNextButton.Free;
  FCancelButton.Free;
  inherited Destroy;
end;

procedure TWizardCtrl.SetNoteBook(Value: TNoteBook);
begin
  FNoteBook := Value;
  if FNoteBook = nil then exit;

  FPageName := FNoteBook.ActivePage;
  AdjustButtons(FNoteBook.PageIndex);
end;

procedure TWizardCtrl.SetHelpCaption(Value: string);
begin
  FHelpCaption := Value;
  FHelpButton.Caption := Value;
  Invalidate;
end;

procedure TWizardCtrl.SetBackCaption(Value: string);
begin
  FBackCaption := Value;
  FBackButton.Caption := Value;
  Invalidate;
end;

procedure TWizardCtrl.SetNextCaption(Value: string);
begin
  FNextCaption := Value;
  if not FFinished then FNextButton.Caption := Value;
  Invalidate;
end;

procedure TWizardCtrl.SetCancelCaption(Value: string);
begin
  FCancelCaption := Value;
  FCancelButton.Caption := Value;
  Invalidate;
end;

procedure TWizardCtrl.SetFinishCaption(Value: string);
begin
  FFinishCaption := Value;
  if FFinished then FNextButton.Caption := Value;
  Invalidate;
end;

procedure TWizardCtrl.SetHelpVisible(Value: Boolean);
begin
  FHelpVisible := Value;
  FHelpButton.Visible := Value;
end;

procedure TWizardCtrl.SetHelpLeftAlign(Value: Boolean);
begin
  FHelpLeftAlign := Value;
  Paint;
end;

procedure TWizardCtrl.SetPageIndex(Index: Integer);
begin
  if not Assigned(FNoteBook) then exit;
  if (Index < 0) or (Index >= FNoteBook.Pages.Count) then exit;
  if FNoteBook.PageIndex = Index then exit;

  FNoteBook.PageIndex := Index;
  AdjustButtons(Index);
  FPageName := FNoteBook.ActivePage;
  if Assigned(FOnPageChange) then FOnPageChange(Self);
end;

function TWizardCtrl.GetPageIndex: Integer;
begin
  if not Assigned(FNoteBook) then
  begin
    Result := -1;
  end else
  begin
    Result := FNoteBook.PageIndex;
  end;
end;

procedure TWizardCtrl.HelpButtonClick(Sender: TObject);
begin
  if Assigned(FOnHelpClick) then
    FOnHelpClick(Self);
end;

procedure TWizardCtrl.BackButtonClick(Sender: TObject);
var
  i: Integer;
  AllowChange: Boolean;
begin
  if Assigned(FNoteBook) then
  begin
    i := FNoteBook.PageIndex;
    if i > 0 then
    begin
      AllowChange := True;
      if Assigned(FOnBackClick) then
        FOnBackClick(Self, AllowChange);
      if AllowChange then
      begin
        Dec(i);
        FNoteBook.PageIndex := i;
        FNextButton.Enabled := True;
        AdjustButtons(i);
        FNextButton.Caption := FNextCaption;
        FPageName := FNoteBook.ActivePage;
        if Assigned(FOnPageChange) then FOnPageChange(Self);
      end;
    end;
  end;
end;

procedure TWizardCtrl.NextButtonClick(Sender: TObject);
var
  i: Integer;
  AllowChange: Boolean;
begin
  if Assigned(FNoteBook) then
  begin
    i := FNoteBook.PageIndex;
    if i < FNoteBook.Pages.Count - 1 then
    begin
      AllowChange := True;
      if Assigned(FOnNextClick) then
        FOnNextClick(Self, AllowChange);
      if AllowChange then
      begin
        Inc(i);
        FNoteBook.PageIndex := i;
        FBackButton.Enabled := True;
        AdjustButtons(i);
        FPageName := FNoteBook.ActivePage;
        if Assigned(FOnPageChange) then FOnPageChange(Self);
        exit;
      end;
    end;
  end;
  if FFinished then
  begin
    if Assigned(FOnFinishClick) then
      FOnFinishClick(Self);
  end;
end;

procedure TWizardCtrl.CancelButtonClick (Sender: TObject);
begin
  if Assigned(FOnCancelClick) then
    FOnCancelClick(Self);
end;

procedure TWizardCtrl.AdjustButtons(PageIdx: Integer);
begin
  if FNoteBook.Pages.Count = 1 then
  begin
    FBackButton.Enabled := False;
    FNextButton.Enabled := True;
    FNextButton.Caption := FFinishCaption;
    FFinished := True;
  end
  else if PageIdx = FNoteBook.Pages.Count - 1 then
  begin
    FBackButton.Enabled := True;
    FNextButton.Enabled := True;
    FNextButton.Caption := FFinishCaption;
    FFinished := True;
  end
  else if PageIdx = 0 then
  begin
    FBackButton.Enabled := False;
    FNextButton.Enabled := True;
    FNextButton.Caption := FNextCaption;
    FFinished := False;
  end else
  begin
    FBackButton.Enabled := True;
    FNextButton.Enabled := True;
    FNextButton.Caption := FNextCaption;
    FFinished := False;
  end;
end;

procedure TWizardCtrl.FirstPage;
begin
  if not Assigned(FNoteBook) then exit;
  SetPageIndex(0);
end;

procedure TWizardCtrl.LastPage;
begin
  if not Assigned(FNoteBook) then exit;
  SetPageIndex(FNoteBook.Pages.Count - 1);
end;

procedure TWizardCtrl.NextPage;
begin
  if not Assigned(FNoteBook) then exit;
  SetPageIndex(FNoteBook.PageIndex + 1);
end;

procedure TWizardCtrl.PrevPage;
begin
  if not Assigned(FNoteBook) then exit;
  SetPageIndex(FNoteBook.PageIndex - 1);
end;

procedure TWizardCtrl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FNoteBook) then
    FNoteBook := nil;
end;

procedure TWizardCtrl.Paint;
begin
  inherited Paint;
  with Canvas do
  begin
    Pen.Color := clBtnShadow;
    MoveTo(0, 0);
    LineTo(Self.ClientWidth, 0);
    Pen.Color := clBtnhighlight;
    MoveTo(0, 1);
    LineTo(Self.ClientWidth, 1);
  End;

  FHelpButton.Top := Self.ClientHeight - FHelpButton.Height;
  FBackButton.Top := Self.ClientHeight - FBackButton.Height;
  FNextButton.Top := Self.ClientHeight - FNextButton.Height;
  FCancelButton.Top := Self.ClientHeight - FCancelButton.Height;

  FCancelButton.Left := Self.ClientWidth - FCancelButton.Width;
  FNextButton.Left := FCancelButton.Left - FNextButton.Width - 10;
  FBackButton.Left := FNextButton.Left - FBackButton.Width;

  if FHelpLeftAlign then
    FHelpButton.Left := 0
  else
    FHelpButton.Left := FBackButton.Left - FHelpButton.Width - 10;

  if FHelpVisible then
    FHelpButton.Visible := True
  else
    FHelpButton.Visible := False;

  if not Assigned(FNoteBook) then
  begin
    FBackButton.Enabled := False;
    FNextButton.Enabled := False;
    FNextButton.Caption := FFinishCaption;
  end;
end;

procedure TWizardCtrl.Resize;
begin
  inherited Resize;
end;

end.
*)

