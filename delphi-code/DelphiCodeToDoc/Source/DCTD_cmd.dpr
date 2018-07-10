{*-------------------------------------------------------------------------------
  DelphiCodeToDoc is a free documentation system for Delphi
  It uses information about source code symbols and formatted comments in files
  to produce accurate documentation from your application and component.
  This is the Console (DOS) application
  http://dephicodetodoc.sourceforge.net/
  Copyright TridenT 2003 - Under GNU GPL licence

  @Author    TridenT
  @Version   2003/12/01   TridenT   Initial revision
-------------------------------------------------------------------------------}
program DCTD_cmd;

{$APPTYPE CONSOLE}



uses
  SysUtils,
  uDocGeneratorVisitor in 'Generator\uDocGeneratorVisitor.pas',
  uDocGeneratorBase in 'Generator\uDocGeneratorBase.pas',
  uDocGeneratorChm in 'Generator\Chm\uDocGeneratorChm.pas',
  uDocGenCHM_Tools in 'Generator\Chm\uDocGenCHM_Tools.pas',
  uDocGenHtmlVisitor in 'Generator\Html\uDocGenHtmlVisitor.pas',
  uDocGeneratorHtml in 'Generator\Html\uDocGeneratorHtml.pas',
  uDocGenHTML_Tools in 'Generator\Html\uDocGenHTML_Tools.pas',
  uTAGComment in 'Parse\uTAGComment.pas',
  AsmKeywords in 'Parse\AsmKeywords.pas',
  BuildParseTree in 'Parse\BuildParseTree.pas',
  BuildTokenList in 'Parse\BuildTokenList.pas',
  ParseError in 'Parse\ParseError.pas',
  ParseTreeNode in 'Parse\ParseTreeNode.pas',
  ParseTreeNodeType in 'Parse\ParseTreeNodeType.pas',
  SourceToken in 'Parse\SourceToken.pas',
  SourceTokenList in 'Parse\SourceTokenList.pas',
  Tokens in 'Parse\Tokens.pas',
  TokenUtils in 'Parse\TokenUtils.pas',
  PreProcessorParseTree in 'Parse\PreProcessor\PreProcessorParseTree.pas',
  PreProcessorExpressionParser in 'Parse\PreProcessor\PreProcessorExpressionParser.pas',
  PreProcessorExpressionTokenise in 'Parse\PreProcessor\PreProcessorExpressionTokenise.pas',
  PreProcessorExpressionTokens in 'Parse\PreProcessor\PreProcessorExpressionTokens.pas',
  VisitStructure in 'Process\VisitStructure.pas',
  AllProcesses in 'Process\AllProcesses.pas',
  BaseVisitor in 'Process\BaseVisitor.pas',
  Nesting in 'Process\Nesting.pas',
  TreeWalker in 'Process\TreeWalker.pas',
  VisitComment in 'Process\VisitComment.pas',
  VisitSetNesting in 'Process\VisitSetNesting.pas',
  VisitSetXY in 'Process\VisitSetXY.pas',
  ConvertTypes in 'ReadWrite\ConvertTypes.pas',
  Converter in 'ReadWrite\Converter.pas',
  uOptions in 'Settings\uOptions.pas',
  uDocProject in 'Settings\uDocProject.pas',
  uOldOptions in 'Settings\uOldOptions.pas',
  uDocVar in 'Structure\uDocVar.pas',
  uDocClass in 'Structure\uDocClass.pas',
  uDocClassTree in 'Structure\uDocClassTree.pas',
  uDocConstant in 'Structure\uDocConstant.pas',
  uDocEvent in 'Structure\uDocEvent.pas',
  uDocField in 'Structure\uDocField.pas',
  uDocFunction in 'Structure\uDocFunction.pas',
  uDocInterface in 'Structure\uDocInterface.pas',
  uDocLibrary in 'Structure\uDocLibrary.pas',
  uDocMember in 'Structure\uDocMember.pas',
  uDocMethod in 'Structure\uDocMethod.pas',
  uDocParameter in 'Structure\uDocParameter.pas',
  uDocProgram in 'Structure\uDocProgram.pas',
  uDocProperty in 'Structure\uDocProperty.pas',
  uDocRecord in 'Structure\uDocRecord.pas',
  uDocStructure in 'Structure\uDocStructure.pas',
  uDocTagCoverage in 'Structure\uDocTagCoverage.pas',
  uDocTemplate in 'Structure\uDocTemplate.pas',
  uDocType in 'Structure\uDocType.pas',
  uDocUnit in 'Structure\uDocUnit.pas',
  uDocUseUnit in 'Structure\uDocUseUnit.pas',
  uDocToNodesVisitor in 'Structure\Visitor\uDocToNodesVisitor.pas',
  uDocBaseVisitor in 'Structure\Visitor\uDocBaseVisitor.pas',
  uDocFunctionTypeCommentFixVisitor in 'Structure\Visitor\uDocFunctionTypeCommentFixVisitor.pas',
  uDocInheritanceFixVisitor in 'Structure\Visitor\uDocInheritanceFixVisitor.pas',
  uDocSortVisitor in 'Structure\Visitor\uDocSortVisitor.pas',
  uDocTagCoverageVisitor in 'Structure\Visitor\uDocTagCoverageVisitor.pas',
  uCommandLine in 'UI\uCommandLine.pas',
  uMessages in 'UI\uMessages.pas',
  RedCon in 'Utils\RedCon.pas',
  FileUtils in 'Utils\FileUtils.pas',
  JcfLog in 'Utils\JcfLog.pas',
  JcfMiscFunctions in 'Utils\JcfMiscFunctions.pas',
  JcfUnicodeFiles in 'Utils\JcfUnicodeFiles.pas',
  JcfUnicode in 'Utils\JcfUnicode.pas',
  JcfStringUtils in 'Utils\JcfStringUtils.pas',
  uHtmlDocRegistry in 'Generator\Pdf\uHtmlDocRegistry.pas',
  uDocGeneratorPdf in 'Generator\Pdf\uDocGeneratorPdf.pas',
  uDocGenPDF_Tools in 'Generator\Pdf\uDocGenPDF_Tools.pas';

var
  ReturnCode : integer;
begin
  // Init return code to error
  ReturnCode := 1;
  IgnoreTranslations();
  SearchTranslations();
  if VerifyCommand() then
   if IsLegalCommandLine() then
    if cmdOpenProject() then
     if cmdCheckExecute() then
      if cmdBuildExecute() then
      begin
        FinishProcess();
        ReturnCode := 0;
      end;
  // Set Exit code (errorlevel)
  ExitCode := ReturnCode;
end.
