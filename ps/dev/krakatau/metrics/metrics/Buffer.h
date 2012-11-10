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
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef METRICS_BUFFER
#define METRICS_BUFFER

#include <vector>

#include "OurSQL.h"
#include "DataRow.h"

namespace metrics
{
  class Buffer
  {
  private:
    std::vector<DataRow*> theBuffer ;     // Vector of DataRows
    unsigned long theLimit ;            // No. of DataRows to hold
                      // before committing
    bool theSingleCommit ;

  protected:

    OurSQL *theConnection ;

  public:
    Buffer()
    {
      theLimit = 100 ;
      theSingleCommit = false ;
    }
    Buffer(OurSQL *newConnection)
    {
      theConnection = newConnection ;
      theLimit = 100 ;
      theSingleCommit = false ;
    }
    Buffer(OurSQL *newConnection,long newLimit)
    {
      theConnection = newConnection ;
      theLimit = newLimit ;
      theSingleCommit = false ;
    }
    Buffer(OurSQL *newConnection,long newLimit, bool newSingleCommit)
    {
      theConnection = newConnection ;
      theLimit = newLimit ;
      theSingleCommit = newSingleCommit ;
    }
    virtual ~Buffer() ;
    Buffer(const Buffer& rhs) ;
    const Buffer& operator=(const Buffer& rhs) ;

    long getLimit() { return theLimit ; }
    void setLimit(long newLimit) { theLimit = newLimit ; }

    void setConnection(OurSQL *newConnection)
    {
      theConnection = newConnection ;
    }

    //void add(Link newLink) ;
    void add(DataRow *newDataRow) ;
    void commit() ;

  } ;
} ;

#endif
