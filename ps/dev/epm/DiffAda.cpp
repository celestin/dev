/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2008 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Ada language Diff
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Mar-06    199 : Separate Diff by Language.
 * CAM  18-Jul-06    272 : Implement CHG,DEL,ADD LLOC.
 * CAM  20-Jul-06    272 : GetLineSC now includes string contents.
 * CAM  22-Jul-06    291 : Stop looking for semi-colons on a "lines" after MAX_LLOC_LEN.
 * CAM  25-Oct-07    319 : Correct leak in getLine*.
 * CAM  01-Nov-07    320 : Correct issue with theMultiLine in getLineSC.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  09-Jul-2009  10457 : Allow extra space at the end of getLineCR.currline for the null terminator.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "DiffAda.h"

#include <iostream>
using namespace std;

DiffAda::DiffAda(const char *filename1, const char *filename2) : Diff(filename1, filename2, true)
{
}

void DiffAda::getLineCR(FILE *input, char *&currline)
{

  try
  {
    char buffer[1000];
    if (!fgets(buffer,1000,input)) {
      currline = NULL;     // EOF or error
      return;
    }

    char *c = buffer;

    char *retval = (char*) malloc(1000*sizeof(char));

    int currAvailLength = 1000;    // The current allocated size of retval
    int buffLength = strlen(buffer); // The length of the string in the buffer
    int i=0;
    int retLength = 0;         // Used to keep track of the created string

    bool skip = false;
    bool finishedML = true;

    if (theMultiLine)
      finishedML = false;

    while (true)
    {
      if (*c=='\0')   // We have reached the end of the buffer but not found a newline
      {
        // Get the next 1000 chars from the file
        if (!fgets(buffer,1000,input))  // EOF or error
        {
          if (retLength>0)  // If there is a return value return it
          {
            retval[retLength] = '\0';
            currline = retval;
            return;
          }
          else // otherwise return NULL
          {
            try { free(retval); } catch (...) {}
            currline = NULL;
            return;
          }
        }

        c = buffer;

        buffLength = strlen(buffer); // Set the length of the buffer string
        i = 0;
      }

      if (retLength>=currAvailLength-1)
      {
        currAvailLength+=1000;

        // Re-size the return string
        retval = (char*) realloc(retval, currAvailLength*sizeof(char*));
      }

      while (!finishedML)
      {

        switch (*c)
        {
        case '\0':
          {
            if (!fgets(buffer,1000,input))  // EOF or error
            {
              if (retLength>0)  // If there is a return value return it
              {
                retval[retLength] = '\0';
                currline = retval;
                return;
              }
              else // return NULL
              {
                try { free(retval); } catch (...) {}
                currline = NULL;
                return;
              }
            }

            c = buffer;
            break;
          }
        case '\n':
          {
            if (retLength>0)  // If there is a return value return it
            {
              retval[retLength] = '\0';
              currline = retval;
              return;
            }

            c++;
            break;
          }
        default:
          {
            c++;
          }
        }
      }

      switch (*c)
      {
      case '"':
        {
          if (!skip)
            skip = true;
          else
            skip = false;

          retval[retLength] = *c;
          retLength++;

          c++;
          i++;

          break;
        }
      case ' ':
      case '\t':
        {
          c++;
          i++;
          break;
        }
      case '\n':
        {
          if (retLength>0)
          {
            retval[retLength] = '\0';
            currline = retval;
            return;
          }
          c++;
          i++;
          break;
        }
      case '-':
        {
          if (!skip)
          {
            char *oldc = c;
            c++;
            switch (*c)
            {
            case '-':
              {
                // At this point a comment to end of line
                // has been found so make set *c to '\n' and break
                *oldc = '\n';
                *c = '\0';

                c = oldc;

                break;
              }
            default:
              {
                retval[retLength] = '/';
                retLength++;
                retval[retLength] = *c;
                retLength++;

                c++;
                i++;
              }
            }
          }
          else
          {
            // Skip was true, ie we are in a string so just output the '/'
            retval[retLength] = *c;
            retLength++;

            c++;
            i++;
          }

          break;
        }
      case '\\':
        {
          if (skip)
          {
            // We are in a string so this is the start of an escape sequence
            // so output the '\' then move onto the next char
            retval[retLength] = *c;
            retLength++;

            c++;
            i++;

            // Do not break - instead move onto the defualt clause to output
            // the char following the '\'
          }
        }
      default:
        {
          retval[retLength] = *c;
          retLength++;

          c++;
          i++;
        }
      }
    }
  }
  catch (...)
  {
    currline = _strdup("");
    return;
  }
}


void DiffAda::getLineSC(FILE *input, char *&currline)
{
  char *retval = (char*) malloc(MAX_LLOC_LEN*sizeof(char));
  int b = 0;

  try
  {
    int nc,nc2 = 0;
    bool skip = false;
    bool comskip = false;

    while ((nc=fgetc(input))!=EOF && b<(MAX_LLOC_LEN-2)) {
      switch (nc)
      {
      //case 9:
      //case ' ':
      //  {
          // ignore whitespace
      //    break;
      //  }
      case '"':
        {
          skip = !skip;
          retval[b++] = nc;
          break;
        }
      case ';':
        {
          if (!comskip) {
            retval[b++] = ';';
            retval[b++] = '\0';
            currline = retval;
            return;
          }
        }
      case '\n':
        {
          comskip = false;
          break;
        }
      case '-':
        {
          if (comskip || skip) {
            // Ignore
          } else {
            if ((nc2=fgetc(input))!=EOF) {
              if (nc2 == '-') {
                comskip = true;
              } else if (!comskip) {
                retval[b++] = nc;
                retval[b++] = nc2;
              }
            }
          }
          break;
        }
      case '\\':
        {
          retval[b++] = nc;
          if (skip)
          {
            if ((nc2=fgetc(input))!=EOF) {
              retval[b++] = nc2;
            }
          }
          break;
        }
      default:
        {
          if (!comskip) retval[b++] = nc;
          break;
        }
      }
    }
  }
  catch (...)
  {
    currline = _strdup("");
    return;
  }

  if (b == 0) {
    try { free(retval); } catch (...) {}
    currline = NULL;
    return;
  }

  retval[b++] = '\0';
  currline = retval;
}
