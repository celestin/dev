/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004-2006 Power Software
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
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef CLASS_LANG
#define CLASS_LANG

using namespace std;

enum Langs { LANG_OTHER, LANG_CPP, LANG_CS, LANG_JAVA, LANG_VB, LANG_S1, LANG_ADA, LANG_PERL };

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
      }

      return "Other";
    }
  };
};

#endif

