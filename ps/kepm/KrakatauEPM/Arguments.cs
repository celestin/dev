/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright 2006 Craig McKay <craig@frontburner.co.uk>
 *
 * Argument Parsing
 *
 * $Log: /kepm/KrakatauEPM.root/KrakatauEPM/KrakatauEPM/Arguments.cs $
 * 
 * 1     26/03/06 19:49 Craig
 * 213
 * 
 * Who  When       Why
 * CAM  26-Mar-06   213 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Specialized;
using System.Text.RegularExpressions;

namespace KrakatauEPM
{
  /// <summary>
  /// Arguments class
  /// </summary>
  public class Arguments
  {
    // Variables
    private StringDictionary _params;

    // Constructor
    public Arguments(string Args)
    {
      _params = new StringDictionary();

      Regex re = new Regex(@"^(?:(?:""(?<token>[^""]+)""|(?<token>[^\s]+))(?:\s+|$))+");
      // note escaping of " characters as "" in this format of string literal

      Match match = re.Match(Args);
      string previous = null;
      foreach (Capture cap in match.Groups["token"].Captures)
      {
        if (previous != null && previous.Substring(0,1).Equals("-")) 
        {
          _params.Add(previous.Substring(1,previous.Length-1), cap.Value);
        }
        previous = cap.Value;
      } 
    }

    public string this [string Param]
    {
      get
      {
        return(_params[Param]);
      }
    }
  }
}

