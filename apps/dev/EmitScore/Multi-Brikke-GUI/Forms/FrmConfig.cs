/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : Changed copyright text.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace FrontBurner.Apps.EmitScore.MultiBrikke.Forms
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
