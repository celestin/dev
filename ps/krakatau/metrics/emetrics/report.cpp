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

#include "report.h"

#include <string>

using namespace std ;
using namespace metrics ;

string HTMLWriter::COL_TABLE_HEADER 		= "eeeeff" ;
string HTMLWriter::COL_TABLE_FOOTER 		= "eeeeff" ;
string HTMLWriter::COL_CELL_NAME 			= "ddffdd" ;
string HTMLWriter::COL_CELL_OK 				= "99FFAA" ;
string HTMLWriter::COL_CELL_VIOL_UPPER		= "FF99AA" ;
string HTMLWriter::COL_CELL_VIOL_LOWER		= "99AAFF" ;
string HTMLWriter::COL_MSG_NODATA			= "5555EE" ;
int HTMLWriter::CELL_WIDTH_METRIC			= 75 ;
int HTMLWriter::CELL_WIDTH_NAME				= 140 ;
int HTMLWriter::CELL_WIDTH_FILENAME			= 200 ;
		
string HTMLWriter::JUSTIFICATION_RIGHT		= "RIGHT" ;
string HTMLWriter::colorMap[] = {"ffdddd","ccddff","bbbbff","ffeedd","eeeedd","ccaaee"} ;


HTMLWriter::HTMLWriter(string newDir, string catname,
					   bool newViolationsOnly, bool qualifyingNames) : output()
{
		theSingleFile = false ;
		theDir = newDir + "/" + catname + "/" ;
		theCatName = catname ;

//		theReportModel = mrm ;
//		theType = type ;
		theViolationsOnly = newViolationsOnly ;
		theQualifyingNames = qualifyingNames ;

//		theIndexType = MetricInformation.getMappedIndex(theType) ;		
//		theStates = MetricInformation.getStates(theType, 
//		MetricInformation.CHOSEN_METRICS, MetricInformation.ABSOL_METCAT) ;
		
//		theFormat = NumberFormat.getInstance() ;
//		theFormat.setMaximumFractionDigits(2) ;
//		theFormat.setMinimumFractionDigits(0) ;
		
//		theTitle = MetricInformation.METRIC_TYPE_NAMES[theType] ;		
		theNoPages = 0 ;
}
	
HTMLWriter::HTMLWriter(string newFile,
					   bool newViolationsOnly, bool qualifyingNames) : output()
{
	theSingleFile = true ;
	theFile = newFile ;

//		theReportModel = mrm ;
//		theType = type ;
		theViolationsOnly = newViolationsOnly ;
		theQualifyingNames = qualifyingNames ;

//		theIndexType = MetricInformation.getMappedIndex(theType) ;		
//		theStates = MetricInformation.getStates(theType, 
//		MetricInformation.CHOSEN_METRICS, MetricInformation.ABSOL_METCAT) ;
		
//		theFormat = NumberFormat.getInstance() ;
//		theFormat.setMaximumFractionDigits(2) ;
//		theFormat.setMinimumFractionDigits(0) ;
		
//		theTitle = MetricInformation.METRIC_TYPE_NAMES[theType] ;		
		theNoPages = 0 ;
}
	
void HTMLWriter::createNewFile() 
{
	//char temp[10];

	string filename;

	if (theSingleFile) {
		filename = theFile;
	} else {
    char fname[MAX_PATH];
    sprintf_s(fname, MAX_PATH, "%s%s%d.html", theDir.c_str(), theCatName.c_str(), ++theNoPages);
		filename = fname;
	}

	rows = 0;
		
	//output = new RandomAccessFile(outputFile,"rw");

	output.close() ;
	output.clear() ;
	output.open(filename.c_str()) ;

	start() ;
	//printHeader() ;
}
	
void HTMLWriter::closeFile() 
{
	if (theNoPages > 0) {

		//printNavBar(false);
		printFooter();
		end();
		output.flush() ;
		output.close();
	}
}
	
void HTMLWriter::print(string s) {
	output << s ;//<< flush ;
}
	
void HTMLWriter::println(string s) 
{
	output << s << '\n' ;//endl ;
}

void HTMLWriter::start() 
{
	println("<HTML><TITLE>"+theTitle+"</TITLE>");
	
	println("<STYLE TYPE=\"Text/css\">") ;
	println("<!--") ;
	println("body, p, table, td {") ;
	println("  FONT-FAMILY: \"Arial,Helvetica\";") ;
	println("  FONT-SIZE: 8pt;") ;
	println("  TEXT-DECORATION: none ;") ;
	println("}") ;
	println("td.title {") ;
	println("  FONT-FAMILY: \"Arial,Helvetica\";") ;
	println("  FONT-SIZE: 12pt;") ;
	println("  TEXT-DECORATION: none ;") ;
	println("}") ;
	println("td.name {") ;
	println("  FONT-FAMILY: \"Arial,Helvetica\";") ;
	println("  FONT-SIZE: 10pt;") ;
	println("  TEXT-DECORATION: none ;") ;
	println("  FONT-WEIGHT: bold ;") ;
	println("}") ;
	println("//--></STYLE>") ;
	
	println("<BODY>");
}
	
void HTMLWriter::end() {
	println("</BODY></HTML>");
}
	


void HTMLWriter::singleHeader(const string &cat, int nlinks, const string *links) {

	println("\t<BR><BR>\n") ;
	print("<A NAME=\"") ;
	print(cat) ;
	println("\"></A>") ;
	println("\t<TABLE BGCOLOR=\"#000000\" WIDTH=\"100%\" CELLSPACING=2 CELLPADDING=0>") ;
	println("\t\t<TR><TD><TABLE WIDTH=\"100%\"CELLSPACING=0 CELLPADDING=4 >") ;
	println("\t\t\t<TR VALIGN=top BGCOLOR=\"#EEEEFF\">") ;
	println("\t\t\t\t<TD CLASS=\"title\">") ;
	print(cat) ;
	println(" Metrics</TD>") ;

	for (int i=0 ; i<nlinks ; i++) {
		print("<TD WIDTH=\"50\" ALIGN=CENTER>") ;
		print(links[i]) ;
		println("</TD>") ;
	}

	println("\t\t\t</TR>") ;
	println("\t\t</TABLE></TD></TR>") ;
	println("\t</TABLE>\n") ;

}


void HTMLWriter::multipleHeader() {

	println("\t<TABLE BGCOLOR=\"#000000\" WIDTH=\"100%\" CELLSPACING=2 CELLPADDING=0>") ;
	println("\t\t<TR><TD><TABLE WIDTH=\"100%\"CELLSPACING=0 CELLPADDING=4 >") ;
	println("\t\t\t<TR VALIGN=top BGCOLOR=\"#EEEEFF\">") ;
	print("\t\t\t\t<TD CLASS=\"title\">") ;
	print(theCatName) ;
	println(" Report</TD>") ;
	println("\t\t\t</TR>") ;
	println("\t\t</TABLE></TD></TR>") ;
	println("\t</TABLE>\n") ;

}
	

void HTMLWriter::printFooter() {
	//TODO
//	string dateString = DateFormat.getDateInstance().format(Calendar.getInstance().getTime());

	println("<BR><BR>") ;
	println("\t<TABLE BGCOLOR=\"#000000\" WIDTH=\"100%\" CELLSPACING=2 CELLPADDING=0>") ;
	println("\t\t<TR><TD><TABLE WIDTH=\"100%\" CELLSPACING=0 CELLPADDING=4>") ;
	println("\t\t\t<TR BGCOLOR=\"#EEEEFF\" ALIGN=RIGHT VALIGN=CENTER>") ;
	println("\t\t\t\t<TD CLASS=\"title\" WIDTH=\"100%\">Krakatau <I>is</I> &copy; 2001 <A HREF=\"http://www.powersoftware.com/\">Power Software.</A></TD>") ;
	println("\t\t\t\t<TD><A HREF=\"http://www.powersoftware.com/\"><IMG SRC=\"../img/pslogo.gif\" width=80 height=32 align=right valign=top></A></TD>") ;
	println("\t\t\t</TR>\n\t\t</TABLE></TD></TR>\n\t</TABLE>") ;

}


void HTMLWriter::printImage(string imageName, int width, int height, string othertags) {
	//char temp[10]; 
  char buf[2048];
  
  sprintf_s(buf, 2048, "<img src=\042%s.gif\042 width=%d height=%d %s>", imageName, width, height, othertags);
/*
  string line = "<img src=\042"+imageName+".gif\042 width=" ;
  _itoa_s(width,temp,10,10);
	line += temp;
	line += " height=" ;
  _itoa_s(height,temp,10,10);
	line += temp;
	line += " "+othertags+">" ;
	println(line) ;
*/
  println(buf);
}

void HTMLWriter::startLink(string destPage) {
	print("<a href = \042"+destPage+".html\042>") ;
}

void HTMLWriter::endLink() {
	print("</a>") ;
}

#define METRIC_MAX 8	

void HTMLWriter::symbolMetricTable(int size, const string *codes,const string *values) {

	println("\t<BR><BR>\n") ;
	println("\t<TABLE BGCOLOR=\"#AAAAAA\" WIDTH=\"100%\" CELLSPACING=0 CELLPADDING=0>") ;
	println("\t\t<TR><TD><TABLE WIDTH=\"100%\" CELLSPACING=1 CELLPADDING=4>") ;
	
	for (int i=0 ; i<size ; i+=METRIC_MAX) {

		println("\t\t\t<TR valign=top ALIGN=CENTER BGCOLOR=\"#EEEEFF\">") ;
		
		int j,k ;
		for (j=0,k=i ; j<METRIC_MAX ; j++,k++) {
			if (k<size) {
				print("\t\t\t\t<TD WIDTH=\"1%\">") ;
				print(codes[k]) ;
				println("</TD>") ;
			} else {
				println("\t\t\t\t<TD WIDTH=\"1%\">&nbsp;</TD>") ;
			}
		}

		println("\t\t\t</TR>") ;
		println("\t\t\t<TR ALIGN=CENTER BGCOLOR=\"#FFFFFF\">") ;

		for (j=0,k=i ; j<METRIC_MAX ; j++,k++) {
			if (k<size) {
				print("\t\t\t\t<TD>") ;
				print(values[k]) ;
				println("</TD>") ;
			} else {
				println("\t\t\t\t<TD>&nbsp;</TD>") ;
			}
		}


		println("\t\t\t</TR>") ;
	
	}

	println("\t\t</TABLE></TD></TR>") ;
	println("\t</TABLE>") ;

}

	
void HTMLWriter::metricTableHeader(int size, const string *codes) {

	println("\t<BR><BR>\n") ;
	println("\t<TABLE BGCOLOR=\"#AAAAAA\" WIDTH=\"100%\" CELLSPACING=0 CELLPADDING=0>") ;
	println("\t\t<TR><TD><TABLE WIDTH=\"100%\" CELLSPACING=1 CELLPADDING=4>") ;
	println("\t\t\t<TR valign=top ALIGN=CENTER BGCOLOR=\"#EEEEFF\">") ;
	
	println("\t\t\t\t<TD>&nbsp;</TD>") ;
	
	for (int i=0 ; i<size ; i++) {
		print("\t\t\t\t<TD WIDTH=\"1%\" NOWRAP>") ;
		print(codes[i]) ;
		println("</TD>") ;
	}

	println("\t\t\t</TR>") ;

}

	
void HTMLWriter::metricTableRow(const string &name, int size, const string *values) {

	println("\t\t\t<TR ALIGN=CENTER BGCOLOR=\"#FFFFFF\">") ;

	print("\t\t\t\t<TD NOWRAP>") ;
	print(name) ;
	println("</TD>") ;

	for (int i=0 ; i<size ; i++) {
		print("\t\t\t\t<TD NOWRAP>") ;
		print(values[i]) ;
		println("</TD>") ;
	}
	println("\t\t\t</TR>") ;

}

	
void HTMLWriter::metricTableFooter() {

	println("\t\t</TABLE></TD></TR>") ;
	println("\t</TABLE>") ;

}

	
void HTMLWriter::symbolHeader(const string &name, const string &anchor,
							  const string &clink,const string &flink) {
	println("\t<BR><BR>") ;
	print("\t<A NAME=\"") ;
	print(anchor) ;
	println("\"></A>") ;
	println("\t<TABLE WIDTH=\"100%\" border=0 CELLSPACING=2 CELLPADDING=0>") ;
	println("\t\t<TR><TD><TABLE WIDTH=\"100%\" border=0 CELLSPACING=0 CELLPADDING=0>") ;
	println("\t\t\t<TR><TD ALIGN=left WIDTH=\"1\" CLASS=\"name\">Name:&nbsp;&nbsp;</TD>") ;
	print("\t\t\t\t<TD ALIGN=left CLASS=\"name\">") ;
	print(name) ;
	println("</TD>") ;
	println("\t\t\t\t<TD ALIGN=right><TABLE border=0 CELLSPACING=0 CELLPADDING=5><TR>") ;
	if (clink.size()>0) {
		println("\t\t\t\t\t<TD>Class:</TD>");
		print("\t\t\t\t\t<TD>") ;
		print(clink) ;
		println("</TD>") ;
	}
	if (flink.size()>0) {
		println("\t\t\t\t\t<TD>File:</TD>") ;
		print("\t\t\t\t\t<TD>") ;
		print(flink) ;
		println("</TD>") ;
	}
	println("\t\t\t\t</TR></TABLE></TD>");
	println("\t\t\t</TR></TABLE></TD>") ;
	println("\t\t</TR></TABLE>") ;

}

	
void HTMLWriter::endMetricTable() {
	
	creatingMetricTable = false;
	
	rows = 0;
	endTable();		
}

//----

void HTMLWriter::writeMetrics(char *metrics[])
{
/*	startTableRow() ;

	for (int i=0 ; i<theNMet ; i++) {
		startMetricCell("ffffff") ;
		print(metrics[i]) ;
		endTableCell() ;
	}

	endTableRow() ;
	rows++ ;*/
}


//TODO	
/*void HTMLWriter::writeMetrics() {

	if (theReportModel == null) {
	
		writeProjectMetrics() ;
		return ;
		
	} else if (theReportModel.getNoPages() == 0) {
	
		createNewFile() ;
		startCentredTable("50%") ;
		noViolationsBody() ;
		endCentredTable() ;
		printFooter() ;
		end() ;
		output.close() ;
		return ;
	}
	
	for(int p=0; p<theReportModel.getNoPages(); p++) {
	
		createNewFile() ;		
		startMetricTable() ;
		
		for(int i=0; i<theReportModel.getSize(); i++) {
		
			writeMetrics(theReportModel.getElementAt(i)) ;			
		}

		endMetricTable() ;
		closeFile() ;
		
		if (theReportModel.hasNextPage())
			theReportModel.moveNextPage() ;
	}
}

	void HTMLWriter::writeMetrics(Symbol s) {

		Symbol ancenstors[] ;
		startTableRow() ;
		
		string sName = s.getName() ;
		
		if (theQualifyingNames) {
		
			if (s.getCategory() == MetricInformation.METHOD_METRICS) {
				
				startTableCell(colorMap[theIndexType]) ;
				if (s.getFileName() != null) {
					print(s.getFileName()) ;
				} else {
					print("File not found") ;
				}
				endTableCell() ;
		
				if ((s.getParentName() != null) && 
					(s.getParentCatID() == MetricInformation.CLASS_METRICS)) {
					sName = s.getParentName() + "::<b>" + sName + "</b>" ;
				}
				
			} else if ((s.getCategory() == MetricInformation.CLASS_METRICS) ||
				(s.getCategory() == MetricInformation.INTERFACE_METRICS)) {

				startTableCell(colorMap[theIndexType]) ;
				if (s.getFileName() != null) {
					print(s.getFileName()) ;
				} else {
					print("File not found") ;
				}
				endTableCell() ;
			}
		}

		startTableCell(colorMap[theIndexType]) ;				
		print(sName) ;
		endTableCell() ;
		
		//Metrics metrics = s.getMetrics(MetricInformation.ALL_METCAT) ;
		Metrics metrics = new Metrics(s.getID(), s.getStatus(), 
			MetricInformation.ABSOL_METCAT) ;
		
		for (int i=0 ; i<theStates.length ; i++) {

			string cellColour = COL_CELL_OK ;	// Assume Ok
			MetricDetails md = metrics.getMetricDetails(theStates[i].getID()) ;
			
			if (md == null) {
				// TODO: Investigate Missing Metrics for certain Symbols
				emptyTableCell(cellColour) ;

			} else {

				int violating = theStates[i].checkBounds(md.value) ;
		
				if (violating == State.VIOL_UPPER) {
				
					cellColour = COL_CELL_VIOL_UPPER ;
					
				} else if (violating == State.VIOL_LOWER) {
				
					cellColour = COL_CELL_VIOL_LOWER ;				
				}
	
				startMetricCell(cellColour) ;
				print(theFormat.format(md.value)) ;
				endTableCell() ;
			}
		}
		
		endTableRow();
		rows++ ;
	}*/
	
void HTMLWriter::noViolationsBody() {

	startTableRow() ;
	
	// Metric Name
	startTableCell(colorMap[theIndexType], "30%") ;
	print("No Violations") ;
	endTableCell() ;
	
	endTableRow();
}

//TODO	
/*	void HTMLWriter::writeProjectMetrics() {
	
		createNewFile() ;
		startCentredTable("50%") ;
		
		int nViols = 0 ;
		
		Symbol root = new Symbol(1) ;
		//Metrics metrics = root.getMetrics() ;
		Metrics metrics = new Metrics(root.getID(), root.getStatus(), 
			MetricInformation.ABSOL_METCAT) ;
		
		if (metrics == null) System.err.println("Null root metrics") ;
		
		for (int i=0 ; i<theStates.length ; i++) {
		
			string cellColour = COL_CELL_OK ;	// Assume Ok
			MetricDetails md = metrics.getMetricDetails(theStates[i].getID()) ;
			
			if (md == null) {
				// TODO: Investigate Missing Metrics for certain Symbols
				emptyTableCell(cellColour) ;

			} else {
			
				int violating = theStates[i].checkBounds(md.value) ;
		
				if (violating == State.VIOL_UPPER) {
				
					cellColour = COL_CELL_VIOL_UPPER ;
					
				} else if (violating == State.VIOL_LOWER) {
				
					cellColour = COL_CELL_VIOL_LOWER ;
					
				} else {
				
					if (theViolationsOnly) break ;	// Do not output this row - not a violation
				}
				
				nViols++ ;
				
				startTableRow() ;
				
				// Metric Name
				startTableCell(colorMap[theIndexType], "30%") ;
				print(MetricInformation.getCodeFromID(theStates[i].getID())) ;
				endTableCell() ;
				
	
				// Metric Value
				startTableCell(cellColour, "30%", JUSTIFICATION_RIGHT) ;
				print(theFormat.format(md.value)) ;
				endTableCell() ;
			}
			
			endTableRow() ;
			rows++ ;
		}
		
		if (nViols == 0) noViolationsBody() ;
		
		endCentredTable() ;
		printFooter();
		end();
		output.close();
	}	
}*/


void HTMLWriter::startTable() {
	println("<TABLE BGCOLOR=#000000 WIDTH=\"100%\"><TR><TD><TABLE CELLSPACING=1 CELLPADDING=4 BORDER=0 WIDTH=\"100%\">");
}

void HTMLWriter::startTable(string width) {
	println("<TABLE BGCOLOR=#000000 WIDTH=\"" + width + "\"><TR><TD><TABLE CELLSPACING=1 CELLPADDING=4 BORDER=0 WIDTH=\"100%\">");
}
	
	
void HTMLWriter::endTable() {
	println("</TABLE></TD></TR></TABLE><br>"); 
}
	
void HTMLWriter::startCentredTable(string width) {
	println("<table><tr><td><center><TABLE BGCOLOR=#000000 WIDTH=\"" + width + "\"><TR><TD><TABLE CELLSPACING=1 CELLPADDING=4 BORDER=0 WIDTH=\"" + width + "\">");
}
	
void HTMLWriter::endCentredTable() {
	println("</TABLE></TD></TR></TABLE></center></td></tr></table><br>");
}
		
	
void HTMLWriter::startTableRow() {
	println("<TR valign=top>");
}
	

void HTMLWriter::endTableRow() {
	println("</TR>");
}
	
void HTMLWriter::startTableCell() {
	print("<td>");
}
	
void HTMLWriter::startTableCell(string colour) {
	print("<TD BGCOLOR=#" + colour + ">");
}

void HTMLWriter::startTableCell(string colour, string colwidth) {
	print("<TD BGCOLOR=#"+colour+" WIDTH=\""+colwidth+"\">");
}

void HTMLWriter::startTableCell(string colour, string colwidth, string justification) {
	print("<TD BGCOLOR=#"+colour+" WIDTH=\""+colwidth+"\" ALIGN=\"" + justification + "\">");
}

void HTMLWriter::startTableCell(string colour, string colwidth, int rows) {
	char temp[10];
  _itoa_s(rows,temp,10,10);
	print("<TD BGCOLOR=#"+colour+" WIDTH=\""+colwidth+"\" ROWSPAN="+string(temp)+">");
}

void HTMLWriter::emptyTableCell(string colour) {
	print("\n<td BGCOLOR=#" + colour + ">&nbsp;</td>\n") ;
}

void HTMLWriter::startMetricCell(string colour) {
	print("<TD BGCOLOR=#" + colour + " ALIGN=\"" + JUSTIFICATION_RIGHT + "\">");
}

void HTMLWriter::endTableCell() {
	println("</TD>");
}
