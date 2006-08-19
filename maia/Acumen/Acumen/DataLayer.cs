/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Maia Systems Acumen
 * Copyright (c) 2006 Maia Systems
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Database Layer
 *
 * $Id$
 * 
 * Who  When       Why
 * CAM  6-Apr-06   100 : Added to Source Safe.
 * CAM  19-Apr-06  100 : Added Contract Node.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections;
using System.Windows.Forms;
using Npgsql;

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

    private Npgsql.NpgsqlConnection _conn;
    private string _moteSql;
    private string _moteCols;
    private string _moteWarningSql;
    private string _moteDangerSql;
    private Hashtable _darts;

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
        _conn = new NpgsqlConnection();
        _conn.ConnectionString = Prefs.Preferences.ConnectionString;
        _conn.Open();
      }
      catch (Npgsql.NpgsqlException)
      {
        //
      }

      _moteSql = null;
      _darts = new Hashtable();
    }

    protected string MoteSQL() 
    {
      if (_moteSql == null) 
      {
        string sql = "SELECT '(' || name || '*' || eqm || ')+' || TRIM(TO_CHAR(eqc,'99990.000')) || ' as ' || name AS factored, name " +
                     "FROM acumen.motecol WHERE sensor IS NOT NULL";        

        _moteSql = "SELECT TO_CHAR(result_time, 'HH24:MI:SS') AS mdatetime,oid,result_time,nodeid,parent";
        _moteCols = null;

        Npgsql.NpgsqlCommand cmd = new NpgsqlCommand(sql);
        cmd.Connection = this._conn;
        Npgsql.NpgsqlDataReader r = cmd.ExecuteReader();
        while (r.Read())
        {
          _moteSql += "," + r.GetString(0);
          if (_moteCols != null) 
          {
            _moteCols += ",";
          }
          _moteCols += r.GetString(1);
        }
        r.Close();

        _moteSql += " FROM mda500_results WHERE ";
      }

      return _moteSql;
    }

    protected string MoteEventSQL(string eventtype, string select) 
    {
      string sql = "SELECT " + select + " FROM acumen.motecol WHERE sensor IS NOT NULL";
      string rval = this.MoteSQL() + " (";
      int i=0;

      Npgsql.NpgsqlCommand cmd = new NpgsqlCommand(sql);
      cmd.Connection = this._conn;
      Npgsql.NpgsqlDataReader r = cmd.ExecuteReader();
      while (r.Read())
      {
        if (i++ > 0) 
        {
          rval += " OR ";
        }
        rval += r.GetString(0);
      }
      r.Close();

      rval += ")";
        
      rval = "INSERT INTO acumen.eventhistory (result_oid,result_time,nodeid,parent,eventtype," + _moteCols + ") " +
        "SELECT oid,result_time,nodeid,parent,'" + eventtype + "'," + _moteCols + " FROM (" + rval + ") m " +
        "WHERE NOT EXISTS (SELECT 1 FROM acumen.eventhistory WHERE result_oid = m.oid)";

      return rval;
    }

    protected string MoteWarningSQL() 
    {
      if (_moteWarningSql == null) 
      {
        _moteWarningSql = MoteEventSQL("W", "name || ' between ' || warnlow || ' and ' || warnhigh ");        
      }

      return _moteWarningSql;
    }
    
    protected string MoteDangerSQL()
    {
      if (_moteDangerSql == null) 
      {
        _moteDangerSql = MoteEventSQL("D", "name || ' between ' || dangerlow || ' and ' || dangerhigh ");        
      }

      return _moteDangerSql;
    }
    
    public void CheckEventHistory() 
    {
      Npgsql.NpgsqlCommand cmd = new NpgsqlCommand(this.MoteWarningSQL());
      cmd.Connection = this._conn;
      cmd.ExecuteNonQuery();

      //MessageBox.Show(this.MoteDangerSQL());
      //cmd.CommandText = this.MoteDangerSQL();
      //cmd.ExecuteNonQuery();
    }

    public ArrayList GetEvents() 
    {
      string sql = "SELECT nodeid,eventtype,TO_CHAR(result_time, 'HH24:MI:SS') As result_time,adc7,adc6,adc5,adc4,adc3 " +
                   "FROM acumen.eventhistory "+
                   "WHERE nodeid IN (SELECT nodeid FROM acumen.motenode)";
      ArrayList rval = new ArrayList();
      Npgsql.NpgsqlCommand cmd = new NpgsqlCommand(sql);
      cmd.Connection = this._conn;
      Npgsql.NpgsqlDataReader r = cmd.ExecuteReader();
      while (r.Read())
      {
        Event e = new Event(r.GetInt32(0),
                            r.GetString(1),
                            r.GetString(2),
                            float.Parse(r.GetValue(3).ToString()),
                            float.Parse(r.GetValue(4).ToString()),
                            float.Parse(r.GetValue(5).ToString()),
                            float.Parse(r.GetValue(6).ToString()),
                            float.Parse(r.GetValue(7).ToString()));
        rval.Add(e);
      }
      r.Close();
      return rval;
    }


    public double[] GetMinMax(int mtype) 
    {
      double[] rval = new double[2];
      string sql = "SELECT MIN(m1),MAX(m1) FROM acumen.dat " +
                   "WHERE mtype = '" + mtype.ToString() + "' ";

      Npgsql.NpgsqlCommand cmd = new NpgsqlCommand(sql);
      cmd.Connection = this._conn;
      Npgsql.NpgsqlDataReader r = cmd.ExecuteReader();
      if (r.Read())
      {
        rval[0] = r.GetDouble(0);
        rval[1] = r.GetDouble(1);
      }
      r.Close();
      return rval;
    }

    public void UpdateMeasurementData(ComponentNode component, Pego peg, int sets, MeasurementTypes mtype) 
    {
      int maxPoints = 5000;
      int i=0,p=0;
      float[] fdat = new float[sets];

      Npgsql.NpgsqlCommand cmd = null;
      Npgsql.NpgsqlDataReader r = null;

      int mt = 0;
      switch (mtype) 
      {
        case MeasurementTypes.Speed:
          mt = 1;
          break;
        case MeasurementTypes.Temperature:
          mt = 2;
          break;
        case MeasurementTypes.Vibration:
          mt = 3;
          break;
      }

      string sql = "SELECT TO_CHAR(mdate, 'HH:MI:SS') AS mdatetime,m1,m2,m3,alarm " +
                  "FROM acumen.dat " +
                  "WHERE component_id = '" + component.Id + "' " +
                  "AND mtype = '" + mt + "' " +                        
                  "ORDER BY id LIMIT " + maxPoints.ToString();

      MessageBox.Show(sql);

      cmd = new NpgsqlCommand(sql);
      cmd.Connection = this._conn;
      r = cmd.ExecuteReader();
      while (r.Read())
      {
        for (i=0; i<fdat.Length; i++)
        {
          try 
          {
            peg.PeData.Y[i, p] = float.Parse(r.GetValue(i+1).ToString(), System.Globalization.NumberStyles.Float);
          } 
          catch
          {
          }
          
        }
        peg.PeData.PointLabels[p++] = r.GetString(0);
      }
      peg.Refresh();
      r.Close();
    }

    public void UpdateMoteData(ComponentNode component, Pego peg, MeasurementTypes mtype) 
    {
      int maxPoints = 80;
      int i=0;
      float[] fdat = null;
      
      if (mtype == MeasurementTypes.Vibration && component.ComponentType == ComponentTypes.Dart2) 
      {
        fdat = new float[3];
      }
      else
      {
        fdat = new float[1];
      }

      Npgsql.NpgsqlCommand cmd = null;
      Npgsql.NpgsqlDataReader r = null;
      string sql = this.MoteSQL() + "nodeid='" + component.Id + "' ";
      if (component.LastData > 0) 
      {
        sql += "AND oid>" + component.LastData + " ";
      }
      sql += "ORDER BY oid LIMIT " + maxPoints.ToString();
      //MessageBox.Show(sql);
      
      cmd = new NpgsqlCommand(sql);
      cmd.Connection = this._conn;
      r = cmd.ExecuteReader();
      while (r.Read())
      {
        for (i=0; i<r.FieldCount; i++)
        {
          if (mtype == MeasurementTypes.Speed && r.GetName(i).Equals("adc7")) 
          {
            fdat[0] = float.Parse(r.GetValue(i).ToString());
            component.LastData = long.Parse(r.GetValue(1).ToString());
          } 
          else if (mtype == MeasurementTypes.Temperature && r.GetName(i).Equals("adc6")) 
          {
            fdat[0] = float.Parse(r.GetValue(i).ToString());
          }
          else if (mtype == MeasurementTypes.Vibration && r.GetName(i).Equals("adc5")) 
          {
            fdat[0] = float.Parse(r.GetValue(i).ToString());
          }
          else if (mtype == MeasurementTypes.Vibration && r.GetName(i).Equals("adc4") && fdat.Length == 3) 
          {
            fdat[1] = float.Parse(r.GetValue(i).ToString());
          }
          else if (mtype == MeasurementTypes.Vibration && r.GetName(i).Equals("adc3") && fdat.Length == 3) 
          {
            fdat[2] = float.Parse(r.GetValue(i).ToString());
          }
        }
        
        try 
        {
          Gigasoft.ProEssentials.Api.PEvset(peg.PeSpecial.HObject, Gigasoft.ProEssentials.DllProperties.AppendPointLabelData, r.GetString(0), 1);
          Gigasoft.ProEssentials.Api.PEvset(peg.PeSpecial.HObject, Gigasoft.ProEssentials.DllProperties.AppendYData, fdat, 1);
        }
        catch (Exception)
        {
        }
      }
      peg.Refresh();
      r.Close();
    }

    public SensorData[] GetMeasurementData(ComponentNode component, int lastId, MeasurementTypes mtype) 
    {
      int maxPoints = 250;
      if (component.ComponentType == ComponentTypes.SealChip) 
      {
        maxPoints = 5000;
      }

      SensorData[] rval;
      SensorData[] results = new SensorData[maxPoints];
      int index=0;

      Npgsql.NpgsqlCommand cmd = null;
      Npgsql.NpgsqlDataReader r = null;
      string sql = "SELECT id,TO_CHAR(mdate, 'HH24:MI:SS') mdatetime,m1,m2,m3,alarm " +
                   "FROM acumen.dat " +
                   "WHERE component_id = '" + component.Id + "' " +
                   "AND mtype = '" + mtype + "' ";

      if ((lastId > 0) && (component.ComponentType == ComponentTypes.Wireless)) 
      {
        sql += "AND id > '" + lastId.ToString() + "' ";
      }
      sql += "ORDER BY mdate DESC LIMIT " + maxPoints.ToString();

      //MessageBox.Show(sql);

      cmd = new NpgsqlCommand(sql);
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

    public void populateTree(TreeView trv, Hashtable dartButtons) 
    {
      Npgsql.NpgsqlCommand cmd = new NpgsqlCommand();
      Npgsql.NpgsqlDataReader r;
      cmd.Connection = this._conn;

      Hashtable assets = new Hashtable();
      Hashtable schematics = new Hashtable();
      Hashtable tags = new Hashtable();
      
      TreeNode root = null;
      TreeNode parent = null;

      // Company data
      cmd.CommandText = "SELECT id,code,company FROM acumen.company";
      r = cmd.ExecuteReader();
      if (r.Read())
      {
        root = new CompanyNode(r.GetInt32(0), r.GetString(1), r.GetString(2));
      }
      r.Close();

      ContractNode contract = new ContractNode(0, "BPUKCS", "BP UKCS");
      root.Nodes.Add(contract);

      // Assets
      cmd.CommandText = "SELECT id,code,asset FROM acumen.asset ORDER BY asset";
      r = cmd.ExecuteReader();
      while (r.Read()) 
      {
        AssetNode n = new AssetNode(r.GetInt32(0), r.GetString(1), r.GetString(2));
        assets.Add(n.Id, n);           
        contract.Nodes.Add(n);
      }
      r.Close();

      // Schematics
      cmd.CommandText = "SELECT id,code,schematic,asset_id FROM acumen.schematic ORDER BY disporder,schematic";
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
      cmd.CommandText = "SELECT id,code,tag,schematic_id,traffic FROM acumen.tag ORDER BY tag";
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
      cmd.CommandText = "SELECT id,code,component,tag_id,ctype,physical_end FROM acumen.component ORDER BY physical_end,component";
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

      // Demo Rig Darts
      DemoRigNode drn = new DemoRigNode(1, "ONS", "Demo Rig");
      root.Nodes.Add(drn);
      cmd.CommandText = "SELECT nodeid,code,component,tag_id,ctype,physical_end FROM acumen.motenode ORDER BY physical_end,code";
      r = cmd.ExecuteReader();
      while (r.Read()) 
      {
        AcumenNode n = new ComponentNode(r.GetInt32(0), r.GetString(1), r.GetString(2), r.GetInt32(4), r.GetInt32(5));

        _darts[r.GetInt32(0)] = n;

        Object o = dartButtons[n.Code];
        if (o is Button) 
        {
          Button btn = (Button) o;
          btn.Text = n.Text;
          btn.Tag = n;                    
        }

        drn.Nodes.Add(n);
      }
      r.Close();
      
      trv.Nodes.Add(root);
      root.Expand();
    }

    public ComponentNode DartComponent(int i) 
    {
      return (ComponentNode) _darts[i];
    }
	}
}
