/* * * * * * * * * * * * * * * * * * * * * * * *
 * Ministry Search Engine Data Builder
 * Copyright (c) 2007 Front Burner
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  22-Sep-2007  File added to source control.
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

    protected MySqlDataAdapter _dadAuthor;

    protected BibleBookCollection _books;

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
      string Database = " southesk_com_-_min";
      string UserID     = "southesk";
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
      if (_books == null)
      {
        String sql;
        MySqlDataReader dr;
        BibleBook book;
        _books = new BibleBookCollection();

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

            _books.Add(book);
          }
        } while (dr.NextResult());

        dr.Close();
      }

      return _books;
    }

    public VolumeCollection GetVolumes()
    {
      String sql;
      MySqlDataReader dr;
      Volume vol;
      VolumeCollection rval = new VolumeCollection();

      sql = "SELECT author,vol,title,added,localfile " +
            "FROM mse_volume ";

      lock (_semaphore)
      {
        if (_cmdVolume == null)
        {
          _cmdVolume = new MySqlCommand(sql, _conn);
        }
        dr = _cmdVolume.ExecuteReader();
      }

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

      return rval;
    }

    /*
    public void GetStateDefinition(Instrument instrument, Sensor sensor)
    {
      String sql;
      SqlDataReader dr;
      StateDefinition sd;
      StateSequence ss;

      lock (_semaphore)
      {
        if (_cmdStateDefinition == null)
        {
          sql =
            "SELECT state_id, hysteresis " +
            "FROM tbl_sensor_state " +
            "WHERE instrument_id = @fieldUnitSerial " +
            "AND sensor_id = @sensorId ";

          _cmdStateDefinition = new SqlCommand(sql, _conn);
          _cmdStateDefinition.Parameters.Add(new SqlParameter("@fieldUnitSerial", SqlDbType.Int, 0));
          _cmdStateDefinition.Parameters.Add(new SqlParameter("@sensorId", SqlDbType.Int, 0));
          _cmdStateDefinition.Prepare();
        }

        _cmdStateDefinition.Parameters[0].Value = instrument.InstrumentId;
        _cmdStateDefinition.Parameters[1].Value = sensor.SensorId;

        dr = _cmdStateDefinition.ExecuteReader();
      }

      do
      {
        while (dr.Read())
        {
          sd = new StateDefinition(dr.GetGuid(0));
          if (!dr.IsDBNull(1)) sd.Hysteresis = dr.GetDouble(1);
          sensor.Add(sd);
        }
      } while (dr.NextResult());
      dr.Close();

      lock (_semaphore)
      {
        if (_cmdStateSequence == null)
        {
          sql =
            "SELECT sq.state_id, sq.state_seq, sq.state_level, sq.state_code, sq.state_description, sq.upper_limit " +
            "FROM tbl_sensor_state_seq sq, tbl_sensor_state ss " +
            "WHERE sq.state_id = ss.state_id " +
            "AND ss.instrument_id = @fieldUnitSerial " +
            "AND ss.sensor_id = @sensorId ";

          _cmdStateSequence = new SqlCommand(sql, _conn);
          _cmdStateSequence.Parameters.Add(new SqlParameter("@fieldUnitSerial", SqlDbType.Int, 0));
          _cmdStateSequence.Parameters.Add(new SqlParameter("@sensorId", SqlDbType.Int, 0));
          _cmdStateSequence.Prepare();
        }

        _cmdStateSequence.Parameters[0].Value = instrument.InstrumentId;
        _cmdStateSequence.Parameters[1].Value = sensor.SensorId;

        dr = _cmdStateSequence.ExecuteReader();
      }

      do
      {
        while (dr.Read())
        {
          sd = sensor[dr.GetGuid(0)];
          if (sd != null)
          {
            ss = new StateSequence();
            ss.Sequence = dr.GetInt16(1);
            ss.Level = (StateLevel)dr.GetByte(2);
            ss.Code = dr.GetString(3);

            if (!dr.IsDBNull(4)) ss.Description = dr.GetString(4);
            if (!dr.IsDBNull(5)) ss.UpperLimit = dr.GetDouble(5);

            sd.Add(ss);
          }
        }
      } while (dr.NextResult());
      dr.Close();
    }
    */

    public DataSet GetAuthors()
    {
      DataSet ds = new DataSet();

      lock (_semaphore)
      {
        if (_dadAuthor == null)
        {
          string sql =
            "SELECT author, name " +
            "FROM mse_author";

          _dadAuthor = new MySqlDataAdapter(sql, _conn);
        }

        _dadAuthor.Fill(ds, "Author");
      }

      return ds;
    }

    public void DeleteVolume(Volume vol)
    {
      this.ExecuteSql(String.Format("DELETE FROM mse_article WHERE author = '{0}' and vol = {1}", vol.Author, vol.Vol));
      this.ExecuteSql(String.Format("DELETE FROM mse_text WHERE author = '{0}' and vol = {1}", vol.Author, vol.Vol));
      this.ExecuteSql(String.Format("DELETE FROM mse_bible_ref WHERE author = '{0}' and vol = {1}", vol.Author, vol.Vol));
    }

    public void ExecuteSql(string sql)
    {
      MySqlCommand cmd = new MySqlCommand(sql, _conn);
      cmd.ExecuteNonQuery();
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
