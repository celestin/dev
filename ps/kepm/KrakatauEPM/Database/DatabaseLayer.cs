/* * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Feb-2010  10558 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace SourceCodeMetrics.Krakatau.Kepm.Database
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

    public bool Open(string datasource, string database, string userid, string password)
    {
      string DataSource = "localhost";
      string Database = "goodteaching_org_min";
      string UserID = "goodteaching";
      string Password = "psalm45";

      string MyConString = "Data Source=" + DataSource +
          ";Database=" + Database +
          ";User ID=" + UserID +
          ";Password=" + Password;

      lock (_semaphore)
      {
        try
        {
          Close();

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

    public void GetBibleVersions()
    {
      //String sql;
      //MySqlDataReader dr;
      //BibleVersionCollection versions = new BibleVersionCollection();

      //sql = "SELECT verid, vercode, versionname " +
      //      "FROM mse_bible_version ";

      //lock (_semaphore)
      //{
      //  if (_cmdVersions == null)
      //  {
      //    _cmdVersions = new MySqlCommand(sql, _conn);
      //  }
      //  dr = _cmdVersions.ExecuteReader();
      //}

      //do
      //{
      //  while (dr.Read())
      //  {
      //    versions.Add(new BibleVersion(dr.GetInt32(0), dr.GetString(1), dr.GetString(2)));
      //  }
      //} while (dr.NextResult());

      //dr.Close();

      //return versions;
    }
  }
}
