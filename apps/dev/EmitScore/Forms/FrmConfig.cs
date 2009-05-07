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
  public partial class FrmConfig : Form
  {
    public FrmConfig()
    {
      InitializeComponent();
    }

    private void FrmConfig_Load(object sender, EventArgs e)
    {
      configTableAdapter.Fill(emitScoreDataSet.Config);
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void FrmConfig_FormClosing(object sender, FormClosingEventArgs e)
    {
      configTableAdapter.Update(emitScoreDataSet.Config);
    }
  }
}
