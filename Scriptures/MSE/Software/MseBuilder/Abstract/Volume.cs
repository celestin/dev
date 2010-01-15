/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  12-May-2008  10265 : Added IsFullMarkup.
 * CAM  15-Jan-2010  10528 : Added Series and Title options.
 * CAM  15-Jan-2010  10529 : Converted Volume.Author from string to Author class.
 * CAM  15-Jan-2010  10529 : Missed a reference to Author.
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
    private Author _author;
    private int _vol;
    private string _title;
    private string _series;
    private DateTime _added;
    private string _localFile;

    public string Id
    {
      get
      {
        return GetId(_author.Inits, _vol);
      }
    }
    public Author Author
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
    public string FullTitle
    {
      get
      {
        if (Title.Length > 0)
        {
          return String.Format("{0} - {1} (#{2})", Author.Inits, Title, Vol);
        }

        return String.Format("{0} Volume {1}", Author.Inits, Vol);
      }
    }
    public string VolumeTitle
    {
      get
      {
        if (Title.Length > 0)
        {
          return String.Format("{0} (#{1})", Title, Vol);
        }

        return String.Format("Volume {0}", Vol);
      }
    }
    public string Series
    {
      get { return _series; }
      set { _series = value; }
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

    public bool IsFullMarkup
    {
      get
      {
        return _author.Equals("JND");
      }
    }

    public Volume(Author author, int vol)
    {
      _author = author;
      _vol = vol;
      _series = "";
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
