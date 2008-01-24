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

#include <iostream>
using namespace std;
#include "Buffer.h"
#include "MasterData.h"
using namespace metrics ;

Buffer::Buffer(const Buffer& rhs)
{
	for (int i=0 ; i<rhs.theBuffer.size() ; i++)
		theBuffer.push_back(rhs.theBuffer[i]) ;

	theLimit = rhs.theLimit ;
}


Buffer::~Buffer()
{
}


const Buffer& Buffer::operator=(const Buffer& rhs)
{
	for (int i=0 ; i<rhs.theBuffer.size() ; i++)
		theBuffer.push_back(rhs.theBuffer[i]) ;

	theLimit = rhs.theLimit ;

	return (*this);
}


/*void Buffer::add(Link newLink)
{
	if (theBuffer.size() >= theLimit)
		this->commit() ;

	theBuffer.push_back(newLink) ;
}*/

void Buffer::add(DataRow *newDataRow)
{
	if (theBuffer.size() >= theLimit)
		this->commit() ;

	theBuffer.push_back(newDataRow) ;
}

void Buffer::commit()
{
	vector<DataRow*>::iterator current ;

	if (theSingleCommit)
	{
		if (theBuffer.size()>0)
		{
			char sqlc[100000] ;

			theBuffer[0]->getStatement(sqlc) ;
			//string sql = theBuffer[0]->getStatement() ;

			for(int i=0 ; i<theBuffer.size()-1 ; i++)
			{
				//sql += theBuffer[i]->getValues() + "," ;
				theBuffer[i]->getValues(sqlc) ;
				strcat(sqlc, ",") ;

				//MasterData::theLog << sqlc << endl ;
				delete theBuffer[i] ;
			}

			//sql += theBuffer[theBuffer.size()-1]->getValues() ;
			theBuffer[theBuffer.size()-1]->getValues(sqlc) ;
			delete theBuffer[theBuffer.size()-1] ;
			theBuffer.clear() ;

			//MasterData::theLog << sqlc << endl ;
			theConnection->executeResultlessQuery(sqlc) ;
		}
	}
	else
	{
		for(current=theBuffer.begin();current<theBuffer.end();current++)
		{
			(*current)->write() ;
			delete (*current) ;
		}
	}
	theBuffer.clear() ;
}

