{*-------------------------------------------------------------------------------
  Option holder for application. Will be saved as XML file
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2008/07/03  TridenT  First revision
-------------------------------------------------------------------------------}
unit uAppSettings;

interface

uses
  SysUtils , Classes ;

type
  // Container for application settings
  TAppSettings = class(TPersistent)
  private
    FModified : boolean;  /// Are the settings newly modified ?
    FApplicationLanguage: string;  /// Language of the application (from gnugettext)
    procedure SetApplicationLanguage(const Value: string);
  protected
    function LoadFromFile(const Filename : TFilename): Boolean;
    function SaveToFile(const Filename : TFilename): Boolean;
  public
    procedure Save();
    procedure SetDefaultValue();
    constructor Create(); virtual;
  published
    property ApplicationLanguage : string read FApplicationLanguage write SetApplicationLanguage;
  end;

var
  /// Application settings variable
  AppSettings : TAppSettings;

procedure InitializeApplicationSettings();
procedure FinalizeApplicationSettings();

implementation

uses
  JvAppStorage, JvAppXMLStorage, Forms; // for Application variable

const
  /// Root node of XML file
  ST_ROOTNODE_NAME : string = 'DelphiCodeToDoc_Settings';
  /// Technical level node of XML file
  ST_TECHNICAL_LEVEL : string = 'TechnicalLevel';
  /// Classname node of XML file
  ST_CLASSNAME : string = 'Classname';
  /// Filename for application settings
  ST_APPSETTINGS_FILENAME : string ='DelphiCodeToDoc.config';

var
{*------------------------------------------------------------------------------
  Technical level of saved project's file is the compatibility level of fiels.
  When adding informations to the project file, the TL change to reflect
  an incompatibility

  TL01  : First release (XML format)
  ------------------------------------------------------------------------------*}
  C_OPTIONS_TECHNICAL_LEVEL: integer = $01;

{*------------------------------------------------------------------------------
  Initialize application storage with standard configuration
  @param XmlStorage TJvAppXMLFileStorage object to initialize
------------------------------------------------------------------------------*}
procedure InitXmlStorage(const XmlStorage : TJvAppXMLFileStorage);
begin
  XmlStorage.AutoFlush := FALSE;
  XmlStorage.AutoReload := FALSE;
  XmlStorage.StorageOptions.BooleanAsString := True;
  XmlStorage.StorageOptions.EnumerationAsString := True;
  XmlStorage.StorageOptions.AutoEncodeValue := TRUE;
  XmlStorage.RootNodeName := ST_ROOTNODE_NAME;
  XmlStorage.StorageOptions.BooleanStringTrueValues := 'TRUE';
  XmlStorage.StorageOptions.BooleanStringFalseValues := 'FALSE';
end;

/// Create a TAppSettings instance and set default value
constructor TAppSettings.Create;
begin
  SetDefaultValue();
end;

{*------------------------------------------------------------------------------
  Load application settings from a stream
  @param Filename filename to save the settings to
  @return True if sucessfully loaded file
------------------------------------------------------------------------------*}
function TAppSettings.LoadFromFile(const Filename : TFilename): Boolean;
var
  JvAppXMLFileStorage : TJvAppXMLFileStorage;
  Read_TL : integer;
  //IsProjectUpgraded : Boolean;
begin
  FModified := False; // Clear pending notification
  //IsProjectUpgraded := False;
  // Init XML option storage
  JvAppXMLFileStorage := TJvAppXMLFileStorage.Create(nil);
  InitXmlStorage(JvAppXMLFileStorage);
  JvAppXMLFileStorage.Location := flCustom;
  JvAppXMLFileStorage.FileName := Filename;
  // Update JvAppXMLFileStorage with XML file
  JvAppXMLFileStorage.Reload;

  // Check Technical Level
  Result := False;
  Read_TL := JvAppXMLFileStorage.ReadInteger(ST_TECHNICAL_LEVEL);
  if(Read_TL <> C_OPTIONS_TECHNICAL_LEVEL) then
  begin
    //IsProjectUpgraded := TRUE;
    exit; // Exit on error in Tech level not handles
  end;

  // Check the ClassName (START ID)
  Result := False;
  if JvAppXMLFileStorage.ReadString(ST_CLASSNAME) <> Self.ClassName then
  begin
    exit;
  end;

  // Load TDOCOptions properties from XML storage
  JvAppXMLFileStorage.ReadPersistent(self.ClassName,self);
  FreeAndNil(JvAppXMLFileStorage);
  Result := True;
end;

{*------------------------------------------------------------------------------
  Save application settings
------------------------------------------------------------------------------*}
procedure TAppSettings.Save;
begin
  SaveToFile(ExtractFilePath(Application.ExeName) + ST_APPSETTINGS_FILENAME);
end;

{*------------------------------------------------------------------------------
  Save application settings to a stream
  @param Filename Filename destination for settings
  @return True if successfully written the settings
------------------------------------------------------------------------------*}
function TAppSettings.SaveToFile(const Filename : TFilename): Boolean;
var
  JvAppXMLFileStorage : TJvAppXMLFileStorage;
begin
  // Init XML option storage
  JvAppXMLFileStorage := TJvAppXMLFileStorage.Create(nil);
  InitXmlStorage(JvAppXMLFileStorage);
  JvAppXMLFileStorage.Location := flCustom;
  JvAppXMLFileStorage.FileName := Filename;
  // Save infos
  JvAppXMLFileStorage.WriteInteger(ST_TECHNICAL_LEVEL,C_OPTIONS_TECHNICAL_LEVEL);
  JvAppXMLFileStorage.WriteString(ST_CLASSNAME,TAppSettings.ClassName);
  // Save TDOCOptions properties to XML storage
  JvAppXMLFileStorage.WritePersistent(self.ClassName,self);
  JvAppXMLFileStorage.Flush;
  FreeAndNil(JvAppXMLFileStorage);
  Result := True;
end;

{*------------------------------------------------------------------------------
  Set language of application
  @param Value   string representing the language used
------------------------------------------------------------------------------*}
procedure TAppSettings.SetApplicationLanguage(const Value: string);
begin
  FModified := True;
  FApplicationLanguage := Value;
end;

/// Set default value ie. ENGLISH language
procedure TAppSettings.SetDefaultValue;
begin
  FApplicationLanguage := 'en';
end;

/// Initialize application settings and load if a config file exists
procedure InitializeApplicationSettings();
var
  fn : string;
begin
  AppSettings := TAppSettings.Create();
  fn := ExtractFilePath(Application.ExeName) + ST_APPSETTINGS_FILENAME;
  if(FileExists(fn)) then
  begin
    AppSettings.LoadFromFile(fn);
  end;
end;

/// Finalize application settings by saving if modified and destroying the instance
procedure FinalizeApplicationSettings();
begin
  if(AppSettings.FModified = true) then
  begin
    AppSettings.Save;
  end;
  FreeAndNil(AppSettings);
end;

end.
