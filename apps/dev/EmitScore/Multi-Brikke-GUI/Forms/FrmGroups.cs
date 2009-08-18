/* * * * * * * * * * * * * * * * * * * * * * * *
 * EmitScore
 * Copyright (c) 2008,2009 Front Burner Ltd
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Aug-2009  10473 : Allow groups to be deleted.
 * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Data;
using System.Windows.Forms;

using FrontBurner.Apps.EmitScore.MultiBrikke.Data;

namespace FrontBurner.Apps.EmitScore.MultiBrikke.Forms
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

      _dataSet.Team.DefaultView.Sort = "TeamName ASC";
      _bdsTeam.DataSource = _dataSet.Team;           
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
        if (group.RowState != DataRowState.Deleted && !group.IsTeamIdNull())
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
