/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2011 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * UC language Diff
 *
 * $Id: $
 *
 * Who  When         Why
 * CAM  18-Jun-2011  10963 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_DIFFUC
#define CLASS_DIFFUC

#include "Diff.h"

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>

class DiffUc : public Diff
{
  protected:
    void getLineCR(FILE*, char*&);
    void getLineSC(FILE*, char*&);

  public:
    DiffUc(const char *filename1, const char *filename2);
    ~DiffUc() {}
};

#endif
