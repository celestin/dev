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

#ifndef METRICS_DATAROW
#define METRICS_DATAROW

#include <string>

namespace metrics
{
	class DataRow
	{
	private:

	protected:

	public:
		//
		virtual ~DataRow() { } ;

		//DataRow(const DataRow& rhs) = 0 ;

		virtual void write() =0 ;//{
		virtual void read() = 0 ; //{} ;

		virtual void getStatement(char*) = 0 ; //{} ;
		virtual void getValues(char*) = 0 ; //{} ;

	} ;
} ;

#endif
