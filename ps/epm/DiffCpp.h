/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * C/C++/Java language Diff
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  11-Mar-06   199 : Separate Diff by Language.
 * CAM  18-Jul-06   272 : Implement CHG,DEL,ADD LLOC.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_DIFFCPP
#define CLASS_DIFFCPP

#include "Diff.h"

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>

class DiffCpp : public Diff
{
  protected:
    void getLineCR(FILE*, char*&);
    void getLineSC(FILE*, char*&);

  public:
    //DiffCpp();
    DiffCpp(const char *filename1, const char *filename2);
    ~DiffCpp() {}
};

#endif
