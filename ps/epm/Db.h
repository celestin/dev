/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * MySQL Database Control through Registry and Services
 *
 * $Id$
 *
 * Who  When        Why
 * CAM  20-Dec-04   File added.
 * CAM  24-Nov-05   160 : Use Windows Services rather standalone mode.
 * CAM  11-May-06   241 : Allow EPM to be run from any location.
 * CAM  30-May-06   244 : Ensure trailing slash is present on InstallDir.
 *                        Remove old service of the same name before installing.
 *                        Wait for Service Remove/Install to complete before starting.
 * CAM  24-Apr-08   358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  30-May-08   365 : Only start the MySQL process if required.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef DB_HEADER
#define DB_HEADER

#include "batch.h"
#include <process.h>
#include <windows.h>
#include <stdlib.h>

using namespace std;

string getInstallDir() {
  HKEY hkey;
  char szKey[1024];
  strcpy_s(szKey, 1024, "Software\\Power Software\\EPM");
  string rval;

  if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, szKey, 0, KEY_QUERY_VALUE, &hkey) == ERROR_SUCCESS) {
    DWORD dwType = 0;
    char installDir[2048];
    DWORD dwSize = sizeof(installDir);
    RegQueryValueEx(hkey, "InstallDir", NULL, &dwType, (BYTE*)&installDir, &dwSize);

    rval = installDir;

    RegCloseKey(hkey);
  }

  if (rval.substr(rval.length()-1,rval.length()).c_str()[0] != '\\') {
    // Ensure there is a trailing slash
    rval += '\\';
  }

  return rval;
}

void startDatabase(bool start) {
  HANDLE pid;
  const int MAX_CMD = 4096;
  char cmdLine[MAX_CMD];
  string dir = getInstallDir();

  // Remove any old database service of the same name
  strcpy_s(cmdLine, MAX_CMD, dir.c_str());
  strcat_s(cmdLine, MAX_CMD, "db\\bin\\mysqld-nt --remove EPMdb");
  pid = createProcess(cmdLine, true);
  WaitForSingleObject(pid, TIME_TO_WAIT);

  // Install the database service
  strcpy_s(cmdLine, MAX_CMD, dir.c_str());
  strcat_s(cmdLine, MAX_CMD, "db\\bin\\mysqld-nt --install EPMdb --basedir=\"");
  strcat_s(cmdLine, MAX_CMD, dir.c_str());
  strcat_s(cmdLine, MAX_CMD, "db\"");
  pid = createProcess(cmdLine, true);
  WaitForSingleObject(pid, TIME_TO_WAIT);

  if (start)
  {
    // Start the Service
    pid = createProcess("net start EPMdb");
    WaitForSingleObject(pid, TIME_TO_WAIT);
  }
}

void stopDatabase() {
  HANDLE pid;
  // Stop database Service
  cout << endl;
  pid = createProcess("net stop EPMdb");
  WaitForSingleObject(pid, TIME_TO_WAIT);
}


#endif