/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Various Utilities
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  29-Dec-04    File added.
 * CAM  13-Mar-2010  10581 : Optmised getLastModTime and getFileSize.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef METRICS_UTILITIES
#define METRICS_UTILITIES

#include <string>
#include <sys/types.h>
#include <sys/stat.h>

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
      struct stat buf;
      int result = stat(filename.c_str(), &buf);  // Get file data

      if (!result) // Check for valid results
      {
        return (long) buf.st_mtime ;
      }

      return 0;
    }


    static long getFileSize(std::string filename)
    {
      struct stat buf;
      int result = stat(filename.c_str(), &buf);  // Get file data

      if (!result) // Check for valid results
      {
        return (long) buf.st_size ;
      }

      return 0;
    }
  } ;
} ;

#endif
