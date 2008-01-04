/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Metrics
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  04-Jan-05  File added.
 * CAM  24-Jan-05  Changed to metrics value to float and added Halstead calcs.
 * CAM  03-Feb-05    40 : Added calculateChange to encapsulate this logic.
 * CAM  14-Mar-05    78 : Correctly calculate Effort.
 * CAM  19-Mar-05    81 : Correctly calculate all Halstead values.
 * CAM  24-Mar-05    82 : Correctly calculate Changed status (based on CHG_SLOC metrics).
 * CAM  28-Nov-05   164 : Added metshow.
 * CAM  28-Jan-06   180 : metshow must be intialised for *all* metrics, then disabled.
 * CAM  14-Mar-06   202 : Calculate old and new projects when performing calculateHalstead.
 * CAM  23-Mar-06   218 : Hide Halstead metrics for Project level summary.
 * CAM  01-Jun-06   252 : Re-instate Halstead metrics for Project level, but only show Min/Max/Avg.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_METRICS
#define CLASS_METRICS

#include "math.h"
#include "Metric.h"
#include "ReportItem.h"

#include <iostream>

namespace metrics
{
  class Metrics
  {
  protected:
    float met[METS][5];
    bool metshow[METS][2];

  public:
    Metrics() {
      for (int i=0; i<METS; i++) {
        metshow[i][ITEM_PROJECT] = true;
        metshow[i][ITEM_FILE] = true;
      }

      // Ignore NFILE for Files
      metshow[MET(NFILE)][ITEM_FILE] = false;

      // Ignore all the Halstead metrics for Projects
      for (i=MET(N1); i<=MET(B); i++) {
        metshow[i][ITEM_PROJECT] = false;
      }
    }

    void  set(int m, float value) { set(m,0,value); }
    void  add(int m, float value) { add(m,0,value); }

    void set(int m, int p, float value) { met[m][p] = value; }
    void add(int m, int p, float value) { met[m][p] += value; }

    void set(int m, float valmin, float valmax, float valavg) {
      met[m][2] = valmin;
      met[m][3] = valmax;
      met[m][4] = valavg;
    }

    void add(Metrics &m) {
      int i;

      for (i=0; i<MET(CLOC); i++) {
        add(i, 0, m.met[i][0]);
        add(i, 1, m.met[i][1]);
      }

      for (i=MET(CLOC); i<METS; i++) {
        add(i, 0, m.met[i][0]);
      }
    }

    float get(int m, int p) { return met[m][p]; }
    float get(int m)        { return get(m,0); }

    bool isShow(ReportItem &rhs, long metId) {
      return metshow[metId][rhs.getType()];
    }

    bool isShow(ItemTypes type, long metId) {
      return metshow[metId][type];
    }

    void clearMetrics() {
      for(int i=0; i<METS; i++) {
        for(int j=0; j<5; j++) {
          met[i][j] = 0;
        }
      }
    }

    void calculateHalstead() {
      long n,ns,n1,n2,n1s,n2s,v,d,e;

      for (int i=0; i<2; i++) {
        n=ns=n1=n2=n1s=n2s=n2=v=d=e=0;

        n1s = this->get(MET(N1S), i);
        n2s = this->get(MET(N2S), i);
        n1 = this->get(MET(N1), i);
        n2 = this->get(MET(N2), i);

        n = n1 + n2;                              // Halstead Program Length
        ns = n1s + n2s;                           // Halstead Program Vocabulary
        if (ns > 0) v = (n * (log(ns) / LOG2));   // Halstead Volume

        if (n2s > 0) d = (((double)n1s / 2) *     // Halstead Difficulty
                     ((double)n2 / (double)n2s));

        e = v * d;                                // Halstead Effort

        // Set these values
        this->set(MET(N), i, n);
        this->set(MET(NS), i, ns);
        this->set(MET(V), i, v);
        this->set(MET(D), i, d);
        this->set(MET(E), i, e);

        // Halstead Bugs
        this->set(MET(B), i, ((float)pow(e, ((double)2/(double)3))) / (double)3000);
      }
    }


    void calculateChange(ReportItem &currItem) {
      bool itemChanged = false;
      for (int i=MET(CLOC); i<METFILE && !itemChanged; i++) {
        itemChanged = (this->get(i,0)!=0);
      }

      if ((currItem.getItemStatus() == STATUS_CHANGED) && (!itemChanged)) {
        currItem.setStatus("");
      }

      int metID = 0;
      switch (currItem.getItemStatus()) {
        case STATUS_CHANGED:
          metID = MET(CFILE);
          break;
        case STATUS_DELETED:
          metID = MET(DFILE);
          break;
        case STATUS_ADDED:
          metID = MET(AFILE);
          break;
      }

      if (metID) this->add(metID, 1);  // Increment changed, deleted, added file where appropriate
    }

  };
};

#endif

