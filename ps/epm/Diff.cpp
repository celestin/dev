/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Original Powersoftware Diff (C/C++/Java)
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  29-Dec-04  File added.
 * CAM  11-Mar-06   199 : Separate Diff by Language.
 * CAM  18-Jul-06   272 : Implement CHG,DEL,ADD LLOC.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "Diff.h"

#include <iostream>
using namespace std;

int ntimes = 0;


Diff::Diff(const char *filename1, const char *filename2, bool nscValid) : theTrace()
{
  theFilename1 = filename1;
  theFilename2 = filename2;

  level=0;

  theChangedLines = theDeletedLines = theInsertedLines = 0;

  theMultiLine = false;
  theNSC = false;
  theNSCValid = nscValid;
}


void Diff::greedy(const int *A, const int Aoffset, const int N, const int *B, const int Boffset, const int M)
{
  delta = N-M;
  delta_odd = (delta%2)==0 ? false : true;

  for (int i=0; i<2*(max+1); i++)
  {
    Vfor[i] = -1;
    Vrev[i] = N+1;
  }

  int k;
  int xfor,yfor,xrev,yrev;
  bool match = false;
  x=y=u=v=0;
  int xtmp,ytmp,vtmp,utmp;

  int limit = max/2;

  Vfor[max+1] = 0;
  Vrev[max+delta-1] = N-1;

  for ( D=0; D<=((M+N)/2)+1; D++ )
  {
    for ( k=-D; k<=D; k+=2 )
    {

      if ( /*((k==-D) || (k!=D)) &&*/ (Vfor[k+max-1]<Vfor[k+max+1]) )
      {
        xfor = Vfor[k+max+1];
      }
      else
      {
        xfor = Vfor[k+max-1]+1;
      }

      yfor = xfor-k;

      xtmp = xfor;
      ytmp = yfor;

      if ( (xfor+Aoffset>=0) && (yfor+Boffset>=0) )
      {
        while ( (xfor<N) && (yfor<M) && (A[xfor+Aoffset]==B[yfor+Boffset]) )
        {
          match = true;

          xfor++;
          yfor++;
        }
      }

      Vfor[k+max] = xfor;

      if (delta_odd && k>=delta-(D-1) && k<=delta+(D-1))
      {
        if ( (xfor>Vrev[k+max]) )//&& match)
        {
          x = xtmp;
          y = ytmp;
          u = xfor;
          v = yfor;
          ses = 2*D-1;
          return;
        }
      }
    }
    for ( k=-D+delta; k<=D+delta; k+=2 )
    {
      if ( (k+max>0) && (k<max) ) {

        if ((Vrev[k+max-1]<Vrev[k+max+1]) )
        {
          xrev = Vrev[k+max-1];
        }
        else
        {
          xrev = Vrev[k+max+1]-1;
        }

        yrev = xrev-k;

        utmp = xrev+1;
        vtmp = yrev+1;

        while ( (xrev>=0) && (yrev>=0) && (A[xrev+Aoffset]==B[yrev+Boffset]) )
        {
          match = true;

          xrev--;
          yrev--;
        }

        Vrev[k+max] = xrev;

        if (!delta_odd && (k>=-D) && (k<=D))
        {
          if ( (Vfor[k+max]>xrev) )//&& match)
          {
            x = xrev+1;
            y = yrev+1;
            u = utmp;
            v = vtmp;
            ses = 2*D;
            return;
          }
        }
      }
    }
  }
  ses = N+M;
  x=y=u=v=-1;
}


void Diff::dncSES(const int *A, const int Aoffset, const int N, const int *B, const int Boffset, const int M)
{
  level++;
  ntimes++;

  // CAM 25/10 Changed || to && for Kari Alho @ Tellabs
  if ( ((Aoffset>-1) && (Boffset>-1)) && ((N>0) && (M>0)) )
  {
    greedy(A,Aoffset,N,B,Boffset,M);

    if (ses>1 || M==N)
    {
      int xtmp = x;
      int ytmp = y;
      int utmp = u;
      int vtmp = v;

      dncSES(A,0+Aoffset,x,B,0+Boffset,y);

      int i,c;
      for (i=xtmp, c=0; i<utmp; i++,c++)
      {
        theTrace.push_back(TraceElement(i+Aoffset+1,ytmp+c+Boffset+1));
      }

      dncSES(A,utmp+Aoffset,N-utmp,B,vtmp+Boffset,M-vtmp);
    }
    else if (M>N)
    {
      if (y>M-ses)  // Insert is at the end
      {
        for (int i=0; i<N; i++) {
          theTrace.push_back(TraceElement(i+Aoffset+1,i+Boffset+1));
        }
      }
      else if (y<=1)  // Insert is at the beginning
      {
        for (int i=0; i<N; i++) {
          theTrace.push_back(TraceElement(i+Aoffset+1,i+ses+Boffset+1));
        }
      } else      // Insert is in the middle
      {
        int i;
        for (i=0; i<y; i++) {
          theTrace.push_back(TraceElement(i+Aoffset+1,i+Boffset+1));
        }
        for (i=y; i<N; i++) {
          theTrace.push_back(TraceElement(i+Aoffset+1,i+ses+Boffset+1));
        }
      }
    }
    else if (N>M)
    {
      if (x>N-ses)  // Delete is at the end
      {
        for (int i=0; i<M; i++) {
          theTrace.push_back(TraceElement(i+Aoffset+1,i+Boffset+1));
        }
      }
      else if (x<=1)  // Delete is at the beginning
      {
        for (int i=0; i<M; i++) {
          theTrace.push_back(TraceElement(i+ses+Aoffset+1,i+Boffset+1));
        }
      } else      // Delete is in the middle
      {
        int i;
        for (i=0; i<x; i++) {
          theTrace.push_back(TraceElement(i+Aoffset+1,i+Boffset+1));
        }
        for (i=x; i<M; i++) {
          theTrace.push_back(TraceElement(i+ses+Aoffset+1,i+Boffset+1));
        }
      }
    }
  }
  level--;
}

void Diff::SES(const int *A, const int N, const int *B, const int M)
{
  max = N+M;

  Vfor = (int*) malloc((2*(max+1))*sizeof(int));
  Vrev = (int*) malloc((2*(max+1))*sizeof(int));
  xprev = -1;
  yprev = -1;

  theTrace.push_back(TraceElement(0,0));
  xtarget = N;
  ytarget = M;

  dncSES(A,0,N,B,0,M);

  theTrace.push_back(TraceElement(N+1,M+1));

  free (Vfor);
  free (Vrev);
}

void Diff::changes()
{
  bool deletes,inserts;
  int j=0;

  theChangedLines = theDeletedLines = theInsertedLines = 0;

  for ( int i=0; i<theTrace.size()-1; i++)
  {
    inserts=deletes=false;

    if (theTrace[i].theY+1<theTrace[i+1].theY)
    {
      inserts = true;
    }

    if (theTrace[i].theX+1<theTrace[i+1].theX)
    {
      deletes = true;
    }

    if (deletes && inserts)
    {
      int tmpInserts = 0,tmpDeletes = 0;

      for (j=theTrace[i].theY+1; j<theTrace[i+1].theY; j++)
      {
        tmpInserts++; //theChangedLines++;
      }
      for (j=theTrace[i].theX+1; j<theTrace[i+1].theX; j++)
      {
        tmpDeletes++ ; //theChangedLines++;
      }

      if (tmpInserts==tmpDeletes)
      {
        theChangedLines+=tmpInserts;
      }
      else if (tmpInserts>tmpDeletes)
      {
        theChangedLines+=tmpDeletes;
        theInsertedLines+= (tmpInserts-tmpDeletes);
      }
      else // (tmpInserts<tmpDeletes)
      {
        theChangedLines+=tmpInserts;
        theDeletedLines+= (tmpDeletes-tmpInserts);
      }
    }
    else if (inserts)
    {
      for (j=theTrace[i].theY+1; j<theTrace[i+1].theY; j++)
      {
        theInsertedLines++;
      }
    }
    else
    {
      for (j=theTrace[i].theX+1; j<theTrace[i+1].theX; j++)
      {
        theDeletedLines++;
      }
    }
  }
}


void Diff::printTrace() {
  for (int i=0; i<theTrace.size(); i++) {
    cout << theTrace[i].theX << "," << theTrace[i].theY << endl;
  }
}

int Diff::hash(const char *str)
{
  int retval = 0;
  int length = strlen(str);

  if (length==0) return 0;

  for (int i=0; i<length; i++ ,str++)
  {
      retval = 31*retval + (*str);
  }
  return retval;
}

void Diff::compare(bool nsc)
{
  theNSC = nsc;
  compare();
}

void Diff::compare()
{
  theChangedLines = theDeletedLines = theInsertedLines = 0;
  theMultiLine = false;

  if (theNSC && !theNSCValid) return; // Trying to perform an Logical Line diff on a language that doesn't support it
  if ((theFilename1 == NULL) || (theFilename2 == NULL)) return;

  theTrace.clear();

  FILE *file1, *file2;

  file1 = fopen(theFilename1,"r");
  file2 = fopen(theFilename2,"r");

  // Do not try to compare file if there has been a problem when opening
  if (file1!=NULL && file2!=NULL)
  {
    char *currString = NULL;
    int length = 0;

    int avail_size = 1000;
    int increment = 500;
    int *first= (int*) malloc(avail_size*sizeof(int));
    int fsize = 0;

    getLine(file1, currString);
    while (currString)
    {
      first[fsize] = hash(currString);

      try {
        free(currString);
      } catch (...) { }

      fsize++;
      if (fsize>=avail_size)
      {
        avail_size+=increment;
        first = (int*) realloc(first, avail_size*sizeof(int));
      }
      getLine(file1, currString);
    }

    avail_size = 1000;
    int *second= (int*) malloc(avail_size*sizeof(int));
    int ssize = 0;

    getLine(file2, currString);
    while (currString)
    {
      second[ssize] = hash(currString);

      try {
        free(currString);
      } catch (...) {
      }

      ssize++;
      if (ssize>=avail_size) {
        avail_size+=increment;
        second = (int*) realloc(second, avail_size*sizeof(int));
      }
      getLine(file2, currString);
    }

    SES(first,fsize,second,ssize);
    changes();
    free (first);
    free (second);
  }

  if (file1) {
    fclose (file1);
  }
  if (file2) {
    fclose (file2);
  }
}

void Diff::getLine(FILE *input, char *&currline) {
  if (theNSC) {
    getLineSC(input, currline);
  } else {
    getLineCR(input, currline);
  }
}

