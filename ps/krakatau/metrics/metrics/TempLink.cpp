/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * CAM  02-Apr-08  339 : Corrected deprecation warnings.
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
}


void TempLink::read()
{
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
  char sql[QUERY_MAX] ;
  char charNumber[30] ;

  if (theSingle)
  {
    strcpy_s(sql,QUERY_MAX,"SELECT lnkID, symID, lktID, ref FROM link WHERE symID=") ;
    strcat_s(sql,QUERY_MAX, ltostr(theSymID, charNumber, 30)) ;

    strcat_s(sql,QUERY_MAX, " AND sym2ID=-1 AND lktID=") ;
    strcat_s(sql,QUERY_MAX, ltostr(theLktID, charNumber, 30)) ;

    if (connection.executeQuery(string(sql)))
    {
      for (int i=0 ; i<connection.rows() ; i++)
      {
        this->push_back(TempLink(
          connection.longCell(i,0),   // lnkID
          connection.longCell(i,1),   // symID
          connection.longCell(i,2),   // lktID
          connection.cell(i,3),     // ref
          false)) ;           // parms
      }
    }
  }
  else
  {
    if (theIDs.size()<1) return ;

    int i,j,term,r,numIDs = theIDs.size() ;

    for(j=0; j < numIDs; j += SYMBOLS_PER_SELECT)
    {
      strcpy_s(sql,QUERY_MAX,"SELECT lnkID, symID, lktID, ref FROM link WHERE symID in (") ;

      // Calculate terminating index
      term = j + SYMBOLS_PER_SELECT - 1 ;

      // Crop index to the end of the vector, if necessary
      if (term >= numIDs) term = numIDs - 1 ;

      // Build the string
      for (i=j ; i < term; i++ )
      {
        strcat_s(sql,QUERY_MAX, ltostr(theIDs[i], charNumber, 30)) ;
        strcat_s(sql,QUERY_MAX,",") ;
      }

      // Add the last index to the string
      strcat_s(sql,QUERY_MAX, ltostr(theIDs[term], charNumber, 30)) ;

      // Close of the string
      strcat_s(sql,QUERY_MAX, ") AND sym2ID=-1 and lktID=") ;
      strcat_s(sql,QUERY_MAX, ltostr(theLktID, charNumber, 30)) ;

      if (connection.executeQuery(string(sql)))
      {
        for (r=0 ; r<connection.rows() ; r++)
        {
          this->push_back(TempLink(
            connection.longCell(r,0),   // lnkID
            connection.longCell(r,1),   // symID
            connection.longCell(r,2),   // lktID
            connection.cell(r,3),     // ref
            false)) ;           // parms
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

      strcpy_s(sql,QUERY_MAX,"SELECT lktID FROM templinkdetail WHERE tlkID=") ;
      strcat_s(sql,QUERY_MAX, ltostr(iter->getID(), charNumber, 30)) ;

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
