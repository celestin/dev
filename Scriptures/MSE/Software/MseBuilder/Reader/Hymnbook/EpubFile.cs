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
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubFile 
  {
    private EpubHymnDocument _doc;

    public EpubHymnDocument Document
    {
      get { return _doc; }
      set { _doc = value; }
    }

    public EpubFile(EpubHymnDocument doc)
    {
      Document = doc;
    }
  }
}