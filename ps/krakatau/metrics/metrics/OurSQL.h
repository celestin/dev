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

#ifndef CLASS_OURSQL
#define CLASS_OURSQL

//#include <windows.h>
#include <mysql.h>
#include <string.h>
#include <string>
#include <vector>
#include <iostream>

#define OUR_TYPE_NULL 0
#define OUR_TYPE_LONG 1
#define OUR_TYPE_DOUBLE 2
#define OUR_TYPE_STRING 3

namespace metrics
{
	class OurSQL
	{
	private:
		MYSQL	*theConnection ;	// MySQL Connection data
		bool	theConnected ;		// Has a connection been established?
		std::string theHost ;		// Hostname (def. "localhost")
		std::string theDB ;			// Database

		bool	theResultsAvailable ;	// Result set is available?
		int		*theColTypes ;			// Column Types array
		std::vector<char**> theResults ;		// Results matrix
		int		theRows ;				// Number of Rows in Result set
		int		theCols ;				// Number of Cols in Result set

	protected:

		void initResults() ;


	public:

		OurSQL() ;
		OurSQL(std::string host, std::string dbName) ;
		OurSQL(std::string dbName) ;
		OurSQL(const OurSQL &rhs) ;

		const OurSQL& operator=(const OurSQL &rhs) ;

		virtual ~OurSQL() ;

		int no_of_queries ;

		// Connecting
		void connect() ;
		inline bool connected() const { return (theConnected) ; }
		void disconnect() ;
		bool executeQuery(std::string query) ;
		bool executeQuery(char *query) ;
		bool executeResultlessQuery(char *query) ;
		bool executeResultlessQuery(std::string query) ;

		// Managing Result Set
		void setupResultGrid(MYSQL_RES *result) ;
		inline bool resultsAvailable() const { return (theResultsAvailable) ; }
		inline int rows() const { return (theRows) ; }
		int cols() const { return (theCols) ; }
		int getColType(int c)  const ;

		// Get contents of Cell in Matrix
		std::string cell(int row, int col) const ;	// String return type
		long longCell(int row, int col) const ;		// Long value (0 if no conversion)
		double doubleCell(int row, int col) const ;	// Double value (0 if no conversion)
		void clearResults() ;

		std::string getHost()	{ return theHost ; }
		std::string getDB()		{ return theDB ; }

	} ;


	/*class DBCreate
	{
	private:
		OurSQL theConnection ;
		std::string theDBName ;

	public:
		DBCreate() ;
		DBCreate(std::string newDBName) ;
		virtual ~DBCreate() ;

		void drop() ;
		void create() ;

		void disconnect() ;

	} ;*/
} ;

#endif

