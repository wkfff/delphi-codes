unit uHtmlDocRegistry;

interface

type

  HtmlDocRegistryValues = record
    data : string;
    doc : string;
  end;

  THtmlDocRegistry = class
   private
    UnRegisterHtmlDocPathNeedRestore : boolean;
    SavedValues : HtmlDocRegistryValues;
   public
    procedure RegisterHtmlDocPath(const BasePathToHtmlDoc : string);
    procedure UnRegisterHtmlDocPath;
  end;

implementation

uses
  Registry, Windows, SysUtils;

const
  HTMLDOC_KEY = '\SOFTWARE\Easy Software Products\HTMLDOC';
  HTMLDOC_VALUE_DATA = 'data';
  HTMLDOC_VALUE_DOC = 'doc';

procedure THtmlDocRegistry.RegisterHtmlDocPath(const BasePathToHtmlDoc : string);
var
  Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  // Backup old regitry ?
  UnRegisterHtmlDocPathNeedRestore := Reg.KeyExists(HTMLDOC_KEY);
  if(UnRegisterHtmlDocPathNeedRestore) then
  begin
    // save old key
    SavedValues.data := Reg.ReadString(HTMLDOC_VALUE_DATA);
    SavedValues.doc := Reg.ReadString(HTMLDOC_VALUE_DOC);
    // Delete old key
    Reg.DeleteKey(HTMLDOC_KEY);
  end;
  //Reg.Access
  // Write new key
  Reg.OpenKey(HTMLDOC_KEY, True);
  Reg.WriteString(HTMLDOC_VALUE_DATA, BasePathToHtmlDoc);
  Reg.WriteString(HTMLDOC_VALUE_DOC, BasePathToHtmlDoc + '\' + HTMLDOC_VALUE_DOC);
  FreeAndNil(Reg);
end;

procedure THtmlDocRegistry.UnRegisterHtmlDocPath;
var
  Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  // Restore old registry ?
  // Delete old key
  Reg.DeleteKey(HTMLDOC_KEY);
  if(UnRegisterHtmlDocPathNeedRestore) then
  begin
    Reg.OpenKey(HTMLDOC_KEY, True);
    Reg.WriteString(HTMLDOC_VALUE_DATA, SavedValues.data);
    Reg.WriteString(HTMLDOC_VALUE_DOC, SavedValues.doc);
  end;
  FreeAndNil(Reg);
end;

end.
