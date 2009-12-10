/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PowerBuilder language Diff
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Dec-2009  10508 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_DIFFPOWERBUILDER
#define CLASS_DIFFPOWERBUILDER

#include "Diff.h"

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>

class DiffPowerBuilder : public Diff
{
  protected:
    void getLineCR(FILE*, char*&);
    void getLineSC(FILE*, char*&);

  public:
    DiffPowerBuilder(const char *filename1, const char *filename2);
    ~DiffPowerBuilder() {}
};

#endif
