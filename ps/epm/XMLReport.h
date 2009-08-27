/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * XML Reporting
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Mar-05    85 : Class created.
 * CAM  27-Aug-2009  10483 : Removed specific execute implementation.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_XMLREPORT
#define CLASS_XMLREPORT

#include "Report.h"
#include "ReportItem.h"
#include "Metric.h"
#include "Metrics.h"

namespace metrics
{
  class XMLReport : public Report
  {
  private:
    //int lastMetric;

  public:
    XMLReport(OurSQL&, std::string);
    virtual void execute();

  protected:
    void projectLine(std::ofstream&);
    void xmlMetrics(std::ofstream&, ReportItem&, std::string&);
  };
};

#endif

