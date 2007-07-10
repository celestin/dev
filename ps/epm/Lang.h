/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2007 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Language Utility Class
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  03-May-05    50 : File created.
 * CAM  09-May-05    49 : Added more languages.
 * CAM  02-Aug-05    76 : Added ADA.
 * CAM  13-Aug-05   114 : Added Perl.
 * CAM  18-Jul-06   272 : Added hasLogicalLines.
 * CAM  19-Sep-06   117 : Added ASP.
 * CAM  04-Nov-06   301 : Added PHP.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_LANG
#define CLASS_LANG

using namespace std;

enum Langs {
  LANG_OTHER, LANG_CPP, LANG_CS, LANG_JAVA, LANG_VB,
  LANG_S1, LANG_ADA, LANG_PERL, LANG_ASP, LANG_PHP,
  LANG_IDL
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

      if (!stricmp(lang.c_str(), "CP")) {
        theLang = LANG_CPP;
      } else if (!stricmp(lang.c_str(), "CS")) {
        theLang = LANG_CS;
      } else if (!stricmp(lang.c_str(), "JV")) {
        theLang = LANG_JAVA;
      } else if (!stricmp(lang.c_str(), "VB")) {
        theLang = LANG_VB;
      } else if (!stricmp(lang.c_str(), "S1")) {
        theLang = LANG_S1;
      } else if (!stricmp(lang.c_str(), "AD")) {
        theLang = LANG_ADA;
      } else if (!stricmp(lang.c_str(), "PL")) {
        theLang = LANG_PERL;
      } else if (!stricmp(lang.c_str(), "AS")) {
        theLang = LANG_ASP;
      } else if (!stricmp(lang.c_str(), "PH")) {
        theLang = LANG_PHP;
      } else if (!stricmp(lang.c_str(), "ID")) {
        theLang = LANG_IDL;
      }

      return theLang;
    }

    Langs getLanguage() {
      return theLang;
    }

    string getDescription() {
      switch (theLang) {
        case LANG_CPP:
        return "C++";
        case LANG_CS:
        return "C#";
        case LANG_JAVA:
        return "Java";
        case LANG_VB:
        return "Visual Basic";
        case LANG_S1:
        return "PL/SQL";
        case LANG_ADA:
        return "ADA";
        case LANG_PERL:
        return "Perl";
        case LANG_ASP:
        return "ASP";
        case LANG_PHP:
        return "PHP";
        case LANG_IDL:
        return "IDL";
      }

      return "Other";
    }

    bool hasLogicalLines() {
      switch (theLang) {
        case LANG_ADA:
        case LANG_CPP:
        case LANG_CS:
        case LANG_JAVA:
        case LANG_ASP:
        case LANG_PHP:
        case LANG_IDL:
          return true;
          break;

        case LANG_VB:
        case LANG_S1:
        case LANG_PERL:
          return false;
          break;
      }

      return false;
    }
  };
};

#endif

