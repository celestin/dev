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

#ifndef METRICS_METRICPHASE
#define METRICS_METRICPHASE

#include <iostream>
#include <list>
#include <vector>
#include <string>

#include <math.h>

#include "Utilities.h"
#include "MasterData.h"
#include "Phase.h"
#include "RootNode.h"
#include "Subproject.h"
#include "SymbolNode.h"

namespace metrics
{
	class MetricPhase : public Phase
	{

#ifdef PROFESSIONAL

		class DepthItem
		{
		public:
			long theID ;
			long theDepth ;

			DepthItem() { theID = 0 ; theDepth = 0 ; }
			virtual ~DepthItem() {}
			DepthItem(long newID, long newDepth)
			{
				theID = newID ; theDepth = newDepth ;
			}
			bool operator>(DepthItem &di)
			{
				return (theDepth > di.theDepth) ;
			}
			bool deeper(DepthItem &di)
			{
				return ((theID == di.theID) && (theDepth >= di.theDepth)) ;
			}
			void sinkTo(DepthItem &di) { theDepth = di.theDepth ; }
		} ;

#endif

	private:

		float theStage ;
		float theNoStages ;

//		long theNumMethods ;
//		long theNumClasses ;
//		long theNumFiles ;

		SymbolNode theProjNode ;

		// Class Metric Storage
//		float theInheritenceTreeSize ;

		// Project Metric Storage
//		float theLOC ;
//		float theSLOC ;
//		float theWLOC ;
//		float theCCOM ;
//		float theCPPCOM ;
#ifdef LANGUAGE_CPP
//		float theTLOC ;
#elif LANGUAGE_JAVA
//		float theJCOM ;
#endif
//		float theCOM ;
//		float theNSC ;
//		float theMLOC ;

#ifdef PROFESSIONAL
//		float theFieldV ;	// Sum of V for Fields in all classes
//		float theFieldTC ;	// Total Fields in all classes
//		float theMethodV ;	// Sum of V for Methods in all classes
//		float theMethodTC ;	// Total Methods in all classes

//		float theV ;		// aveV - avg Halstead volume
//		float theVg ;		// aveV(g') - avg extended cyclomatic complexity

		float theHIER ;
		float theDEPTH ;
		float theAVPATHS ;
		float thePDIT ;		// Depth of Inheritance Tree (Project)

//		float theInherAttrib ;
//		float theTotalAttrib ;
//		float theInherOp ;
//		float theTotalOp ;
//		float theOpsOver ;
//		float theAddSub ;

#endif

		float *theMetrics ;


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
		// FILE Metrics
		void summariseFile(SymbolNode&) ;
#ifdef PROFESSIONAL
		void calc_NTopLevel(SymbolNode&) ;
#endif

		// METHOD Metrics
		float calc_Statements(SymbolNode&) ;
		void calc_QCP(SymbolNode&) ;

#ifdef PROFESSIONAL
		void calc_NnVDE(SymbolNode&, bool) ;
		float calc_ECC(SymbolNode&) ;
		float calc_CALLS(SymbolNode&) ;
		float calc_OAC(SymbolNode&) ;
		void calc_NP(SymbolNode&) ;
		void calc_RLOC(SymbolNode&) ;

		void buildDepthGauge(int depth, SymbolNode &sn, std::vector<DepthItem>& depthGauge) ;
		void calc_DEPTH(SymbolNode&) ;
		int pathsFrom(SymbolNode&, std::vector<long>&) ;


		// CLASS Metrics
		void traverseAddedEntities(SymbolNode&, long, int&,	std::vector<std::string>&) ;
		int countAddedEntities(SymbolNode&, long) ;
		void traverseInherited(SymbolNode&, long, int&) ;
		int countInherited(SymbolNode&, long) ;

		void calc_Members(SymbolNode&) ;

#ifdef LANGUAGE_JAVA
		void calc_InterfaceMembers(SymbolNode&) ;
		void calc_NOCI(SymbolNode &) ;
		void calc_PACK_NORC(SymbolNode &) ;
#endif

		int determineDIT(SymbolNode&) ;
		void calc_DIT(SymbolNode&) ;

		void calc_NOCC(SymbolNode&) ;
		void calc_CBO(SymbolNode&) ;
		void calc_RFC(SymbolNode&) ;

		void calc_LCOM(SymbolNode&) ;
		bool checkIntersection(const long *a, const long *b) ;

		void calc_Inheritence(SymbolNode&) ;
		void calc_WMC(SymbolNode&) ;
		void calc_PA(SymbolNode&) ;
		void calc_AC(SymbolNode&) ;
		void calc_InheritenceTreeSize(SymbolNode&) ;

		void calculateClassMetrics(SymbolNode&, bool classMember) ;
#endif


		// PROJECT Metrics
		void calculateProjectAverages() ;
		void initialiseProject() ;
		void addMetrics(SymbolNode&) ;

#ifdef PROFESSIONAL
		float calc_V(SymbolNode&) ;
		void calc_HidingFactors() ;
		void calc_InheritenceFactors() ;
		void calc_POF() ;
		void calc_NORC() ;
		int countUniqueWithLinks(long) ;
		void calc_ProjectDepth() ;
		void calculateProjectMetrics() ;
#endif

		void nextStage()
		{
			LOCKMUTEX(progress_lock) ;
			theStage++ ;
			UNLOCKMUTEX(progress_lock) ;
		}

		void calculateMetrics(SymbolNode&) ;

#ifndef PROFESSIONAL
		void calc_Complexity(SymbolNode&) ;
#endif

	public:

		MetricPhase() ;
		virtual ~MetricPhase() ;

		int getProgress() ;
		void execute(RootNode*) ;

	} ;

} ;

#endif
