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

#ifndef METRICS_MASTERDATA
#define METRICS_MASTERDATA

#include <map>
#include <fstream>
//#include "LogOFStream.h"

#include <string.h>
#include <math.h>


#include "AutoNumber.h"
//#include "Buffer.h"
//#include "OurSQL.h"


#ifdef WIN32

#include <io.h>
#include <process.h>
#include <windows.h>
//#include <winbase.h>

#define THREAD_IDENTIFIER HANDLE
#define LOCKMUTEX(x) WaitForSingleObject(x,INFINITE)
#define SAFELOCKMUTEX(x) WaitForSingleObject(x,5000 )!=WAIT_TIMEOUT
#define UNLOCKMUTEX(x) ReleaseMutex(x)
#define BEGINTHREAD(x,y) CreateThread(NULL,0,x,NULL,0,y)
#define ENDTHREAD(x) ExitThread(x)
#define THR_RET_TYPE unsigned long _stdcall

#elif sun

#include <thread.h>
#include <synch.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

#define THREAD_IDENTIFIER thread_t
#define LOCKMUTEX(x) mutex_lock(&x)
#define SAFELOCKMUTEX(x) !mutex_lock(&x)
#define UNLOCKMUTEX(x) mutex_unlock(&x)
#define BEGINTHREAD(x,y) thr_create(NULL,0,x,NULL,THR_NEW_LWP,y)
#define ENDTHREAD thr_exit(NULL)
#define THR_RET_TYPE void *

#elif hpux

#include <pthread.h>
#undef write
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

#define LOCKMUTEX(x) pthread_mutex_lock(&x)
#define SAFELOCKMUTEX(x) pthread_mutex_lock(&x)
#define UNLOCKMUTEX(x) pthread_mutex_unlock(&x)
#define BEGINTHREAD(x) pthread_create(&mythr,pthread_attr_default,x,NULL)
#define ENDTHREAD pthread_exit(NULL)
#define THR_RET_TYPE void *
pthread_t mythr;

#elif linux

#include <pthread.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

#define LOCKMUTEX(x) pthread_mutex_lock(&x)
#define SAFELOCKMUTEX(x) pthread_mutex_lock(&x)
#define UNLOCKMUTEX(x) pthread_mutex_unlock(&x)
#define BEGINTHREAD(x) pthread_create(&mythr,NULL,x,NULL)
#define ENDTHREAD pthread_exit(NULL)
#define THR_RET_TYPE void *
pthread_t mythr;
#endif

char *dtoa(double d, char *buff, int buffsize) ;
char *ltostr(long l) ;
char *ltostr(long l, char *buff, int buffsize) ;


namespace metrics
{
	class OurSQL ;

	class MasterData
	{
	private:

		MasterData() {;}


		AutoNumber theCurrentTypeID ;

		// Metric Type Group ID counters
		static int theCommonCat ;
		static int theProjectCat ;
#ifdef LANGUAGE_JAVA
		static int thePackageCat ;
#endif
		static int theFileCat ;
		static int theClassCat ;
		static int theInterfaceCat ;
		static int theMethodCat ;


	public:

		static std::ofstream theLog ;
		//static LogOFStream theLog ;


		//OurSQL theDBConnection ;
		//Buffer theBuffer ;
		//Buffer theTempBuffer ;

		// == COMMON DEFINITIONS =======================

		// Categories
		static const int PROJECT_CAT ;
		static const int PACKAGE_CAT ;
		static const int NAMESPACE_CAT ;
		static const int FILE_CAT ;
		static const int CLASS_CAT ;
		static const int INTERFACE_CAT ;
		static const int METHOD_CAT ;
		static const int FIELD_CAT ;

		// Links
		static const int XREF_LINK ;
		static const int SUPER_LINK ;
		static const int SUB_LINK ;
		static const int PACKAGE_LINK ;
		static const int IMPORT_LINK ;
		static const int IMPLEMENTS_LINK ;
		static const int PARAMETER_LINK ;
		static const int TYPE_LINK ;

		// Protection Levels
		static const int PACKAGE_PROT ;
		static const int PUBLIC_PROT ;
		static const int PROTECTED_PROT ;
		static const int PRIVATE_PROT ;

		// Fundamental Types
		static const int INT_T ;
		static const int LONG_T ;
		static const int SHORT_T ;
		static const int FLOAT_T ;
		static const int DOUBLE_T ;
		static const int BYTE_T ;
		static const int CHAR_T ;
		static const int WORD_T ;
		static const int BOOL_T ;
		static const int VOID_T ;
		static const int USERTYPES ;

		// Changed States
		static const int CHANGED_STATE ;
		static const int UNCHANGED_STATE ;
		static const int NEW_STATE ;
		static const int DELETED_STATE ;


		// == METRICS =============================

		// Metric ID Calculation
		static const int METRIC_FACTOR ;

		static const int ABSOLUTE_METCAT ;
		static const int DELTA_METCAT ;

		// Metric Groups
		/*static const int COMMON_MTG ;
		static const int PROJECT_MTG ;
		static const int FILE_MTG ;
		static const int CLASS_MTG ;
		static const int INTERFACE_MTG ;
		static const int METHOD_MTG ;*/

		// Common Metrics
		static const int LOC_MET ;
		static const int SLOC_MET ;
		static const int NION_MET ;
		static const int ANION_MET ;
		static const int N1_MET ;
		static const int N2_MET ;
		static const int n1_MET ;
		static const int n2_MET ;
		static const int NSC_MET ;
		static const int CONTROL_MET ;
		static const int EXECUTABLE_MET ;
		static const int COM_MET ;
		static const int CCOM_MET ;
		static const int CPPCOM_MET ;
#ifdef LANGUAGE_JAVA
		static const int JCOM_MET ;
#endif
		static const int OC_MET ;
		static const int CYCLO_MET ;
		static const int EVG_MET ;
		static const int BRANCH_MET ;
		static const int NEST_MET ;
		static const int N_MET ;
		static const int n_MET ;
		static const int V_MET ;
		static const int D_MET ;
		static const int E_MET ;
		static const int B_MET ;
		static const int WLOC_MET ;


		// Project Metrics
		static const int MHF_MET ;
		static const int AHF_MET ;
		static const int MIF_MET ;
		static const int AIF_MET ;
		static const int POF_MET ;
		static const int COF_MET ;
		static const int HIER_MET ;
		static const int AVPATHS_MET ;
		static const int PROJDEPTH_MET ;
		static const int PDIT_MET ;
		static const int COM_RAT_MET ;
		static const int TCOM_RAT_MET ;
		static const int SEIMI_MET ;
		static const int NCLASS_MET ;
#ifdef LANGUAGE_JAVA
		static const int NINTER_MET ;
#endif
		static const int NFILE_MET ;
		static const int NMETH_MET ;
		static const int NORC_MET ;
		static const int ACLOC_MET ;
		static const int AMLOC_MET ;
		static const int P_CHG_LOC_MET ;
		static const int P_DEL_LOC_MET ;
		static const int P_INS_LOC_MET ;
#ifdef PM
		static const int CHG_FILE_MET ;
		static const int DEL_FILE_MET ;
		static const int INS_FILE_MET ;

#ifdef LANGUAGE_JAVA
		static const int CHG_PACK_MET ;
		static const int DEL_PACK_MET ;
		static const int INS_PACK_MET ;
#endif

		static const int CHG_CLASS_MET ;
		static const int DEL_CLASS_MET ;
		static const int INS_CLASS_MET ;

		static const int CHG_METH_MET ;
		static const int DEL_METH_MET ;
		static const int INS_METH_MET ;
#endif
		static const int SUMV_MET ;
		static const int SUMVG_MET ;
		static const int SUM_INH_ATT_MET ;
		static const int SUM_INH_ATT_TOT_MET ;
		static const int SUM_INH_OP_MET ;
		static const int SUM_INH_OP_TOT_MET ;
		static const int SUM_OV_OP_MET ;
		static const int SUM_ADD_SUB_MET ;
		static const int MLOC_MET ;
		static const int CLOC_MET ;
		static const int FIELDV_MET ;
		static const int FIELDTC_MET ;
		static const int METHODV_MET ;
		static const int METHODTC_MET ;
		static const int INH_MET ;


#ifdef LANGUAGE_JAVA
		// Package Metrics
		static const int PACK_NFILE_MET ;
		static const int PACK_NTC_MET ;
		static const int PACK_NTI_MET ;
#endif

		// File Metrics
		static const int FILE_COM_RAT_MET ;
		static const int FILE_TCOM_RAT_MET ;
		static const int NTC_MET ;
#ifdef LANGUAGE_CPP
		static const int NTM_MET ;
#elif LANGUAGE_JAVA
		static const int NTI_MET ;
#endif
		static const int CHG_LOC_MET ;
		static const int DEL_LOC_MET ;
		static const int INS_LOC_MET ;

		// Class Metrics
		static const int CSA_MET ;
		static const int CSO_MET ;
		static const int CSAO_MET ;
		static const int PAPAPAPC_MET ;
		static const int NOCC_MET ;
		static const int DIT_MET ;
		static const int RFC_MET ;
		static const int CBO_MET ;
		static const int LCOM_MET ;
		static const int NOOC_MET ;
		static const int NOAC_MET ;
		static const int NAAC_MET ;
		static const int NOIC_MET ;
		static const int NAIC_MET ;
		static const int WMC_MET ;
		static const int CSI_MET ;
		static const int OSavg_MET ;
		static const int NPavgC_MET ;
		static const int PA_MET ;
		static const int AC_MET ;
#ifdef LANGUAGE_CPP
		static const int TLOC_MET ;
#endif

		// Interface Metrics
		static const int ISA_MET ;
		static const int ISO_MET ;
		static const int ISAO_MET ;
		static const int INTER_PAPAPAPC_MET ;
		static const int NOCI_MET ;


		// Method Metrics
		static const int CALLS_MET ;
		static const int CDENS_MET ;
		static const int DEPTH_MET ;
		static const int ECC_MET ;
		static const int NP_MET ;
		static const int NSTAT_MET ;
		static const int OAC_MET ;
		static const int QCP_MAINT_MET ;
		static const int QCP_CRCT_MET ;
		static const int QCP_RLBTY_MET ;
		static const int RLOC_MET ;


		// Memory Management
		static const long MEM_NO_MANS_LAND ;
		static const long MEM_FREED ;
		static const long MEM_UNINIT_GLOBAL ;
		static const long MEM_UNINIT_LOCAL ;


#ifdef LANGUAGE_CPP
		// C++ definitions
#elif  LANGUAGE_JAVA
		// Java definitions
#endif

		/*MasterData(std::string dbName) ;
		~MasterData() ;*/

//		static long getMetricGroup(int catID) ;
		static long getMaxMetricTypeID(long) ;
		static long codeMtt(long, long) ;
		//static long codeMttFromCategory(long metricID, long catID) ;
		static long decodeMtt(long mttID) ;

		static bool isUserType(long sytID) { return (sytID >= USERTYPES) ; }

	} ;
} ;

#endif
