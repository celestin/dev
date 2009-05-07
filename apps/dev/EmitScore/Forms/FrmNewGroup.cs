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
using System.Data;
using System.Windows.Forms;

using FrontBurner.Apps.EmitScore.Data;

namespace FrontBurner.Apps.EmitScore.Forms
{
  public partial class FrmNewGroup : Form
  {
    private int _groupId;

    public FrmNewGroup(int groupId)
    {
      _groupId = groupId;

      InitializeComponent();
    }

    private void FrmNewGroup_Load(object sender, EventArgs e)
    {
      categoryTableAdapter.Fill(_dataSet.Category);
      groupTableAdapter.Fill(_dataSet.Group);

      _bdsGroup.Filter = String.Format("groupID='{0}'", _groupId);
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Close();
    }

    protected override void OnFormClosing(FormClosingEventArgs e)
    {
      base.OnFormClosing(e);

      if (MessageBox.Show("Have you clicked the Header row to ensure the data saves?",
        "Clicked the Header Row?", MessageBoxButtons.YesNo,
        MessageBoxIcon.Question) == DialogResult.Yes)
      {
        //foreach (DataRow row in _dataSet.Group)
        //{
        //  EmitScoreDataSet.GroupRow group = (EmitScoreDataSet.GroupRow)row;
        //  if (group.GroupId == _groupId)
        //  {
        //    if (!group.IsTeamIdNull())
        //    {
        //      group.BeginEdit();
        //      EmitScoreDataSet.TeamRow team = _dataSet.Team.FindByTeamId(group.TeamId);
        //      group.CategoryId = team.CategoryId;
        //      group.EndEdit();
        //    }
        //  }
        //}

        groupTableAdapter.Update(_dataSet.Group);
      }
      else
      {
        e.Cancel = true;
      }
    }
  }
}
