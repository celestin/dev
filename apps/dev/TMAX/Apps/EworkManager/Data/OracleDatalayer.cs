/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Ework Manager
 * Copyright (c) 2013 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Oct-2013  11181 : Created.
 * CAM  18-May-2013  11181 : Moved Connection to public accessor to enable use from ValidateDatalayer.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

using System.Data;
using System.Data.OracleClient;


namespace FrontBurner.Tmax.Apps.EworkManager.Data
{
  public class OracleDatalayer
  {
    private OracleConnection _con;
    private static OracleDatalayer _layer;

    public OracleConnection Connection
    {
      get { return _con; }
    }

    private OracleDatalayer()
    {
      _con = new OracleConnection();
    }

    public static OracleDatalayer Instance
    {
      get
      {
        if (_layer == null) _layer = new OracleDatalayer();
        return _layer;
      }
    }

    public void Open(string id, string password, string tns)
    {
      if (Connection.State != System.Data.ConnectionState.Open)
      {
        Connection.ConnectionString = String.Format("Data Source={0};User ID={1}; Password={2}", tns, id, password);
        Connection.Open();
      }
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
      OracleCommand cmd = new OracleCommand(s, Connection);
      //OracleDataReader reader = cmd.ExecuteReader();

      OracleDataAdapter da = new OracleDataAdapter(cmd);
      DataTable rval = new DataTable();
      da.Fill(rval);
      return rval;
    }
  }
}
