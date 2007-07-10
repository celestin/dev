/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Create Process
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  20-Dec-04  File added.
 * CAM  19-Jan-04  Added TIME_TO_WAIT.
 * CAM  24-Nov-05  160 : Added ignoreHandles to createProcess.
 * CAM  28-Jan-06   168 : Added METRICS_SET_MASK.
 * CAM  07-Feb-06   187 : Added MYSQL_PARAM_SIZE.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "OurSQL.h"

#ifndef BATCH_HEADER
#define BATCH_HEADER

#include <stack>

#include <windows.h>
#include <windef.h>
#include <process.h>
#include <io.h>
#include <direct.h>

#include <iostream>
#include <fstream>

#define FEATURE "cspm"

//#include "lmpolicy.h"
#include <limits.h>
#include <fcntl.h>


#ifndef PATH_MAX
  #ifdef MAX_PATH
    #define PATH_MAX MAX_PATH
  #endif
#endif

#define QUERY_MAX 4096
#define MYSQL_PARAM_SIZE 256
#define PROJECT_MAX 10
#define TIME_TO_WAIT 25000

#define realpath(X,Y) _fullpath(Y, X, PATH_MAX)

HANDLE createProcess(std::string cmdLine, bool ignoreHandles)
{
  STARTUPINFO si;
  PROCESS_INFORMATION pi;

  memset(&pi, 0, sizeof(pi));
  memset(&si, 0, sizeof(si));

  si.cb = sizeof(si);
  si.dwFlags |= STARTF_USESHOWWINDOW;
  si.wShowWindow |= SW_SHOWMINIMIZED;

  if (ignoreHandles) {
    si.dwFlags |= STARTF_USESTDHANDLES;
    si.hStdInput = NULL;
    si.hStdOutput = NULL;
    si.hStdError = NULL;
  }

  char mpath[256];
  strcpy(mpath, cmdLine.c_str());

  if (!CreateProcess(0,mpath, 0, 0, true, 0, 0, 0, &si,&pi))
  {
    return NULL;
  }

  return pi.hProcess;
}

HANDLE createProcess(std::string cmdLine)
{
  return createProcess(cmdLine, false);
}

#define MkDir(X) mkdir(X)

#include <sys/types.h>
#include <sys/stat.h>
//#include <sys/wait.h>

#define RECURSIVE_MASK      0x0000001
#define DIR_MASK            0x0000002
#define SINGLE_GRID_MASK    0x0000004
#define MULTIPLE_GRID_MASK  0x0000008
#define SINGLE_SYMB_MASK    0x0000010
#define MULTIPLE_SYMB_MASK  0x0000020
#define CSV_MASK            0x0000040
#define FILE_LIST_MASK      0x0000080
#define XML_MASK            0x0000100
#define OEM_MASK            0x0000200
#define METRICS_SET_MASK    0x0000400

#endif