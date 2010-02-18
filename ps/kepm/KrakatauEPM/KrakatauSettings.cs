/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  15-Feb-2010  10565 : File created.
 * CAM  18-Feb-2010  10574 : Added InstallDirPath.get.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Collections;

namespace SourceCodeMetrics.Krakatau.Kepm
{
  /// <summary>
  /// KEPM Settings - singleton with global application options.
  /// </summary>
  public class KrakatauSettings
  {
    private static KrakatauSettings _settings = null;
    private DirectoryInfo _installDir;

    public DirectoryInfo InstallDir
    {
      get { return _installDir; }
      set { _installDir = value; }
    }

    public string InstallDirPath
    {
      get { return _installDir.FullName; }
      set
      {
        string p = value;
        if (!p.EndsWith("\\"))
        {
          p += "\\";
        }
        InstallDir = new DirectoryInfo(p);
      }
    }
    public string InstallDrive
    {
      get
      {
        return InstallDir.FullName.Substring(0, 2);
      }
    }
    private KrakatauSettings(DirectoryInfo appPath)
    {
      InstallDir = appPath;
    }

    public static void Create(string appPath)
    {
      _settings = new KrakatauSettings(new DirectoryInfo(appPath));
    }

    public static KrakatauSettings Settings
    {
      get { return _settings; }
    }
  }
}
