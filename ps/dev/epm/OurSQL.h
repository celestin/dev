/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2008 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * OurSQL - MySQL C API Wrapper Class
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  20-Dec-04  File added.
 * CAM  13-Jan-05  Added theUser and thePass.
 * CAM  23-Aug-05   115 : Altered includes for compilation.
 * CAM  24-Apr-08   358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_OURSQL
#define CLASS_OURSQL

#include <string.h>
#include <string>
#include <vector>
#include <iostream>
#include <windows.h>
#include <mysql.h>

#define OUR_TYPE_NULL 0
#define OUR_TYPE_LONG 1
#define OUR_TYPE_DOUBLE 2
#define OUR_TYPE_STRING 3

#define QUERY_MAX 4096

namespace metrics
{
  class OurSQL
  {
  private:
    MYSQL *theConnection;         // MySQL Connection data
    bool  theConnected;           // Has a connection been established?
    std::string theHost;          // Hostname (def. "localhost")
    std::string theUser;          // Username (def. "root")
    std::string thePass;          // Password (def. "")
    std::string theDB;            // Database

    bool  theResultsAvailable;    // Result set is available?
    int   *theColTypes;           // Column Types array
    std::vector<char**> theResults;   // Results matrix
    int   theRows;                // Number of Rows in Result set
    int   theCols;                // Number of Cols in Result set

  protected:
    void initResults() ;

  public:
    OurSQL() ;
    OurSQL(std::string host, std::string dbName) ;
    OurSQL(std::string dbName) ;
    OurSQL(const OurSQL &rhs) ;

    const OurSQL& operator=(const OurSQL&) ;

    virtual ~OurSQL() ;

    int no_of_queries ;

    // Connecting
    void connect(std::string&, std::string&, std::string&);
    void connect(std::string&, std::string&, std::string&, std::string&);
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
    std::string cell(int row, int col) const ;  // String return type
    long longCell(int row, int col) const ;   // Long value (0 if no conversion)
    double doubleCell(int row, int col) const ; // Double value (0 if no conversion)
    void clearResults() ;

    std::string getHost() { return theHost ; }
    std::string getDB()   { return theDB ; }

  };

};

#endif

