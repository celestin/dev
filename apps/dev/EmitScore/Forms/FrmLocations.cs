/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  07-May-2009  10444 : Changed to Front Burner.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace FrontBurner.Apps.EmitScore.Forms
{
  public partial class FrmLocations : Form
  {
    public FrmLocations()
    {
      InitializeComponent();
    }

    private void FrmLocations_Load(object sender, EventArgs e)
    {
      locationTableAdapter.Fill(emitScoreDataSet.Location);
    }

    private void FrmLocations_FormClosing(object sender, FormClosingEventArgs e)
    {
      locationTableAdapter.Update(emitScoreDataSet.Location);
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }
  }
}
