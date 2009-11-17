/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2008 PowerSoftware.com
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
 * CAM  22-Jul-06   291 : Added constant MAX_LLOC_LEN.
 * CAM  24-Apr-08   359 : Added WSTrim to correct LLOC Diff errors.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_STANDARD_DIFF
#define CLASS_STANDARD_DIFF

#define MAX_LLOC_LEN 65536

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>
#include <iostream>

class TraceElement {

  public:
    int theX;
    int theY;

    TraceElement(int newX, int newY)
    {
      theX = newX;
      theY = newY;
    }
    TraceElement(const TraceElement &rhs)
    {
      theX = rhs.theX;
      theY = rhs.theY;
    }
    const TraceElement &operator=(const TraceElement &rhs)
    {
      theX = rhs.theX;
      theY = rhs.theY;

      return (*this);
    }
    ~TraceElement() {;}


    int getX() { return theX; }
    int getY() { return theY; }
};



class Diff
{
  protected:
    const char *theFilename1;   // Name of first file
    const char *theFilename2;   // Name of second file
    bool theNSC;                // Semi-colon (NSC) Diff or standard Newline Diff

    std::vector<TraceElement> theTrace;

    int theChangedLines;
    int theDeletedLines;
    int theInsertedLines;

    bool theMultiLine;
    bool theNSCValid;

    int max;
    int *Vfor, *Vrev;
    char **firstactual, **secondactual;
    int delta;
    bool delta_odd;
    int D,x,y,u,v,ses;
    int xprev,yprev,xtarget,ytarget;

    int *traceX, *traceY;
    int traceLength;
    bool traceCreated;

    int level;

    void WSTrim(char*&);
    void getLine(FILE*, char*&);

    virtual void getLineCR(FILE*, char*&) {}
    virtual void getLineSC(FILE*, char*&) {}

    void greedy(const int *A, const int Aoffset, const int N, const int *B, const int Boffset, const int M);
    void dncSES(const int *A, const int Aoffset, const int N, const int *B, const int Boffset, const int M);
    void SES(const int *A, const int N, const int *B, const int M);
    void changes();
    int hash(const char *str);

  public:

    Diff(const char*, const char*, bool);
    ~Diff() {}

    void compare(bool);
    void compare();

    int getChangedLines()   { return theChangedLines; }
    int getDeletedLines()   { return theDeletedLines; }
    int getInsertedLines()  { return theInsertedLines; }

    void printTrace();
};

#endif
