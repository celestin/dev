/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Ada language Diff
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  11-Mar-06   199 : Separate Diff by Language.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_DIFFADA
#define CLASS_DIFFADA

#include "Diff.h"

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>

class DiffAda : public Diff
{
  protected:
    void getLine(FILE*, char*&);

  public:
    DiffAda();
    DiffAda(const char *filename1, const char *filename2);
    ~DiffAda() {}
};

#endif
