unit DesignBar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,DesignWindows, StdCtrls,NavBar, ComCtrls, Menus, Buttons;

type
  TFrmDesignBar = class(TDesignWindow)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    TreeView1: TTreeView;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure TreeView1Edited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure FormShow(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private

    function FindName(AName:string):Boolean;
    function GetGroupName:string;
    function GetItemName:string;
    procedure AddGroup;
    procedure AddItem;
    procedure DeleteNode;
    procedure LoadTree;
  public
    NavBar:TmrNavBar;
  end;

var
  FrmDesignBar: TFrmDesignBar;

implementation

{$R *.dfm}


procedure TFrmDesignBar.AddGroup;
var
  Node:TTreeNode;
  Group:TNavGroup;
begin
  Node := TreeView1.Items.AddChild(nil,GetGroupName);
  Group := NavBar.NavGroups.Add;
  Group.Name := Node.Text;
  Group.Text := Node.Text;
  Node.Data := Group;
  Self.Designer.Modified;
end;

procedure TFrmDesignBar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  NavBar.Invalidate;
end;

procedure TFrmDesignBar.LoadTree;
var
  i,j:Integer;
  Node,SubNode:TTreeNode;
begin
  TreeView1.Items.Clear;
  with NavBar do
  for i := 0 to NavGroups.Count -1 do
  begin
    Node := TreeView1.Items.AddChild(nil,NavGroups.NavGroups[i].Text);
    Node.Data := NavGroups.NavGroups[i];
    for j := 0 to NavGroups.NavGroups[i].Count - 1 do
    begin
      SubNode := TreeView1.Items.AddChild(Node,NavGroups.NavGroups[i].NavItems[j].Text);
      SubNode.Data := NavGroups.NavGroups[i].NavItems[j];
    end;
  end;
end;

procedure TFrmDesignBar.N1Click(Sender: TObject);
begin
  AddGroup;
end;

procedure TFrmDesignBar.TreeView1Edited(Sender: TObject; Node: TTreeNode;
  var S: String);
begin
  TNavGroup(Node.Data).Text := S;
end;

procedure TFrmDesignBar.FormShow(Sender: TObject);
begin
  LoadTree;
end;

procedure TFrmDesignBar.AddItem;
var
  NavItem:TNavItem;
  Node:TTreeNode;
begin
  if TreeView1.Selected <> nil then
  begin
    if TreeView1.Selected.Level = 0 then
    begin
      Node := TreeView1.Items.AddChild(TreeView1.Selected,GetItemName);
      NavItem := TNavGroup(TreeView1.Selected.Data).Add;
      NavItem.Name := Node.Text;
      NavItem.Text := Node.Text;
      Node.Data := NavItem;
      Self.Designer.Modified;
    end
    else
    begin
      ShowMessage('ÇëÑ¡Ôñ·Ö×é');  
    end;
  end;
end;

procedure TFrmDesignBar.N2Click(Sender: TObject);
begin
  AddItem;
end;

procedure TFrmDesignBar.TreeView1Click(Sender: TObject);
begin
  if TreeView1.Selected <> nil then
  begin
    Designer.SelectComponent(TPersistent(TreeView1.Selected.Data));
  end;
  
end;

function TFrmDesignBar.GetGroupName: string;
var
  i:Integer;
begin
  i := 1;
  Result := TNavGroup.ClassName + IntToStr(i);
  while FindName(Result) do
  begin
    Inc(i);
    Result := TNavGroup.ClassName + IntToStr(i);
  end;
end;

function TFrmDesignBar.GetItemName: string;
var
  i:Integer;
begin
  i := 1;
  Result := TNavItem.ClassName + IntToStr(i);
  while FindName(Result) do
  begin
    Inc(i);
    Result := TNavItem.ClassName + IntToStr(i);
  end;
end;

function TFrmDesignBar.FindName(AName: string): Boolean;
var
  i:Integer;
begin
  Result := False;
  for i:= 0 to TreeView1.Items.Count - 1 do
  begin
    if TreeView1.Items[i].Text = AName then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TFrmDesignBar.DeleteNode;
begin
  if TreeView1.Selected <> nil then
  begin
    if TreeView1.Selected.Level = 0 then
    begin
      NavBar.NavGroups.Delete(TNavGroup(TreeView1.Selected.Data));
    end
    else
    begin
      TNavGroup(TreeView1.Selected.Parent.Data).Delete(TNavItem(TreeView1.Selected.Data));
    end;
    TreeView1.Selected.Delete;
    Designer.Modified;
  end;
end;

procedure TFrmDesignBar.N3Click(Sender: TObject);
begin
  DeleteNode;
end;

procedure TFrmDesignBar.SpeedButton1Click(Sender: TObject);
begin
  AddGroup;
end;

procedure TFrmDesignBar.SpeedButton2Click(Sender: TObject);
begin
  AddItem;
end;

procedure TFrmDesignBar.SpeedButton3Click(Sender: TObject);
begin
  DeleteNode;
end;

end.
