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

#ifndef METRICS_UTILITIES
#define METRICS_UTILITIES

#include <string>
#include <sys/types.h>
#include <sys/stat.h>

#include "MasterData.h"

namespace metrics
{
	class Utilities
	{

	private:

		Utilities() { ; }
		virtual ~Utilities() { ; }

	public:

		static std::string findAndReplace(std::string inputText,
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


		static long getLastModTime(std::string filename)
		{
			struct stat buf ;
			int result ;
			long timestamp = 0 ;

			result = stat( filename.c_str(), &buf );	// Get file data

			if( result != 0 )	// Check for valid results
			{
				MasterData::theLog << "Error: Utilities::getLastModTime() [" << filename << "]" << std::endl ;
			}
			else
			{
				timestamp = (long) buf.st_mtime ;
			}

			return timestamp ;
		}


		static long getFileSize(std::string filename)
		{
			struct stat buf ;
			int result ;
			long filesize = 0 ;

			result = stat( filename.c_str(), &buf );	// Get file data

			if( result != 0 )	// Check for valid results
			{
				MasterData::theLog << "Error: Utilities::getFileSize() [" << filename << "]" << std::endl ;
			}
			else
			{
				filesize = (long) buf.st_size ;
			}

			return filesize ;
		}
	} ;
} ;

#endif
