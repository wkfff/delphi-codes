unit EditorsLookupDemoMain;

interface

{$I cxVer.inc}


uses
  Variants, Windows, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxLookupGrid, cxLookupDBGrid, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid,
  cxGridCardView, cxGridDBCardView, cxMaskEdit, StdCtrls, ExtCtrls,
  cxContainer, cxEdit, cxTextEdit, cxDropDownEdit, cxDBEdit, cxStyles,
  Menus, ActnList, ImgList, ComCtrls, cxLookAndFeels,
  cxLookupEdit, cxDBLookupComboBox, DBCtrls, cxCustomData, cxGraphics,
  cxFilter, cxData, DB, cxDBData, cxClasses, cxCalendar, cxImageComboBox,
  cxMemo, cxCheckBox, cxButtons, cxNavigator, cxDBLookupEdit,
  cxStorage, cxPropertiesStore, cxDBNavigator, cxLookAndFeelPainters, BaseForm,
  cxGroupBox, cxLabel;

type
  TEditorsLookupDemoMainForm = class(TfmBaseForm)
    miOptions: TMenuItem;
    miStorage: TMenuItem;
    miStorageType: TMenuItem;
    miStore: TMenuItem;
    miRestore: TMenuItem;
    miIniStoreType: TMenuItem;
    miRegistryStoreType: TMenuItem;
    miMemoryStoreType: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    miStorageActive: TMenuItem;
    LookupOptions1: TMenuItem;
    miPickMode: TMenuItem;
    miStandardMode: TMenuItem;
    miEditMode: TMenuItem;
    cxPropertiesStore: TcxPropertiesStore;
    cxStorageActiveStore: TcxPropertiesStore;
    pnlEditors: TPanel;
    gbIssue: TcxGroupBox;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label9: TcxLabel;
    edName: TcxDBTextEdit;
    meDescription: TcxDBMemo;
    lcbCreator: TcxDBLookupComboBox;
    gbInfo: TcxGroupBox;
    Label3: TcxLabel;
    Label4: TcxLabel;
    cbPriority: TcxDBImageComboBox;
    deCreateDate: TcxDBDateEdit;
    chbRequest: TcxDBCheckBox;
    gbStatus: TcxGroupBox;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    cbStatus: TcxDBImageComboBox;
    deLastModifiedDate: TcxDBDateEdit;
    deFixedDate: TcxDBDateEdit;
    DBNavigator: TcxDBNavigator;
    gbProject: TcxGroupBox;
    Label8: TcxLabel;
    Label10: TcxLabel;
    lcbProject: TcxDBLookupComboBox;
    lcbOwner: TcxDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ChangeLookupModeClick(Sender: TObject);
    procedure lcbCreatorNewLookupDisplayText(Sender: TObject;
      const AText: TCaption);
    procedure miStoreClick(Sender: TObject);
    procedure miRestoreClick(Sender: TObject);
    procedure miStorageActiveClick(Sender: TObject);
    procedure StorageTypeClick(Sender: TObject);
  private
    FStream: TMemoryStream;
    procedure SelectStorageType(AStorageType: TcxStorageType);
    procedure SetEditLookupMode;
    procedure SetPickLookupMode;
    procedure SetStandardLookupMode;
  end;

var
  EditorsLookupDemoMainForm: TEditorsLookupDemoMainForm;

implementation

{$R *.dfm}

uses
  EditorsLookupDemoData, EditorsLookupDemoNewUser, SysUtils, AboutDemoForm;

procedure TEditorsLookupDemoMainForm.FormCreate(Sender: TObject);
begin
  FStream := TMemoryStream.Create;
  cxPropertiesStore.StorageStream := FStream;
end;

procedure TEditorsLookupDemoMainForm.FormDestroy(Sender: TObject);
begin
  if cxPropertiesStore.StorageType = stStream then
    SelectStorageType(stIniFile);
  FreeAndNil(FStream);
end;

procedure TEditorsLookupDemoMainForm.lcbCreatorNewLookupDisplayText(
  Sender: TObject; const AText: TCaption);
var
  ALookupControl: TcxDBLookupComboBox;
begin
  ALookupControl := TcxDBLookupComboBox(Sender);
  ALookupControl.Reset;
  if (EditorsLookupDemoNewUserForm.ShowEX(AText) = mrOK) then
  begin
    ALookupControl.Text := EditorsLookupDemoDataDM.tblUsersUserName.AsString;
    ALookupControl.DataBinding.Field.Value :=
      EditorsLookupDemoDataDM.tblUsersID.Value;
  end;
  Abort;
end;

procedure TEditorsLookupDemoMainForm.ChangeLookupModeClick(Sender: TObject);
begin
  MenuItemSetChecked(Sender, True);
  case (Sender as TComponent).Tag of
    1: SetPickLookupMode;
    2: SetStandardLookupMode;
    3: SetEditLookupMode;
  end
end;

procedure TEditorsLookupDemoMainForm.SetPickLookupMode;
begin
  with lcbCreator.Properties do
  begin
    DropDownListStyle := lsEditFixedList;
    ImmediateDropDown := True;
  end;
  with lcbOwner.Properties do
  begin
    DropDownListStyle := lsEditFixedList;
    ImmediateDropDown := True;
  end;
  lcbProject.Properties.DropDownListStyle := lsEditFixedList;
end;

procedure TEditorsLookupDemoMainForm.SetStandardLookupMode;
begin
  with lcbCreator.Properties do
  begin
    DropDownListStyle := lsFixedList;
    ImmediateDropDown := True;
  end;
  with lcbOwner.Properties do
  begin
    DropDownListStyle := lsFixedList;
    ImmediateDropDown := True;
  end;
  lcbProject.Properties.DropDownListStyle := lsFixedList;
end;

procedure TEditorsLookupDemoMainForm.SetEditLookupMode;
begin
  with lcbCreator.Properties do
  begin
    DropDownListStyle := lsEditList;
    ImmediateDropDown := False;
  end;
  with lcbOwner.Properties do
  begin
    DropDownListStyle := lsEditList;
    ImmediateDropDown := False;
  end;
  lcbProject.Properties.DropDownListStyle := lsEditFixedList;
end;

procedure TEditorsLookupDemoMainForm.SelectStorageType(AStorageType: TcxStorageType);
begin
  cxPropertiesStore.StorageType := AStorageType;
  if cxPropertiesStore.StorageType = stIniFile then
    cxPropertiesStore.StorageName := cxPropertiesStore.Name + '.ini'
  else
    cxPropertiesStore.StorageName := cxPropertiesStore.Name;
end;

procedure TEditorsLookupDemoMainForm.StorageTypeClick(Sender: TObject);
begin
  MenuItemSetChecked(Sender, True);
  SelectStorageType(TcxStorageType((Sender as TComponent).Tag));
end;

procedure TEditorsLookupDemoMainForm.miStoreClick(Sender: TObject);
begin
  cxPropertiesStore.StoreTo;
end;

procedure TEditorsLookupDemoMainForm.miRestoreClick(Sender: TObject);
begin
  FStream.Position := 0;
  cxPropertiesStore.RestoreFrom;
end;

procedure TEditorsLookupDemoMainForm.miStorageActiveClick(Sender: TObject);
begin
  cxPropertiesStore.Active := GetMenuItemChecked(Sender);
end;

end.
