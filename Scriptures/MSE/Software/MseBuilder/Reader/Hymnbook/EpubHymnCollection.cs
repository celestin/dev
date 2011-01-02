/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.ObjectModel;
using System.Text;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubArticleCollection : KeyedCollection<long, EpubHymn>
  {
    private EpubHymnDocument _doc;

    public EpubArticleCollection(EpubHymnDocument doc)
      : base()
    {
      _doc = doc;
    }

    protected override long GetKeyForItem(EpubHymn item)
    {
      return item.HymnNo;
    }

    protected EpubHymn CreateArticle(EpubHymn article)
    {
      Add(article);
      return article;
    }
  }
}
