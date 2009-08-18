/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : Added datatable for Courses.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace FrontBurner.Apps.EmitScore.MultiBrikke.Forms
{
  public partial class FrmLocations : Form
  {
    public FrmLocations()
    {
      InitializeComponent();
    }

    private void FrmLocations_Load(object sender, EventArgs e)
    {
      courseTableAdapter.Fill(emitScoreDataSet.Course);
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
