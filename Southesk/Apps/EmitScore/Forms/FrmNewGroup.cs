using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

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

    protected DataRow GetCurrentRow()
    {
      foreach (DataRow row in _dataSet.Group)
      {
        if (row[_dataSet.Group.GroupIdColumn].Equals(_groupId))
        {
          return row;
        }
      }
      return null;
    }

    private void FrmNewGroup_Load(object sender, EventArgs e)
    {
      // TODO: This line of code loads data into the '_dataSet.Team' table. You can move, or remove it, as needed.
      this.teamTableAdapter.Fill(this._dataSet.Team);
      _bdsGroup.Filter = "groupID='" + _groupId.ToString() + "'";

      this.categoryTableAdapter.Fill(this._dataSet.Category);
      this.groupTableAdapter.Fill(this._dataSet.Group);

      DataRow row = GetCurrentRow();
      if (row != null)
      {
        row.BeginEdit();
      }
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {    
      this.Dispose();
    }

    private void FrmNewGroup_FormClosing(object sender, FormClosingEventArgs e)
    {
      DataRow row = GetCurrentRow();
      if (row != null)
      {
        row.EndEdit();
        groupTableAdapter.Update(row);
      }
    }
  }
}
