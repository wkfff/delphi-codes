unit Config;

interface

uses
  Classes, SysUtils, IniFiles, Forms, Windows;

const
  csIniRefSection = 'Ref';
  csIniNewSection = 'New';

  {Section: Ref}
  csIniRefRefFiles = 'RefFiles';

  {Section: New}
  csIniNewNewFiles = 'NewFiles';

type
  TIniOptions = class(TObject)
  private
    {Section: Ref}
    FRefRefFiles: string;

    {Section: New}
    FNewNewFiles: string;
  public
    procedure LoadSettings(Ini: TIniFile);
    procedure SaveSettings(Ini: TIniFile);
    
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);

    {Section: Ref}
    property RefRefFiles: string read FRefRefFiles write FRefRefFiles;

    {Section: New}
    property NewNewFiles: string read FNewNewFiles write FNewNewFiles;
  end;

var
  IniOptions: TIniOptions = nil;

implementation

procedure TIniOptions.LoadSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: Ref}
    FRefRefFiles := Ini.ReadString(csIniRefSection, csIniRefRefFiles, '');

    {Section: New}
    FNewNewFiles := Ini.ReadString(csIniNewSection, csIniNewNewFiles, '');
  end;
end;

procedure TIniOptions.SaveSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: Ref}
    Ini.WriteString(csIniRefSection, csIniRefRefFiles, FRefRefFiles);

    {Section: New}
    Ini.WriteString(csIniNewSection, csIniNewNewFiles, FNewNewFiles);
  end;
end;

procedure TIniOptions.LoadFromFile(const FileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  try
    LoadSettings(Ini);
  finally
    Ini.Free;
  end;
end;

procedure TIniOptions.SaveToFile(const FileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  try
    SaveSettings(Ini);
  finally
    Ini.Free;
  end;
end;

initialization
  IniOptions := TIniOptions.Create;

finalization
  IniOptions.Free;

end.

