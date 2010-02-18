
echo $Id$

@echo off

set SETUPFILE=setup.exe
set INSTALLFILE=KrakatauEpmSetup.exe
set OUTPUT_PATH=C:\Dev\PS\Release\em\emetrics_kepm\Express\SingleImage\DiskImages\DISK1
set ICON=C:\Dev\PS\Release\em\Common\VolcanoEPM.ico
set ZIPFILE=kepm_114_0001.zip

echo Copying output SETUP.EXE and replacing Icon

"C:\Dev\bin\ResHack\ResHacker.exe" -addoverwrite "%OUTPUT_PATH%\%SETUPFILE%", "%INSTALLFILE%", "%ICON%", ICONGROUP,MAINICON,0

echo Zipping file

zip %ZIPFILE% %INSTALLFILE%

echo Deleting temp exe 

del %INSTALLFILE%

