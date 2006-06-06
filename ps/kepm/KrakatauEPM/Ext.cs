/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2006 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Model of File Extensions
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  11-Oct-05   152 : Added to Source Safe.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;

namespace KrakatauEPM
{
	/// <summary>
	/// Summary description for Ext.
	/// </summary>
	public class Ext
	{
    private string _name;
    private string _ext;
    private string _ftype;
    private string _lang;

		public Ext()
		{
		}

    public Ext(string name, string ext, string ftype, string lang) 
    {
      _name = name;
      _ext = ext;
      _ftype = ftype;
      _lang = lang;
    }

    public string Name
    {
      get
      {
        return _name;
      }
      set
      {
        _name = value;
      }
    }
    public string Extension
    {
      get
      {
        return _ext;
      }
      set
      {
        _ext = value;
      }
    }
    public string Filetype
    {
      get
      {
        return _ftype;
      }
      set
      {
        _ftype = value;
      }
    }
    public string Language
    {
      get
      {
        return _lang;
      }
      set
      {
        _lang = value;
      }
    }


    public override string ToString()
    {
      return _lang + " " + _ftype + " - " + _name + " (*." + _ext + ")";
    }
	}
}
