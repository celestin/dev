#include "codefn.h"

char* decodefn(char* filename)
{ char *i;
  i=filename;
  while (*i!='\0')
  { if (*i==1) {*i=' ';}
    i++; }
	return (filename);
  }
	
char* codefn(char* filename)
{ char *i;
  i=filename;
  while (*i!='\0')
  { if (*i==' ') {*i=1;}
    i++; }
	return (filename);
 }