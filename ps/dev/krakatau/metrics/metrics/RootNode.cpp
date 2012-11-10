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
#include <queue>
using namespace std;

#include "MasterData.h"
#include "RootNode.h"
using namespace metrics;

RootNode::RootNode() : SymbolNode(), TreeHelper(), theTempBuffer(this,1000,true)
{
  theParentID = -1;

  // Reset Symbols autonumber
  long nextID = getNextID("symbol","symID");

  if (nextID<2)
  {
    reset(2);
  }
  else
  {
    reset(nextID);
  }

  // Reset Links autonumber
  nextID = getNextID("link","lnkID");

  if (nextID<1)
  {
    reset(1);
  }
  else
  {
    reset(nextID);
  }

  theDirty = true;

  theMetrics = NULL;
  theMetricsDirty = NULL;

  theAdded = true;
  actualRoot = false;
  committing = false;

  Cache::add(theID,this);

  setAdded(true);
}


RootNode::RootNode(std::string newName, long newCatID):
  TreeHelper(newName), SymbolNode(),
  theTempBuffer(this,1000,true)
{
  connect();

  theParentID = -1;

  theID = newID();

  theName = newName;
  theCatID = newCatID;

  theTreeHelper = this;

  theMetrics = NULL;
  theMetricsDirty = NULL;

  theAdded = true;
  actualRoot = true;
  committing = false;
  theIsRoot = true;

  Cache::add(theID,this);

  theDirty = true;
  setAdded(true);
}


RootNode::RootNode(const RootNode& rhs)
{
  theAdded = true;
  actualRoot = false;
  committing = false;

  theIsRoot = true;

  theMetrics = rhs.theMetrics;
  theMetricsDirty = rhs.theMetricsDirty;

  theID = rhs.theID;
  theActual = rhs.theActual;

  theDirty = rhs.theDirty;

  theTempBuffer = rhs.theTempBuffer;
}


RootNode& RootNode::operator=(const RootNode& rhs)
{
  theAdded = true;
  actualRoot = false;
  committing = false;

  theIsRoot = true;

  theMetrics = rhs.theMetrics;
  theMetricsDirty = rhs.theMetricsDirty;

  theID = rhs.theID;
  theActual = rhs.theActual;

  theDirty = rhs.theDirty;

  theTempBuffer = rhs.theTempBuffer;

  return (*this);
}


RootNode::~RootNode()
{
  if (actualRoot)
  {
    write();

    try
    {
      Cache::flush();
      flushDeleteSymbol();
      disconnect();

    } catch (...)
    {
      MasterData::theLog << "error when flushing" << endl;
    }
  }
}


void RootNode::setFreshBuild(bool newFreshBuild)
{
  theFreshBuild = newFreshBuild;
  long nextID = 2;

  if (theFreshBuild)
  {
    recreateDatabase();
  }
  else
  {
    nextID = getNextID("symbol","symID");
  }

  reset(nextID);
}
