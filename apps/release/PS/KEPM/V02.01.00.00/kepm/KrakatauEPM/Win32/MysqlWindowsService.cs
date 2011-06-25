/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Essential PM (KEPM)
 * Copyright (c) 2004,2010 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  18-Feb-2010  10574 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Diagnostics;
using System.ServiceProcess;

namespace SourceCodeMetrics.Krakatau.Kepm.Win32
{
  public class MysqlWindowsService
  {
    public static readonly string EpmDbServiceName = "EPMdb";
    public static readonly TimeSpan ReasonableTimeout = TimeSpan.FromMilliseconds(20000); // 20 seconds

    private DirectoryInfo _epmDbBaseDir;
    private FileInfo _epmDbExe;

    public MysqlWindowsService()
    {
      _epmDbBaseDir = new DirectoryInfo(String.Format(@"{0}\db", KrakatauSettings.Settings.InstallDirPath));
      _epmDbExe = new FileInfo(String.Format(@"{0}\bin\mysqld.exe", _epmDbBaseDir.FullName));
    }

    public bool InstallService()
    {
      try
      {
        RemoveService();  // Remove any existing service of the same name (from a previous installation?)
      }
      catch
      {
        // Ignore any exceptions caused by attempting to remove - the service may not be installed at all
      }

      try
      {
        // Install the service from the current KEPM installation
        Process p = CreateProcess(_epmDbExe.FullName);
        p.StartInfo.Arguments = String.Format("--install {0} --basedir=\"{1}\"", EpmDbServiceName, _epmDbBaseDir.FullName);
        p.Start();
        p.WaitForExit();
      }
      catch
      {
        return false;
      }

      return StartService(); // Attempt to Start the newly-installed service
    }

    public bool RemoveService()
    {
      try
      {
        StopService(); // Need to stop the service before removing
      }
      catch
      {
        // Ignore any exceptions caused by attempting to stop - the service may not exist at all
      }

      try
      {
        // Remove any EPMdb service
        Process p = CreateProcess(_epmDbExe.FullName);
        p.StartInfo.Arguments = String.Format("--remove {0}", EpmDbServiceName);
        p.Start();
        p.WaitForExit();
      }
      catch
      {
        return false;
      }

      return true;
    }

    public bool StartService()
    {
      ServiceController service = new ServiceController(EpmDbServiceName);
      try
      {
        service.Start();
        service.WaitForStatus(ServiceControllerStatus.Running, ReasonableTimeout);
      }
      catch
      {
        return false;
      }

      return true;
    }

    public bool StopService()
    {
      ServiceController service = new ServiceController(EpmDbServiceName);

      try
      {
        if (!service.CanStop) return true;  // If it can't be stopped, and doesn't throw an error, it probably IS stopped!
      }
      catch (System.InvalidOperationException)
      {
        throw new Exception(String.Format("The service cannot be stopped.  Is it installed?\n\n" +
          "Try installing using Diagnotics > MySQL > Install Service.", EpmDbServiceName));
      }

      try
      {
        service.Stop();
        service.WaitForStatus(ServiceControllerStatus.Stopped, ReasonableTimeout);
      }
      catch
      {
        return false;
      }

      return true;
    }

    protected Process CreateProcess(string filename)
    {
      Process p = new Process();
      p.StartInfo.RedirectStandardOutput = false;
      p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
      p.StartInfo.UseShellExecute = true;
      p.StartInfo.FileName = filename;
      return p;
    }
  }
}
