unit EditorsLookupDemoMain;

interface

{$I cxVer.inc}


uses
  {$IFDEF DELPHI6}
  Variants,
  {$ENDIF}
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs, cxControls,
  cxLookupGrid, cxLookupDBGrid, cxMaskEdit, StdCtrls, ExtCtrls, cxContainer,
  cxEdit, cxTextEdit, cxDropDownEdit, cxDBEdit, cxStyles, Menus, ActnList,
  ImgList, ShellAPI, ComCtrls, cxLookAndFeels, cxLookupEdit, cxDBLookupComboBox,
  DBCtrls, cxCustomData, cxGraphics, cxFilter, cxData, DB, cxDBData, cxClasses,
  cxCalendar, cxImageComboBox, cxMemo, cxCheckBox, cxButtons, cxNavigator,
  cxDBLookupEdit, cxStorage, cxPropertiesStore, cxDBNavigator, DemoBasicMain,
  cxLookAndFeelPainters;

type
  TEditorsLookupDemoMainForm = class(TDemoBasicMainForm)
    miStorage: TMenuItem;
    miStorageType: TMenuItem;
    miStore: TMenuItem;
    miRestore: TMenuItem;
    miIniStoreType: TMenuItem;
    miRegistryStoreType: TMenuItem;
    miMemoryStoreType: TMenuItem;
    N5: TMenuItem;
    N3: TMenuItem;
    miStoringGridLookFeel: TMenuItem;
    N6: TMenuItem;
    miStorageActive: TMenuItem;
    N1: TMenuItem;
    LookupOptions1: TMenuItem;
    miPickMode: TMenuItem;
    miStandardMode: TMenuItem;
    miEditMode: TMenuItem;
    cxPropertiesStore: TcxPropertiesStore;
    cxStorageActiveStore: TcxPropertiesStore;
    pnlEditors: TPanel;
    gbIssue: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    edName: TcxDBTextEdit;
    meDescription: TcxDBMemo;
    lcbCreator: TcxDBLookupComboBox;
    gbInfo: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    cbPriority: TcxDBImageComboBox;
    deCreateDate: TcxDBDateEdit;
    chbRequest: TcxDBCheckBox;
    gbStatus: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    cbStatus: TcxDBImageComboBox;
    deLastModifiedDate: TcxDBDateEdit;
    deFixedDate: TcxDBDateEdit;
    DBNavigator: TcxDBNavigator;
    gbProject: TGroupBox;
    Label8: TLabel;
    Label10: TLabel;
    lcbProject: TcxDBLookupComboBox;
    lcbOwner: TcxDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChangeLookupModeClick(Sender: TObject);
    procedure lcbCreatorNewLookupDisplayText(Sender: TObject;
      const AText: TCaption);
    procedure miStoreClick(Sender: TObject);
    procedure miRestoreClick(Sender: TObject);
    procedure miStoringGridLookFeelClick(Sender: TObject);
    procedure miStorageActiveClick(Sender: TObject);
    procedure StorageTypeClick(Sender: TObject);
  private
    FStream: TMemoryStream;
    procedure SetPickLookupMode;
    procedure SetStandardLookupMode;
    procedure SetEditLookupMode;
  protected
    procedure SetDefaultLookAndFeel; override;
  end;

var
  EditorsLookupDemoMainForm: TEditorsLookupDemoMainForm;

implementation

uses EditorsLookupDemoData, EditorsLookupDemoNewUser, SysUtils;

{$R *.dfm}

procedure TEditorsLookupDemoMainForm.FormCreate(Sender: TObject);
begin
  inherited;
  FStream := TMemoryStream.Create;
  cxPropertiesStore.StorageStream := FStream;
  miStoringGridLookFeel.Checked := True;
  miStoringGridLookFeelClick(miStoringGridLookFeel);
end;

procedure TEditorsLookupDemoMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FStream);
end;

procedure TEditorsLookupDemoMainForm.FormShow(Sender: TObject);
begin
{ remove/add the closing brace on this line to disable/enable the following code

  ShowMessage('WARNING: tutorial not completed. First, please apply the steps '+
              'shown in the EditorsLookupDemo.doc file');

//}
end;

procedure TEditorsLookupDemoMainForm.lcbCreatorNewLookupDisplayText(
  Sender: TObject; const AText: TCaption);
var
  ALookupControl: TcxDBLookupComboBox;
begin
{ remove/add the closing brace on this line to disable/enable the following code}

  ALookupControl := TcxDBLookupComboBox(Sender);
  ALookupControl.Reset;
  if (EditorsLookupDemoNewUserForm.ShowEX(AText) = mrOK) then
  begin
    ALookupControl.Text := EditorsLookupDemoDataDM.tblUsersUserName.AsString;
    ALookupControl.DataBinding.Field.Value :=
      EditorsLookupDemoDataDM.tblUsersID.Value;
  end;
  Abort;

//}
end;

procedure TEditorsLookupDemoMainForm.ChangeLookupModeClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := True;
  case TMenuItem(Sender).Tag of
    1: SetPickLookupMode;
    2: SetStandardLookupMode;
    3: SetEditLookupMode;
  end
end;


procedure TEditorsLookupDemoMainForm.SetDefaultLookAndFeel;
begin
  //
end;

procedure TEditorsLookupDemoMainForm.SetPickLookupMode;
begin
{ remove/add the closing brace on this line to disable/enable the following code}

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

//}
end;

procedure TEditorsLookupDemoMainForm.SetStandardLookupMode;
begin
{ remove/add the closing brace on this line to disable/enable the following code}

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

//}
end;

procedure TEditorsLookupDemoMainForm.SetEditLookupMode;
begin
{ remove/add the closing brace on this line to disable/enable the following code}

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

//}
end;

procedure TEditorsLookupDemoMainForm.StorageTypeClick(Sender: TObject);
begin
{ remove/add the closing brace on this line to disable/enable the following code}

  TMenuItem(Sender).Checked := True;
  TMenuItem(Sender).Parent.Tag := TMenuItem(Sender).Tag;
  cxPropertiesStore.StorageType := TcxStorageType(TMenuItem(Sender).Tag);
  if TMenuItem(Sender).Tag = 0 then
    cxPropertiesStore.StorageName := cxPropertiesStore.Name + '.ini'
  else
    cxPropertiesStore.StorageName := cxPropertiesStore.Name;

//}
end;

procedure TEditorsLookupDemoMainForm.miStoreClick(Sender: TObject);
begin
{ remove/add the closing brace on this line to disable/enable the following code}

  cxPropertiesStore.StoreTo;

//}
end;

procedure TEditorsLookupDemoMainForm.miRestoreClick(Sender: TObject);
begin
{ remove/add the closing brace on this line to disable/enable the following code}

  FStream.Position := 0;
  cxPropertiesStore.RestoreFrom;

//}
end;

procedure TEditorsLookupDemoMainForm.miStoringGridLookFeelClick(
  Sender: TObject);
var
 AIndex: Integer;

  function IndexOfPropertiesStoreComponent(AComponent: TComponent): Integer;
  begin
    for Result := 0 to cxPropertiesStore.Components.Count - 1 do
      if cxPropertiesStore.Components[Result].Component = AComponent then
        Exit;
    Result := -1;
  end;

  procedure AddMenuItemStoreComponent(AItem: TComponent);
  begin
    AIndex := IndexOfPropertiesStoreComponent(AItem);
    if AIndex > -1 then
      cxPropertiesStore.Components[AIndex].Properties.Add('Checked')
    else
      with TcxPropertiesStoreComponent(cxPropertiesStore.Components.Add) do
      begin
        Component := AItem;
        Properties.Add('Checked');
      end;
  end;

  function GetLookAndFeelMenuItem: TMenuItem;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to miOptions.Count - 1 do
      if miOptions.Items[I].Caption = '&Look&&Feel' then
      begin
        Result := miOptions.Items[I];
        Break;
      end;
  end;

var
  ALookAndFeelMenuItem: TMenuItem;
  I: Integer;
begin
{ remove/add the closing brace on this line to disable/enable the following code}

  AIndex := IndexOfPropertiesStoreComponent(cxLookAndFeelController);
  ALookAndFeelMenuItem := GetLookAndFeelMenuItem;
  if TMenuItem(Sender).Checked then
  begin
    if AIndex > -1 then
    begin
      cxPropertiesStore.Components[AIndex].Properties.Add('NativeStyle');
      cxPropertiesStore.Components[AIndex].Properties.Add('Kind');
    end
    else
      with TcxPropertiesStoreComponent(cxPropertiesStore.Components.Add) do
      begin
        Component := cxLookAndFeelController;
        Properties.Add('NativeStyle');
        Properties.Add('Kind');
      end;
    for I := 0 to ALookAndFeelMenuItem.Count - 1 do
      AddMenuItemStoreComponent(ALookAndFeelMenuItem[I]);
  end
  else
    if AIndex > -1 then
    begin
      cxPropertiesStore.Components[AIndex].Free;
      for I := 0 to ALookAndFeelMenuItem.Count - 1 do
      begin
        AIndex := IndexOfPropertiesStoreComponent(ALookAndFeelMenuItem[I]);
        cxPropertiesStore.Components[AIndex].Free;
      end;
    end; 

//}
end;

procedure TEditorsLookupDemoMainForm.miStorageActiveClick(
  Sender: TObject);
begin
{ remove/add the closing brace on this line to disable/enable the following code}

  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  cxPropertiesStore.Active := TMenuItem(Sender).Checked;
  miStoringGridLookFeel.Enabled := TMenuItem(Sender).Checked;

//}
end;

end.