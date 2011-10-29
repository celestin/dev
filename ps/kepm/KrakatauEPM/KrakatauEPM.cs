/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2011 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  24-May-08    362 : File created (replicating frmMain).
 * CAM  15-Feb-2010  10565 : Use KrakatauSettings for InstallDir.
 * CAM  15-Feb-2010  11048 : Use Hephaestus licensing.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Diagnostics;
using System.Reflection;
using System.Windows.Forms;

using PowerSoftware.Tools.Licensing.Hephaestus;

using PowerSoftware.Krakatau.Kepm.Forms;
using PowerSoftware.Krakatau.Kepm.Win32;

namespace PowerSoftware.Krakatau.Kepm
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
      bool kepmLicensed = false;

      LicFileHelper helper = new LicFileHelper(KrakatauSettings.Settings.InstallDir);
      if (helper.FindFile())
      {
        try
        {
          // Attempt to validate against a Hephaestus license

          helper.LicenseFile.Load();
          kepmLicensed = helper.LicenseFile.Features.LicensedFor(Feature.FeatureEpmkr);
        }
        catch
        {
          // Invalid Hephaestus license, try FLEXlm

          Process p = new Process();
          p.StartInfo.RedirectStandardOutput = false;
          p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
          p.StartInfo.UseShellExecute = true;
          p.StartInfo.FileName = String.Format(@"{0}\lic.exe", helper.LicenseFile.File.DirectoryName);
          p.Start();
          p.WaitForExit();

          kepmLicensed = ((p.ExitCode & Feature.FeatureEpmkr.Key) == Feature.FeatureEpmkr.Key);
        }
      }

      if (kepmLicensed)
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
