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
#include "SourceFiles.h"
using namespace metrics ;


// =-=-= SourceFile IMPLEMENTATION =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

SourceFile::SourceFile(long newID, string newFilename, long newLastMod): theFilename(newFilename)
{
  theID = newID ;
  theLastMod = newLastMod ;

  long actualLastMod = Utilities::getLastModTime(theFilename) ;

  if (theLastMod != actualLastMod) // file has changed
  {
    theLastMod = actualLastMod ;
    theChanged = true ;
  }
  else
  {
    theChanged = false ;
  }
}


SourceFile::SourceFile(string newFilename): theFilename(newFilename)
{
  theID = 0 ;
  theLastMod = Utilities::getLastModTime(theFilename) ;
  theChanged = false ;
}


bool SourceFile::hasChanged()
{
  return theChanged ;
}


char* SourceFile::insertNew(char *sql)
{
  strcpy_s(sql,QUERY_MAX,"insert into sourcefilenew (srnName) values ('") ;
  strcat_s(sql,QUERY_MAX, theFilename.c_str()) ;
  strcat_s(sql,QUERY_MAX,"')") ;

  return sql ;
}


char* SourceFile::insertDel(char *sql)
{
  strcpy_s(sql,QUERY_MAX,"insert into sourcefiledel (srdName) values ('") ;
  strcat_s(sql,QUERY_MAX, theFilename.c_str()) ;
  strcat_s(sql,QUERY_MAX,"')") ;

  return sql ;
}


char* SourceFile::update(char *sql)
{
  char charNumber[30] ;

  strcpy_s(sql,QUERY_MAX,"update sourcefilelast set srlLastMod=") ;
  strcat_s(sql,QUERY_MAX, ltostr(theLastMod, charNumber, 30)) ;
  strcat_s(sql,QUERY_MAX," where srlID=") ;
  strcat_s(sql,QUERY_MAX, ltostr(theID, charNumber, 30)) ;

  return sql ;
}


// =-=-= SourceFiles IMPLEMENTATION =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

const long SourceFiles::SOURCE_GUI = 0 ;
const long SourceFiles::SOURCE_DEL = 1 ;
const long SourceFiles::SOURCE_NEW = 2 ;

SourceFiles::SourceFiles(RootNode *newRoot): theKiller()
{
  theRootNode = newRoot ;
  theFreshBuild = true ;
  theMatchCount = theDelCount = theNewCount = 0 ;

  // Remove when finally working
  setSourceTable(SOURCE_GUI) ;
  theRootNode->setFreshBuild(true) ;
  return ;

  theKiller.setConnection(new OurSQL(theRootNode->getHost(),theRootNode->getDB())) ;

  if (theRootNode == NULL)
  {
    MasterData::theLog << "Null Pointer Exception at SourceFiles() :- newRoot" << endl ;
  }
  else
  {
    // Has the GUI decided on a fresh build?
    theFreshBuild = theRootNode->isFreshBuild() ;

    if (!theFreshBuild) // GUI wants to append, check for SourceFilesLast table
    {
      if (existsSourceFileLast())
      {
        buildDeltaTables() ;  // Build Match, New & Deleted tables
        checkMatchedFiles() ; // Compare actual LastMod to SourceFileLast time

        MasterData::theLog << "INCREMENTAL_UPDATE m:" << theMatchCount <<
          "  n:" << theNewCount << "  d:" << theDelCount << endl ;

        if ((((float)theDelCount+theNewCount)/(float)theMatchCount*100) > REBUILD_THRESHOLD)
        {
          theFreshBuild = true ;  // The % of Deleted & New entries exceeds
        }             // the threshold - do fresh build
      }
      else // SourceFilesLast does not exist - override GUI append and do fresh build
      {
        theFreshBuild = true ;
      }
    }

    if (theFreshBuild != theRootNode->isFreshBuild())
    {
      theRootNode->setFreshBuild(theFreshBuild) ; // If fresh build decision has
    }                       // changed, update RootNode
    else
    {                 // Otherwise load previously resolved
      theRootNode->readSymbolType() ; // SymbolTypes from database
    }
  }

  if (theFreshBuild) // Use table populated by GUI
  {
    MasterData::theLog << "fresh" << endl ;
    setSourceTable(SOURCE_GUI) ;
    createSourceFileLast() ;
    copyGuiToLast() ;
    updateLastModTimes() ;
  }
  else if ((theNewCount+theDelCount+theChgCount) > 0) // Use New table as generated above
  {
    MasterData::theLog << "new" << endl ;
    setSourceTable(SOURCE_NEW) ;
    copyNewToLast() ;
    updateLastModTimes() ;

    removeFiles() ;
  }
  else // No new or changed files - nothing to do
  {
    MasterData::theLog << "none" << endl ;
    theCurrent = 0 ;
    theCount = 0 ;
  }

}

SourceFiles::~SourceFiles()
{
}


void SourceFiles::setSourceTable(int newTable)
{
  theTable = newTable ;
  char sql[1024] ;

  switch (theTable)
  {
  case SOURCE_GUI:
    strcpy_s(sql,1024, COUNT_GUI_SQL) ;
    break ;
  case SOURCE_DEL:
    strcpy_s(sql,1024, COUNT_DEL_SQL) ;
    break ;
  case SOURCE_NEW:
    strcpy_s(sql,1024, COUNT_NEW_SQL) ;
    break ;
  }

  if (theRootNode->executeQuery(sql))
  {
    theCount = theRootNode->longCell(0,0) ;
    theCurrent = 0 ;
  }
}


bool SourceFiles::existsSourceFileLast()
{
  if (theRootNode->executeQuery("show tables like 'sourcefilelast'"))
  {
    if (theRootNode->rows() > 0)
    {
      return true ;
    }
  }

  return false ;
}


void SourceFiles::createSourceFileLast()
{
  if (!theRootNode->executeResultlessQuery("drop table if exists sourcefilelast"))
  {
    // Error droping table - possibly index - therefore delete all contents
    theRootNode->executeResultlessQuery("delete from sourcefilelast") ;
  }
  else
  {
    theRootNode->executeResultlessQuery("create table if not exists sourcefilelast (srlID int AUTO_INCREMENT not null, srlName varchar(255) binary not null, srlLastMod int unsigned not null, primary key (srlID), unique index(srlID))") ;
  }
}


void SourceFiles::buildDeltaTables()
{
  // -- MATCHED ------------------------

  if (!theRootNode->executeResultlessQuery("drop table if exists sourcefilematch"))
  {
    // Error droping table - possibly index - therefore delete all contents
    theRootNode->executeResultlessQuery("delete from sourcefilematch") ;
  }
  else
  {
    theRootNode->executeResultlessQuery("create table if not exists sourcefilematch (srlID int not null, srmName varchar(255) binary not null, srlLastMod int unsigned not null, srmDone int not null, primary key (srlID), unique index(srlID))") ;
  }

  theRootNode->executeResultlessQuery("insert sourcefilematch select srlID, srfname, srlLastMod, 0 from sourcefile f inner join sourcefilelast l on srfname=srlname") ;

  if (theRootNode->executeQuery("select count(*) as RecordCount from sourcefilematch"))
  {
    theMatchCount = theRootNode->longCell(0,0) ;
  }


  // -- DELETED ------------------------

  if (!theRootNode->executeResultlessQuery("drop table if exists sourcefiledel"))
  {
    // Error droping table - possibly index - therefore delete all contents
    theRootNode->executeResultlessQuery("delete from sourcefiledel") ;
  }
  else
  {
    theRootNode->executeResultlessQuery("create table if not exists sourcefiledel (srdName varchar(255) binary not null, primary key (srdName), unique index(srdName))") ;
  }

  theRootNode->executeResultlessQuery("Insert sourcefiledel select srlname from sourcefile f RIGHT outer join sourcefilelast l on srfname=srlname where srfname is null") ;

  if (theRootNode->executeQuery("select count(*) as RecordCount from sourcefiledel"))
  {
    theDelCount = theRootNode->longCell(0,0) ;
  }


  // -- NEW -------------------------------

  if (!theRootNode->executeResultlessQuery("drop table if exists sourcefilenew"))
  {
    // Error droping table - possibly index - therefore delete all contents
    theRootNode->executeResultlessQuery("delete from sourcefilenew") ;
  }
  else
  {
    theRootNode->executeResultlessQuery("create table if not exists sourcefilenew (srnName varchar(255) binary not null, primary key (srnName), unique index(srnName))") ;
  }

  theRootNode->executeResultlessQuery("insert sourcefilenew select srfname from sourcefile f LEFT outer join sourcefilelast l on srfname=srlname where srlname is null") ;

  if (theRootNode->executeQuery("select count(*) as RecordCount from sourcefilenew"))
  {
    theNewCount = theRootNode->longCell(0,0) ;
  }
}


void SourceFiles::checkMatchedFiles()
{
  if (theMatchCount == 0) return ; // no files to check

  theChgCount = 0 ;

  while (theRootNode->executeQuery("select srlID, srmName, srlLastMod from sourcefilematch where srmDone=0 limit 50"))
  {
    int r=theRootNode->rows() ;
    char delSql[1024], updateSql[1024], charNumber[30] ;
    vector<SourceFile> files ;

    strcpy_s(delSql,1024, "delete from sourcefilelast where srlID in (") ;
    strcpy_s(updateSql,1024, "update sourcefilematch set srmDone=1 where srlID in (") ;

    for(int i=0; i<r; i++)
    {
      SourceFile currFile(theRootNode->longCell(i,0),
              theRootNode->cell(i,1),
              theRootNode->longCell(i,2)) ;

      if (currFile.hasChanged())
      {
        MasterData::theLog << currFile.getFilename() << " has changed." << endl ;

        theChgCount++ ;

        strcat_s(delSql,1024, ltostr(currFile.getID(), charNumber, 30)) ;
        strcat_s(delSql,1024, ",") ;

        files.push_back(currFile) ;
      }

      strcat_s(updateSql,1024, ltostr(currFile.getID(), charNumber, 30)) ;
      strcat_s(updateSql,1024, ",") ;
    }

    if (r > 0)
    {
      char sql[512] ;

      updateSql[strlen(updateSql)-1] = ')' ;  // Replace last commas
      delSql[strlen(delSql)-1] = ')' ;    //  with closing bracket
      theRootNode->executeResultlessQuery(updateSql) ;
      theRootNode->executeResultlessQuery(delSql) ;

      for(unsigned int j=0; j<files.size(); j++)
      {
        theRootNode->executeResultlessQuery(files[j].insertNew(sql)) ;
        theRootNode->executeResultlessQuery(files[j].insertDel(sql)) ;
      }
    }
  }
}


void SourceFiles::copyGuiToLast()
{
  theRootNode->executeResultlessQuery("insert sourcefilelast (srlName, srlLastMod) select srfName,0 from sourcefile") ;
}


void SourceFiles::copyNewToLast()
{
  theRootNode->executeResultlessQuery("insert sourcefilelast (srlName, srlLastMod) select srnName,0 from sourcefilenew") ;
}


void SourceFiles::updateLastModTimes()
{
  while (theRootNode->executeQuery("select srlID, srlName from sourcefilelast where srlLastMod=0 limit 100"))
  {
    vector<SourceFile> files ;
    unsigned int r=theRootNode->rows() ;
    char sql[512] ;

    unsigned int i ;
    for(i=0; i<r; i++)
    {
      SourceFile newfile(theRootNode->longCell(i,0),
        theRootNode->cell(i,1), 0) ;

      files.push_back(newfile) ;
    }

    for(i=0; i < files.size(); i++)
    {
      theRootNode->executeResultlessQuery(files[i].update(sql)) ;
    }
  }
}

bool SourceFiles::getNext(string &sourceFile)
{
  if ((theCount == 0) || (theCurrent >= theCount) || (theRootNode == NULL)) return false ;

  char sql[1024] ;

  switch (theTable)
  {
  case SOURCE_GUI:
    strcpy_s(sql,1024, SOURCE_GUI_SQL) ;
    break ;
  case SOURCE_DEL:
    strcpy_s(sql,1024, SOURCE_DEL_SQL) ;
    break ;
  case SOURCE_NEW:
    strcpy_s(sql,1024, SOURCE_NEW_SQL) ;
    break ;
  }

  char charNumber[30] ;

  strcat_s(sql,1024, ltostr(theCurrent, charNumber, 30)) ;
  strcat_s(sql,1024, ",1") ;

  try
  {
    if (theRootNode->executeQuery(sql))
    {
      sourceFile = theRootNode->cell(0,0) ;
      theCurrent++ ;
      return true ;
    }
  }
  catch (...)
  {
    MasterData::theLog << "Failed executing SourceFiles::getNext query" << endl ;
  }

  return false ;
}


void SourceFiles::removeFiles()
{
  if ((theDelCount+theChgCount) > 0)
  {
    if (theRootNode->executeQuery("select symID from sourcefiledel inner join symbol on srdName=symName"))
    {
      int r=theRootNode->rows() ;

      for(int i=0; i<r; i++)
      {
        theKiller.add(theRootNode->longCell(i,0)) ;
      }
    }
  }

  theKiller.flush() ;
}
