/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Jan-2010  10540 : File created.
 * CAM  21-Jan-2010  10544 : Create the EPUB zipfile.
 * CAM  11-Feb-2010  10559 : Mimetype without newline (needed?).
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Reader.Epub.Article;
using FrontBurner.Ministry.MseBuilder.Util;

namespace FrontBurner.Ministry.MseBuilder.Reader.Epub
{
  public class EpubDocument : IEpubGenerator, IEpubTocGenerator
  {
    private DirectoryInfo _rootDir;
    private DirectoryInfo _outputDir;
    private Volume _volume;
    private DirectoryInfo _epubDir;
    private DirectoryInfo _metaDir;
    private DirectoryInfo _opsDir;
    private DirectoryInfo _cssDir;
    private DirectoryInfo _imgDir;
    private FileInfo _epubFile;

    private FileInfo _cssFile;
    private FileInfo _authorImage;

    private EpubContainer _container;
    private EpubOpf _opf;
    private EpubNcx _ncx;

    private EpubArticleCollection _articles;

    public DirectoryInfo RootDir
    {
      get { return _rootDir; }
      set { _rootDir = value; }
    }
    public DirectoryInfo OutputDir
    {
      get { return _outputDir; }
      set { _outputDir = value; }
    }
    public DirectoryInfo OpsDir
    {
      get { return _opsDir; }
    }
    public Volume Volume
    {
      get { return _volume; }
      set { _volume = value; }
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

    public EpubArticleCollection Articles
    {
      get { return _articles; }
    }

    public EpubDocument(DirectoryInfo root, DirectoryInfo output, Volume volume, FileInfo cssFile, FileInfo authorImage)
    {
      RootDir = root;
      OutputDir = output;
      Volume = volume;
      _cssFile = cssFile;
      _authorImage = authorImage;

      _articles = new EpubArticleCollection(this);

      GenerateEpub();
    }

    public void GenerateEpub()
    {
      _epubDir = new DirectoryInfo(String.Format(@"{0}\{1}", RootDir.FullName, _volume.Filename));

      _metaDir = new DirectoryInfo(String.Format(@"{0}\META-INF", _epubDir.FullName));
      _opsDir = new DirectoryInfo(String.Format(@"{0}\OPS", _epubDir.FullName));

      _cssDir = new DirectoryInfo(String.Format(@"{0}\css", _opsDir.FullName));
      _imgDir = new DirectoryInfo(String.Format(@"{0}\img", _opsDir.FullName));

      _epubFile = new FileInfo(String.Format(@"{0}\{1}.epub", OutputDir.FullName, _volume.Filename));

      Container = new EpubContainer(_metaDir, Volume);
      Opf = new EpubOpf(this, _opsDir, Volume);
      Ncx = new EpubNcx(this, _opsDir, Volume);
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

      foreach (EpubArticle article in Articles)
      {
        article.SaveFile();
      }

      CreateMimeType();
      CopyResources();

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
      _authorImage.CopyTo(String.Format(@"{0}\{1}", _imgDir.FullName, _authorImage.Name), true);
    }
  }
}
