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
using System.Data;
using System.Windows.Forms;

using Southesk.Apps.EmitScore.Data;

namespace Southesk.Apps.EmitScore.Forms
{
  public partial class FrmGroups : Form
  {
    public FrmGroups()
    {
      InitializeComponent();
    }

    private void FrmGroups_Load(object sender, EventArgs e)
    {
      this.teamTableAdapter.Fill(this._dataSet.Team);
      this.categoryTableAdapter.Fill(this._dataSet.Category);
      this.groupTableAdapter.Fill(this._dataSet.Group);
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void FrmGroups_FormClosing(object sender, FormClosingEventArgs e)
    {
      foreach (DataRow row in _dataSet.Group)
      {
        EmitScoreDataSet.GroupRow group = (EmitScoreDataSet.GroupRow)row;
        if (!group.IsTeamIdNull())
        {
          group.BeginEdit();
          EmitScoreDataSet.TeamRow team = _dataSet.Team.FindByTeamId(group.TeamId);
          group.CategoryId = team.CategoryId;
          group.EndEdit();
        }
      }

      groupTableAdapter.Update(_dataSet.Group);
    }
  }
}
