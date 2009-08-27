/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * XML Reporting
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Mar-05    85 : Class created.
 * CAM  07-Feb-06    187 : Check getItems() are report error if zero.
 * CAM  25-Mar-06    221 : Obey the Metrics.isShow rules.
 * CAM  06-Jun-06    257 : If a MetricSet has been specified, only display chosen metrics.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  27-Aug-2009  10483 : Removed event output to main program.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <fstream>
#include <iostream>
#include <vector>
using namespace std;

#include "XMLReport.h"
#include "ReportItem.h"
using namespace metrics;

XMLReport::XMLReport(OurSQL &db, std::string path) : Report(db, path) {
}

void XMLReport::xmlMetrics(ofstream &current, ReportItem &currItem, std::string &tab) {
  unsigned int i;
  char newVal[256];
  char oldVal[256];
  char diffVal[256];
  string status;
  Metrics m;

  current << tab << "<Metrics>" << endl;

  lastMetric = MET(CLOC);

  if (currItem.getType() == ITEM_PROJECT) {
    m = projMet;

    if (isPM()) {
      lastMetric = METS;
    } else {
      lastMetric = MET(CLOC);
    }

  } else {
    m = met;

    if (isPM()) {
      lastMetric = METFILE;
    }
  }

  for (i=0; i<lastMetric; i++) {
    if (m.isShow(currItem, i) && isSetMember(METID(i))) {
      float diff = (m.get(i,0) - m.get(i,1));

      sprintf_s(newVal, 256, "val=\"%d\" ", (long) m.get(i,0));
      sprintf_s(oldVal, 256, "oldVal=\"%d\" ", (long) m.get(i,1));
      sprintf_s(diffVal, 256, "diffVal=\"%d\" ", (long) diff);

      current << tab << "  <Met id=\"" << (i+100) << "\" " << flush;

      if (currItem.getType() == ITEM_PROJECT) {
        current << "code=\"" << metCode[i] << "\" "
            << "description=\"" << metDesc[i] << "\" " << flush;
      }

      if (currItem.getType() == ITEM_PROJECT) {
        current << newVal;

        if (isPM() && (i<MET(CLOC))) {
        current << oldVal;
        current << diffVal;
        }
      } else {
        if (currItem.getItemStatus() != STATUS_DELETED) {
        current << newVal;
        }

        if (currItem.getItemStatus() == STATUS_CHANGED || currItem.getItemStatus() == STATUS_DELETED) {
        if (i<MET(CLOC)) current << oldVal;
        }

        if (currItem.getItemStatus() == STATUS_CHANGED) {
        if (i<MET(CLOC)) current << diffVal;
        }
      }

      current << "/>" << endl;
    }
  }

  current << tab << "</Metrics>" << endl;
}

void XMLReport::execute() {
  ofstream current;
  string fname;
  string tab = "      ";
  char stat;
  unsigned int f;

  getMetDesc();

  current.clear();
  current.open(thePath.c_str()) ;
  current << "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" << endl;

  if (getItems() == 0) {
    cout << "No source files found... " << flush;
    return;
  }

  current << "<Project name=\"" << project[0].getShortName() << "\" "
          << "snapshotDate=\"" << project[0].getText1() << "\">" << endl;

  current << "  <Items>" << endl;

  for (f=0; f<fileList.size(); f++) {
    getMetrics(fileList[f]);

    current << "    <File id=\"" << fileList[f].getID() << "\" "
            << "name=\"" << fileList[f].getShortName() << "\"";

    if (isPM()) {
      stat = fileList[f].getStatus().c_str()[0];
      switch (stat) {
        case 'C':
        case 'D':
        case 'A':
          current << " status=\"" << stat << "\"";
          break;
        default:
          break;
      }
    }

    current << ">" << endl;

    xmlMetrics(current, fileList[f], tab);

    current << "    </File>" << endl;
  }

  current << "  </Items>" << endl;

  tab = "  ";
  calculateProjectMetrics();
  xmlMetrics(current, project[0], tab);

  current << "</Project>" << endl;

  current.close();
}
