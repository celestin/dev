/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  29-May-08   364 : Added Preferences.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

using SourceCodeMetrics.Krakatau.Kepm.Win32;

namespace SourceCodeMetrics.Krakatau.Kepm.Forms
{
  public partial class FormPreferences : Form
  {
    public FormPreferences()
    {
      InitializeComponent();
    }

    private void FormPreferences_Load(object sender, EventArgs e)
    {
      Prefs p = Prefs.Preferences;

      _txtServer.Text = p.MySqlServer;
      _txtUsername.Text = p.MySqlUsername;
      _txtPassword.Text = p.MySqlPassword;
      _chkUse.Checked = p.MySqlUse;
    }

    private void FormPreferences_FormClosing(object sender, FormClosingEventArgs e)
    {
      Prefs p = Prefs.Preferences;

      p.MySqlServer = _txtServer.Text;
      p.MySqlUsername = _txtUsername.Text;
      p.MySqlPassword = _txtPassword.Text;
      p.MySqlUse = _chkUse.Checked;
    }
  }
}
