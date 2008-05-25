/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-May-08   362 : File created (replicating frmMain).
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Windows.Forms;
using System.Diagnostics;

namespace KrakatauEPM
{
  static class Program
  {
    /// <summary>
    /// The main entry point for the application.
    /// </summary>
    [STAThread]
    static void Main()
    {
      Application.EnableVisualStyles();
      Application.SetCompatibleTextRenderingDefault(false);
      FormKrakatauEPM app = new FormKrakatauEPM();

      Process p = new Process();
      p.StartInfo.RedirectStandardOutput = false;
      p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
      p.StartInfo.UseShellExecute = true;
      p.StartInfo.FileName = Prefs.Preferences.InstallDir + "lic.exe";
      p.Start();
      p.WaitForExit();

      if ((p.ExitCode & 128) == 128)
      {
        Application.Run(app);
      }
      else
      {
        MessageBox.Show(app, "You are not licensed to use Krakatau EPM.\n\n" +
                        "Please contact laurence.arthur@powersoftware.com for a new license.",
          "Unlicensed Krakatau EPM",
          MessageBoxButtons.OK, MessageBoxIcon.Stop);
      }

    }
  }
}
