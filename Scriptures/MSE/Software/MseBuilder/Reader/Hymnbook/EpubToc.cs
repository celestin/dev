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
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubToc : EpubFile, IEpubTocGenerator
  {
    private DirectoryInfo _dir;

    public DirectoryInfo Dir
    {
      get { return _dir; }
      set { _dir = value; }
    }

    public string QualifiedId
    {
      get { return String.Format("{0}-toc", Document.LanguageCode); }
    }
    public FileInfo XmlFile
    {
      get { return new FileInfo(String.Format(@"{0}\{1}.html", Document.OpsDir.FullName, QualifiedId)); }
    }

    public EpubToc(EpubHymnbookDocument doc, DirectoryInfo dir)
      : base(doc)
    {
      Dir = dir;
    }

    public void GenerateToc()
    {
    }

    public virtual void SaveFile()
    {
      using (StreamWriter writer = new StreamWriter(XmlFile.FullName))
      {
        EpubHeading heading = new EpubHeading("Table of Contents");
        string li;

        WriteHeader(writer, heading.Text);
        writer.WriteLine(heading.RenderToXhtml());

        writer.WriteLine(@"    <ul>");

        foreach (EpubHymn article in Document.Hymns)
        {
          li = "      <li><a href=\"" + article.XmlFile.Name + "\">" + article.ShortHymnNo + "</a></li>";
          writer.WriteLine(li);
        }

        writer.WriteLine(@"    </ul>");

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