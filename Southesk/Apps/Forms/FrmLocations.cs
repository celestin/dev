using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Southesk.Apps.EmitScore.Forms
{
  public partial class FrmLocations : Form
  {
    public FrmLocations()
    {
      InitializeComponent();
    }

    private void FrmLocations_Load(object sender, EventArgs e)
    {
      locationTableAdapter.Fill(emitScoreDataSet.Location);
    }

    private void FrmLocations_FormClosing(object sender, FormClosingEventArgs e)
    {
      locationTableAdapter.Update(emitScoreDataSet.Location);
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }
  }
}
