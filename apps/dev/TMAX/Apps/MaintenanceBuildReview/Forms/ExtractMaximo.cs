/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Maintenance Build Review
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-May-2013  11172 : Created.
 * CAM  28-Oct-2013  11172 : Added LongDescription checks (no longer required).
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Threading;
using System.Drawing;
using System.IO;
using System.Text;
using System.Windows.Forms;

using FrontBurner.Tmax.Apps.MaintenanceBuildReview.Data;
using FrontBurner.Tmax.Apps.MaintenanceBuildReview.Process;

namespace FrontBurner.Tmax.Apps.MaintenanceBuildReview.Forms
{
  public partial class ExtractMaximo : Form
  {
    private LongDescriptionProcess _ldp;
    private Thread _process;

    public ExtractMaximo()
    {
      InitializeComponent();

      txtValidateDb.Text = ValidateDb;
    }

    public string ValidateDb
    {
      set
      {
        FileInfo db = new FileInfo(value);
        if (db.Exists)
        {
          if (ValidateDatalayer.Instance.Open(db))
          {
            Properties.Settings.Default.ValidateDbPath = txtValidateDb.Text = db.FullName;
          }
        }
      }
      get
      {
        return Properties.Settings.Default.ValidateDbPath;
      }
    }

    private void CloseWindow(object sender, EventArgs e)
    {
      this.Close();
    }

    private void ExtractData(object sender, EventArgs e)
    {
      Properties.Settings s = Properties.Settings.Default;

      OracleDatalayer odl = OracleDatalayer.Instance;
      odl.Open(s.OraUsername, s.OraPassword, s.OraTNS);

      ValidateDatalayer vdl = ValidateDatalayer.Instance;
      vdl.Open(new FileInfo(this.ValidateDb));
      vdl.Extract(tslStatus, tspExtract);
    }

    private void SetValidateDatabase(object sender, EventArgs e)
    {
      Properties.Settings s = Properties.Settings.Default;
      ofdValidateDb.Title = "Select Validate Access Database";

      if (ofdValidateDb.ShowDialog() == DialogResult.OK)
      {
        ValidateDb = ofdValidateDb.FileName;
      }

    }

    private void LongDescriptionCheck(object sender, EventArgs e)
    {
      updateTimer.Enabled = false;

      _ldp = new LongDescriptionProcess(new FileInfo(this.ValidateDb));
      _process = new Thread(_ldp.Execute);
      _process.IsBackground = true;
      _process.Start();

      updateTimer.Enabled = true;
    }

    private void updateTimer_Tick(object sender, EventArgs e)
    {
      if (_process.IsAlive)
      {
        tspExtract.Maximum = _ldp.MaximumRows;
        tspExtract.Value = _ldp.CurrentRow;
        tslStatus.Text = _ldp.CurrentTableName + ": " + _ldp.CurrentRow + " row of " + _ldp.MaximumRows;
      }
      else
      {
        updateTimer.Enabled = false;
      }
    }
  }
}
