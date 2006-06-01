/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * HTML Reporting
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  02-Jan-05  File added.
 * CAM  04-Jan-05  Changed report to use frames.
 * CAM  24-Jan-05  Added metCode.
 * CAM  26-Jan-05  Allow navTable to show only changes.
 * CAM  31-Jan-05  Added ability to specify body class.
 * CAM  03-Feb-05    40 : Added 'project' Project metrics.
 * CAM  24-Mar-05    83 : Represent Project E in 1000s.
 * CAM  26-Mar-05    79 : Moved common code to Report class.
 * CAM  28-Jan-06   168 : Added metTdVal.
 * CAM  01-Jun-06   252 : Added metTdNA.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_HTMLREPORT
#define CLASS_HTMLREPORT

#include "Report.h"
#include "ReportItem.h"
#include "Metric.h"
#include "Metrics.h"

namespace metrics
{
  class HTMLReport : public Report
  {
  public:
    HTMLReport(OurSQL&, std::string);
    virtual void execute();

  protected:
    void createFrameset();

    void htmlStart(std::ofstream&, std::string&);
    void htmlStart(std::ofstream&, std::string&, int);
    void htmlStart(std::ofstream&, std::string&, std::string&);
    void htmlStart(std::ofstream&, std::string&, int, std::string&);
    void htmlEnd(std::ofstream&);
    void mainTable(std::ofstream&);
    void projectTable(std::ofstream&);
    void navTable(std::ofstream&, std::vector<ReportItem>&, ItemStatus);

    void metTd(std::ofstream&, ReportItem&, int);
    void metTdVal(ofstream&, int, long);
    void metTdNA(ofstream&);
    void metTable(std::ofstream&, ReportItem&);

    void executeHTML();
  };
};

#endif

