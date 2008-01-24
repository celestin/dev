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

#include "Link.h"
#include "MasterData.h"
using namespace metrics ;
using namespace std ;

AutoNumber Link::theAutoNumber ;

Link::~Link()
{

}


string Link::formSqlInsert()
{
	char sql[512] ;
	char charNumber[30] ;

	strcpy(sql,"(") ;

	//itoa(theAutoNumber.newID(), charNumber, 10) ;
	//strcat(charNumber,",") ;
	//strcat(sql, charNumber) ;

	if (theID == AUTONUMBER) theID = theAutoNumber.newID() ;

	strcat(sql, ltostr(theAutoNumber.newID(), charNumber, 30)) ;
	strcat(sql,",") ;

	//itoa(theSourceID, charNumber, 10) ;
	//strcat(charNumber,",") ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(theSourceID, charNumber, 30)) ;
	strcat(sql,",") ;

	//itoa(theDestID, charNumber, 10) ;
	//strcat(charNumber,",") ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(theDestID, charNumber, 30)) ;
	strcat(sql,",") ;

	//itoa(theTypeID, charNumber, 10) ;
	//strcat(charNumber,")") ;
	//strcat(sql, charNumber) ;
	strcat(sql, ltostr(theTypeID, charNumber, 30)) ;
	strcat(sql,",'") ;

	strcat(sql, theRef.c_str()) ;
	strcat(sql,"')") ;

	return string(sql) ;
}


void Link::updateLink(OurSQL &connection)
{
	char sql[512], charNumber[30] ;

	strcpy(sql,"update link set sym2ID=") ;
	strcat(sql, ltostr(theDestID, charNumber, 30)) ;
	strcat(sql," where lnkID=") ;
	strcat(sql, ltostr(theID, charNumber, 30)) ;

	connection.executeResultlessQuery(sql) ;
}


void Link::write()
{
	/*ostringstream sql ;

	if (!theWritten)
	{
		sql << "Insert Into link Values ( "
			<< theAutoNumber.newID() << " , "
			<< theSourceID << " , "
			<< theDestID << " , "
			<< theTypeID << " ) " << flush ;

		try
		{
			md->theDBConnection.executeResultlessQuery(sql.str()) ;
		}
		catch (...)
		{
			MasterData::theLog << "Link::write() - Error executing query!" << endl ;
		}

		theWritten = true ;
	}*/
}


void Link::read()
{
	//TODO: Fill this in

}


Links::~Links()
{
	int i;
	for( i=0; i<NLINKTYPES; i++)
	{
		if (theLinks[i] != NULL)
		{
			theLinks[i]->clear() ;
			delete theLinks[i] ;
			theLinks[i] = NULL ;
		}
	}
}


void Links::initLinks()
{
	int i;
	for( i=0; i<NLINKTYPES; i++)
		theLinks[i] = NULL ;

	theInsertSql = "" ;
	theNumInserts = 0 ;
}


// Clear all vectors pointed at by theLinks
void Links::deleteLinks()
{
	for(int c=0; c<NLINKTYPES; c++)
	{
		if (theLinks[c] != NULL)
		{
			theLinks[c]->clear() ;
			delete theLinks[c] ;
			theLinks[c] = NULL ;
		}
	}

	theInsertSql = "" ;
	theNumInserts = 0 ;
}


// Clear all vectors pointed at by theLinks
void Links::clearLinks()
{
	for(int c=0; c<NLINKTYPES; c++)
	{
		if (theLinks[c] != NULL)
		{
			theLinks[c]->clear() ;
		}
	}

	theInsertSql = "" ;
	theNumInserts = 0 ;
}


// Add Link to correct vector
void Links::addLink(long toID, long lktID)
{
	if (lktID>NLINKTYPES)
		return ;
	else
	{
		if (!theLinks[lktID])
		{
			theLinks[lktID] = new vector<Link> ;
		}

		theLinks[lktID]->push_back(Link(theID, toID, lktID)) ;
	}
}


void Links::addLink(long lnkID, long toID, long lktID)
{
	if (lktID>NLINKTYPES)
		return ;
	else
	{
		if (!theLinks[lktID])
		{
			theLinks[lktID] = new vector<Link> ;
		}

		theLinks[lktID]->push_back(Link(lnkID, theID, toID, lktID)) ;
	}
}


vector<Link> Links::getLinks(long lktID)
{
	vector<Link> retval ;

	if (lktID>NLINKTYPES) return retval ;

	if (theLinks[lktID] != NULL)
	{
		return (*theLinks[lktID]) ;
	}

	return retval ;
}


vector<Link> Links::getLinks()
{
	vector<Link> retval ;

	int i,j ;
	for (i=0 ; i<NLINKTYPES ; i++)
	{
		if (theLinks[i] != NULL)
		{
			for (j=0 ; j<theLinks[i]->size() ; j++)
			{
				retval.push_back((*theLinks[i])[j]) ;
			}
		}
	}
	return retval ;
}


void Links::readLinks(OurSQL& connection)
{
	//ostringstream linkSql ;
	char sql[100] ;
	char charNumber[30] ;
	vector<long> linkTypes ;
	int current,i,j ;

	deleteLinks() ;


	try
	{
		// First determine get an overview of the number of
		// types of Link for this Symbol

		//linkSql << "Select lktID From link Where SymID = "
		//		<< theID << " Group By lktID" << flush ;

		strcpy(sql,"Select lktID From link Where SymID = ") ;
		strcat(sql, ltostr(theID, charNumber, 30)) ;
		strcat(sql, " Group By lktID") ;

		if (connection.executeQuery(sql))
		{
			for(j=0; j<connection.rows(); j++ )
				linkTypes.push_back(atol(connection.cell(j,0).c_str())) ;
		}


		// Process each type of link, retreiving the detail rows
		// and adding them to the vectors of Links within *this
		for(i=0; i<linkTypes.size(); i++)
		{
			current = linkTypes[i] ;
			//ostringstream currentSql ;
			char sql[512], charNumber[30] ;

			// Create a new vector for this type
			theLinks[current] = new vector<Link> ;

			strcpy(sql,"Select sym2ID From link Where SymID=") ;
			strcat(sql, ltostr(theID, charNumber, 30)) ;
			strcat(sql, " And lktID=") ;
			strcat(sql, ltostr(current, charNumber, 30)) ;

			//currentSql << "Select sym2ID From link Where SymID = "
			//	<< theID << " And lktID = " << current << flush ;

			if (connection.executeQuery(sql))
			{
				for( j=0; j<connection.rows(); j++)
				{
					theLinks[current]->push_back(Link(theID, atol(connection.cell(j,0).c_str()), current,true)) ;
				}
			}
		}
	}
	catch (...)
	{
		MasterData::theLog << "Error in SymbolNode::readLinks()" << endl ;
	}
}


void Links::write(OurSQL &connection)
{
	int i,j ;

	for (i=0 ; i<NLINKTYPES ; i++)
	{
		if (theLinks[i] != NULL)
		{
			for (j=0 ; j<theLinks[i]->size() ; j++)
			{
				if (!(*theLinks[i])[j].theWritten)
				{
					if ((*theLinks[i])[j].getID() == AUTONUMBER)
					{
						addInsert(connection, (*theLinks[i])[j].formSqlInsert()) ;
						(*theLinks[i])[j].theWritten = true ;
					}
					else
					{
						(*theLinks[i])[j].updateLink(connection) ;
						(*theLinks[i])[j].theWritten = true ;
					}
				}
			}
		}
	}

	flushInsert(connection) ;
}


void Links::flushInsert(OurSQL &connection)
{
	if (theNumInserts > 0)
	{
		try
		{
			connection.executeResultlessQuery(theInsertSql) ;
		}
		catch (...)
		{
			MasterData::theLog << "Links::flushInsert() - Error executing query!" << endl ;
		}

		theInsertSql = "" ;
		theNumInserts = 0 ;
	}
}


void Links::addInsert(OurSQL &connection, string insertSql)
{
	if (theNumInserts == 0)
	{
		theInsertSql = "Insert Into link Values " + insertSql ;
	}
	else if (theNumInserts >= MAX_LINK_INSERTS)
	{
		flushInsert(connection) ;
		theInsertSql = "Insert Into link Values " + insertSql ;
	}
	else
	{
		theInsertSql += "," + insertSql ;
	}

	theNumInserts++ ;
}


Killer::Killer()
{
	theConnection = NULL ;
	clear() ;
}


Killer::~Killer()
{
	flush() ;
}


void Killer::setConnection(OurSQL *newConnection)
{
	theConnection = newConnection ;
}


void Killer::clear()
{
	strcpy(theLinkFromSql,	"delete from link where symID in (") ;
	strcpy(theLinkToSql,	"update link set sym2ID=-1 where sym2ID in (") ;
	strcpy(theTypeSql,		"delete from symboltype where symID in (") ;
	strcpy(theSymbolSql,	"delete from symbol where symID in (") ;

	anyData = false ;
}


void Killer::flush()
{
	if (!anyData) return ;

	theLinkFromSql[strlen(theLinkFromSql)-1] = ')' ;
	theLinkToSql[strlen(theLinkToSql)-1] = ')' ;
	theTypeSql[strlen(theTypeSql)-1] = ')' ;
	theSymbolSql[strlen(theSymbolSql)-1] = ')' ;

	if (theConnection)
	{
		MasterData::theLog << theLinkFromSql << endl ;

		theConnection->executeResultlessQuery(theLinkFromSql) ;
		theConnection->executeResultlessQuery(theLinkToSql) ;
		theConnection->executeResultlessQuery(theTypeSql) ;
		theConnection->executeResultlessQuery(theSymbolSql) ;
	}

	clear() ;
}


void Killer::add(long lnkID)
{
	char charNumber[30] ;
	ltostr(lnkID, charNumber, 30) ;

	if ((strlen(theLinkToSql)+20) > KILLER_BUFFER_SIZE)
	{
		flush() ;
	}

	strcat(theLinkFromSql, charNumber) ;
	strcat(theLinkFromSql, ",") ;

	strcat(theLinkToSql, charNumber) ;
	strcat(theLinkToSql, ",") ;

	strcat(theTypeSql, charNumber) ;
	strcat(theTypeSql, ",") ;

	strcat(theSymbolSql, charNumber) ;
	strcat(theSymbolSql, ",") ;

	anyData = true ;
}


