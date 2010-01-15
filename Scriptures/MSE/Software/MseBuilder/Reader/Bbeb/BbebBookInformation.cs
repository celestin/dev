/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  15-Jan-2010  10528 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Xml;
using System.IO;

namespace FrontBurner.Ministry.MseBuilder.Reader.Bbeb
{
  public class BbebBookInformation : BbebElement
  {
    private string _title;
    private string _author;
    private string _bookId;
    private string _category;
    private FileInfo _thumbnail;
    private string _creator;

    public string Title
    {
      get { return _title; }
      set { _title = value; }
    }
    public string Author
    {
      get { return _author; }
      set { _author = value; }
    }
    public string BookId
    {
      get { return _bookId; }
      set { _bookId = value; }
    }
    public string Category
    {
      get { return _category; }
      set { _category = value; }
    }
    public FileInfo Thumbnail
    {
      get { return _thumbnail; }
      set { _thumbnail = value; }
    }
    public string Creator
    {
      get { return _creator; }
      set { _creator = value; }
    }

    public BbebBookInformation(BbebDocument doc)
      : base(doc, "BookInformation")
    {
      Thumbnail = new FileInfo(@"C:\Program Files\Calibre2\eministry.gif");
    }

    public override void GenerateBbeb()
    {
      XmlElement info;
      XmlElement toc;
      XmlElement bookInfo;
      XmlElement docInfo;
      XmlAttribute attribute;

      info = OwnerDocument.CreateElement("", "Info", "");
      AppendChild(info);
      attribute = OwnerDocument.CreateAttribute("version");
      attribute.Value = "1.1";
      info.Attributes.Append(attribute);

      bookInfo = OwnerDocument.CreateElement("", "BookInfo", "");
      info.AppendChild(bookInfo);

      docInfo = OwnerDocument.CreateElement("", "DocInfo", "");
      info.AppendChild(docInfo);

      toc = OwnerDocument.CreateElement("", "TOC", "");
      AppendChild(toc);

      XmlElement title = OwnerDocument.CreateElement("", "Title", "");
      bookInfo.AppendChild(title);
      title.Attributes.Append(OwnerDocument.CreateAttribute("reading"));
      title.AppendChild(OwnerDocument.CreateTextNode(Title));

      XmlElement author = OwnerDocument.CreateElement("", "Author", "");
      bookInfo.AppendChild(author);
      author.Attributes.Append(OwnerDocument.CreateAttribute("reading"));
      author.AppendChild(OwnerDocument.CreateTextNode(Author));

      XmlElement bookId = OwnerDocument.CreateElement("", "BookID", "");
      bookInfo.AppendChild(bookId);
      bookId.AppendChild(OwnerDocument.CreateTextNode(BookId));

      XmlElement category = OwnerDocument.CreateElement("", "Category", "");
      bookInfo.AppendChild(category);
      category.Attributes.Append(OwnerDocument.CreateAttribute("reading"));
      category.AppendChild(OwnerDocument.CreateTextNode(Category));

      XmlElement thumbnail = OwnerDocument.CreateElement("", "CThumbnail", "");
      bookInfo.AppendChild(thumbnail);
      attribute = OwnerDocument.CreateAttribute("file");
      attribute.Value = Thumbnail.Name;
      thumbnail.Attributes.Append(attribute);

      XmlElement creator = OwnerDocument.CreateElement("", "Creator", "");
      bookInfo.AppendChild(creator);
      creator.Attributes.Append(OwnerDocument.CreateAttribute("reading"));
      creator.AppendChild(OwnerDocument.CreateTextNode(Creator));
    }
  }
}
