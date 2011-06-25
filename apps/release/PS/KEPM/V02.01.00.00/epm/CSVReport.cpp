/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * CSV Reporting
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  26-Mar-05    79 : Class created.
 * CAM  07-Feb-06    187 : Check getItems() are report error if zero.
 * CAM  25-Mar-06    221 : Obey the Metrics.isShow rules.
 * CAM  06-Jun-06    257 : If a MetricSet has been specified, only display chosen metrics.
 * CAM  06-Jun-06    255 : Ensure DEL_SLOC and DEL_FILE appear on the Old Line for CSV.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  24-Apr-08    356 : Added DLLOC special condition along with DLOC and DFILE.
 * CAM  12-May-2009  10445 : Quotes around text/filenames to prevent commas disrupting the CSV format.
 * CAM  20-Aug-2009  10456 : Output values as floats.
 * CAM  27-Aug-2009  10483 : Removed event output to main program.
 * CAM  04-Feb-2010  10556 : Ensure CRN_SLOC, CRN_LLOC and CRN_FILE values are correct for DELETED files.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <fstream>
#include <iostream>
#include <vector>
using namespace std;

#include "CSVReport.h"
#include "ReportItem.h"
using namespace metrics;

CSVReport::CSVReport(OurSQL &db, std::string path) : Report(db, path) {
}

void CSVReport::csvLine(ofstream &current, ReportItem &currItem) {
  const int MAX_CSVLINE = 4096;
  unsigned int i;
  int nline,oline;
  char startLine[MAX_CSVLINE];
  char newLine[MAX_CSVLINE];
  char oldLine[MAX_CSVLINE];
  char diffLine[MAX_CSVLINE];
  char metValue[256];
  string status;
  Metrics m;

  sprintf_s(startLine, MAX_CSVLINE, "%d,%d,\"%s\",\"%s\",", currItem.getID().c_str(), currItem.getType(), currItem.getShortName().c_str(), currItem.getText1().c_str());

  if (currItem.getType() == ITEM_PROJECT) {
    m = projMet;
    if (isPM()) status = 'C';
  } else {
    m = met;
    char stat = currItem.getStatus().c_str()[0];
    switch (stat) {
      case 'C':
      case 'D':
        status = stat;
        break;
      case 'A':
        status = 'N';
        break;
      default:
        if (isPM()) status = 'U';
        break;
    }
  }

  strcpy_s(newLine, MAX_CSVLINE, startLine);
  strcat_s(newLine, MAX_CSVLINE, status.c_str());

  strcpy_s(diffLine, MAX_CSVLINE, startLine);
  strcat_s(diffLine, MAX_CSVLINE, "X");

  if (currItem.getType() == ITEM_PROJECT && isPM()) {
    sprintf_s(startLine, MAX_CSVLINE, "%d,%d,\"%s\",\"%s\",", project[1].getID().c_str(), project[1].getType(), project[1].getShortName().c_str(), project[1].getText1().c_str());
  }

  strcpy_s(oldLine, MAX_CSVLINE, startLine);
  strcat_s(oldLine, MAX_CSVLINE, "O");

  for (i=0; i<lastMetric; i++) {
    if (isSetMember(METID(i))) {
      if (m.isShow(currItem, i)) {
        float diff = (m.get(i,0) - m.get(i,1));

        nline = 0;
        oline = 1;
        if ((i == MET(DLOC)) || (i == MET(DLLOC)) || (i == MET(DFILE))) {
          nline = 1;
          oline = 0;
        }
        if ((currItem.getItemStatus() == STATUS_DELETED) &&
           ((i == MET(XLOC)) || (i == MET(XLLOC)) || (i == MET(XFILE)))) {
          int j=0;
          switch (i) {
            case MET(XLOC):
              j=MET(DLOC);
              break;
            case MET(XLLOC):
              j=MET(DLLOC);
              break;
            case MET(XFILE):
              j=MET(DFILE);
              break;

          }
          sprintf_s(metValue, 256, ",%f", m.get(j,nline));
          strcat_s(oldLine, MAX_CSVLINE, metValue);
        } else {
          sprintf_s(metValue, 256, ",%f", m.get(i,nline));
          strcat_s(newLine, MAX_CSVLINE, metValue);

          sprintf_s(metValue, 256, ",%f", m.get(i,oline));
          strcat_s(oldLine, MAX_CSVLINE, metValue);

          sprintf_s(metValue, 256, ",%f", diff);
          strcat_s(diffLine, MAX_CSVLINE, metValue);
        }
      } else {
        strcpy_s(metValue, 256, ",");
        strcat_s(newLine, MAX_CSVLINE, metValue);
        strcat_s(oldLine, MAX_CSVLINE, metValue);
        strcat_s(diffLine, MAX_CSVLINE, metValue);
      }
    }
  }

  if (currItem.getType() == ITEM_PROJECT) {
    current << newLine << endl;

    if (isPM()) {
      current << oldLine << endl;
      current << diffLine << endl;
    }
  } else {
    if (currItem.getItemStatus() != STATUS_DELETED) {
      current << newLine << endl;
    }

    if (currItem.getItemStatus() == STATUS_CHANGED || currItem.getItemStatus() == STATUS_DELETED) {
      current << oldLine << endl;
    }

    if (currItem.getItemStatus() == STATUS_CHANGED) {
      current << diffLine << endl;
    }
  }
}

void CSVReport::execute() {
  ofstream current;
  string fname;
  unsigned int f;

  if (isPM()) {
    lastMetric = METS;
  } else {
    lastMetric = MET(CLOC);
  }

  getMetDesc();

  current.clear();
  current.open(thePath.c_str()) ;
  current << "id,item_type,name,snapshot,line_type" << flush;

  for (f=0; f<lastMetric; f++) {
    if (isSetMember(METID(f))) {
      current << ',' << metCode[f] << flush;
    }
  }
  current << endl;

  if (getItems() == 0) {
    cout << "No source files found... " << flush;
    return;
  }

  for (f=0; f<fileList.size(); f++) {
    getMetrics(fileList[f]);
    csvLine(current, fileList[f]);
  }

  calculateProjectMetrics();
  csvLine(current, project[0]);

  current.close();
}
