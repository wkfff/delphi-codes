color A

cd /d %1


pause

del /S *.~*
del /S *.*~
del /S *.bkm
del /S *.dcu
del /S *.ddp
del /S *.drc
del /S *.dsk
del /S *.elf
del /S *.hpp
del /S *.map
del /S *.mps
del /S *.mpt
del /S *.rsb
del /S *.rsm
del /S *.stat

del /S *.bdsproj.local
del /S *.bdsgroup.local
del /S *.dcuil
del /S *.identcache

del /S *.dproj.local
del /S *.groupproj.local

del /S .cvsignore
del /S vssver.scc
del /S mssccprj.scc

del /S *.compiled
del /S *.o
del /S *.ppu
del /S *.rst

del /S *.exe

del /S /F /A:R *.drc

echo off
for /r %1 %%i in (__history) do if exist "%%i" rd /s/q "%%i"

pause
