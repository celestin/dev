/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * CAM  21-Jan-2010  10543 : Added dc:Subject (Tags).
 * CAM  21-Jan-2010  10549 : Use Volume.FullTitle for book title.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Xml;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub
{
  public class EpubOpf : EpubXmlFile, IEpubTocGenerator
  {
    private EpubDocument _doc;

    protected static readonly string XmlnsOpf = "http://www.idpf.org/2007/opf";
    protected static readonly string XmlnsDc = "http://purl.org/dc/elements/1.1/";

    private XmlElement _metaData;
    private XmlElement _manifest;
    private XmlElement _spine;
    private Guid _bookId;

    public override string XmlFilename { get { return "ministry.opf"; } }
    public override string RootName { get { return "package"; } }

    public XmlElement MetaData
    {
      get { return _metaData; }
    }
    public XmlElement Manifest
    {
      get { return _manifest; }
    }
    public XmlElement Spine
    {
      get { return _spine; }
    }
    public string BookId
    {
      get { return _bookId.ToString().ToUpper(); }
    }
    public string QualifiedBookId
    {
      get { return String.Format("urn:uuid:{0}", BookId); }
    }

    public EpubOpf(EpubDocument doc, DirectoryInfo dir, Volume volume)
      : base(dir, volume)
    {
      _doc = doc;
      _bookId = Guid.NewGuid();

      GenerateEpub();
    }

    public override void GenerateEpub()
    {
      base.GenerateEpub();

      _metaData = AppendElement(Root, "metadata");
      AppendAttribute(MetaData, "xmlns:opf", XmlnsOpf);
      AppendAttribute(MetaData, "xmlns:dc", XmlnsDc);

      _manifest = AppendElement(Root, "manifest");

      _spine = AppendElement(Root, "spine");
      AppendAttribute(Spine, "toc", "ncx");

      AddMetaData();
      AddSupportFiles();
    }

    public void GenerateToc()
    {
      foreach (EpubArticle article in _doc.Articles)
      {
        XmlElement element = AppendElement(Manifest, "item");
        AppendAttribute(element, "id", article.QualifiedId);
        AppendAttribute(element, "href", article.XmlFile.Name);
        AppendAttribute(element, "media-type", MimeTypes.GetMimeType(MimeType.Xhtml));

        element = AppendElement(Spine, "itemref");
        AppendAttribute(element, "idref", article.QualifiedId);
        AppendAttribute(element, "linear", "yes");
      }
    }

    protected string TagSafe(string type)
    {
      return type.Replace(",", "");
    }

    protected void AddMetaData()
    {
      XmlElement element = AppendElement(MetaData, "dc:title", XmlnsDc, Volume.FullTitle);

      element = AppendElement(MetaData, "dc:creator", XmlnsDc, Volume.Author.Name);
      AppendAttribute(element, "opf:role", XmlnsOpf, "aut");
      AppendAttribute(element, "opf:file-as", XmlnsOpf, Volume.Author.Name);

      element = AppendElement(MetaData, "dc:subject", XmlnsDc, TagSafe(Volume.Author.Name));
      element = AppendElement(MetaData, "dc:publisher", XmlnsDc, "GoodTeaching.org/Craig McKay");

      element = AppendElement(MetaData, "dc:date", XmlnsDc, DateTime.Now.ToString("YYYY-MM-DD"));
      AppendAttribute(element, "opf:event", XmlnsOpf, "epub-publication");

      element = AppendElement(MetaData, "dc:source", XmlnsDc, "GoodTeaching.org");

      element = AppendElement(MetaData, "dc:identifier", XmlnsDc, QualifiedBookId);
      AppendAttribute(element, "id", "EPB-UUID");

      element = AppendElement(MetaData, "dc:language", XmlnsDc, "en-gb");
    }

    protected void AddSupportFiles()
    {
      AddManifestFile("main-css", "css/epub-ministry.css", MimeType.Css);
      AddManifestFile("author-photo", String.Format("images/{0}", Volume.Author.ImageFilename), MimeType.ImagePng);
      AddManifestFile("ncx", "ministry.ncx", MimeType.Ncx);
    }

    protected void AddManifestFile(string id, string fileName, MimeType mimeType)
    {
      XmlElement element = AppendElement(Manifest, "item");
      AppendAttribute(element, "id", id);
      AppendAttribute(element, "href", fileName);
      AppendAttribute(element, "media-type", MimeTypes.GetMimeType(mimeType));
    }
  }
}