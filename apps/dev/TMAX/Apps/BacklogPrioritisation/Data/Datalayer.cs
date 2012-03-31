/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Backlog Prioritisation
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  31-Mar-2012  11104 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.Data.OleDb;
using System.Windows.Forms;

namespace FrontBurner.Tmax.Apps.BacklogPrioritisation.Data
{
  public class Datalayer
  {
    public Datalayer()
    {
    }

    public void TestConnection()
    {
      OleDbConnection conn = new OleDbConnection();
      conn.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;" +
        @"Data Source=.\Data\BacklogPrioritisation.mdb;Persist Security Info=True";

      try
      {
        conn.Open();

        string strSQL = "SELECT * FROM V_Progress";
        OleDbCommand cmd = new OleDbCommand(strSQL, conn);
        OleDbDataReader dr = null;
        try
        {
          dr = cmd.ExecuteReader();
          while (dr.Read() == true)
          {
            //MessageBox.Show(dr["AssessmentStatus"].ToString());
          }
        }
        catch (Exception e)
        {
        }
        finally
        {
          dr.Close();
        }
      }
      catch (Exception ex)
      {
        MessageBox.Show(ex.ToString());
      }
      finally
      {
        conn.Close();
      }
    }
  }
}
