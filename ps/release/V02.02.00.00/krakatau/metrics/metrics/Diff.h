/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef SJW_DIFF_CLASS
#define SJW_DIFF_CLASS

#include <stdio.h>
#include <math.h>
#include <string.h>

#include <vector>
//#include "MasterData.h"

class TraceElement {

	public:
		int theX ;
		int theY ;

		TraceElement(int newX, int newY)
		{
			theX = newX ;
			theY = newY ;
		}
		TraceElement(const TraceElement &rhs)
		{
			theX = rhs.theX ;
			theY = rhs.theY ;
		}
		const TraceElement &operator=(const TraceElement &rhs)
		{
			theX = rhs.theX ;
			theY = rhs.theY ;

			return (*this) ;
		}
		~TraceElement() {;}


		int getX() { return theX; }
		int getY() { return theY; }
} ;



class Diff
{
	private:

		const char *theFilename1 ;	// Name of first file
		const char *theFilename2 ;	// Name of second file

		std::vector<TraceElement> theTrace ;

		int theChangedLines ;
		int theDeletedLines ;
		int theInsertedLines ;

		bool theMultiLine ;
		//bool debugging ;

	protected:

		int max ;
		int *Vfor, *Vrev ;
		char **firstactual, **secondactual ;
		int delta ;
		bool delta_odd ;
		int D,x,y,u,v,ses ;
		int xprev,yprev,xtarget,ytarget ;

		int *traceX, *traceY ;
		int traceLength ;
		bool traceCreated ;

		int level ;

		char *getLine(FILE *input) ;
		void printTrace() ;
		void greedy(const int *A, const int Aoffset, const int N, const int *B, const int Boffset, const int M) ;
		void dncSES(const int *A, const int Aoffset, const int N, const int *B, const int Boffset, const int M) ;
		void SES(const int *A, const int N, const int *B, const int M) ;
		void changes() ;
		int hash(const char *str) ;

	public:

		Diff() ;
		Diff(const char *filename1, const char *filename2) ;
		~Diff() {}

		void compare(const char *filename1, const char *filename2, bool hc=false) ;
		void compare() ;

		int getChangedLines() { return theChangedLines ; }
		int getDeletedLines() { return theDeletedLines ; }
		int getInsertedLines() { return theInsertedLines ; }

} ;

#endif
