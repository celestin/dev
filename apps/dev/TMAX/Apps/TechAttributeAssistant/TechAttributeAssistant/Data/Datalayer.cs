using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

using System.Data.OracleClient;


namespace FrontBurner.Tmax.Apps.TechAttributeAssistant.Data
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

      // Setup connection string to access local Oracle 9
      con.ConnectionString = String.Format("Data Source={0};User ID={1}; Password={2}", tns, id, password);

      // Open the connection
      con.Open();

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

    public string LocationClass(string location)
    {
      string rval = String.Empty;
      string s = String.Format(
        "select l.location, l.description locdescription, lo.failurecode, " +
        "l.classstructureid, csl.classificationid, ac.description classdescription " +
        "from locations l, locoper lo, classstructlink csl, assetclass ac " +
        "where lo.location = l.location " +
        "and csl.classstructureid (+)= l.classstructureid " +
        "and ac.classificationid = csl.classificationid " +
        "and l.location = '{0}'", location);

      OracleCommand cmd = new OracleCommand(s, con);
      OracleDataReader reader = cmd.ExecuteReader();

      // Iterate through the DataReader and display row
      if (reader.Read())
      {
        rval = reader[2].ToString();
      }

      return rval;
    }
  }
}
