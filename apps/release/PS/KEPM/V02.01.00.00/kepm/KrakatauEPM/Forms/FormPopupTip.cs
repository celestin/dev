/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  16-Mar-2010  10597 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;

using SourceCodeMetrics.Krakatau.Kepm.Win32;

namespace SourceCodeMetrics.Krakatau.Kepm.Forms
{
  /// <summary>
  /// Dialog to display Popup Tips assisting users with the operation of Krakatau EPM.
  /// </summary>
  public partial class FormPopupTip : Form
  {
    private PopupTip _tip;

    public PopupTip Tip
    {
      get { return _tip; }
      set { _tip = value; }
    }

    public FormPopupTip(PopupTip tip)
    {
      InitializeComponent();

      Tip = tip;

      txtTip.Text = PopupTips.GetMessage(_tip);

      if (!Prefs.Preferences.PopupTipList.IsIgnorePopupTip(tip)) ShowDialog();
    }

    private void OkClicked(object sender, EventArgs e)
    {
      if (chkNeverShowAnyTips.Checked)
      {
        Prefs.Preferences.PopupTipList.IgnorePopupTip(PopupTip.NeverShow);
      }

      if (chkDontShowThisTip.Checked)
      {
        Prefs.Preferences.PopupTipList.IgnorePopupTip(Tip);
      }

      Dispose();
    }
  }
}
