using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

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
      // TODO: This line of code loads data into the 'emitScoreDataSet.Team' table. You can move, or remove it, as needed.
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
      groupTableAdapter.Update(_dataSet.Group);
    }
  }
}
