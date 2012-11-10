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

#ifndef REPORT_HEADER
#define REPORT_HEADER

#include "OurSQL.h"
#include <string>
#include <fstream>
#include <iostream>
#include <stdio.h>

#include "lmpolicy.h" 

#ifdef WIN32
	#define itoa(X,Y) _itoa_s(X,Y,10,10)
#else
	char *itoa(int i, char *buff)
	{
		sprintf(buff, "%d", i) ;
		return buff ;
	}
#endif

class Chosen 
{
	int metid ;
	int upper ;
	int lower ;
} ;

#define MAX_NO_OF_ROWS = 25 ;


class HTMLWriter {
	
protected:	

	static std::string colorMap[] ; //= {"ffdddd","ccddff","bbbbff","ffeedd","eeeedd","ccaaee"} ;
	
	static std::string COL_TABLE_HEADER ;
	static std::string COL_TABLE_FOOTER ;
	static std::string COL_CELL_NAME ;
	static std::string COL_CELL_OK ;
	static std::string COL_CELL_VIOL_UPPER ;
	static std::string COL_CELL_VIOL_LOWER ;
	static std::string COL_MSG_NODATA ;
	static int CELL_WIDTH_METRIC ;
	static int CELL_WIDTH_NAME ;
	static int CELL_WIDTH_FILENAME ;
		
	static std::string JUSTIFICATION_RIGHT ;
	
	//private BufferedWriter output;
//	MetricReportModel theReportModel ;
//	RandomAccessFile output ;
	std::ofstream output ;
	std::string theDir ;
	std::string theTitle ;
	int theType ;
	int theIndexType ;
	int rows ;
	bool creatingMetricTable ;
//	State[] theStates ;
//	NumberFormat theFormat ;
	bool theViolationsOnly ;
	bool theQualifyingNames ;

	int theNoPages ;

	std::string theCatName ;
	std::string theFile ;
	bool theSingleFile ;
	
	void start() ;
	void end() ;
	void startTable() ;
	void startTable(std::string width) ;
	void endTable() ;
	void startCentredTable(std::string width) ;
	void endCentredTable() ;
	void startTableCell() ;
	void startTableCell(std::string colour) ;
	void startTableCell(std::string colour, std::string colwidth) ;
	void startTableCell(std::string colour, std::string colwidth, std::string justification) ;
	void startTableCell(std::string colour, std::string colwidth, int rows) ;
	void emptyTableCell(std::string colour) ;
//	void printNavBar(bool last) ;
	void printImage(std::string imageName, int width, int height, std::string othertags) ;
	void startLink(std::string destPage) ;
	void endLink() ;
	void noViolationsBody() ;

public:

	HTMLWriter() {}
	HTMLWriter(std::string directory, std::string catname,
		bool newViolationsOnly, bool qualifyingNames) ;
	HTMLWriter(std::string filename,
		bool newViolationsOnly, bool qualifyingNames) ;
	//void writeMetrics() ;
	//void writeMetrics(Symbol s) ;
	void writeProjectMetrics() ;
	void createNewFile() ;
	void closeFile() ;
//	void startMetricTable(const std::string &,const std::string &,
//		const std::string &,const std::string &,const std::string &) ;
	void symbolMetricTable(int, const std::string*,const std::string*) ;

	void metricTableHeader(int, const std::string*) ;
	void metricTableRow(const std::string&, int, const std::string*) ;
	void metricTableFooter() ;
	
	void symbolHeader(const std::string &,const std::string &,
		const std::string &,const std::string &) ;
	void endMetricTable() ;
	void writeMetrics(char *metrics[]) ;

	void startMetricCell(std::string colour) ;
	void endTableCell() ;
	void print(std::string outstring) ;
	void println(std::string outstring) ;
	void startTableRow() ;
	void endTableRow() ;

	void singleHeader(const std::string&, int, const std::string*) ;
	void multipleHeader() ;
	void printFooter() ;
} ;


extern void createCDFReport(metrics::OurSQL&, const char *filename, Chosen[]=NULL) ;


#endif
