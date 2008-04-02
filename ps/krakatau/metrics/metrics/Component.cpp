/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * CAM  22-Jan-08  339 : Corrected deprecation warnings.
 * CAM  02-Apr-08  339 : Corrected deprecation warnings.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "Component.h"
using namespace metrics ;

const int Component::OPERATION_CALL = 0 ;
const int Component::OPERATION_TYPE = 1 ;

using namespace std ;

Component::Component()
{
  theComponentsCount = 0 ;
}


void Component::clearComponents()
{
  int i ;

  for(i = 0; i < theComponentsCount; i++)
  {
    free(theComponents[i]) ;
  }

  theComponentsCount = 0 ;
}


void Component::componentise(string newName, int operation)
{
  clearComponents() ; // Remove the components array

  // Remove any templates from the name
  char noTemplates[8192] ;
  const char *inp = newName.c_str() ;
  int i, count=0, tmplen=0, inplen=strlen(inp) ;

  for (i=0;i<inplen;i++)
  {
    if (inp[i]=='<') count++ ;

    if (count==0)
    {
      noTemplates[tmplen++] = inp[i] ;
    }

    if (inp[i]=='>') count-- ;
  }
  noTemplates[tmplen] = '\0' ;

  // Build the new components array
  char sep[3] ;
  if (operation == OPERATION_TYPE)
  {
    strcpy_s(sep, 3, "::") ;
  }
  else
  {
    strcpy_s(sep, 3, ".") ;
  }

  const char *token;
  char *next_token;

  token = strtok_s(noTemplates, sep, &next_token);
  while (token != NULL)
  {
    theComponents[theComponentsCount++] = _strdup(token) ;
    token = strtok_s(NULL, sep, &next_token);
  }
}

