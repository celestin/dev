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

#ifndef METRICS_SYMBOLCOMP
#define METRICS_SYMBOLCOMP

#include <string>

#include "DataRow.h"
#include "MasterData.h"

#define COMPS_PER_SELECT 1000

namespace metrics
{
	class SymbolComp : public DataRow
	{
	private:

		long theSymID ;
		//long theSym2ID ;
		long theStatus ;

	protected:

	public:

		SymbolComp()
		{
			theSymID = 0 ;
			//theSym2ID = 0 ;
			theStatus = 0 ;
		}

		SymbolComp(long newSymID, /*long newSym2ID,*/ long newStatus)
		{
			theSymID = newSymID ;
			//theSym2ID = newSym2ID ;
			theStatus = newStatus ;
		}

		virtual ~SymbolComp() {;}

		void write() {;}
		void read() {;}

		void getStatement(char *sql)
		{
			strcpy(sql, "REPLACE INTO symbolcomp VALUES ") ;
		}

		void getValues(char *sql)
		{
			char charNumber[30] ;

			strcat(sql,"(") ;

			//itoa(theSymID, charNumber, 10) ;
			//strcat(charNumber,",") ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theSymID, charNumber, 30)) ;
			strcat(sql,",") ;

			//itoa(theStatus, charNumber, 10) ;
			//strcat(charNumber,")") ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theStatus, charNumber, 30)) ;
			strcat(sql,")") ;
		}

	} ;


	class SymbolDel : public DataRow
	{
	private:

		long theSymID ;
		long theParentID ;
		long theNewParentID ;
		std::string theName ;
		long theTypeID ;
		long theCatID ;
		long theProtectionID ;


	protected:

	public:

		SymbolDel() : theName("")
		{
			theSymID = 0 ;
			theParentID = 0 ;
			theNewParentID = 0 ;
			theTypeID = 0 ;
			theCatID = 0 ;
			theProtectionID = 0 ;
		}

		SymbolDel(long newSymID, long newParentID, long newNewParentID, std::string newName,
			long newTypeID, long newCatID, long newProtID) : theName(newName)
		{
			theSymID = newSymID ;
			theParentID = newParentID ;
			theNewParentID = newNewParentID ;
			theTypeID = newTypeID ;
			theCatID = newCatID ;
			theProtectionID = newProtID ;
		}

		virtual ~SymbolDel() {;}

		void write() {;}
		void read() {;}

		void getStatement(char *sql)
		{
			strcpy(sql, "REPLACE INTO symboldel VALUES ") ;
		}

		void getValues(char *sql)
		{
			char charNumber[30] ;

			strcat(sql,"(") ;

			//itoa(theSymID, charNumber, 10) ;
			//strcat(charNumber,",") ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theSymID, charNumber, 30)) ;
			strcat(sql,",") ;

			//itoa(theParentID, charNumber, 10) ;
			//strcat(charNumber,",") ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theParentID, charNumber, 30)) ;
			strcat(sql,",") ;

			//itoa(theNewParentID, charNumber, 10) ;
			//strcat(charNumber,",'") ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theNewParentID, charNumber, 30)) ;
			strcat(sql,",'") ;

			strcat(sql, theName.c_str()) ;
			strcat(sql, "',") ;

			//itoa(theTypeID, charNumber, 10) ;
			//strcat(charNumber,",") ;
			strcat(sql, charNumber) ;
			strcat(sql, ltostr(theTypeID, charNumber, 30)) ;
			strcat(sql,",") ;

			//itoa(theCatID, charNumber, 10) ;
			//strcat(charNumber,",") ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theCatID, charNumber, 30)) ;
			strcat(sql,",") ;

			//itoa(theProtectionID, charNumber, 10) ;
			//strcat(charNumber,")") ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theProtectionID, charNumber, 30)) ;
			strcat(sql,")") ;
		}

	} ;


	class MetricComp : public DataRow
	{
	private:

		long theSymID ;
		long theMttID ;
		float theMetvalue ;

	protected:

	public:

		MetricComp()
		{
			theSymID = 0 ;
			theMttID = 0 ;
			theMetvalue = 0 ;
		}

		MetricComp(long newSymID, long newMttID, float newMetvalue)
		{
			theSymID = newSymID ;
			theMttID = newMttID ;
			theMetvalue = newMetvalue ;
		}

		virtual ~MetricComp() {;}

		void write() {;}
		void read() {;}

		void getStatement(char *sql)
		{
			strcpy(sql, "REPLACE INTO metriccomp VALUES ") ;
		}

		void getValues(char *sql)
		{
			char charNumber[30] ;

			strcat(sql,"(") ;

			//itoa(theSymID, charNumber, 10) ;
			//strcat(charNumber,",") ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theSymID, charNumber, 30)) ;
			strcat(sql,",") ;

			//itoa(theMttID, charNumber, 10) ;
			//strcat(charNumber,",") ;
			//strcat(sql, charNumber) ;
			strcat(sql, ltostr(theMttID, charNumber, 30)) ;
			strcat(sql,",") ;

			//_gcvt(theMetvalue, 7, charNumber) ;
			//strcat(charNumber,")") ;
			//strcat(sql, charNumber) ;
			strcat(sql,dtoa(theMetvalue, charNumber, 30)) ;
			strcat(sql,")") ;
		}

	} ;

} ;

#endif
