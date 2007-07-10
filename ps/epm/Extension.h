/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Extension Class to manage Languages, File Types and Extensions.
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  23-Aug-05  115 : File added.
 * CAM  06-Jan-06  168 : Moved Tuple to own file.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef EXTENSION_H
#define EXTENSION_H

#define MAXLANG 20
#define MAXTYPE 5
#define MAXEXT  10

#include "Tuple.h"

class Extension {
  public:
    Tuple sLang[MAXLANG];
    Tuple sType[MAXLANG][MAXTYPE];
    Tuple sExt[MAXLANG][MAXTYPE][MAXEXT];

    int   nLang;
    int   nType[MAXLANG];
    int   nExt[MAXLANG][MAXTYPE];
    int   nErrors;

    Extension() {
      nErrors = nLang = 0;
      for (int i=0; i<MAXLANG; i++) {
        nType[i] = 0;
        for (int j=0; j<MAXTYPE; j++) {
          nExt[i][j]=0;
        }
      }
    }
};

#endif