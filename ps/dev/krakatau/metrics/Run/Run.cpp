/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Application Launcher
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  27-Mar-08  347 : File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "stdafx.h"
#include "Run.h"
#include "RunConfig.h"

#include "lmpolicy.h"
#include <direct.h>

#define APP_FILE      "jre\\bin\\java"
#define LICENSE_FILE  "license.dat"
#define QUOT_CHAR   "\""

#define LICENSE_PATH  ".\\license.dat"
#define BUFFLEN 256

#include <fstream>
#include <iostream>
using namespace std ;

char *chopSlash(char *pathName) {

  int pathLen=strlen(pathName)-1 ;
  if (pathName[pathLen] == '\\') {
    pathName[pathLen] = '\0' ;
  }

  return pathName ;
}

HANDLE create_process(string cmdLine)
{
    STARTUPINFO si ;
  PROCESS_INFORMATION pi ;

    memset(&pi, 0, sizeof(pi)) ;
  memset(&si, 0, sizeof(si)) ;

  si.cb = sizeof(si) ;
    si.dwFlags |= STARTF_USESHOWWINDOW ;
    si.wShowWindow |= SW_SHOWMINIMIZED ;

  char mpath[256] ;
  strcpy_s(mpath, 256, cmdLine.c_str()) ;

    if (!CreateProcess(0,mpath, 0, 0, 0, 0, 0, 0, &si,&pi))
    {
        //DWORD myError = GetLastError() ;
        return NULL ;
    }

  return pi.hProcess ;
}



#ifdef BATCH_CONSOLE
int main(int argc, char *argv[])
{

  char cmdLine[BUFFLEN] ;
  char appPath[BUFFLEN] ;
  char cwdtmp[BUFFLEN] ;
  char cwd[BUFFLEN] ;

  strcpy_s(cwd, BUFFLEN, QUOT_CHAR) ;
  strcat_s(cwd, BUFFLEN, _getcwd(cwdtmp, BUFFLEN)) ;
  chopSlash(cwd) ;
  strcat_s(cwd, BUFFLEN, QUOT_CHAR) ;


  bool pathFound=false ;

  strcpy_s(cmdLine, BUFFLEN, " ") ;
  strcpy_s(appPath, BUFFLEN, "") ;

  for (int i=1; i<argc; i++) {

    if ((argv[i][0] == '-') && (argv[i][1] == 'p')) {
      strcpy_s(appPath, BUFFLEN, argv[i]+2) ;
      chopSlash(appPath) ;
    } else {

      char tmp[BUFFLEN] ;
      strcpy_s(tmp, BUFFLEN, QUOT_CHAR) ;
      strcat_s(tmp, BUFFLEN, argv[i]) ;
      chopSlash(tmp) ;
      strcat_s(tmp, BUFFLEN, QUOT_CHAR) ;

      strcat_s(cmdLine, BUFFLEN, tmp) ;
      strcat_s(cmdLine, BUFFLEN, " ") ;
    }
  }

  if (strlen(appPath)>0) {
    _chdir(appPath) ;
  }

#else
int WINAPI WinMain(HINSTANCE hInstance,
           HINSTANCE hPrevInstance,
           LPSTR lpCmdLine,
           int nCmdShow)
{
#endif

  bool evalLicense = false ;

  char *database ;

  OSVERSIONINFO oi ;
  oi.dwOSVersionInfoSize = sizeof(OSVERSIONINFO) ;

  GetVersionEx(&oi) ;
  if (oi.dwPlatformId==VER_PLATFORM_WIN32_WINDOWS) {
    database = _strdup("db\\bin\\mysqld.exe\0") ;
  } else if (oi.dwPlatformId==VER_PLATFORM_WIN32_NT) {
    database = _strdup("db\\bin\\mysqld-nt.exe --standalone\0") ;
  } else {
    return -1 ;
  }


  if (CHECKOUT(LM_RESTRICTIVE, LICENSE_TYPE, LICENSE_VERSION, LICENSE_PATH))
  {
#ifdef BATCH_CONSOLE
    PERROR("Checkout Failed") ;
    return 1 ;
#else
    //logFile << "Failed.\nTesting for '" << EVAL_LICENSE << "' validity..." ;

    if (CHECKOUT(LM_RESTRICTIVE, EVAL_LICENSE, LICENSE_VERSION, LICENSE_PATH))
    {
      //logFile << "Failed." << endl ;

      PERROR("Checkout Failed") ;
      return 1 ;
    }

    //logFile << "evalLicense=true... " ;
    evalLicense = true ;
#endif
  }
  //logFile << "Success!" << endl ;

#ifdef NT_SERVICE
  HANDLE pid ;
  char cmdexe[256] ;
  char installDir[256] ;
  string cmdNet ;

  _getcwd(installDir, 256) ;
  strcpy_s(cmdexe, 256, getenv("comspec")) ;

  // Install Service
  char cmdLine[512];
  strcpy_s(cmdLine, 512, "db\\bin\\mysqld-nt --install KrakatauDb --basedir=\"");
  strcat_s(cmdLine, 512, installDir);
  strcat_s(cmdLine, 512, "\\db\"");

  pid = create_process(cmdLine) ;
  WaitForSingleObject(pid, TIME_TO_WAIT) ;

  // Start Service
  pid = create_process("net start KrakatauDb") ;
  WaitForSingleObject(pid, TIME_TO_WAIT) ;

#else
  // Create MySQL cnf
  /*
  FILE *testFile = fopen("c:\\my.cnf", "w") ;
  fprintf(testFile, " \n") ;
  fclose(testFile) ;
  */

  HANDLE metDBpid ;
  metDBpid = create_process(database) ;
#endif

  // Start Krakatau front-end
#ifdef BATCH_CONSOLE
  if (argc>0)
#else
  if (strlen(lpCmdLine)>0)
#endif
  {

#ifdef BATCH_CONSOLE

    _spawnl(_P_WAIT,"jre\\bin\\java","jre\\bin\\java",OPTIONS,
      "-classpath", CLASSPATH, APPLICATION, LANG, FLAVOUR,
      "-p", cwd, cmdLine, NULL) ;
#else
    if (evalLicense)
    {
      _spawnl(_P_WAIT,"jre\\bin\\javaw","jre\\bin\\javaw",OPTIONS,
        "-classpath", CLASSPATH, APPLICATION, LANG, FLAVOUR, EVAL_OPTION,
        lpCmdLine, NULL) ;
    }
    else
    {
      _spawnl(_P_WAIT,"jre\\bin\\javaw","jre\\bin\\javaw",OPTIONS,
        "-classpath",CLASSPATH,APPLICATION, LANG, FLAVOUR, lpCmdLine, NULL) ;
    }
#endif
  }
  else
  {
#ifdef BATCH_CONSOLE
    _spawnl(_P_WAIT,"jre\\bin\\java","jre\\bin\\java",OPTIONS,"-classpath",CLASSPATH,APPLICATION, LANG, FLAVOUR, NULL) ;
#else
    if (evalLicense)
    {
      //logFile << "In here." << endl ;

      _spawnl(_P_WAIT,"jre\\bin\\javaw","jre\\bin\\javaw",OPTIONS,
        "-classpath", CLASSPATH, APPLICATION, LANG, FLAVOUR, EVAL_OPTION, NULL) ;
    }
    else
    {
      _spawnl(_P_WAIT,"jre\\bin\\javaw","jre\\bin\\javaw",OPTIONS,
        "-classpath",CLASSPATH,APPLICATION, LANG, FLAVOUR, NULL) ;
    }
#endif
  }


#ifdef NT_SERVICE
  // Stop Service
  pid = create_process("net stop KrakatauDb");
  WaitForSingleObject(pid, TIME_TO_WAIT);

  // Remove Service
  pid = create_process("db\\bin\\mysqld-nt.exe --remove KrakatauDb") ;
  WaitForSingleObject(pid, TIME_TO_WAIT) ;
#else
  if (oi.dwPlatformId==VER_PLATFORM_WIN32_WINDOWS) {
    create_process("db\\bin\\mysqladmin.exe shutdown") ;
  } else if (oi.dwPlatformId==VER_PLATFORM_WIN32_NT) {
    TerminateProcess(metDBpid, 0) ;
  } else {
    return -1 ;
  }
#endif


  return FALSE ;
}
