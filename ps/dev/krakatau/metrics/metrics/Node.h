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

#ifndef METRICS_NODE
#define METRICS_NODE

namespace metrics
{

	class Node
	{
	private:

	protected:

		friend class Cache ;

		long theID ;
		long theCatID ;
		int theNReferences ;

		Node() { ; }

	public:

		virtual void write() = 0 ;
		virtual bool isRoot() = 0 ;

		virtual ~Node() { ; }

	} ;


} ;

#endif
