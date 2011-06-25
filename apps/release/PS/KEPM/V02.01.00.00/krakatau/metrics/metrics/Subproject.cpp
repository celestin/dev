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

  char sql[1024] ;

  // Get Subproject name
  strcpy_s(sql,1024, "select subName from subproject where subID=") ;
  strcat_s(sql,1024, theCharSubID) ;
  try
  {
    if (theRootNode->executeQuery(sql))
    {
      theName = theRootNode->cell(0,0) ;
    }
  }
  catch (...)
  {
    MasterData::theLog << "Failed executing Subproject constructor query (name)" << endl ;
  }

  // Get Subprojects within this subproject
  strcpy_s(sql,1024, "select subID from subproject where parID=") ;
  strcat_s(sql,1024, theCharSubID) ;
  try
  {
    if (theRootNode->executeQuery(sql))
    {
      for (int i=0; i < theRootNode->rows(); i++)
      {
        theSubs.push_back(theRootNode->longCell(i,0)) ;
      }
    }
  }
  catch (...)
  {
    MasterData::theLog << "Failed executing Subproject constructor query (subs)" << endl ;
  }

  // Get the number of SourceFiles within this project
  strcpy_s(sql,1024, "select count(*) as RecordCount from sourcefile where subID=") ;
  strcat_s(sql,1024, theCharSubID) ;
  if (theRootNode->executeQuery(sql))
  {
    theFileCount = theRootNode->longCell(0,0) ;
  }
  else
  {
    theFileCount = 0 ;
  }

  theCurrentSub = theCurrentFile = 0 ;
}


Subproject::~Subproject()
{
}


bool Subproject::getNextFile(string &sourceFile)
{
  if ((theFileCount == 0) || (theCurrentFile >= theFileCount) || (theRootNode == NULL)) return false ;

  char sql[1024] ;
  char charNumber[30] ;

  strcpy_s(sql,1024, "select srfName from sourcefile where subID=") ;
  strcat_s(sql,1024, theCharSubID) ;
  strcat_s(sql,1024, " limit ") ;
  strcat_s(sql,1024, ltostr(theCurrentFile, charNumber, 30)) ;
  strcat_s(sql,1024, ",1") ;

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
  if ((theSubs.size() == 0) || ((unsigned int)theCurrentSub >= theSubs.size()) || (theRootNode == NULL)) return false ;

  subID = theSubs[theCurrentSub++] ;
  return true ;
}


void Subproject::updateSymbolID(long symID)
{
  char sql[1024] ;
  char charNumber[30] ;

  strcpy_s(sql,1024, "update subproject set symID=") ;
  strcat_s(sql,1024, ltostr(symID, charNumber, 30)) ;
  strcat_s(sql,1024, " where subID=") ;
  strcat_s(sql,1024, theCharSubID) ;

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
  if ((theSubs.size() == 0) || ((unsigned int)theCurrentSub >= theSubs.size()) || (theRootNode == NULL)) return false ;

  subID = theSubs[theCurrentSub++] ;
  return true ;
}
