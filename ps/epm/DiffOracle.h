/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Oracle language Diff
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  18-Mar-06   212 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_DIFFORACLE
#define CLASS_DIFFORACLE

#include "Diff.h"

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>

class DiffOracle : public Diff
{
  protected:
    void getLine(FILE*, char*&);

  public:
    DiffOracle();
    DiffOracle(const char *filename1, const char *filename2);
    ~DiffOracle() {}
};

#endif
