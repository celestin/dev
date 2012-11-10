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

#ifndef METRICS_SYMBOLCOMP
#define METRICS_SYMBOLCOMP

#include <string>

#include "DataRow.h"
#include "MasterData.h"

#define COMPS_PER_SELECT 1000

namespace metrics
{
  class SymbolComp : public DataRow
  {
  private:

    long theSymID ;
    //long theSym2ID ;
    long theStatus ;

  protected:

  public:

    SymbolComp()
    {
      theSymID = 0 ;
      //theSym2ID = 0 ;
      theStatus = 0 ;
    }

    SymbolComp(long newSymID, /*long newSym2ID,*/ long newStatus)
    {
      theSymID = newSymID ;
      //theSym2ID = newSym2ID ;
      theStatus = newStatus ;
    }

    virtual ~SymbolComp() {;}

    void write() {;}
    void read() {;}

    void getStatement(char *sql)
    {
      strcpy_s(sql, QUERY_MAX, "REPLACE INTO symbolcomp VALUES ") ;
    }

    void getValues(char *sql)
    {
      char charNumber[30] ;

      strcat_s(sql, QUERY_MAX,"(") ;
      strcat_s(sql, QUERY_MAX, ltostr(theSymID, charNumber, 30)) ;
      strcat_s(sql, QUERY_MAX,",") ;
      strcat_s(sql, QUERY_MAX, ltostr(theStatus, charNumber, 30)) ;
      strcat_s(sql, QUERY_MAX,")") ;
    }
  } ;


  class SymbolDel : public DataRow
  {
  private:

    long theSymID ;
    long theParentID ;
    long theNewParentID ;
    std::string theName ;
    long theTypeID ;
    long theCatID ;
    long theProtectionID ;


  protected:

  public:

    SymbolDel() : theName("")
    {
      theSymID = 0 ;
      theParentID = 0 ;
      theNewParentID = 0 ;
      theTypeID = 0 ;
      theCatID = 0 ;
      theProtectionID = 0 ;
    }

    SymbolDel(long newSymID, long newParentID, long newNewParentID, std::string newName,
      long newTypeID, long newCatID, long newProtID) : theName(newName)
    {
      theSymID = newSymID ;
      theParentID = newParentID ;
      theNewParentID = newNewParentID ;
      theTypeID = newTypeID ;
      theCatID = newCatID ;
      theProtectionID = newProtID ;
    }

    virtual ~SymbolDel() {;}

    void write() {;}
    void read() {;}

    void getStatement(char *sql)
    {
      strcpy_s(sql, QUERY_MAX, "REPLACE INTO symboldel VALUES ") ;
    }

    void getValues(char *sql)
    {
      char charNumber[30] ;

      strcat_s(sql, QUERY_MAX,"(") ;
      strcat_s(sql, QUERY_MAX, ltostr(theSymID, charNumber, 30)) ;
      strcat_s(sql, QUERY_MAX,",") ;
      strcat_s(sql, QUERY_MAX, ltostr(theParentID, charNumber, 30)) ;
      strcat_s(sql, QUERY_MAX,",") ;
      strcat_s(sql, QUERY_MAX, ltostr(theNewParentID, charNumber, 30)) ;
      strcat_s(sql, QUERY_MAX,",'") ;
      strcat_s(sql, QUERY_MAX, theName.c_str()) ;
      strcat_s(sql, QUERY_MAX, "',") ;
      strcat_s(sql, QUERY_MAX, charNumber) ;
      strcat_s(sql, QUERY_MAX, ltostr(theTypeID, charNumber, 30)) ;
      strcat_s(sql, QUERY_MAX,",") ;
      strcat_s(sql, QUERY_MAX, ltostr(theCatID, charNumber, 30)) ;
      strcat_s(sql, QUERY_MAX,",") ;
      strcat_s(sql, QUERY_MAX, ltostr(theProtectionID, charNumber, 30)) ;
      strcat_s(sql, QUERY_MAX,")") ;
    }
  } ;


  class MetricComp : public DataRow
  {
  private:

    long theSymID ;
    long theMttID ;
    float theMetvalue ;

  protected:

  public:

    MetricComp()
    {
      theSymID = 0 ;
      theMttID = 0 ;
      theMetvalue = 0 ;
    }

    MetricComp(long newSymID, long newMttID, float newMetvalue)
    {
      theSymID = newSymID ;
      theMttID = newMttID ;
      theMetvalue = newMetvalue ;
    }

    virtual ~MetricComp() {;}

    void write() {;}
    void read() {;}

    void getStatement(char *sql)
    {
      strcpy_s(sql, QUERY_MAX, "REPLACE INTO metriccomp VALUES ") ;
    }

    void getValues(char *sql)
    {
      char charNumber[30] ;

      strcat_s(sql, QUERY_MAX,"(") ;
      strcat_s(sql, QUERY_MAX, ltostr(theSymID, charNumber, 30)) ;
      strcat_s(sql, QUERY_MAX,",") ;
      strcat_s(sql, QUERY_MAX, ltostr(theMttID, charNumber, 30)) ;
      strcat_s(sql, QUERY_MAX,",") ;
      strcat_s(sql, QUERY_MAX,dtoa(theMetvalue, charNumber, 30)) ;
      strcat_s(sql, QUERY_MAX,")") ;
    }
  };
};

#endif
