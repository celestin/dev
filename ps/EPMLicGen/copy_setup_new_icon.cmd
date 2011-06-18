
echo $Id: $

@echo off

set SETUPFILE=setup.exe
set INSTALLFILE=PowerSoftwareLicGen.exe
set OUTPUT_PATH=C:\Dev\PS\EPMLicGen\EPMLicGen\Express\SingleImage\DiskImages\DISK1
set ICON=C:\Dev\PS\EPMLicGen\LicenseKey.ico
set ZIPFILE=licgen_303_0000.zip

echo Copying output SETUP.EXE and replacing Icon

"C:\Dev\bin\ResHack\ResHacker.exe" -addoverwrite "%OUTPUT_PATH%\%SETUPFILE%", "%INSTALLFILE%", "%ICON%", ICONGROUP,MAINICON,0

echo Zipping file

zip %ZIPFILE% %INSTALLFILE%

echo Deleting temp exe 

del %INSTALLFILE%

