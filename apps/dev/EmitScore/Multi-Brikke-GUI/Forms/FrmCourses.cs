/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace FrontBurner.Apps.EmitScore.MultiBrikke.Forms
{
  public partial class FrmCourses : Form
  {
    public FrmCourses()
    {
      InitializeComponent();
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void FrmCourses_Load(object sender, EventArgs e)
    {
      courseTableAdapter.Fill(this.emitScoreDataSet.Course);
    }

    private void FrmCourses_FormClosing(object sender, FormClosingEventArgs e)
    {
      courseTableAdapter.Update(emitScoreDataSet.Course);
    }
  }
}
