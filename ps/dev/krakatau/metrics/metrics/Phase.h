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

#ifndef METRICS_PHASE
#define METRICS_PHASE

#include "RootNode.h"

namespace metrics
{

	class Phase
	{
	private:

	protected:

		RootNode *theRoot ;
		int theProgress ;

		void setProgress(int i) ;
		void incProgress() { theProgress++ ; }

	public:

		Phase() { theProgress = 0 ; }

		virtual int getProgress() = 0 ;
		virtual void execute(RootNode *root) = 0 ;

	} ;


} ;

#endif
