/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-May-2013  11172 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;

using System.Data;
using System.Data.OleDb;
using System.Data.OracleClient;


namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data
{
  public class ValidateDatalayer
  {
    #region Singleton Members
    private static ValidateDatalayer _layer;
    private string _insertSql;

    public static ValidateDatalayer Instance
    {
      get
      {
        if (_layer == null) _layer = new ValidateDatalayer();
        return _layer;
      }
    }
    #endregion

    #region ValidateLayer Members
    private OleDbConnection _con;


    public OleDbConnection Connection
    {
      get { return _con; }
    }
    private ValidateDatalayer()
    {
      _con = new OleDbConnection();
    }

    public bool Open(FileInfo accessFile)
    {
      if (!accessFile.Exists) return false;

      try
      {
        if (Connection.State != System.Data.ConnectionState.Open)
        {
          Connection.ConnectionString = String.Format("Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};User Id=admin;Password=;", accessFile.FullName);
          Connection.Open();
        }
      }
      catch (OleDbException oe)
      {
        MessageBox.Show(oe.Message);
        return false;
      }

      return true;
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
          "WHERE ObjectSource='MAX' AND ExtractSql IS NOT NULL", Connection);
        OleDbDataReader reader = cmd.ExecuteReader();
        if (reader.Read())
        {
          tspExtract.Maximum = int.Parse(reader[0].ToString());
        }
        reader.Close();

        cmd = new OleDbCommand(
          "SELECT ObjectName,ExtractSql,KeyColumns FROM [Object] " +
          "WHERE ObjectSource='MAX' AND ExtractSql IS NOT NULL", Connection);
        reader = cmd.ExecuteReader();

        // Iterate through the DataReader and display row
        while (reader.Read())
        {
          tspExtract.Increment(1);

          tableName = reader[0].ToString();
          extractSql = reader[1].ToString();
          keyColumns = reader[2].ToString();

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
                columns[i] = string.Format("'{0}'", oraRdr.GetValue(i).ToString());
              }
              i++;
            }

            using (OleDbCommand cmd2 = AccessDatalayer.Instance.Connection.CreateCommand())
            {
              cmd2.CommandType = CommandType.Text;
              cmd2.CommandText = String.Format(_insertSql, String.Join(",", columns));
              cmd2.ExecuteNonQuery();
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
      catch (OleDbException oe)
      {
        MessageBox.Show(oe.Message);
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
        columns[i++] = dr["ColumnName"].ToString();
      }
      _insertSql = String.Format("INSERT INTO {0} ({1}) {2}", tableName, String.Join(",", columns), "VALUES ({0})");
    }
    #endregion
  }
}
