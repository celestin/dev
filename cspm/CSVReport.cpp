/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * C# parser
 * Copyright 2004 Craig McKay <craig@southesk.com>
 *
 * CSV Report Builder
 *
 * $Log: /cspm/CSVReport.cpp $
 * 
 * 1     27/03/05 21:53 Craig
 * 79
 *
 * Who  When       Why
 * CAM  26-Mar-05    79 : Class created.
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
  int i;
  char startLine[2048];
  char newLine[4096];
  char oldLine[4096];
  char diffLine[4096];
  char metValue[256];
  string status;
  Metrics m;

  sprintf(startLine, "%d,%d,%s,%s,", currItem.getID().c_str(), currItem.getType(), currItem.getShortName().c_str(), currItem.getText1().c_str());

  if (currItem.getType() == ITEM_PROJECT) {
    m = projMet;
    if (isPM()) status = 'C';
  } else {
    m = met;
    char stat = currItem.getStatus().c_str()[0];
    switch (stat) {
      case 'C':
      case 'D':
      case 'A':
        status = stat;
        break;
      default:
        if (isPM()) status = 'U';
        break;
    }
  }

  strcpy(newLine, startLine);
  strcat(newLine, status.c_str());

  strcpy(diffLine, startLine);
  strcat(diffLine, "X");

  if (currItem.getType() == ITEM_PROJECT && isPM()) {
    sprintf(startLine, "%d,%d,%s,%s,", project[1].getID().c_str(), project[1].getType(), project[1].getShortName().c_str(), project[1].getText1().c_str());
  }

  strcpy(oldLine, startLine);
  strcat(oldLine, "O");

  for (i=0; i<lastMetric; i++) {
    float diff = (m.get(i,0) - m.get(i,1));

    sprintf(metValue, ",%d", (long) m.get(i,0));
    strcat(newLine, metValue);

    sprintf(metValue, ",%d", (long) m.get(i,1));
    strcat(oldLine, metValue);

    sprintf(metValue, ",%d", (long) diff);
    strcat(diffLine, metValue);
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

void CSVReport::executeCSV() {
  ofstream current;
  string fname;
  int f;

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
    current << ',' << metCode[f] << flush;
  }
  current << endl;

  getItems();

  for (f=0; f<fileList.size(); f++) {
    getMetrics(fileList[f]);
    csvLine(current, fileList[f]);
  }

  calculateProjectMetrics();
  csvLine(current, project[0]);

  current.close();
}

void CSVReport::execute() {
  if (isPM()) {
    cout << "CSV PM Report... " << flush;
  } else {
    cout << "CSV single project Report... " << flush;
  }

  executeCSV();
  cout << "Done." << endl;
}