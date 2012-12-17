/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  17-Dec-2012  11149 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

using System.Data;
using System.Data.OracleClient;


namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data
{
  public class Datalayer
  {
    private OracleConnection con;
    private static Datalayer _layer;

    private Datalayer()
    {
      con = new OracleConnection();
    }

    public static Datalayer Instance
    {
      get
      {
        if (_layer == null) _layer = new Datalayer();
        return _layer;
      }
    }

    public int Open(string id, string password, string tns)
    {
      int rval = -1;

      if (con.State != System.Data.ConnectionState.Open)
      {
        con.ConnectionString = String.Format("Data Source={0};User ID={1}; Password={2}", tns, id, password);
        con.Open();
      }

      // Create and execute the query
      OracleCommand cmd = new OracleCommand("select count(*) loccount from locations", con);
      OracleDataReader reader = cmd.ExecuteReader();

      // Iterate through the DataReader and display row
      if (reader.Read())
      {
        rval = int.Parse(reader[0].ToString());
      }

      return rval;
    }

    public DataTable LocationClass(string location)
    {
      string s = String.Format(
        "select l.location, l.description locdescription, lo.failurecode eqclasscode, f.description eqclassdesc, " +
        "l.classstructureid, csl.classificationid, ac.description classdescription " +
        "from locations l, locoper lo, failurecode f, classstructlink csl, assetclass ac " +
        "where lo.location = l.location " +
        "and f.failurecode = lo.failurecode " +
        "and csl.classstructureid (+)= l.classstructureid " +
        "and ac.classificationid = csl.classificationid " +
        "and l.location = '{0}'", location);

      OracleCommand cmd = new OracleCommand(s, con);
      //OracleDataReader reader = cmd.ExecuteReader();

      OracleDataAdapter da = new OracleDataAdapter(cmd);
      DataTable rval = new DataTable();
      da.Fill(rval);
      return rval;
    }

    public DataTable LocationAttributes(string location, string classid)
    {
      string s = String.Format(
        "select ls.assetattrid, ls.displaysequence, aa.description, " +
        "decode(aa.datatype, 'ALN', ls.alnvalue, cast(ls.numvalue as varchar2(100))) attrvalue " +
        "from locationspec ls, assetattribute aa " +
        "where aa.assetattrid = ls.assetattrid " +
        "and ls.location = '{0}' " +
        "and ls.classstructureid = '{1}' " +
        "order by ls.displaysequence", location, classid);
      //MessageBox.Show(s);
      OracleCommand cmd = new OracleCommand(s, con);
      //OracleDataReader reader = cmd.ExecuteReader();

      OracleDataAdapter da = new OracleDataAdapter(cmd);
      DataTable rval = new DataTable();
      da.Fill(rval);
      return rval;
    }
  }
}
