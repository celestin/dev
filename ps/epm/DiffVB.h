/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * VB language Diff
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  18-Mar-06   212 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_DIFFVB
#define CLASS_DIFFVB

#include "Diff.h"

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>

class DiffVB : public Diff
{
  protected:
    void getLine(FILE*, char*&);

  public:
    DiffVB();
    DiffVB(const char *filename1, const char *filename2);
    ~DiffVB() {}
};

#endif
