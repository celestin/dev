/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Language Utility Class
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  03-May-05    50 : File created.
 * CAM  09-May-05    49 : Added more languages.
 * CAM  02-Aug-05    76 : Added ADA.
 * CAM  13-Aug-05    114 : Added Perl.
 * CAM  18-Jul-06    272 : Added hasLogicalLines.
 * CAM  19-Sep-06    117 : Added ASP.
 * CAM  04-Nov-06    301 : Added PHP.
 * CAM  28-Jun-07    314 : Added Ericsson IDL.
 * CAM  26-Jul-07    316 : Added VHDL.
 * CAM  04-Dec-07    324 : Added JSP/XML (#325).
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  14-Apr-2009  10400 : Added Assembler (AY), Python (PY), JavaScript (JT) and HTML (HT).
 * CAM  14-Apr-2009  10403 : Python and XML do not have logical lines.
 * CAM  18-Apr-2009  10421 : State ASP does not have logical lines.  C# script within does, but not enough to warrant.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_LANG
#define CLASS_LANG

using namespace std;

enum Langs {
  LANG_OTHER, LANG_ADA, LANG_ASP, LANG_CPP, LANG_CS, LANG_IDL,
  LANG_JAVA, LANG_JSP,
  LANG_S1, LANG_PERL, LANG_PHP,
  LANG_VB, LANG_VHDL, LANG_XML,
  LANG_ASM, LANG_HTML, LANG_JT, LANG_PYTHON
};

namespace metrics
{
  class Lang
  {
  protected:
    Langs theLang;

  public:
    Lang() { theLang = LANG_OTHER; }
    Lang(string lang) { setLanguage(lang); }

    Langs setLanguage(string lang) {
      theLang = LANG_OTHER;

      if (!_stricmp(lang.c_str(), "CP")) {
        theLang = LANG_CPP;
      } else if (!_stricmp(lang.c_str(), "CS")) {
        theLang = LANG_CS;
      } else if (!_stricmp(lang.c_str(), "JV")) {
        theLang = LANG_JAVA;
      } else if (!_stricmp(lang.c_str(), "JS")) {
        theLang = LANG_JSP;
      } else if (!_stricmp(lang.c_str(), "S1")) {
        theLang = LANG_S1;
      } else if (!_stricmp(lang.c_str(), "AD")) {
        theLang = LANG_ADA;
      } else if (!_stricmp(lang.c_str(), "PL")) {
        theLang = LANG_PERL;
      } else if (!_stricmp(lang.c_str(), "AS")) {
        theLang = LANG_ASP;
      } else if (!_stricmp(lang.c_str(), "PH")) {
        theLang = LANG_PHP;
      } else if (!_stricmp(lang.c_str(), "ID")) {
        theLang = LANG_IDL;
      } else if (!_stricmp(lang.c_str(), "VB")) {
        theLang = LANG_VB;
      } else if (!_stricmp(lang.c_str(), "VH")) {
        theLang = LANG_VHDL;
      } else if (!_stricmp(lang.c_str(), "XM")) {
        theLang = LANG_XML;
      } else if (!_stricmp(lang.c_str(), "AY")) {
        theLang = LANG_ASM;
      } else if (!_stricmp(lang.c_str(), "HT")) {
        theLang = LANG_HTML;
      } else if (!_stricmp(lang.c_str(), "JT")) {
        theLang = LANG_JT;
      } else if (!_stricmp(lang.c_str(), "PY")) {
        theLang = LANG_PYTHON;
      }

      return theLang;
    }

    Langs getLanguage() {
      return theLang;
    }

    string getDescription() {
      switch (theLang) {
        case LANG_ADA:
        return "ADA";
        case LANG_ASP:
        return "ASP";
        case LANG_CPP:
        return "C++";
        case LANG_CS:
        return "C#";
        case LANG_IDL:
        return "IDL";
        case LANG_JAVA:
        return "Java";
        case LANG_JSP:
        return "JSP";
        case LANG_PERL:
        return "Perl";
        case LANG_PHP:
        return "PHP";
        case LANG_S1:
        return "PL/SQL";
        case LANG_VB:
        return "Visual Basic";
        case LANG_VHDL:
        return "VHDL";
        case LANG_XML:
        return "XML";
        case LANG_ASM:
        return "TI Assembly";
        case LANG_HTML:
        return "HTML";
        case LANG_JT:
        return "JavaScript";
        case LANG_PYTHON:
        return "Python";
      }

      return "Other";
    }

    bool hasLogicalLines() {
      switch (theLang) {
        case LANG_ADA:
        case LANG_CPP:
        case LANG_CS:
        case LANG_IDL:
        case LANG_JAVA:
        case LANG_JSP:
        case LANG_PHP:
        case LANG_VHDL:
        case LANG_JT:
          return true;
          break;

        case LANG_ASP:    // C# within ASP does, but safer to exclude
        case LANG_PERL:
        case LANG_PYTHON:
        case LANG_S1:
        case LANG_VB:
        case LANG_ASM:
        case LANG_HTML:
        case LANG_XML:
          return false;
          break;
      }

      return false;
    }
  };
};

#endif

