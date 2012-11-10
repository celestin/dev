/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Assembler language Diff
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Apr-2009  10402 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_DIFFASM
#define CLASS_DIFFASM

#include "Diff.h"

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>

class DiffAsm : public Diff
{
  protected:
    void getLineCR(FILE*, char*&);
    void getLineSC(FILE*, char*&);

  public:
    DiffAsm(const char *filename1, const char *filename2);
    ~DiffAsm() {}
};

#endif
