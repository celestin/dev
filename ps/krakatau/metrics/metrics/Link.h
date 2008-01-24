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

#ifndef METRICS_LINK
#define METRICS_LINK

#include <iostream>
#include <vector>
#include "AutoNumber.h"
#include "DataRow.h"
#include "MasterData.h"
#include "OurSQL.h"

namespace metrics
{

#define AUTONUMBER 0

	class Links ;

	class Link : public DataRow
	{
		friend class Links ;

	private:
		static AutoNumber theAutoNumber ;

		long theID ;			// Link ID (lnkID)
		long theSourceID ;		// Source (or From) ID (symID)
		long theDestID ;		// Destination (or To) ID (sym2ID)
		long theTypeID ;		// Link Type (lktID)
		std::string theRef ;	// Ref (or Name)

	protected:

	public:

		bool theWritten ;

		Link(): theRef("")
		{
			theID = AUTONUMBER ;
			theSourceID = 0 ;
			theDestID = 0 ;
			theTypeID = 0 ;
			theWritten = false ;
		}

		Link(long sourceID, long destID, long typeID): theRef("")
		{
			theID = AUTONUMBER ;
			theSourceID = sourceID ;
			theDestID = destID ;
			theTypeID = typeID ;
			theWritten = false ;
		}

		Link(long newID, long sourceID, long destID, long typeID): theRef("")
		{
			theID = newID ;
			theSourceID = sourceID ;
			theDestID = destID ;
			theTypeID = typeID ;
			theWritten = false ;  // Allow this Link to be updated
		}

		Link(long sourceID, long destID, long typeID, bool newWritten): theRef("")
		{
			theID = AUTONUMBER ;
			theSourceID = sourceID ;
			theDestID = destID ;
			theTypeID = typeID ;
			theWritten = newWritten ;
		}

		Link(long sourceID, long typeID, std::string newRef): theRef(newRef)
		{
			// Used to mimic TempLinks
			theID = AUTONUMBER ;
			theSourceID = sourceID ;
			theDestID = -1 ;
			theTypeID = typeID ;
			theWritten = false ;
		}

		Link(const Link& rhs)
		{
			theID = rhs.theID ;
			theSourceID = rhs.theSourceID ;
			theDestID = rhs.theDestID ;
			theTypeID = rhs.theTypeID ;
			theWritten = rhs.theWritten ;
			theRef = rhs.theRef ;
		}

		virtual ~Link() ;

		void setID(long newID)				{ theID = newID ; }
		long getID()						{ return theID ; }
		void setSourceID(long newSourceID)	{ theSourceID = newSourceID ; }
		long getSourceID()					{ return theSourceID ; }
		void setDestID(long newDestID)		{ theDestID = newDestID; }
		long getDestID()					{ return theDestID ; }
		void setTypeID(long newTypeID)		{ theTypeID = newTypeID ; }
		long getTypeID()					{ return theTypeID ; }
		void setRef(std::string newRef)		{ theRef = newRef ; }
		std::string getRef()				{ return theRef ; }

		void write() ;	// Send Row to DatabaseConnection
		void read() ;	// Get Row from DatabaseConnection

		std::string formSqlInsert() ;
		void updateLink(OurSQL &connection) ;

		void getStatement(char *sql)
		{
			strcpy(sql, "Insert into link values ") ;
		}


		void getValues(char *sql)
		{
			char charNumber[30] ;

			strcat(sql,"(") ;

			if (theID == AUTONUMBER) theID = theAutoNumber.newID() ;

			strcat(sql, ltostr(theID, charNumber, 30)) ;
			strcat(sql,",") ;

			strcat(sql, ltostr(theSourceID, charNumber, 30)) ;
			strcat(sql,",") ;

			strcat(sql, ltostr(theDestID, charNumber, 30)) ;
			strcat(sql,",") ;

			strcat(sql, ltostr(theTypeID, charNumber, 30)) ;
			strcat(sql,",'") ;

			strcat(sql, theRef.c_str()) ;
			strcat(sql, "')") ;
		}


		static void resetID(long initial) { theAutoNumber.reset(initial) ; }
	} ;

#define NLINKTYPES 8
#define MAX_LINK_INSERTS 1000

	class Links
	{

	protected:

		long theID ;
		std::vector<Link> *theLinks[NLINKTYPES]  ;

		std::string theInsertSql ;
		int theNumInserts ;

		void deleteLinks() ;

		void flushInsert(OurSQL&) ;
		void addInsert(OurSQL&, std::string) ;

	public:

		Links(): theInsertSql("")
		{
			int i;
			for( i=0; i<NLINKTYPES; i++)
			{
				theLinks[i] = NULL ;
			}
			theID = 0 ;
			theNumInserts = 0 ;
		}
		Links(int newID): theInsertSql("")
		{
			int i;
			for( i=0; i<NLINKTYPES; i++)
			{
				theLinks[i] = NULL ;
			}
			theID = newID ;
			theNumInserts = 0 ;
		}
		virtual ~Links() ;

		void initLinks() ;
		void clearLinks() ;
		void readLinks(OurSQL&) ;
		void addLink(long toID, long lktID) ;
		void addLink(long lnkID, long toID, long lktID) ;
		std::vector<Link> getLinks() ;
		std::vector<Link> getLinks(long lktID) ;

		void write(OurSQL&) ;

	} ;


	class Killer
	{

#define KILLER_BUFFER_SIZE 4096

	private:
		OurSQL *theConnection ;
		char theLinkFromSql[KILLER_BUFFER_SIZE] ;
		char theLinkToSql[KILLER_BUFFER_SIZE] ;
		char theTypeSql[KILLER_BUFFER_SIZE] ;
		char theSymbolSql[KILLER_BUFFER_SIZE] ;
		bool anyData ;

	public:
		Killer() ;
		~Killer() ;

		void setConnection(OurSQL *newConnection) ;
		void clear() ;
		void add(long symID) ;
		void flush() ;
	} ;
} ;

#endif
