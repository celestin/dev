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

#ifndef METRICS_CACHE
#define METRICS_CACHE

#include "MasterData.h"
#include "Node.h"
#include <string>

namespace metrics
{

	class CacheItem
	{

	private:
		Node *theNode ;
		CacheItem *theLastRecent ;
		CacheItem *theNextRecent ;

		CacheItem *theNext ;

	protected:

	public:

		bool isContainer ;

		CacheItem(Node *newNode)
		{
			theNode = newNode ;
			theLastRecent = NULL ;
			theNextRecent = NULL ;

			theNext = NULL ;
			isContainer = false ;
		}
		~CacheItem()
		{
			;
		}

		void setLastRecent(CacheItem *newLastRecent) { theLastRecent = newLastRecent ; }
		CacheItem *getLastRecent() { return theLastRecent ; }

		void setNextRecent(CacheItem *newNextRecent) { theNextRecent = newNextRecent ; }
		CacheItem *getNextRecent() { return theNextRecent ; }

		void setNext(CacheItem *newNext) { theNext = newNext ; }
		CacheItem *getNext() { return theNext ; }

		void setNode(Node *newNode) { theNode = newNode ; }
		Node *getNode() { return theNode ; }

	} ;


	class Cache
	{

	private:

		long theLimit ;					// No. of Nodes to hold
										// before writing
		long theIncrement ;				// No. of Nodes to write
										// when the cache gets full
		long theContainerLimit, theLeafLimit ;

		CacheItem *current, *last ;
		CacheItem *prev, *next ;
		CacheItem *ci ;
		Node *currNode ;
		long currID ;
		int position ;

		CacheItem *theHead ;
		CacheItem *theFloater ;
		CacheItem *theTail ;

		long theSize ;
		long theContainerSize ;
		long theLeafSize ;

		CacheItem **theMap ;
		int theMapSize ;

		int itemNo ;

		long hash(long key) {
/*			key += ~(key << 15) ;
			key ^=  (key >> 10) ;
			key +=  (key << 3) ;
			key ^=  (key >> 6) ;
			key += ~(key << 11) ;
			key ^=  (key >> 16) ;

			return static_cast<int> (key) ;*/

			/*key ^= ((~key) >> 31) ;
			key += (key << 28) ;
			key ^= (key >> 21) ;
			key += (key << 3) ;
			key ^= ((~key) >> 5) ;
			key += (key << 13) ;
			key ^= (key >> 27) ;
			key += (key << 32) ;*/

			return key ;
		}

#define MAX_SYMBOL_INSERTS 500
		std::string theSymbolInsertSql ;
		int theNumSymbolInserts ;


#ifdef WIN32
		HANDLE progress_lock;
#elif sun
		mutex_t progress_lock;
#elif hpux
		pthread_mutex_t progress_lock;
#elif linux
		pthread_mutex_t progress_lock;
#endif

	protected:

		bool Cache::isLegit()
		{
			if (theContainerSize>theContainerLimit) return false ;
			if (theLeafSize>theLeafLimit) return false;
			return true ;
		}


		void compact() ;				// clear theIncrement spaces
										// from the cache

		CacheItem *addToList(Node *newNode, CacheItem *list) ;
		CacheItem *removeFromList(long ID,CacheItem *list) ;
		CacheItem *locateInList(long ID,CacheItem *list) ;

		//void addSymbolInsert(std::string) ;
		//void flushSymbolInsert() ;

	public:

		Cache() ;
		Cache(long newLimit, int newIncrement) ;

		virtual ~Cache() ;

		const Cache& operator=(const Cache& rhs) ;

		long getLimit() { return theLimit ; }
		void setLimit(long newLimit) { theLimit = newLimit ; }

//		bool isLegit() ;

		long getIncrement() { return theIncrement ; }
		void setIncrement(long newIncrement) { theIncrement = newIncrement ; }

		void add(long ID, Node *newNode) ;
		void remove(long ID) ;
		Node *get(long ID) ;

		long hits ;
		long misses ;

		int getProgress() ;
		//void write(Node*) ;
		void flush() ;					// clear the cache
 		virtual void commit() ;
	} ;

};

#endif