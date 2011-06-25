/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2008,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  29-May-08   364 : Added Preferences.
 * CAM  13-Mar-2010  10597 : Added Never Show PopupTips.
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

      _chkNeverShowPopupTips.Checked = p.PopupTipList.IsIgnorePopupTip(PopupTip.NeverShow);
    }

    private void FormPreferences_FormClosing(object sender, FormClosingEventArgs e)
    {
      Prefs p = Prefs.Preferences;

      p.MySqlServer = _txtServer.Text;
      p.MySqlUsername = _txtUsername.Text;
      p.MySqlPassword = _txtPassword.Text;
      p.MySqlUse = _chkUse.Checked;

      p.PopupTipList.IgnorePopupTip(PopupTip.NeverShow, _chkNeverShowPopupTips.Checked);
    }
  }
}
