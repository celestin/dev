/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Abstract.Hymnbook
{
  public class Hymn
  {
    protected long _hymnNo;
    protected string _author;
    protected string _meter;

    public long HymnNo
    {
      get
      {
        return _hymnNo;
      }
      set
      {
        _hymnNo = value;
      }
    }

    public static string GetTitle(string title)
    {
      const string SuperscriptStart = "<sup>";
      const string SuperscriptEnd = "</sup>";

      int p = title.IndexOf(SuperscriptStart);
      while (p >= 0)
      {
        int e = title.IndexOf(SuperscriptEnd, p);
        if (e > 0) title = title.Substring(0, p) + title.Substring(e + SuperscriptEnd.Length);

        p = title.IndexOf(SuperscriptStart);
      }

      return title;
    }

    public Hymn(int hymnNo)
    {
      HymnNo = hymnNo;
    }
  }

  public class HymnCollection : KeyedCollection<long, Hymn>
  {
    public HymnCollection()
      : base()
    {
    }

    protected override long GetKeyForItem(Hymn hymn)
    {
      return hymn.HymnNo;
    }
  }
}
