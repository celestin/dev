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

#ifndef METRICS_RESOLVEPHASE
#define METRICS_RESOLVEPHASE

#include <string>
#include <vector>

#include "Component.h"
#include "Phase.h"

namespace metrics
{

	class ResolvePhase : public Phase, Component
	{
	private:

		static const int inheritance ;
		static const int external ;
		static const int references ;
		static const int committing ;

		//bool typeComponentLocate(std::string name,SymbolNode &referrer,SymbolNode &ret) ;
		long typeComponentLocate(std::string name,SymbolNode &referrer,SymbolNode &ret) ;
		//bool locateTypeFromClass(std::string name,SymbolNode &referrer,SymbolNode &ret) ;
		long locateTypeFromClass(std::string name,SymbolNode &referrer,SymbolNode &ret) ;
		void resolveTypeReference(SymbolNode &item) ;
		void resolveInheritance(SymbolNode &item) ;

		long theStage ;
		long currentNode ;
		long totalNodes ;
		std::vector<long> theResolvedIDs ;

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

		long progress ;

#ifdef LANGUAGE_JAVA
		void resolveImports(SymbolNode &) ;
#endif
		void resolveExternalMethod(SymbolNode &) ;
		void resolve(SymbolNode &) ;
		bool previouslyResolved(int) ;

	public:

		ResolvePhase()
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

			//theStage = 0 ;
			progress = 0 ;
			currentNode = 0 ;
			totalNodes = 1 ;


//			LOCKMUTEX(progress_lock) ;
		}

		int getProgress() ;
		virtual void execute(RootNode *root) ;
	} ;


} ;

#endif
