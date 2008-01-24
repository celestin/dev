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
using namespace std;

#include "TempLink.h"
using namespace metrics;

AutoNumber TempLink::theHeaderNum ;
AutoNumber TempLink::theDetailNum ;

extern MasterData *md ;

TempLink::~TempLink()
{
	theTypes.clear() ;
}


void TempLink::addType(long lktID)
{
	theTypes.push_back(lktID) ;
	theParms = true ;
}


LongVect TempLink::getTypes()
{
	return (theTypes) ;
}


void TempLink::write()
{
	/*if (!theWritten)
	{
		try
		{
			char sql[512], charNumber[30] ;

			long theID = theHeaderNum.newID() ;

			strcpy(sql,"Insert Into TempLink Values ( ") ;
			strcat(sql, ltostr(theID, charNumber, 30)) ;
			strcat(sql, ",") ;
			strcat(sql, ltostr(theSymID, charNumber, 30)) ;
			strcat(sql, ",") ;
			strcat(sql, ltostr(theLktID, charNumber, 30)) ;
			strcat(sql, ",'") ;
			strcat(sql, theRef.c_str()) ;
			strcat(sql, "',") ;
			strcat(sql, ltostr(theParms, charNumber, 30)) ;
			strcat(sql, ")") ;

			md->theDBConnection.executeResultlessQuery(sql.str()) ;
*/
			/*if (theParms)
			{
				LongVectIter iter ;
				for (iter=theTypes.begin(); iter<theTypes.end(); iter++)
				{
					sql << "Insert Into TempLinkDetail Values ( "
						<< theDetailNum.newID() << " , "
						<< theID << " , "
						<< iter << " )" << flush ;

					md->theDBConnection.executeResultlessQuery(sql.str()) ;
				}
			}*/
/*		}
		catch (...)
		{
			MasterData::theLog << "TempLink::write() - Error executing query!" << endl ;
		}

		theWritten = true ;
	}*/
}


void TempLink::read()
{
	// Not reqd - performed by TempLinks
}


void TempLink::resetIDs()
{
	theHeaderNum.reset(1) ;
	theDetailNum.reset(1) ;
}


// == TempLink Collection - TempLinks =============================

TempLinks::TempLinks(OurSQL &connection, long symID, long lktID) : list<TempLink>()
{
	theSymID = symID ;
	theLktID = lktID ;
	theSingle = true ;

	read(connection) ;
}

TempLinks::TempLinks(OurSQL &connection, vector<long> IDs, long lktID) : list<TempLink>()
{
	theLktID = lktID ;
	theSingle = false ;
	theIDs = IDs ;

	read(connection) ;
}

TempLinks::~TempLinks()
{
	// Nothing to delete
}


void TempLinks::read(OurSQL &connection)
{
	char sql[8192] ;
	char charNumber[30] ;

	if (theSingle)
	{
		strcpy(sql,"SELECT lnkID, symID, lktID, ref FROM link WHERE symID=") ;
		strcat(sql, ltostr(theSymID, charNumber, 30)) ;

		strcat(sql, " AND sym2ID=-1 AND lktID=") ;
		strcat(sql, ltostr(theLktID, charNumber, 30)) ;

		if (connection.executeQuery(string(sql)))
		{
			for (int i=0 ; i<connection.rows() ; i++)
			{
				this->push_back(TempLink(
					connection.longCell(i,0),		// lnkID
					connection.longCell(i,1),		// symID
					connection.longCell(i,2),		// lktID
					connection.cell(i,3),			// ref
					false)) ;						// parms
			}
		}
	}
	else
	{
		if (theIDs.size()<1) return ;

		int i,j,term,r,numIDs = theIDs.size() ;

		for(j=0; j < numIDs; j += SYMBOLS_PER_SELECT)
		{
			strcpy(sql,"SELECT lnkID, symID, lktID, ref FROM link WHERE symID in (") ;

			// Calculate terminating index
			term = j + SYMBOLS_PER_SELECT - 1 ;

			// Crop index to the end of the vector, if necessary
			if (term >= numIDs) term = numIDs - 1 ;

			// Build the string
			for (i=j ; i < term; i++ )
			{
				strcat(sql, ltostr(theIDs[i], charNumber, 30)) ;
				strcat(sql,",") ;
			}

			// Add the last index to the string
			strcat(sql, ltostr(theIDs[term], charNumber, 30)) ;

			// Close of the string
			strcat(sql, ") AND sym2ID=-1 and lktID=") ;
			strcat(sql, ltostr(theLktID, charNumber, 30)) ;

			if (connection.executeQuery(string(sql)))
			{
				for (r=0 ; r<connection.rows() ; r++)
				{
					this->push_back(TempLink(
						connection.longCell(r,0),		// lnkID
						connection.longCell(r,1),		// symID
						connection.longCell(r,2),		// lktID
						connection.cell(r,3),			// ref
						false)) ;						// parms
				}
			}
		}
	}

	return ;

	// Ignore Temp Link detail for now (unused as yet)

	TempLinks::iterator iter ;

	for (iter = begin(); iter != end(); iter++ )
	{
		if (iter->hasParms())
		{
			char sql[512], charNumber[30] ;

			strcpy(sql,"SELECT lktID FROM templinkdetail WHERE tlkID=") ;
			strcat(sql, ltostr(iter->getID(), charNumber, 30)) ;

			if (connection.executeQuery(sql))
			{
				for (int i=0 ; i<connection.rows() ; i++)
				{
					iter->addType(connection.longCell(i,0)) ;
				}
			}
		}
	}
}


/*void TempLinks::read(OurSQL &connection)
{
	char sql[8192] ;
	char charNumber[30] ;

	if (theSingle)
	{
		strcpy(sql,"SELECT tlkID, symID, lktID, ref, parms FROM TempLink WHERE symID=") ;
		//itoa(theSymID, charNumber, 10) ;
		//strcat(sql, charNumber) ;
		strcat(sql, ltostr(theSymID, charNumber, 30)) ;

		strcat(sql, " AND lktID=") ;
		//itoa(theLktID, charNumber, 10) ;
		//strcat(sql, charNumber) ;
		strcat(sql, ltostr(theLktID, charNumber, 30)) ;

		if (connection.executeQuery(string(sql)))
		{
			for (int i=0 ; i<connection.rows() ; i++)
			{
				this->push_back(TempLink(
					connection.longCell(i,0),		// tlkID
					connection.longCell(i,1),		// symID
					connection.longCell(i,2),		// lktID
					connection.cell(i,3),			// ref
					connection.longCell(i,4)==1)) ;	// parms
			}
		}
	}
	else
	{
		if (theIDs.size()<1) return ;

		int i,j,term,r,numIDs = theIDs.size() ;

		for(j=0; j < numIDs; j += SYMBOLS_PER_SELECT)
		{
			strcpy(sql,"SELECT tlkID, symID, lktID, ref, parms FROM TempLink WHERE symID in (") ;

			// Calculate terminating index
			term = j + SYMBOLS_PER_SELECT - 1 ;

			// Crop index to the end of the vector, if necessary
			if (term >= numIDs) term = numIDs - 1 ;

			// Build the string
			for (i=j ; i < term; i++ )
			{
				//itoa(theIDs[i], charNumber, 10) ;
				//strcat(sql, charNumber) ;
				//strcat(sql, ",") ;
				strcat(sql, ltostr(theIDs[i], charNumber, 30)) ;
				strcat(sql,",") ;
			}

			// Add the last index to the string
			//itoa(theIDs[term], charNumber, 10) ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theIDs[term], charNumber, 30)) ;

			// Close of the string
			strcat(sql, ") and lktID=") ;
			//itoa(theLktID, charNumber, 10) ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theLktID, charNumber, 30)) ;

			if (connection.executeQuery(string(sql)))
			{
				for (r=0 ; r<connection.rows() ; r++)
				{
					this->push_back(TempLink(
						connection.longCell(r,0),			// tlkID
						connection.longCell(r,1),			// symID
						connection.longCell(r,2),			// lktID
						connection.cell(r,3),				// ref
						connection.longCell(r,4)==1)) ;	// parms
				}
			}
		}
	}

	return ;

	// Ignore Temp Link detail for now (unused as yet)

	TempLinks::iterator iter ;

	for (iter = begin(); iter != end(); iter++ )
	{
		if (iter->hasParms())
		{
			char sql[512], charNumber[30] ;

			strcpy(sql,"SELECT lktID FROM TempLinkDetail WHERE tlkID=") ;
			strcat(sql, ltostr(iter->getID(), charNumber, 30)) ;

			if (connection.executeQuery(sql))
			{
				for (int i=0 ; i<connection.rows() ; i++)
				{
					iter->addType(connection.longCell(i,0)) ;
				}
			}
		}
	}

	//sort() ;		// removed CAM 09/01/2001 - not req'd (and TempLinks.sort() may be
					//		called at any subsequent time)
}*/


