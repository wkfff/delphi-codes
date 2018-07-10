{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2011 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPSfmStlAdd;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxPSForm, dxPgsDlg, Menus, cxLookAndFeelPainters, cxButtons,
  cxControls, cxContainer, cxEdit, cxGroupBox, cxGraphics, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLabel, cxLookAndFeels;

type
  TdxfmSelectStyleClass = class(TCustomdxPSForm)
    btnOK: TcxButton;
    btnCancel: TcxButton;
    btnHelp: TcxButton;
    GroupBox1: TcxGroupBox;
    cbxStyleTypes: TcxComboBox;
    Label1: TcxLabel;
    procedure Label1Click(Sender: TObject);
    procedure cbxStyleTypesChange(Sender: TObject);
  private
    FStyleClass: TdxPrintStyleClass;
    procedure RefreshList;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute(const Pt: TPoint): TdxPrintStyleClass;
  end;

function dxSelectStyleClass(const Pt: TPoint): TdxPrintStyleClass;

implementation

{$R *.DFM}

uses
  dxPSGlbl;

function dxSelectStyleClass(const Pt: TPoint): TdxPrintStyleClass;
begin
  with TdxfmSelectStyleClass.Create(nil) do
  try
    Result := Execute(Pt);
  finally
    Free;
  end;
end;

{ TdxfmAddNewPrintStyle }

constructor TdxfmSelectStyleClass.Create(AOwner: TComponent);
begin
  inherited;
  HelpContext := dxPSGlbl.dxhcAddStyleDlg;
  btnHelp.Visible := HelpContext <> 0;
  if not btnHelp.Visible then
  begin
    btnOK.BoundsRect := btnCancel.BoundsRect;
    btnCancel.BoundsRect := btnHelp.BoundsRect;
  end;
  FStyleClass := nil;
  RefreshList;
end;

procedure TdxfmSelectStyleClass.RefreshList;
var
  SaveCursor: TCursor;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    with cbxStyleTypes.Properties do
    begin
      Items.BeginUpdate;
      try
        Items.Clear;
        dxPSGetRegisteredPrintStylesList(Items);
      finally
        Items.EndUpdate;
      end;
      if Items.Count <> 0 then
      begin
        cbxStyleTypes.ItemIndex := Items.IndexOfObject(TObject(dxPgsDlg.dxDefaultPrintStyleClass));
        if cbxStyleTypes.ItemIndex = -1 then
          cbxStyleTypes.ItemIndex := 0;
        cbxStyleTypesChange(nil);
      end;
    end;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

function TdxfmSelectStyleClass.Execute(const Pt: TPoint): TdxPrintStyleClass;
begin
  if (Pt.X = MaxInt) and (Pt.Y = MaxInt) then
    Position := poScreenCenter
  else
  begin
    Position := poDesigned;
    Left := Pt.X;
    Top := Pt.Y;
  end;
  
  if ShowModal = mrOK then
    Result := FStyleClass
  else
    Result := nil;
end;

procedure TdxfmSelectStyleClass.Label1Click(Sender: TObject);
begin
  ActiveControl := TcxLabel(Sender).FocusControl;
  if TcxComboBox(ActiveControl).Properties.DropDownListStyle = lsFixedList then
    TcxComboBox(ActiveControl).DroppedDown := True;
end;                                

procedure TdxfmSelectStyleClass.cbxStyleTypesChange(Sender: TObject);
begin
  with cbxStyleTypes do
    FStyleClass := TdxPrintStyleClass(Properties.Items.Objects[ItemIndex]);
end;

end.
