/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Backlog Prioritisation
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  31-Mar-2012  11104 : Created.
 * CAM  29-Dec-2012  11104 : Added Priority Summary.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.OleDb;
using System.Windows.Forms;

namespace FrontBurner.Tmax.Apps.BacklogPrioritisation.Data
{
  public class Datalayer
  {
    private static Datalayer _instance;
    private OleDbConnection _conn;
    private string _site;

    private Datalayer()
    {
    }

    public static Datalayer Instance
    {
      get
      {
        if (_instance == null) _instance = new Datalayer();
        return _instance;
      }
    }

    public string Site
    {
      get
      {
        if (_site == null) GetConfig();
        return _site;
      }
    }

    protected void GetConfig()
    {
      string sSQL = "SELECT Site FROM Config";
      OleDbCommand cmd = new OleDbCommand(sSQL, _conn);
      OleDbDataReader dr = null;

      dr = cmd.ExecuteReader();
      if (dr.Read())
      {
        _site = dr["Site"].ToString();
      }

      dr.Close();
      dr.Dispose();
      cmd.Dispose();
    }

    public void Open()
    {
      _conn = new OleDbConnection();
      _conn.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;" +
        @"Data Source=.\Data\BacklogPrioritisation.mdb;Persist Security Info=True";

      try
      {
        _conn.Open();
      }
      catch (Exception ex)
      {
        MessageBox.Show(ex.ToString());
      }
    }

    public DataSet GetProgressSummary()
    {
      string sSQL = "SELECT * FROM V_Progress";
      OleDbCommand cmd = new OleDbCommand(sSQL, _conn);
      OleDbDataAdapter da = new OleDbDataAdapter(cmd);
      DataSet ds = new DataSet();
      da.Fill(ds, "Progress");

      cmd.Dispose();
      da.Dispose();
      return ds;
    }

    public DataSet GetPrioritySummary(AssessmentStatus status)
    {
      string sSQL = "SELECT WOPriority, WoCount " +
        "FROM V_Priority " +
        "WHERE AssessmentStatus='" + AssessmentStatuses.GetStatusCode(status) + "'";
      OleDbCommand cmd = new OleDbCommand(sSQL, _conn);
      OleDbDataAdapter da = new OleDbDataAdapter(cmd);
      DataSet ds = new DataSet();
      da.Fill(ds, "Priority");

      cmd.Dispose();
      da.Dispose();
      return ds;
    }
  }
}
