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
      this.categoryTableAdapter.Fill(this.emitScoreDataSet.Category);
      this.groupTableAdapter.Fill(this.emitScoreDataSet.Group);
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void FrmGroups_FormClosing(object sender, FormClosingEventArgs e)
    {
      groupTableAdapter.Update(emitScoreDataSet.Group);
    }
  }
}
