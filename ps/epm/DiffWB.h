/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Windows Batch language diff
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Aug-2009  10455 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_DIFFWB
#define CLASS_DIFFWB

#include "Diff.h"

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>

class DiffWB : public Diff
{
  protected:
    void getLineCR(FILE*, char*&);
    void getLineSC(FILE*, char*&);
    char* check_for_comment_line(char* source_line);

  public:
    DiffWB(const char *filename1, const char *filename2);
    ~DiffWB() {}
};

#endif
