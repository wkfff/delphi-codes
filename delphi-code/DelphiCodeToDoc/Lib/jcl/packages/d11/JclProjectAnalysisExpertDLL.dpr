Library JclProjectAnalysisExpertDLL;
{
-----------------------------------------------------------------------------
     DO NOT EDIT THIS FILE, IT IS GENERATED BY THE PACKAGE GENERATOR
            ALWAYS EDIT THE RELATED XML FILE (JclProjectAnalysisExpertDLL-L.xml)

     Last generated: 07-08-2010  09:30:00 UTC
-----------------------------------------------------------------------------
}

{$R *.res}
{$ALIGN 8}
{$ASSERTIONS ON}
{$BOOLEVAL OFF}
{$DEBUGINFO OFF}
{$EXTENDEDSYNTAX ON}
{$IMPORTEDDATA ON}
{$IOCHECKS ON}
{$LOCALSYMBOLS OFF}
{$LONGSTRINGS ON}
{$OPENSTRINGS ON}
{$OPTIMIZATION ON}
{$OVERFLOWCHECKS OFF}
{$RANGECHECKS OFF}
{$REFERENCEINFO OFF}
{$SAFEDIVIDE OFF}
{$STACKFRAMES OFF}
{$TYPEDADDRESS OFF}
{$VARSTRINGCHECKS ON}
{$WRITEABLECONST ON}
{$MINENUMSIZE 1}
{$IMAGEBASE $58060000}
{$DESCRIPTION 'JCL Project Analyzer'}
{$LIBSUFFIX '110'}
{$IMPLICITBUILD OFF}

{$DEFINE BCB}
{$DEFINE WIN32}
{$DEFINE CONDITIONALEXPRESSIONS}
{$DEFINE VER180}
{$DEFINE VER185}
{$DEFINE RELEASE}

uses
  ToolsAPI,
  JclProjectAnalyzerFrm in '..\..\experts\projectanalyzer\JclProjectAnalyzerFrm.pas' {ProjectAnalyzerForm},
  JclProjectAnalyzerImpl in '..\..\experts\projectanalyzer\JclProjectAnalyzerImpl.pas' 
  ;

exports
  JCLWizardInit name WizardEntryPoint;

end.
