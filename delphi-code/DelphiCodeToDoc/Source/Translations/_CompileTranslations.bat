@echo off
echo #Compiling *.mo files
msgfmt LanguageCodes\languagecodes.po -olanguagecodes.mo
msgfmt cs.po -ocs.mo
msgfmt de.po -ode.mo
msgfmt fr_FR.po -ofr_FR.mo
msgfmt hu.po -ohu.mo
msgfmt it.po -oit.mo
msgfmt polish.po -opolish.mo
msgfmt ru.po -oru.mo
msgfmt zh_CN.po -ozh_CN.mo
msgfmt zh_TW.po -ozh_TW.mo
msgfmt pt_BR.po -opt_BR.mo


echo # DONE !
pause
