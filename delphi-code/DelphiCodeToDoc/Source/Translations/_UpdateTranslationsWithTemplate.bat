@echo off
rem The languages that are known
set LANGUAGES=cs de fr_FR hu it it2 polish ru zh_CN zh_TW pt_BR

echo #Update Translations With latest Template
FOR %%l IN (%LANGUAGES%) DO call :UpdateLanguage %%l
echo.
echo # DONE !
pause
exit

:UpdateLanguage
echo Processing [ %1 ]
msgmerge -U %1.po default.po
goto :eof


