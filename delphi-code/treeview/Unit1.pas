unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GSPMultiViewLinker, StdCtrls, ComCtrls, RichTreeView, GSPControls,
  GSPEngineUtils, GSPInterface;

type
  TForm1 = class(TForm)
    tv1: TGSPTreeView;
    btn1: TButton;
    RichTreeView1: TRichTreeView;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RichTreeView1StateChanged(Sender: TObject; Node: TTreeNode);
  private
    FViewLinker: TGSPMultiViewLinker;
    FGSPModel: IGSPModel;
    procedure BuildTree;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

const
  CFileName = 'E:\Projdata.GSP';

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  BuildTree;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  oNode, oNode1: TTreeNode;
begin
  FViewLinker := TGSPMultiViewLinker.Create();
//  RichTreeView1.Auto3DCheck := True;
  oNode := RichTreeView1.TopItem;
  oNode := RichTreeView1.Items.Add(oNode, 'a');
  oNode1 := RichTreeView1.Items.AddChild(oNode, 'a1');
  oNode1 := RichTreeView1.Items.Add(oNode1, 'a2');
  oNode := RichTreeView1.Items.Add(oNode, 'b');
  oNode := RichTreeView1.Items.Add(oNode, 'c');
end;

{ TForm1 }

procedure TForm1.BuildTree;
var
  iModel: IGSPModel;
  oView: IGSPView;
begin
  iModel := GSPEngine().CreateModel();
  GSPEngine().CreateModelXMLReader().Read(CFileName, iModel);

  oView := iModel.FindTable('Business', 'WorkQty').CreateView();

  tv1.UnBind;
  FViewLinker.BindView([oView]);

  tv1.BindView(FViewLinker, ['Description']);

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FViewLinker.Free;
end;

procedure TForm1.RichTreeView1StateChanged(Sender: TObject; Node: TTreeNode);
begin
  if   TRichTreeNode(Node).CheckState = rcChecked then
  begin
//    TRichTreeNode(Node).CheckState := rcChecked;
    TRichTreeNode(Node).Selected := True;
  end
  else if   TRichTreeNode(Node).CheckState = rcUnchecked then
  begin
//    TRichTreeNode(Node).CheckState := rcchecked;
    TRichTreeNode(Node).Selected := False;
  end;


end;

end.
