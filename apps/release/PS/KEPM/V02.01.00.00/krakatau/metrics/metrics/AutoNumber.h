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

#ifndef METRICS_AUTONUMBER
#define METRICS_AUTONUMBER

#include <stack>

namespace metrics
{
	class AutoNumber
	{
	private:
		long theCurrentID ;					// The Current ID
		std::stack<long> theReleasedIDs ;	// Short list of released/available IDs

	public:
		AutoNumber() { theCurrentID = 1 ; }	// Def cons - Start ID of 1
		AutoNumber(int startID) { theCurrentID = startID ; }	// Set Start ID
		virtual ~AutoNumber() {}

		long newID() ;					// Generate new Unique ID
		void releaseID(long anID) ;		// Release an ID (add to stack)

		virtual void reset(int initial) ;	// Reset the AutoNumber to zero and clear theReleasedIDs

	} ;
} ;

#endif
