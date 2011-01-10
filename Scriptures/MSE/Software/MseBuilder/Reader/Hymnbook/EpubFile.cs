/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  02-Jan-2011  10917 : File created.
 * CAM  03-Jan-2011  10917 : Class renames to make Hymn EPUB more obviously separate.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubFile
  {
    private EpubHymnbookDocument _doc;

    public EpubHymnbookDocument Document
    {
      get { return _doc; }
      set { _doc = value; }
    }

    public EpubFile(EpubHymnbookDocument doc)
    {
      Document = doc;
    }
  }
}