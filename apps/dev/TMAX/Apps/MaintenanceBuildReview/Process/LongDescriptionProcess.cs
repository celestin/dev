/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2013 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Oct-2013  11172 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System.IO;

using FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data;

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Process
{
  public class LongDescriptionProcess
  {
    private FileInfo _validateDb;

    public LongDescriptionProcess(FileInfo validateDb)
    {
      _validateDb = validateDb;
    }

    public int MaximumRows { get { return ValidateDatalayer.Instance.MaximumRows; } }
    public int CurrentRow { get { return ValidateDatalayer.Instance.CurrentRow; } }
    public string CurrentTableName { get { return ValidateDatalayer.Instance.CurrentTableName; } }

    public void Execute()
    {
      Properties.Settings s = Properties.Settings.Default;

      OracleDatalayer odl = OracleDatalayer.Instance;
      odl.Open(s.OraUsername, s.OraPassword, s.OraTNS);

      ValidateDatalayer vdl = ValidateDatalayer.Instance;
      vdl.Open(_validateDb);
      vdl.LongDescriptionCheck();
    }
  }
}
