/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.IO;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class Volume
  {
    protected string _author;
    protected int _vol;
    protected string _title;
    protected DateTime _added;
    protected string _localFile;

    public string Id
    {
      get
      {
        return GetId(_author, _vol);
      }
    }
    public string Author
    {
      get
      {
        return _author;
      }
      set
      {
        _author = value; 
      }
    }
    public int Vol
    {
      get
      {
        return _vol;
      }
      set
      {
        _vol = value;
      }
    }
    public string Title
    {
      get
      {
        return _title;
      }
      set
      {
        _title = value;
      }
    }
    public DateTime Added
    {
      get
      {
        return _added;
      }
      set
      {
        _added = value;
      }
    }
    public string LocalFile
    {
      get
      {
        return _localFile;
      }
      set
      {
        _localFile = value.Replace("\\\\", "\\");
      }
    }

    public Volume(string author, int vol)
    {
      _author = author;
      _vol = vol;
    }

    public FileInfo GetFile()
    {
      if (_localFile == null) return null;

      return new FileInfo(_localFile);
    }

    public static string GetId(string author, int vol)
    {
      return String.Format("{0}-{1}", author, vol);
    }
  }

  public class VolumeCollection : KeyedCollection<string, Volume>
  {
    public VolumeCollection()
      : base()
    {
    }

    protected override string GetKeyForItem(Volume vol)
    {
      return vol.Id;
    }
  }
}
