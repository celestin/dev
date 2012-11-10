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

#ifndef METRICS_TEMPLINK
#define METRICS_TEMPLINK

#include <list>
#include <string>
#include <vector>

#include "AutoNumber.h"
#include "DataRow.h"
#include "MasterData.h"
#include "OurSQL.h"

#define SYMBOLS_PER_SELECT 1000

namespace metrics
{
  typedef std::vector<long> LongVect ;
  typedef std::vector<long>::iterator LongVectIter ;

  class TempLink : public DataRow
  {
  private:
    static AutoNumber theHeaderNum ;
    static AutoNumber theDetailNum ;

    long theID ;      // TempLink ID (tlkID)
    long theSymID ;     // Corresponding Symbol ID
    long theLktID ;     // Link Type
    std::string theRef ;  // Ref (or Name)
    bool theParms ;     // Flag: Has Parameters?
    LongVect theTypes ;   // Vector of Parameter types
    bool theWritten ;   // Flag: Been Written?

  protected:

  public:

    TempLink() : theRef("")
    {
      theID = 0 ;
      theSymID = 0 ;
      theLktID = 0 ;
      theParms = false ;
      theWritten = false ;
      theTypes.clear() ;
    }

    TempLink(long symID, long lktID, std::string ref)
    {
      theID = 0 ;
      theSymID = symID ;
      theLktID = lktID ;
      theRef = ref ;
      theParms = false ;
      theWritten = false ;
      theTypes.clear() ;
    }


    TempLink(long symID)
    {
      theSymID = symID ;
      theTypes.clear() ;

      read() ;
    }


    TempLink(long tlkID, long symID, long lktID, std::string ref, bool parms)
    {
      theID = tlkID ;
      theSymID = symID ;
      theLktID = lktID ;
      theRef = ref ;
      theParms = parms ;
      theWritten = true ;
      theTypes.clear() ;
    }


    virtual ~TempLink() ;

    bool operator==(TempLink &rhs) { return (!theRef.compare(rhs.theRef)) ; }
    bool operator<(TempLink &rhs) { return (theRef.compare(rhs.theRef)<=0) ; }
    bool operator>(TempLink &rhs) { return (theRef.compare(rhs.theRef)>0) ; }

    long getID()          { return theID ; }
    void setSymID(long newSymID)  { theSymID = newSymID; }
    long getSymID()         { return theSymID ; }
    void setTypeID(long newLktID) { theLktID = newLktID; }
    long getTypeID()        { return theLktID ; }
    void setRef(std::string newRef) { theRef = newRef ; }
    std::string getRef()      { return theRef ; }
    bool hasParms()         { return theParms ; }

    void addType(long lktID) ;
    LongVect getTypes() ;

    void write() ;
    void read() ;

    void getStatement(char *sql)
    {
      strcpy_s(sql,QUERY_MAX, "INSERT INTO templink VALUES ") ;
    }


    void getValues(char *sql)
    {
      //char sql[512] ;
      char charNumber[30] ;

      strcat_s(sql,QUERY_MAX,"(") ;

      strcat_s(sql,QUERY_MAX, ltostr(theHeaderNum.newID(), charNumber, 30)) ;
      strcat_s(sql,QUERY_MAX,",") ;

      strcat_s(sql,QUERY_MAX, ltostr(theSymID, charNumber, 30)) ;
      strcat_s(sql,QUERY_MAX,",") ;

      strcat_s(sql,QUERY_MAX, ltostr(theLktID, charNumber, 30)) ;
      strcat_s(sql,QUERY_MAX,",'") ;

      strcat_s(sql,QUERY_MAX, theRef.c_str()) ;
      strcat_s(sql,QUERY_MAX, "',") ;

      strcat_s(sql,QUERY_MAX, ltostr(theParms, charNumber, 30)) ;
      strcat_s(sql,QUERY_MAX,")") ;
    }

    static void resetIDs() ;

  } ;


  class TempLinks : public std::list<TempLink>
  {
  private:

  protected:

    long theSymID ;
    long theLktID ;
    void read(OurSQL&) ;

    std::vector<long> theIDs ;
    bool theSingle ;

  public:
    // Housekeeping
    TempLinks() { theSymID = 0 ; };
    TempLinks(OurSQL&, long, long) ;
    TempLinks(OurSQL&, std::vector<long>, long) ;
    virtual ~TempLinks() ;
  } ;

} ;

#endif
