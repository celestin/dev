/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-May-2013  11172 : Created.
 * CAM  28-Oct-2013  11172 : Added Progress handling.
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
        MessageBox.Show(oe.Message + "\n" + oe.InnerException, "Error Opening Access Database", MessageBoxButtons.OK, MessageBoxIcon.Error);
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

          extractSql = extractSql.Replace("{SITECODE}", Config.Instance.SiteCode);
          extractSql = extractSql.Replace("{ROOTCODE}", Config.Instance.RootCode);

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

    public void LongDescriptionCheck()
    {
      string prevTableName = null;  
      long ldkey = 0;
      string sql = null;
      OracleCommand oraCmd = null;
      OracleDataReader oraRdr = null;
      OracleParameter ldkeyParam = null;

      CurrentRow = 0;

      try
      {
        OracleCommand oraCmdLd = new OracleCommand("Select count(*) From LongDescription", OracleDatalayer.Instance.Connection);
        OracleDataReader oraRdrLd = oraCmdLd.ExecuteReader();
        if (oraRdrLd.Read())
        {
          MaximumRows = int.Parse(oraRdrLd[0].ToString());
        }
        oraRdrLd.Close();

        oraCmdLd = new OracleCommand("Select LdOwnertable, Ldkey From LongDescription Order By LdOwnertable", OracleDatalayer.Instance.Connection);
        oraRdrLd = oraCmdLd.ExecuteReader();

        // Iterate through the DataReader and display row
        while (oraRdrLd.Read())
        {
          CurrentRow++;

          CurrentTableName = oraRdrLd[0].ToString();
          ldkey = long.Parse(oraRdrLd[1].ToString());

          if (CurrentTableName != prevTableName)
          {
            // New prepared statement
            sql = String.Format("SELECT count(*) FROM {0} WHERE ldkey= :ldkey", CurrentTableName);
            oraCmd = new OracleCommand(sql, OracleDatalayer.Instance.Connection);
            ldkeyParam = oraCmd.Parameters.Add(":ldkey", OracleType.Int32);
            oraCmd.Prepare();
          }

          ldkeyParam.Value = ldkey;
          oraRdr = oraCmd.ExecuteReader();
          if (oraRdr.Read())
          {
            if (int.Parse(oraRdr[0].ToString()) == 0)
            {
              MessageBox.Show("No rows for " + sql);
            }
          }

          oraRdr.Close();
          oraRdr.Dispose();
          prevTableName = CurrentTableName;
        }

        oraRdrLd.Close();
        oraCmdLd.Dispose();
      }
      catch (Exception exc)
      {
        MessageBox.Show(exc.Message + "\n" + sql, "Error Extracting Data", MessageBoxButtons.OK, MessageBoxIcon.Error);
      }
    }

    #endregion
  }
}
