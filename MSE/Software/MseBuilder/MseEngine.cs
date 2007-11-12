/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  22-Oct-2007  10186 : Added Zip method.
 * CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
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

    public int Current
    {
      get
      {
        return _current;
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
      //MessageBox.Show(String.Format("Author {0} Vol {1}", vol.Author, vol.Vol));

      DatabaseLayer.Instance.DeleteVolume(vol);
      MseParser parser = new MseParser(vol);

      //parser.ParseArticles();
      parser.ParseText();

      /****
       * // TODO [#10188] - add this
       *   // Update Article pages and output Inserts for Articles
        while ($row2 = mysql_fetch_array($sql2)) {
          foreach($row2 AS $key2 => $val2) {
            $$key2 = stripslashes($val2);
          }
          $ssql = "UPDATE mse_text ".
                  "SET article_page = $page ".
                  "WHERE author = '$author' ".
                  "AND vol = $vol ".
                  "AND localrow >= $localrow ".
                  "AND article_page = 0";
          $sql3 = mysql_query($ssql);

          $insertsql = "INSERT INTO mse_article (author,vol,page,article,scriptures) VALUES ".
          "('$author',$vol,$page,'".f_sqlstring($article)."','".f_sqlstring($scriptures)."');\n";

          fwrite($uf, $insertsql);
       *
       *
       */

    }

    public void Build()
    {
      VolumeCollection vols = DatabaseLayer.Instance.GetVolumes();
      _current = 0;

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
      byte[] dataBuffer = new byte[4096];
      String sql = "";
      DirectoryInfo root = new DirectoryInfo(@"C:\tmp\mse1");
      FileInfo sqlFile;
      FileInfo zipFile;

      if (root.Exists) root.Delete(true);
      root.Create();
      _current = 0;

      using (StreamWriter script = new StreamWriter(root.FullName + "\\aaa"))
      {
        foreach (Volume vol in DatabaseLayer.Instance.GetVolumes())
        {
          sqlFile = new FileInfo(String.Format(@"{0}\{1}_{2}.sql", root.FullName, vol.Author.ToLower(), vol.Vol.ToString("00")));

          using (StreamWriter sw = new StreamWriter(sqlFile.FullName))
          {
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
              string inits = dr["inits"].ToString();
              string text = dr["text"].ToString();

              if (inits.Length == 0)
              {
                inits = "NULL";
              }
              else
              {
                inits = DatabaseLayer.SqlText(inits, true);
              }

              if (text.Length > 0)
              {
                sql = String.Format(
                  "INSERT INTO mse_text (author,vol,page,para,article_page,inits,text) VALUES " +
                  "('{0}',{1},{2},{3},{4},{5},'{6}');",
                  vol.Author, vol.Vol,
                  dr["page"], dr["para"], dr["article_page"], inits, DatabaseLayer.SqlText(text));

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

          _current++;
          Thread.Sleep(100);
        }
      }
    }
  }
}
