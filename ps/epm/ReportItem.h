/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Stores information about items (Projects, Packages, Files) used in reporting
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  04-Jan-05    File added.
 * CAM  04-Jan-05    Expanded to use multiple types.
 * CAM  26-Jan-05    Added setStatus.
 * CAM  31-Jan-05    Added enum for Status.
 * CAM  03-Feb-05    39 : Added Text1.
 * CAM  04-May-05    50 : Added Language.
 * CAM  28-Jan-06    168 : Added getLastMetric.
 * CAM  18-Jul-06    272 : Added getLang.
 * CAM  17-Apr-2009  10430 : Extended last metrics to include Churn.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_REPORTITEM
#define CLASS_REPORTITEM

#include "Lang.h"
#include "Metric.h"

using namespace std;

enum ItemTypes { ITEM_PROJECT, ITEM_FILE };
enum ItemStatus { STATUS_ALL, STATUS_UNCHANGED, STATUS_CHANGED, STATUS_DELETED, STATUS_ADDED };

namespace metrics
{
  class ReportItem
  {
  protected:
    ItemTypes theType;
    string theStatus;
    string theID;
    string theID2;
    string theShortName;
    string theLongName;
    string theLongName2;
    string theReportFile;
    string theText1;
    Lang theLang;
    long theUniqueID;
    ItemStatus theItemStatus;

  public:
    ReportItem(): theLang() {}

    ReportItem(ItemTypes itemType, string status, string id, string id2,
      string shortName, string longName, string longName2): theLang() {

      theType =       itemType;
      theID =         id;
      theID2 =        id2;
      theShortName =  shortName;
      theLongName =   longName;
      theLongName2 =  longName2;

      theUniqueID = atoi(id.c_str());

      string prefix;
      switch (theType) {
        case ITEM_PROJECT:
          prefix = "project_metrics";
          break;
        case ITEM_FILE:
          prefix = "f" + id;
          break;
      }

      theReportFile = prefix + ".html";
      setStatus(status);
    }

    int getType()              { return theType; }
    string getStatus()         { return theStatus; }
    ItemStatus getItemStatus() { return theItemStatus; }
    string getID()             { return theID; }
    string getID2()            { return theID2; }
    string getShortName()      { return theShortName; }
    string getLongName()       { return theLongName; }
    string getLongName2()      { return theLongName2; }
    string getText1()          { return theText1; }

    int getLastMetric() {
      if (theType == ITEM_PROJECT) {
        return XFILE;
      }
      return XLLOC;
    }

    string getReportFile()                { return theReportFile; }
    string getReportFile(string path)     { return path + theReportFile; }

    void setStatus(string status) {
      theStatus = status;

      switch (theStatus.c_str()[0]) {
        case 'C':
          theItemStatus = STATUS_CHANGED;
          break;
        case 'D':
          theItemStatus = STATUS_DELETED;
          break;
        case 'A':
          theItemStatus = STATUS_ADDED;
          break;
        default:
          theItemStatus = STATUS_UNCHANGED;
          break;
      }
    }

    void setLanguage(string lang)     { theLang.setLanguage(lang); }
    Lang getLang()                    { return theLang; }
    //Langs getLanguage()               { return theLang.getLanguage(); }
    string getLangDesc()              { return theLang.getDescription(); }


    void setText1(string text1)       { theText1 = text1; }

    bool operator==(ReportItem &rhs)  { return (theUniqueID == rhs.theUniqueID); }
    bool operator!=(long id)          { return (theUniqueID != id); }

  };
};

#endif

