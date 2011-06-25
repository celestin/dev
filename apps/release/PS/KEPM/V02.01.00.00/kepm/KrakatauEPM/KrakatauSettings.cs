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
 * CAM  24-Feb-2010  10558 : Added MetricCollection and NewMetricSetName.
 * CAM  27-Feb-2010  10582 : Added DefaultDirectory.
 * CAM  13-Mar-2010  10581 : Added UserHomeDir.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.IO;
using System.Collections;

using SourceCodeMetrics.Krakatau.Kepm.Metrics;

namespace SourceCodeMetrics.Krakatau.Kepm
{
  /// <summary>
  /// KEPM Settings - singleton with global application options.
  /// </summary>
  public class KrakatauSettings
  {
    private static KrakatauSettings _settings = null;
    private DirectoryInfo _installDir;
    private DirectoryInfo _userHomeDir;
    private MetricCollection _metrics;
    private int _nextMetricSetId;
    private string _defaultDirectory;

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
    public DirectoryInfo UserHomeDir
    {
      get { return _userHomeDir; }
      set { _userHomeDir = value; }
    }
    public MetricCollection Metrics
    {
      get { return _metrics; }
      set { _metrics = value; }
    }
    public string DefaultDirectory
    {
      get
      {
        if (_defaultDirectory == null)
        {
          _defaultDirectory = Environment.GetFolderPath(Environment.SpecialFolder.Personal);
        }
        return _defaultDirectory;
      }
    }

    private KrakatauSettings(DirectoryInfo appPath)
    {
      InstallDir = appPath;
      UserHomeDir = new DirectoryInfo(Environment.GetEnvironmentVariable("USERPROFILE"));

      _nextMetricSetId = 1;
      PopulateMetrics();
    }

    public static KrakatauSettings Settings
    {
      get { return _settings; }
    }

    public static void Create(string appPath)
    {
      _settings = new KrakatauSettings(new DirectoryInfo(appPath));
    }

    public string NewMetricSetName()
    {
      return String.Format("New-Set-{0}", _nextMetricSetId++);
    }

    protected void PopulateMetrics()
    {
      Metrics = new MetricCollection();

      // Add the General metrics
      Metrics.Add(new Metric(100, MetricType.General, "LOC"));
      Metrics.Add(new Metric(101, MetricType.General, "SLOC"));
      Metrics.Add(new Metric(102, MetricType.General, "SLOC_NAT"));
      Metrics.Add(new Metric(103, MetricType.General, "SLOC_TAG"));
      Metrics.Add(new Metric(104, MetricType.General, "SLOC_HTM"));
      Metrics.Add(new Metric(105, MetricType.General, "SLOC_SCR"));
      Metrics.Add(new Metric(106, MetricType.General, "PLOC"));
      Metrics.Add(new Metric(107, MetricType.General, "LLOC"));
      Metrics.Add(new Metric(108, MetricType.General, "N1"));
      Metrics.Add(new Metric(109, MetricType.General, "N2"));
      Metrics.Add(new Metric(110, MetricType.General, "N1S"));
      Metrics.Add(new Metric(111, MetricType.General, "N2S"));
      Metrics.Add(new Metric(112, MetricType.General, "N"));
      Metrics.Add(new Metric(113, MetricType.General, "NS"));
      Metrics.Add(new Metric(114, MetricType.General, "V"));
      Metrics.Add(new Metric(115, MetricType.General, "D"));
      Metrics.Add(new Metric(116, MetricType.General, "E"));
      Metrics.Add(new Metric(117, MetricType.General, "B"));
      Metrics.Add(new Metric(118, MetricType.General, "J_COM"));
      Metrics.Add(new Metric(119, MetricType.General, "C_COM"));
      Metrics.Add(new Metric(120, MetricType.General, "CPP_COM"));
      Metrics.Add(new Metric(121, MetricType.General, "COM_LOC"));
      Metrics.Add(new Metric(122, MetricType.General, "BYTES"));
      Metrics.Add(new Metric(123, MetricType.General, "NFILE", MetricLevel.Project));

      // Add the Changed metrics
      Metrics.Add(new Metric(124, MetricType.Changed, "CHG_SLOC"));
      Metrics.Add(new Metric(125, MetricType.Changed, "DEL_SLOC"));
      Metrics.Add(new Metric(126, MetricType.Changed, "ADD_SLOC"));
      Metrics.Add(new Metric(127, MetricType.Changed, "CRN_SLOC"));
      Metrics.Add(new Metric(128, MetricType.Changed, "CHG_LLOC"));
      Metrics.Add(new Metric(129, MetricType.Changed, "DEL_LLOC"));
      Metrics.Add(new Metric(130, MetricType.Changed, "ADD_LLOC"));
      Metrics.Add(new Metric(131, MetricType.Changed, "CRN_LLOC"));
      Metrics.Add(new Metric(132, MetricType.Changed, "CHG_FILE", MetricLevel.Project));
      Metrics.Add(new Metric(133, MetricType.Changed, "DEL_FILE", MetricLevel.Project));
      Metrics.Add(new Metric(134, MetricType.Changed, "ADD_FILE", MetricLevel.Project));
      Metrics.Add(new Metric(135, MetricType.Changed, "CRN_FILE", MetricLevel.Project));
    }
  }
}
