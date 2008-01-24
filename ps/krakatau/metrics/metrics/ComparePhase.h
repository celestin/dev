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

#ifndef METRICS_COMPAREPHASE
#define METRICS_COMPAREPHASE

#include <string>
#include <vector>

#include "Phase.h"
#include "Buffer.h"
#include "MasterData.h"
#include "MetricComp.h"
#include "Utilities.h"

namespace metrics
{

	class ComparePhase : public Phase
	{
	private:

#ifdef WIN32
		HANDLE progress_lock;
#elif sun
		mutex_t progress_lock;
#elif hpux
		pthread_mutex_t progress_lock;
#elif linux
		pthread_mutex_t progress_lock;
#endif
/*
		long theTotalChangedLines ;
		long theTotalDeletedLines ;
		long theTotalInsertedLines ;

		long theNAddFiles ;
		long theNChgFiles ;
		long theNDelFiles ;

		long theNAddPack ;
		long theNChgPack ;
		long theNDelPack ;

		long theNAddClass ;
		long theNChgClass ;
		long theNDelClass ;

		long theNAddMeth ;
		long theNChgMeth ;
		long theNDelMeth ;
*/
	protected:

		RootNode *theRoot1, *theRoot2 ;
		SymbolNode theProjNode ;

		static const int DIFFERENT_CAT ;
		static const int EQUAL ;
		static const int UNEQUAL ;

		Buffer theMetricCompBuff, theSymbolCompBuff, theSymbolDelBuff ;

		bool theProjectChanged ;

		void newHierarchyFrom(SymbolNode&) ;
		void delHierarchyFrom(SymbolNode&) ;

		int changed(SymbolNode&, SymbolNode&) ;
		void calcDiff(SymbolNode &node1, SymbolNode &node2) ;
		//long sumMetric(long) ;

		std::vector<long> getChildrenOfCat(RootNode*, SymbolNode&, long) ;

		void compare(SymbolNode&, SymbolNode&) ;
		bool compareSubprojects(SymbolNode&, int, SymbolNode&, int) ;
		bool compareFiles(SymbolNode&, int, SymbolNode&, int) ;
		void comparePackages(SymbolNode&, int, SymbolNode&, int) ;
		virtual void execute(RootNode*) ;

	public:

		ComparePhase() : theMetricCompBuff(NULL,100,true) , theSymbolCompBuff(NULL,100,true), theSymbolDelBuff(NULL,100,true)
		{
			theProgress = 0 ;

#ifdef WIN32
			progress_lock=CreateMutex(NULL,FALSE,NULL);
#elif sun
			mutex_init(&progress_lock,0,NULL);
#elif hpux
			pthread_mutex_init(&progress_lock,pthread_mutexattr_default);
#elif linux
			pthread_mutex_init(&progress_lock,NULL);
#endif

			LOCKMUTEX(progress_lock) ;

			//theTotalChangedLines = theTotalDeletedLines = theTotalInsertedLines = 0 ;

			theProjectChanged = false ;
		}

		int getProgress() { return -1 ; }
		virtual void execute(RootNode*, int, RootNode*, int) ;
	} ;


} ;

#endif
