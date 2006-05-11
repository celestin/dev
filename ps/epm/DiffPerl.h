/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Perl language Diff
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  18-Mar-06   212 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_DIFFPERL
#define CLASS_DIFFPERL

#include "Diff.h"

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>

class DiffPerl : public Diff
{
  protected:
    void getLine(FILE*, char*&);

  public:
    DiffPerl();
    DiffPerl(const char *filename1, const char *filename2);
    ~DiffPerl() {}
};

#endif
