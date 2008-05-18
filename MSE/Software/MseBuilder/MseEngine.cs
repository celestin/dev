/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007,2008 Front Burner
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
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using System.IO;
using System.Data;
using ICSharpCode.SharpZipLib.Core;
using ICSharpCode.SharpZipLib.GZip;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder
{
  public class MseEngine
  {
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
      VolumeCollection vols = BusinessLayer.Instance.GetVolumes();
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
          if ((volume == 0) || ((volume > 0) && (vol.Author.Equals(author)) && (vol.Vol == volume)))
          {
            sqlFile = new FileInfo(String.Format(@"{0}\{1}_{2}.sql", root.FullName, vol.Author.ToLower(), vol.Vol.ToString("000")));

            using (StreamWriter sw = new StreamWriter(sqlFile.FullName))
            {
              sw.NewLine = "\n";

              sw.WriteLine(String.Format("-- {0} {1}\n", vol.Author, vol.Vol));

              sw.WriteLine("\n-- REMOVE EXISTING VOLUME\n");

              // Empty existing data
              sw.WriteLine(String.Format("UPDATE mse_volume SET added=now() WHERE author='{0}' AND vol={1};\n", vol.Author, vol.Vol));
              sw.WriteLine(String.Format("DELETE FROM mse_article WHERE author='{0}' AND vol={1};", vol.Author, vol.Vol));
              sw.WriteLine(String.Format("DELETE FROM mse_text WHERE author='{0}' AND vol={1};", vol.Author, vol.Vol));
              sw.WriteLine(String.Format("DELETE FROM mse_bible_ref WHERE author='{0}' AND vol={1};\n", vol.Author, vol.Vol));

              sw.WriteLine("\n-- ADD ARTICLES\n");

              // Write Articles
              foreach (DataRow dr in DatabaseLayer.Instance.GetArticles(vol).Rows)
              {
                sql = String.Format(
                  "INSERT INTO mse_article (author,vol,page,article,scriptures) VALUES " +
                  "('{0}',{1},{2},'{3}','{4}');",
                  vol.Author, vol.Vol, dr["page"],
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
                    vol.Author, vol.Vol,
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
                  vol.Author, vol.Vol,
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
  }
}
