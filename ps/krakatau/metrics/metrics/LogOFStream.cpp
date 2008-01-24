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

#include "LogOFStream.h"
using namespace std ;
using namespace metrics ;

const int LogOFStream::XOR_VALUE = 52 ;

ofstream& LogOFStream::operator<<(std::ostream& (*pf)(std::ostream&))
{
	ofstream::operator<< (*pf) ;
	return (*this) ;
}

ofstream& LogOFStream::operator<<(std::ios& (*pf)(std::ios&))
{
	ofstream::operator<< (*pf) ;
	return (*this) ;
}

ofstream& LogOFStream::operator<<(std::ios_base& (*pf)(std::ios_base&))
{
	ofstream::operator<< (*pf) ;
	return (*this) ;
}

ofstream& LogOFStream::operator<<(std::streambuf *sb)
{
	ofstream::operator<< (sb) ;
	return (*this) ;
}

ofstream& LogOFStream::operator<<(const char *s)
{
	const char*c ;

	for (c=s ; (*c)!='\0' ; c++)
	{
		switch (*c)
		{
		case '\n':
			{
				ofstream::put('\n') ;
			}
		default:
			{
				ofstream::put((char) ((*c) ^ XOR_VALUE)) ;
			}
		}
	}
	return (*this) ;
}

ofstream& LogOFStream::operator<<(char c)
{
	switch (c)
	{
	case '\n':
		{
			ofstream::put('\n') ;
		}
	default:
		{
			ofstream::put((char) (c ^ XOR_VALUE)) ;
		}
	}
	return (*this) ;
}

ofstream& LogOFStream::operator<<(bool n)
{
	return (*this) ;
}

ofstream& LogOFStream::operator<<(short n)
{
	char s[100] ;
	itoa(n, s, 10) ;

	const char*c ;

	for (c=s ; (*c)!='\0' ; c++)
	{
		ofstream::put((char) ((*c) ^ XOR_VALUE)) ;
	}
	return (*this) ;
}

ofstream& LogOFStream::operator<<(unsigned short n)
{
	char s[100] ;
	itoa(n, s, 10) ;

	const char*c ;

	for (c=s ; (*c)!='\0' ; c++)
	{
		ofstream::put((char) ((*c) ^ XOR_VALUE)) ;
	}
	return (*this) ;
}

ofstream& LogOFStream::operator<<(int n)
{
	char s[100] ;
	itoa(n, s, 10) ;

	const char*c ;

	for (c=s ; (*c)!='\0' ; c++)
	{
		ofstream::put((char) ((*c) ^ XOR_VALUE)) ;
	}
	return (*this) ;
}

ofstream& LogOFStream::operator<<(unsigned int n)
{
	char s[100] ;
	itoa(n, s, 10) ;

	const char*c ;

	for (c=s ; (*c)!='\0' ; c++)
	{
		ofstream::put((char) ((*c) ^ XOR_VALUE)) ;
	}
	return (*this) ;
}

ofstream& LogOFStream::operator<<(long n)
{
	char s[100] ;
	ltoa(n, s, 10) ;

	const char*c ;

	for (c=s ; (*c)!='\0' ; c++)
	{
		ofstream::put((char) ((*c) ^ XOR_VALUE)) ;
	}
	return (*this) ;
}

ofstream& LogOFStream::operator<<(unsigned long n)
{
	char s[100] ;
	ultoa(n, s, 10) ;

	const char*c ;

	for (c=s ; (*c)!='\0' ; c++)
	{
		ofstream::put((char) ((*c) ^ XOR_VALUE)) ;
	}
	return (*this) ;
}

ofstream& LogOFStream::operator<<(float n)
{
	char s[100] ;
	_gcvt(n, 2, s) ;

	const char*c ;

	for (c=s ; (*c)!='\0' ; c++)
	{
		ofstream::put((char) ((*c) ^ XOR_VALUE)) ;
	}
	return (*this) ;
}

ofstream& LogOFStream::operator<<(double n)
{
	char s[100] ;
	_gcvt(n, 2, s) ;

	const char*c ;

	for (c=s ; (*c)!='\0' ; c++)
	{
		ofstream::put((char) ((*c) ^ XOR_VALUE)) ;
	}
	return (*this) ;
}

ofstream& LogOFStream::operator<<(long double n)
{
	char s[100] ;
	_gcvt(n, 2, s) ;

	const char*c ;

	for (c=s ; (*c)!='\0' ; c++)
	{
		switch (*c)
		{
		case '\n':
			{
				ofstream::put('\n') ;
			}
		default:
			{
				ofstream::put((char) ((*c) ^ XOR_VALUE)) ;
			}
		}
	}
	return (*this) ;
}

ofstream& LogOFStream::operator<<(void * n)
{
	return (*this) ;
}

ofstream& LogOFStream::put(char c)
{
	switch (c)
	{
	case '\n':
		{
			ofstream::put('\n') ;
		}
	default:
		{
			ofstream::put((char) (c ^ XOR_VALUE)) ;
		}
	}
	return (*this) ;
}

ofstream& LogOFStream::write(char *s, streamsize n)
{
	int i;
	for (i=0 ; i<n ; i++)
	{
		switch (s[i])
		{
		case '\n':
			{
				ofstream::put('\n') ;
			}
		default:
			{
				ofstream::put((char) ((s[i]) ^ XOR_VALUE)) ;
			}
		}
	}

	return (*this) ;
}

