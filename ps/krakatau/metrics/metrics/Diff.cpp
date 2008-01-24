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

#include "Diff.h"
#include "Utilities.h"

#include <iostream>
using namespace std ;

#include "MasterData.h"
using namespace metrics ;

int ntimes = 0 ;

Diff::Diff() : theTrace()
{
	theFilename1 = NULL ;
	theFilename2 = NULL ;

	level=0 ;

	theChangedLines = theDeletedLines = theInsertedLines = 0 ;

	theMultiLine = false ;
}

Diff::Diff(const char *filename1, const char *filename2) : theTrace()
{
	theFilename1 = filename1 ;
	theFilename2 = filename2 ;

	level=0 ;

	theChangedLines = theDeletedLines = theInsertedLines = 0 ;

	theMultiLine = false ;
}


void Diff::greedy(const int *A, const int Aoffset, const int N, const int *B, const int Boffset, const int M)
{
	delta = N-M ;
	delta_odd = (delta%2)==0 ? false : true ;

	for (int i=0 ; i<2*(max+1) ; i++)
	{
		Vfor[i] = -1 ;
		Vrev[i] = N+1 ;
	}

	int k ;
	int xfor,yfor,xrev,yrev ;
	bool match = false ;
	//x=N ; y=M ; u=v=0;
	x=y=u=v=0 ;
	int xtmp,ytmp,vtmp,utmp ;

	int limit = max/2 ;

	Vfor[max+1] = 0 ;
	//Vrev[max+delta+1] = N-1 ;
	Vrev[max+delta-1] = N-1 ;

	for ( D=0 ; D<=((M+N)/2)+1 ; D++ )
	{
		for ( k=-D ; k<=D ; k+=2 )
		{
			MasterData::theLog << "k [" << k << "]  k+max-1 [" << k+max-1 << "]" << endl ;

			if ( /*((k==-D) || (k!=D)) &&*/ (Vfor[k+max-1]<Vfor[k+max+1]) )
			{
				xfor = Vfor[k+max+1] ;
			}
			else
			{
				xfor = Vfor[k+max-1]+1 ;
			}

			yfor = xfor-k ;

			xtmp = xfor ;
			ytmp = yfor ;

//			match = false ;

			if ( (xfor+Aoffset>=0) && (yfor+Boffset>=0) )
			{
				while ( (xfor<N) && (yfor<M) && (A[xfor+Aoffset]==B[yfor+Boffset]) )
				{
					match = true ;

					xfor++ ;
					yfor++ ;
				}
			}

//			if (match)
//			{
//				x = xtmp ;
//				y = ytmp ;
//				u = xfor ;
//				v = yfor ;
//			}


			Vfor[k+max] = xfor ;

			if (delta_odd && k>=delta-(D-1) && k<=delta+(D-1))
			{
				if ( (xfor>Vrev[k+max]) )//&& match)
				{
					x = xtmp ;
					y = ytmp ;
					u = xfor ;
					v = yfor ;
					//Overlap
					//if (match)
						ses = 2*D-1 ;
					//else
					//	ses = N+M ;
					return ;
				}
			}
		}
		for ( k=-D+delta ; k<=D+delta ; k+=2 )
		{
			if ( (k+max>0) && (k<max) ) {

				if ( /*((k==-D+delta) || (k!=D+delta)) && */(Vrev[k+max-1]<Vrev[k+max+1]) )
				{
					xrev = Vrev[k+max-1] ;
				}
				else
				{
					xrev = Vrev[k+max+1]-1 ;
				}

				yrev = xrev-k ;

				utmp = xrev+1 ;
				vtmp = yrev+1 ;

	//			match = false;
				//if ( (xrev/*+Aoffset*/<N) && (yrev/*+Boffset*/<M) )
				//{
					while ( (xrev>=0) && (yrev>=0) && (A[xrev+Aoffset]==B[yrev+Boffset]) )
					{
						match = true ;

						xrev-- ;
						yrev-- ;
					}
					//xrev++ ;
				//}

	// No longer needed
	//			if (match)
	//			{
	//				x = xrev+1 ;
	//				y = yrev+1 ;
	//				u = utmp ;
	//				v = vtmp ;
	//			}

				Vrev[k+max] = xrev ;

				if (!delta_odd && (k>=-D) && (k<=D))
				{
					/*x=Vfor[k+max] ;
					y=Vfor[k+max]-k ;
					u=xrev ;
					v=yrev ;*/

					if ( (Vfor[k+max]>xrev) )//&& match)
					{
						//Overlap
						x = xrev+1 ;
						y = yrev+1 ;
						u = utmp ;
						v = vtmp ;

	//					if (match)
							ses = 2*D ;
	//					else
	//						ses = N+M ;
						return ;
					}
				}
			}
		}
	}
	ses = N+M ;
	x=y=u=v=-1;
}


void Diff::dncSES(const int *A, const int Aoffset, const int N, const int *B, const int Boffset, const int M)
{
	level++ ;
	ntimes++ ;

	//if ( ((Aoffset>-1) && (Boffset>-1)) && ((N>0) || (M>0)) )
	// CAM 25/10 Changed || to && for Kari Alho @ Tellabs
	if ( ((Aoffset>-1) && (Boffset>-1)) && ((N>0) && (M>0)) )
	{
		greedy(A,Aoffset,N,B,Boffset,M) ;

		//MasterData::theLog << "SES: " << ses << endl ;

		// Changed 26-09-01 Stephen Webster
		// From:
		//if (D>1 || M==N)
		// To:
		if (ses>1 || M==N)
		{
			int xtmp = x;
			int ytmp = y;
			int utmp = u;
			int vtmp = v;


			dncSES(A,0+Aoffset,x,B,0+Boffset,y) ;

			int i,c ;
			//MasterData::theLog << "[A] xtmp: " << xtmp << ", utmp: " << utmp << endl ;
			for (i=xtmp, c=0 ; i<utmp ; i++,c++)
			{
				theTrace.push_back(TraceElement(i+Aoffset+1,ytmp+c+Boffset+1)) ;
			}

			dncSES(A,utmp+Aoffset,N-utmp,B,vtmp+Boffset,M-vtmp) ;
		}
		else if (M>N)
		{
			// Removed 26-09-01
			// Stephen Webster
			//
			// I do not think that this for loop should be here - testing to follow

//			int i,c ;
			//MasterData::theLog << "N: " << N << ", M: " << M << endl ;

			//MasterData::theLog << "x: " << x << ", y: " << y << endl ;
			//MasterData::theLog << "u: " << u << ", v: " << v << endl ;

//			for (i=x, c=0 ; i<u ; i++,c++)
//			{
//				theTrace.push_back(TraceElement(i+Aoffset+1,y+c+Boffset+1)) ;
//			}

			if (y>M-ses)	// Insert is at the end
			{
				//MasterData::theLog << "[C] n: " << N << endl ;
				for (int i=0 ; i<N ; i++) {
					theTrace.push_back(TraceElement(i+Aoffset+1,i+Boffset+1)) ;
				}
			}
			else if (y<=1)	// Insert is at the beginning
			{
				//MasterData::theLog << "[D] n: " << N << endl ;
				for (int i=0 ; i<N ; i++) {
					theTrace.push_back(TraceElement(i+Aoffset+1,i+ses+Boffset+1)) ;
				}
			} else			// Insert is in the middle
			{
				int i;
				//MasterData::theLog << "[E] y: " << y << ", n: " << N << endl ;
				for (i=0 ; i<y ; i++) {
					theTrace.push_back(TraceElement(i+Aoffset+1,i+Boffset+1)) ;
				}
				for (i=y ; i<N ; i++) {
					theTrace.push_back(TraceElement(i+Aoffset+1,i+ses+Boffset+1)) ;
				}
			}
		}
		else if (N>M)
		{
			if (x>N-ses)	// Delete is at the end
			{
				//MasterData::theLog << "[F] m: " << M << endl ;
				for (int i=0 ; i<M ; i++) {
					theTrace.push_back(TraceElement(i+Aoffset+1,i+Boffset+1)) ;
				}
			}
			else if (x<=1)	// Delete is at the beginning
			{
				//MasterData::theLog << "[G] m: " << M << endl ;
				for (int i=0 ; i<M ; i++) {
					theTrace.push_back(TraceElement(i+ses+Aoffset+1,i+Boffset+1)) ;
				}
			} else			// Delete is in the middle
			{
				int i;
				//MasterData::theLog << "[H] x: " << x << ", M: " << M << endl ;
				for (i=0 ; i<x ; i++) {
					theTrace.push_back(TraceElement(i+Aoffset+1,i+Boffset+1)) ;
				}
				for (i=x ; i<M ; i++) {
					theTrace.push_back(TraceElement(i+ses+Aoffset+1,i+Boffset+1)) ;
				}
			}
		}
	}
	level-- ;
}

void Diff::SES(const int *A, const int N, const int *B, const int M)
{
//	try
//	{
		//try {
			max = N+M ;

			Vfor = (int*) malloc((2*(max+1))*sizeof(int)) ;
			//Vfor = new int[2*(max+1)] ;
			Vrev = (int*) malloc((2*(max+1))*sizeof(int)) ;
			//Vrev = new int[2*(max+1)] ;

		/*} catch (...) {
			MasterData::theLog << "mark1" << endl ;
		}

		try {*/
			xprev = -1 ;
			yprev = -1 ;

			theTrace.push_back(TraceElement(0,0)) ;
			xtarget = N ;
			ytarget = M ;
		/*} catch (...) {
			MasterData::theLog << "mark1.1" << endl ;
		}

		try{*/
			dncSES(A,0,N,B,0,M) ;
		/*} catch (...) {
			MasterData::theLog << "mark2" << endl ;
		}
		try {*/
			//greedy(A,0,N,B,0,M) ;
			theTrace.push_back(TraceElement(N+1,M+1)) ;
		/*} catch (...) {
			MasterData::theLog << "mark3" << endl ;
		}*/


		/*try {*/
			free (Vfor) ;
			//delete Vfor ;
			free (Vrev) ;
			//delete Vrev ;
		/*} catch (...) {
			MasterData::theLog << "mark4" << endl ;
		}*/

//	} catch (...)
//	{
//		MasterData::theLog << "Exception in Diff::SES()!" << endl ;
//		//cout << "Exception in Diff::SES()" << endl ;
//	}
}

void Diff::changes()
{
	bool deletes,inserts ;
	int j=0 ;

	theChangedLines = theDeletedLines = theInsertedLines = 0 ;

	for ( int i=0 ; i<theTrace.size()-1 ; i++)
	{
		inserts=deletes=false ;

		if (theTrace[i].theY+1<theTrace[i+1].theY)
		{
			inserts = true ;
		}

		if (theTrace[i].theX+1<theTrace[i+1].theX)
		{
			deletes = true ;
		}

		if (deletes && inserts)
		{
			int tmpInserts = 0,tmpDeletes = 0 ;

			for (j=theTrace[i].theY+1 ; j<theTrace[i+1].theY ; j++)
			{
				tmpInserts++ ; //theChangedLines++ ;
			}
			for (j=theTrace[i].theX+1 ; j<theTrace[i+1].theX ; j++)
			{
				tmpDeletes++  ; //theChangedLines++ ;
			}

			if (tmpInserts==tmpDeletes)
			{
				theChangedLines+=tmpInserts ;
			}
			else if (tmpInserts>tmpDeletes)
			{
				theChangedLines+=tmpDeletes ;
				theInsertedLines+= (tmpInserts-tmpDeletes) ;
			}
			else // (tmpInserts<tmpDeletes)
			{
				theChangedLines+=tmpInserts ;
				theDeletedLines+= (tmpDeletes-tmpInserts) ;
			}
		}
		else if (inserts)
		{
			for (j=theTrace[i].theY+1 ; j<theTrace[i+1].theY ; j++)
			{
				//fprintf(stdout,"%dI: %s",theTrace[i].theX,secondactual[j-1]);
				theInsertedLines++ ;
			}
		}
		else
		{
			for (j=theTrace[i].theX+1 ; j<theTrace[i+1].theX ; j++)
			{
				//fprintf(stdout,"%dD\n",j) ;
				theDeletedLines++ ;
			}
		}
	}
}


void Diff::printTrace()
{
	for (int i=0 ; i<theTrace.size() ; i++)
	{
		//MasterData::theLog << "(" << theTrace[i].theX << "," << theTrace[i].theY << ")" ;
		MasterData::theLog << theTrace[i].theX << "," << theTrace[i].theY << endl ;
	}

	//MasterData::theLog << endl ;
}

int Diff::hash(const char *str)
{
	//s[0]*31^(n-1) + s[1]*31^(n-2) + ... + s[n-1]
	int retval = 0 ;
	int length = strlen(str) ;

	if (length==0) return 0 ;

	for (int i=0 ; i<length ; i++ ,str++)
	{
		//if (!strchr(" \t\n",*str))
			retval = 31*retval + (*str) ;
	}
	return retval ;
}


void Diff::compare(const char *filename1, const char *filename2,bool hc)
{
	theFilename1 = filename1 ;
	theFilename2 = filename2 ;

	compare() ;

	if (hc) {
		;
	}
}


/*char *Diff::consumeComment(FILE *input)
{
}*/


char *Diff::getLine(FILE *input)
{
	// This method returns the next line in the file.
	// It seeks ahead until it finds the next suitable line, that is
	// a line that contents characters that are not in a comment and
	// are not whitespace.

	try
	{
		char buffer[1000] ;
		if (!fgets(buffer,1000,input))
			return NULL ;			// EOF or error

		char *c = buffer ;

		char *retval = (char*) malloc(1000*sizeof(char)) ;

		int currAvailLength = 1000 ;		// The current allocated size of retval
		int buffLength = strlen(buffer) ;	// The length of the string in the buffer
		int i=0 ;
		int retLength = 0 ;					// Used to keep track of the created string

		bool skip = false ;
		bool finishedML = true ;

		if (theMultiLine)
			finishedML = false ;

		while (true)
		{
			//if (i>=buffLength)	// We have reached the end of the buffer but not found
			if (*c=='\0')		// We have reached the end of the buffer but not found
			{					// a newline
				// Get the next 1000 chars from the file

				if (!fgets(buffer,1000,input))	// EOF or error
				{
					if (retLength>0)	// If there is a return value return it
					{
						retval[retLength] = '\0' ;
						return retval ;
					}
					else				// otherwise return NULL
						return NULL ;
				}

				c = buffer ;

				buffLength = strlen(buffer) ;	// Set the length of the buffer string
				i = 0 ;							// Reset i
			}

			if (retLength>=currAvailLength-1)
			{
				currAvailLength+=1000 ;

				// Re-size the return string
				retval = (char*) realloc(retval, currAvailLength*sizeof(char*)) ;
			}

			while (!finishedML)
			{

				switch (*c)
				{
				case '\0':
					{
						if (!fgets(buffer,1000,input))	// EOF or error
						{
							if (retLength>0)	// If there is a return value return it
							{
								retval[retLength] = '\0' ;
								return retval ;
							}
							else				// otherwise return NULL
								return NULL ;
						}

						c = buffer ;
						break ;
					}
				case '\n':
					{
						if (retLength>0)	// If there is a return value return it
						{
							retval[retLength] = '\0' ;
							return retval ;
						}

						c++ ;
						break ;
					}
				case '*':
					{
						c++ ;

						if (*c=='/')
						{
							c++ ;
							theMultiLine = false ;
							finishedML = true ;
							break ;
						}
					}

					break ;
				default:
					{
						c++ ;
					}
				}
			}

			switch (*c)
			{
			case '"':
				{
					if (!skip)
						skip = true ;
					else
						skip = false ;

					retval[retLength] = *c ;
					retLength++ ;

					c++ ;
					i++ ;

					break ;
				}
			case ' ':
			case '\t':
				{
					c++ ;
					i++ ;
					break ;
				}
			case '\n':
				{
					if (retLength>0)
					{
						retval[retLength] = '\0' ;
						return retval ;
					}
					c++ ;
					i++ ;
					break ;
				}
			case '/':
				{
					if (!skip)
					{
						char *oldc = c ;
						c++ ;
						switch (*c)
						{
						case '/':
							{
								// At this point a comment to end of line
								// has been found so make set *c to '\n' and break

								// TODO must check that buffer contains eol ie check
								// if the line is more than 1000 chars

								*oldc = '\n';
								*c = '\0';

								c = oldc ;

								break ;
							}
						case '*':
							{
								// At this point a multi line comment
								// has been found so read from file until the end
								// of the comment has been reached

								theMultiLine = true ;
								finishedML = false ;

								break ;
							}
						default:
							{
								retval[retLength] = '/' ;
								retLength++ ;
								retval[retLength] = *c ;
								retLength++ ;

								c++ ;
								i++ ;
							}
						}
					}
					else
					{
						// Skip was true, ie we are in a string so just output the '/'

						retval[retLength] = *c ;
						retLength++ ;

						c++ ;
						i++ ;
					}

					break ;
				}
			case '\\':
				{
					if (skip)
					{
						// We are in a string so this is the start of an escape sequence
						// so output the '\' then move onto the next char

						retval[retLength] = *c ;
						retLength++ ;

						c++ ;
						i++ ;

						// Do not break - instead move onto the defualt clause to output
						// the char following the '\'
					}
				}
			default:
				{
					retval[retLength] = *c ;
					retLength++ ;

					c++ ;
					i++ ;
				}
			}
		}
	}
	catch (...)
	{
		MasterData::theLog << "Exception in Diff::getLine()" << endl ;
		//cout << "Exception in Diff::getLine()" << endl ;
		return strdup("") ;
	}
}


void Diff::compare()
{
	if ((theFilename1 == NULL) || (theFilename2 == NULL)) return ;

	theChangedLines = theDeletedLines = theInsertedLines = 0 ;
	theTrace.clear() ;

	FILE *file1, *file2 ;

	MasterData::theLog << "D,1,\"" << theFilename1 << "\"," <<
		Utilities::getFileSize(theFilename1) << endl ;
	file1 = fopen(theFilename1,"r") ;
	MasterData::theLog << "D,2,\"" << theFilename2 << "\"," <<
		Utilities::getFileSize(theFilename2) << endl ;
	file2 = fopen(theFilename2,"r") ;

	/*if (strcmp(theFilename1 + strlen(theFilename1)-8, "gfqlit.h") == 0) {
		debugging = true ;
	} else {
		debugging = false ;
	}*/

	// Do not try to compare file if there has been a problem when opening

//	try {
		//MasterData::theLog << "D,3" ;
		if ( file1!=NULL && file2!=NULL)
		{

			//char buffer[1000] ;
			char *currString ;
			int length = 0 ;

			int avail_size = 1000 ;
			int increment = 500 ;
			int *first= (int*) malloc(avail_size*sizeof(int)) ;
			//REMOVED: firstactual= (char**) malloc(avail_size*sizeof(char**)) ;
			int fsize = 0 ;


			//while ( fgets(buffer,1000,file1))
			//MasterData::theLog << ",4" ;
			currString = getLine(file1) ;
			while (currString)
			{
				first[fsize] = hash(currString) ;
				//REMOVED: firstactual[fsize] = currString ;
				//MasterData::theLog << currString << endl ;
				//cout << currString << endl ;

				try {
					free(currString) ;
				} catch (...)
				{
					MasterData::theLog << "Exception(1) in Diff::compare()" << endl ;
					//cout << "Exception(1) in Diff::compare()" << endl ;
				}

				fsize++ ;
				if (fsize>=avail_size)
				{
					avail_size+=increment ;

					first = (int*) realloc(first, avail_size*sizeof(int)) ;
					//REMOVED: firstactual = (char**) realloc(firstactual, avail_size*sizeof(char**)) ;
				}
				currString = getLine(file1) ;
			}

			avail_size = 1000 ;
			int *second= (int*) malloc(avail_size*sizeof(int)) ;
			//REMOVED: secondactual= (char**) malloc(avail_size*sizeof(char**)) ;
			int ssize = 0 ;

			//while ( fgets(buffer,1000,file2))
			//MasterData::theLog << ",5" ;
			currString = getLine(file2) ;
			while (currString)
			{
				second[ssize] = hash(currString) ;
				//REMOVED: secondactual[ssize] = currString ;
				//MasterData::theLog << currString << endl ;
				//cout << currString << endl ;

				try {
					free(currString) ;

				} catch (...)
				{
					MasterData::theLog << "Exception(2) in Diff::compare()" << endl ;
					//cout << "Exception(2) in Diff::compare()" << endl ;
				}

				ssize++ ;
				if (ssize>=avail_size)
				{
					avail_size+=increment ;

					second = (int*) realloc(second, avail_size*sizeof(int)) ;
					//REMOVED: secondactual = (char**) realloc(secondactual, avail_size*sizeof(char**)) ;
				}
				currString = getLine(file2) ;
			}

			//MasterData::theLog << ",6" ;
			SES(first,fsize,second,ssize) ;

			//printTrace() ;

			//MasterData::theLog << ",7" ;
			changes() ;

//			throw 0 ;
//			MasterData::theLog << "is this printed?" << endl ;

			//MasterData::theLog << ",8" ;
			free (first) ;
			//MasterData::theLog << ",9" ;
			free (second) ;

		}

		if (file1)
		{
			//MasterData::theLog << ",10" ;
			fclose (file1) ;
		}
		if (file2)
		{
			//MasterData::theLog << ",11" << endl ;
			fclose (file2) ;
		}

/*	} catch (...)
	{
		MasterData::theLog << "Exception(3) in Diff::compare()" << endl ;
		//cout << "Exception(3) in Diff::compare()" << endl ;
	}*/
}
