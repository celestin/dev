/* * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004-2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Feb-2010  10558 : File created.
 * CAM  23-Feb-2010  10558 : Added Get Results.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Data;
using MySql.Data.MySqlClient;

using SourceCodeMetrics.Krakatau.Kepm.Config;

namespace SourceCodeMetrics.Krakatau.Kepm.Database
{
  /// <summary>
  /// Retrieves MySQL data
  /// </summary>
  public class DatabaseLayer
  {
    private static DatabaseLayer _dbLayer;
    protected static readonly object _semaphore = new object();

    private MySqlConnection _conn;
    protected MySqlCommand _cmdResults;
    protected MySqlDataAdapter _dadResults;

    protected MySqlConnection Connection
    {
      get { return _conn; }
      set { _conn = value; }
    }

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

    public bool Open(string datasource, string database, string username, string password)
    {
      string connectionString = String.Format("Data Source={0};Database={1};User ID={2};Password={3}",
        datasource, database, username, password);

      lock (_semaphore)
      {
        try
        {
          Close();

          Connection = new MySqlConnection(connectionString);
          Connection.Open();
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
        if (Connection != null && Connection.State == ConnectionState.Open)
        {
          Connection.Close();
        }
      }
    }

    public void BuildTable(DataSet set, string tableName, MetricSet metricSet)
    {

    }

    public void GetResults(DataSet set, string tableName, MetricSet metricSet)
    {
      lock (_semaphore)
      {
        if ((_cmdResults == null) || (_cmdResults.Connection != Connection))
        {
          string sql =
            "select p.pr_name as Project, sf.sf_shortname as Filename, sf.sf_type as Lang, cf.status as Status " +
            "from sourcefile sf, comparefile cf, project p " +
            "where cf.sfid = sf.sfid " +
            "and p.projid = sf.projid ";

          _cmdResults = new MySqlCommand(sql, Connection);
          _cmdResults.Prepare();

          _dadResults = new MySqlDataAdapter();
          _dadResults.SelectCommand = _cmdResults;
        }
      }

      if (set.Tables.Contains(tableName))
      {
        set.Tables.Remove(tableName);
      }

      _dadResults.Fill(set, tableName);

      if (set.Tables.Contains(tableName))
      {
        DataTable table = set.Tables[tableName];
        if (table.PrimaryKey == null)
        {
          table.PrimaryKey = new DataColumn[] { table.Columns["Filename"] };
        }
      }
    }
  }
}
