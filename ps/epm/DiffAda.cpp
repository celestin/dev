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
 * CAM  18-Jul-06   272 : Implement CHG,DEL,ADD LLOC.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "DiffAda.h"

#include <iostream>
using namespace std;

DiffAda::DiffAda(const char *filename1, const char *filename2) : Diff(filename1, filename2, true)
{
}

void DiffAda::getLineCR(FILE *input, char *&currline)
{

//cout << "new " << flush;

  try
  {
    char buffer[1000];
    if (!fgets(buffer,1000,input)) {
//cout << "1 " << flush;
      currline = NULL;     // EOF or error
      return;
    }

//cout << "1 " << flush;
    char *c = buffer;

    char *retval = (char*) malloc(1000*sizeof(char));
//cout << "2 " << flush;

    int currAvailLength = 1000;    // The current allocated size of retval
    int buffLength = strlen(buffer); // The length of the string in the buffer
    int i=0;
    int retLength = 0;         // Used to keep track of the created string

    bool skip = false;
    bool finishedML = true;

    if (theMultiLine)
      finishedML = false;

//cout << "3 " << flush;
    while (true)
    {
      if (*c=='\0')   // We have reached the end of the buffer but not found
      {         // a newline
        // Get the next 1000 chars from the file
        if (!fgets(buffer,1000,input))  // EOF or error
        {
          if (retLength>0)  // If there is a return value return it
          {
            retval[retLength] = '\0';
            currline = retval;
//cout << "ret1::" << currline << ' ' << flush;
            return;
          }
          else // otherwise return NULL
          {
            currline = NULL;
//cout << "ret2::NULL " << flush;
            return;
          }
        }

        c = buffer;

        buffLength = strlen(buffer); // Set the length of the buffer string
        i = 0;             // Reset i
      }

      if (retLength>=currAvailLength-1)
      {
        currAvailLength+=1000;

        // Re-size the return string
        retval = (char*) realloc(retval, currAvailLength*sizeof(char*));
      }

//cout << "4 " << flush;
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
//cout << "ret3::" << currline << ' ' << flush;
                return;
              }
              else        // otherwise return NULL
              {
                currline = NULL;
//cout << "ret4::NULL " << flush;
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
//cout << "ret5::" << currline << ' ' << flush;
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
//cout << "ret6::" << currline << ' ' << flush;
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
//cout << "5 " << flush;
  }
  catch (...)
  {
    currline = strdup("");
    return;
  }
}


void DiffAda::getLineSC(FILE *input, char *&currline)
{
  char *retval = (char*) malloc(65536*sizeof(char));
  int b = 0;

  try
  {

    int nc,nc2 = 0;
    bool skip = false;
    bool comskip = false;

    while ((nc=fgetc(input))!=EOF) {
      switch (nc)
      {
      case '"':
        {
          if (skip) {
            skip = false;
          } else {
            skip = true;
          }
          break;
        }
      case ';':
        {
          if (!skip && !comskip) {
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
          if (skip) {
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
          if (skip)
          {
            // We are in a string so this is the start of an escape sequence
            // so output the '\' then move onto the next char
            if (!skip && !comskip) retval[b++] = nc;
          }
          break;
        }
      default:
        {
          if (!skip && !comskip) retval[b++] = nc;
          break;
        }
      }
    }
  }
  catch (...)
  {
    currline = strdup("");
    return;
  }

  if (b == 0) {
    currline = NULL;
    return;
  }

  retval[b++] = '\0';
  currline = retval;
}

