/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008 Southesk.com
 * Author Craig McKay <craig@southesk.com>
 *
 * $Id: FrmConfig.cs 872 2008-08-11 23:42:36Z craig $
 *
 * Who  When         Why
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace Southesk.Apps.EmitScore.Forms
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
