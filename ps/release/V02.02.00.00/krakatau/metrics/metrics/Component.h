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

#ifndef METRICS_COMPONENT
#define METRICS_COMPONENT

#include <string>

namespace metrics
{
	class Component
	{
	private:

	protected:
		char *theComponents[50] ;
		int theComponentsCount ;

		void clearComponents() ;

	public:
		static const int OPERATION_TYPE ;
		static const int OPERATION_CALL ;

		Component() ;
		void componentise(std::string newName, int operation) ;
	} ;
} ;

#endif