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
using System.Text;
using System.IO;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Abstract.Hymnbook;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubHymn : EpubFile, IEpubGenerator
  {
    private Hymn _hymn;
    private EpubItemCollection _items;
    private string _title;
    private string _scriptures;

    public Hymn Hymn
    {
      get { return _hymn; }
      set { _hymn = value; }
    }
    public long HymnNo
    {
      get { return Hymn.HymnNo; }
    }
    public string QualifiedId
    {
      get { return String.Format("{0}-{1:000}", Document.LanguageCode, HymnNo); }
    }
    public FileInfo XmlFile
    {
      get { return new FileInfo(String.Format(@"{0}\{1}.html", Document.OpsDir.FullName, QualifiedId)); }
    }
    public EpubItemCollection Items
    {
      get { return _items; }
    }
    public string Title
    {
      get
      {
        if (_title == null) return String.Empty;
        return _title;
      }
      set
      {
        _title = value;
      }
    }
    public string PlainTitle
    {
      get
      {
        return FrontBurner.Ministry.MseBuilder.Abstract.Article.GetTitle(Title);
      }
    }
    public string Scriptures
    {
      get
      {
        if (_scriptures == null) return String.Empty;
        return _scriptures;
      }
      set { _scriptures = value; }
    }

    public EpubHymn(Hymn hymn, EpubHymnDocument doc)
      : base(doc)
    {
      Hymn = hymn;
      _items = new EpubItemCollection();
    }

    public virtual void GenerateEpub()
    {
    }

    public virtual void SaveFile()
    {
      using (StreamWriter writer = new StreamWriter(XmlFile.FullName))
      {
        EpubHeading heading = new EpubHeading(Title);
        EpubScriptures scriptures = new EpubScriptures(Scriptures);

        WriteHeader(writer, PlainTitle);
        writer.WriteLine(heading.RenderToXhtml());
        writer.WriteLine(scriptures.RenderToXhtml());

        foreach (EpubItem item in Items)
        {
          writer.WriteLine(item.RenderToXhtml());
        }

        WriteFooter(writer);
      }
    }

    public void WriteHeader(StreamWriter writer, string title)
    {
      writer.WriteLine(@"<?xml version=""1.0"" encoding=""UTF-8""?>");
      writer.WriteLine(@"<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.1//EN"" ""http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"">");
      writer.WriteLine(@"<html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""en"">");
      writer.WriteLine(@"  <head>");
      writer.WriteLine(@"    <title>" + title + "</title>");
      writer.WriteLine(@"    <link rel=""stylesheet"" href=""css/epub-hymn.css"" type=""text/css""/>");
      writer.WriteLine(@"    <meta http-equiv=""Content-Type"" content=""application/xhtml+xml; charset=utf-8""/>");
      writer.WriteLine(@"    <meta name=""EPB-UUID"" content=""" + Document.BookId + @"""/>");
      writer.WriteLine(@"  </head>");
      writer.WriteLine(@"  <body>");
    }

    public void WriteFooter(StreamWriter writer)
    {
      writer.WriteLine(@"  </body>");
      writer.WriteLine(@"</html>");
    }
  }
}
