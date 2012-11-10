

#include "report.h"

#include <fstream>
#include <iostream>

using namespace std ;
using namespace metrics ;

#define PAGE_SIZE 100


void createCDFReport(OurSQL &conn, const char *filename, Chosen chosen[]) {

	ofstream output(filename) ;

	conn.executeQuery("select * from category where catid<8 order by catid") ;

	int nCats = conn.rows() ;
	int *cats = (int*) malloc(nCats*sizeof(int)) ;
	char **cat_names = (char**) malloc(nCats*sizeof(char*)) ; ;

	for (int i=0 ; i<nCats ; i++) {
		cats[i] = (int) conn.longCell(i,0) ;
		cat_names[i] = strdup(conn.cell(i,1).c_str());
	}

	char *qry ;

	long size=0 ;
	int nmet=0 ;

	for (i=0 ; i<nCats ; i++) {

		// Create the symbol table for this category
		conn.executeQuery("drop table if exists reporttmp") ;
		conn.executeQuery("create table if not exists reporttmp (symID int not null, symName varchar (128) binary not null, primary key (symID) , unique index (symID))") ;
	
		qry = strdup("insert reporttmp select symID,symname from symbol where catid=") ;
		qry = (char*) realloc (qry,(strlen(qry)+2)*sizeof(char)) ;
		sprintf(qry,"%s%d",qry,cats[i]) ;

		conn.executeQuery(qry) ;
		free(qry) ;

		// Find out the amount of symbols of this type
		qry = strdup("select count(*) from reporttmp") ;

		conn.executeQuery(qry) ;
		free(qry) ;

		size = conn.longCell(0,0) ;

		// Create the metricused temp table
		conn.executeQuery("drop table if exists metricused") ;
		conn.executeQuery("create table if not exists metricused (mttID int not null, mttCode varchar (10) BINARY not null, primary key (mttID) , unique index (mttID))") ;

		qry = strdup("insert metricused select m.mttID,t.mttCode from metric m inner join metrictype t on m.mttid=t.mttid where m.mttid like") ;
		qry = (char*) realloc (qry,(strlen(qry)+23)*sizeof(char)) ;
		sprintf(qry,"%s '%d%%' order by m.mttID",qry,cats[i]) ;

		conn.executeQuery(qry) ;
		free(qry) ;

		qry = strdup("select mttID,mttCode from metricused order by mttID") ;

		conn.executeQuery(qry) ;
		free(qry) ;

		nmet = conn.rows() ;

		// Output the header for this category to the file

		output << cat_names[i] << "," ;
		for (int j=0 ; j<nmet ; j++) {
			output << conn.cell(j,1) << "," ;
		}
		output << endl ;

		int nPages = (size%PAGE_SIZE)==0 ? (int) size/PAGE_SIZE : size/PAGE_SIZE+1 ;

		cout << "Size: " << size << ", No of pages: " << nPages << endl ;

		// Create the symbol table for this category
		conn.executeQuery("drop table if exists jointmp") ;
		conn.executeQuery("create table if not exists jointmp (symID int not null, symName varchar (128) binary not null, primary key (symID) , unique index (symID))") ;


		for (j=0 ; j<nPages ; j++) {

			qry = strdup("insert jointmp select symID,symname from reporttmp limit") ;
			qry = (char*) realloc (qry,(strlen(qry)+25)*sizeof(char)) ;
			sprintf(qry,"%s %d,%d",qry,j*PAGE_SIZE,PAGE_SIZE) ;

			conn.executeQuery(qry) ;

			qry = strdup("select s.symID,s.symname,m.metvalue from jointmp s inner join metric m on s.symid=m.symid order by s.symid") ;

			conn.executeQuery(qry) ;

			for (int k=0 ; k<conn.rows() ; k++) {
				long symid = conn.longCell(k,0) ;
				long oldid = symid ;

				output << symid << "," << conn.cell(k,1) << "," ;

				while (symid==oldid) {
					output << conn.longCell(k,2) << "," ;
					// Make sure that there are more results
					if (++k<conn.rows())
						symid = conn.longCell(k,0) ;
					else //no more results
						symid=-1 ;
				}
				k-- ;

				output << endl ;
				oldid = symid ;
			}
		}



	}

	output.close() ;
}