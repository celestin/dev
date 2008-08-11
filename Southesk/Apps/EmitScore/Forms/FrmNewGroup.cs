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
      _bdsGroup.Filter = String.Format("groupID='{0}'", _groupId);

      teamTableAdapter.Fill(_dataSet.Team);
      categoryTableAdapter.Fill(_dataSet.Category);
      groupTableAdapter.Fill(_dataSet.Group);
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {    
      this.Dispose();
    }

    private void FrmNewGroup_FormClosing(object sender, FormClosingEventArgs e)
    {
      foreach (DataRow row in _dataSet.Group) 
      {
        EmitScoreDataSet.GroupRow group = (EmitScoreDataSet.GroupRow)row;
        if (group.GroupId == _groupId)
        {
          if (!group.IsTeamIdNull())
          {
            group.BeginEdit();
            EmitScoreDataSet.TeamRow team = _dataSet.Team.FindByTeamId(group.TeamId);
            group.CategoryId = team.CategoryId;
            group.EndEdit();
          }
        }
      }
      
      groupTableAdapter.Update(_dataSet.Group);      
    }    
  }
}
