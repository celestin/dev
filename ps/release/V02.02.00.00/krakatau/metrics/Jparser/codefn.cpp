/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Java Parser (JPARSER.EXE)
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  29-Mar-08  346 : File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "codefn.h"

extern char* decodefn(char* filename)
{
  char *i;
  i=filename;
  while (*i!='\0')
  { if (*i==1) {*i=' ';}
    i++; }
  return (filename);
}

extern char* codefn(char* filename)
{
  char *i;
  i=filename;
  while (*i!='\0')
  { if (*i==' ') {*i=1;}
    i++; }
  return (filename);
}
