/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2008 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  24-May-08   362 : File created (replicating frmMain).
 * CAM  15-Feb-2010  10565 : Use KrakatauSettings for InstallDir.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Diagnostics;
using System.Reflection;
using System.Windows.Forms;

using SourceCodeMetrics.Krakatau.Kepm.Forms;
using SourceCodeMetrics.Krakatau.Kepm.Win32;

namespace SourceCodeMetrics.Krakatau.Kepm
{
  static class KrakatauEPM
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
      p.StartInfo.FileName = String.Format(@"{0}\lic.exe", KrakatauSettings.Settings.InstallDir);
      p.Start();
      p.WaitForExit();

      if ((p.ExitCode & 128) == 128)
      {
        Application.Run(app);
      }
      else
      {
        MessageBox.Show(app, "You are not licensed to use " + KrakatauEPM.AssemblyProduct + ".\n\n" +
                        "Please contact laurence.arthur@powersoftware.com for a new license.",
          "Unlicensed " + KrakatauEPM.AssemblyProduct,
          MessageBoxButtons.OK, MessageBoxIcon.Stop);
      }
    }

    #region Assembly Properties
    static public string AssemblyProduct
    {
      get
      {
        object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyProductAttribute), false);
        if (attributes.Length == 0) return "";
        return ((AssemblyProductAttribute)attributes[0]).Product;
      }
    }
    static public string AssemblyDescription
    {
      get
      {
        object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyDescriptionAttribute), false);
        if (attributes.Length == 0) return "";
        return ((AssemblyDescriptionAttribute)attributes[0]).Description;
      }
    }
    static public string AssemblyEpmConfiguration
    {
      get
      {
        object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyConfigurationAttribute), false);
        if (attributes.Length == 0) return "";
        return ((AssemblyConfigurationAttribute)attributes[0]).Configuration;
      }
    }
    static public string AssemblyCopyright
    {
      get
      {
        object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyCopyrightAttribute), false);
        if (attributes.Length == 0) return "";
        return ((AssemblyCopyrightAttribute)attributes[0]).Copyright;
      }
    }
    static public string AssemblyVersion
    {
      get
      {
        return Assembly.GetExecutingAssembly().GetName().Version.ToString();
      }
    }
    #endregion
  }
}
