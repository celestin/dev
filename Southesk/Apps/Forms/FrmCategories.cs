using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Southesk.Apps.EmitScore.Forms
{
  public partial class FrmCategories : Form
  {
    public FrmCategories()
    {
      InitializeComponent();
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void FrmCategories_Load(object sender, EventArgs e)
    {
      this.categoryTableAdapter.Fill(emitScoreDataSet.Category);
    }

    private void FrmCategories_FormClosing(object sender, FormClosingEventArgs e)
    {
      categoryTableAdapter.Update(emitScoreDataSet.Category);
    }
  }
}
