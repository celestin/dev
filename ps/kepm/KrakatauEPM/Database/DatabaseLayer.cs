/* * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  19-Feb-2010  10558 : File created.
 * CAM  23-Feb-2010  10558 : Added Get Results.
 * CAM  24-Feb-2010  10558 : Implemented BuildTable with relevant columns (according to MetricSet if any).
 * CAM  27-Feb-2010  10583 : Set Churn Status using short code.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Data;
using MySql.Data.MySqlClient;

using PowerSoftware.Krakatau.Kepm.Config;
using PowerSoftware.Krakatau.Kepm.Metrics;
using PowerSoftware.Krakatau.Kepm.Results;

namespace PowerSoftware.Krakatau.Kepm.Database
{
  /// <summary>
  /// Retrieves MySQL data.
  /// </summary>
  public class DatabaseLayer
  {
    #region Static, singleton support members
    /// <summary>
    /// Singleton instance of the DatabaseLayer.
    /// </summary>
    private static DatabaseLayer _dbLayer;
    /// <summary>
    /// Semaphore to support concurrency.
    /// </summary>
    protected static readonly object _semaphore = new object();

    /// <summary>
    /// Return the single instance of the DatabaseLayer.
    /// </summary>
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
    #endregion

    #region Member Vars
    private MySqlConnection _conn;
    private MySqlCommand _cmdResults;
    #endregion

    #region Properties
    /// <summary>
    /// Encapsulated connection to enable any clever stuff.
    /// </summary>
    protected MySqlConnection Connection
    {
      get { return _conn; }
      set { _conn = value; }
    }
    #endregion

    #region Constructor & Database connection methods
    /// <summary>
    /// Private constructor - used only by static Instance property.
    /// </summary>
    private DatabaseLayer()
    {
    }

    /// <summary>
    /// Open a database connection.
    /// </summary>
    /// <param name="datasource">The Server - usually localhost.</param>
    /// <param name="database">The Project Database name.</param>
    /// <param name="username">root by default.</param>
    /// <param name="password">empty by default.</param>
    /// <returns></returns>
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

    /// <summary>
    /// Close any open database connection.
    /// </summary>
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
    #endregion

    #region Database access
    /// <summary>
    /// Build a suitable collection of valid Metrics based on the selected MetricSet.
    /// <remarks>An empty MetricSet will result in all metrics being added, with the exception of Project
    /// level metrics which are always omitted.</remarks>
    /// </summary>
    /// <param name="metricSet">Selected MetricSet, acting as a filter on the columns to be displayed.</param>
    /// <returns></returns>
    protected MetricCollection ChooseMetrics(MetricSet metricSet)
    {
      MetricCollection rval = new MetricCollection();

      foreach (Metric m in KrakatauSettings.Settings.Metrics)
      {
        bool include = false;
        if (m.Level == MetricLevel.Project)
        {
          include = false;
        }
        else if (metricSet == null)
        {
          include = true;
        }
        else
        {
          include = metricSet.Contains(m);
        }

        if (include)
        {
          rval.Add(m);
        }
      }

      return rval;
    }

    /// <summary>
    /// Create the DataTable with appropriate columns based on the MetricsCollection that has been prepared.
    /// </summary>
    /// <param name="set">DataSet used to hold the table.</param>
    /// <param name="tableName">Desired name for the results table.</param>
    /// <param name="metrics">Collection of metrics to be included in the table.</param>
    /// <returns></returns>
    public DataTable BuildTable(DataSet set, string tableName, MetricCollection metrics)
    {
      if (set.Tables.Contains(tableName))
      {
        set.Tables.Remove(tableName);
      }

      DataTable table = set.Tables.Add(tableName);
      Type typeString = Type.GetType("System.String");
      Type typeLong = Type.GetType("System.Int32");
      Type typeDouble = Type.GetType("System.Double");
      DataColumn col = table.Columns.Add("Project", typeString);
      col = table.Columns.Add("Filename", typeString);
      col = table.Columns.Add("Lang", typeString);
      col = table.Columns.Add("Status", typeString);

      foreach (Metric m in metrics)
      {
        col = table.Columns.Add(m.Code, typeDouble);
      }

      return table;
    }

    /// <summary>
    /// Retrieve the results from the database, building a crosstab with key Sourcefile attributes followed by all the
    /// metrics in the selected MetricSet (if any).
    /// </summary>
    /// <param name="set">DataSet into which the results should be added.</param>
    /// <param name="tableName"></param>
    /// <param name="tableName">Desired name for the results table.</param>
    /// <param name="metricSet">Selected MetricSet to use as a filter (may be null to include all metrics).</param>
    public void GetResults(DataSet set, string tableName, MetricSet metricSet)
    {
      lock (_semaphore)
      {
        if ((_cmdResults == null) || (_cmdResults.Connection != Connection))
        {
          string sql =
            "SELECT sf.sfid, p.pr_name, sf.sf_shortname, sf.sf_type, cf.status, sm.mid, sm.mvalue " +
            "FROM sourcefile sf, comparefile cf, project p, sourcemetric sm " +
            "WHERE cf.sfid = sf.sfid " +
            "AND p.projid = sf.projid " +
            "AND sm.sfid = sf.sfid " +
            "AND sm.mvalue <> 0 " +
            "ORDER BY sf.sfid, sm.mid";

          _cmdResults = new MySqlCommand(sql, Connection);
          _cmdResults.Prepare();
        }
      }

      MetricCollection metrics = ChooseMetrics(metricSet);
      DataTable table = BuildTable(set, tableName, metrics);

      MySqlDataReader dr = _cmdResults.ExecuteReader();
      DataRow row = null;
      long id;
      long prevousId = -1;
      long mid = 0;
      Metric m = null;

      while (dr.Read())
      {
        id = long.Parse(dr["sfid"].ToString());

        if (id != prevousId)
        {
          row = table.NewRow();
          table.Rows.Add(row);

          row["Project"] = dr["pr_name"].ToString();
          row["Filename"] = dr["sf_shortname"].ToString();
          row["Lang"] = dr["sf_type"].ToString();
          row["Status"] = ChurnStatuses.GetShortCode(dr["status"].ToString());
        }

        mid = long.Parse(dr["mid"].ToString());
        if (metrics.Contains(mid))
        {
          m = metrics[mid];

          if (table.Columns.Contains(m.Code))
          {
            row[m.Code] = double.Parse(dr["mvalue"].ToString());
          }
        }

        prevousId = id;
      }
    }
    #endregion
  }
}
