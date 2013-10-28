/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Ework Manager
 * Copyright (c) 2013 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  28-Oct-2013  11181 : Created.
 * CAM  18-May-2013  11181 : Added call to ExtractMaximo form.
 * CAM  28-Oct-2013  11181 : Improved MSAccess checks when opening db.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.IO;
using System.Windows.Forms;
using System.Threading;

using FrontBurner.Tmax.Apps.EworkManager.Data;
using FrontBurner.Tmax.Apps.EworkManager.Process;

namespace FrontBurner.Tmax.Apps.EworkManager.Forms
{
  public partial class App : Form
  {
    private EworkExtractProcess _eep;
    private Thread _process;

    public string EworkCrDb
    {
      set
      {
        FileInfo db = new FileInfo(value);
        if (db.Exists)
        {
          Properties.Settings.Default.EworkCrDbPath = txtEworkCrDb.Text = db.FullName;
        }
      }
      get
      {
        return Properties.Settings.Default.EworkCrDbPath;
      }
    }

    public App()
    {
      InitializeComponent();

      txtEworkCrDb.Text = Properties.Settings.Default.EworkCrDbPath;
    }

    private void ExitApplication(object sender, EventArgs e)
    {
      Application.Exit();
    }

    private void HelpAbout(object sender, EventArgs e)
    {
      AboutEworkManager about = new AboutEworkManager();
      about.ShowDialog();
    }

    private void SetEworkCrDatabase(object sender, EventArgs e)
    {
      Properties.Settings s = Properties.Settings.Default;
      ofdEworkCrDb.Title = "Select Validate Access Database";

      if (ofdEworkCrDb.ShowDialog() == DialogResult.OK)
      {
        FileInfo db = new FileInfo(ofdEworkCrDb.FileName);
        if (db.Exists)
        {
          EcrState state = AccessDatalayer.Instance.Open(db);

          if (state == EcrState.Invalid)
          {
            MessageBox.Show("Could not open Database!");
            return;
          }
          else if (state == EcrState.OK)
          {
            this.Text = "Ework Manager - EworkCR Open";
            EworkCrDb = db.FullName;
            AccessDatalayer.Instance.Close();
          }
        }
      }
    }

    private void TakeNewSnapshot(object sender, EventArgs e)
    {
      updateTimer.Enabled = false;
      tsbTakeNewSnapshot.Enabled = false;

      _eep = new EworkExtractProcess(new FileInfo(EworkCrDb));
      _process = new Thread(_eep.Execute);
      _process.IsBackground = true;
      _process.Start();

      updateTimer.Enabled = true;
    }

    private void UpdateTimerTick(object sender, EventArgs e)
    {
      if (_process != null && _process.IsAlive)
      {
        tspSnapshot.Maximum = _eep.MaximumRows;
        tspSnapshot.Value = _eep.CurrentRow;
        tslStatus.Text = _eep.CurrentTableName;
      }
      else
      {
        updateTimer.Enabled = false;
        tspSnapshot.Value = 0;
        tslStatus.Text = "Ready.";
        tsbTakeNewSnapshot.Enabled = true;
      }
    }

    private void EmailAssignments(object sender, EventArgs e)
    {
      FileInfo db = new FileInfo(Properties.Settings.Default.EworkCrDbPath);
      EcrState state = AccessDatalayer.Instance.Open(db);
      if (state == EcrState.OK)
      {
        EmailHelper email = new EmailHelper();
        AccessDatalayer.Instance.EmailAssignments(email);
      }
    }
  }
}
