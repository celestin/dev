/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Ework Manager
 * Copyright (c) 2013 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Oct-2013  11181 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System.IO;

using FrontBurner.Tmax.Apps.EworkManager.Data;

namespace FrontBurner.Tmax.Apps.EworkManager.Process
{
  public class EworkExtractProcess
  {
    private FileInfo _EworkCrDb;

    public EworkExtractProcess(FileInfo EworkCrDb)
    {
      _EworkCrDb = EworkCrDb;
    }

    public int MaximumRows { get { return AccessDatalayer.Instance.MaximumRows; } }
    public int CurrentRow { get { return AccessDatalayer.Instance.CurrentRow; } }
    public string CurrentTableName { get { return AccessDatalayer.Instance.CurrentTableName; } }

    public void Execute()
    {
      Properties.Settings s = Properties.Settings.Default;

      OracleDatalayer odl = OracleDatalayer.Instance;
      odl.Open(s.OraUsername, s.OraPassword, s.OraTNS);

      AccessDatalayer adl = AccessDatalayer.Instance;
      adl.Open(_EworkCrDb);

      adl.TakeSnapshot();
      adl.Close();
    }
  }
}
