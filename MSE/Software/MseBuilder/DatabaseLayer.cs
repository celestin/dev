/* * * * * * * * * * * * * * * * * * * * * * * *
 * Good Teaching Search Engine Data Builder
 * Copyright (c) 2007 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
 * CAM  22-Oct-2007  10186 : Added methods for exporting.
 * CAM  12-Nov-2007  10202 : Migrated to goodteaching.org.
 * CAM  24-Nov-2007  10188 : Save Mse_Text.Article_Page.
 * CAM  24-Nov-2007  10208 : Write NewPages to mse_text.
 * CAM  25-Nov-2007  10208 : Added newpages to sql extraction in GetText.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;

using FrontBurner.Ministry.MseBuilder.Abstract;

namespace FrontBurner.Ministry.MseBuilder
{
  /// <summary>
  /// Retrieves MySQL data
  /// </summary>
  public class DatabaseLayer
  {
    private static DatabaseLayer _dbLayer;
    protected static readonly object _semaphore = new object();

    protected MySqlConnection _conn;

    protected MySqlCommand _cmdVolume;
    protected MySqlCommand _cmdBooks;
    protected MySqlCommand _cmdArticles;
    protected MySqlCommand _cmdText;
    protected MySqlCommand _cmdBibleRef;

    protected MySqlCommand _cmdInsertText;
    protected MySqlCommand _cmdInsertBibleRef;
    protected MySqlCommand _cmdInsertBadBibleRef;

    protected MySqlDataAdapter _dadAuthor;

    private DatabaseLayer()
    {
    }

    public static DatabaseLayer Instance
    {
      get
      {
        lock (_semaphore)
        {
          if (_dbLayer == null)
          {
            _dbLayer = new DatabaseLayer();
          }
          return _dbLayer;
        }
      }
    }

    public bool Open()
    {
      string DataSource = "localhost";
      string Database = "goodteaching_org_min";
      string UserID     = "goodteaching";
      string Password   = "psalm45";

      string MyConString  = "Data Source=" + DataSource +
          ";Database=" + Database +
          ";User ID=" + UserID +
          ";Password=" + Password;

      lock (_semaphore)
      {
        try
        {
          _conn = new MySqlConnection(MyConString);
          _conn.Open();
        }
        catch (Exception)
        {
          return false;
        }
      }
      return true;
    }

    public void Close()
    {
      lock (_semaphore)
      {
        if (_conn != null && _conn.State == ConnectionState.Open)
        {
          _conn.Close();
        }

      }
    }

    public BibleBookCollection GetBooks()
    {
      String sql;
      MySqlDataReader dr;
      BibleBook book;
      BibleBookCollection books = new BibleBookCollection();

      sql = "SELECT bookid, bookname, singlechap " +
            "FROM mse_bible_book ";

      lock (_semaphore)
      {
        if (_cmdBooks == null)
        {
          _cmdBooks = new MySqlCommand(sql, _conn);
        }
        dr = _cmdBooks.ExecuteReader();
      }

      do
      {
        while (dr.Read())
        {
          book = new BibleBook(dr.GetInt32(0), dr.GetString(1));
          if (!dr.IsDBNull(2)) book.SingleChap = (dr.GetInt32(2)==1);

          books.Add(book);
        }
      } while (dr.NextResult());

      dr.Close();

      return books;
    }

    public VolumeCollection GetVolumes()
    {
      MySqlDataReader dr;
      Volume vol;
      VolumeCollection rval = new VolumeCollection();

      lock (_semaphore)
      {
        if (_cmdVolume == null)
        {
          string sql =
            "SELECT author,vol,title,added,localfile " +
            "FROM mse_volume " +
            "WHERE author <> 'GRC' ";

          _cmdVolume = new MySqlCommand(sql, _conn);
        }
        dr = _cmdVolume.ExecuteReader();

        do
        {
          while (dr.Read())
          {
            vol = new Volume(dr.GetString(0), dr.GetInt32(1));

            if (!dr.IsDBNull(2)) vol.Title = dr.GetString(2);
            if (!dr.IsDBNull(3)) vol.Added = dr.GetDateTime(3);
            if (!dr.IsDBNull(4)) vol.LocalFile = dr.GetString(4);

            rval.Add(vol);
          }
        } while (dr.NextResult());

        dr.Close();
      }

      return rval;
    }

    public DataSet GetAuthors()
    {
      DataSet ds = new DataSet();

      lock (_semaphore)
      {
        if (_dadAuthor == null)
        {
          string sql =
            "SELECT author, name " +
            "FROM mse_author " +
            "WHERE author <> 'GRC' ";

          _dadAuthor = new MySqlDataAdapter(sql, _conn);
        }

        _dadAuthor.Fill(ds, "Author");
      }

      return ds;
    }

    public DataTable GetArticles(Volume vol)
    {
      if (_cmdArticles == null)
      {
        string sql =
          "SELECT page,article,scriptures,localrow " +
          "FROM mse_article " +
          "WHERE author = ?author " +
          "AND vol = ?vol " +
          "ORDER BY page DESC";

        _cmdArticles = new MySqlCommand(sql, _conn);
        _cmdArticles.Prepare();

        _cmdArticles.Parameters.Add("?author", MySqlDbType.String);
        _cmdArticles.Parameters.Add("?vol", MySqlDbType.Int32);
      }

      _cmdArticles.Parameters["?author"].Value = vol.Author;
      _cmdArticles.Parameters["?vol"].Value = vol.Vol;

      DataTable dt = new DataTable("mse_article");
      MySqlDataAdapter da = new MySqlDataAdapter(_cmdArticles);
      da.Fill(dt);
      return dt;
    }

    public DataTable GetText(Volume vol)
    {
      if (_cmdText == null)
      {
        string sql =
          "SELECT page,para,article_page,text,inits,newpages " +
          "FROM mse_text " +
          "WHERE author = ?author " +
          "AND vol = ?vol " +
          "ORDER BY page,para";

        _cmdText = new MySqlCommand(sql, _conn);
        _cmdText.Prepare();

        _cmdText.Parameters.Add("?author", MySqlDbType.String);
        _cmdText.Parameters.Add("?vol", MySqlDbType.Int32);
      }

      _cmdText.Parameters["?author"].Value = vol.Author;
      _cmdText.Parameters["?vol"].Value = vol.Vol;

      DataTable dt = new DataTable("mse_text");
      MySqlDataAdapter da = new MySqlDataAdapter(_cmdText);
      da.Fill(dt);
      return dt;
    }

    public DataTable GetBibleRefs(Volume vol)
    {
      if (_cmdBibleRef == null)
      {
        string sql =
          "SELECT page,para,ref,bookid,chapter,vstart,vend " +
          "FROM mse_bible_ref " +
          "WHERE author = ?author " +
          "AND vol = ?vol " +
          "ORDER BY page,para,ref";

        _cmdBibleRef = new MySqlCommand(sql, _conn);
        _cmdBibleRef.Prepare();

        _cmdBibleRef.Parameters.Add("?author", MySqlDbType.String);
        _cmdBibleRef.Parameters.Add("?vol", MySqlDbType.Int32);
      }

      _cmdBibleRef.Parameters["?author"].Value = vol.Author;
      _cmdBibleRef.Parameters["?vol"].Value = vol.Vol;

      DataTable dt = new DataTable("mse_bible_ref");
      MySqlDataAdapter da = new MySqlDataAdapter(_cmdBibleRef);
      da.Fill(dt);
      return dt;
    }

    public void InsertParagraph(Paragraph para)
    {
      if (_cmdInsertText == null)
      {
        string sql =
          "INSERT INTO mse_text (" +
            "author, vol, page, para, article_page, localrow, inits, text, newpages" +
          ") VALUES (" +
            "?author, ?vol, ?pageNo, ?para, ?articlePage, ?localRow, ?inits, ?text, ?newPages" +
          ")";

        _cmdInsertText = new MySqlCommand(sql, _conn);
        _cmdInsertText.Prepare();

        _cmdInsertText.Parameters.Add("?author", MySqlDbType.String);
        _cmdInsertText.Parameters.Add("?vol", MySqlDbType.Int32);
        _cmdInsertText.Parameters.Add("?pageNo", MySqlDbType.Int32);
        _cmdInsertText.Parameters.Add("?para", MySqlDbType.Int32);
        _cmdInsertText.Parameters.Add("?articlePage", MySqlDbType.Int32);
        _cmdInsertText.Parameters.Add("?localRow", MySqlDbType.Int32);
        _cmdInsertText.Parameters.Add("?inits", MySqlDbType.String);
        _cmdInsertText.Parameters.Add("?text", MySqlDbType.String);
        _cmdInsertText.Parameters.Add("?newPages", MySqlDbType.String);
      }

      _cmdInsertText.Parameters["?author"].Value = para.Volume.Author;
      _cmdInsertText.Parameters["?vol"].Value = para.Volume.Vol;
      _cmdInsertText.Parameters["?pageNo"].Value = para.PageNo;
      _cmdInsertText.Parameters["?para"].Value = para.Para;
      _cmdInsertText.Parameters["?articlePage"].Value = para.Article.PageNo;
      _cmdInsertText.Parameters["?localRow"].Value = para.LocalRow;
      _cmdInsertText.Parameters["?inits"].Value = para.Inits;
      _cmdInsertText.Parameters["?text"].Value = para.Text;

      if (para.NewPages.Length == 0)
      {
        _cmdInsertText.Parameters["?newPages"].Value = DBNull.Value;
      }
      else
      {
        _cmdInsertText.Parameters["?newPages"].Value = para.NewPages;
      }

      _cmdInsertText.ExecuteNonQuery();
    }

    public void InsertBibleRef(Paragraph paragraph, int refNo, BibleRef bref)
    {
      if (_cmdInsertBibleRef == null)
      {
        string sql =
          "INSERT INTO mse_bible_ref (" +
           "author, vol, page, para, ref, " +
            "bookid, chapter, vstart, vend" +
          ") VALUES (" +
            "?author, ?vol, ?pageNo, ?para, ?ref, " +
            "?bookId, ?chapter, ?vStart, ?vEnd" +
          ")";

        _cmdInsertBibleRef = new MySqlCommand(sql, _conn);
        _cmdInsertBibleRef.Prepare();

        _cmdInsertBibleRef.Parameters.Add("?author", MySqlDbType.String);
        _cmdInsertBibleRef.Parameters.Add("?vol", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?pageNo", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?para", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?ref", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?bookId", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?chapter", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?vStart", MySqlDbType.Int32);
        _cmdInsertBibleRef.Parameters.Add("?vEnd", MySqlDbType.Int32);
      }

      _cmdInsertBibleRef.Parameters["?author"].Value = paragraph.Volume.Author;
      _cmdInsertBibleRef.Parameters["?vol"].Value = paragraph.Volume.Vol;
      _cmdInsertBibleRef.Parameters["?pageNo"].Value = paragraph.PageNo;
      _cmdInsertBibleRef.Parameters["?para"].Value = paragraph.Para;
      _cmdInsertBibleRef.Parameters["?ref"].Value = refNo;
      _cmdInsertBibleRef.Parameters["?bookId"].Value = bref.Book.BookId;
      _cmdInsertBibleRef.Parameters["?chapter"].Value = bref.Chapter;
      _cmdInsertBibleRef.Parameters["?vStart"].Value = bref.VerseStart;
      _cmdInsertBibleRef.Parameters["?vEnd"].Value = bref.VerseEnd;

      _cmdInsertBibleRef.ExecuteNonQuery();
    }

    public void InsertBadBibleRef(Volume vol, int pageNo, int para, int refNo, char errCode, string text)
    {
      if (_cmdInsertBadBibleRef == null)
      {
        string sql =
          "INSERT INTO mse_bible_ref_error (" +
           "author, vol, page, para, ref, " +
            "error_code, text" +
          ") VALUES (" +
            "?author, ?vol, ?pageNo, ?para, ?ref, " +
            "?errCode, ?text" +
          ")";

        _cmdInsertBadBibleRef = new MySqlCommand(sql, _conn);
        _cmdInsertBadBibleRef.Prepare();

        _cmdInsertBadBibleRef.Parameters.Add("?author", MySqlDbType.String);
        _cmdInsertBadBibleRef.Parameters.Add("?vol", MySqlDbType.Int32);
        _cmdInsertBadBibleRef.Parameters.Add("?pageNo", MySqlDbType.Int32);
        _cmdInsertBadBibleRef.Parameters.Add("?para", MySqlDbType.Int32);
        _cmdInsertBadBibleRef.Parameters.Add("?ref", MySqlDbType.Int32);
        _cmdInsertBadBibleRef.Parameters.Add("?errCode", MySqlDbType.String);
        _cmdInsertBadBibleRef.Parameters.Add("?text", MySqlDbType.String);
      }

      _cmdInsertBadBibleRef.Parameters["?author"].Value = vol.Author;
      _cmdInsertBadBibleRef.Parameters["?vol"].Value = vol.Vol;
      _cmdInsertBadBibleRef.Parameters["?pageNo"].Value = pageNo;
      _cmdInsertBadBibleRef.Parameters["?para"].Value = para;
      _cmdInsertBadBibleRef.Parameters["?ref"].Value = refNo;
      _cmdInsertBadBibleRef.Parameters["?errCode"].Value = errCode;
      _cmdInsertBadBibleRef.Parameters["?text"].Value = text;

      _cmdInsertBadBibleRef.ExecuteNonQuery();
    }

    public void UpdateArticle(Article art)
    {
      string sql;

      if (art.Scriptures == null)
      {
        sql = String.Format(
          "REPLACE INTO mse_article ( " +
            "author, vol, article, localrow, page " +
          ") VALUES (" +
            "'{0}', '{1}', '{2}', '{3}', '{4}')",
          art.Volume.Author, art.Volume.Vol, DatabaseLayer.SqlText(art.Title), art.LocalRow, art.PageNo);
      }
      else
      {
        sql = String.Format(
          "UPDATE mse_article " +
          "SET scriptures = '{0}' " +
          "WHERE author = '{1}' " +
          "AND vol = '{2}' " +
          "AND localrow = '{3}'",
          DatabaseLayer.SqlText(art.Scriptures), art.Volume.Author, art.Volume.Vol, art.LocalRow);
      }

      ExecuteSql(sql);
    }

    public void TruncateTables()
    {
      this.ExecuteSql("TRUNCATE TABLE mse_article");
      this.ExecuteSql("TRUNCATE TABLE mse_text");
      this.ExecuteSql("TRUNCATE TABLE mse_bible_ref");
    }

    public void DeleteVolume(Volume vol)
    {
      this.ExecuteSql(String.Format("DELETE FROM mse_article WHERE author = '{0}' and vol = {1}", vol.Author, vol.Vol), true);
      this.ExecuteSql(String.Format("DELETE FROM mse_text WHERE author = '{0}' and vol = {1}", vol.Author, vol.Vol), true);
      this.ExecuteSql(String.Format("DELETE FROM mse_bible_ref WHERE author = '{0}' and vol = {1}", vol.Author, vol.Vol), true);
    }

    public void ExecuteSql(string sql)
    {
      ExecuteSql(sql, false);
    }

    public void ExecuteSql(string sql, bool longRunning)
    {
      MySqlCommand cmd = new MySqlCommand(sql, _conn);

      if (longRunning)
      {
        cmd.CommandTimeout = 300;
      }

      cmd.ExecuteNonQuery();
    }

    public static string SqlText(object text)
    {
      return SqlText(text.ToString(), false);
    }

    public static string SqlText(string text)
    {
      return SqlText(text, false);
    }

    public static string SqlText(string text, bool quotes)
    {
      text = text.Replace("'", "\\'");
      if (quotes)
      {
        text = String.Format("'{0}'", text);
      }
      return text;
    }

    public static bool IsInteger(string text)
    {
      if (text.Length == 0) return true;

      try
      {
        Int32.Parse(text);
      }
      catch (Exception)
      {
        return false;
      }

      return true;
    }
  }
}
