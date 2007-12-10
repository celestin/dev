# Microsoft Developer Studio Project File - Name="csp" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=csp - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "epm.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "epm.mak" CFG="csp - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "csp - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "csp - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "csp - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /MT /W3 /GX /O2 /I "c:\appserv\mysql\include" /I "C:\Dev\PS\epm\lic" /I "C:\Dev\PS\epm\xerces\include" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FR /FD /Zm512 /c
# ADD BASE RSC /l 0x809 /d "NDEBUG"
# ADD RSC /l 0x809 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 xerces-c_2.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib /nologo /subsystem:console /machine:I386 /libpath:"c:\Program Files\flexlm\v7.2\i86_n3" /libpath:"c:\appserv\mysql\lib\opt" /libpath:"C:\Dev\PS\epm\xerces\lib"
# SUBTRACT LINK32 /pdb:none /incremental:yes /nodefaultlib
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=C:\Dev\PS\epm\epm\Release\epm.copy.cmd
# End Special Build Tool

!ELSEIF  "$(CFG)" == "csp - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /I "C:\Dev\PS\epm\lic" /I "c:\Program Files\flexlm\v7.2\machind" /I "C:\AppServ\mysql\include" /I "C:\Dev\PS\epm\xerces\include" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /Zm512 /c
# ADD BASE RSC /l 0x809 /d "_DEBUG"
# ADD RSC /l 0x809 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 xerces-c_2d.lib mysqlclient.lib libmySQL.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /nodefaultlib:"libcd" /nodefaultlib:"libcpd" /pdbtype:sept /libpath:"c:\Program Files\flexlm\v7.2\i86_n3" /libpath:"C:\AppServ\mysql\lib\debug" /libpath:"C:\Dev\PS\epm\xerces\lib"
# SUBTRACT LINK32 /pdb:none
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=copy "C:\Dev\PS\epm\epm\Debug\epm.exe" "C:\Program Files\Power Software\Krakatau EPM"
# End Special Build Tool

!ENDIF 

# Begin Target

# Name "csp - Win32 Release"
# Name "csp - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\CSVReport.cpp
# End Source File
# Begin Source File

SOURCE=.\Diff.cpp
# End Source File
# Begin Source File

SOURCE=.\DiffAda.cpp
# End Source File
# Begin Source File

SOURCE=.\DiffASP.cpp
# End Source File
# Begin Source File

SOURCE=.\DiffCpp.cpp
# End Source File
# Begin Source File

SOURCE=.\DiffOracle.cpp
# End Source File
# Begin Source File

SOURCE=.\DiffPerl.cpp
# End Source File
# Begin Source File

SOURCE=.\DiffVB.cpp
# End Source File
# Begin Source File

SOURCE=.\Flex.cpp
# End Source File
# Begin Source File

SOURCE=.\HTMLReport.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.ada.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.asp.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.c.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.cs.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.idl.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.j.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.jsp.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.php.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.pl.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.s1.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.vb.cpp
# End Source File
# Begin Source File

SOURCE=.\lex.vhdl.cpp
# End Source File
# Begin Source File

SOURCE=.\main.cpp
# End Source File
# Begin Source File

SOURCE=.\OurSQL.cpp
# End Source File
# Begin Source File

SOURCE=.\PParse.cpp
# End Source File
# Begin Source File

SOURCE=.\PParseHandlers.cpp
# End Source File
# Begin Source File

SOURCE=.\Report.cpp
# End Source File
# Begin Source File

SOURCE=.\XMLReport.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\batch.h
# End Source File
# Begin Source File

SOURCE=.\CSVReport.h
# End Source File
# Begin Source File

SOURCE=.\Db.h
# End Source File
# Begin Source File

SOURCE=.\Diff.h
# End Source File
# Begin Source File

SOURCE=.\DiffAda.h
# End Source File
# Begin Source File

SOURCE=.\DiffASP.h
# End Source File
# Begin Source File

SOURCE=.\DiffCpp.h
# End Source File
# Begin Source File

SOURCE=.\DiffOracle.h
# End Source File
# Begin Source File

SOURCE=.\DiffPerl.h
# End Source File
# Begin Source File

SOURCE=.\DiffVB.h
# End Source File
# Begin Source File

SOURCE=.\epm.dtd
# End Source File
# Begin Source File

SOURCE=.\Extension.h
# End Source File
# Begin Source File

SOURCE=.\HTMLReport.h
# End Source File
# Begin Source File

SOURCE=.\Lang.h
# End Source File
# Begin Source File

SOURCE=.\lexer.ada.l
# End Source File
# Begin Source File

SOURCE=.\lexer.c.l
# End Source File
# Begin Source File

SOURCE=.\lexer.cs.l
# End Source File
# Begin Source File

SOURCE=.\lexer.idl.l
# End Source File
# Begin Source File

SOURCE=.\lexer.j.l
# End Source File
# Begin Source File

SOURCE=.\lexer.jsp.l
# End Source File
# Begin Source File

SOURCE=.\lexer.php.l
# End Source File
# Begin Source File

SOURCE=.\lexer.pl.l
# End Source File
# Begin Source File

SOURCE=.\lexer.s1.l
# End Source File
# Begin Source File

SOURCE=.\lexer.vb.l
# End Source File
# Begin Source File

SOURCE=.\lexer.vhdl.l
# End Source File
# Begin Source File

SOURCE=..\lic\LicConfig.h
# End Source File
# Begin Source File

SOURCE=.\Metric.h
# End Source File
# Begin Source File

SOURCE=.\Metrics.h
# End Source File
# Begin Source File

SOURCE=.\MetricSet.h
# End Source File
# Begin Source File

SOURCE=.\OurSQL.h
# End Source File
# Begin Source File

SOURCE=.\PParse.hpp
# End Source File
# Begin Source File

SOURCE=.\PParseHandlers.hpp
# End Source File
# Begin Source File

SOURCE=.\Project.h
# End Source File
# Begin Source File

SOURCE=.\Report.h
# End Source File
# Begin Source File

SOURCE=.\ReportItem.h
# End Source File
# Begin Source File

SOURCE=.\Tuple.h
# End Source File
# Begin Source File

SOURCE=.\Utilities.h
# End Source File
# Begin Source File

SOURCE=.\XMLConfig.h
# End Source File
# Begin Source File

SOURCE=.\XMLReport.h
# End Source File
# Begin Source File

SOURCE=.\y.ada.h
# End Source File
# Begin Source File

SOURCE=.\y.c.h
# End Source File
# Begin Source File

SOURCE=.\y.cs.h
# End Source File
# Begin Source File

SOURCE=.\y.idl.h
# End Source File
# Begin Source File

SOURCE=.\y.j.h
# End Source File
# Begin Source File

SOURCE=.\y.jsp.h
# End Source File
# Begin Source File

SOURCE=.\y.php.h
# End Source File
# Begin Source File

SOURCE=.\y.pl.h
# End Source File
# Begin Source File

SOURCE=.\y.s1.h
# End Source File
# Begin Source File

SOURCE=.\y.vb.h
# End Source File
# Begin Source File

SOURCE=.\y.vhdl.h
# End Source File
# End Group
# End Target
# End Project
