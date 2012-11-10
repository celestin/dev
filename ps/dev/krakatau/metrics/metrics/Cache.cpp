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

#include <iostream>

#include <malloc.h>

#include "MasterData.h"
#include "Cache.h"

using namespace metrics ;
using namespace std ;

int acollisions = 0 ;
//extern MasterData *md ;

Cache::Cache(): theSymbolInsertSql("")
{
#ifdef WIN32
	progress_lock=CreateMutex(NULL,FALSE,NULL);
#elif sun
	mutex_init(&progress_lock,0,NULL);
#elif hpux
	pthread_mutex_init(&progress_lock,pthread_mutexattr_default);
#elif linux
	pthread_mutex_init(&progress_lock,NULL);
#endif

	hits = 0 ;
	misses = 0 ;
	theContainerSize = 0 ;
	theLeafSize = 0 ;

	theLimit = 10000 ;
	theContainerLimit = (int) (3*theLimit/4) ;
	theLeafLimit = theLimit - theContainerLimit ;
	theIncrement = 5000 ;

	theMapSize = 3*theLimit ;
	theMap = new CacheItem*[theMapSize] ;

	for (int i=0 ; i<theMapSize ; i++) theMap[i] = NULL ;

	LOCKMUTEX(progress_lock);
	theSize = 0 ;
	UNLOCKMUTEX(progress_lock);

	theHead = new CacheItem(NULL) ;
	theFloater = new CacheItem(NULL) ;
	theTail = new CacheItem(NULL) ;

	theHead->setLastRecent(theFloater) ;
	theFloater->setNextRecent(theHead) ;
	theFloater->setLastRecent(theTail) ;
	theTail->setNextRecent(theFloater) ;

	theNumSymbolInserts = 0 ;
}


Cache::Cache(long newLimit, int newIncrement): theSymbolInsertSql("")
{
#ifdef WIN32
	progress_lock=CreateMutex(NULL,FALSE,NULL);
#elif sun
	mutex_init(&progress_lock,0,NULL);
#elif hpux
	pthread_mutex_init(&progress_lock,pthread_mutexattr_default);
#elif linux
	pthread_mutex_init(&progress_lock,NULL);
#endif

	hits = 0 ;
	misses = 0 ;
	theContainerSize = 0 ;
	theLeafSize = 0 ;

	theLimit = newLimit ;
	theContainerLimit = (int) (3*theLimit/4) ;
	theLeafLimit = theLimit - theContainerLimit ;
	theIncrement = newIncrement ;

	theMapSize = 3*newLimit ;
	theMap = new CacheItem*[theMapSize] ;

	for (int i=0 ; i<theMapSize ; i++) theMap[i] = NULL ;

	LOCKMUTEX(progress_lock);
	theSize = 0 ;
	UNLOCKMUTEX(progress_lock);

	theHead = new CacheItem(NULL) ;
	theFloater = new CacheItem(NULL) ;
	theTail = new CacheItem(NULL) ;

	theHead->setLastRecent(theFloater) ;
	theFloater->setNextRecent(theHead) ;
	theFloater->setLastRecent(theTail) ;
	theTail->setNextRecent(theFloater) ;

	theNumSymbolInserts = 0 ;
}


/*Cache::Cache(const Cache& rhs)
{
	//TODO: copy whole list

	theHead = rhs.theHead ;
	theTail = rhs.theTail ;
	theSize = rhs.theSize;

	theMap = rhs.theMap ;

	theLimit = rhs.theLimit ;
	theIncrement = rhs.theIncrement ;
}*/


Cache::~Cache()
{
	/*MasterData::theLog << "in Cache destructor" << endl ;
	CacheItem *currentItem = theTail->getNextRecent() ;
	CacheItem *next ;
	Node *currentNode = NULL ;
	int counter=0 ;

	while ( counter<theSize )
	{
		next = currentItem->getNextRecent() ;

		if (currentItem==theFloater)
		{
			currentItem = next ;
			next = currentItem->getNextRecent() ;
		}

		currentNode = currentItem->getNode() ;

		delete currentItem ;
		if (!currentNode->isRoot())
		{
			delete currentNode ;
		}

		currentItem = next ;
		counter++ ;
	}
*/
	delete theTail ;
	delete theFloater ;
	delete theHead ;
}


const Cache& Cache::operator=(const Cache& rhs)
{
	//TODO: copy whole list

	theHead = rhs.theHead ;
	theFloater = rhs.theFloater ;
	theTail = rhs.theTail ;
	theSize = rhs.theSize;

	theMap = rhs.theMap ;

	theLimit = rhs.theLimit ;
	theIncrement = rhs.theIncrement ;

	return (*this);
}

CacheItem *Cache::addToList(Node *newNode,CacheItem *llist)
{
	current = llist ;
	last = current ;
	currNode = NULL ;
	currID = newNode->theID ;

	while (current)
	{
		currNode = current->getNode() ;
		if (currNode)
		{
			if (currNode->theID==currID){
				// Already in list - so remove from recency
				prev = current->getLastRecent() ;
				next = current->getNextRecent() ;

				next->setLastRecent(prev) ;
				prev->setNextRecent(next) ;

				// Should check that memory is different
				current->setNode(currNode) ;

				break ;
			}
		}
		last = current ;
		current = current->getNext() ;
	}

	if (!current)
	{
		current = new CacheItem(newNode) ;
		LOCKMUTEX(progress_lock) ;
		theSize++ ;
		if (newNode->theCatID<8)
		{
			theContainerSize++;
			current->isContainer = true ;
		}
		else
		{
			//MasterData::theLog << "+Leaf2: " << newNode->theID << " [" << newNode->theCatID << "]" << endl ;
			theLeafSize++ ;
		}
		UNLOCKMUTEX(progress_lock) ;

		last->setNext(current) ;
	}

	if (newNode->theCatID<8)
	{
		prev = theHead->getLastRecent() ;

		current->setNextRecent(theHead) ;
		current->setLastRecent(prev);

		prev->setNextRecent(current);
		theHead->setLastRecent(current) ;
	}
	else
	{
		prev = theFloater->getLastRecent() ;

		current->setNextRecent(theFloater) ;
		current->setLastRecent(prev);

		prev->setNextRecent(current);
		theFloater->setLastRecent(current) ;
	}

	return llist ;
}


CacheItem *Cache::removeFromList(long ID,CacheItem *llist)
{
	/*CacheItem */current = llist ;
	/*CacheItem */last = current ;
	/*Node */currNode = NULL ;
	//CacheItem *prev,*next ;

	if (current)
	{
		currNode = current->getNode() ;
		if (currNode)
		{
			if (currNode->theID==ID)
			{
				if (currNode->theNReferences<1)
				{
					last = current->getNext() ;

					prev = current->getLastRecent() ;
					next = current->getNextRecent() ;

					next->setLastRecent(prev) ;
					prev->setNextRecent(next) ;

					LOCKMUTEX(progress_lock) ;
					theSize-- ;
					if (current->isContainer)
					{
						theContainerSize-- ;
					}
					else
					{
						//MasterData::theLog << "-Leaf1: " << currNode->theID << " [" << currNode->theCatID << "]" << endl ;
						theLeafSize-- ;
					}

					UNLOCKMUTEX(progress_lock) ;

					if (current) delete current ;
					if (currNode) delete currNode ;

					return last ;
				}
				else
				{
					return llist ;
				}
			}
		}
	}
	else
	{
		return NULL;
	}

	last = current ;
	current = current->getNext() ;

	while (current)
	{
		currNode = current->getNode() ;
		if (currNode)
		{
			if (currNode->theID==ID)
			{
				if (currNode->theNReferences<1)
				{
					last->setNext(current->getNext()) ;

					prev = current->getLastRecent() ;
					next = current->getNextRecent() ;

					next->setLastRecent(prev) ;
					prev->setNextRecent(next) ;

					LOCKMUTEX(progress_lock) ;
					theSize-- ;
					if (current->isContainer)
					{
						theContainerSize-- ;
					}
					else
					{
						//MasterData::theLog << "-Leaf2: " << currNode->theID << " [" << currNode->theCatID << "]" << endl ;
						theLeafSize-- ;
					}
					UNLOCKMUTEX(progress_lock) ;

					if (current) delete current ;
					if (currNode) delete currNode ;
				}

				return llist ;
			}
		}
		last = current ;
		current = current->getNext() ;
	}

	return llist ;
}


CacheItem *Cache::locateInList(long ID,CacheItem *llist)
{
	/*CacheItem */current = llist ;
	/*SymbolNode */currNode = NULL ;

	while (current)
	{
		currNode = current->getNode() ;
		if (currNode)
		{
			if (currNode->theID==ID){
					return current ;
			}
		}
		current = current->getNext() ;
	}

	return NULL ;
}

void Cache::add(long ID, Node *newNode)
{
	if (!isLegit()) compact() ;

	position = hash(ID)%theMapSize ;
	ci = theMap[position] ;

	if (!ci)
	{
		// Add new CacheItem
		ci = new CacheItem(newNode) ;

		if (newNode->theCatID<8)
		{
			// Container
			theContainerSize++;
			ci->isContainer = true ;

			ci->setNextRecent(theHead) ;
			ci->setLastRecent(theHead->getLastRecent());

			theHead->getLastRecent()->setNextRecent(ci);
			theHead->setLastRecent(ci) ;
		}
		else
		{
			//MasterData::theLog << "+Leaf1: " << newNode->theID << " [" << newNode->theCatID << "]" << endl ;
			theLeafSize++;

			ci->setNextRecent(theFloater) ;
			ci->setLastRecent(theFloater->getLastRecent());

			theFloater->getLastRecent()->setNextRecent(ci);
			theFloater->setLastRecent(ci) ;
		}

		LOCKMUTEX(progress_lock) ;
		theSize++ ;
		UNLOCKMUTEX(progress_lock) ;

		theMap[position] = ci ;
	}
	else
	{
		theMap[position] = addToList(newNode,ci) ;
	}

}


void Cache::remove(long ID)
{
	long position = hash(ID)%theMapSize ;
	CacheItem *ci = theMap[position] ;

	if (!ci) return;

	theMap[position] = removeFromList(ID,ci) ;
}


Node *Cache::get(long ID)
{
	position = hash(ID)%theMapSize ;

	/*CacheItem */ci = theMap[position] ;
	//CacheItem *next,*prev ;

	if (!ci)
	{
		misses++ ;
		return NULL ;
	}

	/*CacheItem */ci = locateInList(ID,ci) ;

	if (!ci)
	{
		misses++ ;
		return NULL ;
	}


	prev = ci->getLastRecent() ;
	next = ci->getNextRecent() ;

	next->setLastRecent(prev) ;
	prev->setNextRecent(next) ;

	currNode = ci->getNode() ;

	if (currNode->theCatID<8)
	{
		ci->setNextRecent(theHead) ;
		ci->setLastRecent(theHead->getLastRecent());

		theHead->getLastRecent()->setNextRecent(ci);
		theHead->setLastRecent(ci) ;
	}
	else
	{
		ci->setNextRecent(theFloater) ;
		ci->setLastRecent(theFloater->getLastRecent()) ;

		theFloater->getLastRecent()->setNextRecent(ci) ;
		theFloater->setLastRecent(ci) ;
	}

	hits++ ;

	return ci->getNode() ;
}


int Cache::getProgress() {
	LOCKMUTEX(progress_lock) ;
	int retval;

	if (!theSize)
	{
		UNLOCKMUTEX(progress_lock) ;
		return 100;
	}

	retval = (int) 100*itemNo/theSize ;
	UNLOCKMUTEX(progress_lock) ;

 	return retval ;
}


/*void Cache::flushSymbolInsert()
{
	if (theNumSymbolInserts > 0)
	{
		try
		{
			// md->theDBConnection.executeResultlessQuery(theSymbolInsertSql) ; // changed 31/01/01
		}
		catch (...)
		{
			MasterData::theLog << "Cache::flushSymbolInsert() - Error executing query!" << endl ;
		}

		theSymbolInsertSql = "" ;
		theNumSymbolInserts = 0 ;
	}
}


void Cache::addSymbolInsert(string insertSql)
{
	if (theNumSymbolInserts == 0)
	{
		theSymbolInsertSql = "Insert DELAYED Into symbol Values " + insertSql ;
	}
	else if (theNumSymbolInserts >= MAX_SYMBOL_INSERTS)
	{
		flushSymbolInsert() ;
		theSymbolInsertSql = "Insert DELAYED Into symbol Values " + insertSql ;
	}
	else
	{
		theSymbolInsertSql += "," + insertSql ;
	}

	theNumSymbolInserts++ ;
}


void Cache::write(SymbolNode *node)
{
	node->writeMetrics() ;
	//node->theLinks.write() ;

	ostringstream ost ;

	if ((node->theFirstTime) || (node->theDirty))
	{
		addSymbolInsert(node->formSqlInsert()) ;
	}
	else
	{				// If not First Time or Dirty, do not
		return ;	// execute query.
	}				// (Not elegant, but efficient)

	node->theDirty = node->theFirstTime = false ;
	node->theWritten = true ;
}*/


void Cache::compact()
{
	if (theLeafSize>theLeafLimit)
	{
		CacheItem *currentItem = theTail->getNextRecent() ;
		CacheItem *next ;
		CacheItem *llist = NULL ;
		Node *currentNode = currentItem->getNode() ;
		int i=0,ID ;
		int position ;

		while ( (i<theIncrement) && //(i<theLeafSize))
			( currentItem!=theFloater ))
		{
			next = currentItem->getNextRecent() ;

			//write(currentNode) ; //Changed 30/01/01
			if (currentNode->theNReferences<1)
			{
				currentNode->write() ;

				ID = currentNode->theID ;

				position = hash(ID)%theMapSize ;
				llist = theMap[position] ;

				theMap[position] = removeFromList(ID,llist) ;

				i++ ;
			}

			currentItem = next ;
			currentNode = currentItem->getNode() ;
		}

		// Removed 23/04/01 by SJW
		// This is handled by the removeFromList method and the
		// following 2 lines produce incorrect results
		//theTail->setNextRecent(next) ;
		//next->setLastRecent(theTail) ;
	}
	else
	{
		//compact container section of list

		CacheItem *currentItem = theFloater->getNextRecent() ;
		CacheItem *next ;
		CacheItem *llist = NULL ;
		Node *currentNode = currentItem->getNode() ;
		int i=0,ID ;
		int position ;

		while ( (i<theIncrement) && //(i<theContainerSize))
		 ( currentItem!=theHead ))
		{
			next = currentItem->getNextRecent() ;


			//write(currentNode) ; //Changed 30/01/01
			//MasterData::theLog << "No of refs to sym: " << currentNode->theNReferences << endl ;
			if (!currentNode->isRoot() && currentNode->theNReferences<1)
			{
				currentNode->write() ;

				ID = currentNode->theID ;

				position = hash(ID)%theMapSize ;
				llist = theMap[position] ;


				theMap[position] = removeFromList(ID,llist) ;

				i++ ;
			}

			currentItem = next ;
			currentNode = currentItem->getNode() ;

		}

		// Removed 23/04/01 by SJW
		// This is handled by the removeFromList method and the
		// following 2 lines produce incorrect results
		//theFloater->setNextRecent(next) ;
		//next->setLastRecent(theFloater) ;
	}

	//flushSymbolInsert() ;
}

void Cache::flush()
{
	CacheItem *currentItem = theTail->getNextRecent() ;
	CacheItem *next ;
	Node *currentNode = NULL ;

	LOCKMUTEX(progress_lock) ;
	itemNo = 0 ;
	int counter = 0 ;
	UNLOCKMUTEX(progress_lock) ;

	while ( counter<theSize )
	{
		next = currentItem->getNextRecent() ;

		if (currentItem==theFloater)
		{
			currentItem = next ;
			next = currentItem->getNextRecent() ;
		}

		try
		{
			currentNode = currentItem->getNode() ;
			//write(currentNode) ; //Changed 30/01/01

			currentNode->write() ;

			if (currentItem) delete currentItem ;
			if (!currentNode->isRoot())
			{
				if (currentNode) delete currentNode ;
			}
		} catch (...)
		{
			// currentNode->theAdded is false so this node will get
			// killed in the above call
		}

		currentItem = next ;
		counter++ ;
		LOCKMUTEX(progress_lock) ;
		itemNo = counter ;
		UNLOCKMUTEX(progress_lock) ;
	}

	theTail->setNextRecent(theTail) ;
	theFloater->setNextRecent(theHead) ;
	theFloater->setLastRecent(theTail) ;
	theHead->setLastRecent(theFloater) ;

	for (int j=0 ; j<theMapSize ; j++) theMap[j] = NULL ;

	LOCKMUTEX(progress_lock) ;
	theSize = 0 ;
	theContainerSize = 0 ;
	theLeafSize = 0 ;
	UNLOCKMUTEX(progress_lock) ;

	//flushSymbolInsert() ;
}


void Cache::commit()
{
	CacheItem *currentItem = theTail->getNextRecent() ;
	CacheItem *next ;
	Node *currentNode = NULL ;

	LOCKMUTEX(progress_lock) ;
	itemNo = 0 ;
	int counter = 0 ;
	UNLOCKMUTEX(progress_lock) ;

	//try
	//{

		//while (counter<theSize )
		while (currentItem!=theHead)
		{
			next = currentItem->getNextRecent() ;

			if (currentItem==theFloater)
			{
				currentItem = next ;
				next = currentItem->getNextRecent() ;
			}

			currentNode = currentItem->getNode() ;
			//write(currentNode) ; //Changed 30/01/01
			//try
			//{
				currentNode->write() ;
			//} catch (...)
			//{
			//	MasterData::theLog << "Exception (1) caught in Cache::commit()" << endl ;
			//}

			currentItem = next ;
			counter++ ;

			LOCKMUTEX(progress_lock) ;
			itemNo = counter ;
			UNLOCKMUTEX(progress_lock) ;
		}

	//}
	//catch (...)
	//{
	//	MasterData::theLog << "Exception (2) caught in Cache::commit()" << endl ;
	//}
	//flushSymbolInsert() ;
}


