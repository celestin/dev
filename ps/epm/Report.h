/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Report Builder
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  02-Jan-05  File added.
 * CAM  08-Jan-05  Added theProjCount and getProjectCount().
 * CAM  26-Mar-05    79 : Moved common code to Report class.
 * CAM  29-Mar-05    85 : Added lastMetric.
 * CAM  28-Jan-06   168 : Added setMetricsSet and related functions for MetricSets.
 * CAM  07-Feb-06   187 : Added return number of items to getItems().
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_REPORT
#define CLASS_REPORT

#include "OurSQL.h"
#include "ReportItem.h"
#include "Metric.h"
#include "Metrics.h"
#include "MetricSet.h"

namespace metrics
{
  class Report
  {
  protected:
    std::string thePath;                // Filename (for single-file reports)
                                        // or Path (for multiple-file reports)
    OurSQL theDb;                       // Database connection
    int theProjCount;                   // Count of Projects
    Metrics met;                        // Current Item Metrics
    Metrics projMet;                    // Project Summary Metrics
    std::string metCode[METS];          // Metric Codes (e.g. LOC)
    std::string metDesc[METS];          // Metric Descriptions (e.g. Lines Of Code)
    std::vector<ReportItem> fileList;   // Vector of files info
    ReportItem project[2];              // Info for up to two Projects
    int lastMetric;                     // Last Metric ID to output for the current item

    void setPath();
    void getMetDesc();
    long getItems();
    void getMetrics(ReportItem &currItem);
    void calculateProjectMetrics();
    bool isSetMember(int);              // Is the specified Metric ID part of the Active Set?
    bool isAnyStandard();
    bool isAnyChanged(long);


  public:
    Report(OurSQL &db, std::string path);
    std::string getPath() const { return thePath; }
    void makePath() const;
    bool isPM();
    int getProjectCount();
    void setMetricsSet(std::string);
    virtual void execute() = 0;

  };
};

#endif

