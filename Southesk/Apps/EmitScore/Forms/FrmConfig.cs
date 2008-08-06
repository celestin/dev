using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Southesk.Apps.EmitScore.Forms
{
  public partial class FrmConfig : Form
  {
    public FrmConfig()
    {
      InitializeComponent();
    }

    private void FrmConfig_Load(object sender, EventArgs e)
    {
      configTableAdapter.Fill(emitScoreDataSet.Config);
    }

    private void _tsbExit_Click(object sender, EventArgs e)
    {
      this.Dispose();
    }

    private void FrmConfig_FormClosing(object sender, FormClosingEventArgs e)
    {
      configTableAdapter.Update(emitScoreDataSet.Config);
    }
  }
}
