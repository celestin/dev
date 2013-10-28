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

using FrontBurner.Tmax.Apps.EworkManager.Process;

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
      DataTable schemaTable;

      int postWeight = 200;

      Queries qs = new Queries();
      qs.Add(new EWorkStatusQuery());
      qs.Add(new EWorkEventQuery());
      qs.Add(new EWorkAlertQuery());

      List<string> post = new List<string>();
      post.Add("[00 Delete removed Ework]");
      post.Add("[01 Update changed Ework]");
      post.Add("[02 Append new Ework]");
      post.Add("[03 Create new Snapshot]");
      post.Add("[04 Copy Snapshot]");
      post.Add("[05a Delete Unrelated Alerts]");
      //post.Add("[05b Delete Alerts for Non AD Users]");
      post.Add("[05c Delete Alerts for Disabled AD Users]");

      MaximumRows = (post.Count * postWeight);
      CurrentRow = 0;
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

      foreach (Query q in qs)
      {
        CurrentTableName = "Truncating " + q.TableName;

        cmd = new OleDbCommand(q.TruncateSql, Connection);
        cmd.ExecuteNonQuery();
      }

      CurrentRow = 0;

      foreach (Query q in qs)
      {
        CurrentTableName = "Retrieving " + q.TableName;

        oraCmd = new OracleCommand(q.DataSql, OracleDatalayer.Instance.Connection);
        oraRdr = oraCmd.ExecuteReader();
        schemaTable = oraRdr.GetSchemaTable();
        CreateInsertSql(q.TableName, schemaTable);  // Prepare the INSERT SQL that will be used for each row

        while (oraRdr.Read())
        {
          CurrentRow++;

          #region Insert into MS-Access

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
          #endregion
        }
        oraRdr.Close();
      }

      foreach (string q in post)
      {
        CurrentRow += postWeight;
        CurrentTableName = "Running housekeeping " + q;

        cmd = new OleDbCommand(q, Connection);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.ExecuteNonQuery();
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

    #region Email
    public void EmailAssignments(EmailHelper email)
    {
      string prevEmailTo="";
      string emailTo;
      string firstName;
      string wmsPriority;
      string wmsCategory;
      string siteId;
      string folderName;
      string description;
      string wmsComments;
      double wmsEffort;
      long efolderId;
 
      using (OleDbCommand cmd = AccessDatalayer.Instance.Connection.CreateCommand())
      {
        cmd.CommandType = CommandType.Text;
        cmd.CommandText = "SELECT Person.Email, Person.Firstname, EworkItem.WmsPriority, EworkItem.WmsCategory, " +
          "EworkItem.SiteId, EworkItem.FolderName, EworkItem.Description, EworkItem.WmsComments, " +
          "EworkItem.WmsEffort, EworkItem.EfolderId " +
          "FROM Person INNER JOIN EworkItem ON Person.PersonId = EworkItem.WmsAssignedTo " +
          "WHERE (((Person.WmsCore)=True) AND ((EworkItem.EworkStatus)=\"06 WMS Team for Action\")) " +
          "ORDER BY Person.Email, EworkItem.WmsPriority, EworkItem.WmsCategory ";
        OleDbDataReader reader = cmd.ExecuteReader();
        while (reader.Read())
        {
          emailTo = ""; if (!reader.IsDBNull(0)) emailTo = reader.GetString(0);
          firstName = ""; if (!reader.IsDBNull(1)) firstName = reader.GetString(1);
          wmsPriority = ""; if (!reader.IsDBNull(2)) wmsPriority = reader.GetString(2); 
          wmsCategory = ""; if (!reader.IsDBNull(3)) wmsCategory = reader.GetString(3); 
          siteId = ""; if (!reader.IsDBNull(4)) siteId = reader.GetString(4); 
          folderName = ""; if (!reader.IsDBNull(5)) folderName = reader.GetString(5);
          description = ""; if (!reader.IsDBNull(6)) description = reader.GetString(6);
          wmsComments = ""; if (!reader.IsDBNull(7)) wmsComments = reader.GetString(7); 
          wmsEffort = 0; if (!reader.IsDBNull(8)) wmsEffort = double.Parse(reader.GetValue(8).ToString());
          efolderId = 0; if (!reader.IsDBNull(9)) efolderId = long.Parse(reader.GetValue(9).ToString()); 
          
          if (prevEmailTo != emailTo)
          {
            if (prevEmailTo.Length > 0) email.SendAssignments();
            email.PrepareAssignments(emailTo, firstName);
          }

          email.AddAssignment(efolderId, folderName, wmsPriority, wmsCategory, siteId, description, wmsComments, wmsEffort);

          prevEmailTo = emailTo;
        }

        email.SendAssignments();
      }
    }
    #endregion
  }
}
