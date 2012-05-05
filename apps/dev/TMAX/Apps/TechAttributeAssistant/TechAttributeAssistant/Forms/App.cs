/* * * * * * * * * * * * * * * * * * * * * * * *
 * TMAX Technical Attribute Assistant
 * Copyright (c) 2012 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  15-Apr-2012  11113 : Created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using FrontBurner.Tmax.Apps.TechAttributeAssistant.Data;

namespace FrontBurner.Tmax.Apps.TechAttributeAssistant.Forms
{
  public partial class App : Form
  {
    public App()
    {
      InitializeComponent();
    }

    private void exitToolStripMenuItem_Click(object sender, EventArgs e)
    {
      Application.Exit();
    }

    private void tsbCount_Click(object sender, EventArgs e)
    {
      Datalayer d = Datalayer.Instance;
      try
      {
        Properties.Settings s = Properties.Settings.Default;

        statusLabel.Text = String.Format("Locations {0}", d.Open(s.OraUsername, s.OraPassword, s.OraTNS));
      }
      catch (Exception ex)
      {
        MessageBox.Show(ex.ToString());
      }
    }

    private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
    {

    }

    private void tsbRetrieve_Click(object sender, EventArgs e)
    {
      Datalayer d = Datalayer.Instance;
      try
      {
        Properties.Settings s = Properties.Settings.Default;

        statusLabel.Text = String.Format("Locations {0}", d.Open(s.OraUsername, s.OraPassword, s.OraTNS));
        lblEqClassCode.Text = d.LocationClass(txtLocation.Text);
      }
      catch (Exception ex)
      {
        MessageBox.Show(ex.ToString());
      }
    }
  }
}
