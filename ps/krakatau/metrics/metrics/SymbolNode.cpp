/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <string>
#include <iostream>
#include <stdlib.h>
using namespace std ;

#include "SymbolNode.h"
using namespace metrics ;

//Cache SymbolNode::theCache(75011,5000) ;
//Cache SymbolNode::theCache(110017,5000) ;
//Cache SymbolNode::theCache(400009,2003) ;
//Cache SymbolNode::theCache(327317,5000) ;
//Cache SymbolNode::theCache(1511,503) ;
//Cache SymbolNode::theCache(101,20) ;
//Cache SymbolNode::theCache(10007,503) ;
//AutoNumber SymbolNode::theAutoNumber ;

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

	//theQNameLong = false ;

	theAdded = true ;
	theActual = true ;

	//OLD initLinks() ;

	theIsRoot = false ;

	// Initialise Metrics
	theMetrics = NULL ;			// Value array
	theMetricsDirty = NULL ;	// Dirty array
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

	//theQNameLong = false ;

	//OLD initLinks() ;

	theIsRoot = false ;
	theChildren.clear() ;

	// Initialise Metrics
	theMetrics = NULL ;			// Value array
	theMetricsDirty = NULL ;	// Dirty array
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
			//theAutoNumber.releaseID(theID) ;
			//theTreeHelper->releaseID(theID) ;
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
				//theCache.remove(theID) ;
				theTreeHelper->remove(theID) ;
			}
		}
	}
}


SymbolNode *SymbolNode::getSymbolNode(long ID)
{
	//SymbolNode *retval = dynamic_cast<SymbolNode*> (theCache.get(ID)) ;
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
/*
//	try
//	{
	MasterData::theLog << "findSymbolNodeFromTypeID(...) mark1" << endl ;
		SymbolNode *retval = getSymbolNode(ID) ;
//	}
//	catch (...)
//	{
//		// Exception when trying to find the SymbolNode so return false
//		return false ;
//	}

	long targetID = -1;
	char sql[512], charNumber[30] ;

	MasterData::theLog << "findSymbolNodeFromTypeID(...) mark2" << endl ;
	strcpy(sql,"select symID from symboltype where sytid=") ;
	strcat(sql, ltostr(ID, charNumber, 30)) ;

//	try {
	MasterData::theLog << "findSymbolNodeFromTypeID(...) mark3" << endl ;
		if (theTreeHelper->executeQuery(sql))
		{
	MasterData::theLog << "findSymbolNodeFromTypeID(...) mark4" << endl ;
			targetID = theTreeHelper->longCell(0,0) ;
		}
		else
		{
	MasterData::theLog << "findSymbolNodeFromTypeID(...) mark5" << endl ;
			return false ;
		}
//	}
//	catch (...)
//	{
//		return false ;
//	}
*/

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

	char sql[512] ;
	char charNumber[30] ;

	strcpy(sql, "select symID from symbol where symParentID=") ;
	//itoa(theID, charNumber, 10) ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;
	strcat(sql, " order by symName") ;

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

	for (int i=0 ; i<theChildren.size() ; i++)
	{
		removeChild(i) ;
	}
}


void SymbolNode::removeChild(int i)
{
	SymbolNode *actualNode = getSymbolNode(theID) ;
	/*SymbolNode *actualNode = this ;
	if (!theActual)
	{
		actualNode = getSymbolNode(theID) ;
	}*/

	SymbolNode* child = getSymbolNode(actualNode->theChildren[i]) ;

	// As this child node may still be in the cache, and it has been added,
	// it may later on be written out to the db -- set theAdded to false to
	// prevent this happening
	child->theAdded = false ;

	// Remove this from theChildren vector
	actualNode->theChildren.erase(actualNode->theChildren.begin() + i) ;

	// Delete children of this node,  to ensure the entire branch is removed
	child->removeChildren() ;

/*	// Remove from the cache - added 9/12/00 CAM
	//theCache.remove(child->getID()) ;
	theTreeHelper->remove(child->getID()) ;

	// Delete from the db if it has been written out
	child->erase() ;
*/
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

	char sql[512] ;
	char charNumber[30] ;

	strcpy(sql,"select count(distinct link.sym2ID) as uniquelinks from link inner join symbol on link.sym2ID=symbol.symid where link.symID=") ;

	//itoa(theID, charNumber, 10) ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;

	strcat(sql, " and link.lktID=") ;
	//itoa(lktID, charNumber, 10) ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(lktID, charNumber, 30)) ;

	strcat(sql, " and symbol.catID=") ;
	//itoa(catID, charNumber, 10) ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(catID, charNumber, 30)) ;

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
	char sql[512], charNumber[30] ;

	strcpy(sql,"select count(sym2ID) as linksCount from link where symID=") ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;
	strcat(sql," and lktID=") ;
	strcat(sql, ltostr(lktID, charNumber, 30)) ;

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


list<long> &SymbolNode::getUniqueTypesOfChildren(long catID, list<long> &types)
{
	// Query the database for all Children of this node, with a specified
	// category (catID) and return a unique list of their types
	int uniqueLinks = 0 ;

	char sql[512] ;
	char charNumber[30] ;

	strcpy(sql,"select distinct symbol.sytID from symbol where symbol.symParentID=") ;
	//itoa(theID, charNumber, 10) ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;

	strcat(sql, " and Symbol.catID=") ;
	//itoa(catID, charNumber, 10) ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(catID, charNumber, 30)) ;

	try
	{
		if (theTreeHelper->executeQuery(string(sql)))
		{
			// Read the results into the unique list
			int r ;
			for(r = 0 ; r < theTreeHelper->rows(); r++)
			{
				types.push_back(theTreeHelper->longCell(r,0)) ;
			}
		}
	}
	catch (...)
	{
		MasterData::theLog << "SymbolNode::getUniqueTypesOfChildren() - Error executing query!" << endl ;
	}

	return types ;
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
	char sql[512], charNumber[30] ;

	strcpy(sql,"select count(s2.symID) as varUsage from symbol s1 left outer join link lk on s1.symID = lk.symid left outer join symbol s2 on s2.symID = lk.sym2ID and s2.symParentID = s1.symParentID where s1.symParentID=") ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;
	strcat(sql," and s1.catID=") ;
	strcat(sql, ltostr(MasterData::FIELD_CAT, charNumber, 30)) ;
	strcat(sql," and ( lk.lktID=") ;
	strcat(sql, ltostr(MasterData::XREF_LINK, charNumber, 30)) ;
	strcat(sql," or lk.lktID is null ) group by s1.symID") ;

	//MasterData::theLog << "LOCM_SQL:" << sql << endl ;

	//	sql << "select count(s2.symID) as varUsage "
	//		<< "  from Symbol s1 "
	//		<< "  left outer join Link lk "
	//		<< "	on s1.symID = lk.symid "
	//		<< "  left outer join Symbol s2 "
	//		<< "	on s2.symID = lk.sym2ID "
	//		<< "   and s2.symParentID = s1.symParentID "
	//		<< " where s1.symParentID = " << theID
	//		<< "   and s1.catID = " << MasterData::FIELD_CAT
	//		<< "   and (    lk.lktID = " << MasterData::XREF_LINK
	//		<< "         or lk.lktID is null ) "
	//		<< " group by s1.symID " << flush ;

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

	char sql[512], charNumber[30] ;

	strcpy(sql,"select count(s1.symid) as fieldUsage from symbol s1 inner join link lk on s1.symID = lk.symid inner join symbol s2 on s2.symID = lk.sym2ID where s1.symParentID=") ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;
	strcat(sql," and s2.symParentID=") ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;
	strcat(sql," and s2.catID=") ;
	strcat(sql, ltostr(MasterData::FIELD_CAT, charNumber, 30)) ;

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
	char sql[512], charNumber[30] ;

	//	<< "Select count(distinct s2.symID) as varUsage "
	//	<< "  from Symbol s1 "
	//	<< "  inner join Link lk "
	//	<< "    on s1.symID = lk.sym2ID "
	//	<< "  inner join Symbol s2 "
	//	<< "    on s2.symID = lk.symID "
	//	<< "   and s2.symParentID = s1.symParentID "
	//	<< " where s1.symID = " << theID
	//	<< "   and lk.lktID = " << MasterData::XREF_LINK
	//	<< " ;" << flush ;

	strcpy(sql,"Select count(distinct s2.symID) as varUsage from symbol s1 inner join link lk on s1.symID=lk.sym2ID inner join symbol s2 on s2.symID=lk.symID and s2.symParentID=s1.symParentID where s1.symID=") ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;
	strcat(sql," and lk.lktID=") ;
	strcat(sql, ltostr(MasterData::XREF_LINK, charNumber, 30)) ;

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
	char sql[512], charNumber[30] ;

	//	<< "select count(s2.symID) as fnUsage "
	//	<< "  from Symbol s1 "
	//	<< " inner join Link lk "
	//	<< "    on s1.symID = lk.sym2id "
	//	<< " inner join Symbol s2 "
	//	<< "    on s2.symID = lk.symID "
	//	<< " where s1.symID = " << theID
	//	<< "   and lk.lktID = " << MasterData::XREF_LINK
	//	<< "   and s1.catID = " << MasterData::METHOD_CAT
	//	<< " ;" << flush ;

	strcpy(sql,"select count(s2.symID) as fnUsage from symbol s1 inner join link lk on s1.symID = lk.sym2id inner join symbol s2 on s2.symID = lk.symID where s1.symID=") ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;
	strcat(sql," and lk.lktID=") ;
	strcat(sql, ltostr(MasterData::XREF_LINK, charNumber, 30)) ;
	strcat(sql," and s1.catID=") ;
	strcat(sql, ltostr(MasterData::METHOD_CAT, charNumber, 30)) ;

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
	char sql[512] ;
	char charNumber[30] ;

	strcpy(sql,"(") ;

	//itoa(theID, charNumber, 10) ;
	//strcat(charNumber,",") ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;
	strcat(sql,",") ;

	//itoa(theParentID, charNumber, 10) ;
	//strcat(charNumber,",'") ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(theParentID, charNumber, 30)) ;
	strcat(sql,",") ;

	strcat(sql, theName.c_str()) ;
	strcat(sql, "',") ;

	//itoa(theTypeID, charNumber, 10) ;
	//strcat(charNumber,",") ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(theTypeID, charNumber, 30)) ;
	strcat(sql,",") ;

	//itoa(theCatID, charNumber, 10) ;
	//strcat(charNumber,",") ;
	//strcat(sql, charNumber) ;

	strcat(sql, ltostr(theCatID, charNumber, 30)) ;
	strcat(sql,",") ;

	//itoa(theProtectionID, charNumber, 10) ;
	//strcat(charNumber,")") ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(theProtectionID, charNumber, 30)) ;
	strcat(sql,")") ;

	return string(sql) ;
}


void SymbolNode::write()
{
	writeMetrics() ;
	theLinks.write(*theTreeHelper) ;

	//char sql[512], charNumber[30] ;

/*	if (theFirstTime)
	{
		ost << "INSERT INTO symbol VALUES ( "
			<< theID << " , "
			<< theParentID << " , "
			<< "'" << theName << "' , "
			<< theTypeID << " , "
			<< theCatID << " , "
			<< theProtectionID << " ) " << flush ;
	}
	else if(theDirty)
	{
		ost << "UPDATE symbol SET "
			<< "symParentID = " << theParentID << " , "
			<< "symName = '" << theName << "' , "
			<< "sytID = " << theTypeID << " , "
			<< "catID = " << theCatID << " , "
			<< "prtID = " << theProtectionID << "  "
			<< "WHERE symID = " << theID << flush ;
	}*/
	if (theDirty)
	{
		//	<< "REPLACE INTO symbol VALUES ( "
		//	<< theID << " , "
		//	<< theParentID << " , "
		//	<< "'" << theName << "' , "
		//	<< theTypeID << " , "
		//	<< theCatID << " , "
		//	<< theProtectionID << " ) " << flush ;

		theTreeHelper->writeSymbol(theID,theParentID,theName.c_str(),theTypeID,theCatID,theProtectionID) ;

		/*strcpy(sql,"REPLACE INTO symbol VALUES ( ") ;
		strcat(sql, ltostr(theID, charNumber, 30)) ;
		strcat(sql,",") ;
		strcat(sql, ltostr(theParentID, charNumber, 30)) ;
		strcat(sql,",'") ;
		strcat(sql, theName.c_str()) ;
		strcat(sql, "',") ;
		strcat(sql, ltostr(theTypeID, charNumber, 30)) ;
		strcat(sql,",") ;
		strcat(sql, ltostr(theCatID, charNumber, 30)) ;
		strcat(sql,",") ;
		strcat(sql, ltostr(theProtectionID, charNumber, 30)) ;
		strcat(sql,")") ;*/
	}
	else
	{
		return ;
	}


	/*try
	{
		theTreeHelper->executeResultlessQuery(sql) ;
	}
	catch (...)
	{
		MasterData::theLog << "SymbolNode::write() - Error executing query!" << endl ;
	}*/

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
		for(int c=0; c<scope->theChildren.size(); c++)
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
	//ostringstream sql ;
	theTreeHelper->flushWriteSymbol() ;
	char sql[512] ;
	strcpy(sql,"Select symParentID,symName,sytID,catID,prtID From symbol Where symID=") ;

	char charNumber[30] ;
	//itoa(theID,number,10) ;
	//strcat(sql,number) ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;

	if (theTreeHelper->executeQuery(sql))
	{
		theParentID =		theTreeHelper->longCell(0,0) ;
		theName =			theTreeHelper->cell(0,1) ;
		theTypeID =			theTreeHelper->longCell(0,2) ;
		theCatID =			theTreeHelper->longCell(0,3) ;
		theProtectionID =	theTreeHelper->longCell(0,4) ;

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
		char sql[512], charNumber[30] ;

		strcpy(sql,"Select symParentID From symbol Where symID=") ;
		strcat(sql, ltostr(ID, charNumber, 30)) ;

		if (theTreeHelper->executeQuery(sql))
		{
			myParentID = theTreeHelper->longCell(0,0) ;
		}

		// Retreive this Node's children
		strcpy(sql,"Select symID From symbol Where symParentID=") ;
		strcat(sql, ltostr(ID, charNumber, 30)) ;

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


// Metrics Functions

/*long SymbolNode::getMetricGroup()
{
	long mtgID = 0 ;
	long catID = theCatID ;

	if (catID == MasterData::PROJECT_CAT)
		return MasterData::PROJECT_MTG ;

	else if (catID == MasterData::FILE_CAT)
		return MasterData::FILE_MTG ;

	else if (catID == MasterData::CLASS_CAT)
		return MasterData::CLASS_MTG ;

	else if (catID == MasterData::INTERFACE_CAT)
		return MasterData::INTERFACE_MTG ;

	else if (catID == MasterData::METHOD_CAT)
		return MasterData::METHOD_MTG ;

	else
		return 0 ;
}


long SymbolNode::getMetricGroup(long mttID)
{
	// Now we always return the group, even where the metric is common.
	// Thus, LOC would be 2001, 3001, 4001, depending on the MTG of the
	// symbol, rather than always being 1001.  The impact of this is that
	// we can set bounds for LOC for different groups.
	return getMetricGroup() ;
}*/


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

	char sql[4096] ;
	char charNumber[30] ;

	strcpy(sql,"Replace Into metric Values (") ;

	int maxID = MasterData::getMaxMetricTypeID(theCatID) ;
	for(mttID = 1; mttID<maxID; mttID++)
	{
		if (theMetricsDirty[mttID] == MET_DIRTY_TRUE)
		{
			proceed = true ;

			//itoa(theID, charNumber, 10) ;
			//strcat(charNumber,",") ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theID, charNumber, 30)) ;
			strcat(sql,",") ;

			//itoa(MasterData::codeMtt(mttID,theCatID), charNumber, 10) ;
			//strcat(charNumber,",") ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(MasterData::codeMtt(mttID,theCatID), charNumber, 30)) ;
			strcat(sql,",") ;

			//_gcvt(theMetrics[mttID], 7, charNumber) ;
			//strcat(sql,charNumber) ;
			//strcat(sql,"),(") ;
			strcat(sql,dtoa(theMetrics[mttID], charNumber, 30)) ;
			strcat(sql,"),(") ;

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
	char sql[512], charNumber[30] ;

	strcpy(sql,"SELECT mttID, metValue FROM metric WHERE symID=") ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;

	if (theTreeHelper->executeQuery(sql))
	{
		checkMetrics() ;
		clearMetricsDirty() ;
		int i ;
		for (i=0 ; i<theTreeHelper->rows() ; i++)
		{
			long mttID = MasterData::decodeMtt(theTreeHelper->longCell(i,0)) ;
			float newValue = theTreeHelper->doubleCell(i,1) ;

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
	int i ;

	for (i=0 ; i < subclasses.size() ; i++)
	{
		SymbolNode subclass ;
		if (findSymbolNode(subclasses[i].getDestID(), subclass))
		{
			if (classNode.getID() == subclass.getID())
				return true ;

			if (subclass.hasSubclass(classNode))
				return true ;	// Search deeper down
		}
	}

	return false ;
}


int SymbolNode::countSubclasses()
{
	vector<Link> subclasses = getLinks(MasterData::SUB_LINK) ;
	int retval = subclasses.size() ;
	SymbolNode subclass ;

	int i ;
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


