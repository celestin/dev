/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008 Southesk.com
 * Author Craig McKay <craig@southesk.com>
 *
 * $Id$
 *
 * Who  When         Why
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

namespace Southesk.Apps.EmitScore.Forms
{
  public partial class FrmTeams : Form
  {
    public FrmTeams()
    {
      InitializeComponent();
    }

    private void FrmTeams_Load(object sender, EventArgs e)
    {
      categoryTableAdapter.Fill(emitScoreDataSet.Category);
      teamTableAdapter.Fill(emitScoreDataSet.Team);
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void FrmTeams_FormClosing(object sender, FormClosingEventArgs e)
    {
      teamTableAdapter.Update(emitScoreDataSet.Team);
    }
  }
}
