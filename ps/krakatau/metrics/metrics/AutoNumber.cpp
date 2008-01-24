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

#include "AutoNumber.h"
using namespace metrics ;


// Generate new Unique ID
long AutoNumber::newID()
{
	long retval ;

	if (theReleasedIDs.size() > 0)
	{
		retval = theReleasedIDs.top() ;
		theReleasedIDs.pop() ;
	}
	else
	{
		retval = theCurrentID++ ;
	}

	return (retval) ;
}


// Release an ID (add to stack)
void AutoNumber::releaseID(long anID)
{
	theReleasedIDs.push(anID) ;
}


// Reset the AutoNumber to zero and clear theReleasedIDs
void AutoNumber::reset(int initial)
{
	theCurrentID = initial ;
	while (!theReleasedIDs.empty())
	{
		theReleasedIDs.pop() ;
	}
}