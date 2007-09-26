/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  26-Sep-2007  Early working version.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Abstract
{
  public class Article
  {
    protected Volume _vol;
    protected int _pageNo;
    protected int _para;
    protected string _title;
    protected string _scriptures;

    public string Id
    {
      get
      {
        return GetId(_vol, _para);
      }
    }
    public Volume Volume
    {
      get
      {
        return _vol;
      }
    }
    public int PageNo
    {
      get
      {
        return _pageNo;
      }
      set
      {
        _pageNo = value;
      }
    }
    public int Para
    {
      get
      {
        return _para;
      }
      set
      {
        _para = value;
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
    public string Scriptures
    {
      get
      {
        return _scriptures;
      }
      set
      {
        _scriptures = value;
      }
    }

    public Article(Volume vol, int pageNo, int para, string title)
    {
      _vol = vol;
      _pageNo = pageNo;
      _para = para;
      _title = title;
    }

    public static string GetId(Volume vol, int para)
    {
      return String.Format("{0}-{1}", vol.Id, para);
    }
  }

  public class ArticleCollection : KeyedCollection<string, Article>
  {
    public ArticleCollection()
      : base()
    {
    }

    protected override string GetKeyForItem(Article article)
    {
      return article.Id;
    }
  }
}
