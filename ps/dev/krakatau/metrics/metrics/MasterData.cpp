/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * CAM  02-Apr-08  339 : Corrected deprecation warnings.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <iostream>
#include <stdlib.h>
#include "MasterData.h"
using namespace metrics ;
using namespace std ;

//ofstream MasterData::theLog("log/metrics.log") ;
ofstream MasterData::theLog ;

// Categories
const int MasterData::PROJECT_CAT = 1 ;
const int MasterData::PACKAGE_CAT = 2 ;
const int MasterData::NAMESPACE_CAT = 3 ;
const int MasterData::FILE_CAT = 4 ;
const int MasterData::CLASS_CAT = 5 ;
const int MasterData::INTERFACE_CAT = 6 ;
const int MasterData::METHOD_CAT = 7 ;
const int MasterData::FIELD_CAT = 8 ;

// Metrics
const int MasterData::METRIC_FACTOR = 1000 ;
const int MasterData::ABSOLUTE_METCAT = 0 ;
const int MasterData::DELTA_METCAT = 1 ;

// Links
const int MasterData::XREF_LINK = 1 ;
const int MasterData::SUPER_LINK = 2 ;
const int MasterData::SUB_LINK = 3 ;
const int MasterData::PACKAGE_LINK = 4 ;
const int MasterData::IMPORT_LINK = 5 ;
const int MasterData::IMPLEMENTS_LINK = 6 ;
const int MasterData::PARAMETER_LINK = 7 ;
const int MasterData::TYPE_LINK = 8 ;

// Protection Levels
const int MasterData::PACKAGE_PROT = 1 ;
const int MasterData::PUBLIC_PROT = 2 ;
const int MasterData::PROTECTED_PROT = 3 ;
const int MasterData::PRIVATE_PROT = 4 ;

// Types
const int MasterData::INT_T = 1 ;
const int MasterData::LONG_T = 2 ;
const int MasterData::SHORT_T = 3 ;
const int MasterData::FLOAT_T = 4 ;
const int MasterData::DOUBLE_T = 5 ;
const int MasterData::BYTE_T = 6 ;
const int MasterData::CHAR_T = 7 ;
const int MasterData::WORD_T = 8 ;
const int MasterData::BOOL_T = 9 ;
const int MasterData::VOID_T = 10 ;
const int MasterData::USERTYPES = 50 ;

// States
const int MasterData::CHANGED_STATE = 0 ;
const int MasterData::UNCHANGED_STATE = 1 ;
const int MasterData::NEW_STATE = 2 ;
const int MasterData::DELETED_STATE = 3 ;


// Common Metrics
int MasterData::theCommonCat = 1 ;

const int MasterData::LOC_MET   = MasterData::theCommonCat++ ;
const int MasterData::SLOC_MET    = MasterData::theCommonCat++ ;
const int MasterData::NION_MET    = MasterData::theCommonCat++ ;
const int MasterData::ANION_MET   = MasterData::theCommonCat++ ;
const int MasterData::N1_MET    = MasterData::theCommonCat++ ;
const int MasterData::N2_MET    = MasterData::theCommonCat++ ;
const int MasterData::n1_MET    = MasterData::theCommonCat++ ;
const int MasterData::n2_MET      = MasterData::theCommonCat++ ;
const int MasterData::NSC_MET     = MasterData::theCommonCat++ ;
const int MasterData::CONTROL_MET   = MasterData::theCommonCat++ ;
const int MasterData::EXECUTABLE_MET  = MasterData::theCommonCat++ ;
const int MasterData::COM_MET     = MasterData::theCommonCat++ ;
const int MasterData::CCOM_MET    = MasterData::theCommonCat++ ;
const int MasterData::CPPCOM_MET  = MasterData::theCommonCat++ ;
const int MasterData::OC_MET    = MasterData::theCommonCat++ ;
const int MasterData::CYCLO_MET   = MasterData::theCommonCat++ ;
const int MasterData::EVG_MET   = MasterData::theCommonCat++ ;
const int MasterData::BRANCH_MET  = MasterData::theCommonCat++ ;
const int MasterData::NEST_MET    = MasterData::theCommonCat++ ;
const int MasterData::N_MET     = MasterData::theCommonCat++ ;
const int MasterData::n_MET     = MasterData::theCommonCat++ ;
const int MasterData::V_MET     = MasterData::theCommonCat++ ;
const int MasterData::D_MET     = MasterData::theCommonCat++ ;
const int MasterData::E_MET     = MasterData::theCommonCat++ ;
const int MasterData::B_MET     = MasterData::theCommonCat++ ;
#ifdef LANGUAGE_JAVA
const int MasterData::JCOM_MET    = MasterData::theCommonCat++ ;
#endif
const int MasterData::WLOC_MET    = MasterData::theCommonCat++ ;


// Project Metrics
int MasterData::theProjectCat = MasterData::theCommonCat ;

const int MasterData::MHF_MET   = MasterData::theProjectCat++ ;
const int MasterData::AHF_MET   = MasterData::theProjectCat++ ;
const int MasterData::MIF_MET   = MasterData::theProjectCat++ ;
const int MasterData::AIF_MET   = MasterData::theProjectCat++ ;
const int MasterData::POF_MET   = MasterData::theProjectCat++ ;
const int MasterData::COF_MET   = MasterData::theProjectCat++ ;
const int MasterData::HIER_MET    = MasterData::theProjectCat++ ;
const int MasterData::AVPATHS_MET = MasterData::theProjectCat++ ;
const int MasterData::PROJDEPTH_MET = MasterData::theProjectCat++ ;
const int MasterData::PDIT_MET      = MasterData::theProjectCat++ ;
const int MasterData::COM_RAT_MET = MasterData::theProjectCat++ ;
const int MasterData::TCOM_RAT_MET  = MasterData::theProjectCat++ ;
const int MasterData::SEIMI_MET   = MasterData::theProjectCat++ ;
const int MasterData::NCLASS_MET  = MasterData::theProjectCat++ ;
#ifdef LANGUAGE_JAVA
const int MasterData::NINTER_MET  = MasterData::theProjectCat++ ;
#endif
const int MasterData::NFILE_MET   = MasterData::theProjectCat++ ;
const int MasterData::NMETH_MET   = MasterData::theProjectCat++ ;
const int MasterData::NORC_MET    = MasterData::theProjectCat++ ;
const int MasterData::ACLOC_MET   = MasterData::theProjectCat++ ;
const int MasterData::AMLOC_MET   = MasterData::theProjectCat++ ;
const int MasterData::P_CHG_LOC_MET = MasterData::theProjectCat++ ;
const int MasterData::P_DEL_LOC_MET = MasterData::theProjectCat++ ;
const int MasterData::P_INS_LOC_MET = MasterData::theProjectCat++ ;
#ifdef PM
const int MasterData::CHG_FILE_MET  = MasterData::theProjectCat++ ;
const int MasterData::DEL_FILE_MET  = MasterData::theProjectCat++ ;
const int MasterData::INS_FILE_MET  = MasterData::theProjectCat++ ;

#ifdef LANGUAGE_JAVA
const int MasterData::CHG_PACK_MET  = MasterData::theProjectCat++ ;
const int MasterData::DEL_PACK_MET  = MasterData::theProjectCat++ ;
const int MasterData::INS_PACK_MET  = MasterData::theProjectCat++ ;
#endif

const int MasterData::CHG_CLASS_MET = MasterData::theProjectCat++ ;
const int MasterData::DEL_CLASS_MET = MasterData::theProjectCat++ ;
const int MasterData::INS_CLASS_MET = MasterData::theProjectCat++ ;

const int MasterData::CHG_METH_MET  = MasterData::theProjectCat++ ;
const int MasterData::DEL_METH_MET  = MasterData::theProjectCat++ ;
const int MasterData::INS_METH_MET  = MasterData::theProjectCat++ ;
#endif
const int MasterData::SUMV_MET    = MasterData::theProjectCat++ ;
const int MasterData::SUMVG_MET   = MasterData::theProjectCat++ ;
const int MasterData::SUM_INH_ATT_MET = MasterData::theProjectCat++ ;
const int MasterData::SUM_INH_ATT_TOT_MET = MasterData::theProjectCat++ ;
const int MasterData::SUM_INH_OP_MET  = MasterData::theProjectCat++ ;
const int MasterData::SUM_INH_OP_TOT_MET = MasterData::theProjectCat++ ;
const int MasterData::SUM_OV_OP_MET   = MasterData::theProjectCat++ ;
const int MasterData::SUM_ADD_SUB_MET = MasterData::theProjectCat++ ;
const int MasterData::MLOC_MET      = MasterData::theProjectCat++ ;
const int MasterData::CLOC_MET      = MasterData::theProjectCat++ ;
const int MasterData::FIELDV_MET    = MasterData::theProjectCat++ ;
const int MasterData::FIELDTC_MET   = MasterData::theProjectCat++ ;
const int MasterData::METHODV_MET   = MasterData::theProjectCat++ ;
const int MasterData::METHODTC_MET    = MasterData::theProjectCat++ ;
const int MasterData::INH_MET     = MasterData::theProjectCat++ ;

#ifdef LANGUAGE_JAVA
// Package Metrics
int MasterData::thePackageCat = MasterData::theCommonCat ;

const int MasterData::PACK_NFILE_MET  = MasterData::thePackageCat++ ;
const int MasterData::PACK_NTC_MET    = MasterData::thePackageCat++ ;
const int MasterData::PACK_NTI_MET    = MasterData::thePackageCat++ ;
#endif

// File Metrics
int MasterData::theFileCat = MasterData::theCommonCat ;

const int MasterData::FILE_COM_RAT_MET  = MasterData::theFileCat++ ;
const int MasterData::FILE_TCOM_RAT_MET = MasterData::theFileCat++ ;
const int MasterData::NTC_MET     = MasterData::theFileCat++ ;
#ifdef LANGUAGE_CPP
const int MasterData::NTM_MET     = MasterData::theFileCat++ ;
#elif LANGUAGE_JAVA
const int MasterData::NTI_MET     = MasterData::theFileCat++ ;
#endif
const int MasterData::CHG_LOC_MET   = MasterData::theFileCat++ ;
const int MasterData::DEL_LOC_MET   = MasterData::theFileCat++ ;
const int MasterData::INS_LOC_MET   = MasterData::theFileCat++ ;

// Class Metrics
int MasterData::theClassCat = MasterData::theCommonCat ;

const int MasterData::CSA_MET   = MasterData::theClassCat++ ;
const int MasterData::CSO_MET   = MasterData::theClassCat++ ;
const int MasterData::CSAO_MET    = MasterData::theClassCat++ ;
const int MasterData::PAPAPAPC_MET  = MasterData::theClassCat++ ;
const int MasterData::NOCC_MET    = MasterData::theClassCat++ ;
const int MasterData::DIT_MET   = MasterData::theClassCat++ ;
const int MasterData::RFC_MET   = MasterData::theClassCat++ ;
const int MasterData::CBO_MET   = MasterData::theClassCat++ ;
const int MasterData::LCOM_MET    = MasterData::theClassCat++ ; // Lack of Cohesion in Methods
const int MasterData::NOOC_MET    = MasterData::theClassCat++ ; // Ops Overriden
const int MasterData::NOAC_MET    = MasterData::theClassCat++ ; // Ops Added
const int MasterData::NAAC_MET    = MasterData::theClassCat++ ; // Att Added
const int MasterData::NOIC_MET    = MasterData::theClassCat++ ; // Ops Inherited
const int MasterData::NAIC_MET    = MasterData::theClassCat++ ; // Att Inherited
const int MasterData::WMC_MET   = MasterData::theClassCat++ ;
const int MasterData::CSI_MET   = MasterData::theClassCat++ ;
const int MasterData::OSavg_MET   = MasterData::theClassCat++ ;
const int MasterData::NPavgC_MET  = MasterData::theClassCat++ ;
const int MasterData::PA_MET    = MasterData::theClassCat++ ;
const int MasterData::AC_MET    = MasterData::theClassCat++ ;
#ifdef LANGUAGE_CPP
const int MasterData::TLOC_MET    = MasterData::theClassCat++ ;
#endif


// Interface Metrics
int MasterData::theInterfaceCat = MasterData::theCommonCat ;

const int MasterData::ISA_MET = MasterData::theInterfaceCat++ ;
const int MasterData::ISO_MET = MasterData::theInterfaceCat++ ;
const int MasterData::ISAO_MET = MasterData::theInterfaceCat++ ;
const int MasterData::INTER_PAPAPAPC_MET = MasterData::theInterfaceCat++ ;
const int MasterData::NOCI_MET = MasterData::theInterfaceCat++ ;


// Method Metrics
int MasterData::theMethodCat = MasterData::theCommonCat ;

const int MasterData::CALLS_MET = MasterData::theMethodCat++ ;
const int MasterData::CDENS_MET = MasterData::theMethodCat++ ;
const int MasterData::DEPTH_MET = MasterData::theMethodCat++ ;
const int MasterData::ECC_MET = MasterData::theMethodCat++ ;
const int MasterData::NP_MET = MasterData::theMethodCat++ ;
const int MasterData::NSTAT_MET = MasterData::theMethodCat++ ;
const int MasterData::OAC_MET = MasterData::theMethodCat++ ;
const int MasterData::QCP_MAINT_MET = MasterData::theMethodCat++ ;
const int MasterData::QCP_CRCT_MET = MasterData::theMethodCat++ ;
const int MasterData::QCP_RLBTY_MET = MasterData::theMethodCat++ ;
const int MasterData::RLOC_MET = MasterData::theMethodCat++ ;

const long MasterData::MEM_NO_MANS_LAND   = 0xFDFDFDFD ;
const long MasterData::MEM_FREED      = 0xDDDDDDDD ;
const long MasterData::MEM_UNINIT_GLOBAL  = 0xCDCDCDCD ;
const long MasterData::MEM_UNINIT_LOCAL   = 0xCCCCCCCC ;


long MasterData::codeMtt(long metricID, long catID)
{
  return ((catID * METRIC_FACTOR) + metricID) ;
}


long MasterData::decodeMtt(long mttID)
{
  return (long) mttID % METRIC_FACTOR ;
}


long MasterData::getMaxMetricTypeID(long catID)
{
  if (catID == MasterData::PROJECT_CAT)
    return theProjectCat ;

#ifdef LANGUAGE_JAVA
  else if (catID == MasterData::PACKAGE_CAT)
    return thePackageCat ;
#endif

  else if (catID == MasterData::FILE_CAT)
    return theFileCat ;

  else if (catID == MasterData::CLASS_CAT)
    return theClassCat ;

  else if (catID == MasterData::INTERFACE_CAT)
    return theInterfaceCat ;

  else if (catID == MasterData::METHOD_CAT)
    return theMethodCat ;

  else
    return theCommonCat ;
}


char *dtoa(double d, char *buff, int buffsize)
{
  sprintf_s(buff, 100, "%.3f", d) ;
  return buff ;
}

#ifdef WIN32

//--------------------------------------------------------
//
// The standard string conversion are not portable between
// Windows and Solaris.
//
// This is an implementation for Windows
//
//--------------------------------------------------------
char *ltostr(long l)
{
  char *retval = (char*) malloc(20*sizeof(char)) ;
  _ltoa_s(l,retval,20,10) ;

  return retval ;
}

char *ltostr(long l, char *buff, int buffsize)
{
  _ltoa_s(l,buff,buffsize,10) ;

  return buff ;
}

#elif sun

//--------------------------------------------------------
//
// The standard string conversion are not portable between
// Windows and Solaris.
//
// This is an implementation for Solaris
//
//--------------------------------------------------------
char *ltostr(long l)
{
  // Not currently used - should be checked
  char *tmp = (char*) malloc (20*sizeof(char)) ;
  char *retval = tmp + 20 ;
  *retval = '\0' ;

  retval = strdup(lltostr(l,retval)) ;

  free (tmp) ;
  return retval ;
}

char *ltostr(long l, char *buff, int buffsize)
{
  sprintf(buff, "%d", l) ;
  return buff ;
}
#endif
