/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * CAM  22-Jan-08  341 : Corrected SQL to return child types, and ensure we don't return types like the parent class.
 * CAM  02-Apr-08  339 : Corrected deprecation warnings.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <string>
#include <iostream>
#include <stdlib.h>
using namespace std ;

#include "SymbolNode.h"
using namespace metrics ;

// Prevent compiler errors and improve performance
// when checking theMetricsDirty
const char SymbolNode::MET_DIRTY_TRUE = 1 ;
const char SymbolNode::MET_DIRTY_FALSE = 0 ;

int counter = 0 ;

SymbolNode::SymbolNode(long newID, long newParentID, vector<long> newChildren) :
  theName(""), theLinks(newID)
{
  theID = newID ;
  theParentID = newParentID ;
  theChildren = newChildren ;

  theTypeID = 0 ;
  theCatID = 0 ;
  theProtectionID = 0 ;

  theDirty = true ;
  theFirstTime = true ;
  theWritten = false ;

  theAdded = true ;
  theActual = true ;

  theIsRoot = false ;

  // Initialise Metrics
  theMetrics = NULL ;     // Value array
  theMetricsDirty = NULL ;  // Dirty array
}


SymbolNode::SymbolNode(long newID, bool unused) :
  theName("") , theChildren(), theLinks(newID)
{
  theID = newID ;
  theParentID = 0 ;

  theAdded = false ;
  theActual = true ;

  theTypeID = 0 ;
  theCatID = 0 ;
  theProtectionID = 0 ;

  theDirty = true ;
  theFirstTime = true ;
  theWritten = false ;

  theIsRoot = false ;
  theChildren.clear() ;

  // Initialise Metrics
  theMetrics = NULL ;     // Value array
  theMetricsDirty = NULL ;  // Dirty array
}


SymbolNode::~SymbolNode()
{
  if (isRoot()) return ;

  if (theActual)
  {
    // TODO We should handle situation when the actual is deleted but
    // references still exist

    if (!theAdded)
    {
      erase() ;
    }

    // Delete Metrics value & dirty arrays
    if (theMetrics) delete [] theMetrics ;
    if (theMetricsDirty) delete [] theMetricsDirty ;
  }
  else if (theID>0)
  {
    SymbolNode *actualNode = dynamic_cast<SymbolNode*> (theTreeHelper->get(theID)) ;

    if (actualNode)
    {
      actualNode->theNReferences-- ;

      if (actualNode->theNReferences<1 && !actualNode->theAdded)
      {
        // Remove the actual from the Cache (deleting it)
        theTreeHelper->remove(theID) ;
      }
    }
  }
}


SymbolNode *SymbolNode::getSymbolNode(long ID)
{
  SymbolNode *retval = dynamic_cast<SymbolNode*> (theTreeHelper->get(ID)) ;

  if (retval!=NULL)
    return retval ;

  retval = read(ID) ;

  return retval ;
}


bool SymbolNode::findSymbolNode(long ID, SymbolNode &ret)
{
  if (ID>0)
  {
    SymbolNode *retval = getSymbolNode(ID) ;

    if (retval == NULL)
      return false ;

    ret = (*retval) ;
    return true ;
  }

  return false ;
}


bool SymbolNode::findSymbolNodeFromTypeID(long sytID, SymbolNode &ret)
{
  long targetID = theTreeHelper->getSymbolID(sytID) ;

  if (targetID<1) return false ;

  return findSymbolNode(targetID,ret) ;

}



SymbolNode SymbolNode::getParent()
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  return (*getSymbolNode(actualNode->theParentID)) ;
}


SymbolNode SymbolNode::getChild(int i)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  return (*getSymbolNode(actualNode->theChildren[i])) ;
}


vector<long> SymbolNode::getChildren()
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  return actualNode->theChildren ;
}


vector<long> SymbolNode::sortChildren()
{
  SymbolNode *actualNode = getSymbolNode(theID) ;

  actualNode->theChildren.clear() ; // Clear current children

  char sql[1024] ;
  char charNumber[30] ;

  strcpy_s(sql,1024, "select symID from symbol where symParentID=") ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;
  strcat_s(sql,1024, " order by symName") ;

  if (theTreeHelper->executeQuery(string(sql)))
  {
    int r ;
    for(r = 0 ; r < theTreeHelper->rows(); r++)
    {
      actualNode->theChildren.push_back(theTreeHelper->longCell(r,0)) ;
    }
  }

  return actualNode->theChildren ;
}


int SymbolNode::childCount()
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  return actualNode->theChildren.size() ;
}


string SymbolNode::getName()
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  return actualNode->theName ;
}


void SymbolNode::setName(string newName)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->theName = newName ;
  actualNode->theDirty = true ;
}


long SymbolNode::getTypeID()
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  return actualNode->theTypeID ;
}


void SymbolNode::setTypeID(long newTypeID)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->theTypeID = newTypeID;
  actualNode->theDirty = true ;
}


long SymbolNode::getCategoryID()
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  return actualNode->theCatID ;
}


void SymbolNode::setCategoryID(long newCatID)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->theCatID = newCatID ;
  actualNode->theDirty = true ;
}


long SymbolNode::getParentID()
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  return actualNode->theParentID ;
}


void SymbolNode::setParentID(long newParentID)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->theParentID = newParentID ;
  actualNode->theDirty = true ;
}


void SymbolNode::setAdded(bool isAdded)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->theAdded = isAdded ;
  actualNode->theDirty = true ;
}


bool SymbolNode::getAdded()
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  return actualNode->theAdded ;
}


long SymbolNode::getProtectionID()
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  return actualNode->theProtectionID ;
}


void SymbolNode::setProtectionID(long newProtID)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->theProtectionID = newProtID ;
  actualNode->theDirty = true ;
}


void SymbolNode::addNode(SymbolNode &object)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;

  object.setParentID(theID) ;
  object.setAdded(true) ;

  long ID = object.getID() ;
  actualNode->theChildren.push_back(ID) ;
  theTreeHelper->incNodeCount() ;
}


void SymbolNode::erase()
{
  if (theWritten)
  {
    theTreeHelper->deleteSymbol(theID) ;
  }
}


void SymbolNode::removeChildren()
{
  if (!theActual) return ;

  for (unsigned int i=0; i<theChildren.size(); i++)
  {
    removeChild(i) ;
  }
}


void SymbolNode::removeChild(int i)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  SymbolNode* child = getSymbolNode(actualNode->theChildren[i]) ;

  // As this child node may still be in the cache, and it has been added,
  // it may later on be written out to the db -- set theAdded to false to
  // prevent this happening
  child->theAdded = false ;

  // Remove this from theChildren vector
  actualNode->theChildren.erase(actualNode->theChildren.begin() + i) ;

  // Delete children of this node,  to ensure the entire branch is removed
  child->removeChildren() ;

  // Decrement the Node Count
  theTreeHelper->decNodeCount() ;
}


void SymbolNode::removeChild(SymbolNode &object)
{
  long ID = object.getID() ;

  SymbolNode *actualNode = getSymbolNode(theID) ;

  vector<long>::iterator iter = actualNode->theChildren.begin() ;

  int i;
  for ( i=0 ; iter<actualNode->theChildren.end() ; i++ , iter++)
  {
    if ((*iter)==ID)
    {
      removeChild(i) ;
    }
  }
}


bool SymbolNode::graft(SymbolNode &newParent)
{
  // Locates this child within it's parent and removes it
  // Then add this child to the new parent

  // Get Parent Actual Node
  SymbolNode *currentParent = getSymbolNode(getParentID()) ;
  vector<long>::iterator iter ;

  for(iter = currentParent->theChildren.begin() ;
    iter < currentParent->theChildren.end() ; iter++)
  {
    if ((*iter) == theID)
    {
      // Remove from old parent
      currentParent->theChildren.erase(iter) ;

      // Set child's new parent
      setParentID(newParent.getID()) ;

      // Add to new parent
      SymbolNode *actualNode = getSymbolNode(newParent.getID()) ;
      actualNode->theChildren.push_back(theID) ;
      return true ;
    }
  }

  return false ;
}


// Add Link to correct vector
void SymbolNode::addLink(long toID, long lktID)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->theLinks.addLink(toID,lktID) ;
}


void SymbolNode::addLink(long lnkID, long toID, long lktID)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->theLinks.addLink(lnkID,toID,lktID) ;
}


vector<Link> SymbolNode::getLinks(long lktID)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  return actualNode->theLinks.getLinks(lktID) ;
}


int SymbolNode::countUniqueLinks(long lktID, long catID)
{
  // Query the database for a count of all unique links of a
  // particular type (lktID) from this symbol to symbols of
  // specified category (catID)
  int uniqueLinks = 0 ;

  char sql[1024] ;
  char charNumber[30] ;

  strcpy_s(sql,1024,"select count(distinct link.sym2ID) as uniquelinks from link inner join symbol on link.sym2ID=symbol.symid where link.symID=") ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;
  strcat_s(sql,1024, " and link.lktID=") ;
  strcat_s(sql,1024, ltostr(lktID, charNumber, 30)) ;
  strcat_s(sql,1024, " and symbol.catID=") ;
  strcat_s(sql,1024, ltostr(catID, charNumber, 30)) ;

  try
  {
    if (theTreeHelper->executeQuery(string(sql)))
    {
      // There should always be a result, even if it is zero
      uniqueLinks = theTreeHelper->longCell(0,0) ;
    }
  }
  catch (...)
  {
    MasterData::theLog << "SymbolNode::countUniqueLinks() - Error executing query!" << endl ;
  }

  return uniqueLinks ;
}


int SymbolNode::countLinks(long lktID)
{
  // Query the database for a count of all links of a
  // particular type (lktID) from this symbol
  int linksCount = 0 ;
  char sql[1024], charNumber[30] ;

  strcpy_s(sql,1024,"select count(sym2ID) as linksCount from link where symID=") ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;
  strcat_s(sql,1024," and lktID=") ;
  strcat_s(sql,1024, ltostr(lktID, charNumber, 30)) ;

  try
  {
    if (theTreeHelper->executeQuery(sql))
    {
      // There should always be a result, even if it is zero
      linksCount = theTreeHelper->longCell(0,0) ;
    }
  }
  catch (...)
  {
    MasterData::theLog << "SymbolNode::countLinks() - Error executing query!" << endl ;
  }

  return linksCount ;
}


list<long> &SymbolNode::getUniqueTypesOfChildren(long catID, long classID, list<long> &types)
{
  // Query the database for all Children of this node, with a specified
  // category (catID) and return a unique list of their types
  int uniqueLinks = 0;

  char sql[512];

  sprintf_s(sql, sizeof(char)*512,
    "select distinct symbol.sytID from symbol, symboltype where symbol.symParentID=%d and symbol.catID=%d and symbol.sytID = symboltype.sytID and symboltype.symID<>%d",
    theID, catID, classID);

  try
  {
    if (theTreeHelper->executeQuery(string(sql)))
    {
      // Read the results into the unique list
      for(int r = 0; r < theTreeHelper->rows(); r++)
      {
        types.push_back(theTreeHelper->longCell(r,0));
      }
    }
  }
  catch (...)
  {
    MasterData::theLog << "SymbolNode::getUniqueTypesOfChildren() - Error executing query!" << endl;
  }

  return types;
}


vector<int> &SymbolNode::getAttributeUsage(vector<int> &varUsage)
{
  // Count the number of references to distinct member variables
  // in all methods of this class.  The list returned is in
  // an arbitrary order - this is acceptable for the methods that
  // calculate metrics based on the data (i.e. calculate methods
  // do not concern themselves with which actual variable's usage
  // they are dealing, but just iterate through the vector performing
  // the calculation).
  char sql[1024], charNumber[30] ;

  strcpy_s(sql,1024,"select count(s2.symID) as varUsage from symbol s1 left outer join link lk on s1.symID = lk.symid left outer join symbol s2 on s2.symID = lk.sym2ID and s2.symParentID = s1.symParentID where s1.symParentID=") ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;
  strcat_s(sql,1024," and s1.catID=") ;
  strcat_s(sql,1024, ltostr(MasterData::FIELD_CAT, charNumber, 30)) ;
  strcat_s(sql,1024," and ( lk.lktID=") ;
  strcat_s(sql,1024, ltostr(MasterData::XREF_LINK, charNumber, 30)) ;
  strcat_s(sql,1024," or lk.lktID is null ) group by s1.symID") ;

  try
  {
    if (theTreeHelper->executeQuery(sql))
    {
      // Read the results into the vector
      int r ;
      for(r = 0 ; r < theTreeHelper->rows(); r++)
      {
        varUsage.push_back(theTreeHelper->longCell(r,0)) ;
      }
    }
  }
  catch (...)
  {
    MasterData::theLog << "SymbolNode::getMemVarUsage() - Error executing query!" << endl ;
  }

  return varUsage ;
}


int SymbolNode::getFieldUsage() {

  char sql[1024], charNumber[30] ;

  strcpy_s(sql,1024,"select count(s1.symid) as fieldUsage from symbol s1 inner join link lk on s1.symID = lk.symid inner join symbol s2 on s2.symID = lk.sym2ID where s1.symParentID=") ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;
  strcat_s(sql,1024," and s2.symParentID=") ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;
  strcat_s(sql,1024," and s2.catID=") ;
  strcat_s(sql,1024, ltostr(MasterData::FIELD_CAT, charNumber, 30)) ;

  try
  {
    if (theTreeHelper->executeQuery(sql))
    {
      return theTreeHelper->longCell(0,0) ;
    }
  }
  catch (...)
  {
    MasterData::theLog << "SymbolNode::getFieldUsage() - Error executing query!" << endl ;
  }

  return 0 ;
}


int SymbolNode::getAttributeUsage()
{
  // Count the distinct number of references to this member variable
  // within other members of the class
  char sql[1024], charNumber[30] ;

  strcpy_s(sql,1024,"Select count(distinct s2.symID) as varUsage from symbol s1 inner join link lk on s1.symID=lk.sym2ID inner join symbol s2 on s2.symID=lk.symID and s2.symParentID=s1.symParentID where s1.symID=") ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;
  strcat_s(sql,1024," and lk.lktID=") ;
  strcat_s(sql,1024, ltostr(MasterData::XREF_LINK, charNumber, 30)) ;

  try
  {
    if (theTreeHelper->executeQuery(sql))
    {
      return theTreeHelper->longCell(0,0) ;
    }
  }
  catch (...)
  {
    MasterData::theLog << "SymbolNode::getAttributeUsage() - Error executing query!" << endl ;
  }

  return 0 ;
}


int SymbolNode::getOperationUsage()
{
  // Count the number of references to this member function
  // from any other functions
  char sql[1024], charNumber[30] ;

  strcpy_s(sql,1024,"select count(s2.symID) as fnUsage from symbol s1 inner join link lk on s1.symID = lk.sym2id inner join symbol s2 on s2.symID = lk.symID where s1.symID=") ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;
  strcat_s(sql,1024," and lk.lktID=") ;
  strcat_s(sql,1024, ltostr(MasterData::XREF_LINK, charNumber, 30)) ;
  strcat_s(sql,1024," and s1.catID=") ;
  strcat_s(sql,1024, ltostr(MasterData::METHOD_CAT, charNumber, 30)) ;

  try
  {
    if (theTreeHelper->executeQuery(sql))
    {
      return theTreeHelper->longCell(0,0) ;
    }
  }
  catch (...)
  {
    MasterData::theLog << "SymbolNode::getOperationUsage() - Error executing query!" << endl ;
  }

  return 0 ;
}


string SymbolNode::formSqlInsert()
{
  char sql[1024] ;
  char charNumber[30] ;

  strcpy_s(sql,1024,"(") ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;
  strcat_s(sql,1024,",") ;
  strcat_s(sql,1024, ltostr(theParentID, charNumber, 30)) ;
  strcat_s(sql,1024,",") ;
  strcat_s(sql,1024, theName.c_str()) ;
  strcat_s(sql,1024, "',") ;
  strcat_s(sql,1024, ltostr(theTypeID, charNumber, 30)) ;
  strcat_s(sql,1024,",") ;
  strcat_s(sql,1024, ltostr(theCatID, charNumber, 30)) ;
  strcat_s(sql,1024,",") ;
  strcat_s(sql,1024, ltostr(theProtectionID, charNumber, 30)) ;
  strcat_s(sql,1024,")") ;

  return string(sql) ;
}


void SymbolNode::write()
{
  writeMetrics() ;
  theLinks.write(*theTreeHelper) ;

  if (theDirty)
  {
    theTreeHelper->writeSymbol(theID,theParentID,theName.c_str(),theTypeID,theCatID,theProtectionID) ;
  }
  else
  {
    return ;
  }

  theDirty = theFirstTime = false ;
  theWritten = true ;
}


SymbolNode *SymbolNode::find(SymbolNode *scope, long catID, string objName)
{
  if ( (scope->getCategoryID() == catID) && (!objName.compare(scope->getName())) )
  {
    // Success - found the node we are looking for
    return scope ;
  }

  else
  {
    // Search children
    for(unsigned int c=0; c<scope->theChildren.size(); c++)
    {
      SymbolNode *child = find(getSymbolNode(scope->theChildren[c]), catID, objName) ;
      if (child != NULL) return child ;
    }

    return NULL ;
  }
}


bool SymbolNode::find(long catID, string objName, SymbolNode &ret )
{
  SymbolNode *retval = find(getSymbolNode(theID),catID,objName) ;

  if (retval == NULL)
  {
    return false ;
  }

  ret = (*retval) ;
  return true ;
}


void SymbolNode::read()
{
  theTreeHelper->flushWriteSymbol() ;
  char sql[1024] ;
  strcpy_s(sql,1024,"Select symParentID,symName,sytID,catID,prtID From symbol Where symID=") ;

  char charNumber[30] ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;

  if (theTreeHelper->executeQuery(sql))
  {
    theParentID =     theTreeHelper->longCell(0,0) ;
    theName =         theTreeHelper->cell(0,1) ;
    theTypeID =       theTreeHelper->longCell(0,2) ;
    theCatID =        theTreeHelper->longCell(0,3) ;
    theProtectionID = theTreeHelper->longCell(0,4) ;

    theLinks.readLinks(*theTreeHelper) ;

    readMetrics() ;
    theDirty = theFirstTime = false ;
  }
}


SymbolNode *SymbolNode::read(long ID)
{
  theTreeHelper->flushWriteSymbol() ;

  long myParentID = -1 ;
  long myChildCount = -1 ;
  vector<long> myChildren ;

  try
  {
    // Get this Node
    char sql[1024], charNumber[30] ;

    strcpy_s(sql,1024,"Select symParentID From symbol Where symID=") ;
    strcat_s(sql,1024, ltostr(ID, charNumber, 30)) ;

    if (theTreeHelper->executeQuery(sql))
    {
      myParentID = theTreeHelper->longCell(0,0) ;
    }

    // Retreive this Node's children
    strcpy_s(sql,1024,"Select symID From symbol Where symParentID=") ;
    strcat_s(sql,1024, ltostr(ID, charNumber, 30)) ;

    if (theTreeHelper->executeQuery(sql))
    {
      for (int i=0 ; i<theTreeHelper->rows() ; i++ )
      {
        myChildren.push_back(theTreeHelper->longCell(i,0)) ;
      }
    }
  }
  catch (...)
  {
    MasterData::theLog << "*SymbolNode::read() - Error executing query!" << endl ;
  }

  SymbolNode *retval = new SymbolNode(ID,myParentID,myChildren) ;
  retval->theTreeHelper = theTreeHelper ;

  retval->read() ;
  //theCache.add(retval->getID(),retval) ;
  theTreeHelper->add(retval->getID(),retval) ;

  return retval ;
}


void SymbolNode::checkMetrics()
{
  if (theMetrics == NULL)
  {
    int maxID = MasterData::getMaxMetricTypeID(theCatID) ;
    theMetrics = new float[maxID] ;

    int c ;
    for(c = 0; c < maxID; c++)
    {
      theMetrics[c] = 0 ;
    }

    clearMetricsDirty() ;

    if (theCatID == MasterData::METHOD_CAT)
    {
      theMetrics[MasterData::CYCLO_MET] = 1 ;
      theMetrics[MasterData::EVG_MET] = 1 ;
      theMetrics[MasterData::NION_MET] = 1 ;
      theMetrics[MasterData::ANION_MET] = 1 ;

      theMetricsDirty[MasterData::CYCLO_MET] = MET_DIRTY_TRUE ;
      theMetricsDirty[MasterData::EVG_MET] = MET_DIRTY_TRUE ;
      theMetricsDirty[MasterData::NION_MET] = MET_DIRTY_TRUE ;
      theMetricsDirty[MasterData::ANION_MET] = MET_DIRTY_TRUE ;
      theMetricsDirty[MasterData::CONTROL_MET] = MET_DIRTY_TRUE ;
      theMetricsDirty[MasterData::EXECUTABLE_MET] = MET_DIRTY_TRUE ;
      theMetricsDirty[MasterData::NEST_MET] = MET_DIRTY_TRUE ;
      theMetricsDirty[MasterData::BRANCH_MET] = MET_DIRTY_TRUE ;
      theMetricsDirty[MasterData::OC_MET] = MET_DIRTY_TRUE ;
    }

  }
}


void SymbolNode::clearMetricsDirty()
{
  int c ;
  int maxID = MasterData::getMaxMetricTypeID(theCatID) ;
  if (theMetricsDirty == NULL) theMetricsDirty = new char[maxID] ;

  for(c = 0; c < maxID; c++)
  {
    theMetricsDirty[c] = MET_DIRTY_FALSE ;
  }
}


float SymbolNode::getMetric(long mttID)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->checkMetrics() ;
  return actualNode->theMetrics[mttID] ;
}


vector<float> SymbolNode::getMetrics()
{
  vector<float> metrics ;
  SymbolNode *actualNode = getSymbolNode(theID) ;
  if (actualNode->theMetrics == NULL) return metrics ;

  int c ;
  int maxID = MasterData::getMaxMetricTypeID(actualNode->theCatID) ;
  for(c = 0; c<maxID ; c++)
  {
    metrics.push_back(actualNode->theMetrics[c]) ;
  }

  return metrics ;
}


void SymbolNode::getMetrics(float *&metrics)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;

  if (actualNode->theMetrics == NULL)
  {
    metrics = NULL ;
    return ;
  }

  int maxID = MasterData::getMaxMetricTypeID(actualNode->theCatID) ;
  metrics = new float[maxID] ;

  int c ;
  for(c = 0; c < maxID; c++)
  {
    metrics[c] = actualNode->theMetrics[c] ;
  }
}


void SymbolNode::setMetric(long mttID, float newValue)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->checkMetrics() ;
  actualNode->theMetrics[mttID] = newValue ;
  actualNode->theMetricsDirty[mttID] = MET_DIRTY_TRUE ;
}


void SymbolNode::incMetric(long mttID, float incAmount)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->checkMetrics() ;
  actualNode->theMetrics[mttID] += incAmount ;
  actualNode->theMetricsDirty[mttID] = MET_DIRTY_TRUE ;
}


void SymbolNode::decMetric(long mttID, float decAmount)
{
  SymbolNode *actualNode = getSymbolNode(theID) ;
  actualNode->checkMetrics() ;
  actualNode->theMetrics[mttID] -= decAmount ;
  actualNode->theMetricsDirty[mttID] = MET_DIRTY_TRUE ;
}


void SymbolNode::writeMetrics()
{
  string del, ins ;
  int mttID ;
  bool proceed = false ;

  checkMetrics() ;

  char sql[QUERY_MAX] ;
  char charNumber[30] ;

  strcpy_s(sql,QUERY_MAX,"Replace Into metric Values (") ;

  int maxID = MasterData::getMaxMetricTypeID(theCatID) ;
  for(mttID = 1; mttID<maxID; mttID++)
  {
    if (theMetricsDirty[mttID] == MET_DIRTY_TRUE)
    {
      proceed = true ;

      strcat_s(sql,QUERY_MAX, ltostr(theID, charNumber, 30)) ;
      strcat_s(sql,QUERY_MAX,",") ;

      strcat_s(sql,QUERY_MAX, ltostr(MasterData::codeMtt(mttID,theCatID), charNumber, 30)) ;
      strcat_s(sql,QUERY_MAX,",") ;

      strcat_s(sql,QUERY_MAX,dtoa(theMetrics[mttID], charNumber, 30)) ;
      strcat_s(sql,QUERY_MAX,"),(") ;

      theMetricsDirty[mttID] = MET_DIRTY_FALSE ;
    }
  }

  if (proceed)
  {
    try
    {
      sql[strlen(sql)-2] = '\0' ;  // chop off last ",("
      theTreeHelper->executeResultlessQuery(sql) ;
    }
    catch (...)
    {
      MasterData::theLog << "SymbolNode::writeMetrics()" << endl ;
    }
  }
}


void SymbolNode::readMetrics()
{
  char sql[1024], charNumber[30] ;

  strcpy_s(sql,1024,"SELECT mttID, metValue FROM metric WHERE symID=") ;
  strcat_s(sql,1024, ltostr(theID, charNumber, 30)) ;

  if (theTreeHelper->executeQuery(sql))
  {
    checkMetrics() ;
    clearMetricsDirty() ;
    int i ;
    for (i=0 ; i<theTreeHelper->rows() ; i++)
    {
      long mttID = MasterData::decodeMtt(theTreeHelper->longCell(i,0)) ;
      float newValue = (float)theTreeHelper->doubleCell(i,1) ;

      theMetrics[mttID] = newValue ;
      theMetricsDirty[mttID] = MET_DIRTY_FALSE ;
    }
  }
}


bool SymbolNode::hasSubclass(SymbolNode &classNode)
{
  // Does this class contain classNode in its subclass heirarchy
  // Called on: Class nodes

  vector<Link> subclasses = getLinks(MasterData::SUB_LINK) ;
  unsigned int i ;

  for (i=0 ; i < subclasses.size() ; i++)
  {
    SymbolNode subclass ;
    if (findSymbolNode(subclasses[i].getDestID(), subclass))
    {
      if (classNode.getID() == subclass.getID())
        return true ;

      if (subclass.hasSubclass(classNode))
        return true ; // Search deeper down
    }
  }

  return false ;
}


int SymbolNode::countSubclasses()
{
  vector<Link> subclasses = getLinks(MasterData::SUB_LINK) ;
  int retval = subclasses.size() ;
  SymbolNode subclass ;

  unsigned int i ;
  for( i = 0 ; i < subclasses.size() ; i++)
  {
    if (findSymbolNode(subclasses[i].getDestID(), subclass))
    {
      retval += subclass.countSubclasses() ;
    }
  }

  return retval ;
}


bool SymbolNode::isVisible(SymbolNode &classNode)
{
  // Is this method/field node visible to classNode?
  // Called on: Method & field nodes

  if ((getCategoryID() != MasterData::METHOD_CAT) &&
    (getCategoryID() != MasterData::FIELD_CAT))
    return false ;

  long protection = getProtectionID() ;

  if (protection == MasterData::PUBLIC_PROT)
  {
    // Public members are visible
    return true ;
  }
  else if (protection == MasterData::PROTECTED_PROT)
  {
    // Protected members visible to subclasses and class
    if (getParentID() == classNode.getID()) return true ;

    SymbolNode parent ;
    if (findSymbolNode(getParentID(), parent))
    {
      if (parent.hasSubclass(classNode)) return true ;
    }
  }
  else if (protection == MasterData::PRIVATE_PROT)
  {
    // Private members only (usually) visible within class
    if (getParentID() == classNode.getID()) return true ;
  }
  else
  {
    // should never happen for C/C++
  }

  return false ;
}
