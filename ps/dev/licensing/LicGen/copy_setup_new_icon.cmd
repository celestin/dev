
echo $Id$

@echo off

set SETUPFILE=setup.exe
set INSTALLFILE=PowerSoftwareLicGen.exe
set OUTPUT_PATH=C:\Dev\PS\licensing\LicGen\LicGen\Express\SingleImage\DiskImages\DISK1
set ICON=C:\Dev\PS\licensing\LicGen\LicenseKey.ico
set ZIPFILE=licgen_400_0000.zip

echo Copying output SETUP.EXE and replacing Icon

"C:\Dev\bin\ResHack\ResHacker.exe" -addoverwrite "%OUTPUT_PATH%\%SETUPFILE%", "%INSTALLFILE%", "%ICON%", ICONGROUP,MAINICON,0

echo Zipping file

zip %ZIPFILE% %INSTALLFILE%

echo Deleting temp exe 

del %INSTALLFILE%
