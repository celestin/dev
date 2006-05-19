/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Database Layer
 *
 * $Id: $
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * CAM  19-Apr-06  100 : Added Contract Node.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

using Gigasoft.ProEssentials;
using frontburner.maia.Acumen.Nodes;

namespace frontburner.maia.Acumen
{
	/// <summary>
	/// DataSupplier retrieves MySQL data for use by the TreeView and graphing components.
	/// </summary>
	public class DataLayer
	{
    private static DataLayer _dl;

    private MySqlConnection _conn;

    public static DataLayer getDataLayer() 
    {
      if (_dl == null) 
      {
        _dl = new DataLayer();
      } 
      return _dl;
    }
    
    private DataLayer()
		{
      try
      {
        _conn = new MySqlConnection();
        _conn.ConnectionString = "server=127.0.0.1;uid=root;database=acumen;";
        _conn.Open();
      }
      catch (MySqlException)
      {
        //
      }
    }

    public double[] GetMinMax(int mtype) 
    {
      double[] rval = new double[2];
      string sql = "SELECT MIN(m1),MAX(m1) FROM dat " +
                   "WHERE mtype = '" + mtype.ToString() + "' ";

      MySqlCommand cmd = new MySqlCommand(sql);
      cmd.Connection = this._conn;
      MySqlDataReader r = cmd.ExecuteReader();
      if (r.Read())
      {
        rval[0] = r.GetDouble(0);
        rval[1] = r.GetDouble(1);
      }
      r.Close();
      return rval;
    }

    public void UpdateMeasurementData(ComponentNode component, Pego peg, int sets, int mtype) 
    {
      int maxPoints = 5000;
      int i=0,p=0;
      float[] fdat = new float[sets];

      MySqlCommand cmd = null;
      MySqlDataReader r = null;
      string sql = "SELECT DATE_FORMAT(mdate, '%H:%i:%S') mdatetime,m1,m2,m3,alarm " +
                  "FROM dat " +
                  "WHERE component_id = '" + component.Id + "' " +
                  "AND mtype = '" + mtype + "' " +                        
                  "ORDER BY id LIMIT " + maxPoints.ToString();

      //MessageBox.Show(sql);

      cmd = new MySqlCommand(sql);
      cmd.Connection = this._conn;
      r = cmd.ExecuteReader();
      while (r.Read())
      {
        for (i=0; i<fdat.Length; i++)
        {
          peg.PeData.Y[i, p] = (float)r.GetDouble(i+1);
        }
        peg.PeData.PointLabels[p++] = r.GetString(0);
      }
      peg.Refresh();
      r.Close();
    }

    public SensorData[] GetMeasurementData(ComponentNode component, int lastId, int mtype) 
    {
      int maxPoints = 250;
      if (component.ComponentType == ComponentTypes.SealChip) 
      {
        maxPoints = 5000;
      }

      SensorData[] rval;
      SensorData[] results = new SensorData[maxPoints];
      int index=0;

      MySqlCommand cmd = null;
      MySqlDataReader r = null;
      string sql = "SELECT id,DATE_FORMAT(mdate, '%H:%i:%S') mdatetime,m1,m2,m3,alarm " +
                   "FROM dat " +
                   "WHERE component_id = '" + component.Id + "' " +
                   "AND mtype = '" + mtype + "' ";
                           
      if ((lastId > 0) && (component.ComponentType == ComponentTypes.Wireless)) 
      {
        sql += "AND id > '" + lastId.ToString() + "' ";
      }
      sql += "ORDER BY mdate DESC LIMIT " + maxPoints.ToString();

      //MessageBox.Show(sql);

      cmd = new MySqlCommand(sql);
      cmd.Connection = this._conn;
      r = cmd.ExecuteReader();
      while (r.Read())
      {
        results[index++] = new SensorData(r.GetInt32(0), r.GetString(1), r.GetDouble(2), r.GetDouble(3), r.GetDouble(4), r.GetInt32(5));
      }

      rval = new SensorData[index];
      for (int i=0; i<index; i++)
      {
        rval[index-i-1] = results[i];
      }

      r.Close();
      return rval;
    }

    public void populateTree(TreeView trv) 
    {
      MySqlCommand cmd = new MySqlCommand();
      MySqlDataReader r;
      cmd.Connection = this._conn;

      Hashtable assets = new Hashtable();
      Hashtable schematics = new Hashtable();
      Hashtable tags = new Hashtable();
      
      TreeNode root = null;
      TreeNode parent = null;

      // Company data
      cmd.CommandText = "SELECT id,code,company FROM company";
      r = cmd.ExecuteReader();
      if (r.Read()) 
      {
        root = new CompanyNode(r.GetInt32(0), r.GetString(1), r.GetString(2));
      }
      r.Close();

      ContractNode contract = new ContractNode(0, "BPUKCS", "BP UKCS");
      root.Nodes.Add(contract);

      // Assets
      cmd.CommandText = "SELECT id,code,asset FROM asset ORDER BY asset";
      r = cmd.ExecuteReader();
      while (r.Read()) 
      {
        AssetNode n = new AssetNode(r.GetInt32(0), r.GetString(1), r.GetString(2));
        assets.Add(n.Id, n);           
        contract.Nodes.Add(n);
      }
      r.Close();

      // Schematics
      cmd.CommandText = "SELECT id,code,schematic,asset_id FROM schematic ORDER BY disporder,schematic";
      r = cmd.ExecuteReader();
      while (r.Read()) 
      {
        SchematicNode n = new SchematicNode(r.GetInt32(0), r.GetString(1), r.GetString(2));
        parent = (TreeNode) assets[r.GetInt32(3)];       

        if (parent != null)
        {
          parent.Nodes.Add(n);
          schematics.Add(n.Id, n);
        }
      }
      r.Close();

      // Tags
      cmd.CommandText = "SELECT id,code,tag,schematic_id,traffic FROM tag ORDER BY tag";
      r = cmd.ExecuteReader();
      while (r.Read()) 
      {
        AcumenNode n = new TagNode(r.GetInt32(0), r.GetString(1), r.GetString(2), r.GetInt32(4));
        parent = (TreeNode) schematics[r.GetInt32(3)];

        if (parent != null)
        {
          parent.Nodes.Add(n);
          tags.Add(n.Id, n);
        }
      }
      r.Close();

      // Components
      cmd.CommandText = "SELECT id,code,component,tag_id,ctype,physical_end FROM component ORDER BY physical_end,component";
      r = cmd.ExecuteReader();
      while (r.Read()) 
      {
        AcumenNode n = new ComponentNode(r.GetInt32(0), r.GetString(1), r.GetString(2), r.GetInt32(4), r.GetInt32(5));
        parent = (TreeNode) tags[r.GetInt32(3)];

        if (parent != null)
        {
          parent.Nodes.Add(n);
        }
      }
      r.Close();
      
      trv.Nodes.Add(root);
      root.Expand();
    }
	}
}
