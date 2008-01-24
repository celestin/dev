/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * --------------------------------------------------------------------------------
 * ID  By    Date        Description
 * A01 CAM   10/10/2001  Added code to build Ancestry table - a denormalised table
 * A02                   code symbol ID, Cat & Name + Parent ID Cat & Name +
 *                       File ID & Name - for reporting purposes
 * --------------------------------------------------------------------------------
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef METRICS_TREEHELPER
#define METRICS_TREEHELPER

#include "AutoNumber.h"
#include "Cache.h"
#include "OurSQL.h"
#include "MasterData.h"

#include <string>

typedef std::map<std::string,long> Datum ;
typedef std::map<std::string,long>::iterator DatumItr ;

namespace metrics
{
	class TreeHelper : public AutoNumber, public OurSQL, public Cache
	{

#define DELETED_THRESHOLD 100
#define MAX_QUERY_LENGTH 4096

	private:

		AutoNumber theCurrentTypeID ;
		std::vector<long> theDelIDs ;
		char theTmpSymWrite[400] ;
		char theSymWrite[MAX_QUERY_LENGTH] ;
		char theCharNumber[30] ;
		char theTableName[64] ;
		int theNSymWrite ;
		bool theSymToWrite ;

	protected:

		Datum theType ;

		long theNodeCount ;

		void dropTable(std::string tableName) ;
		void createTable(std::string tableName, std::string fieldList) ;
		void createTable(std::string tableName, std::string fieldList,
			std::string keyField) ;
		void addIndex(std::string tableName, std::string indexName,
			std::string fieldList) ;
		void insertRow(DatumItr d, std::string tableName) ;
		void insertSymbolTypeRow(long, std::string, long) ;
		void insertCommonMetricsForCat(long) ;
		void insertMetricTypeRow(long, long, std::string, std::string) ;
		void insertMetricTypeRow(long, long, int, std::string, std::string) ;

		void createCategory() ;
		void createLink() ;
		void createLinkType() ;
		void createMetric() ;
		void createMetricComp() ;
		void createSymbolComp() ;
		void createSymbolDel() ;
		void createMetricType() ;
		void createProtectionLevel() ;
		void createSymbol() ;
		void createSymbolXtra() ;
		void createSymbolType() ;

		char* buildTableName(const int, int) ; // A01

	public:

		TreeHelper() : AutoNumber(), OurSQL(), Cache()
		{
			long nextID = getNextID("symboltype","sytID") ;
			if (nextID>MasterData::USERTYPES)
			{
				theCurrentTypeID.reset(nextID) ;
			}

			strcpy(theSymWrite, "replace into symbol values ") ;
			theNSymWrite = strlen(theSymWrite) ;
			theSymToWrite = false ;
		}

		TreeHelper(std::string dbName) ;
		virtual ~TreeHelper() { MasterData::theLog << "Complete." << std::endl ;}


		void incNodeCount() { theNodeCount++; }
		void decNodeCount() { theNodeCount--; }
		void setNodeCount(long newNodeCount) { theNodeCount = newNodeCount; }
		long getNodeCount() { return theNodeCount; }

		virtual void reset(int initial)
		{
			theNodeCount = 0 ;
			AutoNumber::reset(initial) ;
		}

		void recreateDatabase() ;
		void readSymbolType() ;
		long getNextID(std::string tableName, std::string idField) ;

		void deleteSymbol(long) ;
		void flushDeleteSymbol() ;

		void writeSymbol(long, long, const char*, long, long, long) ;
		void flushWriteSymbol() ;

		long addSymbolType(long, std::string) ;
		long getSymbolID(long) ;
		long getSymbolTypeID(std::string) ;
		std::string getSymbolTypeName(long) ;


		void createTempLink() ;
		void dropTempLink() ;
		void zapMetric()		{ createMetric() ; }
		void deleteTempLinks() ;

		void createSourceFile() ;
		void insertSourceFile(std::string filename)
		{
			executeQuery(std::string("insert into sourcefile (srfName) values ('" + filename + "')")) ;
		}

		void buildAncestry() ;  // A02

	} ;

} ;

#endif
