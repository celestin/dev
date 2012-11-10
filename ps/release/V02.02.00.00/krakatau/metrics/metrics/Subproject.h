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

#ifndef METRICS_SUBPROJECT
#define METRICS_SUBPROJECT

#include <iostream>
#include <vector>
#include "RootNode.h"

namespace metrics
{
	class Subproject
	{

#define CHAR_NUM_SIZE 30

	private:
		long theSubID,			// This Subproject ID
			theCurrentFile,		// Current File (used during iteration)
			theFileCount,		// Count of Source Files within this Subproject
			theCurrentSub ;		// Current Subproject (used during iteration)

		std::string theName ;				// The name of this Subproject
		char theCharSubID[CHAR_NUM_SIZE] ;	// Char version of Subproject ID (for queries)

		std::vector<long> theSubs ;	// Subprojects within this Subproject
		RootNode *theRootNode ;		// The RootNode associated with this Subproject

	protected:

	public:

		Subproject(RootNode *newRoot, long newSubID) ;
		~Subproject() ;

		bool getNextFile(std::string&) ;	// Get next filename from source table
		bool getNextSub(long&) ;			// Get next Subproject ID
		void updateSymbolID(long) ;			// Update this Subproject row with
											// corresponding Symbol ID

		std::string getSubName()	{ return theName ; }
		long getFileCount()			{ return theFileCount ; }
		long getSubCount()			{ return theSubs.size() ; }

	} ;

	class SubprojectTree
	{

	private:
		long theCurrentSub,		// Current File (used during iteration)
			theSubCount ;		// Count of Source Files within this Subproject

		std::vector<long> theSubs ;	// Subprojects within this Subproject
		RootNode *theRootNode ;		// The RootNode associated with this Subproject

	protected:

	public:

		SubprojectTree(RootNode *newRoot) ;
		~SubprojectTree() ;

		bool getNextSub(long&) ;	// Get next Subproject ID
		long getSubCount()			{ return theSubs.size() ; }

	} ;
} ;

#endif
