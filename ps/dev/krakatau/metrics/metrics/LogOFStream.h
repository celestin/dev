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

#ifndef METRICS_LOGOFSTREAM
#define METRICS_LOGOFSTREAM

#include <iostream>
#include <fstream>

namespace metrics
{
	class LogOFStream : public std::basic_ofstream<char, std::char_traits<char> >  {

	protected:

		std::ofstream& put(char c) ;
		std::ofstream& write(char *s, std::streamsize n) ;


	public:

		LogOFStream() : std::basic_ofstream<char, std::char_traits<char> >() {;}
		LogOFStream(const char *filename) : std::basic_ofstream<char, std::char_traits<char> >(filename) {;}

		~LogOFStream() {;}

		// Categories
		static const int XOR_VALUE ;


		std::ofstream& operator<<(std::ostream& (*pf)(std::ostream&));
		std::ofstream& operator<<(std::ios& (*pf)(std::ios&));
		std::ofstream& operator<<(std::ios_base& (*pf)(std::ios_base&));
		std::ofstream& operator<<(std::streambuf *sb);

		std::ofstream& operator<<(const char *s) ;
		std::ofstream& operator<<(char c) ;
		std::ofstream& operator<<(bool n) ;
		std::ofstream& operator<<(short n) ;
		std::ofstream& operator<<(unsigned short n) ;
		std::ofstream& operator<<(int n) ;
		std::ofstream& operator<<(unsigned int n) ;
		std::ofstream& operator<<(long n) ;
		std::ofstream& operator<<(unsigned long n) ;
		std::ofstream& operator<<(float n) ;
		std::ofstream& operator<<(double n) ;
		std::ofstream& operator<<(long double n) ;
		std::ofstream& operator<<(void * n) ;


	} ;

} ;

#endif

