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

#ifndef METRICS_NAMEHELPER
#define METRICS_NAMEHELPER

#include <string>
#include <vector>

namespace metrics
{
	typedef std::vector<std::string> StringVect ;
	typedef std::vector<std::string>::iterator StringVectIter ;

	class NameHelper
	{

	public:

		NameHelper() { }
		virtual ~NameHelper() { }


		/*static StringVect NameHelper::explode(std::string inputText, std::string separator)
		{
			StringVect retval ;
			char *inp = strdup(inputText.c_str()) ;
			const char *sep = separator.c_str() ;
			const char *token ;

			token = strtok(inp, sep) ;
			while (token != NULL)
			{
				retval.push_back(std::string(token)) ;
				token = strtok(NULL, sep) ;
			}

			free(inp) ;
			return retval ;
		}


		static std::string NameHelper::removeTemplates(std::string inputText)
		{
			char retval[8192] ;
			const char *inp = inputText.c_str() ;
			int i, count=0, retlen=0, inplen=strlen(inp) ;

			for (i=0;i<inplen;i++)
			{
				if (inp[i]=='<') count++ ;

				if (count==0)
				{
					retval[retlen++] = inp[i] ;
				}

				if (inp[i]=='>') count-- ;
			}

			retval[retlen] = '\0' ;
			return std::string(retval) ;
		}*/


		static std::string NameHelper::findAndReplace(std::string inputText,
			std::string findText, std::string replaceText)
		{
			std::string outputText(""),
				lhs(""),
				rhs("") ;

			std::string remaining(inputText) ;

			while (remaining.length() > 0)
			{
				int pos = remaining.find(findText) ;

				if (pos != -1)
				{
					outputText += remaining.substr(0, pos) + replaceText ;
					remaining = remaining.substr(pos+findText.length(),remaining.length()) ;
				}
				else
				{
					outputText += remaining ;
					remaining = "" ;
				}
			}

			return outputText ;
		}
	} ;
} ;

#endif
