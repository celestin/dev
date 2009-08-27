/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Event Logging
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Aug-2009  10483 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <time.h>
#include "EpmVersion.h"

char *logfilename = NULL;
fstream logfile;

void logDateTime()
{
  char sDate[9];
  char sTime[9];
  _strdate_s(sDate);
  _strtime_s(sTime);

  if (!logfile.is_open()) return;
  logfile << sDate << " " << sTime << "  " << flush;
}

void openLogfile()
{
  if (!logfilename) return;

  logfile.open(logfilename, ios::out);
  logDateTime();
  logfile << "Essential Project Manager (EPM) Version " << EPM_VERSION << endl;
  logfile.close();
}

void logEvent(char* message)
{
  logfile.open(logfilename, ios::app);
  logDateTime();
  logfile << message << endl;
  logfile.close();
}
