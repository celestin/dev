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
#include <vector>
#include <fstream>
#include <iostream>
using namespace std;

#include "MasterData.h"
#include "ResolvePhase.h"
#include "RootNode.h"
#include "TempLink.h"
using namespace metrics ;

const int ResolvePhase::inheritance = 0 ;
const int ResolvePhase::external = 1 ;
const int ResolvePhase::references = 2 ;
const int ResolvePhase::committing = 3 ;

//map<string,long> resolved ;
//map<string,long> unresolvable ;


long ResolvePhase::locateTypeFromClass(string name,SymbolNode &referrer, SymbolNode &ret)
{
	// not only should we return the type reference, we should record other type
	// references along the way... - ok

	SymbolNode current = referrer ;
	SymbolNode tmp = referrer ;
	int i = 0 ;

	// Chop out contents of < >, componentise on ::
	componentise(name, Component::OPERATION_TYPE) ;
	// We have something like a,b,c in components - we're
	// looking through a,b to find c.

	long retval = -1 ;
	while (i < theComponentsCount)
	{
		retval = typeComponentLocate(theComponents[i],current,tmp) ;
		if (retval!=-1)
		{
			current = tmp ;
			i++ ;
		}
		else
		{
			return -1 ;
		}
	}

	return retval ;
}


void ResolvePhase::resolveInheritance(SymbolNode &node)
{
	SymbolNode current = node ;
	SymbolNode ret = node ;
	string name ;

	if ( node.getCategoryID() == MasterData::CLASS_CAT)
	{
		TempLinks supers((*theRoot),node.getID(),MasterData::SUPER_LINK) ;
		current = node.getParent();

		for (TempLinks::iterator iter = supers.begin() ; iter != supers.end() ; iter++)
		{
			name = iter->getRef() ;

			long sytID = typeComponentLocate(name,current,ret) ;
			if (theRoot->findSymbolNodeFromTypeID(sytID,ret))
			{
				node.addLink(iter->getID(), ret.getID(),MasterData::SUPER_LINK) ;
				ret.addLink(node.getID(),MasterData::SUB_LINK) ;
			}
		}
	}
	if ( node.getCategoryID() == MasterData::INTERFACE_CAT)
	{
		// TODO:
		//MasterData::theLog << "Looking at the inheritance of an interface." << endl ;
	}
}


void ResolvePhase::resolveExternalMethod(SymbolNode &node)
{
	componentise(node.getName(), Component::OPERATION_TYPE) ;
	SymbolNode searchScope = node ;
	int i ;

	if (theComponentsCount < 2)
	{
		return ; 	// The name is not qualified with "::" - ignore
	}

	// Attempt to move through classes (like sheep in the night?) by
	// progressing through the components until we reach the last
	// component and find a method

	// searchScope changes as we move through the classes - start with
	// theRoot(Node).

	for (i=0; i < theComponentsCount; i++)
	{
		if (i==0)
		{
			// Find the first class
			long sytID = typeComponentLocate(theComponents[0],searchScope,searchScope) ;

			if (sytID == -1)
			{
				return ; // Could not locate first class
			}

			if (!theRoot->findSymbolNodeFromTypeID(sytID,searchScope))
			{
				return ;
			}
//			if (!theRoot->find(MasterData::CLASS_CAT, components[0],searchScope))
//				return ;
		}

		else if (i==(theComponentsCount-1))
		{
			// If last component, search for a method
			for (int j=0;j<searchScope.childCount();j++)
			{
				SymbolNode child = searchScope.getChild(j) ;

				// Search within searchScope for a METHOD matching entity name
				if ((child.getCategoryID()==MasterData::METHOD_CAT) &&
					(theComponents[i] == child.getName()))
				{
					// We have now located the prototype (i.e. method DEFINITION).
					// Now we want to delete the prototype, and move the IMPLEMENTATION
					// in its place, meaning that a class and all its methods are together

					long protection = searchScope.getChild(j).getProtectionID() ;
					searchScope.removeChild(j) ;	// Remove the DEF
					node.graft(searchScope) ;		// Graft the IMP from File to Class
					node.setProtectionID(protection) ;	// Adjust from PUBLIC to DEF's level
					node.setName(theComponents[i]) ;	// Drop the qualified part of the name

					// Remember this ID to prevent processing it a second time
					// when we reach its new position in the tree
					theResolvedIDs.push_back(node.getID()) ;

					return ;
				}
			}
			return ;
		}
		else
		{
			// If in the middle of components, search the children of the current class
			// (searchScope) for a match for this component

			for (int j=0;j<searchScope.childCount();j++)
			{
				SymbolNode child = searchScope.getChild(j) ;

				if ((child.getCategoryID() == MasterData::CLASS_CAT) &&
					(theComponents[i] == child.getName()))
				{
					searchScope = child ;
					//goto got_this_class ;
					break ;
				}

				// Could not find this component within children of searchScope - abandon
				return ;
			}
		}
	}

	return ;
}


long ResolvePhase::typeComponentLocate(string name, SymbolNode &referrer, SymbolNode &ret)
{
	long sytID = theRoot->getSymbolTypeID(name) ;

	return sytID ;
}

#ifdef LANGUAGE_JAVA
void ResolvePhase::resolveImports(SymbolNode &item)
{
	// in this method, we check for imported packages

	SymbolNode current = item ;
	SymbolNode ret = item ;
	string ref ;

	//MasterData::theLog << "In file: " << item.getName() << endl ;
	TempLinks type((*theRoot),item.getChildren(), MasterData::IMPORT_LINK) ;

	for (TempLinks::iterator iter = type.begin() ; iter!=type.end() ; iter++)
	{
		if (theRoot->findSymbolNode(iter->getSymID(),current))
		{
			ref = iter->getRef() ;

			//MasterData::theLog << "Found import: " << ref << endl ;
		}
	}
}
#endif

void ResolvePhase::resolveTypeReference(SymbolNode &item)
{
	// in this function, we check for types of instance variables and return
	// types of methods.  These types are matched to actual classes

	SymbolNode current = item ;
	SymbolNode ret = item ;
	string ref ;

//	if (item.getCategoryID() == MasterData::FIELD_CAT)
//		return ;

	if (item.childCount() > 0)
	{
		TempLinks type((*theRoot),item.getChildren(), MasterData::TYPE_LINK) ;

		for (TempLinks::iterator iter = type.begin() ; iter!=type.end() ; iter++)
		{
			if (theRoot->findSymbolNode(iter->getSymID(),current))
			{
				ref = iter->getRef() ;

				/*long toID ;
				if (toID = resolved[ref])
				{
					current.setTypeID(toID);
				}
				else if (toID = unresolvable[ref])
				{
					current.setTypeID(-1);
				}
				else if (locateTypeFromClass(ref,current,ret))
				{
					long typeID = theRoot->addSymbolType(ret.getID(),ref) ;
					resolved[ref] = typeID ;
					//TODO: check addSymbolType
					current.setTypeID(typeID);
				}
				else
				{
					current.setTypeID(-1);
					unresolvable[ref] = iter->getID() ;
				}*/

				int type = locateTypeFromClass(ref,current,ret) ;
				current.setTypeID(type) ;
			}
		}
	}
}


bool ResolvePhase::previouslyResolved(int ID)
{
	vector<long>::iterator iter ;

	for(iter = theResolvedIDs.begin(); iter < theResolvedIDs.end(); iter++)
	{
		if ((*iter) == ID) return true ;
	}

	return false ;
}


void ResolvePhase::resolve(SymbolNode &item)
{
	LOCKMUTEX(progress_lock) ;
	currentNode++ ;
	UNLOCKMUTEX(progress_lock) ;

	int category = item.getCategoryID() ;

	if (category == MasterData::PROJECT_CAT)
	{
		// Nothing to resolve at project level
	}
	else if (category == MasterData::NAMESPACE_CAT)
	{
		// Nothing to resolve at namespace level
	}
	else if (category == MasterData::FILE_CAT)
	{
		resolveTypeReference(item) ;
#ifdef LANGUAGE_JAVA
		resolveImports(item) ;
#endif
	}
	else if (category == MasterData::CLASS_CAT)
	{
		resolveInheritance(item) ;
		resolveTypeReference(item) ;
	}
	else if (category == MasterData::INTERFACE_CAT)
	{
		resolveInheritance(item) ;
	}
	else if (category == MasterData::METHOD_CAT)
	{
#ifdef LANGUAGE_CPP
		resolveExternalMethod(item) ;
#endif
		resolveTypeReference(item) ;
	}
	else if (category == MasterData::FIELD_CAT)
	{
		// Nothing to resolve at field level
	}

	// This is faulty because method during can be removed (during
	// resolveExternalMethod), thus disrupting the sequence of IDs.
	// CAM 12/01/2001
	/*int i;
	for (i=0 ; i<item.childCount() ; i++)
	{
		resolve(item.getChild(i)) ;
	}*/

	vector<long> children = item.getChildren() ;

//	MasterData::theLog << "Node: " << item.getName() << ", " ;
//	MasterData::theLog << "nChildren: " << children.size() << endl ;

	int i;
	SymbolNode child = item ;

	for (i=0 ; i<children.size() ; i++)
	{
		if ((!previouslyResolved(children[i])) &&
			(theRoot->findSymbolNode(children[i], child)))
		{
			resolve(child) ;
		}
	}

}


int ResolvePhase::getProgress() {
	//MasterData::theLog << "ResolvePhase about to lock progress_lock." << endl;
	LOCKMUTEX(progress_lock);
	progress = (int) (100*currentNode/totalNodes) ;
	UNLOCKMUTEX(progress_lock);
	//MasterData::theLog << "ResolvePhase unlocked progress_lock." << endl;
	return progress ;
}

void ResolvePhase::execute(RootNode *root)
{
	LOCKMUTEX(progress_lock) ;
	theRoot = root ;
	totalNodes = theRoot->getNodeCount() ;

	theStage = 0 ;
	currentNode = 0  ;
	theResolvedIDs.clear() ;
	progress = 0 ;

	MasterData::theLog << "Total nodes: " << totalNodes << endl ;
	MasterData::theLog << "Root: " << theRoot->getName() << endl ;

	//theStage = inheritance ;
	//currentNode=0 ;
	UNLOCKMUTEX(progress_lock) ;

	MasterData::theLog << "About to resolve" << endl ;

	resolve(*theRoot) ;
	//theRoot->commit() ;

	MasterData::theLog << "Resolve finished" << endl ;
}
