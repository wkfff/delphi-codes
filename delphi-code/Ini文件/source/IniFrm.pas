unit IniFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,IniFiles, TOTInfosDataModel;

type
  TMainForm = class(TForm)
    memMain: TMemo;
    btnShow: TButton;
    procedure btnShowClick(Sender: TObject);
    private
      FToTInfos: TTOTInfos;
    public
      procedure FillDataModel(ADataModel: TTOTInfos);
      function FormatSecionContent(AIniFile: TIniFile; ASection: string): string;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnShowClick(Sender: TObject);
begin
  FillDataModel(FToTInfos);
end;

procedure TMainForm.FillDataModel(ADataModel: TTOTInfos);
var
  oMyIniFile: TIniFile;
  I: Integer;
  s: string;
  slSections: TStringList;
  oSection: TSection;
begin
  try
    oMyIniFile := TIniFile.Create('I:\Test\Ini\ToTInfos.ini');
    slSections := TStringList.Create;
    oMyIniFile.readSections(slSections);
    DModel.SetLeng(slSections.Count);
    for I := 0 to slSections.Count - 1 do
    begin
      oSection := TSection.Create(slSections[I]);
      oSection.SetData(FormatSecionContent(oMyIniFile, slSections[I]));
      DModel.AddSection(oSection);
      s := s + slSections[I] + #13 + DModel.GetSectionContent(slSections[I]) + #13;
    end;
    MainForm.memMain.Lines.Text := s;
  finally
    FreeAndNil(oMyIniFile);
    slSections.Free;
  end;
end;

{

function TMainForm.FormatSecionContent(AIniFile: TIniFile; ASection: string): string;
var
  sContent: string;
begin
  if SameText(AIniFile.ReadString(ASection, 'gender', ''), '0') then
    sContent := sContent + '�Ա�' + '��' + #13
  else
    sContent := sContent + '�Ա�' +  'Ů' + #13;
  sContent := sContent + '���䣺' + AIniFile.ReadString(ASection, 'ege', '')
           + #13;
  sContent := sContent + '���գ�' + AIniFile.ReadString(ASection, 'birthday', '')
           + #13;
  sContent := sContent + '���ã�' + AIniFile.ReadString(ASection, 'hobby', '')
           + #13;
  sContent := sContent + '��飺' + AIniFile.ReadString(ASection, 'introduction', '')
           + #13;
  Result := sContent;
end;
 }
//constructor TMainForm.Create(AOwner: TComponent);
//begin
//  inherited;
//  sSections:= TStringList.Create;
//  DModel := TTOTDataModel.Create();
//end;
//
//destructor TMainForm.Destroy;
//begin
//  FreeAndNil(sSections);
//  DModel.Free;
//  inherited;
//end;



end.
