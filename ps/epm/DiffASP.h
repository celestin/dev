/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2006-2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * VB language Diff
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  19-Sep-06   117 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_DIFFASP
#define CLASS_DIFFASP

#include "Diff.h"

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>

class DiffASP : public Diff
{
  protected:
    void getLineCR(FILE*, char*&);
    void getLineSC(FILE*, char*&);

  public:
    DiffASP(const char *filename1, const char *filename2);
    ~DiffASP() {}
};

#endif
