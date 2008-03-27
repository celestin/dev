/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau C/C++ Parser (CPARSER.EXE)
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  27-Mar-08  345 : File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

char* decodefn(char* filename)
{ char *i;
  i=filename;
  while (*i!='\0')
  { if (*i==1) {*i=' ';}
    if (*i=='\n') {
      *i='\0';
      return filename ;
    }
    i++; }
  return (filename);
  }

char* codefn(char* filename)
{ char *i;
  i=filename;
  while (*i!='\0')
  {
    if (*i==' ') {
      *i=1;
    }
    if (*i=='\n') {
      *i='\0';
      return filename ;
    }
    i++;
  }
  return (filename);
 }