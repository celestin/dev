/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Metrics (metrics.exe)
 * Copyright (c) 2001,2008 SourceCodeMetrics.com
 * Author Craig McKay <craig.mckay@powersoftware.com>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-Jan-08  337 : Add to source control.
 * CAM  22-Jan-08  339 : Corrected deprecation warnings.
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
