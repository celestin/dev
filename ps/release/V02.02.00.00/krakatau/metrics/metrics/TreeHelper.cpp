/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * --------------------------------------------------------------------------------
 * ID  By    Date        Description
 * C01 CAM   27/09/2001  Put this line back in
 * A01 CAM   10/10/2001  Added code to build Ancestry table - a denormalised table
 *                       code symbol ID, Cat & Name + Parent ID Cat & Name +
 *                       File ID & Name - for reporting purposes
 * --------------------------------------------------------------------------------
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * CAM  22-Jan-08  339 : Corrected deprecation warnings.
 * CAM  26-Mar-08  338 : Tidied LCOM name.
 * CAM  02-Apr-08  339 : Corrected deprecation warnings.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <iostream>
#include <stdlib.h>
#include "TreeHelper.h"

using namespace metrics ;
using namespace std ;

#define DROP_TABLE "drop table if exists "
#define CREATE_TABLE "create table if not exists "
#define INSERT_TABLE "insert "
#define ANCESTRY 1
#define SUBPRO 2


TreeHelper::TreeHelper(std::string dbName) : AutoNumber(), OurSQL(dbName),
#ifdef PROFESSIONAL
  Cache(200001,10000)
#else
  Cache(50001,5000)
#endif
{
  theNodeCount = 0 ;

  long nextID = getNextID("symboltype","sytID") ;
  if (nextID>MasterData::USERTYPES)
  {
    theCurrentTypeID.reset(nextID) ;
  }
  else
  {
    theCurrentTypeID.reset(MasterData::USERTYPES) ;
  }

  strcpy_s(theSymWrite,QUERY_MAX, "replace into symbol values ") ;
  theNSymWrite = strlen(theSymWrite) ;
  theSymToWrite = false ;
}


void TreeHelper::recreateDatabase()
{
  if (connected())
  {
    createCategory() ;
    createLink() ;
    createLinkType() ;
    createMetric() ;
    createMetricComp() ;
    createSymbolComp() ;
    createSymbolDel() ;
    createMetricType() ;
    createProtectionLevel() ;
    createSymbol() ;
    createSymbolType() ;
  }
}


void TreeHelper::dropTable(string tableName)
{
  string sql = "Drop Table IF EXISTS " + tableName ;

  try
  {
    executeResultlessQuery(sql) ;
  }
  catch (...)
  {
    // Ignore - means the table has already been dropped
  }
}


// Create table with primary key and index
void TreeHelper::createTable(string tableName, string fieldList, string keyField)
{
  dropTable(tableName) ;

  char sql[1024] ;

  strcpy_s(sql,1024, "Create Table ") ;
  strcat_s(sql,1024, tableName.c_str()) ;
  strcat_s(sql,1024, " (") ;
  strcat_s(sql,1024, fieldList.c_str()) ;
  strcat_s(sql,1024, " , Primary Key (") ;
  strcat_s(sql,1024, keyField.c_str()) ;
  strcat_s(sql,1024, ") , Unique Index (") ;
  strcat_s(sql,1024, keyField.c_str()) ;
  strcat_s(sql,1024, "))") ;

  try
  {
    executeResultlessQuery(sql) ;
  }
  catch (...)
  {
    // Ignore - means the table has already been created
  }
}


// Add an index to an existing table
void TreeHelper::addIndex(string tableName, string indexName, string fieldList)
{
  char sql[1024] ;

  strcpy_s(sql,1024,"Alter Table ") ;
  strcat_s(sql,1024,tableName.c_str()) ;
  strcat_s(sql,1024," Add Index ") ;
  strcat_s(sql,1024,indexName.c_str()) ;
  strcat_s(sql,1024," ( ") ;
  strcat_s(sql,1024,fieldList.c_str()) ;
  strcat_s(sql,1024," )") ;

  try
  {
    executeResultlessQuery(sql) ;
  }
  catch (...)
  {
    // Ignore - means the index has already been created
  }
}


// Get the next ID for a table
long TreeHelper::getNextID(string tableName, string idField)
{
  string sql ;
  sql = "Select Max(" + idField + ")+1 As nextID From " + tableName ;

  try
  {
    if (executeQuery(sql.c_str()))
    {
      return longCell(0,0) ;
    }
  }
  catch (...)
  {
    // Ignore - means the table has already been created
  }

  return 1 ;
}


void TreeHelper::insertRow(DatumItr d, std::string tableName)
{
  char sql[1024], charNumber[30] ;

  strcpy_s(sql,1024,"Insert DELAYED Into ") ;
  strcat_s(sql,1024,tableName.c_str()) ;
  strcat_s(sql,1024," Values ( ") ;
  strcat_s(sql,1024, ltostr(d->second, charNumber, 30)) ;
  strcat_s(sql,1024,",'") ;
  strcat_s(sql,1024,d->first.c_str()) ;
  strcat_s(sql,1024,"')") ;


  try
  {
    executeResultlessQuery(sql) ;
  }
  catch (...)
  {
    //TODO: theLog << "TreeHelper::insertRow() - Error executing query!" << endl ;
  }
}


void TreeHelper::insertSymbolTypeRow(long sytID, string name, long symID)
{
  char sql[1024], charNumber[30] ;

  strcpy_s(sql,1024,"Insert Into symboltype Values ( ") ;
  strcat_s(sql,1024, ltostr(sytID, charNumber, 30)) ;  // Unique SymbolTypeID
  strcat_s(sql,1024,",") ;
  strcat_s(sql,1024, ltostr(symID, charNumber, 30)) ;    // Ref to this type's Symbol
  strcat_s(sql,1024,",'") ;
  strcat_s(sql,1024,name.c_str()) ;            // Type Name
  strcat_s(sql,1024,"')") ;


  try
  {
    executeResultlessQuery(sql) ;
  }
  catch (...)
  {
    //TODO: theLog << "Error SymbolType executing query!" << endl ;
  }
}


void TreeHelper::insertMetricTypeRow(long hlpID, long mttID, string mttCode, string mttName)
{
  insertMetricTypeRow(hlpID, mttID, 0, mttCode, mttName) ;
}


void TreeHelper::insertMetricTypeRow(long hlpID, long mttID, int mtcID, string mttCode, string mttName)
{
  char sql[1024], charNumber[30] ;

  strcpy_s(sql,1024,"Insert DELAYED Into metrictype Values ( ") ;
  strcat_s(sql,1024, ltostr(mttID, charNumber, 30)) ;  // Unique MetricTypeID (mttID)
  strcat_s(sql,1024,",") ;
  strcat_s(sql,1024, ltostr(mtcID, charNumber, 30)) ;  // Metric Type Category (0=Absolute, 1=Delta)
  strcat_s(sql,1024,",'") ;
  strcat_s(sql,1024, mttCode.c_str()) ;          // Metric Code
  strcat_s(sql,1024,"','") ;
  strcat_s(sql,1024, mttName.c_str()) ;          // Metric Name
  strcat_s(sql,1024,"',1,0,0,0,0,") ;          // Chosen, Lower & Upper bounds
  strcat_s(sql,1024,ltostr(hlpID, charNumber, 30)) ;   // Metric Help ID
  strcat_s(sql,1024,")") ;

  try
  {
    executeResultlessQuery(sql) ;
  }
  catch (...)
  {
    //TODO: theLog << "Error insertMetricTypeRow executing query!" << endl ;
  }
}


void TreeHelper::createSymbol()
{
  createTable("symbol", "symID int not null,symParentID int not null,symName varchar (128) binary not null,sytID int not null,catID int not null,prtID int not null", "symID") ;
  addIndex("symbol", "parent", "symParentID") ;
}


void TreeHelper::createSymbolXtra()
{
  createTable("symbolxtra", "symID int not null , symQName text not null", "symID") ;
}


void TreeHelper::createSymbolType()
{
  // Create Table
  createTable("symboltype", "sytID int not null,symID int not null,sytName varchar (25) not null", "sytID") ;

  // Populate array with data
  theType["int"] = MasterData::INT_T ;
  theType["long"] = MasterData::LONG_T ;
  theType["short"] = MasterData::SHORT_T ;
  theType["float"] = MasterData::FLOAT_T ;
  theType["double"] = MasterData::DOUBLE_T ;
  theType["byte"] = MasterData::BYTE_T ;
  theType["char"] = MasterData::CHAR_T ;
  theType["word"] = MasterData::WORD_T ;
  theType["bool"] = MasterData::BOOL_T ;
  theType["void"] = MasterData::VOID_T ;

  for(DatumItr d = theType.begin() ; d != theType.end() ; d++)
    insertSymbolTypeRow(d->second,d->first, 0) ;
}


void TreeHelper::readSymbolType()
{
  try
  {
    if (executeQuery("select sytID, sytName from symboltype order by sytName"))
    {
      int r = rows() ;

      for(int i=0; i<r; i++)
      {
        theType[cell(i,1)] = longCell(i,0) ;
      }
    }
  }
  catch (...)
  {
    // Ignore - means the table has already been dropped
  }
}


void TreeHelper::createMetric()
{
  createTable("metric", "symID int not null,mttID int not null,metValue real not null", "symID , mttID") ;
}


void TreeHelper::createSymbolComp()
{
  createTable("symbolcomp", "symID int not null,mttStatus int not null", "symID") ;
}


void TreeHelper::createSymbolDel()
{
  createTable("symboldel", "symID int not null,symParentID int not null,symNewParID int not null,symName varchar (128) binary not null,sytID int not null,catID int not null,prtID int not null", "symID") ;
}


void TreeHelper::createMetricComp()
{
  createTable("metriccomp", "symID int not null,mttID int not null,metValue real not null", "symID,mttID") ;
}

void TreeHelper::createSourceFile()
{
  dropTable("sourcefile") ;

  char sql[1024] ;
  strcpy_s(sql,1024, "Create Table sourcefile (srfID int AUTO_INCREMENT not null, srfName varchar(255) binary not null, primary key (srfID), unique index (srfID))") ;

  try
  {
    executeResultlessQuery(sql) ;
  }
  catch (...)
  {
    // Ignore - means the table has already been created
  }
}



//void TreeHelper::insertCommonMetricsForGroup(long mtg)
void TreeHelper::insertCommonMetricsForCat(long cat)
{
  long hlp = cat * 10000 ;

  insertMetricTypeRow(hlp+101, MasterData::codeMtt(MasterData::LOC_MET, cat),
    "LOC",    "Lines of code") ;
  insertMetricTypeRow(hlp+102, MasterData::codeMtt(MasterData::SLOC_MET, cat),
    "SLOC",   "Source lines of code") ;
  insertMetricTypeRow(hlp+126, MasterData::codeMtt(MasterData::WLOC_MET, cat),
    "WLOC",   "Whitespace lines of code") ;
#ifdef PROFESSIONAL
  insertMetricTypeRow(hlp+103, MasterData::codeMtt(MasterData::NION_MET, cat),
    "NION",   "Number of I/O nodes") ;
//  insertMetricTypeRow(hlp+104, MasterData::codeMtt(MasterData::ANION_MET, cat),
//    "ANION",  "Adjusted number of I/O nodes") ;
  insertMetricTypeRow(hlp+105, MasterData::codeMtt(MasterData::N1_MET, cat),
    "N1",   "Halstead total number of operators") ;
  insertMetricTypeRow(hlp+106, MasterData::codeMtt(MasterData::N2_MET, cat),
    "N2",   "Halstead total number of operands") ;
  insertMetricTypeRow(hlp+107, MasterData::codeMtt(MasterData::n1_MET, cat),
    "n1",   "Halstead number of unique operators") ;
  insertMetricTypeRow(hlp+108, MasterData::codeMtt(MasterData::n2_MET, cat),
    "n2",   "Halstead number of unique operands") ;
#endif
  insertMetricTypeRow(hlp+109, MasterData::codeMtt(MasterData::NSC_MET, cat),
    "NSC",    "Number of Semicolons") ;
  insertMetricTypeRow(hlp+110, MasterData::codeMtt(MasterData::CONTROL_MET, cat),
    "CONTROL",  "Number of control statements") ;
  insertMetricTypeRow(hlp+111, MasterData::codeMtt(MasterData::EXECUTABLE_MET, cat),
    "EXEC",   "Number of executable statements") ;
  insertMetricTypeRow(hlp+112, MasterData::codeMtt(MasterData::COM_MET, cat),
    "COM_LOC", "Comment lines of code") ;
  insertMetricTypeRow(hlp+113, MasterData::codeMtt(MasterData::CCOM_MET, cat),
    "C_COM",  "C style comments") ;
  insertMetricTypeRow(hlp+114, MasterData::codeMtt(MasterData::CPPCOM_MET, cat),
    "CPP_COM",  "C++ sytle comments") ;
#ifdef LANGUAGE_JAVA
  insertMetricTypeRow(hlp+115, MasterData::codeMtt(MasterData::JCOM_MET, cat),
    "J_COM",  "Java Style comments") ;
#endif
#ifdef PROFESSIONAL
  insertMetricTypeRow(hlp+116, MasterData::codeMtt(MasterData::OC_MET, cat),
    "OC", "Operational Complexity") ;
#endif
  insertMetricTypeRow(hlp+117, MasterData::codeMtt(MasterData::CYCLO_MET, cat),
    "V(G)",   "Cyclomatic Complexity") ;
  insertMetricTypeRow(hlp+118, MasterData::codeMtt(MasterData::EVG_MET, cat),
    "eV(G)",  "Essential Complexity") ;
#ifdef PROFESSIONAL
  insertMetricTypeRow(hlp+119, MasterData::codeMtt(MasterData::BRANCH_MET, cat),
    "BRANCH", "Number of branching nodes") ;
  insertMetricTypeRow(hlp+120, MasterData::codeMtt(MasterData::NEST_MET, cat),
    "NEST",   "Maxmium number of levels") ;
  insertMetricTypeRow(hlp+121, MasterData::codeMtt(MasterData::N_MET, cat),
    "N",    "Halstead program Length") ;
  insertMetricTypeRow(hlp+122, MasterData::codeMtt(MasterData::n_MET, cat),
    "n",    "Halstead program Vocabulary") ;
  insertMetricTypeRow(hlp+123, MasterData::codeMtt(MasterData::V_MET, cat),
    "V",    "Halstead program Volume") ;
  insertMetricTypeRow(hlp+124, MasterData::codeMtt(MasterData::D_MET, cat),
    "D",    "Halstead program Difficulty") ;
  insertMetricTypeRow(hlp+125, MasterData::codeMtt(MasterData::E_MET, cat),
    "E",    "Halstead program Effort") ;
  insertMetricTypeRow(hlp+127, MasterData::codeMtt(MasterData::B_MET, cat),
    "B",    "Halstead Bug prediction") ;
#endif
}


void TreeHelper::createMetricType()
{
  //TODO: theLog << "Starting createMetricType" << endl << flush ;

  string tableName("metrictype") ;

  // Create Table
  createTable(tableName, "mttID int not null, mtcID int not null, mttCode varchar (10) BINARY not null, mttName varchar (42) not null,mttChosen int not null,mttLBound real not null,mttLBoundAct int not null,mttUBound real not null,mttUBoundAct int not null,hlpID int not null", "mttID") ;

  // Project Metrics
  insertCommonMetricsForCat(MasterData::PROJECT_CAT) ;

#ifdef PROFESSIONAL
  insertMetricTypeRow(10501, MasterData::codeMtt(MasterData::MHF_MET, MasterData::PROJECT_CAT),
    "MHF",    "Method Hiding Factor") ;
  insertMetricTypeRow(10502, MasterData::codeMtt(MasterData::AHF_MET, MasterData::PROJECT_CAT),
    "AHF",    "Attribute Hiding Factor") ;
  insertMetricTypeRow(10503, MasterData::codeMtt(MasterData::MIF_MET, MasterData::PROJECT_CAT),
    "MIF",    "Method Inheritence Factor") ;
  insertMetricTypeRow(10504, MasterData::codeMtt(MasterData::AIF_MET, MasterData::PROJECT_CAT),
    "AIF",    "Attribute Inheritence Factor") ;
  insertMetricTypeRow(10505, MasterData::codeMtt(MasterData::POF_MET, MasterData::PROJECT_CAT),
    "POF",    "Polymorphism Factor") ;
  insertMetricTypeRow(10506, MasterData::codeMtt(MasterData::COF_MET, MasterData::PROJECT_CAT),
    "COF",    "Coupling Factor") ;
//  insertMetricTypeRow(10507, MasterData::codeMtt(MasterData::HIER_MET, MasterData::PROJECT_CAT),
//    "HIER",   "Hierarchical Depth") ;
  insertMetricTypeRow(10508, MasterData::codeMtt(MasterData::AVPATHS_MET, MasterData::PROJECT_CAT),
    "AVPATHS",  "Average Depth of Paths") ;
  insertMetricTypeRow(10509, MasterData::codeMtt(MasterData::PROJDEPTH_MET, MasterData::PROJECT_CAT),
    "DEPTH",  "Total Maximum Method Depths (Project)") ;
#endif
  insertMetricTypeRow(10510, MasterData::codeMtt(MasterData::COM_RAT_MET, MasterData::PROJECT_CAT),
    "COM_RAT",  "Comments Ratio (Project)") ;
  insertMetricTypeRow(10511, MasterData::codeMtt(MasterData::TCOM_RAT_MET, MasterData::PROJECT_CAT),
    "TCOM_RAT", "True Comments Ratio (Project)") ;
#ifdef PROFESSIONAL
  insertMetricTypeRow(10512, MasterData::codeMtt(MasterData::SEIMI_MET, MasterData::PROJECT_CAT),
    "SEIMI",  "SEI Maintainability Index") ;
#endif
  insertMetricTypeRow(10513, MasterData::codeMtt(MasterData::NCLASS_MET, MasterData::PROJECT_CAT),
    "NCLASS", "Number of Classes") ;
  insertMetricTypeRow(10514, MasterData::codeMtt(MasterData::NFILE_MET, MasterData::PROJECT_CAT),
    "NFILE",  "Number of Files") ;
  insertMetricTypeRow(10515, MasterData::codeMtt(MasterData::NMETH_MET, MasterData::PROJECT_CAT),
    "NMETH",  "Number of Methods") ;
#ifdef PROFESSIONAL
  insertMetricTypeRow(10516, MasterData::codeMtt(MasterData::NORC_MET, MasterData::PROJECT_CAT),
    "NORC",   "Number of Root Classes") ;
  insertMetricTypeRow(10517, MasterData::codeMtt(MasterData::ACLOC_MET, MasterData::PROJECT_CAT),
    "ACLOC",  "Average Lines per Class") ;
  insertMetricTypeRow(10518, MasterData::codeMtt(MasterData::AMLOC_MET, MasterData::PROJECT_CAT),
    "AMLOC",  "Average Lines per Method") ;
  insertMetricTypeRow(10531, MasterData::codeMtt(MasterData::PDIT_MET, MasterData::PROJECT_CAT),
    "PDIT",   "Depth of Inheritance Tree (Project)") ;
#endif
#ifdef PM
  insertMetricTypeRow(10519, MasterData::codeMtt(MasterData::P_CHG_LOC_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "CHG_SLOC", "Source Lines of Code (Changed)") ;
  insertMetricTypeRow(10520, MasterData::codeMtt(MasterData::P_DEL_LOC_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "DEL_SLOC", "Source Lines of Code (Deleted)") ;
  insertMetricTypeRow(10521, MasterData::codeMtt(MasterData::P_INS_LOC_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "ADD_SLOC", "Source Lines of Code (Added)") ;
  insertMetricTypeRow(10522, MasterData::codeMtt(MasterData::CHG_FILE_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "CHG_FILE", "Number of Files (Changed)") ;
  insertMetricTypeRow(10523, MasterData::codeMtt(MasterData::DEL_FILE_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "DEL_FILE", "Number of Files (Deleted)") ;
  insertMetricTypeRow(10524, MasterData::codeMtt(MasterData::INS_FILE_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "ADD_FILE", "Number of Files (Added)") ;
  insertMetricTypeRow(10528, MasterData::codeMtt(MasterData::CHG_METH_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "CHG_METH", "Number of Methods (Changed)") ;
  insertMetricTypeRow(10529, MasterData::codeMtt(MasterData::DEL_METH_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "DEL_METH", "Number of Methods (Deleted)") ;
  insertMetricTypeRow(10530, MasterData::codeMtt(MasterData::INS_METH_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "ADD_METH", "Number of Methods (Added)") ;

#ifdef LANGUAGE_JAVA
  insertMetricTypeRow(10531, MasterData::codeMtt(MasterData::CHG_PACK_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "CHG_PACK", "Number of Packages (Changed)") ;
  insertMetricTypeRow(10532, MasterData::codeMtt(MasterData::DEL_PACK_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "DEL_PACK", "Number of Classes (Deleted)") ;
  insertMetricTypeRow(10533, MasterData::codeMtt(MasterData::INS_PACK_MET, MasterData::PROJECT_CAT),
    MasterData::DELTA_METCAT, "ADD_PACK", "Number of Classes (Added)") ;
#endif
#endif

#ifdef LANGUAGE_JAVA
  // Package Metrics
  insertCommonMetricsForCat(MasterData::PACKAGE_CAT) ;

  insertMetricTypeRow(20501, MasterData::codeMtt(MasterData::PACK_NFILE_MET, MasterData::PACKAGE_CAT),
    "NFILE",  "Number of Files") ;
  insertMetricTypeRow(20502, MasterData::codeMtt(MasterData::PACK_NTI_MET, MasterData::PACKAGE_CAT),
    "NTI",  "Number of Top-level Interfaces") ;
  insertMetricTypeRow(20503, MasterData::codeMtt(MasterData::PACK_NTC_MET, MasterData::PACKAGE_CAT),
    "NTC",  "Number of Top-level Classes") ;
#endif

  // File Metrics
  insertCommonMetricsForCat(MasterData::FILE_CAT) ;

  insertMetricTypeRow(40501, MasterData::codeMtt(MasterData::FILE_COM_RAT_MET, MasterData::FILE_CAT),
    "COM_RAT",  "Comments Ratio") ;
  insertMetricTypeRow(40502, MasterData::codeMtt(MasterData::FILE_TCOM_RAT_MET, MasterData::FILE_CAT),
    "TCOM_RAT", "True Comments Ratio") ;
#ifdef PROFESSIONAL
  insertMetricTypeRow(40503, MasterData::codeMtt(MasterData::NTC_MET, MasterData::FILE_CAT),
    "NTC",  "Number of Top-level Classes") ;
#ifdef LANGUAGE_CPP
  insertMetricTypeRow(40504, MasterData::codeMtt(MasterData::NTM_MET, MasterData::FILE_CAT),
    "NTM",  "Number of Top-level Methods") ;
#elif LANGUAGE_JAVA
  insertMetricTypeRow(40505, MasterData::codeMtt(MasterData::NTI_MET, MasterData::FILE_CAT),
    "NTI",  "Number of Top-level Interfaces") ;
#endif
#endif
#ifdef PM
  insertMetricTypeRow(40506, MasterData::codeMtt(MasterData::CHG_LOC_MET, MasterData::FILE_CAT),
    MasterData::DELTA_METCAT, "CHG_SLOC", "Source Lines of Code (Changed)") ;
  insertMetricTypeRow(40507, MasterData::codeMtt(MasterData::DEL_LOC_MET, MasterData::FILE_CAT),
    MasterData::DELTA_METCAT, "DEL_SLOC", "Source Lines of Code (Deleted)") ;
  insertMetricTypeRow(40508, MasterData::codeMtt(MasterData::INS_LOC_MET, MasterData::FILE_CAT),
    MasterData::DELTA_METCAT, "ADD_SLOC", "Source Lines of Code (Added)") ;
#endif

  // Class Metrics
  insertCommonMetricsForCat(MasterData::CLASS_CAT) ;

#ifdef PROFESSIONAL
  insertMetricTypeRow(50501, MasterData::codeMtt(MasterData::CSA_MET, MasterData::CLASS_CAT),
    "CSA",    "Class Size (Attributes)") ;
  insertMetricTypeRow(50502, MasterData::codeMtt(MasterData::CSO_MET, MasterData::CLASS_CAT),
    "CSO",    "Class Size (Operations)") ;
  insertMetricTypeRow(50503, MasterData::codeMtt(MasterData::CSAO_MET, MasterData::CLASS_CAT),
    "CSAO",   "Class Size (Attributes & Operations)") ;
  insertMetricTypeRow(50504, MasterData::codeMtt(MasterData::PAPAPAPC_MET, MasterData::CLASS_CAT),
    "PPPC",   "Percentage Public/Protected methods") ;
  insertMetricTypeRow(50505, MasterData::codeMtt(MasterData::NOCC_MET, MasterData::CLASS_CAT),
    "NOCC",   "Number of child classes") ;
  insertMetricTypeRow(50506, MasterData::codeMtt(MasterData::DIT_MET, MasterData::CLASS_CAT),
    "DIT",    "Depth of Inheritence Tree") ;
  insertMetricTypeRow(50507, MasterData::codeMtt(MasterData::RFC_MET, MasterData::CLASS_CAT),
    "RFC",    "Response For Class") ;
  insertMetricTypeRow(50508, MasterData::codeMtt(MasterData::CBO_MET, MasterData::CLASS_CAT),
    "CBO",    "Coupling Between Object classes") ;
  insertMetricTypeRow(50509, MasterData::codeMtt(MasterData::LCOM_MET, MasterData::CLASS_CAT),
    "LCOM",   "Lack of Cohesion Methods") ;
  insertMetricTypeRow(50510, MasterData::codeMtt(MasterData::NOOC_MET, MasterData::CLASS_CAT),
    "NOOC",   "Number of Operations Overridden") ;
  insertMetricTypeRow(50511, MasterData::codeMtt(MasterData::NOAC_MET, MasterData::CLASS_CAT),
    "NOAC",   "Number of Operations Added") ;
  insertMetricTypeRow(50512, MasterData::codeMtt(MasterData::NAAC_MET, MasterData::CLASS_CAT),
    "NAAC",   "Number of Attributes Added") ;
  insertMetricTypeRow(50513, MasterData::codeMtt(MasterData::NOIC_MET, MasterData::CLASS_CAT),
    "NOIC",   "Number of Operations Inherited") ;
  insertMetricTypeRow(50514, MasterData::codeMtt(MasterData::NAIC_MET, MasterData::CLASS_CAT),
    "NAIC",   "Number of Attributes Inherited") ;
  insertMetricTypeRow(50515, MasterData::codeMtt(MasterData::WMC_MET, MasterData::CLASS_CAT),
    "WMC",    "Weighted Methods in Class") ;
  insertMetricTypeRow(50516, MasterData::codeMtt(MasterData::CSI_MET, MasterData::CLASS_CAT),
    "CSI",    "Class Specialisation Index") ;
  insertMetricTypeRow(50517, MasterData::codeMtt(MasterData::OSavg_MET, MasterData::CLASS_CAT),
    "OSavg",  "Average Operation Size") ;
  insertMetricTypeRow(50518, MasterData::codeMtt(MasterData::NPavgC_MET, MasterData::CLASS_CAT),
    "NPavgC", "Average Number of Method Parameters") ;
  insertMetricTypeRow(50519, MasterData::codeMtt(MasterData::PA_MET, MasterData::CLASS_CAT),
    "PA",   "Private Attribute Usage") ;
  insertMetricTypeRow(50520, MasterData::codeMtt(MasterData::AC_MET, MasterData::CLASS_CAT),
    "AC",   "Attribute Complexity") ;
#ifdef LANGUAGE_CPP
  insertMetricTypeRow(50521, MasterData::codeMtt(MasterData::TLOC_MET, MasterData::CLASS_CAT),
    "TLOC",   "Total Lines of Code") ;
#endif
#endif

#ifdef LANGUAGE_JAVA
  // Interface Metrics
  insertCommonMetricsForCat(MasterData::INTERFACE_CAT) ;

#ifdef PROFESSIONAL
  insertMetricTypeRow(60501, MasterData::codeMtt(MasterData::ISA_MET, MasterData::INTERFACE_CAT),
    "ISA",    "Interface Size (Attributes)") ;
  insertMetricTypeRow(60502, MasterData::codeMtt(MasterData::ISO_MET, MasterData::INTERFACE_CAT),
    "ISO",    "Interface Size (Operations)") ;
  insertMetricTypeRow(60503, MasterData::codeMtt(MasterData::ISAO_MET, MasterData::INTERFACE_CAT),
    "ISAO",   "Interface Size (Attributes & Operations)") ;
  insertMetricTypeRow(60504, MasterData::codeMtt(MasterData::PAPAPAPC_MET, MasterData::INTERFACE_CAT),
    "PPPC",   "Percentage Public/Protected methods") ;
  insertMetricTypeRow(60505, MasterData::codeMtt(MasterData::NOCI_MET, MasterData::INTERFACE_CAT),
    "NOCI",   "Number of child Interfaces") ;
#endif
#endif

  // Method Metrics
  insertCommonMetricsForCat(MasterData::METHOD_CAT) ;

#ifdef PROFESSIONAL
  insertMetricTypeRow(70501, MasterData::codeMtt(MasterData::ECC_MET, MasterData::METHOD_CAT),
    "V\\'(G)",  "Extended Cyclomatic Complexity") ;
  insertMetricTypeRow(70502, MasterData::codeMtt(MasterData::RLOC_MET, MasterData::METHOD_CAT),
    "RLOC",   "Relative Lines of Code") ;
  insertMetricTypeRow(70503, MasterData::codeMtt(MasterData::CALLS_MET, MasterData::METHOD_CAT),
    "CALLS",  "Number of external Calls") ;
//  insertMetricTypeRow(70504, MasterData::codeMtt(MasterData::OAC_MET, MasterData::METHOD_CAT),
//    "OAC",    "Operation Argument Complexity") ;
  insertMetricTypeRow(70505, MasterData::codeMtt(MasterData::CDENS_MET, MasterData::METHOD_CAT),
    "CDENS",  "Control Density") ;
  insertMetricTypeRow(70506, MasterData::codeMtt(MasterData::DEPTH_MET, MasterData::METHOD_CAT),
    "DEPTH",  "Greatest depth from this method") ;
//  insertMetricTypeRow(70507, MasterData::codeMtt(MasterData::QCP_MAINT_MET, MasterData::METHOD_CAT),
//    "QCP_MAINT",  "Quality Criteria Profile (Maintainability)") ;
//  insertMetricTypeRow(70508, MasterData::codeMtt(MasterData::QCP_CRCT_MET, MasterData::METHOD_CAT),
//    "QCP_CRCT",   "Quality Criteria Profile (Correctness)") ;
//  insertMetricTypeRow(70509, MasterData::codeMtt(MasterData::QCP_RLBTY_MET, MasterData::METHOD_CAT),
//    "QCP_RLBTY",  "Quality Criteria Profile (Reliability)") ;
  insertMetricTypeRow(70510, MasterData::codeMtt(MasterData::NSTAT_MET, MasterData::METHOD_CAT),
    "NSTAT",  "Number of Statements") ;
  // C01 Begin ---------
  insertMetricTypeRow(70511, MasterData::codeMtt(MasterData::NP_MET, MasterData::METHOD_CAT),
    "NP",   "Number of Parameters") ;
  // C01 End -----------
#endif

  //TODO: theLog << "Finished createMetricType" << endl << flush ;
}


void TreeHelper::createLink()
{
  createTable("link", "lnkID int not null,symID int not null,sym2ID int not null,lktID int not null,ref varchar (128) binary not null", "lnkID" ) ;
  addIndex("link", "sym", "symID") ;
  addIndex("link", "sym2", "sym2ID") ;
  addIndex("link", "symAndType", "symID, lktID") ;
  addIndex("link", "ref", "ref") ;
}


void TreeHelper::deleteTempLinks()
{
  char sql[100] ;

  strcpy_s(sql,100, "Delete from link where sym2ID=-1") ;

  try
  {
    executeResultlessQuery(sql) ;
  }
  catch (...)
  {
  }
}


void TreeHelper::createLinkType()
{
  string tableName("linktype") ;

  // Create Table
  createTable(tableName , "lktID int not null , lktName varchar (25) not null", "lktID") ;

  // Populate array with data

  Datum linkType ;

  linkType["xref"] = MasterData::XREF_LINK ;
  linkType["super"] = MasterData::SUPER_LINK ;
  linkType["sub"] = MasterData::SUB_LINK ;
  linkType["package"] = MasterData::PACKAGE_LINK ;
  linkType["import"] = MasterData::IMPORT_LINK ;
  linkType["implements"] = MasterData::IMPLEMENTS_LINK ;
  linkType["parameter"] = MasterData::PARAMETER_LINK ;
  linkType["type"] = MasterData::TYPE_LINK ;

  for(DatumItr d = linkType.begin() ; d != linkType.end() ; d++)
    insertRow(d, tableName) ;
}


void TreeHelper::createCategory()
{
  string tableName("category") ;

  // Create Table
  createTable(tableName , "catID int not null , catName varchar (25) not null", "catID") ;

  // Populate array with data
  Datum category ;

  category["project"] = MasterData::PROJECT_CAT ;
  category["package"] = MasterData::PACKAGE_CAT ;
  category["namespace"] = MasterData::NAMESPACE_CAT ;
  category["file"] = MasterData::FILE_CAT ;
  category["class"] = MasterData::CLASS_CAT ;
  category["interface"] = MasterData::INTERFACE_CAT ;
  category["method"] = MasterData::METHOD_CAT ;
  category["field"] = MasterData::FIELD_CAT ;

  for(DatumItr d = category.begin() ; d != category.end() ; d++)
    insertRow(d, tableName) ;
}


void TreeHelper::createProtectionLevel()
{
  string tableName("protectionlevel") ;

  // Create Table
  createTable(tableName , "prtID int not null , prtName varchar (25) not null", "prtID") ;

  Datum protLevel ;

  protLevel["package"] = MasterData::PACKAGE_PROT ;
  protLevel["public"] = MasterData::PUBLIC_PROT ;
  protLevel["protected"] = MasterData::PROTECTED_PROT ;
  protLevel["private"] = MasterData::PRIVATE_PROT ;

  for(DatumItr d = protLevel.begin() ; d != protLevel.end() ; d++)
    insertRow(d, tableName) ;
}


void TreeHelper::createTempLink()
{
  // TempLink 1:M TempLinkDetail
  // Detail table contains zero to many types for each TempLink
  // Used to store the types of each parameter in an unresolved fn call

  dropTempLink() ;

  createTable("templink", "tlkID int not null,symID int not null,lktID int not null,ref varchar (128) not null,parms int not null", "tlkID") ;
  addIndex("templink" , "refIndex", "ref") ;
  addIndex("templink" , "lktIndex", "lktID") ;
  addIndex("lemplink" , "symIDIndex", "symID") ;

  createTable("TempLinkDetail" , "tldID int not null,tlkID int not null,lktID int not null", "tlkID") ;
}


void TreeHelper::dropTempLink()
{
  dropTable("TempLink") ;
  dropTable("TempLinkDetail") ;
}


long TreeHelper::addSymbolType(long symID, string sytName)
{
  long newID = theCurrentTypeID.newID() ;
  theType[sytName] = newID ;
  //DatumItr d = theType.find(sytName) ;
  insertSymbolTypeRow(newID,sytName, symID) ;

  return newID ;
}


string TreeHelper::getSymbolTypeName(long sytID)
{
  DatumItr i = theType.begin() ;

  for ( ; i!=theType.end() ; i++)
  {
    if (i->second == sytID)
      return i->first ;
  }

  return "" ;
}


long TreeHelper::getSymbolID(long sytID)
{
  // Given a Symbol Type ID, locates the row in SymbolType
  // and returns the symID (i.e. the Symbol Definition) for
  // the Type

  char sql[1024], charNumber[30] ;

  strcpy_s(sql,1024,"Select symID From symboltype Where sytID=") ;
  strcat_s(sql,1024, ltostr(sytID, charNumber, 30)) ;

  try
  {
    if (executeQuery(sql))
    {
      return longCell(0,0) ;
    }
  }
  catch (...)
  {
    //TODO: theLog << "Error SymbolType executing query!" << endl ;
  }

  return -1 ;
}


long TreeHelper::getSymbolTypeID(string symName)
{
  long retval = theType[symName] ;

  if (retval == 0)
  {
    return -1 ;
  }

  return retval ;
}


void TreeHelper::deleteSymbol(long symID)
{
  if (theDelIDs.size() > DELETED_THRESHOLD)
  {
    flushDeleteSymbol();
  }

  theDelIDs.push_back(symID) ;
}

void TreeHelper::flushDeleteSymbol()
{
  if (theDelIDs.size()>0)
  {
    flushWriteSymbol() ;

    char sql[QUERY_MAX] ;
    char idString[4096], charNumber[30] ;

    strcpy_s(idString,4096, "(") ;

    for(unsigned int i=0; i<theDelIDs.size(); i++)
    {
      strcat_s(idString,4096, ltostr(theDelIDs[i], charNumber, 30)) ;
      strcat_s(idString,4096, ",") ;
      releaseID(theDelIDs[i]) ;
    }

    idString[strlen(idString)-1] = ')' ;

#ifdef PROFESSIONAL
    strcpy_s(sql,QUERY_MAX, "delete from link where symID IN ") ;
    strcat_s(sql,QUERY_MAX, idString) ;
    strcat_s(sql,QUERY_MAX, " or sym2ID IN ") ;
    strcat_s(sql,QUERY_MAX, idString) ;
    executeResultlessQuery(sql) ;
#endif

    strcpy_s(sql,QUERY_MAX, "delete from symbol where symID IN ") ;
    strcat_s(sql,QUERY_MAX, idString) ;
    executeResultlessQuery(sql) ;

    strcpy_s(sql,QUERY_MAX, "delete from metric where symID IN ") ;
    strcat_s(sql,QUERY_MAX, idString) ;
    executeResultlessQuery(sql) ;

    theDelIDs.clear() ;
  }
}


void TreeHelper::writeSymbol(long symID, long parID, const char *symName, long sytID, long catID, long prtID)
{
  strcpy_s(theTmpSymWrite,512,"(") ;
  strcat_s(theTmpSymWrite,512, ltostr(symID, theCharNumber, 30)) ;
  strcat_s(theTmpSymWrite,512,",") ;
  strcat_s(theTmpSymWrite,512, ltostr(parID, theCharNumber, 30)) ;
  strcat_s(theTmpSymWrite,512,",'") ;
  strcat_s(theTmpSymWrite,512, symName) ;
  strcat_s(theTmpSymWrite,512, "',") ;
  strcat_s(theTmpSymWrite,512, ltostr(sytID, theCharNumber, 30)) ;
  strcat_s(theTmpSymWrite,512,",") ;
  strcat_s(theTmpSymWrite,512, ltostr(catID, theCharNumber, 30)) ;
  strcat_s(theTmpSymWrite,512,",") ;
  strcat_s(theTmpSymWrite,512, ltostr(prtID, theCharNumber, 30)) ;
  strcat_s(theTmpSymWrite,512,"),") ;

  theNSymWrite += strlen(theTmpSymWrite) ;

  if (theNSymWrite>=QUERY_MAX)
  {
    flushWriteSymbol() ;
    strcat_s(theSymWrite, QUERY_MAX, theTmpSymWrite) ;

    theSymToWrite = true ;
    theNSymWrite = strlen(theSymWrite) ;
  }
  else
  {
    theSymToWrite = true ;
    strcat_s(theSymWrite,QUERY_MAX,theTmpSymWrite) ;
  }
}

void TreeHelper::flushWriteSymbol()
{
  if (theSymToWrite)
  {
    theSymWrite[strlen(theSymWrite)-1] = '\0' ;
    executeResultlessQuery(theSymWrite) ;

    strcpy_s(theSymWrite, QUERY_MAX, "REPLACE INTO symbol VALUES ") ;

    theNSymWrite = strlen(theSymWrite) ;
    theSymToWrite = false ;
  }
}


// A01 Begin ------------------------------------------------------------------

char* TreeHelper::buildTableName(const int table, int index)
{
  if (table == ANCESTRY)
  {
    strcpy_s(theTableName, 64, "ancestry") ;
  } else {
    // SUBPRO
    strcpy_s(theTableName, 64, "ancestry_subp") ;
  }

  if (index == 0) return theTableName ;

  strcat_s(theTableName, 64, ltostr(index, theCharNumber, 30)) ;
  return theTableName ;
}


void TreeHelper::buildAncestry()
{
  char *createTable2, *insertTable2, *insertTable3, *insertTable4, *insertTable5, *insertTable6 ;

  createTable2 = _strdup(" (symid int not null, catid int not null, symname varchar(128), psymid int not null, pcatid int not null, psymname varchar(128) not null, filid int, filname varchar(128), primary key (symid), unique index (symid))") ;

  insertTable2 = _strdup(" select s1.symID as symID, s1.catID as catID, s1.symName as symName, s2.symID as psymID, s2.catID as pcatID, s2.symName as psymName, s2.symID as filID, s2.symName as filName from symbol s1 inner join ") ;
  insertTable3 = _strdup(" s2 on s1.symparentid=s2.symid where s2.catid=4") ;

  insertTable4 = _strdup(" select s1.symID as symID, s1.catID as catID, s1.symName as symName, s2.symID as psymID, s2.catID as pcatID, s2.symName as psymName, s2.filID as filID, s2.filName as filName from symbol s1 inner join ") ;
  insertTable5 = _strdup(" s2 on s1.symparentid=s2.symid where s1.catid<>8") ;

  char sql[QUERY_MAX] ;

  // Drop initial Ancestry table
  strcpy_s(sql,QUERY_MAX, DROP_TABLE) ;
  strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, 0)) ;
  executeResultlessQuery(sql) ;

  // Create initial Ancestry table
  strcpy_s(sql,QUERY_MAX, CREATE_TABLE) ;
  strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, 0)) ;
  strcat_s(sql,QUERY_MAX, createTable2) ;
  executeResultlessQuery(sql) ;

  // Get initial data from symbol
  strcpy_s(sql,QUERY_MAX, INSERT_TABLE) ;
  strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, 0)) ;
  strcat_s(sql,QUERY_MAX, insertTable2) ;
  strcat_s(sql,QUERY_MAX, "symbol") ;
  strcat_s(sql,QUERY_MAX, insertTable3) ;
  executeResultlessQuery(sql) ;

  int i,j,c=1 ;
  for(i=1; c>0; i++)
  {
    // Drop i-level Ancestry table
    strcpy_s(sql,QUERY_MAX, DROP_TABLE) ;
    strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, i)) ;
    executeResultlessQuery(sql) ;

    // Create i-level Ancestry table
    strcpy_s(sql,QUERY_MAX, CREATE_TABLE) ;
    strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, i)) ;
    strcat_s(sql,QUERY_MAX, createTable2) ;
    executeResultlessQuery(sql) ;

    // Get i-level data from previous Ancestry
    strcpy_s(sql,QUERY_MAX, INSERT_TABLE) ;
    strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, i)) ;
    strcat_s(sql,QUERY_MAX, insertTable4) ;
    strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, i-1)) ;
    strcat_s(sql,QUERY_MAX, insertTable5) ;
    executeResultlessQuery(sql) ;

    strcpy_s(sql,QUERY_MAX, "select count(*) from ") ;
    strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, i)) ;
    if (executeQuery(sql))
    {
      c = longCell(0, 0) ;
    }
  }

  // Copy all temp ancestryX tables into master ancestry
  for(j=1; j<i; j++)
  {
    // Copy details from temporary table into master
    strcpy_s(sql,QUERY_MAX, "insert ") ;
    strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, 0)) ;
    strcat_s(sql,QUERY_MAX, " select * from ") ;
    strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, j)) ;
    executeResultlessQuery(sql) ;

    // Drop temporary table
    strcpy_s(sql,QUERY_MAX, DROP_TABLE) ;
    strcat_s(sql,QUERY_MAX, theTableName) ;
    executeResultlessQuery(sql) ;
  }

  // Drop last temporary table that was never populated
  strcpy_s(sql,QUERY_MAX, DROP_TABLE) ;
  strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, i)) ;
  executeResultlessQuery(sql) ;

  free(createTable2) ;
  free(insertTable2) ;
  free(insertTable3) ;
  free(insertTable4) ;
  free(insertTable5) ;

  createTable2 = _strdup(" (symid int not null, symname varchar(128), psymid int not null, psymname varchar(128) not null, subdepth int not null, primary key (symid), unique index (symid))") ;
  insertTable2 = _strdup(" select symid, symname, symparentid as psymid, concat('/',symname) as psymname, 1 from symbol where symparentid=1 and catid=1") ;
  insertTable4 = _strdup(" select s1.symid, s1.symname, s1.symparentid, concat(sp.psymname,'/',s1.symname), ") ;
  insertTable5 = _strdup(" from symbol s1 inner join ") ;
  insertTable6 = _strdup(" sp on s1.symparentid=sp.symid where catid=1") ;

  // Drop initial Subpro table
  strcpy_s(sql,QUERY_MAX, DROP_TABLE) ;
  strcat_s(sql,QUERY_MAX, buildTableName(SUBPRO, 0)) ;
  executeResultlessQuery(sql) ;

  // Create initial Subpro table
  strcpy_s(sql,QUERY_MAX, CREATE_TABLE) ;
  strcat_s(sql,QUERY_MAX, buildTableName(SUBPRO, 0)) ;
  strcat_s(sql,QUERY_MAX, createTable2) ;
  executeResultlessQuery(sql) ;

  // Get initial data from symbol
  strcpy_s(sql,QUERY_MAX, INSERT_TABLE) ;
  strcat_s(sql,QUERY_MAX, buildTableName(SUBPRO, 0)) ;
  strcat_s(sql,QUERY_MAX, insertTable2) ;
  executeResultlessQuery(sql) ;

  for(i=1, c=1; c>0; i++)
  {
    // Drop i-level Subpro table
    strcpy_s(sql,QUERY_MAX, DROP_TABLE) ;
    strcat_s(sql,QUERY_MAX, buildTableName(SUBPRO, i)) ;
    executeResultlessQuery(sql) ;

    // Create i-level Subpro table
    strcpy_s(sql,QUERY_MAX, CREATE_TABLE) ;
    strcat_s(sql,QUERY_MAX, buildTableName(SUBPRO, i)) ;
    strcat_s(sql,QUERY_MAX, createTable2) ;
    executeResultlessQuery(sql) ;

    // Get i-level data from previous Subpro
    strcpy_s(sql,QUERY_MAX, INSERT_TABLE) ;
    strcat_s(sql,QUERY_MAX, buildTableName(SUBPRO, i)) ;
    strcat_s(sql,QUERY_MAX, insertTable4) ;
    strcat_s(sql,QUERY_MAX, ltostr(i+1, theCharNumber, 30)) ; // Include depth information
    strcat_s(sql,QUERY_MAX, insertTable5) ;
    strcat_s(sql,QUERY_MAX, buildTableName(SUBPRO, i-1)) ;
    strcat_s(sql,QUERY_MAX, insertTable6) ;
    executeResultlessQuery(sql) ;

    strcpy_s(sql,QUERY_MAX, "select count(*) from ") ;
    strcat_s(sql,QUERY_MAX, buildTableName(SUBPRO, i)) ;
    if (executeQuery(sql))
    {
      c = longCell(0, 0) ;
    }
  }

  // Copy all temp subpX tables into master Ancestry
  for(j=0; j<i; j++)
  {
    // Copy details from temporary table into master
    strcpy_s(sql,QUERY_MAX, INSERT_TABLE) ;
    strcat_s(sql,QUERY_MAX, buildTableName(ANCESTRY, 0)) ;
    strcat_s(sql,QUERY_MAX, " select symid, 1, symname, psymid, 1, psymname, subdepth as filid, '' as filname from ") ;
    strcat_s(sql,QUERY_MAX, buildTableName(SUBPRO, j)) ;
    executeResultlessQuery(sql) ;

    // Drop temporary table
    strcpy_s(sql,QUERY_MAX, DROP_TABLE) ;
    strcat_s(sql,QUERY_MAX, theTableName) ;
    executeResultlessQuery(sql) ;
  }

  // Drop last temporary table that was never populated
  strcpy_s(sql,QUERY_MAX, DROP_TABLE) ;
  strcat_s(sql,QUERY_MAX, buildTableName(SUBPRO, i)) ;
  executeResultlessQuery(sql) ;

  // Lastly, insert the root project
  strcpy_s(sql,QUERY_MAX, "insert ancestry values (1, 1, '/', 0, 0, '/', 0, '')") ;
  executeResultlessQuery(sql) ;

  free(createTable2) ;
  free(insertTable2) ;
  free(insertTable4) ;
  free(insertTable5) ;
  free(insertTable6) ;

  // Finally, copy across Packages and Files so that all data is available from the Ancestry table
  strcpy_s(sql,QUERY_MAX, "insert ancestry select symid, catid, symname, 0, 0, '', 0, '' from symbol where catid in (2,4) order by catid") ;
  executeResultlessQuery(sql) ;
}

// A01 End --------------------------------------------------------------------
