/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2010 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  22-Oct-2007  10186 : Added Zip method.
 * CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
 * CAM  25-Nov-2007  10208 : Added newpages to SQL that is written to the loader file.
 * CAM  11-May-2008  10265 : Allow Zipping of single Volume.
 * CAM  17-May-2008  10266 : Check for Errors during Build.
 * CAM  08-Jun-2008  10269 : Don't just do an update on the export script: the volume may not exist - do a REPLACE including Title.
 * CAM  15-Jan-2010  10528 : Added CreateBbebFiles.
 * CAM  15-Jan-2010  10529 : Converted Volume.Author from string to Author class.
 * CAM  15-Jan-2010  10531 : Added ArticleStage.
 * CAM  15-Jan-2010  10532 : Add Articles to the TOC.
 * CAM  15-Jan-2010  10533 : Copy image files to target directory.
 * CAM  18-Jan-2010  10529 : Missed several references to Author!
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Threading;
using System.Windows.Forms;

using ICSharpCode.SharpZipLib.Core;
using ICSharpCode.SharpZipLib.GZip;

using FrontBurner.Ministry.MseBuilder.Abstract;
using FrontBurner.Ministry.MseBuilder.Reader.Bbeb;

namespace FrontBurner.Ministry.MseBuilder
{
  public class MseEngine
  {
    private enum ArticleStage
    {
      Title,
      Scriptures,
      Body
    }

    protected int _current;
    protected bool _anyErrors;

    public int Current
    {
      get
      {
        return _current;
      }
    }
    public bool AnyErrors
    {
      get
      {
        return _anyErrors;
      }
    }

    public MseEngine()
    {
      DatabaseLayer.Instance.Open();
    }

    public void Build(string author, int vol)
    {
      VolumeCollection vols = BusinessLayer.Instance.Volumes;
      Volume vol1 = null;
      _anyErrors = false;

      try
      {
        vol1 = vols[Volume.GetId(author, vol)];
      }
      catch (Exception)
      {
        throw;
      }

      if (vol1 != null)
      {
        Build(vol1);
      }
    }

    public void Build(Volume vol)
    {
      DatabaseLayer.Instance.DeleteVolume(vol);
      MseParser parser = new MseParser(vol);
      if (parser.ParseText()) _anyErrors = true;
    }

    public void Build()
    {
      VolumeCollection vols = DatabaseLayer.Instance.GetVolumes();
      _current = 0;
      _anyErrors = false;

      DatabaseLayer.Instance.TruncateTables();

      foreach (Volume vol in vols)
      {
        Build(vol);
        _current++;
        Thread.Sleep(2000);
      }
    }

    public void Zip()
    {
      this.Zip(string.Empty, 0);
    }

    public void Zip(string author, int volume)
    {
      byte[] dataBuffer = new byte[4096];
      string sql = "";
      string colSql = "";
      DirectoryInfo root = new DirectoryInfo(@"C:\tmp\mse1");
      FileInfo sqlFile = null;
      FileInfo zipFile = null;

      if (root.Exists) root.Delete(true);
      root.Create();
      _current = 0;

      using (StreamWriter script = new StreamWriter(root.FullName + @"\aaa"))
      {
        foreach (Volume vol in DatabaseLayer.Instance.GetVolumes())
        {
          if ((volume == 0) || ((volume > 0) && (vol.Author.Inits.Equals(author)) && (vol.Vol == volume)))
          {
            sqlFile = new FileInfo(String.Format(@"{0}\{1}_{2}.sql", root.FullName, vol.Author.Inits.ToLower(), vol.Vol.ToString("000")));

            using (StreamWriter sw = new StreamWriter(sqlFile.FullName))
            {
              sw.NewLine = "\n";

              sw.WriteLine(String.Format("-- {0} {1}\n", vol.Author.Inits, vol.Vol));

              sw.WriteLine("\n-- REMOVE EXISTING VOLUME\n");

              // Empty existing data
              sw.WriteLine(String.Format("REPLACE INTO mse_volume (author,vol,title,added) VALUES ('{0}', '{1}', '{2}', NOW());\n", vol.Author.Inits, vol.Vol, vol.Title));
              sw.WriteLine(String.Format("DELETE FROM mse_article WHERE author='{0}' AND vol={1};", vol.Author.Inits, vol.Vol));
              sw.WriteLine(String.Format("DELETE FROM mse_text WHERE author='{0}' AND vol={1};", vol.Author.Inits, vol.Vol));
              sw.WriteLine(String.Format("DELETE FROM mse_bible_ref WHERE author='{0}' AND vol={1};\n", vol.Author.Inits, vol.Vol));

              sw.WriteLine("\n-- ADD ARTICLES\n");

              // Write Articles
              foreach (DataRow dr in DatabaseLayer.Instance.GetArticles(vol).Rows)
              {
                sql = String.Format(
                  "INSERT INTO mse_article (author,vol,page,article,scriptures) VALUES " +
                  "('{0}',{1},{2},'{3}','{4}');",
                  vol.Author.Inits, vol.Vol, dr["page"],
                  DatabaseLayer.SqlText(dr["article"]),
                  DatabaseLayer.SqlText(dr["scriptures"]));

                sw.WriteLine(sql);
              }

              sw.WriteLine("\n-- ADD TEXT\n");

              foreach (DataRow dr in DatabaseLayer.Instance.GetText(vol).Rows)
              {
                string text = dr["text"].ToString();
                string inits = dr["inits"].ToString();
                string newPages = dr["newpages"].ToString();

                if (text.Length > 0)
                {
                  // Non-null columns
                  colSql = "INSERT INTO mse_text (author,vol,page,para,article_page,text";
                  sql = String.Format(
                    "'{0}',{1},{2},{3},{4},'{5}'",
                    vol.Author.Inits, vol.Vol,
                    dr["page"], dr["para"], dr["article_page"], DatabaseLayer.SqlText(text));

                  // Add each nullable column
                  if (inits.Length > 0)
                  {
                    colSql += ",inits";
                    sql += "," + DatabaseLayer.SqlText(inits, true);
                  }
                  if (newPages.Length > 0)
                  {
                    colSql += ",newpages";
                    sql += "," + DatabaseLayer.SqlText(newPages, true);
                  }

                  sql = colSql + ") VALUES (" + sql + ");";
                  sw.WriteLine(sql);
                }
              }

              sw.WriteLine("\n-- ADD BIBLE REFS\n");

              foreach (DataRow dr in DatabaseLayer.Instance.GetBibleRefs(vol).Rows)
              {
                sql = String.Format(
                  "INSERT INTO mse_bible_ref (author,vol,page,para,ref,bookid,chapter,vstart,vend) VALUES " +
                  "('{0}',{1},{2},{3},{4},{5},{6},{7},{8});",
                  vol.Author.Inits, vol.Vol,
                  dr["page"], dr["para"], dr["ref"],
                  dr["bookid"], dr["chapter"], dr["vstart"], dr["vend"]);

                sw.WriteLine(sql);
              }

              sw.Close();
            }

            zipFile = new FileInfo(sqlFile.FullName + ".gz");

            using (Stream stream = new GZipOutputStream(File.Create(zipFile.FullName)))
            using (FileStream fileStream = File.OpenRead(sqlFile.FullName))
            {
              StreamUtils.Copy(fileStream, stream, dataBuffer);
            }

            sqlFile.Delete();

            script.WriteLine(String.Format("gunzip {0}", zipFile.Name));
            script.WriteLine(String.Format("mysql -u goodteaching -ppsalm45 -D goodteaching_org_min < {0}", sqlFile.Name));
            script.WriteLine(String.Format("rm {0}", sqlFile.Name));
            script.Flush();

            Thread.Sleep(100);
          }

          _current++;
        }
      }
    }

    public void CreateBbebFiles()
    {
      CreateBbebFiles(null, 0);
    }

    public void CreateBbebFiles(string author, int volume)
    {
      byte[] dataBuffer = new byte[4096];
      DirectoryInfo root = new DirectoryInfo(@"C:\tmp\bbeb");
      FileInfo lrsFile = null;

      Process p = new Process();
      p.StartInfo.WorkingDirectory = root.FullName;
      p.StartInfo.FileName = @"C:\Program Files\Calibre2\lrs2lrf.exe";
      p.StartInfo.CreateNoWindow = true;

      if (root.Exists)
      {
        foreach (FileInfo file in root.GetFiles())
        {
          file.Delete();
        }
      }
      else
      {
        root.Create();
      }

      // Copy Icon
      FileInfo exe = new FileInfo(Application.ExecutablePath);
      FileInfo thumbnail = new FileInfo(String.Format(@"{0}\img\eministry.gif", exe.DirectoryName));
      thumbnail.CopyTo(String.Format(@"{0}\{1}", root.FullName, thumbnail.Name), true);

      // Copy each of the Author photos
      foreach (Author auth in BusinessLayer.Instance.Authors)
      {
        FileInfo image = new FileInfo(String.Format(@"{0}\img\author\{1}", exe.DirectoryName, auth.ImageFilename));
        image.CopyTo(String.Format(@"{0}\{1}", root.FullName, image.Name), true);
      }

      _current = 0;

      foreach (Volume vol in DatabaseLayer.Instance.GetVolumes())
      {
        if ((volume == 0) || ((volume > 0) && (vol.Author.Inits.Equals(author)) && (vol.Vol == volume)))
        {
          lrsFile = new FileInfo(String.Format(@"{0}\{1}_{2}.lrs", root.FullName, vol.Author.Inits.ToLower(), vol.Vol.ToString("000")));

          if (vol.Author.Inits.Equals("JT"))
          {
            vol.Series = "New Series";
          }

          BbebDocument doc = new BbebDocument(lrsFile, vol);

          doc.BookInformation.Title = vol.FullTitle;
          doc.BookInformation.Author = vol.Author.Name;
          doc.BookInformation.BookId = BbebUtil.Instance.NextBookId();
          doc.BookInformation.Category = vol.Author.Name;
          doc.BookInformation.Creator = "GoodTeaching.org (Craig McKay)";
          doc.GenerateBbeb();

          int currentArticle = 0;
          BbebPage page = null;
          BbebTextBlock textBlock = null;
          ArticleStage stage = ArticleStage.Title;

          // Need to put an outer loop by article, for ease of outputting title and scripture

          foreach (DataRow dr in DatabaseLayer.Instance.GetText(vol).Rows)
          {
            string text = dr["text"].ToString();
            string inits = dr["inits"].ToString();
            string newPages = dr["newpages"].ToString();
            int articlePage = int.Parse(dr["article_page"].ToString());

            if (articlePage != currentArticle)
            {
              // New article, start a new page
              page = new BbebPage(doc, doc.PageStyle);
              doc.MainBlock.AppendChild(page);
              page.GenerateBbeb();

              currentArticle = articlePage;
              stage = ArticleStage.Title;
            }

            if (stage == ArticleStage.Title)
            {
              if (Paragraph.IsTitle(text))
              {
                textBlock = new BbebTextBlock(doc, doc.BlockStyle, doc.TextStyleCollection[TextPurpose.ArticleTitle]);
                textBlock.AddTitle(text);
                textBlock.GenerateBbeb();
                page.AppendChild(textBlock);
                doc.BookInformation.Toc.Add(new BbebTocLabel(doc, page, textBlock, text));

                stage = ArticleStage.Scriptures;
              }
            }
            else
            {

              if (stage == ArticleStage.Scriptures && text.Trim().StartsWith("@"))
              {
                textBlock = new BbebTextBlock(doc, doc.BlockStyle, doc.TextStyleCollection[TextPurpose.ArticleScriptures]);
                textBlock.AddScriptures(text);
                stage = ArticleStage.Body;
              }
              else
              {
                textBlock = new BbebTextBlock(doc, doc.BlockStyle, doc.TextStyleCollection[TextPurpose.ArticleText]);
                if (inits.Length > 0)
                {
                  textBlock.AddParagraph(inits, text);
                }
                else
                {
                  textBlock.AddParagraph(text);
                }
              }

              textBlock.GenerateBbeb();
              page.AppendChild(textBlock);
            }
          }

          doc.BookInformation.GenerateToc();

          doc.SaveFile();

          p.StartInfo.Arguments = lrsFile.Name;
          p.Start();
          p.WaitForExit();

          Thread.Sleep(100);
        }

        _current++;
      }
    }
  }
}
