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

      dataGridView1.DataSource = bindingSource1;

      lblLocationDesc.Text = lblEqClassCode.Text = lblEqClassDesc.Text = 
        lblSpecCode.Text = lblSpecDesc.Text = String.Empty;
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

    private void tsbRetrieve_Click(object sender, EventArgs e)
    {
      Datalayer d = Datalayer.Instance;
      try
      {
        Properties.Settings s = Properties.Settings.Default;

        statusLabel.Text = String.Format("Locations {0}", d.Open(s.OraUsername, s.OraPassword, s.OraTNS));
        txtLocation.Text = txtLocation.Text.ToUpper();
        DataTable dt = d.LocationClass(txtLocation.Text);

        if (dt.Rows.Count > 0)
        {
          DataRow row = dt.Rows[0];
          lblLocationDesc.Text = row["locdescription"].ToString();
          lblEqClassCode.Text = row["eqclasscode"].ToString();
          lblEqClassDesc.Text = row["eqclassdesc"].ToString();
          lblSpecCode.Text = row["classificationid"].ToString();
          lblSpecDesc.Text = row["classdescription"].ToString();

          DataTable ds = d.LocationAttributes(txtLocation.Text, row["classstructureid"].ToString());
          bindingSource1.DataSource = ds;
          dataGridView1.AutoResizeColumns(DataGridViewAutoSizeColumnsMode.AllCells);
        }
        else
        {
          statusLabel.Text = String.Format("There is no Location {0}", txtLocation.Text);
        }
      }
      catch (Exception ex)
      {
        MessageBox.Show(ex.ToString());
      }
    }

    private void tsbExit_Click(object sender, EventArgs e)
    {
      Application.Exit();
    }
  }
}
