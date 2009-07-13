using System;
using System.Windows.Forms;
using System.Reflection;

namespace Southesk.Apps.EmitScore.Forms
{
  public partial class FrmHelpAbout : Form
  {
    public FrmHelpAbout()
    {
      InitializeComponent();
    }

    private void FrmHelpAbout_Load(object sender, EventArgs e)
    {
      lblVersion.Text = Assembly.GetExecutingAssembly().GetName().Version.ToString();
    }
  }
}
