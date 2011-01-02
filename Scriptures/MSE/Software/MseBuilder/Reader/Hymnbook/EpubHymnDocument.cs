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
using System.Drawing;
using System.IO;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;
using FrontBurner.Ministry.MseBuilder.Util;
using FrontBurner.Ministry.MseBuilder.Engine;
using FrontBurner.Ministry.MseBuilder.Reader.Epub;

namespace FrontBurner.Ministry.MseBuilder.Reader.Hymnbook
{
  public class EpubHymnDocument : IEpubGenerator, IEpubTocGenerator
  {
    private Guid _bookId;

    private Language _language;
    private DirectoryInfo _rootDir;
    private DirectoryInfo _outputEpub;
    private DirectoryInfo _outputMobi;
    private DirectoryInfo _epubDir;
    private DirectoryInfo _metaDir;
    private DirectoryInfo _opsDir;
    private DirectoryInfo _cssDir;
    private DirectoryInfo _imgDir;
    private FileInfo _epubFile;
    private FileInfo _mobiFile;

    private FileInfo _cssFile;
    private FileInfo _coverImage;

    private EpubContainer _container;
    private EpubOpf _opf;
    private EpubNcx _ncx;
    private EpubToc _toc;

    private EpubArticleCollection _articles;

    public string BookId
    {
      get { return _bookId.ToString().ToUpper(); }
    }
    public string QualifiedBookId
    {
      get { return String.Format("urn:uuid:{0}", BookId); }
    }
    public Language Language
    {
      get { return _language; }
      set { _language = value; }
    }
    public string LanguageCode
    {
      get { return Languages.LanguageCode(Language); }
    }
    public string Filename
    {
      get { return String.Format("hymns-1962-{0}"); }
    }
    public string HymnBookTitle
    {
      get { return "Hymns and Spiritual Songs (1962)"; }
    }
    public string HymnBookAuthor
    {
      get { return "Brethren"; }
    }
    public DirectoryInfo RootDir
    {
      get { return _rootDir; }
      set { _rootDir = value; }
    }
    public DirectoryInfo OutputEpub
    {
      get { return _outputEpub; }
      set { _outputEpub = value; }
    }
    public DirectoryInfo OutputMobi
    {
      get { return _outputMobi; }
      set { _outputMobi = value; }
    }
    public DirectoryInfo OpsDir
    {
      get { return _opsDir; }
    }
    public EpubContainer Container
    {
      get { return _container; }
      set { _container = value; }
    }
    public EpubOpf Opf
    {
      get { return _opf; }
      set { _opf = value; }
    }
    public EpubNcx Ncx
    {
      get { return _ncx; }
      set { _ncx = value; }
    }
    public EpubToc Toc
    {
      get { return _toc; }
      set { _toc = value; }
    }

    public EpubArticleCollection Articles
    {
      get { return _articles; }
    }

    public EpubHymnDocument(Language language, DirectoryInfo root, DirectoryInfo outputEpub, DirectoryInfo outputMobi, FileInfo cssFile, FileInfo coverImage)
    {
      Language = language;
      RootDir = root;
      OutputEpub = outputEpub;
      OutputMobi = outputMobi;
      _cssFile = cssFile;
      _coverImage = coverImage;

      _bookId = Guid.NewGuid();

      _articles = new EpubArticleCollection(this);

      // Build based on the Epub for Mobi, alter for Standard later (as this has less functionality)
      EngineSettings.Instance.Mode = BuildMode.KindleMobiEpub;

      GenerateEpub();
    }

    public void GenerateEpub()
    {
      _epubDir = new DirectoryInfo(String.Format(@"{0}\{1}", RootDir.FullName, LanguageCode));

      _metaDir = new DirectoryInfo(String.Format(@"{0}\META-INF", _epubDir.FullName));
      _opsDir = new DirectoryInfo(String.Format(@"{0}\OPS", _epubDir.FullName));

      _cssDir = new DirectoryInfo(String.Format(@"{0}\css", _opsDir.FullName));
      _imgDir = new DirectoryInfo(String.Format(@"{0}\img", _opsDir.FullName));

      _epubFile = new FileInfo(String.Format(@"{0}\{1}.epub", OutputEpub.FullName, Filename));
      _mobiFile = new FileInfo(String.Format(@"{0}\{1}.mobi", OutputMobi.FullName, Filename));

      Ncx = new EpubNcx(this, _opsDir);
      Toc = new EpubToc(this, _opsDir);
      Opf = new EpubOpf(this, _opsDir);
      Container = new EpubContainer(this, _metaDir);
    }

    public void GenerateToc()
    {
      Opf.GenerateToc();
      Ncx.GenerateToc();
    }

    public void SaveFile()
    {
      CreateDirectoryStructure();

      Container.SaveFile();
      Opf.SaveFile();
      Ncx.SaveFile();
      Toc.SaveFile();

      foreach (EpubHymn article in Articles)
      {
        article.SaveFile();
      }

      CreateMimeType();
      CopyResources();

      // MOBI generated with Kindle TOC
      KindleGen.Instance.GenerateMobi(_opf.File, _mobiFile);

      // Regenerate without the Kindle TOC for EPUB (iPad etc)
      EngineSettings.Instance.Mode = BuildMode.StandardEpub;
      Opf.GenerateEpub();
      Opf.GenerateToc();
      Opf.SaveFile();
      Zipper.Instance.ZipDirectory(_epubDir, _epubFile);
    }

    protected void CreateDirectoryStructure()
    {
      if (_epubDir.Exists) _epubDir.Delete(true);
      if (_epubFile.Exists) _epubFile.Delete();

      _epubDir.Create();
      _metaDir.Create();
      _opsDir.Create();

      _cssDir.Create();
      _imgDir.Create();
    }

    protected void CreateMimeType()
    {
      FileInfo mimetypeFile = new FileInfo(String.Format(@"{0}\mimetype", _epubDir));

      using (StreamWriter writer = new StreamWriter(mimetypeFile.FullName))
      {
        writer.Write(MimeTypes.GetMimeType(MimeType.EpubZip));
      }
    }

    protected void CopyResources()
    {
      _cssFile.CopyTo(String.Format(@"{0}\{1}", _cssDir.FullName, _cssFile.Name), true);

      // Determine the text and therefore size/position of the title 
      string title = String.Format("({0})", Languages.LanguageCode(Language));
      int fontSize = 48;
      float vertical = 0.25f;

      // Copy the plain volume cover and add the specific title
      Bitmap coverBitmap = new Bitmap(_coverImage.FullName);
      Graphics g = Graphics.FromImage(coverBitmap);
      g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;

      StringFormat strFormat = new StringFormat();
      strFormat.Alignment = StringAlignment.Center;
      int h = (int)(((float)coverBitmap.Height) * vertical);
      int w = (int)(((float)coverBitmap.Width) * 0.9f);
      g.DrawString(title, new Font("Tahoma", fontSize), new SolidBrush(Color.FromArgb(255, 243, 186)),
          new RectangleF((coverBitmap.Width-w)/2, coverBitmap.Height-h, w, h), strFormat);
      coverBitmap.Save(String.Format(@"{0}\cover-{1}", _imgDir.FullName, _coverImage.Name));
    }
  }
}
