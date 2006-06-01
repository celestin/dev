/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * EPM Reporting
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  02-Jan-05  File added.
 * CAM  08-Jan-05  Improved efficiency of isPM() by adding getProjectCount().
 * CAM  26-Mar-05    79 : Moved common code to Report class.
 * CAM  04-May-05    50 : Set Language.
 * CAM  23-Aug-05   115 : SQL for Single Project correct (Language).
 * CAM  28-Nov-05   164 : Added retrieval of NFILE for Project metrics.
 * CAM  28-Jan-06   180 : Use Metric ID (mid) from the database not an calculated index.
 * CAM  28-Jan-06   168 : Added setMetricsSet and related functions for MetricSets.
 * CAM  07-Feb-06   187 : Added return number of items to getItems().
 * CAM  23-Mar-06   220 : Ensure New metric values are stored in position 1 (as are Deleted).
 * CAM  23-Mar-06   218 : Commented out the Project Halstead metrics retrieve.
 * CAM  25-Mar-06   220 : Above (220) comment is nonsense - new values should be in position 0.  Adjusted HTMLReport accordingly.
 * CAM  01-Jun-06   252 : Re-instate Halstead metrics for Project level, but only show Min/Max/Avg.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <iostream>
using namespace std;

#include "Report.h"
#include "OurSQL.h"
using namespace metrics;

extern MetricSet *metSet;

Report::Report(OurSQL &db, std::string path) {
  theDb = db;
  thePath = path;
  theProjCount = -1;
}

void Report::setPath() {
  const char* p = thePath.c_str();
  if (p[strlen(p)-1] != '\\') {
    thePath += '\\';
  }
}

int Report::getProjectCount() {
  if (theProjCount >= 0) {
    return theProjCount;
  }

  char sql[2048];
  bool rval = false;

  strcpy(sql, "SELECT count(*) proj_count FROM project ");
  if (theDb.executeQuery(sql)) {
    theProjCount = theDb.longCell(0,0);
    theDb.clearResults();
  }

  return theProjCount;
}


bool Report::isPM() {
  return (getProjectCount() > 1);
}


void Report::makePath() const {
}


bool Report::isSetMember(int mid) {
  return metSet->isActive(mid);
}

bool Report::isAnyStandard() {
  if (!metSet->isActive()) return true;

  for (int i=LOC; i<NFILE; i++) {
    if (metSet->isActive(i)) return true;
  }
  return false;
}

bool Report::isAnyChanged(long lastMid) {
  if (!metSet->isActive()) return true;

  for (int i=CLOC; i<lastMid; i++) {
    if (metSet->isActive(i)) return true;
  }
  return false;
}

void Report::setMetricsSet(string msName) {
  if (metSet->setActive(msName.c_str())) {
    cout << "Applying Metric Set \"" << msName << "\"" << endl;
  } else {
    cout << "Could not find Metric Set \"" << msName << "\"!" << endl;
  }
}


void Report::getMetDesc() {
  char sql[2048];
  strcpy(sql, "SELECT mid-100, m_name, m_desc FROM metric ORDER BY mid");

  if (theDb.executeQuery(sql)) {
    for (int r=0; r<theDb.rows(); r++) {
      metCode[theDb.longCell(r, 0)] = theDb.cell(r, 1);
      metDesc[theDb.longCell(r, 0)] = theDb.cell(r, 2);
    }
  }
  theDb.clearResults();
}

long Report::getItems() {
  char sql[2048];
  long f;

  getMetDesc();
  projMet.clearMetrics();

  if (isPM()) {
    strcpy(sql, "SELECT IfNull(cf.status, ' ') status, cf.sfid, cf.sfid2, sf1.sf_shortname, sf1.sf_name, IfNull(sf2.sf_name, 'empty'), IfNull(sf1.sf_type, 0) ");
    strcat(sql, "FROM sourcefile sf1, comparefile cf ");
    strcat(sql, "LEFT OUTER JOIN sourcefile sf2 ");
    strcat(sql, "ON cf.sfid2 = sf2.sfid ");
    strcat(sql, "WHERE cf.sfid = sf1.sfid ");
    strcat(sql, "ORDER BY sf1.sf_shortname ");

    if (theDb.executeQuery(sql)) {
      for (f=0; f<theDb.rows(); f++) {
        ReportItem rfile(ITEM_FILE, theDb.cell(f, 0), theDb.cell(f, 1), theDb.cell(f, 2),
                         theDb.cell(f, 3), theDb.cell(f, 4), theDb.cell(f, 5));
        rfile.setLanguage(theDb.cell(f,6));
        fileList.push_back(rfile);
      }
      theDb.clearResults();
    }
  } else {
    strcpy(sql, "SELECT sfid, sf_shortname, sf_name, IfNull(sf_type, 0) ");
    strcat(sql, "FROM sourcefile ");
    strcat(sql, "ORDER BY sf_shortname ");

    string dummy = "empty";
    if (theDb.executeQuery(sql)) {
      for (f=0; f<theDb.rows(); f++) {
        ReportItem rfile(ITEM_FILE, dummy, theDb.cell(f, 0), dummy,
                         theDb.cell(f, 1), theDb.cell(f, 2), dummy);
        rfile.setLanguage(theDb.cell(f,3));
        fileList.push_back(rfile);
      }
      theDb.clearResults();
    }
  }

  if (fileList.size() == 0) return 0;

  // Get Project details
  strcpy(sql, "SELECT projid, pr_name, snap_date, base_dir ");
  strcat(sql, "FROM project ");
  strcat(sql, "ORDER BY projid ");

  if (theDb.executeQuery(sql)) {
    for (f=0; f<theDb.rows(); f++) {
      project[f] = ReportItem(ITEM_PROJECT, theDb.cell(f, 0), theDb.cell(f, 0), theDb.cell(f, 0),
                       theDb.cell(f, 1), theDb.cell(f, 3), theDb.cell(f, 1));
      project[f].setText1(theDb.cell(f, 2));
    }
    theDb.clearResults();
  }

  return fileList.size();
}

void Report::getMetrics(ReportItem &currItem) {
  char sql[2048];
  int r,j,k;
  long id,mid,value;

  met.clearMetrics();

  strcpy(sql, "SELECT sfid,mid,mvalue FROM sourcemetric WHERE sfid IN (");
  strcat(sql, currItem.getID().c_str());

  if (isPM()) {
    strcat(sql, ",");
    strcat(sql, currItem.getID2().c_str());
  }

  strcat(sql, ") ORDER BY sfid,mid");

  j=k=0;

  if (!currItem.getStatus().compare("D")) j++;

  if (theDb.executeQuery(sql)) {
    for (r=0; r<theDb.rows(); r++) {
      id = theDb.longCell(r, 0);
      mid = theDb.longCell(r, 1);
      value = theDb.longCell(r, 2);

      if (currItem != id && (j == 0)) {
        j++;
      }

      // Ensure Changed metrics are always in position 0
      k = ((mid >= CLOC) && (mid <= ALOC)) ? 0 : j;

      met.set(MET(mid), k, value);
    }
    theDb.clearResults();
  }

  met.calculateChange(currItem);

  projMet.add(met);
}

void Report::calculateProjectMetrics() {
  //projMet.calculateHalstead();

  char sql[2048];
  //char mid[256];
  long f;

  // Retrieve Min/Max/Avg
  strcpy(sql, "SELECT sf.projid,sm.mid,MIN(mvalue) valmin, MAX(mvalue) valmax, AVG(mvalue) valavg ");
  strcat(sql, "FROM sourcemetric sm, sourcefile sf ");
  strcat(sql, "WHERE sm.sfid = sf.sfid ");
  strcat(sql, "AND sf.projid = 1 AND mvalue>0 ");
  strcat(sql, "GROUP BY sf.projid, sm.mid");

  if (theDb.executeQuery(sql)) {
    for (f=0; f<theDb.rows(); f++) {
      //Have to set in strings rather than numerics
      projMet.set(MET(theDb.longCell(f, 1)), theDb.longCell(f, 2), theDb.longCell(f, 3), theDb.longCell(f, 4));
    }
    theDb.clearResults();
  }

  // Retrieve NFILE
  strcpy(sql, "SELECT projid, COUNT(*) nfile ");
  strcat(sql, "FROM sourcefile ");
  strcat(sql, "GROUP BY projid");

  if (theDb.executeQuery(sql)) {
    for (f=0; f<theDb.rows(); f++) {
      projMet.set(MET(NFILE), theDb.longCell(f, 0)-1, theDb.longCell(f, 1));
    }
    theDb.clearResults();
  }
}

