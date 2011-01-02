/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2011 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id: IEpubGenerator.cs 1128 2010-01-19 21:51:08Z craig $
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public enum Language
  {
    English,
    Dutch,
    German
  }

  public static class Languages
  {
    public static string LanguageCode(Language language)
    {
      switch (language)
      {
        case Language.Dutch:
          return "nl";
        case Language.German:
          return "de";
        default:
          break;
      }

      return "en-gb";
    }

    /// <summary>
    /// Language Suffix is used on table names to indicate the language of the contents.
    /// (Terrible design... shoot me!)
    /// </summary>
    /// <param name="language"></param>
    /// <returns></returns>
    public static string LanguageSuffix(Language language)
    {
      switch (language)
      {
        case Language.Dutch:
          return "_nl";
        case Language.German:
          return "_de";
        default:
          break;
      }

      return String.Empty;
    }
  }
}
