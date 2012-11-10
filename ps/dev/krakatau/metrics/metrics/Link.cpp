/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * CAM  22-Jan-08  339 : Corrected deprecation warnings.
 * CAM  02-Apr-08  339 : Corrected deprecation warnings.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include "Link.h"
#include "MasterData.h"
using namespace metrics ;
using namespace std ;

AutoNumber Link::theAutoNumber ;

Link::~Link()
{

}


string Link::formSqlInsert()
{
  char sql[1024] ;
  char charNumber[30] ;

  strcpy_s(sql,"(") ;

  if (theID == AUTONUMBER) theID = theAutoNumber.newID() ;

  strcat_s(sql,1024, ltostr(theAutoNumber.newID(), charNumber, 30)) ;
  strcat_s(sql,1024,",") ;

  strcat_s(sql,1024, ltostr(theSourceID, charNumber, 30)) ;
  strcat_s(sql,1024,",") ;

  strcat_s(sql,1024, ltostr(theDestID, charNumber, 30)) ;
  strcat_s(sql,1024,",") ;

  strcat_s(sql,1024, ltostr(theTypeID, charNumber, 30)) ;
  strcat_s(sql,1024,",'") ;

  strcat_s(sql,1024, theRef.c_str()) ;
  strcat_s(sql,1024,"')") ;

  return string(sql) ;
}


void Link::updateLink(OurSQL &connection)
{
  char sql[1024], charNumber[30] ;

  strcpy_s(sql,1024,"update link set sym2ID=") ;
  strcat_s(sql,1024, ltostr(theDestID, charNumber, 30)) ;
  strcat_s(sql,1024," where lnkID=") ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;

  connection.executeResultlessQuery(sql) ;
}


void Link::write()
{
}


void Link::read()
{
}


Links::~Links()
{
  int i;
  for( i=0; i<NLINKTYPES; i++)
  {
    if (theLinks[i] != NULL)
    {
      theLinks[i]->clear() ;
      delete theLinks[i] ;
      theLinks[i] = NULL ;
    }
  }
}


void Links::initLinks()
{
  int i;
  for( i=0; i<NLINKTYPES; i++)
    theLinks[i] = NULL ;

  theInsertSql = "" ;
  theNumInserts = 0 ;
}


// Clear all vectors pointed at by theLinks
void Links::deleteLinks()
{
  for(int c=0; c<NLINKTYPES; c++)
  {
    if (theLinks[c] != NULL)
    {
      theLinks[c]->clear() ;
      delete theLinks[c] ;
      theLinks[c] = NULL ;
    }
  }

  theInsertSql = "" ;
  theNumInserts = 0 ;
}


// Clear all vectors pointed at by theLinks
void Links::clearLinks()
{
  for(int c=0; c<NLINKTYPES; c++)
  {
    if (theLinks[c] != NULL)
    {
      theLinks[c]->clear() ;
    }
  }

  theInsertSql = "" ;
  theNumInserts = 0 ;
}


// Add Link to correct vector
void Links::addLink(long toID, long lktID)
{
  if (lktID>NLINKTYPES)
    return ;
  else
  {
    if (!theLinks[lktID])
    {
      theLinks[lktID] = new vector<Link> ;
    }

    theLinks[lktID]->push_back(Link(theID, toID, lktID)) ;
  }
}


void Links::addLink(long lnkID, long toID, long lktID)
{
  if (lktID>NLINKTYPES)
    return ;
  else
  {
    if (!theLinks[lktID])
    {
      theLinks[lktID] = new vector<Link> ;
    }

    theLinks[lktID]->push_back(Link(lnkID, theID, toID, lktID)) ;
  }
}


vector<Link> Links::getLinks(long lktID)
{
  vector<Link> retval ;

  if (lktID>NLINKTYPES) return retval ;

  if (theLinks[lktID] != NULL)
  {
    return (*theLinks[lktID]) ;
  }

  return retval ;
}


vector<Link> Links::getLinks()
{
  vector<Link> retval ;

  unsigned int i,j;
  for (i=0 ; i<NLINKTYPES ; i++)
  {
    if (theLinks[i] != NULL)
    {
      for (j=0 ; j<theLinks[i]->size() ; j++)
      {
        retval.push_back((*theLinks[i])[j]) ;
      }
    }
  }
  return retval ;
}


void Links::readLinks(OurSQL& connection)
{
  char sql[1024];
  char charNumber[30];
  vector<long> linkTypes;
  unsigned int i;
  int current,j;

  deleteLinks() ;

  try
  {
    // First determine get an overview of the number of
    // types of Link for this Symbol

    strcpy_s(sql,1024,"Select lktID From link Where SymID = ") ;
    strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;
    strcat_s(sql,1024, " Group By lktID") ;

    if (connection.executeQuery(sql))
    {
      for(j=0; j<connection.rows(); j++ )
        linkTypes.push_back(atol(connection.cell(j,0).c_str())) ;
    }

    // Process each type of link, retreiving the detail rows
    // and adding them to the vectors of Links within *this
    for(i=0; i<linkTypes.size(); i++)
    {
      current = linkTypes[i] ;
      //ostringstream currentSql ;
      char sql[512], charNumber[30] ;

      // Create a new vector for this type
      theLinks[current] = new vector<Link> ;

      strcpy_s(sql,1024,"Select sym2ID From link Where SymID=") ;
      strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;
      strcat_s(sql,1024, " And lktID=") ;
      strcat_s(sql,1024, ltostr(current, charNumber, 30)) ;

      if (connection.executeQuery(sql))
      {
        for( j=0; j<connection.rows(); j++)
        {
          theLinks[current]->push_back(Link(theID, atol(connection.cell(j,0).c_str()), current,true)) ;
        }
      }
    }
  }
  catch (...)
  {
    MasterData::theLog << "Error in SymbolNode::readLinks()" << endl ;
  }
}


void Links::write(OurSQL &connection)
{
  for (int i=0 ; i<NLINKTYPES ; i++)
  {
    if (theLinks[i] != NULL)
    {
      for (unsigned int j=0 ; j<theLinks[i]->size() ; j++)
      {
        if (!(*theLinks[i])[j].theWritten)
        {
          if ((*theLinks[i])[j].getID() == AUTONUMBER)
          {
            addInsert(connection, (*theLinks[i])[j].formSqlInsert()) ;
            (*theLinks[i])[j].theWritten = true ;
          }
          else
          {
            (*theLinks[i])[j].updateLink(connection) ;
            (*theLinks[i])[j].theWritten = true ;
          }
        }
      }
    }
  }

  flushInsert(connection) ;
}


void Links::flushInsert(OurSQL &connection)
{
  if (theNumInserts > 0)
  {
    try
    {
      connection.executeResultlessQuery(theInsertSql) ;
    }
    catch (...)
    {
      MasterData::theLog << "Links::flushInsert() - Error executing query!" << endl ;
    }

    theInsertSql = "" ;
    theNumInserts = 0 ;
  }
}


void Links::addInsert(OurSQL &connection, string insertSql)
{
  if (theNumInserts == 0)
  {
    theInsertSql = "Insert Into link Values " + insertSql ;
  }
  else if (theNumInserts >= MAX_LINK_INSERTS)
  {
    flushInsert(connection) ;
    theInsertSql = "Insert Into link Values " + insertSql ;
  }
  else
  {
    theInsertSql += "," + insertSql ;
  }

  theNumInserts++ ;
}


Killer::Killer()
{
  theConnection = NULL ;
  clear() ;
}


Killer::~Killer()
{
  flush() ;
}


void Killer::setConnection(OurSQL *newConnection)
{
  theConnection = newConnection ;
}


void Killer::clear()
{
  strcpy_s(theLinkFromSql,KILLER_BUFFER_SIZE,  "delete from link where symID in (") ;
  strcpy_s(theLinkToSql,KILLER_BUFFER_SIZE,    "update link set sym2ID=-1 where sym2ID in (") ;
  strcpy_s(theTypeSql,KILLER_BUFFER_SIZE,      "delete from symboltype where symID in (") ;
  strcpy_s(theSymbolSql,KILLER_BUFFER_SIZE,    "delete from symbol where symID in (") ;

  anyData = false ;
}


void Killer::flush()
{
  if (!anyData) return ;

  theLinkFromSql[strlen(theLinkFromSql)-1] = ')' ;
  theLinkToSql[strlen(theLinkToSql)-1] = ')' ;
  theTypeSql[strlen(theTypeSql)-1] = ')' ;
  theSymbolSql[strlen(theSymbolSql)-1] = ')' ;

  if (theConnection)
  {
    MasterData::theLog << theLinkFromSql << endl ;

    theConnection->executeResultlessQuery(theLinkFromSql) ;
    theConnection->executeResultlessQuery(theLinkToSql) ;
    theConnection->executeResultlessQuery(theTypeSql) ;
    theConnection->executeResultlessQuery(theSymbolSql) ;
  }

  clear() ;
}


void Killer::add(long lnkID)
{
  char charNumber[30] ;
  ltostr(lnkID, charNumber, 30) ;

  if ((strlen(theLinkToSql)+20) > KILLER_BUFFER_SIZE)
  {
    flush() ;
  }

  strcat_s(theLinkFromSql,KILLER_BUFFER_SIZE, charNumber) ;
  strcat_s(theLinkFromSql,KILLER_BUFFER_SIZE, ",") ;

  strcat_s(theLinkToSql,KILLER_BUFFER_SIZE, charNumber) ;
  strcat_s(theLinkToSql,KILLER_BUFFER_SIZE, ",") ;

  strcat_s(theTypeSql,KILLER_BUFFER_SIZE, charNumber) ;
  strcat_s(theTypeSql,KILLER_BUFFER_SIZE, ",") ;

  strcat_s(theSymbolSql,KILLER_BUFFER_SIZE, charNumber) ;
  strcat_s(theSymbolSql,KILLER_BUFFER_SIZE, ",") ;

  anyData = true ;
}
