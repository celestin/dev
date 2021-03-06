/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * CSV Report Builder
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  26-Mar-05    79 : Moved common code to Report class.
 * CAM  29-Mar-05    85 : Moved lastMetric to Report class.
 * CAM  27-Aug-2009  10483 : Removed specific execute implementation.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_CSVREPORT
#define CLASS_CSVREPORT

#include "Report.h"
#include "ReportItem.h"
#include "Metric.h"
#include "Metrics.h"

namespace metrics
{
  class CSVReport : public Report
  {
  public:
    CSVReport(OurSQL&, std::string);
    virtual void execute();

  protected:
    void projectLine(std::ofstream&);
    void csvLine(std::ofstream&, ReportItem&);
  };
};

#endif

