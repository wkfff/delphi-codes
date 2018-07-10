@echo off
echo #Copying Translation to DCTD EXE directory (xx/LC_MESSAGES)
copy LanguageCodes.mo 	..\..\Exe\languagecodes.mo
copy cs.mo 	..\..\Exe\locale\cs\LC_MESSAGES\default.mo
copy de.mo 	..\..\Exe\locale\de\LC_MESSAGES\default.mo
copy fr_FR.mo 	..\..\Exe\locale\fr\LC_MESSAGES\default.mo
copy hu.mo 	..\..\Exe\locale\hu\LC_MESSAGES\default.mo
copy it.mo 	..\..\Exe\locale\it\LC_MESSAGES\default.mo
copy polish.mo 	..\..\Exe\locale\pl\LC_MESSAGES\default.mo
copy ru.mo 	..\..\Exe\locale\ru\LC_MESSAGES\default.mo
copy zh_CN.mo 	..\..\Exe\locale\zh_CN\LC_MESSAGES\default.mo
copy zh_TW.mo 	..\..\Exe\locale\zh_TW\LC_MESSAGES\default.mo
copy pt_BR.mo 	..\..\Exe\locale\pt_BR\LC_MESSAGES\default.mo
echo # DONE !
pause
