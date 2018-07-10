unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExplorerDrop, StdCtrls, SpinEdit, ShellBrowser, ComCtrls, WizardPage,
  ExtCtrls, CrossEdit;

type
  TForm1 = class(TForm)
    explrdrp1: TExplorerDrop;
    mmo1: TMemo;
    grp1: TGroupBox;
    edt1: TFloatSpinEdit;
    shlbrwsr1: TShellBrowser;
    btn1: TButton;
    wzrdpg1: TWizardPage;
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts3: TTabSheet;
    lbl1: TLabel;
    edt2: TEdit;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    edt3: TCrossEdit;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure explrdrp1Dropped(Sender: TObject; Files: TStrings; FileCount, x, y:
        Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  shlbrwsr1.Execute;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  with  TSaveDialog.Create(nil) do
  begin
    Filter := 'bmp|*.bmp';
    Execute();
    Free;
  end;
end;

procedure TForm1.explrdrp1Dropped(Sender: TObject; Files: TStrings; FileCount,
    x, y: Integer);
begin
  mmo1.Lines.LoadFromFile(Files[0]);
end;

end.
