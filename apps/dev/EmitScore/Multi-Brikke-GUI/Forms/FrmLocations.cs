/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008 Southesk.com
 * Author Craig McKay <craig@southesk.com>
 *
 * $Id: FrmLocations.cs 872 2008-08-11 23:42:36Z craig $
 *
 * Who  When         Why
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace Southesk.Apps.EmitScore.Forms
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
