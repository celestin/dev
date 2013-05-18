/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Dec-2012  11149 : Created.
 * CAM  18-May-2013  11172 : Renamed Connection for consistency.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;

using System.Data;
using System.Data.OleDb;

using FrontBurner.Tmax.Apps.MaintenanceBuildReview.Tree;

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data
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

    public bool Open(FileInfo accessFile)
    {
      if (!accessFile.Exists) return false;

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
        OleDbCommand cmd = new OleDbCommand("Select RootCode,RootDescription From MBR_CONFIG", Connection);
        OleDbDataReader reader = cmd.ExecuteReader();

        // Iterate through the DataReader and display row
        if (reader.Read())
        {
          Config cfg = Config.Instance;
          cfg.RootCode = reader[0].ToString();
          cfg.RootDescription = reader[1].ToString();
          cfg.ReviewDataActive = true;
        }
      }
      catch (OleDbException oe)
      {
        MessageBox.Show(oe.Message);
        return false;
      }

      return true;
    }
    public LocationCollection GetLocations()
    {
      LocationCollection rval = new LocationCollection();

      if (Connection.State != System.Data.ConnectionState.Open) return rval;

      try
      {
        // Create and execute the query
        OleDbCommand cmd = new OleDbCommand(
          "SELECT r.LOCATION, IIf(IsNull([m].[location]),'Create',[r].[LocationActionReqd]) AS LocationActionReqd, "+
          "m.DESCRIPTION, r.Description, "+
          "m.PARENT, r.ParentLocation, "+
          "m.SCE, r.SCE, "+
          "m.ECE, r.ECE, "+
          "m.PCE, r.PCE "+
          "FROM MAX_LOCATIONS AS m RIGHT JOIN MBC_Location AS r ON m.LOCATION = r.LOCATION", Connection);
        OleDbDataReader reader = cmd.ExecuteReader();

        // Iterate through the DataReader and display row
        while (reader.Read())
        {
          int i = 0;
          Location loc = new Location(reader[i++].ToString());
          loc.ActionStatus = ActionStatuses.GetActionStatus(reader[i++].ToString());
          loc.Description = new Changeable(reader[i++].ToString(), reader[i++].ToString());
          loc.Parent = new Changeable(reader[i++].ToString(), reader[i++].ToString());
          rval.Add(loc);
        }

        reader.Close();
        cmd.Dispose();
      }
      catch (OleDbException oe)
      {
        MessageBox.Show(oe.Message);        
      }

      return rval;
    }

    
    //public void GetChildren(LocNode loc)
    //{
    //  if (Con.State != System.Data.ConnectionState.Open) return;

    //  try
    //  {
    //    // Create and execute the query
    //    OleDbCommand cmd = new OleDbCommand(String.Format(
    //      "Select Location,Description,SCE,ECE,PCE,Failurecode " +
    //      "From ODL_Location " +
    //      "Where ParentLocation='{0}' " +
    //      "Order By Location", loc.Code), Con);
    //    OleDbDataReader reader = cmd.ExecuteReader();

    //    // Iterate through the DataReader and display row
    //    while (reader.Read())
    //    {
    //      LocNode child = new LocNode(reader[0].ToString(), reader[1].ToString());
    //      loc.Nodes.Add(child);
    //    }

    //    reader.Close();
    //    cmd.Dispose();
    //  }
    //  catch (OleDbException oe)
    //  {
    //    MessageBox.Show(oe.Message);
    //  }
    //}
    
    #endregion
  }
}
