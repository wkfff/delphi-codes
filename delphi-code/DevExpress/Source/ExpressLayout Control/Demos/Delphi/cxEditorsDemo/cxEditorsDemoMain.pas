unit cxEditorsDemoMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxLayoutControl, cxControls, StdCtrls, cxLookAndFeels,
  dxLayoutLookAndFeels, ExtCtrls, Menus, DB, DBTables, DemoDM,
  dxLayoutControlAdapters, DBCtrls, Mask, Grids, DBGrids, BasicDemoMain,
  cxGraphics, cxCurrencyEdit, cxDBEdit, cxCalc, cxDropDownEdit, cxSpinEdit,
  cxTimeEdit, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxCalendar,
  cxCheckBox, cxHyperLinkEdit, cxMemo, cxImage, cxNavigator, cxDBNavigator,
  dxLayoutcxEditAdapters, ImgList, ActnList, cxLookAndFeelPainters,
  dxLayoutContainer;

type
  TfrmEditorsDemoMain = class(TfrmBasicDemoMain)
    cxDBDateEdit1: TcxDBDateEdit;
    cxDBTimeEdit1: TcxDBTimeEdit;
    cxDBComboBox1: TcxDBComboBox;
    cxDBCalcEdit1: TcxDBCalcEdit;
    cxDBCurrencyEdit1: TcxDBCurrencyEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit3: TcxDBTextEdit;
    cxDBTextEdit4: TcxDBTextEdit;
    cxDBTextEdit5: TcxDBTextEdit;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBTextEdit6: TcxDBTextEdit;
    cxDBTextEdit7: TcxDBTextEdit;
    cxDBTextEdit8: TcxDBTextEdit;
    cxDBTextEdit9: TcxDBTextEdit;
    cxDBMaskEdit1: TcxDBMaskEdit;
    cxDBTextEdit10: TcxDBTextEdit;
    cxDBMaskEdit2: TcxDBMaskEdit;
    cxDBMaskEdit3: TcxDBMaskEdit;
    cxDBHyperLinkEdit1: TcxDBHyperLinkEdit;
    cxDBTextEdit12: TcxDBTextEdit;
    cxDBTextEdit11: TcxDBTextEdit;
    cxDBHyperLinkEdit2: TcxDBHyperLinkEdit;
    cxDBCurrencyEdit2: TcxDBCurrencyEdit;
    cxDBSpinEdit1: TcxDBSpinEdit;
    cxDBSpinEdit2: TcxDBSpinEdit;
    cxDBSpinEdit3: TcxDBSpinEdit;
    cxDBSpinEdit4: TcxDBSpinEdit;
    cxDBSpinEdit5: TcxDBSpinEdit;
    cxDBSpinEdit6: TcxDBSpinEdit;
    cxDBCheckBox2: TcxDBCheckBox;
    cxDBImage1: TcxDBImage;
    cxDBMemo1: TcxDBMemo;
    cxDBNavigator1: TcxDBNavigator;
    cxImageList1: TcxImageList;
    lcMainGroup1: TdxLayoutGroup;
    lcMainGroup2: TdxLayoutGroup;
    lcMainGroup3: TdxLayoutGroup;
    lcMainGroup4: TdxLayoutGroup;
    lcMainGroup5: TdxLayoutGroup;
    lcMainGroup6: TdxLayoutGroup;
    lcMainGroup7: TdxLayoutGroup;
    lcMainGroup8: TdxLayoutGroup;
    lcMainGroup13: TdxLayoutGroup;
    lcMainGroup14: TdxLayoutGroup;
    lcMainGroup15: TdxLayoutGroup;
    lcMainGroup16: TdxLayoutGroup;
    lcMainGroup17: TdxLayoutGroup;
    lcMainGroup10: TdxLayoutGroup;
    lcMainGroup18: TdxLayoutGroup;
    lcMainItem1: TdxLayoutItem;
    lcMainItem2: TdxLayoutItem;
    lcMainItem3: TdxLayoutItem;
    lcMainItem4: TdxLayoutItem;
    lcMainItem5: TdxLayoutItem;
    lcMainItem6: TdxLayoutItem;
    lcMainItem7: TdxLayoutItem;
    lcMainItem8: TdxLayoutItem;
    lcMainItem9: TdxLayoutItem;
    lcMainItem10: TdxLayoutItem;
    lcMainItem11: TdxLayoutItem;
    lcMainItem12: TdxLayoutItem;
    lcMainItem13: TdxLayoutItem;
    lcMainItem14: TdxLayoutItem;
    lcMainItem15: TdxLayoutItem;
    lcMainItem16: TdxLayoutItem;
    lcMainItem17: TdxLayoutItem;
    lcMainItem18: TdxLayoutItem;
    lcMainItem19: TdxLayoutItem;
    lcMainItem20: TdxLayoutItem;
    lcMainItem21: TdxLayoutItem;
    lcMainItem22: TdxLayoutItem;
    lcMainItem23: TdxLayoutItem;
    lcMainItem24: TdxLayoutItem;
    lcMainItem25: TdxLayoutItem;
    lcMainItem26: TdxLayoutItem;
    lcMainItem27: TdxLayoutItem;
    lcMainItem28: TdxLayoutItem;
    lcMainItem29: TdxLayoutItem;
    lcMainItem30: TdxLayoutItem;
    lcMainItem31: TdxLayoutItem;
    lcMainItem32: TdxLayoutItem;
    lcMainItem33: TdxLayoutItem;
    lcMainItem34: TdxLayoutItem;
    lcMainSplitterItem1: TdxLayoutSplitterItem;
    lcMainSeparatorItem1: TdxLayoutSeparatorItem;
    lcMainSplitterItem2: TdxLayoutSplitterItem;
    lcMainSeparatorItem2: TdxLayoutSeparatorItem;
    procedure lcMainGroup1Button0Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  frmEditorsDemoMain: TfrmEditorsDemoMain;

implementation

{$R *.dfm}

procedure TfrmEditorsDemoMain.lcMainGroup1Button0Click(Sender: TObject);
begin
  inherited;
  lcMainGroup1.Parent := nil;
end;

end.
