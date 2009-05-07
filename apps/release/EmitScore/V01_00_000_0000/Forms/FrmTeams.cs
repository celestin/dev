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
      categoryTableAdapter.Fill(_dataSet.Category);
      teamTableAdapter.Fill(_dataSet.Team);

      _dataSet.Team.DefaultView.Sort = "CategoryId, TeamName";
      _bdsTeam.DataSource = _dataSet.Team;
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void FrmTeams_FormClosing(object sender, FormClosingEventArgs e)
    {
      teamTableAdapter.Update(_dataSet.Team);
    }
  }
}
