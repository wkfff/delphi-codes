unit IniOptionsTest;

interface

uses
  Classes, SysUtils, IniFiles, Forms, Windows;

const
  csIniSQLServerSection = 'SQLServer';
  csIniBJSection = 'BJ';
  csIniXASection = 'XA';

  {Section: SQLServer}
  csIniSQLServerServer = 'Server';
  csIniSQLServerUID = 'UID';
  csIniSQLServerPWD = 'PWD';
  csIniSQLServerAuthentication = 'Authentication';
  csIniSQLServerBJDB = 'BJDB';
  csIniSQLServerXADB = 'XADB';
  csIniSQLServerFBJDB = 'FBJDB';
  csIniSQLServerFXADB = 'FXADB';

  {Section: BJ}
  csIniBJYear = 'Year';
  csIniBJMrktPriceDir = 'MrktPriceDir';
  csIniBJInfoPriceJDir = 'InfoPriceJDir';
  csIniBJPriceRef = 'PriceRef';

  {Section: XA}
  csIniXAYear = 'Year';
  csIniXAMrktPriceDir = 'MrktPriceDir';
  csIniXAInfoPriceJDir = 'InfoPriceJDir';
  csIniXAPriceRef = 'PriceRef';

type
  TIniOptions = class(TObject)
  private
    {Section: SQLServer}
    FSQLServerServer: string;
    FSQLServerUID: string;
    FSQLServerPWD: string;
    FSQLServerAuthentication: string;
    FSQLServerBJDB: string;
    FSQLServerXADB: string;
    FSQLServerFBJDB: string;
    FSQLServerFXADB: string;

    {Section: BJ}
    FBJYear: Integer;
    FBJMrktPriceDir: string;
    FBJInfoPriceJDir: string;
    FBJPriceRef: string;

    {Section: XA}
    FXAYear: Integer;
    FXAMrktPriceDir: string;
    FXAInfoPriceJDir: string;
    FXAPriceRef: string;
  public
    procedure LoadSettings(Ini: TIniFile);
    procedure SaveSettings(Ini: TIniFile);
    
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);

    {Section: SQLServer}
    property SQLServerServer: string read FSQLServerServer write FSQLServerServer;
    property SQLServerUID: string read FSQLServerUID write FSQLServerUID;
    property SQLServerPWD: string read FSQLServerPWD write FSQLServerPWD;
    property SQLServerAuthentication: string read FSQLServerAuthentication write FSQLServerAuthentication;
    property SQLServerBJDB: string read FSQLServerBJDB write FSQLServerBJDB;
    property SQLServerXADB: string read FSQLServerXADB write FSQLServerXADB;
    property SQLServerFBJDB: string read FSQLServerFBJDB write FSQLServerFBJDB;
    property SQLServerFXADB: string read FSQLServerFXADB write FSQLServerFXADB;

    {Section: BJ}
    property BJYear: Integer read FBJYear write FBJYear;
    property BJMrktPriceDir: string read FBJMrktPriceDir write FBJMrktPriceDir;
    property BJInfoPriceJDir: string read FBJInfoPriceJDir write FBJInfoPriceJDir;
    property BJPriceRef: string read FBJPriceRef write FBJPriceRef;

    {Section: XA}
    property XAYear: Integer read FXAYear write FXAYear;
    property XAMrktPriceDir: string read FXAMrktPriceDir write FXAMrktPriceDir;
    property XAInfoPriceJDir: string read FXAInfoPriceJDir write FXAInfoPriceJDir;
    property XAPriceRef: string read FXAPriceRef write FXAPriceRef;
  end;

var
  IniOptions: TIniOptions = nil;

implementation

procedure TIniOptions.LoadSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: SQLServer}
    FSQLServerServer := Ini.ReadString(csIniSQLServerSection, csIniSQLServerServer, 'LiuL-A');
    FSQLServerUID := Ini.ReadString(csIniSQLServerSection, csIniSQLServerUID, 'sa');
    FSQLServerPWD := Ini.ReadString(csIniSQLServerSection, csIniSQLServerPWD, '123qwe!@#');
    FSQLServerAuthentication := Ini.ReadString(csIniSQLServerSection, csIniSQLServerAuthentication, 'SQLServer身份认证');
    FSQLServerBJDB := Ini.ReadString(csIniSQLServerSection, csIniSQLServerBJDB, 'bjgcj');
    FSQLServerXADB := Ini.ReadString(csIniSQLServerSection, csIniSQLServerXADB, 'gcjtemp');
    FSQLServerFBJDB := Ini.ReadString(csIniSQLServerSection, csIniSQLServerFBJDB, '');
    FSQLServerFXADB := Ini.ReadString(csIniSQLServerSection, csIniSQLServerFXADB, 'gcjtemp');

    {Section: BJ}
    FBJYear := Ini.ReadInteger(csIniBJSection, csIniBJYear, 2010);
    FBJMrktPriceDir := Ini.ReadString(csIniBJSection, csIniBJMrktPriceDir, '..\data\市场价\北京');
    FBJInfoPriceJDir := Ini.ReadString(csIniBJSection, csIniBJInfoPriceJDir, '..\data\信息价\北京');
    FBJPriceRef := Ini.ReadString(csIniBJSection, csIniBJPriceRef, '..\data\市场价\北京地区市场参考价.dat');

    {Section: XA}
    FXAYear := Ini.ReadInteger(csIniXASection, csIniXAYear, 2010);
    FXAMrktPriceDir := Ini.ReadString(csIniXASection, csIniXAMrktPriceDir, '..\data\市场价\bj地区市场参考价.dat');
    FXAInfoPriceJDir := Ini.ReadString(csIniXASection, csIniXAInfoPriceJDir, 'E:\GCPT\data\信息价\陕西');
    FXAPriceRef := Ini.ReadString(csIniXASection, csIniXAPriceRef, '..\data\市场价\西安地区市场参考价.dat');
  end;
end;

procedure TIniOptions.SaveSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: SQLServer}
    Ini.WriteString(csIniSQLServerSection, csIniSQLServerServer, FSQLServerServer);
    Ini.WriteString(csIniSQLServerSection, csIniSQLServerUID, FSQLServerUID);
    Ini.WriteString(csIniSQLServerSection, csIniSQLServerPWD, FSQLServerPWD);
    Ini.WriteString(csIniSQLServerSection, csIniSQLServerAuthentication, FSQLServerAuthentication);
    Ini.WriteString(csIniSQLServerSection, csIniSQLServerBJDB, FSQLServerBJDB);
    Ini.WriteString(csIniSQLServerSection, csIniSQLServerXADB, FSQLServerXADB);
    Ini.WriteString(csIniSQLServerSection, csIniSQLServerFBJDB, FSQLServerFBJDB);
    Ini.WriteString(csIniSQLServerSection, csIniSQLServerFXADB, FSQLServerFXADB);

    {Section: BJ}
    Ini.WriteInteger(csIniBJSection, csIniBJYear, FBJYear);
    Ini.WriteString(csIniBJSection, csIniBJMrktPriceDir, FBJMrktPriceDir);
    Ini.WriteString(csIniBJSection, csIniBJInfoPriceJDir, FBJInfoPriceJDir);
    Ini.WriteString(csIniBJSection, csIniBJPriceRef, FBJPriceRef);

    {Section: XA}
    Ini.WriteInteger(csIniXASection, csIniXAYear, FXAYear);
    Ini.WriteString(csIniXASection, csIniXAMrktPriceDir, FXAMrktPriceDir);
    Ini.WriteString(csIniXASection, csIniXAInfoPriceJDir, FXAInfoPriceJDir);
    Ini.WriteString(csIniXASection, csIniXAPriceRef, FXAPriceRef);
  end;
end;

procedure TIniOptions.LoadFromFile(const FileName: string);
var
  Ini: TIniFile;
begin
  if FileExists(FileName) then
  begin
    Ini := TIniFile.Create(FileName);
    try
      LoadSettings(Ini);
    finally
      Ini.Free;
    end;
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

