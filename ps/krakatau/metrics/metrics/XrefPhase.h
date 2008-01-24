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

#ifndef METRICS_XREFPHASE
#define METRICS_XREFPHASE

#include <iostream>
#include <vector>
#include <string>

#include "Component.h"
#include "MasterData.h"
#include "Phase.h"
#include "RootNode.h"
#include "SymbolNode.h"
#include "TempLink.h"

namespace metrics
{
	class XrefPhase : public Phase, Component
	{
	private:

		float theStage ;
		float theNoStages ;

	protected:

#ifdef WIN32
		HANDLE progress_lock;
#elif sun
		mutex_t progress_lock;
#elif hpux
		pthread_mutex_t progress_lock;
#elif linux
		pthread_mutex_t progress_lock;
#endif

		bool findProgramElement(SymbolNode&, const char *, int, SymbolNode&) ;
		SymbolNode findMethodWithSameName(SymbolNode&) ;

		void resolveCrossRef(SymbolNode&, std::string, long) ;
		void resolve(SymbolNode&) ;

	public:

		XrefPhase()
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

			//MasterData::theLog << "XrefPhase() about to lock progress_lock." << endl;

			theStage = 0 ;
			theNoStages = 1 ;
		}

		int getProgress() ;
		void execute(RootNode*) ;
	} ;


} ;

#endif