unit RibbonNotepadDemoOptions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cxGraphics, cxControls, cxLookAndFeels, ExtCtrls;

type
  TRibbonDemoStyle = (rdsOffice2007, rdsOffice2010, rdsScenic);

  TScreenTipOptions = record
    ShowScreenTips: Boolean;
    ShowDescripitons: Boolean;
  end;

  { TRibbonDemoOptionsForm }

  TRibbonDemoOptionsForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    gbPanel: TBevel;
    cbColorScheme: TComboBox;
    cbRibbonStyle: TComboBox;
    cbScreenTipStyle: TComboBox;
    lblColorScheme: TLabel;
    lblRibbonStyle: TLabel;
    lblScreenTipStyle: TLabel;
  private
    procedure PopulateColorSchemes(AItems: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    procedure LoadOptions(const AColorSchemeName: string;
      const AScreenTipOptions: TScreenTipOptions; AStyle: TRibbonDemoStyle);
    procedure SaveOptions(out AColorSchemeName: string;
      out AScreenTipOptions: TScreenTipOptions; out AStyle: TRibbonDemoStyle);
  end;

function ExecuteRibbonDemoOptions(var AColorSchemeName: string;
  var AScreenTipOptions: TScreenTipOptions; var AStyle: TRibbonDemoStyle): Boolean;
implementation

uses
  cxLookAndFeelPainters;

{$R *.dfm}

function ExecuteRibbonDemoOptions(var AColorSchemeName: string;
  var AScreenTipOptions: TScreenTipOptions; var AStyle: TRibbonDemoStyle): Boolean;
begin
  with TRibbonDemoOptionsForm.Create(nil) do
  try
    LoadOptions(AColorSchemeName, AScreenTipOptions, AStyle);
    Result := ShowModal = mrOk;
    if Result then
      SaveOptions(AColorSchemeName, AScreenTipOptions, AStyle);
  finally
    Free;
  end;
end;

{ TRibbonDemoOptionsForm }

constructor TRibbonDemoOptionsForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PopulateColorSchemes(cbColorScheme.Items);
end;

procedure TRibbonDemoOptionsForm.LoadOptions(const AColorSchemeName: string;
  const AScreenTipOptions: TScreenTipOptions; AStyle: TRibbonDemoStyle);
begin
  cbRibbonStyle.ItemIndex := Ord(AStyle);
  cbColorScheme.ItemIndex := cbColorScheme.Items.IndexOf(AColorSchemeName);
  if AScreenTipOptions.ShowScreenTips then
    cbScreenTipStyle.ItemIndex := Ord(not AScreenTipOptions.ShowDescripitons)
  else
    cbScreenTipStyle.ItemIndex := 2;
end;

procedure TRibbonDemoOptionsForm.SaveOptions(out AColorSchemeName: string;
  out AScreenTipOptions: TScreenTipOptions; out AStyle: TRibbonDemoStyle);
begin
  AColorSchemeName := cbColorScheme.Text;
  AStyle := TRibbonDemoStyle(cbRibbonStyle.ItemIndex);
  AScreenTipOptions.ShowScreenTips := cbScreenTipStyle.ItemIndex <> 2;
  AScreenTipOptions.ShowDescripitons := cbScreenTipStyle.ItemIndex = 0;
end;

procedure TRibbonDemoOptionsForm.PopulateColorSchemes(AItems: TStrings);

  procedure AddColorScheme(const AName: string);
  begin
    if AItems.IndexOf(AName) < 0 then
      AItems.Add(AName)
  end;

var
  I: Integer;
begin
  AItems.BeginUpdate;
  try
    AItems.Clear;
    AddColorScheme('Black');
    AddColorScheme('Blue');
    AddColorScheme('Silver');

    for I := 0 to cxLookAndFeelPaintersManager.Count - 1 do
    begin
      if cxLookAndFeelPaintersManager[I].LookAndFeelStyle = lfsSkin then
        AddColorScheme(cxLookAndFeelPaintersManager[I].LookAndFeelName);
    end;
  finally
    AItems.EndUpdate;
  end;
end;

end.
