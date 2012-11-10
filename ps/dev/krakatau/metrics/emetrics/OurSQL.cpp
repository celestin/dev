/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential Metrics (EMETRICS.EXE)
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  28-Mar-08  348 : File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <iostream> 
//#include <sstream>
using namespace std ;

#include "OurSQL.h"
using namespace metrics ;


OurSQL::OurSQL()
{
	theHost = "" ;
	theDB = "" ;
	theConnected = false ;
	no_of_queries = 0 ;

	theResultsAvailable = false ;
	initResults() ;
}


OurSQL::OurSQL(std::string host, std::string dbName)
{
	theHost = host ;
	theDB = dbName ;
	theConnected = false ;
	no_of_queries = 0 ;
	
	theResultsAvailable = false ;
	initResults() ;
}


OurSQL::OurSQL(std::string dbName)
{
	theHost = "" ;
	theDB = dbName ;
	theConnected = false ;
	no_of_queries = 0 ;
	
	theResultsAvailable = false ;
	initResults() ;
}

OurSQL::OurSQL(const OurSQL &rhs)
{
	theConnection = rhs.theConnection ;
	theConnected = rhs.theConnected ;
	theHost = rhs.theHost ;
	theDB = rhs.theDB ;
	
	theResultsAvailable = rhs.theResultsAvailable ;

	theColTypes = rhs.theColTypes ;
	theResults = rhs.theResults ;
	theRows = rhs.theRows ;
	theCols = rhs.theCols ;

	no_of_queries = rhs.no_of_queries ;
}


const OurSQL& OurSQL::operator=(const OurSQL &rhs)
{
	theConnection = rhs.theConnection ;
	theConnected = rhs.theConnected ;
	theHost = rhs.theHost ;
	theDB = rhs.theDB ;
	
	theResultsAvailable = rhs.theResultsAvailable ;

	theColTypes = rhs.theColTypes ;
	theResults = rhs.theResults ;
	theRows = rhs.theRows ;
	theCols = rhs.theCols ;

	no_of_queries = rhs.no_of_queries ;

	return (*this) ;
}


OurSQL::~OurSQL()
{
	clearResults() ;	// Clear any query results
	//disconnect() ;		// Disconnect from DB
}


void OurSQL::initResults()
{
	theResults.clear() ;
	theColTypes = NULL ;
}


void OurSQL::connect()
{
	theConnection = mysql_init((MYSQL*) 0) ;

	if (!mysql_real_connect(theConnection, theHost.c_str(), "root", 
		"", theDB.c_str(), 0, NULL, 0))
	{
		//MasterData::theLog << "Failed to connect to database: Error: " << 
		//		mysql_error(theConnection) << endl ;
	}
	else
		theConnected = true ;
}


void OurSQL::disconnect()
{
	if (theConnected)
	{
		mysql_close(theConnection) ;
		theConnected = false ;
	}
}


void OurSQL::setupResultGrid(MYSQL_RES *result)
{
	theCols = mysql_num_fields(result) ;
	theRows = 0 ;

	theColTypes = new int[theCols] ;
	theResults.clear() ;

	unsigned int numFields ;
	unsigned int i;
	MYSQL_FIELD *fields;

	numFields = mysql_num_fields(result);
	fields = mysql_fetch_fields(result);
	for(i = 0; i < numFields; i++)
	{
		int type = fields[i].type ;

		if (IS_NUM(type)) // MySQL macro to determine numericy or otherwise
		{
			if ((type == FIELD_TYPE_FLOAT) || (type == FIELD_TYPE_DOUBLE))
			{
				theColTypes[i] = OUR_TYPE_DOUBLE ;
			}
			else
			{
				theColTypes[i] = OUR_TYPE_LONG ;
			}
		}
		else
		{
			theColTypes[i] = OUR_TYPE_STRING ;
		}
	}
}


bool OurSQL::executeQuery(string query)
{
	if (!theConnected) return false ;

	MYSQL_RES *result;
	clearResults() ; // Clear any existing results first

	if (mysql_query(theConnection,query.c_str()))
	{
		//cout << "[" << query.c_str() << "]" << endl ;
		return false ;
	}
	else // query succeeded, process any data returned by it
	{
		result = mysql_use_result(theConnection) ;

		if (result) // There is a result
		{
			MYSQL_ROW row ;
			row = mysql_fetch_row(result) ;

			if (row != NULL)  // Check there are actually rows
			{
				theResultsAvailable = true ;
				setupResultGrid(result) ;
				char **thisRow ;

				while (row != NULL) // Retrieve rows
				{
					thisRow = new char*[theCols] ;

					for(int i = 0; i < theCols; i++)
					{
						thisRow[i] = _strdup(row[i]) ;
					}

					theResults.push_back(thisRow) ;
					theRows++ ;

					row = mysql_fetch_row(result) ;			
				}
			}

			mysql_free_result(result) ;
		}
	}
	
	return theResultsAvailable ;
}


bool OurSQL::executeQuery(char *query)
{
	if (!theConnected) return false ;

	MYSQL_RES *result;
	clearResults() ; // Clear any existing results first

	if (mysql_query(theConnection,query))
	{
		//cout << "[" << query.c_str() << "]" << endl ;
		return false ;
	}
	else // query succeeded, process any data returned by it
	{
		result = mysql_use_result(theConnection) ;

		if (result) // There is a result
		{
			MYSQL_ROW row ;
			row = mysql_fetch_row(result) ;

			if (row != NULL)  // Check there are actually rows
			{
				theResultsAvailable = true ;
				setupResultGrid(result) ;
				char **thisRow ;

				while (row != NULL) // Retrieve rows
				{
					thisRow = new char*[theCols] ;

					for(int i = 0; i < theCols; i++)
					{
						thisRow[i] = _strdup(row[i]) ;
					}

					theResults.push_back(thisRow) ;
					theRows++ ;

					row = mysql_fetch_row(result) ;			
				}
			}

			mysql_free_result(result) ;
		}
	}
	
	return theResultsAvailable ;
}


bool OurSQL::executeResultlessQuery(char *query)
{
	if (!theConnected) return false ;
	theResultsAvailable = false ;

	if (mysql_query(theConnection,query))
	{
		return false ;	// Query failed
	}

	return true ;	// Query succeeded	
}


bool OurSQL::executeResultlessQuery(string query)
{
	if (!theConnected) return false ;
	theResultsAvailable = false ;

	if (mysql_query(theConnection,query.c_str()))
	{
		return false ;	// Query failed
	}

	return true ;	// Query succeeded
}


int OurSQL::getColType(int c) const
{
	if (theResultsAvailable) 
		return theColTypes[c] ;
	else
		return OUR_TYPE_NULL ;
}


// Get contents of Cell in Matrix: STRING
string OurSQL::cell(int row, int col) const
{	
	if (theResultsAvailable && row < theRows && col < theCols)
		return (string(theResults[row][col])) ;
	else
		return (string("")) ;
}


// Get contents of Cell in Matrix: Long return value
long OurSQL::longCell(int row, int col) const
{	
	if (theResultsAvailable && row <= theRows && col <= theCols)
	{
		int type = theColTypes[col] ;
		if ((type == OUR_TYPE_LONG) || (type == OUR_TYPE_DOUBLE))
			return (atol(theResults[row][col])) ;
		else if (type == OUR_TYPE_STRING)
			return (0) ;
	}

	return (0) ;
}

// Get contents of Cell in Matrix: Long return value
int OurSQL::intCell(int row, int col) const
{	
	if (theResultsAvailable && row <= theRows && col <= theCols)
	{
		int type = theColTypes[col] ;
		if (type == OUR_TYPE_LONG)
			return (atoi(theResults[row][col])) ;
		else if (type == OUR_TYPE_STRING)
			return (0) ;
	}

	return (0) ;
}

// Get contents of Cell in Matrix: Double return value
double OurSQL::doubleCell(int row, int col) const
{	
	if (theResultsAvailable && row <= theRows && col <= theCols)
	{
		int type = theColTypes[col] ;
		if ((type == OUR_TYPE_LONG) || (type == OUR_TYPE_DOUBLE))
			return ((long) atol(theResults[row][col])) ;
		else if (type == OUR_TYPE_STRING)
			return (0) ;
	}

	return (0) ;
}


// Clear any query results
void OurSQL::clearResults()
{
	int r,c ;

	if (theResultsAvailable)
	{
		for(r=0; r<theRows; r++)
		{
			for(c=0; c<theCols; c++)
			{
				if (theResults[r][c] != NULL)
				{
					free(theResults[r][c]) ;	// free the cell contents
				}
			}
			delete [] theResults[r] ;	// delete the row *char array
		}

		theResults.clear() ;		// Remove all the rows from the vector
		theResultsAvailable = false ;
		theRows = theCols = 0 ;

		if (theColTypes != NULL) 
		{
			delete [] theColTypes ;
			theColTypes = NULL ;
		}
	}
}

/*
// == DBCreate ==================================================================

DBCreate::DBCreate(): theDBName(""), theConnection("test")
{
	theConnection.connect() ;
}


DBCreate::DBCreate(std::string newDBName): theDBName(newDBName), theConnection("test") 
{
	theConnection.connect() ;
}


DBCreate::~DBCreate() 
{
	theConnection.disconnect() ;
}


void DBCreate::drop()
{
	string sql = "Drop Database If Exists " ;
	sql += theDBName ;

	try
	{		
		theConnection.executeResultlessQuery(sql.c_str()) ;
	}
	catch (...)
	{
		//cerr << "DBCreate::drop() - Error executing query!" << endl ;
	}
}


void DBCreate::create()
{
	string sql = "Create Database " ;
	sql += theDBName ;

	try
	{		
		theConnection.executeResultlessQuery(sql.c_str()) ;
	}
	catch (...)
	{
		//cerr << "DBCreate::create() - Error executing query!" << endl ;
	}
}


void DBCreate::disconnect() 
{
	theConnection.disconnect() ;
}

*/
