/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  11-Oct-05    152 : Added to Source Safe.
 * CAM  11-Nov-2009  10502 : Added ExtList.
 * CAM  17-Nov-2009  10502 : Enable searching of ExtList by string.
 * CAM  16-Jun-2011  10967 : Ignore case when checking for Extension match.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;

namespace SourceCodeMetrics.Krakatau.Kepm.Config
{
  /// <summary>
  /// Model of File Extensions.
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

  public class ExtList : List<Ext>
  {
    public ExtList()
      : base()
    {
    }

    public bool Contains(string ext)
    {
      if (ext.StartsWith("."))
      {
        ext = ext.Substring(1);
      }

      foreach (Ext e in this)
      {
        if (e.Extension.ToLower().Equals(ext.ToLower())) return true;
      }
      return false;
    }

    public string[] ConvertToArray()
    {
      string[] rval = new string[this.Count];
      int i = 0;
      foreach (Ext e in this)
      {
        rval[i++] = e.Extension;
      }
      return rval;
    }
  }
}
