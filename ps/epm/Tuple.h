/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Tuple class
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  06-Jan-06  168 : File created.
 * CAM  24-Apr-08   358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef TUPLE_H
#define TUPLE_H

#include <iostream>

class Tuple {
  public:
    char *fId, *fDesc;
    Tuple() {}

    void set(const char *id, const char *desc) {
      fId = _strdup(id);
      fDesc = _strdup(desc);
    }
};

#endif