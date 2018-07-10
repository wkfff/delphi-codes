unit AQtime_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 6/19/2009 3:52:42 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: AQtime.tlb (1)
// LIBID: {F3CCE843-2B63-4EE7-A35A-5E843602253C}
// LCID: 0
// Helpfile: 
// HelpString: AutomatedQA AQtime Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v6.21 DebuggerEngine, (Y:\AQtime6\Src\AQtime 6\Public\Common\DebuggerEngine.tlb)
// Errors:
//   Hint: TypeInfo 'AQtime' changed to 'AQtime_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of IaqNativeStoreTypeInfoClass.GetMember changed to 'Type_'
//   Hint: Parameter 'Type' of IaqNativeStoreTypeInfoClass.GetProperty changed to 'Type_'
//   Hint: Parameter 'Type' of IaqNativeStoreTypeInfoEnum.GetElement changed to 'Type_'
//   Hint: Parameter 'Type' of IaqPatcher.SetApplicationType changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: TypeInfo 'AQtime' changed to 'AQtime_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses ActiveX, DebuggerEngine_TLB;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  AQtimeMajorVersion = 6;
  AQtimeMinorVersion = 0;

  LIBID_AQtime: TGUID = '{F3CCE843-2B63-4EE7-A35A-5E843602253C}';

  IID_IaqIterator: TGUID = '{CBF231D8-BA01-4937-B653-41048D569054}';
  IID_IaqUnknownIterator: TGUID = '{1C991424-03D6-4E98-9F77-580EA569C2D9}';
  IID_IaqGUIDIterator: TGUID = '{5F8E7434-68EB-4953-8F4E-EA6790E99E79}';
  IID_IaqModuleIntf: TGUID = '{C6736F7A-FD53-4EE5-9899-478623853C6C}';
  IID_IaqModuleIntfNotifier: TGUID = '{6D26EF70-10E3-4321-8FEA-CB63B923685C}';
  IID_IaqKeyItem: TGUID = '{F3851EB7-0D12-425C-A983-30A86A0A5E64}';
  IID_IaqStream: TGUID = '{BFC06497-51E1-4952-8882-00539BBFF737}';
  IID_IaqPersistStream: TGUID = '{F911D2BB-6928-4A5B-9292-47374D5408B5}';
  IID_IaqStringIterator: TGUID = '{E7D22731-F671-4C07-90CA-C8829E03B10C}';
  IID_IaqActionItem: TGUID = '{8317D966-E1A6-42A6-A35A-9BC3F4AD67BF}';
  IID_IaqActionNotifier: TGUID = '{BBFA0DB1-C94E-4C24-94B6-64A7218682E2}';
  IID_IaqSubsystemManager: TGUID = '{91DD7397-BDF6-4786-B806-6BF82E40EBA3}';
  IID_IaqBaseManager: TGUID = '{F6BA5917-54F4-45B4-AEE9-5A49ACDFB419}';
  IID_IaqProductInfo: TGUID = '{C9AC70BB-6C3A-4228-BFC2-4142CC21D17B}';
  IID_IaqActionManager: TGUID = '{66B82366-743B-4638-B399-DC7745476471}';
  IID_IaqActionProvider: TGUID = '{0BC3528C-1C19-4AA2-8343-FA57FACB4E4D}';
  IID_IaqActionsContainer: TGUID = '{7FB5765D-05CB-47AA-8166-DA774AA43678}';
  IID_IaqSubMenu: TGUID = '{E50593FE-999F-4972-8E26-EDB6C4CFC68B}';
  IID_IaqToolbar: TGUID = '{4FFB9E34-5DCA-4687-B392-19F539474E00}';
  IID_IaqPopupMenu: TGUID = '{0CE857AD-D614-4FEB-BFAB-E21B81B2E7AA}';
  IID_IaqActionsCustomizer: TGUID = '{239FCDBF-49D7-4838-BD45-77288F7D9B57}';
  IID_IaqHelpSystemManager: TGUID = '{9881C64F-1CBB-468F-A6E9-A9AB9040AA30}';
  IID_IaqBaseEvent: TGUID = '{8FDE4C22-70A8-41F5-9A12-AB2D32B3B495}';
  IID_IaqEventDispatcher: TGUID = '{41BB7A50-D638-4A13-A817-3E8A18185387}';
  IID_IaqRegistrationInfo: TGUID = '{9001119C-9507-4781-A177-BFE0F7D95A42}';
  IID_IaqEventsListenerProvider: TGUID = '{FD39D04F-1093-43A8-8BD8-B4938F47F495}';
  IID_IaqEventManager: TGUID = '{B194834B-CBC1-4C10-9840-53294F41FC3F}';
  IID_IaqBeforeEvent: TGUID = '{07418EA2-7AFE-4BDF-B02C-A77353D50830}';
  IID_IaqAfterEvent: TGUID = '{1195DF76-3EB4-4C86-94A5-9B2AF1443EC6}';
  IID_IaqOptionsNode: TGUID = '{85A753A9-022E-42AC-818D-77679EA52F29}';
  IID_IaqOptionsNodeIterator: TGUID = '{F39421D0-ABA5-4CF1-B206-5CDA51B2A31D}';
  IID_IaqProperties: TGUID = '{0EFA31D8-7670-4532-A9E1-0AC737E491CC}';
  IID_IaqPropertiesIterator: TGUID = '{92BE422C-B52A-4D07-8D07-4223D1BA5296}';
  IID_IaqPropertiesEx: TGUID = '{1D0BFE81-F9BD-4AC4-82DA-8BE3C4A7A49E}';
  IID_IaqOptionsNodeStore: TGUID = '{2D203D1F-607A-4219-B015-2F93072067F3}';
  IID_IaqOptionsProvider: TGUID = '{77755B15-2928-4B94-ADAF-2FB7D379C06F}';
  IID_IaqBasePlugin: TGUID = '{3E6C0AA1-39DF-D511-9A51-00D0B749C8FE}';
  IID_IaqExtendedPlugin: TGUID = '{CA5413B8-13F3-D511-915D-00D0B749C8FE}';
  IID_IaqPluginInformationRepository: TGUID = '{69FB0002-D3DA-41ED-909B-12BEF03232B8}';
  IID_IaqPluginInformation: TGUID = '{D94A89FE-CBD9-45E1-8928-9FF371836E00}';
  IID_IaqExtensionRegistrator: TGUID = '{A82D9D30-3CDF-D511-9A51-00D0B749C8FE}';
  IID_IaqWindowProvider: TGUID = '{AAE6E3E8-3BDF-D511-9A51-00D0B749C8FE}';
  IID_IaqWhatsThisSupportProvider: TGUID = '{97538BAE-6D45-443B-AA40-7BBB5C9B62BB}';
  IID_IaqUIShell: TGUID = '{04FA5B4B-ED49-4678-A7CF-975F64D76058}';
  IID_IaqInfoDialog: TGUID = '{9B15D4AF-3073-4BE1-890E-D4E6AD71D0A4}';
  IID_IaqCancelNotifier: TGUID = '{5CA0618F-3CBE-4BD9-BEED-BD837719000B}';
  IID_IaqSelectionProvider: TGUID = '{4C254C79-745A-4D26-A014-0E12993A62B8}';
  IID_IaqMessenger: TGUID = '{7851795C-2C1B-4F85-8B40-5BB7C058F3B8}';
  IID_IaqSilentLog: TGUID = '{81F2C7F1-B686-4201-A1FC-2A0C5F32D5F8}';
  IID_IaqSettingsManager_DVS: TGUID = '{B2B8BD2F-363E-48DD-9FB1-FD64DE2428B7}';
  IID_IaqBaseSetting_DVS: TGUID = '{4629D053-6622-41F2-8F93-CC2FE9D3DDDC}';
  IID_IaqSettingsManagerIntegration_DVS: TGUID = '{B6C6824F-159A-4329-A8C7-D5466BEB3315}';
  IID_IaqTableSettingSchema_DVS: TGUID = '{A33D550E-B941-41AB-9732-B34D1DE3D0C0}';
  IID_IaqTableSetting_DVS: TGUID = '{C8705533-F5CD-485B-9B61-8F945A74196A}';
  IID_IaqSettingsProvider_DVS: TGUID = '{22345578-A212-4C7F-A05A-646ED72D2CB4}';
  IID_IaqSettings_DVS: TGUID = '{8EFFF4D5-3F81-4F30-8EA0-34877B57900A}';
  IID_IaqSettingIterator_DVS: TGUID = '{C37728A4-CACC-4043-BD7A-E03F67D5872F}';
  IID_IaqSettingsActionsProvider: TGUID = '{113D4CA2-6208-4E91-97AD-D315CE62D1C2}';
  IID_IaqSettingsUpdateListener_DVS: TGUID = '{767C39FB-834E-4096-96AA-4E872DD8E646}';
  IID_IaqSettingsGroup: TGUID = '{0AF3FEC8-776A-46CD-ADC1-AED68DA68C37}';
  IID_IaqSettingValidator: TGUID = '{3CDB097B-7B86-4FE2-9417-F826D43F8790}';
  IID_IaqUnknownCollection: TGUID = '{F86BE24D-8E20-4434-9397-176CAA40950C}';
  IID_IaqDumpStringsManager: TGUID = '{764618CB-3653-4C25-A4BC-FDA070B13AB6}';
  IID_IaqDbgSymbolManager: TGUID = '{8DCBD7AB-85C7-4B95-AAEB-52DF2C48AEBC}';
  IID_IaqDbgSymbolType: TGUID = '{E84C200C-A532-42E0-BC68-AC36864AB597}';
  IID_IaqDbgSymbolStoreIterator: TGUID = '{C43628A1-BAED-4645-A594-E186C338CF83}';
  IID_IaqDbgSymbolStore: TGUID = '{7E932C3E-16B2-4A82-A2E7-B44AD734DE81}';
  IID_IaqDbgSymbol: TGUID = '{6B0D6874-A262-4291-A9D3-FB7DFE7487E0}';
  IID_IaqDbgSymbolReader: TGUID = '{E2AB5F41-20BD-4D32-84E1-7AE0E59C8B9D}';
  IID_IaqDbgSymbolReaderCallback: TGUID = '{3D5F9784-B82A-49CB-AC0F-96E25C678EF6}';
  IID_IaqDbgSymbolReaderEx: TGUID = '{FE31590A-A32F-4CCC-8801-ED1184B16C45}';
  IID_IaqDbgSymbolReference: TGUID = '{5A22F94E-7AD6-4D66-8203-AB59A1489D5A}';
  IID_IaqDbgSourceFile: TGUID = '{C1E81474-7606-4B31-ACF3-2B68C2728499}';
  IID_IaqDbgRoutine: TGUID = '{D69FA7BA-CA79-4FC2-8F3C-A68BC9041A35}';
  IID_IaqDbgClass: TGUID = '{453E2BC4-3E3D-4B1D-A178-169AEF72D2EA}';
  IID_IaqDbgSymbolReaderBeginEndListener: TGUID = '{B780D1BF-23DD-4009-8120-73CAF88A59D8}';
  IID_IaqDbgSymbolStoreEx: TGUID = '{C5D9BB87-0C50-4ABA-8BA2-AEB763F3814F}';
  IID_IaqIdleProvider: TGUID = '{5599ED29-89B5-4A2A-954A-9A4E362208C4}';
  IID_IaqContextManager: TGUID = '{B4FE2003-80F1-469E-8C46-F286F8310606}';
  IID_IaqContextProvider: TGUID = '{0751AB3E-E195-44C5-96B0-051EE53C9E25}';
  IID_IaqContextManager2: TGUID = '{C7C2F61E-92FF-4F42-AD7B-DC29B69F083E}';
  IID_IaqContextChangedEvent: TGUID = '{9F113F4D-4EFE-46A4-85B1-59F7731CB36A}';
  IID_IaqFileMonitorManager: TGUID = '{71AC8535-F164-498D-A0FD-A412BAB665A1}';
  IID_IaqFileChangeEvent: TGUID = '{7B32F915-DA6C-400A-9054-D754C73BEEE1}';
  IID_IaqDataProviderStorage_XXX: TGUID = '{47C63009-CFDC-48E4-BA0B-1688222835EA}';
  IID_IaqDataProvider_XXX: TGUID = '{9853EA36-C681-452C-B14B-889C1754F4EE}';
  IID_IaqDataSchema_XXX: TGUID = '{579D9A51-EA23-4CD0-A7BF-7DDF6423118D}';
  IID_IaqDataMoniker_XXX: TGUID = '{D42FB808-B6AB-43EF-99DD-A394B425501F}';
  IID_IaqDataContainerProvider_XXX: TGUID = '{CDC36F90-C827-45F0-86CD-9B66639865C7}';
  IID_IaqDataTableProvider_XXX: TGUID = '{25022DB6-093A-420C-BE67-3445893A1695}';
  IID_IaqDataTextProvider_XXX: TGUID = '{9365AD3E-A755-43C9-B891-4F3A2399C783}';
  IID_IaqDataLinkListener_XXX: TGUID = '{283F4FBE-B683-4421-9566-0B57B6391D66}';
  IID_IaqDataMonikerProvider_XXX: TGUID = '{358DCE25-8DF4-4800-97C6-2434394E04EA}';
  IID_IaqDataTableMonikerProvider_XXX: TGUID = '{24939A6D-8F06-4616-AE9D-1E2FD99387C9}';
  IID_IaqDataContainerSchema_XXX: TGUID = '{42E35A22-FE65-4700-874F-AD24EA4EEF15}';
  IID_IaqDataTableSchema_XXX: TGUID = '{2494EF33-70CE-4CF4-B658-AD10AB6FD424}';
  IID_IaqDataBandedTableSchema_XXX: TGUID = '{A1224B21-63F7-4936-9EAB-EBE89074B353}';
  IID_IaqDataPictureProvider_XXX: TGUID = '{2FBADEA4-7D8A-4B8A-A769-2B6A0454B56F}';
  IID_IaqDataPictureSchema_XXX: TGUID = '{8C4B1C1A-9F0C-47F0-8E8E-069A9FF02796}';
  IID_IaqFilterTableSchema: TGUID = '{A78398D7-E79C-4819-99F9-F2D5B232CD56}';
  IID_IaqFilterTableProvider: TGUID = '{B7DB5380-62C2-4D91-9327-F86E269CFC5C}';
  IID_IaqDataNavigationSchema: TGUID = '{402DC57D-D7A6-4774-9525-534890AC7EC4}';
  IID_IaqDataNavigationProvider: TGUID = '{611E1D54-A05B-402A-9FA4-38982B5716B4}';
  IID_IaqDataTreeProvider_XXX: TGUID = '{219CA22C-FC85-411D-9E47-E975D9D7EC9D}';
  IID_IaqDataGraphSchema_XXX: TGUID = '{7C7F147D-6EF6-4CCB-A2C9-0E97190876C6}';
  IID_IaqDataDiagramSchema_XXX: TGUID = '{5E59ED41-C85F-4A2E-9641-940315B82579}';
  IID_IaqDataTreeSchema_XXX: TGUID = '{A901230A-B010-479B-8215-3F7986A2640F}';
  IID_IaqDataTextSchema_XXX: TGUID = '{41ADB9D7-C45C-42ED-851B-E60AC1B3D67E}';
  IID_IaqSymbolDataMoniker_XXX: TGUID = '{86796B87-1B32-497C-B105-FBFDEEB90E0B}';
  IID_IaqDataProviderEvent_XXX: TGUID = '{04EDF72C-F15D-4D3B-A92B-99B07C152BF8}';
  IID_IaqExportImportProvider: TGUID = '{5F32ACAF-43D5-4D48-B631-5EDB3DDC8173}';
  IID_IaqTimeProductInfo: TGUID = '{9BDF54B8-19AD-479E-B589-907B5701AFFF}';
  IID_IaqViews: TGUID = '{70EBC214-6BF3-11D3-9E00-0020781423AC}';
  IID_IaqViewEvent: TGUID = '{825DA0DE-77F0-4856-B614-DD31C66A4BBC}';
  IID_IaqViewsEvent: TGUID = '{6BE4A07A-515E-4BB5-8BF1-143461370759}';
  IID_IaqEventViewCallBack: TGUID = '{86C06394-BB1F-407F-A6EA-00A4EFD777FE}';
  IID_IaqEventViewEngineManager: TGUID = '{3BAB2505-7883-4C7B-9BD7-DB554B7934BE}';
  IID_IaqResultsStorageItem: TGUID = '{D600EF75-449D-4F67-90A7-53E4FA883B07}';
  IID_IaqResult: TGUID = '{5ADF5988-8442-4327-B707-1D2BCA027C85}';
  IID_IaqResultNode: TGUID = '{20E4EC8E-5234-43D4-9605-1EDA0541D0DF}';
  IID_IaqMetaProvider: TGUID = '{71249768-E741-4B51-B92E-4702AAF097FC}';
  IID_IaqDataProvider: TGUID = '{E2D38B17-BAC9-4CA7-9D98-DE3517ADCCF8}';
  IID_IaqDataSchema: TGUID = '{529B1C02-741A-4D90-94BD-85C794633F84}';
  IID_IaqBrowseObject: TGUID = '{9782B7F4-D479-4AF6-935D-71564BEAED7F}';
  IID_IaqDataSchemaEx: TGUID = '{C28B59EA-87CB-4DA4-A1F4-497AA4A0AC26}';
  IID_IaqTableDataSchema: TGUID = '{B54A842C-D1CC-46B9-9839-9391E589DFC5}';
  IID_IaqTableBand: TGUID = '{0E74660D-CC02-4D09-80DA-F0D5BAED1C79}';
  IID_IaqTableDataProvider: TGUID = '{6060C1A0-366F-41B4-A058-85476058478B}';
  IID_IaqTableDataProviderEx: TGUID = '{A175E5D1-5BE1-4499-8BA9-CA79F00D2D9D}';
  IID_IaqNotepadProvider: TGUID = '{2C8C7B8F-9B0A-49A5-B8A3-6F0B77DCC4D7}';
  IID_IaqGraphDataProvider: TGUID = '{0C90B6A6-9C58-46F6-8B14-21F6F2570121}';
  IID_IaqSourceFileProvider: TGUID = '{25014317-DE2D-4F38-8823-5C962F22549F}';
  IID_IaqCallGraphDataProvider: TGUID = '{7BDCEBF0-6F6A-441E-A876-90AE15DB0656}';
  IID_IaqSummaryDataProvider: TGUID = '{949DCC6A-1A1E-49E0-B43B-88F5D541A959}';
  IID_IaqTextNotesDataProvider: TGUID = '{05FCF9D2-4A50-4DC4-965E-4B7286DDBA9B}';
  IID_IaqTextNotesSchema: TGUID = '{C461AA88-B09F-4713-AEA5-274DF55C03B2}';
  IID_IaqBrowseDataEvent: TGUID = '{A4385868-6BAE-4F31-A410-E8A0FD1735FF}';
  IID_IaqSourceFilesProvider: TGUID = '{DA36799E-F5C1-4B05-900F-BA9E92732C15}';
  IID_IaqSymbolMonikerProvider: TGUID = '{223B4703-2F1F-4501-91B8-702BAAEA1F01}';
  IID_IaqProfilersManager: TGUID = '{41CC57C3-F8E7-4ECF-BC2F-29F13A34FFFB}';
  IID_IaqBaseProfiler: TGUID = '{4D7665E4-4011-4681-83DD-B9F9AEF2B999}';
  IID_IaqRunMode: TGUID = '{11AD2E12-E372-4BA8-A3BB-33CAEEF6E508}';
  IID_IaqDynamicProfiler: TGUID = '{F058A8B0-9BCE-4A29-AFFD-A39777F956A7}';
  IID_IaqStaticProfiler: TGUID = '{24663498-A741-4B04-8D3F-8F34F4A08195}';
  IID_IaqSetupProvider: TGUID = '{31D25A66-DB1F-47D2-A8D2-8221BBB99045}';
  IID_IaqLaunchProvider: TGUID = '{77DC4EB9-7127-4CFA-A831-31ED94082DAC}';
  IID_IaqResultsProvider: TGUID = '{4C31630D-8632-42C8-991B-469B50995195}';
  IID_IaqCompactResultsProvider: TGUID = '{51E14FA7-D190-4866-A31D-04DD640A6D3E}';
  IID_IaqMergeProvider: TGUID = '{9610990C-5146-436E-AC85-C2753ACD94CF}';
  IID_IaqCompareProvider: TGUID = '{6E7B5843-662B-40FE-BB80-833AD735A7C6}';
  IID_IaqResultsThreadRenamer: TGUID = '{475009FA-E9FD-46A3-B636-BD2452FB8C6B}';
  IID_IaqProfilersManagerExtender: TGUID = '{617938D3-110E-45FD-9381-D4F2EC7DDBAF}';
  IID_IaqProfilerEvent: TGUID = '{605469B4-C681-49EA-958D-E67D6BB8A66F}';
  IID_IaqNormalRunMode: TGUID = '{AB17D974-3482-45FE-A84E-A4686A1020F4}';
  IID_IaqCOMRunMode: TGUID = '{DC75CD58-EA42-4D9E-AC19-F4EAA68CECD8}';
  IID_IaqASPNETRunMode: TGUID = '{02AB9751-AB0A-4A7D-80ED-05DFA8325830}';
  IID_IaqServiceRunMode: TGUID = '{7B6142C2-87EA-40C7-87AE-87973CFD73BB}';
  IID_IaqIISAppRunMode: TGUID = '{6B184049-7169-42A8-AB89-DCF86B925250}';
  IID_IaqDebuggerEvent: TGUID = '{491F4B23-08AA-4384-ABDD-68AC52EFBDFB}';
  IID_IaqDebuggerEventEx: TGUID = '{08614A4B-F62E-4EAA-82C8-F96346B64C5A}';
  IID_IaqClrDebuggerEvent: TGUID = '{D90A494B-810C-4AFB-98C5-EEA7BEE5C6A1}';
  IID_IaqModuleCollection: TGUID = '{AFE2DF72-81A7-4794-A92A-2E32AE1A81B0}';
  IID_IaqModule: TGUID = '{B4F9B3D9-1A1F-4D80-A975-009242138DC7}';
  IID_IaqProjectEvent: TGUID = '{9C959502-B8AD-11D2-9C23-0020781423AC}';
  IID_IaqProjectManager: TGUID = '{30E68CAF-A6ED-41F8-818C-C86193AE18C9}';
  IID_IaqSetupEvent: TGUID = '{6C20055F-42FE-433F-A455-589E2FBE867C}';
  IID_IaqSetupElement: TGUID = '{F333912E-050A-42FD-8C08-7E846B7C015F}';
  IID_IaqSetupTrigger: TGUID = '{72C09691-BFCD-40A6-8BF8-32B326A4585C}';
  IID_IaqSetupArea: TGUID = '{07F2E96B-93CA-49A0-BF3D-72E74B92731B}';
  IID_IaqSetupAction: TGUID = '{3156CFBC-08F5-4EE0-9AF5-5B85B1055A13}';
  IID_IaqAreaItem: TGUID = '{5B43AE76-5B1A-42D4-999A-329FF9D1CD00}';
  IID_IaqAreaTriggerItem: TGUID = '{A96D2058-BF34-47B2-8970-DBF73B46E762}';
  IID_IaqAreaActionItem: TGUID = '{67626F67-897F-41D6-A6EE-B94C73EF5092}';
  IID_IaqSetupManager: TGUID = '{7915A720-2B02-4429-AE3F-06A1F85F5CF7}';
  IID_IaqSearchFileManager: TGUID = '{7EA374F9-0DE9-410F-BC29-F103B8157581}';
  IID_IaqSearchFileManagerEvent: TGUID = '{F7C7BF2F-5661-4D5B-B097-54DE059BC09F}';
  IID_IaqShowSymbolEvent: TGUID = '{85A54236-6A2B-4B09-B85B-A53835670F6A}';
  IID_IaqDisassemblerManager: TGUID = '{D3A2ED8C-5BF9-4569-8F84-0BE7CAD01A5F}';
  IID_IaqDisassembler: TGUID = '{A8DA0E0F-FAE8-40D5-8475-05AFE4D2A880}';
  IID_IaqModuleAnalyzer: TGUID = '{F111E2C9-EBB3-450D-9560-8541934EAC1F}';
  IID_IaqRoutineAnalyzer: TGUID = '{5F1C6059-393A-459D-A8F3-46CE09007BCB}';
  IID_IaqCodeDisassembler: TGUID = '{2A8E19AD-5ACB-4217-A845-99335044AE56}';
  IID_IaqComparingManager: TGUID = '{C10B910A-B5CA-4257-B054-870F38CD2B10}';
  IID_IaqReportProvider_XXX: TGUID = '{8EC4FB9B-4B41-4755-978B-1C8F360B70A6}';
  IID_IaqNotePadProvider_XXX: TGUID = '{E57FEB1B-ACB6-47AE-AEEF-4095C5AD8CD7}';
  IID_IaqSummaryProvider_XXX: TGUID = '{D7AF58E1-F865-49FE-8296-758C8B992757}';
  IID_IaqCallGraphProvider_XXX: TGUID = '{34DFD10E-C46B-4C6F-8C0E-DF81575C334E}';
  IID_IaqGraphProvider_XXX: TGUID = '{7D7EDFA2-81A9-4F71-BE25-C290400C39B0}';
  IID_IaqSourceFilesProvider_XXX: TGUID = '{D2C6C609-8E45-4875-9043-1516257119A3}';
  IID_IaqSourceFileProvider_XXX: TGUID = '{DAA25EC5-24E7-4449-83D4-2048E5F20EC4}';
  IID_IaqGutterProvider_XXX: TGUID = '{97A337A1-40F1-4007-8702-8A7751569AD4}';
  IID_IaqCommentsProvider_XXX: TGUID = '{C0C6B116-4D62-4B3D-B4CC-F0CFBB05CA7D}';
  IID_IaqTimeIntegrationRunMode: TGUID = '{D4CB267A-237D-44C0-BE2A-B6D2F5D19A90}';
  IID_IaqTimeIntegrationSupportManager: TGUID = '{CFC99F80-0568-45F6-8A5C-A27C8D3BED32}';
  IID_IaqBaseFunction: TGUID = '{85E78ABD-3DE6-468B-A2D6-459B4316656D}';
  IID_IaqCustomIterator: TGUID = '{2FB06D5C-4432-4C3D-A071-A9FDFBEA26C4}';
  IID_IaqSubCategoriesIterator: TGUID = '{A7B7334D-0EBF-4048-8A4A-D8AD773A251D}';
  IID_IaqCategoriesIterator: TGUID = '{4AFB1820-9B9A-4EA2-9433-DAB3505606AC}';
  IID_IaqFunctionsIterator: TGUID = '{B39232CD-1319-40B1-8887-5236338575C7}';
  IID_IaqCustomParameter: TGUID = '{DAE8D33B-2467-430A-9CBC-C23B2515DD2D}';
  IID_IaqFunctionParameter: TGUID = '{CA10916B-4643-4D8A-A011-CB11690B3682}';
  IID_IaqCustomIdentifier: TGUID = '{18A8B003-A9E1-410C-8BE4-A334190E52A6}';
  IID_IaqFunction: TGUID = '{C1A5EAEB-9CDD-4A89-9621-72FBE49C939E}';
  IID_IaqPlatformsIterator: TGUID = '{BA9C8261-9165-4360-A4C5-4169F8D7435D}';
  IID_IaqWinAPIDatabase: TGUID = '{0DE1DEFD-2C89-4912-8C34-612BD673EB6D}';
  IID_IaqWinAPIDatabaseLegacy: TGUID = '{605F9B67-FF9C-4044-8703-2A780A3F0ED6}';
  IID_IaqWinAPIDatabaseModule: TGUID = '{B5D4DF6F-1B42-4B5C-9CE3-B5003853C884}';
  IID_IaqWinAPIDatabaseManager: TGUID = '{2ADD6327-2B10-47DA-A000-BC2138B34062}';
  IID_IaqMonitorMetaProvider: TGUID = '{C4B9AED8-E069-45B6-A538-448721C51F3B}';
  IID_IaqMonitorDataEvent: TGUID = '{3C1084C8-52CB-4B5A-8138-CB4C86997A43}';
  IID_IaqProfIntf: TGUID = '{B235822F-EED2-45C2-A3AE-4502E83C16D2}';
  IID_IaqProfPluginRegistry: TGUID = '{EBA97606-79C5-46B8-874D-1C06DBACD6E4}';
  IID_IaqProfPluginFactory: TGUID = '{B2DFA27C-29BD-43D8-BD92-C5FF4F256FF3}';
  IID_IaqProfPlugin: TGUID = '{36AAE878-3186-4480-9D8B-144CE26854F6}';
  IID_IaqProfPersistent: TGUID = '{BFC15E9D-45DC-47FE-A8B4-6D89C51E0B16}';
  IID_IaqProfBaseContext: TGUID = '{9770004E-ABED-4AEA-8499-DDE6991054B5}';
  IID_IaqProfPluginManager: TGUID = '{C41CC42A-CDE9-4C60-9FC3-2B490DA0536D}';
  IID_IaqProfPluginCallback: TGUID = '{72565749-D520-4310-9D54-32E290AEDAC7}';
  IID_IaqProfDataManager: TGUID = '{7421A575-9691-4F9D-AD8E-E7354D2EFCF6}';
  IID_IaqProfTable: TGUID = '{1E956DCA-CC74-4DB1-A884-E0567B1161B4}';
  IID_IaqProfTableSchema: TGUID = '{D85C3A87-572F-4CA1-AD0B-49C64A1F8C5C}';
  IID_IaqProfTableColumn: TGUID = '{2105915E-5959-421F-AA36-4E805FD46DF0}';
  IID_IaqProfTableColumnCallback: TGUID = '{79042041-8CB1-44AB-A8C6-785B9E03C5CA}';
  IID_IaqProfTableCallback: TGUID = '{C2405983-7661-4E57-A175-EC7914C6F40F}';
  IID_IaqProfTableProviderCallback: TGUID = '{10D3A427-B538-4FCA-B252-66CFACD84100}';
  IID_IaqProfTableProvider: TGUID = '{E6EA944A-A465-447F-9303-EE68452AD904}';
  IID_IaqProfMergeCallback: TGUID = '{8145B073-3553-4B99-974C-215A55D3B97B}';
  IID_IaqProfThreadMapperRegistry: TGUID = '{1C664E41-07C6-4B6E-A848-40F9372F8325}';
  IID_IaqProfCounterRegistry: TGUID = '{D069C862-44AC-47AD-BCE9-9D4F41130851}';
  IID_IaqProfDynamicContext: TGUID = '{174746F6-E02E-4235-841C-258AF05DAF9E}';
  IID_IaqProfThreadManager: TGUID = '{8716A0F4-B900-40A2-9AB9-7692A4361BB9}';
  IID_IaqProfCounterManager: TGUID = '{483D8CE3-C4DB-4723-ACF2-939FED88779F}';
  IID_IaqProfCounter: TGUID = '{12201681-D9E5-4B3C-A18E-6CBB74F90B99}';
  IID_IaqProfProfilingCallback: TGUID = '{976CC1B0-0C10-48A1-8ECD-D8B34AA751B6}';
  IID_IaqProfMarshalCallback: TGUID = '{525F2A79-529E-42D6-95A7-32B57651601C}';
  IID_IaqProfSessionListener: TGUID = '{9ACA8BCE-4250-4AA8-B86C-C7D7433C2685}';
  IID_IaqProfSession: TGUID = '{2EFDECFC-3840-4501-955C-3F00FD4A02C2}';
  IID_IaqProfProcessCallback: TGUID = '{42466E47-0BD9-4E94-BF78-3749A57D6CE0}';
  IID_IaqProfTableColumnType: TGUID = '{A3ED49B2-76A1-4CE0-B937-451A163EC1D7}';
  IID_IaqProfTableType: TGUID = '{62EC67D1-38F7-4135-B718-DF1BA996FD4A}';
  IID_IaqProfThreadMapper: TGUID = '{A709902E-767E-44C1-B13E-7B36A092A552}';
  IID_IaqProfCounterFrequency: TGUID = '{8DB03846-916D-4848-9ED2-866CAACC50B9}';
  IID_IaqProfModuleLevel: TGUID = '{5C5FF40D-1E6D-4564-AADD-1D2F829928E6}';
  IID_IaqProfSourceFileLevel: TGUID = '{D9AAFD53-5876-4A07-ABF4-3F3791422551}';
  IID_IaqProfClassLevel: TGUID = '{4C61EB29-F0CE-470D-B757-0B73A013E6E6}';
  IID_IaqProfRoutineLevel: TGUID = '{5A0C191C-540D-4331-8877-2594592EC3A2}';
  IID_IaqProfObjectLevel: TGUID = '{E0BCBC94-1AC0-43DC-839E-E8E77133CADE}';
  IID_IaqProfWin32ThreadMapper: TGUID = '{A8F27470-4AB5-4DBB-9D23-F6BC05372591}';
  IID_IaqProfClrThreadMapper: TGUID = '{EE3D1E04-5D17-4111-B9FD-D3F98F1EA6A0}';
  IID_IaqProfTriggers: TGUID = '{42726E92-02AF-4DCD-855D-AABF1E50096C}';
  IID_IaqProfActions: TGUID = '{F77090B2-F0B6-4713-98A1-966D4FB619BD}';
  IID_IaqProfContextPostPrecessor: TGUID = '{3677FFD2-A7F0-4045-B4D8-74E7E805A7C7}';
  IID_IaqProfLightCoverage: TGUID = '{9D434641-9082-40E7-A8CA-15314283449B}';
  IID_IaqProfRowset: TGUID = '{4508566F-31E3-400A-9BA4-3BD49C750DA1}';
  IID_IaqProfRoutineHitCounter: TGUID = '{532AEA2A-EFE4-4E37-9905-E424905E0328}';
  IID_IaqClrSymbolStore: TGUID = '{FED65C87-A24A-4733-A332-3297FE461707}';
  IID_IaqClrRoutine: TGUID = '{D0FC2E9D-A091-428D-88D5-D27A4AF4AA82}';
  IID_IaqClrClass: TGUID = '{9DD9D21A-BF19-4D44-8603-D4A893A264A5}';
  IID_IaqClrNamespace: TGUID = '{2FD28638-62EC-4C3D-A827-52E62FBEA9F4}';
  IID_IaqClrPatchManager: TGUID = '{ABFD3A6B-DEFE-4BE8-A9E6-8D12F2D39189}';
  IID_IaqClrPatcherCallback: TGUID = '{39DA2AB6-EF23-4F5A-96D6-7B222F6BCAAC}';
  IID_IaqClrPatcher: TGUID = '{92B4C855-DB19-4738-A134-EA6C09A1531B}';
  IID_IaqScriptRoutine: TGUID = '{B67676D9-4554-4FC4-A093-53F1E9CDFA7E}';
  IID_IaqInternalNativeSymbolStore: TGUID = '{3886E03D-E55C-4F87-BD15-841F6CC0DF8A}';
  IID_IaqNativeProcedure: TGUID = '{2FA4BF32-33B0-496A-90DA-478324D44081}';
  IID_IaqNativeProcedureType: TGUID = '{296EDCC4-7473-47D1-8E14-E18DCA44F41F}';
  IID_IaqNativeStoreType: TGUID = '{3B724334-CF44-4809-8519-AB636C5E37B8}';
  IID_IaqNativeStoreTypeInfo: TGUID = '{88F09B69-7E93-43C7-9005-2CBD98CD6002}';
  IID_IaqNativeSymbolStore: TGUID = '{250C9B2E-A58A-4EA5-BE50-7F46C6EF2728}';
  IID_IaqNativeClass: TGUID = '{3A488545-819E-44C9-AD3A-F2BE2E7F4E46}';
  IID_IaqNativeStoreTypeInfoClass: TGUID = '{8803156E-4B27-44C9-8E38-7B27FD6BA9E9}';
  IID_IaqNativeStoreTypeInfoEnum: TGUID = '{B0AD891E-A4B7-4EAA-82B9-9238D038EA9D}';
  IID_IaqExportRoutine: TGUID = '{F42C16B3-F546-4C47-BE0A-91ED241420AF}';
  IID_IaqPatcher: TGUID = '{6CBD2119-D2D0-4E04-91C8-47EAF6F476D6}';
  IID_IaqPatcherX64: TGUID = '{F4033582-F35E-44A9-ADD5-06401EBA71E7}';
  IID_IaqDbgHelp: TGUID = '{2548C27F-5813-43A5-84AB-A4534B2F8C88}';
  IID_IaqPEFile: TGUID = '{536C85CF-1E90-4710-9EA4-28CD683B802A}';
  IID_IaqPEImportModule: TGUID = '{6A77A2C5-BA5C-4017-9CAA-46B8AD0A0935}';
  IID_IaqStackWalkHelper: TGUID = '{7E46201F-6C3F-4ED5-B9A3-210CB77F841F}';
  IID_IaqDbgHelpStack: TGUID = '{6EDC0B90-4EC2-428B-9B79-675C4B63F5CD}';
  IID_IaqDbgHelpProcessList: TGUID = '{35816889-B074-4F31-A882-616A1E48A9C6}';
  IID_IaqDbgHelpProcessListLight: TGUID = '{CD22C7BD-8074-47F4-9A1B-076CA4F38A43}';
  IID_IaqModuleList: TGUID = '{EADD5CBA-4EC3-46F3-8FAA-BABC0402BA95}';
  IID_IaqWindowsList: TGUID = '{F07000CB-295B-45A8-A98D-E7CF6F331FC9}';
  IID_IaqWindowFilter: TGUID = '{D354A9F8-85ED-4F2B-9454-3CE64373F518}';
  IID_IaqIISManager: TGUID = '{CC751A48-510A-4C9F-835B-D62AF272F717}';
  IID_IaqDbgHelpManager: TGUID = '{84F27C07-E689-4FAD-BD97-E62F874BDDB4}';
  IID_IaqStack: TGUID = '{C1BA3881-C81F-4C5E-A9D5-DCF73C634090}';
  IID_IaqDbgHelpManagerExtender: TGUID = '{E56E2708-5118-42B4-A672-6DF6533E5EFF}';
  IID_IaqDbgHelpManagerExtenderX64: TGUID = '{CCDB5438-E06F-4FEB-926A-57B3DB45A2ED}';
  IID_IaqWindowsManager: TGUID = '{463D5E7A-02B6-4BE5-A74C-2D885DC8D6BB}';
  IID_IaqWindowsManagerEx: TGUID = '{D4A9548A-CE42-416D-B780-40DA334E62EB}';
  IID_IaqProfilersFactory: TGUID = '{D0462B77-0E92-4643-BCCC-4A4D03C77AA9}';
  IID_IaqBaseContextProfiler: TGUID = '{F32813A1-673F-4E4D-B272-E3B4A82409A6}';
  IID_IaqBaseContextProfilerExtender: TGUID = '{C79F66D5-DD33-4322-8045-D606C1CE9A2D}';
  IID_IaqContextProfilerImpl: TGUID = '{F88321C5-4CFE-4AAF-ADDC-66CF5B1592A1}';
  IID_IaqContextMetaProvider: TGUID = '{78901125-1CFB-4EC1-AA8C-01C4CF81D5E2}';
  IID_IaqContextProfilerProvider: TGUID = '{DE4902E9-80A8-4827-BE59-2A1D562FF8B2}';
  IID_IaqContextDataSchema: TGUID = '{95BF83A8-EB6E-4C7B-B45B-847DC6DED7E0}';
  IID_IaqContextBrowseObjectSupport: TGUID = '{3F82A4F9-C9D9-4910-AE6A-3397D971B306}';
  IID_IaqContextProfilerEngine: TGUID = '{F77AF285-2A13-460D-991F-ADADC4A39AAA}';
  IID_IaqContextProfilerEngineCallback: TGUID = '{EBE414FF-E84C-4D46-9CBC-8EB26560FC7C}';
  IID_IaqContextProfilerEngineAreasExtender: TGUID = '{CF3F248A-01A6-4F2C-8FE0-29B3815F8ADF}';
  IID_IaqStaticAnalysisEngineCallback: TGUID = '{4D5CF070-C569-4E1E-A5D9-4A1953729212}';
  IID_IaqContextProfilerCounterExtender: TGUID = '{771FC8DD-2217-4C16-B4DD-1E9620E9E6A7}';
  IID_IaqStaticContextProfilerImpl: TGUID = '{A4ED44F3-4A5F-4DC2-AFEC-F99468C19A8E}';
  IID_IaqContextProfilerResultsActivator: TGUID = '{652D6874-E760-43A7-873E-C686AF47944F}';
  IID_IaqContextProfilerOptions: TGUID = '{3284A6CF-5091-48DC-AF21-578F3C58C132}';
  IID_IaqContextProfilerSettings: TGUID = '{CEF0852C-04FD-45D2-AB15-C7286925D010}';
  IID_IaqContextProfilerMetaProvider: TGUID = '{82695983-5D20-460F-9416-267DF6D758FF}';
  IID_IaqContextProfilerToolbar: TGUID = '{B89CF15E-C383-4DB0-8BFF-2494BD76EB0E}';
  IID_IaqContextProfilerEngineExcludeAreaExtender: TGUID = '{AF5BA3FC-CD7B-4802-B1E8-1001B49D0108}';
  IID_IaqContextProfilerEngineAreasImportExtender: TGUID = '{AB5C327B-55C5-4154-B01B-348F93072B1B}';
  IID_IaqContextProfilerSessionEngine: TGUID = '{CB9042F8-9F24-48C8-B43D-2E31A47CC3D4}';
  IID_IaqContextProfilerDbgEngine: TGUID = '{06CEDBD2-CC0E-4E6A-B3AF-8874532C336D}';
  IID_IaqContextProfilerDbgEngineEx: TGUID = '{E925C844-C853-4447-B34B-C277B1B17B69}';
  IID_IaqContextProfilerActivationEngine: TGUID = '{896C7431-689E-4577-8098-64D43B0146BC}';
  IID_IaqResultCleaner: TGUID = '{93071ABC-F4C0-40A7-8146-99FDCFA1FB1F}';
  IID_IaqContextProfilerEngineRoutineCallback: TGUID = '{CB4330D1-66F4-4BCE-8E5D-644BCDD50AEE}';
  IID_IaqContextProfilerDBExporter: TGUID = '{59632D4C-166D-4E51-9C0E-FC7C0914A2A2}';
  IID_IaqExportResultsToDBManager: TGUID = '{35A743D2-CEA8-4491-A7AA-E1D61468FCE6}';
  IID_IAQtimeManager: TGUID = '{63BD16B6-F03F-11D3-B765-00105A6753FE}';
  CLASS_AQtime_: TGUID = '{39FF6FD8-027C-48C5-AD7D-7E8D1E04BCD6}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum AQ_HANDLE_TYPE
type
  AQ_HANDLE_TYPE = TOleEnum;
const
  htWindowHandle = $00000000;
  htVCLForm = $00000001;
  htCLXForm = $00000002;

// Constants for enum WindowVisibleState
type
  WindowVisibleState = TOleEnum;
const
  wvsFull = $00000000;
  wvsPartial = $00000001;
  wvsHidden = $00000002;
  wvsError = $00000003;

// Constants for enum ScrollBarType
type
  ScrollBarType = TOleEnum;
const
  sbtControl = $00000000;
  sbtHorizontal = $00000001;
  sbtVertical = $00000002;

// Constants for enum ScrollInfoMask
type
  ScrollInfoMask = TOleEnum;
const
  simPage = $00000000;
  simPos = $00000001;
  simRange = $00000002;
  simTrackPos = $00000003;
  simAll = $00000004;

// Constants for enum MenuItemInfoMask
type
  MenuItemInfoMask = TOleEnum;
const
  miimCheckMarks = $00000000;
  miimData = $00000001;
  miimId = $00000002;
  miimState = $00000003;
  miimSubMenu = $00000004;
  miimType = $00000005;

// Constants for enum GetWindowConduct
type
  GetWindowConduct = TOleEnum;
const
  gwcChild = $00000000;
  gwcFirst = $00000001;
  gwcLast = $00000002;
  gwcNext = $00000003;
  gwcPrev = $00000004;
  gwcOwner = $00000005;

// Constants for enum AQ_WINDOW_SHOW_FLAG
type
  AQ_WINDOW_SHOW_FLAG = TOleEnum;
const
  AQ_WSF_BRINGTOFRONT = $00000000;
  AQ_WSF_HIDE = $00000001;

// Constants for enum AQ_INFO_DIALOG_TYPE
type
  AQ_INFO_DIALOG_TYPE = TOleEnum;
const
  AQ_IDT_OK = $00000001;
  AQ_IDT_OKCANCEL = $00000002;
  AQ_IDT_YesNo = $00000003;

// Constants for enum AQ_ACTION_TYPE
type
  AQ_ACTION_TYPE = TOleEnum;
const
  atCommand = $00000000;
  atButton = $00000001;
  atCheckButton = $00000002;
  atDropDown = $00000003;
  atMRUButton = $00000004;
  atMRUMenu = $00000005;
  atCommandDropDown = $00000006;
  atFinderButton = $00000007;
  atEditDropDown = $00000008;
  atFirst = $00000000;
  atLast = $00000008;

// Constants for enum AQ_ACTION_POSITION
type
  AQ_ACTION_POSITION = TOleEnum;
const
  mmFirst = $00000000;
  mmBefore = $00000001;
  mmAfter = $00000002;
  mmLast = $00000003;

// Constants for enum AQ_SHELL_LOOK_AND_FEEL
type
  AQ_SHELL_LOOK_AND_FEEL = TOleEnum;
const
  AQ_SLF_STANDARD = $00000000;
  AQ_SLF_ENHANCED = $00000001;
  AQ_SLF_FLAT = $00000002;
  AQ_SLF_THEMED = $00000003;
  AQ_SLF_OFFICEXP = $00000004;
  AQ_SLF_MSVS = $00000005;
  AQ_SLF_MSVS2005 = $00000006;

// Constants for enum AQ_SHELL_DOCKING_STYLE
type
  AQ_SHELL_DOCKING_STYLE = TOleEnum;
const
  AQ_SDS_NATIVE = $00000000;
  AQ_SDS_VS2005 = $00000001;

// Constants for enum AQ_MAINMANAGER_STATE
type
  AQ_MAINMANAGER_STATE = TOleEnum;
const
  AQ_MS_INITIALIZING = $00000000;
  AQ_MS_INITIALIZING_EXTENDERS = $00000001;
  AQ_MS_LOADING = $00000002;
  AQ_MS_RUNNING = $00000003;
  AQ_MS_STORING = $00000004;
  AQ_MS_FINALIZING = $00000005;

// Constants for enum AQ_TABLE_COLUMN_TYPE
type
  AQ_TABLE_COLUMN_TYPE = TOleEnum;
const
  ctInteger = $00000000;
  ctString = $00000001;
  ctFloat = $00000002;
  ctBoolean = $00000003;
  ctImage = $00000004;
  ctHyperlink = $00000005;
  ctDateTime = $00000006;
  ctTimeDuration = $00000007;
  ctX32Address = $00000008;
  ctX64Address = $00000009;

// Constants for enum AQ_MOUSE_CURSOR
type
  AQ_MOUSE_CURSOR = TOleEnum;
const
  AQ_MC_NONE = $FFFFFFFF;
  AQ_MC_ARROW = $FFFFFFFE;
  AQ_MC_CROSS = $FFFFFFFD;
  AQ_MC_IBEAM = $FFFFFFFC;
  AQ_MC_SIZE = $FFFFFFEA;
  AQ_MC_SIZENESW = $FFFFFFFA;
  AQ_MC_SIZENS = $FFFFFFF9;
  AQ_MC_SIZENWSE = $FFFFFFF8;
  AQ_MC_SIZEWE = $FFFFFFF7;
  AQ_MC_UPARROW = $FFFFFFF6;
  AQ_MC_HOURGLASS = $FFFFFFF5;
  AQ_MC_DRAG = $FFFFFFF4;
  AQ_MC_NODROP = $FFFFFFF3;
  AQ_MC_HSPLIT = $FFFFFFF2;
  AQ_MC_VSPLIT = $FFFFFFF1;
  AQ_MC_MULTIDRAG = $FFFFFFF0;
  AQ_MC_SQLWAIT = $FFFFFFEF;
  AQ_MC_NO = $FFFFFFEE;
  AQ_MC_APPSTART = $FFFFFFED;
  AQ_MC_HELP = $FFFFFFEC;
  AQ_MC_HANDPOINT = $FFFFFFEB;
  AQ_MC_SIZEALL = $FFFFFFEA;

// Constants for enum AQ_ACTION_EXEC_RESULT
type
  AQ_ACTION_EXEC_RESULT = TOleEnum;
const
  AQ_AER_OK = $00000000;
  AQ_AER_ACTION_DISABLED = $00000001;
  AQ_AER_ACTION_CANCELED = $00000002;
  AQ_AER_ACTION_RECURSIVE_EXEC = $00000003;

// Constants for enum AQ_SAVE_RESULT
type
  AQ_SAVE_RESULT = TOleEnum;
const
  AQ_SR_OK = $00000000;
  AQ_SR_INCOMPLETE = $00000001;
  AQ_SR_CANCEL = $00000002;

// Constants for enum AQ_MESSENGER_BUTTONS
type
  AQ_MESSENGER_BUTTONS = TOleEnum;
const
  AQ_MB_YES = $00000001;
  AQ_MB_NO = $00000002;
  AQ_MB_OK = $00000004;
  AQ_MB_CANCEL = $00000008;
  AQ_MB_ABORT = $00000010;
  AQ_MB_RETRY = $00000020;
  AQ_MB_IGNORE = $00000040;
  AQ_MB_ALL = $00000080;
  AQ_MB_NOTOALL = $00000100;
  AQ_MB_YESTOALL = $00000200;

// Constants for enum AQ_MESSENGER_DIALOG_TYPE
type
  AQ_MESSENGER_DIALOG_TYPE = TOleEnum;
const
  AQ_MD_MESSAGE = $00000000;
  AQ_MD_ERROR = $00000001;
  AQ_MD_WARNING = $00000002;
  AQ_MD_CONFIRMATION = $00000003;

// Constants for enum TaqRunMode
type
  TaqRunMode = TOleEnum;
const
  rmNormal = $00000000;
  rmErrorAndWarning = $00000001;
  rmErrorOnly = $00000002;
  rmSilent = $00000003;

// Constants for enum __MIDL___MIDL_itf_AQtime_0134_0001
type
  __MIDL___MIDL_itf_AQtime_0134_0001 = TOleEnum;
const
  IDProductInfoName = $00026001;
  IDProductInfoVersionMajor = $00026002;
  IDProductInfoVersionMinor = $00026003;
  IDProductInfoVersionRelease = $00026004;
  IDProductInfoVersionBuild = $00026005;
  IDProductInfoVersionValue = $00026006;
  IDProductInfoRegistryPath = $00026007;
  IDProductInfoProductPath = $00026008;
  IDProductAppDataFolder = $00026009;
  IDProductLocalSettingsDataFolder = $0002600A;
  IDProductCommonDataFolder = $0002600B;
  IDProductInfoHelpFile = $0002600C;
  IDProductInfoWhatThisHelpFile = $0002600D;
  IDProductInfoWebSite = $0002600E;
  IDProductInfoSupportAddress = $0002600F;
  IDProductInfoSupportText = $00026010;
  IDProductInfoCopyright = $00026011;
  IDProductInfoIntegrationType = $00026012;
  IDProductInfoProductKey = $00026013;

// Constants for enum __MIDL___MIDL_itf_AQtime_0135_0001
type
  __MIDL___MIDL_itf_AQtime_0135_0001 = TOleEnum;
const
  IDRunMode = $00027001;
  IDAddManager = $00027002;
  IDRemoveManager = $00027003;
  IDManagers = $00027004;
  IDAddCallBack = $00027005;
  IDRemoveCallBack = $00027006;
  IDProductInfo = $00027007;
  IDHelpFileName = $00027008;
  IDManagersByString = $00027009;
  IDEnvironmentSettings = $0002700A;
  IDBaseManagerState = $0002700B;
  IDBaseManagerApplicationMode = $0002700C;

// Constants for enum __MIDL___MIDL_itf_AQtime_0138_0001
type
  __MIDL___MIDL_itf_AQtime_0138_0001 = TOleEnum;
const
  IDDispatchEvent = $00010001;
  IDSyncNotifier = $00010002;
  IDAsyncNotifier = $00010003;

// Constants for enum __MIDL___MIDL_itf_AQtime_0139_0001
type
  __MIDL___MIDL_itf_AQtime_0139_0001 = TOleEnum;
const
  IDAddEventsProvider = $0001601A;
  IDRemoveEventsProvider = $0001601B;
  IDAddEventEx = $0001601C;
  IDRemoveEventEx = $0001601D;
  IDAddDispatcher = $0001601E;
  IDRemoveDispatcher = $0001601F;
  IDGetNotifier = $00016020;
  IDCallEvent = $00016021;
  IDCallEventEx = $00016022;
  IDCallEventVariant = $00016023;

// Constants for enum AQ_PROPERTY_TYPE
type
  AQ_PROPERTY_TYPE = TOleEnum;
const
  AQ_PT_INTEGER = $00000000;
  AQ_PT_STRING = $00000001;
  AQ_PT_DOUBLE = $00000002;
  AQ_PT_LONG = $00000003;
  AQ_PT_BINARY = $00000004;
  AQ_PT_BOOLEAN = $00000005;
  AQ_PT_NOPROPERTY = $00008000;

// Constants for enum AQ_OPTIONS_STORAGE_KIND
type
  AQ_OPTIONS_STORAGE_KIND = TOleEnum;
const
  otUnspecified = $00000000;
  otXML = $00000001;
  otBinary = $00000002;
  otRegistry = $00000003;
  otString = $00000004;

// Constants for enum AQ_OPTIONS_SLICE_MODE
type
  AQ_OPTIONS_SLICE_MODE = TOleEnum;
const
  AQ_OPTIONS_LOCAL_COPY = $00000000;
  AQ_OPTIONS_READ_ONLY = $00000001;
  AQ_OPTIONS_READ_WRITE = $00000002;

// Constants for enum __MIDL___MIDL_itf_AQtime_0157_0001
type
  __MIDL___MIDL_itf_AQtime_0157_0001 = TOleEnum;
const
  IDUIShellApplicationHandle = $00015000;
  IDUIShellMainWindow = $00015001;
  IDUIShellMinimize = $00015002;
  IDUIShellMaximize = $00015003;
  IDUIShellRestore = $00015004;
  IDUIShellVisible = $00015005;
  IDUIShellCaption = $00015006;
  IDUIShellLookAndFeel = $00015007;
  IDUIShellDockingStyle = $00015008;
  IDUIShellShowWindow = $00015009;
  IDUIShellEnableModeless = $0001500A;
  IDUIShellSetCursor = $0001500B;
  IDUIShellResetCursor = $0001500C;
  IDUIShellWindowName = $0001500D;

// Constants for enum __MIDL___MIDL_itf_AQtime_0158_0001
type
  __MIDL___MIDL_itf_AQtime_0158_0001 = TOleEnum;
const
  IDInfoDialogShowForm = $00022000;
  IDInfoDialogHelpId = $00022001;
  IDInfoDialogAddColumn = $00022002;
  IDInfoDialogAddRowValues = $00022003;
  IDInfoDialogDontShowAgain = $00022004;
  IDInfoDialogDontShowAgainVisible = $00022005;
  IDInfoDialogDialogType = $00022006;
  IDInfoDialogText = $00022007;
  IDInfoDialogCaption = $00022008;
  IDInfoDialogHelpFileId = $00022009;

// Constants for enum __MIDL___MIDL_itf_AQtime_0159_0001
type
  __MIDL___MIDL_itf_AQtime_0159_0001 = TOleEnum;
const
  IDCancelNotifierOnCancelPressed = $00025000;

// Constants for enum __MIDL___MIDL_itf_AQtime_0161_0001
type
  __MIDL___MIDL_itf_AQtime_0161_0001 = TOleEnum;
const
  IDMessengerYesNoConfirm = $0001E000;
  IDMessengerYesNoSevere = $0001E001;
  IDMessengerYesNoCancel = $0001E002;
  IDMessengerYesNoMessageAsk = $0001E003;
  IDMessengerYesNoMessageCheck = $0001E004;
  IDMessengerShowMildError = $0001E005;
  IDMessengerShowSevereError = $0001E006;
  IDMessengerShowInformation = $0001E007;
  IDMessengerShowMessageDontAsk = $0001E008;
  IDMessengerCreateInfoDialog = $0001E009;
  IDMessengerShowProgressWaitMessage = $0001E00A;
  IDMessengerShowWaitMessage = $0001E00B;
  IDMessengerHideWaitMessage = $0001E00C;
  IDMessengerWaitProgressValue = $0001E00D;
  IDMessengerWaitMessage = $0001E00E;
  IDWaitForMessageClose = $0001E00F;
  IDShowCustomDialog = $0001E010;
  IDMessengerShowMoreDialog = $0001E011;

// Constants for enum AQ_SETTING_STATE
type
  AQ_SETTING_STATE = TOleEnum;
const
  AQ_SETTING_STATE_READY = $00000000;
  AQ_SETTING_STATE_LOADING = $00000001;
  AQ_SETTING_STATE_UPDATING = $00000002;
  AQ_SETTING_STATE_CANCELING = $00000004;

// Constants for enum AQ_SETTING_TYPE
type
  AQ_SETTING_TYPE = TOleEnum;
const
  AQ_SETTING_BOOLEAN = $00000001;
  AQ_SETTING_INTEGER = $00000002;
  AQ_SETTING_INT64 = $00000003;
  AQ_SETTING_FLOAT = $00000004;
  AQ_SETTING_STRING = $00000005;
  AQ_SETTING_TABLE = $00000006;

// Constants for enum AQ_DBG_SYMBOLSTORE_KIND
type
  AQ_DBG_SYMBOLSTORE_KIND = TOleEnum;
const
  AQ_SSK_UNKNOWN = $00000000;
  AQ_SSK_NATIVE = $00000001;
  AQ_SSK_JAVA = $00000002;
  AQ_SSK_DOTNET = $00000003;

// Constants for enum AQ_DBG_READ_TYPES_DEPTH
type
  AQ_DBG_READ_TYPES_DEPTH = TOleEnum;
const
  AQ_RTD_BASIC = $00000000;
  AQ_RTD_PARAMS = $00000001;
  AQ_RTD_FULL = $00000002;

// Constants for enum AQ_MONITORING_CHANGES
type
  AQ_MONITORING_CHANGES = TOleEnum;
const
  AQ_MC_FILE_DELETE = $00000001;
  AQ_MC_FILE_CREATE = $00000002;
  AQ_MC_ATTRIBUTES = $00000004;
  AQ_MC_LAST_WRITE = $00000008;

// Constants for enum AQDATA_MONIKER_ACTION
type
  AQDATA_MONIKER_ACTION = TOleEnum;
const
  AQDATA_MONIKER_ACTION_UNKNOWN = $00000000;
  AQDATA_MONIKER_ACTION_SELECT = $00000001;
  AQDATA_MONIKER_ACTION_ACTIVATE = $00000002;

// Constants for enum AQ_TEXT_FORMAT_XXX
type
  AQ_TEXT_FORMAT_XXX = TOleEnum;
const
  AQ_TEXT_FORMAT_PLAIN_TEXT = $00000000;
  AQ_TEXT_FORMAT_HTML = $00000001;
  AQ_TEXT_FORMAT_XML = $00000002;
  AQ_TEXT_FORMAT_LINK_TO_TEXT = $00000003;

// Constants for enum TProfileLevel
type
  TProfileLevel = TOleEnum;
const
  plNone = $00000000;
  plClassLevel = $00000001;
  plRoutineLevel = $00000002;
  plLineLevel = $00000003;

// Constants for enum AQ_VIEWS_EVENT
type
  AQ_VIEWS_EVENT = TOleEnum;
const
  AQ_VE_ADDED = $00000001;
  AQ_VE_DELETED = $00000002;
  AQ_VE_RENAMED = $00000003;
  AQ_VE_CHANGED = $00000004;

// Constants for enum AQ_BROWSEOBJECT_ACTION_TYPE
type
  AQ_BROWSEOBJECT_ACTION_TYPE = TOleEnum;
const
  AQ_BOAT_UNKNOWN = $00000000;
  AQ_BOAT_SELECT = $00000001;
  AQ_BOAT_ACTIVATE = $00000002;

// Constants for enum AQ_TEXT_NOTES_TYPE
type
  AQ_TEXT_NOTES_TYPE = TOleEnum;
const
  AQ_TN_PLAIN_TEXT = $00000000;

// Constants for enum AQ_PROFILER_START_OPERATION
type
  AQ_PROFILER_START_OPERATION = TOleEnum;
const
  AQ_PSO_START = $00000000;
  AQ_PSO_ATTACH = $00000001;

// Constants for enum AQ_DYNAMIC_PROFILER_FEATURES
type
  AQ_DYNAMIC_PROFILER_FEATURES = TOleEnum;
const
  AQ_DPF_START_PROCESS = $00000001;
  AQ_DPF_ATTACH_TO_PROCESS = $00000002;
  AQ_DPF_TAKE_SNAPSHOT = $00000004;
  AQ_DPF_ENABLE_PROFILING = $00000008;
  AQ_DPF_CLEAR_RESULTS = $00000010;
  AQ_DPF_PROFILE_SCRIPTS = $00000020;

// Constants for enum AQ_PROFILER_EVENT
type
  AQ_PROFILER_EVENT = TOleEnum;
const
  AQ_PEV_BEFORE_START = $00000001;
  AQ_PEV_BEFORE_ATTACH = $00000002;
  AQ_PEV_AFTER_STOP = $00000004;
  AQ_PEV_AFTER_TERMINATE = $00000005;
  AQ_PEV_AFTER_ACTIVATE = $00000006;
  AQ_PEV_BEFORE_DEACTIVATE = $00000007;
  AQ_PEV_NEW_RESULTS_READY = $00000008;
  AQ_PEV_RESULTS_LOADED = $00000009;
  AQ_PEV_ADDED = $0000000A;
  AQ_PEV_DELETED = $0000000B;
  AQ_PEV_RUN_PARAMETERS_CHANGED = $0000000C;
  AQ_PEV_ENABLE_PROFILING = $0000000D;
  AQ_PEV_DISABLE_PROFILING = $0000000E;
  AQ_PEV_START_FAILED = $0000000F;
  AQ_PEV_ATTACH_FAILED = $00000010;
  AQ_PEV_CLEAR_RESULTS = $00000011;

// Constants for enum AQ_SETUP_FEATURE
type
  AQ_SETUP_FEATURE = TOleEnum;
const
  AQ_SF_ENABLE_CLASS_LEVEL = $00000001;
  AQ_SF_ENABLE_ROUTINE_LEVEL = $00000002;
  AQ_SF_ENABLE_LINE_LEVEL = $00000004;
  AQ_SF_ENABLE_TRIGGERS = $00000008;
  AQ_SF_ENABLE_ACTIONS = $00000010;
  AQ_SF_STANDARD_SOURCES_EXCLUSION = $00000020;

// Constants for enum _AQ_PROFILE_PLATFORM_INFO
type
  _AQ_PROFILE_PLATFORM_INFO = TOleEnum;
const
  AQ_PPI_Native = $00000001;
  AQ_PPI_DotNet = $00000002;
  AQ_PPI_Script = $00000004;
  AQ_PPI_Java = $00000008;

// Constants for enum __MIDL___MIDL_itf_AQtime_0257_0001
type
  __MIDL___MIDL_itf_AQtime_0257_0001 = TOleEnum;
const
  IDProfilerFeatures = $00010101;
  IDIsSupportMode = $00010102;
  IDCanStart = $00010103;
  IDStart = $00010104;
  IDCanAttach = $00010105;
  IDAttach = $00010106;
  IDDetach = $00010107;
  IDTakeSnapshot = $00010108;
  IDEnableProfiling = $00010109;
  IDClearResults = $0001010A;

// Constants for enum IDProjects
type
  IDProjects = TOleEnum;
const
  IDProjectOpen = $0100C001;
  IDProjectOpenFile = $0100C002;
  IDProjectCreateEmpty = $0100C003;
  IDProjectCanClose = $0100C004;
  IDProjectSave = $0100C005;
  IDProjectSaveAs = $0100C006;
  IDProjectClose = $0100C007;
  IDProjectIsOpen = $0100C008;
  IDProjectModified = $0100C009;
  IDProjectRecentCount = $0100C00A;
  IDProjectRecent = $0100C00B;
  IDProjectModules = $0100C00C;

// Constants for enum ModuleCollectionIDs
type
  ModuleCollectionIDs = TOleEnum;
const
  ModuleCollection_Count_ID = $0100C004;
  ModuleCollection_Modules_ID = $0100C005;
  ModuleCollection_ModuleByName_ID = $0100C006;
  ModuleCollection_Add_ID = $0100C007;
  ModuleCollection_Remove_ID = $0100C008;
  ModuleCollection_ActiveModule_ID = $0100C009;

// Constants for enum ProjectEventsIDS
type
  ProjectEventsIDS = TOleEnum;
const
  ProjectEvents_ProjectStartLoadingID = $0100A001;
  ProjectEvents_ProjectLoadID = $0100A002;
  ProjectEvents_DebugSymbolsRead_ID = $0100A003;
  ProjectEvent_DebugSymbolRefreshed = $0100A004;
  ProjectEvents_ModuleAdded_ID = $0100A005;
  ProjectEvents_ModuleRemoved_ID = $0100A006;
  ProjectEvents_ModuleActivate_ID = $0100A007;
  ProjectEvents_ProjectClosed = $0100A008;

// Constants for enum IaqModule_IDS
type
  IaqModule_IDS = TOleEnum;
const
  ModuleSymbolStoreCountID = $01009001;
  ModuleSymbolStoreID = $01009002;
  ModuleFullFileNameID = $01009003;
  ModuleAvailableID = $01009004;
  ModuleActiveID = $01009005;

// Constants for enum TSelection
type
  TSelection = TOleEnum;
const
  asSelected = $00000000;
  asUnselected = $00000001;
  asGrayed = $00000002;

// Constants for enum TAreaType
type
  TAreaType = TOleEnum;
const
  atInclude = $00000000;
  atExclude = $00000001;

// Constants for enum TTriggerType
type
  TTriggerType = TOleEnum;
const
  ttOn = $00000000;
  ttOff = $00000001;

// Constants for enum TActionType
type
  TActionType = TOleEnum;
const
  atEnableProfiling = $00000000;
  atDisableProfiling = $00000001;
  atGetResult = $00000002;
  atClearResults = $00000003;

// Constants for enum TExecuteType
type
  TExecuteType = TOleEnum;
const
  etOnEnter = $00000000;
  etOnExit = $00000001;

// Constants for enum TaqAreaItemOptions
type
  TaqAreaItemOptions = TOleEnum;
const
  AQ_AO_SELECTED_AS_CLASS_LEVEL = $00000001;
  AQ_AO_SELECTED_AS_ROUTINE_LEVEL = $00000002;
  AQ_AO_SELECTED_AS_LINE_LEVEL = $00000004;
  AQ_AO_SELECTED_AS_TRIGGER = $00000008;
  AQ_AO_SELECTED_AS_ACTION = $00000010;
  AQ_AO_RETRIEVE_PARAMETER_VALUES = $00000020;

// Constants for enum _AQ_SEARCH_PATH_CHANGE
type
  _AQ_SEARCH_PATH_CHANGE = TOleEnum;
const
  AQ_SPC_GLOBAL = $00000001;
  AQ_SPC_PROJECT = $00000002;

// Constants for enum TaqPlatformComplianceType
type
  TaqPlatformComplianceType = TOleEnum;
const
  pcSupported = $00000000;
  pcObsolete = $00000001;
  pcNonFunctional = $00000002;
  pcSpecialUsage = $00000003;
  pcSpecialRequirements = $00000004;
  pcUnknown = $00000005;
  pcUnsupported = $00000006;

// Constants for enum TaqTypeID
type
  TaqTypeID = TOleEnum;
const
  ttUnknown = $00000000;
  ttFunction = $00000001;
  ttStructure = $00000002;
  ttType = $00000003;
  ttUnion = $00000004;

// Constants for enum TaqResultValueType
type
  TaqResultValueType = TOleEnum;
const
  rtValue = $00000000;
  rtConstant = $00000001;

// Constants for enum TaqAllocateResourceType
type
  TaqAllocateResourceType = TOleEnum;
const
  atUnknown = $00000000;
  atAllocate = $00000001;
  atReallocate = $00000002;
  atDeallocate = $00000003;
  atCustomProcessing = $00000004;

// Constants for enum TaqResultValueCheckType
type
  TaqResultValueCheckType = TOleEnum;
const
  ctEqual = $00000000;
  ctNotEqual = $00000001;
  ctAlwaysSuccessful = $00000003;
  ctSucceded = $00000004;

// Constants for enum TaqInOutParamType
type
  TaqInOutParamType = TOleEnum;
const
  ptIn = $00000000;
  ptOut = $00000001;
  ptInOut = $00000002;
  ptUnknown = $00000003;

// Constants for enum TaqArrayRef
type
  TaqArrayRef = TOleEnum;
const
  arUnknown = $00000000;
  arPointerToArray = $00000001;
  arArray = $00000002;

// Constants for enum TaqValueType
type
  TaqValueType = TOleEnum;
const
  vtUnknown = $00000000;
  vtSigned32 = $00000001;
  vtString = $00000002;
  vtBool = $00000003;
  vtConstant = $00000004;
  vtUNIString = $00000005;
  vtByte = $00000006;
  vtSigned16 = $00000007;
  vtSigned64 = $00000008;
  vtUnsigned16 = $00000009;
  vtUnsigned32 = $0000000A;
  vtUnsigned64 = $0000000B;
  vtFloat = $0000000C;
  vtPointer32 = $0000000D;
  vtPointer64 = $0000000E;
  vtVariant = $0000000F;
  vtBStr = $00000010;
  vtGUID = $00000011;
  vtResourceStrOrInt = $00000012;

// Constants for enum TaqSetAttribute
type
  TaqSetAttribute = TOleEnum;
const
  saAddressInStack = $00000001;
  saAddressInMemory = $00000002;
  saValueInStack = $00000004;
  saValueInMemory = $00000008;
  saCurrentValue = $00000010;

// Constants for enum TaqCheckErrorType
type
  TaqCheckErrorType = TOleEnum;
const
  ceGetLastError = $00000000;
  ceFunctionResult = $00000001;

// Constants for enum AQPROF_TABLE_SCHEMA_FLAGS
type
  AQPROF_TABLE_SCHEMA_FLAGS = TOleEnum;
const
  AQPROF_TSF_NONE = $00000000;
  AQPROF_TSF_EXPLORE = $00000001;
  AQPROF_TSF_PRIVATE = $00000002;
  AQPROF_TSF_INLINED = $00000004;

// Constants for enum AQPROF_TABLE_COLUMN_TYPE
type
  AQPROF_TABLE_COLUMN_TYPE = TOleEnum;
const
  AQPROF_TCT_EMPTY = $00000000;
  AQPROF_TCT_BOOL = $00000001;
  AQPROF_TCT_INT8 = $00000002;
  AQPROF_TCT_UINT8 = $00000003;
  AQPROF_TCT_INT16 = $00000004;
  AQPROF_TCT_UINT16 = $00000005;
  AQPROF_TCT_INT32 = $00000006;
  AQPROF_TCT_UINT32 = $00000007;
  AQPROF_TCT_INT64 = $00000008;
  AQPROF_TCT_UINT64 = $00000009;
  AQPROF_TCT_FLOAT = $0000000A;
  AQPROF_TCT_DOUBLE = $0000000B;
  AQPROF_TCT_BSTR = $0000000C;
  AQPROF_TCT_BUFFER = $0000000D;
  AQPROF_TCT_BITMAP = $0000000E;
  AQPROF_TCT_LINK = $0000000F;
  AQPROF_TCT_STRING_LOOKUP = $00000010;
  AQPROF_TCT_TABLE_LOOKUP = $00000011;
  AQPROF_TCT_FILENAME_LOOKUP = $00000012;
  AQPROF_TCT_WINAPIDB_LOOKUP = $00000013;
  AQPROF_TCT_PUBLISHED_COLUMN = $00000014;
  AQPROF_TCT_INVALID = $00000015;

// Constants for enum AQPROF_TABLE_COLUMN_MERGE_KIND
type
  AQPROF_TABLE_COLUMN_MERGE_KIND = TOleEnum;
const
  AQPROF_TCMK_NONE = $00000000;
  AQPROF_TCMK_COPY = $00000001;
  AQPROF_TCMK_SUM = $00000002;
  AQPROF_TCMK_DIFFERENCE = $00000004;
  AQPROF_TCMK_PRODUCT = $00000008;
  AQPROF_TCMK_QUOTIENT = $00000010;
  AQPROF_TCMK_MAX = $00000020;
  AQPROF_TCMK_MIN = $00000040;
  AQPROF_TCMK_AVERAGE = $00000080;
  AQPROF_TCMK_INVALID = $00000081;

// Constants for enum AQPROF_TABLE_COLUMN_SUMMARY
type
  AQPROF_TABLE_COLUMN_SUMMARY = TOleEnum;
const
  AQPROF_TCS_NONE = $00000000;
  AQPROF_TCS_SUM = $00000001;
  AQPROF_TCS_INVALID = $00000002;

// Constants for enum AQPROF_EVENT
type
  AQPROF_EVENT = TOleEnum;
const
  AQPROF_EVENT_NONE = $00000000;
  AQPROF_EVENT_THREAD_CREATE = $00000001;
  AQPROF_EVENT_THREAD_DESTROY = $00000002;
  AQPROF_EVENT_ROUTINE_ENTER = $00000003;
  AQPROF_EVENT_ROUTINE_LEAVE = $00000004;
  AQPROF_EVENT_LINE_ENTER = $00000005;
  AQPROF_EVENT_EXCEPTION_THROWN = $00000006;
  AQPROF_EVENT_OBJECT_CREATE = $00000007;
  AQPROF_EVENT_OBJECT_DELETE = $00000008;
  AQPROF_EVENT_REFERENCE_CREATE = $00000009;
  AQPROF_EVENT_REFERENCE_DELETE = $0000000A;
  AQPROF_EVENT_CLEAR_REFERENCES = $0000000B;
  AQPROF_EVENT_ROOT_REFERENCE = $0000000C;
  AQPROF_EVENT_MEMORY_ALLOC = $0000000D;
  AQPROF_EVENT_MEMORY_FREE = $0000000E;
  AQPROF_EVENT_GC_STARTED = $0000000F;
  AQPROF_EVENT_GC_FINISHED = $00000010;
  AQPROF_EVENT_ENABLED_CHANGED = $00000011;
  AQPROF_EVENT_WINAPI_ERROR = $00000012;
  AQPROF_EVENT_ROUTINE_ENTER_WPARAM = $00000013;
  AQPROF_EVENT_ROUTINE_LEAVE_WPARAM = $00000014;
  AQPROF_EVENT_BEGIN_CLEAR_RESULTS = $00000015;
  AQPROF_EVENT_END_CLEAR_RESULTS = $00000016;
  AQPROF_EVENT_ADDREF = $00000017;
  AQPROF_EVENT_RELEASE = $00000018;
  AQPROF_EVENT_ROUTINE_ENTER_FILTERED = $00000019;
  AQPROF_EVENT_ROUTINE_LEAVE_FILTERED = $0000001A;
  AQPROF_EVENT_ROUTINE_ENTER_FLOW_CONTROL = $0000001B;
  AQPROF_EVENT_ROUTINE_LEAVE_FLOW_CONTROL = $0000001C;
  AQPROF_EVENT_ADD_ERROR_REPORT = $0000001D;
  AQPROF_EVENT_MAX = $0000001E;

// Constants for enum AQPROF_ACTION_TYPE
type
  AQPROF_ACTION_TYPE = TOleEnum;
const
  AQPROF_ACTION_ENABLE_PROFILING = $00000000;
  AQPROF_ACTION_DISABLE_PROFILING = $00000001;
  AQPROF_ACTION_TAKE_SNAPSHOT = $00000002;
  AQPROF_ACTION_CLEAR_RESULTS = $00000003;

// Constants for enum AQPROF_ACTION_PLACEMENT
type
  AQPROF_ACTION_PLACEMENT = TOleEnum;
const
  AQPROF_ACTION_ON_ROUTINE_ENTER = $00000000;
  AQPROF_ACTION_ON_ROUTINE_LEAVE = $00000001;

// Constants for enum AQPROF_LEAKFILTER_COMPILERS
type
  AQPROF_LEAKFILTER_COMPILERS = TOleEnum;
const
  AQPROF_LFC_UNKNOWN = $00000000;
  AQPROF_LFC_MSVC6 = $00000001;
  AQPROF_LFC_DELPHI7 = $00000002;
  AQPROF_LFC_BUILDER6_DELPHI6 = $00000003;
  AQPROF_LFC_BUILDER5_DELPHI5 = $00000004;
  AQPROF_LFC_BUILDER4_DELPHI4 = $00000005;
  AQPROF_LFC_BUILDER3_DELPHI3 = $00000006;
  AQPROF_LFC_MSVS2005 = $00000007;
  AQPROF_LFC_INVALID = $00000008;

// Constants for enum AQPROF_TABLE_COLUMN_CALLBACK_EVENTS
type
  AQPROF_TABLE_COLUMN_CALLBACK_EVENTS = TOleEnum;
const
  AQPROF_TCCE_NONE = $00000000;
  AQPROF_TCCE_GET_VALUE = $00000001;
  AQPROF_TCCE_COPY = $00000002;
  AQPROF_TCCE_MERGE = $00000004;
  AQPROF_TCCE_INVALID = $00000008;

// Constants for enum AQPROF_TABLE_COLUMN_METADATA_FLAGS
type
  AQPROF_TABLE_COLUMN_METADATA_FLAGS = TOleEnum;
const
  AQPROF_TCMF_NONE = $00000000;
  AQPROF_TCMF_KEY = $00000001;
  AQPROF_TCMF_PUBLISH = $00000002;
  AQPROF_TCMF_INVALID = $00000004;
  AQPROF_TCMF_DO_NOT_EXPORT_TO_DB = $00000008;

// Constants for enum AQPROF_WINAPI_ERROR_KIND
type
  AQPROF_WINAPI_ERROR_KIND = TOleEnum;
const
  AQPROF_WINAPI_ERROR = $00000001;
  AQPROF_WINAPI_WARNING = $00000002;

// Constants for enum AQPROF_COLLECT_CALLSTACK
type
  AQPROF_COLLECT_CALLSTACK = TOleEnum;
const
  AQPROF_CCS_NONE = $00000000;
  AQPROF_CCS_ROUTINES = $00000001;
  AQPROF_CCS_LINES = $00000002;

// Constants for enum AQ_CLR_PATCH_EVENT
type
  AQ_CLR_PATCH_EVENT = TOleEnum;
const
  AQ_PE_OPCODE = $00000001;
  AQ_PE_FUNCTION_ENTER = $00000002;
  AQ_PE_FUNCTION_LEAVE = $00000004;
  AQ_PE_LINE_ENTER = $00000008;
  AQ_PE_MAX = $00000009;

// Constants for enum AQ_CLR_OPFLOW
type
  AQ_CLR_OPFLOW = TOleEnum;
const
  AQ_FLOW_META = $00000000;
  AQ_FLOW_CALL = $00000001;
  AQ_FLOW_BRANCH = $00000002;
  AQ_FLOW_COND_BRANCH = $00000003;
  AQ_FLOW_PHI = $00000004;
  AQ_FLOW_THROW = $00000005;
  AQ_FLOW_BREAK = $00000006;
  AQ_FLOW_RETURN = $00000007;
  AQ_FLOW_NEXT = $00000008;

// Constants for enum AQNATSYM_APPLICATION_TYPE
type
  AQNATSYM_APPLICATION_TYPE = TOleEnum;
const
  AQNATSYM_APPLICATION_NONE = $00000001;
  AQNATSYM_APPLICATION_BUILDER = $00000002;
  AQNATSYM_APPLICATION_DELPHI = $00000003;
  AQNATSYM_APPLICATION_GCC = $00000004;
  AQNATSYM_APPLICATION_KYLIX = $00000005;
  AQNATSYM_APPLICATION_MSVC = $00000006;
  AQNATSYM_APPLICATION_MSVC7 = $00000007;
  AQNATSYM_APPLICATION_CLARION = $00000008;
  AQNATSYM_APPLICATION_VB = $00000009;

// Constants for enum AQNATSYM_SYSTEM_TYPE
type
  AQNATSYM_SYSTEM_TYPE = TOleEnum;
const
  AQNATSYM_SYSTEM_UNKNOWN = $00000001;
  AQNATSYM_SYSTEM_X86 = $00000002;
  AQNATSYM_SYSTEM_X64 = $00000003;

// Constants for enum AQNATSYM_CALLING_CONVENTION
type
  AQNATSYM_CALLING_CONVENTION = TOleEnum;
const
  AQNATSYM_C_CALL = $00000001;
  AQNATSYM_FAST_CALL = $00000002;
  AQNATSYM_STD_CALL = $00000003;
  AQNATSYM_SYS_CALL = $00000004;
  AQNATSYM_THIS_CALL = $00000005;
  AQNATSYM_PASCAL_CALL = $00000006;
  AQNATSYM_DELPHI_CALL = $00000007;

// Constants for enum AQNATSYM_TYPE_KIND
type
  AQNATSYM_TYPE_KIND = TOleEnum;
const
  AQNATSYM_TYPE_UNKNOWN = $00000000;
  AQNATSYM_TYPE_VOID = $00000001;
  AQNATSYM_TYPE_CHAR = $00000002;
  AQNATSYM_TYPE_UCHAR = $00000003;
  AQNATSYM_TYPE_WCHAR = $00000004;
  AQNATSYM_TYPE_PAS_CHAR = $00000005;
  AQNATSYM_TYPE_PCHAR = $00000006;
  AQNATSYM_TYPE_SHORT = $00000007;
  AQNATSYM_TYPE_USHORT = $00000008;
  AQNATSYM_TYPE_INT = $00000009;
  AQNATSYM_TYPE_UINT = $0000000A;
  AQNATSYM_TYPE_LONG = $0000000B;
  AQNATSYM_TYPE_ULONG = $0000000C;
  AQNATSYM_TYPE_INT64 = $0000000D;
  AQNATSYM_TYPE_UINT64 = $0000000E;
  AQNATSYM_TYPE_FLOAT = $0000000F;
  AQNATSYM_TYPE_DOUBLE = $00000010;
  AQNATSYM_TYPE_REAL48 = $00000011;
  AQNATSYM_TYPE_EXTENDED = $00000012;
  AQNATSYM_TYPE_REAL128 = $00000013;
  AQNATSYM_TYPE_COMPLEX = $00000014;
  AQNATSYM_TYPE_COMPLEX32 = $00000015;
  AQNATSYM_TYPE_COMPLEX64 = $00000016;
  AQNATSYM_TYPE_COMPLEX80 = $00000017;
  AQNATSYM_TYPE_COMPLEX128 = $00000018;
  AQNATSYM_TYPE_BCD = $00000019;
  AQNATSYM_TYPE_BOOL = $0000001A;
  AQNATSYM_TYPE_WORDBOOL = $0000001B;
  AQNATSYM_TYPE_LONGBOOL = $0000001C;
  AQNATSYM_TYPE_CURRENCY = $0000001D;
  AQNATSYM_TYPE_DATE = $0000001E;
  AQNATSYM_TYPE_VARIANT = $0000001F;
  AQNATSYM_TYPE_BIT = $00000020;
  AQNATSYM_TYPE_BSTR = $00000021;
  AQNATSYM_TYPE_HRESULT = $00000022;
  AQNATSYM_TYPE_ENUM = $00000023;
  AQNATSYM_TYPE_POINTER = $00000024;
  AQNATSYM_TYPE_FUNCTION = $00000025;
  AQNATSYM_TYPE_CLASS = $00000026;
  AQNATSYM_TYPE_STRUCT = $00000027;
  AQNATSYM_TYPE_UNION = $00000028;
  AQNATSYM_TYPE_SUBRANGE = $00000029;
  AQNATSYM_TYPE_MODIFIER = $0000002A;
  AQNATSYM_TYPE_LSTRING = $0000002B;
  AQNATSYM_TYPE_WSTRING = $0000002C;
  AQNATSYM_TYPE_SET = $0000002D;
  AQNATSYM_TYPE_CLASSREF = $0000002E;
  AQNATSYM_TYPE_INTERFACE = $0000002F;

// Constants for enum AQNATSYM_ACCESS_TYPE
type
  AQNATSYM_ACCESS_TYPE = TOleEnum;
const
  AQNATSYM_PUBLIC = $00000001;
  AQNATSYM_PRIVATE = $00000002;
  AQNATSYM_PROTECTED = $00000003;

// Constants for enum AQNATSYM_THIS_LOCATION
type
  AQNATSYM_THIS_LOCATION = TOleEnum;
const
  AQNATSYM_LOCATION_UNKNOWN = $00000000;
  AQNATSYM_LOCATION_EAX = $00000001;
  AQNATSYM_LOCATION_ECX = $00000002;
  AQNATSYM_LOCATION_EDX = $00000003;
  AQNATSYM_LOCATION_EBX = $00000004;
  AQNATSYM_LOCATION_ESP = $00000005;
  AQNATSYM_LOCATION_EBP = $00000006;
  AQNATSYM_LOCATION_ESI = $00000007;
  AQNATSYM_LOCATION_EDI = $00000008;
  AQNATSYM_LOCATION_RAX = $00000009;
  AQNATSYM_LOCATION_RBX = $0000000A;
  AQNATSYM_LOCATION_RCX = $0000000B;
  AQNATSYM_LOCATION_RDX = $0000000C;
  AQNATSYM_LOCATION_RSI = $0000000D;
  AQNATSYM_LOCATION_RDI = $0000000E;
  AQNATSYM_LOCATION_RBP = $0000000F;
  AQNATSYM_LOCATION_RSP = $00000010;
  AQNATSYM_LOCATION_R8 = $00000011;
  AQNATSYM_LOCATION_R9 = $00000012;
  AQNATSYM_LOCATION_R10 = $00000013;
  AQNATSYM_LOCATION_R11 = $00000014;
  AQNATSYM_LOCATION_R12 = $00000015;
  AQNATSYM_LOCATION_R13 = $00000016;
  AQNATSYM_LOCATION_R14 = $00000017;
  AQNATSYM_LOCATION_R15 = $00000018;
  AQNATSYM_LOCATION_STACK = $00000019;

// Constants for enum AQPatchType
type
  AQPatchType = TOleEnum;
const
  ptCall = $00000000;
  ptMove = $00000001;

// Constants for enum AQ_PEIMAGE_APPTYPE
type
  AQ_PEIMAGE_APPTYPE = TOleEnum;
const
  piaUnknown = $00000000;
  piaX86 = $00000001;
  piaX64 = $00000002;
  piaARM = $00000003;
  piaThumb = $00000004;

// Constants for enum AQ_PEIMAGE_APPTYPE_EX
type
  AQ_PEIMAGE_APPTYPE_EX = TOleEnum;
const
  piaeUnknown = $00000000;
  piaeX86 = $00000001;
  piaeX64 = $00000002;
  piaeCLRAny = $00000003;
  piaeARM = $00000004;
  piaeThumb = $00000005;

// Constants for enum HighlightWindowType
type
  HighlightWindowType = TOleEnum;
const
  hwtNormal = $00000000;
  hwtOnScreen = $00000001;
  hwtVisibleOnly = $00000002;

// Constants for enum DWMNCRenderingPolicy
type
  DWMNCRenderingPolicy = TOleEnum;
const
  drpUseWindowStyle = $00000000;
  drpDisabled = $00000001;
  drpEnabled = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IaqIterator = interface;
  IaqUnknownIterator = interface;
  IaqGUIDIterator = interface;
  IaqModuleIntf = interface;
  IaqModuleIntfNotifier = interface;
  IaqKeyItem = interface;
  IaqStream = interface;
  IaqPersistStream = interface;
  IaqStringIterator = interface;
  IaqActionItem = interface;
  IaqActionNotifier = interface;
  IaqSubsystemManager = interface;
  IaqSubsystemManagerDisp = dispinterface;
  IaqBaseManager = interface;
  IaqBaseManagerDisp = dispinterface;
  IaqProductInfo = interface;
  IaqProductInfoDisp = dispinterface;
  IaqActionManager = interface;
  IaqActionManagerDisp = dispinterface;
  IaqActionProvider = interface;
  IaqActionsContainer = interface;
  IaqSubMenu = interface;
  IaqToolbar = interface;
  IaqPopupMenu = interface;
  IaqActionsCustomizer = interface;
  IaqHelpSystemManager = interface;
  IaqHelpSystemManagerDisp = dispinterface;
  IaqBaseEvent = interface;
  IaqEventDispatcher = interface;
  IaqRegistrationInfo = interface;
  IaqEventsListenerProvider = interface;
  IaqEventManager = interface;
  IaqEventManagerDisp = dispinterface;
  IaqBeforeEvent = interface;
  IaqAfterEvent = interface;
  IaqOptionsNode = interface;
  IaqOptionsNodeIterator = interface;
  IaqProperties = interface;
  IaqPropertiesIterator = interface;
  IaqPropertiesEx = interface;
  IaqOptionsNodeStore = interface;
  IaqOptionsProvider = interface;
  IaqBasePlugin = interface;
  IaqExtendedPlugin = interface;
  IaqPluginInformationRepository = interface;
  IaqPluginInformation = interface;
  IaqExtensionRegistrator = interface;
  IaqWindowProvider = interface;
  IaqWhatsThisSupportProvider = interface;
  IaqUIShell = interface;
  IaqUIShellDisp = dispinterface;
  IaqInfoDialog = interface;
  IaqCancelNotifier = interface;
  IaqCancelNotifierDisp = dispinterface;
  IaqSelectionProvider = interface;
  IaqSelectionProviderDisp = dispinterface;
  IaqMessenger = interface;
  IaqMessengerDisp = dispinterface;
  IaqSilentLog = interface;
  IaqSettingsManager_DVS = interface;
  IaqSettingsManager_DVSDisp = dispinterface;
  IaqBaseSetting_DVS = interface;
  IaqBaseSetting_DVSDisp = dispinterface;
  IaqSettingsManagerIntegration_DVS = interface;
  IaqSettingsManagerIntegration_DVSDisp = dispinterface;
  IaqTableSettingSchema_DVS = interface;
  IaqTableSetting_DVS = interface;
  IaqSettingsProvider_DVS = interface;
  IaqSettings_DVS = interface;
  IaqSettingIterator_DVS = interface;
  IaqSettingsActionsProvider = interface;
  IaqSettingsUpdateListener_DVS = interface;
  IaqSettingsGroup = interface;
  IaqSettingValidator = interface;
  IaqUnknownCollection = interface;
  IaqDumpStringsManager = interface;
  IaqDumpStringsManagerDisp = dispinterface;
  IaqDbgSymbolManager = interface;
  IaqDbgSymbolType = interface;
  IaqDbgSymbolStoreIterator = interface;
  IaqDbgSymbolStore = interface;
  IaqDbgSymbol = interface;
  IaqDbgSymbolReader = interface;
  IaqDbgSymbolReaderCallback = interface;
  IaqDbgSymbolReaderEx = interface;
  IaqDbgSymbolReference = interface;
  IaqDbgSourceFile = interface;
  IaqDbgRoutine = interface;
  IaqDbgClass = interface;
  IaqDbgSymbolReaderBeginEndListener = interface;
  IaqDbgSymbolStoreEx = interface;
  IaqIdleProvider = interface;
  IaqContextManager = interface;
  IaqContextProvider = interface;
  IaqContextManager2 = interface;
  IaqContextChangedEvent = interface;
  IaqFileMonitorManager = interface;
  IaqFileChangeEvent = interface;
  IaqDataProviderStorage_XXX = interface;
  IaqDataProvider_XXX = interface;
  IaqDataSchema_XXX = interface;
  IaqDataMoniker_XXX = interface;
  IaqDataContainerProvider_XXX = interface;
  IaqDataTableProvider_XXX = interface;
  IaqDataTextProvider_XXX = interface;
  IaqDataLinkListener_XXX = interface;
  IaqDataMonikerProvider_XXX = interface;
  IaqDataTableMonikerProvider_XXX = interface;
  IaqDataContainerSchema_XXX = interface;
  IaqDataTableSchema_XXX = interface;
  IaqDataBandedTableSchema_XXX = interface;
  IaqDataPictureProvider_XXX = interface;
  IaqDataPictureSchema_XXX = interface;
  IaqFilterTableSchema = interface;
  IaqFilterTableProvider = interface;
  IaqDataNavigationSchema = interface;
  IaqDataNavigationProvider = interface;
  IaqDataTreeProvider_XXX = interface;
  IaqDataGraphSchema_XXX = interface;
  IaqDataDiagramSchema_XXX = interface;
  IaqDataTreeSchema_XXX = interface;
  IaqDataTextSchema_XXX = interface;
  IaqSymbolDataMoniker_XXX = interface;
  IaqDataProviderEvent_XXX = interface;
  IaqExportImportProvider = interface;
  IaqTimeProductInfo = interface;
  IaqTimeProductInfoDisp = dispinterface;
  IaqViews = interface;
  IaqViewEvent = interface;
  IaqViewsEvent = interface;
  IaqEventViewCallBack = interface;
  IaqEventViewEngineManager = interface;
  IaqEventViewEngineManagerDisp = dispinterface;
  IaqResultsStorageItem = interface;
  IaqResultsStorageItemDisp = dispinterface;
  IaqResult = interface;
  IaqResultDisp = dispinterface;
  IaqResultNode = interface;
  IaqResultNodeDisp = dispinterface;
  IaqMetaProvider = interface;
  IaqDataProvider = interface;
  IaqDataSchema = interface;
  IaqBrowseObject = interface;
  IaqDataSchemaEx = interface;
  IaqTableDataSchema = interface;
  IaqTableBand = interface;
  IaqTableDataProvider = interface;
  IaqTableDataProviderEx = interface;
  IaqNotepadProvider = interface;
  IaqGraphDataProvider = interface;
  IaqSourceFileProvider = interface;
  IaqCallGraphDataProvider = interface;
  IaqSummaryDataProvider = interface;
  IaqTextNotesDataProvider = interface;
  IaqTextNotesSchema = interface;
  IaqBrowseDataEvent = interface;
  IaqSourceFilesProvider = interface;
  IaqSymbolMonikerProvider = interface;
  IaqProfilersManager = interface;
  IaqProfilersManagerDisp = dispinterface;
  IaqBaseProfiler = interface;
  IaqRunMode = interface;
  IaqDynamicProfiler = interface;
  IaqStaticProfiler = interface;
  IaqSetupProvider = interface;
  IaqLaunchProvider = interface;
  IaqResultsProvider = interface;
  IaqCompactResultsProvider = interface;
  IaqMergeProvider = interface;
  IaqCompareProvider = interface;
  IaqResultsThreadRenamer = interface;
  IaqProfilersManagerExtender = interface;
  IaqProfilerEvent = interface;
  IaqNormalRunMode = interface;
  IaqNormalRunModeDisp = dispinterface;
  IaqCOMRunMode = interface;
  IaqCOMRunModeDisp = dispinterface;
  IaqASPNETRunMode = interface;
  IaqASPNETRunModeDisp = dispinterface;
  IaqServiceRunMode = interface;
  IaqServiceRunModeDisp = dispinterface;
  IaqIISAppRunMode = interface;
  IaqIISAppRunModeDisp = dispinterface;
  IaqDebuggerEvent = interface;
  IaqDebuggerEventEx = interface;
  IaqClrDebuggerEvent = interface;
  IaqModuleCollection = interface;
  IaqModuleCollectionDisp = dispinterface;
  IaqModule = interface;
  IaqModuleDisp = dispinterface;
  IaqProjectEvent = interface;
  IaqProjectManager = interface;
  IaqProjectManagerDisp = dispinterface;
  IaqSetupEvent = interface;
  IaqSetupElement = interface;
  IaqSetupElementDisp = dispinterface;
  IaqSetupTrigger = interface;
  IaqSetupTriggerDisp = dispinterface;
  IaqSetupArea = interface;
  IaqSetupAreaDisp = dispinterface;
  IaqSetupAction = interface;
  IaqSetupActionDisp = dispinterface;
  IaqAreaItem = interface;
  IaqAreaItemDisp = dispinterface;
  IaqAreaTriggerItem = interface;
  IaqAreaTriggerItemDisp = dispinterface;
  IaqAreaActionItem = interface;
  IaqAreaActionItemDisp = dispinterface;
  IaqSetupManager = interface;
  IaqSetupManagerDisp = dispinterface;
  IaqSearchFileManager = interface;
  IaqSearchFileManagerDisp = dispinterface;
  IaqSearchFileManagerEvent = interface;
  IaqShowSymbolEvent = interface;
  IaqDisassemblerManager = interface;
  IaqDisassemblerManagerDisp = dispinterface;
  IaqDisassembler = interface;
  IaqModuleAnalyzer = interface;
  IaqRoutineAnalyzer = interface;
  IaqCodeDisassembler = interface;
  IaqComparingManager = interface;
  IaqComparingManagerDisp = dispinterface;
  IaqReportProvider_XXX = interface;
  IaqNotePadProvider_XXX = interface;
  IaqSummaryProvider_XXX = interface;
  IaqCallGraphProvider_XXX = interface;
  IaqGraphProvider_XXX = interface;
  IaqSourceFilesProvider_XXX = interface;
  IaqSourceFileProvider_XXX = interface;
  IaqGutterProvider_XXX = interface;
  IaqCommentsProvider_XXX = interface;
  IaqTimeIntegrationRunMode = interface;
  IaqTimeIntegrationRunModeDisp = dispinterface;
  IaqTimeIntegrationSupportManager = interface;
  IaqTimeIntegrationSupportManagerDisp = dispinterface;
  IaqBaseFunction = interface;
  IaqCustomIterator = interface;
  IaqCustomIteratorDisp = dispinterface;
  IaqSubCategoriesIterator = interface;
  IaqSubCategoriesIteratorDisp = dispinterface;
  IaqCategoriesIterator = interface;
  IaqCategoriesIteratorDisp = dispinterface;
  IaqFunctionsIterator = interface;
  IaqFunctionsIteratorDisp = dispinterface;
  IaqCustomParameter = interface;
  IaqCustomParameterDisp = dispinterface;
  IaqFunctionParameter = interface;
  IaqFunctionParameterDisp = dispinterface;
  IaqCustomIdentifier = interface;
  IaqFunction = interface;
  IaqFunctionDisp = dispinterface;
  IaqPlatformsIterator = interface;
  IaqPlatformsIteratorDisp = dispinterface;
  IaqWinAPIDatabase = interface;
  IaqWinAPIDatabaseDisp = dispinterface;
  IaqWinAPIDatabaseLegacy = interface;
  IaqWinAPIDatabaseLegacyDisp = dispinterface;
  IaqWinAPIDatabaseModule = interface;
  IaqWinAPIDatabaseModuleDisp = dispinterface;
  IaqWinAPIDatabaseManager = interface;
  IaqWinAPIDatabaseManagerDisp = dispinterface;
  IaqMonitorMetaProvider = interface;
  IaqMonitorDataEvent = interface;
  IaqProfIntf = interface;
  IaqProfPluginRegistry = interface;
  IaqProfPluginFactory = interface;
  IaqProfPlugin = interface;
  IaqProfPersistent = interface;
  IaqProfBaseContext = interface;
  IaqProfPluginManager = interface;
  IaqProfPluginCallback = interface;
  IaqProfDataManager = interface;
  IaqProfTable = interface;
  IaqProfTableSchema = interface;
  IaqProfTableColumn = interface;
  IaqProfTableColumnCallback = interface;
  IaqProfTableCallback = interface;
  IaqProfTableProviderCallback = interface;
  IaqProfTableProvider = interface;
  IaqProfMergeCallback = interface;
  IaqProfThreadMapperRegistry = interface;
  IaqProfCounterRegistry = interface;
  IaqProfDynamicContext = interface;
  IaqProfThreadManager = interface;
  IaqProfCounterManager = interface;
  IaqProfCounter = interface;
  IaqProfProfilingCallback = interface;
  IaqProfMarshalCallback = interface;
  IaqProfSessionListener = interface;
  IaqProfSession = interface;
  IaqProfProcessCallback = interface;
  IaqProfTableColumnType = interface;
  IaqProfTableType = interface;
  IaqProfThreadMapper = interface;
  IaqProfCounterFrequency = interface;
  IaqProfModuleLevel = interface;
  IaqProfSourceFileLevel = interface;
  IaqProfClassLevel = interface;
  IaqProfRoutineLevel = interface;
  IaqProfObjectLevel = interface;
  IaqProfWin32ThreadMapper = interface;
  IaqProfClrThreadMapper = interface;
  IaqProfTriggers = interface;
  IaqProfActions = interface;
  IaqProfContextPostPrecessor = interface;
  IaqProfLightCoverage = interface;
  IaqProfRowset = interface;
  IaqProfRoutineHitCounter = interface;
  IaqClrSymbolStore = interface;
  IaqClrRoutine = interface;
  IaqClrClass = interface;
  IaqClrNamespace = interface;
  IaqClrPatchManager = interface;
  IaqClrPatcherCallback = interface;
  IaqClrPatcher = interface;
  IaqScriptRoutine = interface;
  IaqInternalNativeSymbolStore = interface;
  IaqNativeProcedure = interface;
  IaqNativeProcedureType = interface;
  IaqNativeStoreType = interface;
  IaqNativeStoreTypeInfo = interface;
  IaqNativeSymbolStore = interface;
  IaqNativeClass = interface;
  IaqNativeStoreTypeInfoClass = interface;
  IaqNativeStoreTypeInfoEnum = interface;
  IaqExportRoutine = interface;
  IaqPatcher = interface;
  IaqPatcherX64 = interface;
  IaqDbgHelp = interface;
  IaqPEFile = interface;
  IaqPEImportModule = interface;
  IaqStackWalkHelper = interface;
  IaqDbgHelpStack = interface;
  IaqDbgHelpProcessList = interface;
  IaqDbgHelpProcessListLight = interface;
  IaqModuleList = interface;
  IaqWindowsList = interface;
  IaqWindowFilter = interface;
  IaqIISManager = interface;
  IaqDbgHelpManager = interface;
  IaqStack = interface;
  IaqDbgHelpManagerExtender = interface;
  IaqDbgHelpManagerExtenderX64 = interface;
  IaqWindowsManager = interface;
  IaqWindowsManagerEx = interface;
  IaqProfilersFactory = interface;
  IaqBaseContextProfiler = interface;
  IaqBaseContextProfilerExtender = interface;
  IaqContextProfilerImpl = interface;
  IaqContextMetaProvider = interface;
  IaqContextProfilerProvider = interface;
  IaqContextDataSchema = interface;
  IaqContextBrowseObjectSupport = interface;
  IaqContextProfilerEngine = interface;
  IaqContextProfilerEngineCallback = interface;
  IaqContextProfilerEngineAreasExtender = interface;
  IaqStaticAnalysisEngineCallback = interface;
  IaqContextProfilerCounterExtender = interface;
  IaqStaticContextProfilerImpl = interface;
  IaqContextProfilerResultsActivator = interface;
  IaqContextProfilerOptions = interface;
  IaqContextProfilerSettings = interface;
  IaqContextProfilerMetaProvider = interface;
  IaqContextProfilerToolbar = interface;
  IaqContextProfilerEngineExcludeAreaExtender = interface;
  IaqContextProfilerEngineAreasImportExtender = interface;
  IaqContextProfilerSessionEngine = interface;
  IaqContextProfilerDbgEngine = interface;
  IaqContextProfilerDbgEngineEx = interface;
  IaqContextProfilerActivationEngine = interface;
  IaqResultCleaner = interface;
  IaqContextProfilerEngineRoutineCallback = interface;
  IaqContextProfilerDBExporter = interface;
  IaqExportResultsToDBManager = interface;
  IaqExportResultsToDBManagerDisp = dispinterface;
  IAQtimeManager = interface;
  IAQtimeManagerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  AQtime_ = IAQtimeManager;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PAQ_ACTION_PROPERTY = ^AQ_ACTION_PROPERTY; 
  PAQ_PROPERTY_DESCRIPTION = ^AQ_PROPERTY_DESCRIPTION; 
  PAQ_OPTIONS_STORAGE_INFO = ^AQ_OPTIONS_STORAGE_INFO; 
  PAQDATA_COLUMN_INFO_XXX = ^AQDATA_COLUMN_INFO_XXX; 
  PAQDATA_BAND_INFO_XXX = ^AQDATA_BAND_INFO_XXX; 
  CPAQDATA_COLUMN_INFO_XXX = ^AQDATA_COLUMN_INFO_XXX; 
  CPAQDATA_BAND_INFO_XXX = ^AQDATA_BAND_INFO_XXX; 
  PAQ_TABLE_COLUMN_INFO = ^AQ_TABLE_COLUMN_INFO; 
  PAQ_TRIGGER_OPTIONS = ^AQ_TRIGGER_OPTIONS; 
  PAQ_ACTION_OPTIONS = ^AQ_ACTION_OPTIONS; 
  CPAQPROF_PLUGIN_INFO = ^AQPROF_PLUGIN_INFO; 
  CPAQPROF_TABLE_SCHEMA_INFO = ^AQPROF_TABLE_SCHEMA_INFO; 
  CPAQPROF_TABLE_COLUMN_INFO = ^AQPROF_TABLE_COLUMN_INFO; 
  CPAQPROF_TABLE_MERGE_INFO = ^AQPROF_TABLE_MERGE_INFO; 
  CPAQPROF_THREAD_MAPPER_INFO = ^AQPROF_THREAD_MAPPER_INFO; 
  CPAQPROF_COUNTER_INFO = ^AQPROF_COUNTER_INFO; 
  CPAQPROF_COUNTER_UNIT = ^AQPROF_COUNTER_UNIT; 
  PAQPROF_THREAD_METADATA = ^AQPROF_THREAD_METADATA; 
  PAQPROF_MODULE_METADATA = ^AQPROF_MODULE_METADATA; 
  PAQPROF_SOURCE_FILE_METADATA = ^AQPROF_SOURCE_FILE_METADATA; 
  PAQPROF_CLASS_METADATA = ^AQPROF_CLASS_METADATA; 
  PAQPROF_ROUTINE_METADATA = ^AQPROF_ROUTINE_METADATA; 
  PAQPROF_LINE_METADATA = ^AQPROF_LINE_METADATA; 
  PAQPROF_OBJECT_DATA = ^AQPROF_OBJECT_DATA; 
  PAQPROF_TRIGGER_METADATA = ^AQPROF_TRIGGER_METADATA; 
  PAQPROF_ACTION_METADATA = ^AQPROF_ACTION_METADATA; 
  PAQPROF_TABLE_ENUM2 = ^AQPROF_TABLE_ENUM2; 
  CPAQPROF_TABLE_ENUM2 = ^AQPROF_TABLE_ENUM2; 
  PAQPROF_PLUGIN_INFO = ^AQPROF_PLUGIN_INFO; 
  PAQPROF_THREAD_MAPPER_INFO = ^AQPROF_THREAD_MAPPER_INFO; 
  PAQPROF_COUNTER_UNIT = ^AQPROF_COUNTER_UNIT; 
  PAQPROF_COUNTER_INFO = ^AQPROF_COUNTER_INFO; 
  PAQPROF_TABLE_COLUMN_INFO = ^AQPROF_TABLE_COLUMN_INFO; 
  PAQPROF_TABLE_SCHEMA_INFO = ^AQPROF_TABLE_SCHEMA_INFO; 
  PAQPROF_EXTERNAL_TRACER_FUNCTION_DATA = ^AQPROF_EXTERNAL_TRACER_FUNCTION_DATA; 
  CPAQPROF_EXTERNAL_TRACER_FUNCTION_DATA = ^AQPROF_EXTERNAL_TRACER_FUNCTION_DATA; 
  PAQPROF_EXTERNAL_TRACER_PARAMETER_ENTER_DATA = ^AQPROF_EXTERNAL_TRACER_PARAMETER_ENTER_DATA; 
  CPAQPROF_EXTERNAL_TRACER_PARAMETER_ENTER_DATA = ^AQPROF_EXTERNAL_TRACER_PARAMETER_ENTER_DATA; 
  PAQPROF_EXTERNAL_TRACER_PARAMETER_LEAVE_DATA = ^AQPROF_EXTERNAL_TRACER_PARAMETER_LEAVE_DATA; 
  CPAQPROF_EXTERNAL_TRACER_PARAMETER_LEAVE_DATA = ^AQPROF_EXTERNAL_TRACER_PARAMETER_LEAVE_DATA; 
  PAQPROF_EXTERNAL_TRACER_ROUTE_DATA = ^AQPROF_EXTERNAL_TRACER_ROUTE_DATA; 
  CPAQPROF_EXTERNAL_TRACER_ROUTE_DATA = ^AQPROF_EXTERNAL_TRACER_ROUTE_DATA; 
  PAQPROF_EXTERNAL_TRACER_PREV_ROUTINE_POINTER = ^AQPROF_EXTERNAL_TRACER_PREV_ROUTINE_POINTER; 
  CPAQPROF_EXTERNAL_TRACER_PREV_ROUTINE_POINTER = ^AQPROF_EXTERNAL_TRACER_PREV_ROUTINE_POINTER; 
  PAQPROF_EXTERNAL_TRACER_MY_STACK_DATA = ^AQPROF_EXTERNAL_TRACER_MY_STACK_DATA; 
  CPAQPROF_EXTERNAL_TRACER_MY_STACK_DATA = ^AQPROF_EXTERNAL_TRACER_MY_STACK_DATA; 
  PAQPROF_EXTERNAL_TRACER_ROUTE_CALL_DATA = ^AQPROF_EXTERNAL_TRACER_ROUTE_CALL_DATA; 
  CPAQPROF_EXTERNAL_TRACER_ROUTE_CALL_DATA = ^AQPROF_EXTERNAL_TRACER_ROUTE_CALL_DATA; 
  PAQPROF_EXTERNAL_TRACER_ROUTE_STACK_DATA = ^AQPROF_EXTERNAL_TRACER_ROUTE_STACK_DATA; 
  CPAQPROF_EXTERNAL_TRACER_ROUTE_STACK_DATA = ^AQPROF_EXTERNAL_TRACER_ROUTE_STACK_DATA; 
  PAQPROF_TABLE_MERGE_INFO = ^AQPROF_TABLE_MERGE_INFO; 
  PAQPROF_PARAMETER_DATA = ^AQPROF_PARAMETER_DATA; 
  CPAQPROF_PARAMETER_DATA = ^AQPROF_PARAMETER_DATA; 
  PAQPROF_WINAPI_ERROR_EVENT_DATA = ^AQPROF_WINAPI_ERROR_EVENT_DATA; 
  CPAQPROF_WINAPI_ERROR_EVENT_DATA = ^AQPROF_WINAPI_ERROR_EVENT_DATA; 
  PAQPROF_FAILURE_EVENT_DATA = ^AQPROF_FAILURE_EVENT_DATA; 
  CPAQPROF_FAILURE_EVENT_DATA = ^AQPROF_FAILURE_EVENT_DATA; 
  PAQPROF_ENABLED_EVENT_DATA = ^AQPROF_ENABLED_EVENT_DATA; 
  CPAQPROF_ENABLED_EVENT_DATA = ^AQPROF_ENABLED_EVENT_DATA; 
  PAQPROF_THREAD_EVENT_DATA = ^AQPROF_THREAD_EVENT_DATA; 
  CPAQPROF_THREAD_EVENT_DATA = ^AQPROF_THREAD_EVENT_DATA; 
  PAQPROF_ROUTINE_EVENT_DATA = ^AQPROF_ROUTINE_EVENT_DATA; 
  CPAQPROF_ROUTINE_EVENT_DATA = ^AQPROF_ROUTINE_EVENT_DATA; 
  PAQPROF_LINE_EVENT_DATA = ^AQPROF_LINE_EVENT_DATA; 
  CPAQPROF_LINE_EVENT_DATA = ^AQPROF_LINE_EVENT_DATA; 
  PAQPROF_EXCEPTION_EVENT_DATA = ^AQPROF_EXCEPTION_EVENT_DATA; 
  CPAQPROF_EXCEPTION_EVENT_DATA = ^AQPROF_EXCEPTION_EVENT_DATA; 
  PAQPROF_OBJECT_EVENT_DATA = ^AQPROF_OBJECT_EVENT_DATA; 
  CPAQPROF_OBJECT_EVENT_DATA = ^AQPROF_OBJECT_EVENT_DATA; 
  PAQPROF_ADDREF_RELEASE_EVENT_DATA = ^AQPROF_ADDREF_RELEASE_EVENT_DATA; 
  CPAQPROF_ADDREF_RELEASE_EVENT_DATA = ^AQPROF_ADDREF_RELEASE_EVENT_DATA; 
  PAQPROF_REFERENCE_EVENT_DATA = ^AQPROF_REFERENCE_EVENT_DATA; 
  CPAQPROF_REFERENCE_EVENT_DATA = ^AQPROF_REFERENCE_EVENT_DATA; 
  PAQPROF_GC_EVENT_DATA = ^AQPROF_GC_EVENT_DATA; 
  CPAQPROF_GC_EVENT_DATA = ^AQPROF_GC_EVENT_DATA; 
  CPAQPROF_THREAD_METADATA = ^AQPROF_THREAD_METADATA; 
  CPAQPROF_MODULE_METADATA = ^AQPROF_MODULE_METADATA; 
  CPAQPROF_SOURCE_FILE_METADATA = ^AQPROF_SOURCE_FILE_METADATA; 
  CPAQPROF_ROUTINE_METADATA = ^AQPROF_ROUTINE_METADATA; 
  PAQPROF_CLR_ROUTINE_METADATA = ^AQPROF_CLR_ROUTINE_METADATA; 
  CPAQPROF_CLR_ROUTINE_METADATA = ^AQPROF_CLR_ROUTINE_METADATA; 
  PAQPROF_X86_ROUTINE_METADATA = ^AQPROF_X86_ROUTINE_METADATA; 
  CPAQPROF_X86_ROUTINE_METADATA = ^AQPROF_X86_ROUTINE_METADATA; 
  PAQPROF_X86_STATIC_ROUTINE_METADATA = ^AQPROF_X86_STATIC_ROUTINE_METADATA; 
  CPAQPROF_X86_STATIC_ROUTINE_METADATA = ^AQPROF_X86_STATIC_ROUTINE_METADATA; 
  CPAQPROF_LINE_METADATA = ^AQPROF_LINE_METADATA; 
  PAQPROF_STACKFRAME_DATA = ^AQPROF_STACKFRAME_DATA; 
  CPAQPROF_STACKFRAME_DATA = ^AQPROF_STACKFRAME_DATA; 
  CPAQPROF_CLASS_METADATA = ^AQPROF_CLASS_METADATA; 
  PAQPROF_CLR_CLASS_METADATA = ^AQPROF_CLR_CLASS_METADATA; 
  CPAQPROF_CLR_CLASS_METADATA = ^AQPROF_CLR_CLASS_METADATA; 
  CPAQPROF_OBJECT_DATA = ^AQPROF_OBJECT_DATA; 
  CPAQPROF_ACTION_METADATA = ^AQPROF_ACTION_METADATA; 
  CPAQPROF_TRIGGER_METADATA = ^AQPROF_TRIGGER_METADATA; 
  PAQPROF_CALLGRAPH_STRATEGY_ROUTINE_DATA = ^AQPROF_CALLGRAPH_STRATEGY_ROUTINE_DATA; 
  CPAQPROF_CALLGRAPH_STRATEGY_ROUTINE_DATA = ^AQPROF_CALLGRAPH_STRATEGY_ROUTINE_DATA; 
  PAQPROF_CALLGRAPH_STRATEGY_PARENTCHILD_DATA = ^AQPROF_CALLGRAPH_STRATEGY_PARENTCHILD_DATA; 
  CPAQPROF_CALLGRAPH_STRATEGY_PARENTCHILD_DATA = ^AQPROF_CALLGRAPH_STRATEGY_PARENTCHILD_DATA; 
  PAQPROF_CALLGRAPH_STRATEGY_LINE_DATA = ^AQPROF_CALLGRAPH_STRATEGY_LINE_DATA; 
  CPAQPROF_CALLGRAPH_STRATEGY_LINE_DATA = ^AQPROF_CALLGRAPH_STRATEGY_LINE_DATA; 
  PAQPROF_CALLGRAPH_STRATEGY_CLASS_THREAD_DATA = ^AQPROF_CALLGRAPH_STRATEGY_CLASS_THREAD_DATA; 
  CPAQPROF_CALLGRAPH_STRATEGY_CLASS_THREAD_DATA = ^AQPROF_CALLGRAPH_STRATEGY_CLASS_THREAD_DATA; 
  PAQPROF_CALLGRAPH_STRATEGY_MODULE_THREAD_DATA = ^AQPROF_CALLGRAPH_STRATEGY_MODULE_THREAD_DATA; 
  CPAQPROF_CALLGRAPH_STRATEGY_MODULE_THREAD_DATA = ^AQPROF_CALLGRAPH_STRATEGY_MODULE_THREAD_DATA; 
  PAQPROF_CALLGRAPH_STRATEGY_SOURCE_FILE_THREAD_DATA = ^AQPROF_CALLGRAPH_STRATEGY_SOURCE_FILE_THREAD_DATA; 
  CPAQPROF_CALLGRAPH_STRATEGY_SOURCE_FILE_THREAD_DATA = ^AQPROF_CALLGRAPH_STRATEGY_SOURCE_FILE_THREAD_DATA; 
  PAQPROF_COVERAGE_STRATEGY_ROUTINE_DATA = ^AQPROF_COVERAGE_STRATEGY_ROUTINE_DATA; 
  CPAQPROF_COVERAGE_STRATEGY_ROUTINE_DATA = ^AQPROF_COVERAGE_STRATEGY_ROUTINE_DATA; 
  PAQPROF_THREAD_STRATEGY_ROUTINE_DATA = ^AQPROF_THREAD_STRATEGY_ROUTINE_DATA; 
  CPAQPROF_THREAD_STRATEGY_ROUTINE_DATA = ^AQPROF_THREAD_STRATEGY_ROUTINE_DATA; 
  PAQPROF_COVERAGE_STRATEGY_BLOCK_DATA = ^AQPROF_COVERAGE_STRATEGY_BLOCK_DATA; 
  CPAQPROF_COVERAGE_STRATEGY_BLOCK_DATA = ^AQPROF_COVERAGE_STRATEGY_BLOCK_DATA; 
  PAQPROF_COVERAGE_STRATEGY_LINE_DATA = ^AQPROF_COVERAGE_STRATEGY_LINE_DATA; 
  CPAQPROF_COVERAGE_STRATEGY_LINE_DATA = ^AQPROF_COVERAGE_STRATEGY_LINE_DATA; 
  PAQPROF_COVERAGE_STRATEGY_MODULE_THREAD_DATA = ^AQPROF_COVERAGE_STRATEGY_MODULE_THREAD_DATA; 
  CPAQPROF_COVERAGE_STRATEGY_MODULE_THREAD_DATA = ^AQPROF_COVERAGE_STRATEGY_MODULE_THREAD_DATA; 
  PAQPROF_COVERAGE_STRATEGY_SOURCE_FILE_THREAD_DATA = ^AQPROF_COVERAGE_STRATEGY_SOURCE_FILE_THREAD_DATA; 
  CPAQPROF_COVERAGE_STRATEGY_SOURCE_FILE_THREAD_DATA = ^AQPROF_COVERAGE_STRATEGY_SOURCE_FILE_THREAD_DATA; 
  PAQPROF_CLASS_ALLOCATION_STRATEGY_CLASS_DATA = ^AQPROF_CLASS_ALLOCATION_STRATEGY_CLASS_DATA; 
  CPAQPROF_CLASS_ALLOCATION_STRATEGY_CLASS_DATA = ^AQPROF_CLASS_ALLOCATION_STRATEGY_CLASS_DATA; 
  PAQPROF_REFERENCES_STRATEGY_PARENTCHILD_DATA = ^AQPROF_REFERENCES_STRATEGY_PARENTCHILD_DATA; 
  CPAQPROF_REFERENCES_STRATEGY_PARENTCHILD_DATA = ^AQPROF_REFERENCES_STRATEGY_PARENTCHILD_DATA; 
  PAQPROF_OBJECT_STACK_DATA = ^AQPROF_OBJECT_STACK_DATA; 
  CPAQPROF_OBJECT_STACK_DATA = ^AQPROF_OBJECT_STACK_DATA; 
  PAQPROF_FAILURE_DATA = ^AQPROF_FAILURE_DATA; 
  CPAQPROF_FAILURE_DATA = ^AQPROF_FAILURE_DATA; 
  PAQPROF_EVENT_DATA = ^AQPROF_EVENT_DATA; 
  CPAQPROF_EVENT_DATA = ^AQPROF_EVENT_DATA; 
  PAQPROF_EVENT_SET_OPTION = ^AQPROF_EVENT_SET_OPTION; 
  CPAQPROF_EVENT_SET_OPTION = ^AQPROF_EVENT_SET_OPTION; 
  CPAQPE_DOS_HEADER = ^AQPE_DOS_HEADER; 
  CPAQPE_FILE_HEADER = ^AQPE_FILE_HEADER; 
  CPAQPE_OPTIONAL_HEADER = ^AQPE_OPTIONAL_HEADER; 
  CPAQPE_SECTION_HEADER = ^AQPE_SECTION_HEADER; 
  PAQPE_IMPORT_ROUTINE_INFO = ^AQPE_IMPORT_ROUTINE_INFO; 
  PAQPE_EXPORT_ROUTINE_INFO = ^AQPE_EXPORT_ROUTINE_INFO; 
  CPAQDBGHELP_START_WALKSTACK_INFO = ^AQDBGHELP_START_WALKSTACK_INFO; 
  PAQDBGHELP_ROUTINE_INFO = ^AQDBGHELP_ROUTINE_INFO; 
  PAQ_EXCEPTION_INFO = ^AQ_EXCEPTION_INFO; 
  CPAQ_PROCESS_INFORMATION = ^AQ_PROCESS_INFORMATION; 
  CPAQ_PROCESS_INFORMATION_LIGHT = ^AQ_PROCESS_INFORMATION_LIGHT; 
  PAQ_PROCESS_INFORMATION = ^AQ_PROCESS_INFORMATION; 
  CPAQ_MODULE_DESCRIPTION = ^AQ_MODULE_DESCRIPTION; 
  CPAQ_WINDOW_INFO = ^AQ_WINDOW_INFO; 
  PAQ_SCROLL_INFO = ^AQ_SCROLL_INFO_TAG; 
  CPAQ_SCROLL_INFO = ^AQ_SCROLL_INFO_TAG; 
  PAQ_MENUITEM_INFO = ^AQ_MENUITEM_INFO; 
  CPAQ_MENUITEM_INFO = ^AQ_MENUITEM_INFO; 
  CPAQDBGHELP_ROUTINE_INFO = ^AQDBGHELP_ROUTINE_INFO; 
  PAQDBGHELP_START_WALKSTACK_INFO = ^AQDBGHELP_START_WALKSTACK_INFO; 
  PAQ_PROCESS_INFORMATION_LIGHT = ^AQ_PROCESS_INFORMATION_LIGHT; 
  PAQ_MODULE_DESCRIPTION = ^AQ_MODULE_DESCRIPTION; 
  PAQ_EXCEPTION_RECORD = ^AQ_EXCEPTION_RECORD; 
  CPAQ_EXCEPTION_RECORD = ^AQ_EXCEPTION_RECORD; 
  CPAQ_EXCEPTION_INFO = ^AQ_EXCEPTION_INFO; 
  PAQ_WINDOW_INFO = ^AQ_WINDOW_INFO; 
  CPAQPE_EXPORT_ROUTINE_INFO = ^AQPE_EXPORT_ROUTINE_INFO; 
  CPAQPE_IMPORT_ROUTINE_INFO = ^AQPE_IMPORT_ROUTINE_INFO; 
  PAQPE_DOS_HEADER = ^AQPE_DOS_HEADER; 
  PAQPE_FILE_HEADER = ^AQPE_FILE_HEADER; 
  PAQPE_DATA_DIRECTORY = ^AQPE_DATA_DIRECTORY; 
  CPAQPE_DATA_DIRECTORY = ^AQPE_DATA_DIRECTORY; 
  PAQPE_OPTIONAL_HEADER = ^AQPE_OPTIONAL_HEADER; 
  PAQPE_SECTION_HEADER = ^AQPE_SECTION_HEADER; 
  CPAQDBGHELP_STACK_ITEM_INFO = ^AQDBGHELP_STACK_ITEM_INFO; 
  PAQDBGHELP_STACK_ITEM_INFO = ^AQDBGHELP_STACK_ITEM_INFO; 
  PAQ_BASE_PROFILER_DESCRIPTION = ^AQ_BASE_PROFILER_DESCRIPTION; 
  CPAQ_BASE_PROFILER_DESCRIPTION = ^AQ_BASE_PROFILER_DESCRIPTION; 
  PUserType1 = ^TGUID; {*}
  PPUserType1 = ^PAQDATA_COLUMN_INFO_XXX; {*}
  PUINT1 = ^AQPROF_TABLE_ROW; {*}
  POleVariant1 = ^OleVariant; {*}
  PUINT2 = ^AQPROF_EVENT_CALLBACK; {*}
  PByte1 = ^Byte; {*}
  PUserType2 = ^AQDBGHELP_START_WALKSTACK_INFO64; {*}
  PUserType3 = ^AQ_SCROLL_INFO; {*}
  PUserType4 = ^tagRECT; {*}
  PIUnknown1 = ^IUnknown; {*}
  PWideString1 = ^WideString; {*}
  PUserType5 = ^AQ_BASE_PROFILER_DESCRIPTION; {*}
  PUserType6 = ^tagSAFEARRAY; {*}

  AQ_RESOURCE_INFO = LongWord; 
  AQ_ACTION_PROPERTY = SYSINT; 
  UINT_PTR = LongWord; 
  VOID_PTR = UINT_PTR; 
  CVOID_PTR = UINT_PTR; 

  AQ_EVENT_INFO = packed record
    EventID: TGUID;
    NotifyInMainThread: WordBool;
  end;

  AQ_PROPERTY_DESCRIPTION = packed record
    Name: WideString;
    PropType: AQ_PROPERTY_TYPE;
  end;

  AQ_OPTIONS_STORAGE_INFO = packed record
    Kind: AQ_OPTIONS_STORAGE_KIND;
    Location: WideString;
  end;


  AQ_PLUGIN_VERSION = packed record
    Major: Integer;
    Minor: Integer;
  end;

  AQ_SYMBOLSTORE_KIND = AQ_DBG_SYMBOLSTORE_KIND; 

  AQ_DBG_OFFSET_INFO = packed record
    Offset: LongWord;
    LineNo: LongWord;
  end;


  AQDATA_COLUMN_INFO_XXX = packed record
    Id: TGUID;
    Caption: WideString;
    type_: AQ_TABLE_COLUMN_TYPE;
  end;


  AQDATA_BAND_INFO_XXX = packed record
    Id: TGUID;
    Caption: WideString;
  end;

  AQ_FILTER_DESCRIPTION = packed record
    FilterName: WideString;
    RefFilterImage: Integer;
    RowType: Integer;
  end;

  AQ_DATA_TYPE_DESCRIPTION = packed record
    DataTypeName: WideString;
    RefDataTypeImage: Integer;
    TypeID: Integer;
  end;

  AQ_BROWSE_OBJECT_ACTION_TYPE = AQ_BROWSEOBJECT_ACTION_TYPE; 

  AQ_TABLE_COLUMN_INFO = packed record
    Key: TGUID;
    BandKey: TGUID;
    Caption: WideString;
    ColumnType: AQ_TABLE_COLUMN_TYPE;
  end;

  AQ_SETUP_FEATURES = LongWord; 
  AQ_PROFILE_PLATFORM_INFO = LongWord; 

  AQ_TRIGGER_OPTIONS = packed record
    TriggerType: TTriggerType;
    PassCount: Integer;
    WorkCount: Integer;
    Cycling: Integer;
    Global: Integer;
  end;


  AQ_ACTION_OPTIONS = packed record
    ActionType: TActionType;
    ExecuteType: TExecuteType;
  end;

  AQ_SEARCH_PATH_CHANGE = LongWord; 

  AQPROF_PLUGIN_INFO = packed record
    Id: TGUID;
    FilePath: PChar;
    CreatePluginProcName: PChar;
  end;


  AQPROF_TABLE_SCHEMA_INFO = packed record
    Id: TGUID;
    MetaId: TGUID;
    TableType: TGUID;
    RecordType: TGUID;
    Caption: PWideChar;
    Flags: AQPROF_TABLE_SCHEMA_FLAGS;
  end;

  AQPROF_TABLE_ACCESSOR = VOID_PTR; 

  AQPROF_TABLE_COLUMN_INFO = packed record
    Id: TGUID;
    Caption: PWideChar;
    ColumnType: AQPROF_TABLE_COLUMN_TYPE;
    DataType: AQPROF_TABLE_COLUMN_TYPE;
    MergeKind: AQPROF_TABLE_COLUMN_MERGE_KIND;
    UserMergeKinds: LongWord;
    IsPrivate: Integer;
    CallbackEvents: LongWord;
    BufferSize: LongWord;
    MetaDataFlags: LongWord;
    Summary: AQPROF_TABLE_COLUMN_SUMMARY;
    DataType2: TGUID;
    ActualType: AQPROF_TABLE_COLUMN_TYPE;
    LookupTableGUID: TGUID;
  end;

  AQPROF_TABLE_ROW = VOID_PTR; 
  AQPROF_TABLE_RECID = SYSUINT; 

  AQPROF_TABLE_MERGE_INFO = packed record
    MergeIteration: LongWord;
    MergeCount: LongWord;
    UseDefaultMergeKind: Integer;
  end;

  AQPROF_TABLE_ENUM = VOID_PTR; 
  AQPROF_COMPACT_STRING = SYSUINT; 

  AQPROF_THREAD_MAPPER_INFO = packed record
    Id: TGUID;
    Name: PWideChar;
    PluginId: TGUID;
  end;


  AQPROF_COUNTER_INFO = packed record
    Id: TGUID;
    Name: PWideChar;
    ColumnName: PWideChar;
    UnitCount: Integer;
    Units: CPAQPROF_COUNTER_UNIT;
    MultiSessionSupport: Integer;
    PluginId: TGUID;
    IsHiddenCounter: Integer;
  end;

  AQPROF_COUNTER_UNIT = packed record
    FullName: PWideChar;
    ShortName: PWideChar;
  end;


  AQPROF_THREAD_METADATA = packed record
    Key: SYSUINT;
    Name: WideString;
    IsWorked: Integer;
    Enabled: Integer;
  end;

  AQPROF_CALIBRATION_FUNCTION = VOID_PTR; 
  AQPROF_RAW_COUNTER = Int64; 
  AQPROF_EVENT_CALLBACK = VOID_PTR; 

  AQPROF_MODULE_METADATA = packed record
    ModuleName: AQPROF_COMPACT_STRING;
  end;


  AQPROF_SOURCE_FILE_METADATA = packed record
    FileName: AQPROF_COMPACT_STRING;
    SymbolMoniker: WideString;
  end;


  AQPROF_CLASS_METADATA = packed record
    ModuleName: AQPROF_COMPACT_STRING;
    ClsName: AQPROF_COMPACT_STRING;
    SymbolMoniker: WideString;
  end;


  AQPROF_ROUTINE_METADATA = packed record
    ModuleName: AQPROF_COMPACT_STRING;
    SourceFile: AQPROF_COMPACT_STRING;
    ClsName: AQPROF_COMPACT_STRING;
    RoutineName: AQPROF_COMPACT_STRING;
    SourceLine: LongWord;
    CodeType: AQPROF_COMPACT_STRING;
    AnalysisResult: WideString;
    SymbolMoniker: WideString;
    ProfileLines: Integer;
  end;


  AQPROF_LINE_METADATA = packed record
    SourceLine: LongWord;
  end;


  AQPROF_OBJECT_DATA = packed record
    ThreadRid: AQPROF_TABLE_RECID;
    ClassRid: AQPROF_TABLE_RECID;
    InstanceId: Int64;
    Size: Int64;
    Address: Int64;
    SnapshotNumber: SYSINT;
    Moniker: WideString;
  end;


  AQPROF_TRIGGER_METADATA = packed record
    Active: Integer;
    Enabling: Integer;
    DisableRoutine: Integer;
    PassCount: LongWord;
    WorkCount: LongWord;
    Cycling: Integer;
    Global: Integer;
  end;


  AQPROF_ACTION_METADATA = packed record
    Active: Integer;
    AType: AQPROF_ACTION_TYPE;
    Placement: AQPROF_ACTION_PLACEMENT;
    DisableRoutine: Integer;
  end;

  AQPROF_ROW_MANAGER = VOID_PTR; 

  AQPROF_TABLE_ENUM2 = packed record
    RecId: AQPROF_TABLE_RECID;
    Row: AQPROF_TABLE_ROW;
  end;


  AQPROF_EXTERNAL_TRACER_FUNCTION_DATA = packed record
    Number: AQPROF_TABLE_RECID;
    ParentNumber: AQPROF_TABLE_RECID;
    RoutineRid: AQPROF_TABLE_RECID;
    Counter: AQPROF_RAW_COUNTER;
    CounterWithChildren: AQPROF_RAW_COUNTER;
    NextNumber: AQPROF_TABLE_RECID;
    Line: Int64;
    Rid: AQPROF_TABLE_RECID;
  end;


  AQPROF_EXTERNAL_TRACER_PARAMETER_ENTER_DATA = packed record
    Number: AQPROF_TABLE_RECID;
    type_: AQPROF_TABLE_RECID;
    Value: AQPROF_COMPACT_STRING;
  end;


  AQPROF_EXTERNAL_TRACER_PARAMETER_LEAVE_DATA = packed record
    Number: AQPROF_TABLE_RECID;
    type_: AQPROF_TABLE_RECID;
    Comment: AQPROF_COMPACT_STRING;
    Value: AQPROF_COMPACT_STRING;
  end;


  AQPROF_EXTERNAL_TRACER_ROUTE_DATA = packed record
    HitCount: Int64;
  end;


  AQPROF_EXTERNAL_TRACER_PREV_ROUTINE_POINTER = packed record
    Pointer: Int64;
    PrevStackDepth: Int64;
  end;


  AQPROF_EXTERNAL_TRACER_MY_STACK_DATA = packed record
    Number: AQPROF_TABLE_RECID;
    StartCounter: AQPROF_RAW_COUNTER;
    PrevRoutinePointer: Int64;
    Enabled: SYSINT;
  end;


  AQPROF_EXTERNAL_TRACER_ROUTE_CALL_DATA = packed record
    CallNumber: Int64;
    HitCount: Int64;
    TraceRid: AQPROF_TABLE_RECID;
  end;


  AQPROF_EXTERNAL_TRACER_ROUTE_STACK_DATA = packed record
    RoutineName: AQPROF_TABLE_RECID;
    SourceLine: Int64;
    SourceFile: AQPROF_COMPACT_STRING;
    ModuleName: AQPROF_COMPACT_STRING;
    Number: SYSINT;
    RoutineRid: AQPROF_TABLE_RECID;
  end;

  AQPROF_COMPARE_RECID = VOID_PTR; 

  AQPROF_PARAMETER_DATA = packed record
    type_: WideString;
    Value: WideString;
    pNextParameter: CVOID_PTR;
  end;


  AQPROF_WINAPI_ERROR_EVENT_DATA = packed record
    ErrorValue: SYSINT;
    Description: WideString;
    Kind: AQPROF_WINAPI_ERROR_KIND;
    FuncId: SYSUINT;
  end;


  AQPROF_FAILURE_EVENT_DATA = packed record
    _dummy: SYSINT;
  end;


  AQPROF_ENABLED_EVENT_DATA = packed record
    Value: Integer;
  end;


  AQPROF_THREAD_EVENT_DATA = packed record
    ThreadRow: AQPROF_TABLE_ROW;
  end;


  AQPROF_ROUTINE_EVENT_DATA = packed record
    This: VOID_PTR;
    RoutineRid: AQPROF_TABLE_RECID;
    Esp: ULONG_PTR;
    ReturnAddress: ULONG_PTR;
    pFirstParameter: PAQPROF_PARAMETER_DATA;
    bCallOriginalFuntion: Integer;
    StackParamSize: LongWord;
  end;


  AQPROF_LINE_EVENT_DATA = packed record
    This: VOID_PTR;
    RoutineRid: AQPROF_TABLE_RECID;
    LineRid: AQPROF_TABLE_RECID;
    Block: LongWord;
  end;


  AQPROF_EXCEPTION_EVENT_DATA = packed record
    This: VOID_PTR;
    RoutineRid: AQPROF_TABLE_RECID;
  end;


  AQPROF_OBJECT_EVENT_DATA = packed record
    ObjectRid: AQPROF_TABLE_RECID;
    ClassRid: AQPROF_TABLE_RECID;
    ObjectSize: Int64;
    Address: Int64;
  end;


  AQPROF_ADDREF_RELEASE_EVENT_DATA = packed record
    ObjectRid: AQPROF_TABLE_RECID;
    RefCount: Int64;
  end;


  AQPROF_REFERENCE_EVENT_DATA = packed record
    ObjectRid: AQPROF_TABLE_RECID;
    ClassRid: AQPROF_TABLE_RECID;
    RefCount: LongWord;
    RefObjects: ^AQPROF_TABLE_RECID;
  end;


  AQPROF_GC_EVENT_DATA = packed record
    BytesCompacted: LongWord;
    BytesMoved: LongWord;
    ObjectsCompacted: LongWord;
    ObjectsMoved: LongWord;
  end;


  AQPROF_CLR_ROUTINE_METADATA = packed record
    Namespace: AQPROF_COMPACT_STRING;
    Token: LongWord;
  end;


  AQPROF_X86_ROUTINE_METADATA = packed record
    UnitName: AQPROF_COMPACT_STRING;
    Address: Int64;
  end;


  AQPROF_X86_STATIC_ROUTINE_METADATA = packed record
    UnitName: AQPROF_COMPACT_STRING;
    ModuleBase: Int64;
    Rva: Int64;
  end;


  AQPROF_STACKFRAME_DATA = packed record
    RoutineRid: AQPROF_TABLE_RECID;
    LineRid: AQPROF_TABLE_RECID;
  end;


  AQPROF_CLR_CLASS_METADATA = packed record
    Namespace: AQPROF_COMPACT_STRING;
    Token: LongWord;
    Finalizable: Integer;
  end;


  AQPROF_CALLGRAPH_STRATEGY_ROUTINE_DATA = packed record
    HitCount: Int64;
    CallsOnStack: Int64;
    MaxRecursionDepth: Int64;
    Exceptions: Int64;
    SkipCount: Int64;
    Counter: AQPROF_RAW_COUNTER;
    CounterWithChildren: AQPROF_RAW_COUNTER;
    FirstCounter: AQPROF_RAW_COUNTER;
    FirstCounterWithChildren: AQPROF_RAW_COUNTER;
    MaxCounter: AQPROF_RAW_COUNTER;
    MinCounter: AQPROF_RAW_COUNTER;
    MaxCounterWithChildren: AQPROF_RAW_COUNTER;
    MinCounterWithChildren: AQPROF_RAW_COUNTER;
  end;


  AQPROF_CALLGRAPH_STRATEGY_PARENTCHILD_DATA = packed record
    HitCount: Int64;
    Exceptions: Int64;
    Counter: AQPROF_RAW_COUNTER;
    CounterWithChildren: AQPROF_RAW_COUNTER;
    MaxCounter: AQPROF_RAW_COUNTER;
    MinCounter: AQPROF_RAW_COUNTER;
    MaxCounterWithChildren: AQPROF_RAW_COUNTER;
    MinCounterWithChildren: AQPROF_RAW_COUNTER;
  end;


  AQPROF_CALLGRAPH_STRATEGY_LINE_DATA = packed record
    HitCount: Int64;
    Exceptions: Int64;
    Counter: AQPROF_RAW_COUNTER;
    CounterWithChildren: AQPROF_RAW_COUNTER;
  end;


  AQPROF_CALLGRAPH_STRATEGY_CLASS_THREAD_DATA = packed record
    HitCount: Int64;
    Exceptions: Int64;
    SkipCount: Int64;
    Counter: AQPROF_RAW_COUNTER;
  end;


  AQPROF_CALLGRAPH_STRATEGY_MODULE_THREAD_DATA = packed record
    HitCount: Int64;
    Exceptions: Int64;
    SkipCount: Int64;
    Counter: AQPROF_RAW_COUNTER;
  end;


  AQPROF_CALLGRAPH_STRATEGY_SOURCE_FILE_THREAD_DATA = packed record
    HitCount: Int64;
    Exceptions: Int64;
    SkipCount: Int64;
    Counter: AQPROF_RAW_COUNTER;
  end;


  AQPROF_COVERAGE_STRATEGY_ROUTINE_DATA = packed record
    HitCount: Int64;
    SkipCount: Int64;
  end;


  AQPROF_THREAD_STRATEGY_ROUTINE_DATA = packed record
    CollisionCount: Int64;
    HitCount: Int64;
    LastThreadID: LongWord;
  end;


  AQPROF_COVERAGE_STRATEGY_BLOCK_DATA = packed record
    Blocks: array[0..15] of Byte;
  end;


  AQPROF_COVERAGE_STRATEGY_LINE_DATA = packed record
    HitCount: Int64;
    BlockCount: LongWord;
    Blocks: AQPROF_COVERAGE_STRATEGY_BLOCK_DATA;
  end;


  AQPROF_COVERAGE_STRATEGY_MODULE_THREAD_DATA = packed record
    Calculated: Integer;
    HitCount: Int64;
    SkipCount: Int64;
    PercentCovered: Double;
    LineCount: SYSINT;
    Lines: WideString;
  end;


  AQPROF_COVERAGE_STRATEGY_SOURCE_FILE_THREAD_DATA = packed record
    Calculated: Integer;
    HitCount: Int64;
    SkipCount: Int64;
    PercentCovered: Double;
    LineCount: SYSINT;
    Lines: WideString;
  end;


  AQPROF_CLASS_ALLOCATION_STRATEGY_CLASS_DATA = packed record
    TotalCount: Int64;
    PeakCount: Int64;
    LiveCount: Int64;
    TotalSize: Int64;
    PeakSize: Int64;
    LiveSize: Int64;
  end;


  AQPROF_REFERENCES_STRATEGY_PARENTCHILD_DATA = packed record
    RefCount: SYSINT;
  end;


  AQPROF_OBJECT_STACK_DATA = packed record
    RoutineRid: AQPROF_TABLE_RECID;
    LineRid: AQPROF_TABLE_RECID;
  end;


  AQPROF_FAILURE_DATA = packed record
    FailureNo: SYSINT;
    FailureDesc: WideString;
  end;


  AQPROF_EVENT_DATA = packed record
    Event: AQPROF_EVENT;
    Data: CVOID_PTR;
    ThreadRow: AQPROF_TABLE_ROW;
  end;


  AQPROF_EVENT_SET_OPTION = packed record
    Id: TGUID;
    Value: OleVariant;
  end;

  INT_PTR = Integer; 

  tagImportFunctionInfo = packed record
    Name: WideString;
    Ordinal: LongWord;
    ThunkAddress: Int64;
    OriginalAddress: Int64;
  end;

  tagTaqPatchInfo = packed record
    HookAddress: Largeuint;
  end;

  tagTaqBlockInfo = packed record
    StartOffset: LongWord;
    EndOffset: LongWord;
    StartInfo: tagTaqPatchInfo;
    BlockId: LongWord;
    SubBlocksCount: LongWord;
  end;

  tagTaqLineInfo = packed record
    StartOffset: LongWord;
    EndOffset: LongWord;
  end;


  AQPE_DOS_HEADER = packed record
    e_magic: Word;
    e_cblp: Word;
    e_cp: Word;
    e_crlc: Word;
    e_cparhdr: Word;
    e_minalloc: Word;
    e_maxalloc: Word;
    e_ss: Word;
    e_sp: Word;
    e_csum: Word;
    e_ip: Word;
    e_cs: Word;
    e_lfarlc: Word;
    e_ovno: Word;
    e_res: array[0..3] of Word;
    e_oemid: Word;
    e_oeminfo: Word;
    e_res2: array[0..9] of Word;
    e_lfanew: Integer;
  end;


  AQPE_FILE_HEADER = packed record
    Machine: Word;
    NumberOfSections: Word;
    TimeDateStamp: LongWord;
    PointerToSymbolTable: LongWord;
    NumberOfSymbols: LongWord;
    SizeOfOptionalHeader: Word;
    Characteristics: Word;
  end;


  AQPE_OPTIONAL_HEADER = packed record
    Magic: Word;
    MajorLinkerVersion: Byte;
    MinorLinkerVersion: Byte;
    SizeOfCode: LongWord;
    SizeOfInitializedData: LongWord;
    SizeOfUninitializedData: LongWord;
    AddressOfEntryPoint: LongWord;
    BaseOfCode: LongWord;
    BaseOfData: LongWord;
    ImageBase: Largeuint;
    SectionAlignment: LongWord;
    FileAlignment: LongWord;
    MajorOperatingSystemVersion: Word;
    MinorOperatingSystemVersion: Word;
    MajorImageVersion: Word;
    MinorImageVersion: Word;
    MajorSubsystemVersion: Word;
    MinorSubsystemVersion: Word;
    Win32VersionValue: LongWord;
    SizeOfImage: LongWord;
    SizeOfHeaders: LongWord;
    CheckSum: LongWord;
    Subsystem: Word;
    DllCharacteristics: Word;
    SizeOfStackReserve: Largeuint;
    SizeOfStackCommit: Largeuint;
    SizeOfHeapReserve: Largeuint;
    SizeOfHeapCommit: Largeuint;
    LoaderFlags: LongWord;
    NumberOfRvaAndSizes: LongWord;
    DataDirectory: array[0..127] of Byte;
  end;


  AQPE_SECTION_HEADER_MISC = record
    case Integer of
      0: (PhysicalAddress: LongWord);
      1: (VirtualSize: LongWord);
  end;

  AQPE_SECTION_HEADER = packed record
    Name: array[0..7] of Byte;
    Misc: AQPE_SECTION_HEADER_MISC;
    VirtualAddress: LongWord;
    SizeOfRawData: LongWord;
    PointerToRawData: LongWord;
    PointerToRelocations: LongWord;
    PointerToLinenumbers: LongWord;
    NumberOfRelocations: Word;
    NumberOfLinenumbers: Word;
    Characteristics: LongWord;
  end;


  AQPE_IMPORT_ROUTINE_INFO = packed record
    Name: WideString;
    Hint: LongWord;
    Ordinal: LongWord;
    OffsetToAddress: LongWord;
  end;


  AQPE_EXPORT_ROUTINE_INFO = packed record
    Name: WideString;
    Address: UINT_PTR;
    Ordinal: LongWord;
    Hint: LongWord;
  end;


  AQDBGHELP_START_WALKSTACK_INFO = packed record
    EIP: UINT_PTR;
    Esp: UINT_PTR;
    EBP: UINT_PTR;
    StackTop: UINT_PTR;
  end;


  AQDBGHELP_ROUTINE_INFO = packed record
    AddressStart: UINT_PTR;
    AddressEnd: UINT_PTR;
    HasStackFrame: WordBool;
    LocalVarSize: UINT_PTR;
    ParameterSize: UINT_PTR;
  end;

  AQDBGHELP_START_WALKSTACK_INFO64 = packed record
    Rip: Largeuint;
    Rax: Largeuint;
    Rcx: Largeuint;
    Rdx: Largeuint;
    Rbx: Largeuint;
    Rsp: Largeuint;
    Rbp: Largeuint;
    Rsi: Largeuint;
    Rdi: Largeuint;
    R8: Largeuint;
    R9: Largeuint;
    R10: Largeuint;
    R11: Largeuint;
    R12: Largeuint;
    R13: Largeuint;
    R14: Largeuint;
    R15: Largeuint;
  end;


  AQ_EXCEPTION_RECORD = packed record
    ExceptionCode: LongWord;
    ExceptionFlags: LongWord;
    ExceptionRecord: Pointer;
    ExceptionAddress: Pointer;
    NumberParameters: LongWord;
    ExceptionInformation: array[0..14] of UINT_PTR;
  end;

  AQ_EXCEPTION_INFO = packed record
    ExceptionRecord: AQ_EXCEPTION_RECORD;
    dwFirstChance: LongWord;
  end;


  AQ_PROCESS_INFORMATION = packed record
    PID: LongWord;
    ProcessName: WideString;
    ProcessPath: WideString;
    UserName: WideString;
    CommandLine: WideString;
    IsDebugging: WordBool;
    IsSystemProcess: WordBool;
    IsSystemIdleProcess: WordBool;
    IsFakeProcess: WordBool;
    ParentPID: LongWord;
    PriorityClass: Integer;
    ProcessTime: Int64;
    ThreadCount: SYSINT;
    HandleCount: SYSINT;
    MemUsage: LongWord;
    VMSize: LongWord;
    SessionId: LongWord;
  end;


  AQ_PROCESS_INFORMATION_LIGHT = packed record
    PID: LongWord;
    ParentPID: LongWord;
    PriorityClass: Integer;
    ProcessTime: Int64;
    ThreadCount: SYSINT;
    HandleCount: SYSINT;
    MemUsage: LongWord;
    VMSize: LongWord;
    SessionId: LongWord;
  end;


  AQ_MODULE_DESCRIPTION = packed record
    hModule: UINT_PTR;
    ModuleName: WideString;
    ModulePath: WideString;
    BaseAddress: UINT_PTR;
    ImageSize: SYSINT;
  end;

  tagRECT = packed record
    Left: Integer;
    Top: Integer;
    right: Integer;
    bottom: Integer;
  end;


  AQ_WINDOW_INFO = packed record
    hWnd: UINT_PTR;
    ThreadID: LongWord;
    ProcessID: LongWord;
  end;

  AQ_SCROLL_INFO_TAG = packed record
    Min: Integer;
    Max: Integer;
    Page: Integer;
    Pos: Integer;
    TrackPos: Integer;
  end;

  AQ_SCROLL_INFO = AQ_SCROLL_INFO_TAG; 

  AQ_MENUITEM_INFO = packed record
    type_: Integer;
    State: Integer;
    Id: Integer;
    SubMenu: UINT_PTR;
    hBmpChecked: UINT_PTR;
    hBmpUnchecked: UINT_PTR;
    dwItemData: UINT_PTR;
    TypeData: WideString;
  end;

  tagPOINT = packed record
    X: Integer;
    Y: Integer;
  end;


  AQPE_DATA_DIRECTORY = packed record
    VirtualAddress: LongWord;
    Size: LongWord;
  end;


  AQDBGHELP_STACK_ITEM_INFO = packed record
    Address: Largeuint;
    ModuleName: WideString;
    Routine: IaqDbgRoutine;
    OffsetFromRoutineStart: Integer;
    LineNo: Integer;
    StackAddress: Largeuint;
  end;


  AQ_BASE_PROFILER_DESCRIPTION = packed record
    Key: TGUID;
    Name: WideString;
    Description: WideString;
    IsStatic: WordBool;
    InjectDll: WordBool;
    CreateAllThreadsNode: WordBool;
    Conflicts: WideString;
    Depends: WideString;
    MajorVersion: Integer;
    MinorVersion: Integer;
  end;

  tagSAFEARRAYBOUND = packed record
    cElements: LongWord;
    lLbound: Integer;
  end;

  tagSAFEARRAY = packed record
    cDims: Word;
    fFeatures: Word;
    cbElements: LongWord;
    cLocks: LongWord;
    pvData: Pointer;
    rgsabound: ^tagSAFEARRAYBOUND;
  end;


// *********************************************************************//
// Interface: IaqIterator
// Flags:     (0)
// GUID:      {CBF231D8-BA01-4937-B653-41048D569054}
// *********************************************************************//
  IaqIterator = interface(IUnknown)
    ['{CBF231D8-BA01-4937-B653-41048D569054}']
    procedure Skip(Count: Integer); stdcall;
    function HasNext: WordBool; stdcall;
    procedure Reset; stdcall;
  end;

// *********************************************************************//
// Interface: IaqUnknownIterator
// Flags:     (0)
// GUID:      {1C991424-03D6-4E98-9F77-580EA569C2D9}
// *********************************************************************//
  IaqUnknownIterator = interface(IaqIterator)
    ['{1C991424-03D6-4E98-9F77-580EA569C2D9}']
    function Next: IUnknown; safecall;
  end;

// *********************************************************************//
// Interface: IaqGUIDIterator
// Flags:     (0)
// GUID:      {5F8E7434-68EB-4953-8F4E-EA6790E99E79}
// *********************************************************************//
  IaqGUIDIterator = interface(IaqIterator)
    ['{5F8E7434-68EB-4953-8F4E-EA6790E99E79}']
    procedure Next(out Value: TGUID); stdcall;
  end;

// *********************************************************************//
// Interface: IaqModuleIntf
// Flags:     (0)
// GUID:      {C6736F7A-FD53-4EE5-9899-478623853C6C}
// *********************************************************************//
  IaqModuleIntf = interface(IUnknown)
    ['{C6736F7A-FD53-4EE5-9899-478623853C6C}']
    procedure AddNotifier(const Notifier: IaqModuleIntfNotifier); safecall;
    procedure RemoveNotifier(const Notifier: IaqModuleIntfNotifier); safecall;
    procedure AddLastNotifier(const Notifier: IaqModuleIntfNotifier); safecall;
    procedure RemoveLastNotifier(const Notifier: IaqModuleIntfNotifier); safecall;
  end;

// *********************************************************************//
// Interface: IaqModuleIntfNotifier
// Flags:     (0)
// GUID:      {6D26EF70-10E3-4321-8FEA-CB63B923685C}
// *********************************************************************//
  IaqModuleIntfNotifier = interface(IUnknown)
    ['{6D26EF70-10E3-4321-8FEA-CB63B923685C}']
    procedure OnUnloadDll(const FileName: WideString; const Module: IaqModuleIntf); safecall;
  end;

// *********************************************************************//
// Interface: IaqKeyItem
// Flags:     (256) OleAutomation
// GUID:      {F3851EB7-0D12-425C-A983-30A86A0A5E64}
// *********************************************************************//
  IaqKeyItem = interface(IUnknown)
    ['{F3851EB7-0D12-425C-A983-30A86A0A5E64}']
    procedure GetKey(out Value: TGUID); stdcall;
  end;

// *********************************************************************//
// Interface: IaqStream
// Flags:     (0)
// GUID:      {BFC06497-51E1-4952-8882-00539BBFF737}
// *********************************************************************//
  IaqStream = interface(IUnknown)
    ['{BFC06497-51E1-4952-8882-00539BBFF737}']
    function Get_Size: LongWord; safecall;
    function Get_Position: LongWord; safecall;
    procedure Set_Position(Value: LongWord); safecall;
    procedure Read(Buffer: VOID_PTR; Size: LongWord); safecall;
    function ReadByte: Byte; safecall;
    function ReadInt16: Smallint; safecall;
    function ReadUInt16: Word; safecall;
    function ReadInt32: Integer; safecall;
    function ReadUInt32: LongWord; safecall;
    function ReadInt64: Int64; safecall;
    function ReadUInt64: Largeuint; safecall;
    function ReadSingle: Single; safecall;
    function ReadDouble: Double; safecall;
    function ReadString: WideString; safecall;
    function ReadVariant: OleVariant; safecall;
    procedure Write(Buffer: CVOID_PTR; Size: LongWord); safecall;
    procedure WriteByte(Value: Byte); safecall;
    procedure WriteInt16(Value: Smallint); safecall;
    procedure WriteUInt16(Value: Word); safecall;
    procedure WriteInt32(Value: Integer); safecall;
    procedure WriteUInt32(Value: LongWord); safecall;
    procedure WriteInt64(Value: Int64); safecall;
    procedure WriteUInt64(Value: Largeuint); safecall;
    procedure WriteString(const Value: WideString); safecall;
    procedure WriteVariant(Value: OleVariant); safecall;
    property Size: LongWord read Get_Size;
    property Position: LongWord read Get_Position write Set_Position;
  end;

// *********************************************************************//
// Interface: IaqPersistStream
// Flags:     (0)
// GUID:      {F911D2BB-6928-4A5B-9292-47374D5408B5}
// *********************************************************************//
  IaqPersistStream = interface(IUnknown)
    ['{F911D2BB-6928-4A5B-9292-47374D5408B5}']
    procedure SaveToStream(const Stream: IaqStream); safecall;
    procedure LoadFromStream(const Stream: IaqStream); safecall;
  end;

// *********************************************************************//
// Interface: IaqStringIterator
// Flags:     (0)
// GUID:      {E7D22731-F671-4C07-90CA-C8829E03B10C}
// *********************************************************************//
  IaqStringIterator = interface(IaqIterator)
    ['{E7D22731-F671-4C07-90CA-C8829E03B10C}']
    procedure Next(out Value: WideString); stdcall;
  end;

// *********************************************************************//
// Interface: IaqActionItem
// Flags:     (0)
// GUID:      {8317D966-E1A6-42A6-A35A-9BC3F4AD67BF}
// *********************************************************************//
  IaqActionItem = interface(IaqKeyItem)
    ['{8317D966-E1A6-42A6-A35A-9BC3F4AD67BF}']
    function GetCategory: WideString; safecall;
    function GetActionType: AQ_ACTION_TYPE; stdcall;
    procedure GetContextType(out Value: TGUID); stdcall;
    procedure GetProperties(PropertyID: AQ_ACTION_PROPERTY; out Value: OleVariant); stdcall;
    procedure SetProperties(PropertyID: AQ_ACTION_PROPERTY; Value: OleVariant); stdcall;
    function Execute(InValue: OleVariant; out OutValue: OleVariant): AQ_ACTION_EXEC_RESULT; stdcall;
    procedure Update; stdcall;
    procedure UpdateAll; stdcall;
  end;

// *********************************************************************//
// Interface: IaqActionNotifier
// Flags:     (0)
// GUID:      {BBFA0DB1-C94E-4C24-94B6-64A7218682E2}
// *********************************************************************//
  IaqActionNotifier = interface(IUnknown)
    ['{BBFA0DB1-C94E-4C24-94B6-64A7218682E2}']
    function OnExecute(const Sender: IaqActionItem; InValue: OleVariant; out OutValue: OleVariant): AQ_ACTION_EXEC_RESULT; stdcall;
    procedure OnUpdate(const Sender: IaqActionItem); stdcall;
  end;

// *********************************************************************//
// Interface: IaqSubsystemManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {91DD7397-BDF6-4786-B806-6BF82E40EBA3}
// *********************************************************************//
  IaqSubsystemManager = interface(IDispatch)
    ['{91DD7397-BDF6-4786-B806-6BF82E40EBA3}']
    function Get_BaseManager: IaqBaseManager; safecall;
    procedure InitializeManager(const Manager: IaqBaseManager); safecall;
    procedure DisposeManager; safecall;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); safecall;
    property BaseManager: IaqBaseManager read Get_BaseManager;
  end;

// *********************************************************************//
// DispIntf:  IaqSubsystemManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {91DD7397-BDF6-4786-B806-6BF82E40EBA3}
// *********************************************************************//
  IaqSubsystemManagerDisp = dispinterface
    ['{91DD7397-BDF6-4786-B806-6BF82E40EBA3}']
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqBaseManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F6BA5917-54F4-45B4-AEE9-5A49ACDFB419}
// *********************************************************************//
  IaqBaseManager = interface(IDispatch)
    ['{F6BA5917-54F4-45B4-AEE9-5A49ACDFB419}']
    function Get_RunMode: TaqRunMode; safecall;
    procedure Set_RunMode(RetVal: TaqRunMode); safecall;
    procedure AddManager(Id: TGUID; const Value: IaqSubsystemManager); safecall;
    procedure RemoveManager(Id: TGUID); safecall;
    function Get_Managers(Id: TGUID): IaqSubsystemManager; safecall;
    function Get_ProductInfo: IaqProductInfo; safecall;
    function Get_ManagersByString(const Id: WideString): IaqSubsystemManager; safecall;
    function Get_State: AQ_MAINMANAGER_STATE; safecall;
    property RunMode: TaqRunMode read Get_RunMode write Set_RunMode;
    property Managers[Id: TGUID]: IaqSubsystemManager read Get_Managers;
    property ProductInfo: IaqProductInfo read Get_ProductInfo;
    property ManagersByString[const Id: WideString]: IaqSubsystemManager read Get_ManagersByString;
    property State: AQ_MAINMANAGER_STATE read Get_State;
  end;

// *********************************************************************//
// DispIntf:  IaqBaseManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F6BA5917-54F4-45B4-AEE9-5A49ACDFB419}
// *********************************************************************//
  IaqBaseManagerDisp = dispinterface
    ['{F6BA5917-54F4-45B4-AEE9-5A49ACDFB419}']
    property RunMode: TaqRunMode dispid 159745;
    procedure AddManager(Id: {??TGUID}OleVariant; const Value: IaqSubsystemManager); dispid 159746;
    procedure RemoveManager(Id: {??TGUID}OleVariant); dispid 159747;
    property Managers[Id: {??TGUID}OleVariant]: IaqSubsystemManager readonly dispid 159748;
    property ProductInfo: IaqProductInfo readonly dispid 159751;
    property ManagersByString[const Id: WideString]: IaqSubsystemManager readonly dispid 159753;
    property State: AQ_MAINMANAGER_STATE readonly dispid 159755;
  end;

// *********************************************************************//
// Interface: IaqProductInfo
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C9AC70BB-6C3A-4228-BFC2-4142CC21D17B}
// *********************************************************************//
  IaqProductInfo = interface(IDispatch)
    ['{C9AC70BB-6C3A-4228-BFC2-4142CC21D17B}']
    function Get_Name: WideString; safecall;
    function Get_VersionMajor: Integer; safecall;
    function Get_VersionMinor: Integer; safecall;
    function Get_VersionRelease: Integer; safecall;
    function Get_VersionBuild: Integer; safecall;
    function Get_VersionValue: WideString; safecall;
    function Get_RegistryPath: WideString; safecall;
    function Get_ProductPath: WideString; safecall;
    function Get_ProductDataFolder: WideString; safecall;
    function Get_ProductLocalSettingsDataFolder: WideString; safecall;
    function Get_ProductCommonDataFolder: WideString; safecall;
    function Get_HelpFile: WideString; safecall;
    function Get_WhatThisHelpFile: WideString; safecall;
    function Get_WebSite: WideString; safecall;
    function Get_SupportAddress: WideString; safecall;
    function Get_SupportText: WideString; safecall;
    function Get_Copyright: WideString; safecall;
    function Get_IntegrationType: TGUID; safecall;
    function Get_ProductKey: TGUID; safecall;
    property Name: WideString read Get_Name;
    property VersionMajor: Integer read Get_VersionMajor;
    property VersionMinor: Integer read Get_VersionMinor;
    property VersionRelease: Integer read Get_VersionRelease;
    property VersionBuild: Integer read Get_VersionBuild;
    property VersionValue: WideString read Get_VersionValue;
    property RegistryPath: WideString read Get_RegistryPath;
    property ProductPath: WideString read Get_ProductPath;
    property ProductDataFolder: WideString read Get_ProductDataFolder;
    property ProductLocalSettingsDataFolder: WideString read Get_ProductLocalSettingsDataFolder;
    property ProductCommonDataFolder: WideString read Get_ProductCommonDataFolder;
    property HelpFile: WideString read Get_HelpFile;
    property WhatThisHelpFile: WideString read Get_WhatThisHelpFile;
    property WebSite: WideString read Get_WebSite;
    property SupportAddress: WideString read Get_SupportAddress;
    property SupportText: WideString read Get_SupportText;
    property Copyright: WideString read Get_Copyright;
    property IntegrationType: TGUID read Get_IntegrationType;
    property ProductKey: TGUID read Get_ProductKey;
  end;

// *********************************************************************//
// DispIntf:  IaqProductInfoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C9AC70BB-6C3A-4228-BFC2-4142CC21D17B}
// *********************************************************************//
  IaqProductInfoDisp = dispinterface
    ['{C9AC70BB-6C3A-4228-BFC2-4142CC21D17B}']
    property Name: WideString readonly dispid 155649;
    property VersionMajor: Integer readonly dispid 155650;
    property VersionMinor: Integer readonly dispid 155651;
    property VersionRelease: Integer readonly dispid 155652;
    property VersionBuild: Integer readonly dispid 155653;
    property VersionValue: WideString readonly dispid 155654;
    property RegistryPath: WideString readonly dispid 155655;
    property ProductPath: WideString readonly dispid 155656;
    property ProductDataFolder: WideString readonly dispid 155657;
    property ProductLocalSettingsDataFolder: WideString readonly dispid 155658;
    property ProductCommonDataFolder: WideString readonly dispid 155659;
    property HelpFile: WideString readonly dispid 155660;
    property WhatThisHelpFile: WideString readonly dispid 155661;
    property WebSite: WideString readonly dispid 155662;
    property SupportAddress: WideString readonly dispid 155663;
    property SupportText: WideString readonly dispid 155664;
    property Copyright: WideString readonly dispid 155665;
    property IntegrationType: {??TGUID}OleVariant readonly dispid 155666;
    property ProductKey: {??TGUID}OleVariant readonly dispid 155667;
  end;

// *********************************************************************//
// Interface: IaqActionManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {66B82366-743B-4638-B399-DC7745476471}
// *********************************************************************//
  IaqActionManager = interface(IaqSubsystemManager)
    ['{66B82366-743B-4638-B399-DC7745476471}']
    function CreateEmptyAction(AActionType: AQ_ACTION_TYPE; AActionKey: TGUID; 
                               const ACategory: WideString; APermanent: WordBool; ContextType: TGUID): IaqActionItem; safecall;
    procedure AddAction(const AAction: IaqActionItem; ActionProviderKey: TGUID); safecall;
    procedure RemoveAction(AActionKey: TGUID); safecall;
    procedure AddActionNotifier(AActionKey: TGUID; AContextKey: TGUID; 
                                const ANotification: IaqActionNotifier); safecall;
    procedure RemoveActionNotifier(AActionKey: TGUID; AContextKey: TGUID); safecall;
    procedure AddActionProvider(const ActionProvider: IaqActionProvider); safecall;
    procedure RemoveActionProvider(ActionProviderKey: TGUID); safecall;
    procedure BeginUpdate; safecall;
    procedure EndUpdate; safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqActionManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {66B82366-743B-4638-B399-DC7745476471}
// *********************************************************************//
  IaqActionManagerDisp = dispinterface
    ['{66B82366-743B-4638-B399-DC7745476471}']
    function CreateEmptyAction(AActionType: AQ_ACTION_TYPE; AActionKey: {??TGUID}OleVariant; 
                               const ACategory: WideString; APermanent: WordBool; 
                               ContextType: {??TGUID}OleVariant): IaqActionItem; dispid 1610809344;
    procedure AddAction(const AAction: IaqActionItem; ActionProviderKey: {??TGUID}OleVariant); dispid 1610809345;
    procedure RemoveAction(AActionKey: {??TGUID}OleVariant); dispid 1610809346;
    procedure AddActionNotifier(AActionKey: {??TGUID}OleVariant; AContextKey: {??TGUID}OleVariant; 
                                const ANotification: IaqActionNotifier); dispid 1610809347;
    procedure RemoveActionNotifier(AActionKey: {??TGUID}OleVariant; AContextKey: {??TGUID}OleVariant); dispid 18874372;
    procedure AddActionProvider(const ActionProvider: IaqActionProvider); dispid 1610809349;
    procedure RemoveActionProvider(ActionProviderKey: {??TGUID}OleVariant); dispid 1610809350;
    procedure BeginUpdate; dispid 1610809351;
    procedure EndUpdate; dispid 1610809352;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqActionProvider
// Flags:     (0)
// GUID:      {0BC3528C-1C19-4AA2-8343-FA57FACB4E4D}
// *********************************************************************//
  IaqActionProvider = interface(IaqKeyItem)
    ['{0BC3528C-1C19-4AA2-8343-FA57FACB4E4D}']
    procedure CreateActions; safecall;
    procedure ConfigureActions; safecall;
    procedure ActionsRemoved; safecall;
  end;

// *********************************************************************//
// Interface: IaqActionsContainer
// Flags:     (0)
// GUID:      {7FB5765D-05CB-47AA-8166-DA774AA43678}
// *********************************************************************//
  IaqActionsContainer = interface(IaqKeyItem)
    ['{7FB5765D-05CB-47AA-8166-DA774AA43678}']
    procedure AddAction(AActionKey: TGUID; APosition: AQ_ACTION_POSITION; const PositionKey: PGUID); safecall;
    procedure AddSubmenu(const ASubMenu: IaqSubMenu; APosition: AQ_ACTION_POSITION; 
                         const PositionKey: PGUID); safecall;
    procedure AddSeparator(APosition: AQ_ACTION_POSITION; const PositionKey: PGUID); safecall;
    procedure RemoveAction(AActionKey: TGUID); safecall;
    procedure Clear; safecall;
    procedure BeginUpdate; safecall;
    procedure EndUpdate; safecall;
    function Get_IsPersistent: WordBool; safecall;
    procedure Set_IsPersistent(Value: WordBool); safecall;
    property IsPersistent: WordBool read Get_IsPersistent write Set_IsPersistent;
  end;

// *********************************************************************//
// Interface: IaqSubMenu
// Flags:     (0)
// GUID:      {E50593FE-999F-4972-8E26-EDB6C4CFC68B}
// *********************************************************************//
  IaqSubMenu = interface(IaqActionsContainer)
    ['{E50593FE-999F-4972-8E26-EDB6C4CFC68B}']
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    property Caption: WideString read Get_Caption write Set_Caption;
  end;

// *********************************************************************//
// Interface: IaqToolbar
// Flags:     (0)
// GUID:      {4FFB9E34-5DCA-4687-B392-19F539474E00}
// *********************************************************************//
  IaqToolbar = interface(IaqActionsContainer)
    ['{4FFB9E34-5DCA-4687-B392-19F539474E00}']
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure AddLabel(const Caption: WideString; APosition: AQ_ACTION_POSITION; 
                       const PositionKey: PGUID); safecall;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Visible: WordBool read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// Interface: IaqPopupMenu
// Flags:     (0)
// GUID:      {0CE857AD-D614-4FEB-BFAB-E21B81B2E7AA}
// *********************************************************************//
  IaqPopupMenu = interface(IaqActionsContainer)
    ['{0CE857AD-D614-4FEB-BFAB-E21B81B2E7AA}']
    procedure PopUp; safecall;
    procedure PopUpAtPos(X: Integer; Y: Integer); safecall;
    function Get_Visible: WordBool; safecall;
    property Visible: WordBool read Get_Visible;
  end;

// *********************************************************************//
// Interface: IaqActionsCustomizer
// Flags:     (4096) Dispatchable
// GUID:      {239FCDBF-49D7-4838-BD45-77288F7D9B57}
// *********************************************************************//
  IaqActionsCustomizer = interface(IaqSubsystemManager)
    ['{239FCDBF-49D7-4838-BD45-77288F7D9B57}']
    function AddToolbar(AToolBarKey: TGUID; ActionsStorageKey: TGUID): IaqToolbar; safecall;
    procedure RemoveToolbar(AToolBarKey: TGUID); safecall;
    function AddPopupMenu(APopUpMenuKey: TGUID; ActionsStorageKey: TGUID): IaqPopupMenu; safecall;
    procedure RemovePopupMenu(APopUpMenuKey: TGUID); safecall;
    function AddSubmenu(ASubMenuKey: TGUID; ActionsStorageKey: TGUID): IaqSubMenu; safecall;
    procedure RemoveSubMenu(ASubMenuKey: TGUID); safecall;
    function Get_Toolbars(AToolBarKey: TGUID): IaqToolbar; safecall;
    function Get_PopupMenus(APopUpMenuKey: TGUID): IaqPopupMenu; safecall;
    function Get_SubMenus(ASubMenuKey: TGUID): IaqSubMenu; safecall;
    procedure HidePopupMenus; safecall;
    function HasVisiblePopupMenu: WordBool; safecall;
    property Toolbars[AToolBarKey: TGUID]: IaqToolbar read Get_Toolbars;
    property PopupMenus[APopUpMenuKey: TGUID]: IaqPopupMenu read Get_PopupMenus;
    property SubMenus[ASubMenuKey: TGUID]: IaqSubMenu read Get_SubMenus;
  end;

// *********************************************************************//
// Interface: IaqHelpSystemManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9881C64F-1CBB-468F-A6E9-A9AB9040AA30}
// *********************************************************************//
  IaqHelpSystemManager = interface(IaqSubsystemManager)
    ['{9881C64F-1CBB-468F-A6E9-A9AB9040AA30}']
    procedure ShowTOC; safecall;
    procedure ShowIndex; safecall;
    procedure ShowHelp(ContextID: Integer; const HelpFileName: WideString); safecall;
    procedure ShowKeywordHelp(const KeyWord: WideString; const HelpFileName: WideString); safecall;
    function WinHelpCommand(Handle: Integer; const HelpFile: WideString; Command: Smallint; 
                            Data: Integer): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqHelpSystemManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9881C64F-1CBB-468F-A6E9-A9AB9040AA30}
// *********************************************************************//
  IaqHelpSystemManagerDisp = dispinterface
    ['{9881C64F-1CBB-468F-A6E9-A9AB9040AA30}']
    procedure ShowTOC; dispid 1610809344;
    procedure ShowIndex; dispid 1610809345;
    procedure ShowHelp(ContextID: Integer; const HelpFileName: WideString); dispid 1610809346;
    procedure ShowKeywordHelp(const KeyWord: WideString; const HelpFileName: WideString); dispid 1610809347;
    function WinHelpCommand(Handle: Integer; const HelpFile: WideString; Command: Smallint; 
                            Data: Integer): WordBool; dispid 1610809348;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqBaseEvent
// Flags:     (256) OleAutomation
// GUID:      {8FDE4C22-70A8-41F5-9A12-AB2D32B3B495}
// *********************************************************************//
  IaqBaseEvent = interface(IaqKeyItem)
    ['{8FDE4C22-70A8-41F5-9A12-AB2D32B3B495}']
    function Get_EventInfo: WideString; safecall;
    property EventInfo: WideString read Get_EventInfo;
  end;

// *********************************************************************//
// Interface: IaqEventDispatcher
// Flags:     (0)
// GUID:      {41BB7A50-D638-4A13-A817-3E8A18185387}
// *********************************************************************//
  IaqEventDispatcher = interface(IUnknown)
    ['{41BB7A50-D638-4A13-A817-3E8A18185387}']
    procedure DispatchEvent(const EventID: TGUID; Data: UINT_PTR; Size: LongWord; 
                            const Event: IaqBaseEvent); safecall;
    function Get_SyncNotifier: IaqBaseEvent; safecall;
    function Get_AsyncNotifier: IaqBaseEvent; safecall;
    property SyncNotifier: IaqBaseEvent read Get_SyncNotifier;
    property AsyncNotifier: IaqBaseEvent read Get_AsyncNotifier;
  end;

// *********************************************************************//
// Interface: IaqRegistrationInfo
// Flags:     (4352) OleAutomation Dispatchable
// GUID:      {9001119C-9507-4781-A177-BFE0F7D95A42}
// *********************************************************************//
  IaqRegistrationInfo = interface(IDispatch)
    ['{9001119C-9507-4781-A177-BFE0F7D95A42}']
    function IsRegistered: WordBool; safecall;
  end;

// *********************************************************************//
// Interface: IaqEventsListenerProvider
// Flags:     (256) OleAutomation
// GUID:      {FD39D04F-1093-43A8-8BD8-B4938F47F495}
// *********************************************************************//
  IaqEventsListenerProvider = interface(IaqBaseEvent)
    ['{FD39D04F-1093-43A8-8BD8-B4938F47F495}']
    function GetCountListenedEvent: Integer; stdcall;
    procedure GetListenedEventInfo(Index: Integer; out Value: AQ_EVENT_INFO); stdcall;
  end;

// *********************************************************************//
// Interface: IaqEventManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B194834B-CBC1-4C10-9840-53294F41FC3F}
// *********************************************************************//
  IaqEventManager = interface(IaqSubsystemManager)
    ['{B194834B-CBC1-4C10-9840-53294F41FC3F}']
    procedure AddEventsProvider(const AProvider: IaqEventsListenerProvider); safecall;
    procedure RemoveEventsProvider(const AProviderKey: TGUID); safecall;
    procedure AddDispatcher(const EventID: TGUID; const Dispatcher: IaqEventDispatcher); safecall;
    procedure RemoveDispatcher(const EventID: TGUID); safecall;
    function GetNotifier(const EventID: TGUID; CallSynchronously: WordBool): IUnknown; safecall;
    procedure RaiseEvent(const EventID: TGUID; CallSynchronously: WordBool); safecall;
    procedure RaiseEventEx(const EventID: TGUID; Data: UINT_PTR; Size: LongWord; 
                           CallSynchronously: WordBool); safecall;
    procedure RaiseVariantEvent(const EventID: TGUID; Data: OleVariant; CallSynchronously: WordBool); safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqEventManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B194834B-CBC1-4C10-9840-53294F41FC3F}
// *********************************************************************//
  IaqEventManagerDisp = dispinterface
    ['{B194834B-CBC1-4C10-9840-53294F41FC3F}']
    procedure AddEventsProvider(const AProvider: IaqEventsListenerProvider); dispid 90138;
    procedure RemoveEventsProvider(var AProviderKey: {??TGUID}OleVariant); dispid 90139;
    procedure AddDispatcher(var EventID: {??TGUID}OleVariant; const Dispatcher: IaqEventDispatcher); dispid 90142;
    procedure RemoveDispatcher(var EventID: {??TGUID}OleVariant); dispid 90143;
    function GetNotifier(var EventID: {??TGUID}OleVariant; CallSynchronously: WordBool): IUnknown; dispid 90144;
    procedure RaiseEvent(var EventID: {??TGUID}OleVariant; CallSynchronously: WordBool); dispid 90145;
    procedure RaiseEventEx(var EventID: {??TGUID}OleVariant; Data: UINT_PTR; Size: LongWord; 
                           CallSynchronously: WordBool); dispid 90146;
    procedure RaiseVariantEvent(var EventID: {??TGUID}OleVariant; Data: OleVariant; 
                                CallSynchronously: WordBool); dispid 90147;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqBeforeEvent
// Flags:     (256) OleAutomation
// GUID:      {07418EA2-7AFE-4BDF-B02C-A77353D50830}
// *********************************************************************//
  IaqBeforeEvent = interface(IaqBaseEvent)
    ['{07418EA2-7AFE-4BDF-B02C-A77353D50830}']
    procedure OnBeforeEvent(const EventID: TGUID); stdcall;
  end;

// *********************************************************************//
// Interface: IaqAfterEvent
// Flags:     (256) OleAutomation
// GUID:      {1195DF76-3EB4-4C86-94A5-9B2AF1443EC6}
// *********************************************************************//
  IaqAfterEvent = interface(IaqBaseEvent)
    ['{1195DF76-3EB4-4C86-94A5-9B2AF1443EC6}']
    procedure OnAfterEvent(const EventID: TGUID); stdcall;
  end;

// *********************************************************************//
// Interface: IaqOptionsNode
// Flags:     (0)
// GUID:      {85A753A9-022E-42AC-818D-77679EA52F29}
// *********************************************************************//
  IaqOptionsNode = interface(IUnknown)
    ['{85A753A9-022E-42AC-818D-77679EA52F29}']
    procedure GetName(out Value: WideString); stdcall;
    procedure GetChild(const ChildNodeName: WideString; out Value: IaqOptionsNode); stdcall;
    procedure RemoveChild(const ChildNodeName: WideString); stdcall;
    function IsChildExist(const ChildNodeName: WideString): WordBool; stdcall;
    procedure Clear; stdcall;
    procedure CopyTo(const DestinationNode: IaqOptionsNode); stdcall;
    procedure EnumChilds(out Value: IaqOptionsNodeIterator); stdcall;
    procedure GetProperties(out Value: IaqProperties); stdcall;
    function IsChanged: WordBool; stdcall;
    procedure GetStorageInfo(out Value: AQ_OPTIONS_STORAGE_INFO); stdcall;
  end;

// *********************************************************************//
// Interface: IaqOptionsNodeIterator
// Flags:     (0)
// GUID:      {F39421D0-ABA5-4CF1-B206-5CDA51B2A31D}
// *********************************************************************//
  IaqOptionsNodeIterator = interface(IaqIterator)
    ['{F39421D0-ABA5-4CF1-B206-5CDA51B2A31D}']
    procedure Next(out Value: IaqOptionsNode); stdcall;
  end;

// *********************************************************************//
// Interface: IaqProperties
// Flags:     (0)
// GUID:      {0EFA31D8-7670-4532-A9E1-0AC737E491CC}
// *********************************************************************//
  IaqProperties = interface(IUnknown)
    ['{0EFA31D8-7670-4532-A9E1-0AC737E491CC}']
    function GetInteger(const PropertyName: WideString; DefValue: Integer): Integer; safecall;
    function GetString(const PropertyName: WideString; const DefValue: WideString): WideString; safecall;
    function GetLong(const PropertyName: WideString; DefValue: Int64): Int64; safecall;
    function GetDouble(const PropertyName: WideString; DefValue: Double): Double; safecall;
    function GetBinary(const PropertyName: WideString; Buffer: UINT_PTR; BufferSize: Integer): Integer; safecall;
    function GetBoolean(const PropertyName: WideString; DefValue: WordBool): WordBool; safecall;
    procedure SetInteger(const PropertyName: WideString; Value: Integer); safecall;
    procedure SetString(const PropertyName: WideString; const Value: WideString); safecall;
    procedure SetLong(const PropertyName: WideString; Value: Int64); safecall;
    procedure SetDouble(const PropertyName: WideString; Value: Double); safecall;
    procedure SetBinary(const PropertyName: WideString; Buffer: UINT_PTR; BufferSize: Integer; 
                        CompressData: WordBool); safecall;
    procedure SetBoolean(const PropertyName: WideString; Value: WordBool); safecall;
    function GetBinaryPropertySize(const PropertyName: WideString): Integer; safecall;
    function IsPropertyExists(const PropertyName: WideString): WordBool; safecall;
    function EnumProperties: IaqPropertiesIterator; safecall;
    procedure Clear; safecall;
  end;

// *********************************************************************//
// Interface: IaqPropertiesIterator
// Flags:     (0)
// GUID:      {92BE422C-B52A-4D07-8D07-4223D1BA5296}
// *********************************************************************//
  IaqPropertiesIterator = interface(IaqIterator)
    ['{92BE422C-B52A-4D07-8D07-4223D1BA5296}']
    procedure Next(out Value: AQ_PROPERTY_DESCRIPTION); stdcall;
  end;

// *********************************************************************//
// Interface: IaqPropertiesEx
// Flags:     (0)
// GUID:      {1D0BFE81-F9BD-4AC4-82DA-8BE3C4A7A49E}
// *********************************************************************//
  IaqPropertiesEx = interface(IUnknown)
    ['{1D0BFE81-F9BD-4AC4-82DA-8BE3C4A7A49E}']
    function GetPropertyType(const PropertyName: WideString): AQ_PROPERTY_TYPE; safecall;
  end;

// *********************************************************************//
// Interface: IaqOptionsNodeStore
// Flags:     (0)
// GUID:      {2D203D1F-607A-4219-B015-2F93072067F3}
// *********************************************************************//
  IaqOptionsNodeStore = interface(IUnknown)
    ['{2D203D1F-607A-4219-B015-2F93072067F3}']
    procedure GetNode(SliceID: TGUID; out Value: IaqOptionsNode); stdcall;
    function GetSliceMode(SliceID: TGUID): AQ_OPTIONS_SLICE_MODE; stdcall;
    procedure GetChild(const ChildName: WideString; out Value: IaqOptionsNodeStore); stdcall;
  end;

// *********************************************************************//
// Interface: IaqOptionsProvider
// Flags:     (0)
// GUID:      {77755B15-2928-4B94-ADAF-2FB7D379C06F}
// *********************************************************************//
  IaqOptionsProvider = interface(IUnknown)
    ['{77755B15-2928-4B94-ADAF-2FB7D379C06F}']
    procedure SetOptions(const AOptionsNodeStore: IaqOptionsNodeStore); stdcall;
    procedure ReadOptions; stdcall;
    procedure SaveOptions; stdcall;
  end;

// *********************************************************************//
// Interface: IaqBasePlugin
// Flags:     (0)
// GUID:      {3E6C0AA1-39DF-D511-9A51-00D0B749C8FE}
// *********************************************************************//
  IaqBasePlugin = interface(IaqKeyItem)
    ['{3E6C0AA1-39DF-D511-9A51-00D0B749C8FE}']
    procedure Initialize(const Manager: IaqBaseManager); safecall;
    procedure Update; safecall;
    procedure Finalize; safecall;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); safecall;
  end;

// *********************************************************************//
// Interface: IaqExtendedPlugin
// Flags:     (0)
// GUID:      {CA5413B8-13F3-D511-915D-00D0B749C8FE}
// *********************************************************************//
  IaqExtendedPlugin = interface(IaqBasePlugin)
    ['{CA5413B8-13F3-D511-915D-00D0B749C8FE}']
    function Get_Name: WideString; safecall;
    function Get_Category: WideString; safecall;
    function Get_Image: AQ_RESOURCE_INFO; safecall;
    function Get_HelpFileName: WideString; safecall;
    function Get_HelpContext: Integer; safecall;
    property Name: WideString read Get_Name;
    property Category: WideString read Get_Category;
    property Image: AQ_RESOURCE_INFO read Get_Image;
    property HelpFileName: WideString read Get_HelpFileName;
    property HelpContext: Integer read Get_HelpContext;
  end;

// *********************************************************************//
// Interface: IaqPluginInformationRepository
// Flags:     (4096) Dispatchable
// GUID:      {69FB0002-D3DA-41ED-909B-12BEF03232B8}
// *********************************************************************//
  IaqPluginInformationRepository = interface(IaqSubsystemManager)
    ['{69FB0002-D3DA-41ED-909B-12BEF03232B8}']
    function Get_PluginInformation(PluginKey: TGUID): IaqPluginInformation; safecall;
    function CanInstallPlugin(PluginKey: TGUID): WordBool; safecall;
    function IsValidCurrentPluginSet: WordBool; safecall;
    procedure PostChange; safecall;
    procedure CancelChange; safecall;
    property PluginInformation[PluginKey: TGUID]: IaqPluginInformation read Get_PluginInformation;
  end;

// *********************************************************************//
// Interface: IaqPluginInformation
// Flags:     (0)
// GUID:      {D94A89FE-CBD9-45E1-8928-9FF371836E00}
// *********************************************************************//
  IaqPluginInformation = interface(IaqKeyItem)
    ['{D94A89FE-CBD9-45E1-8928-9FF371836E00}']
    function Get_Name: WideString; safecall;
    function Get_Description: WideString; safecall;
    function Get_Version: AQ_PLUGIN_VERSION; safecall;
    function Get_ConflictCount: Integer; safecall;
    function Get_DependencyCount: Integer; safecall;
    function Get_Conflicts(Index: Integer): TGUID; safecall;
    function Get_Dependencies(Index: Integer): TGUID; safecall;
    function Get_Selected: WordBool; safecall;
    procedure Set_Selected(Value: WordBool); safecall;
    function Get_Plugin: IaqBasePlugin; safecall;
    property Name: WideString read Get_Name;
    property Description: WideString read Get_Description;
    property Version: AQ_PLUGIN_VERSION read Get_Version;
    property ConflictCount: Integer read Get_ConflictCount;
    property DependencyCount: Integer read Get_DependencyCount;
    property Conflicts[Index: Integer]: TGUID read Get_Conflicts;
    property Dependencies[Index: Integer]: TGUID read Get_Dependencies;
    property Selected: WordBool read Get_Selected write Set_Selected;
    property Plugin: IaqBasePlugin read Get_Plugin;
  end;

// *********************************************************************//
// Interface: IaqExtensionRegistrator
// Flags:     (0)
// GUID:      {A82D9D30-3CDF-D511-9A51-00D0B749C8FE}
// *********************************************************************//
  IaqExtensionRegistrator = interface(IaqKeyItem)
    ['{A82D9D30-3CDF-D511-9A51-00D0B749C8FE}']
    function Get_Name: WideString; safecall;
    function Get_Copyright: WideString; safecall;
    function Get_TargetIntegrationCount: Integer; safecall;
    function Get_TargetIntegrationKey(Index: Integer): TGUID; safecall;
    function Get_TargetProductCount: Integer; safecall;
    function Get_TargetProductKey(Index: Integer): TGUID; safecall;
    function Get_PluginCount: Integer; safecall;
    function Get_PluginKey(Index: Integer): TGUID; safecall;
    function Get_PluginName(Index: Integer): WideString; safecall;
    function Get_PluginDescription(Index: Integer): WideString; safecall;
    function Get_PluginVersion(Index: Integer): AQ_PLUGIN_VERSION; safecall;
    function Get_PluginDefaultSelected(Index: Integer): WordBool; safecall;
    function Get_PluginDependencyCount(Index: Integer): Integer; safecall;
    function Get_PluginDependencies(Index: Integer; DependsIndex: Integer): TGUID; safecall;
    function Get_PluginConflictCount(Index: Integer): Integer; safecall;
    function Get_PluginConflicts(Index: Integer; ConflictIndex: Integer): TGUID; safecall;
    function CreatePlugin(Index: Integer): IaqBasePlugin; safecall;
    property Name: WideString read Get_Name;
    property Copyright: WideString read Get_Copyright;
    property TargetIntegrationCount: Integer read Get_TargetIntegrationCount;
    property TargetIntegrationKey[Index: Integer]: TGUID read Get_TargetIntegrationKey;
    property TargetProductCount: Integer read Get_TargetProductCount;
    property TargetProductKey[Index: Integer]: TGUID read Get_TargetProductKey;
    property PluginCount: Integer read Get_PluginCount;
    property PluginKey[Index: Integer]: TGUID read Get_PluginKey;
    property PluginName[Index: Integer]: WideString read Get_PluginName;
    property PluginDescription[Index: Integer]: WideString read Get_PluginDescription;
    property PluginVersion[Index: Integer]: AQ_PLUGIN_VERSION read Get_PluginVersion;
    property PluginDefaultSelected[Index: Integer]: WordBool read Get_PluginDefaultSelected;
    property PluginDependencyCount[Index: Integer]: Integer read Get_PluginDependencyCount;
    property PluginDependencies[Index: Integer; DependsIndex: Integer]: TGUID read Get_PluginDependencies;
    property PluginConflictCount[Index: Integer]: Integer read Get_PluginConflictCount;
    property PluginConflicts[Index: Integer; ConflictIndex: Integer]: TGUID read Get_PluginConflicts;
  end;

// *********************************************************************//
// Interface: IaqWindowProvider
// Flags:     (0)
// GUID:      {AAE6E3E8-3BDF-D511-9A51-00D0B749C8FE}
// *********************************************************************//
  IaqWindowProvider = interface(IaqKeyItem)
    ['{AAE6E3E8-3BDF-D511-9A51-00D0B749C8FE}']
    function Get_CreatePaneAtStartup: WordBool; safecall;
    function Get_AcceptsHandleType(SiteHandleType: AQ_HANDLE_TYPE): WordBool; safecall;
    procedure Set_Visible(pValue: WordBool); safecall;
    function Get_Visible: WordBool; safecall;
    procedure SetSite(SiteHandleType: AQ_HANDLE_TYPE; SiteHandle: UINT_PTR); safecall;
    procedure SetBounds(Left: Integer; Top: Integer; Width: Integer; Height: Integer); safecall;
    property CreatePaneAtStartup: WordBool read Get_CreatePaneAtStartup;
    property AcceptsHandleType[SiteHandleType: AQ_HANDLE_TYPE]: WordBool read Get_AcceptsHandleType;
    property Visible: WordBool read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// Interface: IaqWhatsThisSupportProvider
// Flags:     (0)
// GUID:      {97538BAE-6D45-443B-AA40-7BBB5C9B62BB}
// *********************************************************************//
  IaqWhatsThisSupportProvider = interface(IaqKeyItem)
    ['{97538BAE-6D45-443B-AA40-7BBB5C9B62BB}']
    function IsManagedHandle(Handle: UINT_PTR): WordBool; stdcall;
    procedure ProcessClick(Handle: UINT_PTR; ScreenCoordX: Integer; ScreenCoordY: Integer; 
                           out HelpId: Integer; out HelpFileName: WideString; 
                           out ShowAsPopup: WordBool); stdcall;
  end;

// *********************************************************************//
// Interface: IaqUIShell
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {04FA5B4B-ED49-4678-A7CF-975F64D76058}
// *********************************************************************//
  IaqUIShell = interface(IaqSubsystemManager)
    ['{04FA5B4B-ED49-4678-A7CF-975F64D76058}']
    function Get_ApplicationHandle: OLE_HANDLE; safecall;
    function Get_MainWindowHandle: OLE_HANDLE; safecall;
    procedure Minimize; safecall;
    procedure Maximize; safecall;
    procedure Restore; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(RetVal: WordBool); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const RetVal: WideString); safecall;
    function Get_LookAndFeel: AQ_SHELL_LOOK_AND_FEEL; safecall;
    procedure Set_LookAndFeel(Value: AQ_SHELL_LOOK_AND_FEEL); safecall;
    function Get_DockingStyle: AQ_SHELL_DOCKING_STYLE; safecall;
    procedure Set_DockingStyle(Value: AQ_SHELL_DOCKING_STYLE); safecall;
    procedure ShowWindow(WindowKey: TGUID; ShowFlag: AQ_WINDOW_SHOW_FLAG); safecall;
    procedure Set_WindowCaption(WindowKey: TGUID; const Param2: WideString); safecall;
    procedure EnableModeless(Enable: WordBool); safecall;
    procedure SetCursor(Value: AQ_MOUSE_CURSOR); safecall;
    procedure ResetCursor; safecall;
    property ApplicationHandle: OLE_HANDLE read Get_ApplicationHandle;
    property MainWindowHandle: OLE_HANDLE read Get_MainWindowHandle;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Caption: WideString read Get_Caption write Set_Caption;
    property LookAndFeel: AQ_SHELL_LOOK_AND_FEEL read Get_LookAndFeel write Set_LookAndFeel;
    property DockingStyle: AQ_SHELL_DOCKING_STYLE read Get_DockingStyle write Set_DockingStyle;
    property WindowCaption[WindowKey: TGUID]: WideString write Set_WindowCaption;
  end;

// *********************************************************************//
// DispIntf:  IaqUIShellDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {04FA5B4B-ED49-4678-A7CF-975F64D76058}
// *********************************************************************//
  IaqUIShellDisp = dispinterface
    ['{04FA5B4B-ED49-4678-A7CF-975F64D76058}']
    property ApplicationHandle: OLE_HANDLE readonly dispid 86016;
    property MainWindowHandle: OLE_HANDLE readonly dispid 86017;
    procedure Minimize; dispid 86018;
    procedure Maximize; dispid 86019;
    procedure Restore; dispid 86020;
    property Visible: WordBool dispid 86021;
    property Caption: WideString dispid 86022;
    property LookAndFeel: AQ_SHELL_LOOK_AND_FEEL dispid 86023;
    property DockingStyle: AQ_SHELL_DOCKING_STYLE dispid 86024;
    procedure ShowWindow(WindowKey: {??TGUID}OleVariant; ShowFlag: AQ_WINDOW_SHOW_FLAG); dispid 86025;
    property WindowCaption[WindowKey: {??TGUID}OleVariant]: WideString writeonly dispid 86029;
    procedure EnableModeless(Enable: WordBool); dispid 86026;
    procedure SetCursor(Value: AQ_MOUSE_CURSOR); dispid 86027;
    procedure ResetCursor; dispid 86028;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqInfoDialog
// Flags:     (0)
// GUID:      {9B15D4AF-3073-4BE1-890E-D4E6AD71D0A4}
// *********************************************************************//
  IaqInfoDialog = interface(IUnknown)
    ['{9B15D4AF-3073-4BE1-890E-D4E6AD71D0A4}']
    function ShowForm: WordBool; safecall;
    procedure Set_HelpId(Param1: Integer); safecall;
    procedure Set_HelpFileName(const Param1: WideString); safecall;
    procedure AddColumn(const Name: WideString; Width: Integer); safecall;
    procedure AddRowValues(AValues: OleVariant); safecall;
    procedure Set_DontShowAgain(bValue: WordBool); safecall;
    function Get_DontShowAgain: WordBool; safecall;
    procedure Set_DontShowAgainVisible(Param1: WordBool); safecall;
    procedure Set_Text(const Param1: WideString); safecall;
    procedure Set_Caption(const Param1: WideString); safecall;
    property HelpId: Integer write Set_HelpId;
    property HelpFileName: WideString write Set_HelpFileName;
    property DontShowAgain: WordBool read Get_DontShowAgain write Set_DontShowAgain;
    property DontShowAgainVisible: WordBool write Set_DontShowAgainVisible;
    property Text: WideString write Set_Text;
    property Caption: WideString write Set_Caption;
  end;

// *********************************************************************//
// Interface: IaqCancelNotifier
// Flags:     (320) Dual OleAutomation
// GUID:      {5CA0618F-3CBE-4BD9-BEED-BD837719000B}
// *********************************************************************//
  IaqCancelNotifier = interface(IUnknown)
    ['{5CA0618F-3CBE-4BD9-BEED-BD837719000B}']
    procedure OnCancelPressed; safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqCancelNotifierDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5CA0618F-3CBE-4BD9-BEED-BD837719000B}
// *********************************************************************//
  IaqCancelNotifierDisp = dispinterface
    ['{5CA0618F-3CBE-4BD9-BEED-BD837719000B}']
    procedure OnCancelPressed; dispid 151552;
  end;

// *********************************************************************//
// Interface: IaqSelectionProvider
// Flags:     (320) Dual OleAutomation
// GUID:      {4C254C79-745A-4D26-A014-0E12993A62B8}
// *********************************************************************//
  IaqSelectionProvider = interface(IUnknown)
    ['{4C254C79-745A-4D26-A014-0E12993A62B8}']
    function Get_SelectedObjects: OleVariant; safecall;
    function Get_FocusedObject: OleVariant; safecall;
    property SelectedObjects: OleVariant read Get_SelectedObjects;
    property FocusedObject: OleVariant read Get_FocusedObject;
  end;

// *********************************************************************//
// DispIntf:  IaqSelectionProviderDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {4C254C79-745A-4D26-A014-0E12993A62B8}
// *********************************************************************//
  IaqSelectionProviderDisp = dispinterface
    ['{4C254C79-745A-4D26-A014-0E12993A62B8}']
    property SelectedObjects: OleVariant readonly dispid 1610678272;
    property FocusedObject: OleVariant readonly dispid 1610678273;
  end;

// *********************************************************************//
// Interface: IaqMessenger
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7851795C-2C1B-4F85-8B40-5BB7C058F3B8}
// *********************************************************************//
  IaqMessenger = interface(IaqSubsystemManager)
    ['{7851795C-2C1B-4F85-8B40-5BB7C058F3B8}']
    function YesNoConfirm(const Message: WideString; HelpId: Integer; 
                          const HelpFileName: WideString; DefaultResult: WordBool): WordBool; safecall;
    function YesNoSevere(const Message: WideString; HelpId: Integer; 
                         const HelpFileName: WideString; DefaultResult: WordBool): WordBool; safecall;
    function YesNoCancel(const Message: WideString; HelpId: Integer; 
                         const HelpFileName: WideString; DefaultResult: Integer): Integer; safecall;
    function YesNoMessageAsk(const Message: WideString; var AskAgain: WordBool; HelpId: Integer; 
                             const HelpFileName: WideString; DefaultResult: WordBool): WordBool; safecall;
    function YesNoMessageCheck(const Message: WideString; var Checked: WordBool; 
                               const CheckCaption: WideString; HelpId: Integer; 
                               const HelpFileName: WideString; DefaultResult: WordBool): WordBool; safecall;
    procedure ShowMildError(const Message: WideString; HelpId: Integer; 
                            const HelpFileName: WideString = ''); safecall;
    procedure ShowSevereError(const Message: WideString; HelpId: Integer; 
                              const HelpFileName: WideString = ''); safecall;
    procedure ShowInformation(const Message: WideString; HelpId: Integer; 
                              const HelpFileName: WideString = ''); safecall;
    procedure ShowMessageDontAsk(const Message: WideString; var AskAgain: WordBool; 
                                 HelpId: Integer; const HelpFileName: WideString = ''); safecall;
    function CreateInfoDialog(DialogType: AQ_INFO_DIALOG_TYPE): IaqInfoDialog; safecall;
    function ShowProgressWaitMessage(const Msg: WideString; MinValue: Integer; MaxValue: Integer; 
                                     InitialValue: Integer; 
                                     const lpCancelNotifier: IaqCancelNotifier): Integer; safecall;
    function ShowWaitMessage(const Msg: WideString; const lpCancelNotifier: IaqCancelNotifier): Integer; safecall;
    procedure HideWaitMessage(MsgCookie: Integer); safecall;
    procedure Set_WaitProgressValue(MsgCookie: Integer; Param2: Integer); safecall;
    procedure Set_WaitMessage(MsgCookie: Integer; const Param2: WideString); safecall;
    procedure WaitForCloseMessage(MsgCookie: Integer); safecall;
    function ShowCustomDialog(const Message: WideString; DialogType: AQ_MESSENGER_DIALOG_TYPE; 
                              DialogButtons: LongWord; DefaultButton: AQ_MESSENGER_BUTTONS; 
                              HelpId: Integer; const HelpFileName: WideString = ''): Integer; safecall;
    function ShowMoreDialog(DialogType: AQ_MESSENGER_DIALOG_TYPE; const Message: WideString; 
                            const MoreMessage: WideString; DialogButtons: LongWord; 
                            DefaultButton: AQ_MESSENGER_BUTTONS; HelpId: Integer; 
                            const HelpFileName: WideString = ''): Integer; safecall;
    property WaitProgressValue[MsgCookie: Integer]: Integer write Set_WaitProgressValue;
    property WaitMessage[MsgCookie: Integer]: WideString write Set_WaitMessage;
  end;

// *********************************************************************//
// DispIntf:  IaqMessengerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7851795C-2C1B-4F85-8B40-5BB7C058F3B8}
// *********************************************************************//
  IaqMessengerDisp = dispinterface
    ['{7851795C-2C1B-4F85-8B40-5BB7C058F3B8}']
    function YesNoConfirm(const Message: WideString; HelpId: Integer; 
                          const HelpFileName: WideString; DefaultResult: WordBool): WordBool; dispid 122880;
    function YesNoSevere(const Message: WideString; HelpId: Integer; 
                         const HelpFileName: WideString; DefaultResult: WordBool): WordBool; dispid 122881;
    function YesNoCancel(const Message: WideString; HelpId: Integer; 
                         const HelpFileName: WideString; DefaultResult: Integer): Integer; dispid 122882;
    function YesNoMessageAsk(const Message: WideString; var AskAgain: WordBool; HelpId: Integer; 
                             const HelpFileName: WideString; DefaultResult: WordBool): WordBool; dispid 122883;
    function YesNoMessageCheck(const Message: WideString; var Checked: WordBool; 
                               const CheckCaption: WideString; HelpId: Integer; 
                               const HelpFileName: WideString; DefaultResult: WordBool): WordBool; dispid 122884;
    procedure ShowMildError(const Message: WideString; HelpId: Integer; 
                            const HelpFileName: WideString); dispid 122885;
    procedure ShowSevereError(const Message: WideString; HelpId: Integer; 
                              const HelpFileName: WideString); dispid 122886;
    procedure ShowInformation(const Message: WideString; HelpId: Integer; 
                              const HelpFileName: WideString); dispid 122887;
    procedure ShowMessageDontAsk(const Message: WideString; var AskAgain: WordBool; 
                                 HelpId: Integer; const HelpFileName: WideString); dispid 122888;
    function CreateInfoDialog(DialogType: AQ_INFO_DIALOG_TYPE): IaqInfoDialog; dispid 122889;
    function ShowProgressWaitMessage(const Msg: WideString; MinValue: Integer; MaxValue: Integer; 
                                     InitialValue: Integer; 
                                     const lpCancelNotifier: IaqCancelNotifier): Integer; dispid 122890;
    function ShowWaitMessage(const Msg: WideString; const lpCancelNotifier: IaqCancelNotifier): Integer; dispid 122891;
    procedure HideWaitMessage(MsgCookie: Integer); dispid 122892;
    property WaitProgressValue[MsgCookie: Integer]: Integer writeonly dispid 122893;
    property WaitMessage[MsgCookie: Integer]: WideString writeonly dispid 122894;
    procedure WaitForCloseMessage(MsgCookie: Integer); dispid 122895;
    function ShowCustomDialog(const Message: WideString; DialogType: AQ_MESSENGER_DIALOG_TYPE; 
                              DialogButtons: LongWord; DefaultButton: AQ_MESSENGER_BUTTONS; 
                              HelpId: Integer; const HelpFileName: WideString): Integer; dispid 122896;
    function ShowMoreDialog(DialogType: AQ_MESSENGER_DIALOG_TYPE; const Message: WideString; 
                            const MoreMessage: WideString; DialogButtons: LongWord; 
                            DefaultButton: AQ_MESSENGER_BUTTONS; HelpId: Integer; 
                            const HelpFileName: WideString): Integer; dispid 122897;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqSilentLog
// Flags:     (0)
// GUID:      {81F2C7F1-B686-4201-A1FC-2A0C5F32D5F8}
// *********************************************************************//
  IaqSilentLog = interface(IUnknown)
    ['{81F2C7F1-B686-4201-A1FC-2A0C5F32D5F8}']
    procedure AddMessage(const Message: WideString); stdcall;
  end;

// *********************************************************************//
// Interface: IaqSettingsManager_DVS
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B2B8BD2F-363E-48DD-9FB1-FD64DE2428B7}
// *********************************************************************//
  IaqSettingsManager_DVS = interface(IaqSubsystemManager)
    ['{B2B8BD2F-363E-48DD-9FB1-FD64DE2428B7}']
    function GetSetting(const AKey: TGUID): IaqBaseSetting_DVS; safecall;
    function GetSettingByStringKey(const AKey: WideString): IaqBaseSetting_DVS; safecall;
    function ConfigureSettings(const ASelectedGroupKey: TGUID): Integer; safecall;
    function ConfigureSettingsEx(const ALayoutKey: TGUID; const ASettings: IaqUnknownIterator; 
                                 const AActions: IaqUnknownIterator; AImageHandle: UINT_PTR; 
                                 const ACaption: WideString; const ADescription: WideString; 
                                 AHelpContext: Integer): Integer; safecall;
    function GetProviderSettings(const AProviderKey: TGUID): IaqUnknownIterator; safecall;
    function GetProviderActions(const AProviderKey: TGUID): IaqUnknownIterator; safecall;   
  end;

// *********************************************************************//
// DispIntf:  IaqSettingsManager_DVSDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B2B8BD2F-363E-48DD-9FB1-FD64DE2428B7}
// *********************************************************************//
  IaqSettingsManager_DVSDisp = dispinterface
    ['{B2B8BD2F-363E-48DD-9FB1-FD64DE2428B7}']
    function GetSetting(var AKey: {??TGUID}OleVariant): IaqBaseSetting_DVS; dispid 1610809344;
    function GetSettingByStringKey(const AKey: WideString): IaqBaseSetting_DVS; dispid 1610809345;
    function ConfigureSettings(var ASelectedGroupKey: {??TGUID}OleVariant): Integer; dispid 1610809346;
    function ConfigureSettingsEx(var ALayoutKey: {??TGUID}OleVariant; 
                                 const ASettings: IaqUnknownIterator; 
                                 const AActions: IaqUnknownIterator; AImageHandle: UINT_PTR; 
                                 const ACaption: WideString; const ADescription: WideString; 
                                 AHelpContext: Integer): Integer; dispid 1610809347;
    function GetProviderSettings(var AProviderKey: {??TGUID}OleVariant): IaqUnknownIterator; dispid 1610809348;
    function GetProviderActions(var AProviderKey: {??TGUID}OleVariant): IaqUnknownIterator; dispid 1610809349;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqBaseSetting_DVS
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4629D053-6622-41F2-8F93-CC2FE9D3DDDC}
// *********************************************************************//
  IaqBaseSetting_DVS = interface(IDispatch)
    ['{4629D053-6622-41F2-8F93-CC2FE9D3DDDC}']
    procedure BeginUpdate; safecall;
    function EndUpdate: WordBool; safecall;
    function GetKey: TGUID; safecall;
    function GetType: Integer; safecall;
    function IsKey(const AValue: TGUID): WordBool; safecall;
    function GetChanged: WordBool; safecall;
    function GetState: AQ_SETTING_STATE; safecall;
    function GetCaption: WideString; safecall;
    function GetDescription: WideString; safecall;
    function GetCategory: WideString; safecall;
    function GetEnabled: WordBool; safecall;
    procedure SetEnabled(AValue: WordBool); safecall;
    function GetVisible: WordBool; safecall;
    procedure SetVisible(AValue: WordBool); safecall;
    function GetReadOnly: WordBool; safecall;
    function GetValue: OleVariant; safecall;
    function SetValue(AValue: OleVariant): OleVariant; safecall;
    procedure LoadFromOptions(const AOptions: IaqOptionsNode); safecall;
    procedure SaveToOptions(const AOptions: IaqOptionsNode); safecall;
    procedure Load; safecall;
    procedure Save; safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqBaseSetting_DVSDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4629D053-6622-41F2-8F93-CC2FE9D3DDDC}
// *********************************************************************//
  IaqBaseSetting_DVSDisp = dispinterface
    ['{4629D053-6622-41F2-8F93-CC2FE9D3DDDC}']
    procedure BeginUpdate; dispid 1610743808;
    function EndUpdate: WordBool; dispid 1610743809;
    function GetKey: {??TGUID}OleVariant; dispid 1610743810;
    function GetType: Integer; dispid 1610743811;
    function IsKey(var AValue: {??TGUID}OleVariant): WordBool; dispid 1610743812;
    function GetChanged: WordBool; dispid 1610743813;
    function GetState: AQ_SETTING_STATE; dispid 1610743814;
    function GetCaption: WideString; dispid 1610743815;
    function GetDescription: WideString; dispid 1610743816;
    function GetCategory: WideString; dispid 1610743817;
    function GetEnabled: WordBool; dispid 1610743818;
    procedure SetEnabled(AValue: WordBool); dispid 1610743819;
    function GetVisible: WordBool; dispid 1610743820;
    procedure SetVisible(AValue: WordBool); dispid 1610743821;
    function GetReadOnly: WordBool; dispid 1610743822;
    function GetValue: OleVariant; dispid 1610743823;
    function SetValue(AValue: OleVariant): OleVariant; dispid 1610743824;
    procedure LoadFromOptions(const AOptions: IaqOptionsNode); dispid 1610743825;
    procedure SaveToOptions(const AOptions: IaqOptionsNode); dispid 1610743826;
    procedure Load; dispid 1610743827;
    procedure Save; dispid 1610743828;
  end;

// *********************************************************************//
// Interface: IaqSettingsManagerIntegration_DVS
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B6C6824F-159A-4329-A8C7-D5466BEB3315}
// *********************************************************************//
  IaqSettingsManagerIntegration_DVS = interface(IaqSettingsManager_DVS)
    ['{B6C6824F-159A-4329-A8C7-D5466BEB3315}']
    procedure BeginConfigureSettings; safecall;
    procedure EndConfigureSettings(ApplyChanges: WordBool); safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqSettingsManagerIntegration_DVSDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B6C6824F-159A-4329-A8C7-D5466BEB3315}
// *********************************************************************//
  IaqSettingsManagerIntegration_DVSDisp = dispinterface
    ['{B6C6824F-159A-4329-A8C7-D5466BEB3315}']
    procedure BeginConfigureSettings; dispid 1610874880;
    procedure EndConfigureSettings(ApplyChanges: WordBool); dispid 1610874881;
    function GetSetting(var AKey: {??TGUID}OleVariant): IaqBaseSetting_DVS; dispid 1610809344;
    function GetSettingByStringKey(const AKey: WideString): IaqBaseSetting_DVS; dispid 1610809345;
    function ConfigureSettings(var ASelectedGroupKey: {??TGUID}OleVariant): Integer; dispid 1610809346;
    function ConfigureSettingsEx(var ALayoutKey: {??TGUID}OleVariant; 
                                 const ASettings: IaqUnknownIterator; 
                                 const AActions: IaqUnknownIterator; AImageHandle: UINT_PTR; 
                                 const ACaption: WideString; const ADescription: WideString; 
                                 AHelpContext: Integer): Integer; dispid 1610809347;
    function GetProviderSettings(var AProviderKey: {??TGUID}OleVariant): IaqUnknownIterator; dispid 1610809348;
    function GetProviderActions(var AProviderKey: {??TGUID}OleVariant): IaqUnknownIterator; dispid 1610809349;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqTableSettingSchema_DVS
// Flags:     (0)
// GUID:      {A33D550E-B941-41AB-9732-B34D1DE3D0C0}
// *********************************************************************//
  IaqTableSettingSchema_DVS = interface(IUnknown)
    ['{A33D550E-B941-41AB-9732-B34D1DE3D0C0}']
    function AddColumn(AType: AQ_SETTING_TYPE; const ACaption: WideString; AVisible: WordBool; 
                       AReadOnly: WordBool): Integer; stdcall;
    function GetColCount: Integer; stdcall;
    function GetColumnType(AIndex: Integer): AQ_SETTING_TYPE; stdcall;
    procedure GetColumnCaption(AColIdx: Integer; out AValue: WideString); stdcall;
    procedure GetColumnDescription(AColIdx: Integer; out AValue: WideString); stdcall;
    procedure SetColumnDescription(AColIdx: Integer; const AValue: WideString); stdcall;
    function GetColumnVisible(AColIdx: Integer): WordBool; stdcall;
    function GetColumnEnabled(AColIdx: Integer): WordBool; stdcall;
    procedure SetColumnEnabled(AColIdx: Integer; AValue: WordBool); stdcall;
    function GetColumnReadOnly(AColIdx: Integer): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqTableSetting_DVS
// Flags:     (4096) Dispatchable
// GUID:      {C8705533-F5CD-485B-9B61-8F945A74196A}
// *********************************************************************//
  IaqTableSetting_DVS = interface(IaqBaseSetting_DVS)
    ['{C8705533-F5CD-485B-9B61-8F945A74196A}']
    function AddRow: Integer; safecall;
    procedure Clear; safecall;
    procedure DeleteRow(ARowIdx: Integer); safecall;
    procedure SetRowCount(AValue: Integer); safecall;
    function GetRowCount: Integer; safecall;
    function GetCellValue(AColIdx: Integer; ARowIdx: Integer): OleVariant; safecall;
    procedure SetCellValue(AColIdx: Integer; ARowIdx: Integer; AValue: OleVariant); safecall;
    function GetSelectedRow: Integer; safecall;
    procedure SetSelectedRow(AValue: Integer); safecall;
    function GetSelectedColumn: Integer; safecall;
    procedure SetSelectedColumn(AValue: Integer); safecall;
  end;

// *********************************************************************//
// Interface: IaqSettingsProvider_DVS
// Flags:     (0)
// GUID:      {22345578-A212-4C7F-A05A-646ED72D2CB4}
// *********************************************************************//
  IaqSettingsProvider_DVS = interface(IaqKeyItem)
    ['{22345578-A212-4C7F-A05A-646ED72D2CB4}']
    procedure InitializeSettings(const ASettings: IaqSettings_DVS); stdcall;
    procedure FinalizeSettings; stdcall;
  end;

// *********************************************************************//
// Interface: IaqSettings_DVS
// Flags:     (0)
// GUID:      {8EFFF4D5-3F81-4F30-8EA0-34877B57900A}
// *********************************************************************//
  IaqSettings_DVS = interface(IaqKeyItem)
    ['{8EFFF4D5-3F81-4F30-8EA0-34877B57900A}']
    procedure GetSettingByKey(const ASettingKey: TGUID; out ASetting: IaqBaseSetting_DVS); stdcall;
    procedure GetSettingIterator(out AIterator: IaqSettingIterator_DVS); stdcall;
    procedure CreateSetting(ASettingType: Integer; const ASettingKey: TGUID;
                            const ASettingsGroupKey: TGUID; const ACaption: WideString; 
                            const ADescription: WideString; const ACategory: WideString; 
                            AReadOnly: WordBool; AStored: WordBool; out ASetting: IaqBaseSetting_DVS); stdcall;
    procedure RemoveSetting(const ASettingKey: TGUID); stdcall;
    procedure Clear; stdcall;
  end;

// *********************************************************************//
// Interface: IaqSettingIterator_DVS
// Flags:     (0)
// GUID:      {C37728A4-CACC-4043-BD7A-E03F67D5872F}
// *********************************************************************//
  IaqSettingIterator_DVS = interface(IaqIterator)
    ['{C37728A4-CACC-4043-BD7A-E03F67D5872F}']
    procedure Next(out ASetting: IaqBaseSetting_DVS); stdcall;
  end;

// *********************************************************************//
// Interface: IaqSettingsActionsProvider
// Flags:     (0)
// GUID:      {113D4CA2-6208-4E91-97AD-D315CE62D1C2}
// *********************************************************************//
  IaqSettingsActionsProvider = interface(IaqKeyItem)
    ['{113D4CA2-6208-4E91-97AD-D315CE62D1C2}']
    function GetActionCount: Integer; stdcall;
    procedure GetActionByIndex(AIndex: Integer; out AAction: IaqActionItem); stdcall;
  end;

// *********************************************************************//
// Interface: IaqSettingsUpdateListener_DVS
// Flags:     (0)
// GUID:      {767C39FB-834E-4096-96AA-4E872DD8E646}
// *********************************************************************//
  IaqSettingsUpdateListener_DVS = interface(IaqKeyItem)
    ['{767C39FB-834E-4096-96AA-4E872DD8E646}']
    procedure BeginUpdateSettings; stdcall;
    procedure UpdateSetting(const ASetting: IaqBaseSetting_DVS; AParam: OleVariant); stdcall;
    procedure EndUpdateSettings; stdcall;
  end;

// *********************************************************************//
// Interface: IaqSettingsGroup
// Flags:     (0)
// GUID:      {0AF3FEC8-776A-46CD-ADC1-AED68DA68C37}
// *********************************************************************//
  IaqSettingsGroup = interface(IaqKeyItem)
    ['{0AF3FEC8-776A-46CD-ADC1-AED68DA68C37}']
    function GetPath: WideString; safecall;
    function GetCaption: WideString; safecall;
    function GetHelpContext: Integer; safecall;
    function GetImageHandleReference: UINT_PTR; safecall;
    function HasChildren: WordBool; safecall;
    function GetParent: IaqSettingsGroup; safecall;
    function GetName: WideString; safecall;
    function GetLayoutFileName: WideString; safecall;
  end;

// *********************************************************************//
// Interface: IaqSettingValidator
// Flags:     (0)
// GUID:      {3CDB097B-7B86-4FE2-9417-F826D43F8790}
// *********************************************************************//
  IaqSettingValidator = interface(IUnknown)
    ['{3CDB097B-7B86-4FE2-9417-F826D43F8790}']
    function GetMinValue: OleVariant; safecall;
    procedure SetMinValue(Value: OleVariant); safecall;
    function GetMaxValue: OleVariant; safecall;
    procedure SetMaxValue(Value: OleVariant); safecall;
  end;

// *********************************************************************//
// Interface: IaqUnknownCollection
// Flags:     (0)
// GUID:      {F86BE24D-8E20-4434-9397-176CAA40950C}
// *********************************************************************//
  IaqUnknownCollection = interface(IUnknown)
    ['{F86BE24D-8E20-4434-9397-176CAA40950C}']
    procedure AddIntf(const AValue: IUnknown); stdcall;
    procedure GetIterator(out AValue: IaqUnknownIterator); stdcall;
    function Count: Integer; stdcall;
    procedure Clear; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDumpStringsManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {764618CB-3653-4C25-A4BC-FDA070B13AB6}
// *********************************************************************//
  IaqDumpStringsManager = interface(IaqSubsystemManager)
    ['{764618CB-3653-4C25-A4BC-FDA070B13AB6}']
    procedure OutputDumpString(const Value: WideString); safecall;
    procedure ClearStrings; safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqDumpStringsManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {764618CB-3653-4C25-A4BC-FDA070B13AB6}
// *********************************************************************//
  IaqDumpStringsManagerDisp = dispinterface
    ['{764618CB-3653-4C25-A4BC-FDA070B13AB6}']
    procedure OutputDumpString(const Value: WideString); dispid 1610809344;
    procedure ClearStrings; dispid 1610809345;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqDbgSymbolManager
// Flags:     (4096) Dispatchable
// GUID:      {8DCBD7AB-85C7-4B95-AAEB-52DF2C48AEBC}
// *********************************************************************//
  IaqDbgSymbolManager = interface(IaqSubsystemManager)
    ['{8DCBD7AB-85C7-4B95-AAEB-52DF2C48AEBC}']
    function Get_TypeCount: Integer; safecall;
    function Get_Types(Index: Integer): IaqDbgSymbolType; safecall;
    function ReadSymbols(const FileName: WideString; ProgressDialogCookie: Integer; 
                         ReadTypes: WordBool): IaqDbgSymbolStoreIterator; safecall;
    function GetSymbolByMoniker(const Moniker: WideString): IaqDbgSymbol; safecall;
    procedure RegisterNoDebugInfoReader(const Reader: IaqDbgSymbolReader); stdcall;
    procedure UnregisterNoDebugInfoReader; stdcall;
    property TypeCount: Integer read Get_TypeCount;
    property Types[Index: Integer]: IaqDbgSymbolType read Get_Types;
  end;

// *********************************************************************//
// Interface: IaqDbgSymbolType
// Flags:     (256) OleAutomation
// GUID:      {E84C200C-A532-42E0-BC68-AC36864AB597}
// *********************************************************************//
  IaqDbgSymbolType = interface(IUnknown)
    ['{E84C200C-A532-42E0-BC68-AC36864AB597}']
    function Get_Id: TGUID; safecall;
    function Get_Name: WideString; safecall;
    function Get_ViewByFullName(const OwnerType: IaqDbgSymbolType): WordBool; safecall;
    property Id: TGUID read Get_Id;
    property Name: WideString read Get_Name;
    property ViewByFullName[const OwnerType: IaqDbgSymbolType]: WordBool read Get_ViewByFullName;
  end;

// *********************************************************************//
// Interface: IaqDbgSymbolStoreIterator
// Flags:     (0)
// GUID:      {C43628A1-BAED-4645-A594-E186C338CF83}
// *********************************************************************//
  IaqDbgSymbolStoreIterator = interface(IaqIterator)
    ['{C43628A1-BAED-4645-A594-E186C338CF83}']
    function Next: IaqDbgSymbolStore; safecall;
  end;

// *********************************************************************//
// Interface: IaqDbgSymbolStore
// Flags:     (256) OleAutomation
// GUID:      {7E932C3E-16B2-4A82-A2E7-B44AD734DE81}
// *********************************************************************//
  IaqDbgSymbolStore = interface(IUnknown)
    ['{7E932C3E-16B2-4A82-A2E7-B44AD734DE81}']
    function Get_ModuleName: WideString; safecall;
    function Get_Kind: AQ_SYMBOLSTORE_KIND; safecall;
    function Get_DefaultType: IaqDbgSymbolType; safecall;
    function Get_SymbolCount: Integer; safecall;
    function Get_Symbols(Index: Integer): IaqDbgSymbol; safecall;
    function FindSymbol(const Moniker: WideString): IaqDbgSymbol; safecall;
    property ModuleName: WideString read Get_ModuleName;
    property Kind: AQ_SYMBOLSTORE_KIND read Get_Kind;
    property DefaultType: IaqDbgSymbolType read Get_DefaultType;
    property SymbolCount: Integer read Get_SymbolCount;
    property Symbols[Index: Integer]: IaqDbgSymbol read Get_Symbols;
  end;

// *********************************************************************//
// Interface: IaqDbgSymbol
// Flags:     (256) OleAutomation
// GUID:      {6B0D6874-A262-4291-A9D3-FB7DFE7487E0}
// *********************************************************************//
  IaqDbgSymbol = interface(IUnknown)
    ['{6B0D6874-A262-4291-A9D3-FB7DFE7487E0}']
    function Get_Store: IaqDbgSymbolStore; safecall;
    function Get_Kind: AQ_SYMBOLSTORE_KIND; safecall;
    function Get_SymType: IaqDbgSymbolType; safecall;
    function Get_Id: LongWord; safecall;
    function Get_Name: WideString; safecall;
    function Get_FullName: WideString; safecall;
    function Get_HInstance: UINT_PTR; safecall;
    function Get_Icon: LongWord; safecall;
    function Get_ChildSymbolCount: Integer; safecall;
    function Get_ChildSymbols(Index: Integer): IaqDbgSymbol; safecall;
    function CreateMoniker: WideString; safecall;
    property Store: IaqDbgSymbolStore read Get_Store;
    property Kind: AQ_SYMBOLSTORE_KIND read Get_Kind;
    property SymType: IaqDbgSymbolType read Get_SymType;
    property Id: LongWord read Get_Id;
    property Name: WideString read Get_Name;
    property FullName: WideString read Get_FullName;
    property HInstance: UINT_PTR read Get_HInstance;
    property Icon: LongWord read Get_Icon;
    property ChildSymbolCount: Integer read Get_ChildSymbolCount;
    property ChildSymbols[Index: Integer]: IaqDbgSymbol read Get_ChildSymbols;
  end;

// *********************************************************************//
// Interface: IaqDbgSymbolReader
// Flags:     (0)
// GUID:      {E2AB5F41-20BD-4D32-84E1-7AE0E59C8B9D}
// *********************************************************************//
  IaqDbgSymbolReader = interface(IUnknown)
    ['{E2AB5F41-20BD-4D32-84E1-7AE0E59C8B9D}']
    function Get_Name: WideString; safecall;
    function Get_TypeCount: Integer; safecall;
    function Get_Types(Index: Integer): IaqDbgSymbolType; safecall;
    procedure Set_SymbolSearchPath(const Param1: WideString); safecall;
    procedure Initialize(const Callback: IaqDbgSymbolReaderCallback); safecall;
    procedure Finalize; safecall;
    function ReadSymbols(const FileName: WideString; ReadTypesDepth: AQ_DBG_READ_TYPES_DEPTH): IaqDbgSymbolStore; safecall;
    function CanReadSymbols(const FileName: WideString): WordBool; safecall;
    property Name: WideString read Get_Name;
    property TypeCount: Integer read Get_TypeCount;
    property Types[Index: Integer]: IaqDbgSymbolType read Get_Types;
    property SymbolSearchPath: WideString write Set_SymbolSearchPath;
  end;

// *********************************************************************//
// Interface: IaqDbgSymbolReaderCallback
// Flags:     (0)
// GUID:      {3D5F9784-B82A-49CB-AC0F-96E25C678EF6}
// *********************************************************************//
  IaqDbgSymbolReaderCallback = interface(IUnknown)
    ['{3D5F9784-B82A-49CB-AC0F-96E25C678EF6}']
    procedure SetWaitProgressValue(Value: Integer); stdcall;
    procedure AddWarningMessage(const Message: WideString); stdcall;
    procedure AddErrorMessage(const Message: WideString); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDbgSymbolReaderEx
// Flags:     (0)
// GUID:      {FE31590A-A32F-4CCC-8801-ED1184B16C45}
// *********************************************************************//
  IaqDbgSymbolReaderEx = interface(IUnknown)
    ['{FE31590A-A32F-4CCC-8801-ED1184B16C45}']
    function Get_GroupKey: TGUID; safecall;
    function Get_Priority: Integer; safecall;
    property GroupKey: TGUID read Get_GroupKey;
    property Priority: Integer read Get_Priority;
  end;

// *********************************************************************//
// Interface: IaqDbgSymbolReference
// Flags:     (0)
// GUID:      {5A22F94E-7AD6-4D66-8203-AB59A1489D5A}
// *********************************************************************//
  IaqDbgSymbolReference = interface(IUnknown)
    ['{5A22F94E-7AD6-4D66-8203-AB59A1489D5A}']
    function Dereference: IaqDbgSymbol; safecall;
  end;

// *********************************************************************//
// Interface: IaqDbgSourceFile
// Flags:     (0)
// GUID:      {C1E81474-7606-4B31-ACF3-2B68C2728499}
// *********************************************************************//
  IaqDbgSourceFile = interface(IaqDbgSymbol)
    ['{C1E81474-7606-4B31-ACF3-2B68C2728499}']
    function Get_FileName: WideString; safecall;
    property FileName: WideString read Get_FileName;
  end;

// *********************************************************************//
// Interface: IaqDbgRoutine
// Flags:     (0)
// GUID:      {D69FA7BA-CA79-4FC2-8F3C-A68BC9041A35}
// *********************************************************************//
  IaqDbgRoutine = interface(IaqDbgSymbol)
    ['{D69FA7BA-CA79-4FC2-8F3C-A68BC9041A35}']
    function Get_Clazz: IaqDbgClass; safecall;
    function Get_SourceFile: IaqDbgSourceFile; safecall;
    function Get_NameWithClass: WideString; safecall;
    procedure GetLines(Count: Integer; out ActualCount: Integer; SrcLines: UINT_PTR); safecall;
    procedure GetOffsets(Count: Integer; out ActualCount: Integer; Offsets: UINT_PTR); safecall;
    property Clazz: IaqDbgClass read Get_Clazz;
    property SourceFile: IaqDbgSourceFile read Get_SourceFile;
    property NameWithClass: WideString read Get_NameWithClass;
  end;

// *********************************************************************//
// Interface: IaqDbgClass
// Flags:     (0)
// GUID:      {453E2BC4-3E3D-4B1D-A178-169AEF72D2EA}
// *********************************************************************//
  IaqDbgClass = interface(IaqDbgSymbol)
    ['{453E2BC4-3E3D-4B1D-A178-169AEF72D2EA}']
    function Get_RoutineCount: Integer; safecall;
    function Get_Routines(Index: Integer): IaqDbgRoutine; safecall;
    property RoutineCount: Integer read Get_RoutineCount;
    property Routines[Index: Integer]: IaqDbgRoutine read Get_Routines;
  end;

// *********************************************************************//
// Interface: IaqDbgSymbolReaderBeginEndListener
// Flags:     (0)
// GUID:      {B780D1BF-23DD-4009-8120-73CAF88A59D8}
// *********************************************************************//
  IaqDbgSymbolReaderBeginEndListener = interface(IUnknown)
    ['{B780D1BF-23DD-4009-8120-73CAF88A59D8}']
    procedure OnBeginReadDebugInfo; stdcall;
    procedure OnEndReadDebugInfo; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDbgSymbolStoreEx
// Flags:     (0)
// GUID:      {C5D9BB87-0C50-4ABA-8BA2-AEB763F3814F}
// *********************************************************************//
  IaqDbgSymbolStoreEx = interface(IUnknown)
    ['{C5D9BB87-0C50-4ABA-8BA2-AEB763F3814F}']
    function Get_ErrorCount: Integer; safecall;
    function Get_ErrorMessage(Index: Integer): WideString; safecall;
    property ErrorCount: Integer read Get_ErrorCount;
    property ErrorMessage[Index: Integer]: WideString read Get_ErrorMessage;
  end;

// *********************************************************************//
// Interface: IaqIdleProvider
// Flags:     (0)
// GUID:      {5599ED29-89B5-4A2A-954A-9A4E362208C4}
// *********************************************************************//
  IaqIdleProvider = interface(IUnknown)
    ['{5599ED29-89B5-4A2A-954A-9A4E362208C4}']
    procedure OnIdle; safecall;
  end;

// *********************************************************************//
// Interface: IaqContextManager
// Flags:     (4352) OleAutomation Dispatchable
// GUID:      {B4FE2003-80F1-469E-8C46-F286F8310606}
// *********************************************************************//
  IaqContextManager = interface(IaqSubsystemManager)
    ['{B4FE2003-80F1-469E-8C46-F286F8310606}']
    procedure RegisterContext(ContextType: TGUID; const ContextProvider: IaqContextProvider); safecall;
    procedure UnRegisterContext(ContextType: TGUID); safecall;
    function Get_CurrentContext(ContextType: TGUID): TGUID; safecall;
    property CurrentContext[ContextType: TGUID]: TGUID read Get_CurrentContext;
  end;

// *********************************************************************//
// Interface: IaqContextProvider
// Flags:     (0)
// GUID:      {0751AB3E-E195-44C5-96B0-051EE53C9E25}
// *********************************************************************//
  IaqContextProvider = interface(IUnknown)
    ['{0751AB3E-E195-44C5-96B0-051EE53C9E25}']
    function Get_CurrentContext(ContextType: TGUID): TGUID; safecall;
    property CurrentContext[ContextType: TGUID]: TGUID read Get_CurrentContext;
  end;

// *********************************************************************//
// Interface: IaqContextManager2
// Flags:     (4352) OleAutomation Dispatchable
// GUID:      {C7C2F61E-92FF-4F42-AD7B-DC29B69F083E}
// *********************************************************************//
  IaqContextManager2 = interface(IaqSubsystemManager)
    ['{C7C2F61E-92FF-4F42-AD7B-DC29B69F083E}']
    procedure RegisterContext2(ContextType: TGUID); safecall;
    procedure UnRegisterContext2(ContextType: TGUID); safecall;
    procedure SetContextValue(ContextType: TGUID; Value: TGUID); safecall;
  end;

// *********************************************************************//
// Interface: IaqContextChangedEvent
// Flags:     (0)
// GUID:      {9F113F4D-4EFE-46A4-85B1-59F7731CB36A}
// *********************************************************************//
  IaqContextChangedEvent = interface(IaqBaseEvent)
    ['{9F113F4D-4EFE-46A4-85B1-59F7731CB36A}']
    procedure OnContextChanged(const ContextType: TGUID; const OldContextValue: TGUID; 
                               const NewContextValue: TGUID); safecall;
  end;

// *********************************************************************//
// Interface: IaqFileMonitorManager
// Flags:     (4096) Dispatchable
// GUID:      {71AC8535-F164-498D-A0FD-A412BAB665A1}
// *********************************************************************//
  IaqFileMonitorManager = interface(IaqSubsystemManager)
    ['{71AC8535-F164-498D-A0FD-A412BAB665A1}']
    function AddFileToMonitoring(const FileName: WideString): Integer; safecall;
    procedure RemoveFileFromMonitoring(Id: Integer); safecall;
    procedure LockMonitoring; safecall;
    procedure UnLockMonitoring; safecall;
  end;

// *********************************************************************//
// Interface: IaqFileChangeEvent
// Flags:     (0)
// GUID:      {7B32F915-DA6C-400A-9054-D754C73BEEE1}
// *********************************************************************//
  IaqFileChangeEvent = interface(IaqBaseEvent)
    ['{7B32F915-DA6C-400A-9054-D754C73BEEE1}']
    procedure OnFileChange(const FileName: WideString; ChangedAttribute: Integer); safecall;
  end;

// *********************************************************************//
// Interface: IaqDataProviderStorage_XXX
// Flags:     (0)
// GUID:      {47C63009-CFDC-48E4-BA0B-1688222835EA}
// *********************************************************************//
  IaqDataProviderStorage_XXX = interface(IaqKeyItem)
    ['{47C63009-CFDC-48E4-BA0B-1688222835EA}']
    function FindProvider(ProviderType: TGUID; out Value: IaqDataProvider_XXX): WordBool; stdcall;
    function GetProviderCount: Integer; stdcall;
    procedure GetProvider(Index: Integer; out Value: IaqDataProvider_XXX); stdcall;
    procedure ChangeDataMoniker(const DataMoniker: IaqDataMoniker_XXX; 
                                Action: AQDATA_MONIKER_ACTION; Cookie: TGUID); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataProvider_XXX
// Flags:     (0)
// GUID:      {9853EA36-C681-452C-B14B-889C1754F4EE}
// *********************************************************************//
  IaqDataProvider_XXX = interface(IUnknown)
    ['{9853EA36-C681-452C-B14B-889C1754F4EE}']
    procedure GetSchema(out Value: IaqDataSchema_XXX); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataSchema_XXX
// Flags:     (0)
// GUID:      {579D9A51-EA23-4CD0-A7BF-7DDF6423118D}
// *********************************************************************//
  IaqDataSchema_XXX = interface(IaqKeyItem)
    ['{579D9A51-EA23-4CD0-A7BF-7DDF6423118D}']
    procedure GetName(out Value: WideString); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataMoniker_XXX
// Flags:     (0)
// GUID:      {D42FB808-B6AB-43EF-99DD-A394B425501F}
// *********************************************************************//
  IaqDataMoniker_XXX = interface(IUnknown)
    ['{D42FB808-B6AB-43EF-99DD-A394B425501F}']
    procedure GetType(out Value: TGUID); stdcall;
    function IsEqual(const Moniker: IaqDataMoniker_XXX): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataContainerProvider_XXX
// Flags:     (0)
// GUID:      {CDC36F90-C827-45F0-86CD-9B66639865C7}
// *********************************************************************//
  IaqDataContainerProvider_XXX = interface(IUnknown)
    ['{CDC36F90-C827-45F0-86CD-9B66639865C7}']
    procedure GetChild(const Moniker: IaqDataMoniker_XXX; ChildIndex: Integer; 
                       out Value: IaqDataProvider_XXX); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataTableProvider_XXX
// Flags:     (0)
// GUID:      {25022DB6-093A-420C-BE67-3445893A1695}
// *********************************************************************//
  IaqDataTableProvider_XXX = interface(IUnknown)
    ['{25022DB6-093A-420C-BE67-3445893A1695}']
    function GetRowCount: Integer; stdcall;
    procedure GetValue(RowIndex: Integer; ColIndex: Integer; out Value: OleVariant); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataTextProvider_XXX
// Flags:     (0)
// GUID:      {9365AD3E-A755-43C9-B891-4F3A2399C783}
// *********************************************************************//
  IaqDataTextProvider_XXX = interface(IUnknown)
    ['{9365AD3E-A755-43C9-B891-4F3A2399C783}']
    procedure GetText(out Value: WideString); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataLinkListener_XXX
// Flags:     (0)
// GUID:      {283F4FBE-B683-4421-9566-0B57B6391D66}
// *********************************************************************//
  IaqDataLinkListener_XXX = interface(IUnknown)
    ['{283F4FBE-B683-4421-9566-0B57B6391D66}']
    procedure OnLinkSelect(const Link: WideString; out Processed: WordBool); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataMonikerProvider_XXX
// Flags:     (0)
// GUID:      {358DCE25-8DF4-4800-97C6-2434394E04EA}
// *********************************************************************//
  IaqDataMonikerProvider_XXX = interface(IUnknown)
    ['{358DCE25-8DF4-4800-97C6-2434394E04EA}']
    procedure StringToMoniker(const MonikerString: WideString; out Value: IaqDataMoniker_XXX); stdcall;
    procedure MonikerToString(const DataMoniker: IaqDataMoniker_XXX; out MonikerString: WideString); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataTableMonikerProvider_XXX
// Flags:     (0)
// GUID:      {24939A6D-8F06-4616-AE9D-1E2FD99387C9}
// *********************************************************************//
  IaqDataTableMonikerProvider_XXX = interface(IUnknown)
    ['{24939A6D-8F06-4616-AE9D-1E2FD99387C9}']
    procedure GetMonikerByRowIndex(RowIndex: Integer; out Value: IaqDataMoniker_XXX); stdcall;
    function GetRowIndex(const DataMoniker: IaqDataMoniker_XXX): Integer; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataContainerSchema_XXX
// Flags:     (0)
// GUID:      {42E35A22-FE65-4700-874F-AD24EA4EEF15}
// *********************************************************************//
  IaqDataContainerSchema_XXX = interface(IUnknown)
    ['{42E35A22-FE65-4700-874F-AD24EA4EEF15}']
    function GetChildCount: Integer; stdcall;
    procedure GetChild(ChildIndex: Integer; out Value: IaqDataSchema_XXX); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataTableSchema_XXX
// Flags:     (0)
// GUID:      {2494EF33-70CE-4CF4-B658-AD10AB6FD424}
// *********************************************************************//
  IaqDataTableSchema_XXX = interface(IUnknown)
    ['{2494EF33-70CE-4CF4-B658-AD10AB6FD424}']
    function GetColumnCount: Integer; stdcall;
    procedure GetColumn(ColumnIndex: Integer; out Value: PAQDATA_COLUMN_INFO_XXX); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataBandedTableSchema_XXX
// Flags:     (0)
// GUID:      {A1224B21-63F7-4936-9EAB-EBE89074B353}
// *********************************************************************//
  IaqDataBandedTableSchema_XXX = interface(IaqDataTableSchema_XXX)
    ['{A1224B21-63F7-4936-9EAB-EBE89074B353}']
    function GetBandCount: Integer; stdcall;
    procedure GetBandInfo(BandIndex: Integer; out Value: PAQDATA_BAND_INFO_XXX); stdcall;
    function GetBandColumnCount(BandIndex: Integer): Integer; stdcall;
    function GetBandColumn(BandIndex: Integer; ColumnIndex: Integer; Value: PPUserType1): Integer; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataPictureProvider_XXX
// Flags:     (0)
// GUID:      {2FBADEA4-7D8A-4B8A-A769-2B6A0454B56F}
// *********************************************************************//
  IaqDataPictureProvider_XXX = interface(IUnknown)
    ['{2FBADEA4-7D8A-4B8A-A769-2B6A0454B56F}']
    function GetImageReference: Integer; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataPictureSchema_XXX
// Flags:     (0)
// GUID:      {8C4B1C1A-9F0C-47F0-8E8E-069A9FF02796}
// *********************************************************************//
  IaqDataPictureSchema_XXX = interface(IUnknown)
    ['{8C4B1C1A-9F0C-47F0-8E8E-069A9FF02796}']
  end;

// *********************************************************************//
// Interface: IaqFilterTableSchema
// Flags:     (0)
// GUID:      {A78398D7-E79C-4819-99F9-F2D5B232CD56}
// *********************************************************************//
  IaqFilterTableSchema = interface(IUnknown)
    ['{A78398D7-E79C-4819-99F9-F2D5B232CD56}']
    function GetFilterCount: Integer; stdcall;
    procedure GetFilterDescription(FilterDescIndex: Integer; out Description: AQ_FILTER_DESCRIPTION); stdcall;
  end;

// *********************************************************************//
// Interface: IaqFilterTableProvider
// Flags:     (0)
// GUID:      {B7DB5380-62C2-4D91-9327-F86E269CFC5C}
// *********************************************************************//
  IaqFilterTableProvider = interface(IUnknown)
    ['{B7DB5380-62C2-4D91-9327-F86E269CFC5C}']
    function GetFilterRowType(RowIndex: Integer): Integer; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataNavigationSchema
// Flags:     (0)
// GUID:      {402DC57D-D7A6-4774-9525-534890AC7EC4}
// *********************************************************************//
  IaqDataNavigationSchema = interface(IUnknown)
    ['{402DC57D-D7A6-4774-9525-534890AC7EC4}']
    function GetDataTypeCount: Integer; stdcall;
    procedure GetDataTypeDescription(DataTypeIndex: Integer; 
                                     out Description: AQ_DATA_TYPE_DESCRIPTION); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataNavigationProvider
// Flags:     (0)
// GUID:      {611E1D54-A05B-402A-9FA4-38982B5716B4}
// *********************************************************************//
  IaqDataNavigationProvider = interface(IUnknown)
    ['{611E1D54-A05B-402A-9FA4-38982B5716B4}']
    function GetDataType(const Moniker: IaqDataMoniker_XXX): Integer; stdcall;
    procedure GetChildDataProviderMoniker(const Moniker: IaqDataMoniker_XXX; 
                                          out MonikerSring: WideString); stdcall;
    procedure GetParentDataMoniker(out ParentMoniker: IaqDataMoniker_XXX); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataTreeProvider_XXX
// Flags:     (0)
// GUID:      {219CA22C-FC85-411D-9E47-E975D9D7EC9D}
// *********************************************************************//
  IaqDataTreeProvider_XXX = interface(IaqDataTableProvider_XXX)
    ['{219CA22C-FC85-411D-9E47-E975D9D7EC9D}']
    function GetParentRowIndex(RowIndex: Integer): Integer; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataGraphSchema_XXX
// Flags:     (0)
// GUID:      {7C7F147D-6EF6-4CCB-A2C9-0E97190876C6}
// *********************************************************************//
  IaqDataGraphSchema_XXX = interface(IUnknown)
    ['{7C7F147D-6EF6-4CCB-A2C9-0E97190876C6}']
    function ColumnCanBeAbsciss(const ColumnID: TGUID): WordBool; stdcall;
    function ValidCombination(const AbscissColumnID: TGUID; const OrdinateColumnID: TGUID): WordBool; stdcall;
    procedure GetDefaultAbsciss(out AbscissColumnID: TGUID); stdcall;
    function GetDefaultOrdinateCount: Integer; stdcall;
    procedure GetDefaultOrdinate(Index: Integer; out OrdinateColumnID: TGUID); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataDiagramSchema_XXX
// Flags:     (0)
// GUID:      {5E59ED41-C85F-4A2E-9641-940315B82579}
// *********************************************************************//
  IaqDataDiagramSchema_XXX = interface(IUnknown)
    ['{5E59ED41-C85F-4A2E-9641-940315B82579}']
    function ColumnCanBeInformation(const ColumnID: TGUID): WordBool; stdcall;
    function ValidCombination(const InformationColumnID: TGUID; const ValueColumnID: TGUID): WordBool; stdcall;
    function NeedSortValue(const InformationColumnID: TGUID): WordBool; stdcall;
    procedure GetDefaultInformation(out InformationColumnID: TGUID); stdcall;
    procedure GetDefaultValue(out ValueColumnID: TGUID); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataTreeSchema_XXX
// Flags:     (0)
// GUID:      {A901230A-B010-479B-8215-3F7986A2640F}
// *********************************************************************//
  IaqDataTreeSchema_XXX = interface(IUnknown)
    ['{A901230A-B010-479B-8215-3F7986A2640F}']
  end;

// *********************************************************************//
// Interface: IaqDataTextSchema_XXX
// Flags:     (0)
// GUID:      {41ADB9D7-C45C-42ED-851B-E60AC1B3D67E}
// *********************************************************************//
  IaqDataTextSchema_XXX = interface(IUnknown)
    ['{41ADB9D7-C45C-42ED-851B-E60AC1B3D67E}']
    function GetFormat: AQ_TEXT_FORMAT_XXX; stdcall;
  end;

// *********************************************************************//
// Interface: IaqSymbolDataMoniker_XXX
// Flags:     (0)
// GUID:      {86796B87-1B32-497C-B105-FBFDEEB90E0B}
// *********************************************************************//
  IaqSymbolDataMoniker_XXX = interface(IUnknown)
    ['{86796B87-1B32-497C-B105-FBFDEEB90E0B}']
    procedure GetSymbolMoniker(out Value: WideString); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataProviderEvent_XXX
// Flags:     (0)
// GUID:      {04EDF72C-F15D-4D3B-A92B-99B07C152BF8}
// *********************************************************************//
  IaqDataProviderEvent_XXX = interface(IaqBaseEvent)
    ['{04EDF72C-F15D-4D3B-A92B-99B07C152BF8}']
    procedure OnDataChanged(SchemaKey: TGUID); stdcall;
    procedure OnSchemaChanged(SchemaKey: TGUID); stdcall;
  end;

// *********************************************************************//
// Interface: IaqExportImportProvider
// Flags:     (0)
// GUID:      {5F32ACAF-43D5-4D48-B631-5EDB3DDC8173}
// *********************************************************************//
  IaqExportImportProvider = interface(IaqKeyItem)
    ['{5F32ACAF-43D5-4D48-B631-5EDB3DDC8173}']
    procedure GetGroupKey(out Value: TGUID); stdcall;
    procedure GetCaption(out Value: WideString); stdcall;
    procedure ExportConfiguration(const AOptions: IaqOptionsNode); stdcall;
    procedure ImportConfiguration(const AOptions: IaqOptionsNode); stdcall;
  end;

// *********************************************************************//
// Interface: IaqTimeProductInfo
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BDF54B8-19AD-479E-B589-907B5701AFFF}
// *********************************************************************//
  IaqTimeProductInfo = interface(IaqProductInfo)
    ['{9BDF54B8-19AD-479E-B589-907B5701AFFF}']
    function Get_ViewsPath: WideString; safecall;
    property ViewsPath: WideString read Get_ViewsPath;
  end;

// *********************************************************************//
// DispIntf:  IaqTimeProductInfoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BDF54B8-19AD-479E-B589-907B5701AFFF}
// *********************************************************************//
  IaqTimeProductInfoDisp = dispinterface
    ['{9BDF54B8-19AD-479E-B589-907B5701AFFF}']
    property ViewsPath: WideString readonly dispid 1610809344;
    property Name: WideString readonly dispid 155649;
    property VersionMajor: Integer readonly dispid 155650;
    property VersionMinor: Integer readonly dispid 155651;
    property VersionRelease: Integer readonly dispid 155652;
    property VersionBuild: Integer readonly dispid 155653;
    property VersionValue: WideString readonly dispid 155654;
    property RegistryPath: WideString readonly dispid 155655;
    property ProductPath: WideString readonly dispid 155656;
    property ProductDataFolder: WideString readonly dispid 155657;
    property ProductLocalSettingsDataFolder: WideString readonly dispid 155658;
    property ProductCommonDataFolder: WideString readonly dispid 155659;
    property HelpFile: WideString readonly dispid 155660;
    property WhatThisHelpFile: WideString readonly dispid 155661;
    property WebSite: WideString readonly dispid 155662;
    property SupportAddress: WideString readonly dispid 155663;
    property SupportText: WideString readonly dispid 155664;
    property Copyright: WideString readonly dispid 155665;
    property IntegrationType: {??TGUID}OleVariant readonly dispid 155666;
    property ProductKey: {??TGUID}OleVariant readonly dispid 155667;
  end;

// *********************************************************************//
// Interface: IaqViews
// Flags:     (4096) Dispatchable
// GUID:      {70EBC214-6BF3-11D3-9E00-0020781423AC}
// *********************************************************************//
  IaqViews = interface(IaqSubsystemManager)
    ['{70EBC214-6BF3-11D3-9E00-0020781423AC}']
    function Get_ViewCount: Integer; safecall;
    function Get_ViewName(Index: Integer): WideString; safecall;
    procedure SelectAsCurrent(const Name: WideString); safecall;
    function GetOptionsByKey(Key: TGUID): IaqOptionsNode; safecall;
    function GetGlobalViewOptionsByKey(Key: TGUID): IaqOptionsNode; safecall;
    property ViewCount: Integer read Get_ViewCount;
    property ViewName[Index: Integer]: WideString read Get_ViewName;
  end;

// *********************************************************************//
// Interface: IaqViewEvent
// Flags:     (0)
// GUID:      {825DA0DE-77F0-4856-B614-DD31C66A4BBC}
// *********************************************************************//
  IaqViewEvent = interface(IaqBaseEvent)
    ['{825DA0DE-77F0-4856-B614-DD31C66A4BBC}']
    procedure SaveView; safecall;
    procedure LoadView; safecall;
  end;

// *********************************************************************//
// Interface: IaqViewsEvent
// Flags:     (0)
// GUID:      {6BE4A07A-515E-4BB5-8BF1-143461370759}
// *********************************************************************//
  IaqViewsEvent = interface(IaqBaseEvent)
    ['{6BE4A07A-515E-4BB5-8BF1-143461370759}']
    procedure OnViewChanged(Event: AQ_VIEWS_EVENT; Index: Integer); safecall;
  end;

// *********************************************************************//
// Interface: IaqEventViewCallBack
// Flags:     (0)
// GUID:      {86C06394-BB1F-407F-A6EA-00A4EFD777FE}
// *********************************************************************//
  IaqEventViewCallBack = interface(IUnknown)
    ['{86C06394-BB1F-407F-A6EA-00A4EFD777FE}']
    procedure OnSelectMessage(const MessageKey: TGUID; MessageData: OleVariant); safecall;
    function GetSelectedObject(const MessageKey: TGUID; MessageData: OleVariant): OleVariant; safecall;
  end;

// *********************************************************************//
// Interface: IaqEventViewEngineManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3BAB2505-7883-4C7B-9BD7-DB554B7934BE}
// *********************************************************************//
  IaqEventViewEngineManager = interface(IaqSubsystemManager)
    ['{3BAB2505-7883-4C7B-9BD7-DB554B7934BE}']
    procedure RegisterMessageGroup(const GroupKey: TGUID; const GroupName: WideString); safecall;
    procedure UnRegisterMessageGroup(const GroupKey: TGUID); safecall;
    procedure RegisterMessageType(const MessageKey: TGUID; const GroupKey: TGUID; 
                                  const MessageCaption: WideString; Image: OLE_HANDLE; 
                                  const Callback: IaqEventViewCallBack); safecall;
    procedure UnregisterMessageType(const MessageKey: TGUID); safecall;
    function AddMessage(OwnerMessageIndex: Integer; const MessageKey: TGUID; 
                        const Message: WideString; ThreadID: Integer; MessageData: OleVariant): Integer; safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqEventViewEngineManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3BAB2505-7883-4C7B-9BD7-DB554B7934BE}
// *********************************************************************//
  IaqEventViewEngineManagerDisp = dispinterface
    ['{3BAB2505-7883-4C7B-9BD7-DB554B7934BE}']
    procedure RegisterMessageGroup(var GroupKey: {??TGUID}OleVariant; const GroupName: WideString); dispid 1610809344;
    procedure UnRegisterMessageGroup(var GroupKey: {??TGUID}OleVariant); dispid 1610809345;
    procedure RegisterMessageType(var MessageKey: {??TGUID}OleVariant; 
                                  var GroupKey: {??TGUID}OleVariant; 
                                  const MessageCaption: WideString; Image: OLE_HANDLE; 
                                  const Callback: IaqEventViewCallBack); dispid 1610809346;
    procedure UnregisterMessageType(var MessageKey: {??TGUID}OleVariant); dispid 1610809347;
    function AddMessage(OwnerMessageIndex: Integer; var MessageKey: {??TGUID}OleVariant; 
                        const Message: WideString; ThreadID: Integer; MessageData: OleVariant): Integer; dispid 1610809348;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqResultsStorageItem
// Flags:     (320) Dual OleAutomation
// GUID:      {D600EF75-449D-4F67-90A7-53E4FA883B07}
// *********************************************************************//
  IaqResultsStorageItem = interface(IUnknown)
    ['{D600EF75-449D-4F67-90A7-53E4FA883B07}']
    function Get_Key: TGUID; safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    function Get_Description: WideString; safecall;
    procedure Set_Description(const Value: WideString); safecall;
    property Key: TGUID read Get_Key;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Description: WideString read Get_Description write Set_Description;
  end;

// *********************************************************************//
// DispIntf:  IaqResultsStorageItemDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {D600EF75-449D-4F67-90A7-53E4FA883B07}
// *********************************************************************//
  IaqResultsStorageItemDisp = dispinterface
    ['{D600EF75-449D-4F67-90A7-53E4FA883B07}']
    property Key: {??TGUID}OleVariant readonly dispid 16834561;
    property Caption: WideString dispid 16834562;
    property Description: WideString dispid 16834563;
  end;

// *********************************************************************//
// Interface: IaqResult
// Flags:     (320) Dual OleAutomation
// GUID:      {5ADF5988-8442-4327-B707-1D2BCA027C85}
// *********************************************************************//
  IaqResult = interface(IaqResultsStorageItem)
    ['{5ADF5988-8442-4327-B707-1D2BCA027C85}']
    function Get_ResultData: IaqOptionsNode; safecall;
    function AddResultNode(const DisplayName: WideString; TypeID: TGUID; CustomData: OleVariant): IaqResultNode; safecall;
    function Get_ResultNodeCount: Integer; safecall;
    function Get_ResultNodes(Index: Integer): IaqResultNode; safecall;
    property ResultData: IaqOptionsNode read Get_ResultData;
    property ResultNodeCount: Integer read Get_ResultNodeCount;
    property ResultNodes[Index: Integer]: IaqResultNode read Get_ResultNodes;
  end;

// *********************************************************************//
// DispIntf:  IaqResultDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5ADF5988-8442-4327-B707-1D2BCA027C85}
// *********************************************************************//
  IaqResultDisp = dispinterface
    ['{5ADF5988-8442-4327-B707-1D2BCA027C85}']
    property ResultData: IaqOptionsNode readonly dispid 16855041;
    function AddResultNode(const DisplayName: WideString; TypeID: {??TGUID}OleVariant; 
                           CustomData: OleVariant): IaqResultNode; dispid 16855042;
    property ResultNodeCount: Integer readonly dispid 16855043;
    property ResultNodes[Index: Integer]: IaqResultNode readonly dispid 16855044;
    property Key: {??TGUID}OleVariant readonly dispid 16834561;
    property Caption: WideString dispid 16834562;
    property Description: WideString dispid 16834563;
  end;

// *********************************************************************//
// Interface: IaqResultNode
// Flags:     (320) Dual OleAutomation
// GUID:      {20E4EC8E-5234-43D4-9605-1EDA0541D0DF}
// *********************************************************************//
  IaqResultNode = interface(IUnknown)
    ['{20E4EC8E-5234-43D4-9605-1EDA0541D0DF}']
    function Get_Key: TGUID; safecall;
    function Get_DisplayName: WideString; safecall;
    function Get_TypeID: TGUID; safecall;
    function Get_CustomData: OleVariant; safecall;
    function AddResultNode(const DisplayName: WideString; TypeID: TGUID; CustomData: OleVariant): IaqResultNode; safecall;
    function Get_ResultNodeCount: Integer; safecall;
    function Get_ResultNodes(Index: Integer): IaqResultNode; safecall;
    function Get_Parent: IaqResultNode; safecall;
    function Get_Description: WideString; safecall;
    procedure Set_Description(const Value: WideString); safecall;
    function Get_IsDefault: WordBool; safecall;
    procedure Set_IsDefault(Value: WordBool); safecall;
    property Key: TGUID read Get_Key;
    property DisplayName: WideString read Get_DisplayName;
    property TypeID: TGUID read Get_TypeID;
    property CustomData: OleVariant read Get_CustomData;
    property ResultNodeCount: Integer read Get_ResultNodeCount;
    property ResultNodes[Index: Integer]: IaqResultNode read Get_ResultNodes;
    property Parent: IaqResultNode read Get_Parent;
    property Description: WideString read Get_Description write Set_Description;
    property IsDefault: WordBool read Get_IsDefault write Set_IsDefault;
  end;

// *********************************************************************//
// DispIntf:  IaqResultNodeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {20E4EC8E-5234-43D4-9605-1EDA0541D0DF}
// *********************************************************************//
  IaqResultNodeDisp = dispinterface
    ['{20E4EC8E-5234-43D4-9605-1EDA0541D0DF}']
    property Key: {??TGUID}OleVariant readonly dispid 16859137;
    property DisplayName: WideString readonly dispid 16859138;
    property TypeID: {??TGUID}OleVariant readonly dispid 16859139;
    property CustomData: OleVariant readonly dispid 16859140;
    function AddResultNode(const DisplayName: WideString; TypeID: {??TGUID}OleVariant; 
                           CustomData: OleVariant): IaqResultNode; dispid 16859141;
    property ResultNodeCount: Integer readonly dispid 16859142;
    property ResultNodes[Index: Integer]: IaqResultNode readonly dispid 16859143;
    property Parent: IaqResultNode readonly dispid 16859144;
    property Description: WideString dispid 16859145;
    property IsDefault: WordBool dispid 16859152;
  end;

// *********************************************************************//
// Interface: IaqMetaProvider
// Flags:     (0)
// GUID:      {71249768-E741-4B51-B92E-4702AAF097FC}
// *********************************************************************//
  IaqMetaProvider = interface(IUnknown)
    ['{71249768-E741-4B51-B92E-4702AAF097FC}']
    function IsSupportProvider(const ProviderType: TGUID): WordBool; stdcall;
    function GetDataProvider(const ProviderType: TGUID): IaqDataProvider; safecall;
    procedure SetCurrentBrowseObject(const BrowseObj: IaqBrowseObject; 
                                     ActionType: AQ_BROWSE_OBJECT_ACTION_TYPE; const Cookie: TGUID); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDataProvider
// Flags:     (0)
// GUID:      {E2D38B17-BAC9-4CA7-9D98-DE3517ADCCF8}
// *********************************************************************//
  IaqDataProvider = interface(IUnknown)
    ['{E2D38B17-BAC9-4CA7-9D98-DE3517ADCCF8}']
    function GetSchema: IaqDataSchema; safecall;
    function GetMetaProvider: IaqMetaProvider; safecall;
  end;

// *********************************************************************//
// Interface: IaqDataSchema
// Flags:     (0)
// GUID:      {529B1C02-741A-4D90-94BD-85C794633F84}
// *********************************************************************//
  IaqDataSchema = interface(IaqKeyItem)
    ['{529B1C02-741A-4D90-94BD-85C794633F84}']
    function GetCaption: WideString; safecall;
    function GetChildCount: Integer; stdcall;
    function GetChilds(ChildIndex: Integer): IaqDataSchema; safecall;
  end;

// *********************************************************************//
// Interface: IaqBrowseObject
// Flags:     (0)
// GUID:      {9782B7F4-D479-4AF6-935D-71564BEAED7F}
// *********************************************************************//
  IaqBrowseObject = interface(IUnknown)
    ['{9782B7F4-D479-4AF6-935D-71564BEAED7F}']
    procedure GetBrowseType(out Value: TGUID); stdcall;
    function IsEqual(const Obj: IaqBrowseObject): WordBool; stdcall;
    function GetMoniker: WideString; safecall;
  end;

// *********************************************************************//
// Interface: IaqDataSchemaEx
// Flags:     (0)
// GUID:      {C28B59EA-87CB-4DA4-A1F4-497AA4A0AC26}
// *********************************************************************//
  IaqDataSchemaEx = interface(IaqDataSchema)
    ['{C28B59EA-87CB-4DA4-A1F4-497AA4A0AC26}']
    procedure AddChild(const Value: IaqDataSchema); safecall;
    procedure RemoveChild(const Value: IaqDataSchema); safecall;
  end;

// *********************************************************************//
// Interface: IaqTableDataSchema
// Flags:     (0)
// GUID:      {B54A842C-D1CC-46B9-9839-9391E589DFC5}
// *********************************************************************//
  IaqTableDataSchema = interface(IaqDataSchema)
    ['{B54A842C-D1CC-46B9-9839-9391E589DFC5}']
    function GetColumnCount: Integer; stdcall;
    function GetColumns(ColumnIndex: Integer): PAQ_TABLE_COLUMN_INFO; stdcall;
    function GetBandCount: Integer; stdcall;
    function GetBands(BandIndex: Integer): IaqTableBand; safecall;
  end;

// *********************************************************************//
// Interface: IaqTableBand
// Flags:     (0)
// GUID:      {0E74660D-CC02-4D09-80DA-F0D5BAED1C79}
// *********************************************************************//
  IaqTableBand = interface(IaqKeyItem)
    ['{0E74660D-CC02-4D09-80DA-F0D5BAED1C79}']
    function GetCaption: WideString; safecall;
  end;

// *********************************************************************//
// Interface: IaqTableDataProvider
// Flags:     (0)
// GUID:      {6060C1A0-366F-41B4-A058-85476058478B}
// *********************************************************************//
  IaqTableDataProvider = interface(IaqDataProvider)
    ['{6060C1A0-366F-41B4-A058-85476058478B}']
    function GetRowCount: Integer; stdcall;
    function GetChildCount: Integer; stdcall;
    procedure GetValue(RowIndex: Integer; ColIndex: Integer; out Value: OleVariant); stdcall;
    function GetBrowseObject(RowIndex: Integer): IaqBrowseObject; safecall;
    function GetRowIndex(const BrowseObject: IaqBrowseObject): Integer; stdcall;
    function GetChilds(RowIndex: Integer; ChildIndex: Integer): IaqDataProvider; safecall;
  end;

// *********************************************************************//
// Interface: IaqTableDataProviderEx
// Flags:     (0)
// GUID:      {A175E5D1-5BE1-4499-8BA9-CA79F00D2D9D}
// *********************************************************************//
  IaqTableDataProviderEx = interface(IaqTableDataProvider)
    ['{A175E5D1-5BE1-4499-8BA9-CA79F00D2D9D}']
    procedure SetTextNotesColumnGUID(ColumnID: TGUID); safecall;
    procedure SetTextNotesCaption(const Caption: WideString); safecall;
  end;

// *********************************************************************//
// Interface: IaqNotepadProvider
// Flags:     (0)
// GUID:      {2C8C7B8F-9B0A-49A5-B8A3-6F0B77DCC4D7}
// *********************************************************************//
  IaqNotepadProvider = interface(IaqDataProvider)
    ['{2C8C7B8F-9B0A-49A5-B8A3-6F0B77DCC4D7}']
    function GetText: WideString; safecall;
  end;

// *********************************************************************//
// Interface: IaqGraphDataProvider
// Flags:     (0)
// GUID:      {0C90B6A6-9C58-46F6-8B14-21F6F2570121}
// *********************************************************************//
  IaqGraphDataProvider = interface(IaqTableDataProvider)
    ['{0C90B6A6-9C58-46F6-8B14-21F6F2570121}']
  end;

// *********************************************************************//
// Interface: IaqSourceFileProvider
// Flags:     (0)
// GUID:      {25014317-DE2D-4F38-8823-5C962F22549F}
// *********************************************************************//
  IaqSourceFileProvider = interface(IaqTableDataProvider)
    ['{25014317-DE2D-4F38-8823-5C962F22549F}']
    function GetSourceLine(RowIndex: Integer): Integer; stdcall;
  end;

// *********************************************************************//
// Interface: IaqCallGraphDataProvider
// Flags:     (0)
// GUID:      {7BDCEBF0-6F6A-441E-A876-90AE15DB0656}
// *********************************************************************//
  IaqCallGraphDataProvider = interface(IaqTableDataProvider)
    ['{7BDCEBF0-6F6A-441E-A876-90AE15DB0656}']
    function GetParentsIndex: Integer; stdcall;
    function GetChildsIndex: Integer; stdcall;
    function GetNodeName(RowIndex: Integer): WideString; safecall;
  end;

// *********************************************************************//
// Interface: IaqSummaryDataProvider
// Flags:     (0)
// GUID:      {949DCC6A-1A1E-49E0-B43B-88F5D541A959}
// *********************************************************************//
  IaqSummaryDataProvider = interface(IaqDataProvider)
    ['{949DCC6A-1A1E-49E0-B43B-88F5D541A959}']
    function GetXMLData: WideString; safecall;
    procedure OnLinkSelect(const Reference: WideString; out Processed: WordBool); stdcall;
  end;

// *********************************************************************//
// Interface: IaqTextNotesDataProvider
// Flags:     (0)
// GUID:      {05FCF9D2-4A50-4DC4-965E-4B7286DDBA9B}
// *********************************************************************//
  IaqTextNotesDataProvider = interface(IaqDataProvider)
    ['{05FCF9D2-4A50-4DC4-965E-4B7286DDBA9B}']
    function GetText: WideString; safecall;
  end;

// *********************************************************************//
// Interface: IaqTextNotesSchema
// Flags:     (0)
// GUID:      {C461AA88-B09F-4713-AEA5-274DF55C03B2}
// *********************************************************************//
  IaqTextNotesSchema = interface(IUnknown)
    ['{C461AA88-B09F-4713-AEA5-274DF55C03B2}']
    function GetFormat: AQ_TEXT_NOTES_TYPE; stdcall;
  end;

// *********************************************************************//
// Interface: IaqBrowseDataEvent
// Flags:     (0)
// GUID:      {A4385868-6BAE-4F31-A410-E8A0FD1735FF}
// *********************************************************************//
  IaqBrowseDataEvent = interface(IaqBaseEvent)
    ['{A4385868-6BAE-4F31-A410-E8A0FD1735FF}']
    procedure MetaProviderCreated(const MetaProvider: IaqMetaProvider); stdcall;
    procedure MetaProviderChanged(const MetaProvider: IaqMetaProvider; ShemaChanged: WordBool); stdcall;
    procedure MetaProviderDataMonikerChanged(const MetaProvider: IaqMetaProvider; 
                                             const Moniker: IaqBrowseObject; 
                                             ActionType: AQ_BROWSE_OBJECT_ACTION_TYPE; Cookie: TGUID); stdcall;
    procedure MetaProviderDestroyed(const MetaProvider: IaqMetaProvider); stdcall;
  end;

// *********************************************************************//
// Interface: IaqSourceFilesProvider
// Flags:     (0)
// GUID:      {DA36799E-F5C1-4B05-900F-BA9E92732C15}
// *********************************************************************//
  IaqSourceFilesProvider = interface(IaqTableDataProvider)
    ['{DA36799E-F5C1-4B05-900F-BA9E92732C15}']
    function GetGutterSchema: IaqDataSchema; safecall;
    function GetGutterChildsIndex: Integer; stdcall;
    function GetCommentsSchema: IaqDataSchema; safecall;
    function GetCommentsChildsIndex: Integer; stdcall;
    function GetFileName(RowIndex: Integer): WideString; safecall;
  end;

// *********************************************************************//
// Interface: IaqSymbolMonikerProvider
// Flags:     (0)
// GUID:      {223B4703-2F1F-4501-91B8-702BAAEA1F01}
// *********************************************************************//
  IaqSymbolMonikerProvider = interface(IaqDataProvider)
    ['{223B4703-2F1F-4501-91B8-702BAAEA1F01}']
    procedure GetMoniker(RowIndex: Integer; out Value: WideString); stdcall;
    function GetRowIndex(const SymbolMoniker: WideString): Integer; stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfilersManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {41CC57C3-F8E7-4ECF-BC2F-29F13A34FFFB}
// *********************************************************************//
  IaqProfilersManager = interface(IaqSubsystemManager)
    ['{41CC57C3-F8E7-4ECF-BC2F-29F13A34FFFB}']
    function Get_Count: Integer; safecall;
    function Get_Profilers(Index: Integer): IaqBaseProfiler; safecall;
    function Get_Current: IaqBaseProfiler; safecall;
    procedure SelectProfiler(Index: Integer); safecall;
    procedure SelectProfilerByKey(ProfilerKey: TGUID); safecall;
    function Get_RunModeKey: TGUID; safecall;
    procedure Set_RunModeKey(Value: TGUID); safecall;
    function Get_RunMode: IaqRunMode; safecall;
    function Get_RunModeCount: Integer; safecall;
    function Get_RunModeByIndex(Index: Integer): IaqRunMode; safecall;
    function Get_IsStarted: WordBool; safecall;
    function Get_IsSuspended: WordBool; safecall;
    function Start: WordBool; safecall;
    function Attach(ProcessID: LongWord): WordBool; safecall;
    function Detach: WordBool; safecall;
    procedure Terminate; safecall;
    procedure Suspend; safecall;
    procedure Resume; safecall;
    procedure CancelProfiling; safecall;
    procedure SetEnableProfilingState(State: WordBool); safecall;
    property Count: Integer read Get_Count;
    property Profilers[Index: Integer]: IaqBaseProfiler read Get_Profilers;
    property Current: IaqBaseProfiler read Get_Current;
    property RunModeKey: TGUID read Get_RunModeKey write Set_RunModeKey;
    property RunMode: IaqRunMode read Get_RunMode;
    property RunModeCount: Integer read Get_RunModeCount;
    property RunModeByIndex[Index: Integer]: IaqRunMode read Get_RunModeByIndex;
    property IsStarted: WordBool read Get_IsStarted;
    property IsSuspended: WordBool read Get_IsSuspended;
  end;

// *********************************************************************//
// DispIntf:  IaqProfilersManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {41CC57C3-F8E7-4ECF-BC2F-29F13A34FFFB}
// *********************************************************************//
  IaqProfilersManagerDisp = dispinterface
    ['{41CC57C3-F8E7-4ECF-BC2F-29F13A34FFFB}']
    property Count: Integer readonly dispid 1610809344;
    property Profilers[Index: Integer]: IaqBaseProfiler readonly dispid 1610809345;
    property Current: IaqBaseProfiler readonly dispid 1610809346;
    procedure SelectProfiler(Index: Integer); dispid 1610809347;
    procedure SelectProfilerByKey(ProfilerKey: {??TGUID}OleVariant); dispid 1610809348;
    property RunModeKey: {??TGUID}OleVariant dispid 16777217;
    property RunMode: IaqRunMode readonly dispid 1610809351;
    property RunModeCount: Integer readonly dispid 1610809352;
    property RunModeByIndex[Index: Integer]: IaqRunMode readonly dispid 1610809353;
    property IsStarted: WordBool readonly dispid 1610809354;
    property IsSuspended: WordBool readonly dispid 1610809355;
    function Start: WordBool; dispid 1610809356;
    function Attach(ProcessID: LongWord): WordBool; dispid 1610809357;
    function Detach: WordBool; dispid 1610809358;
    procedure Terminate; dispid 1610809359;
    procedure Suspend; dispid 1610809360;
    procedure Resume; dispid 1610809361;
    procedure CancelProfiling; dispid 1610809362;
    procedure SetEnableProfilingState(State: WordBool); dispid 1610809363;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqBaseProfiler
// Flags:     (0)
// GUID:      {4D7665E4-4011-4681-83DD-B9F9AEF2B999}
// *********************************************************************//
  IaqBaseProfiler = interface(IaqExtendedPlugin)
    ['{4D7665E4-4011-4681-83DD-B9F9AEF2B999}']
    procedure Activate; safecall;
    procedure Deactivate; safecall;
  end;

// *********************************************************************//
// Interface: IaqRunMode
// Flags:     (0)
// GUID:      {11AD2E12-E372-4BA8-A3BB-33CAEEF6E508}
// *********************************************************************//
  IaqRunMode = interface(IaqKeyItem)
    ['{11AD2E12-E372-4BA8-A3BB-33CAEEF6E508}']
    procedure GetName(out Value: WideString); stdcall;
    function PrepareRun(StartOperation: AQ_PROFILER_START_OPERATION): WordBool; stdcall;
    function Run(const pProfiler: IaqDynamicProfiler; const Listener: IaqDebugListener): WordBool; stdcall;
    function IsAttachSupported: WordBool; stdcall;
    function Attach(ProcessID: LongWord; const pProfiler: IaqDynamicProfiler; 
                    const Listener: IaqDebugListener): WordBool; stdcall;
    procedure RunFailed; stdcall;
    function GetParameterCount: Integer; stdcall;
    procedure GetParameter(Index: Integer; out ParamName: WideString; out ParamValue: OleVariant); stdcall;
    procedure SetParameter(Index: Integer; Value: OleVariant); stdcall;
    function ConfigureParameters: WordBool; stdcall;
    procedure GetSettings(out Value: IaqSettings_DVS); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDynamicProfiler
// Flags:     (0)
// GUID:      {F058A8B0-9BCE-4A29-AFFD-A39777F956A7}
// *********************************************************************//
  IaqDynamicProfiler = interface(IaqBaseProfiler)
    ['{F058A8B0-9BCE-4A29-AFFD-A39777F956A7}']
    function Get_ProfilerFeatures: LongWord; safecall;
    function PrepareRun: WordBool; stdcall;
    procedure GetInjectDllName(x64: WordBool; out Value: WideString); stdcall;
    procedure GetEnvironmentVariables(x64: WordBool; out Value: PSafeArray); stdcall;
    procedure RunFailed; stdcall;
    procedure TakeSnapshot; safecall;
    function ClearResults: WordBool; safecall;
    procedure Set_EnableProfiling(Value: WordBool); safecall;
    function Get_EnableProfiling: WordBool; safecall;
    property ProfilerFeatures: LongWord read Get_ProfilerFeatures;
    property EnableProfiling: WordBool read Get_EnableProfiling write Set_EnableProfiling;
  end;

// *********************************************************************//
// Interface: IaqStaticProfiler
// Flags:     (0)
// GUID:      {24663498-A741-4B04-8D3F-8F34F4A08195}
// *********************************************************************//
  IaqStaticProfiler = interface(IaqBaseProfiler)
    ['{24663498-A741-4B04-8D3F-8F34F4A08195}']
    function PrepareRun: WordBool; stdcall;
    procedure Start; safecall;
  end;

// *********************************************************************//
// Interface: IaqSetupProvider
// Flags:     (0)
// GUID:      {31D25A66-DB1F-47D2-A8D2-8221BBB99045}
// *********************************************************************//
  IaqSetupProvider = interface(IUnknown)
    ['{31D25A66-DB1F-47D2-A8D2-8221BBB99045}']
    function Get_SetupFeatures: AQ_SETUP_FEATURES; safecall;
    property SetupFeatures: AQ_SETUP_FEATURES read Get_SetupFeatures;
  end;

// *********************************************************************//
// Interface: IaqLaunchProvider
// Flags:     (0)
// GUID:      {77DC4EB9-7127-4CFA-A831-31ED94082DAC}
// *********************************************************************//
  IaqLaunchProvider = interface(IUnknown)
    ['{77DC4EB9-7127-4CFA-A831-31ED94082DAC}']
    function Get_IsStarted: WordBool; safecall;
    function Get_IsSuspended: WordBool; safecall;
    procedure Terminate; safecall;
    procedure CancelProfiling; safecall;
    procedure Suspend; safecall;
    procedure Resume; safecall;
    procedure Detach; safecall;
    property IsStarted: WordBool read Get_IsStarted;
    property IsSuspended: WordBool read Get_IsSuspended;
  end;

// *********************************************************************//
// Interface: IaqResultsProvider
// Flags:     (0)
// GUID:      {4C31630D-8632-42C8-991B-469B50995195}
// *********************************************************************//
  IaqResultsProvider = interface(IUnknown)
    ['{4C31630D-8632-42C8-991B-469B50995195}']
    procedure SaveResults(const ResultStore: IaqResult); safecall;
    procedure LoadResults(const ResultStore: IaqResult; const ResultNode: IaqResultNode); safecall;
    procedure ActivateResultNode(const ResultNode: IaqResultNode); safecall;
    function ConvertResultToMetaProvider(const ResultStore: IaqResult; 
                                         const ResultNode: IaqResultNode): IaqMetaProvider; safecall;
  end;

// *********************************************************************//
// Interface: IaqCompactResultsProvider
// Flags:     (0)
// GUID:      {51E14FA7-D190-4866-A31D-04DD640A6D3E}
// *********************************************************************//
  IaqCompactResultsProvider = interface(IUnknown)
    ['{51E14FA7-D190-4866-A31D-04DD640A6D3E}']
    function Get_ResultCount: Integer; safecall;
    function Get_ResultTypes(Index: Integer): WideString; safecall;
    function Get_ResultValues(Index: Integer): OleVariant; safecall;
    property ResultCount: Integer read Get_ResultCount;
    property ResultTypes[Index: Integer]: WideString read Get_ResultTypes;
    property ResultValues[Index: Integer]: OleVariant read Get_ResultValues;
  end;

// *********************************************************************//
// Interface: IaqMergeProvider
// Flags:     (0)
// GUID:      {9610990C-5146-436E-AC85-C2753ACD94CF}
// *********************************************************************//
  IaqMergeProvider = interface(IUnknown)
    ['{9610990C-5146-436E-AC85-C2753ACD94CF}']
    procedure MergeResults(Count: Integer; Results: OleVariant); safecall;
    function Get_MergeSettings: IaqSettings_DVS; safecall;
    procedure ApplyMergeSettings; safecall;
    property MergeSettings: IaqSettings_DVS read Get_MergeSettings;
  end;

// *********************************************************************//
// Interface: IaqCompareProvider
// Flags:     (0)
// GUID:      {6E7B5843-662B-40FE-BB80-833AD735A7C6}
// *********************************************************************//
  IaqCompareProvider = interface(IUnknown)
    ['{6E7B5843-662B-40FE-BB80-833AD735A7C6}']
    procedure CompareResults(Count: Integer; Results: OleVariant; ResultNodes: OleVariant); safecall;
  end;

// *********************************************************************//
// Interface: IaqResultsThreadRenamer
// Flags:     (0)
// GUID:      {475009FA-E9FD-46A3-B636-BD2452FB8C6B}
// *********************************************************************//
  IaqResultsThreadRenamer = interface
    ['{475009FA-E9FD-46A3-B636-BD2452FB8C6B}']
    procedure RenameThread(const ResultStore: IaqResult; const OldThreadCaption: WideString; 
                           const NewThreadCaption: WideString); safecall;
  end;

// *********************************************************************//
// Interface: IaqProfilersManagerExtender
// Flags:     (0)
// GUID:      {617938D3-110E-45FD-9381-D4F2EC7DDBAF}
// *********************************************************************//
  IaqProfilersManagerExtender = interface(IUnknown)
    ['{617938D3-110E-45FD-9381-D4F2EC7DDBAF}']
    function CanStartCurrentProfiler: WordBool; safecall;
  end;

// *********************************************************************//
// Interface: IaqProfilerEvent
// Flags:     (0)
// GUID:      {605469B4-C681-49EA-958D-E67D6BB8A66F}
// *********************************************************************//
  IaqProfilerEvent = interface(IaqBaseEvent)
    ['{605469B4-C681-49EA-958D-E67D6BB8A66F}']
    procedure OnProfilerEvent(Event: AQ_PROFILER_EVENT; const Profiler: IaqBaseProfiler); safecall;
  end;

// *********************************************************************//
// Interface: IaqNormalRunMode
// Flags:     (320) Dual OleAutomation
// GUID:      {AB17D974-3482-45FE-A84E-A4686A1020F4}
// *********************************************************************//
  IaqNormalRunMode = interface(IaqRunMode)
    ['{AB17D974-3482-45FE-A84E-A4686A1020F4}']
  end;

// *********************************************************************//
// DispIntf:  IaqNormalRunModeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {AB17D974-3482-45FE-A84E-A4686A1020F4}
// *********************************************************************//
  IaqNormalRunModeDisp = dispinterface
    ['{AB17D974-3482-45FE-A84E-A4686A1020F4}']
    function GetName: WideString; dispid 1610743808;
    function PrepareRun(StartOperation: AQ_PROFILER_START_OPERATION): WordBool; dispid 1610743809;
    function Run(const pProfiler: IaqDynamicProfiler; const Listener: IaqDebugListener): WordBool; dispid 1610743810;
    function IsAttachSupported: WordBool; dispid 1610743811;
    function Attach(ProcessID: LongWord; const pProfiler: IaqDynamicProfiler; 
                    const Listener: IaqDebugListener): WordBool; dispid 1610743812;
    procedure RunFailed; dispid 1610743813;
    function GetParameterCount: Integer; dispid 1610743814;
    procedure GetParameter(Index: Integer; out ParamName: WideString; out ParamValue: OleVariant); dispid 1610743815;
    procedure SetParameter(Index: Integer; Value: OleVariant); dispid 1610743816;
    function ConfigureParameters: WordBool; dispid 1610743817;
    procedure GetSettings(out Value: IaqSettings_DVS); dispid 1610743818;
    function GetKey: {??TGUID}OleVariant; dispid 1610678272;
  end;

// *********************************************************************//
// Interface: IaqCOMRunMode
// Flags:     (320) Dual OleAutomation
// GUID:      {DC75CD58-EA42-4D9E-AC19-F4EAA68CECD8}
// *********************************************************************//
  IaqCOMRunMode = interface(IaqRunMode)
    ['{DC75CD58-EA42-4D9E-AC19-F4EAA68CECD8}']
  end;

// *********************************************************************//
// DispIntf:  IaqCOMRunModeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {DC75CD58-EA42-4D9E-AC19-F4EAA68CECD8}
// *********************************************************************//
  IaqCOMRunModeDisp = dispinterface
    ['{DC75CD58-EA42-4D9E-AC19-F4EAA68CECD8}']
    function GetName: WideString; dispid 1610743808;
    function PrepareRun(StartOperation: AQ_PROFILER_START_OPERATION): WordBool; dispid 1610743809;
    function Run(const pProfiler: IaqDynamicProfiler; const Listener: IaqDebugListener): WordBool; dispid 1610743810;
    function IsAttachSupported: WordBool; dispid 1610743811;
    function Attach(ProcessID: LongWord; const pProfiler: IaqDynamicProfiler; 
                    const Listener: IaqDebugListener): WordBool; dispid 1610743812;
    procedure RunFailed; dispid 1610743813;
    function GetParameterCount: Integer; dispid 1610743814;
    procedure GetParameter(Index: Integer; out ParamName: WideString; out ParamValue: OleVariant); dispid 1610743815;
    procedure SetParameter(Index: Integer; Value: OleVariant); dispid 1610743816;
    function ConfigureParameters: WordBool; dispid 1610743817;
    procedure GetSettings(out Value: IaqSettings_DVS); dispid 1610743818;
    function GetKey: {??TGUID}OleVariant; dispid 1610678272;
  end;

// *********************************************************************//
// Interface: IaqASPNETRunMode
// Flags:     (320) Dual OleAutomation
// GUID:      {02AB9751-AB0A-4A7D-80ED-05DFA8325830}
// *********************************************************************//
  IaqASPNETRunMode = interface(IaqRunMode)
    ['{02AB9751-AB0A-4A7D-80ED-05DFA8325830}']
  end;

// *********************************************************************//
// DispIntf:  IaqASPNETRunModeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {02AB9751-AB0A-4A7D-80ED-05DFA8325830}
// *********************************************************************//
  IaqASPNETRunModeDisp = dispinterface
    ['{02AB9751-AB0A-4A7D-80ED-05DFA8325830}']
    function GetName: WideString; dispid 1610743808;
    function PrepareRun(StartOperation: AQ_PROFILER_START_OPERATION): WordBool; dispid 1610743809;
    function Run(const pProfiler: IaqDynamicProfiler; const Listener: IaqDebugListener): WordBool; dispid 1610743810;
    function IsAttachSupported: WordBool; dispid 1610743811;
    function Attach(ProcessID: LongWord; const pProfiler: IaqDynamicProfiler; 
                    const Listener: IaqDebugListener): WordBool; dispid 1610743812;
    procedure RunFailed; dispid 1610743813;
    function GetParameterCount: Integer; dispid 1610743814;
    procedure GetParameter(Index: Integer; out ParamName: WideString; out ParamValue: OleVariant); dispid 1610743815;
    procedure SetParameter(Index: Integer; Value: OleVariant); dispid 1610743816;
    function ConfigureParameters: WordBool; dispid 1610743817;
    procedure GetSettings(out Value: IaqSettings_DVS); dispid 1610743818;
    function GetKey: {??TGUID}OleVariant; dispid 1610678272;
  end;

// *********************************************************************//
// Interface: IaqServiceRunMode
// Flags:     (320) Dual OleAutomation
// GUID:      {7B6142C2-87EA-40C7-87AE-87973CFD73BB}
// *********************************************************************//
  IaqServiceRunMode = interface(IaqRunMode)
    ['{7B6142C2-87EA-40C7-87AE-87973CFD73BB}']
  end;

// *********************************************************************//
// DispIntf:  IaqServiceRunModeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {7B6142C2-87EA-40C7-87AE-87973CFD73BB}
// *********************************************************************//
  IaqServiceRunModeDisp = dispinterface
    ['{7B6142C2-87EA-40C7-87AE-87973CFD73BB}']
    function GetName: WideString; dispid 1610743808;
    function PrepareRun(StartOperation: AQ_PROFILER_START_OPERATION): WordBool; dispid 1610743809;
    function Run(const pProfiler: IaqDynamicProfiler; const Listener: IaqDebugListener): WordBool; dispid 1610743810;
    function IsAttachSupported: WordBool; dispid 1610743811;
    function Attach(ProcessID: LongWord; const pProfiler: IaqDynamicProfiler; 
                    const Listener: IaqDebugListener): WordBool; dispid 1610743812;
    procedure RunFailed; dispid 1610743813;
    function GetParameterCount: Integer; dispid 1610743814;
    procedure GetParameter(Index: Integer; out ParamName: WideString; out ParamValue: OleVariant); dispid 1610743815;
    procedure SetParameter(Index: Integer; Value: OleVariant); dispid 1610743816;
    function ConfigureParameters: WordBool; dispid 1610743817;
    procedure GetSettings(out Value: IaqSettings_DVS); dispid 1610743818;
    function GetKey: {??TGUID}OleVariant; dispid 1610678272;
  end;

// *********************************************************************//
// Interface: IaqIISAppRunMode
// Flags:     (320) Dual OleAutomation
// GUID:      {6B184049-7169-42A8-AB89-DCF86B925250}
// *********************************************************************//
  IaqIISAppRunMode = interface(IaqRunMode)
    ['{6B184049-7169-42A8-AB89-DCF86B925250}']
  end;

// *********************************************************************//
// DispIntf:  IaqIISAppRunModeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {6B184049-7169-42A8-AB89-DCF86B925250}
// *********************************************************************//
  IaqIISAppRunModeDisp = dispinterface
    ['{6B184049-7169-42A8-AB89-DCF86B925250}']
    function GetName: WideString; dispid 1610743808;
    function PrepareRun(StartOperation: AQ_PROFILER_START_OPERATION): WordBool; dispid 1610743809;
    function Run(const pProfiler: IaqDynamicProfiler; const Listener: IaqDebugListener): WordBool; dispid 1610743810;
    function IsAttachSupported: WordBool; dispid 1610743811;
    function Attach(ProcessID: LongWord; const pProfiler: IaqDynamicProfiler; 
                    const Listener: IaqDebugListener): WordBool; dispid 1610743812;
    procedure RunFailed; dispid 1610743813;
    function GetParameterCount: Integer; dispid 1610743814;
    procedure GetParameter(Index: Integer; out ParamName: WideString; out ParamValue: OleVariant); dispid 1610743815;
    procedure SetParameter(Index: Integer; Value: OleVariant); dispid 1610743816;
    function ConfigureParameters: WordBool; dispid 1610743817;
    procedure GetSettings(out Value: IaqSettings_DVS); dispid 1610743818;
    function GetKey: {??TGUID}OleVariant; dispid 1610678272;
  end;

// *********************************************************************//
// Interface: IaqDebuggerEvent
// Flags:     (0)
// GUID:      {491F4B23-08AA-4384-ABDD-68AC52EFBDFB}
// *********************************************************************//
  IaqDebuggerEvent = interface(IaqBaseEvent)
    ['{491F4B23-08AA-4384-ABDD-68AC52EFBDFB}']
    procedure OnCreateProcess(const pProcess: IaqDebugProcess); safecall;
    procedure OnTerminateProcess(const pProcess: IaqDebugProcess; IsKilled: WordBool); safecall;
    procedure OnResumeProcess(const pProcess: IaqDebugProcess); safecall;
    procedure OnSuspendProcess(const pProcess: IaqDebugProcess); safecall;
    procedure OnDetachFromProcess(const pProcess: IaqDebugProcess); safecall;
    procedure OnLoadModule(const pModule: IaqDebugModule); safecall;
    procedure OnUnloadModule(const pModule: IaqDebugModule); safecall;
    procedure OnModuleStarted(const pModule: IaqDebugModule); safecall;
    procedure OnCreateThead(const pThread: IaqDebugThread); safecall;
    procedure OnExitThread(const pThread: IaqDebugThread); safecall;
    procedure OnDebugString(const str: IaqDebugString); safecall;
    procedure OnOutputDebugStringCalled(const str: IaqDebugString); safecall;
    procedure OnException(const pException: IaqDebugException); safecall;
    procedure OnInjectDll; safecall;
    procedure OnBreakpoint(const pBreakPoint: IaqDebugBreakpoint); safecall;
    procedure OnUserBreakpoint(const pBreakPoint: IaqBreakpoint); safecall;
  end;

// *********************************************************************//
// Interface: IaqDebuggerEventEx
// Flags:     (0)
// GUID:      {08614A4B-F62E-4EAA-82C8-F96346B64C5A}
// *********************************************************************//
  IaqDebuggerEventEx = interface(IaqBaseEvent)
    ['{08614A4B-F62E-4EAA-82C8-F96346B64C5A}']
    procedure OnDiscard(const pProcess: IaqDebugProcess); safecall;
  end;

// *********************************************************************//
// Interface: IaqClrDebuggerEvent
// Flags:     (0)
// GUID:      {D90A494B-810C-4AFB-98C5-EEA7BEE5C6A1}
// *********************************************************************//
  IaqClrDebuggerEvent = interface(IaqBaseEvent)
    ['{D90A494B-810C-4AFB-98C5-EEA7BEE5C6A1}']
    procedure OnCreateAppDomain(const pDomain: IaqClrDebugAppDomain); safecall;
    procedure OnExitAppDomain(const pDomain: IaqClrDebugAppDomain); safecall;
    procedure OnLoadAssembly(const pAssembly: IaqClrDebugAssembly); safecall;
    procedure OnUnloadAssembly(const pAssembly: IaqClrDebugAssembly); safecall;
    procedure OnLoadClrModule(const pModule: IaqClrDebugModule); safecall;
    procedure OnUnloadClrModule(const pModule: IaqClrDebugModule); safecall;
    procedure OnClrException(const pException: IaqClrDebugException); safecall;
  end;

// *********************************************************************//
// Interface: IaqModuleCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AFE2DF72-81A7-4794-A92A-2E32AE1A81B0}
// *********************************************************************//
  IaqModuleCollection = interface(IDispatch)
    ['{AFE2DF72-81A7-4794-A92A-2E32AE1A81B0}']
    function Get_Count: Integer; safecall;
    function Get_Modules(Index: Integer): IaqModule; safecall;
    function Get_ModuleByName(const ModuleName: WideString): IaqModule; safecall;
    function Add(const FileName: WideString): IaqModule; safecall;
    function Remove(const ModuleName: WideString): WordBool; safecall;
    procedure Set_ActiveModule(const Module: IaqModule); safecall;
    function Get_ActiveModule: IaqModule; safecall;
    property Count: Integer read Get_Count;
    property Modules[Index: Integer]: IaqModule read Get_Modules;
    property ModuleByName[const ModuleName: WideString]: IaqModule read Get_ModuleByName;
    property ActiveModule: IaqModule read Get_ActiveModule write Set_ActiveModule;
  end;

// *********************************************************************//
// DispIntf:  IaqModuleCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AFE2DF72-81A7-4794-A92A-2E32AE1A81B0}
// *********************************************************************//
  IaqModuleCollectionDisp = dispinterface
    ['{AFE2DF72-81A7-4794-A92A-2E32AE1A81B0}']
    property Count: Integer readonly dispid 16826372;
    property Modules[Index: Integer]: IaqModule readonly dispid 16826373;
    property ModuleByName[const ModuleName: WideString]: IaqModule readonly dispid 16826374;
    function Add(const FileName: WideString): IaqModule; dispid 16826375;
    function Remove(const ModuleName: WideString): WordBool; dispid 16826376;
    property ActiveModule: IaqModule dispid 16826377;
  end;

// *********************************************************************//
// Interface: IaqModule
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B4F9B3D9-1A1F-4D80-A975-009242138DC7}
// *********************************************************************//
  IaqModule = interface(IDispatch)
    ['{B4F9B3D9-1A1F-4D80-A975-009242138DC7}']
    function Get_SymbolStoreCount: Integer; safecall;
    function Get_SymbolStore(Index: Integer): IaqDbgSymbolStore; safecall;
    function Get_FullFileName: WideString; safecall;
    function Get_Available: WordBool; safecall;
    function Get_Active: WordBool; safecall;
    property SymbolStoreCount: Integer read Get_SymbolStoreCount;
    property SymbolStore[Index: Integer]: IaqDbgSymbolStore read Get_SymbolStore;
    property FullFileName: WideString read Get_FullFileName;
    property Available: WordBool read Get_Available;
    property Active: WordBool read Get_Active;
  end;

// *********************************************************************//
// DispIntf:  IaqModuleDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B4F9B3D9-1A1F-4D80-A975-009242138DC7}
// *********************************************************************//
  IaqModuleDisp = dispinterface
    ['{B4F9B3D9-1A1F-4D80-A975-009242138DC7}']
    property SymbolStoreCount: Integer readonly dispid 16814081;
    property SymbolStore[Index: Integer]: IaqDbgSymbolStore readonly dispid 16814082;
    property FullFileName: WideString readonly dispid 16814083;
    property Available: WordBool readonly dispid 16814084;
    property Active: WordBool readonly dispid 16814085;
  end;

// *********************************************************************//
// Interface: IaqProjectEvent
// Flags:     (0)
// GUID:      {9C959502-B8AD-11D2-9C23-0020781423AC}
// *********************************************************************//
  IaqProjectEvent = interface(IaqBaseEvent)
    ['{9C959502-B8AD-11D2-9C23-0020781423AC}']
    procedure OnProjectStartLoading(const AProjectName: WideString); safecall;
    procedure OnProjectLoaded; safecall;
    procedure OnDebugSymbolsRead(const Module: IaqModule); safecall;
    procedure OnDebugSymbolsRefreshed; safecall;
    procedure OnModuleAdded(const Module: IaqModule); safecall;
    procedure OnModuleRemoved(const Module: IaqModule); safecall;
    procedure OnModuleActivate(const Module: IaqModule); safecall;
    procedure OnProjectClosed; safecall;
  end;

// *********************************************************************//
// Interface: IaqProjectManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {30E68CAF-A6ED-41F8-818C-C86193AE18C9}
// *********************************************************************//
  IaqProjectManager = interface(IaqSubsystemManager)
    ['{30E68CAF-A6ED-41F8-818C-C86193AE18C9}']
    function OpenProject(const AProjectFileName: WideString): WordBool; safecall;
    function OpenFile(const AFileName: WideString): WordBool; safecall;
    function CreateEmptyProject: WordBool; safecall;
    function Get_CanClose: WordBool; safecall;
    procedure Save(out fCancelled: WordBool); safecall;
    procedure SaveAs(const AProjectFileName: WideString; out fCancelled: WordBool); safecall;
    function Close(fNoSave: WordBool): WordBool; safecall;
    function Get_IsOpen: WordBool; safecall;
    function Get_Modified: WordBool; safecall;
    function Get_RecentProjectCount: Integer; safecall;
    function Get_RecentProjects(Index: Integer): WideString; safecall;
    function Get_ModuleCollection: IaqModuleCollection; safecall;
    property CanClose: WordBool read Get_CanClose;
    property IsOpen: WordBool read Get_IsOpen;
    property Modified: WordBool read Get_Modified;
    property RecentProjectCount: Integer read Get_RecentProjectCount;
    property RecentProjects[Index: Integer]: WideString read Get_RecentProjects;
    property ModuleCollection: IaqModuleCollection read Get_ModuleCollection;
  end;

// *********************************************************************//
// DispIntf:  IaqProjectManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {30E68CAF-A6ED-41F8-818C-C86193AE18C9}
// *********************************************************************//
  IaqProjectManagerDisp = dispinterface
    ['{30E68CAF-A6ED-41F8-818C-C86193AE18C9}']
    function OpenProject(const AProjectFileName: WideString): WordBool; dispid 16826369;
    function OpenFile(const AFileName: WideString): WordBool; dispid 16826370;
    function CreateEmptyProject: WordBool; dispid 16826371;
    property CanClose: WordBool readonly dispid 16826372;
    procedure Save(out fCancelled: WordBool); dispid 16826373;
    procedure SaveAs(const AProjectFileName: WideString; out fCancelled: WordBool); dispid 16826374;
    function Close(fNoSave: WordBool): WordBool; dispid 16826375;
    property IsOpen: WordBool readonly dispid 16826376;
    property Modified: WordBool readonly dispid 16826377;
    property RecentProjectCount: Integer readonly dispid 16826378;
    property RecentProjects[Index: Integer]: WideString readonly dispid 16826379;
    property ModuleCollection: IaqModuleCollection readonly dispid 16826380;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqSetupEvent
// Flags:     (0)
// GUID:      {6C20055F-42FE-433F-A455-589E2FBE867C}
// *********************************************************************//
  IaqSetupEvent = interface(IaqBaseEvent)
    ['{6C20055F-42FE-433F-A455-589E2FBE867C}']
    procedure OnChange; safecall;
  end;

// *********************************************************************//
// Interface: IaqSetupElement
// Flags:     (320) Dual OleAutomation
// GUID:      {F333912E-050A-42FD-8C08-7E846B7C015F}
// *********************************************************************//
  IaqSetupElement = interface(IUnknown)
    ['{F333912E-050A-42FD-8C08-7E846B7C015F}']
    procedure Add(const Value: IUnknown); safecall;
    procedure Remove(ItemKey: TGUID); safecall;
    function Get_Count: Integer; safecall;
    function Get_Items(Index: Integer): IUnknown; safecall;
    procedure Clear; safecall;
    function Get_Selected: TSelection; safecall;
    procedure Set_Selected(Value: TSelection); safecall;
    function GetItemSelected(ItemKey: TGUID): WordBool; safecall;
    procedure SetItemSelected(ItemKey: TGUID; Value: WordBool); safecall;
    function Get_ItemSelectedByIndex(Index: Integer): WordBool; safecall;
    procedure Set_ItemSelectedByIndex(Index: Integer; Value: WordBool); safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Value: WideString); safecall;
    function Get_ItemKey(Index: Integer): TGUID; safecall;
    function Get_ItemCaption(ItemKey: TGUID): WideString; safecall;
    property Count: Integer read Get_Count;
    property Items[Index: Integer]: IUnknown read Get_Items;
    property Selected: TSelection read Get_Selected write Set_Selected;
    property ItemSelectedByIndex[Index: Integer]: WordBool read Get_ItemSelectedByIndex write Set_ItemSelectedByIndex;
    property Name: WideString read Get_Name write Set_Name;
    property ItemKey[Index: Integer]: TGUID read Get_ItemKey;
    property ItemCaption[ItemKey: TGUID]: WideString read Get_ItemCaption;
  end;

// *********************************************************************//
// DispIntf:  IaqSetupElementDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {F333912E-050A-42FD-8C08-7E846B7C015F}
// *********************************************************************//
  IaqSetupElementDisp = dispinterface
    ['{F333912E-050A-42FD-8C08-7E846B7C015F}']
    procedure Add(const Value: IUnknown); dispid 1610678272;
    procedure Remove(ItemKey: {??TGUID}OleVariant); dispid 1610678273;
    property Count: Integer readonly dispid 1610678274;
    property Items[Index: Integer]: IUnknown readonly dispid 1610678275;
    procedure Clear; dispid 1610678276;
    property Selected: TSelection dispid 1;
    function GetItemSelected(ItemKey: {??TGUID}OleVariant): WordBool; dispid 1610678279;
    procedure SetItemSelected(ItemKey: {??TGUID}OleVariant; Value: WordBool); dispid 1610678280;
    property ItemSelectedByIndex[Index: Integer]: WordBool dispid 3;
    property Name: WideString dispid 4;
    property ItemKey[Index: Integer]: {??TGUID}OleVariant readonly dispid 1610678285;
    property ItemCaption[ItemKey: {??TGUID}OleVariant]: WideString readonly dispid 1610678286;
  end;

// *********************************************************************//
// Interface: IaqSetupTrigger
// Flags:     (320) Dual OleAutomation
// GUID:      {72C09691-BFCD-40A6-8BF8-32B326A4585C}
// *********************************************************************//
  IaqSetupTrigger = interface(IaqSetupElement)
    ['{72C09691-BFCD-40A6-8BF8-32B326A4585C}']
    function Get_TriggerType: TTriggerType; safecall;
    procedure Set_TriggerType(Value: TTriggerType); safecall;
    function Get_PassCount: Integer; safecall;
    procedure Set_PassCount(Value: Integer); safecall;
    function Get_WorkCount: Integer; safecall;
    procedure Set_WorkCount(Value: Integer); safecall;
    function Get_Cycling: WordBool; safecall;
    procedure Set_Cycling(Value: WordBool); safecall;
    function Get_Global: WordBool; safecall;
    procedure Set_Global(Value: WordBool); safecall;
    property TriggerType: TTriggerType read Get_TriggerType write Set_TriggerType;
    property PassCount: Integer read Get_PassCount write Set_PassCount;
    property WorkCount: Integer read Get_WorkCount write Set_WorkCount;
    property Cycling: WordBool read Get_Cycling write Set_Cycling;
    property Global: WordBool read Get_Global write Set_Global;
  end;

// *********************************************************************//
// DispIntf:  IaqSetupTriggerDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {72C09691-BFCD-40A6-8BF8-32B326A4585C}
// *********************************************************************//
  IaqSetupTriggerDisp = dispinterface
    ['{72C09691-BFCD-40A6-8BF8-32B326A4585C}']
    property TriggerType: TTriggerType dispid 5;
    property PassCount: Integer dispid 6;
    property WorkCount: Integer dispid 7;
    property Cycling: WordBool dispid 8;
    property Global: WordBool dispid 9;
    procedure Add(const Value: IUnknown); dispid 1610678272;
    procedure Remove(ItemKey: {??TGUID}OleVariant); dispid 1610678273;
    property Count: Integer readonly dispid 1610678274;
    property Items[Index: Integer]: IUnknown readonly dispid 1610678275;
    procedure Clear; dispid 1610678276;
    property Selected: TSelection dispid 1;
    function GetItemSelected(ItemKey: {??TGUID}OleVariant): WordBool; dispid 1610678279;
    procedure SetItemSelected(ItemKey: {??TGUID}OleVariant; Value: WordBool); dispid 1610678280;
    property ItemSelectedByIndex[Index: Integer]: WordBool dispid 3;
    property Name: WideString dispid 4;
    property ItemKey[Index: Integer]: {??TGUID}OleVariant readonly dispid 1610678285;
    property ItemCaption[ItemKey: {??TGUID}OleVariant]: WideString readonly dispid 1610678286;
  end;

// *********************************************************************//
// Interface: IaqSetupArea
// Flags:     (320) Dual OleAutomation
// GUID:      {07F2E96B-93CA-49A0-BF3D-72E74B92731B}
// *********************************************************************//
  IaqSetupArea = interface(IaqSetupElement)
    ['{07F2E96B-93CA-49A0-BF3D-72E74B92731B}']
    function Get_AreaType: TAreaType; safecall;
    procedure Set_AreaType(Value: TAreaType); safecall;
    function Get_AreaLevel: TProfileLevel; safecall;
    procedure Set_AreaLevel(Value: TProfileLevel); safecall;
    function Get_RetrieveParameterValues: WordBool; safecall;
    procedure Set_RetrieveParameterValues(Value: WordBool); safecall;
    property AreaType: TAreaType read Get_AreaType write Set_AreaType;
    property AreaLevel: TProfileLevel read Get_AreaLevel write Set_AreaLevel;
    property RetrieveParameterValues: WordBool read Get_RetrieveParameterValues write Set_RetrieveParameterValues;
  end;

// *********************************************************************//
// DispIntf:  IaqSetupAreaDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {07F2E96B-93CA-49A0-BF3D-72E74B92731B}
// *********************************************************************//
  IaqSetupAreaDisp = dispinterface
    ['{07F2E96B-93CA-49A0-BF3D-72E74B92731B}']
    property AreaType: TAreaType dispid 5;
    property AreaLevel: TProfileLevel dispid 6;
    property RetrieveParameterValues: WordBool dispid 7;
    procedure Add(const Value: IUnknown); dispid 1610678272;
    procedure Remove(ItemKey: {??TGUID}OleVariant); dispid 1610678273;
    property Count: Integer readonly dispid 1610678274;
    property Items[Index: Integer]: IUnknown readonly dispid 1610678275;
    procedure Clear; dispid 1610678276;
    property Selected: TSelection dispid 1;
    function GetItemSelected(ItemKey: {??TGUID}OleVariant): WordBool; dispid 1610678279;
    procedure SetItemSelected(ItemKey: {??TGUID}OleVariant; Value: WordBool); dispid 1610678280;
    property ItemSelectedByIndex[Index: Integer]: WordBool dispid 3;
    property Name: WideString dispid 4;
    property ItemKey[Index: Integer]: {??TGUID}OleVariant readonly dispid 1610678285;
    property ItemCaption[ItemKey: {??TGUID}OleVariant]: WideString readonly dispid 1610678286;
  end;

// *********************************************************************//
// Interface: IaqSetupAction
// Flags:     (320) Dual OleAutomation
// GUID:      {3156CFBC-08F5-4EE0-9AF5-5B85B1055A13}
// *********************************************************************//
  IaqSetupAction = interface(IaqSetupElement)
    ['{3156CFBC-08F5-4EE0-9AF5-5B85B1055A13}']
    function Get_ActionType: TActionType; safecall;
    procedure Set_ActionType(Value: TActionType); safecall;
    function Get_ExecuteType: TExecuteType; safecall;
    procedure Set_ExecuteType(Value: TExecuteType); safecall;
    property ActionType: TActionType read Get_ActionType write Set_ActionType;
    property ExecuteType: TExecuteType read Get_ExecuteType write Set_ExecuteType;
  end;

// *********************************************************************//
// DispIntf:  IaqSetupActionDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {3156CFBC-08F5-4EE0-9AF5-5B85B1055A13}
// *********************************************************************//
  IaqSetupActionDisp = dispinterface
    ['{3156CFBC-08F5-4EE0-9AF5-5B85B1055A13}']
    property ActionType: TActionType dispid 5;
    property ExecuteType: TExecuteType dispid 6;
    procedure Add(const Value: IUnknown); dispid 1610678272;
    procedure Remove(ItemKey: {??TGUID}OleVariant); dispid 1610678273;
    property Count: Integer readonly dispid 1610678274;
    property Items[Index: Integer]: IUnknown readonly dispid 1610678275;
    procedure Clear; dispid 1610678276;
    property Selected: TSelection dispid 1;
    function GetItemSelected(ItemKey: {??TGUID}OleVariant): WordBool; dispid 1610678279;
    procedure SetItemSelected(ItemKey: {??TGUID}OleVariant; Value: WordBool); dispid 1610678280;
    property ItemSelectedByIndex[Index: Integer]: WordBool dispid 3;
    property Name: WideString dispid 4;
    property ItemKey[Index: Integer]: {??TGUID}OleVariant readonly dispid 1610678285;
    property ItemCaption[ItemKey: {??TGUID}OleVariant]: WideString readonly dispid 1610678286;
  end;

// *********************************************************************//
// Interface: IaqAreaItem
// Flags:     (320) Dual OleAutomation
// GUID:      {5B43AE76-5B1A-42D4-999A-329FF9D1CD00}
// *********************************************************************//
  IaqAreaItem = interface(IUnknown)
    ['{5B43AE76-5B1A-42D4-999A-329FF9D1CD00}']
    function Get_DbgSymbol: IaqDbgSymbol; safecall;
    function Get_ChildItemCount: Integer; safecall;
    function Get_ChildItems(Index: Integer): IaqAreaItem; safecall;
    function Get_CustomData: UINT_PTR; safecall;
    procedure Set_CustomData(Value: UINT_PTR); safecall;
    function Get_ItemOptions: TaqAreaItemOptions; safecall;
    function Get_Parent: IaqAreaItem; safecall;
    property DbgSymbol: IaqDbgSymbol read Get_DbgSymbol;
    property ChildItemCount: Integer read Get_ChildItemCount;
    property ChildItems[Index: Integer]: IaqAreaItem read Get_ChildItems;
    property CustomData: UINT_PTR read Get_CustomData write Set_CustomData;
    property ItemOptions: TaqAreaItemOptions read Get_ItemOptions;
    property Parent: IaqAreaItem read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  IaqAreaItemDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5B43AE76-5B1A-42D4-999A-329FF9D1CD00}
// *********************************************************************//
  IaqAreaItemDisp = dispinterface
    ['{5B43AE76-5B1A-42D4-999A-329FF9D1CD00}']
    property DbgSymbol: IaqDbgSymbol readonly dispid 1610678272;
    property ChildItemCount: Integer readonly dispid 1610678273;
    property ChildItems[Index: Integer]: IaqAreaItem readonly dispid 1610678274;
    property CustomData: UINT_PTR dispid 1;
    property ItemOptions: TaqAreaItemOptions readonly dispid 1610678277;
    property Parent: IaqAreaItem readonly dispid 1610678278;
  end;

// *********************************************************************//
// Interface: IaqAreaTriggerItem
// Flags:     (320) Dual OleAutomation
// GUID:      {A96D2058-BF34-47B2-8970-DBF73B46E762}
// *********************************************************************//
  IaqAreaTriggerItem = interface(IaqAreaItem)
    ['{A96D2058-BF34-47B2-8970-DBF73B46E762}']
    function Get_GetTriggerOptions: PAQ_TRIGGER_OPTIONS; safecall;
    property GetTriggerOptions: PAQ_TRIGGER_OPTIONS read Get_GetTriggerOptions;
  end;

// *********************************************************************//
// DispIntf:  IaqAreaTriggerItemDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {A96D2058-BF34-47B2-8970-DBF73B46E762}
// *********************************************************************//
  IaqAreaTriggerItemDisp = dispinterface
    ['{A96D2058-BF34-47B2-8970-DBF73B46E762}']
    property GetTriggerOptions: {??PAQ_TRIGGER_OPTIONS}OleVariant readonly dispid 1610743808;
    property DbgSymbol: IaqDbgSymbol readonly dispid 1610678272;
    property ChildItemCount: Integer readonly dispid 1610678273;
    property ChildItems[Index: Integer]: IaqAreaItem readonly dispid 1610678274;
    property CustomData: UINT_PTR dispid 1;
    property ItemOptions: TaqAreaItemOptions readonly dispid 1610678277;
    property Parent: IaqAreaItem readonly dispid 1610678278;
  end;

// *********************************************************************//
// Interface: IaqAreaActionItem
// Flags:     (320) Dual OleAutomation
// GUID:      {67626F67-897F-41D6-A6EE-B94C73EF5092}
// *********************************************************************//
  IaqAreaActionItem = interface(IaqAreaItem)
    ['{67626F67-897F-41D6-A6EE-B94C73EF5092}']
    function Get_GetActionOptions: PAQ_ACTION_OPTIONS; safecall;
    property GetActionOptions: PAQ_ACTION_OPTIONS read Get_GetActionOptions;
  end;

// *********************************************************************//
// DispIntf:  IaqAreaActionItemDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {67626F67-897F-41D6-A6EE-B94C73EF5092}
// *********************************************************************//
  IaqAreaActionItemDisp = dispinterface
    ['{67626F67-897F-41D6-A6EE-B94C73EF5092}']
    property GetActionOptions: {??PAQ_ACTION_OPTIONS}OleVariant readonly dispid 1610743808;
    property DbgSymbol: IaqDbgSymbol readonly dispid 1610678272;
    property ChildItemCount: Integer readonly dispid 1610678273;
    property ChildItems[Index: Integer]: IaqAreaItem readonly dispid 1610678274;
    property CustomData: UINT_PTR dispid 1;
    property ItemOptions: TaqAreaItemOptions readonly dispid 1610678277;
    property Parent: IaqAreaItem readonly dispid 1610678278;
  end;

// *********************************************************************//
// Interface: IaqSetupManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7915A720-2B02-4429-AE3F-06A1F85F5CF7}
// *********************************************************************//
  IaqSetupManager = interface(IaqSubsystemManager)
    ['{7915A720-2B02-4429-AE3F-06A1F85F5CF7}']
    function Get_FullCheck: WordBool; safecall;
    procedure Set_FullCheck(Value: WordBool); safecall;
    function Get_FullCheckLevel: TProfileLevel; safecall;
    procedure Set_FullCheckLevel(Value: TProfileLevel); safecall;
    function Get_ProfileAll: WordBool; safecall;
    procedure Set_ProfileAll(Value: WordBool); safecall;
    function Get_ProfileAllLevel: TProfileLevel; safecall;
    procedure Set_ProfileAllLevel(Value: TProfileLevel); safecall;
    function Get_EnableProfilingForThreads: WordBool; safecall;
    procedure Set_EnableProfilingForThreads(Value: WordBool); safecall;
    function Get_AreaCount: Integer; safecall;
    function Get_Areas(Index: Integer): IaqSetupArea; safecall;
    function AddArea(const AreaName: WideString; AreaType: TAreaType; AreaLevel: TProfileLevel): IaqSetupArea; safecall;
    procedure RemoveArea(const Area: IaqSetupArea); safecall;
    function GetAreaByName(const Name: WideString): IaqSetupArea; safecall;
    function Get_TriggerCount: Integer; safecall;
    function Get_Triggers(Index: Integer): IaqSetupTrigger; safecall;
    function AddTrigger(const Name: WideString; TriggerType: TTriggerType; PassCount: Integer; 
                        WorkCount: Integer; Cycling: WordBool; Global: WordBool): IaqSetupTrigger; safecall;
    procedure RemoveTrigger(const Trigger: IaqSetupTrigger); safecall;
    function GetTriggerByName(const Name: WideString): IaqSetupTrigger; safecall;
    function Get_ActionCount: Integer; safecall;
    function Get_Actions(Index: Integer): IaqSetupAction; safecall;
    function AddAction(const ActionName: WideString; ActionType: TActionType; 
                       ExecuteType: TExecuteType): IaqSetupAction; safecall;
    procedure RemoveAction(const Action: IaqSetupAction); safecall;
    function GetActionByName(const Name: WideString): IaqSetupAction; safecall;
    procedure ClearAreas; safecall;
    procedure ClearTriggers; safecall;
    procedure ClearActions; safecall;
    procedure Clear; safecall;
    procedure BeginUpdate; safecall;
    procedure EndUpdate; safecall;
    function Get_AutoSelectItems: WordBool; safecall;
    procedure Set_AutoSelectItems(Value: WordBool); safecall;
    function GetAreaItems(const Module: IaqModule; TypesCount: Integer; Types: UINT_PTR; 
                          out SupportedPlatform: AQ_PROFILE_PLATFORM_INFO): IaqAreaItem; safecall;
    function GetAllAreaItems(const Module: IaqModule; TypesCount: Integer; Types: UINT_PTR; 
                             out SupportedPlatform: AQ_PROFILE_PLATFORM_INFO): IaqAreaItem; safecall;
    function Get_ModificationAborted: WordBool; safecall;
    function Get_ProfileAllScript: WordBool; safecall;
    procedure Set_ProfileAllScript(Value: WordBool); safecall;
    function Get_ProfileAllScriptLevel: TProfileLevel; safecall;
    procedure Set_ProfileAllScriptLevel(Value: TProfileLevel); safecall;
    property FullCheck: WordBool read Get_FullCheck write Set_FullCheck;
    property FullCheckLevel: TProfileLevel read Get_FullCheckLevel write Set_FullCheckLevel;
    property ProfileAll: WordBool read Get_ProfileAll write Set_ProfileAll;
    property ProfileAllLevel: TProfileLevel read Get_ProfileAllLevel write Set_ProfileAllLevel;
    property EnableProfilingForThreads: WordBool read Get_EnableProfilingForThreads write Set_EnableProfilingForThreads;
    property AreaCount: Integer read Get_AreaCount;
    property Areas[Index: Integer]: IaqSetupArea read Get_Areas;
    property TriggerCount: Integer read Get_TriggerCount;
    property Triggers[Index: Integer]: IaqSetupTrigger read Get_Triggers;
    property ActionCount: Integer read Get_ActionCount;
    property Actions[Index: Integer]: IaqSetupAction read Get_Actions;
    property AutoSelectItems: WordBool read Get_AutoSelectItems write Set_AutoSelectItems;
    property ModificationAborted: WordBool read Get_ModificationAborted;
    property ProfileAllScript: WordBool read Get_ProfileAllScript write Set_ProfileAllScript;
    property ProfileAllScriptLevel: TProfileLevel read Get_ProfileAllScriptLevel write Set_ProfileAllScriptLevel;
  end;

// *********************************************************************//
// DispIntf:  IaqSetupManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7915A720-2B02-4429-AE3F-06A1F85F5CF7}
// *********************************************************************//
  IaqSetupManagerDisp = dispinterface
    ['{7915A720-2B02-4429-AE3F-06A1F85F5CF7}']
    property FullCheck: WordBool dispid 1;
    property FullCheckLevel: TProfileLevel dispid 2;
    property ProfileAll: WordBool dispid 3;
    property ProfileAllLevel: TProfileLevel dispid 4;
    property EnableProfilingForThreads: WordBool dispid 5;
    property AreaCount: Integer readonly dispid 1610809354;
    property Areas[Index: Integer]: IaqSetupArea readonly dispid 1610809355;
    function AddArea(const AreaName: WideString; AreaType: TAreaType; AreaLevel: TProfileLevel): IaqSetupArea; dispid 1610809356;
    procedure RemoveArea(const Area: IaqSetupArea); dispid 1610809357;
    function GetAreaByName(const Name: WideString): IaqSetupArea; dispid 1610809358;
    property TriggerCount: Integer readonly dispid 1610809359;
    property Triggers[Index: Integer]: IaqSetupTrigger readonly dispid 1610809360;
    function AddTrigger(const Name: WideString; TriggerType: TTriggerType; PassCount: Integer; 
                        WorkCount: Integer; Cycling: WordBool; Global: WordBool): IaqSetupTrigger; dispid 1610809361;
    procedure RemoveTrigger(const Trigger: IaqSetupTrigger); dispid 1610809362;
    function GetTriggerByName(const Name: WideString): IaqSetupTrigger; dispid 1610809363;
    property ActionCount: Integer readonly dispid 1610809364;
    property Actions[Index: Integer]: IaqSetupAction readonly dispid 1610809365;
    function AddAction(const ActionName: WideString; ActionType: TActionType; 
                       ExecuteType: TExecuteType): IaqSetupAction; dispid 1610809366;
    procedure RemoveAction(const Action: IaqSetupAction); dispid 1610809367;
    function GetActionByName(const Name: WideString): IaqSetupAction; dispid 1610809368;
    procedure ClearAreas; dispid 1610809369;
    procedure ClearTriggers; dispid 1610809370;
    procedure ClearActions; dispid 1610809371;
    procedure Clear; dispid 1610809372;
    procedure BeginUpdate; dispid 1610809373;
    procedure EndUpdate; dispid 1610809374;
    property AutoSelectItems: WordBool dispid 6;
    function GetAreaItems(const Module: IaqModule; TypesCount: Integer; Types: UINT_PTR; 
                          out SupportedPlatform: AQ_PROFILE_PLATFORM_INFO): IaqAreaItem; dispid 1610809377;
    function GetAllAreaItems(const Module: IaqModule; TypesCount: Integer; Types: UINT_PTR; 
                             out SupportedPlatform: AQ_PROFILE_PLATFORM_INFO): IaqAreaItem; dispid 1610809378;
    property ModificationAborted: WordBool readonly dispid 1610809379;
    property ProfileAllScript: WordBool dispid 7;
    property ProfileAllScriptLevel: TProfileLevel dispid 8;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqSearchFileManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7EA374F9-0DE9-410F-BC29-F103B8157581}
// *********************************************************************//
  IaqSearchFileManager = interface(IaqSubsystemManager)
    ['{7EA374F9-0DE9-410F-BC29-F103B8157581}']
    function ExpandFileName(const FileName: WideString; const BasePath: WideString; 
                            out ExpandedFileName: WideString; var ShowQuery: WordBool): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqSearchFileManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7EA374F9-0DE9-410F-BC29-F103B8157581}
// *********************************************************************//
  IaqSearchFileManagerDisp = dispinterface
    ['{7EA374F9-0DE9-410F-BC29-F103B8157581}']
    function ExpandFileName(const FileName: WideString; const BasePath: WideString; 
                            out ExpandedFileName: WideString; var ShowQuery: WordBool): WordBool; dispid 1610809344;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqSearchFileManagerEvent
// Flags:     (0)
// GUID:      {F7C7BF2F-5661-4D5B-B097-54DE059BC09F}
// *********************************************************************//
  IaqSearchFileManagerEvent = interface(IaqBaseEvent)
    ['{F7C7BF2F-5661-4D5B-B097-54DE059BC09F}']
    procedure OnSearchPathsChanged(ChangeFlags: AQ_SEARCH_PATH_CHANGE); safecall;
  end;

// *********************************************************************//
// Interface: IaqShowSymbolEvent
// Flags:     (0)
// GUID:      {85A54236-6A2B-4B09-B85B-A53835670F6A}
// *********************************************************************//
  IaqShowSymbolEvent = interface(IaqBaseEvent)
    ['{85A54236-6A2B-4B09-B85B-A53835670F6A}']
    procedure ShowSourceFile(const Symbol: IaqDbgSymbol; LineNo: Integer); safecall;
  end;

// *********************************************************************//
// Interface: IaqDisassemblerManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D3A2ED8C-5BF9-4569-8F84-0BE7CAD01A5F}
// *********************************************************************//
  IaqDisassemblerManager = interface(IaqSubsystemManager)
    ['{D3A2ED8C-5BF9-4569-8F84-0BE7CAD01A5F}']
    function Get_DisassemblerCount: Integer; safecall;
    function Get_Disasemblers(Index: Integer): IaqDisassembler; safecall;
    function GetModuleAnalyzer(const ModuleName: WideString): IaqModuleAnalyzer; safecall;
    function DisassembleSymbol(const Symbol: IaqDbgSymbol): IaqCodeDisassembler; safecall;
    property DisassemblerCount: Integer read Get_DisassemblerCount;
    property Disasemblers[Index: Integer]: IaqDisassembler read Get_Disasemblers;
  end;

// *********************************************************************//
// DispIntf:  IaqDisassemblerManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D3A2ED8C-5BF9-4569-8F84-0BE7CAD01A5F}
// *********************************************************************//
  IaqDisassemblerManagerDisp = dispinterface
    ['{D3A2ED8C-5BF9-4569-8F84-0BE7CAD01A5F}']
    property DisassemblerCount: Integer readonly dispid 1610809344;
    property Disasemblers[Index: Integer]: IaqDisassembler readonly dispid 1610809345;
    function GetModuleAnalyzer(const ModuleName: WideString): IaqModuleAnalyzer; dispid 1610809346;
    function DisassembleSymbol(const Symbol: IaqDbgSymbol): IaqCodeDisassembler; dispid 1610809347;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqDisassembler
// Flags:     (0)
// GUID:      {A8DA0E0F-FAE8-40D5-8475-05AFE4D2A880}
// *********************************************************************//
  IaqDisassembler = interface(IUnknown)
    ['{A8DA0E0F-FAE8-40D5-8475-05AFE4D2A880}']
    procedure Initialize(const BaseManager: IaqBaseManager); stdcall;
    procedure Finalize; stdcall;
    procedure GetName(out Value: WideString); stdcall;
    procedure GetSettingsGroupKey(out Value: TGUID); stdcall;
    procedure GetAnalyzerSchema(out Value: IaqTableDataSchema); stdcall;
    function GetModuleAnalyzer(const ModuleName: WideString; out Value: IaqModuleAnalyzer): LongBool; stdcall;
    procedure GetCodeDisassembler(const Symbol: IaqDbgSymbol; out Value: IaqCodeDisassembler); stdcall;
    procedure GetCodeDisassemblerBuffer(Buffer: VOID_PTR; Size: LongWord; 
                                        out Value: IaqCodeDisassembler); stdcall;
  end;

// *********************************************************************//
// Interface: IaqModuleAnalyzer
// Flags:     (0)
// GUID:      {F111E2C9-EBB3-450D-9560-8541934EAC1F}
// *********************************************************************//
  IaqModuleAnalyzer = interface(IUnknown)
    ['{F111E2C9-EBB3-450D-9560-8541934EAC1F}']
    function GetRoutineAnalyzer(const Symbol: IaqDbgSymbol; out Value: IaqRoutineAnalyzer): LongBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqRoutineAnalyzer
// Flags:     (0)
// GUID:      {5F1C6059-393A-459D-A8F3-46CE09007BCB}
// *********************************************************************//
  IaqRoutineAnalyzer = interface(IUnknown)
    ['{5F1C6059-393A-459D-A8F3-46CE09007BCB}']
    procedure GetDisassembler(out Value: IaqDisassembler); stdcall;
    procedure GetRoutineCharacteristic(Index: Integer; out Value: OleVariant); stdcall;
    function GetChildRoutinesCount: Integer; stdcall;
    procedure GetChildRoutine(Index: Integer; out Value: IaqDbgRoutine); stdcall;
  end;

// *********************************************************************//
// Interface: IaqCodeDisassembler
// Flags:     (0)
// GUID:      {2A8E19AD-5ACB-4217-A845-99335044AE56}
// *********************************************************************//
  IaqCodeDisassembler = interface(IaqTableDataProvider)
    ['{2A8E19AD-5ACB-4217-A845-99335044AE56}']
    procedure GetDisassemblerName(out Value: WideString); stdcall;
    procedure GetInstructionSet(out Value: WideString); stdcall;
    function GetCodeSize: Integer; stdcall;
    function GetSourceLineColumnIndex: Integer; stdcall;
    function GetMnemonicColumnIndex: Integer; stdcall;
    procedure GetInstructionDescription(RowIndex: Integer; out Value: WideString); stdcall;
    function GetTargetRow(RowIndex: Integer): Integer; stdcall;
    procedure GetTargetRoutine(RowIndex: Integer; out Routine: IaqDbgRoutine); stdcall;
    procedure GetColumnSummary(ColIndex: Integer; RowIndexFirst: Integer; RowIndexLast: Integer; 
                               out SummaryValue: WideString); stdcall;
  end;

// *********************************************************************//
// Interface: IaqComparingManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C10B910A-B5CA-4257-B054-870F38CD2B10}
// *********************************************************************//
  IaqComparingManager = interface(IaqSubsystemManager)
    ['{C10B910A-B5CA-4257-B054-870F38CD2B10}']
    function Compare(Count: Integer; Results: OleVariant; ResultNodes: OleVariant; 
                     MetaProviders: OleVariant): IaqMetaProvider; safecall;
    function Get_ComparedDataSchemaKey: TGUID; safecall;
    property ComparedDataSchemaKey: TGUID read Get_ComparedDataSchemaKey;
  end;

// *********************************************************************//
// DispIntf:  IaqComparingManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C10B910A-B5CA-4257-B054-870F38CD2B10}
// *********************************************************************//
  IaqComparingManagerDisp = dispinterface
    ['{C10B910A-B5CA-4257-B054-870F38CD2B10}']
    function Compare(Count: Integer; Results: OleVariant; ResultNodes: OleVariant; 
                     MetaProviders: OleVariant): IaqMetaProvider; dispid 1610809344;
    property ComparedDataSchemaKey: {??TGUID}OleVariant readonly dispid 1610809345;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqReportProvider_XXX
// Flags:     (0)
// GUID:      {8EC4FB9B-4B41-4755-978B-1C8F360B70A6}
// *********************************************************************//
  IaqReportProvider_XXX = interface(IaqDataTableProvider_XXX)
    ['{8EC4FB9B-4B41-4755-978B-1C8F360B70A6}']
  end;

// *********************************************************************//
// Interface: IaqNotePadProvider_XXX
// Flags:     (0)
// GUID:      {E57FEB1B-ACB6-47AE-AEEF-4095C5AD8CD7}
// *********************************************************************//
  IaqNotePadProvider_XXX = interface(IaqDataTextProvider_XXX)
    ['{E57FEB1B-ACB6-47AE-AEEF-4095C5AD8CD7}']
  end;

// *********************************************************************//
// Interface: IaqSummaryProvider_XXX
// Flags:     (0)
// GUID:      {D7AF58E1-F865-49FE-8296-758C8B992757}
// *********************************************************************//
  IaqSummaryProvider_XXX = interface(IaqDataTextProvider_XXX)
    ['{D7AF58E1-F865-49FE-8296-758C8B992757}']
  end;

// *********************************************************************//
// Interface: IaqCallGraphProvider_XXX
// Flags:     (0)
// GUID:      {34DFD10E-C46B-4C6F-8C0E-DF81575C334E}
// *********************************************************************//
  IaqCallGraphProvider_XXX = interface(IaqDataTableProvider_XXX)
    ['{34DFD10E-C46B-4C6F-8C0E-DF81575C334E}']
    function Get_ParentTable(RowIndex: Integer): IaqCallGraphProvider_XXX; safecall;
    function Get_ChildTable(RowIndex: Integer): IaqCallGraphProvider_XXX; safecall;
    function Get_Caption(RowIndex: Integer): WideString; safecall;
    property ParentTable[RowIndex: Integer]: IaqCallGraphProvider_XXX read Get_ParentTable;
    property ChildTable[RowIndex: Integer]: IaqCallGraphProvider_XXX read Get_ChildTable;
    property Caption[RowIndex: Integer]: WideString read Get_Caption;
  end;

// *********************************************************************//
// Interface: IaqGraphProvider_XXX
// Flags:     (0)
// GUID:      {7D7EDFA2-81A9-4F71-BE25-C290400C39B0}
// *********************************************************************//
  IaqGraphProvider_XXX = interface(IaqDataTableProvider_XXX)
    ['{7D7EDFA2-81A9-4F71-BE25-C290400C39B0}']
  end;

// *********************************************************************//
// Interface: IaqSourceFilesProvider_XXX
// Flags:     (0)
// GUID:      {D2C6C609-8E45-4875-9043-1516257119A3}
// *********************************************************************//
  IaqSourceFilesProvider_XXX = interface(IaqDataMonikerProvider_XXX)
    ['{D2C6C609-8E45-4875-9043-1516257119A3}']
    function Get_Count: Integer; safecall;
    function Get_FileName(FileIndex: Integer): WideString; safecall;
    function Get_SourceFileProvider(FileIndex: Integer): IaqSourceFileProvider_XXX; safecall;
    property Count: Integer read Get_Count;
    property FileName[FileIndex: Integer]: WideString read Get_FileName;
    property SourceFileProvider[FileIndex: Integer]: IaqSourceFileProvider_XXX read Get_SourceFileProvider;
  end;

// *********************************************************************//
// Interface: IaqSourceFileProvider_XXX
// Flags:     (0)
// GUID:      {DAA25EC5-24E7-4449-83D4-2048E5F20EC4}
// *********************************************************************//
  IaqSourceFileProvider_XXX = interface(IUnknown)
    ['{DAA25EC5-24E7-4449-83D4-2048E5F20EC4}']
    function Get_Gutter: IaqGutterProvider_XXX; safecall;
    function Get_Comments: IaqCommentsProvider_XXX; safecall;
    property Gutter: IaqGutterProvider_XXX read Get_Gutter;
    property Comments: IaqCommentsProvider_XXX read Get_Comments;
  end;

// *********************************************************************//
// Interface: IaqGutterProvider_XXX
// Flags:     (0)
// GUID:      {97A337A1-40F1-4007-8702-8A7751569AD4}
// *********************************************************************//
  IaqGutterProvider_XXX = interface(IaqDataTableProvider_XXX)
    ['{97A337A1-40F1-4007-8702-8A7751569AD4}']
    function Get_SourceLine(RowIndex: Integer): Integer; safecall;
    function Get_GetRelativePercentValue(ColIndex: Integer; RowIndex: Integer): Double; safecall;
    property SourceLine[RowIndex: Integer]: Integer read Get_SourceLine;
    property GetRelativePercentValue[ColIndex: Integer; RowIndex: Integer]: Double read Get_GetRelativePercentValue;
  end;

// *********************************************************************//
// Interface: IaqCommentsProvider_XXX
// Flags:     (0)
// GUID:      {C0C6B116-4D62-4B3D-B4CC-F0CFBB05CA7D}
// *********************************************************************//
  IaqCommentsProvider_XXX = interface(IaqDataTableProvider_XXX)
    ['{C0C6B116-4D62-4B3D-B4CC-F0CFBB05CA7D}']
    function Get_SourceLine(RowIndex: Integer): Integer; safecall;
    property SourceLine[RowIndex: Integer]: Integer read Get_SourceLine;
  end;

// *********************************************************************//
// Interface: IaqTimeIntegrationRunMode
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D4CB267A-237D-44C0-BE2A-B6D2F5D19A90}
// *********************************************************************//
  IaqTimeIntegrationRunMode = interface(IDispatch)
    ['{D4CB267A-237D-44C0-BE2A-B6D2F5D19A90}']
    function Get_Name: WideString; safecall;
    function Get_ParametersCount: Integer; safecall;
    function GetParameterName(Index: Integer): WideString; safecall;
    function GetParameterValue(Index: Integer): OleVariant; safecall;
    procedure SetParameterValue(Index: Integer; Value: OleVariant); safecall;
    property Name: WideString read Get_Name;
    property ParametersCount: Integer read Get_ParametersCount;
  end;

// *********************************************************************//
// DispIntf:  IaqTimeIntegrationRunModeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D4CB267A-237D-44C0-BE2A-B6D2F5D19A90}
// *********************************************************************//
  IaqTimeIntegrationRunModeDisp = dispinterface
    ['{D4CB267A-237D-44C0-BE2A-B6D2F5D19A90}']
    property Name: WideString readonly dispid 1610743808;
    property ParametersCount: Integer readonly dispid 1610743809;
    function GetParameterName(Index: Integer): WideString; dispid 1610743810;
    function GetParameterValue(Index: Integer): OleVariant; dispid 1610743811;
    procedure SetParameterValue(Index: Integer; Value: OleVariant); dispid 1610743812;
  end;

// *********************************************************************//
// Interface: IaqTimeIntegrationSupportManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CFC99F80-0568-45F6-8A5C-A27C8D3BED32}
// *********************************************************************//
  IaqTimeIntegrationSupportManager = interface(IaqSubsystemManager)
    ['{CFC99F80-0568-45F6-8A5C-A27C8D3BED32}']
    function OpenProject(const AProjectFileName: WideString): WordBool; safecall;
    function NewProjectFromModule(const AExecutableFileName: WideString): WordBool; safecall;
    function Get_ProfilersCount: Integer; safecall;
    function Get_ProfilerName(Index: Integer): WideString; safecall;
    function Get_ProfilerCategory(Index: Integer): WideString; safecall;
    function SelectProfiler(const AProfilerName: WideString): WordBool; safecall;
    function EnableProfiling(AEnable: WordBool): WordBool; safecall;
    function Start(const SummaryResultsFile: WideString; const FullResultsFile: WideString): WordBool; safecall;
    function Attach(ProcessID: Integer; const SummaryResultsFile: WideString; 
                    const FullResultsFile: WideString): WordBool; safecall;
    function TakeSnapshot(TimeOut: Integer): WordBool; safecall;
    function ClearResults: WordBool; safecall;
    function Get_ResultReady: WordBool; safecall;
    function Get_ProfilingStarted: WordBool; safecall;
    procedure TerminateProfiling; safecall;
    function OpenConfiguration(const AConfigFileName: WideString): WordBool; safecall;
    function ExportCurrentResults(const SummaryResultsFile: WideString; 
                                  const FullResultsFile: WideString): WordBool; safecall;
    function Get_RunModeCount: Integer; safecall;
    function GetRunMode(Index: Integer): IaqTimeIntegrationRunMode; safecall;
    procedure SelectRunMode(const RunModeName: WideString); safecall;
    procedure AddModule(const AFileName: WideString); safecall;
    procedure RemoveModule(const AFileName: WideString); safecall;
    property ProfilersCount: Integer read Get_ProfilersCount;
    property ProfilerName[Index: Integer]: WideString read Get_ProfilerName;
    property ProfilerCategory[Index: Integer]: WideString read Get_ProfilerCategory;
    property ResultReady: WordBool read Get_ResultReady;
    property ProfilingStarted: WordBool read Get_ProfilingStarted;
    property RunModeCount: Integer read Get_RunModeCount;
  end;

// *********************************************************************//
// DispIntf:  IaqTimeIntegrationSupportManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CFC99F80-0568-45F6-8A5C-A27C8D3BED32}
// *********************************************************************//
  IaqTimeIntegrationSupportManagerDisp = dispinterface
    ['{CFC99F80-0568-45F6-8A5C-A27C8D3BED32}']
    function OpenProject(const AProjectFileName: WideString): WordBool; dispid 1610809344;
    function NewProjectFromModule(const AExecutableFileName: WideString): WordBool; dispid 1610809345;
    property ProfilersCount: Integer readonly dispid 1610809346;
    property ProfilerName[Index: Integer]: WideString readonly dispid 1610809347;
    property ProfilerCategory[Index: Integer]: WideString readonly dispid 1610809348;
    function SelectProfiler(const AProfilerName: WideString): WordBool; dispid 1610809349;
    function EnableProfiling(AEnable: WordBool): WordBool; dispid 1610809350;
    function Start(const SummaryResultsFile: WideString; const FullResultsFile: WideString): WordBool; dispid 1610809351;
    function Attach(ProcessID: Integer; const SummaryResultsFile: WideString; 
                    const FullResultsFile: WideString): WordBool; dispid 1610809352;
    function TakeSnapshot(TimeOut: Integer): WordBool; dispid 1610809353;
    function ClearResults: WordBool; dispid 1610809354;
    property ResultReady: WordBool readonly dispid 1610809355;
    property ProfilingStarted: WordBool readonly dispid 1610809356;
    procedure TerminateProfiling; dispid 1610809357;
    function OpenConfiguration(const AConfigFileName: WideString): WordBool; dispid 1610809358;
    function ExportCurrentResults(const SummaryResultsFile: WideString; 
                                  const FullResultsFile: WideString): WordBool; dispid 1610809359;
    property RunModeCount: Integer readonly dispid 1610809360;
    function GetRunMode(Index: Integer): IaqTimeIntegrationRunMode; dispid 1610809361;
    procedure SelectRunMode(const RunModeName: WideString); dispid 1610809362;
    procedure AddModule(const AFileName: WideString); dispid 1610809363;
    procedure RemoveModule(const AFileName: WideString); dispid 1610809364;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqBaseFunction
// Flags:     (0)
// GUID:      {85E78ABD-3DE6-468B-A2D6-459B4316656D}
// *********************************************************************//
  IaqBaseFunction = interface(IUnknown)
    ['{85E78ABD-3DE6-468B-A2D6-459B4316656D}']
    function Get_ParamCount: Integer; safecall;
    function Get_ParamSize(Index: Integer): Integer; safecall;
    property ParamCount: Integer read Get_ParamCount;
    property ParamSize[Index: Integer]: Integer read Get_ParamSize;
  end;

// *********************************************************************//
// Interface: IaqCustomIterator
// Flags:     (320) Dual OleAutomation
// GUID:      {2FB06D5C-4432-4C3D-A071-A9FDFBEA26C4}
// *********************************************************************//
  IaqCustomIterator = interface(IUnknown)
    ['{2FB06D5C-4432-4C3D-A071-A9FDFBEA26C4}']
    procedure Reset; safecall;
    procedure Next; safecall;
    function HasNext: WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqCustomIteratorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {2FB06D5C-4432-4C3D-A071-A9FDFBEA26C4}
// *********************************************************************//
  IaqCustomIteratorDisp = dispinterface
    ['{2FB06D5C-4432-4C3D-A071-A9FDFBEA26C4}']
    procedure Reset; dispid 1610678272;
    procedure Next; dispid 1610678273;
    function HasNext: WordBool; dispid 1610678274;
  end;

// *********************************************************************//
// Interface: IaqSubCategoriesIterator
// Flags:     (320) Dual OleAutomation
// GUID:      {A7B7334D-0EBF-4048-8A4A-D8AD773A251D}
// *********************************************************************//
  IaqSubCategoriesIterator = interface(IaqCustomIterator)
    ['{A7B7334D-0EBF-4048-8A4A-D8AD773A251D}']
    function Get_SubCategoryName: WideString; safecall;
    function Get_SubCategoryID: Integer; safecall;
    function GetSubCategoryBitmap: UINT_PTR; safecall;
    property SubCategoryName: WideString read Get_SubCategoryName;
    property SubCategoryID: Integer read Get_SubCategoryID;
  end;

// *********************************************************************//
// DispIntf:  IaqSubCategoriesIteratorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {A7B7334D-0EBF-4048-8A4A-D8AD773A251D}
// *********************************************************************//
  IaqSubCategoriesIteratorDisp = dispinterface
    ['{A7B7334D-0EBF-4048-8A4A-D8AD773A251D}']
    property SubCategoryName: WideString readonly dispid 1610743808;
    property SubCategoryID: Integer readonly dispid 1610743809;
    function GetSubCategoryBitmap: UINT_PTR; dispid 1610743810;
    procedure Reset; dispid 1610678272;
    procedure Next; dispid 1610678273;
    function HasNext: WordBool; dispid 1610678274;
  end;

// *********************************************************************//
// Interface: IaqCategoriesIterator
// Flags:     (320) Dual OleAutomation
// GUID:      {4AFB1820-9B9A-4EA2-9433-DAB3505606AC}
// *********************************************************************//
  IaqCategoriesIterator = interface(IaqCustomIterator)
    ['{4AFB1820-9B9A-4EA2-9433-DAB3505606AC}']
    function Get_CategoryName: WideString; safecall;
    function Get_CategoryID: Integer; safecall;
    function Get_SubCategories: IaqSubCategoriesIterator; safecall;
    function Get_SubCategoryIDByName(const ASubCategoryName: WideString): Integer; safecall;
    function GetCategoryBitmap: UINT_PTR; safecall;
    property CategoryName: WideString read Get_CategoryName;
    property CategoryID: Integer read Get_CategoryID;
    property SubCategories: IaqSubCategoriesIterator read Get_SubCategories;
    property SubCategoryIDByName[const ASubCategoryName: WideString]: Integer read Get_SubCategoryIDByName;
  end;

// *********************************************************************//
// DispIntf:  IaqCategoriesIteratorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {4AFB1820-9B9A-4EA2-9433-DAB3505606AC}
// *********************************************************************//
  IaqCategoriesIteratorDisp = dispinterface
    ['{4AFB1820-9B9A-4EA2-9433-DAB3505606AC}']
    property CategoryName: WideString readonly dispid 1610743808;
    property CategoryID: Integer readonly dispid 1610743809;
    property SubCategories: IaqSubCategoriesIterator readonly dispid 1610743810;
    property SubCategoryIDByName[const ASubCategoryName: WideString]: Integer readonly dispid 1610743811;
    function GetCategoryBitmap: UINT_PTR; dispid 1610743812;
    procedure Reset; dispid 1610678272;
    procedure Next; dispid 1610678273;
    function HasNext: WordBool; dispid 1610678274;
  end;

// *********************************************************************//
// Interface: IaqFunctionsIterator
// Flags:     (320) Dual OleAutomation
// GUID:      {B39232CD-1319-40B1-8887-5236338575C7}
// *********************************************************************//
  IaqFunctionsIterator = interface(IaqCustomIterator)
    ['{B39232CD-1319-40B1-8887-5236338575C7}']
    function AllocateResource: TaqAllocateResourceType; safecall;
    function Get_FunctionID: Integer; safecall;
    function Get_FunctionName: WideString; safecall;
    function Get_LibraryName: WideString; safecall;
    function Get_CategoryID: Integer; safecall;
    function Get_SubCategoryID: Integer; safecall;
    function Get_MultipleSubCategories: WordBool; safecall;
    function Get_CheckErrorType: TaqCheckErrorType; safecall;
    function Get_BaseFunction: IaqBaseFunction; safecall;
    property FunctionID: Integer read Get_FunctionID;
    property FunctionName: WideString read Get_FunctionName;
    property LibraryName: WideString read Get_LibraryName;
    property CategoryID: Integer read Get_CategoryID;
    property SubCategoryID: Integer read Get_SubCategoryID;
    property MultipleSubCategories: WordBool read Get_MultipleSubCategories;
    property CheckErrorType: TaqCheckErrorType read Get_CheckErrorType;
    property BaseFunction: IaqBaseFunction read Get_BaseFunction;
  end;

// *********************************************************************//
// DispIntf:  IaqFunctionsIteratorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {B39232CD-1319-40B1-8887-5236338575C7}
// *********************************************************************//
  IaqFunctionsIteratorDisp = dispinterface
    ['{B39232CD-1319-40B1-8887-5236338575C7}']
    function AllocateResource: TaqAllocateResourceType; dispid 1610743808;
    property FunctionID: Integer readonly dispid 1610743809;
    property FunctionName: WideString readonly dispid 1610743810;
    property LibraryName: WideString readonly dispid 1610743811;
    property CategoryID: Integer readonly dispid 1610743812;
    property SubCategoryID: Integer readonly dispid 1610743813;
    property MultipleSubCategories: WordBool readonly dispid 1610743814;
    property CheckErrorType: TaqCheckErrorType readonly dispid 1610743815;
    property BaseFunction: IaqBaseFunction readonly dispid 1610743816;
    procedure Reset; dispid 1610678272;
    procedure Next; dispid 1610678273;
    function HasNext: WordBool; dispid 1610678274;
  end;

// *********************************************************************//
// Interface: IaqCustomParameter
// Flags:     (320) Dual OleAutomation
// GUID:      {DAE8D33B-2467-430A-9CBC-C23B2515DD2D}
// *********************************************************************//
  IaqCustomParameter = interface(IUnknown)
    ['{DAE8D33B-2467-430A-9CBC-C23B2515DD2D}']
    function Get_IdentifierID: Integer; safecall;
    function Get_ParamID: Integer; safecall;
    function Get_ParamPos: Integer; safecall;
    function Get_ParamName: WideString; safecall;
    function Get_ArrayRef: TaqArrayRef; safecall;
    function Get_ArraySize: Integer; safecall;
    function Get_ByRef: WordBool; safecall;
    function Get_InOutParamType: TaqInOutParamType; safecall;
    function Get_ParamSizeInMem: Integer; safecall;
    function Get_ParamDataType: TaqValueType; safecall;
    function Get_ParamTypeName: WideString; safecall;
    procedure Set_AddressInStack(Result: UINT_PTR); safecall;
    function Get_AddressInStack: UINT_PTR; safecall;
    procedure Set_AddressInMemory(Result: UINT_PTR); safecall;
    function Get_AddressInMemory: UINT_PTR; safecall;
    procedure Set_ValueInStack(AValue: UINT_PTR); safecall;
    function Get_ValueInStack: UINT_PTR; safecall;
    procedure Set_ValueInMemory(AValue: UINT_PTR); safecall;
    function Get_ValueInMemory: UINT_PTR; safecall;
    function Get_CurrentValue: OleVariant; safecall;
    procedure Set_CurrentValue(Result: OleVariant); safecall;
    function AttributeSpecified(AAttribute: TaqSetAttribute): WordBool; safecall;
    function Get_AttributesSet: LongWord; safecall;
    procedure ReReadParamFromStack; safecall;
    property IdentifierID: Integer read Get_IdentifierID;
    property ParamID: Integer read Get_ParamID;
    property ParamPos: Integer read Get_ParamPos;
    property ParamName: WideString read Get_ParamName;
    property ArrayRef: TaqArrayRef read Get_ArrayRef;
    property ArraySize: Integer read Get_ArraySize;
    property ByRef: WordBool read Get_ByRef;
    property InOutParamType: TaqInOutParamType read Get_InOutParamType;
    property ParamSizeInMem: Integer read Get_ParamSizeInMem;
    property ParamDataType: TaqValueType read Get_ParamDataType;
    property ParamTypeName: WideString read Get_ParamTypeName;
    property AddressInStack: UINT_PTR read Get_AddressInStack write Set_AddressInStack;
    property AddressInMemory: UINT_PTR read Get_AddressInMemory write Set_AddressInMemory;
    property ValueInStack: UINT_PTR read Get_ValueInStack write Set_ValueInStack;
    property ValueInMemory: UINT_PTR read Get_ValueInMemory write Set_ValueInMemory;
    property CurrentValue: OleVariant read Get_CurrentValue write Set_CurrentValue;
    property AttributesSet: LongWord read Get_AttributesSet;
  end;

// *********************************************************************//
// DispIntf:  IaqCustomParameterDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {DAE8D33B-2467-430A-9CBC-C23B2515DD2D}
// *********************************************************************//
  IaqCustomParameterDisp = dispinterface
    ['{DAE8D33B-2467-430A-9CBC-C23B2515DD2D}']
    property IdentifierID: Integer readonly dispid 1610678272;
    property ParamID: Integer readonly dispid 1610678273;
    property ParamPos: Integer readonly dispid 1610678274;
    property ParamName: WideString readonly dispid 1610678275;
    property ArrayRef: TaqArrayRef readonly dispid 1610678276;
    property ArraySize: Integer readonly dispid 1610678277;
    property ByRef: WordBool readonly dispid 1610678278;
    property InOutParamType: TaqInOutParamType readonly dispid 1610678279;
    property ParamSizeInMem: Integer readonly dispid 1610678280;
    property ParamDataType: TaqValueType readonly dispid 1610678281;
    property ParamTypeName: WideString readonly dispid 1610678282;
    property AddressInStack: UINT_PTR dispid 1610678283;
    property AddressInMemory: UINT_PTR dispid 1610678285;
    property ValueInStack: UINT_PTR dispid 1610678287;
    property ValueInMemory: UINT_PTR dispid 1610678289;
    property CurrentValue: OleVariant dispid 1610678291;
    function AttributeSpecified(AAttribute: TaqSetAttribute): WordBool; dispid 1610678293;
    property AttributesSet: LongWord readonly dispid 1610678294;
    procedure ReReadParamFromStack; dispid 1610678295;
  end;

// *********************************************************************//
// Interface: IaqFunctionParameter
// Flags:     (320) Dual OleAutomation
// GUID:      {CA10916B-4643-4D8A-A011-CB11690B3682}
// *********************************************************************//
  IaqFunctionParameter = interface(IaqCustomParameter)
    ['{CA10916B-4643-4D8A-A011-CB11690B3682}']
  end;

// *********************************************************************//
// DispIntf:  IaqFunctionParameterDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {CA10916B-4643-4D8A-A011-CB11690B3682}
// *********************************************************************//
  IaqFunctionParameterDisp = dispinterface
    ['{CA10916B-4643-4D8A-A011-CB11690B3682}']
    property IdentifierID: Integer readonly dispid 1610678272;
    property ParamID: Integer readonly dispid 1610678273;
    property ParamPos: Integer readonly dispid 1610678274;
    property ParamName: WideString readonly dispid 1610678275;
    property ArrayRef: TaqArrayRef readonly dispid 1610678276;
    property ArraySize: Integer readonly dispid 1610678277;
    property ByRef: WordBool readonly dispid 1610678278;
    property InOutParamType: TaqInOutParamType readonly dispid 1610678279;
    property ParamSizeInMem: Integer readonly dispid 1610678280;
    property ParamDataType: TaqValueType readonly dispid 1610678281;
    property ParamTypeName: WideString readonly dispid 1610678282;
    property AddressInStack: UINT_PTR dispid 1610678283;
    property AddressInMemory: UINT_PTR dispid 1610678285;
    property ValueInStack: UINT_PTR dispid 1610678287;
    property ValueInMemory: UINT_PTR dispid 1610678289;
    property CurrentValue: OleVariant dispid 1610678291;
    function AttributeSpecified(AAttribute: TaqSetAttribute): WordBool; dispid 1610678293;
    property AttributesSet: LongWord readonly dispid 1610678294;
    procedure ReReadParamFromStack; dispid 1610678295;
  end;

// *********************************************************************//
// Interface: IaqCustomIdentifier
// Flags:     (0)
// GUID:      {18A8B003-A9E1-410C-8BE4-A334190E52A6}
// *********************************************************************//
  IaqCustomIdentifier = interface(IaqBaseFunction)
    ['{18A8B003-A9E1-410C-8BE4-A334190E52A6}']
    function Get_Id: Integer; safecall;
    function Get_Name: WideString; safecall;
    function Get_Params(Index: Integer): IaqCustomParameter; safecall;
    function Get_ParamByID(AParamID: Integer): IaqCustomParameter; safecall;
    property Id: Integer read Get_Id;
    property Name: WideString read Get_Name;
    property Params[Index: Integer]: IaqCustomParameter read Get_Params;
    property ParamByID[AParamID: Integer]: IaqCustomParameter read Get_ParamByID;
  end;

// *********************************************************************//
// Interface: IaqFunction
// Flags:     (320) Dual OleAutomation
// GUID:      {C1A5EAEB-9CDD-4A89-9621-72FBE49C939E}
// *********************************************************************//
  IaqFunction = interface(IaqCustomIdentifier)
    ['{C1A5EAEB-9CDD-4A89-9621-72FBE49C939E}']
    function Get_LibraryName: WideString; safecall;
    function Get_LibraryID: Integer; safecall;
    function Get_CategoryID: Integer; safecall;
    function Get_SubCategoryID: Integer; safecall;
    function Get_MultipleSubCategories: WordBool; safecall;
    function Get_AllocateResource: TaqAllocateResourceType; safecall;
    function Get_Description: WideString; safecall;
    function Get_AllocationByCall: WordBool; safecall;
    function Get_HoldsResourceIn: Integer; safecall;
    function Get_HoldsResourceSizeIn: Integer; safecall;
    function Get_ResultValueCheckType: TaqResultValueCheckType; safecall;
    function Get_ResultValueToCheck: UINT_PTR; safecall;
    function Get_URL: WideString; safecall;
    function Get_CheckErrorType: TaqCheckErrorType; safecall;
    function Get_PlatformNotes(APlatformID: Integer): WideString; safecall;
    function Get_PlatformCompliance(APlatformID: Integer): TaqPlatformComplianceType; safecall;
    function Clone: IaqFunction; safecall;
    property LibraryName: WideString read Get_LibraryName;
    property LibraryID: Integer read Get_LibraryID;
    property CategoryID: Integer read Get_CategoryID;
    property SubCategoryID: Integer read Get_SubCategoryID;
    property MultipleSubCategories: WordBool read Get_MultipleSubCategories;
    property AllocateResource: TaqAllocateResourceType read Get_AllocateResource;
    property Description: WideString read Get_Description;
    property AllocationByCall: WordBool read Get_AllocationByCall;
    property HoldsResourceIn: Integer read Get_HoldsResourceIn;
    property HoldsResourceSizeIn: Integer read Get_HoldsResourceSizeIn;
    property ResultValueCheckType: TaqResultValueCheckType read Get_ResultValueCheckType;
    property ResultValueToCheck: UINT_PTR read Get_ResultValueToCheck;
    property URL: WideString read Get_URL;
    property CheckErrorType: TaqCheckErrorType read Get_CheckErrorType;
    property PlatformNotes[APlatformID: Integer]: WideString read Get_PlatformNotes;
    property PlatformCompliance[APlatformID: Integer]: TaqPlatformComplianceType read Get_PlatformCompliance;
  end;

// *********************************************************************//
// DispIntf:  IaqFunctionDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {C1A5EAEB-9CDD-4A89-9621-72FBE49C939E}
// *********************************************************************//
  IaqFunctionDisp = dispinterface
    ['{C1A5EAEB-9CDD-4A89-9621-72FBE49C939E}']
    property LibraryName: WideString readonly dispid 1610809344;
    property LibraryID: Integer readonly dispid 1610809345;
    property CategoryID: Integer readonly dispid 1610809346;
    property SubCategoryID: Integer readonly dispid 1610809347;
    property MultipleSubCategories: WordBool readonly dispid 1610809348;
    property AllocateResource: TaqAllocateResourceType readonly dispid 1610809349;
    property Description: WideString readonly dispid 1610809350;
    property AllocationByCall: WordBool readonly dispid 1610809351;
    property HoldsResourceIn: Integer readonly dispid 1610809352;
    property HoldsResourceSizeIn: Integer readonly dispid 1610809353;
    property ResultValueCheckType: TaqResultValueCheckType readonly dispid 1610809354;
    property ResultValueToCheck: UINT_PTR readonly dispid 1610809355;
    property URL: WideString readonly dispid 1610809356;
    property CheckErrorType: TaqCheckErrorType readonly dispid 1610809357;
    property PlatformNotes[APlatformID: Integer]: WideString readonly dispid 1610809358;
    property PlatformCompliance[APlatformID: Integer]: TaqPlatformComplianceType readonly dispid 1610809359;
    function Clone: IaqFunction; dispid 1610809360;
    property Id: Integer readonly dispid 1610743808;
    property Name: WideString readonly dispid 1610743809;
    property Params[Index: Integer]: IaqCustomParameter readonly dispid 1610743810;
    property ParamByID[AParamID: Integer]: IaqCustomParameter readonly dispid 1610743811;
    property ParamCount: Integer readonly dispid 1610678272;
    property ParamSize[Index: Integer]: Integer readonly dispid 1610678273;
  end;

// *********************************************************************//
// Interface: IaqPlatformsIterator
// Flags:     (320) Dual OleAutomation
// GUID:      {BA9C8261-9165-4360-A4C5-4169F8D7435D}
// *********************************************************************//
  IaqPlatformsIterator = interface(IaqCustomIterator)
    ['{BA9C8261-9165-4360-A4C5-4169F8D7435D}']
    function Get_PlatformName: WideString; safecall;
    function Get_PlatformID: Integer; safecall;
    property PlatformName: WideString read Get_PlatformName;
    property PlatformID: Integer read Get_PlatformID;
  end;

// *********************************************************************//
// DispIntf:  IaqPlatformsIteratorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {BA9C8261-9165-4360-A4C5-4169F8D7435D}
// *********************************************************************//
  IaqPlatformsIteratorDisp = dispinterface
    ['{BA9C8261-9165-4360-A4C5-4169F8D7435D}']
    property PlatformName: WideString readonly dispid 1610743808;
    property PlatformID: Integer readonly dispid 1610743809;
    procedure Reset; dispid 1610678272;
    procedure Next; dispid 1610678273;
    function HasNext: WordBool; dispid 1610678274;
  end;

// *********************************************************************//
// Interface: IaqWinAPIDatabase
// Flags:     (320) Dual OleAutomation
// GUID:      {0DE1DEFD-2C89-4912-8C34-612BD673EB6D}
// *********************************************************************//
  IaqWinAPIDatabase = interface(IUnknown)
    ['{0DE1DEFD-2C89-4912-8C34-612BD673EB6D}']
    function Get_CategoriesCount: Integer; safecall;
    function GetCategoriesIterator: IaqCategoriesIterator; safecall;
    function GetFunctionsIterator(ACategoryID: Integer): IaqFunctionsIterator; safecall;
    function GetPlatformsIterator: IaqPlatformsIterator; safecall;
    function GetFunctionByNameAndLibraryName(const AFunctionName: WideString; 
                                             const ALibraryName: WideString): IaqFunction; safecall;
    function GetFunctionById(AFuncId: Integer): IaqFunction; safecall;
    function IsContainsLibrary(const ALibraryName: WideString): WordBool; safecall;
    function LoadData: WordBool; safecall;
    function IsDataLoaded: WordBool; safecall;
    procedure UnloadData; safecall;
    function GetFunctionCategory(AFuncId: Integer): Integer; safecall;
    procedure BeginPrepareFunctions; safecall;
    procedure EndPrepareFunctions; safecall;
    function MarkFunctionForCheck(AFuncId: Integer): WordBool; safecall;
    procedure BeginCheck; safecall;
    procedure EndCheck; safecall;
    function GetParameterString(const AFunction: IaqFunction): WideString; safecall;
    function CheckParameters(const AFunction: IaqFunction): WideString; safecall;
    function BeforeCall(AFuncId: Integer; AStack: UINT_PTR; ARCX: UINT_PTR; ARDX: UINT_PTR; 
                        AR8: UINT_PTR; AR9: UINT_PTR): IaqFunction; safecall;
    function AfterCall_AllocateResource(const AFunction: IaqFunction; AEAX: UINT_PTR; 
                                        LastError: LongWord; out AResourceHandle: UINT_PTR; 
                                        out AResourceSize: Integer): WordBool; safecall;
    function AfterCall_DeallocateResource(const AFunction: IaqFunction; AEAX: UINT_PTR; 
                                          LastError: LongWord; 
                                          out ADeallocatedResourceHandle: UINT_PTR): WordBool; safecall;
    function AfterCall_ReallocateResource(const AFunction: IaqFunction; AEAX: UINT_PTR; 
                                          LastError: LongWord; out AOldResourceHandle: UINT_PTR; 
                                          out ANewResourceHandle: UINT_PTR; 
                                          out ANewResourceSize: Integer): WordBool; safecall;
    procedure GetLastErrorDescription(const AFunction: IaqFunction; AEAX: UINT_PTR; 
                                      out ErrCode: LongWord; out ErrorDescription: WideString); safecall;
    procedure GetLastErrorDescription2(const AFunction: IaqFunction; AEAX: UINT_PTR; 
                                       LastError: LongWord; out ErrCode: LongWord; 
                                       out ErrorDescription: WideString); safecall;
    procedure UpdateOutParamData(const AParam: IaqCustomParameter); safecall;
    property CategoriesCount: Integer read Get_CategoriesCount;
  end;

// *********************************************************************//
// DispIntf:  IaqWinAPIDatabaseDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {0DE1DEFD-2C89-4912-8C34-612BD673EB6D}
// *********************************************************************//
  IaqWinAPIDatabaseDisp = dispinterface
    ['{0DE1DEFD-2C89-4912-8C34-612BD673EB6D}']
    property CategoriesCount: Integer readonly dispid 1610678272;
    function GetCategoriesIterator: IaqCategoriesIterator; dispid 1610678273;
    function GetFunctionsIterator(ACategoryID: Integer): IaqFunctionsIterator; dispid 1610678274;
    function GetPlatformsIterator: IaqPlatformsIterator; dispid 1610678275;
    function GetFunctionByNameAndLibraryName(const AFunctionName: WideString; 
                                             const ALibraryName: WideString): IaqFunction; dispid 1610678276;
    function GetFunctionById(AFuncId: Integer): IaqFunction; dispid 1610678277;
    function IsContainsLibrary(const ALibraryName: WideString): WordBool; dispid 1610678278;
    function LoadData: WordBool; dispid 1610678279;
    function IsDataLoaded: WordBool; dispid 1610678280;
    procedure UnloadData; dispid 1610678281;
    function GetFunctionCategory(AFuncId: Integer): Integer; dispid 1610678282;
    procedure BeginPrepareFunctions; dispid 1610678283;
    procedure EndPrepareFunctions; dispid 1610678284;
    function MarkFunctionForCheck(AFuncId: Integer): WordBool; dispid 1610678285;
    procedure BeginCheck; dispid 1610678286;
    procedure EndCheck; dispid 1610678287;
    function GetParameterString(const AFunction: IaqFunction): WideString; dispid 1610678288;
    function CheckParameters(const AFunction: IaqFunction): WideString; dispid 1610678289;
    function BeforeCall(AFuncId: Integer; AStack: UINT_PTR; ARCX: UINT_PTR; ARDX: UINT_PTR; 
                        AR8: UINT_PTR; AR9: UINT_PTR): IaqFunction; dispid 1610678290;
    function AfterCall_AllocateResource(const AFunction: IaqFunction; AEAX: UINT_PTR; 
                                        LastError: LongWord; out AResourceHandle: UINT_PTR; 
                                        out AResourceSize: Integer): WordBool; dispid 1610678291;
    function AfterCall_DeallocateResource(const AFunction: IaqFunction; AEAX: UINT_PTR; 
                                          LastError: LongWord; 
                                          out ADeallocatedResourceHandle: UINT_PTR): WordBool; dispid 1610678292;
    function AfterCall_ReallocateResource(const AFunction: IaqFunction; AEAX: UINT_PTR; 
                                          LastError: LongWord; out AOldResourceHandle: UINT_PTR; 
                                          out ANewResourceHandle: UINT_PTR; 
                                          out ANewResourceSize: Integer): WordBool; dispid 1610678293;
    procedure GetLastErrorDescription(const AFunction: IaqFunction; AEAX: UINT_PTR; 
                                      out ErrCode: LongWord; out ErrorDescription: WideString); dispid 1610678294;
    procedure GetLastErrorDescription2(const AFunction: IaqFunction; AEAX: UINT_PTR; 
                                       LastError: LongWord; out ErrCode: LongWord; 
                                       out ErrorDescription: WideString); dispid 1610678295;
    procedure UpdateOutParamData(const AParam: IaqCustomParameter); dispid 1610678296;
  end;

// *********************************************************************//
// Interface: IaqWinAPIDatabaseLegacy
// Flags:     (320) Dual OleAutomation
// GUID:      {605F9B67-FF9C-4044-8703-2A780A3F0ED6}
// *********************************************************************//
  IaqWinAPIDatabaseLegacy = interface(IUnknown)
    ['{605F9B67-FF9C-4044-8703-2A780A3F0ED6}']
    procedure GetAQT5CategoryIDByAQT4(AQT4CategoryID: Integer; out AQT5CategoryID: Integer); safecall;
    procedure GetAQT5FunctionIDByAQT4(AQT4FunctionID: Integer; out AQT5FunctionID: Integer); safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqWinAPIDatabaseLegacyDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {605F9B67-FF9C-4044-8703-2A780A3F0ED6}
// *********************************************************************//
  IaqWinAPIDatabaseLegacyDisp = dispinterface
    ['{605F9B67-FF9C-4044-8703-2A780A3F0ED6}']
    procedure GetAQT5CategoryIDByAQT4(AQT4CategoryID: Integer; out AQT5CategoryID: Integer); dispid 1610678272;
    procedure GetAQT5FunctionIDByAQT4(AQT4FunctionID: Integer; out AQT5FunctionID: Integer); dispid 1610678273;
  end;

// *********************************************************************//
// Interface: IaqWinAPIDatabaseModule
// Flags:     (320) Dual OleAutomation
// GUID:      {B5D4DF6F-1B42-4B5C-9CE3-B5003853C884}
// *********************************************************************//
  IaqWinAPIDatabaseModule = interface(IUnknown)
    ['{B5D4DF6F-1B42-4B5C-9CE3-B5003853C884}']
    function Get_Database(const FileName: WideString; const Messenger: IUnknown): IaqWinAPIDatabase; safecall;
    property Database[const FileName: WideString; const Messenger: IUnknown]: IaqWinAPIDatabase read Get_Database;
  end;

// *********************************************************************//
// DispIntf:  IaqWinAPIDatabaseModuleDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {B5D4DF6F-1B42-4B5C-9CE3-B5003853C884}
// *********************************************************************//
  IaqWinAPIDatabaseModuleDisp = dispinterface
    ['{B5D4DF6F-1B42-4B5C-9CE3-B5003853C884}']
    property Database[const FileName: WideString; const Messenger: IUnknown]: IaqWinAPIDatabase readonly dispid 1610678272;
  end;

// *********************************************************************//
// Interface: IaqWinAPIDatabaseManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2ADD6327-2B10-47DA-A000-BC2138B34062}
// *********************************************************************//
  IaqWinAPIDatabaseManager = interface(IaqSubsystemManager)
    ['{2ADD6327-2B10-47DA-A000-BC2138B34062}']
    function Get_Database: IaqWinAPIDatabase; safecall;
    property Database: IaqWinAPIDatabase read Get_Database;
  end;

// *********************************************************************//
// DispIntf:  IaqWinAPIDatabaseManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2ADD6327-2B10-47DA-A000-BC2138B34062}
// *********************************************************************//
  IaqWinAPIDatabaseManagerDisp = dispinterface
    ['{2ADD6327-2B10-47DA-A000-BC2138B34062}']
    property Database: IaqWinAPIDatabase readonly dispid 1610809344;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IaqMonitorMetaProvider
// Flags:     (0)
// GUID:      {C4B9AED8-E069-45B6-A538-448721C51F3B}
// *********************************************************************//
  IaqMonitorMetaProvider = interface(IaqKeyItem)
    ['{C4B9AED8-E069-45B6-A538-448721C51F3B}']
    procedure UpdateSettings(Active: WordBool; UpdateInterval: Integer); stdcall;
    function GetProviderCount: Integer; stdcall;
    procedure GetProviders(Index: Integer; out Value: IaqDataProvider); stdcall;
    function FindProvider(Key: TGUID; out Value: IaqDataProvider): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqMonitorDataEvent
// Flags:     (0)
// GUID:      {3C1084C8-52CB-4B5A-8138-CB4C86997A43}
// *********************************************************************//
  IaqMonitorDataEvent = interface(IaqBaseEvent)
    ['{3C1084C8-52CB-4B5A-8138-CB4C86997A43}']
    procedure MonitorProviderCreated(const AMetaProvider: IaqMonitorMetaProvider); safecall;
    procedure MonitorProviderDestroyed(const AMetaProvider: IaqMonitorMetaProvider); safecall;
    procedure MonitorProviderDataCleared(const AMetaProvider: IaqMonitorMetaProvider); safecall;
    procedure MonitorProviderDataChanged(const AMetaProvider: IaqMonitorMetaProvider); safecall;
  end;

// *********************************************************************//
// Interface: IaqProfIntf
// Flags:     (0)
// GUID:      {B235822F-EED2-45C2-A3AE-4502E83C16D2}
// *********************************************************************//
  IaqProfIntf = interface(IaqModuleIntf)
    ['{B235822F-EED2-45C2-A3AE-4502E83C16D2}']
    function Get_PluginRegistry: IaqProfPluginRegistry; safecall;
    function Get_ThreadMapperRegistry: IaqProfThreadMapperRegistry; safecall;
    function Get_CounterRegistry: IaqProfCounterRegistry; safecall;
    function Get_ProfilingEnabled: WordBool; safecall;
    procedure Set_ProfilingEnabled(Value: WordBool); safecall;
    function Get_CurrentThreadName: WideString; safecall;
    procedure Set_CurrentThreadName(const Value: WideString); safecall;
    function CreateDynamicContext: IaqProfDynamicContext; safecall;
    function CreateSession(ProcessID: LongWord; const Context: IaqProfDynamicContext; 
                           const Listener: IaqProfSessionListener): IaqProfSession; safecall;
    function StartProfiling: IaqProfDynamicContext; safecall;
    function StopProfiling: WordBool; safecall;
    procedure TakeSnapshot; safecall;
    procedure ClearResults; safecall;
    function CreateStream: IaqStream; safecall;
    function AddProcessCallback(const Callback: IaqProfProcessCallback): LongWord; safecall;
    procedure RemoveProcessCallback(CallbackCookie: LongWord); stdcall;
    procedure SendProfilerEvent(const EventID: TGUID; Data: CVOID_PTR; DataSize: LongWord); safecall;
    function RowManager_GetRecId(Row: AQPROF_TABLE_ROW): AQPROF_TABLE_RECID; stdcall;
    function RowManager_GetTable(Row: AQPROF_TABLE_ROW): VOID_PTR; stdcall;
    function RowManager_GetData(Row: AQPROF_TABLE_ROW; Accessor: AQPROF_TABLE_ACCESSOR): VOID_PTR; stdcall;
    function RowManager_GetChild(Row: AQPROF_TABLE_ROW; Accessor: AQPROF_TABLE_ACCESSOR): VOID_PTR; stdcall;
    property PluginRegistry: IaqProfPluginRegistry read Get_PluginRegistry;
    property ThreadMapperRegistry: IaqProfThreadMapperRegistry read Get_ThreadMapperRegistry;
    property CounterRegistry: IaqProfCounterRegistry read Get_CounterRegistry;
    property ProfilingEnabled: WordBool read Get_ProfilingEnabled write Set_ProfilingEnabled;
    property CurrentThreadName: WideString read Get_CurrentThreadName write Set_CurrentThreadName;
  end;

// *********************************************************************//
// Interface: IaqProfPluginRegistry
// Flags:     (0)
// GUID:      {EBA97606-79C5-46B8-874D-1C06DBACD6E4}
// *********************************************************************//
  IaqProfPluginRegistry = interface(IUnknown)
    ['{EBA97606-79C5-46B8-874D-1C06DBACD6E4}']
    function Get_Count: Integer; safecall;
    function Get_Items(Index: Integer): CPAQPROF_PLUGIN_INFO; safecall;
    function Find(const PluginId: TGUID): CPAQPROF_PLUGIN_INFO; safecall;
    procedure RegisterFactory(PluginId: TGUID; const Factory: IaqProfPluginFactory); safecall;
    procedure Register(const Info: AQPROF_PLUGIN_INFO); safecall;
    procedure Unregister(const PluginId: TGUID); safecall;
    function Create(const PluginId: TGUID): IaqProfPlugin; safecall;
    property Count: Integer read Get_Count;
    property Items[Index: Integer]: CPAQPROF_PLUGIN_INFO read Get_Items;
  end;

// *********************************************************************//
// Interface: IaqProfPluginFactory
// Flags:     (0)
// GUID:      {B2DFA27C-29BD-43D8-BD92-C5FF4F256FF3}
// *********************************************************************//
  IaqProfPluginFactory = interface(IUnknown)
    ['{B2DFA27C-29BD-43D8-BD92-C5FF4F256FF3}']
    procedure CreatePlugin(PluginId: TGUID; out Value: IaqProfPlugin); stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfPlugin
// Flags:     (0)
// GUID:      {36AAE878-3186-4480-9D8B-144CE26854F6}
// *********************************************************************//
  IaqProfPlugin = interface(IUnknown)
    ['{36AAE878-3186-4480-9D8B-144CE26854F6}']
    procedure Connect(const Context: IaqProfBaseContext); safecall;
    procedure Disconnect; stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfPersistent
// Flags:     (0)
// GUID:      {BFC15E9D-45DC-47FE-A8B4-6D89C51E0B16}
// *********************************************************************//
  IaqProfPersistent = interface(IUnknown)
    ['{BFC15E9D-45DC-47FE-A8B4-6D89C51E0B16}']
    procedure Marshal(const Stream: IaqStream); safecall;
    procedure Unmarshal(const Stream: IaqStream); safecall;
    procedure Save(const Stream: IaqStream); safecall;
    procedure Load(const Stream: IaqStream); safecall;
  end;

// *********************************************************************//
// Interface: IaqProfBaseContext
// Flags:     (0)
// GUID:      {9770004E-ABED-4AEA-8499-DDE6991054B5}
// *********************************************************************//
  IaqProfBaseContext = interface(IaqProfPersistent)
    ['{9770004E-ABED-4AEA-8499-DDE6991054B5}']
    function Get_PluginManager: IaqProfPluginManager; safecall;
    function Get_DataManager: IaqProfDataManager; safecall;
    function Get_Merged: WordBool; safecall;
    function AddMergeCallback(const Callback: IaqProfMergeCallback): LongWord; safecall;
    procedure RemoveMergeCallback(CallbackCookie: LongWord); safecall;
    function GetOption(const Key: TGUID): OleVariant; safecall;
    procedure SetOption(const Key: TGUID; Value: OleVariant); safecall;
    procedure Merge(const MrgContext: IaqProfBaseContext); safecall;
    procedure FatalError(HR: HResult); stdcall;
    procedure Dispose; safecall;
    property PluginManager: IaqProfPluginManager read Get_PluginManager;
    property DataManager: IaqProfDataManager read Get_DataManager;
    property Merged: WordBool read Get_Merged;
  end;

// *********************************************************************//
// Interface: IaqProfPluginManager
// Flags:     (0)
// GUID:      {C41CC42A-CDE9-4C60-9FC3-2B490DA0536D}
// *********************************************************************//
  IaqProfPluginManager = interface(IUnknown)
    ['{C41CC42A-CDE9-4C60-9FC3-2B490DA0536D}']
    function Get_PluginCount: Integer; safecall;
    function Get_Plugins(Index: Integer): IaqProfPlugin; safecall;
    function AddPluginCallback(const Callback: IaqProfPluginCallback): LongWord; safecall;
    procedure RemovePluginCallback(CallbackCookie: LongWord); stdcall;
    function Connect(const PluginId: TGUID): IaqProfPlugin; safecall;
    function ConnectEx(var PluginId: TGUID; var IID: TGUID): Pointer; safecall;
    function Find(const PluginId: TGUID): IaqProfPlugin; safecall;
    property PluginCount: Integer read Get_PluginCount;
    property Plugins[Index: Integer]: IaqProfPlugin read Get_Plugins;
  end;

// *********************************************************************//
// Interface: IaqProfPluginCallback
// Flags:     (0)
// GUID:      {72565749-D520-4310-9D54-32E290AEDAC7}
// *********************************************************************//
  IaqProfPluginCallback = interface(IUnknown)
    ['{72565749-D520-4310-9D54-32E290AEDAC7}']
    procedure OnAddPlugin(const Plugin: IaqProfPlugin); stdcall;
    procedure OnRemovePlugin(const Plugin: IaqProfPlugin); stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfDataManager
// Flags:     (0)
// GUID:      {7421A575-9691-4F9D-AD8E-E7354D2EFCF6}
// *********************************************************************//
  IaqProfDataManager = interface(IUnknown)
    ['{7421A575-9691-4F9D-AD8E-E7354D2EFCF6}']
    function Get_TableCount: Integer; safecall;
    function Get_Tables(Index: Integer): IaqProfTable; safecall;
    function GetRecId(Row: AQPROF_TABLE_ROW): AQPROF_TABLE_RECID; safecall;
    function GetDataByRow(Row: AQPROF_TABLE_ROW; Accessor: AQPROF_TABLE_ACCESSOR): Pointer; safecall;
    function GetChildByRow(Row: AQPROF_TABLE_ROW; Accessor: AQPROF_TABLE_ACCESSOR): IaqProfTable; safecall;
    function AddTable(var SchemaInfo: AQPROF_TABLE_SCHEMA_INFO; const Callback: IaqProfTableCallback): IaqProfTable; safecall;
    function FindTable(const SchemaId: TGUID): IaqProfTable; safecall;
    function AddStringColumn(const Schema: IaqProfTableSchema; const Info: AQPROF_TABLE_COLUMN_INFO): IaqProfTableColumn; safecall;
    procedure PublishColumns(const FromSchemaId: TGUID; const ToSchema: IaqProfTableSchema); safecall;
    procedure PublishColumn(var FromSchemaId: TGUID; var ColumnID: TGUID; 
                            const ToSchema: IaqProfTableSchema); safecall;
    function AddString(const Text: WideString): AQPROF_COMPACT_STRING; safecall;
    function AddChars(Text: PWideChar): AQPROF_COMPACT_STRING; safecall;
    function GetString(StringId: AQPROF_COMPACT_STRING): WideString; safecall;
    function MergeChilds(const SchemaId: TGUID; const ChildSchemaId: TGUID): IaqProfTable; safecall;
    function CreateProvider(const Table: IaqProfTable): IaqProfTableProvider; safecall;
    function AddFileNameColumn(const Schema: IaqProfTableSchema; const Info: AQPROF_TABLE_COLUMN_INFO): IaqProfTableColumn; safecall;
    function GetFileName(StringId: AQPROF_COMPACT_STRING): WideString; safecall;
    function GetStoredSize: LongWord; safecall;
    property TableCount: Integer read Get_TableCount;
    property Tables[Index: Integer]: IaqProfTable read Get_Tables;
  end;

// *********************************************************************//
// Interface: IaqProfTable
// Flags:     (0)
// GUID:      {1E956DCA-CC74-4DB1-A884-E0567B1161B4}
// *********************************************************************//
  IaqProfTable = interface(IUnknown)
    ['{1E956DCA-CC74-4DB1-A884-E0567B1161B4}']
    function Get_Schema: IaqProfTableSchema; safecall;
    function Get_Parent: IaqProfTable; safecall;
    function Get_ParentRow: AQPROF_TABLE_ROW; safecall;
    function Get_Capacity: Integer; safecall;
    procedure Set_Capacity(Value: Integer); safecall;
    function Get_RowCount: Integer; safecall;
    function GetRow(RecId: AQPROF_TABLE_RECID): AQPROF_TABLE_ROW; safecall;
    function GetRecId(Row: AQPROF_TABLE_ROW): AQPROF_TABLE_RECID; safecall;
    function GetDataByRow(Row: AQPROF_TABLE_ROW; Accessor: AQPROF_TABLE_ACCESSOR): Pointer; safecall;
    function GetDataByRecId(RecId: AQPROF_TABLE_RECID; Accessor: AQPROF_TABLE_ACCESSOR): Pointer; safecall;
    function GetChildByRow(Row: AQPROF_TABLE_ROW; Accessor: AQPROF_TABLE_ACCESSOR): IaqProfTable; safecall;
    function GetChildByRecId(RecId: AQPROF_TABLE_RECID; Accessor: AQPROF_TABLE_ACCESSOR): IaqProfTable; safecall;
    function AddRow: AQPROF_TABLE_ROW; safecall;
    procedure DeleteByRow(Row: AQPROF_TABLE_ROW); safecall;
    procedure DeleteByRecId(RecId: AQPROF_TABLE_RECID); safecall;
    procedure Clear; safecall;
    function Contains(RecId: AQPROF_TABLE_RECID): WordBool; safecall;
    procedure FindRow(Row: AQPROF_TABLE_ROW; var Value: AQPROF_TABLE_ROW); safecall;
    function CreateEnum: AQPROF_TABLE_ENUM; safecall;
    procedure CloseEnum(Enum: AQPROF_TABLE_ENUM); safecall;
    function EnumRows(Enum: AQPROF_TABLE_ENUM; Rows: VOID_PTR; Count: Integer): Integer; safecall;
    function EnumRecords(Enum: AQPROF_TABLE_ENUM; RecIds: VOID_PTR; Count: Integer): Integer; safecall;
    procedure Copy(const DestTable: IaqProfTable); safecall;
    procedure Merge(const DstTable: IaqProfTable; var MergeInfo: AQPROF_TABLE_MERGE_INFO); safecall;
    procedure SaveToStream(const Stream: IaqStream); safecall;
    procedure LoadFromStream(const Stream: IaqStream); safecall;
    function GetRowManager: Pointer; stdcall;
    property Schema: IaqProfTableSchema read Get_Schema;
    property Parent: IaqProfTable read Get_Parent;
    property ParentRow: AQPROF_TABLE_ROW read Get_ParentRow;
    property Capacity: Integer read Get_Capacity write Set_Capacity;
    property RowCount: Integer read Get_RowCount;
  end;

// *********************************************************************//
// Interface: IaqProfTableSchema
// Flags:     (0)
// GUID:      {D85C3A87-572F-4CA1-AD0B-49C64A1F8C5C}
// *********************************************************************//
  IaqProfTableSchema = interface(IUnknown)
    ['{D85C3A87-572F-4CA1-AD0B-49C64A1F8C5C}']
    function Get_Parent: IaqProfTableSchema; safecall;
    function Get_Info: CPAQPROF_TABLE_SCHEMA_INFO; safecall;
    function Get_Accessor: AQPROF_TABLE_ACCESSOR; safecall;
    function Get_ChildIndex: Integer; safecall;
    function Get_ChildCount: Integer; safecall;
    function Get_Childs(Index: Integer): IaqProfTableSchema; safecall;
    function Get_ColumnCount: Integer; safecall;
    function Get_Columns(Index: Integer): IaqProfTableColumn; safecall;
    function AddColumn(const Info: AQPROF_TABLE_COLUMN_INFO;
                       const Callback: IaqProfTableColumnCallback; CallbackCookie: LongWord): IaqProfTableColumn; safecall;
    function AddChild(var Info: AQPROF_TABLE_SCHEMA_INFO; const Callback: IaqProfTableCallback): IaqProfTableSchema; safecall;
    function FindColumn(const Id: TGUID): IaqProfTableColumn; safecall;
    function FindChild(const Id: TGUID): IaqProfTableSchema; safecall;
    function FindAccessor(const Id: TGUID): AQPROF_TABLE_ACCESSOR; safecall;
    function AddProviderCallback(const Value: IaqProfTableProviderCallback): LongWord; safecall;
    procedure RemoveProviderCallback(CallbackCookie: LongWord); safecall;
    function CreateTable: IaqProfTable; safecall;
    property Parent: IaqProfTableSchema read Get_Parent;
    property Info: CPAQPROF_TABLE_SCHEMA_INFO read Get_Info;
    property Accessor: AQPROF_TABLE_ACCESSOR read Get_Accessor;
    property ChildIndex: Integer read Get_ChildIndex;
    property ChildCount: Integer read Get_ChildCount;
    property Childs[Index: Integer]: IaqProfTableSchema read Get_Childs;
    property ColumnCount: Integer read Get_ColumnCount;
    property Columns[Index: Integer]: IaqProfTableColumn read Get_Columns;
  end;

// *********************************************************************//
// Interface: IaqProfTableColumn
// Flags:     (0)
// GUID:      {2105915E-5959-421F-AA36-4E805FD46DF0}
// *********************************************************************//
  IaqProfTableColumn = interface(IUnknown)
    ['{2105915E-5959-421F-AA36-4E805FD46DF0}']
    function Get_Schema: IaqProfTableSchema; safecall;
    function Get_Info: CPAQPROF_TABLE_COLUMN_INFO; safecall;
    function Get_Accessor: AQPROF_TABLE_ACCESSOR; safecall;
    function Get_Index: Integer; safecall;
    function Get_UserMergeKind: AQPROF_TABLE_COLUMN_MERGE_KIND; safecall;
    procedure Set_UserMergeKind(Value: AQPROF_TABLE_COLUMN_MERGE_KIND); safecall;
    property Schema: IaqProfTableSchema read Get_Schema;
    property Info: CPAQPROF_TABLE_COLUMN_INFO read Get_Info;
    property Accessor: AQPROF_TABLE_ACCESSOR read Get_Accessor;
    property Index: Integer read Get_Index;
    property UserMergeKind: AQPROF_TABLE_COLUMN_MERGE_KIND read Get_UserMergeKind write Set_UserMergeKind;
  end;

// *********************************************************************//
// Interface: IaqProfTableColumnCallback
// Flags:     (0)
// GUID:      {79042041-8CB1-44AB-A8C6-785B9E03C5CA}
// *********************************************************************//
  IaqProfTableColumnCallback = interface(IUnknown)
    ['{79042041-8CB1-44AB-A8C6-785B9E03C5CA}']
    procedure OnGetFieldValue(Row: AQPROF_TABLE_ROW; Accessor: AQPROF_TABLE_ACCESSOR; 
                              Cookie: LongWord; var Value: OleVariant); safecall;
    procedure OnCopyFields(const SrcTable: IaqProfTable; const DestTable: IaqProfTable; 
                           RecId: AQPROF_TABLE_RECID; SrcField: VOID_PTR; DestField: VOID_PTR; 
                           Cookie: LongWord); safecall;
    procedure OnMergeFields(const SrcTable: IaqProfTable; const DestTable: IaqProfTable; 
                            RecId: AQPROF_TABLE_RECID; SrcField: VOID_PTR; DestField: VOID_PTR; 
                            const MergeInfo: AQPROF_TABLE_MERGE_INFO;
                            MergeKind: AQPROF_TABLE_COLUMN_MERGE_KIND; Cookie: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IaqProfTableCallback
// Flags:     (0)
// GUID:      {C2405983-7661-4E57-A175-EC7914C6F40F}
// *********************************************************************//
  IaqProfTableCallback = interface(IUnknown)
    ['{C2405983-7661-4E57-A175-EC7914C6F40F}']
    procedure OnCreateRow(Row: AQPROF_TABLE_ROW); safecall;
    function OnMergeRow(const DstTable: IaqProfTable; SrcRow: AQPROF_TABLE_ROW): AQPROF_TABLE_ROW; safecall;
  end;

// *********************************************************************//
// Interface: IaqProfTableProviderCallback
// Flags:     (0)
// GUID:      {10D3A427-B538-4FCA-B252-66CFACD84100}
// *********************************************************************//
  IaqProfTableProviderCallback = interface(IUnknown)
    ['{10D3A427-B538-4FCA-B252-66CFACD84100}']
    procedure OnBeginFillProvider(const Provider: IaqProfTableProvider; const Table: IaqProfTable); safecall;
    procedure OnEndFillProvider(const Provider: IaqProfTableProvider; const Table: IaqProfTable); safecall;
    function OnAddRow(const Table: IaqProfTable; Row: AQPROF_TABLE_ROW): Integer; safecall;
  end;

// *********************************************************************//
// Interface: IaqProfTableProvider
// Flags:     (0)
// GUID:      {E6EA944A-A465-447F-9303-EE68452AD904}
// *********************************************************************//
  IaqProfTableProvider = interface(IUnknown)
    ['{E6EA944A-A465-447F-9303-EE68452AD904}']
    function Get_Table: IaqProfTable; safecall;
    function Get_Schema: IaqProfTableSchema; safecall;
    function Get_Parent: IaqProfTableProvider; safecall;
    function Get_ParentRecId: AQPROF_TABLE_RECID; safecall;
    function Get_RowCount: Integer; safecall;
    function Get_ColCount: Integer; safecall;
    function Get_ChildCount: Integer; safecall;
    function GetRecId(RowIndex: Integer): AQPROF_TABLE_RECID; safecall;
    function GetRowIndex(RecId: AQPROF_TABLE_RECID): Integer; safecall;
    function GetValue(RowIndex: Integer; ColIndex: Integer): OleVariant; safecall;
    function GetChild(RowIndex: Integer; ChildIndex: Integer): IaqProfTableProvider; safecall;
    property Table: IaqProfTable read Get_Table;
    property Schema: IaqProfTableSchema read Get_Schema;
    property Parent: IaqProfTableProvider read Get_Parent;
    property ParentRecId: AQPROF_TABLE_RECID read Get_ParentRecId;
    property RowCount: Integer read Get_RowCount;
    property ColCount: Integer read Get_ColCount;
    property ChildCount: Integer read Get_ChildCount;
  end;

// *********************************************************************//
// Interface: IaqProfMergeCallback
// Flags:     (0)
// GUID:      {8145B073-3553-4B99-974C-215A55D3B97B}
// *********************************************************************//
  IaqProfMergeCallback = interface(IUnknown)
    ['{8145B073-3553-4B99-974C-215A55D3B97B}']
    procedure BeforeMerge(const MrgContext: IaqProfBaseContext; 
                          var MergeInfo: AQPROF_TABLE_MERGE_INFO); safecall;
    procedure Merge(const MrgContext: IaqProfBaseContext; var MergeInfo: AQPROF_TABLE_MERGE_INFO); safecall;
    procedure AfterMerge(const MrgContext: IaqProfBaseContext; 
                         var MergeInfo: AQPROF_TABLE_MERGE_INFO); safecall;
  end;

// *********************************************************************//
// Interface: IaqProfThreadMapperRegistry
// Flags:     (0)
// GUID:      {1C664E41-07C6-4B6E-A848-40F9372F8325}
// *********************************************************************//
  IaqProfThreadMapperRegistry = interface(IUnknown)
    ['{1C664E41-07C6-4B6E-A848-40F9372F8325}']
    function Get_Count: Integer; safecall;
    function Get_Items(Index: Integer): CPAQPROF_THREAD_MAPPER_INFO; safecall;
    function Find(const ThreadMapperId: TGUID): CPAQPROF_THREAD_MAPPER_INFO; safecall;
    procedure Register(const Info: AQPROF_THREAD_MAPPER_INFO); safecall;
    procedure Unregister(const ThreadMapperId: TGUID); safecall;
    property Count: Integer read Get_Count;
    property Items[Index: Integer]: CPAQPROF_THREAD_MAPPER_INFO read Get_Items;
  end;

// *********************************************************************//
// Interface: IaqProfCounterRegistry
// Flags:     (0)
// GUID:      {D069C862-44AC-47AD-BCE9-9D4F41130851}
// *********************************************************************//
  IaqProfCounterRegistry = interface(IUnknown)
    ['{D069C862-44AC-47AD-BCE9-9D4F41130851}']
    function Get_Count: Integer; safecall;
    function Get_Items(Index: Integer): CPAQPROF_COUNTER_INFO; safecall;
    function Find(const CounterId: TGUID): CPAQPROF_COUNTER_INFO; safecall;
    procedure Register(const Info: AQPROF_COUNTER_INFO); safecall;
    procedure Unregister(const CounterId: TGUID); safecall;
    property Count: Integer read Get_Count;
    property Items[Index: Integer]: CPAQPROF_COUNTER_INFO read Get_Items;
  end;

// *********************************************************************//
// Interface: IaqProfDynamicContext
// Flags:     (0)
// GUID:      {174746F6-E02E-4235-841C-258AF05DAF9E}
// *********************************************************************//
  IaqProfDynamicContext = interface(IaqProfBaseContext)
    ['{174746F6-E02E-4235-841C-258AF05DAF9E}']
    function Get_ThreadManager: IaqProfThreadManager; safecall;
    function Get_CounterManager: IaqProfCounterManager; safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_CurrentThreadEnabled: WordBool; safecall;
    procedure Set_CurrentThreadEnabled(Value: WordBool); safecall;
    function Get_CurrentThreadName: WideString; safecall;
    procedure Set_CurrentThreadName(const Value: WideString); safecall;
    function AddProfilingCallback(const Callback: IaqProfProfilingCallback): LongWord; safecall;
    procedure RemoveProfilingCallback(CallbackCookie: LongWord); stdcall;
    function AddMarshalCallback(const Callback: IaqProfMarshalCallback): LongWord; safecall;
    procedure RemoveMarshalCallback(CallbackCookie: LongWord); stdcall;
    function AddEventCallback(Event: AQPROF_EVENT; const Callback: AQPROF_EVENT_CALLBACK;
                              CallbackData: VOID_PTR; SequenceNumber: LongWord): LongWord; safecall;
    procedure RemoveEventCallback(Event: AQPROF_EVENT; CallbackCookie: LongWord); stdcall;
    procedure StartProfiling; stdcall;
    procedure StopProfiling; stdcall;
    procedure BeginUpdate(CalibrationCookie: LongWord); stdcall;
    procedure EndUpdate; stdcall;
    procedure NotifyEvent(Event: AQPROF_EVENT; EventData: CVOID_PTR); stdcall;
    procedure CalibrationBeginUpdate(CalibrationCookie: LongWord); stdcall;
    procedure CalibrationEndUpdate; stdcall;
    function WaitForStartProfiling: Integer; stdcall;
    function IsThreadEnabled(ThreadRow: AQPROF_TABLE_ROW): Integer; stdcall;
    property ThreadManager: IaqProfThreadManager read Get_ThreadManager;
    property CounterManager: IaqProfCounterManager read Get_CounterManager;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property CurrentThreadEnabled: WordBool read Get_CurrentThreadEnabled write Set_CurrentThreadEnabled;
    property CurrentThreadName: WideString read Get_CurrentThreadName write Set_CurrentThreadName;
  end;

// *********************************************************************//
// Interface: IaqProfThreadManager
// Flags:     (0)
// GUID:      {8716A0F4-B900-40A2-9AB9-7692A4361BB9}
// *********************************************************************//
  IaqProfThreadManager = interface(IUnknown)
    ['{8716A0F4-B900-40A2-9AB9-7692A4361BB9}']
    function Get_ThreadMapper: TGUID; safecall;
    procedure Set_ThreadMapper(Value: TGUID); safecall;
    function Get_ThreadEnabled: WordBool; safecall;
    procedure Set_ThreadEnabled(Value: WordBool); safecall;
    function GetThreadData(ThreadRid: AQPROF_TABLE_RECID): PAQPROF_THREAD_METADATA; safecall;
    procedure RenameThread(const OldThreadName: WideString; const NewThreadName: WideString); safecall;
    function AddThread: AQPROF_TABLE_RECID; stdcall;
    function GetCurrentThreadRow: AQPROF_TABLE_ROW; stdcall;
    function GetCurrentThreadRid: AQPROF_TABLE_RECID; stdcall;
    property ThreadMapper: TGUID read Get_ThreadMapper write Set_ThreadMapper;
    property ThreadEnabled: WordBool read Get_ThreadEnabled write Set_ThreadEnabled;
  end;

// *********************************************************************//
// Interface: IaqProfCounterManager
// Flags:     (0)
// GUID:      {483D8CE3-C4DB-4723-ACF2-939FED88779F}
// *********************************************************************//
  IaqProfCounterManager = interface(IUnknown)
    ['{483D8CE3-C4DB-4723-ACF2-939FED88779F}']
    function Get_Counter: TGUID; safecall;
    procedure Set_Counter(Value: TGUID); safecall;
    function Get_CurrentUnit: Integer; safecall;
    procedure Set_CurrentUnit(Value: Integer); safecall;
    function AddCounterColumn(const Schema: IaqProfTableSchema; const Info: AQPROF_TABLE_COLUMN_INFO): IaqProfTableColumn; safecall;
    function Calibrate(SourceFunc: AQPROF_CALIBRATION_FUNCTION; 
                       PatchedFunc: AQPROF_CALIBRATION_FUNCTION): LongWord; safecall;
    function GetCurrentThreadCounter: AQPROF_RAW_COUNTER; safecall;
    function GetCurrentCounterObject: IaqProfCounter; safecall;
    property Counter: TGUID read Get_Counter write Set_Counter;
    property CurrentUnit: Integer read Get_CurrentUnit write Set_CurrentUnit;
  end;

// *********************************************************************//
// Interface: IaqProfCounter
// Flags:     (0)
// GUID:      {12201681-D9E5-4B3C-A18E-6CBB74F90B99}
// *********************************************************************//
  IaqProfCounter = interface(IUnknown)
    ['{12201681-D9E5-4B3C-A18E-6CBB74F90B99}']
    procedure InitializeCounter(const CounterId: TGUID); safecall;
    function CalculateValue(UnitIndex: Integer; RawValue: AQPROF_RAW_COUNTER): OleVariant; safecall;
    function CalculateRawValue(UnitIndex: Integer; Value: OleVariant): AQPROF_RAW_COUNTER; safecall;
    function BeginUpdate: AQPROF_RAW_COUNTER; stdcall;
    function EndUpdate: AQPROF_RAW_COUNTER; stdcall;
    function GetCalibrationFix: Double; stdcall;
    function Get_IsTimeCounter: WordBool; safecall;
    property IsTimeCounter: WordBool read Get_IsTimeCounter;
  end;

// *********************************************************************//
// Interface: IaqProfProfilingCallback
// Flags:     (0)
// GUID:      {976CC1B0-0C10-48A1-8ECD-D8B34AA751B6}
// *********************************************************************//
  IaqProfProfilingCallback = interface(IUnknown)
    ['{976CC1B0-0C10-48A1-8ECD-D8B34AA751B6}']
    procedure OnStartProfiling; stdcall;
    procedure OnStopProfiling; stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfMarshalCallback
// Flags:     (0)
// GUID:      {525F2A79-529E-42D6-95A7-32B57651601C}
// *********************************************************************//
  IaqProfMarshalCallback = interface(IUnknown)
    ['{525F2A79-529E-42D6-95A7-32B57651601C}']
    procedure OnBeforeMarshal(const Stream: IaqStream); stdcall;
    procedure OnAfterMarshal(const Stream: IaqStream); stdcall;
    procedure OnBeforeUnmarshal(const Stream: IaqStream); stdcall;
    procedure OnAfterUnmarshal(const Stream: IaqStream); stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfSessionListener
// Flags:     (0)
// GUID:      {9ACA8BCE-4250-4AA8-B86C-C7D7433C2685}
// *********************************************************************//
  IaqProfSessionListener = interface(IUnknown)
    ['{9ACA8BCE-4250-4AA8-B86C-C7D7433C2685}']
    procedure OnTakeSnapshot(const Context: IaqProfDynamicContext; CloseSession: WordBool); safecall;
    procedure OnChangeEnabled(Value: WordBool); safecall;
    procedure OnSessionEvent(const EventID: TGUID; Data: CVOID_PTR; DataSize: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IaqProfSession
// Flags:     (0)
// GUID:      {2EFDECFC-3840-4501-955C-3F00FD4A02C2}
// *********************************************************************//
  IaqProfSession = interface(IUnknown)
    ['{2EFDECFC-3840-4501-955C-3F00FD4A02C2}']
    procedure StartChangeEnabled(Value: WordBool); safecall;
    procedure StartTakeSnapshot; safecall;
    procedure StopTakeSnapshot; safecall;
    procedure ForceGC; safecall;
    procedure Close; safecall;
    procedure SendEvent(const EventID: TGUID; Data: CVOID_PTR; DataSize: LongWord); safecall;
    procedure AsyncSendEvent(const EventID: TGUID; Data: CVOID_PTR; DataSize: LongWord); safecall;
    procedure ClearResults; safecall;
  end;

// *********************************************************************//
// Interface: IaqProfProcessCallback
// Flags:     (0)
// GUID:      {42466E47-0BD9-4E94-BF78-3749A57D6CE0}
// *********************************************************************//
  IaqProfProcessCallback = interface(IUnknown)
    ['{42466E47-0BD9-4E94-BF78-3749A57D6CE0}']
    procedure OnBeforeTakeSnapshot(CloseSession: Integer); stdcall;
    procedure OnAfterTakeSnapshot(CloseSession: Integer); stdcall;
    procedure OnForceGC; stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfTableColumnType
// Flags:     (0)
// GUID:      {A3ED49B2-76A1-4CE0-B937-451A163EC1D7}
// *********************************************************************//
  IaqProfTableColumnType = interface(IUnknown)
    ['{A3ED49B2-76A1-4CE0-B937-451A163EC1D7}']
    function IsSimple: Integer; stdcall;
    function GetDataSize: LongWord; stdcall;
    procedure Clear(Data: VOID_PTR); stdcall;
    procedure Copy(DstData: VOID_PTR; SrcData: VOID_PTR); stdcall;
    procedure Merge(DstData: VOID_PTR; SrcData: VOID_PTR; var MergeInfo: AQPROF_TABLE_MERGE_INFO; 
                    MergeKind: AQPROF_TABLE_COLUMN_MERGE_KIND); stdcall;
    procedure Write(const Stream: IaqStream; Data: VOID_PTR); stdcall;
    procedure Read(const Stream: IaqStream; Data: VOID_PTR); stdcall;
    procedure GetValue(Data: VOID_PTR; out Value: OleVariant); stdcall;
    function Compare(Data1: VOID_PTR; Data2: VOID_PTR): Integer; stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfTableType
// Flags:     (0)
// GUID:      {62EC67D1-38F7-4135-B718-DF1BA996FD4A}
// *********************************************************************//
  IaqProfTableType = interface(IUnknown)
    ['{62EC67D1-38F7-4135-B718-DF1BA996FD4A}']
    function GetDataSize: LongWord; stdcall;
    procedure Construct(Data: VOID_PTR); stdcall;
    procedure Destroy(Data: VOID_PTR); stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfThreadMapper
// Flags:     (0)
// GUID:      {A709902E-767E-44C1-B13E-7B36A092A552}
// *********************************************************************//
  IaqProfThreadMapper = interface(IUnknown)
    ['{A709902E-767E-44C1-B13E-7B36A092A552}']
    function GetCurrentThreadRid: AQPROF_TABLE_RECID; stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfCounterFrequency
// Flags:     (0)
// GUID:      {8DB03846-916D-4848-9ED2-866CAACC50B9}
// *********************************************************************//
  IaqProfCounterFrequency = interface(IUnknown)
    ['{8DB03846-916D-4848-9ED2-866CAACC50B9}']
    function Get_Frequency: AQPROF_RAW_COUNTER; safecall;
    procedure Set_Frequency(Value: AQPROF_RAW_COUNTER); safecall;
    property Frequency: AQPROF_RAW_COUNTER read Get_Frequency write Set_Frequency;
  end;

// *********************************************************************//
// Interface: IaqProfModuleLevel
// Flags:     (0)
// GUID:      {5C5FF40D-1E6D-4564-AADD-1D2F829928E6}
// *********************************************************************//
  IaqProfModuleLevel = interface(IUnknown)
    ['{5C5FF40D-1E6D-4564-AADD-1D2F829928E6}']
    function AddModule: AQPROF_TABLE_RECID; safecall;
    function GetModuleMetaData(ModuleRid: AQPROF_TABLE_RECID): PAQPROF_MODULE_METADATA; safecall;
    function FindModule(ModuleName: AQPROF_COMPACT_STRING): AQPROF_TABLE_RECID; safecall;
  end;

// *********************************************************************//
// Interface: IaqProfSourceFileLevel
// Flags:     (0)
// GUID:      {D9AAFD53-5876-4A07-ABF4-3F3791422551}
// *********************************************************************//
  IaqProfSourceFileLevel = interface(IUnknown)
    ['{D9AAFD53-5876-4A07-ABF4-3F3791422551}']
    function AddSourceFile: AQPROF_TABLE_RECID; safecall;
    function GetSourceFileMetaData(SourceFileRid: AQPROF_TABLE_RECID): PAQPROF_SOURCE_FILE_METADATA; safecall;
    function FindSourceFile(FileName: AQPROF_COMPACT_STRING): AQPROF_TABLE_RECID; safecall;
  end;

// *********************************************************************//
// Interface: IaqProfClassLevel
// Flags:     (0)
// GUID:      {4C61EB29-F0CE-470D-B757-0B73A013E6E6}
// *********************************************************************//
  IaqProfClassLevel = interface(IUnknown)
    ['{4C61EB29-F0CE-470D-B757-0B73A013E6E6}']
    function AddClass: AQPROF_TABLE_RECID; safecall;
    function GetClassMetaData(ClassRid: AQPROF_TABLE_RECID): PAQPROF_CLASS_METADATA; safecall;
    function FindClass(ClsName: AQPROF_COMPACT_STRING): AQPROF_TABLE_RECID; safecall;
  end;

// *********************************************************************//
// Interface: IaqProfRoutineLevel
// Flags:     (0)
// GUID:      {5A0C191C-540D-4331-8877-2594592EC3A2}
// *********************************************************************//
  IaqProfRoutineLevel = interface(IUnknown)
    ['{5A0C191C-540D-4331-8877-2594592EC3A2}']
    function AddRoutine: AQPROF_TABLE_RECID; safecall;
    function GetRoutineMetaData(RoutineRid: AQPROF_TABLE_RECID): PAQPROF_ROUTINE_METADATA; safecall;
    function GetLineMetaData(RoutineRid: AQPROF_TABLE_RECID; LineRid: AQPROF_TABLE_RECID): PAQPROF_LINE_METADATA; safecall;
    procedure UpdateLineInformation(RoutineRid: AQPROF_TABLE_RECID); safecall;
  end;

// *********************************************************************//
// Interface: IaqProfObjectLevel
// Flags:     (0)
// GUID:      {E0BCBC94-1AC0-43DC-839E-E8E77133CADE}
// *********************************************************************//
  IaqProfObjectLevel = interface(IUnknown)
    ['{E0BCBC94-1AC0-43DC-839E-E8E77133CADE}']
    function CreateObjectRid: AQPROF_TABLE_RECID; safecall;
    function GetObjectData(ObjectRid: AQPROF_TABLE_RECID): PAQPROF_OBJECT_DATA; safecall;
  end;

// *********************************************************************//
// Interface: IaqProfWin32ThreadMapper
// Flags:     (0)
// GUID:      {A8F27470-4AB5-4DBB-9D23-F6BC05372591}
// *********************************************************************//
  IaqProfWin32ThreadMapper = interface(IaqProfThreadMapper)
    ['{A8F27470-4AB5-4DBB-9D23-F6BC05372591}']
    procedure ThreadDestroyed(ThreadID: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IaqProfClrThreadMapper
// Flags:     (0)
// GUID:      {EE3D1E04-5D17-4111-B9FD-D3F98F1EA6A0}
// *********************************************************************//
  IaqProfClrThreadMapper = interface(IaqProfThreadMapper)
    ['{EE3D1E04-5D17-4111-B9FD-D3F98F1EA6A0}']
    procedure CorInitialized(const CorProfInfo: IUnknown); safecall;
    procedure CorFinalized; safecall;
    procedure CorThreadAssignedToWin32Thread(CorThreadId: UINT_PTR; Win32ThreadId: LongWord); safecall;
    procedure CorThreadDestroyed(ThreadID: UINT_PTR); safecall;
    procedure Win32ThreadDestroyed(ThreadID: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IaqProfTriggers
// Flags:     (0)
// GUID:      {42726E92-02AF-4DCD-855D-AABF1E50096C}
// *********************************************************************//
  IaqProfTriggers = interface(IUnknown)
    ['{42726E92-02AF-4DCD-855D-AABF1E50096C}']
    function GetTriggerMetaData(RoutineRid: AQPROF_TABLE_RECID): PAQPROF_TRIGGER_METADATA; safecall;
  end;

// *********************************************************************//
// Interface: IaqProfActions
// Flags:     (0)
// GUID:      {F77090B2-F0B6-4713-98A1-966D4FB619BD}
// *********************************************************************//
  IaqProfActions = interface(IUnknown)
    ['{F77090B2-F0B6-4713-98A1-966D4FB619BD}']
    function GetActionMetaData(RoutineRid: AQPROF_TABLE_RECID): PAQPROF_ACTION_METADATA; safecall;
  end;

// *********************************************************************//
// Interface: IaqProfContextPostPrecessor
// Flags:     (0)
// GUID:      {3677FFD2-A7F0-4045-B4D8-74E7E805A7C7}
// *********************************************************************//
  IaqProfContextPostPrecessor = interface(IUnknown)
    ['{3677FFD2-A7F0-4045-B4D8-74E7E805A7C7}']
    procedure PostProcess; stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfLightCoverage
// Flags:     (0)
// GUID:      {9D434641-9082-40E7-A8CA-15314283449B}
// *********************************************************************//
  IaqProfLightCoverage = interface(IaqProfContextPostPrecessor)
    ['{9D434641-9082-40E7-A8CA-15314283449B}']
    procedure MarkRoutine(RoutineRid: AQPROF_TABLE_RECID); safecall;
    procedure AddBlock(RoutineRid: AQPROF_TABLE_RECID; LineIndex: LongWord; IsMarked: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IaqProfRowset
// Flags:     (0)
// GUID:      {4508566F-31E3-400A-9BA4-3BD49C750DA1}
// *********************************************************************//
  IaqProfRowset = interface
    ['{4508566F-31E3-400A-9BA4-3BD49C750DA1}']
    function GetCapacity: UINT_PTR; stdcall;
    procedure SetCapacity(Value: UINT_PTR); stdcall;
    function GetRowCount: UINT_PTR; stdcall;
    function AddRow: AQPROF_TABLE_ROW; stdcall;
    procedure DeleteRow(RecId: AQPROF_TABLE_RECID); stdcall;
    procedure Clear; stdcall;
    function GetRow(RecId: AQPROF_TABLE_RECID): AQPROF_TABLE_ROW; stdcall;
    function Contains(RecId: AQPROF_TABLE_RECID): AQPROF_TABLE_ROW; stdcall;
    function CreateEnum: CPAQPROF_TABLE_ENUM2; stdcall;
    procedure CloseEnum(var Enum: AQPROF_TABLE_ENUM2); stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfRoutineHitCounter
// Flags:     (0)
// GUID:      {532AEA2A-EFE4-4E37-9905-E424905E0328}
// *********************************************************************//
  IaqProfRoutineHitCounter = interface(IUnknown)
    ['{532AEA2A-EFE4-4E37-9905-E424905E0328}']
    function GetRoutineHitCount(RoutineRid: AQPROF_TABLE_RECID): LongWord; safecall;
  end;

// *********************************************************************//
// Interface: IaqClrSymbolStore
// Flags:     (0)
// GUID:      {FED65C87-A24A-4733-A332-3297FE461707}
// *********************************************************************//
  IaqClrSymbolStore = interface(IaqDbgSymbolStore)
    ['{FED65C87-A24A-4733-A332-3297FE461707}']
    function FindRoutine(Token: INT_PTR; out Value: IaqClrRoutine): Integer; stdcall;
    procedure GetMethodRefMoniker(Token: INT_PTR; out Value: WideString); stdcall;
  end;

// *********************************************************************//
// Interface: IaqClrRoutine
// Flags:     (0)
// GUID:      {D0FC2E9D-A091-428D-88D5-D27A4AF4AA82}
// *********************************************************************//
  IaqClrRoutine = interface(IaqDbgRoutine)
    ['{D0FC2E9D-A091-428D-88D5-D27A4AF4AA82}']
    function Get_Token: INT_PTR; safecall;
    function IsPInvoke: Integer; stdcall;
    function GetRVA: LongWord; stdcall;
    function IsUnmanaged: WordBool; stdcall;
    property Token: INT_PTR read Get_Token;
  end;

// *********************************************************************//
// Interface: IaqClrClass
// Flags:     (0)
// GUID:      {9DD9D21A-BF19-4D44-8603-D4A893A264A5}
// *********************************************************************//
  IaqClrClass = interface(IaqDbgClass)
    ['{9DD9D21A-BF19-4D44-8603-D4A893A264A5}']
    function Get_Token: INT_PTR; safecall;
    function Get_Namespace: IaqClrNamespace; safecall;
    property Token: INT_PTR read Get_Token;
    property Namespace: IaqClrNamespace read Get_Namespace;
  end;

// *********************************************************************//
// Interface: IaqClrNamespace
// Flags:     (0)
// GUID:      {2FD28638-62EC-4C3D-A827-52E62FBEA9F4}
// *********************************************************************//
  IaqClrNamespace = interface(IaqDbgSymbol)
    ['{2FD28638-62EC-4C3D-A827-52E62FBEA9F4}']
  end;

// *********************************************************************//
// Interface: IaqClrPatchManager
// Flags:     (0)
// GUID:      {ABFD3A6B-DEFE-4BE8-A9E6-8D12F2D39189}
// *********************************************************************//
  IaqClrPatchManager = interface(IUnknown)
    ['{ABFD3A6B-DEFE-4BE8-A9E6-8D12F2D39189}']
    procedure AddCallback(const Callback: IaqClrPatcherCallback; Events: LongWord); safecall;
    procedure AddHook(HookFunc: UINT_PTR; CallConv: LongWord; ParamCount: LongWord); safecall;
    procedure AddClrHook(Id: TGUID; AssemblyName: PWideChar; TypeName: PWideChar; 
                         MethodName: PWideChar); safecall;
    function GetClrHookProps(ModuleId: UINT_PTR; FunctionID: UINT_PTR; Id: TGUID; 
                             var SigBlob: Byte; SigSize: LongWord): SYSINT; safecall;
    procedure RemoveCallback(const Callback: IaqClrPatcherCallback); safecall;
    procedure Patch(FuncId: UINT_PTR); safecall;
  end;

// *********************************************************************//
// Interface: IaqClrPatcherCallback
// Flags:     (0)
// GUID:      {39DA2AB6-EF23-4F5A-96D6-7B222F6BCAAC}
// *********************************************************************//
  IaqClrPatcherCallback = interface(IUnknown)
    ['{39DA2AB6-EF23-4F5A-96D6-7B222F6BCAAC}']
    procedure OnPatcherEvent(const Patcher: IaqClrPatcher; Event: AQ_CLR_PATCH_EVENT; 
                             CodeIndex: LongWord; CodeOffset: LongWord; Param: VOID_PTR); safecall;
  end;

// *********************************************************************//
// Interface: IaqClrPatcher
// Flags:     (0)
// GUID:      {92B4C855-DB19-4738-A134-EA6C09A1531B}
// *********************************************************************//
  IaqClrPatcher = interface(IUnknown)
    ['{92B4C855-DB19-4738-A134-EA6C09A1531B}']
    function Get_Manager: IaqClrPatchManager; safecall;
    procedure AddCode(Code: LongWord; Param: Int64); safecall;
    procedure CallHook(HookFunc: UINT_PTR; Params: UINT_PTR); safecall;
    procedure GetFunctionProps(out FuncId: UINT_PTR; out ModuleId: UINT_PTR; 
                               out MethodToken: UINT_PTR); safecall;
    property Manager: IaqClrPatchManager read Get_Manager;
  end;

// *********************************************************************//
// Interface: IaqScriptRoutine
// Flags:     (0)
// GUID:      {B67676D9-4554-4FC4-A093-53F1E9CDFA7E}
// *********************************************************************//
  IaqScriptRoutine = interface(IaqDbgRoutine)
    ['{B67676D9-4554-4FC4-A093-53F1E9CDFA7E}']
  end;

// *********************************************************************//
// Interface: IaqInternalNativeSymbolStore
// Flags:     (0)
// GUID:      {3886E03D-E55C-4F87-BD15-841F6CC0DF8A}
// *********************************************************************//
  IaqInternalNativeSymbolStore = interface(IaqDbgSymbolStore)
    ['{3886E03D-E55C-4F87-BD15-841F6CC0DF8A}']
    function FindInternalProcedure(const Name: WideString; out nativeProcedure: IaqNativeProcedure): WordBool; safecall;
  end;

// *********************************************************************//
// Interface: IaqNativeProcedure
// Flags:     (0)
// GUID:      {2FA4BF32-33B0-496A-90DA-478324D44081}
// *********************************************************************//
  IaqNativeProcedure = interface(IaqDbgRoutine)
    ['{2FA4BF32-33B0-496A-90DA-478324D44081}']
    function Get_Address: UINT_PTR; safecall;
    function Get_Size: Integer; safecall;
    function Get_UnitName: WideString; safecall;
    function Get_Unit: IaqDbgSymbol; safecall;
    function Get_NameOfClass: WideString; safecall;
    function Get_CallingConvention: Integer; safecall;
    function Get_ParametersCount: Integer; safecall;
    procedure GetParameter(Index: Integer; out Value: IaqNativeProcedureType); safecall;
    procedure GetParameterName(Index: Integer; out Value: WideString); safecall;
    function Get_ReturnValue: IaqNativeProcedureType; safecall;
    function Get_AccessType: AQNATSYM_ACCESS_TYPE; safecall;
    function Get_ThisLocation: AQNATSYM_THIS_LOCATION; safecall;
    function Get_IsStatic: WordBool; safecall;
    function Get_HasLongJumpStuff: WordBool; safecall;
    property Address: UINT_PTR read Get_Address;
    property Size: Integer read Get_Size;
    property UnitName: WideString read Get_UnitName;
    property NameOfClass: WideString read Get_NameOfClass;
    property CallingConvention: Integer read Get_CallingConvention;
    property ParametersCount: Integer read Get_ParametersCount;
    property ReturnValue: IaqNativeProcedureType read Get_ReturnValue;
    property AccessType: AQNATSYM_ACCESS_TYPE read Get_AccessType;
    property ThisLocation: AQNATSYM_THIS_LOCATION read Get_ThisLocation;
    property IsStatic: WordBool read Get_IsStatic;
    property HasLongJumpStuff: WordBool read Get_HasLongJumpStuff;
  end;

// *********************************************************************//
// Interface: IaqNativeProcedureType
// Flags:     (0)
// GUID:      {296EDCC4-7473-47D1-8E14-E18DCA44F41F}
// *********************************************************************//
  IaqNativeProcedureType = interface(IUnknown)
    ['{296EDCC4-7473-47D1-8E14-E18DCA44F41F}']
    function Get_Name: WideString; safecall;
    function Get_MemSize: Integer; safecall;
    function Get_type_: IaqNativeStoreType; safecall;
    property Name: WideString read Get_Name;
    property MemSize: Integer read Get_MemSize;
    property type_: IaqNativeStoreType read Get_type_;
  end;

// *********************************************************************//
// Interface: IaqNativeStoreType
// Flags:     (0)
// GUID:      {3B724334-CF44-4809-8519-AB636C5E37B8}
// *********************************************************************//
  IaqNativeStoreType = interface(IUnknown)
    ['{3B724334-CF44-4809-8519-AB636C5E37B8}']
    function Get_Name: WideString; safecall;
    function Get_Kind: Integer; safecall;
    function Get_TypeCount: Integer; safecall;
    procedure GetType(Index: Integer; out Value: IaqNativeStoreType); safecall;
    procedure GetTypeInfo(out Value: IaqNativeStoreTypeInfo); safecall;
    procedure GetReference(out Value: WordBool); safecall;
    property Name: WideString read Get_Name;
    property Kind: Integer read Get_Kind;
    property TypeCount: Integer read Get_TypeCount;
  end;

// *********************************************************************//
// Interface: IaqNativeStoreTypeInfo
// Flags:     (0)
// GUID:      {88F09B69-7E93-43C7-9005-2CBD98CD6002}
// *********************************************************************//
  IaqNativeStoreTypeInfo = interface(IUnknown)
    ['{88F09B69-7E93-43C7-9005-2CBD98CD6002}']
  end;

// *********************************************************************//
// Interface: IaqNativeSymbolStore
// Flags:     (0)
// GUID:      {250C9B2E-A58A-4EA5-BE50-7F46C6EF2728}
// *********************************************************************//
  IaqNativeSymbolStore = interface(IaqInternalNativeSymbolStore)
    ['{250C9B2E-A58A-4EA5-BE50-7F46C6EF2728}']
    function FindRoutine(Address: UINT_PTR): IaqDbgRoutine; safecall;
    function FindRoutineByAddress(Address: UINT_PTR; out DbgRoutine: IaqDbgRoutine; 
                                  out LineNo: Integer): WordBool; safecall;
    function ApplicationType: Integer; safecall;
    function GetModuleBase: Int64; safecall;
    function FindRoutineByName(const UnitName: WideString; const ClsName: WideString; 
                               const RoutineName: WideString; out FoundRoutine: IaqDbgRoutine): WordBool; stdcall;
    function SystemType: Integer; safecall;
  end;

// *********************************************************************//
// Interface: IaqNativeClass
// Flags:     (0)
// GUID:      {3A488545-819E-44C9-AD3A-F2BE2E7F4E46}
// *********************************************************************//
  IaqNativeClass = interface(IaqDbgClass)
    ['{3A488545-819E-44C9-AD3A-F2BE2E7F4E46}']
    function Get_type_: IaqNativeStoreType; safecall;
    function Get_DbgUnit: IaqDbgSymbol; safecall;
    property type_: IaqNativeStoreType read Get_type_;
    property DbgUnit: IaqDbgSymbol read Get_DbgUnit;
  end;

// *********************************************************************//
// Interface: IaqNativeStoreTypeInfoClass
// Flags:     (0)
// GUID:      {8803156E-4B27-44C9-8E38-7B27FD6BA9E9}
// *********************************************************************//
  IaqNativeStoreTypeInfoClass = interface(IUnknown)
    ['{8803156E-4B27-44C9-8E38-7B27FD6BA9E9}']
    function Get_MemberCount: Integer; safecall;
    procedure GetMember(Index: Integer; out Name: WideString; out Type_: IaqNativeStoreType; 
                        out Offset: Integer; out BitPos: Integer; out BitLen: Integer; 
                        out Access: AQNATSYM_ACCESS_TYPE); safecall;
    function Get_PropertyCount: Integer; safecall;
    procedure GetProperty(Index: Integer; out Name: WideString; out Type_: IaqNativeStoreType; 
                          out IndexType: IaqNativeStoreType; out ReadOffset: Integer; 
                          out ReadRoutine: WideString; out WriteOffset: Integer; 
                          out WriteRoutine: WideString; out Access: AQNATSYM_ACCESS_TYPE); safecall;
    function Get_BaseClassCount: Integer; safecall;
    procedure GetBaseClass(Index: Integer; out Value: IaqNativeClass); safecall;
    function Get_ConstructrCount: Integer; safecall;
    procedure GetConstructorName(Index: Integer; out Value: WideString); safecall;
    function Get_ClassSize: Integer; safecall;
    property MemberCount: Integer read Get_MemberCount;
    property PropertyCount: Integer read Get_PropertyCount;
    property BaseClassCount: Integer read Get_BaseClassCount;
    property ConstructrCount: Integer read Get_ConstructrCount;
    property ClassSize: Integer read Get_ClassSize;
  end;

// *********************************************************************//
// Interface: IaqNativeStoreTypeInfoEnum
// Flags:     (0)
// GUID:      {B0AD891E-A4B7-4EAA-82B9-9238D038EA9D}
// *********************************************************************//
  IaqNativeStoreTypeInfoEnum = interface(IUnknown)
    ['{B0AD891E-A4B7-4EAA-82B9-9238D038EA9D}']
    function Get_ElementCount: Integer; safecall;
    procedure GetElement(Index: Integer; out Name: WideString; out Type_: IaqNativeStoreType; 
                         out Value: OleVariant); safecall;
    property ElementCount: Integer read Get_ElementCount;
  end;

// *********************************************************************//
// Interface: IaqExportRoutine
// Flags:     (0)
// GUID:      {F42C16B3-F546-4C47-BE0A-91ED241420AF}
// *********************************************************************//
  IaqExportRoutine = interface(IaqDbgRoutine)
    ['{F42C16B3-F546-4C47-BE0A-91ED241420AF}']
    function GetAddress: UINT_PTR; stdcall;
    function GetOrdinal: LongWord; stdcall;
    function GetCalculatedSize: Integer; stdcall;
    procedure GetModuleName(out ModuleName: WideString); stdcall;
    procedure GetUnitName(out UnitName: WideString); stdcall;
    procedure GetClassName(out ClassName: WideString); stdcall;
    procedure GetMangledName(out Name: WideString); stdcall;
    procedure GetUnit(out Value: IaqDbgSymbol); stdcall;
  end;

// *********************************************************************//
// Interface: IaqPatcher
// Flags:     (0)
// GUID:      {6CBD2119-D2D0-4E04-91C8-47EAF6F476D6}
// *********************************************************************//
  IaqPatcher = interface(IUnknown)
    ['{6CBD2119-D2D0-4E04-91C8-47EAF6F476D6}']
    procedure Initialize(addressMap: LongWord; injectedMap: LongWord; mapStart: LongWord; 
                         maxMapSize: LongWord; const DebugProcess: IaqDebugProcess; 
                         PatchType: AQPatchType); safecall;
    procedure SetApplicationType(Type_: AQNATSYM_APPLICATION_TYPE); safecall;
    procedure SetInitExceptionBlockLDTCAddress(initExceptionBlockLDTCAddress: LongWord); safecall;
    procedure PatchVBAExceptHandler(ExceptHandlerAddress: LongWord); safecall;
    function PatchFunction(FunctionID: LongWord; Start: LongWord; Size: LongWord; 
                           EnterHook: LongWord; Blocks: LongWord; blocksCount: LongWord; 
                           Lines: LongWord; linesCount: LongWord; patchByLines: WordBool; 
                           useInLinesBlocks: WordBool; out NewStartAddress: LongWord; 
                           out NewSize: LongWord; out funcExist: WordBool; out retExist: WordBool): WordBool; safecall;
    procedure SetCurrentMapPosition(newPosition: LongWord); stdcall;
    function GetCurrentMapPosition: LongWord; stdcall;
    procedure PatchImportFunctions(const ModuleName: WideString; BaseAddress: Largeuint; 
                                   const ExporterModuleName: WideString; Functions: LongWord; 
                                   FunctionCount: LongWord); stdcall;
  end;

// *********************************************************************//
// Interface: IaqPatcherX64
// Flags:     (0)
// GUID:      {F4033582-F35E-44A9-ADD5-06401EBA71E7}
// *********************************************************************//
  IaqPatcherX64 = interface(IUnknown)
    ['{F4033582-F35E-44A9-ADD5-06401EBA71E7}']
    procedure Initialize(addressMap: LongWord; injectedMap: Largeuint; mapStart: LongWord; 
                         maxMapSize: LongWord; const DebugProcess: IaqDebugProcess; 
                         PatchType: AQPatchType); safecall;
    procedure StartPatchingModule(FunctionEnterHookAddress: Largeuint; 
                                  BlockEnterHookAddress: Largeuint; BaseAddress: Largeuint; 
                                  ModuleSize: Integer; AssumedPatchedSize: Integer; 
                                  GSHandlerCheck_EH_RVA: LongWord; 
                                  GSHandlerCheck_SEH_RVA: LongWord; CxxFrameHandler3_RVA: LongWord; 
                                  C_specific_handler_RVA: LongWord); safecall;
    procedure EndPatchingModule(out NewBaseAddress: Largeuint; out NewEndAddress: Largeuint); safecall;
    procedure ModuleUnloaded(BaseAddress: Largeuint; ModuleSize: Integer); safecall;
    function PatchFunction(FunctionID: LongWord; Start: Largeuint; Size: LongWord; 
                           EnterHook: LongWord; Blocks: LongWord; blocksCount: LongWord; 
                           Lines: LongWord; linesCount: LongWord; patchByLines: WordBool; 
                           useInLinesBlocks: WordBool; out NewStartAddress: Largeuint; 
                           out NewSize: LongWord; out funcExist: WordBool; out retExist: WordBool): WordBool; safecall;
    procedure SetCurrentMapPosition(newPosition: LongWord); stdcall;
    function GetCurrentMapPosition: LongWord; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDbgHelp
// Flags:     (0)
// GUID:      {2548C27F-5813-43A5-84AB-A4534B2F8C88}
// *********************************************************************//
  IaqDbgHelp = interface(IUnknown)
    ['{2548C27F-5813-43A5-84AB-A4534B2F8C88}']
    function GetPEFile(const Name: WideString; out PEFile: IaqPEFile): WordBool; stdcall;
    function FindPEFileImportModulePath(const ModulePath: WideString; 
                                        const ImportModuleName: WideString; 
                                        out ImportModulePath: WideString): WordBool; stdcall;
    procedure WalkStack(var StartInfo: AQDBGHELP_START_WALKSTACK_INFO; 
                        const Helper: IaqStackWalkHelper; out Stack: IaqDbgHelpStack); stdcall;
    procedure WalkStack64(var StartInfo: AQDBGHELP_START_WALKSTACK_INFO64; 
                          const Helper: IaqStackWalkHelper; out Stack: IaqDbgHelpStack); stdcall;
    function CreateProcess(const Path: WideString; const Param: WideString; 
                           const WorkFolder: WideString; TimeOut: LongWord; 
                           out ProcessID: LongWord; out ThreadID: LongWord): WordBool; stdcall;
    function CreateProcessAsUser(const Login: WideString; const Domain: WideString; 
                                 const Password: WideString; const Path: WideString; 
                                 const Param: WideString; const WorkFolder: WideString; 
                                 TimeOut: LongWord; out ProcessID: LongWord; 
                                 out ThreadID: LongWord; out LogonFailed: WordBool): WordBool; stdcall;
    procedure GetExceptionDescription(ProcessID: LongWord; var Exception: AQ_EXCEPTION_INFO; 
                                      out Description: WideString); stdcall;
    procedure GetProcessList(out ProcessList: IaqDbgHelpProcessList); stdcall;
    procedure GetProcessListLight(out ProcessList: IaqDbgHelpProcessListLight); stdcall;
    function GetProcessInformation(ProcessID: LongWord; out Information: AQ_PROCESS_INFORMATION): WordBool; stdcall;
    function CheckProcessExistById(ProcessID: LongWord): WordBool; stdcall;
    function CheckProcessExistByName(const ProcessName: WideString): WordBool; stdcall;
    function IsProcessX64(ProcessID: LongWord): WordBool; stdcall;
    function IsThreadSuspended(ThreadID: LongWord): WordBool; stdcall;
    procedure GetModulesList(ProcessID: LongWord; out ModuleList: IaqModuleList); stdcall;
    function GetProcessCommandLine(ProcessID: LongWord; out CommandLine: WideString): WordBool; stdcall;
    procedure GetDomainName(out Value: WideString); stdcall;
    procedure GetRealFilePath(const FilePath: WideString; out RealFilePath: WideString); stdcall;
    procedure GetDesktopRect(out Rect: tagRECT); stdcall;
    procedure GetProcessTopLevelWindows(ProcessID: LongWord; out WindowsList: IaqWindowsList); stdcall;
    procedure GetProcessChildWindows(ProcessID: LongWord; hWndParent: UINT_PTR; 
                                     out WindowsList: IaqWindowsList); stdcall;
    function GetWindow(hWnd: UINT_PTR; Conduct: LongWord): UINT_PTR; stdcall;
    function GetRealParent(hWnd: UINT_PTR): UINT_PTR; stdcall;
    function GetTopLevelParent(hWnd: UINT_PTR): UINT_PTR; stdcall;
    function GetTopParent(hWnd: UINT_PTR): UINT_PTR; stdcall;
    function GetMDIChildParent(hWnd: UINT_PTR): UINT_PTR; stdcall;
    procedure GetWindowThreadProcessId(hWnd: UINT_PTR; out ProcessID: LongWord; 
                                       out ThreadID: LongWord); stdcall;
    procedure GetWindowClass(hWnd: UINT_PTR; out ClassName: WideString); stdcall;
    procedure GetWindowCaption(hWnd: UINT_PTR; out Caption: WideString); stdcall;
    procedure SetWindowCaption(hWnd: UINT_PTR; const Caption: WideString); stdcall;
    function GetWindowRect(hWnd: UINT_PTR; out Rect: tagRECT): WordBool; stdcall;
    function GetNCSizeTop(hWnd: UINT_PTR): Integer; stdcall;
    function GetNCSizeLeft(hWnd: UINT_PTR): Integer; stdcall;
    function FindWindow(const ClassName: WideString; const WindowName: WideString): UINT_PTR; stdcall;
    function FindWindowEx(hParent: UINT_PTR; hChildAfter: UINT_PTR; const ClassName: WideString; 
                          const WindowName: WideString): UINT_PTR; stdcall;
    function GetScrollInfo(hWnd: UINT_PTR; ScrollBarType: LongWord; ScrollInfoMask: LongWord; 
                           out ScrollInfo: AQ_SCROLL_INFO): WordBool; stdcall;
    function SetScrollInfo(hWnd: UINT_PTR; ScrollBarType: LongWord; ScrollInfoMask: LongWord; 
                           var ScrollInfo: AQ_SCROLL_INFO): Integer; stdcall;
    function GetMenuItemRect(hWnd: UINT_PTR; hMenu: UINT_PTR; Item: Integer; out Rect: tagRECT): WordBool; stdcall;
    function GetMenuItemInfo(hMenu: UINT_PTR; Item: Integer; ByPosition: WordBool; 
                             MenuItemInfoMask: LongWord; out Info: AQ_MENUITEM_INFO): WordBool; stdcall;
    function GetMenuPosFromID(hMenu: UINT_PTR; Id: LongWord): Integer; stdcall;
    function SetFocus(hWnd: UINT_PTR): WordBool; stdcall;
    function GetFocus: LongWord; stdcall;
    function IsPointVisible(hWnd: UINT_PTR; Point: tagPOINT): WordBool; stdcall;
    function RegisterWindowMessage(const MessageString: WideString): Integer; stdcall;
    function IsRectVisible(hWnd: UINT_PTR; var Rect: tagRECT): WordBool; stdcall;
    function IsRgnVisible(hWnd: UINT_PTR; Region: UINT_PTR): WordBool; stdcall;
    function GetVisibleState(hWnd: UINT_PTR): LongWord; stdcall;
    function GetRectVisibleState(hWnd: UINT_PTR; var Rect: tagRECT): LongWord; stdcall;
    procedure ActivateKeyboardLayout(hWnd: UINT_PTR; hkl: UINT_PTR); stdcall;
    procedure GetKeyboardLayoutList(out LayoutList: OleVariant); stdcall;
    function VkKeyScanEx(Character: Word; hkl: UINT_PTR): Smallint; stdcall;
    function ActivateApp(ProcessID: LongWord): WordBool; stdcall;
    function WaitForInputIdle(ProcessID: LongWord; TimeOut: LongWord): WordBool; stdcall;
    function GetScreenImage(X: Integer; Y: Integer; SizeX: Integer; SizeY: Integer; 
                            out Bitmap: UINT_PTR): WordBool; stdcall;
    function GetWindowImage(hWnd: UINT_PTR; out Bitmap: UINT_PTR): WordBool; stdcall;
    function GetWindowFromPoint(X: Integer; Y: Integer; const Filter: IaqWindowFilter; 
                                var Window: AQ_WINDOW_INFO): WordBool; stdcall;
    function GetWindowFromPointWithStatic(X: Integer; Y: Integer; var Window: AQ_WINDOW_INFO): WordBool; stdcall;
    procedure HighLightWindow(hWnd: UINT_PTR; HighlightType: HighlightWindowType; Color: LongWord); stdcall;
    procedure HighLightRect(hWnd: UINT_PTR; var Rectangle: tagRECT; 
                            HighlightType: HighlightWindowType; Color: LongWord); stdcall;
    procedure HighLightRegion(hWnd: UINT_PTR; Region: UINT_PTR; HighlightType: HighlightWindowType; 
                              Color: LongWord); stdcall;
    procedure RepaintDesktop; stdcall;
    function GetConsoleWindowText(hWnd: UINT_PTR; out Text: WideString): WordBool; stdcall;
    function DwmChangeComposition(hWnd: UINT_PTR; Value: DWMNCRenderingPolicy): DWMNCRenderingPolicy; stdcall;
    function OpenSupportPage(const ProductName: WideString; const ProductVersion: WideString; 
                             const RequestType: WideString; const MessageSubject: WideString; 
                             const MaskedRegCode: WideString; AttachedFiles: PSafeArray): WordBool; stdcall;
    function IsValidScriptDebuggerInstalled: WordBool; stdcall;
    procedure OpenURLToStream(const strURL: WideString; var pStream: IUnknown); safecall;
  end;

// *********************************************************************//
// Interface: IaqPEFile
// Flags:     (0)
// GUID:      {536C85CF-1E90-4710-9EA4-28CD683B802A}
// *********************************************************************//
  IaqPEFile = interface(IUnknown)
    ['{536C85CF-1E90-4710-9EA4-28CD683B802A}']
    procedure UnmangleRoutineName(const ManagledName: WideString; var RoutineName: WideString); stdcall;
    function GetAppType: AQ_PEIMAGE_APPTYPE; stdcall;
    function GetAppTypeEx: AQ_PEIMAGE_APPTYPE_EX; stdcall;
    function GetDosHeader: CPAQPE_DOS_HEADER; stdcall;
    function GetFileHeader: CPAQPE_FILE_HEADER; stdcall;
    function GetOptionalHeader: CPAQPE_OPTIONAL_HEADER; stdcall;
    function GetSectionCount: Integer; stdcall;
    function GetSectionHeader(Index: Integer): CPAQPE_SECTION_HEADER; stdcall;
    function GetImportModulesCount: Integer; stdcall;
    procedure GetImportModule(Index: Integer; out ImportModule: IaqPEImportModule); stdcall;
    function FindImportModule(const ModuleName: WideString; out ImportModule: IaqPEImportModule): WordBool; stdcall;
    function GetDelayLoadImportModulesCount: Integer; stdcall;
    procedure GetDelayLoadImportModule(Index: Integer; out ImportModule: IaqPEImportModule); stdcall;
    function FindDelayLoadImportModule(const ModuleName: WideString; 
                                       out ImportModule: IaqPEImportModule): WordBool; stdcall;
    function GetExportRoutinesCount: Integer; stdcall;
    procedure GetExportRoutineInfo(Index: Integer; var Info: AQPE_EXPORT_ROUTINE_INFO); stdcall;
    function FindExportRoutineInfo(const RoutineName: WideString; var Info: AQPE_EXPORT_ROUTINE_INFO): WordBool; stdcall;
    function FindExportRoutineByAddress(Address: UINT_PTR; var Info: AQPE_EXPORT_ROUTINE_INFO): WordBool; stdcall;
    function FindExportRoutineByOrdinal(Ordinal: UINT_PTR; var Info: AQPE_EXPORT_ROUTINE_INFO): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqPEImportModule
// Flags:     (0)
// GUID:      {6A77A2C5-BA5C-4017-9CAA-46B8AD0A0935}
// *********************************************************************//
  IaqPEImportModule = interface(IUnknown)
    ['{6A77A2C5-BA5C-4017-9CAA-46B8AD0A0935}']
    procedure GetName(out Name: WideString); stdcall;
    function GetImportRoutinesCount: Integer; stdcall;
    procedure GetImportRoutineInfo(Index: Integer; var Info: AQPE_IMPORT_ROUTINE_INFO); stdcall;
    function FindImportRoutineInfo(const RoutineName: WideString; var Info: AQPE_IMPORT_ROUTINE_INFO): WordBool; stdcall;
    function FindImportRoutineByOrdinal(Ordinal: LongWord; var Info: AQPE_IMPORT_ROUTINE_INFO): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqStackWalkHelper
// Flags:     (0)
// GUID:      {7E46201F-6C3F-4ED5-B9A3-210CB77F841F}
// *********************************************************************//
  IaqStackWalkHelper = interface(IUnknown)
    ['{7E46201F-6C3F-4ED5-B9A3-210CB77F841F}']
    function ReadMemory(Address: Largeuint; BufferAddress: UINT_PTR; Size: Integer): Integer; stdcall;
    procedure GetFunctionTableAddress(Address: Largeuint; out TableAddress: UINT_PTR); stdcall;
    procedure GetModuleBase(Address: Largeuint; out ModuleBaseAddress: Largeuint; out Size: LongWord); stdcall;
    function GetFunctionInfo(Address: UINT_PTR; var Info: AQDBGHELP_ROUTINE_INFO): WordBool; stdcall;
    function IsCodeAddress(Address: UINT_PTR): WordBool; stdcall;
    function IsLeafRoutine(Address: UINT_PTR): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDbgHelpStack
// Flags:     (0)
// GUID:      {6EDC0B90-4EC2-428B-9B79-675C4B63F5CD}
// *********************************************************************//
  IaqDbgHelpStack = interface(IUnknown)
    ['{6EDC0B90-4EC2-428B-9B79-675C4B63F5CD}']
    function GetAddressCount: Integer; stdcall;
    function GetAddress(Index: Integer): Largeuint; stdcall;
    function GetStackAddress(Index: Integer): Largeuint; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDbgHelpProcessList
// Flags:     (0)
// GUID:      {35816889-B074-4F31-A882-616A1E48A9C6}
// *********************************************************************//
  IaqDbgHelpProcessList = interface(IUnknown)
    ['{35816889-B074-4F31-A882-616A1E48A9C6}']
    function GetProcessCount: Integer; stdcall;
    function GetProcessInformation(Index: Integer): CPAQ_PROCESS_INFORMATION; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDbgHelpProcessListLight
// Flags:     (0)
// GUID:      {CD22C7BD-8074-47F4-9A1B-076CA4F38A43}
// *********************************************************************//
  IaqDbgHelpProcessListLight = interface(IUnknown)
    ['{CD22C7BD-8074-47F4-9A1B-076CA4F38A43}']
    function GetProcessCount: Integer; stdcall;
    function GetProcessInformation(Index: Integer): CPAQ_PROCESS_INFORMATION_LIGHT; stdcall;
  end;

// *********************************************************************//
// Interface: IaqModuleList
// Flags:     (0)
// GUID:      {EADD5CBA-4EC3-46F3-8FAA-BABC0402BA95}
// *********************************************************************//
  IaqModuleList = interface(IUnknown)
    ['{EADD5CBA-4EC3-46F3-8FAA-BABC0402BA95}']
    function GetModulesCount: Integer; stdcall;
    function GetModuleDescription(Index: Integer): CPAQ_MODULE_DESCRIPTION; stdcall;
    function GetModuleDescriptionByName(const Name: WideString; 
                                        var Description: AQ_MODULE_DESCRIPTION): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqWindowsList
// Flags:     (0)
// GUID:      {F07000CB-295B-45A8-A98D-E7CF6F331FC9}
// *********************************************************************//
  IaqWindowsList = interface(IUnknown)
    ['{F07000CB-295B-45A8-A98D-E7CF6F331FC9}']
    function GetWindowCount: Integer; stdcall;
    function GetWindow(Index: Integer): CPAQ_WINDOW_INFO; stdcall;
  end;

// *********************************************************************//
// Interface: IaqWindowFilter
// Flags:     (0)
// GUID:      {D354A9F8-85ED-4F2B-9454-3CE64373F518}
// *********************************************************************//
  IaqWindowFilter = interface(IUnknown)
    ['{D354A9F8-85ED-4F2B-9454-3CE64373F518}']
    function AcceptWindow(hWnd: UINT_PTR): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqIISManager
// Flags:     (0)
// GUID:      {CC751A48-510A-4C9F-835B-D62AF272F717}
// *********************************************************************//
  IaqIISManager = interface(IUnknown)
    ['{CC751A48-510A-4C9F-835B-D62AF272F717}']
    function GetIISVersion: LongWord; stdcall;
    function GetAppPoolIs32Bit(const ModulePhysicalPath: WideString; out Result: WordBool): WordBool; stdcall;
    function GetAppPoolASPNETVersion(const ModulePhysicalPath: WideString; out Result: WideString): WordBool; stdcall;
    function RestartAppPool(const ModulePhysicalPath: WideString): WordBool; stdcall;
    function GetAppIsolationMode(const ModulePhysicalPath: WideString; out Result: LongWord): WordBool; stdcall;
    function GetComAppName(const ModulePhysicalPath: WideString; out Result: WideString): WordBool; stdcall;
    function IsIIS6IsolationMode: WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDbgHelpManager
// Flags:     (0)
// GUID:      {84F27C07-E689-4FAD-BD97-E62F874BDDB4}
// *********************************************************************//
  IaqDbgHelpManager = interface(IUnknown)
    ['{84F27C07-E689-4FAD-BD97-E62F874BDDB4}']
    procedure WalkStack(const Thread: IaqDebugThread; ShowNoDbgInfoRoutines: WordBool; 
                        MaxStackDepth: Integer; out Stack: IaqStack); stdcall;
    function GetPEFile(const Name: WideString; out PEFile: IaqPEFile): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqStack
// Flags:     (0)
// GUID:      {C1BA3881-C81F-4C5E-A9D5-DCF73C634090}
// *********************************************************************//
  IaqStack = interface(IUnknown)
    ['{C1BA3881-C81F-4C5E-A9D5-DCF73C634090}']
    function GetItemCount: Integer; stdcall;
    procedure GetItemInfo(Index: Integer; out ItemInfo: CPAQDBGHELP_STACK_ITEM_INFO); stdcall;
  end;

// *********************************************************************//
// Interface: IaqDbgHelpManagerExtender
// Flags:     (0)
// GUID:      {E56E2708-5118-42B4-A672-6DF6533E5EFF}
// *********************************************************************//
  IaqDbgHelpManagerExtender = interface(IUnknown)
    ['{E56E2708-5118-42B4-A672-6DF6533E5EFF}']
    procedure BeginStackWalk(const Process: IaqDebugProcess; const Thread: IaqDebugThread); stdcall;
    procedure EndStackWalk; stdcall;
    function AcceptRoutine(var StackItemInfo: AQDBGHELP_STACK_ITEM_INFO): WordBool; stdcall;
    function GetStackItemInfo(Address: Largeuint; PrevAddress: Largeuint; 
                              var StackItemInfo: AQDBGHELP_STACK_ITEM_INFO): WordBool; stdcall;
    function GetRoutineInfo(Address: Largeuint; var Info: AQDBGHELP_ROUTINE_INFO): WordBool; stdcall;
    function ReadMemory(Address: Largeuint; BufferAddress: UINT_PTR; Size: Integer; 
                        out Processed: WordBool): Integer; stdcall;
    function IsCodeAddress(Address: UINT_PTR; out Processed: WordBool): WordBool; stdcall;
    function IsLeafRoutine(Address: UINT_PTR; out Processed: WordBool): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqDbgHelpManagerExtenderX64
// Flags:     (0)
// GUID:      {CCDB5438-E06F-4FEB-926A-57B3DB45A2ED}
// *********************************************************************//
  IaqDbgHelpManagerExtenderX64 = interface(IUnknown)
    ['{CCDB5438-E06F-4FEB-926A-57B3DB45A2ED}']
    procedure GetModuleBase(Address: Largeuint; out ModuleBase: Largeuint; out Size: LongWord); stdcall;
    procedure GetFunctionTableAddress(Address: Largeuint; out TableAddress: UINT_PTR); stdcall;
  end;

// *********************************************************************//
// Interface: IaqWindowsManager
// Flags:     (0)
// GUID:      {463D5E7A-02B6-4BE5-A74C-2D885DC8D6BB}
// *********************************************************************//
  IaqWindowsManager = interface(IUnknown)
    ['{463D5E7A-02B6-4BE5-A74C-2D885DC8D6BB}']
    function GetDesktopWindow: UINT_PTR; stdcall;
    procedure GetDesktopRect(out Rect: tagRECT); stdcall;
    function IsWindow(hWnd: UINT_PTR): WordBool; stdcall;
    procedure GetProcessTopLevelWindows(ProcessID: LongWord; out WindowsList: IaqWindowsList); stdcall;
    procedure GetProcessChildWindows(ProcessID: LongWord; hWndParent: UINT_PTR; 
                                     out WindowsList: IaqWindowsList); stdcall;
    function GetWindow(hWnd: UINT_PTR; Conduct: GetWindowConduct): UINT_PTR; stdcall;
    function GetRealParent(hWnd: UINT_PTR): UINT_PTR; stdcall;
    function GetTopLevelParent(hWnd: UINT_PTR): UINT_PTR; stdcall;
    function GetTopParent(hWnd: UINT_PTR): UINT_PTR; stdcall;
    function GetParent(hWnd: UINT_PTR): UINT_PTR; stdcall;
    function GetMDIChildParent(hWnd: UINT_PTR): UINT_PTR; stdcall;
    procedure GetWindowThreadProcessId(hWnd: UINT_PTR; out ProcessID: LongWord; 
                                       out ThreadID: LongWord); stdcall;
    procedure GetWindowClass(hWnd: UINT_PTR; out ClassName: WideString); stdcall;
    procedure GetWindowCaption(hWnd: UINT_PTR; out Caption: WideString); stdcall;
    procedure SetWindowCaption(hWnd: UINT_PTR; const Caption: WideString); stdcall;
    function GetWindowRect(hWnd: UINT_PTR; out Rect: tagRECT): WordBool; stdcall;
    function GetClientRect(hWnd: UINT_PTR; out Rect: tagRECT): WordBool; stdcall;
    function GetCursorPos(out Point: tagPOINT): WordBool; stdcall;
    function SetFocus(hWnd: UINT_PTR): WordBool; stdcall;
    function GetFocus: LongWord; stdcall;
    function GetWindowStyles(hWnd: UINT_PTR): Integer; stdcall;
    function GetWindowStylesEx(hWnd: UINT_PTR): Integer; stdcall;
    function GetClassStyles(hWnd: UINT_PTR): Integer; stdcall;
    function GetWindowIdentifier(hWnd: UINT_PTR): Integer; stdcall;
    function IsWindowEnabled(hWnd: UINT_PTR): WordBool; stdcall;
    function IsWindowVisible(hWnd: UINT_PTR): WordBool; stdcall;
    function GetVisibleState(hWnd: UINT_PTR): WindowVisibleState; stdcall;
    function GetScrollInfo(hWnd: UINT_PTR; BarType: ScrollBarType; Mask: ScrollInfoMask; 
                           out ScrollInfo: AQ_SCROLL_INFO): WordBool; stdcall;
    function SetScrollInfo(hWnd: UINT_PTR; BarType: ScrollBarType; Mask: ScrollInfoMask; 
                           var ScrollInfo: AQ_SCROLL_INFO): Integer; stdcall;
    function FindWindow(const ClassName: WideString; const WindowName: WideString): UINT_PTR; stdcall;
    function FindWindowEx(hParent: UINT_PTR; hChildAfter: UINT_PTR; const ClassName: WideString; 
                          const WindowName: WideString): UINT_PTR; stdcall;
    function GetMenu(hWnd: UINT_PTR): UINT_PTR; stdcall;
    function GetSystemMenu(hWnd: UINT_PTR): UINT_PTR; stdcall;
    function GetMenuItemCount(hMenu: UINT_PTR): Integer; stdcall;
    function GetMenuItemRect(hWnd: UINT_PTR; hMenu: UINT_PTR; Item: Integer; out Rect: tagRECT): WordBool; stdcall;
    function GetMenuItemInfo(hMenu: UINT_PTR; Item: Integer; ByPosition: WordBool; 
                             Mask: MenuItemInfoMask; out Info: AQ_MENUITEM_INFO): WordBool; stdcall;
    function GetMenuPosFromID(hMenu: UINT_PTR; Id: LongWord): Integer; stdcall;
    function ClientToScreen(hWnd: UINT_PTR; var Point: tagPOINT): WordBool; stdcall;
    function ScreenToClient(hWnd: UINT_PTR; var Point: tagPOINT): WordBool; stdcall;
    function ScreenToWindow(hWnd: UINT_PTR; var Point: tagPOINT): WordBool; stdcall;
    function WindowToScreen(hWnd: UINT_PTR; var Point: tagPOINT): WordBool; stdcall;
    function SetForegroundWindow(hWnd: UINT_PTR): WordBool; stdcall;
    function GetForegroundWindow: UINT_PTR; stdcall;
    function MoveWindow(hWnd: UINT_PTR; X: Integer; Y: Integer; Width: Integer; Height: Integer; 
                        Repaint: WordBool): WordBool; stdcall;
    function PostMessage(hWnd: UINT_PTR; Msg: LongWord; wParam: Int64; lParam: Int64): WordBool; stdcall;
    function PostMessageWide(hWnd: UINT_PTR; Msg: LongWord; wParam: Int64; lParam: Int64): WordBool; stdcall;
    function PostThreadMessage(ThreadID: LongWord; Msg: LongWord; wParam: Int64; lParam: Int64): WordBool; stdcall;
    function PostThreadMessageWide(ThreadID: LongWord; Msg: LongWord; wParam: Int64; lParam: Int64): WordBool; stdcall;
    procedure SendMessage(hWnd: UINT_PTR; Msg: LongWord; wParam: Int64; lParam: Int64; 
                          out RetVal: Int64); stdcall;
    procedure SendMessageWide(hWnd: UINT_PTR; Msg: LongWord; wParam: Int64; lParam: Int64; 
                              out RetVal: Int64); stdcall;
    function SendMessageTimeoutWide(hWnd: UINT_PTR; Msg: LongWord; wParam: Int64; lParam: Int64; 
                                    fuFlags: Integer; uTimeout: Integer; out RetVal: Int64): WordBool; stdcall;
    function SendMessageTimeout(hWnd: UINT_PTR; Msg: LongWord; wParam: Int64; lParam: Int64; 
                                fuFlags: Integer; uTimeout: Integer; out RetVal: Int64): WordBool; stdcall;
    function IsPointVisible(hWnd: UINT_PTR; Point: tagPOINT): WordBool; stdcall;
    function RegisterWindowMessage(const MessageString: WideString): Integer; stdcall;
    function GetWindowImage(hWnd: UINT_PTR; CaptureMouse: WordBool; out Bitmap: UINT_PTR): WordBool; stdcall;
    function GetScreenImage(X: Integer; Y: Integer; SizeX: Integer; SizeY: Integer; 
                            CaptureMouse: WordBool; out Bitmap: UINT_PTR): WordBool; stdcall;
    function DrawCursor(X: Integer; Y: Integer; var Bitmap: UINT_PTR): WordBool; stdcall;
    procedure CropImage(X: Integer; Y: Integer; Width: Integer; Height: Integer; 
                        var Bitmap: UINT_PTR); stdcall;
    function IsWindowUnicode(hWnd: UINT_PTR): WordBool; stdcall;
    function ActivateApp(ProcessID: LongWord): WordBool; stdcall;
    procedure ActivateKeyboardLayout(hWnd: UINT_PTR; hkl: UINT_PTR); stdcall;
    function ActivateKeyboardLayoutOld(ProcessID: LongWord; hkl: UINT_PTR; Flags: LongWord): WordBool; stdcall;
    procedure GetKeyboardLayoutList(out LayoutList: OleVariant); stdcall;
    function ImmIsIME(hkl: UINT_PTR): WordBool; stdcall;
    function GetKeyboardLayout(ThreadID: LongWord): UINT_PTR; stdcall;
    function GetKeyboardLayoutEx(hWnd: UINT_PTR): UINT_PTR; stdcall;
    function GetAsyncKeyState(vkCode: LongWord): Smallint; stdcall;
    function VkKeyScanEx(Character: Word; hkl: UINT_PTR): Smallint; stdcall;
    function GetKeyState(vkCode: LongWord): Smallint; stdcall;
    function MapVirtualKeyEx(Code: LongWord; MapType: LongWord; hkl: UINT_PTR): LongWord; stdcall;
    function GetMouseHoverTime: LongWord; stdcall;
    function GetMenuShowDelay: LongWord; stdcall;
    function GetComboboxAnimation(out Value: WordBool): WordBool; stdcall;
    procedure GetCursorMetrics(out Width: Integer; out Height: Integer); stdcall;
    procedure GetDblClickMetrics(out Width: Integer; out Height: Integer; out Time: LongWord); stdcall;
    function WaitForInputIdle(ProcessID: LongWord; TimeOut: LongWord): WordBool; stdcall;
    function GetShowCmd(hWnd: UINT_PTR): LongWord; stdcall;
    function HideCaret(hWnd: UINT_PTR): WordBool; stdcall;
    function ShowCaret(hWnd: UINT_PTR): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqWindowsManagerEx
// Flags:     (0)
// GUID:      {D4A9548A-CE42-416D-B780-40DA334E62EB}
// *********************************************************************//
  IaqWindowsManagerEx = interface(IaqWindowsManager)
    ['{D4A9548A-CE42-416D-B780-40DA334E62EB}']
    function IsMouseCaptured(ThreadID: LongWord): WordBool; stdcall;
    function IsRectVisible(hWnd: UINT_PTR; var Rect: tagRECT): WordBool; stdcall;
    function GetRectVisibleState(hWnd: UINT_PTR; var Rect: tagRECT): WindowVisibleState; stdcall;
    function GetWindowFromPoint(X: Integer; Y: Integer; const Filter: IaqWindowFilter; 
                                var Window: AQ_WINDOW_INFO): WordBool; stdcall;
    function GetWindowFromPointWithStatic(X: Integer; Y: Integer; var Window: AQ_WINDOW_INFO): WordBool; stdcall;
    procedure HighLightWindow(hWnd: UINT_PTR; HighlightType: HighlightWindowType; Color: LongWord); stdcall;
    procedure HighLightRect(hWnd: UINT_PTR; var Rectangle: tagRECT; 
                            HighlightType: HighlightWindowType; Color: LongWord); stdcall;
    procedure HighLightRegion(hWnd: UINT_PTR; Region: UINT_PTR; HighlightType: HighlightWindowType; 
                              Color: LongWord); stdcall;
    procedure RepaintDesktop; stdcall;
    function GetBitmap(ProcessID: LongWord; hBitmap: Int64; out Bitmap: UINT_PTR): WordBool; stdcall;
    function GetIcon(ProcessID: LongWord; hIcon: Int64; out Bitmap: UINT_PTR): WordBool; stdcall;
    function GetImageListBitmap(ProcessID: LongWord; hImageList: Int64; Index: UINT_PTR; 
                                out Bitmap: UINT_PTR): WordBool; stdcall;
    function MainThreadSendMessageTimeout(unicode: WordBool; hWnd: UINT_PTR; Msg: LongWord; 
                                          wParam: Int64; lParam: Int64; fuFlags: Integer; 
                                          uTimeout: Integer; out RetVal: Int64): WordBool; stdcall;
    function GetConsoleWindowText(hWnd: UINT_PTR; out Text: WideString): WordBool; stdcall;
  end;

// *********************************************************************//
// Interface: IaqProfilersFactory
// Flags:     (4096) Dispatchable
// GUID:      {D0462B77-0E92-4643-BCCC-4A4D03C77AA9}
// *********************************************************************//
  IaqProfilersFactory = interface(IaqSubsystemManager)
    ['{D0462B77-0E92-4643-BCCC-4A4D03C77AA9}']
    procedure CreateBaseContextProfiler(const ProfilerInfo: AQ_BASE_PROFILER_DESCRIPTION;
                                        CreatorKey: TGUID; 
                                        out BaseContextProfiler: IaqBaseContextProfiler); stdcall;
    procedure CreateProfilerEngine(DisableAllMessages: WordBool; NotifyNewModuleAddress: WordBool; 
                                   UseInLineBlocks: WordBool; 
                                   out ProfilerEngine: IaqContextProfilerEngine); stdcall;
    procedure CreateProfilerEngineAreasExtender(ItemType: TGUID; FullCheck: WordBool; 
                                                out AreasExtender: IaqContextProfilerEngineAreasExtender); stdcall;
    procedure CreateDotNetProfilerEngine(out ProfilerEngine: IaqContextProfilerEngine); stdcall;
    procedure CreateStaticProfilerEngine(const Callback: IaqStaticAnalysisEngineCallback; 
                                         out ProfilerEngine: IaqContextProfilerEngine); stdcall;
    procedure CreateStaticDotNetProfilerEngine(const Callback: IaqStaticAnalysisEngineCallback; 
                                               out ProfilerEngine: IaqContextProfilerEngine); stdcall;
    procedure CreateThreadMapperSelector(out Extender: IaqBaseContextProfilerExtender); stdcall;
    procedure CreateCommonProfilerOptions(out Extender: IaqBaseContextProfilerExtender); stdcall;
    procedure CreateMonitorProviderEngine(out Extender: IaqBaseContextProfilerExtender); stdcall;
    procedure CreateCounterExtender(out Extender: IaqContextProfilerCounterExtender); stdcall;
    procedure CreateDefaultBrowseObject(out BrowseObject: IaqContextBrowseObjectSupport); stdcall;
    procedure CreateDynamicContext(out DynamicContext: IaqProfDynamicContext); stdcall;
    procedure CreateLeakFilterExtender(out LeakFilterExtender: IaqContextProfilerEngineCallback); stdcall;
    procedure CreateNativeParametersReaderExtender(out NativeParametersReaderExtender: IaqContextProfilerEngineCallback); stdcall;
  end;

// *********************************************************************//
// Interface: IaqBaseContextProfiler
// Flags:     (0)
// GUID:      {F32813A1-673F-4E4D-B272-E3B4A82409A6}
// *********************************************************************//
  IaqBaseContextProfiler = interface(IUnknown)
    ['{F32813A1-673F-4E4D-B272-E3B4A82409A6}']
    procedure AddExtender(const Extender: IaqBaseContextProfilerExtender); stdcall;
  end;

// *********************************************************************//
// Interface: IaqBaseContextProfilerExtender
// Flags:     (0)
// GUID:      {C79F66D5-DD33-4322-8045-D606C1CE9A2D}
// *********************************************************************//
  IaqBaseContextProfilerExtender = interface(IUnknown)
    ['{C79F66D5-DD33-4322-8045-D606C1CE9A2D}']
    procedure Initialize(const Impl: IaqContextProfilerImpl; const Manager: IaqBaseManager); stdcall;
    procedure Finalize; stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerImpl
// Flags:     (0)
// GUID:      {F88321C5-4CFE-4AAF-ADDC-66CF5B1592A1}
// *********************************************************************//
  IaqContextProfilerImpl = interface(IaqKeyItem)
    ['{F88321C5-4CFE-4AAF-ADDC-66CF5B1592A1}']
    procedure Get_Name(out Value: WideString); stdcall;
    procedure Get_Category(out Value: WideString); stdcall;
    function Get_HelpContext: Integer; stdcall;
    procedure Get_HelpFileName(out Value: WideString); stdcall;
    procedure GetProfilerImageName(out Value: WideString); stdcall;
    procedure GetRootSchemaId(out Value: TGUID); stdcall;
    function GetProfilerFeatures: Integer; stdcall;
    function GetSetupFeatures: Integer; stdcall;
    function SupportProfileAllLevel(ProfileLevel: TProfileLevel): WordBool; stdcall;
    procedure CreateContext(IsRunContext: WordBool; out Context: IaqProfDynamicContext); stdcall;
    procedure AddProviders(const MetaProvider: IaqContextMetaProvider; 
                           const BaseSummaryXML: WideString); stdcall;
    procedure GetShowSettingsBeforeStartGuid(out Value: TGUID); stdcall;
    function GetDefaultThreadRid: AQPROF_TABLE_RECID; stdcall;
    procedure GetBrowseObjectSupport(out Value: IaqContextBrowseObjectSupport); stdcall;
    function CanAddResultNode(SchemaId: TGUID): WordBool; stdcall;
    function CanMerge: WordBool; stdcall;
    procedure Merge(const Context1: IaqProfDynamicContext; const Context2: IaqProfDynamicContext); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextMetaProvider
// Flags:     (0)
// GUID:      {78901125-1CFB-4EC1-AA8C-01C4CF81D5E2}
// *********************************************************************//
  IaqContextMetaProvider = interface(IUnknown)
    ['{78901125-1CFB-4EC1-AA8C-01C4CF81D5E2}']
    procedure GetTableProvider(out Value: IaqProfTableProvider); stdcall;
    procedure GetContext(out Value: IaqProfDynamicContext); stdcall;
    procedure AddProvider(Id: TGUID; const Provider: IaqContextProfilerProvider); stdcall;
    procedure GetRootSchema(out Value: IaqContextDataSchema); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerProvider
// Flags:     (0)
// GUID:      {DE4902E9-80A8-4827-BE59-2A1D562FF8B2}
// *********************************************************************//
  IaqContextProfilerProvider = interface(IUnknown)
    ['{DE4902E9-80A8-4827-BE59-2A1D562FF8B2}']
    procedure DestroySelf; stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextDataSchema
// Flags:     (0)
// GUID:      {95BF83A8-EB6E-4C7B-B45B-847DC6DED7E0}
// *********************************************************************//
  IaqContextDataSchema = interface(IaqTableDataSchema)
    ['{95BF83A8-EB6E-4C7B-B45B-847DC6DED7E0}']
    function GetMapIndex(Index: Integer): Integer; stdcall;
    procedure GetChildsInternal(ChildIndex: Integer; out Schema: IaqContextDataSchema); stdcall;
    procedure GetContextSchema(out Value: IaqProfTableSchema); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextBrowseObjectSupport
// Flags:     (0)
// GUID:      {3F82A4F9-C9D9-4910-AE6A-3397D971B306}
// *********************************************************************//
  IaqContextBrowseObjectSupport = interface(IUnknown)
    ['{3F82A4F9-C9D9-4910-AE6A-3397D971B306}']
    procedure CreateBrowseObject(const Context: IaqProfDynamicContext; 
                                 const TableProvider: IaqProfTableProvider; RowIndex: Integer; 
                                 out BrowseObject: IaqBrowseObject); stdcall;
    function GetRowIndex(const Context: IaqProfDynamicContext; 
                         const TableProvider: IaqProfTableProvider; 
                         const BrowseObject: IaqBrowseObject): Integer; stdcall;
    procedure GetMoniker(const Context: IaqProfDynamicContext; 
                         const TableProvider: IaqProfTableProvider; RowIndex: Integer; 
                         out Value: WideString); stdcall;
    function GetRowIndexByMoniker(const Context: IaqProfDynamicContext; 
                                  const TableProvider: IaqProfTableProvider; 
                                  const Moniker: WideString): Integer; stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerEngine
// Flags:     (0)
// GUID:      {F77AF285-2A13-460D-991F-ADADC4A39AAA}
// *********************************************************************//
  IaqContextProfilerEngine = interface(IUnknown)
    ['{F77AF285-2A13-460D-991F-ADADC4A39AAA}']
    procedure AddCallback(const Callback: IaqContextProfilerEngineCallback); stdcall;
    procedure AddAreaExtender(const Extender: IaqContextProfilerEngineAreasExtender); stdcall;
    function CanStart(const RunContext: IaqProfDynamicContext; var ProcessItemsCount: Integer; 
                      out ShowOutOfMemoryWarning: WordBool): WordBool; stdcall;
    procedure Reset; stdcall;
    procedure PostProcessContext(const Context: IaqProfDynamicContext); stdcall;
    procedure GetEnvironmentVariables(Variables: PSAFEARRAY); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerEngineCallback
// Flags:     (0)
// GUID:      {EBE414FF-E84C-4D46-9CBC-8EB26560FC7C}
// *********************************************************************//
  IaqContextProfilerEngineCallback = interface(IUnknown)
    ['{EBE414FF-E84C-4D46-9CBC-8EB26560FC7C}']
  end;

// *********************************************************************//
// Interface: IaqContextProfilerEngineAreasExtender
// Flags:     (0)
// GUID:      {CF3F248A-01A6-4F2C-8FE0-29B3815F8ADF}
// *********************************************************************//
  IaqContextProfilerEngineAreasExtender = interface(IUnknown)
    ['{CF3F248A-01A6-4F2C-8FE0-29B3815F8ADF}']
    function GetModulesCount: Integer; stdcall;
    procedure GetModule(ModuleIndex: Integer; out Module: IaqModule); stdcall;
    procedure GetAreaItems(ModuleIndex: Integer; out Value: IaqAreaItem); stdcall;
  end;

// *********************************************************************//
// Interface: IaqStaticAnalysisEngineCallback
// Flags:     (0)
// GUID:      {4D5CF070-C569-4E1E-A5D9-4A1953729212}
// *********************************************************************//
  IaqStaticAnalysisEngineCallback = interface(IUnknown)
    ['{4D5CF070-C569-4E1E-A5D9-4A1953729212}']
    procedure AddRoutineToContext(const Context: IaqProfDynamicContext; 
                                  RoutineId: AQPROF_TABLE_RECID; ClassId: AQPROF_TABLE_RECID; 
                                  const DbgSymbol: IaqDbgSymbol); stdcall;
    procedure AddClassToContext(const Context: IaqProfDynamicContext; RecId: AQPROF_TABLE_RECID; 
                                const DbgSymbol: IaqDbgSymbol); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerCounterExtender
// Flags:     (0)
// GUID:      {771FC8DD-2217-4C16-B4DD-1E9620E9E6A7}
// *********************************************************************//
  IaqContextProfilerCounterExtender = interface(IUnknown)
    ['{771FC8DD-2217-4C16-B4DD-1E9620E9E6A7}']
    procedure AfterCreateContext(IsRunContext: WordBool; var Context: IaqProfDynamicContext); stdcall;
  end;

// *********************************************************************//
// Interface: IaqStaticContextProfilerImpl
// Flags:     (0)
// GUID:      {A4ED44F3-4A5F-4DC2-AFEC-F99468C19A8E}
// *********************************************************************//
  IaqStaticContextProfilerImpl = interface(IUnknown)
    ['{A4ED44F3-4A5F-4DC2-AFEC-F99468C19A8E}']
    function PrepareRun: WordBool; stdcall;
    procedure Start(const Context: IaqProfDynamicContext); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerResultsActivator
// Flags:     (0)
// GUID:      {652D6874-E760-43A7-873E-C686AF47944F}
// *********************************************************************//
  IaqContextProfilerResultsActivator = interface(IUnknown)
    ['{652D6874-E760-43A7-873E-C686AF47944F}']
    procedure ActivateResults(const CurrentResult: IaqResult; 
                              const ThreadResultNode: IaqResultNode; 
                              const BrowseObject: IaqBrowseObject); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerOptions
// Flags:     (0)
// GUID:      {3284A6CF-5091-48DC-AF21-578F3C58C132}
// *********************************************************************//
  IaqContextProfilerOptions = interface(IaqKeyItem)
    ['{3284A6CF-5091-48DC-AF21-578F3C58C132}']
    procedure ApplyOptionsToContext(const Context: IaqProfDynamicContext); stdcall;
    procedure ReadOptions(const Option: IaqOptionsNodeStore); stdcall;
    procedure SaveOptions(const Option: IaqOptionsNodeStore); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerSettings
// Flags:     (0)
// GUID:      {CEF0852C-04FD-45D2-AB15-C7286925D010}
// *********************************************************************//
  IaqContextProfilerSettings = interface(IUnknown)
    ['{CEF0852C-04FD-45D2-AB15-C7286925D010}']
    procedure InitializeSettings(const Settings: IaqSettings_DVS); stdcall;
    procedure FinalizeSettings; stdcall;
    procedure UpdateSetting(const Setting: IaqBaseSetting_DVS); stdcall;
    procedure ApplySettingsToContext(const Context: IaqProfDynamicContext); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerMetaProvider
// Flags:     (0)
// GUID:      {82695983-5D20-460F-9416-267DF6D758FF}
// *********************************************************************//
  IaqContextProfilerMetaProvider = interface(IUnknown)
    ['{82695983-5D20-460F-9416-267DF6D758FF}']
    procedure MetaProviderChanged(const MetaProvider: IaqContextMetaProvider); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerToolbar
// Flags:     (0)
// GUID:      {B89CF15E-C383-4DB0-8BFF-2494BD76EB0E}
// *********************************************************************//
  IaqContextProfilerToolbar = interface(IUnknown)
    ['{B89CF15E-C383-4DB0-8BFF-2494BD76EB0E}']
    procedure CreateActions(const ActionManager: IaqActionManager; 
                            const Notifiable: IaqActionNotifier; 
                            const ActionProvider: IaqActionProvider; ProfilerKey: TGUID); stdcall;
    procedure ConfigureActions(const ActionManager: IaqActionManager; 
                               const Notifiable: IaqActionNotifier; 
                               const ActionProvider: IaqActionProvider); stdcall;
    procedure RemoveActions(const ActionManager: IaqActionManager; 
                            const ActionProvider: IaqActionProvider); stdcall;
    procedure AddActions(const Toolbar: IaqToolbar); stdcall;
    procedure UpdateAction(const Sender: IaqActionItem); stdcall;
    procedure ExecuteAction(const Sender: IaqActionItem; InValue: OleVariant; 
                            const MetaProvider: IaqContextMetaProvider; out Processed: WordBool; 
                            out Refresh: WordBool; out Result: AQ_ACTION_EXEC_RESULT); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerEngineExcludeAreaExtender
// Flags:     (0)
// GUID:      {AF5BA3FC-CD7B-4802-B1E8-1001B49D0108}
// *********************************************************************//
  IaqContextProfilerEngineExcludeAreaExtender = interface(IUnknown)
    ['{AF5BA3FC-CD7B-4802-B1E8-1001B49D0108}']
    procedure PrepareNotPatchSymbols; stdcall;
    procedure ReleaseNotPatchSymbols; stdcall;
    function GetNotPatchSymbolsCount: Integer; stdcall;
    procedure GetNotPatchSymbols(RoutineIndex: Integer; out DbgSymbol: IaqDbgSymbol); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerEngineAreasImportExtender
// Flags:     (0)
// GUID:      {AB5C327B-55C5-4154-B01B-348F93072B1B}
// *********************************************************************//
  IaqContextProfilerEngineAreasImportExtender = interface(IUnknown)
    ['{AB5C327B-55C5-4154-B01B-348F93072B1B}']
    function GetImportFunctionsCount: Integer; stdcall;
    procedure GetImportRoutineInfo(Index: Integer; out ModuleName: WideString; 
                                   out RoutineName: WideString); stdcall;
    procedure Reset; stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerSessionEngine
// Flags:     (0)
// GUID:      {CB9042F8-9F24-48C8-B43D-2E31A47CC3D4}
// *********************************************************************//
  IaqContextProfilerSessionEngine = interface(IUnknown)
    ['{CB9042F8-9F24-48C8-B43D-2E31A47CC3D4}']
    procedure OnFillRunContext(const Context: IaqProfDynamicContext); stdcall;
    procedure OnCreateSession(const Session: IaqProfSession); stdcall;
    procedure OnCloseSession; stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerDbgEngine
// Flags:     (0)
// GUID:      {06CEDBD2-CC0E-4E6A-B3AF-8874532C336D}
// *********************************************************************//
  IaqContextProfilerDbgEngine = interface(IUnknown)
    ['{06CEDBD2-CC0E-4E6A-B3AF-8874532C336D}']
    procedure ProcessStart(const Process: IaqDebugProcess; AttachMode: WordBool); stdcall;
    procedure ProcessFinish(const Process: IaqDebugProcess); stdcall;
    procedure InjectDllLoad(const Process: IaqDebugProcess); stdcall;
    procedure LoadModule(const Module: IaqDebugModule); stdcall;
    procedure UnloadModule(const Module: IaqDebugModule); stdcall;
    procedure StartedModule(const Module: IaqDebugModule); stdcall;
    procedure ResumeProcess(const Process: IaqDebugProcess); stdcall;
    procedure SuspendProcess(const Process: IaqDebugProcess); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerDbgEngineEx
// Flags:     (0)
// GUID:      {E925C844-C853-4447-B34B-C277B1B17B69}
// *********************************************************************//
  IaqContextProfilerDbgEngineEx = interface(IUnknown)
    ['{E925C844-C853-4447-B34B-C277B1B17B69}']
    procedure OnDebugString(const DbgString: IaqDebugString); stdcall;
    procedure OnException(const Exception: IaqDebugException); stdcall;
    procedure OnUserBreakpoint(const Breakpoint: IaqBreakpoint); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerActivationEngine
// Flags:     (0)
// GUID:      {896C7431-689E-4577-8098-64D43B0146BC}
// *********************************************************************//
  IaqContextProfilerActivationEngine = interface(IUnknown)
    ['{896C7431-689E-4577-8098-64D43B0146BC}']
    procedure Activate; stdcall;
    procedure Deactivate; stdcall;
    procedure OnProjectClosed; stdcall;
  end;

// *********************************************************************//
// Interface: IaqResultCleaner
// Flags:     (0)
// GUID:      {93071ABC-F4C0-40A7-8146-99FDCFA1FB1F}
// *********************************************************************//
  IaqResultCleaner = interface(IUnknown)
    ['{93071ABC-F4C0-40A7-8146-99FDCFA1FB1F}']
    function CanClearResults: WordBool; stdcall;
    procedure ClearResults; stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerEngineRoutineCallback
// Flags:     (0)
// GUID:      {CB4330D1-66F4-4BCE-8E5D-644BCDD50AEE}
// *********************************************************************//
  IaqContextProfilerEngineRoutineCallback = interface(IaqContextProfilerEngineCallback)
    ['{CB4330D1-66F4-4BCE-8E5D-644BCDD50AEE}']
    procedure InitializeCallback(const Context: IaqProfDynamicContext); stdcall;
    procedure FinalizeCallback; stdcall;
    procedure AddRoutineToContext(const Context: IaqProfDynamicContext; 
                                  RoutineId: AQPROF_TABLE_RECID; const DbgSymbol: IaqDbgSymbol); stdcall;
  end;

// *********************************************************************//
// Interface: IaqContextProfilerDBExporter
// Flags:     (0)
// GUID:      {59632D4C-166D-4E51-9C0E-FC7C0914A2A2}
// *********************************************************************//
  IaqContextProfilerDBExporter = interface(IUnknown)
    ['{59632D4C-166D-4E51-9C0E-FC7C0914A2A2}']
    function GetExcludeTableCount: Integer; stdcall;
    procedure GetExcludeTableKey(Index: Integer; out Value: TGUID); stdcall;
  end;

// *********************************************************************//
// Interface: IaqExportResultsToDBManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {35A743D2-CEA8-4491-A7AA-E1D61468FCE6}
// *********************************************************************//
  IaqExportResultsToDBManager = interface(IaqSubsystemManager)
    ['{35A743D2-CEA8-4491-A7AA-E1D61468FCE6}']
    procedure ExportCurrentResults(const ConnectionString: WideString; const Login: WideString; 
                                   const Password: WideString); safecall;
    function ExportCurrentResultsEx(ShowUIMessages: WordBool; const BaseProfiler: IaqBaseProfiler; 
                                    const Results: IaqResult; const ConnectionString: WideString; 
                                    const Login: WideString; const Password: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IaqExportResultsToDBManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {35A743D2-CEA8-4491-A7AA-E1D61468FCE6}
// *********************************************************************//
  IaqExportResultsToDBManagerDisp = dispinterface
    ['{35A743D2-CEA8-4491-A7AA-E1D61468FCE6}']
    procedure ExportCurrentResults(const ConnectionString: WideString; const Login: WideString; 
                                   const Password: WideString); dispid 229634049;
    function ExportCurrentResultsEx(ShowUIMessages: WordBool; const BaseProfiler: IaqBaseProfiler; 
                                    const Results: IaqResult; const ConnectionString: WideString; 
                                    const Login: WideString; const Password: WideString): WordBool; dispid 229634050;
    property BaseManager: IaqBaseManager readonly dispid 167937;
    procedure InitializeManager(const Manager: IaqBaseManager); dispid 167938;
    procedure DisposeManager; dispid 167939;
    procedure BaseManagerStateChanged(State: AQ_MAINMANAGER_STATE); dispid 167940;
  end;

// *********************************************************************//
// Interface: IAQtimeManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {63BD16B6-F03F-11D3-B765-00105A6753FE}
// *********************************************************************//
  IAQtimeManager = interface(IDispatch)
    ['{63BD16B6-F03F-11D3-B765-00105A6753FE}']
    function Get_Manager: IaqBaseManager; safecall;
    function Get_IntegrationManager: IaqTimeIntegrationSupportManager; safecall;
    procedure Quit; safecall;
    property Manager: IaqBaseManager read Get_Manager;
    property IntegrationManager: IaqTimeIntegrationSupportManager read Get_IntegrationManager;
  end;

// *********************************************************************//
// DispIntf:  IAQtimeManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {63BD16B6-F03F-11D3-B765-00105A6753FE}
// *********************************************************************//
  IAQtimeManagerDisp = dispinterface
    ['{63BD16B6-F03F-11D3-B765-00105A6753FE}']
    property Manager: IaqBaseManager readonly dispid 17821697;
    property IntegrationManager: IaqTimeIntegrationSupportManager readonly dispid 17821698;
    procedure Quit; dispid 17821699;
  end;

// *********************************************************************//
// The Class CoAQtime_ provides a Create and CreateRemote method to          
// create instances of the default interface IAQtimeManager exposed by              
// the CoClass AQtime_. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAQtime_ = class
    class function Create: IAQtimeManager;
    class function CreateRemote(const MachineName: string): IAQtimeManager;
  end;

implementation

uses ComObj;

class function CoAQtime_.Create: IAQtimeManager;
begin
  Result := CreateComObject(CLASS_AQtime_) as IAQtimeManager;
end;

class function CoAQtime_.CreateRemote(const MachineName: string): IAQtimeManager;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AQtime_) as IAQtimeManager;
end;

end.
