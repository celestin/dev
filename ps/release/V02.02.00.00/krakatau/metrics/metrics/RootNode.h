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

#ifndef METRICS_ROOTNODE
#define METRICS_ROOTNODE

#include "SymbolNode.h"
#include "Buffer.h"
#include "TreeHelper.h"

#include "MasterData.h"

namespace metrics
{

  class RootNode : public SymbolNode, public TreeHelper
  {
  private:
    bool actualRoot ;
    bool committing ;
    bool theFreshBuild ;    // True=Fresh Build, False=Adding to an existing tree

  protected:

  public:

    // Housekeeping
    Buffer theTempBuffer ;

    RootNode() ;
    RootNode(std::string newName, long newCatID) ;
    virtual ~RootNode() ;

    RootNode(const RootNode& rhs) ;
    RootNode& operator=(const RootNode& rhs) ;

    virtual bool isRoot()   {
      return true ;
    }

    void commit ()
    {
      committing = true ;
      Cache::commit() ;
      flushWriteSymbol() ;
      flushDeleteSymbol() ;
      committing = false ;
    }

    int getProgress() {
      if (committing)
        return Cache::getProgress() ;
      else
        return 100 ;
    }

    SymbolNode createSymbolNode()
    {
      SymbolNode retval(this) ;
      return retval ;
    }

    SymbolNode createSymbolNode(long newCatID)
    {
      SymbolNode retval(this,newCatID) ;
      return retval ;
    }

    SymbolNode createSymbolNode(std::string newName, long newCatID)
    {
      SymbolNode retval(this,newName,newCatID) ;
      return retval ;
    }

    void setFreshBuild(bool newFreshBuild) ;
    bool isFreshBuild() { return theFreshBuild ; }

    void flushBuffers()
    {
      theTempBuffer.commit() ;
    }
  } ;
} ;

#endif
