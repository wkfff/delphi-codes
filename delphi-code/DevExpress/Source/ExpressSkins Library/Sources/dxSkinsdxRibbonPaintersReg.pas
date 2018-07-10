{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{                    ExpressSkins Library                            }
{                                                                    }
{       Copyright (c) 2006-2011 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSSKINS AND ALL ACCOMPANYING     }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit dxSkinsdxRibbonPaintersReg;

{$I cxVer.inc}

interface

uses
  Classes, DesignIntf, dxSkinsReg, dxSkinsDesignHelperReg,
  dxRibbon, dxRibbonReg, dxBarSkin, dxSkinsdxRibbonPainter;

type
  { TdxSkinsdxRibbonColorSchemeNameProperty }

  TdxSkinsdxRibbonColorSchemeNameProperty = class(TdxRibbonColorSchemeNameProperty)
  protected
    function CanAddSkin(ASkin: TdxCustomBarSkin): Boolean; override;
  end;

procedure Register;

implementation

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}
  RegisterPropertyEditor(TypeInfo(string), TdxCustomRibbon,
    'ColorSchemeName', TdxSkinsdxRibbonColorSchemeNameProperty);
end;

{ TdxSkinsdxRibbonColorSchemeNameProperty }

function TdxSkinsdxRibbonColorSchemeNameProperty.CanAddSkin(ASkin: TdxCustomBarSkin): Boolean;
begin
  Result := inherited CanAddSkin(ASkin);
  if Result and (ASkin is TdxSkinRibbonPainter) then
    Result := dxSkinListCanUseSkin(ASkin.DisplayName);
end;

initialization
  dxSkinsAdditionalUnits.Add(TdxCustomRibbon, 'dxSkinsdxRibbonPainter');

finalization
  dxSkinsAdditionalUnits.Remove(TdxCustomRibbon, 'dxSkinsdxRibbonPainter');
end.
