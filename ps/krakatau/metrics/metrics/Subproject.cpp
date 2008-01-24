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

#include <iostream>
#include <vector>
using namespace std ;

#include "MasterData.h"
#include "RootNode.h"
#include "Subproject.h"
using namespace metrics ;


Subproject::Subproject(RootNode *newRoot, long newSubID)
{
	theRootNode = newRoot ;
	theSubID = newSubID ;
	ltostr(theSubID, theCharSubID, CHAR_NUM_SIZE) ;  // Create char version of SubID

	char sql[512] ;

	// Get Subproject name
	strcpy(sql, "select subName from subproject where subID=") ;
	strcat(sql, theCharSubID) ;
	try
	{
		if (theRootNode->executeQuery(sql))
		{
			theName = theRootNode->cell(0,0) ;
			//MasterData::theLog << "theName [" << theName << "]" << endl ;
		}
	}
	catch (...)
	{
		MasterData::theLog << "Failed executing Subproject constructor query (name)" << endl ;
	}

	// Get Subprojects within this subproject
	strcpy(sql, "select subID from subproject where parID=") ;
	strcat(sql, theCharSubID) ;
	try
	{
		if (theRootNode->executeQuery(sql))
		{
			for (int i=0; i < theRootNode->rows(); i++)
			{
				theSubs.push_back(theRootNode->longCell(i,0)) ;
				//MasterData::theLog << "subID [" << theRootNode->longCell(i,0) << "]" << endl ;
			}
		}
	}
	catch (...)
	{
		MasterData::theLog << "Failed executing Subproject constructor query (subs)" << endl ;
	}

	// Get the number of SourceFiles within this project
	strcpy(sql, "select count(*) as RecordCount from sourcefile where subID=") ;
	strcat(sql, theCharSubID) ;
	if (theRootNode->executeQuery(sql))
	{
		theFileCount = theRootNode->longCell(0,0) ;
	}
	else
	{
		theFileCount = 0 ;
	}

	//MasterData::theLog << "theFileCount [" << theFileCount << "]" << endl << endl ;

	theCurrentSub = theCurrentFile = 0 ;
}


Subproject::~Subproject()
{
}


bool Subproject::getNextFile(string &sourceFile)
{
	if ((theFileCount == 0) || (theCurrentFile >= theFileCount) || (theRootNode == NULL)) return false ;

	char sql[512] ;
	char charNumber[30] ;

	strcpy(sql, "select srfName from sourcefile where subID=") ;
	strcat(sql, theCharSubID) ;
	strcat(sql, " limit ") ;
	strcat(sql, ltostr(theCurrentFile, charNumber, 30)) ;
	strcat(sql, ",1") ;

	try
	{
		if (theRootNode->executeQuery(sql))
		{
			sourceFile = theRootNode->cell(0,0) ;
			theCurrentFile++ ;
			return true ;
		}
	}
	catch (...)
	{
		MasterData::theLog << "Failed executing Subproject::getNextFile query" << endl ;
	}

	return false ;
}


bool Subproject::getNextSub(long &subID)
{
	if ((theSubs.size() == 0) || (theCurrentSub >= theSubs.size()) || (theRootNode == NULL)) return false ;

	subID = theSubs[theCurrentSub++] ;
	return true ;
}


void Subproject::updateSymbolID(long symID)
{
	char sql[512] ;
	char charNumber[30] ;

	strcpy(sql, "update subproject set symID=") ;
	strcat(sql, ltostr(symID, charNumber, 30)) ;
	strcat(sql, " where subID=") ;
	strcat(sql, theCharSubID) ;

	try
	{
		theRootNode->executeResultlessQuery(sql) ;
	}
	catch (...)
	{
		MasterData::theLog << "Failed executing Subproject::updateSymbolID query" << endl ;
	}
}


// =-=-= SubprojectTree =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

SubprojectTree::SubprojectTree(RootNode *newRoot)
{
	theRootNode = newRoot ;

	try
	{
		if (theRootNode->executeQuery("select symid from subproject order by sublevel desc, subid"))
		{
			for (int i=0; i < theRootNode->rows(); i++)
			{
				theSubs.push_back(theRootNode->longCell(i,0)) ;
				//MasterData::theLog << "subID [" << theRootNode->longCell(i,0) << "]" << endl ;
			}
		}
	}
	catch (...)
	{
		MasterData::theLog << "Failed executing SubprojectTree constructor query (subs)" << endl ;
	}

	theCurrentSub = 0 ;
}


SubprojectTree::~SubprojectTree()
{
}


bool SubprojectTree::getNextSub(long &subID)
{
	if ((theSubs.size() == 0) || (theCurrentSub >= theSubs.size()) || (theRootNode == NULL)) return false ;

	subID = theSubs[theCurrentSub++] ;
	return true ;
}
