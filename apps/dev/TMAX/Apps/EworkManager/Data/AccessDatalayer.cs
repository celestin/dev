/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Ework Manager
 * Copyright (c) 2013 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Oct-2013  11181 : Created.
 * CAM  18-May-2013  11181 : Renamed Connection for consistency.
 * CAM  28-Oct-2013  11181 : Improved MSAccess connection handling.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;

using System.Data;
using System.Data.OleDb;
using System.Data.OracleClient;


namespace FrontBurner.Tmax.Apps.EworkManager.Data
{
  public class AccessDatalayer
  {
    #region Singleton Members
    private static AccessDatalayer _layer;
    public static AccessDatalayer Instance
    {
      get
      {
        if (_layer == null) _layer = new AccessDatalayer();
        return _layer;
      }
    }
    #endregion

    #region AccessDatalayer Members
    private OleDbConnection _con;

    public OleDbConnection Connection
    {
      get { return _con; }
    }
    private AccessDatalayer()
    {
      _con = new OleDbConnection();
    }

    public EcrState Open(FileInfo accessFile)
    {
      if (!accessFile.Exists) return EcrState.Invalid;

      try
      {
        if (Connection.State != System.Data.ConnectionState.Open)
        {
          Connection.ConnectionString = String.Format("Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};User Id=admin;Password=;", accessFile.FullName);
          Connection.Open();
          // \HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Jet\4.0\Engines\Jet 3.x\MaxBufferSize
          // http://support.microsoft.com/default.aspx?scid=kb;en-us;248014
        }

        // Create and execute the query
        OleDbCommand cmd = new OleDbCommand("Select count(*) From EworkItem", Connection);
        OleDbDataReader reader = cmd.ExecuteReader();

        // Iterate through the DataReader and display row
        if (reader.Read())
        {
        }
      }
      catch (OleDbException oe)
      {
        MessageBox.Show(oe.Message);
        return EcrState.Invalid;
      }

      return EcrState.OK;
    }

    public EcrState Close()
    {
      try
      {
        if (Connection.State == System.Data.ConnectionState.Open)
        {
          Connection.Close();
         }
      }
      catch (OleDbException oe)
      {
        MessageBox.Show(oe.Message);
        return EcrState.Invalid;
      }

      return EcrState.OK;
    }   
    
    #endregion

    #region Snapshot
    private string _insertSql;

    private int _maximumRows;
    private int _currentRow;
    private string _currentTableName;

    public int MaximumRows
    {
      get { return _maximumRows; }
      set { _maximumRows = value; }
    }
    public int CurrentRow
    {
      get { return _currentRow; }
      set { _currentRow = value; }
    }
    public string CurrentTableName
    {
      get { return _currentTableName; }
      set { _currentTableName = value; }
    }

    public void TakeSnapshot()
    {
      OracleCommand oraCmd;
      OracleDataReader oraRdr;

      OleDbCommand cmd;
      OleDbDataReader reader;
      Queries qs = new Queries();
      qs.Add(new EWorkStatusQuery());
      qs.Add(new EWorkEventQuery());
      qs.Add(new EWorkAlertQuery());

      MaximumRows = CurrentRow = 0;
      CurrentTableName = "";

      foreach (Query q in qs)
      {
        CurrentTableName = "Counting " + q.TableName;

        oraCmd = new OracleCommand(q.CountSql, OracleDatalayer.Instance.Connection);

        oraRdr = oraCmd.ExecuteReader();
        if (oraRdr.Read())
        {
          MaximumRows += int.Parse(oraRdr[0].ToString());
        }
        oraRdr.Close();
      }



      CurrentRow = 0;

      foreach (Query q in qs)
      {
        CurrentTableName = "Retrieving " + q.TableName;

        oraCmd = new OracleCommand(q.DataSql, OracleDatalayer.Instance.Connection);

        oraRdr = oraCmd.ExecuteReader();
        while (oraRdr.Read())
        {
          CurrentRow++;
        }
        oraRdr.Close();
      }
    }

    public void Extract(ToolStripLabel tslStatus, ToolStripProgressBar tspExtract)
    {
      string tableName = null;
      string extractSql = null;
      string keyColumns = null;

      tslStatus.Text = "Extract started.";

      try
      {
        OleDbCommand cmd = new OleDbCommand(
          "SELECT count(*) FROM [Object] " +
          "WHERE ObjectSource='MAX' " +
          "AND ExtractSql IS NOT NULL " +
          "AND Active = True", Connection);
        OleDbDataReader reader = cmd.ExecuteReader();
        if (reader.Read())
        {
          tspExtract.Maximum = int.Parse(reader[0].ToString());
        }
        reader.Close();

        cmd = new OleDbCommand(
          "SELECT ObjectName,ExtractSql,KeyColumns FROM [Object] " +
          "WHERE ObjectSource='MAX' " +
          "AND ExtractSql IS NOT NULL " +
          "AND Active = True " +
          "ORDER BY ObjectName", Connection);
        reader = cmd.ExecuteReader();

        // Iterate through the DataReader and display row
        while (reader.Read())
        {
          tspExtract.Increment(1);

          tableName = reader[0].ToString();
          extractSql = reader[1].ToString();
          keyColumns = reader[2].ToString();

          tslStatus.Text = String.Format("Extracting table {0} ({1} of {2})", tableName, tspExtract.Value, tspExtract.Maximum);

          OracleCommand oraCmd = new OracleCommand(extractSql, OracleDatalayer.Instance.Connection);
          OracleDataReader oraRdr = oraCmd.ExecuteReader();
          DataTable schemaTable = oraRdr.GetSchemaTable();

          CreateTableFromReader(tableName, schemaTable, keyColumns); // Create the new table, and its primary key
          CreateInsertSql(tableName, schemaTable);  // Prepare the INSERT SQL that will be used for each row

          while (oraRdr.Read())
          {
            string[] columns = new string[schemaTable.Rows.Count];
            int i = 0;

            foreach (DataRow dr in schemaTable.Rows)
            {
              if (oraRdr.IsDBNull(i))
              {
                columns[i] = "NULL";
              }
              else
              {
                string sqlSafeValue = oraRdr.GetValue(i).ToString();
                sqlSafeValue = sqlSafeValue.Replace("'", "''");
                columns[i] = string.Format("'{0}'", sqlSafeValue);
              }
              i++;
            }

            using (OleDbCommand cmd2 = AccessDatalayer.Instance.Connection.CreateCommand())
            {
              try
              {
                cmd2.CommandType = CommandType.Text;
                cmd2.CommandText = String.Format(_insertSql, String.Join(",", columns));
                cmd2.ExecuteNonQuery();
              }
              catch (Exception exc)
              {
                MessageBox.Show(exc.Message + "\n" + cmd2.CommandText, "Error Inserting to Access", MessageBoxButtons.OK, MessageBoxIcon.Error);
              }
            }
          }

          oraRdr.Close();
          oraRdr.Dispose();
          oraCmd.Dispose();
        }

        reader.Close();
        cmd.Dispose();

        tslStatus.Text = "Extract complete.";

      }
      catch (Exception exc)
      {
        MessageBox.Show(exc.Message + "\n" + extractSql, "Error Extracting Data", MessageBoxButtons.OK, MessageBoxIcon.Error);
      }
    }

    private void CreateTableFromReader(string tableName, DataTable schemaTable, string keyColumns)
    {
      string[] columns = new string[schemaTable.Rows.Count];
      int i = 0;

      foreach (DataRow dr in schemaTable.Rows)
      {
        string dataType = dr["DataType"].ToString().ToLower();
        switch (dataType)
        {
          case "system.string":
            columns[i++] = String.Format("[{0}] TEXT({1})",
              dr["ColumnName"],
              dr["ColumnSize"]
            );
            break;
          case "system.datetime":
            columns[i++] = String.Format("[{0}] DATE",
              dr["ColumnName"]
              );
            break;
          default:
            columns[i++] = String.Format("[{0}] NUMBER",
              dr["ColumnName"]
            );
            break;
        }
      }

      using (OleDbCommand cmd = AccessDatalayer.Instance.Connection.CreateCommand())
      {
        cmd.CommandType = CommandType.Text;

        try
        {
          cmd.CommandText = String.Format("DROP TABLE {0}", tableName);
          cmd.ExecuteNonQuery();
        }
        catch
        {
        }

        cmd.CommandText = String.Format("CREATE TABLE {0} ({1})", tableName, String.Join(",", columns));
        cmd.ExecuteNonQuery();

        cmd.CommandText = String.Format("CREATE UNIQUE INDEX [PrimaryKey] ON {0} ({1}) WITH PRIMARY", tableName, keyColumns);
        cmd.ExecuteNonQuery();
      }
    }
    private void CreateInsertSql(string tableName, DataTable schemaTable)
    {
      string[] columns = new string[schemaTable.Rows.Count];
      int i = 0;

      i = 0;
      foreach (DataRow dr in schemaTable.Rows)
      {
        columns[i++] = "[" + dr["ColumnName"].ToString() + "]";
      }
      _insertSql = String.Format("INSERT INTO {0} ({1}) {2}", tableName, String.Join(",", columns), "VALUES ({0})");
    }


    #endregion
  }
}
