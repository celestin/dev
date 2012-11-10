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

#ifndef METRICS_SOURCEFILES
#define METRICS_SOURCEFILES

#include <iostream>
#include <vector>
#include "RootNode.h"
#include "Utilities.h"

namespace metrics
{
	class SourceFile
	{
	private:
		long theID ;
		std::string theFilename ;
		long theLastMod ;
		bool theChanged ;

	public:
		SourceFile(long newID, std::string newFilename, long newLastMod) ;
		SourceFile(std::string newFilename) ;
		~SourceFile() {}

		long getID()								{ return theID ; }
		void setID(long newID)						{ theID = newID ; }
		std::string getFilename()					{ return theFilename ; }
		void setFilename(std::string newFilename)	{ theFilename = newFilename ; }
		long getLastModTime()						{ return theLastMod ; }
		void setLastModTime(long newLastModTime)	{ theLastMod = newLastModTime ; }

		bool hasChanged() ;
		//char* insert(char *sql) ;
		char* update(char *sql) ;
		char* insertNew(char *sql) ;
		char* insertDel(char *sql) ;

	} ;

#define REBUILD_THRESHOLD 90

#define SOURCE_GUI_SQL  "select srfName from sourcefile limit "
#define SOURCE_DEL_SQL  "select srdName from sourcefiledel limit "
#define SOURCE_NEW_SQL  "select srnName from sourcefilenew limit "
#define COUNT_GUI_SQL   "select count(*) as RecordCount from sourcefile"
#define COUNT_DEL_SQL   "select count(*) as RecordCount from sourcefiledel"
#define COUNT_NEW_SQL   "select count(*) as RecordCount from sourcefilenew"

	class SourceFiles
	{

	private:
		long theCount ;
		long theCurrent ;
		Killer theKiller ;

		RootNode *theRootNode ;	// The RootNode associated with these SourceFiles
		bool theFreshBuild ;	// Is this a Fresh Build?
		long theMatchCount,		// Count of Matched SourceFiles
			theChgCount,		// Count of Changed SourceFiles (db != actual)
			theDelCount,		// Count of Deleted SourceFiles (in db, not gui)
			theNewCount ;		// Count of New SourceFiles (in gui, not db)
		int theTable ;			// Current 'SourceFile' table

	protected:
		bool existsSourceFileLast() ;	// Check whether SourceFileLast exists
		void createSourceFileLast() ;	// Create SourceFileLast table
		void copyGuiToLast() ;			// Copy SourceFile to SourceFileLast
		void copyNewToLast() ;			// Copy SourceFileNew to SourceFileLast
		void updateLastModTimes() ;		// Update LastMod where == 0
		void removeLinks() ;			// Remove Links

		void buildDeltaTables() ;		// Build SourceFileMatch, Del & New
		void checkMatchedFiles() ;		// Check Matched files for changes to ModTime

		void removeFiles() ;			// Remove Deleted files (Symbols) from db
		void removeFromDb(long symID) ;	// Remove a given symbol and its children from db

	public:

		static const long SOURCE_GUI ;
		static const long SOURCE_DEL ;
		static const long SOURCE_NEW ;

		SourceFiles(RootNode *newRoot) ;
		~SourceFiles() ;

		void setSourceTable(int) ;		// Set the source table for retreiving filenames
		bool getNext(std::string&) ;	// Get next filename from source table

		bool isFreshBuild()		{ return theFreshBuild ; }

		long getCount()			{ return theCount ; }
		long getMatchCount()	{ return theMatchCount ; }
		long getDelCount()		{ return theDelCount ; }
		long getNewCount()		{ return theNewCount ; }

	} ;
} ;

#endif
