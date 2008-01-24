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

#include "Buffer.h"
#include "Link.h"
#include "MasterData.h"
#include "MetricPhase.h"
#include "ResolvePhase.h"
#include "XrefPhase.h"
#include "ComparePhase.h"
#include "PopulatePhase.h"
#include "RootNode.h"
#include "SymbolNode.h"
using namespace metrics ;

#include <iostream>
#include <fstream>
using namespace std ;

#include <math.h>

#define CMD_OPTION_LOG "-logfile"
#define DEFAULT_LOG "log/metrics.log"
#define LIMIT 20

#ifdef WIN32
HANDLE current_phase_lock ;
HANDLE finished_lock ;
HANDLE log_lock ;
#elif sun
mutex_t current_phase_lock;
mutex_t finished_lock;
mutex_t log_lock;
#elif hpux
pthread_mutex_t current_phase_lock;
pthread_mutex_t finished_lock;
pthread_mutex_t log_lock;
#elif linux
pthread_mutex_t current_phase_lock;
pthread_mutex_t finished_lock;
pthread_mutex_t log_lock;
#endif

#define POPULATING 0
#define ANALYSING 1
#define COMMITTING 2
#define COMPARING 3
#define FINISHING 4
#define IGNORING 5
#define RESOLVING 6
#define XREFING 7
#define SAVING 8

#ifdef PM
	#ifdef PROFESSIONAL
	#else
		#define POPULATING_WEIGHT 70
		#define RESOLVING_WEIGHT 0
		#define XREFING_WEIGHT 0
		#define COMMITTING_WEIGHT 10
		#define ANALYSING_WEIGHT 4
		#define SAVING_WEIGHT 4
		#define COMPARING_WEIGHT 8
		#define FINISHING_WEIGHT 4
	#endif
#else
	#ifdef PROFESSIONAL
		#define POPULATING_WEIGHT 25
		#define RESOLVING_WEIGHT 20
		#define XREFING_WEIGHT 20
		#define COMMITTING_WEIGHT 5
		#define ANALYSING_WEIGHT 25
		#define SAVING_WEIGHT 0
		#define COMPARING_WEIGHT 0
		#define FINISHING_WEIGHT 5
	#else
		#define POPULATING_WEIGHT 75
		#define RESOLVING_WEIGHT 0
		#define XREFING_WEIGHT 0
		#define COMMITTING_WEIGHT 10
		#define ANALYSING_WEIGHT 10
		#define SAVING_WEIGHT 0
		#define COMPARING_WEIGHT 0
		#define FINISHING_WEIGHT 5
	#endif
#endif


vector<RootNode*> roots ;
vector<string> baseDirs ;
vector<string> projNames ;
vector<string> transFiles ;
int currentRoot ;
int nRoots = 0 ;

// Shared by progress_thread & buildProgressText
int currPhaseProgress, currRoot ;
char progressText[512] ;

#define CALC_PROGRESS(W,C,P) W + (((float)C / (float)nRoots) * (float)currRoot) + (((float)C / (float)nRoots) * ((float)P/(float)100))

bool finished ;
Phase *currentPhase ;
int currentStage = -1 ;


void buildProjNames() {

	OurSQL controlDb("control") ;
	char sql[512] ;

	controlDb.connect() ;

	for(int i=0; i<nRoots; i++) {

		string projName="" ;

		strcpy(sql, "select prjName from project where prjID='") ;
		strcat(sql, projNames[i].c_str()) ;
		strcat(sql, "'") ;

		if (controlDb.executeQuery(sql)) {
			projNames[i] = controlDb.cell(0,0) ;
		}
	}
}

#define BUFFSIZE 30

char *buildProgressText(int prevPhasesTotal, int currPhaseTotal, char *prog, bool showName)
{
	char buff[BUFFSIZE] ;

	float overallProgress = CALC_PROGRESS(prevPhasesTotal,currPhaseTotal,currPhaseProgress) ;

#if defined(PROFESSIONAL) || defined(PM)
	float stageProgress = CALC_PROGRESS(0,100,currPhaseProgress) ;

	strcpy(progressText, ltostr(((long)stageProgress),buff,BUFFSIZE)) ;
	strcat(progressText, ",") ;
	strcat(progressText, ltostr((long)overallProgress,buff,BUFFSIZE)) ;
	strcat(progressText, ",") ;
	strcat(progressText, prog) ;
#if defined(PM)
	if (showName) {
		strcat(progressText, " (") ;
		strcat(progressText, projNames[currRoot].c_str()) ;
		strcat(progressText, ")") ;
	}
#endif

#else
	strcpy(progressText, ltostr(overallProgress,buff,BUFFSIZE)) ;
#endif

	return progressText ;
}



THR_RET_TYPE progress_thread(void* in)
{
	//string input = "";
	char input[128] ;

	do
	{
        int tmpCurrentStage ;

		try {
			//input = "" ;
			//cin >> input;
			strcpy(input,"");
			cin.clear() ;
			cin.getline(input,128) ;
			if (!strcmp(input,"progress"))
			{
				if (SAFELOCKMUTEX(current_phase_lock))
				{
					tmpCurrentStage = currentStage ;
					UNLOCKMUTEX(current_phase_lock) ;


					switch (tmpCurrentStage) {
					case POPULATING:
						{
							if (SAFELOCKMUTEX(current_phase_lock))
							{
								currPhaseProgress = currentPhase->getProgress() ;
								currRoot = currentRoot ;
								UNLOCKMUTEX(current_phase_lock) ;

								buildProgressText(0, POPULATING_WEIGHT,
									"Parsing", true) ;

								MasterData::theLog << "POPULATING " << progressText << endl ;
								cout << progressText << endl ;
							}
							break ;
						}
					case RESOLVING:
						{
							if (SAFELOCKMUTEX(current_phase_lock))
							{
								currPhaseProgress = currentPhase->getProgress() ;
								currRoot = currentRoot ;
								UNLOCKMUTEX(current_phase_lock) ;

								buildProgressText(POPULATING_WEIGHT,RESOLVING_WEIGHT,
									"Resolving Types", false) ;

								MasterData::theLog << "RESOLVING " << progressText << endl ;
								cout << progressText << endl ;
							}
							break ;
						}
					case XREFING:
						{
							if (SAFELOCKMUTEX(current_phase_lock))
							{
								currPhaseProgress = currentPhase->getProgress() ;
								currRoot = currentRoot ;
								UNLOCKMUTEX(current_phase_lock) ;

								buildProgressText(POPULATING_WEIGHT+RESOLVING_WEIGHT,
									XREFING_WEIGHT, "X-Referencing", false) ;

								MasterData::theLog << "XREFING " << progressText << endl ;
								cout << progressText << endl ;
							}
							break ;
						}
					case COMMITTING:
						{
							if (SAFELOCKMUTEX(current_phase_lock))
							{
								currRoot = currentRoot ;
								currPhaseProgress = roots[currRoot]->getProgress() ;
								UNLOCKMUTEX(current_phase_lock) ;

								buildProgressText(POPULATING_WEIGHT+RESOLVING_WEIGHT+XREFING_WEIGHT,
									COMMITTING_WEIGHT, "Committing", true) ;

								MasterData::theLog << "COMMITTING " << progressText << endl ;
								cout << progressText << endl ;
							}
							break ;
						}
					case ANALYSING:
						{
							if (SAFELOCKMUTEX(current_phase_lock))
							{
								currPhaseProgress = currentPhase->getProgress() ;
								currRoot = currentRoot ;
								UNLOCKMUTEX(current_phase_lock) ;

								buildProgressText(POPULATING_WEIGHT+RESOLVING_WEIGHT+XREFING_WEIGHT+COMMITTING_WEIGHT,
									ANALYSING_WEIGHT, "Calculating Metrics", true) ;

								MasterData::theLog << "ANALYSING " << progressText << endl ;
								cout << progressText << endl ;
							}
							break ;
						}
					case SAVING:
						{
							if (SAFELOCKMUTEX(current_phase_lock))
							{
								currRoot = currentRoot ;
								currPhaseProgress = roots[currRoot]->getProgress() ;
								UNLOCKMUTEX(current_phase_lock) ;

								buildProgressText(POPULATING_WEIGHT+RESOLVING_WEIGHT+XREFING_WEIGHT+COMMITTING_WEIGHT+ANALYSING_WEIGHT,
									SAVING_WEIGHT, "Saving Metrics", true) ;

								MasterData::theLog << "COMMITTING " << progressText << endl ;
								cout << progressText << endl ;
							}
							break ;
						}
					case COMPARING:
						{
							if (SAFELOCKMUTEX(current_phase_lock))
							{
								//currPhaseProgress = currentPhase->getProgress() ;
								currPhaseProgress = 50 ;
								currRoot = currentRoot ;
								UNLOCKMUTEX(current_phase_lock) ;

								buildProgressText(POPULATING_WEIGHT+RESOLVING_WEIGHT+XREFING_WEIGHT+COMMITTING_WEIGHT+ANALYSING_WEIGHT+SAVING_WEIGHT,
									COMPARING_WEIGHT, "Comparing Projects", false) ;

								MasterData::theLog << "COMPARING " << progressText << endl ;
								cout << progressText << endl ;
							}
							break ;
						}
					case FINISHING:
						{
							if (SAFELOCKMUTEX(current_phase_lock))
							{
								currRoot = currentRoot ;
								currPhaseProgress = roots[currRoot]->getProgress() ;
								UNLOCKMUTEX(current_phase_lock) ;

								buildProgressText(POPULATING_WEIGHT+RESOLVING_WEIGHT+XREFING_WEIGHT+COMMITTING_WEIGHT+ANALYSING_WEIGHT+SAVING_WEIGHT+COMPARING_WEIGHT,
									FINISHING_WEIGHT, "Finishing", true) ;

								MasterData::theLog << "FINISHING " << progressText << endl ;
								cout << progressText << endl ;
							}
							break ;
						}
					case IGNORING:
						{
#ifdef PROFESSIONAL
								MasterData::theLog << "IGNORING " << 100 << "," << 99 << ",Please Wait" << endl ;
								cout << 100 << "," << 99 << ",Please Wait" << endl ;
#elif PM
								MasterData::theLog << "IGNORING " << 100 << "," << 99 << ",Please Wait" << endl ;
								cout << 100 << "," << 99 << ",Please Wait" << endl ;
#else
								MasterData::theLog << "IGNORING " << 99 << endl ;
								cout << 99 << endl ;
#endif
						}
					default:
						{
							MasterData::theLog << "DEFAULT" << endl ;
							cout << "0" << endl ;
						}
					}
				} else {
					MasterData::theLog << "TIMEOUT" << endl ;
					cout << "0" << endl ;
				}
			}
			else if (!strcmp(input,"bye"))
			{
				return 0 ;
			}
			else
			{
					//MasterData::theLog << "input: " << input << endl ;
			}

		} catch (...) {

			MasterData::theLog << "Exception in progress thread - quitting" << endl ;
			cout << "100" << endl ;
			break ;
		}
	}
#ifdef WIN32
    while (!(SAFELOCKMUTEX(finished_lock))) ;
#elif sun
	while (mutex_trylock(&finished_lock)) ;
#endif

//	MasterData::theLog << "mark11" << endl ;
	return 0 ;

}

const string java[] = {"Diff.java","UpdateNotifier.java",
	"FileChooserFactory.java","FileCopy.java","History.java",
	"IntVector.java","LogViewer.java","ObjectCloner.java",
	"ObservableObject.java","PUtilities.java","StringVector.java",
	"TempDir.java","ExtensionFileFilter.java"} ;


THR_RET_TYPE my_main_thread(void* in)
{
	string name(""), baseDir(""), transFile("") ;
	int freshBuild ;
	RootNode *root ;
	int i ;

	LOCKMUTEX(log_lock) ;
	LOCKMUTEX(finished_lock) ;

	MasterData::theLog << "STARTING\n========" << endl ;

	char tmpstr[1024] ;
	cin >> name  ;

	while (name.compare("END"))
	{
		MasterData::theLog << "Project:   " << name.c_str() << endl ;
//		cin >> baseDir ;
		cin.ignore() ;
		cin.getline(tmpstr,1024) ;
		baseDir = tmpstr ;
		MasterData::theLog << "BaseDir:   " << baseDir.c_str() << endl ;
//		cin >> transFile ;
//#ifdef LANGUAGE_CPP
		cin.getline(tmpstr,1024) ;
		transFile = tmpstr ;
		MasterData::theLog << "TransFile: " << transFile.c_str() << endl ;
//#endif
		cin >> freshBuild ;
		MasterData::theLog << "Initial:   " << freshBuild << endl ;

		root = new RootNode(name,1) ;
		//root->setFreshBuild(freshBuild==1) ;
		root->setFreshBuild(true) ;
		roots.push_back(root) ;
		baseDirs.push_back(baseDir) ;
		transFiles.push_back(transFile) ;
		projNames.push_back(name) ;

		cin >> name ;
	}

	if (roots.size() == 0) return 0 ;

	nRoots = roots.size() ;
	buildProjNames() ;

	MasterData::theLog << "\n\n== PopulatePhase ========================================\n\n" << endl ;

	LOCKMUTEX(current_phase_lock) ;

#ifdef WIN32
	DWORD id ;
	THREAD_IDENTIFIER progressIdentifier = BEGINTHREAD(progress_thread,&id) ;
	SetThreadPriority(progressIdentifier,THREAD_PRIORITY_BELOW_NORMAL) ;
#elif sun
	THREAD_IDENTIFIER progressIdentifier ;
	BEGINTHREAD(progress_thread,&progressIdentifier) ;
	int priority ;
	thr_getprio(progressIdentifier,&priority) ;
	thr_setprio(progressIdentifier,priority+10) ;
#endif


	PopulatePhase *populate = new PopulatePhase() ;
	currentPhase = populate ;
	currentStage = POPULATING ;

	for (i=0; i < nRoots; i++)
	{
		currentRoot = i ;
		UNLOCKMUTEX(current_phase_lock) ;

		if (transFiles[i].compare("NULL") != 0) {
			populate->setTranslationFile(transFiles[i]) ;
		}

		populate->execute(roots[i]) ;

		LOCKMUTEX(current_phase_lock) ;
	}

#ifdef PROFESSIONAL

	MasterData::theLog << "\n\n== ResolvePhase ==========================================\n\n" << endl ;

	ResolvePhase* resolve = new ResolvePhase() ;
	currentPhase = resolve ;
	currentStage = RESOLVING ;
	for (i=0; i < nRoots; i++)
	{
		currentRoot = i ;
		UNLOCKMUTEX(current_phase_lock) ;

		resolve->execute(roots[i]) ;

		LOCKMUTEX(current_phase_lock) ;
	}


	MasterData::theLog << "\n\n== XRefPhase =============================================\n\n" << endl ;

	XrefPhase* xref = new XrefPhase() ;
	currentPhase = xref ;
	currentStage = XREFING ;
	for (i=0; i < nRoots; i++)
	{
		currentRoot = i ;
		UNLOCKMUTEX(current_phase_lock) ;

		xref->execute(roots[i]) ;

		LOCKMUTEX(current_phase_lock) ;
	}

#endif

	MasterData::theLog << "\n\n== Committing ============================================\n\n" << endl ;

	currentPhase = NULL ;
	currentStage = COMMITTING ;

	for (i=0; i < nRoots; i++)
	{
		currentRoot = i ;
		UNLOCKMUTEX(current_phase_lock) ;

		roots[i]->commit() ;

		LOCKMUTEX(current_phase_lock) ;
	}

	MasterData::theLog << "\n\n== MetricPhase ===========================================\n\n" << endl ;

	MetricPhase* metric = new MetricPhase() ;
	currentPhase = metric ;
	currentStage = ANALYSING ;

	for (i=0; i < nRoots; i++)
	{
		currentRoot = i ;
		UNLOCKMUTEX(current_phase_lock) ;

		metric->execute(roots[i]) ;

		LOCKMUTEX(current_phase_lock) ;
	}

#ifdef PM

	if (nRoots > 1)
	{
		MasterData::theLog << "\n\n== Saving ===============================================\n\n" << endl ;

		currentPhase = NULL ;
		currentStage = SAVING ;

		for (i=0; i < nRoots; i++)
		{
			currentRoot = i ;
			UNLOCKMUTEX(current_phase_lock) ;

			roots[i]->commit() ;

			LOCKMUTEX(current_phase_lock) ;
		}

		MasterData::theLog << "\n\n== ComparePhase =========================================\n\n" << endl ;

		ComparePhase* comp = new ComparePhase() ;
		currentPhase = NULL ;
		currentStage = COMPARING ;
		UNLOCKMUTEX(current_phase_lock) ;

		MasterData::theLog << baseDirs[0] << " baseDirs[0].size() = " << baseDirs[0].size() << "\n" <<
			baseDirs[1] << " baseDirs[1].size() = " << baseDirs[1].size() << endl ;

		comp->execute(roots[0],baseDirs[0].size(),roots[1],baseDirs[1].size()) ;

		LOCKMUTEX(current_phase_lock) ;
		delete comp ;
		currentPhase = NULL ;
	}

#endif

	MasterData::theLog << "\n\n== Finishing =============================================\n\n" << endl ;

	currentPhase = NULL ;
	currentStage = FINISHING ;

	for (i=0; i < nRoots; i++)
	{
		currentRoot = i ;
		UNLOCKMUTEX(current_phase_lock) ;

		roots[i]->commit() ;

		LOCKMUTEX(current_phase_lock) ;
	}

	MasterData::theLog << "\n\n== Building Ancestry =====================================\n\n" << endl ;
	for (i=0; i < nRoots; i++)
	{
		roots[0]->buildAncestry() ;
	}

	MasterData::theLog << "\n\n== Deleting Roots ========================================\n\n" << endl ;

	currentStage = IGNORING ;

	UNLOCKMUTEX(current_phase_lock) ;

	for (i=0; i < nRoots; i++)
	{
//		roots[i]->deleteTempLinks() ;
		delete roots[i] ;
	}

	UNLOCKMUTEX(finished_lock) ;

#ifdef WIN32
	TerminateThread(progressIdentifier,0) ;
#endif

	UNLOCKMUTEX(log_lock) ;

	return 0 ;
}


char *options(int argc, char **argv) {
	char *dirname = NULL ;

	for (int i=0; i<argc; i++) {
		dirname = strstr(argv[i], CMD_OPTION_LOG) ;
		if (dirname != NULL) {
			if (strlen(argv[i]) > strlen(CMD_OPTION_LOG)) {
				dirname += strlen(CMD_OPTION_LOG) ;

				return dirname ;
			}

			if (i < argc-1) return argv[i+1] ;
		}
	}

	return dirname ;
}


#ifdef WIN32
int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow)
{
	MasterData::theLog.open(DEFAULT_LOG) ;

#else
int main(int argc, char **argv)
{
	char *logfile = options(argc, argv) ;

	if (logfile != NULL) {
		MasterData::theLog.open(logfile) ;
	} else {
		MasterData::theLog.open(DEFAULT_LOG) ;
	}

#endif

#ifdef WIN32
	current_phase_lock=CreateMutex(NULL,FALSE,NULL) ;
	finished_lock=CreateMutex(NULL,FALSE,NULL) ;
	log_lock=CreateMutex(NULL,FALSE,NULL) ;
//	killProgress_lock=CreateMutex(NULL,FALSE,NULL) ;
#elif sun
	mutex_init(&current_phase_lock,0,NULL);
	mutex_init(&finished_lock,0,NULL);
	mutex_init(&log_lock,0,NULL);
#elif hpux
	pthread_mutex_init(&current_phase_lock,pthread_mutexattr_default);
	pthread_mutex_init(&finished_lock,pthread_mutexattr_default);
	pthread_mutex_init(&log_lock,pthread_mutexattr_default);
#elif linux
	pthread_mutex_init(&current_phase_lock,NULL);
	pthread_mutex_init(&finished_lock,NULL);
	pthread_mutex_init(&log_lock,NULL);
#endif

#ifdef WIN32
	DWORD id ;
	THREAD_IDENTIFIER mainThreadIdentifier = BEGINTHREAD(my_main_thread,&id) ;
	SetThreadPriority(mainThreadIdentifier,THREAD_PRIORITY_LOWEST) ;
#elif sun
	THREAD_IDENTIFIER mainThreadIdentifier ;
	BEGINTHREAD(my_main_thread,&mainThreadIdentifier) ;
	int priority ;
	thr_getprio(mainThreadIdentifier,&priority) ;
	if (priority>20)
		thr_setprio(mainThreadIdentifier,priority-20) ;
	else
		thr_setprio(mainThreadIdentifier,1) ;
#endif


#ifdef WIN32
	WaitForSingleObject(mainThreadIdentifier,INFINITE);
#elif sun
	thr_join(mainThreadIdentifier,NULL,NULL) ;
#endif

#ifdef WIN32
	ExitProcess(0) ;
#endif

	return 0 ;
}
