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

#ifndef METRICS_LEXEME
#define METRICS_LEXEME

#include <string>

namespace metrics {

	class Lexeme
	{

	public:

		int com;
		int param;
		std::string str;

#ifdef LANGUAGE_CPP			// The CPP lexeme has 6 entries
		int line;
		int startcol;
		int endcol;
#endif

		Lexeme(): str("")
		{
			com = 0 ;
			param = 0 ;

#ifdef LANGUAGE_CPP			// The CPP lexeme has 6 entries
			line = 0 ;
			startcol = 0 ;
			endcol = 0 ;
#endif
		}
	} ;
} ;

#endif
