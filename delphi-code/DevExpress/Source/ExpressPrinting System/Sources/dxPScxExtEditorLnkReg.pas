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

unit dxPScxExtEditorLnkReg;

interface

{$I cxVer.inc}

procedure Register;
  
implementation

uses
  DesignIntf, DesignEditors, Classes, cxMCListBox, cxCheckListBox,
  cxListView, cxTreeView,
  cxRichEdit, cxDBRichEdit,
{$IFDEF REGISTERCXSHELLCTRLS}
  cxShellTreeView, cxShellListView,
{$ENDIF}
  dxPScxMCListBoxLnk, dxPScxCheckListBoxLnk, dxPScxExtComCtrlsLnk, dxPSReg;

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}  

  RegisterNoIcon([TcxMCListBoxReportLink, TcxCheckListBoxReportLink]);
  dxPSRegisterReportLinkUnit('dxPScxExtComCtrlsLnk', TcxTreeViewReportLink);
  dxPSRegisterReportLinkUnit('dxPScxExtComCtrlsLnk', TcxListViewReportLink);
  dxPSRegisterReportLinkUnit('dxPScxCheckListBoxLnk', TcxCheckListBoxReportLink);
  dxPSRegisterReportLinkUnit('dxPScxMCListBoxLnk', TcxMCListBoxReportLink);
  RegisterNoIcon([TcxRichEditReportLink]);
  dxPSRegisterReportLinkUnit('dxPScxExtComCtrlsLnk', TcxRichEditReportLink);
  RegisterNoIcon([TcxTreeViewReportLink, TcxListViewReportLink]);
{$IFDEF REGISTERCXSHELLCTRLS}
  RegisterNoIcon([TcxShellListViewReportLink, TcxShellTreeViewReportLink]);
  dxPSRegisterReportLinkUnit('dxPScxExtComCtrlsLnk', TcxShellListViewReportLink);
  dxPSRegisterReportLinkUnit('dxPScxExtComCtrlsLnk', TcxShellTreeViewReportLink);
{$ENDIF}
end;

end.
